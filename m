Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E21BC3ABAC
	for <qemu-devel@archiver.kernel.org>; Fri,  2 May 2025 21:46:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uAyCr-0000gR-DZ; Fri, 02 May 2025 17:46:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uAyCp-0000fT-BP
 for qemu-devel@nongnu.org; Fri, 02 May 2025 17:46:03 -0400
Received: from mail-ej1-x636.google.com ([2a00:1450:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uAyCn-0003VN-JR
 for qemu-devel@nongnu.org; Fri, 02 May 2025 17:46:03 -0400
Received: by mail-ej1-x636.google.com with SMTP id
 a640c23a62f3a-ac2bb7ca40bso404386966b.3
 for <qemu-devel@nongnu.org>; Fri, 02 May 2025 14:46:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746222359; x=1746827159; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LXgZidSSSrLiEhibf6u0N42Azn0PbvpjkuJ4Pt+Naxo=;
 b=ws/sVr45ff9wSgY51A6PofgVsR4PMqlB/g4gVXA+GUJn/mRHMbDeBCuYBPrcnyO/kO
 v5IBd9ylynEqKmEhVdPOkjRyUXUL4L3dz71xAzGBgUNMFGi5XKVuB+N04bSTc1g4q0fs
 KaxS2RKgjcIZgixbVZD3MSYzOTV6mBEJ11z2s8q83xJoG2xwc0blrSQda8e6LoIQW8Rl
 8wgWkCxs9uoPUBGjFi7jfR7r7A9BQ54N8sRsXKnQDQcvbNoFI33AJqUqYP7NlBOVAoxO
 afCWnuTNUU+69BLfaVcji9X3Py2FCDVURoLzu+niYlNLffKZWKS5IzeTF7TFBbwk4lKo
 G8+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746222359; x=1746827159;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=LXgZidSSSrLiEhibf6u0N42Azn0PbvpjkuJ4Pt+Naxo=;
 b=U0/m5ZLt/j481yXGVgZJBIprwTyGjfpLke/mpcWvWLBvAtHqb/WtvHfM+jfXdC8dIs
 +dyhwWafgOUxNu+gcBJxyZyiFyrHN7W1BMv2fgj/A6AfYD4iZ3tVdb0VMkhwSCM/laA3
 FK+fFlVdtcd4HJJGO59FPQJ3LltYaFhWTQwaDdERvWS5lx+UJw1pOxVb2jAvunBtX2Lb
 kFPHLzzo73m8sYM1QC3P1r9eruHPbPI7zdz+HI9NR7lv/sMiMn4u6xdbwwS5u4N2aEhX
 u7nf5e0J73EjPIlmUrns5HMKUpGSeZL9DwO+CyI8uV7NC1+LBlU5Qw8IHBPILwtbv7C6
 belw==
X-Gm-Message-State: AOJu0YwITXw3jLYm7XxajXw3YTPS7L/5JTIfDZiDrI3mgLa+rUFzhsoY
 uZ4s5Xr995FxdnvAbcN1PCKdC3XgVnmxsKpRNiwhtDLlBOyGfb4aaHDjX+p3lkiRowxKiZQbyf+
 o
X-Gm-Gg: ASbGnctHoXtffbSfPP1LPXr2MZbxADhx33Wpf7bQSU6d5rr9Fdo2M3RGoFrOAfrriyD
 zz51iWVhh6D1gUJ741aOUHr/G3OcM79lHguA1ju06f9ssjk6SQAmloM/Fd91bDYwvspYKltDuKD
 8n6g6W9T4Z2IcJq9PNmf2PkPXm6WVYdd/NAYUb1FKr9vpAMbarWxj+VXXPVmeq2BUiCoXkkorE9
 DCYFYq29ZseDDvTUxRUYkssxaPBxeEv0vRgzEcdLl2bbyPsuIcuU7s7syHCe8MLYDBhzAnNW7ZS
 fAJ0iPSAyfDhvjTvlOl36QgdQsjJr0o6Ljw4CH7ELADbuB3hKwCpMVFaatBPYNuEWeIGx5ufN+9
 SEtfH74ACuArSebY=
X-Google-Smtp-Source: AGHT+IHFlQBMf3j6pM6mBfV487yGfeYwWTfE2m2nJmCy6ov1DMZS+DOoNeGmL+CsdB3U8UhG+Jru0w==
X-Received: by 2002:a17:906:22db:b0:ad1:8f1b:21b5 with SMTP id
 a640c23a62f3a-ad18f1b2528mr101985766b.36.1746222359478; 
 Fri, 02 May 2025 14:45:59 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ad189146f74sm104922166b.17.2025.05.02.14.45.58
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 02 May 2025 14:45:59 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Eduardo Habkost <eduardo@habkost.net>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Zhao Liu <zhao1.liu@intel.com>, Yanan Wang <wangyanan55@huawei.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Thomas Huth <thuth@redhat.com>, David Hildenbrand <david@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v3 1/5] qemu/target-info: Factor target_system_arch() out
Date: Fri,  2 May 2025 23:45:47 +0200
Message-ID: <20250502214551.80401-2-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250502214551.80401-1-philmd@linaro.org>
References: <20250502214551.80401-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::636;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x636.google.com
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

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/qemu/target-info.h |  9 +++++++++
 hw/core/machine-qmp-cmds.c |  6 ++----
 target-info.c              | 12 ++++++++++++
 3 files changed, 23 insertions(+), 4 deletions(-)

diff --git a/include/qemu/target-info.h b/include/qemu/target-info.h
index 850a2958b9c..87b4b0e0cbb 100644
--- a/include/qemu/target-info.h
+++ b/include/qemu/target-info.h
@@ -9,6 +9,8 @@
 #ifndef QEMU_TARGET_INFO_H
 #define QEMU_TARGET_INFO_H
 
+#include "qapi/qapi-types-machine.h"
+
 /**
  * target_name:
  *
@@ -16,6 +18,13 @@
  */
 const char *target_name(void);
 
+/**
+ * target_system_arch:
+ *
+ * Returns: QAPI SysEmuTarget enum (i.e. SYS_EMU_TARGET_I386).
+ */
+SysEmuTarget target_system_arch(void);
+
 /**
  * target_long_bits:
  *
diff --git a/hw/core/machine-qmp-cmds.c b/hw/core/machine-qmp-cmds.c
index d82043e1c68..8f491dba441 100644
--- a/hw/core/machine-qmp-cmds.c
+++ b/hw/core/machine-qmp-cmds.c
@@ -37,8 +37,7 @@ CpuInfoFastList *qmp_query_cpus_fast(Error **errp)
     MachineState *ms = MACHINE(qdev_get_machine());
     MachineClass *mc = MACHINE_GET_CLASS(ms);
     CpuInfoFastList *head = NULL, **tail = &head;
-    SysEmuTarget target = qapi_enum_parse(&SysEmuTarget_lookup, target_name(),
-                                          -1, &error_abort);
+    SysEmuTarget target = target_system_arch();
     CPUState *cpu;
 
     CPU_FOREACH(cpu) {
@@ -139,8 +138,7 @@ QemuTargetInfo *qmp_query_target(Error **errp)
 {
     QemuTargetInfo *info = g_malloc0(sizeof(*info));
 
-    info->arch = qapi_enum_parse(&SysEmuTarget_lookup, target_name(), -1,
-                                 &error_abort);
+    info->arch = target_system_arch();
 
     return info;
 }
diff --git a/target-info.c b/target-info.c
index 16fdca7aaaf..8232d488870 100644
--- a/target-info.c
+++ b/target-info.c
@@ -9,6 +9,7 @@
 #include "qemu/osdep.h"
 #include "qemu/target-info.h"
 #include "qemu/target-info-impl.h"
+#include "qapi/error.h"
 
 const char *target_name(void)
 {
@@ -20,6 +21,17 @@ unsigned target_long_bits(void)
     return target_info()->long_bits;
 }
 
+SysEmuTarget target_system_arch(void)
+{
+    static SysEmuTarget system_arch = SYS_EMU_TARGET__MAX;
+
+    if (system_arch == SYS_EMU_TARGET__MAX) {
+        system_arch = qapi_enum_parse(&SysEmuTarget_lookup, target_name(), -1,
+                                      &error_abort);
+    }
+    return system_arch;
+}
+
 const char *target_cpu_type(void)
 {
     return target_info()->cpu_type;
-- 
2.47.1


