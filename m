Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19271C282EC
	for <qemu-devel@archiver.kernel.org>; Sat,  8 Mar 2025 23:02:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tr39W-0005Gl-Jb; Sat, 08 Mar 2025 18:00:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tr38Y-0004bM-47
 for qemu-devel@nongnu.org; Sat, 08 Mar 2025 17:59:18 -0500
Received: from mail-pl1-x635.google.com ([2607:f8b0:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tr38W-0005N4-8Y
 for qemu-devel@nongnu.org; Sat, 08 Mar 2025 17:59:17 -0500
Received: by mail-pl1-x635.google.com with SMTP id
 d9443c01a7336-22438c356c8so24061475ad.1
 for <qemu-devel@nongnu.org>; Sat, 08 Mar 2025 14:59:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741474754; x=1742079554; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=eHwc77IufCe9x4orDpSXC5RbYlXYJFooG8dZmFw32y4=;
 b=ic+vU4cmT3reUaa15NL/SW0dcHsC9vNZZH8jF4X8C77PirjnHM3vgg4yGo0WNQd1XL
 hIxB2CHl1ITzZPEXbj0cN9mAL6FKGLq+eTPw8BQJ4xwbkkYKnPh+Jndkd6v3bkGY1W6c
 XSp8fArG3fbDZtV1iFJp4r21T8Kso2NxoIyEAV0kMbyyD1eeGzXEyMsfBryxYBF0J1BK
 KgXVWBoMbWyiX4HXYtw9fjAXwwSOLU4eKQjNOOH58KtptqBem3RYRRu+ItzePHSkNJAP
 BA2+PyCLOdl2OiHbI/Quknhow8+1AWs+nHP22qQ2al4QZ8p+FO7tafpSm9w93DhSscJT
 UF2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741474754; x=1742079554;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=eHwc77IufCe9x4orDpSXC5RbYlXYJFooG8dZmFw32y4=;
 b=mFi2oTNDvZFOFI15cKrFZcJbQODw7Q6fVDY2tiaGUX05cii/J9e8fQ4jAaRthnWLW7
 9hMA9QLevTJjklFKpvezk3wTJh0xFL3XL0fnTr7N/qIx60hj27tBCAH50TDpiqiIntth
 LJCw/4GMKkjkEymnHUYR1ZRfy/KVN1N9jRnLUmxmkLcr1rGr/MJvK0Kkf2APwJ3prIu/
 t7+b8ABByM4ewWzTQoX8BzMn6tdpoFZ4dICain+aERfbB8af2pJkMHqsi2ARwfjoJCKm
 dpjJ7OVi4JezUVTYCfOjz+IdI3K1gWBmYXOFfuJ/gIg852wSaDwsPBlLFdgWDJx3MUkG
 FF8g==
X-Gm-Message-State: AOJu0Yx9Fbs0Y0MZP3KDujhAV4ZFUOnhE0oVHuCP/XFAOIrDjq8D5GrS
 1fqtOS+cqBSGTJZzWVQEzBMyfnL+bR98EqkKRBDMXlBqDg1bsoSBmWDKgcmae/hiHiE52L9W3DJ
 5
X-Gm-Gg: ASbGnctGFs2Q69PLZ4Hz8WMyizMPkiPpkNwCHU/xNyMPnW4w/8V33JBUHMulcOYbEuQ
 yX+ghzrR/oWrfzyYJq5MirrGh99tG9HTJi53sxqbF/MGOn7trROQ/aJhZ1qt52hNySCwa+Ufp1i
 WpBAsIp/CP0xCqpLrwtxYMViM8i9lbap3Kr4FRSbs5awrsDxUhpi+odc+gGXbO8ty9ANEKuRPa7
 7hgeUYA05YzYRwGahytRr0Zd+loHwDv1ezT9lRi5Aq9zgtYEyli/pRdrWtwKQa7ZMxZ6B7fTv5B
 fJWXZT4urUqHuZi9D25PK8wHBzdvXBWFqZM/1jNXFhxgde5GsiOwbvtsn/iyhPppRCgDyq0fQEh
 J
X-Google-Smtp-Source: AGHT+IEgMclFE7Cbr/jsyychjDSp0NlXatKf6N0/X+VEUMITu7jff8kQm8mQPJPD9/5anny8ARZ/qA==
X-Received: by 2002:a17:902:ec89:b0:224:10a2:cad9 with SMTP id
 d9443c01a7336-22428bd5852mr161240585ad.41.1741474753969; 
 Sat, 08 Mar 2025 14:59:13 -0800 (PST)
Received: from stoup.. (174-21-74-48.tukw.qwest.net. [174.21.74.48])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22410a908a0sm51831175ad.162.2025.03.08.14.59.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 08 Mar 2025 14:59:13 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PULL 15/23] accel/tcg: Build tcg-accel-ops-rr.c once
Date: Sat,  8 Mar 2025 14:58:54 -0800
Message-ID: <20250308225902.1208237-17-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250308225902.1208237-1-richard.henderson@linaro.org>
References: <20250308225902.1208237-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::635;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x635.google.com
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

All that is required is to use cpu-common.h instead of exec-all.h.

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 accel/tcg/tcg-accel-ops-rr.c | 2 +-
 accel/tcg/meson.build        | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/accel/tcg/tcg-accel-ops-rr.c b/accel/tcg/tcg-accel-ops-rr.c
index 028b385af9..f62cf24e1d 100644
--- a/accel/tcg/tcg-accel-ops-rr.c
+++ b/accel/tcg/tcg-accel-ops-rr.c
@@ -31,7 +31,7 @@
 #include "qemu/main-loop.h"
 #include "qemu/notify.h"
 #include "qemu/guest-random.h"
-#include "exec/exec-all.h"
+#include "exec/cpu-common.h"
 #include "tcg/startup.h"
 #include "tcg-accel-ops.h"
 #include "tcg-accel-ops-rr.h"
diff --git a/accel/tcg/meson.build b/accel/tcg/meson.build
index 891b724eb6..87c1394b62 100644
--- a/accel/tcg/meson.build
+++ b/accel/tcg/meson.build
@@ -21,7 +21,6 @@ specific_ss.add_all(when: 'CONFIG_TCG', if_true: tcg_specific_ss)
 specific_ss.add(when: ['CONFIG_SYSTEM_ONLY', 'CONFIG_TCG'], if_true: files(
   'cputlb.c',
   'tcg-accel-ops-mttcg.c',
-  'tcg-accel-ops-rr.c',
 ))
 
 system_ss.add(when: ['CONFIG_TCG'], if_true: files(
@@ -29,5 +28,6 @@ system_ss.add(when: ['CONFIG_TCG'], if_true: files(
   'monitor.c',
   'tcg-accel-ops.c',
   'tcg-accel-ops-icount.c',
+  'tcg-accel-ops-rr.c',
   'watchpoint.c',
 ))
-- 
2.43.0


