Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21B1DC369B2
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Apr 2025 16:55:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u5SVk-0008PR-6l; Thu, 17 Apr 2025 12:54:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u5SVi-0008Oy-Fr
 for qemu-devel@nongnu.org; Thu, 17 Apr 2025 12:54:46 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u5SVg-0003e0-HF
 for qemu-devel@nongnu.org; Thu, 17 Apr 2025 12:54:46 -0400
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-43ede096d73so7692385e9.2
 for <qemu-devel@nongnu.org>; Thu, 17 Apr 2025 09:54:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1744908882; x=1745513682; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CCtxW/YXYxc5X52XHJaBnnxo+Dcm7u6ycMuvffFjq6Q=;
 b=QmvNRD/N+JpL/dH6fDdu00QPtmpcJnEE8cVPYHoNxV0nk9HDqdYPzEOpaMDxdtRi37
 w36nalcq2zt16dh2boTPFaqwi9W5zpBW0ZVw2ift9CRpj/PzMXtJarCSOv/y31vrYeL0
 CuRysbHss2l7I2uLsQHCrbsvVXoUwbAOE9zOReVoyT94BliDFKT1GN+yfhQeymAv2rBH
 yCMsFosXjZcxweyzv5BkoxQ2LDoEaLBo8HVqafOsltL7UXKNGUzyo+gSF29WO49QTnyY
 QjEutopQ2g1mewBel/wUh8SEoebfIr/c/MwQ2bwO2oVWUtbsrqbWKxIClbbQ+wLGgx3T
 xMVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744908882; x=1745513682;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=CCtxW/YXYxc5X52XHJaBnnxo+Dcm7u6ycMuvffFjq6Q=;
 b=EabJOEhVblsccmRFwuI8fCtPFbCKL0G+LajNH2cZiYlRt2Q7CNiGXXM+atalUeyU5B
 wgT6OeU0/NXJJ6RqTTvEYYxwiAH+CUo3qvzqR8VQ663G9saElVrubW1LMwklFM2dG0Vs
 Nu0w4knVSw46Ql0TuZJW+hcxSnUH+oHI3w/01uo0jjZNaSIIb4ymkrJTJlZuJK6Ho1Fm
 9mV9aANEJvhhI+JWRkSNEOWwvxE6F5A51iWA3XPMyXjaqKR65fILx0bJlAz0yIEKNJFi
 C9jy89BDECZIwmzdSyJiXAFiLKGDQWX4QciCUkDAHIDUW1TARKcXXbKSFX02J7g5WEAV
 lGgg==
X-Gm-Message-State: AOJu0YyibvMwj+F64wS35KxlAdtYGNjwzsEeMvjO1ZOHwCq080UugOrD
 HRASYAdSdNjCWGXHYEtKtp5SnGHnfhewVWo0DGsLGreO7507ggR7h2c/qzSnlyRKolgCUDXJYL5
 p
X-Gm-Gg: ASbGnctRAWwMMQa2/CoFoWNbUL+N7czAm13kpZIyZMhK26lQRMlOybhW1sobzttrAYk
 cadY3m/yUNHNGrFg0OJ/j/wKF1su8603Zd2niKXuYwFcyVhtav31UkahgBmss74Bjv9nHPO8h4D
 CddAOsIMca4A+X6r43i031bASaR1S4HiER6t8IPx1f11bZ7GeqDgLVlf7nKhiuto+RCHRfpN3E3
 BHjDs6Y7BN9oMA9I32iH3+Xsj4X3sXM/SxmwUGm7VRzcsrszFX3BsHTcv3gLjnea0UnIb4vzTZg
 QcbX/TolmbS9jrfIHge52uLgarGu4STO1pY2hJvHeo2FJm7HUd/7M8VIXqMKRMP9J0N2QABxAPB
 IvhbNNHZqh/2BCF+BwzCgdH3JkQ==
X-Google-Smtp-Source: AGHT+IE4UBhPopG4WQc59aqnLzyCa1drhRnj9u1vZ2FUwj8PimAVToHbLRkLqhsfmKv+8/4bzoFVew==
X-Received: by 2002:a05:600c:450d:b0:43d:82c:2b11 with SMTP id
 5b1f17b1804b1-4405d69b537mr51236785e9.23.1744908882053; 
 Thu, 17 Apr 2025 09:54:42 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-39efa4931e7sm119904f8f.67.2025.04.17.09.54.41
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 17 Apr 2025 09:54:41 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Yanan Wang <wangyanan55@huawei.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Zhao Liu <zhao1.liu@intel.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 Richard Henderson <richard.henderson@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH 2/7] cpus: Replace CPU_RESOLVING_TYPE -> target_cpu_type()
Date: Thu, 17 Apr 2025 18:54:25 +0200
Message-ID: <20250417165430.58213-3-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250417165430.58213-1-philmd@linaro.org>
References: <20250417165430.58213-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32b.google.com
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

Replace the target-specific CPU_RESOLVING_TYPE definition
by a call to the target-agnostic target_cpu_type() runtime
helper.

Since the big "cpu.h" is not required anymore in tcg-all.c,
remove it, using the tinier "cpu-param.h" header.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 accel/accel-target.c | 6 ++++--
 accel/tcg/tcg-all.c  | 5 +++--
 cpu-target.c         | 7 ++++---
 3 files changed, 11 insertions(+), 7 deletions(-)

diff --git a/accel/accel-target.c b/accel/accel-target.c
index 33a539b4cbb..9e9e70be876 100644
--- a/accel/accel-target.c
+++ b/accel/accel-target.c
@@ -25,6 +25,7 @@
 
 #include "qemu/osdep.h"
 #include "qemu/accel.h"
+#include "qemu/target_info.h"
 
 #include "cpu.h"
 #include "accel/accel-cpu-target.h"
@@ -88,17 +89,18 @@ static void accel_init_cpu_interfaces(AccelClass *ac)
     const char *ac_name; /* AccelClass name */
     char *acc_name;      /* AccelCPUClass name */
     ObjectClass *acc;    /* AccelCPUClass */
+    const char *cpu_resolving_type = target_cpu_type();
 
     ac_name = object_class_get_name(OBJECT_CLASS(ac));
     g_assert(ac_name != NULL);
 
-    acc_name = g_strdup_printf("%s-%s", ac_name, CPU_RESOLVING_TYPE);
+    acc_name = g_strdup_printf("%s-%s", ac_name, cpu_resolving_type);
     acc = object_class_by_name(acc_name);
     g_free(acc_name);
 
     if (acc) {
         object_class_foreach(accel_init_cpu_int_aux,
-                             CPU_RESOLVING_TYPE, false, acc);
+                             cpu_resolving_type, false, acc);
     }
 }
 
diff --git a/accel/tcg/tcg-all.c b/accel/tcg/tcg-all.c
index b0d4e3e1362..25df7db5026 100644
--- a/accel/tcg/tcg-all.c
+++ b/accel/tcg/tcg-all.c
@@ -35,6 +35,7 @@
 #include "qapi/qapi-types-common.h"
 #include "qapi/qapi-builtin-visit.h"
 #include "qemu/units.h"
+#include "qemu/target_info.h"
 #if defined(CONFIG_USER_ONLY)
 #include "hw/qdev-core.h"
 #else
@@ -43,7 +44,7 @@
 #endif
 #include "accel/tcg/cpu-ops.h"
 #include "internal-common.h"
-#include "cpu.h"
+#include "cpu-param.h"
 
 
 struct TCGState {
@@ -89,7 +90,7 @@ static int tcg_init_machine(MachineState *ms)
     unsigned max_threads = 1;
 
 #ifndef CONFIG_USER_ONLY
-    CPUClass *cc = CPU_CLASS(object_class_by_name(CPU_RESOLVING_TYPE));
+    CPUClass *cc = CPU_CLASS(object_class_by_name(target_cpu_type()));
     bool mttcg_supported = cc->tcg_ops->mttcg_supported;
 
     switch (s->mttcg_enabled) {
diff --git a/cpu-target.c b/cpu-target.c
index c99d208a7c4..1779bb5337d 100644
--- a/cpu-target.c
+++ b/cpu-target.c
@@ -22,6 +22,7 @@
 #include "qapi/error.h"
 #include "qemu/error-report.h"
 #include "qemu/qemu-print.h"
+#include "qemu/target_info.h"
 #include "system/accel-ops.h"
 #include "system/cpus.h"
 #include "exec/cpu-common.h"
@@ -37,7 +38,7 @@ QEMU_BUILD_BUG_ON(offsetof(ArchCPU, env) != sizeof(CPUState));
 
 char *cpu_model_from_type(const char *typename)
 {
-    const char *suffix = "-" CPU_RESOLVING_TYPE;
+    g_autofree char *suffix = g_strdup_printf("-%s", target_cpu_type());
 
     if (!object_class_by_name(typename)) {
         return NULL;
@@ -63,7 +64,7 @@ const char *parse_cpu_option(const char *cpu_option)
         exit(1);
     }
 
-    oc = cpu_class_by_name(CPU_RESOLVING_TYPE, model_pieces[0]);
+    oc = cpu_class_by_name(target_cpu_type(), model_pieces[0]);
     if (oc == NULL) {
         error_report("unable to find CPU model '%s'", model_pieces[0]);
         g_strfreev(model_pieces);
@@ -92,7 +93,7 @@ static void cpu_list_entry(gpointer data, gpointer user_data)
 
 void list_cpus(void)
 {
-    CPUClass *cc = CPU_CLASS(object_class_by_name(CPU_RESOLVING_TYPE));
+    CPUClass *cc = CPU_CLASS(object_class_by_name(target_cpu_type()));
 
     if (cc->list_cpus) {
         cc->list_cpus();
-- 
2.47.1


