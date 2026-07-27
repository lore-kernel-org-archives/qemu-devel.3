Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 412C8C531D0
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jul 2026 14:28:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1woMJX-0006Ft-Oh; Mon, 27 Jul 2026 10:28:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dblanzeanu@linux.microsoft.com>)
 id 1woMJW-0006FP-K0
 for qemu-devel@nongnu.org; Mon, 27 Jul 2026 10:28:18 -0400
Received: from linux.microsoft.com ([13.77.154.182])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dblanzeanu@linux.microsoft.com>) id 1woMJV-0001vS-3J
 for qemu-devel@nongnu.org; Mon, 27 Jul 2026 10:28:18 -0400
Received: from laptop.localdomain (unknown [86.121.140.206])
 by linux.microsoft.com (Postfix) with ESMTPSA id 8529120B7167;
 Mon, 27 Jul 2026 07:27:58 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 8529120B7167
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
 s=default; t=1785162480;
 bh=1xQViwwRbTfUwL4or9CH3iqmCMINBdRcqoXMVtitYvw=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=Jj927Rlq2NFFhMZcmAgzJ8MoYgNeIJuvs9TdNV7+YwhFy+pexQz86bitAuqDV2KDJ
 hxPH1Nxuf2lBB7p7/2afUBv2GLR39h8WqVIKNOBx+wO9eUr1MigbPFu+OqkS/Hz6NW
 yV7H5F0nqbkiTgi731G8Oy5P67ArTBN46JeRE73o=
From: =?UTF-8?q?Doru=20Bl=C3=A2nzeanu?= <dblanzeanu@linux.microsoft.com>
To: qemu-devel@nongnu.org
Cc: Magnus Kulke <magnuskulke@linux.microsoft.com>,
 =?UTF-8?q?Doru=20Bl=C3=A2nzeanu?= <dblanzeanu@linux.microsoft.com>,
 =?UTF-8?q?Doru=20Bl=C3=A2nzeanu?= <dblanzeanu@microsoft.com>,
 Wei Liu <liuwe@microsoft.com>, Wei Liu <wei.liu@kernel.org>,
 Magnus Kulke <magnuskulke@microsoft.com>
Subject: [PATCH 1/3] include/hw/hyperv: add ABI for exception intercepts and
 pending events
Date: Mon, 27 Jul 2026 17:28:05 +0300
Message-ID: <20260727142807.84269-2-dblanzeanu@linux.microsoft.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260727142807.84269-1-dblanzeanu@linux.microsoft.com>
References: <20260727142807.84269-1-dblanzeanu@linux.microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=13.77.154.182;
 envelope-from=dblanzeanu@linux.microsoft.com; helo=linux.microsoft.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Import the hypervisor definitions needed to intercept guest exceptions
and to inject events back into a guest, in preparation for gdbstub
debugging support in the MSHV accelerator.

Add:
  - union hv_intercept_parameters, struct hv_input_install_intercept and
    HVCALL_INSTALL_INTERCEPT, used to install an exception intercept on
    the partition;
  - struct hv_x64_exception_intercept_message, the message delivered on
    an intercepted exception, carrying the faulting RIP, the exception
    vector and the instruction bytes;
  - HV_X64_PENDING_EVENT_EXCEPTION, the pending-event type for an
    exception.

These definitions mirror the hypervisor headers and have no functional
effect on their own.

Signed-off-by: Doru Blânzeanu <dblanzeanu@linux.microsoft.com>
---
 include/hw/hyperv/hvgdk_mini.h | 56 ++++++++++++++++++++++++++++++++++
 1 file changed, 56 insertions(+)

diff --git a/include/hw/hyperv/hvgdk_mini.h b/include/hw/hyperv/hvgdk_mini.h
index f8838a31bb..c81928d0c2 100644
--- a/include/hw/hyperv/hvgdk_mini.h
+++ b/include/hw/hyperv/hvgdk_mini.h
@@ -22,6 +22,9 @@
 #define HV_X64_MSR_TSC_FREQUENCY    0x40000022
 #define HV_X64_MSR_APIC_FREQUENCY   0x40000023
 
+/* event_type values for hv_x64_pending_exception_event */
+#define HV_X64_PENDING_EVENT_EXCEPTION 0
+
 typedef enum hv_register_name {
     /* Pending Interruption Register */
     HV_REGISTER_PENDING_INTERRUPTION = 0x00010002,
@@ -236,6 +239,29 @@ enum hv_intercept_type {
     HV_INTERCEPT_TYPE_INVALID               = 0XFFFFFFFF,
 };
 
+union hv_intercept_parameters {
+    /* HV_INTERCEPT_PARAMETERS is defined to be an 8-byte field. */
+    uint64_t as_uint64;
+    /* HV_INTERCEPT_TYPE_X64_IO_PORT */
+    uint16_t io_port;
+    /* HV_INTERCEPT_TYPE_X64_CPUID */
+    uint32_t cpuid_index;
+    /* HV_INTERCEPT_TYPE_X64_APIC_WRITE */
+    uint32_t apic_write_mask;
+    /* HV_INTERCEPT_TYPE_EXCEPTION */
+    uint16_t exception_vector;
+    /* HV_INTERCEPT_TYPE_X64_MSR_INDEX */
+    uint32_t msr_index;
+    /* N.B. Other intercept types do not have any parameters. */
+};
+
+struct hv_input_install_intercept {
+    uint64_t partition_id;
+    uint32_t access_type; /* mask */
+    uint32_t intercept_type; /* enum hv_intercept_type */
+    union hv_intercept_parameters intercept_parameter;
+} QEMU_PACKED;
+
 struct hv_u128 {
     uint64_t low_part;
     uint64_t high_part;
@@ -836,6 +862,35 @@ struct hv_x64_memory_intercept_message {
     uint8_t instruction_bytes[16];
 } QEMU_PACKED;
 
+struct hv_x64_exception_intercept_message {
+    struct hv_x64_intercept_message_header header;
+    uint16_t exception_vector;
+    uint8_t exception_info;
+    uint8_t instruction_byte_count;
+    uint32_t error_code;
+    uint64_t exception_parameter; /* DR6 for #DB, CR2 for #PF */
+    uint64_t reserved;
+    uint8_t instruction_bytes[16];
+    struct hv_x64_segment_register ds_segment;
+    struct hv_x64_segment_register ss_segment;
+    uint64_t rax;
+    uint64_t rcx;
+    uint64_t rdx;
+    uint64_t rbx;
+    uint64_t rsp;
+    uint64_t rbp;
+    uint64_t rsi;
+    uint64_t rdi;
+    uint64_t r8;
+    uint64_t r9;
+    uint64_t r10;
+    uint64_t r11;
+    uint64_t r12;
+    uint64_t r13;
+    uint64_t r14;
+    uint64_t r15;
+} QEMU_PACKED;
+
 union hv_message_flags {
     uint8_t asu8;
     struct {
@@ -943,6 +998,7 @@ struct hv_cpuid {
 
 #define HVCALL_GET_PARTITION_PROPERTY    0x0044
 #define HVCALL_SET_PARTITION_PROPERTY    0x0045
+#define HVCALL_INSTALL_INTERCEPT         0x004d
 #define HVCALL_GET_VP_REGISTERS          0x0050
 #define HVCALL_SET_VP_REGISTERS          0x0051
 #define HVCALL_TRANSLATE_VIRTUAL_ADDRESS 0x0052
-- 
2.53.0


