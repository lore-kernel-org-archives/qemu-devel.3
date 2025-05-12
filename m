Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F12FC3ABCB
	for <qemu-devel@archiver.kernel.org>; Mon, 12 May 2025 19:06:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uEYTo-0006QB-IU; Mon, 12 May 2025 15:06:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uEYTU-0005ad-HI
 for qemu-devel@nongnu.org; Mon, 12 May 2025 15:06:06 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uEYTQ-0007We-RK
 for qemu-devel@nongnu.org; Mon, 12 May 2025 15:06:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1747076760;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+0CN8dWb/jHGIrtBBwaI3tfyGWT/8HnKX9bNRoh/GrI=;
 b=T+xEjnJiFaywZmn/2f1SElur2hM4988ktw/f/0sR+eO9F4lAe61yOb3hRLriOxmGtvL6Jb
 gfUuvRWdnn6XV3KrY4obUq28gqHpft3CYSf4TyZbkfC/wMC40okjRbaf9h2HitaRS2TICG
 THJhWqUwzEeJxD32HHkCvrJocBfR7oo=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-3-CLqa3bnmPRKAv4hFEmfaZQ-1; Mon, 12 May 2025 15:05:57 -0400
X-MC-Unique: CLqa3bnmPRKAv4hFEmfaZQ-1
X-Mimecast-MFC-AGG-ID: CLqa3bnmPRKAv4hFEmfaZQ_1747076756
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-3a0af6219a5so2206598f8f.1
 for <qemu-devel@nongnu.org>; Mon, 12 May 2025 12:05:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747076755; x=1747681555;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+0CN8dWb/jHGIrtBBwaI3tfyGWT/8HnKX9bNRoh/GrI=;
 b=H6b7uf1arVDKkIdRnelAxu8//X/oYKJmodzGSU9UUjNxF49I67M8oSLnmU1SVNsMQ0
 mzhkOTgJ0bdE3Hh1s0+0BF6u2JA+9Ri3tknSrUjo4L5Gv+1eCWbV63YJEjrx1y31Ggyc
 Tv2A/9/J/IUE/LJGmPQwIiApLCNaRZSdry5MH4rsXOAplsiE+8fePsEHFRFOvgG43cZH
 cZUwUTliWEghgwUtzC/GWS3jKxtTKa8TOdnwPkzz2+/SokKUvcLKT9opP3gNiCuP8aFB
 yWrig8EdeeU3FznoTJ8m+fFSLQGRXMpIUDIoF47H8N8+OZvcymsM26KWnfpdmX+OaN9a
 BSJA==
X-Gm-Message-State: AOJu0YyFpRkJ52O5cwoBogWZw34+e+OFcONyIBBH5/o+JzBzKwWkRqoz
 BiCcJzITdkG8JxAsqXybnAnAj+HnWxs3engcSL5nPmJTeLOSYEbf3L75TuCrb8nXgLPXSwW+dj8
 jFKxZjCQ2ZtDPojepV0ygF0PQiiul4VNObXgjUzFqjgEBW+NRh3L4lYsbuz0AMBRPzL6YOAIcre
 BLr6ChV9pdtwFPBxs7olL2oBQwb3S1irua+R8P
X-Gm-Gg: ASbGncu/0lMjl7j++ZbGEz0/6/4P0++1tHF8Ndab71ZvcclJRBxXDTabLDRqjn8bOMU
 za7o/5oIxd6uWl4oqaBXE5TS75ool4R2euYtoC2pBB/xFJtyFI8ZTjMwQeNUsvf8XePTOsf/tOe
 g/WVddgLljoTONVd+Qfu3JAJH2e3u2dNIAay2se9iUxzfbKpn7y6KFA88smct4Y/XlW7a6veRSi
 kdZrrAmxOnyg6tfv/xPu1jT6deR33N6iISJEpTIZnc6RO3lFqFttvmTT+CWY+O9LbTwlevGLB/h
 cxw++kA3dGV2VUE=
X-Received: by 2002:a05:6000:250f:b0:3a1:1215:9bc with SMTP id
 ffacd0b85a97d-3a340d34583mr444923f8f.27.1747076755318; 
 Mon, 12 May 2025 12:05:55 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHCxZUFVgFVBNGKphGRx1rVx1B9teHi4Y5tmp2BN2S6wWEWOHtoTIKjM6OdN94zMGXQ0Liq2Q==
X-Received: by 2002:a05:6000:250f:b0:3a1:1215:9bc with SMTP id
 ffacd0b85a97d-3a340d34583mr444891f8f.27.1747076754443; 
 Mon, 12 May 2025 12:05:54 -0700 (PDT)
Received: from [192.168.122.1] ([151.95.45.141])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a1f57dde6bsm13563597f8f.13.2025.05.12.12.05.52
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 12 May 2025 12:05:54 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 11/16] target/i386/emulate: stop overloading decode->op[N].ptr
Date: Mon, 12 May 2025 21:05:19 +0200
Message-ID: <20250512190524.179419-12-pbonzini@redhat.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250512190524.179419-1-pbonzini@redhat.com>
References: <20250512190524.179419-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.551,
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

decode->op[N].ptr can contain either a host pointer (!) in CPUState
or a guest virtual address.  Pass the whole struct to read_val_ext
and write_val_ext, so that it can decide the contents based on the
operand type.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/emulate/x86_decode.h |   9 ++-
 target/i386/emulate/x86_emu.h    |   8 +--
 target/i386/emulate/x86_decode.c |  74 +++++++++----------
 target/i386/emulate/x86_emu.c    | 119 ++++++++++++++++---------------
 4 files changed, 109 insertions(+), 101 deletions(-)

diff --git a/target/i386/emulate/x86_decode.h b/target/i386/emulate/x86_decode.h
index 87cc728598d..927645af1a3 100644
--- a/target/i386/emulate/x86_decode.h
+++ b/target/i386/emulate/x86_decode.h
@@ -266,7 +266,10 @@ typedef struct x86_decode_op {
     int reg;
     target_ulong val;
 
-    target_ulong ptr;
+    union {
+        target_ulong addr;
+        void *regptr;
+    };
 } x86_decode_op;
 
 typedef struct x86_decode {
@@ -301,8 +304,8 @@ uint64_t sign(uint64_t val, int size);
 
 uint32_t decode_instruction(CPUX86State *env, struct x86_decode *decode);
 
-target_ulong get_reg_ref(CPUX86State *env, int reg, int rex_present,
-                         int is_extended, int size);
+void *get_reg_ref(CPUX86State *env, int reg, int rex_present,
+                  int is_extended, int size);
 target_ulong get_reg_val(CPUX86State *env, int reg, int rex_present,
                          int is_extended, int size);
 void calc_modrm_operand(CPUX86State *env, struct x86_decode *decode,
diff --git a/target/i386/emulate/x86_emu.h b/target/i386/emulate/x86_emu.h
index 555b567e2c7..a1a961284b2 100644
--- a/target/i386/emulate/x86_emu.h
+++ b/target/i386/emulate/x86_emu.h
@@ -42,11 +42,11 @@ void x86_emul_raise_exception(CPUX86State *env, int exception_index, int error_c
 
 target_ulong read_reg(CPUX86State *env, int reg, int size);
 void write_reg(CPUX86State *env, int reg, target_ulong val, int size);
-target_ulong read_val_from_reg(target_ulong reg_ptr, int size);
-void write_val_to_reg(target_ulong reg_ptr, target_ulong val, int size);
-void write_val_ext(CPUX86State *env, target_ulong ptr, target_ulong val, int size);
+target_ulong read_val_from_reg(void *reg_ptr, int size);
+void write_val_to_reg(void *reg_ptr, target_ulong val, int size);
+void write_val_ext(CPUX86State *env, struct x86_decode_op *decode, target_ulong val, int size);
 uint8_t *read_mmio(CPUX86State *env, target_ulong ptr, int bytes);
-target_ulong read_val_ext(CPUX86State *env, target_ulong ptr, int size);
+target_ulong read_val_ext(CPUX86State *env, struct x86_decode_op *decode, int size);
 
 void exec_movzx(CPUX86State *env, struct x86_decode *decode);
 void exec_shl(CPUX86State *env, struct x86_decode *decode);
diff --git a/target/i386/emulate/x86_decode.c b/target/i386/emulate/x86_decode.c
index 88be9479a82..2eca39802e3 100644
--- a/target/i386/emulate/x86_decode.c
+++ b/target/i386/emulate/x86_decode.c
@@ -109,8 +109,8 @@ static void decode_modrm_reg(CPUX86State *env, struct x86_decode *decode,
 {
     op->type = X86_VAR_REG;
     op->reg = decode->modrm.reg;
-    op->ptr = get_reg_ref(env, op->reg, decode->rex.rex, decode->rex.r,
-                          decode->operand_size);
+    op->regptr = get_reg_ref(env, op->reg, decode->rex.rex, decode->rex.r,
+                             decode->operand_size);
 }
 
 static void decode_rax(CPUX86State *env, struct x86_decode *decode,
@@ -119,8 +119,8 @@ static void decode_rax(CPUX86State *env, struct x86_decode *decode,
     op->type = X86_VAR_REG;
     op->reg = R_EAX;
     /* Since reg is always AX, REX prefix has no impact. */
-    op->ptr = get_reg_ref(env, op->reg, false, 0,
-                          decode->operand_size);
+    op->regptr = get_reg_ref(env, op->reg, false, 0,
+                             decode->operand_size);
 }
 
 static inline void decode_immediate(CPUX86State *env, struct x86_decode *decode,
@@ -262,16 +262,16 @@ static void decode_incgroup(CPUX86State *env, struct x86_decode *decode)
 {
     decode->op[0].type = X86_VAR_REG;
     decode->op[0].reg = decode->opcode[0] - 0x40;
-    decode->op[0].ptr = get_reg_ref(env, decode->op[0].reg, decode->rex.rex,
-                                    decode->rex.b, decode->operand_size);
+    decode->op[0].regptr = get_reg_ref(env, decode->op[0].reg, decode->rex.rex,
+                                       decode->rex.b, decode->operand_size);
 }
 
 static void decode_decgroup(CPUX86State *env, struct x86_decode *decode)
 {
     decode->op[0].type = X86_VAR_REG;
     decode->op[0].reg = decode->opcode[0] - 0x48;
-    decode->op[0].ptr = get_reg_ref(env, decode->op[0].reg, decode->rex.rex,
-                                    decode->rex.b, decode->operand_size);
+    decode->op[0].regptr = get_reg_ref(env, decode->op[0].reg, decode->rex.rex,
+                                       decode->rex.b, decode->operand_size);
 }
 
 static void decode_incgroup2(CPUX86State *env, struct x86_decode *decode)
@@ -287,16 +287,16 @@ static void decode_pushgroup(CPUX86State *env, struct x86_decode *decode)
 {
     decode->op[0].type = X86_VAR_REG;
     decode->op[0].reg = decode->opcode[0] - 0x50;
-    decode->op[0].ptr = get_reg_ref(env, decode->op[0].reg, decode->rex.rex,
-                                    decode->rex.b, decode->operand_size);
+    decode->op[0].regptr = get_reg_ref(env, decode->op[0].reg, decode->rex.rex,
+                                       decode->rex.b, decode->operand_size);
 }
 
 static void decode_popgroup(CPUX86State *env, struct x86_decode *decode)
 {
     decode->op[0].type = X86_VAR_REG;
     decode->op[0].reg = decode->opcode[0] - 0x58;
-    decode->op[0].ptr = get_reg_ref(env, decode->op[0].reg, decode->rex.rex,
-                                    decode->rex.b, decode->operand_size);
+    decode->op[0].regptr = get_reg_ref(env, decode->op[0].reg, decode->rex.rex,
+                                       decode->rex.b, decode->operand_size);
 }
 
 static void decode_jxx(CPUX86State *env, struct x86_decode *decode)
@@ -377,16 +377,16 @@ static void decode_xchgroup(CPUX86State *env, struct x86_decode *decode)
 {
     decode->op[0].type = X86_VAR_REG;
     decode->op[0].reg = decode->opcode[0] - 0x90;
-    decode->op[0].ptr = get_reg_ref(env, decode->op[0].reg, decode->rex.rex,
-                                    decode->rex.b, decode->operand_size);
+    decode->op[0].regptr = get_reg_ref(env, decode->op[0].reg, decode->rex.rex,
+                                       decode->rex.b, decode->operand_size);
 }
 
 static void decode_movgroup(CPUX86State *env, struct x86_decode *decode)
 {
     decode->op[0].type = X86_VAR_REG;
     decode->op[0].reg = decode->opcode[0] - 0xb8;
-    decode->op[0].ptr = get_reg_ref(env, decode->op[0].reg, decode->rex.rex,
-                                    decode->rex.b, decode->operand_size);
+    decode->op[0].regptr = get_reg_ref(env, decode->op[0].reg, decode->rex.rex,
+                                       decode->rex.b, decode->operand_size);
     decode_immediate(env, decode, &decode->op[1], decode->operand_size);
 }
 
@@ -394,15 +394,15 @@ static void fetch_moffs(CPUX86State *env, struct x86_decode *decode,
                         struct x86_decode_op *op)
 {
     op->type = X86_VAR_OFFSET;
-    op->ptr = decode_bytes(env, decode, decode->addressing_size);
+    op->addr = decode_bytes(env, decode, decode->addressing_size);
 }
 
 static void decode_movgroup8(CPUX86State *env, struct x86_decode *decode)
 {
     decode->op[0].type = X86_VAR_REG;
     decode->op[0].reg = decode->opcode[0] - 0xb0;
-    decode->op[0].ptr = get_reg_ref(env, decode->op[0].reg, decode->rex.rex,
-                                    decode->rex.b, decode->operand_size);
+    decode->op[0].regptr = get_reg_ref(env, decode->op[0].reg, decode->rex.rex,
+                                       decode->rex.b, decode->operand_size);
     decode_immediate(env, decode, &decode->op[1], decode->operand_size);
 }
 
@@ -411,8 +411,8 @@ static void decode_rcx(CPUX86State *env, struct x86_decode *decode,
 {
     op->type = X86_VAR_REG;
     op->reg = R_ECX;
-    op->ptr = get_reg_ref(env, op->reg, decode->rex.rex, decode->rex.b,
-                          decode->operand_size);
+    op->regptr = get_reg_ref(env, op->reg, decode->rex.rex, decode->rex.b,
+                             decode->operand_size);
 }
 
 struct decode_tbl {
@@ -631,8 +631,8 @@ static void decode_bswap(CPUX86State *env, struct x86_decode *decode)
 {
     decode->op[0].type = X86_VAR_REG;
     decode->op[0].reg = decode->opcode[1] - 0xc8;
-    decode->op[0].ptr = get_reg_ref(env, decode->op[0].reg, decode->rex.rex,
-                                    decode->rex.b, decode->operand_size);
+    decode->op[0].regptr = get_reg_ref(env, decode->op[0].reg, decode->rex.rex,
+                                       decode->rex.b, decode->operand_size);
 }
 
 static void decode_d9_4(CPUX86State *env, struct x86_decode *decode)
@@ -1656,16 +1656,16 @@ void calc_modrm_operand16(CPUX86State *env, struct x86_decode *decode,
     }
 calc_addr:
     if (X86_DECODE_CMD_LEA == decode->cmd) {
-        op->ptr = (uint16_t)ptr;
+        op->addr = (uint16_t)ptr;
     } else {
-        op->ptr = decode_linear_addr(env, decode, (uint16_t)ptr, seg);
+        op->addr = decode_linear_addr(env, decode, (uint16_t)ptr, seg);
     }
 }
 
-target_ulong get_reg_ref(CPUX86State *env, int reg, int rex_present,
+void *get_reg_ref(CPUX86State *env, int reg, int rex_present,
                          int is_extended, int size)
 {
-    target_ulong ptr = 0;
+    void *ptr = NULL;
 
     if (is_extended) {
         reg |= R_R8;
@@ -1674,13 +1674,13 @@ target_ulong get_reg_ref(CPUX86State *env, int reg, int rex_present,
     switch (size) {
     case 1:
         if (is_extended || reg < 4 || rex_present) {
-            ptr = (target_ulong)&RL(env, reg);
+            ptr = &RL(env, reg);
         } else {
-            ptr = (target_ulong)&RH(env, reg - 4);
+            ptr = &RH(env, reg - 4);
         }
         break;
     default:
-        ptr = (target_ulong)&RRX(env, reg);
+        ptr = &RRX(env, reg);
         break;
     }
     return ptr;
@@ -1691,7 +1691,7 @@ target_ulong get_reg_val(CPUX86State *env, int reg, int rex_present,
 {
     target_ulong val = 0;
     memcpy(&val,
-           (void *)get_reg_ref(env, reg, rex_present, is_extended, size),
+           get_reg_ref(env, reg, rex_present, is_extended, size),
            size);
     return val;
 }
@@ -1758,9 +1758,9 @@ void calc_modrm_operand32(CPUX86State *env, struct x86_decode *decode,
     }
 
     if (X86_DECODE_CMD_LEA == decode->cmd) {
-        op->ptr = (uint32_t)ptr;
+        op->addr = (uint32_t)ptr;
     } else {
-        op->ptr = decode_linear_addr(env, decode, (uint32_t)ptr, seg);
+        op->addr = decode_linear_addr(env, decode, (uint32_t)ptr, seg);
     }
 }
 
@@ -1788,9 +1788,9 @@ void calc_modrm_operand64(CPUX86State *env, struct x86_decode *decode,
     }
 
     if (X86_DECODE_CMD_LEA == decode->cmd) {
-        op->ptr = ptr;
+        op->addr = ptr;
     } else {
-        op->ptr = decode_linear_addr(env, decode, ptr, seg);
+        op->addr = decode_linear_addr(env, decode, ptr, seg);
     }
 }
 
@@ -1801,8 +1801,8 @@ void calc_modrm_operand(CPUX86State *env, struct x86_decode *decode,
     if (3 == decode->modrm.mod) {
         op->reg = decode->modrm.reg;
         op->type = X86_VAR_REG;
-        op->ptr = get_reg_ref(env, decode->modrm.rm, decode->rex.rex,
-                              decode->rex.b, decode->operand_size);
+        op->regptr = get_reg_ref(env, decode->modrm.rm, decode->rex.rex,
+                                 decode->rex.b, decode->operand_size);
         return;
     }
 
diff --git a/target/i386/emulate/x86_emu.c b/target/i386/emulate/x86_emu.c
index 7773b51b95e..4c07f08942e 100644
--- a/target/i386/emulate/x86_emu.c
+++ b/target/i386/emulate/x86_emu.c
@@ -52,7 +52,7 @@
         uint8_t v2 = (uint8_t)decode->op[1].val;    \
         uint8_t diff = v1 cmd v2;                   \
         if (save_res) {                              \
-            write_val_ext(env, decode->op[0].ptr, diff, 1);  \
+            write_val_ext(env, &decode->op[0], diff, 1);  \
         } \
         FLAGS_FUNC##8(env, v1, v2, diff);           \
         break;                                      \
@@ -63,7 +63,7 @@
         uint16_t v2 = (uint16_t)decode->op[1].val;  \
         uint16_t diff = v1 cmd v2;                  \
         if (save_res) {                              \
-            write_val_ext(env, decode->op[0].ptr, diff, 2); \
+            write_val_ext(env, &decode->op[0], diff, 2); \
         } \
         FLAGS_FUNC##16(env, v1, v2, diff);          \
         break;                                      \
@@ -74,7 +74,7 @@
         uint32_t v2 = (uint32_t)decode->op[1].val;  \
         uint32_t diff = v1 cmd v2;                  \
         if (save_res) {                              \
-            write_val_ext(env, decode->op[0].ptr, diff, 4); \
+            write_val_ext(env, &decode->op[0], diff, 4); \
         } \
         FLAGS_FUNC##32(env, v1, v2, diff);          \
         break;                                      \
@@ -121,7 +121,7 @@ void write_reg(CPUX86State *env, int reg, target_ulong val, int size)
     }
 }
 
-target_ulong read_val_from_reg(target_ulong reg_ptr, int size)
+target_ulong read_val_from_reg(void *reg_ptr, int size)
 {
     target_ulong val;
     
@@ -144,7 +144,7 @@ target_ulong read_val_from_reg(target_ulong reg_ptr, int size)
     return val;
 }
 
-void write_val_to_reg(target_ulong reg_ptr, target_ulong val, int size)
+void write_val_to_reg(void *reg_ptr, target_ulong val, int size)
 {
     switch (size) {
     case 1:
@@ -164,18 +164,18 @@ void write_val_to_reg(target_ulong reg_ptr, target_ulong val, int size)
     }
 }
 
-static bool is_host_reg(CPUX86State *env, target_ulong ptr)
+static void write_val_to_mem(CPUX86State *env, target_ulong ptr, target_ulong val, int size)
 {
-    return (ptr - (target_ulong)&env->regs[0]) < sizeof(env->regs);
+    emul_ops->write_mem(env_cpu(env), &val, ptr, size);
 }
 
-void write_val_ext(CPUX86State *env, target_ulong ptr, target_ulong val, int size)
+void write_val_ext(CPUX86State *env, struct x86_decode_op *decode, target_ulong val, int size)
 {
-    if (is_host_reg(env, ptr)) {
-        write_val_to_reg(ptr, val, size);
-        return;
+    if (decode->type == X86_VAR_REG) {
+        write_val_to_reg(decode->regptr, val, size);
+    } else {
+        write_val_to_mem(env, decode->addr, val, size);
     }
-    emul_ops->write_mem(env_cpu(env), &val, ptr, size);
 }
 
 uint8_t *read_mmio(CPUX86State *env, target_ulong ptr, int bytes)
@@ -185,15 +185,11 @@ uint8_t *read_mmio(CPUX86State *env, target_ulong ptr, int bytes)
 }
 
 
-target_ulong read_val_ext(CPUX86State *env, target_ulong ptr, int size)
+static target_ulong read_val_from_mem(CPUX86State *env, target_long ptr, int size)
 {
     target_ulong val;
     uint8_t *mmio_ptr;
 
-    if (is_host_reg(env, ptr)) {
-        return read_val_from_reg(ptr, size);
-    }
-
     mmio_ptr = read_mmio(env, ptr, size);
     switch (size) {
     case 1:
@@ -215,6 +211,15 @@ target_ulong read_val_ext(CPUX86State *env, target_ulong ptr, int size)
     return val;
 }
 
+target_ulong read_val_ext(CPUX86State *env, struct x86_decode_op *decode, int size)
+{
+    if (decode->type == X86_VAR_REG) {
+        return read_val_from_reg(decode->regptr, size);
+    } else {
+        return read_val_from_mem(env, decode->addr, size);
+    }
+}
+
 static void fetch_operands(CPUX86State *env, struct x86_decode *decode,
                            int n, bool val_op0, bool val_op1, bool val_op2)
 {
@@ -226,25 +231,25 @@ static void fetch_operands(CPUX86State *env, struct x86_decode *decode,
         case X86_VAR_IMMEDIATE:
             break;
         case X86_VAR_REG:
-            VM_PANIC_ON(!decode->op[i].ptr);
+            VM_PANIC_ON(!decode->op[i].regptr);
             if (calc_val[i]) {
-                decode->op[i].val = read_val_from_reg(decode->op[i].ptr,
+                decode->op[i].val = read_val_from_reg(decode->op[i].regptr,
                                                       decode->operand_size);
             }
             break;
         case X86_VAR_RM:
             calc_modrm_operand(env, decode, &decode->op[i]);
             if (calc_val[i]) {
-                decode->op[i].val = read_val_ext(env, decode->op[i].ptr,
+                decode->op[i].val = read_val_ext(env, &decode->op[i],
                                                  decode->operand_size);
             }
             break;
         case X86_VAR_OFFSET:
-            decode->op[i].ptr = decode_linear_addr(env, decode,
-                                                   decode->op[i].ptr,
-                                                   R_DS);
+            decode->op[i].addr = decode_linear_addr(env, decode,
+                                                    decode->op[i].addr,
+                                                    R_DS);
             if (calc_val[i]) {
-                decode->op[i].val = read_val_ext(env, decode->op[i].ptr,
+                decode->op[i].val = read_val_ext(env, &decode->op[i],
                                                  decode->operand_size);
             }
             break;
@@ -257,7 +262,7 @@ static void fetch_operands(CPUX86State *env, struct x86_decode *decode,
 static void exec_mov(CPUX86State *env, struct x86_decode *decode)
 {
     fetch_operands(env, decode, 2, false, true, false);
-    write_val_ext(env, decode->op[0].ptr, decode->op[1].val,
+    write_val_ext(env, &decode->op[0], decode->op[1].val,
                   decode->operand_size);
 
     env->eip += decode->len;
@@ -312,7 +317,7 @@ static void exec_neg(CPUX86State *env, struct x86_decode *decode)
     fetch_operands(env, decode, 2, true, true, false);
 
     val = 0 - sign(decode->op[1].val, decode->operand_size);
-    write_val_ext(env, decode->op[1].ptr, val, decode->operand_size);
+    write_val_ext(env, &decode->op[1], val, decode->operand_size);
 
     if (4 == decode->operand_size) {
         SET_FLAGS_OSZAPC_SUB32(env, 0, 0 - val, val);
@@ -363,7 +368,7 @@ static void exec_not(CPUX86State *env, struct x86_decode *decode)
 {
     fetch_operands(env, decode, 1, true, false, false);
 
-    write_val_ext(env, decode->op[0].ptr, ~decode->op[0].val,
+    write_val_ext(env, &decode->op[0], ~decode->op[0].val,
                   decode->operand_size);
     env->eip += decode->len;
 }
@@ -382,8 +387,8 @@ void exec_movzx(CPUX86State *env, struct x86_decode *decode)
     }
     decode->operand_size = src_op_size;
     calc_modrm_operand(env, decode, &decode->op[1]);
-    decode->op[1].val = read_val_ext(env, decode->op[1].ptr, src_op_size);
-    write_val_ext(env, decode->op[0].ptr, decode->op[1].val, op_size);
+    decode->op[1].val = read_val_ext(env, &decode->op[1], src_op_size);
+    write_val_ext(env, &decode->op[0], decode->op[1].val, op_size);
 
     env->eip += decode->len;
 }
@@ -535,8 +540,8 @@ static void exec_movs_single(CPUX86State *env, struct x86_decode *decode)
     dst_addr = linear_addr_size(env_cpu(env), RDI(env),
                                 decode->addressing_size, R_ES);
 
-    val = read_val_ext(env, src_addr, decode->operand_size);
-    write_val_ext(env, dst_addr, val, decode->operand_size);
+    val = read_val_from_mem(env, src_addr, decode->operand_size);
+    write_val_to_mem(env, dst_addr, val, decode->operand_size);
 
     string_increment_reg(env, R_ESI, decode);
     string_increment_reg(env, R_EDI, decode);
@@ -563,9 +568,9 @@ static void exec_cmps_single(CPUX86State *env, struct x86_decode *decode)
                                 decode->addressing_size, R_ES);
 
     decode->op[0].type = X86_VAR_IMMEDIATE;
-    decode->op[0].val = read_val_ext(env, src_addr, decode->operand_size);
+    decode->op[0].val = read_val_from_mem(env, src_addr, decode->operand_size);
     decode->op[1].type = X86_VAR_IMMEDIATE;
-    decode->op[1].val = read_val_ext(env, dst_addr, decode->operand_size);
+    decode->op[1].val = read_val_from_mem(env, dst_addr, decode->operand_size);
 
     EXEC_2OP_FLAGS_CMD(env, decode, -, SET_FLAGS_OSZAPC_SUB, false);
 
@@ -697,15 +702,15 @@ static void do_bt(CPUX86State *env, struct x86_decode *decode, int flag)
     if (decode->op[0].type != X86_VAR_REG) {
         if (4 == decode->operand_size) {
             displacement = ((int32_t) (decode->op[1].val & 0xffffffe0)) / 32;
-            decode->op[0].ptr += 4 * displacement;
+            decode->op[0].addr += 4 * displacement;
         } else if (2 == decode->operand_size) {
             displacement = ((int16_t) (decode->op[1].val & 0xfff0)) / 16;
-            decode->op[0].ptr += 2 * displacement;
+            decode->op[0].addr += 2 * displacement;
         } else {
             VM_PANIC("bt 64bit\n");
         }
     }
-    decode->op[0].val = read_val_ext(env, decode->op[0].ptr,
+    decode->op[0].val = read_val_ext(env, &decode->op[0],
                                      decode->operand_size);
     cf = (decode->op[0].val >> index) & 0x01;
 
@@ -723,7 +728,7 @@ static void do_bt(CPUX86State *env, struct x86_decode *decode, int flag)
         decode->op[0].val &= ~(1u << index);
         break;
     }
-    write_val_ext(env, decode->op[0].ptr, decode->op[0].val,
+    write_val_ext(env, &decode->op[0], decode->op[0].val,
                   decode->operand_size);
     set_CF(env, cf);
 }
@@ -775,7 +780,7 @@ void exec_shl(CPUX86State *env, struct x86_decode *decode)
             of = cf ^ (res >> 7);
         }
 
-        write_val_ext(env, decode->op[0].ptr, res, 1);
+        write_val_ext(env, &decode->op[0], res, 1);
         SET_FLAGS_OSZAPC_LOGIC8(env, 0, 0, res);
         SET_FLAGS_OxxxxC(env, of, cf);
         break;
@@ -791,7 +796,7 @@ void exec_shl(CPUX86State *env, struct x86_decode *decode)
             of = cf ^ (res >> 15); /* of = cf ^ result15 */
         }
 
-        write_val_ext(env, decode->op[0].ptr, res, 2);
+        write_val_ext(env, &decode->op[0], res, 2);
         SET_FLAGS_OSZAPC_LOGIC16(env, 0, 0, res);
         SET_FLAGS_OxxxxC(env, of, cf);
         break;
@@ -800,7 +805,7 @@ void exec_shl(CPUX86State *env, struct x86_decode *decode)
     {
         uint32_t res = decode->op[0].val << count;
 
-        write_val_ext(env, decode->op[0].ptr, res, 4);
+        write_val_ext(env, &decode->op[0], res, 4);
         SET_FLAGS_OSZAPC_LOGIC32(env, 0, 0, res);
         cf = (decode->op[0].val >> (32 - count)) & 0x1;
         of = cf ^ (res >> 31); /* of = cf ^ result31 */
@@ -831,10 +836,10 @@ void exec_movsx(CPUX86State *env, struct x86_decode *decode)
 
     decode->operand_size = src_op_size;
     calc_modrm_operand(env, decode, &decode->op[1]);
-    decode->op[1].val = sign(read_val_ext(env, decode->op[1].ptr, src_op_size),
+    decode->op[1].val = sign(read_val_ext(env, &decode->op[1], src_op_size),
                              src_op_size);
 
-    write_val_ext(env, decode->op[0].ptr, decode->op[1].val, op_size);
+    write_val_ext(env, &decode->op[0], decode->op[1].val, op_size);
 
     env->eip += decode->len;
 }
@@ -862,7 +867,7 @@ void exec_ror(CPUX86State *env, struct x86_decode *decode)
             count &= 0x7; /* use only bottom 3 bits */
             res = ((uint8_t)decode->op[0].val >> count) |
                    ((uint8_t)decode->op[0].val << (8 - count));
-            write_val_ext(env, decode->op[0].ptr, res, 1);
+            write_val_ext(env, &decode->op[0], res, 1);
             bit6 = (res >> 6) & 1;
             bit7 = (res >> 7) & 1;
             /* set eflags: ROR count affects the following flags: C, O */
@@ -886,7 +891,7 @@ void exec_ror(CPUX86State *env, struct x86_decode *decode)
             count &= 0x0f;  /* use only 4 LSB's */
             res = ((uint16_t)decode->op[0].val >> count) |
                    ((uint16_t)decode->op[0].val << (16 - count));
-            write_val_ext(env, decode->op[0].ptr, res, 2);
+            write_val_ext(env, &decode->op[0], res, 2);
 
             bit14 = (res >> 14) & 1;
             bit15 = (res >> 15) & 1;
@@ -904,7 +909,7 @@ void exec_ror(CPUX86State *env, struct x86_decode *decode)
         if (count) {
             res = ((uint32_t)decode->op[0].val >> count) |
                    ((uint32_t)decode->op[0].val << (32 - count));
-            write_val_ext(env, decode->op[0].ptr, res, 4);
+            write_val_ext(env, &decode->op[0], res, 4);
 
             bit31 = (res >> 31) & 1;
             bit30 = (res >> 30) & 1;
@@ -941,7 +946,7 @@ void exec_rol(CPUX86State *env, struct x86_decode *decode)
             res = ((uint8_t)decode->op[0].val << count) |
                    ((uint8_t)decode->op[0].val >> (8 - count));
 
-            write_val_ext(env, decode->op[0].ptr, res, 1);
+            write_val_ext(env, &decode->op[0], res, 1);
             /* set eflags:
              * ROL count affects the following flags: C, O
              */
@@ -968,7 +973,7 @@ void exec_rol(CPUX86State *env, struct x86_decode *decode)
             res = ((uint16_t)decode->op[0].val << count) |
                    ((uint16_t)decode->op[0].val >> (16 - count));
 
-            write_val_ext(env, decode->op[0].ptr, res, 2);
+            write_val_ext(env, &decode->op[0], res, 2);
             bit0  = (res & 0x1);
             bit15 = (res >> 15);
             /* of = cf ^ result15 */
@@ -986,7 +991,7 @@ void exec_rol(CPUX86State *env, struct x86_decode *decode)
             res = ((uint32_t)decode->op[0].val << count) |
                    ((uint32_t)decode->op[0].val >> (32 - count));
 
-            write_val_ext(env, decode->op[0].ptr, res, 4);
+            write_val_ext(env, &decode->op[0], res, 4);
             bit0  = (res & 0x1);
             bit31 = (res >> 31);
             /* of = cf ^ result31 */
@@ -1024,7 +1029,7 @@ void exec_rcl(CPUX86State *env, struct x86_decode *decode)
                    (op1_8 >> (9 - count));
         }
 
-        write_val_ext(env, decode->op[0].ptr, res, 1);
+        write_val_ext(env, &decode->op[0], res, 1);
 
         cf = (op1_8 >> (8 - count)) & 0x01;
         of = cf ^ (res >> 7); /* of = cf ^ result7 */
@@ -1050,7 +1055,7 @@ void exec_rcl(CPUX86State *env, struct x86_decode *decode)
                    (op1_16 >> (17 - count));
         }
 
-        write_val_ext(env, decode->op[0].ptr, res, 2);
+        write_val_ext(env, &decode->op[0], res, 2);
 
         cf = (op1_16 >> (16 - count)) & 0x1;
         of = cf ^ (res >> 15); /* of = cf ^ result15 */
@@ -1073,7 +1078,7 @@ void exec_rcl(CPUX86State *env, struct x86_decode *decode)
                    (op1_32 >> (33 - count));
         }
 
-        write_val_ext(env, decode->op[0].ptr, res, 4);
+        write_val_ext(env, &decode->op[0], res, 4);
 
         cf = (op1_32 >> (32 - count)) & 0x1;
         of = cf ^ (res >> 31); /* of = cf ^ result31 */
@@ -1105,7 +1110,7 @@ void exec_rcr(CPUX86State *env, struct x86_decode *decode)
         res = (op1_8 >> count) | (get_CF(env) << (8 - count)) |
                (op1_8 << (9 - count));
 
-        write_val_ext(env, decode->op[0].ptr, res, 1);
+        write_val_ext(env, &decode->op[0], res, 1);
 
         cf = (op1_8 >> (count - 1)) & 0x1;
         of = (((res << 1) ^ res) >> 7) & 0x1; /* of = result6 ^ result7 */
@@ -1124,7 +1129,7 @@ void exec_rcr(CPUX86State *env, struct x86_decode *decode)
         res = (op1_16 >> count) | (get_CF(env) << (16 - count)) |
                (op1_16 << (17 - count));
 
-        write_val_ext(env, decode->op[0].ptr, res, 2);
+        write_val_ext(env, &decode->op[0], res, 2);
 
         cf = (op1_16 >> (count - 1)) & 0x1;
         of = ((uint16_t)((res << 1) ^ res) >> 15) & 0x1; /* of = result15 ^
@@ -1148,7 +1153,7 @@ void exec_rcr(CPUX86State *env, struct x86_decode *decode)
                    (op1_32 << (33 - count));
         }
 
-        write_val_ext(env, decode->op[0].ptr, res, 4);
+        write_val_ext(env, &decode->op[0], res, 4);
 
         cf = (op1_32 >> (count - 1)) & 0x1;
         of = ((res << 1) ^ res) >> 31; /* of = result30 ^ result31 */
@@ -1163,9 +1168,9 @@ static void exec_xchg(CPUX86State *env, struct x86_decode *decode)
 {
     fetch_operands(env, decode, 2, true, true, false);
 
-    write_val_ext(env, decode->op[0].ptr, decode->op[1].val,
+    write_val_ext(env, &decode->op[0], decode->op[1].val,
                   decode->operand_size);
-    write_val_ext(env, decode->op[1].ptr, decode->op[0].val,
+    write_val_ext(env, &decode->op[1], decode->op[0].val,
                   decode->operand_size);
 
     env->eip += decode->len;
@@ -1174,7 +1179,7 @@ static void exec_xchg(CPUX86State *env, struct x86_decode *decode)
 static void exec_xadd(CPUX86State *env, struct x86_decode *decode)
 {
     EXEC_2OP_FLAGS_CMD(env, decode, +, SET_FLAGS_OSZAPC_ADD, true);
-    write_val_ext(env, decode->op[1].ptr, decode->op[0].val,
+    write_val_ext(env, &decode->op[1], decode->op[0].val,
                   decode->operand_size);
 
     env->eip += decode->len;
-- 
2.49.0


