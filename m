Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 540F1D11702
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Dec 2025 16:09:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vQSuo-0003s4-M0; Tue, 02 Dec 2025 11:07:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1vQSui-0003KZ-69; Tue, 02 Dec 2025 11:07:40 -0500
Received: from mgamail.intel.com ([192.198.163.7])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1vQSuf-0008Cu-LA; Tue, 02 Dec 2025 11:07:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1764691658; x=1796227658;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=xbQmgoe2IOU9HSvyb9lb+wg4Nep+wx7DJvs7Fx9TRRo=;
 b=kkmfjHIkpZXBkDLXeHCZ1/CXQI3nKXljtwT6iibB7F1UvBuFsQxcx281
 qvvHSMxT4xwYK2z7lZgB6/U0j4yQwFBisWHfm+32gg8ti1JY9xl7XwdSy
 0G1gPL/cv8qnQwo12UMgfGd++Gj3d0THFwgLByKNPnubcJqmrtdBuq9Kx
 hguG1FMRI41Be63IXGFNU64s1qrMz4Y0pTtv3wNmX+W2k9Zw+UX+A6S1h
 fBshfRWMF4I1HJ3n5OxAKmLYlDG+THIaeSluBm6vfHL/aaeQupXwB4hXV
 mU/TvV+nhTo01mhRbeCieQqBzdZ9O1JpwgtlxXbOwKOwj4smM9P3HdDZ7 Q==;
X-CSE-ConnectionGUID: jXU7DIaVRJ2ZPHu7NaEg9Q==
X-CSE-MsgGUID: PpqVXOERRyGscs/UR/6dBg==
X-IronPort-AV: E=McAfee;i="6800,10657,11630"; a="92142974"
X-IronPort-AV: E=Sophos;i="6.20,243,1758610800"; d="scan'208";a="92142974"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
 by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Dec 2025 08:07:36 -0800
X-CSE-ConnectionGUID: K6boL9nXQgOc2bG5wpxHdg==
X-CSE-MsgGUID: bP0+wkBRQX+2cM0IZVd8Aw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,243,1758610800"; d="scan'208";a="199537874"
Received: from liuzhao-optiplex-7080.sh.intel.com ([10.239.160.39])
 by orviesa005.jf.intel.com with ESMTP; 02 Dec 2025 08:07:26 -0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Thomas Huth <thuth@redhat.com>
Cc: qemu-devel@nongnu.org, devel@lists.libvirt.org, kvm@vger.kernel.org,
 qemu-riscv@nongnu.org, qemu-arm@nongnu.org,
 Richard Henderson <richard.henderson@linaro.org>,
 Sergio Lopez <slp@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Laurent Vivier <lvivier@redhat.com>, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Yi Liu <yi.l.liu@intel.com>, Eduardo Habkost <eduardo@habkost.net>,
 Alistair Francis <alistair.francis@wdc.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Marcelo Tosatti <mtosatti@redhat.com>, Weiwei Li <liwei1518@gmail.com>,
 Amit Shah <amit@kernel.org>, Xiaoyao Li <xiaoyao.li@intel.com>,
 Yanan Wang <wangyanan55@huawei.com>, Helge Deller <deller@gmx.de>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Ani Sinha <anisinha@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 =?UTF-8?q?Cl=C3=A9ment=20Mathieu--Drif?= <clement.mathieu--drif@eviden.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Huacai Chen <chenhuacai@kernel.org>, Jason Wang <jasowang@redhat.com>,
 Mark Cave-Ayland <mark.caveayland@nutanix.com>,
 BALATON Zoltan <balaton@eik.bme.hu>, Peter Krempa <pkrempa@redhat.com>,
 Jiri Denemark <jdenemar@redhat.com>, Zhao Liu <zhao1.liu@intel.com>
Subject: [PATCH v5 23/28] target/i386/cpu: Remove
 CPUX86State::full_cpuid_auto_level field
Date: Wed,  3 Dec 2025 00:28:30 +0800
Message-Id: <20251202162835.3227894-24-zhao1.liu@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251202162835.3227894-1-zhao1.liu@intel.com>
References: <20251202162835.3227894-1-zhao1.liu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.198.163.7; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

From: Philippe Mathieu-Daudé <philmd@linaro.org>

The CPUX86State::full_cpuid_auto_level boolean was only
disabled for the pc-q35-2.7 and pc-i440fx-2.7 machines,
which got removed. Being now always %true, we can remove
it and simplify x86_cpu_expand_features().

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Zhao Liu <zhao1.liu@intel.com>
Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
---
Note, although libvirt still uses this property in its test cases, it
was confirmed this property is not exposed to user directly [*].

[*]: https://lore.kernel.org/qemu-devel/aDmphSY1MSxu7L9R@orkuz.int.mamuti.net/
---
 target/i386/cpu.c | 111 ++++++++++++++++++++++------------------------
 target/i386/cpu.h |   3 --
 2 files changed, 54 insertions(+), 60 deletions(-)

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 641777578637..72c69ba81c1b 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -9019,69 +9019,67 @@ void x86_cpu_expand_features(X86CPU *cpu, Error **errp)
 
     /* CPUID[EAX=7,ECX=0].EBX always increased level automatically: */
     x86_cpu_adjust_feat_level(cpu, FEAT_7_0_EBX);
-    if (cpu->full_cpuid_auto_level) {
-        x86_cpu_adjust_feat_level(cpu, FEAT_1_EDX);
-        x86_cpu_adjust_feat_level(cpu, FEAT_1_ECX);
-        x86_cpu_adjust_feat_level(cpu, FEAT_6_EAX);
-        x86_cpu_adjust_feat_level(cpu, FEAT_7_0_ECX);
-        x86_cpu_adjust_feat_level(cpu, FEAT_7_1_EAX);
-        x86_cpu_adjust_feat_level(cpu, FEAT_7_1_ECX);
-        x86_cpu_adjust_feat_level(cpu, FEAT_7_1_EDX);
-        x86_cpu_adjust_feat_level(cpu, FEAT_7_2_EDX);
-        x86_cpu_adjust_feat_level(cpu, FEAT_8000_0001_EDX);
-        x86_cpu_adjust_feat_level(cpu, FEAT_8000_0001_ECX);
-        x86_cpu_adjust_feat_level(cpu, FEAT_8000_0007_EDX);
-        x86_cpu_adjust_feat_level(cpu, FEAT_8000_0008_EBX);
-        x86_cpu_adjust_feat_level(cpu, FEAT_C000_0001_EDX);
-        x86_cpu_adjust_feat_level(cpu, FEAT_SVM);
-        x86_cpu_adjust_feat_level(cpu, FEAT_XSAVE);
-
-        /* Intel Processor Trace requires CPUID[0x14] */
-        if ((env->features[FEAT_7_0_EBX] & CPUID_7_0_EBX_INTEL_PT)) {
-            if (cpu->intel_pt_auto_level) {
-                x86_cpu_adjust_level(cpu, &cpu->env.cpuid_min_level, 0x14);
-            } else if (cpu->env.cpuid_min_level < 0x14) {
-                mark_unavailable_features(cpu, FEAT_7_0_EBX,
-                    CPUID_7_0_EBX_INTEL_PT,
-                    "Intel PT need CPUID leaf 0x14, please set by \"-cpu ...,intel-pt=on,min-level=0x14\"");
-            }
+    x86_cpu_adjust_feat_level(cpu, FEAT_1_EDX);
+    x86_cpu_adjust_feat_level(cpu, FEAT_1_ECX);
+    x86_cpu_adjust_feat_level(cpu, FEAT_6_EAX);
+    x86_cpu_adjust_feat_level(cpu, FEAT_7_0_ECX);
+    x86_cpu_adjust_feat_level(cpu, FEAT_7_1_EAX);
+    x86_cpu_adjust_feat_level(cpu, FEAT_7_1_ECX);
+    x86_cpu_adjust_feat_level(cpu, FEAT_7_1_EDX);
+    x86_cpu_adjust_feat_level(cpu, FEAT_7_2_EDX);
+    x86_cpu_adjust_feat_level(cpu, FEAT_8000_0001_EDX);
+    x86_cpu_adjust_feat_level(cpu, FEAT_8000_0001_ECX);
+    x86_cpu_adjust_feat_level(cpu, FEAT_8000_0007_EDX);
+    x86_cpu_adjust_feat_level(cpu, FEAT_8000_0008_EBX);
+    x86_cpu_adjust_feat_level(cpu, FEAT_C000_0001_EDX);
+    x86_cpu_adjust_feat_level(cpu, FEAT_SVM);
+    x86_cpu_adjust_feat_level(cpu, FEAT_XSAVE);
+
+    /* Intel Processor Trace requires CPUID[0x14] */
+    if ((env->features[FEAT_7_0_EBX] & CPUID_7_0_EBX_INTEL_PT)) {
+        if (cpu->intel_pt_auto_level) {
+            x86_cpu_adjust_level(cpu, &cpu->env.cpuid_min_level, 0x14);
+        } else if (cpu->env.cpuid_min_level < 0x14) {
+            mark_unavailable_features(cpu, FEAT_7_0_EBX,
+                CPUID_7_0_EBX_INTEL_PT,
+                "Intel PT need CPUID leaf 0x14, please set by \"-cpu ...,intel-pt=on,min-level=0x14\"");
         }
+    }
 
-        /*
-         * Intel CPU topology with multi-dies support requires CPUID[0x1F].
-         * For AMD Rome/Milan, cpuid level is 0x10, and guest OS should detect
-         * extended toplogy by leaf 0xB. Only adjust it for Intel CPU, unless
-         * cpu->vendor_cpuid_only has been unset for compatibility with older
-         * machine types.
-         */
-        if (x86_has_cpuid_0x1f(cpu) &&
-            (IS_INTEL_CPU(env) || !cpu->vendor_cpuid_only)) {
-            x86_cpu_adjust_level(cpu, &env->cpuid_min_level, 0x1F);
-        }
+    /*
+     * Intel CPU topology with multi-dies support requires CPUID[0x1F].
+     * For AMD Rome/Milan, cpuid level is 0x10, and guest OS should detect
+     * extended toplogy by leaf 0xB. Only adjust it for Intel CPU, unless
+     * cpu->vendor_cpuid_only has been unset for compatibility with older
+     * machine types.
+     */
+    if (x86_has_cpuid_0x1f(cpu) &&
+        (IS_INTEL_CPU(env) || !cpu->vendor_cpuid_only)) {
+        x86_cpu_adjust_level(cpu, &env->cpuid_min_level, 0x1F);
+    }
 
-        /* Advanced Vector Extensions 10 (AVX10) requires CPUID[0x24] */
-        if (env->features[FEAT_7_1_EDX] & CPUID_7_1_EDX_AVX10) {
-            x86_cpu_adjust_level(cpu, &env->cpuid_min_level, 0x24);
-        }
+    /* Advanced Vector Extensions 10 (AVX10) requires CPUID[0x24] */
+    if (env->features[FEAT_7_1_EDX] & CPUID_7_1_EDX_AVX10) {
+        x86_cpu_adjust_level(cpu, &env->cpuid_min_level, 0x24);
+    }
 
-        /* SVM requires CPUID[0x8000000A] */
-        if (env->features[FEAT_8000_0001_ECX] & CPUID_EXT3_SVM) {
-            x86_cpu_adjust_level(cpu, &env->cpuid_min_xlevel, 0x8000000A);
-        }
+    /* SVM requires CPUID[0x8000000A] */
+    if (env->features[FEAT_8000_0001_ECX] & CPUID_EXT3_SVM) {
+        x86_cpu_adjust_level(cpu, &env->cpuid_min_xlevel, 0x8000000A);
+    }
 
-        /* SEV requires CPUID[0x8000001F] */
-        if (sev_enabled()) {
-            x86_cpu_adjust_level(cpu, &env->cpuid_min_xlevel, 0x8000001F);
-        }
+    /* SEV requires CPUID[0x8000001F] */
+    if (sev_enabled()) {
+        x86_cpu_adjust_level(cpu, &env->cpuid_min_xlevel, 0x8000001F);
+    }
 
-        if (env->features[FEAT_8000_0021_EAX]) {
-            x86_cpu_adjust_level(cpu, &env->cpuid_min_xlevel, 0x80000021);
-        }
+    if (env->features[FEAT_8000_0021_EAX]) {
+        x86_cpu_adjust_level(cpu, &env->cpuid_min_xlevel, 0x80000021);
+    }
 
-        /* SGX requires CPUID[0x12] for EPC enumeration */
-        if (env->features[FEAT_7_0_EBX] & CPUID_7_0_EBX_SGX) {
-            x86_cpu_adjust_level(cpu, &env->cpuid_min_level, 0x12);
-        }
+    /* SGX requires CPUID[0x12] for EPC enumeration */
+    if (env->features[FEAT_7_0_EBX] & CPUID_7_0_EBX_SGX) {
+        x86_cpu_adjust_level(cpu, &env->cpuid_min_level, 0x12);
     }
 
     /* Set cpuid_*level* based on cpuid_min_*level, if not explicitly set */
@@ -10010,7 +10008,6 @@ static const Property x86_cpu_properties[] = {
     DEFINE_PROP_UINT32("min-xlevel2", X86CPU, env.cpuid_min_xlevel2, 0),
     DEFINE_PROP_UINT8("avx10-version", X86CPU, env.avx10_version, 0),
     DEFINE_PROP_UINT64("ucode-rev", X86CPU, ucode_rev, 0),
-    DEFINE_PROP_BOOL("full-cpuid-auto-level", X86CPU, full_cpuid_auto_level, true),
     DEFINE_PROP_STRING("hv-vendor-id", X86CPU, hyperv_vendor),
     DEFINE_PROP_BOOL("cpuid-0xb", X86CPU, enable_cpuid_0xb, true),
     DEFINE_PROP_BOOL("x-vendor-cpuid-only", X86CPU, vendor_cpuid_only, true),
diff --git a/target/i386/cpu.h b/target/i386/cpu.h
index cee1f692a1c3..8c3eb86fa0c7 100644
--- a/target/i386/cpu.h
+++ b/target/i386/cpu.h
@@ -2292,9 +2292,6 @@ struct ArchCPU {
     /* Force to enable cpuid 0x1f */
     bool force_cpuid_0x1f;
 
-    /* Enable auto level-increase for all CPUID leaves */
-    bool full_cpuid_auto_level;
-
     /*
      * Compatibility bits for old machine types (PC machine v6.0 and older).
      * Only advertise CPUID leaves defined by the vendor.
-- 
2.34.1


