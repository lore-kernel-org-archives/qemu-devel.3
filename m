Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5DC2C87FCE
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Jul 2025 09:07:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ugJoK-0000hy-Jn; Mon, 28 Jul 2025 05:06:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chigot@adacore.com>)
 id 1ugJne-0000I6-51
 for qemu-devel@nongnu.org; Mon, 28 Jul 2025 05:05:54 -0400
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <chigot@adacore.com>)
 id 1ugJnY-0007oB-Ix
 for qemu-devel@nongnu.org; Mon, 28 Jul 2025 05:05:37 -0400
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-4563cfac19cso44700235e9.2
 for <qemu-devel@nongnu.org>; Mon, 28 Jul 2025 02:05:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=adacore.com; s=google; t=1753693526; x=1754298326; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=CERVx5n1WuMT+Yyn+vw4Z4kl+8Rb0pEvu3c7ANOUOlg=;
 b=d0atF5uVIylAQgoZpZdkWXGoxTTjGOi8o+g2Nc2MS5N4n4PiLAC5MR3U3C4I5jj+zz
 7RlqjMRKf40xzUae1O9KpjUdPZC5Yuh++wfqfL2/ggObTugejEtdKuHqI/GxbbaHvaVW
 6k5i+x0K6Etu4TtZq1/3imwu7MOaZbFFBniBEZGGb8aTxYHY+O9/5VSy4yKSkvoNeqGo
 nu/o2E3B9frqHOVP4jQTKX7HTfWNr1CmJxNpUDTQaGBPXvcBX3lQRe9yOuMQDlG6Qnxj
 DchQ/qYeicyTtljNbVRH+301FxqkA5YIuP316DimT+e+xSKAICe7A3IUzbVNEIHHlEog
 PPvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753693526; x=1754298326;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=CERVx5n1WuMT+Yyn+vw4Z4kl+8Rb0pEvu3c7ANOUOlg=;
 b=Nc0mNiMAAZ9xeJPCHlBBZZ2ffW0zwhCJV9Q46AbOuK7vWHHmSiE/skGyU9qAgXX9gL
 NwBkabhX+KgdEvtYv7ou59NyqpWEzeWyGmQV/wsCwba3XxufNKzUyrbQBZBEsw9L+uSC
 raqFCDsRJuUUTvZtY+Ttg9kIn6tH/5TFXsBw4hfX8Scb+6RJVhmWyk70LQon54drguRc
 ogGvWIXHeviIEIGkvSuIaRHL5U5M7FrmzoTc4W6mRmXYL2VMFs7P8aJpRdo72wEbYj17
 9PWG6VbUWIwtluOsn6beQgYxJyyvo0SVLOu5/KHKtunW14GsgyAu+NWBvi7JB1JNluOF
 dy+g==
X-Gm-Message-State: AOJu0Yy7IWFo5jeDnjF5ddwScXwTOsTvzjqIWDGWFDtt/Ug62aUna3Dr
 3pBZGJSvLjgzEitjDZHyRXnYUH8oWLF7bl3sphDxQvUwgys9zRZz8qmf5IFJW4q8k39Dz4ZfA9S
 5ei0=
X-Gm-Gg: ASbGncvKA38bWJoavcnX/XA3XQx79RoK/4oo+881H1YCbYZSf3Kv/ycYd6TQOV2tqgh
 J8pW/AVBo15K+5ablmLaqOdQajBnYXJ5TRXcj4cXaP6ECblLo50virD2jvbLfBnmsqXqTu8Fo4c
 6kvnW0tvLACa+K8yGLcTK0gYXWKEnjbMX6vPCAaA0MIyj+/285F88wlhw6iz7xx/f7QvK96gNzK
 K49rKHQFrPYoSjw9sBpjI62Xo+GKWQIRFv+GQ1CCzCbJSPjFDzjiu4I4oz9we4hsNXVLVs29bYW
 hciUv0M34vcWo6hioJK8PZh37Y5z2gXQEYTNvH2bP73Lm3HZLOwsQJu9kZHz4jLV+RN50aVw+mx
 FNRa0Y02P258XNnowxqAotRZV8kp/Z6eHG2f6+KH9fD7unH7dfj2UWvTL1gtgeS7OCbQo38aJ+Y
 A5+jLy+pASrnGWwPsgM2g=
X-Google-Smtp-Source: AGHT+IH9qakOqF2uZEDMg6ob2ol7iXoXxZhRPHRI8cuIsDQ/VSbsblF1h8UzmP8wr8TrP+ugZO6oNA==
X-Received: by 2002:a05:600c:3484:b0:43d:fa59:af97 with SMTP id
 5b1f17b1804b1-4587666ae80mr78850895e9.32.1753693525721; 
 Mon, 28 Jul 2025 02:05:25 -0700 (PDT)
Received: from chigot-Dell.telnowedge.local
 (lmontsouris-659-1-24-67.w81-250.abo.wanadoo.fr. [81.250.175.67])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4587ac662b2sm89192275e9.26.2025.07.28.02.05.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 28 Jul 2025 02:05:25 -0700 (PDT)
From: =?UTF-8?q?Cl=C3=A9ment=20Chigot?= <chigot@adacore.com>
To: qemu-devel@nongnu.org
Cc: balaton@eik.bme.hu, qemu-ppc@nongnu.org, marcandre.lureau@redhat.com,
 berrange@redhat.com, =?UTF-8?q?Cl=C3=A9ment=20Chigot?= <chigot@adacore.com>
Subject: [PATCH] hw/display/sm501: fix missing error-report.h
Date: Mon, 28 Jul 2025 11:05:18 +0200
Message-Id: <20250728090518.963573-1-chigot@adacore.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=chigot@adacore.com; helo=mail-wm1-x332.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

"qemu/error-report.h" was previously implicitly included. This is no
longer the case following 012842c075520dbe1bd96a2fdcf4e218874ba443.

However, the issue predates this change as `error-report.h` should have
been included when the `warn_report` call was introduced.

Fixes: fa140b9562 ("hw/sm501: allow compiling without PIXMAN")
Signed-off-by: Clément Chigot <chigot@adacore.com>
---
 hw/display/sm501.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/hw/display/sm501.c b/hw/display/sm501.c
index 6d2f18684c..bc091b3c9f 100644
--- a/hw/display/sm501.c
+++ b/hw/display/sm501.c
@@ -26,6 +26,7 @@
 #include "qemu/osdep.h"
 #include "qemu/units.h"
 #include "qapi/error.h"
+#include "qemu/error-report.h"
 #include "qemu/log.h"
 #include "qemu/module.h"
 #include "hw/usb/hcd-ohci.h"
-- 
2.34.1


