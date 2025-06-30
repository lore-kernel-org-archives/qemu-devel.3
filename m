Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82E6EC83000
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Jun 2025 08:14:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uW9eF-00042Y-9L; Mon, 30 Jun 2025 04:13:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1uW9eC-00040i-Hm
 for qemu-devel@nongnu.org; Mon, 30 Jun 2025 04:13:52 -0400
Received: from mgamail.intel.com ([192.198.163.15])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1uW9eA-0008Fh-FG
 for qemu-devel@nongnu.org; Mon, 30 Jun 2025 04:13:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1751271230; x=1782807230;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=wbnYOcHpb08DaNDk4xqwBS52v0jf+Fk+vZfKyddt4bk=;
 b=jMcgLZE5hLx3jKteij4dhAxaOhqHmyRPd0QjcLHEBKjFjJhuktBO3WuG
 z/CRSYg0XnzmeDvdjXazKukS/nltDboSjdJ8WG91vBoBpxhg/1Yy8PHHo
 WKHbkihIqgMD2TCmsfgssAewKMHX6bWrKam8xkpeGm2VnVq6YbvOFUNrf
 MIDcKQ/37QlSYwhbElXKWHEeTm35Fc5GsCycbi32ioGBUCSWVPLllFZQQ
 pX/BJ+XNRdXMt9VsZcxV3mJNNAGQjxPAEMG/HG5HZmc4uG2GY+jMQj12h
 gC0WTwP54+12KRMlTjsROdMdW8h9+gYn+WaOmwOM5+yD14yobNlkGh89w A==;
X-CSE-ConnectionGUID: kzNr7SKRT1iL6ykjtFX4dw==
X-CSE-MsgGUID: dvPhy3c7SFiE0DPXUeL7WA==
X-IronPort-AV: E=McAfee;i="6800,10657,11479"; a="53637410"
X-IronPort-AV: E=Sophos;i="6.16,277,1744095600"; d="scan'208";a="53637410"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
 by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Jun 2025 01:13:43 -0700
X-CSE-ConnectionGUID: MNl0pe2VTpy75SF2gQiotg==
X-CSE-MsgGUID: NZNABDqURWixCRQd3azYkw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,277,1744095600"; d="scan'208";a="152777301"
Received: from lxy-clx-4s.sh.intel.com ([10.239.48.52])
 by orviesa010.jf.intel.com with ESMTP; 30 Jun 2025 01:13:41 -0700
From: Xiaoyao Li <xiaoyao.li@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Zhao Liu <zhao1.liu@intel.com>, Marcelo Tosatti <mtosatti@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org,
 xiaoyao.li@intel.com
Subject: [PATCH 4/4] i386/cpu: Unify family,
 model and stepping calculation for x86 CPU
Date: Mon, 30 Jun 2025 16:06:10 +0800
Message-ID: <20250630080610.3151956-5-xiaoyao.li@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250630080610.3151956-1-xiaoyao.li@intel.com>
References: <20250630080610.3151956-1-xiaoyao.li@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.198.163.15; envelope-from=xiaoyao.li@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -33
X-Spam_score: -3.4
X-Spam_bar: ---
X-Spam_report: (-3.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HK_RANDOM_ENVFROM=0.001, HK_RANDOM_FROM=0.999, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

There are multiple places where CPUID family/model/stepping info
are retrieved from env->cpuid_version.

Besides, the calculation of family and model inside host_cpu_vendor_fms()
doesn't comply to what Intel and AMD define. For family, both Intel
and AMD define that Extended Family ID needs to be counted only when
(base) Family is 0xF. For model, Intel counts Extended Model when
(base) Family is 0x6 or 0xF, while AMD counts EXtended MOdel when
(base) Family is 0xF.

Introduce generic helper functions to get family, model and stepping
from the EAX value of CPUID leaf 1, with the correct calculation
formula.

Signed-off-by: Xiaoyao Li <xiaoyao.li@intel.com>
---
Note, for the calculation of model, it uses the same algorithm as Linux
kernel that counts Extended model when (base) Family is >= 6. To me, this
has the assumption that AMD always has a (base) Family of 0xF and Intel
doens't have processor with (base) Family between (0x6, 0xF).

I'm not sure about the rule on Zhaoxin and Hygon so that not sure if the
contidition of base Family >= 6 works for them or not.

For Zhaoxin, there is "YongFeng" defined in QEMU, which has Family 7 and
model 11. The model 11 doesn't require the Extended model field. So
I'm not sure the rule on Zhaoxin.

For Hygon, there is "Dhyana" defined in QEMU, which has Family 24 and
model 0. The model 0 doens't requrie the Extended model field as well.
---
 target/i386/cpu.c      | 12 ++++--------
 target/i386/cpu.h      | 30 ++++++++++++++++++++++++++++++
 target/i386/host-cpu.c |  6 +++---
 target/i386/kvm/kvm.c  |  2 +-
 4 files changed, 38 insertions(+), 12 deletions(-)

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 83858358f5ec..51fcc8ba9867 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -6324,10 +6324,7 @@ static void x86_cpuid_version_get_family(Object *obj, Visitor *v,
     CPUX86State *env = &cpu->env;
     uint64_t value;
 
-    value = (env->cpuid_version >> 8) & 0xf;
-    if (value == 0xf) {
-        value += (env->cpuid_version >> 20) & 0xff;
-    }
+    value = x86_cpu_family(env->cpuid_version);
     visit_type_uint64(v, name, &value, errp);
 }
 
@@ -6365,8 +6362,7 @@ static void x86_cpuid_version_get_model(Object *obj, Visitor *v,
     CPUX86State *env = &cpu->env;
     uint64_t value;
 
-    value = (env->cpuid_version >> 4) & 0xf;
-    value |= ((env->cpuid_version >> 16) & 0xf) << 4;
+    value = x86_cpu_model(env->cpuid_version);
     visit_type_uint64(v, name, &value, errp);
 }
 
@@ -6400,7 +6396,7 @@ static void x86_cpuid_version_get_stepping(Object *obj, Visitor *v,
     CPUX86State *env = &cpu->env;
     uint64_t value;
 
-    value = env->cpuid_version & 0xf;
+    value = x86_cpu_stepping(env->cpuid_version);
     visit_type_uint64(v, name, &value, errp);
 }
 
@@ -8154,7 +8150,7 @@ static void mce_init(X86CPU *cpu)
     CPUX86State *cenv = &cpu->env;
     unsigned int bank;
 
-    if (((cenv->cpuid_version >> 8) & 0xf) >= 6
+    if (x86_cpu_family(cenv->cpuid_version) >= 6
         && (cenv->features[FEAT_1_EDX] & (CPUID_MCE | CPUID_MCA)) ==
             (CPUID_MCE | CPUID_MCA)) {
         cenv->mcg_cap = MCE_CAP_DEF | MCE_BANKS_DEF |
diff --git a/target/i386/cpu.h b/target/i386/cpu.h
index b83c521d9fbb..b589a00c80d7 100644
--- a/target/i386/cpu.h
+++ b/target/i386/cpu.h
@@ -2671,6 +2671,36 @@ static inline int32_t x86_get_a20_mask(CPUX86State *env)
     }
 }
 
+static inline uint32_t x86_cpu_family(uint32_t eax)
+{
+    uint32_t family = (eax >> 8) & 0xf;
+
+    if (family == 0xf) {
+        family += (eax >> 20) & 0xff;
+    }
+
+    return family;
+}
+
+static inline uint32_t x86_cpu_model(uint32_t eax)
+{
+    uint32_t family, model;
+
+    family = x86_cpu_family(eax);
+    model = (eax >> 4) & 0xf;
+
+    if (family >= 0x6) {
+        model += ((eax >> 16) & 0xf) << 4;
+    }
+
+    return model;
+}
+
+static inline uint32_t x86_cpu_stepping(uint32_t eax)
+{
+    return eax & 0xf;
+}
+
 static inline bool cpu_has_vmx(CPUX86State *env)
 {
     return env->features[FEAT_1_ECX] & CPUID_EXT_VMX;
diff --git a/target/i386/host-cpu.c b/target/i386/host-cpu.c
index 16c236478e2b..383c42d4ae3d 100644
--- a/target/i386/host-cpu.c
+++ b/target/i386/host-cpu.c
@@ -117,13 +117,13 @@ void host_cpu_vendor_fms(char *vendor, int *family, int *model, int *stepping)
 
     host_cpuid(0x1, 0, &eax, &ebx, &ecx, &edx);
     if (family) {
-        *family = ((eax >> 8) & 0x0F) + ((eax >> 20) & 0xFF);
+        *family = x86_cpu_family(eax);
     }
     if (model) {
-        *model = ((eax >> 4) & 0x0F) | ((eax & 0xF0000) >> 12);
+        *model = x86_cpu_model(eax);
     }
     if (stepping) {
-        *stepping = eax & 0x0F;
+        *stepping = x86_cpu_stepping(eax);
     }
 }
 
diff --git a/target/i386/kvm/kvm.c b/target/i386/kvm/kvm.c
index 234878c613f6..650d96210192 100644
--- a/target/i386/kvm/kvm.c
+++ b/target/i386/kvm/kvm.c
@@ -2259,7 +2259,7 @@ int kvm_arch_init_vcpu(CPUState *cs)
     cpuid_i = kvm_x86_build_cpuid(env, cpuid_data.entries, cpuid_i);
     cpuid_data.cpuid.nent = cpuid_i;
 
-    if (((env->cpuid_version >> 8)&0xF) >= 6
+    if (x86_cpu_family(env->cpuid_version) >= 6
         && (env->features[FEAT_1_EDX] & (CPUID_MCE | CPUID_MCA)) ==
            (CPUID_MCE | CPUID_MCA)) {
         uint64_t mcg_cap, unsupported_caps;
-- 
2.43.0


