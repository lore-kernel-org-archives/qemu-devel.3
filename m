Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC2E1D1CA38
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Nov 2024 06:47:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t8DDZ-0000XA-Bf; Tue, 05 Nov 2024 01:39:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1t8DDN-000896-I8
 for qemu-devel@nongnu.org; Tue, 05 Nov 2024 01:38:57 -0500
Received: from mgamail.intel.com ([198.175.65.18])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1t8DDL-0001w0-F3
 for qemu-devel@nongnu.org; Tue, 05 Nov 2024 01:38:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1730788735; x=1762324735;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=63P5g04tq2r6PcAIPsWb8iPHQuE0MH+gEuTLFzYddZI=;
 b=cTAdsF7XPNnZHGt8qt1fk7zeI73w44GZJvRyatd3UqHVVBoSaSsinAw8
 zsDW5NcoaRE06Pt3KDq+0f6aMRlgj8Z0avJrd8Xqh9uAGJIgYhog9pNoP
 Y4rnf1brIjgpu1TEjML7oeU6Yq1GDSaCWMC/CxJoDv/V98ehtixH/jnnP
 6ibx3Q7ZLwqdAmGv7OmQFF1yVnhc+ylQzMgZDex8BoPdOGtN7bS+cOnGB
 N5A7lrHKcFYfXspX38laWDnty9IN7Ai534fAMTVutlmQB4HdxGs09GBs7
 cHDJu04sRUPu4KRkz9xm9I3c7mU8ca3oo69W52a/hs9jrgvoBIH0t8ogH A==;
X-CSE-ConnectionGUID: CGoGwe+YT8SOJE1XHz5Wzg==
X-CSE-MsgGUID: 8MqhssINTvuUjlr46ub66g==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="30689689"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; d="scan'208";a="30689689"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
 by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Nov 2024 22:38:45 -0800
X-CSE-ConnectionGUID: MdCsSwMrQqKD4Co1gmDzvA==
X-CSE-MsgGUID: KOGn8PVPRDGFMXhDPQsGvQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,259,1725346800"; d="scan'208";a="83989240"
Received: from lxy-clx-4s.sh.intel.com ([10.239.48.52])
 by fmviesa009.fm.intel.com with ESMTP; 04 Nov 2024 22:38:40 -0800
From: Xiaoyao Li <xiaoyao.li@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>, Riku Voipio <riku.voipio@iki.fi>,
 Richard Henderson <richard.henderson@linaro.org>,
 Zhao Liu <zhao1.liu@intel.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Igor Mammedov <imammedo@redhat.com>, Ani Sinha <anisinha@redhat.com>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>, Cornelia Huck <cohuck@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Marcelo Tosatti <mtosatti@redhat.com>, rick.p.edgecombe@intel.com,
 kvm@vger.kernel.org, qemu-devel@nongnu.org, xiaoyao.li@intel.com
Subject: [PATCH v6 33/60] i386/cpu: introduce
 x86_confidenetial_guest_cpu_realizefn()
Date: Tue,  5 Nov 2024 01:23:41 -0500
Message-Id: <20241105062408.3533704-34-xiaoyao.li@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241105062408.3533704-1-xiaoyao.li@intel.com>
References: <20241105062408.3533704-1-xiaoyao.li@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=198.175.65.18; envelope-from=xiaoyao.li@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -39
X-Spam_score: -4.0
X-Spam_bar: ----
X-Spam_report: (-4.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.34,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HK_RANDOM_ENVFROM=0.001, HK_RANDOM_FROM=0.781, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

To execute confidential guest specific cpu realize operations.

Signed-off-by: Xiaoyao Li <xiaoyao.li@intel.com>
---
changes in v6:
 - new patch;
---
 target/i386/confidential-guest.h | 12 ++++++++++++
 target/i386/cpu.c                | 13 ++++++++++++-
 2 files changed, 24 insertions(+), 1 deletion(-)

diff --git a/target/i386/confidential-guest.h b/target/i386/confidential-guest.h
index 38169ed68e06..4b7ea91023dc 100644
--- a/target/i386/confidential-guest.h
+++ b/target/i386/confidential-guest.h
@@ -40,6 +40,7 @@ struct X86ConfidentialGuestClass {
     /* <public> */
     int (*kvm_type)(X86ConfidentialGuest *cg);
     void (*cpu_instance_init)(X86ConfidentialGuest *cg, CPUState *cpu);
+    void (*cpu_realizefn)(X86ConfidentialGuest *cg, CPUState *cpu, Error **errp);
     uint32_t (*mask_cpuid_features)(X86ConfidentialGuest *cg, uint32_t feature, uint32_t index,
                                     int reg, uint32_t value);
 };
@@ -70,6 +71,17 @@ static inline void x86_confidential_guest_cpu_instance_init(X86ConfidentialGuest
     }
 }
 
+static inline void x86_confidenetial_guest_cpu_realizefn(X86ConfidentialGuest *cg,
+                                                         CPUState *cpu,
+                                                         Error **errp)
+{
+    X86ConfidentialGuestClass *klass = X86_CONFIDENTIAL_GUEST_GET_CLASS(cg);
+
+    if (klass->cpu_realizefn) {
+        klass->cpu_realizefn(cg, cpu, errp);
+    }
+}
+
 /**
  * x86_confidential_guest_mask_cpuid_features:
  *
diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index c7d65bbeab9b..1ffbafef03e7 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -7848,6 +7848,18 @@ static void x86_cpu_realizefn(DeviceState *dev, Error **errp)
         return;
     }
 
+#ifndef CONFIG_USER_ONLY
+    MachineState *ms = MACHINE(qdev_get_machine());
+
+    if (ms->cgs) {
+        x86_confidenetial_guest_cpu_realizefn(X86_CONFIDENTIAL_GUEST(ms->cgs),
+                                              cs, &local_err);
+        if (local_err != NULL) {
+            goto out;
+        }
+    }
+#endif
+
     if (xcc->host_cpuid_required && !accel_uses_host_cpuid()) {
         g_autofree char *name = x86_cpu_class_get_model_name(xcc);
         error_setg(&local_err, "CPU model '%s' requires KVM or HVF", name);
@@ -7972,7 +7984,6 @@ static void x86_cpu_realizefn(DeviceState *dev, Error **errp)
     }
 
 #ifndef CONFIG_USER_ONLY
-    MachineState *ms = MACHINE(qdev_get_machine());
     qemu_register_reset(x86_cpu_machine_reset_cb, cpu);
 
     if (cpu->env.features[FEAT_1_EDX] & CPUID_APIC || ms->smp.cpus > 1) {
-- 
2.34.1


