Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E55FC9833F
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Sep 2026 13:06:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xBB3P-0000Vp-MA; Mon, 28 Sep 2026 09:06:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1xBB1J-0005iu-VA
 for qemu-devel@nongnu.org; Mon, 28 Sep 2026 09:04:00 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1xBB1E-0004Qz-Um
 for qemu-devel@nongnu.org; Mon, 28 Sep 2026 09:03:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1790600624;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=fzZ5zkzQGm0NEmRL/QyQRtrROMj9NKqg3PW0HwzbjyQ=;
 b=N7chB1m2vG7e4/28Wu6qOTc3TJmDS0uCfA1Kk444f7JJTaOqohj2S3uKS5Y0RcqDGIY2v7
 0nBvl6y/JxgqNJ18ZxYwjjfjai2Igrq2RCt3aJyzGyRs+b4OHIuc2R1tZRrPi6be2oHDEz
 /uW1BzekoLEvwSlbEGFJXmvpAnm8svU=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-513-WJ3S6eiVNGqo9Kp_CgSfwA-1; Mon, 28 Sep 2026 09:03:42 -0400
X-MC-Unique: WJ3S6eiVNGqo9Kp_CgSfwA-1
X-Mimecast-MFC-AGG-ID: WJ3S6eiVNGqo9Kp_CgSfwA_1790600622
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-49e6422198fso19958805e9.1
 for <qemu-devel@nongnu.org>; Mon, 28 Sep 2026 06:03:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1790600621; x=1791205421; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=fzZ5zkzQGm0NEmRL/QyQRtrROMj9NKqg3PW0HwzbjyQ=;
 b=pifmf1sQizXiFn5GDd4LlTUXr5sDw+d8W/iBcLl0elOr3fyJFWerzjtN3b+0dC6n8/
 hS4ztqXmC7iTKRr4x+M6bcQ0NhBI0OkJVJFV6qDML8yepBaoNduPGm3Oh0I9mZZv6HCB
 8sjLgthX9z0wIUL8gtTKx2O21rrKupNQs63ohZjzYzXmSlDsAyVO5UapLBYARI76wpwk
 JHA7aO+2LPRJAJFtRDu0DhwDPfsN6RlhM0ioIqZGqkoEHPI9awQoEjGmW3B5BMlG3iQC
 mhgC1dBxoKQPw5lrnuqKs8cKzCBzGUg6IlnrWr22SVEogR2vS3re1J0T/suENpx6pEeJ
 lehQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790600621; x=1791205421;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=fzZ5zkzQGm0NEmRL/QyQRtrROMj9NKqg3PW0HwzbjyQ=;
 b=Pz8XhUW6zsytmlChQjLdDZv0N5wlNF6bcFEumz8PA4yNBjocn0arc0Clujap0YOmCO
 e9PBC2XS7i3JBcZdrdrPg+FcNm+7fILlQ6Z7JemdRcZptJCvz79rlhL1Cyn41DWxxrEz
 VCa+yRlz6E9UhfRO0MTaaPxvtGAc4AEIp0ywFz5ZzwRzAK3wAfBSZo2yxqs0udBdhFvi
 oHaiWFy+zZHwz5nqsU8dAPhoBZ3yZNbCUhcsGORdmBmBlmbjuaFPNHwJmdvzwtACz9KV
 Y8Nl8hFK07OtL+StIpPTJCEwDVDW8L7SC/lpUn2G9vSudd8RmpS59CQ6KzUBYctyPm6x
 +oYw==
X-Gm-Message-State: AFuF++lbEollJcRl3uqz/ugCeNQz2Ib3K98t08HGzRR4ISSXxGKvasrT
 0FdrBxxzA8OG2Ksl39aarUlx8ncY5kunZKJejDbPRUV7RaspZ3nPAtUIqw/gaCPi+CTs+zdn/xB
 sjdJtBU3TgXgISc8K0Z4EcHNhBqoSMezh7vN1jRc9K6pwIWBqQ6ybeNlcuLojr5uYlozzmJpTQE
 RQ+Dm4eQexZNELIt2rGbKPvNcjJ26GgYvETF8oHFph
X-Gm-Gg: AYBFou3oLoUilRLd3PyyagYq9t0SR6lLPQH6iDDBvu+/2f7GsDBDGeKqLJs0BWqdgbv
 HvgCuYeu9iCabIu5cxC5SKlluv4FykBxfRslda3Ra9JDWtBpro6DORDTAbhPJluNibMDYQEZk/k
 eQ3K/AJ8VzsLa4LErUu1rhYN4o211fYhipwB4WBPLrMaBryqFxNk/3d/CBXVEGUe1clWo71r7Zg
 VanmMkS6J4Y4sKIotaZc39dNhuV3bYjUmCS35dTlcEwrD3BAOUAY3PnrKf7ErwJDCZuyGRVClwf
 2wX9u31YhCL/MzRaDBmeabX85vUOx9qJkNg62MPI0ytlSvAQNebOLrnrN6ReDT4hGWI0e9AjTuF
 THhl5EcwIA/MIy7jjvsJ+C/r5lp487/nHHNIPgj4enKEh7eFBmALAGZEcsE3EE0fkOV5wO3+56n
 c0ddk3
X-Received: by 2002:a05:600c:3b85:b0:49f:ffc7:2099 with SMTP id
 5b1f17b1804b1-4a00071552fmr93818565e9.26.1790600621379; 
 Mon, 28 Sep 2026 06:03:41 -0700 (PDT)
X-Received: by 2002:a05:600c:3b85:b0:49f:ffc7:2099 with SMTP id
 5b1f17b1804b1-4a00071552fmr93817815e9.26.1790600620782; 
 Mon, 28 Sep 2026 06:03:40 -0700 (PDT)
Received: from [192.168.10.48] ([151.49.232.249])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a0017656cesm134572915e9.3.2026.09.28.06.03.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 28 Sep 2026 06:03:40 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 23/30] target/i386/tcg: decode EVEX prefix
Date: Mon, 28 Sep 2026 15:02:21 +0200
Message-ID: <20260928130228.877003-24-pbonzini@redhat.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260928130228.877003-1-pbonzini@redhat.com>
References: <20260928130228.877003-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.238,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_PASS=-0.001,
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

EVEX is really messy and the exact position of the fields is spread all
over the place.  For now store the three data bytes of the prefix in
DisasContext, later the EVEX instruction classes for APX will be added
to extract_evex_params and validate_vex.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/tcg/translate.c      |  8 ++-
 target/i386/tcg/decode-new.c.inc | 89 +++++++++++++++++++++++++++++---
 2 files changed, 87 insertions(+), 10 deletions(-)

diff --git a/target/i386/tcg/translate.c b/target/i386/tcg/translate.c
index 4e012521bd9..8b07e92beef 100644
--- a/target/i386/tcg/translate.c
+++ b/target/i386/tcg/translate.c
@@ -51,6 +51,7 @@
 #define PREFIX_VEX    0x20
 #define PREFIX_REX    0x40
 #define PREFIX_REX2   0x80
+#define PREFIX_EVEX   0x100
 
 #ifdef TARGET_X86_64
 # define ctztl  ctz64
@@ -93,8 +94,8 @@ typedef struct DisasContext {
     MemOp aflag;
     MemOp dflag;
 
+    uint16_t prefix;
     int8_t override; /* -1 if no override, else R_CS, R_DS, etc */
-    uint8_t prefix;
 
     bool has_modrm;
     uint8_t modrm;
@@ -114,6 +115,9 @@ typedef struct DisasContext {
     uint8_t rex_x;
     uint8_t rex_b;
 #endif
+    uint8_t evex2;
+    uint8_t evex3;
+    uint8_t evex4;
     bool vex_w; /* used by AVX even on 32-bit processors */
     bool jmp_opt; /* use direct block chaining for direct jumps */
     bool cc_op_dirty;
@@ -210,7 +214,7 @@ typedef struct DisasContext {
 #endif
 
 #ifdef TARGET_X86_64
-#define REX_PREFIX(S)  (((S)->prefix & (PREFIX_REX | PREFIX_REX2 | PREFIX_VEX)) != 0)
+#define REX_PREFIX(S)  (((S)->prefix & (PREFIX_REX | PREFIX_REX2 | PREFIX_VEX | PREFIX_EVEX)) != 0)
 #define REX_W(S)       ((S)->vex_w)
 #define REX_R(S)       ((S)->rex_r + 0)
 #define REX_X(S)       ((S)->rex_x + 0)
diff --git a/target/i386/tcg/decode-new.c.inc b/target/i386/tcg/decode-new.c.inc
index 5289df7d6eb..3f59a85d474 100644
--- a/target/i386/tcg/decode-new.c.inc
+++ b/target/i386/tcg/decode-new.c.inc
@@ -2049,6 +2049,11 @@ static void decode_REX2_map1(DisasContext *s, CPUX86State *env, X86OpEntry *entr
     };
     decode_REX2(s, env, entry, b, opcode_rex2_map1);
 }
+
+static void decode_EVEX_map4(DisasContext *s, CPUX86State *env, X86OpEntry *entry, uint8_t *b)
+{
+    *entry = UNKNOWN_OPCODE;
+}
 #endif
 
 #undef mmx
@@ -2076,8 +2081,7 @@ static int reg_nb_mask(DisasContext *s, int unit)
     case X86_OP_MMX:
         return 7;
     case X86_OP_SSE:
-        return 15;
-        break;
+        return s->prefix & PREFIX_EVEX ? 31 : 15;
     default:
         return 31;
         break;
@@ -2469,7 +2473,7 @@ static bool decode_op(DisasContext *s, CPUX86State *env, X86DecodedInsn *decode,
         op->unit = X86_OP_SSE;
     get_vex_v:
         if (s->vex_ndd) {
-            assert(s->prefix & PREFIX_VEX);
+            assert(s->prefix & (PREFIX_VEX | PREFIX_EVEX));
             op->n = s->vex_v;
             break;
         }
@@ -2595,6 +2599,15 @@ static bool decode_insn(DisasContext *s, CPUX86State *env, X86DecodeFunc decode_
     return true;
 }
 
+static bool extract_evex_params(DisasContext *s, X86DecodedInsn *decode)
+{
+    /*
+     * Here, the position of RXB and (for AVX512) displacement multiplier
+     * should be known.
+     */
+    return false;
+}
+
 static bool decode_ops(DisasContext *s, CPUX86State *env, X86DecodeFunc decode_func,
                        X86DecodedInsn *decode)
 {
@@ -2729,13 +2742,16 @@ static bool validate_vex(DisasContext *s, X86DecodedInsn *decode)
 {
     X86OpEntry *e = &decode->e;
 
-    if (s->prefix & PREFIX_VEX) {
+    if (s->prefix & (PREFIX_VEX | PREFIX_EVEX)) {
         if (e->op0 == X86_TYPE_H || e->op0 == X86_TYPE_B ||
             e->op1 == X86_TYPE_H || e->op1 == X86_TYPE_B ||
             e->op2 == X86_TYPE_H || e->op2 == X86_TYPE_B) {
             s->vex_ndd = true;
         }
     }
+    if ((s->prefix & PREFIX_EVEX) && !extract_evex_params(s, decode)) {
+        goto illegal;
+    }
 
     switch (e->vex_special) {
     case X86_VEX_None:
@@ -2883,6 +2899,10 @@ static inline uint8_t collapse_two_bits(uint8_t value, uint8_t mask)
     return (value + tweak) & (mask + tweak);
 }
 
+static const int pp_prefix[4] = {
+    0, PREFIX_DATA, PREFIX_REPZ, PREFIX_REPNZ
+};
+
 /*
  * Convert one instruction. s->base.is_jmp is set if the translation must
  * be stopped.
@@ -2908,6 +2928,9 @@ static void disas_insn(DisasContext *s, CPUState *cpu)
     s->vex_v = 0;
     s->vex_w = false;
     s->vex_ndd = false;
+    s->evex2 = 0;
+    s->evex3 = 0;
+    s->evex4 = 0;
     s->has_modrm = false;
     s->prefix = 0;
 
@@ -2994,6 +3017,59 @@ static void disas_insn(DisasContext *s, CPUState *cpu)
         }
         break;
 #endif
+    case 0x62: /* EVEX */
+        if (CODE32(s) && !VM86(s)) {
+            int evex2 = x86_ldub_code(env, s);
+
+            if (!CODE64(s) && (evex2 & 0xc0) != 0xc0) {
+                s->pc--; /* rewind the advance_pc() x86_ldub_code() did */
+                break;
+            }
+#ifdef TARGET_X86_64
+            if (rex != -1) {
+                goto illegal_op;
+            }
+#endif
+            if (s->prefix & (PREFIX_REPZ | PREFIX_REPNZ
+                             | PREFIX_LOCK | PREFIX_DATA)) {
+                goto illegal_op;
+            }
+            /*
+             * Store them because the exact correspondence between EVEX
+             * and RXB bits is only known later.  It's different for APX,
+             * AVX512 register operands, and AVX512 VSIB index operands.
+             */
+            s->evex2 = evex2;
+            s->evex3 = x86_ldub_code(env, s);
+            s->evex4 = x86_ldub_code(env, s);
+            s->vex_w = (s->evex3 >> 7) & 1;
+            s->vex_l = (s->evex4 >> 5) & 3;
+            s->prefix |= pp_prefix[s->evex3 & 3] | PREFIX_EVEX;
+            switch (evex2 & 7) {
+            case 0x01:
+                /*
+                 * Note: actually uses VEX map1, to which AVX512 adds extra
+                 * instructions encoded with VEX.L=1.  Of these, KMOV*
+                 * has an APX extension too.
+                 */
+                decode_func = decode_0F;
+                break;
+            case 0x02:
+                decode_func = decode_0F38;
+                break;
+            case 0x03:
+                decode_func = decode_0F3A;
+                break;
+#ifdef TARGET_X86_64
+            case 0x04:
+                decode_func = decode_EVEX_map4;
+                break;
+#endif
+            default:   /* Reserved for future use.  */
+                goto unknown_op;
+            }
+        }
+        break;
     case 0xc5: /* 2-byte VEX */
     case 0xc4: /* 3-byte VEX */
         /*
@@ -3001,9 +3077,6 @@ static void disas_insn(DisasContext *s, CPUState *cpu)
          * Otherwise the instruction is LES or LDS.  Not allowed in real mode.
          */
         if (PE(s) && !VM86(s)) {
-            static const int pp_prefix[4] = {
-                0, PREFIX_DATA, PREFIX_REPZ, PREFIX_REPNZ
-            };
             int vex3, vex2 = x86_ldub_code(env, s);
 
             if (!CODE64(s) && (vex2 & 0xc0) != 0xc0) {
@@ -3152,7 +3225,7 @@ static void disas_insn(DisasContext *s, CPUState *cpu)
     }
 
     if (decode.e.vex_class == 0) {
-        if (s->prefix & PREFIX_VEX) {
+        if (s->prefix & (PREFIX_VEX | PREFIX_EVEX)) {
             goto illegal_op;
         }
     } else {
-- 
2.55.0


