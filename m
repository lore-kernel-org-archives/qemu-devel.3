Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57E88D58E7A
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Mar 2026 08:49:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vwytq-0002zV-G4; Mon, 02 Mar 2026 03:45:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vwytR-0001w7-DC
 for qemu-devel@nongnu.org; Mon, 02 Mar 2026 03:44:48 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vwytN-0001af-6c
 for qemu-devel@nongnu.org; Mon, 02 Mar 2026 03:44:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1772441078;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=efG39ehvTXHsHgsUkk8khNEEn/y1C14CuxY6g8oqngM=;
 b=Irr6U1hqYCFizdHfkmzMIMN+Lqumffg7Fx4ZxPCPAYOeGobKov5+yEjNQZOL3EQFLIm0+F
 NwGy+xG+FZdSkYYMR1xGMPrVK5xE+p3ibXMolLqj92fn+tFh/WAbvnxl7cjfwZsh4D0MMc
 bDN3x4vBxbgjf/9aiHqTu3VFXjuSu+E=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-657-E6X_o8wCObuVduBo4mwCvw-1; Mon, 02 Mar 2026 03:44:37 -0500
X-MC-Unique: E6X_o8wCObuVduBo4mwCvw-1
X-Mimecast-MFC-AGG-ID: E6X_o8wCObuVduBo4mwCvw_1772441076
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-4837a718f41so23625585e9.2
 for <qemu-devel@nongnu.org>; Mon, 02 Mar 2026 00:44:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1772441076; x=1773045876; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=efG39ehvTXHsHgsUkk8khNEEn/y1C14CuxY6g8oqngM=;
 b=BlDq+lfC1bAzQDjZPj65cQQR/pxKRmluYyon52KoTH+f5OH8jJW0VSFh8Br/DUGotz
 oWIuFaErFAZMrZIOfGBj2QHaw6dShVoMBoWuUskdtBLPbIH8n0/BS8IcXpXRriB0R6+X
 hqYaGPY+EKQveF6HttGNGc5KeMZJGDdmQFfypPX+KtkDCCt7zhzK3OUUr9GM0VBT5R0k
 R9Q0LXWrdwvSYtRzwFou7aE4E6xw8naoDH29DiPCh/oPkhVDMFtFdYz5DQ8D/8Ft4naj
 lmqkw2HOtxCxXQ+ilBUSEsf7tPv17J1VtDUhJhGA6vfCiZvZvyFVXBVwfIHBbuz5QsU/
 Ut+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772441076; x=1773045876;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=efG39ehvTXHsHgsUkk8khNEEn/y1C14CuxY6g8oqngM=;
 b=E5k1a+VAm9ia+jj3/XMWtqJBghQvvlF2V97Mv8oxIC7I+XiH7TWNxoj0+e9fzh8NY9
 6uUQPC9eBoEIrGDgDF2tET0SwjdhTORYJo9+bIumTf0vVytmwspsGioZTx+iVN8zN5Ll
 8uaJw2bPYlZmCbQgPVmhuMiLaqM8yqpuvFPWQQnl851+EFTeafkrWTJQN29k25/gc+wx
 URTWutP7K0NsqYcaifSQbfb6rXdBQtjfRaSp2BEo1tdxqVYHGezzM9qBN5iKK7EZRGYw
 0TSpvOtRsjVmG210GneSQGrLYpFHM4n53Xd0/85+zPs/IcnYIlu1jTGIjL6Xm+t1dW6t
 Khsg==
X-Gm-Message-State: AOJu0YwEFEakIGWKLLHXNMnbs6nnbemeXIDK7r/eP3tH1xuQvwT4Qatd
 vn5ZzuYo26r/oAZsdFmSTe4f9enJaHbInAmdQz7SjsR4kfhB8KDB6WaYSuwzIdBVGRiQ4sjIHnw
 lg1bzdVtck5nNL+5Js3hjybGCU/1+mE0GacUmnuMO5hYOmCZdrJMAxqAr5LTDzZb24AwzVYM6Gr
 kBLOJSwf/VZKgjjzSYBqsSs+bArijdv9Gqh71V5vA/
X-Gm-Gg: ATEYQzyBZxgsT8LJZGK2ld9CK59CJT7c/uQW/YBAyE8ek4AAW0Xd+G2uKCfjtwRkhGk
 2iz+s+TlrOervBG5PNElPoo+6r7AOlSFybap3I5YFtxmpkRM6lEXT+i4rjCUQwaA8l6FdvcgjuC
 uOiA4Zx7lkp4IyuFkYzRn4JWtdpIOywDyzAtnQ2z6X0g6TKgj+9iLv3iZcEtgPcQppSlqIS9iJv
 /bRxOzoaRO8PhYtZeaxYrWsvisIESsdmDnne8Ty51QN7HJLlIEypMz5C9qRQzND53bVWsCmBj4s
 5YmxVQNiQXPnVP7SvJul/PQeUb9DraYDcjsm/2o1/9eo7WfILyh2pNkW74+lZXqKiJNOl/6zN6v
 GQBrqs3kQcsKfoE7dM5W0emKhEBFLFPoVDXnDJTIAUOcJOU68n0ae/b2UXYb2jUDajxWBActHfX
 AoM3F+w/6YGZz9f68QIwoQHQBCatk=
X-Received: by 2002:a05:600c:1d12:b0:483:9cdc:8ac1 with SMTP id
 5b1f17b1804b1-483c9b9eb7amr184474735e9.11.1772441075338; 
 Mon, 02 Mar 2026 00:44:35 -0800 (PST)
X-Received: by 2002:a05:600c:1d12:b0:483:9cdc:8ac1 with SMTP id
 5b1f17b1804b1-483c9b9eb7amr184474055e9.11.1772441074567; 
 Mon, 02 Mar 2026 00:44:34 -0800 (PST)
Received: from [192.168.10.48] ([151.95.144.138])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-439b503425asm7934880f8f.25.2026.03.02.00.44.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Mar 2026 00:44:32 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Mohamed Mediouni <mohamed@unpredictable.fr>
Subject: [PULL 020/102] target/i386: emulate, hvf, mshv: rework MMU code
Date: Mon,  2 Mar 2026 09:42:15 +0100
Message-ID: <20260302084338.473368-21-pbonzini@redhat.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260302084338.473368-1-pbonzini@redhat.com>
References: <20260302084338.473368-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -8
X-Spam_score: -0.9
X-Spam_bar: /
X-Spam_report: (-0.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.012, RCVD_IN_VALIDITY_RPBL_BLOCKED=1.188,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

From: Mohamed Mediouni <mohamed@unpredictable.fr>

target/i386/emulate doesn't currently properly emulate instructions
which might cause a page fault during their execution. Notably, REP STOS/MOVS
from MMIO to an address which is unmapped until a page fault exception is raised
causes an abort() in vmx_write_mem.

Change the interface between the HW accel backend and target/i386/emulate as a first step towards addressing that.

Adapt the page table walker code to give actionable errors,
while leaving a possibility for backends to provide their own walker.

This removes the usage of the Hyper-V page walker in the mshv backend.

Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>
Link: https://lore.kernel.org/r/20260223233950.96076-20-mohamed@unpredictable.fr
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/emulate/x86_emu.h     |   4 +-
 target/i386/emulate/x86_mmu.h     |  31 +++++--
 target/i386/emulate/x86_decode.c  |   2 +-
 target/i386/emulate/x86_emu.c     |  14 +--
 target/i386/emulate/x86_helpers.c |   5 +-
 target/i386/emulate/x86_mmu.c     | 146 +++++++++++++++++++-----------
 target/i386/hvf/hvf.c             |  31 +++----
 target/i386/hvf/x86.c             |   6 +-
 target/i386/hvf/x86_task.c        |   8 +-
 target/i386/mshv/mshv-cpu.c       |  71 ---------------
 target/i386/whpx/whpx-all.c       |  12 ---
 11 files changed, 146 insertions(+), 184 deletions(-)

diff --git a/target/i386/emulate/x86_emu.h b/target/i386/emulate/x86_emu.h
index 05686b162f6..3e485b8ca36 100644
--- a/target/i386/emulate/x86_emu.h
+++ b/target/i386/emulate/x86_emu.h
@@ -21,13 +21,13 @@
 
 #include "x86.h"
 #include "x86_decode.h"
+#include "x86_mmu.h"
 #include "cpu.h"
 
 struct x86_emul_ops {
     void (*fetch_instruction)(CPUState *cpu, void *data, target_ulong addr,
                               int bytes);
-    void (*read_mem)(CPUState *cpu, void *data, target_ulong addr, int bytes);
-    void (*write_mem)(CPUState *cpu, void *data, target_ulong addr, int bytes);
+    MMUTranslateResult (*mmu_gva_to_gpa) (CPUState *cpu, target_ulong gva, uint64_t *gpa, MMUTranslateFlags flags);
     void (*read_segment_descriptor)(CPUState *cpu, struct x86_segment_descriptor *desc,
                                     enum X86Seg seg);
     void (*handle_io)(CPUState *cpu, uint16_t port, void *data, int direction,
diff --git a/target/i386/emulate/x86_mmu.h b/target/i386/emulate/x86_mmu.h
index 9447ae072cd..190bd272a23 100644
--- a/target/i386/emulate/x86_mmu.h
+++ b/target/i386/emulate/x86_mmu.h
@@ -30,15 +30,30 @@
 #define PT_GLOBAL       (1 << 8)
 #define PT_NX           (1llu << 63)
 
-/* error codes */
-#define MMU_PAGE_PT             (1 << 0)
-#define MMU_PAGE_WT             (1 << 1)
-#define MMU_PAGE_US             (1 << 2)
-#define MMU_PAGE_NX             (1 << 3)
+typedef enum MMUTranslateFlags {
+    MMU_TRANSLATE_VALIDATE_WRITE = BIT(1),
+    MMU_TRANSLATE_VALIDATE_EXECUTE = BIT(2),
+    MMU_TRANSLATE_PRIV_CHECKS_EXEMPT = BIT(3)
+} MMUTranslateFlags;
 
-bool mmu_gva_to_gpa(CPUState *cpu, target_ulong gva, uint64_t *gpa);
+typedef enum MMUTranslateResult {
+    MMU_TRANSLATE_SUCCESS = 0,
+    MMU_TRANSLATE_PAGE_NOT_MAPPED = 1,
+    MMU_TRANSLATE_PRIV_VIOLATION = 2,
+    MMU_TRANSLATE_INVALID_PT_FLAGS = 3,
+    MMU_TRANSLATE_GPA_UNMAPPED = 4,
+    MMU_TRANSLATE_GPA_NO_READ_ACCESS = 5,
+    MMU_TRANSLATE_GPA_NO_WRITE_ACCESS = 6
+} MMUTranslateResult;
+
+MMUTranslateResult mmu_gva_to_gpa(CPUState *cpu, target_ulong gva, uint64_t *gpa, MMUTranslateFlags flags);
+
+/* Thin wrappers x86_write_mem_ex/x86_read_mem_ex for code readability */
+MMUTranslateResult x86_write_mem(CPUState *cpu, void *data, target_ulong gva, int bytes);
+MMUTranslateResult x86_read_mem(CPUState *cpu, void *data, target_ulong gva, int bytes);
+
+MMUTranslateResult x86_write_mem_priv(CPUState *cpu, void *data, target_ulong gva, int bytes);
+MMUTranslateResult x86_read_mem_priv(CPUState *cpu, void *data, target_ulong gva, int bytes);
 
-void vmx_write_mem(CPUState *cpu, target_ulong gva, void *data, int bytes);
-void vmx_read_mem(CPUState *cpu, void *data, target_ulong gva, int bytes);
 
 #endif /* X86_MMU_H */
diff --git a/target/i386/emulate/x86_decode.c b/target/i386/emulate/x86_decode.c
index 7bbcd2a9a2a..9faa65a5797 100644
--- a/target/i386/emulate/x86_decode.c
+++ b/target/i386/emulate/x86_decode.c
@@ -80,7 +80,7 @@ static inline uint64_t decode_bytes(CPUX86State *env, struct x86_decode *decode,
         if (emul_ops->fetch_instruction) {
             emul_ops->fetch_instruction(env_cpu(env), &val, va, size);
         } else {
-            emul_ops->read_mem(env_cpu(env), &val, va, size);
+            x86_read_mem(env_cpu(env), &val, va, size);
         }
     }
     decode->len += size;
diff --git a/target/i386/emulate/x86_emu.c b/target/i386/emulate/x86_emu.c
index bf96fe06b45..cfa35561dd5 100644
--- a/target/i386/emulate/x86_emu.c
+++ b/target/i386/emulate/x86_emu.c
@@ -166,7 +166,7 @@ void write_val_to_reg(void *reg_ptr, target_ulong val, int size)
 
 static void write_val_to_mem(CPUX86State *env, target_ulong ptr, target_ulong val, int size)
 {
-    emul_ops->write_mem(env_cpu(env), &val, ptr, size);
+    x86_write_mem(env_cpu(env), &val, ptr, size);
 }
 
 void write_val_ext(CPUX86State *env, struct x86_decode_op *decode, target_ulong val, int size)
@@ -180,7 +180,7 @@ void write_val_ext(CPUX86State *env, struct x86_decode_op *decode, target_ulong
 
 uint8_t *read_mmio(CPUX86State *env, target_ulong ptr, int bytes)
 {
-    emul_ops->read_mem(env_cpu(env), env->emu_mmio_buf, ptr, bytes);
+    x86_read_mem(env_cpu(env), env->emu_mmio_buf, ptr, bytes);
     return env->emu_mmio_buf;
 }
 
@@ -497,7 +497,7 @@ static void exec_ins_single(CPUX86State *env, struct x86_decode *decode)
 
     emul_ops->handle_io(env_cpu(env), DX(env), env->emu_mmio_buf, 0,
                         decode->operand_size, 1);
-    emul_ops->write_mem(env_cpu(env), env->emu_mmio_buf, addr,
+    x86_write_mem(env_cpu(env), env->emu_mmio_buf, addr,
                         decode->operand_size);
 
     string_increment_reg(env, R_EDI, decode);
@@ -518,7 +518,7 @@ static void exec_outs_single(CPUX86State *env, struct x86_decode *decode)
 {
     target_ulong addr = decode_linear_addr(env, decode, RSI(env), R_DS);
 
-    emul_ops->read_mem(env_cpu(env), env->emu_mmio_buf, addr,
+    x86_read_mem(env_cpu(env), env->emu_mmio_buf, addr,
                        decode->operand_size);
     emul_ops->handle_io(env_cpu(env), DX(env), env->emu_mmio_buf, 1,
                         decode->operand_size, 1);
@@ -604,7 +604,7 @@ static void exec_stos_single(CPUX86State *env, struct x86_decode *decode)
     addr = linear_addr_size(env_cpu(env), RDI(env),
                             decode->addressing_size, R_ES);
     val = read_reg(env, R_EAX, decode->operand_size);
-    emul_ops->write_mem(env_cpu(env), &val, addr, decode->operand_size);
+    x86_write_mem(env_cpu(env), &val, addr, decode->operand_size);
 
     string_increment_reg(env, R_EDI, decode);
 }
@@ -628,7 +628,7 @@ static void exec_scas_single(CPUX86State *env, struct x86_decode *decode)
     addr = linear_addr_size(env_cpu(env), RDI(env),
                             decode->addressing_size, R_ES);
     decode->op[1].type = X86_VAR_IMMEDIATE;
-    emul_ops->read_mem(env_cpu(env), &decode->op[1].val, addr, decode->operand_size);
+    x86_read_mem(env_cpu(env), &decode->op[1].val, addr, decode->operand_size);
 
     EXEC_2OP_FLAGS_CMD(env, decode, -, SET_FLAGS_OSZAPC_SUB, false);
     string_increment_reg(env, R_EDI, decode);
@@ -653,7 +653,7 @@ static void exec_lods_single(CPUX86State *env, struct x86_decode *decode)
     target_ulong val = 0;
 
     addr = decode_linear_addr(env, decode, RSI(env), R_DS);
-    emul_ops->read_mem(env_cpu(env), &val, addr,  decode->operand_size);
+    x86_read_mem(env_cpu(env), &val, addr,  decode->operand_size);
     write_reg(env, R_EAX, val, decode->operand_size);
 
     string_increment_reg(env, R_ESI, decode);
diff --git a/target/i386/emulate/x86_helpers.c b/target/i386/emulate/x86_helpers.c
index 7bdd7e4c2a1..024f9a2afcf 100644
--- a/target/i386/emulate/x86_helpers.c
+++ b/target/i386/emulate/x86_helpers.c
@@ -13,6 +13,7 @@
 #include "cpu.h"
 #include "emulate/x86_decode.h"
 #include "emulate/x86_emu.h"
+#include "emulate/x86_mmu.h"
 #include "qemu/error-report.h"
 #include "system/mshv.h"
 
@@ -176,7 +177,7 @@ bool x86_read_segment_descriptor(CPUState *cpu,
     }
 
     gva = base + sel.index * 8;
-    emul_ops->read_mem(cpu, desc, gva, sizeof(*desc));
+    x86_read_mem_priv(cpu, desc, gva, sizeof(*desc));
 
     return true;
 }
@@ -200,7 +201,7 @@ bool x86_read_call_gate(CPUState *cpu, struct x86_call_gate *idt_desc,
     }
 
     gva = base + gate * 8;
-    emul_ops->read_mem(cpu, idt_desc, gva, sizeof(*idt_desc));
+    x86_read_mem_priv(cpu, idt_desc, gva, sizeof(*idt_desc));
 
     return true;
 }
diff --git a/target/i386/emulate/x86_mmu.c b/target/i386/emulate/x86_mmu.c
index 35987a897aa..11e17c2db1d 100644
--- a/target/i386/emulate/x86_mmu.c
+++ b/target/i386/emulate/x86_mmu.c
@@ -21,7 +21,9 @@
 #include "cpu.h"
 #include "system/address-spaces.h"
 #include "system/memory.h"
+#include "qemu/error-report.h"
 #include "emulate/x86.h"
+#include "emulate/x86_emu.h"
 #include "emulate/x86_mmu.h"
 
 #define pte_present(pte) (pte & PT_PRESENT)
@@ -32,6 +34,11 @@
 #define pte_large_page(pte) (pte & PT_PS)
 #define pte_global_access(pte) (pte & PT_GLOBAL)
 
+#define mmu_validate_write(flags) (flags & MMU_TRANSLATE_VALIDATE_WRITE)
+#define mmu_validate_execute(flags) (flags & MMU_TRANSLATE_VALIDATE_EXECUTE)
+#define mmu_priv_checks_exempt(flags) (flags & MMU_TRANSLATE_PRIV_CHECKS_EXEMPT)
+
+
 #define PAE_CR3_MASK                (~0x1fllu)
 #define LEGACY_CR3_MASK             (0xffffffff)
 
@@ -40,14 +47,16 @@
 #define PAE_PTE_LARGE_PAGE_MASK     ((-1llu << (21)) & ((1llu << 52) - 1))
 #define PAE_PTE_SUPER_PAGE_MASK     ((-1llu << (30)) & ((1llu << 52) - 1))
 
+static bool is_user(CPUState *cpu)
+{
+    return false;
+}
+
+
 struct gpt_translation {
     target_ulong  gva;
     uint64_t gpa;
-    int    err_code;
     uint64_t pte[5];
-    bool write_access;
-    bool user_access;
-    bool exec_access;
 };
 
 static int gpt_top_level(CPUState *cpu, bool pae)
@@ -99,25 +108,15 @@ static bool get_pt_entry(CPUState *cpu, struct gpt_translation *pt,
 }
 
 /* test page table entry */
-static bool test_pt_entry(CPUState *cpu, struct gpt_translation *pt,
-                          int level, int *largeness, bool pae)
+static MMUTranslateResult test_pt_entry(CPUState *cpu, struct gpt_translation *pt,
+                          int level, int *largeness, bool pae, MMUTranslateFlags flags)
 {
     X86CPU *x86_cpu = X86_CPU(cpu);
     CPUX86State *env = &x86_cpu->env;
     uint64_t pte = pt->pte[level];
 
-    if (pt->write_access) {
-        pt->err_code |= MMU_PAGE_WT;
-    }
-    if (pt->user_access) {
-        pt->err_code |= MMU_PAGE_US;
-    }
-    if (pt->exec_access) {
-        pt->err_code |= MMU_PAGE_NX;
-    }
-
     if (!pte_present(pte)) {
-        return false;
+        return MMU_TRANSLATE_PAGE_NOT_MAPPED;
     }
 
     if (pae && !x86_is_long_mode(cpu) && 2 == level) {
@@ -125,32 +124,30 @@ static bool test_pt_entry(CPUState *cpu, struct gpt_translation *pt,
     }
 
     if (level && pte_large_page(pte)) {
-        pt->err_code |= MMU_PAGE_PT;
         *largeness = level;
     }
-    if (!level) {
-        pt->err_code |= MMU_PAGE_PT;
-    }
 
     uint32_t cr0 = env->cr[0];
     /* check protection */
     if (cr0 & CR0_WP_MASK) {
-        if (pt->write_access && !pte_write_access(pte)) {
-            return false;
+        if (mmu_validate_write(flags) && !pte_write_access(pte)) {
+            return MMU_TRANSLATE_PRIV_VIOLATION;
         }
     }
 
-    if (pt->user_access && !pte_user_access(pte)) {
-        return false;
+    if (!mmu_priv_checks_exempt(flags)) {
+        if (is_user(cpu) && !pte_user_access(pte)) {
+            return MMU_TRANSLATE_PRIV_VIOLATION;
+        }
     }
 
-    if (pae && pt->exec_access && !pte_exec_access(pte)) {
-        return false;
+    if (pae && mmu_validate_execute(flags) && !pte_exec_access(pte)) {
+        return MMU_TRANSLATE_PRIV_VIOLATION;
     }
     
 exit:
     /* TODO: check reserved bits */
-    return true;
+    return MMU_TRANSLATE_SUCCESS;
 }
 
 static inline uint64_t pse_pte_to_page(uint64_t pte)
@@ -181,7 +178,7 @@ static inline uint64_t large_page_gpa(struct gpt_translation *pt, bool pae,
 
 
 
-static bool walk_gpt(CPUState *cpu, target_ulong addr, int err_code,
+static MMUTranslateResult walk_gpt(CPUState *cpu, target_ulong addr, MMUTranslateFlags flags,
                      struct gpt_translation *pt, bool pae)
 {
     X86CPU *x86_cpu = X86_CPU(cpu);
@@ -190,21 +187,20 @@ static bool walk_gpt(CPUState *cpu, target_ulong addr, int err_code,
     int largeness = 0;
     target_ulong cr3 = env->cr[3];
     uint64_t page_mask = pae ? PAE_PTE_PAGE_MASK : LEGACY_PTE_PAGE_MASK;
+    MMUTranslateResult res;
     
     memset(pt, 0, sizeof(*pt));
     top_level = gpt_top_level(cpu, pae);
 
     pt->pte[top_level] = pae ? (cr3 & PAE_CR3_MASK) : (cr3 & LEGACY_CR3_MASK);
     pt->gva = addr;
-    pt->user_access = (err_code & MMU_PAGE_US);
-    pt->write_access = (err_code & MMU_PAGE_WT);
-    pt->exec_access = (err_code & MMU_PAGE_NX);
     
     for (level = top_level; level > 0; level--) {
         get_pt_entry(cpu, pt, level, pae);
+        res = test_pt_entry(cpu, pt, level - 1, &largeness, pae, flags);
 
-        if (!test_pt_entry(cpu, pt, level - 1, &largeness, pae)) {
-            return false;
+        if (res) {
+            return res;
         }
 
         if (largeness) {
@@ -218,69 +214,111 @@ static bool walk_gpt(CPUState *cpu, target_ulong addr, int err_code,
         pt->gpa = large_page_gpa(pt, pae, largeness);
     }
 
-    return true;
+    return res;
 }
 
 
-bool mmu_gva_to_gpa(CPUState *cpu, target_ulong gva, uint64_t *gpa)
+MMUTranslateResult mmu_gva_to_gpa(CPUState *cpu, target_ulong gva, uint64_t *gpa, MMUTranslateFlags flags)
 {
+    if (emul_ops->mmu_gva_to_gpa) {
+        return emul_ops->mmu_gva_to_gpa(cpu, gva, gpa, flags);
+    }
+
     bool res;
     struct gpt_translation pt;
-    int err_code = 0;
 
     if (!x86_is_paging_mode(cpu)) {
         *gpa = gva;
-        return true;
+        return MMU_TRANSLATE_SUCCESS;
     }
 
-    res = walk_gpt(cpu, gva, err_code, &pt, x86_is_pae_enabled(cpu));
-    if (res) {
+    res = walk_gpt(cpu, gva, flags, &pt, x86_is_pae_enabled(cpu));
+    if (res == MMU_TRANSLATE_SUCCESS) {
         *gpa = pt.gpa;
-        return true;
     }
 
-    return false;
+    return res;
 }
 
-void vmx_write_mem(CPUState *cpu, target_ulong gva, void *data, int bytes)
+static MMUTranslateResult x86_write_mem_ex(CPUState *cpu, void *data, target_ulong gva, int bytes, bool priv_check_exempt)
 {
+    MMUTranslateResult translate_res = MMU_TRANSLATE_SUCCESS;
+    MemTxResult mem_tx_res;
     uint64_t gpa;
 
     while (bytes > 0) {
         /* copy page */
         int copy = MIN(bytes, 0x1000 - (gva & 0xfff));
 
-        if (!mmu_gva_to_gpa(cpu, gva, &gpa)) {
-            VM_PANIC_EX("%s: mmu_gva_to_gpa " TARGET_FMT_lx " failed\n",
-                        __func__, gva);
-        } else {
-            address_space_write(&address_space_memory, gpa,
-                                MEMTXATTRS_UNSPECIFIED, data, copy);
+        translate_res = mmu_gva_to_gpa(cpu, gva, &gpa, MMU_TRANSLATE_VALIDATE_WRITE);
+        if (translate_res) {
+            return translate_res;
+        }
+
+        mem_tx_res = address_space_write(&address_space_memory, gpa,
+                            MEMTXATTRS_UNSPECIFIED, data, copy);
+
+        if (mem_tx_res == MEMTX_DECODE_ERROR) {
+            warn_report("write to unmapped mmio region gpa=0x%" PRIx64 " size=%i", gpa, bytes);
+            return MMU_TRANSLATE_GPA_UNMAPPED;
+        } else if (mem_tx_res == MEMTX_ACCESS_ERROR) {
+            return MMU_TRANSLATE_GPA_NO_WRITE_ACCESS;
         }
 
         bytes -= copy;
         gva += copy;
         data += copy;
     }
+    return translate_res;
 }
 
-void vmx_read_mem(CPUState *cpu, void *data, target_ulong gva, int bytes)
+MMUTranslateResult x86_write_mem(CPUState *cpu, void *data, target_ulong gva, int bytes)
 {
+    return x86_write_mem_ex(cpu, data, gva, bytes, false);
+}
+
+MMUTranslateResult x86_write_mem_priv(CPUState *cpu, void *data, target_ulong gva, int bytes)
+{
+    return x86_write_mem_ex(cpu, data, gva, bytes, true);
+}
+
+static MMUTranslateResult x86_read_mem_ex(CPUState *cpu, void *data, target_ulong gva, int bytes, bool priv_check_exempt)
+{
+    MMUTranslateResult translate_res = MMU_TRANSLATE_SUCCESS;
+    MemTxResult mem_tx_res;
     uint64_t gpa;
 
     while (bytes > 0) {
         /* copy page */
         int copy = MIN(bytes, 0x1000 - (gva & 0xfff));
 
-        if (!mmu_gva_to_gpa(cpu, gva, &gpa)) {
-            VM_PANIC_EX("%s: mmu_gva_to_gpa " TARGET_FMT_lx " failed\n",
-                        __func__, gva);
+        translate_res = mmu_gva_to_gpa(cpu, gva, &gpa, 0);
+        if (translate_res) {
+            return translate_res;
         }
-        address_space_read(&address_space_memory, gpa, MEMTXATTRS_UNSPECIFIED,
+        mem_tx_res = address_space_read(&address_space_memory, gpa, MEMTXATTRS_UNSPECIFIED,
                            data, copy);
 
+        if (mem_tx_res == MEMTX_DECODE_ERROR) {
+            warn_report("read from unmapped mmio region gpa=0x%" PRIx64 " size=%i", gpa, bytes);
+            return MMU_TRANSLATE_GPA_UNMAPPED;
+        } else if (mem_tx_res == MEMTX_ACCESS_ERROR) {
+            return MMU_TRANSLATE_GPA_NO_READ_ACCESS;
+        }
+
         bytes -= copy;
         gva += copy;
         data += copy;
     }
+    return translate_res;
+}
+
+MMUTranslateResult x86_read_mem(CPUState *cpu, void *data, target_ulong gva, int bytes)
+{
+    return x86_read_mem_ex(cpu, data, gva, bytes, false);
+}
+
+MMUTranslateResult x86_read_mem_priv(CPUState *cpu, void *data, target_ulong gva, int bytes)
+{
+    return x86_read_mem_ex(cpu, data, gva, bytes, true);
 }
diff --git a/target/i386/hvf/hvf.c b/target/i386/hvf/hvf.c
index 0b3674ad33d..fb039ff7bd5 100644
--- a/target/i386/hvf/hvf.c
+++ b/target/i386/hvf/hvf.c
@@ -252,27 +252,7 @@ static void hvf_read_segment_descriptor(CPUState *s, struct x86_segment_descript
     vmx_segment_to_x86_descriptor(s, &vmx_segment, desc);
 }
 
-static void hvf_read_mem(CPUState *cpu, void *data, target_ulong gva, int bytes)
-{
-    X86CPU *x86_cpu = X86_CPU(cpu);
-    CPUX86State *env = &x86_cpu->env;
-    env->cr[0] = rvmcs(cpu->accel->fd, VMCS_GUEST_CR0);
-    env->cr[3] = rvmcs(cpu->accel->fd, VMCS_GUEST_CR3);
-    vmx_read_mem(cpu, data, gva, bytes);
-}
-
-static void hvf_write_mem(CPUState *cpu, void *data, target_ulong gva, int bytes)
-{
-    X86CPU *x86_cpu = X86_CPU(cpu);
-    CPUX86State *env = &x86_cpu->env;
-    env->cr[0] = rvmcs(cpu->accel->fd, VMCS_GUEST_CR0);
-    env->cr[3] = rvmcs(cpu->accel->fd, VMCS_GUEST_CR3);
-    vmx_write_mem(cpu, gva, data, bytes);
-}
-
 static const struct x86_emul_ops hvf_x86_emul_ops = {
-    .read_mem = hvf_read_mem,
-    .write_mem = hvf_write_mem,
     .read_segment_descriptor = hvf_read_segment_descriptor,
     .handle_io = hvf_handle_io,
     .simulate_rdmsr = hvf_simulate_rdmsr,
@@ -490,6 +470,14 @@ static void hvf_cpu_x86_cpuid(CPUX86State *env, uint32_t index, uint32_t count,
     }
 }
 
+static void hvf_load_crs(CPUState *cs)
+{
+    X86CPU *x86_cpu = X86_CPU(cpu);
+    CPUX86State *env = &x86_cpu->env;
+
+    env->cr[0] = rvmcs(cpu->accel->fd, VMCS_GUEST_CR0);
+    env->cr[3] = rvmcs(cpu->accel->fd, VMCS_GUEST_CR3);
+}
 void hvf_load_regs(CPUState *cs)
 {
     X86CPU *cpu = X86_CPU(cs);
@@ -802,6 +790,7 @@ static int hvf_handle_vmexit(CPUState *cpu)
             struct x86_decode decode;
 
             hvf_load_regs(cpu);
+            hvf_load_crs(cpu);
             decode_instruction(env, &decode);
             exec_instruction(env, &decode);
             hvf_store_regs(cpu);
@@ -843,6 +832,7 @@ static int hvf_handle_vmexit(CPUState *cpu)
         }
 
         hvf_load_regs(cpu);
+        hvf_load_crs(cpu);
         decode_instruction(env, &decode);
         assert(ins_len == decode.len);
         exec_instruction(env, &decode);
@@ -948,6 +938,7 @@ static int hvf_handle_vmexit(CPUState *cpu)
         struct x86_decode decode;
 
         hvf_load_regs(cpu);
+        hvf_load_crs(cpu);
         decode_instruction(env, &decode);
         exec_instruction(env, &decode);
         hvf_store_regs(cpu);
diff --git a/target/i386/hvf/x86.c b/target/i386/hvf/x86.c
index e98f480f411..7fe710aca3b 100644
--- a/target/i386/hvf/x86.c
+++ b/target/i386/hvf/x86.c
@@ -72,7 +72,7 @@ bool x86_read_segment_descriptor(CPUState *cpu,
         return false;
     }
 
-    vmx_read_mem(cpu, desc, base + sel.index * 8, sizeof(*desc));
+    x86_read_mem_priv(cpu, desc, base + sel.index * 8, sizeof(*desc));
     return true;
 }
 
@@ -95,7 +95,7 @@ bool x86_write_segment_descriptor(CPUState *cpu,
         printf("%s: gdt limit\n", __func__);
         return false;
     }
-    vmx_write_mem(cpu, base + sel.index * 8, desc, sizeof(*desc));
+    x86_write_mem_priv(cpu, desc, base + sel.index * 8, sizeof(*desc));
     return true;
 }
 
@@ -111,7 +111,7 @@ bool x86_read_call_gate(CPUState *cpu, struct x86_call_gate *idt_desc,
         return false;
     }
 
-    vmx_read_mem(cpu, idt_desc, base + gate * 8, sizeof(*idt_desc));
+    x86_read_mem_priv(cpu, idt_desc, base + gate * 8, sizeof(*idt_desc));
     return true;
 }
 
diff --git a/target/i386/hvf/x86_task.c b/target/i386/hvf/x86_task.c
index b1e541a6420..64e30e970d9 100644
--- a/target/i386/hvf/x86_task.c
+++ b/target/i386/hvf/x86_task.c
@@ -93,16 +93,16 @@ static int task_switch_32(CPUState *cpu, x86_segment_selector tss_sel, x86_segme
     uint32_t eip_offset = offsetof(struct x86_tss_segment32, eip);
     uint32_t ldt_sel_offset = offsetof(struct x86_tss_segment32, ldt);
 
-    vmx_read_mem(cpu, &tss_seg, old_tss_base, sizeof(tss_seg));
+    x86_read_mem_priv(cpu, &tss_seg, old_tss_base, sizeof(tss_seg));
     save_state_to_tss32(cpu, &tss_seg);
 
-    vmx_write_mem(cpu, old_tss_base + eip_offset, &tss_seg.eip, ldt_sel_offset - eip_offset);
-    vmx_read_mem(cpu, &tss_seg, new_tss_base, sizeof(tss_seg));
+    x86_write_mem_priv(cpu, &tss_seg.eip, old_tss_base + eip_offset, ldt_sel_offset - eip_offset);
+    x86_read_mem_priv(cpu, &tss_seg, new_tss_base, sizeof(tss_seg));
 
     if (old_tss_sel.sel != 0xffff) {
         tss_seg.prev_tss = old_tss_sel.sel;
 
-        vmx_write_mem(cpu, new_tss_base, &tss_seg.prev_tss, sizeof(tss_seg.prev_tss));
+        x86_write_mem_priv(cpu, &tss_seg.prev_tss, new_tss_base, sizeof(tss_seg.prev_tss));
     }
     load_state_from_tss32(cpu, &tss_seg);
     return 0;
diff --git a/target/i386/mshv/mshv-cpu.c b/target/i386/mshv/mshv-cpu.c
index f190e83bd15..2bc978deb25 100644
--- a/target/i386/mshv/mshv-cpu.c
+++ b/target/i386/mshv/mshv-cpu.c
@@ -1548,74 +1548,6 @@ int mshv_create_vcpu(int vm_fd, uint8_t vp_index, int *cpu_fd)
     return 0;
 }
 
-static int guest_mem_read_with_gva(const CPUState *cpu, uint64_t gva,
-                                   uint8_t *data, uintptr_t size,
-                                   bool fetch_instruction)
-{
-    int ret;
-    uint64_t gpa, flags;
-
-    flags = HV_TRANSLATE_GVA_VALIDATE_READ;
-    ret = translate_gva(cpu, gva, &gpa, flags);
-    if (ret < 0) {
-        error_report("failed to translate gva to gpa");
-        return -1;
-    }
-
-    ret = mshv_guest_mem_read(gpa, data, size, false, fetch_instruction);
-    if (ret < 0) {
-        error_report("failed to read from guest memory");
-        return -1;
-    }
-
-    return 0;
-}
-
-static int guest_mem_write_with_gva(const CPUState *cpu, uint64_t gva,
-                                    const uint8_t *data, uintptr_t size)
-{
-    int ret;
-    uint64_t gpa, flags;
-
-    flags = HV_TRANSLATE_GVA_VALIDATE_WRITE;
-    ret = translate_gva(cpu, gva, &gpa, flags);
-    if (ret < 0) {
-        error_report("failed to translate gva to gpa");
-        return -1;
-    }
-    ret = mshv_guest_mem_write(gpa, data, size, false);
-    if (ret < 0) {
-        error_report("failed to write to guest memory");
-        return -1;
-    }
-    return 0;
-}
-
-static void write_mem(CPUState *cpu, void *data, target_ulong addr, int bytes)
-{
-    if (guest_mem_write_with_gva(cpu, addr, data, bytes) < 0) {
-        error_report("failed to write memory");
-        abort();
-    }
-}
-
-static void fetch_instruction(CPUState *cpu, void *data,
-                              target_ulong addr, int bytes)
-{
-    if (guest_mem_read_with_gva(cpu, addr, data, bytes, true) < 0) {
-        error_report("failed to fetch instruction");
-        abort();
-    }
-}
-
-static void read_mem(CPUState *cpu, void *data, target_ulong addr, int bytes)
-{
-    if (guest_mem_read_with_gva(cpu, addr, data, bytes, false) < 0) {
-        error_report("failed to read memory");
-        abort();
-    }
-}
-
 static void read_segment_descriptor(CPUState *cpu,
                                     struct x86_segment_descriptor *desc,
                                     enum X86Seg seg_idx)
@@ -1634,9 +1566,6 @@ static void read_segment_descriptor(CPUState *cpu,
 }
 
 static const struct x86_emul_ops mshv_x86_emul_ops = {
-    .fetch_instruction = fetch_instruction,
-    .read_mem = read_mem,
-    .write_mem = write_mem,
     .read_segment_descriptor = read_segment_descriptor,
 };
 
diff --git a/target/i386/whpx/whpx-all.c b/target/i386/whpx/whpx-all.c
index ab583e922d4..561a48206ca 100644
--- a/target/i386/whpx/whpx-all.c
+++ b/target/i386/whpx/whpx-all.c
@@ -862,16 +862,6 @@ static int whpx_handle_portio(CPUState *cpu,
     return 0;
 }
 
-static void write_mem(CPUState *cpu, void *data, target_ulong addr, int bytes)
-{
-    vmx_write_mem(cpu, addr, data, bytes);
-}
-
-static void read_mem(CPUState *cpu, void *data, target_ulong addr, int bytes)
-{
-    vmx_read_mem(cpu, data, addr, bytes);
-}
-
 static void read_segment_descriptor(CPUState *cpu,
                                     struct x86_segment_descriptor *desc,
                                     enum X86Seg seg_idx)
@@ -891,8 +881,6 @@ static void read_segment_descriptor(CPUState *cpu,
 
 
 static const struct x86_emul_ops whpx_x86_emul_ops = {
-    .read_mem = read_mem,
-    .write_mem = write_mem,
     .read_segment_descriptor = read_segment_descriptor,
     .handle_io = handle_io
 };
-- 
2.53.0


