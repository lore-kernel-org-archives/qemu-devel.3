Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20F66EC01DD
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Mar 2026 12:06:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w4e3I-0007iI-EB; Mon, 23 Mar 2026 08:06:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <magnuskulke@linux.microsoft.com>)
 id 1w4e33-0007eg-GN
 for qemu-devel@nongnu.org; Mon, 23 Mar 2026 08:06:21 -0400
Received: from linux.microsoft.com ([13.77.154.182])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <magnuskulke@linux.microsoft.com>) id 1w4e31-0005TH-AY
 for qemu-devel@nongnu.org; Mon, 23 Mar 2026 08:06:21 -0400
Received: from DESKTOP-TUU1E5L.localdomain (unknown [167.220.208.76])
 by linux.microsoft.com (Postfix) with ESMTPSA id 935AD20B710C;
 Mon, 23 Mar 2026 05:06:16 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 935AD20B710C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
 s=default; t=1774267577;
 bh=j0zx57orCfjH/b4yZSBp1d3VPOTnjKE85cp35cyPnmg=;
 h=From:To:Cc:Subject:Date:From;
 b=cNbd/8njikJwDdFQO3sQUrcup05Gl54i5U9US/PbWT0ruZlb2ABRe7lS0GAuYW+8D
 OMKvQwspe/pj/HLMD9qQMZmgxTUjiDVC1TCj7iOiq37vWH6SleYAYfkwtykMfEgDtG
 rYhkxUPn4RhVRSD8IYFv2kxmMMqW5mKvdMCE/F/o=
From: Magnus Kulke <magnuskulke@linux.microsoft.com>
To: qemu-devel@nongnu.org
Cc: Anirudh Rayabharam <anirudh@anirudhrb.com>, Wei Liu <wei.liu@kernel.org>,
 Aastha Rawat <aastharawat@linux.microsoft.com>,
 Magnus Kulke <magnuskulke@linux.microsoft.com>
Subject: [PATCH] include/hw/hyperv: add QEMU_PACKED to uapi structs
Date: Mon, 23 Mar 2026 13:06:13 +0100
Message-Id: <20260323120613.355019-1-magnuskulke@linux.microsoft.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=13.77.154.182;
 envelope-from=magnuskulke@linux.microsoft.com; helo=linux.microsoft.com
X-Spam_score_int: -42
X-Spam_score: -4.3
X-Spam_bar: ----
X-Spam_report: (-4.3 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

The uapi definitions are marked with __packed hints in the kernel
headers, since we want to keep the contract of the Microsoft Hypervisor
ABI explicit, we should also added them in our vendored files, with a
few notable exceptions where the attribute is a noop.

Signed-off-by: Magnus Kulke <magnuskulke@linux.microsoft.com>
---
 include/hw/hyperv/hvgdk_mini.h | 37 ++++++++++++++++++++++------------
 include/hw/hyperv/hvhdk.h      | 14 +++++++------
 2 files changed, 32 insertions(+), 19 deletions(-)

diff --git a/include/hw/hyperv/hvgdk_mini.h b/include/hw/hyperv/hvgdk_mini.h
index cb52cc9de2..7d7b2e9b36 100644
--- a/include/hw/hyperv/hvgdk_mini.h
+++ b/include/hw/hyperv/hvgdk_mini.h
@@ -7,6 +7,8 @@
 #ifndef HW_HYPERV_HVGDK_MINI_H
 #define HW_HYPERV_HVGDK_MINI_H
 
+#include "qemu/compiler.h"
+
 #define MSHV_IOCTL  0xB8
 
 typedef enum hv_register_name {
@@ -211,7 +213,7 @@ enum hv_intercept_type {
 struct hv_u128 {
     uint64_t low_part;
     uint64_t high_part;
-};
+} QEMU_PACKED;
 
 union hv_x64_xmm_control_status_register {
     struct hv_u128 as_uint128;
@@ -326,13 +328,13 @@ typedef struct hv_x64_segment_register {
         };
         uint16_t attributes;
     };
-} hv_x64_segment_register;
+} QEMU_PACKED hv_x64_segment_register;
 
 typedef struct hv_x64_table_register {
     uint16_t pad[3];
     uint16_t limit;
     uint64_t base;
-} hv_x64_table_register;
+} QEMU_PACKED hv_x64_table_register;
 
 union hv_x64_fp_control_status_register {
     struct hv_u128 as_uint128;
@@ -416,6 +418,10 @@ typedef union hv_register_value {
     union hv_x64_register_sev_control sev_control;
 } hv_register_value;
 
+/*
+ * This struct is __packed in the kernel. Since all members are naturally
+ * aligned, we can omit QEMU_PACKED to avoid address-of-packed-member warnings.
+ */
 typedef struct hv_register_assoc {
     uint32_t name;         /* enum hv_register_name */
     uint32_t reserved1;
@@ -439,7 +445,7 @@ typedef struct hv_input_get_vp_registers {
     uint8_t  rsvd_z8;
     uint16_t rsvd_z16;
     uint32_t names[];
-} hv_input_get_vp_registers;
+} QEMU_PACKED hv_input_get_vp_registers;
 
 typedef struct hv_input_set_vp_registers {
     uint64_t partition_id;
@@ -448,7 +454,7 @@ typedef struct hv_input_set_vp_registers {
     uint8_t  rsvd_z8;
     uint16_t rsvd_z16;
     struct hv_register_assoc elements[];
-} hv_input_set_vp_registers;
+} QEMU_PACKED hv_input_set_vp_registers;
 
 union hv_interrupt_control {
     uint64_t as_uint64;
@@ -468,7 +474,7 @@ struct hv_input_assert_virtual_interrupt {
     uint8_t target_vtl;
     uint8_t rsvd_z0;
     uint16_t rsvd_z1;
-};
+} QEMU_PACKED;
 
 /* /dev/mshv */
 #define MSHV_CREATE_PARTITION   _IOW(MSHV_IOCTL, 0x00, struct mshv_create_partition)
@@ -487,6 +493,11 @@ struct hv_input_assert_virtual_interrupt {
  ********************************
  */
 
+/*
+ * This struct is __packed in the kernel, but since all members are naturally
+ * aligned, so we can omit QEMU_PACKED to avoid address-of-packed-member
+ * warnings.
+ */
 struct hv_local_interrupt_controller_state {
     /* HV_X64_INTERRUPT_CONTROLLER_STATE */
     uint32_t apic_id;
@@ -644,7 +655,7 @@ struct hv_x64_intercept_message_header {
     struct hv_x64_segment_register cs_segment;
     uint64_t rip;
     uint64_t rflags;
-};
+} QEMU_PACKED;
 
 union hv_x64_io_port_access_info {
     uint8_t as_uint8;
@@ -669,7 +680,7 @@ typedef struct hv_x64_io_port_intercept_message {
     uint64_t rcx;
     uint64_t rsi;
     uint64_t rdi;
-} hv_x64_io_port_intercept_message;
+} QEMU_PACKED hv_x64_io_port_intercept_message;
 
 union hv_x64_memory_access_info {
     uint8_t as_uint8;
@@ -692,7 +703,7 @@ struct hv_x64_memory_intercept_message {
     uint64_t guest_virtual_address;
     uint64_t guest_physical_address;
     uint8_t instruction_bytes[16];
-};
+} QEMU_PACKED;
 
 union hv_message_flags {
     uint8_t asu8;
@@ -711,14 +722,14 @@ struct hv_message_header {
         uint64_t sender;
         union hv_port_id port;
     };
-};
+} QEMU_PACKED;
 
 struct hv_message {
     struct hv_message_header header;
     union {
         uint64_t payload[HV_MESSAGE_PAYLOAD_QWORD_COUNT];
     } u;
-};
+} QEMU_PACKED;
 
 /* From  github.com/rust-vmm/mshv-bindings/src/x86_64/regs.rs */
 
@@ -731,13 +742,13 @@ struct hv_cpuid_entry {
     uint32_t ecx;
     uint32_t edx;
     uint32_t padding[3];
-};
+} QEMU_PACKED;
 
 struct hv_cpuid {
     uint32_t nent;
     uint32_t padding;
     struct hv_cpuid_entry entries[0];
-};
+} QEMU_PACKED;
 
 #define IA32_MSR_TSC            0x00000010
 #define IA32_MSR_EFER           0xC0000080
diff --git a/include/hw/hyperv/hvhdk.h b/include/hw/hyperv/hvhdk.h
index 866c8211bf..bf2f8cbc27 100644
--- a/include/hw/hyperv/hvhdk.h
+++ b/include/hw/hyperv/hvhdk.h
@@ -9,6 +9,8 @@
 #ifndef HW_HYPERV_HVHDK_H
 #define HW_HYPERV_HVHDK_H
 
+#include "qemu/compiler.h"
+
 #define HV_PARTITION_SYNTHETIC_PROCESSOR_FEATURES_BANKS 1
 
 struct hv_input_set_partition_property {
@@ -16,7 +18,7 @@ struct hv_input_set_partition_property {
     uint32_t property_code; /* enum hv_partition_property_code */
     uint32_t padding;
     uint64_t property_value;
-};
+} QEMU_PACKED;
 
 union hv_partition_synthetic_processor_features {
     uint64_t as_uint64[HV_PARTITION_SYNTHETIC_PROCESSOR_FEATURES_BANKS];
@@ -201,12 +203,12 @@ typedef struct hv_input_translate_virtual_address {
     uint32_t padding;
     uint64_t control_flags;
     uint64_t gva_page;
-} hv_input_translate_virtual_address;
+} QEMU_PACKED hv_input_translate_virtual_address;
 
 typedef struct hv_output_translate_virtual_address {
     union hv_translate_gva_result translation_result;
     uint64_t gpa_page;
-} hv_output_translate_virtual_address;
+} QEMU_PACKED hv_output_translate_virtual_address;
 
 typedef struct hv_register_x64_cpuid_result_parameters {
     struct {
@@ -226,13 +228,13 @@ typedef struct hv_register_x64_cpuid_result_parameters {
         uint32_t edx;
         uint32_t edx_mask;
     } result;
-} hv_register_x64_cpuid_result_parameters;
+} QEMU_PACKED hv_register_x64_cpuid_result_parameters;
 
 typedef struct hv_register_x64_msr_result_parameters {
     uint32_t msr_index;
     uint32_t access_type;
     uint32_t action; /* enum hv_unimplemented_msr_action */
-} hv_register_x64_msr_result_parameters;
+} QEMU_PACKED hv_register_x64_msr_result_parameters;
 
 union hv_register_intercept_result_parameters {
     struct hv_register_x64_cpuid_result_parameters cpuid;
@@ -244,6 +246,6 @@ typedef struct hv_input_register_intercept_result {
     uint32_t vp_index;
     uint32_t intercept_type; /* enum hv_intercept_type */
     union hv_register_intercept_result_parameters parameters;
-} hv_input_register_intercept_result;
+} QEMU_PACKED hv_input_register_intercept_result;
 
 #endif /* HW_HYPERV_HVHDK_H */
-- 
2.34.1


