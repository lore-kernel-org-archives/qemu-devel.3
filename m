Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1606D232E2
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Jan 2026 05:33:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ve56d-0004GL-NN; Fri, 09 Jan 2026 00:32:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1ve56a-0004EU-W8
 for qemu-devel@nongnu.org; Fri, 09 Jan 2026 00:32:13 -0500
Received: from mail-pj1-x1034.google.com ([2607:f8b0:4864:20::1034])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1ve56Z-0003gh-DB
 for qemu-devel@nongnu.org; Fri, 09 Jan 2026 00:32:12 -0500
Received: by mail-pj1-x1034.google.com with SMTP id
 98e67ed59e1d1-34ccdcbe520so1320248a91.1
 for <qemu-devel@nongnu.org>; Thu, 08 Jan 2026 21:32:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1767936730; x=1768541530; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=H9MNA25nCytrrB1MJ4OeFVmsiFRsgqqEYw8vG3Tiy1o=;
 b=X7Is279OYNBaRrpitFoMBYLfNbuXgdTILZvenV1GRVRIyHLN6ST11f4aM0CpHDtpxd
 0hU/1FTD+KAU4Sj8Yf9time8fJZi3LjnS4XDvpE/9sy6UHTKmgw923ER3fWg9cPSqj7Q
 LOqx6XGOkuNPI1EWQgCM0tKslCeQbSsWc9+eLStqGJ07v6mRFr4RIB1GF4qLWFMQi4Px
 XQwm/OmgyWaoLkfXWWSZfNZPDdFryDTT77A+m2CQCDw7BZJXyQvpgW426kCAVmvV9eyV
 dkqwWHfbh9qllGhK34/s96nzzC4FCwOvYZHxLshjCHm9rEOt2AofJfWiqX9BgLZlnH5O
 Tb6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767936730; x=1768541530;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=H9MNA25nCytrrB1MJ4OeFVmsiFRsgqqEYw8vG3Tiy1o=;
 b=iTXFsOXM5cEmRVdoiWixIIFJhjVGFfr+C0etS2MAI/P/NJg/UI9LkLGMsi5TW58qbq
 SgVOWsy7DK9HY8WyZGEdFUcwoNQSuRW9JifBTeslucbECS7RJBdbEf0JAevI3QQrUSJj
 /QOsl/nyguvWeApBXzFNU0bZ8G5vA7bPlRzzEruThVk1Xpi0qbif+Xw1B3DPcDbG2fq2
 i5o0tDL1XZqIVN4xb7wvzFY6hZA2T4oOYvzFX99fUqMVEwB6hZPKL8zEoFSrjF/A+JXG
 zc4qyiw4iE6gD0qfSdAj4ulcajFVvMRSNFjihwrotRToagRuSw3YRq5vcuGzdLCIm6Zb
 50vw==
X-Gm-Message-State: AOJu0YxrpSmreUI9wlTp6mTYgZYoSVFhJw2VSOVOp8I1hjg/rPAGE8bf
 SSa0KwYlOLkJokaTsnZtGWVJJlsTDIQinQ+AAoJn07KJX1qTbJ1R4xh8lhpcZi25dtJ0P3GYveS
 ANAQr
X-Gm-Gg: AY/fxX4YkOcdaB7m+sp+/FnoBQwR/Gh23hlHOCuSIRXxNWPxnUe28kdiQmN5CQLxbXD
 vWd2N4JrWxZAfJc6hqho1wimj4Ciafr16ftey85VdB2urOhX6GKqp47WFh9JxG5NdGj8mZ18eFm
 6kWtngDuXw84cHTz52MWjDUupPxw3kDmGjXXrBylht41U7ZaNItxhMdvZWS7jrhMf2apjBremUF
 EGgUO6YT+9C4yGasvhzXR9kBZgVGf3M+hsEOiFiogigmrtkCbye87mZXmtkcjfA/HsmBce+G1Ts
 DOm40noAoivtfjHXJUNzfypz6W3IH5yuRkk24zZxR9La8i4U2qWa8gPTpDGt7+0CNk0yWjMs9Aq
 2h3/2a/SVnUBzhFmRL9B9q8007rmarTh+oxE+8gbgMEErmHse6/0VtQpQa6RjdlhO3obcdGTEeC
 V8Fq2avmRoioRrrR/FXR5jzfHweILxgirCWtMvRloz4URhhkd16OjD57UWzg1nP+Zp
X-Google-Smtp-Source: AGHT+IFjUJ73xsiaR96Cdk8yHLn1/uMMrW1lhxhRUVj3uLzGJS6nQUm4rxyHxQl+ZZ0HgwFA6gyItQ==
X-Received: by 2002:a17:90b:5b87:b0:34f:6312:f225 with SMTP id
 98e67ed59e1d1-34f63130c6bmr6907282a91.14.1767936729981; 
 Thu, 08 Jan 2026 21:32:09 -0800 (PST)
Received: from pc.taild8403c.ts.net (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-34f5fa93f30sm9260137a91.5.2026.01.08.21.32.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 08 Jan 2026 21:32:09 -0800 (PST)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Jim MacArthur <jim.macarthur@linaro.org>, anjo@rev.ng,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH 04/29] target/arm/arm-qmp-cmds.c: make compilation unit common
Date: Thu,  8 Jan 2026 21:31:33 -0800
Message-ID: <20260109053158.2800705-5-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260109053158.2800705-1-pierrick.bouvier@linaro.org>
References: <20260109053158.2800705-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1034;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pj1-x1034.google.com
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

Move gic_cap_kvm_probe to target/arm/kvm.c to remove #ifdef CONFIG_KVM.

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 target/arm/kvm_arm.h      |  3 +++
 target/arm/arm-qmp-cmds.c | 25 +------------------------
 target/arm/kvm-stub.c     |  5 +++++
 target/arm/kvm.c          | 21 +++++++++++++++++++++
 target/arm/meson.build    |  2 +-
 5 files changed, 31 insertions(+), 25 deletions(-)

diff --git a/target/arm/kvm_arm.h b/target/arm/kvm_arm.h
index 6a9b6374a6d..cc0b374254e 100644
--- a/target/arm/kvm_arm.h
+++ b/target/arm/kvm_arm.h
@@ -11,6 +11,7 @@
 #ifndef QEMU_KVM_ARM_H
 #define QEMU_KVM_ARM_H
 
+#include "qapi/qapi-types-misc-arm.h"
 #include "system/kvm.h"
 #include "target/arm/cpu-qom.h"
 
@@ -263,4 +264,6 @@ void kvm_arm_enable_mte(Object *cpuobj, Error **errp);
 
 void arm_cpu_kvm_set_irq(void *arm_cpu, int irq, int level);
 
+void arm_gic_cap_kvm_probe(GICCapability *v2, GICCapability *v3);
+
 #endif
diff --git a/target/arm/arm-qmp-cmds.c b/target/arm/arm-qmp-cmds.c
index 45df15de782..29102587bae 100644
--- a/target/arm/arm-qmp-cmds.c
+++ b/target/arm/arm-qmp-cmds.c
@@ -43,29 +43,6 @@ static GICCapability *gic_cap_new(int version)
     return cap;
 }
 
-static inline void gic_cap_kvm_probe(GICCapability *v2, GICCapability *v3)
-{
-#ifdef CONFIG_KVM
-    int fdarray[3];
-
-    if (!kvm_arm_create_scratch_host_vcpu(fdarray, NULL)) {
-        return;
-    }
-
-    /* Test KVM GICv2 */
-    if (kvm_device_supported(fdarray[1], KVM_DEV_TYPE_ARM_VGIC_V2)) {
-        v2->kernel = true;
-    }
-
-    /* Test KVM GICv3 */
-    if (kvm_device_supported(fdarray[1], KVM_DEV_TYPE_ARM_VGIC_V3)) {
-        v3->kernel = true;
-    }
-
-    kvm_arm_destroy_scratch_host_vcpu(fdarray);
-#endif
-}
-
 GICCapabilityList *qmp_query_gic_capabilities(Error **errp)
 {
     GICCapabilityList *head = NULL;
@@ -74,7 +51,7 @@ GICCapabilityList *qmp_query_gic_capabilities(Error **errp)
     v2->emulated = true;
     v3->emulated = true;
 
-    gic_cap_kvm_probe(v2, v3);
+    arm_gic_cap_kvm_probe(v2, v3);
 
     QAPI_LIST_PREPEND(head, v2);
     QAPI_LIST_PREPEND(head, v3);
diff --git a/target/arm/kvm-stub.c b/target/arm/kvm-stub.c
index c93462c5b9b..ea67deea520 100644
--- a/target/arm/kvm-stub.c
+++ b/target/arm/kvm-stub.c
@@ -124,3 +124,8 @@ bool kvm_arm_cpu_post_load(ARMCPU *cpu)
 {
     g_assert_not_reached();
 }
+
+void arm_gic_cap_kvm_probe(GICCapability *v2, GICCapability *v3)
+{
+    g_assert_not_reached();
+}
diff --git a/target/arm/kvm.c b/target/arm/kvm.c
index 48f853fff80..0677d201158 100644
--- a/target/arm/kvm.c
+++ b/target/arm/kvm.c
@@ -2568,3 +2568,24 @@ void arm_cpu_kvm_set_irq(void *arm_cpu, int irq, int level)
     }
     kvm_arm_set_irq(cs->cpu_index, KVM_ARM_IRQ_TYPE_CPU, irq_id, !!level);
 }
+
+void arm_gic_cap_kvm_probe(GICCapability *v2, GICCapability *v3)
+{
+    int fdarray[3];
+
+    if (!kvm_arm_create_scratch_host_vcpu(fdarray, NULL)) {
+        return;
+    }
+
+    /* Test KVM GICv2 */
+    if (kvm_device_supported(fdarray[1], KVM_DEV_TYPE_ARM_VGIC_V2)) {
+        v2->kernel = true;
+    }
+
+    /* Test KVM GICv3 */
+    if (kvm_device_supported(fdarray[1], KVM_DEV_TYPE_ARM_VGIC_V3)) {
+        v3->kernel = true;
+    }
+
+    kvm_arm_destroy_scratch_host_vcpu(fdarray);
+}
diff --git a/target/arm/meson.build b/target/arm/meson.build
index 462c71148d2..1a1bcde2601 100644
--- a/target/arm/meson.build
+++ b/target/arm/meson.build
@@ -16,7 +16,7 @@ arm_common_ss.add(files(
   'mmuidx.c',
 ))
 
-arm_system_ss.add(files(
+arm_common_system_ss.add(files(
   'arm-qmp-cmds.c',
 ))
 arm_system_ss.add(when: 'CONFIG_KVM', if_true: files('hyp_gdbstub.c', 'kvm.c'))
-- 
2.47.3


