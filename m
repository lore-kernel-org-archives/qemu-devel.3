Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F6A7E77184
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Dec 2024 18:33:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tOLK0-0002zc-08; Thu, 19 Dec 2024 13:32:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tOLJu-0002xa-96
 for qemu-devel@nongnu.org; Thu, 19 Dec 2024 13:32:23 -0500
Received: from mail-pf1-x432.google.com ([2607:f8b0:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tOLJp-0002aR-K7
 for qemu-devel@nongnu.org; Thu, 19 Dec 2024 13:32:20 -0500
Received: by mail-pf1-x432.google.com with SMTP id
 d2e1a72fcca58-728e78c4d7bso899730b3a.0
 for <qemu-devel@nongnu.org>; Thu, 19 Dec 2024 10:32:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734633136; x=1735237936; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Z34VbarymgQiW5Qnm/WH4E3Ova5VTGM3lSMYMRGrvZ8=;
 b=xkhcvJEEV1pghwCH7PAf5aCyrevXrJRGcxT3qCOH7DosXzcwbbD1BcKWZDqqRxbkq5
 3vonvw/IzCF+3MKx7ANTCf5+tHkvzNLf5Zue1JrL0smB5P3XEqkrlE9gNhgwMmGXoA05
 dvxQHKhGvJDEVwV46fm7teYTCCtqvUj+63jxglhS8ysoOjbSHTDt1QssxMK/8zobDD/6
 RdyWz6kY5zZ3hxrUG6vlnI7h8KZy9k30f9VF5Mo1acqXH3tu1yYN1qgdA1n0l/JV8zW3
 ds04FIzmo2e5KdPfxAT+luRc1FDKGZgPELyKK7mEDlEKrxw+oOnucmoHK2b5vXdw35MJ
 E8sA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734633136; x=1735237936;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Z34VbarymgQiW5Qnm/WH4E3Ova5VTGM3lSMYMRGrvZ8=;
 b=dQFsRQLi6lwPaANQK+gvCXo+TcGtZ0YiFPfaXQmD2q3wcHv1o6bPHULA0YTFv11JJO
 lCYtf2t3/DAwDJfQY//JYC3i/UOH10HZ2FVjXYHac+NldY/NdTl+kY+vvZz5XSnFhefp
 f+z4+nlPuwTf83fhY5aI0V3RWmjWPmod72DktfgFztADjdQ/6e5Gu7oD7vpBf2unJ7LH
 UTBbSfut/QcYQZkE3ebfbUy15ZergAzUwxXcf1NZ/w8PZ/us8ROI/s4L1WA9fgh6I/fs
 7iX1mMcDvGOMxRhAwtZm+Tu3PjS5MczfNIZEsRBXcUIV7qiMGIk5x4rYMRIDaETefJST
 R8Jw==
X-Gm-Message-State: AOJu0YxCcUHcT/Xm7udQXwSp1yIYnipwHtU8uFy66uaINCypwoJUZVYT
 qrwcWgdbJq/YTAipdwsC++0dvVPQkd95Urniy665kZEfljBiRfARPtPz0f+jD+P3Bp/GzkHDacA
 ZtUE=
X-Gm-Gg: ASbGncvPMd8PukWWQ2vSxwkWwtt4OWcLriCO+VL9oQqQOnDHADp/0H651ZaYXtb1lZr
 vvKETo/QYM/7/F5DrJrWIEKSUn/Jvm91hrBplYj7/xoweatyFTkXKkNP/L9agFnvXb6dPfACBqM
 GWgF+ZhImPsCkFY73U21w8y10IC33F+LKDkD5jTr+r59F8LgwYBuMzLouSkXeE3h7Ge4RtSGwSJ
 UQgyqxm9SSRu9taX/rJJuW1vlUX/p9F/1FC11eSnXyHt1TCwFP1tCTf
X-Google-Smtp-Source: AGHT+IFoe8gDxr+alMHHQuTDU0AyJbhcDnWAM9pmiTIngaibjftJJMk+DYrmHuUZSjN3+tq20v0Xzg==
X-Received: by 2002:a05:6a00:6c88:b0:728:15fd:dabb with SMTP id
 d2e1a72fcca58-72aa9a43affmr6562513b3a.8.1734633135964; 
 Thu, 19 Dec 2024 10:32:15 -0800 (PST)
Received: from pc.. ([38.39.164.180]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-72aad90b302sm1624733b3a.175.2024.12.19.10.32.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Dec 2024 10:32:15 -0800 (PST)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: Eduardo Habkost <eduardo@habkost.net>, Fabiano Rosas <farosas@suse.de>,
 Peter Maydell <peter.maydell@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>, Zhao Liu <zhao1.liu@intel.com>,
 qemu-arm@nongnu.org, Laurent Vivier <lvivier@redhat.com>,
 alex.bennee@linaro.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v2 2/3] target/arm: change default pauth algorithm to impdef
Date: Thu, 19 Dec 2024 10:32:10 -0800
Message-Id: <20241219183211.3493974-3-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241219183211.3493974-1-pierrick.bouvier@linaro.org>
References: <20241219183211.3493974-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::432;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x432.google.com
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

Pointer authentication on aarch64 is pretty expensive (up to 50% of
execution time) when running a virtual machine with tcg and -cpu max
(which enables pauth=on).

The advice is always: use pauth-impdef=on.
Our documentation even mentions it "by default" in
docs/system/introduction.rst.

Thus, we change the default to use impdef by default. This does not
affect kvm or hvf acceleration, since pauth algorithm used is the one
from host cpu.

This change is retro compatible, in terms of cli, with previous
versions, as the semantic of using -cpu max,pauth-impdef=on, and -cpu
max,pauth-qarma3=on is preserved.
The new option introduced in previous patch and matching old default is
-cpu max,pauth-qarma5=on.
It is retro compatible with migration as well, by defining a backcompat
property, that will use qarma5 by default for virt machine <= 9.2.
Tested by saving and restoring a vm from qemu 9.2.0 into qemu-master
(10.0) for cpus neoverse-n2 and max.

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 docs/system/arm/cpu-features.rst |  2 +-
 docs/system/introduction.rst     |  2 +-
 target/arm/cpu.h                 |  3 +++
 hw/core/machine.c                |  4 +++-
 target/arm/cpu.c                 |  2 ++
 target/arm/cpu64.c               | 22 ++++++++++++++++------
 6 files changed, 26 insertions(+), 9 deletions(-)

diff --git a/docs/system/arm/cpu-features.rst b/docs/system/arm/cpu-features.rst
index d69ebc2b852..37d5dfd15b3 100644
--- a/docs/system/arm/cpu-features.rst
+++ b/docs/system/arm/cpu-features.rst
@@ -223,7 +223,7 @@ Below is the list of TCG VCPU features and their descriptions.
   When ``pauth`` is enabled, select the architected QARMA5 algorithm.
 
 Without ``pauth-impdef``, ``pauth-qarma3`` or ``pauth-qarma5`` enabled,
-the architected QARMA5 algorithm is used.  The architected QARMA5
+the QEMU impdef algorithm is used.  The architected QARMA5
 and QARMA3 algorithms have good cryptographic properties, but can
 be quite slow to emulate.  The impdef algorithm used by QEMU is
 non-cryptographic but significantly faster.
diff --git a/docs/system/introduction.rst b/docs/system/introduction.rst
index 746707eb00e..338d3745c3c 100644
--- a/docs/system/introduction.rst
+++ b/docs/system/introduction.rst
@@ -169,7 +169,7 @@ would default to it anyway.
 
 .. code::
 
- -cpu max,pauth-impdef=on \
+ -cpu max \
  -smp 4 \
  -accel tcg \
 
diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index b7500bebd7f..276a7a557ba 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -972,6 +972,9 @@ struct ArchCPU {
     /* QOM property to indicate we should use the back-compat CNTFRQ default */
     bool backcompat_cntfrq;
 
+    /* QOM property to indicate we should use the back-compat QARMA5 default */
+    bool backcompat_pauth_default_use_qarma5;
+
     /* Specify the number of cores in this CPU cluster. Used for the L2CTLR
      * register.
      */
diff --git a/hw/core/machine.c b/hw/core/machine.c
index d970f753e37..de1547994c4 100644
--- a/hw/core/machine.c
+++ b/hw/core/machine.c
@@ -36,7 +36,9 @@
 #include "hw/virtio/virtio-iommu.h"
 #include "audio/audio.h"
 
-GlobalProperty hw_compat_9_2[] = {};
+GlobalProperty hw_compat_9_2[] = {
+    {"arm-cpu", "backcompat-pauth-default-use-qarma5", "true"},
+};
 const size_t hw_compat_9_2_len = G_N_ELEMENTS(hw_compat_9_2);
 
 GlobalProperty hw_compat_9_1[] = {
diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index 1afa07511e3..68f1ab639b8 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -2652,6 +2652,8 @@ static const Property arm_cpu_properties[] = {
     DEFINE_PROP_INT32("core-count", ARMCPU, core_count, -1),
     /* True to default to the backward-compat old CNTFRQ rather than 1Ghz */
     DEFINE_PROP_BOOL("backcompat-cntfrq", ARMCPU, backcompat_cntfrq, false),
+    DEFINE_PROP_BOOL("backcompat-pauth-default-use-qarma5", ARMCPU,
+                      backcompat_pauth_default_use_qarma5, false),
     DEFINE_PROP_END_OF_LIST()
 };
 
diff --git a/target/arm/cpu64.c b/target/arm/cpu64.c
index 9a193d2b489..045b94fcb4d 100644
--- a/target/arm/cpu64.c
+++ b/target/arm/cpu64.c
@@ -529,15 +529,25 @@ void arm_cpu_pauth_finalize(ARMCPU *cpu, Error **errp)
                 return;
             }
 
-            if (cpu->prop_pauth_impdef) {
-                isar1 = FIELD_DP64(isar1, ID_AA64ISAR1, API, features);
-                isar1 = FIELD_DP64(isar1, ID_AA64ISAR1, GPI, 1);
+            bool use_default = !cpu->prop_pauth_qarma5 &&
+                               !cpu->prop_pauth_qarma3 &&
+                               !cpu->prop_pauth_impdef;
+
+            if (cpu->prop_pauth_qarma5 ||
+                (use_default &&
+                 cpu->backcompat_pauth_default_use_qarma5)) {
+                isar1 = FIELD_DP64(isar1, ID_AA64ISAR1, APA, features);
+                isar1 = FIELD_DP64(isar1, ID_AA64ISAR1, GPA, 1);
             } else if (cpu->prop_pauth_qarma3) {
                 isar2 = FIELD_DP64(isar2, ID_AA64ISAR2, APA3, features);
                 isar2 = FIELD_DP64(isar2, ID_AA64ISAR2, GPA3, 1);
-            } else { /* default is pauth-qarma5 */
-                isar1 = FIELD_DP64(isar1, ID_AA64ISAR1, APA, features);
-                isar1 = FIELD_DP64(isar1, ID_AA64ISAR1, GPA, 1);
+            } else if (cpu->prop_pauth_impdef ||
+                       (use_default &&
+                        !cpu->backcompat_pauth_default_use_qarma5)) {
+                isar1 = FIELD_DP64(isar1, ID_AA64ISAR1, API, features);
+                isar1 = FIELD_DP64(isar1, ID_AA64ISAR1, GPI, 1);
+            } else {
+                g_assert_not_reached();
             }
         } else if (cpu->prop_pauth_impdef ||
                    cpu->prop_pauth_qarma3 ||
-- 
2.39.5


