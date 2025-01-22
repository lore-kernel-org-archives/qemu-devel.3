Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B1E2C02182
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jan 2025 15:19:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tacUN-0004dA-0m; Wed, 22 Jan 2025 10:17:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1tacUL-0004cp-Ll
 for qemu-devel@nongnu.org; Wed, 22 Jan 2025 10:17:53 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1tacUJ-0004Zl-Rg
 for qemu-devel@nongnu.org; Wed, 22 Jan 2025 10:17:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1737559071;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3/JMgGWmATOznOhuHhwYa5PU35n44LVPlDniBVxJxpQ=;
 b=T5wdxC5NxlrDj8INL1BgTfXN+8qFQyi4Xdrj/dtpEeCTMZKN4g5LoWdML9qgPK4tA+klx8
 fYkyB5G9t8vwsGChw0EPr6/ZHnh9UFxsCFwt1Qmy5uy5wINv4mAe20xAlQaJtcZgOhIG3p
 9jkUZu82hnmRTGzMjkypySGQZtMXvo8=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-587-tWjpqeJJNPewrviODl0NUQ-1; Wed,
 22 Jan 2025 10:17:48 -0500
X-MC-Unique: tWjpqeJJNPewrviODl0NUQ-1
X-Mimecast-MFC-AGG-ID: tWjpqeJJNPewrviODl0NUQ
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 64AB01956051; Wed, 22 Jan 2025 15:17:47 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.39.192.154])
 by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 46EB519560AA; Wed, 22 Jan 2025 15:17:44 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-devel@nongnu.org
Cc: Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>, Zhao Liu <zhao1.liu@intel.com>
Subject: [PATCH 4/5] cpu: Introduce cpu_get_phys_bits()
Date: Wed, 22 Jan 2025 16:17:31 +0100
Message-ID: <20250122151732.1351821-5-clg@redhat.com>
In-Reply-To: <20250122151732.1351821-1-clg@redhat.com>
References: <20250122151732.1351821-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -50
X-Spam_score: -5.1
X-Spam_bar: -----
X-Spam_report: (-5.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.996,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
index 1b9c11022c48e3103627d370f7fbdb2ae94a9f81..8f9f75de7cafaca72b4eb32e8229a7a7668f5c1c 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -8239,6 +8239,11 @@ static bool x86_cpu_get_paging_enabled(const CPUState *cs)
 
     return cpu->env.cr[0] & CR0_PG_MASK;
 }
+
+static uint32_t x86_cpu_get_phys_bits(const CPUState *cs)
+{
+    return X86_CPU(cs)->phys_bits;
+}
 #endif /* !CONFIG_USER_ONLY */
 
 static void x86_cpu_set_pc(CPUState *cs, vaddr value)
@@ -8547,6 +8552,7 @@ static const struct SysemuCPUOps i386_sysemu_ops = {
     .get_memory_mapping = x86_cpu_get_memory_mapping,
     .get_paging_enabled = x86_cpu_get_paging_enabled,
     .get_phys_page_attrs_debug = x86_cpu_get_phys_page_attrs_debug,
+    .get_phys_bits = x86_cpu_get_phys_bits,
     .asidx_from_attrs = x86_asidx_from_attrs,
     .get_crash_info = x86_cpu_get_crash_info,
     .write_elf32_note = x86_cpu_write_elf32_note,
-- 
2.48.1


