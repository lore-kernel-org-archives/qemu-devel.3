Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC43FCA5FA2
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Sep 2026 13:07:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xBB3H-0008HF-M1; Mon, 28 Sep 2026 09:05:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1xBB1O-0005jl-9m
 for qemu-devel@nongnu.org; Mon, 28 Sep 2026 09:04:04 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1xBB1L-0004RV-K3
 for qemu-devel@nongnu.org; Mon, 28 Sep 2026 09:03:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1790600630;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7Vgoo90+eLWT02IWpIryDqkEozNGy5j16OFYXXq3WfE=;
 b=c17KMH0o+JLY2EmGrn3lprINmy9KBmL80Do4FHDauLf2WAw4wiR6rvag5aPyjr5k2ROxCE
 bFuWdiRpfZ7jPxy5YcrTGtcY+L+/D7RGh1zly3+d0rZv1dS2Bv05F+KQrA3DS/R24BTVUh
 RZ0qBi1NZ/iQjWsxTBs+y/CllPTMqF8=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-372-vD_0syDQPW-H20zU30_2qA-1; Mon, 28 Sep 2026 09:03:48 -0400
X-MC-Unique: vD_0syDQPW-H20zU30_2qA-1
X-Mimecast-MFC-AGG-ID: vD_0syDQPW-H20zU30_2qA_1790600627
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-48889c90a75so1704256f8f.2
 for <qemu-devel@nongnu.org>; Mon, 28 Sep 2026 06:03:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1790600626; x=1791205426; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=7Vgoo90+eLWT02IWpIryDqkEozNGy5j16OFYXXq3WfE=;
 b=NtFF2jtTxAYotNr1UbBtEX5AJvAvVd0yR9QBmpF/1MzAcW4o3VKUPN516QVy5NFVyB
 19jSCNexF/OqkIt4/Ghy7QxZw45bJrAujpWOJQCC3wskxibCE0ESO3qZoQn0+V0eH/T0
 ZmH+sV4AlPqtNx39Ggtckq+zu0103iebt2O5xgG/R44aeqzwhxwhnGQ1cFWpP04Sg5yB
 SjA23Egbsh7BLrbngxe0/OG4Ss3jZoix+yFd/OpWhcuxmQph2tbVcvUmCvhYgfabAGOh
 fVWKVNdrBDAtwEHMc528KCBvW6aI1xFil6Xd9R9M1W4pHw7L/B0cOdgZXFty+MrZteKR
 pBEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790600626; x=1791205426;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=7Vgoo90+eLWT02IWpIryDqkEozNGy5j16OFYXXq3WfE=;
 b=1uqJXXPqBYqM9KjkESr0YyKr3ZPBWkWlbgvkerkujNzujcli+yzvDF5VyJsVkuU8QL
 RyvzeVL6HTCd47ccDMBUR3AolzIS58uh37IVFiQXcB0hU6z9YqMrEltxDCpQIX28T52w
 fsy1ZyElqEZa9hIMR5TQaodXb+HZJsZrp3SnA3SSntWH2rD4zjDqSlCL5iRGgEbWKeHg
 tvE358mLCqqqQxS83Zc79UdR7ae5cXasIhD4UcMPY9KIi8u4Eggyvw2CD7D6pmZRpDnX
 3ypmPG0lnJ65uMwqYv0GR+MAof6wQi0bgs5QtVp/+5ql36PLyaEa0l9iv7K/k1Q92S+m
 /1HA==
X-Gm-Message-State: AFq9FYIo4dvMYmqzU7+TMOpFirH9XaqNweQYjx4hATAqxPgwEDT1S0lC
 1x5+MwxDsEJ8wF9GV8Wpf6pTx64SV5GA8n4cjRlmV/W/ZlRXSpKZn+2kuOW+gWA+9dVUR9UdgKE
 7xL0M+QLoo3NtHzKC3XYwkK6RfDX+QXCB9LR0OJSCv3aNnMl4ETcsGvbCDFAJO32kCITRHRi5w0
 jhLDkrzI2Wbx8H7ML/ETZX8yv5FD8J2jiiHlPXyrGK
X-Gm-Gg: AYBFou2qrLxR5WklDY/LecBNQTlztynf/6BdVuH2u0w+4/w7urnn4dR5L8vi97dvVqC
 kYaUHSxArdBEjv4YT4gdGEd/fkMdT2ZnOUDU2U7w6fi3IrBMBlFktaDG4KBQNj8wsAXreHe5w25
 MCCmW5cDJXlil1+Qq7E4RuM9eOzjoEU1JciAkMemPkvYBFaEtNA62QqVXYZlGfp9NY5N9etBLiG
 TQSkMfpuqhr4E9dy5t7FxYk/iLDgu988Uabejmo5iJap64uFDiPrcUiZGqsO0feABXkwdzwjRbb
 LJKDByr2FX/0eM9adV4jE6koadAzTEUYlm6FmcmczbHbbKqrO1uFtIOJgeDjSId5qw788lByj4A
 MFM0Tcsfonn9aqC+9wNsOqF+DCPTPEEtN5T+5lXcCWIJPpbUmaUkNMMIVHZseEtralBqUIAUKVB
 hPne2c
X-Received: by 2002:a5d:5f42:0:b0:487:88b:4681 with SMTP id
 ffacd0b85a97d-488716b6cc7mr22943530f8f.10.1790600626528; 
 Mon, 28 Sep 2026 06:03:46 -0700 (PDT)
X-Received: by 2002:a5d:5f42:0:b0:487:88b:4681 with SMTP id
 ffacd0b85a97d-488716b6cc7mr22943463f8f.10.1790600625816; 
 Mon, 28 Sep 2026 06:03:45 -0700 (PDT)
Received: from [192.168.10.48] ([151.49.232.249])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4887a2acb4dsm27247420f8f.0.2026.09.28.06.03.41
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 28 Sep 2026 06:03:41 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 24/30] target/i386/tcg: add decode functionality for APX
Date: Mon, 28 Sep 2026 15:02:22 +0200
Message-ID: <20260928130228.877003-25-pbonzini@redhat.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260928130228.877003-1-pbonzini@redhat.com>
References: <20260928130228.877003-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.238,
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
 target/i386/tcg/decode-new.c.inc | 166 ++++++++++++++++++++++++++++++-
 3 files changed, 179 insertions(+), 8 deletions(-)

diff --git a/target/i386/tcg/decode-new.h b/target/i386/tcg/decode-new.h
index eb692503680..140dd5fa1c8 100644
--- a/target/i386/tcg/decode-new.h
+++ b/target/i386/tcg/decode-new.h
@@ -193,6 +193,9 @@ typedef enum X86InsnCheck {
 
     /* No 0x67 prefix allowed */
     X86_CHECK_no_adr = 16384,
+
+    /* EVEX.NF bit not allowed */
+    X86_CHECK_nf0 = 32768,
 } X86InsnCheck;
 
 typedef enum X86InsnSpecial {
@@ -279,6 +282,13 @@ typedef enum X86VEXSpecial {
     X86_VEX_LIG,
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
index 8b07e92beef..b5a57e74b3f 100644
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
index 3f59a85d474..cfda9774724 100644
--- a/target/i386/tcg/decode-new.c.inc
+++ b/target/i386/tcg/decode-new.c.inc
@@ -257,6 +257,10 @@
 #define vex11 .vex_class = 11,
 #define vex12 .vex_class = 12,
 #define vex13 .vex_class = 13,
+#define evex_apx .vex_class = X86_EVEX_APX,
+#define evex_apx_cmp .vex_class = X86_EVEX_APX_cmp,
+#define evex_apx_pp2 .vex_class = X86_EVEX_APX_pp2,
+#define evex_apx_zu .vex_class = X86_EVEX_APX_zu,
 
 #define chk(a) .check = X86_CHECK_##a,
 #define chk2(a, b) .check = X86_CHECK_##a | X86_CHECK_##b,
@@ -2531,9 +2535,23 @@ static bool validate_sse_prefix(DisasContext *s, X86OpEntry *e)
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
@@ -2605,7 +2623,35 @@ static bool extract_evex_params(DisasContext *s, X86DecodedInsn *decode)
      * Here, the position of RXB and (for AVX512) displacement multiplier
      * should be known.
      */
-    return false;
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
@@ -2738,6 +2784,87 @@ static bool has_cpuid_feature(DisasContext *s, X86CPUIDFeature cpuid)
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
+        assert(e->op0 == X86_TYPE_None || e->s0 == e->s1);
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
+        assert(decode->e.ext0 == X86_EXT_None && !s->vex_ndd);
+        if (!CODE64(s) || !(s->flags & HF_APX_EN_MASK)) {
+            goto illegal;
+        }
+        if (s->vex_v != 0) {
+            goto illegal;
+        }
+        if (EVEX_APX_ND(s)) {
+            decode->op[0].ext = X86_EXT_Unsigned;
+        }
+        evex4_mask = 0x1C;
+        break;
+
+    case X86_EVEX_APX_pp2:
+        if (!CODE64(s) || !(s->flags & HF_APX_EN_MASK) ||
+            !EVEX_APX_ND(s) ||
+            (e->op0 != X86_TYPE_None && s->vex_v == ((s->modrm & 7) | REX_B(s))) ||
+            ((s->modrm & 7) | REX_B(s)) == 4 ||
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
@@ -2834,14 +2961,30 @@ static bool validate_vex(DisasContext *s, X86DecodedInsn *decode)
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
+        if (s->prefix & PREFIX_EVEX && !validate_evex_apx(s, decode)) {
+            return false;
+        }
         /* All integer instructions use VEX.vvvv, so exit.  */
         return true;
+    case X86_EVEX_APX:
+    case X86_EVEX_APX_cmp:
+    case X86_EVEX_APX_pp2:
+    case X86_EVEX_APX_zu:
+        /* Not reached through any VEX map.  */
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
@@ -3217,6 +3360,9 @@ static void disas_insn(DisasContext *s, CPUState *cpu)
         if ((decode.e.check & X86_CHECK_W1) && !s->vex_w) {
             goto illegal_op;
         }
+        if ((decode.e.check & X86_CHECK_nf0) && EVEX_APX_NF(s)) {
+            goto illegal_op;
+        }
     }
 
     if (op_has_modrm(decode.e.op0) || op_has_modrm(decode.e.op1) ||
@@ -3352,6 +3498,18 @@ static void disas_insn(DisasContext *s, CPUState *cpu)
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


