Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E799F8A145
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Apr 2026 09:17:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wDIqd-0005GT-H5; Thu, 16 Apr 2026 05:17:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wDIqN-00059e-M4
 for qemu-devel@nongnu.org; Thu, 16 Apr 2026 05:17:04 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wDIqL-0007je-I7
 for qemu-devel@nongnu.org; Thu, 16 Apr 2026 05:17:02 -0400
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-488b8efed61so4521895e9.1
 for <qemu-devel@nongnu.org>; Thu, 16 Apr 2026 02:16:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1776331018; x=1776935818; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=YwZjzZ7Bg2mukZQOtGprt3UYuZb0NJu5WZnnqHCoblQ=;
 b=EDpmnkFRit3iDBRY21FCW4U1ixGSL8yhQcnlNPHuWdtpjVwfqxgnIgGJD/Ri7pq2oR
 U6hYpmIZ5y6y284UkFMEKNNl2xkNRlU+o9vSHpZM7gG0BI4vpn5TVOoS+XfSRBsTVB+h
 B/+97ynN1ZRRiQeb0FhaOZQI6N0YJal54qIxhJhW7SViQNQ+Y+8Jqs8ojnPA8rK9wuOW
 /gEW08sJ+u0EP87ON3WIZWpFOr9seirDWYWLBRxTrl/w7NhhK/vcnAPrKvWMnZ0/iPEA
 2ouySd2uc7qB+JUV58oKP11D+pQvKRRe8y2SmWH2lwMnLdJHkEdbjgD9SLaLFC0i0zB7
 rTdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776331018; x=1776935818;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=YwZjzZ7Bg2mukZQOtGprt3UYuZb0NJu5WZnnqHCoblQ=;
 b=cbE6HH2CeWYMwPqBTCxdt7MpBFaCJnEBwRhZpIxrkaTM4Tm8+799rW5WPBsMhEPSrM
 0ED6/tgmUoePzjGJO1YhQnYU3FDbPmWL5zRwnVtV4uESEB3ektcytDH+919uAXPDoDkG
 zYmc3X76jZeHdLIWL5Ku33GdQWfOUeuaqbjc1oQiwjsoPmPhAyJ+hHJagkCf7xV1O+TG
 /k/mIkuR+FNIzwK6ddmSyM43L3h21M8zxZNLGVRIB/CzjLII8Hxxe5YrMn3Csh3G8xb0
 rTdbzO0Ooi+KfSIW4JwIV1yKvKwIDKd13+nfMaVRS/Q1BI3ClQzAOl/gSOC9IA6oaKIH
 k6BA==
X-Gm-Message-State: AOJu0YxykQ5IrhrAUUBYwJWmrMl8/ZrAWl4a4ewXk3wvAols6dBgfIXK
 Lmis/f3a9wneivIi1lOnZyCQDL2NCzEiZUdUzSSdVpHsoF3CIiLgR1+kVaQ23/FMR1eT9FySk/N
 QQiEByzU=
X-Gm-Gg: AeBDievtsfl78dfzmAZX8URK21rkF1wrJ8Y5NtOrWIfpuK2dPXoD0jbvlSt1UtSh0FK
 Z5vIen28XLg+JFwVquOMsNBwLA08insDj9eqSmKZxtVZVDUJ9fz7MO1jo9XgsJlJKsQ9A97HrBZ
 Ex0xY8+W1KB8N8Ab9cnvY0Gh3CFmNyCXTv4M9ZOYWm+qr7iou5LaP755udPBDjjdDN9cwPyVGZC
 e3UmX27B/fCDwvq1JMb2eIrvB/j/RLID0WpOp18mwhIhJU4WsDZvsvi/bjc+akUf0lu04nrhSJm
 PsvChCH0cEd/nhug1O+g9RoVz5AhmrDDs40oLiPtzaMRQKrBYpfDu56r8ozQvy38Un2tzn4DFi7
 DOZSDUoHwhkhQluy1zQ3dMDs/hWbqGDJwXAt0NbfQh6+SG7D6xifUWCLU+e6NZhbBC8AePfWRep
 sbnACfRwOJFsT6se2xhQvnhtNRaopxLgtQlEcOTSQAnn4N5LgZd8D44wl6rlMytt4HetrMoEVA7
 +ifvoYMZGJP1ZH+6XOUQ3VDeTZdqFZ4c6W8rVcDPg==
X-Received: by 2002:a05:600c:8582:b0:485:3c2e:60d5 with SMTP id
 5b1f17b1804b1-488f45cc724mr27128215e9.2.1776331018304; 
 Thu, 16 Apr 2026 02:16:58 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-488f5818da1sm37186565e9.6.2026.04.16.02.16.57
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 16 Apr 2026 02:16:57 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 02/28] MAINTAINERS: Remove Anup Patel
Date: Thu, 16 Apr 2026 10:16:28 +0100
Message-ID: <20260416091654.316158-3-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260416091654.316158-1-peter.maydell@linaro.org>
References: <20260416091654.316158-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Anup Patel has not posted to qemu-devel in some years and did not
respond to a query about whether they still wished to be listed in
our MAINTAINERS file.  Remove them, on the assumption that they are
no longer active in QEMU.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 MAINTAINERS | 1 -
 1 file changed, 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index bcb9521d25..119d73a11c 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -841,7 +841,6 @@ F: tests/functional/arm/test_canona1100.py
 F: docs/system/arm/digic.rst
 
 Goldfish RTC
-M: Anup Patel <anup.patel@wdc.com>
 M: Alistair Francis <Alistair.Francis@wdc.com>
 L: qemu-riscv@nongnu.org
 S: Maintained
-- 
2.43.0


