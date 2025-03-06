Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29615C282D1
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Mar 2025 16:05:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tqDW7-0005Z3-Mn; Thu, 06 Mar 2025 10:52:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tqDVe-0004ZQ-35
 for qemu-devel@nongnu.org; Thu, 06 Mar 2025 10:51:42 -0500
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tqDVb-0006n7-OF
 for qemu-devel@nongnu.org; Thu, 06 Mar 2025 10:51:41 -0500
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-43bd5644de8so9768635e9.3
 for <qemu-devel@nongnu.org>; Thu, 06 Mar 2025 07:51:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741276298; x=1741881098; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=isFVV4mWD6JRdhzxnOMLbfC93cakN53tVgpDr87aOmk=;
 b=vUBfsgaUEfPseEAjWTIwxqlMxsFi1NT8O3mOH7GwbkAKFxXqqlZ7TSYX7E+L462Q1g
 vkkRiK8zX4UxpTJNNgeUd32X59PJRiG3CQmCKhVjwXHX+6zRiGnNcKOObP0ZGGPFLMqs
 YRwghAcP2dBBAJvtNBVSoUiPsNbypy74p9eh7KB8TgICaf8pGiYfBySy1XKGyKMLG2i6
 XvnYN6mcY4857sFCyN+HNDpUacmbtZBE4AnY0/hj9fuBV51QLR/ET6WiRhuIifFfRfqF
 5unc1/aVgjAq0lgtPDXQpdkrJvzSyE1QhzkP6UVGGyzsFthy8x+iHNcqH3QwGs6lMKNu
 1bAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741276298; x=1741881098;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=isFVV4mWD6JRdhzxnOMLbfC93cakN53tVgpDr87aOmk=;
 b=b7H/GTcyEEd9p2vnrpxESEdFeYNsdtGiyjwEIEoPLoCjoBsO1oA6hoKZbLoInkbE4U
 WbreuMF/37OZ1rN3QloofPNj2jJIZqBZTRp3sSSjTposdMm8QfYNaR+gNyeQ9jdYlQRc
 BDNSMFPI+qDX0CIc9bEwh+mRt+vMX40gUHzaE4valU4ErLaouWqakocbENSijZv5iUdY
 wiSnnVhjUWjc+l/QAwHW7Pcnk9vUMaVHmY0eK7Vnzv7/5joOFRdjt5HeTAlXWuwqwXE+
 gOBOcXiXzfQTT33d99zb/zdnpTUCm6q/8WYKmIQTbChc1eIPZ2R+CyhQni+yCpBXv5IC
 F//Q==
X-Gm-Message-State: AOJu0YypB+7eTAco7jLsnnoalMiFSwtDwZI9Q9VhKBWVHKma0j/KphYC
 EV2zfUB+Lm2ls2k+xpkqo613CyXtNBfaCxOWGdbFX5Lq1zALD3j5woBVIG0WnXomYrq5FabGSi3
 7++Q=
X-Gm-Gg: ASbGncsgK0WdiuuP0of4GOLgVKsdDaQcHz6mclKgr8eX0uGH7XCcQV+m++iVgjLmhB3
 OzH5UPqPIFTVknZ/ToYvN8VHyh96ZKjkEEesa8gvXu+Vjl9M3U1Z0PO0UGd/VeCvgI/HhQ8Odtq
 YDD/PH0CnJFrb377AE/B+RFsYm7pqYppSvojroIa2dmBCU0EGiRv+Y0tZkhLXRs0sv7wtGfk0L6
 8P8ZzjdC9epTDR97UmxH2/9clUMrqQ8IRdj3nPZKmZiX0wrCz/DLwJzvKLDqD/o+Jl6EWfOqJ7W
 0XdlvvqLYz/d+IiVDQjDtXK6Pnb4qwaTr+mMl6kXE/T4NmdpT0X22s5so/e2tW/JOuD7zG/yaup
 t3MVzkEIqV4Gz/oC40H4=
X-Google-Smtp-Source: AGHT+IGk3HhRNg3trnG6UElzcyn23ZHH6RzgbjbAdF2XzZoe2DSzUMOq0r2Z0smWrc6bvosGuQOawQ==
X-Received: by 2002:a05:600c:1d0f:b0:439:9b80:ca6f with SMTP id
 5b1f17b1804b1-43bd292da03mr90504865e9.5.1741276297665; 
 Thu, 06 Mar 2025 07:51:37 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3912bfbab43sm2455333f8f.15.2025.03.06.07.51.37
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 06 Mar 2025 07:51:37 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 53/54] system: Open-code qemu_init_arch_modules() using
 target_name()
Date: Thu,  6 Mar 2025 16:47:35 +0100
Message-ID: <20250306154737.70886-54-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250306154737.70886-1-philmd@linaro.org>
References: <20250306154737.70886-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x333.google.com
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

Mostly revert commit c80cafa0c73 ("system: Add qemu_init_arch_modules")
but using target_name() instead of the target specific 'TARGET_NAME'
definition.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20250305005225.95051-3-philmd@linaro.org>
---
 include/system/arch_init.h | 2 --
 system/arch_init.c         | 9 ---------
 system/vl.c                | 7 ++++++-
 3 files changed, 6 insertions(+), 12 deletions(-)

diff --git a/include/system/arch_init.h b/include/system/arch_init.h
index 5b1c1026f3a..d8b77440487 100644
--- a/include/system/arch_init.h
+++ b/include/system/arch_init.h
@@ -27,6 +27,4 @@ enum {
 
 extern const uint32_t arch_type;
 
-void qemu_init_arch_modules(void);
-
 #endif
diff --git a/system/arch_init.c b/system/arch_init.c
index d2c32f84887..b1baed18a30 100644
--- a/system/arch_init.c
+++ b/system/arch_init.c
@@ -22,7 +22,6 @@
  * THE SOFTWARE.
  */
 #include "qemu/osdep.h"
-#include "qemu/module.h"
 #include "system/arch_init.h"
 
 #ifdef TARGET_SPARC
@@ -40,11 +39,3 @@ int graphic_depth = 32;
 #endif
 
 const uint32_t arch_type = QEMU_ARCH;
-
-void qemu_init_arch_modules(void)
-{
-#ifdef CONFIG_MODULES
-    module_init_info(qemu_modinfo);
-    module_allow_arch(TARGET_NAME);
-#endif
-}
diff --git a/system/vl.c b/system/vl.c
index 8f776684ec8..04f78466c41 100644
--- a/system/vl.c
+++ b/system/vl.c
@@ -26,6 +26,7 @@
 #include "qemu/help-texts.h"
 #include "qemu/datadir.h"
 #include "qemu/units.h"
+#include "qemu/module.h"
 #include "exec/cpu-common.h"
 #include "exec/page-vary.h"
 #include "hw/qdev-properties.h"
@@ -78,6 +79,7 @@
 #include "hw/block/block.h"
 #include "hw/i386/x86.h"
 #include "hw/i386/pc.h"
+#include "hw/core/cpu.h"
 #include "migration/cpr.h"
 #include "migration/misc.h"
 #include "migration/snapshot.h"
@@ -2885,7 +2887,10 @@ void qemu_init(int argc, char **argv)
 
     os_setup_limits();
 
-    qemu_init_arch_modules();
+#ifdef CONFIG_MODULES
+    module_init_info(qemu_modinfo);
+    module_allow_arch(target_name());
+#endif
 
     qemu_init_subsystems();
 
-- 
2.47.1


