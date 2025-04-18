Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31206C369CF
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Apr 2025 00:52:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u5ZxN-0002C2-Du; Thu, 17 Apr 2025 20:51:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u5ZxK-00025F-Nq
 for qemu-devel@nongnu.org; Thu, 17 Apr 2025 20:51:47 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u5ZxI-000663-WB
 for qemu-devel@nongnu.org; Thu, 17 Apr 2025 20:51:46 -0400
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-4394a0c65fcso14150795e9.1
 for <qemu-devel@nongnu.org>; Thu, 17 Apr 2025 17:51:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1744937503; x=1745542303; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gm2dOsKzPvwvg/Tuqc3gLIr1jfZVElB4JK7LqftVN0s=;
 b=LSW3Cm1cob+cXDI+j6Wq8IvoAUgJciqXpX72kS6oG2GYgK9iSwV9Vm42Vqv2hLEAZl
 IidlcHy0qrtAutBgKMunqM2kQbIP5qxpDVXUjKwJsJWSSb53D60vCjhF4rzirrOcDzzI
 8MaK6l4UBmXILv5Nlh3+fx0mhmnMqY0n4trGvdYE0GP0ESh8psl8PpP6Mo/s4902IT7L
 tuDmG/ucK/jG86DQLE5dV3vFgVWtggM/TNe1FQ20wGQxZ+fZzSPVqwMHPSzyJqrNZBck
 AMKebXF+HKBGNxROz2CA+htRLfdWArLUvuCCQ6ndI/2wmeYsRtFOR616vCqBwNB6VD9C
 o8Tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744937503; x=1745542303;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=gm2dOsKzPvwvg/Tuqc3gLIr1jfZVElB4JK7LqftVN0s=;
 b=CQI7Gtsk5fra7TrhJZpiwPoefWk22JTl6ftVc6+8IAEQKI5cSrS3BYh+fMmWPn4SQs
 GkzGVRwjp8VqIHBBnwb2cV/gsEjLo+a56jmYODzDuKvvtd7tT8Pa+vY+aiNPjvc+/nIL
 eVTdg0VPXdiKgB69hqTvj/NRa9FT9cxhQbpQeijMJiUsUj6x4/6bRr1y6FRavadIUK8k
 7UCjNhbo0GafTGk4ozoZy+U5cosFIk0OluIx85xiLm35bAh2Y1hN1f6699/7euJPWDTL
 OPztgO54oLY/A0hCtcFk0xzakYBD+Ns7OF2KbIMKu6ZZL7o30LGo5FmT/Danj7b3tfYy
 k2Lw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVvT4nAHjTSg+AHHBS0sob3qQxqnlrIhH66Rhc5BWTWC06pQkhefnx2JxSKZKF7zs6DshRzqR+TJLL9@nongnu.org
X-Gm-Message-State: AOJu0Yyt+KLau2/OH4KAIT6c/bIjtYyzsYZnE9StGDwvxwMKzgxYoBTR
 hU9yy0WOe0WOyNyQy62Mfv/SDau5ONOXJclMk1ZsCdECALb9aPQTQIuHgNLF8Zg=
X-Gm-Gg: ASbGncvcTqh23c2dqAdzy8Q2Mwkn+hjcgIOa7sy1gyek+TSr+Z0yq19PFoWxYfa6vfp
 tj7zIRS3jLewdtFEczAlFqupbaY8rmIYxxKLxzcQ38NHseaNuCVC350Q6Brq1i4JNvpZuYHoBJF
 x+DdRbriFeMXPlT+E9ovg8NmKSrsMjA0lUWPCSwbt5c/Mw5LbjRItvsVYHrzSg5cNMJshL/jt7k
 svQ8rh0d2OhlIQsXZOpMO9GSyB7X/LJpYdXiqZza55GdPdOPb++tdd2R+trwX4gCHV+MIqiIEqy
 T+m7tSsvbaFYGW8KLdXEIKQMHT/dArlnsaJ54SRtiSjLYTH/Fr/c+MrXIQc1kLOCd5ADiSuHWFH
 HAaAETKjo9kXdFekhY4Le
X-Google-Smtp-Source: AGHT+IHNfH/7LLXL1HgwvVunz7D17RUhvMqxEwoqsmnnSumoSiwcb9AP2CPhKCpt9CTJtdSN7pmHEA==
X-Received: by 2002:a05:600c:384b:b0:43d:b85:1831 with SMTP id
 5b1f17b1804b1-4406aa872edmr8260175e9.0.1744937503634; 
 Thu, 17 Apr 2025 17:51:43 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4406d5bbd8asm2185285e9.23.2025.04.17.17.51.41
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 17 Apr 2025 17:51:42 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
	qemu-devel@nongnu.org
Cc: Anton Johansson <anjo@rev.ng>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [RFC PATCH v2 08/11] config/target: Implement per-binary TargetInfo
 structure (ARM)
Date: Fri, 18 Apr 2025 02:50:56 +0200
Message-ID: <20250418005059.4436-9-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250418005059.4436-1-philmd@linaro.org>
References: <20250418005059.4436-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32b.google.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_XBL=0.375, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

If a file defining the binary TargetInfo structure is available,
link with it. Otherwise keep using the stub. Implement such
structure for arm-softmmu.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 meson.build                   |  7 ++++++-
 configs/targets/arm-softmmu.c | 22 ++++++++++++++++++++++
 2 files changed, 28 insertions(+), 1 deletion(-)
 create mode 100644 configs/targets/arm-softmmu.c

diff --git a/meson.build b/meson.build
index 168b07b5887..da24cc2ba41 100644
--- a/meson.build
+++ b/meson.build
@@ -3809,7 +3809,6 @@ specific_ss.add(files('page-target.c', 'page-vary-target.c'))
 
 common_ss.add(files('target_info.c'))
 system_ss.add(files('target_info-qom.c'))
-specific_ss.add(files('target_info-stub.c'))
 
 subdir('backends')
 subdir('disas')
@@ -4272,6 +4271,12 @@ foreach target : target_dirs
     arch_srcs += gdbstub_xml
   endif
 
+  target_info_c = meson.project_source_root() / 'configs' / 'targets' / target + '.c'
+  if not fs.exists(target_info_c)
+    target_info_c = meson.project_source_root() / 'target_info-stub.c'
+  endif
+  arch_srcs += target_info_c
+
   t = target_arch[target_base_arch].apply(config_target, strict: false)
   arch_srcs += t.sources()
   arch_deps += t.dependencies()
diff --git a/configs/targets/arm-softmmu.c b/configs/targets/arm-softmmu.c
new file mode 100644
index 00000000000..6263d604f19
--- /dev/null
+++ b/configs/targets/arm-softmmu.c
@@ -0,0 +1,22 @@
+/*
+ * QEMU binary/target API (qemu-system-arm)
+ *
+ *  Copyright (c) Linaro
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include "qemu/osdep.h"
+#include "qemu/target_info-impl.h"
+#include "qemu/target_info-qom.h"
+#include "cpu-qom.h"
+
+static const TargetInfo target_info_arm_system = {
+    .name = "arm",
+    .machine_typename = TYPE_TARGET_ARM_MACHINE,
+};
+
+const TargetInfo *target_info(void)
+{
+    return &target_info_arm_system;
+}
-- 
2.47.1


