Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2006D58E7E
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Mar 2026 08:47:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vwytv-0003aO-E5; Mon, 02 Mar 2026 03:45:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vwyta-00026W-2H
 for qemu-devel@nongnu.org; Mon, 02 Mar 2026 03:44:56 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vwytX-0001cf-KN
 for qemu-devel@nongnu.org; Mon, 02 Mar 2026 03:44:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1772441090;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=6jP0wrr/WHTKUeZphGxDZz0G8W/sby2Vn9bBFERnTZc=;
 b=hU85r5Eff6zKSmxfo4u8dzrPdJNSB5WnCFyYnn3MF/lQw2GqChwh6a/bQCAHhzWp5CST+q
 /jPy8QAn7ro+mlKgH/itbskEracu1pKirf/2nPRMGG4WKGKVEWkx/VQyFWNHUeruCE4uqD
 woqqAI7r9fKiV/ekK3Kfxvn4pib0jlc=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-632-CYsQqbAFNCyDQyikXOehqw-1; Mon, 02 Mar 2026 03:44:49 -0500
X-MC-Unique: CYsQqbAFNCyDQyikXOehqw-1
X-Mimecast-MFC-AGG-ID: CYsQqbAFNCyDQyikXOehqw_1772441088
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-4836cf00787so48172995e9.1
 for <qemu-devel@nongnu.org>; Mon, 02 Mar 2026 00:44:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1772441087; x=1773045887; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6jP0wrr/WHTKUeZphGxDZz0G8W/sby2Vn9bBFERnTZc=;
 b=gfwhVrtn2Z7JBHn+CmDTl2BRHQPfY6beCl4RypusMa09+T8XHAjcp8yHFUJmxyXu0X
 dbJEaBg931r67HffTAw9Gi14atmoJtZrNH5m12166mo+YV6G2Nzs1mDr7KTP0JvRUbq/
 SzVX4W79JtSELFO66L8+JyPaZpx+WjqctHqoQY+joWVfdCONkhtcZWn51P7xrYAlGBj6
 k1zWonUGBjkvqIvQpXkrYgsA+Ars0PX3e1lhd5Zty+LsLPlB70N9KFjC6osBuF65Vg1Z
 GuzsglFchlgaEGl7ekC9cEusRrSWLOsoPr7vFe486/nGE8Y3o0OsRoZlZIXHYdBFjBM7
 3eHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772441087; x=1773045887;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=6jP0wrr/WHTKUeZphGxDZz0G8W/sby2Vn9bBFERnTZc=;
 b=axM4XvjIqZctQlhJzkmXvR1mNEVMlx3MslUpYNLfRL3MXNDvSiuKqcbUMA9YqYhX0f
 dYeWtspoE5H3jRtyJ0uyuF3i0uOFMObF0Yf/2CFxBS2P7W/wwH/VIeRPGsm3lfJskdua
 mqWh6gan/cT9hKDiWQKGvJfloDL6Q6FWVCJUA0WsoXcGNV3KGUAYdac/utyRS+hNzVYa
 7pC/D4GlMe90fZ5og+MGkMZFXuSlDUgaaG27aRvp14YAuc7Xd40BPehVHIuuNQDofROM
 dCa9ICcxiIrCsBr85gA9YPN+pHKdNqnBvOIgvdy5XmNDH+8sfmBK1Gpt7n1RJ9kcVmyH
 ASmg==
X-Gm-Message-State: AOJu0YwvdrY03dK2V+g/yV7nFL0xFvdKiMGDlzoG6vLWAbjfhR0Ivlsb
 BwRdlbbJW00z9bTI8qBr9WCgOt8EPQHTrFwcB9MIC1SFT0cMSJYVAsmVkotMZmIMWPsp45+/RRA
 tJ2gIEEkh5bOEweqtXoQvhSMyAFRuD6/ZAEC3203QZmfiApLF59vzRno7K8/8TcOe9aT8rhYe2d
 bn4zZxJGAlQQTZ6C0VFojhU3ACtqIMEZ3irU//kF1A
X-Gm-Gg: ATEYQzyhBQr1qJFsnRZUL2eLr3cRoSSPjCnv7YlqWmhx01KUNAZlW4lAcEG7CmKpXXQ
 PiDti5aC+BwQ+2GcVIw08kUl0dEKM9D4vK83Sd3IXq+34DllmBet87SH0Iwnn0h1ua5fPlagZVZ
 XqvAIVCoxsZfesEBJGKP9vPyXRLL63531uFAfUUUY5acg1Ks9mhybFceTV7t1/VOukwXO+2+4Zh
 k6Ip7ar2nOdrXF+F+9htsp7yobxyYPuW5ytqmrpFt4nVso1F7T1rzkEUXzrBwMWQxWBv4GPaeyQ
 2ZoPbWIemroUynrHntVkPxiqhM71bVWTEsrQhqyC9K/KnqPGth6PcJH3Bb27kvZsHn5XbLzj2r0
 fz3nPMiFNHtTqzc7B7ZT95m4O5ceWU6NFFM20mEpfJGvBffeGWcRwa9BXNhFJwuToQmcQ+6ynka
 TdGCTM5SBTN/m8MdbSCWeM1GStQIk=
X-Received: by 2002:a05:600c:608a:b0:47e:e2b8:66e6 with SMTP id
 5b1f17b1804b1-483c9934dd3mr205544795e9.14.1772441087216; 
 Mon, 02 Mar 2026 00:44:47 -0800 (PST)
X-Received: by 2002:a05:600c:608a:b0:47e:e2b8:66e6 with SMTP id
 5b1f17b1804b1-483c9934dd3mr205544395e9.14.1772441086704; 
 Mon, 02 Mar 2026 00:44:46 -0800 (PST)
Received: from [192.168.10.48] ([151.95.144.138])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-483c3b44207sm285275155e9.7.2026.03.02.00.44.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Mar 2026 00:44:44 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Mohamed Mediouni <mohamed@unpredictable.fr>
Subject: [PULL 025/102] target/i386: emulate: propagate memory errors on most
 reads/writes
Date: Mon,  2 Mar 2026 09:42:20 +0100
Message-ID: <20260302084338.473368-26-pbonzini@redhat.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260302084338.473368-1-pbonzini@redhat.com>
References: <20260302084338.473368-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.012, RCVD_IN_VALIDITY_RPBL_BLOCKED=1.188,
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

From: Mohamed Mediouni <mohamed@unpredictable.fr>

Use that to not bump RIP for those cases.

Warn on read/write from/to unmapped MMIO, but not consider that as an exception.
For reads, return 0xFF(s) as the register value in that case.

Leaves a coverage gap for read_val_ext(), to be handled in a later commit.

Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>
Link: https://lore.kernel.org/r/20260223233950.96076-25-mohamed@unpredictable.fr
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/emulate/x86_emu.c | 119 +++++++++++++++++++++++++---------
 1 file changed, 88 insertions(+), 31 deletions(-)

diff --git a/target/i386/emulate/x86_emu.c b/target/i386/emulate/x86_emu.c
index 3aedd638a10..ec6bc798a42 100644
--- a/target/i386/emulate/x86_emu.c
+++ b/target/i386/emulate/x86_emu.c
@@ -36,11 +36,14 @@
 /////////////////////////////////////////////////////////////////////////
 
 #include "qemu/osdep.h"
+#include "qemu/error-report.h"
 #include "panic.h"
 #include "x86_decode.h"
 #include "x86.h"
 #include "x86_emu.h"
 #include "x86_flags.h"
+#include "x86_mmu.h"
+
 
 #define EXEC_2OP_FLAGS_CMD(env, decode, cmd, FLAGS_FUNC, save_res) \
 {                                                       \
@@ -175,43 +178,56 @@ void write_val_ext(CPUX86State *env, struct x86_decode_op *decode, target_ulong
 
 uint8_t *read_mmio(CPUX86State *env, target_ulong ptr, int bytes)
 {
-    x86_read_mem(env_cpu(env), env->emu_mmio_buf, ptr, bytes);
+    MMUTranslateResult res = x86_read_mem(env_cpu(env), env->emu_mmio_buf, ptr, bytes);
+    if (res) {
+        if (res == MMU_TRANSLATE_GPA_UNMAPPED) {
+            memset(env->emu_mmio_buf, 0xFF, bytes);
+            return env->emu_mmio_buf;
+        }
+        return NULL;
+    }
     return env->emu_mmio_buf;
 }
 
 
-static target_ulong read_val_from_mem(CPUX86State *env, target_long ptr, int size)
+static bool read_val_from_mem(CPUX86State *env, target_long ptr, int size, target_ulong* val)
 {
-    target_ulong val;
     uint8_t *mmio_ptr;
 
     mmio_ptr = read_mmio(env, ptr, size);
+    if (mmio_ptr == NULL) {
+        return 1;
+    }
     switch (size) {
     case 1:
-        val = *(uint8_t *)mmio_ptr;
+        *val = *(uint8_t *)mmio_ptr;
         break;
     case 2:
-        val = *(uint16_t *)mmio_ptr;
+        *val = *(uint16_t *)mmio_ptr;
         break;
     case 4:
-        val = *(uint32_t *)mmio_ptr;
+        *val = *(uint32_t *)mmio_ptr;
         break;
     case 8:
-        val = *(uint64_t *)mmio_ptr;
+        *val = *(uint64_t *)mmio_ptr;
         break;
     default:
         VM_PANIC("bad size\n");
         break;
     }
-    return val;
+    return 0;
 }
 
 target_ulong read_val_ext(CPUX86State *env, struct x86_decode_op *decode, int size)
 {
+    target_ulong val;
     if (decode->type == X86_VAR_REG) {
         return read_val_from_reg(decode->regptr, size);
     } else {
-        return read_val_from_mem(env, decode->addr, size);
+        if (read_val_from_mem(env, decode->addr, size, &val)) {
+            error_report("target/i386/emulate: read_val_ext: reading from unmapped address.");
+        }
+        return val;
     }
 }
 
@@ -465,15 +481,17 @@ static inline int get_ZF(CPUX86State *env) {
     return env->cc_dst ? 0 : CC_Z;
 }
 
-static inline void string_rep(CPUX86State *env, struct x86_decode *decode,
-                              void (*func)(CPUX86State *env,
+static inline bool string_rep(CPUX86State *env, struct x86_decode *decode,
+                              bool (*func)(CPUX86State *env,
                                            struct x86_decode *ins), int rep)
 {
     target_ulong rcx = read_reg(env, R_ECX, decode->addressing_size);
 
     while (rcx != 0) {
         bool is_cmps_or_scas = decode->cmd == X86_DECODE_CMD_CMPS || decode->cmd == X86_DECODE_CMD_SCAS;
-        func(env, decode);
+        if (func(env, decode)) {
+            return 1;
+        }
         rcx--;
         write_reg(env, R_ECX, rcx, decode->addressing_size);
         if ((PREFIX_REP == rep) && !get_ZF(env) && is_cmps_or_scas) {
@@ -483,33 +501,44 @@ static inline void string_rep(CPUX86State *env, struct x86_decode *decode,
             break;
         }
     }
+    return 0;
 }
 
-static void exec_ins_single(CPUX86State *env, struct x86_decode *decode)
+static bool exec_ins_single(CPUX86State *env, struct x86_decode *decode)
 {
+    MMUTranslateResult res;
+
     target_ulong addr = linear_addr_size(env_cpu(env), RDI(env),
                                          decode->addressing_size, R_ES);
 
     emul_ops->handle_io(env_cpu(env), DX(env), env->emu_mmio_buf, 0,
                         decode->operand_size, 1);
-    x86_write_mem(env_cpu(env), env->emu_mmio_buf, addr,
+    res = x86_write_mem(env_cpu(env), env->emu_mmio_buf, addr,
                         decode->operand_size);
+    if (res) {
+        return 1;
+    }
 
     string_increment_reg(env, R_EDI, decode);
+    return 0;
 }
 
 static void exec_ins(CPUX86State *env, struct x86_decode *decode)
 {
+    bool res;
     if (decode->rep) {
-        string_rep(env, decode, exec_ins_single, 0);
+        res = string_rep(env, decode, exec_ins_single, 0);
     } else {
-        exec_ins_single(env, decode);
+        res = exec_ins_single(env, decode);
     }
 
+    if (res) {
+        return;
+    }
     env->eip += decode->len;
 }
 
-static void exec_outs_single(CPUX86State *env, struct x86_decode *decode)
+static bool exec_outs_single(CPUX86State *env, struct x86_decode *decode)
 {
     target_ulong addr = decode_linear_addr(env, decode, RSI(env), R_DS);
 
@@ -519,48 +548,64 @@ static void exec_outs_single(CPUX86State *env, struct x86_decode *decode)
                         decode->operand_size, 1);
 
     string_increment_reg(env, R_ESI, decode);
+    return 0;
 }
 
 static void exec_outs(CPUX86State *env, struct x86_decode *decode)
 {
+    bool res;
     if (decode->rep) {
-        string_rep(env, decode, exec_outs_single, 0);
+        res = string_rep(env, decode, exec_outs_single, 0);
     } else {
-        exec_outs_single(env, decode);
+        res = exec_outs_single(env, decode);
     }
 
+    if (res) {
+        return;
+    }
     env->eip += decode->len;
 }
 
-static void exec_movs_single(CPUX86State *env, struct x86_decode *decode)
+static bool exec_movs_single(CPUX86State *env, struct x86_decode *decode)
 {
     target_ulong src_addr;
     target_ulong dst_addr;
     target_ulong val;
+    MMUTranslateResult res;
 
     src_addr = decode_linear_addr(env, decode, RSI(env), R_DS);
     dst_addr = linear_addr_size(env_cpu(env), RDI(env),
                                 decode->addressing_size, R_ES);
 
-    val = read_val_from_mem(env, src_addr, decode->operand_size);
-    x86_write_mem(env_cpu(env), &val, dst_addr, decode->operand_size);
+    if (read_val_from_mem(env, src_addr, decode->operand_size, &val)) {
+        return 1;
+    }
+    res = x86_write_mem(env_cpu(env), &val, dst_addr, decode->operand_size);
+    if (res) {
+        return 1;
+    }
 
     string_increment_reg(env, R_ESI, decode);
     string_increment_reg(env, R_EDI, decode);
+    return 0;
 }
 
 static void exec_movs(CPUX86State *env, struct x86_decode *decode)
 {
+    bool res;
     if (decode->rep) {
-        string_rep(env, decode, exec_movs_single, 0);
+        res = string_rep(env, decode, exec_movs_single, 0);
     } else {
-        exec_movs_single(env, decode);
+        res = exec_movs_single(env, decode);
     }
 
+    if (res) {
+        return;
+    }
     env->eip += decode->len;
 }
 
-static void exec_cmps_single(CPUX86State *env, struct x86_decode *decode)
+static bool exec_cmps_single(CPUX86State *env, struct x86_decode *decode)
 {
     target_ulong src_addr;
     target_ulong dst_addr;
@@ -570,14 +615,19 @@ static void exec_cmps_single(CPUX86State *env, struct x86_decode *decode)
                                 decode->addressing_size, R_ES);
 
     decode->op[0].type = X86_VAR_IMMEDIATE;
-    decode->op[0].val = read_val_from_mem(env, src_addr, decode->operand_size);
+    if (read_val_from_mem(env, src_addr, decode->operand_size, &decode->op[0].val)) {
+        return 1;
+    }
     decode->op[1].type = X86_VAR_IMMEDIATE;
-    decode->op[1].val = read_val_from_mem(env, dst_addr, decode->operand_size);
+    if (read_val_from_mem(env, dst_addr, decode->operand_size, &decode->op[1].val)) {
+        return 1;
+    }
 
     EXEC_2OP_FLAGS_CMD(env, decode, -, SET_FLAGS_OSZAPC_SUB, false);
 
     string_increment_reg(env, R_ESI, decode);
     string_increment_reg(env, R_EDI, decode);
+    return 0;
 }
 
 static void exec_cmps(CPUX86State *env, struct x86_decode *decode)
@@ -591,17 +641,22 @@ static void exec_cmps(CPUX86State *env, struct x86_decode *decode)
 }
 
 
-static void exec_stos_single(CPUX86State *env, struct x86_decode *decode)
+static bool exec_stos_single(CPUX86State *env, struct x86_decode *decode)
 {
     target_ulong addr;
     target_ulong val;
+    MMUTranslateResult res;
 
     addr = linear_addr_size(env_cpu(env), RDI(env),
                             decode->addressing_size, R_ES);
     val = read_reg(env, R_EAX, decode->operand_size);
-    x86_write_mem(env_cpu(env), &val, addr, decode->operand_size);
+    res = x86_write_mem(env_cpu(env), &val, addr, decode->operand_size);
+    if (res) {
+        return 1;
+    }
 
     string_increment_reg(env, R_EDI, decode);
+    return 0;
 }
 
 
@@ -616,7 +671,7 @@ static void exec_stos(CPUX86State *env, struct x86_decode *decode)
     env->eip += decode->len;
 }
 
-static void exec_scas_single(CPUX86State *env, struct x86_decode *decode)
+static bool exec_scas_single(CPUX86State *env, struct x86_decode *decode)
 {
     target_ulong addr;
 
@@ -627,6 +682,7 @@ static void exec_scas_single(CPUX86State *env, struct x86_decode *decode)
 
     EXEC_2OP_FLAGS_CMD(env, decode, -, SET_FLAGS_OSZAPC_SUB, false);
     string_increment_reg(env, R_EDI, decode);
+    return 0;
 }
 
 static void exec_scas(CPUX86State *env, struct x86_decode *decode)
@@ -642,7 +698,7 @@ static void exec_scas(CPUX86State *env, struct x86_decode *decode)
     env->eip += decode->len;
 }
 
-static void exec_lods_single(CPUX86State *env, struct x86_decode *decode)
+static bool exec_lods_single(CPUX86State *env, struct x86_decode *decode)
 {
     target_ulong addr;
     target_ulong val = 0;
@@ -652,6 +708,7 @@ static void exec_lods_single(CPUX86State *env, struct x86_decode *decode)
     write_reg(env, R_EAX, val, decode->operand_size);
 
     string_increment_reg(env, R_ESI, decode);
+    return 0;
 }
 
 static void exec_lods(CPUX86State *env, struct x86_decode *decode)
-- 
2.53.0


