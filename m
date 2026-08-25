Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8B22C61DC2
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2026 12:30:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wyqI7-0004nT-Bo; Tue, 25 Aug 2026 08:30:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1wyqI5-0004nI-1D
 for qemu-devel@nongnu.org; Tue, 25 Aug 2026 08:30:09 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1wyqI1-0000g2-Pq
 for qemu-devel@nongnu.org; Tue, 25 Aug 2026 08:30:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1787661005;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5+a5NByR0gcOWXf7SZHpnI5L14NFq3+9KEiaUFOcp3I=;
 b=bMPOi3seC16TYVX4R/hAVu+NJUiydY5lh21Z6rb1ivcMJkJBnbxQ/NrULCL8KLsigBgA/8
 /TpuMEd68APUYcGhvHgdQsebQOLzUJbD2Sw81WqZEdfrTvoPhkNU6b9jS+9HLa7u4q3jf/
 ghgZ6CNb62MWxe0NQLdq5lSFymRDutw=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-400-vsg5hEh0P7uBwJ4hoP4FSw-1; Tue, 25 Aug 2026 08:30:02 -0400
X-MC-Unique: vsg5hEh0P7uBwJ4hoP4FSw-1
X-Mimecast-MFC-AGG-ID: vsg5hEh0P7uBwJ4hoP4FSw_1787661001
Received: by mail-ed1-f72.google.com with SMTP id
 4fb4d7f45d1cf-69e70c286ecso4770511a12.0
 for <qemu-devel@nongnu.org>; Tue, 25 Aug 2026 05:30:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1787661001; x=1788265801; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=5+a5NByR0gcOWXf7SZHpnI5L14NFq3+9KEiaUFOcp3I=;
 b=oWa6R8UUIid3CJpu3KvqqTwTrpcSq4lMXLvy0Gyvc8LzNlu/pMpRzErA54I4ml4cyo
 koFJJnqJ1KOjkI9kctL0+WZzjphFEwn6hXtX7NNQ+UoWlsrECggcf3KpRQ4SEwJ4fKX5
 +/fTASOOe9Wh4Bn0gTL8zZyz/sSR8M6HKr2PdXcQnBMBG5Xov8Xbhyj38LdVkLTXXTRd
 oJxAuBj5X+beYFhNSTQ4pj1cbaeGRiQVaDMy1kh0HRLlvcQPj6z323vS3s5iRu8T9Ylh
 jzHlRgAkzfUIOq6GOMHAsQT9TKw+X/be9udSY31FOluiaUFafI8jEqFB6ZOOIPruzpdl
 xQ0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787661001; x=1788265801;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=5+a5NByR0gcOWXf7SZHpnI5L14NFq3+9KEiaUFOcp3I=;
 b=fo2gSXneSiMmaULvg3tDwuAeWmjjRUXZ4c0U8c1yugGoWVYGjPtJWmgUM2n9GiKoYI
 fb/8lrX6FVC81vlDbwJfuMVMcumGt79hJ0YS6zyxFQ3xEvrH5ujfd1k0k9teDWhL7/FR
 V8skUYwGFaAeh3qk2tM4B0ZNRyA7H1KXfqU79Sa5O8BvMC+nx/DJ/04GBel8SgKcFB00
 RDAZxQy8ZmFZzDyaFFrRzy5AevTg5FQPur+ZLKMGU3D2+JVlPPe//VLKQedSAiB+yqzn
 7VpMnQLoEoIk9ahxtU5Fyytl7XqBLEBtZYmWXT9zKaWwxNvNTwijwLGQpdTuQqr+DnC7
 jJcw==
X-Gm-Message-State: AFuF++lQEcY6gr1sH3jaVCKp2EM23PmNeEwQxS1+zvu3P4g0riadj55D
 1u3hogcco5evjLEMINtEYkvWrEAuj2lZVjv44lT7P1bCLxX7/dzrXIl09IFFBuZgyTOVoPwNzyQ
 qmpgcL6tGnZIW9ehvRWZaAbitcSO0hGtnIhQdf1UNNEuT0J4YRgIMYmoZJjg13PH7FimpsPIyWC
 1raSs+w7HX6qqH3p6XgBEbtWtHNSPheyA/6tRwh1np
X-Gm-Gg: AR+sD11aQ8h8QpkSsSb4A7L/J76+wLrvvjuyXHB8ESt6z3Jy3bGBDVKuuMbq6GGCx+E
 Dr7zO2l1UeeDI7n3fUQWKh3nlpHHkKFuN7wpCBvJybb7CoirEUM5H9HSw3enqPV2l3wpyqH4Znd
 aQT/TSpaA0lQrHusfx5JK3KMn+k/yIjznNNMh6ksPHOBgiL912QR4QMyT2gPXSj1WRzARKI59/5
 3afrGrkI/Q5ffJ5zcoSNqMpqXYqInugdRLC2pF1P4KMbkhSBMvYfem2zdNnOD4AvnkoF72IxbjU
 pO1t0IdELRzNEtG1d6IwORdM4UaPfUk3ssVrP8gNcYHLZmMc6WJdZn/q2/WRiTg3ntsgA4ejMDl
 2hq8cDk1gMoZZ6opaxDeOoAe0Nvv0MDfe7HSSfibv3Fod17gLNEMZzdfmKvofJGj2nbvTm5L/zZ
 KAuKo=
X-Received: by 2002:a05:6402:3714:b0:6a1:28d8:2306 with SMTP id
 4fb4d7f45d1cf-6a5c40d8c55mr8095233a12.1.1787661001189; 
 Tue, 25 Aug 2026 05:30:01 -0700 (PDT)
X-Received: by 2002:a05:6402:3714:b0:6a1:28d8:2306 with SMTP id
 4fb4d7f45d1cf-6a5c40d8c55mr8095112a12.1.1787661000581; 
 Tue, 25 Aug 2026 05:30:00 -0700 (PDT)
Received: from [192.168.10.48] ([151.95.34.92])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-6a5d9824be1sm671820a12.7.2026.08.25.05.29.58
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 25 Aug 2026 05:29:58 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 16/20] target/i386/tcg: add decode functionality for APX
Date: Tue, 25 Aug 2026 14:29:17 +0200
Message-ID: <20260825122921.431739-17-pbonzini@redhat.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260825122921.431739-1-pbonzini@redhat.com>
References: <20260825122921.431739-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Handle the EVEX formats for APX (including the extension of BMI and CMPccXADD
instructions that already supported VEX) and add their validation to
validate_vex().  Exit disas_insn() early if the NF field is set.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/tcg/decode-new.h     |  10 ++
 target/i386/tcg/translate.c      |  11 +-
 target/i386/tcg/decode-new.c.inc | 168 ++++++++++++++++++++++++++++++-
 3 files changed, 181 insertions(+), 8 deletions(-)

diff --git a/target/i386/tcg/decode-new.h b/target/i386/tcg/decode-new.h
index 8650b5ae7a0..1c7ed73c437 100644
--- a/target/i386/tcg/decode-new.h
+++ b/target/i386/tcg/decode-new.h
@@ -187,6 +187,9 @@ typedef enum X86InsnCheck {
 
     /* No 0x67 prefix allowed */
     X86_CHECK_no_adr = 16384,
+
+    /* EVEX.NF bit not allowed */
+    X86_CHECK_nf0 = 32768,
 } X86InsnCheck;
 
 typedef enum X86InsnSpecial {
@@ -274,6 +277,13 @@ typedef enum X86VEXSpecial {
     X86_VEX_AVX2_256,
 } X86VEXSpecial;
 
+typedef enum X86EVEXClass {
+    /* Non-vector instruction that can use APX EGPRs.  */
+    X86_EVEX_APX = 128,
+    X86_EVEX_APX_cmp = 129,
+    X86_EVEX_APX_pp2 = 130,
+    X86_EVEX_APX_zu = 131,
+} X86EVEXClass;
 
 typedef struct X86OpEntry  X86OpEntry;
 typedef struct X86DecodedInsn X86DecodedInsn;
diff --git a/target/i386/tcg/translate.c b/target/i386/tcg/translate.c
index 1d6714f3c6c..770a05f7d8d 100644
--- a/target/i386/tcg/translate.c
+++ b/target/i386/tcg/translate.c
@@ -107,18 +107,17 @@ typedef struct DisasContext {
     uint8_t vex_l;  /* vex vector length */
     uint8_t vex_v;  /* vex vvvv register, without 1's complement.  */
     bool vex_ndd; /* is this a 3-operand instruction? */
+    bool vex_w; /* used by AVX even on 32-bit processors */
     uint8_t popl_esp_hack; /* for correct popl with esp base handling */
     uint8_t rip_offset; /* only used in x86_64, but left for simplicity */
 
-#ifdef TARGET_X86_64
-    uint8_t rex_r;
+    uint8_t rex_r; /* 0 for i386, but left for simplicity */
     uint8_t rex_x;
     uint8_t rex_b;
-#endif
+
     uint8_t evex2;
     uint8_t evex3;
     uint8_t evex4;
-    bool vex_w; /* used by AVX even on 32-bit processors */
     bool jmp_opt; /* use direct block chaining for direct jumps */
     bool cc_op_dirty;
 
@@ -219,12 +218,16 @@ typedef struct DisasContext {
 #define REX_R(S)       ((S)->rex_r + 0)
 #define REX_X(S)       ((S)->rex_x + 0)
 #define REX_B(S)       ((S)->rex_b + 0)
+#define EVEX_APX_ND(S) (((S)->evex4 & 0x10) != 0)
+#define EVEX_APX_NF(S) (((S)->evex4 & 0x04) != 0)
 #else
 #define REX_PREFIX(S)  false
 #define REX_W(S)       false
 #define REX_R(S)       0
 #define REX_X(S)       0
 #define REX_B(S)       0
+#define EVEX_APX_ND(S) 0
+#define EVEX_APX_NF(S) 0
 #endif
 
 /*
diff --git a/target/i386/tcg/decode-new.c.inc b/target/i386/tcg/decode-new.c.inc
index 76266b829cb..ebbfa4f6592 100644
--- a/target/i386/tcg/decode-new.c.inc
+++ b/target/i386/tcg/decode-new.c.inc
@@ -253,6 +253,10 @@
 #define vex11 .vex_class = 11,
 #define vex12 .vex_class = 12,
 #define vex13 .vex_class = 13,
+#define evex_apx .vex_class = X86_EVEX_APX,
+#define evex_apx_cmp .vex_class = X86_EVEX_APX_cmp,
+#define evex_apx_pp2 .vex_class = X86_EVEX_APX_pp2,
+#define evex_apx_zu .vex_class = X86_EVEX_APX_zu,
 
 #define chk(a) .check = X86_CHECK_##a,
 #define chk2(a, b) .check = X86_CHECK_##a | X86_CHECK_##b,
@@ -2529,9 +2533,23 @@ static bool validate_sse_prefix(DisasContext *s, X86OpEntry *e)
 {
     uint16_t sse_prefixes;
 
-    if (!e->valid_prefix) {
-        return true;
+    switch (e->vex_class) {
+    case X86_EVEX_APX:
+    case X86_EVEX_APX_cmp:
+    case X86_EVEX_APX_pp2:
+    case X86_EVEX_APX_zu:
+        /* For APX-extended instructions, only EVEX versions check the prefix.  */
+        if (!(s->prefix & PREFIX_EVEX)) {
+            return true;
+        }
+
+        /* fallthrough */
+    default:
+        if (!e->valid_prefix) {
+            return true;
+        }
     }
+
     if (s->prefix & (PREFIX_REPZ | PREFIX_REPNZ)) {
         /* In SSE instructions, 0xF3 and 0xF2 cancel 0x66.  */
         s->prefix &= ~PREFIX_DATA;
@@ -2603,7 +2621,35 @@ static bool extract_evex_params(DisasContext *s, X86DecodedInsn *decode)
      * Here, the position of RXB and (for AVX512) displacement multiplier
      * should be known.
      */
-    g_assert_not_reached();
+    X86OpEntry *e = &decode->e;
+    uint8_t rex_r, rex_x, rex_b;
+
+    switch (e->vex_class) {
+    case 13:
+    case X86_EVEX_APX:
+    case X86_EVEX_APX_cmp:
+    case X86_EVEX_APX_pp2:
+    case X86_EVEX_APX_zu:
+        /* Only reached through EVEX map 4.  */
+        rex_r = (~s->evex2 & 0x10) | ((~s->evex2 >> 4) & 8);
+        rex_x = ((~s->evex3 << 2) & 0x10) | ((~s->evex2 >> 3) & 8);
+        rex_b = ((s->evex2 << 1) & 0x10) | ((~s->evex2 >> 2) & 8);
+        s->vex_v = ((~s->evex4 << 1) & 0x10) | ((~s->evex3 >> 3) & 15);
+        break;
+    default:
+        return false;
+    }
+
+#ifdef TARGET_X86_64
+    s->rex_r = rex_r;
+    s->rex_x = rex_x;
+    s->rex_b = rex_b;
+#else
+    (void)rex_r;
+    (void)rex_x;
+    (void)rex_b;
+#endif
+    return true;
 }
 
 static bool decode_ops(DisasContext *s, CPUX86State *env, X86DecodeFunc decode_func,
@@ -2733,6 +2779,87 @@ static bool has_cpuid_feature(DisasContext *s, X86CPUIDFeature cpuid)
     g_assert_not_reached();
 }
 
+static bool validate_evex_apx(DisasContext *s, X86DecodedInsn *decode)
+{
+    X86OpEntry *e = &decode->e;
+    uint8_t evex4_mask = 0;
+
+    assert(s->has_modrm);
+    switch (e->vex_class) {
+    case 13:
+        /*
+         * APX-EVEX-BMI and APX-EVEX-CMPCCXADD do not define EVEX.ND.
+         * They only differ for checks on NF, which happen elsewhere.
+         */
+        if (!CODE64(s) || !(s->flags & HF_APX_EN_MASK)) {
+            goto illegal;
+        }
+        evex4_mask = 0x0C;
+        break;
+
+    case X86_EVEX_APX:
+        /* APX-EVEX-INT.  Checks on NF happen elsewhere.  */
+        assert(e->s0 == e->s1);
+        if (!CODE64(s) || !(s->flags & HF_APX_EN_MASK)) {
+            goto illegal;
+        }
+        if (!EVEX_APX_ND(s)) {
+            s->vex_ndd = false;
+        } else if (!s->vex_ndd) {
+            goto illegal;
+        }
+        evex4_mask = 0x1C;
+        break;
+
+    case X86_EVEX_APX_zu:
+        /* APX-EVEX-INT, with ZU bit defined.  Checks on NF happen elsewhere.  */
+        assert(decode->e.special == 0 && !s->vex_ndd);
+        if (!CODE64(s) || !(s->flags & HF_APX_EN_MASK)) {
+            goto illegal;
+        }
+        if (s->vex_v != 0) {
+            goto illegal;
+        }
+        if (EVEX_APX_ND(s)) {
+            decode->e.special = X86_SPECIAL_Op0_ZU;
+        }
+        evex4_mask = 0x1C;
+        break;
+
+    case X86_EVEX_APX_pp2:
+        if (!CODE64(s) || !(s->flags & HF_APX_EN_MASK) ||
+            !EVEX_APX_ND(s) ||
+            (e->op0 != X86_TYPE_None && s->vex_v == ((decode->b & 7) | REX_B(s))) ||
+            ((decode->b & 7) | REX_B(s)) == 4 ||
+            s->vex_v == 4) {
+            goto illegal;
+        }
+        evex4_mask = 0x18;
+        break;
+
+    case X86_EVEX_APX_cmp:
+        if (!CODE64(s) || !(s->flags & HF_APX_EN_MASK)) {
+            goto illegal;
+        }
+        evex4_mask = 0x0F;
+        break;
+    }
+
+    if (s->evex4 & ~evex4_mask) {
+        goto illegal;
+    }
+
+    /* r/m == 11b requires X4=0 (that is, EVEX.U is 1)  */
+    if ((s->modrm >> 6) == 3 && (s->rex_x & 16)) {
+        goto illegal;
+    }
+    return true;
+
+illegal:
+    gen_illegal_opcode(s);
+    return false;
+}
+
 static bool validate_vex(DisasContext *s, X86DecodedInsn *decode)
 {
     X86OpEntry *e = &decode->e;
@@ -2825,14 +2952,32 @@ static bool validate_vex(DisasContext *s, X86DecodedInsn *decode)
         }
         break;
     case 13:
-        if (!(s->prefix & PREFIX_VEX)) {
+        if (!(s->prefix & (PREFIX_VEX | PREFIX_EVEX))) {
             goto illegal;
         }
         if (s->vex_l) {
             goto illegal;
         }
+        if (s->prefix & PREFIX_EVEX) {
+            if (!validate_evex_apx(s, decode)) {
+                return false;
+            }
+        }
         /* All integer instructions use VEX.vvvv, so exit.  */
         return true;
+    case X86_EVEX_APX:
+    case X86_EVEX_APX_cmp:
+    case X86_EVEX_APX_pp2:
+    case X86_EVEX_APX_zu:
+        /* Only reached through EVEX map 4.  */
+        assert(!(s->prefix & PREFIX_VEX));
+        if (s->vex_l) {
+            goto illegal;
+        }
+        if ((s->prefix & PREFIX_EVEX) && !validate_evex_apx(s, decode)) {
+            return false;
+        }
+        return true;
     }
 
     if (s->vex_v != 0 && !s->vex_ndd) {
@@ -3202,6 +3347,9 @@ static void disas_insn(DisasContext *s, CPUState *cpu)
         if ((decode.e.check & X86_CHECK_W1) && !s->vex_w) {
             goto illegal_op;
         }
+        if ((decode.e.check & X86_CHECK_nf0) && EVEX_APX_NF(s)) {
+            goto illegal_op;
+        }
     }
 
     if (op_has_modrm(decode.e.op0) || op_has_modrm(decode.e.op1) ||
@@ -3347,6 +3495,18 @@ static void disas_insn(DisasContext *s, CPUState *cpu)
      * cause incorrect tracking of CC_OP for instructions that write to both memory
      * and flags.
      */
+    switch (decode.e.vex_class) {
+    case 13:
+    case X86_EVEX_APX:
+    case X86_EVEX_APX_zu:
+        if (EVEX_APX_NF(s)) {
+            return;
+        }
+        break;
+    default:
+        break;
+    }
+
     if (decode.cc_op != -1) {
         if (decode.cc_dst) {
             tcg_gen_mov_tl(cpu_cc_dst, decode.cc_dst);
-- 
2.55.0


