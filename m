Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2B7FECD6C5
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Feb 2026 16:08:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vqCkh-0002pu-7M; Wed, 11 Feb 2026 11:07:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <magnuskulke@linux.microsoft.com>)
 id 1vqCXp-0007Dn-CT
 for qemu-devel@nongnu.org; Wed, 11 Feb 2026 10:54:25 -0500
Received: from linux.microsoft.com ([13.77.154.182])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <magnuskulke@linux.microsoft.com>) id 1vqCXn-0003QP-FX
 for qemu-devel@nongnu.org; Wed, 11 Feb 2026 10:54:25 -0500
Received: from DESKTOP-TUU1E5L.localdomain (unknown [167.220.208.59])
 by linux.microsoft.com (Postfix) with ESMTPSA id A7FEA20B716A;
 Wed, 11 Feb 2026 07:54:20 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com A7FEA20B716A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
 s=default; t=1770825262;
 bh=4I9lmLORCr+NoAh4zAx7PDJ3LLuGZqTYbC/uA6RwjRU=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=J7rl/BQx23vCdXub8g5P2a1jEz5yP1xLcshGAx5j9AdgDSNp3RI4nmxq7qnbDpA0w
 v8Z86babBCgabD56SNcTD9eAmjshfNkI5WZMk/LqH53mFCEh12Z+XQCq/sRicvC6GK
 BZW2PcuZ0p0CxGs4NFvyFN6oYeilVvOfxAj9GRDE=
From: Magnus Kulke <magnuskulke@linux.microsoft.com>
To: qemu-devel@nongnu.org
Cc: Magnus Kulke <magnuskulke@linux.microsoft.com>,
 Wei Liu <liuwe@microsoft.com>, Wei Liu <wei.liu@kernel.org>,
 Zhao Liu <zhao1.liu@intel.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Magnus Kulke <magnuskulke@microsoft.com>
Subject: [PATCH 03/10] accel/mshv: use mshv_create_partition_v2 payload
Date: Wed, 11 Feb 2026 16:54:03 +0100
Message-Id: <20260211155410.203883-4-magnuskulke@linux.microsoft.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260211155410.203883-1-magnuskulke@linux.microsoft.com>
References: <20260211155410.203883-1-magnuskulke@linux.microsoft.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=13.77.154.182;
 envelope-from=magnuskulke@linux.microsoft.com; helo=linux.microsoft.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Wed, 11 Feb 2026 11:07:30 -0500
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

When using the extended request format we can instruct the hypervisor to
provision enough space for requested XSAVE features. This is required
for supporting QEMU models provided via the -cpu flag properly.

Signed-off-by: Magnus Kulke <magnuskulke@linux.microsoft.com>
---
 accel/mshv/mshv-all.c          |  35 +++++--
 include/hw/hyperv/hvgdk_mini.h |   2 +
 include/hw/hyperv/hvhdk.h      | 185 +++++++++++++++++++++++++++++++++
 3 files changed, 214 insertions(+), 8 deletions(-)

diff --git a/accel/mshv/mshv-all.c b/accel/mshv/mshv-all.c
index bed0fa298e..8446f7128a 100644
--- a/accel/mshv/mshv-all.c
+++ b/accel/mshv/mshv-all.c
@@ -112,19 +112,38 @@ static int resume_vm(int vm_fd)
 
 static int create_partition(int mshv_fd, int *vm_fd)
 {
-    int ret;
-    struct mshv_create_partition args = {0};
+    int ret, i;
+    uint64_t pt_flags;
+    union hv_partition_processor_xsave_features disabled_xsave_features;
+    union hv_partition_processor_features disabled_processor_features;
+    struct mshv_create_partition_v2 args = {0};
 
     /* Initialize pt_flags with the desired features */
-    uint64_t pt_flags = (1ULL << MSHV_PT_BIT_LAPIC) |
-                        (1ULL << MSHV_PT_BIT_X2APIC) |
-                        (1ULL << MSHV_PT_BIT_GPA_SUPER_PAGES);
+    pt_flags = (1ULL << MSHV_PT_BIT_LAPIC) |
+               (1ULL << MSHV_PT_BIT_X2APIC) |
+               (1ULL << MSHV_PT_BIT_GPA_SUPER_PAGES) |
+               (1ULL << MSHV_PT_BIT_CPU_AND_XSAVE_FEATURES);
 
-    /* Set default isolation type */
-    uint64_t pt_isolation = MSHV_PT_ISOLATION_NONE;
+    /* enable all */
+    disabled_xsave_features.as_uint64 = 0;
 
+    /* Enable all proc features by default */
+    for (i = 0; i < MSHV_NUM_CPU_FEATURES_BANKS; i++) {
+        disabled_processor_features.as_uint64[i] = 0;
+    }
+    disabled_processor_features.reserved_bank0 = 1;
+    for (i = 0; i < MSHV_NUM_CPU_FEATURES_BANKS; i++) {
+        disabled_processor_features.as_uint64[i] = 0;
+    }
+
+    /* populate args structure */
     args.pt_flags = pt_flags;
-    args.pt_isolation = pt_isolation;
+    args.pt_isolation = MSHV_PT_ISOLATION_NONE;
+    args.pt_disabled_xsave = disabled_xsave_features.as_uint64;
+    args.pt_num_cpu_fbanks = MSHV_NUM_CPU_FEATURES_BANKS;
+    for (i = 0; i < MSHV_NUM_CPU_FEATURES_BANKS; i++) {
+        args.pt_cpu_fbanks[i] = disabled_processor_features.as_uint64[i];
+    }
 
     ret = ioctl(mshv_fd, MSHV_CREATE_PARTITION, &args);
     if (ret < 0) {
diff --git a/include/hw/hyperv/hvgdk_mini.h b/include/hw/hyperv/hvgdk_mini.h
index 7d7b2e9b36..a8d4b2b2b1 100644
--- a/include/hw/hyperv/hvgdk_mini.h
+++ b/include/hw/hyperv/hvgdk_mini.h
@@ -456,6 +456,8 @@ typedef struct hv_input_set_vp_registers {
     struct hv_register_assoc elements[];
 } QEMU_PACKED hv_input_set_vp_registers;
 
+#define MSHV_VP_MAX_REGISTERS   128
+
 union hv_interrupt_control {
     uint64_t as_uint64;
     struct {
diff --git a/include/hw/hyperv/hvhdk.h b/include/hw/hyperv/hvhdk.h
index bf2f8cbc27..83f12a8781 100644
--- a/include/hw/hyperv/hvhdk.h
+++ b/include/hw/hyperv/hvhdk.h
@@ -163,6 +163,191 @@ union hv_partition_synthetic_processor_features {
     };
 };
 
+union hv_partition_processor_xsave_features {
+    struct {
+        uint64_t xsave_support:1;
+        uint64_t xsaveopt_support:1;
+        uint64_t avx_support:1;
+        uint64_t avx2_support:1;
+        uint64_t fma_support:1;
+        uint64_t mpx_support:1;
+        uint64_t avx512_support:1;
+        uint64_t avx512_dq_support:1;
+        uint64_t avx512_cd_support:1;
+        uint64_t avx512_bw_support:1;
+        uint64_t avx512_vl_support:1;
+        uint64_t xsave_comp_support:1;
+        uint64_t xsave_supervisor_support:1;
+        uint64_t xcr1_support:1;
+        uint64_t avx512_bitalg_support:1;
+        uint64_t avx512_i_fma_support:1;
+        uint64_t avx512_v_bmi_support:1;
+        uint64_t avx512_v_bmi2_support:1;
+        uint64_t avx512_vnni_support:1;
+        uint64_t gfni_support:1;
+        uint64_t vaes_support:1;
+        uint64_t avx512_v_popcntdq_support:1;
+        uint64_t vpclmulqdq_support:1;
+        uint64_t avx512_bf16_support:1;
+        uint64_t avx512_vp2_intersect_support:1;
+        uint64_t avx512_fp16_support:1;
+        uint64_t xfd_support:1;
+        uint64_t amx_tile_support:1;
+        uint64_t amx_bf16_support:1;
+        uint64_t amx_int8_support:1;
+        uint64_t avx_vnni_support:1;
+        uint64_t avx_ifma_support:1;
+        uint64_t avx_ne_convert_support:1;
+        uint64_t avx_vnni_int8_support:1;
+        uint64_t avx_vnni_int16_support:1;
+        uint64_t avx10_1_256_support:1;
+        uint64_t avx10_1_512_support:1;
+        uint64_t amx_fp16_support:1;
+        uint64_t reserved1:26;
+    };
+    uint64_t as_uint64;
+};
+
+#define HV_PARTITION_PROCESSOR_FEATURES_BANKS 2
+#define HV_PARTITION_PROCESSOR_FEATURES_RESERVEDBANK1_BITFIELD_COUNT 4
+
+
+union hv_partition_processor_features {
+    uint64_t as_uint64[HV_PARTITION_PROCESSOR_FEATURES_BANKS];
+    struct {
+        uint64_t sse3_support:1;
+        uint64_t lahf_sahf_support:1;
+        uint64_t ssse3_support:1;
+        uint64_t sse4_1_support:1;
+        uint64_t sse4_2_support:1;
+        uint64_t sse4a_support:1;
+        uint64_t xop_support:1;
+        uint64_t pop_cnt_support:1;
+        uint64_t cmpxchg16b_support:1;
+        uint64_t altmovcr8_support:1;
+        uint64_t lzcnt_support:1;
+        uint64_t mis_align_sse_support:1;
+        uint64_t mmx_ext_support:1;
+        uint64_t amd3dnow_support:1;
+        uint64_t extended_amd3dnow_support:1;
+        uint64_t page_1gb_support:1;
+        uint64_t aes_support:1;
+        uint64_t pclmulqdq_support:1;
+        uint64_t pcid_support:1;
+        uint64_t fma4_support:1;
+        uint64_t f16c_support:1;
+        uint64_t rd_rand_support:1;
+        uint64_t rd_wr_fs_gs_support:1;
+        uint64_t smep_support:1;
+        uint64_t enhanced_fast_string_support:1;
+        uint64_t bmi1_support:1;
+        uint64_t bmi2_support:1;
+        uint64_t hle_support_deprecated:1;
+        uint64_t rtm_support_deprecated:1;
+        uint64_t movbe_support:1;
+        uint64_t npiep1_support:1;
+        uint64_t dep_x87_fpu_save_support:1;
+        uint64_t rd_seed_support:1;
+        uint64_t adx_support:1;
+        uint64_t intel_prefetch_support:1;
+        uint64_t smap_support:1;
+        uint64_t hle_support:1;
+        uint64_t rtm_support:1;
+        uint64_t rdtscp_support:1;
+        uint64_t clflushopt_support:1;
+        uint64_t clwb_support:1;
+        uint64_t sha_support:1;
+        uint64_t x87_pointers_saved_support:1;
+        uint64_t invpcid_support:1;
+        uint64_t ibrs_support:1;
+        uint64_t stibp_support:1;
+        uint64_t ibpb_support:1;
+        uint64_t unrestricted_guest_support:1;
+        uint64_t mdd_support:1;
+        uint64_t fast_short_rep_mov_support:1;
+        uint64_t l1dcache_flush_support:1;
+        uint64_t rdcl_no_support:1;
+        uint64_t ibrs_all_support:1;
+        uint64_t skip_l1df_support:1;
+        uint64_t ssb_no_support:1;
+        uint64_t rsb_a_no_support:1;
+        uint64_t virt_spec_ctrl_support:1;
+        uint64_t rd_pid_support:1;
+        uint64_t umip_support:1;
+        uint64_t mbs_no_support:1;
+        uint64_t mb_clear_support:1;
+        uint64_t taa_no_support:1;
+        uint64_t tsx_ctrl_support:1;
+        uint64_t reserved_bank0:1;
+
+        /* N.B. Begin bank 1 processor features. */
+        uint64_t a_count_m_count_support:1;
+        uint64_t tsc_invariant_support:1;
+        uint64_t cl_zero_support:1;
+        uint64_t rdpru_support:1;
+        uint64_t la57_support:1;
+        uint64_t mbec_support:1;
+        uint64_t nested_virt_support:1;
+        uint64_t psfd_support:1;
+        uint64_t cet_ss_support:1;
+        uint64_t cet_ibt_support:1;
+        uint64_t vmx_exception_inject_support:1;
+        uint64_t enqcmd_support:1;
+        uint64_t umwait_tpause_support:1;
+        uint64_t movdiri_support:1;
+        uint64_t movdir64b_support:1;
+        uint64_t cldemote_support:1;
+        uint64_t serialize_support:1;
+        uint64_t tsc_deadline_tmr_support:1;
+        uint64_t tsc_adjust_support:1;
+        uint64_t fzl_rep_movsb:1;
+        uint64_t fs_rep_stosb:1;
+        uint64_t fs_rep_cmpsb:1;
+        uint64_t tsx_ld_trk_support:1;
+        uint64_t vmx_ins_outs_exit_info_support:1;
+        uint64_t hlat_support:1;
+        uint64_t sbdr_ssdp_no_support:1;
+        uint64_t fbsdp_no_support:1;
+        uint64_t psdp_no_support:1;
+        uint64_t fb_clear_support:1;
+        uint64_t btc_no_support:1;
+        uint64_t ibpb_rsb_flush_support:1;
+        uint64_t stibp_always_on_support:1;
+        uint64_t perf_global_ctrl_support:1;
+        uint64_t npt_execute_only_support:1;
+        uint64_t npt_ad_flags_support:1;
+        uint64_t npt1_gb_page_support:1;
+        uint64_t amd_processor_topology_node_id_support:1;
+        uint64_t local_machine_check_support:1;
+        uint64_t extended_topology_leaf_fp256_amd_support:1;
+        uint64_t gds_no_support:1;
+        uint64_t cmpccxadd_support:1;
+        uint64_t tsc_aux_virtualization_support:1;
+        uint64_t rmp_query_support:1;
+        uint64_t bhi_no_support:1;
+        uint64_t bhi_dis_support:1;
+        uint64_t prefetch_i_support:1;
+        uint64_t sha512_support:1;
+        uint64_t mitigation_ctrl_support:1;
+        uint64_t rfds_no_support:1;
+        uint64_t rfds_clear_support:1;
+        uint64_t sm3_support:1;
+        uint64_t sm4_support:1;
+        uint64_t secure_avic_support:1;
+        uint64_t guest_intercept_ctrl_support:1;
+        uint64_t sbpb_supported:1;
+        uint64_t ibpb_br_type_supported:1;
+        uint64_t srso_no_supported:1;
+        uint64_t srso_user_kernel_no_supported:1;
+        uint64_t vrew_clear_supported:1;
+        uint64_t tsa_l1_no_supported:1;
+        uint64_t tsa_sq_no_supported:1;
+        uint64_t lass_support:1;
+        uint64_t idle_hlt_intercept_support:1;
+        uint64_t msr_list_support:1;
+    };
+};
+
 enum hv_translate_gva_result_code {
     HV_TRANSLATE_GVA_SUCCESS                    = 0,
 
-- 
2.34.1


