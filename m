Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4CF69C02190
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jan 2025 13:45:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tdUq6-0000o3-K3; Thu, 30 Jan 2025 08:44:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1tdUq4-0000mb-Si
 for qemu-devel@nongnu.org; Thu, 30 Jan 2025 08:44:12 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1tdUq2-0003Qk-3E
 for qemu-devel@nongnu.org; Thu, 30 Jan 2025 08:44:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1738244649;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=uc9G9aeAGfHn2OUicVdP0JeeDtL9D3T72qdTSgdZmY8=;
 b=f8gRZsP/dRla5TTy4UU+k9Vjq+GKnv2KPzrVp2PtIn4hssxu4IFAhfO5qMZHb+mnTbGWFZ
 1ygUngbTTb5RsP9Ybcu4GxOEMEUN+EfD6kVQYl1hsPpbWxjuukC+jbE85BMn6x/gaqgbbB
 x+ULDWH4wti4xx5HTeFOMcMdnHNn4QA=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-473-V1reARLCP1eQPGxQZu_a4Q-1; Thu,
 30 Jan 2025 08:44:06 -0500
X-MC-Unique: V1reARLCP1eQPGxQZu_a4Q-1
X-Mimecast-MFC-AGG-ID: V1reARLCP1eQPGxQZu_a4Q
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id B737E18009D5; Thu, 30 Jan 2025 13:44:04 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.39.192.105])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id CAE961800951; Thu, 30 Jan 2025 13:44:01 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-devel@nongnu.org
Cc: Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>, Zhao Liu <zhao1.liu@intel.com>
Subject: [PATCH v2 7/9] cpu: Introduce cpu_get_phys_bits()
Date: Thu, 30 Jan 2025 14:43:44 +0100
Message-ID: <20250130134346.1754143-8-clg@redhat.com>
In-Reply-To: <20250130134346.1754143-1-clg@redhat.com>
References: <20250130134346.1754143-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -33
X-Spam_score: -3.4
X-Spam_bar: ---
X-Spam_report: (-3.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.3,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

The Intel CPU has a complex history regarding setting of the physical
address space width on KVM. A 'phys_bits' field and a "phys-bits"
property were added by commit af45907a1328 ("target-i386: Allow
physical address bits to be set") to tune this value.

In certain circumstances, it is interesting to know this value to
check that all the conditions are met for optimal operation. For
instance, when the system has a 39-bit IOMMU address space width and a
larger CPU physical address space, we expect issues when mapping the
MMIO regions of passthrough devices and it would good to report to the
user. These hybrid HW configs can be found on some consumer grade
processors or when using a vIOMMU device with default settings.

For this purpose, add an helper routine and a CPUClass callback to
return the physical address space width of a CPU.

Cc: Richard Henderson <richard.henderson@linaro.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Eduardo Habkost <eduardo@habkost.net>
Cc: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Cc: "Philippe Mathieu-Daudé" <philmd@linaro.org>
Cc: Yanan Wang <wangyanan55@huawei.com>
Cc: Zhao Liu <zhao1.liu@intel.com>
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 include/hw/core/cpu.h            |  9 +++++++++
 include/hw/core/sysemu-cpu-ops.h |  6 ++++++
 cpu-target.c                     |  5 +++++
 hw/core/cpu-system.c             | 11 +++++++++++
 target/i386/cpu.c                |  6 ++++++
 5 files changed, 37 insertions(+)

diff --git a/include/hw/core/cpu.h b/include/hw/core/cpu.h
index fb397cdfc53d12d40d3e4e7f86251fc31c48b9f6..1b3eead102ce62fcee55ab0ed5e0dff327fa2fc5 100644
--- a/include/hw/core/cpu.h
+++ b/include/hw/core/cpu.h
@@ -748,6 +748,14 @@ int cpu_asidx_from_attrs(CPUState *cpu, MemTxAttrs attrs);
  */
 bool cpu_virtio_is_big_endian(CPUState *cpu);
 
+/**
+ * cpu_get_phys_bits:
+ * @cpu: CPU
+ *
+ * Return the physical address space width of the CPU @cpu.
+ */
+uint32_t cpu_get_phys_bits(const CPUState *cpu);
+
 #endif /* CONFIG_USER_ONLY */
 
 /**
@@ -1168,6 +1176,7 @@ void cpu_exec_unrealizefn(CPUState *cpu);
 void cpu_exec_reset_hold(CPUState *cpu);
 
 const char *target_name(void);
+uint32_t target_phys_bits(void);
 
 #ifdef COMPILING_PER_TARGET
 
diff --git a/include/hw/core/sysemu-cpu-ops.h b/include/hw/core/sysemu-cpu-ops.h
index 0df5b058f50073e47d2a6b8286be5204776520d2..210b3ed57985525795b81559e41e0085969210d5 100644
--- a/include/hw/core/sysemu-cpu-ops.h
+++ b/include/hw/core/sysemu-cpu-ops.h
@@ -81,6 +81,12 @@ typedef struct SysemuCPUOps {
      */
     bool (*virtio_is_big_endian)(CPUState *cpu);
 
+    /**
+     * @get_phys_bits: Callback to return the physical address space
+     * width of a CPU.
+     */
+    uint32_t (*get_phys_bits)(const CPUState *cpu);
+
     /**
      * @legacy_vmsd: Legacy state for migration.
      *               Do not use in new targets, use #DeviceClass::vmsd instead.
diff --git a/cpu-target.c b/cpu-target.c
index 667688332c929aa53782c94343def34571272d5f..88158272c06cc42424d435b9701e33735f080239 100644
--- a/cpu-target.c
+++ b/cpu-target.c
@@ -472,3 +472,8 @@ const char *target_name(void)
 {
     return TARGET_NAME;
 }
+
+uint32_t target_phys_bits(void)
+{
+    return TARGET_PHYS_ADDR_SPACE_BITS;
+}
diff --git a/hw/core/cpu-system.c b/hw/core/cpu-system.c
index 6aae28a349a7a377d010ff9dcab5ebc29e1126ca..05067d84f4258facf4252216f17729e390d38eae 100644
--- a/hw/core/cpu-system.c
+++ b/hw/core/cpu-system.c
@@ -60,6 +60,17 @@ hwaddr cpu_get_phys_page_attrs_debug(CPUState *cpu, vaddr addr,
     return cc->sysemu_ops->get_phys_page_debug(cpu, addr);
 }
 
+uint32_t cpu_get_phys_bits(const CPUState *cpu)
+{
+    CPUClass *cc = CPU_GET_CLASS(cpu);
+
+    if (cc->sysemu_ops->get_phys_bits) {
+        return cc->sysemu_ops->get_phys_bits(cpu);
+    }
+
+    return target_phys_bits();
+}
+
 hwaddr cpu_get_phys_page_debug(CPUState *cpu, vaddr addr)
 {
     MemTxAttrs attrs = {};
diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index b5dd60d2812e0c3d13c1743fd485a9068ab29c4f..01cf9a44963710a415c755c17582730f75233143 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -8393,6 +8393,11 @@ static bool x86_cpu_get_paging_enabled(const CPUState *cs)
 
     return cpu->env.cr[0] & CR0_PG_MASK;
 }
+
+static uint32_t x86_cpu_get_phys_bits(const CPUState *cs)
+{
+    return X86_CPU(cs)->phys_bits;
+}
 #endif /* !CONFIG_USER_ONLY */
 
 static void x86_cpu_set_pc(CPUState *cs, vaddr value)
@@ -8701,6 +8706,7 @@ static const struct SysemuCPUOps i386_sysemu_ops = {
     .get_memory_mapping = x86_cpu_get_memory_mapping,
     .get_paging_enabled = x86_cpu_get_paging_enabled,
     .get_phys_page_attrs_debug = x86_cpu_get_phys_page_attrs_debug,
+    .get_phys_bits = x86_cpu_get_phys_bits,
     .asidx_from_attrs = x86_asidx_from_attrs,
     .get_crash_info = x86_cpu_get_crash_info,
     .write_elf32_note = x86_cpu_write_elf32_note,
-- 
2.48.1


