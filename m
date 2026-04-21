Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32562F588C9
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Apr 2026 05:23:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wF3Zy-0008Oj-KR; Tue, 21 Apr 2026 01:23:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aastharawat@linux.microsoft.com>)
 id 1wF3Yg-0007ZU-IA; Tue, 21 Apr 2026 01:22:02 -0400
Received: from linux.microsoft.com ([13.77.154.182])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <aastharawat@linux.microsoft.com>)
 id 1wF3Ye-0000jX-IR; Tue, 21 Apr 2026 01:22:02 -0400
Received: from localhost (unknown [131.107.147.136])
 by linux.microsoft.com (Postfix) with ESMTPSA id 313B820B6F20;
 Mon, 20 Apr 2026 22:21:58 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 313B820B6F20
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
 s=default; t=1776748918;
 bh=aiVWl92e6PUYoJGvSxfSYd8qlj5urawU2dcb1f8iQJs=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
 b=OX+raQ04oSqo6mcggL0Zhh4/14sg+1m1JG88/7NRaSvl82vsiHWWb5SZdt75Fj/V2
 FKiwUkWt9JrIRxcmb/rqy/AmD+BkN6CiK2hptfMhGidXUGzyp76mkEaMat0T643GI3
 XpAjvD/dEyBX/TBIMAoLUet1Aq5ASkCcUWRTvDzs=
From: Aastha Rawat <aastharawat@linux.microsoft.com>
Date: Tue, 21 Apr 2026 05:21:52 +0000
Subject: [PATCH v3 07/14] accel/mshv: Add access_vp_regs synthetic proc
 features
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260421-mshv_accel_arm64_supp-v3-7-469f544778ba@linux.microsoft.com>
References: <20260421-mshv_accel_arm64_supp-v3-0-469f544778ba@linux.microsoft.com>
In-Reply-To: <20260421-mshv_accel_arm64_supp-v3-0-469f544778ba@linux.microsoft.com>
To: qemu-devel@nongnu.org
Cc: Magnus Kulke <magnuskulke@linux.microsoft.com>, 
 Wei Liu <wei.liu@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 Peter Maydell <peter.maydell@linaro.org>, 
 Anirudh Rayabharam <anirudh@anirudhrb.com>, 
 Aastha Rawat <aastharawat@linux.microsoft.com>, 
 Magnus Kulke <magnus.kulke@linux.microsoft.com>, qemu-arm@nongnu.org, 
 Alexander Graf <agraf@csgraf.de>, Pedro Barbuda <pbarbuda@microsoft.com>, 
 Mohamed Mediouni <mohamed@unpredictable.fr>
X-Mailer: b4 0.15.1
Received-SPF: pass client-ip=13.77.154.182;
 envelope-from=aastharawat@linux.microsoft.com; helo=linux.microsoft.com
X-Spam_score_int: -42
X-Spam_score: -4.3
X-Spam_bar: ----
X-Spam_report: (-4.3 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, RCVD_IN_DNSWL_MED=-2.3,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Enable access_vp_regs feature for regs. In arm64, this feature bit
allows the guest to set VP registers using hypercall. This wasn't
required for x86 because such registers are set using wrmsr instead of
hypercall.

Signed-off-by: Aastha Rawat <aastharawat@linux.microsoft.com>
---
 accel/mshv/mshv-all.c     |  1 +
 include/hw/hyperv/hvhdk.h | 91 ++++++++++++++++++++++++++++++++++++++++++++++-
 2 files changed, 91 insertions(+), 1 deletion(-)

diff --git a/accel/mshv/mshv-all.c b/accel/mshv/mshv-all.c
index 6940ad9989..5ce76e86db 100644
--- a/accel/mshv/mshv-all.c
+++ b/accel/mshv/mshv-all.c
@@ -156,6 +156,7 @@ static int set_synthetic_proc_features(int vm_fd)
     features.tb_flush_hypercalls = 1;
     features.synthetic_cluster_ipi = 1;
     features.direct_synthetic_timers = 1;
+    features.access_vp_regs = 1;
 
     mshv_arch_amend_proc_features(&features);
 
diff --git a/include/hw/hyperv/hvhdk.h b/include/hw/hyperv/hvhdk.h
index 2e1ef80972..3807ed4302 100644
--- a/include/hw/hyperv/hvhdk.h
+++ b/include/hw/hyperv/hvhdk.h
@@ -94,11 +94,16 @@ union hv_partition_synthetic_processor_features {
          */
         uint64_t access_partition_reference_tsc:1;
 
+#if defined(__x86_64__)
+
         /*
          * Partition has access to the guest idle reg. Corresponds to
          * access_guest_idle_reg privilege.
          */
         uint64_t access_guest_idle_reg:1;
+#else
+        uint64_t reserved_z10:1;
+#endif
 
         /*
          * Partition has access to frequency regs. corresponds to
@@ -110,11 +115,16 @@ union hv_partition_synthetic_processor_features {
         uint64_t reserved_z13:1; /* Reserved for access_root_scheduler_reg */
         uint64_t reserved_z14:1; /* Reserved for access_tsc_invariant_controls */
 
+#if defined(__x86_64__)
+
         /*
          * Extended GVA ranges for HvCallFlushVirtualAddressList hypercall.
          * Corresponds to privilege.
          */
         uint64_t enable_extended_gva_ranges_for_flush_virtual_address_list:1;
+#else
+        uint64_t reserved_z15:1;
+#endif
 
         uint64_t reserved_z16:1; /* Reserved for access_vsm. */
         uint64_t reserved_z17:1; /* Reserved for access_vp_registers. */
@@ -161,13 +171,92 @@ union hv_partition_synthetic_processor_features {
         /* HvCallRetargetDeviceInterrupt is supported. */
         uint64_t retarget_device_interrupt:1;
 
+#if defined(__x86_64__)
         /* HvCallRestorePartitionTime is supported. */
         uint64_t restore_time:1;
 
         /* EnlightenedVmcs nested enlightenment is supported. */
         uint64_t enlightened_vmcs:1;
 
-        uint64_t reserved:30;
+        uint64_t nested_debug_ctl:1;
+        uint64_t synthetic_time_unhalted_timer:1;
+        uint64_t idle_spec_ctrl:1;
+
+#else
+        uint64_t reserved_z31:1;
+        uint64_t reserved_z32:1;
+        uint64_t reserved_z33:1;
+        uint64_t reserved_z34:1;
+        uint64_t reserved_z35:1;
+#endif
+
+#if defined(__aarch64__)
+        /*
+         * Register intercepts supported in V1. As more registers are supported
+         * in future releases, new bits will be added here to prevent migration
+         * between incompatible hosts.
+         *
+         * List of registers supported in V1:
+         * 1. TPIDRRO_EL0
+         * 2. TPIDR_EL1
+         * 3. SCTLR_EL1 - Supports write intercept mask.
+         * 4. VBAR_EL1
+         * 5. TCR_EL1 - Supports write intercept mask.
+         * 6. MAIR_EL1 - Supports write intercept mask.
+         * 7. CPACR_EL1 - Supports write intercept mask.
+         * 8. CONTEXTIDR_EL1
+         * 9. PAuth keys (total 10 registers)
+         * 10. HvArm64RegisterSyntheticException
+         */
+        uint64_t register_intercepts_v1:1;
+#else
+        uint64_t reserved_z36:1;
+#endif
+
+        /* HvCallWakeVps is supported */
+        uint64_t wake_vps:1;
+
+        /*
+         * HvCallGet/SetVpRegisters is supported.
+         * Corresponds to AccessVpRegisters privilege.
+         * This feature only affects exo partitions.
+         */
+        uint64_t access_vp_regs:1;
+
+#if defined(__aarch64__)
+        /* HvCallSyncContext/Ex is supported. */
+        uint64_t sync_context:1;
+#else
+        uint64_t reserved_z39:1;
+#endif /* __aarch64__ */
+
+        /*
+         * Management VTL synic support is allowed.
+         * Corresponds to the ManagementVtlSynicSupport privilege.
+         */
+        uint64_t management_vtl_synic_support:1;
+
+#if defined(__x86_64__)
+        /*
+         * Hypervisor supports guest mechanism to signal pending interrupts to
+         * paravisor.
+         */
+        uint64_t proxy_interrupt_doorbell_support:1;
+#else
+        uint64_t reserved_z41:1;
+#endif
+
+#if defined(__aarch64__)
+        /* InterceptSystemResetAvailable is exposed. */
+        uint64_t intercept_system_reset:1;
+#else
+        uint64_t reserved_z42:1;
+#endif
+
+        /* Hypercalls for host MMIO operations are available. */
+        uint64_t mmio_hypercalls:1;
+
+        uint64_t reserved:20;
     };
 };
 

-- 
2.45.4


