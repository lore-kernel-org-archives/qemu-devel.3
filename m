Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0115DCA5FFF
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2026 08:53:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xENCu-0001f5-Dv; Wed, 07 Oct 2026 04:41:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <magnuskulke@linux.microsoft.com>)
 id 1xEIsw-0008Vg-VJ
 for qemu-devel@nongnu.org; Wed, 07 Oct 2026 00:04:11 -0400
Received: from linux.microsoft.com ([13.77.154.182])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <magnuskulke@linux.microsoft.com>) id 1xEIsr-0004ZN-DS
 for qemu-devel@nongnu.org; Wed, 07 Oct 2026 00:04:04 -0400
Received: from DESKTOP-TUU1E5L.localdomain (unknown [167.220.208.46])
 by linux.microsoft.com (Postfix) with ESMTPSA id 7938320B7170;
 Tue,  6 Oct 2026 09:48:54 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 7938320B7170
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
 s=default; t=1791305335;
 bh=2ii5b00CUyR1UNtMlmJCJdrt3NnMzm03IXQ1lMcVGNc=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=Ej3nKIi6MZsLXjvRmSTXQYDO52eYmjSwRopdGpRpNMCfwrlzlUgkFNiK1S1kjBQdN
 uLf0hV9heEIesDYQccNFi1AEiK2VYwbKTUEspPUx6SUFIqD1njcTItUroeEIu61ij0
 aTVJoFxEVIRzk/9FX0sReWGfA0MLGtsfLRbn7mM8=
From: Magnus Kulke <magnuskulke@linux.microsoft.com>
To: qemu-devel@nongnu.org
Cc: Wei Liu <wei.liu@kernel.org>,
 =?UTF-8?q?Doru=20Bl=C3=A2nzeanu?= <dblanzeanu@linux.microsoft.com>,
 Magnus Kulke <magnuskulke@microsoft.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: [PULL 09/11] include/hw/hyperv: add ABI for exception intercepts and
 pending events
Date: Tue,  6 Oct 2026 18:49:03 +0200
Message-Id: <20261006164905.776466-10-magnuskulke@linux.microsoft.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261006164905.776466-1-magnuskulke@linux.microsoft.com>
References: <20261006164905.776466-1-magnuskulke@linux.microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=13.77.154.182;
 envelope-from=magnuskulke@linux.microsoft.com; helo=linux.microsoft.com
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

From: Doru Blânzeanu <dblanzeanu@linux.microsoft.com>

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
Reviewed-by: Magnus Kulke <magnuskulke@linux.microsoft.com>
Signed-off-by: Magnus Kulke <magnuskulke@linux.microsoft.com>
---
 include/hw/hyperv/hvgdk_mini.h | 56 ++++++++++++++++++++++++++++++++++
 1 file changed, 56 insertions(+)

diff --git a/include/hw/hyperv/hvgdk_mini.h b/include/hw/hyperv/hvgdk_mini.h
index 4ae20d2ac1..0983e3a58d 100644
--- a/include/hw/hyperv/hvgdk_mini.h
+++ b/include/hw/hyperv/hvgdk_mini.h
@@ -22,6 +22,9 @@
 #define HV_X64_MSR_TSC_FREQUENCY    0x40000022
 #define HV_X64_MSR_APIC_FREQUENCY   0x40000023
 
+/* event_type values for hv_x64_pending_exception_event */
+#define HV_X64_PENDING_EVENT_EXCEPTION 0
+
 typedef enum hv_register_name {
     /* VP Management Registers */
     HV_REGISTER_INTERNAL_ACTIVITY_STATE = 0x00000004,
@@ -240,6 +243,29 @@ enum hv_intercept_type {
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
@@ -737,6 +763,35 @@ struct hv_x64_memory_intercept_message {
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
@@ -845,6 +900,7 @@ struct hv_cpuid {
 
 #define HVCALL_GET_PARTITION_PROPERTY    0x0044
 #define HVCALL_SET_PARTITION_PROPERTY    0x0045
+#define HVCALL_INSTALL_INTERCEPT         0x004d
 #define HVCALL_GET_VP_REGISTERS          0x0050
 #define HVCALL_SET_VP_REGISTERS          0x0051
 #define HVCALL_TRANSLATE_VIRTUAL_ADDRESS 0x0052
-- 
2.34.1


