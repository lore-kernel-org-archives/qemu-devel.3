Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48B80FF886D
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Apr 2026 14:01:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wHizs-00040Y-IB; Tue, 28 Apr 2026 10:01:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dblanzeanu@linux.microsoft.com>)
 id 1wHiqD-0002Ti-Bq
 for qemu-devel@nongnu.org; Tue, 28 Apr 2026 09:51:09 -0400
Received: from linux.microsoft.com ([13.77.154.182])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dblanzeanu@linux.microsoft.com>) id 1wHiqB-0005kH-Qm
 for qemu-devel@nongnu.org; Tue, 28 Apr 2026 09:51:09 -0400
Received: from laptop.localdomain (unknown [86.121.140.248])
 by linux.microsoft.com (Postfix) with ESMTPSA id AEE8420B716C;
 Tue, 28 Apr 2026 06:51:05 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com AEE8420B716C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
 s=default; t=1777384267;
 bh=WJ38DvPHOqPdr07vUC966sHLG/3L8q3zyQeBdhMkfd8=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=LYhAsljsNH8Fze7X7qLlONLrF6eA/2SZ4P1w+2pCowMkN91G60EYjKqvlTAXs3uDI
 J6bsxFO06fJsQkIpuA1xB6E5sgDXJEsbyNdTSSVneyc5CbSNDbOWIhQGc/lwUt7gXJ
 RDHDO1sUe9LR4faPcJc9BSfN2uFs5CJRKND3lGTs=
From: =?UTF-8?q?Doru=20Bl=C3=A2nzeanu?= <dblanzeanu@linux.microsoft.com>
To: qemu-devel@nongnu.org
Cc: Magnus Kulke <magnuskulke@linux.microsoft.com>,
 Wei Liu <wei.liu@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>,
 Zhao Liu <zhao1.liu@intel.com>
Subject: [PATCH 3/6] include/hw/hyperv: add hv_vp_register_page struct
 definition
Date: Tue, 28 Apr 2026 16:50:50 +0300
Message-ID: <20260428135053.251200-4-dblanzeanu@linux.microsoft.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260428135053.251200-1-dblanzeanu@linux.microsoft.com>
References: <20260428135053.251200-1-dblanzeanu@linux.microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=13.77.154.182;
 envelope-from=dblanzeanu@linux.microsoft.com; helo=linux.microsoft.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Tue, 28 Apr 2026 10:00:24 -0400
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

Define the `hv_vp_register_page` structure that the linux kernel uses
to allow access to vcpu registers.

This structure is going to be used in later patches to access vcpu
registers.

Signed-off-by: Doru Blânzeanu <dblanzeanu@linux.microsoft.com>
---
 include/hw/hyperv/hvgdk_mini.h | 103 +++++++++++++++++++++++++++++++++
 1 file changed, 103 insertions(+)

diff --git a/include/hw/hyperv/hvgdk_mini.h b/include/hw/hyperv/hvgdk_mini.h
index c3a8f33280..07e322865a 100644
--- a/include/hw/hyperv/hvgdk_mini.h
+++ b/include/hw/hyperv/hvgdk_mini.h
@@ -474,6 +474,109 @@ struct hv_input_assert_virtual_interrupt {
     uint16_t rsvd_z1;
 } QEMU_PACKED;
 
+/* Flags for dirty mask of hv_vp_register_page */
+enum hv_x64_register_class_type {
+    HV_X64_REGISTER_CLASS_GENERAL = 0,
+    HV_X64_REGISTER_CLASS_IP = 1,
+    HV_X64_REGISTER_CLASS_XMM = 2,
+    HV_X64_REGISTER_CLASS_SEGMENT = 3,
+    HV_X64_REGISTER_CLASS_FLAGS = 4,
+};
+
+#define HV_VP_REGISTER_PAGE_MAX_VECTOR_COUNT  7
+
+union hv_vp_register_page_interrupt_vectors {
+    uint64_t as_uint64;
+    struct {
+        uint8_t vector_count;
+        uint8_t vector[HV_VP_REGISTER_PAGE_MAX_VECTOR_COUNT];
+    };
+};
+
+struct hv_vp_register_page {
+    uint16_t version;
+    uint8_t isvalid;
+    uint8_t rsvdz;
+    uint32_t dirty;
+
+    union {
+        struct {
+            /* General purpose registers (HV_X64_REGISTER_CLASS_GENERAL) */
+            union {
+                struct {
+                    uint64_t rax;
+                    uint64_t rcx;
+                    uint64_t rdx;
+                    uint64_t rbx;
+                    uint64_t rsp;
+                    uint64_t rbp;
+                    uint64_t rsi;
+                    uint64_t rdi;
+                    uint64_t r8;
+                    uint64_t r9;
+                    uint64_t r10;
+                    uint64_t r11;
+                    uint64_t r12;
+                    uint64_t r13;
+                    uint64_t r14;
+                    uint64_t r15;
+                } QEMU_PACKED;
+
+                uint64_t gp_registers[16];
+            };
+            /* Instruction pointer (HV_X64_REGISTER_CLASS_IP) */
+            uint64_t rip;
+            /* Flags (HV_X64_REGISTER_CLASS_FLAGS) */
+            uint64_t rflags;
+        } QEMU_PACKED;
+
+        uint64_t registers[18];
+    };
+    uint8_t reserved[8];
+    /* Volatile XMM registers (HV_X64_REGISTER_CLASS_XMM) */
+    union {
+        struct {
+            struct hv_u128 xmm0;
+            struct hv_u128 xmm1;
+            struct hv_u128 xmm2;
+            struct hv_u128 xmm3;
+            struct hv_u128 xmm4;
+            struct hv_u128 xmm5;
+        } QEMU_PACKED;
+
+        struct hv_u128 xmm_registers[6];
+    };
+    /* Segment registers (HV_X64_REGISTER_CLASS_SEGMENT) */
+    union {
+        struct {
+            struct hv_x64_segment_register es;
+            struct hv_x64_segment_register cs;
+            struct hv_x64_segment_register ss;
+            struct hv_x64_segment_register ds;
+            struct hv_x64_segment_register fs;
+            struct hv_x64_segment_register gs;
+        } QEMU_PACKED;
+
+        struct hv_x64_segment_register segment_registers[6];
+    };
+    /* Misc. control registers (cannot be set via this interface) */
+    uint64_t cr0;
+    uint64_t cr3;
+    uint64_t cr4;
+    uint64_t cr8;
+    uint64_t efer;
+    uint64_t dr7;
+    union hv_x64_pending_interruption_register pending_interruption;
+    union hv_x64_interrupt_state_register interrupt_state;
+    uint64_t instruction_emulation_hints;
+    uint64_t xfem;
+
+    uint8_t reserved1[0x100];
+
+    /* Interrupts injected as part of HvCallDispatchVp. */
+    union hv_vp_register_page_interrupt_vectors interrupt_vectors;
+} QEMU_PACKED;
+
 /* /dev/mshv */
 #define MSHV_CREATE_PARTITION   _IOW(MSHV_IOCTL, 0x00, struct mshv_create_partition)
 #define MSHV_CREATE_VP          _IOW(MSHV_IOCTL, 0x01, struct mshv_create_vp)
-- 
2.53.0


