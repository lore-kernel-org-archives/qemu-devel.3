Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 581F6C9833F
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Sep 2026 13:05:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xBB2k-0006UP-W5; Mon, 28 Sep 2026 09:05:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1xBB19-0005ZM-R7
 for qemu-devel@nongnu.org; Mon, 28 Sep 2026 09:03:43 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1xBB17-0004QF-Vl
 for qemu-devel@nongnu.org; Mon, 28 Sep 2026 09:03:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1790600616;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=KAcfqtbVAb5pnaKetSqUEg4BiO5HB5L3GZOP7o6cwU4=;
 b=enkyZXoB+ad9zkZT2PCwxEL2VMV22eaBeq2CzbfxhqNJgFFvE/9CH8fMIbKJ85ACmjskh4
 Fzb8foE/jugk3oJeC+sGjYx1qhNk5Q1O7zlhexFX5Mh1Us1qskJh0GEZxxWTFVz6kM03ea
 pPSkIpZA0DoYcuescuZ//Rlo2uN5kpE=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-306-bEpqLNPrPbyPBNr2Rasqtw-1; Mon, 28 Sep 2026 09:03:35 -0400
X-MC-Unique: bEpqLNPrPbyPBNr2Rasqtw-1
X-Mimecast-MFC-AGG-ID: bEpqLNPrPbyPBNr2Rasqtw_1790600614
Received: by mail-ej1-f72.google.com with SMTP id
 a640c23a62f3a-c294442d71dso345183866b.2
 for <qemu-devel@nongnu.org>; Mon, 28 Sep 2026 06:03:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1790600614; x=1791205414; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=KAcfqtbVAb5pnaKetSqUEg4BiO5HB5L3GZOP7o6cwU4=;
 b=HSebAYyWSRp7+YMV+lCy7H00zpSlrjI+kAsIdBX1Yp9RNMz3rxqgvtM1AXOPlxbQtu
 PpvA7r6VxaDjdA3BTeNJ+ZwuBdrmxH5vJgpU7DxF0kY8loZpD1iCyk0l3WYkwpof4M2O
 6aSmA0rMmayoqG2T78Off62Q73pwBFp4GroBKCk1Dyynn9Bu4GZ0FtJpD0Oq9O9c6aqP
 Bl8RcI8gMnX5aaTLeNgOpJT+JlhxOafjVXPP9uzjHx4w/zKGD1OAfjDR34cimfngglIm
 BA9Jki6igWfumYPA8cxT1RCJVvM8WEWCVPx0nozRKADSW8J0p0VfF1o0DvMBqN1xqjvj
 un1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790600614; x=1791205414;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=KAcfqtbVAb5pnaKetSqUEg4BiO5HB5L3GZOP7o6cwU4=;
 b=UKbTdh884RS7LMJxXsooPjiFtq68QfrRF2Josnbfd5KvX+KYmxeTnoy60StXmTOvyD
 AiSaJY7SjSmf2Q/TkUjN5i7f8fZDD7RmL4pcH9QbaaAaDPYQZr9CTZGv79NZdRqTl/TZ
 P4kuXrjFWdGrMK54YCu6ppcUeN+NOv9UN8KEP+ibmqr24nSiRMLfdbddiJp8O7m4vGtB
 L7WVs7OWp6W33Y4+bOGBFDvikujL3f9fAMQpZ3wq5T9OviaK3Fn7ylFedQhmkFaVbxaI
 IltT1wMQXGbPoe+8FDBeMRPsbUpElMZxchF+SXLIu312FegSLGc4nlkwtwB4Ss99u1hQ
 M81g==
X-Gm-Message-State: AFuF++lFrD7FhGUGWxD3PaOi6De7Xizvwb5Xsb5H+Y2lpBQUvhXnjJBb
 xKxms/2Mtrd+k/wBl+68T/MsVJbkA6VEMqMAgGoicCMFRyyZ/myDgJV8xTZniZ8MhQlMO1V9oXP
 As8UTuHvXzcjLuNWxUp3euRZgUpmmLknO65VL4rWl4fqdn/1f8Rxl3eZJl8magJtyODICBydYya
 LBw4cm1HQll2ynrD8wVWgc1LDtu7eRrRh09gs0c62x
X-Gm-Gg: AYBFou3hbHiQuJlfyLpeSlfqO6Le+tcqF4Xq0VgvIXDt/f0MZKp6S7guzXa74q2z14O
 A3fsMsL6lwinA3ysP1Sx56HF3qPT4hhfRRWhkBKCG4LTeLVwrNrc/193pmnAFgEMbhl+o0F/9Ls
 ZYXZ0m2FHeVKjB1JunfOcyquxl+QE7HLWzoKbAjKg19A8XeDYvFuvqsE5KvdFlFTrZpOwAKyoeb
 cq9whrdDfRKifDMY0drDa3mNMd7mLNy4s2hb0JwYF7dy7ZM9haj7oraQvhHeMek/1+Qw2jAFRR4
 bjdsL0WoAapKiucXq1t5JzbJXvOE0eJsXpSSo+rXRQj52Lsb5J9FzzTYj6qD8UG/hLzFRQotCiS
 9zxTK+oMwA4UkyyseAn7ZPHXtYWAWH4XcdoK4PyEeYWdAY8dpxTzaUddlv1AOKRe4L1ugzcUZ6Z
 588NJZ
X-Received: by 2002:a17:906:c114:b0:c29:555e:bf9 with SMTP id
 a640c23a62f3a-c2ae97cc5e6mr796301766b.18.1790600613631; 
 Mon, 28 Sep 2026 06:03:33 -0700 (PDT)
X-Received: by 2002:a17:906:c114:b0:c29:555e:bf9 with SMTP id
 a640c23a62f3a-c2ae97cc5e6mr796298166b.18.1790600613040; 
 Mon, 28 Sep 2026 06:03:33 -0700 (PDT)
Received: from [192.168.10.48] ([151.49.232.249])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c2ae757b84bsm462976066b.31.2026.09.28.06.03.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 28 Sep 2026 06:03:31 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: "Chang S. Bae" <chang.seok.bae@intel.com>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 20/30] target/i386/tcg: decode REX2 prefix
Date: Mon, 28 Sep 2026 15:02:18 +0200
Message-ID: <20260928130228.877003-21-pbonzini@redhat.com>
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

The REX2 prefix has two main complications: it does not apply
to vector registers, and it disables or mutates some opcodes
(thus needing separate decoding functions instead of decode_root
and decode_0F).  Otherwise, all it does is extend s->rex_r,
s->rex_w and s->rex_b to two bits.

Since REX2 provides the ability to access r16...r31, extend
cpu_regs[] to CPU_NB_EREGS elements.

Reviewed-by: Chang S. Bae <chang.seok.bae@intel.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/tcg/translate.c      |  22 +++++-
 target/i386/tcg/decode-new.c.inc | 114 +++++++++++++++++++++++++++++--
 2 files changed, 126 insertions(+), 10 deletions(-)

diff --git a/target/i386/tcg/translate.c b/target/i386/tcg/translate.c
index 2e48e3a8898..99c74e4d5d5 100644
--- a/target/i386/tcg/translate.c
+++ b/target/i386/tcg/translate.c
@@ -78,7 +78,7 @@
 static TCGv cpu_cc_dst, cpu_cc_src, cpu_cc_src2;
 static TCGv cpu_eip;
 static TCGv_i32 cpu_cc_op;
-static TCGv cpu_regs[CPU_NB_REGS];
+static TCGv cpu_regs[CPU_NB_EREGS];
 static TCGv cpu_seg_base[6];
 static TCGv_i64 cpu_bndl[4];
 static TCGv_i64 cpu_bndu[4];
@@ -3341,7 +3341,7 @@ static void gen_multi0F(DisasContext *s, X86DecodedInsn *decode)
 
 void tcg_x86_init(void)
 {
-    static const char reg_names[CPU_NB_REGS][4] = {
+    static const char reg_names[CPU_NB_EREGS][4] = {
 #ifdef TARGET_X86_64
         [R_EAX] = "rax",
         [R_EBX] = "rbx",
@@ -3359,6 +3359,22 @@ void tcg_x86_init(void)
         [13] = "r13",
         [14] = "r14",
         [15] = "r15",
+        [16] = "r16",
+        [17] = "r17",
+        [18] = "r18",
+        [19] = "r19",
+        [20] = "r20",
+        [21] = "r21",
+        [22] = "r22",
+        [23] = "r23",
+        [24] = "r24",
+        [25] = "r25",
+        [26] = "r26",
+        [27] = "r27",
+        [28] = "r28",
+        [29] = "r29",
+        [30] = "r30",
+        [31] = "r31",
 #else
         [R_EAX] = "eax",
         [R_EBX] = "ebx",
@@ -3403,7 +3419,7 @@ void tcg_x86_init(void)
                                      "cc_src2");
     cpu_eip = tcg_global_mem_new(tcg_env, offsetof(CPUX86State, eip), eip_name);
 
-    for (i = 0; i < CPU_NB_REGS; ++i) {
+    for (i = 0; i < CPU_NB_EREGS; ++i) {
         cpu_regs[i] = tcg_global_mem_new(tcg_env,
                                          offsetof(CPUX86State, regs[i]),
                                          reg_names[i]);
diff --git a/target/i386/tcg/decode-new.c.inc b/target/i386/tcg/decode-new.c.inc
index 546c6451ed1..f79098e8348 100644
--- a/target/i386/tcg/decode-new.c.inc
+++ b/target/i386/tcg/decode-new.c.inc
@@ -1991,6 +1991,65 @@ static const X86OpEntry opcodes_root[256] = {
     [0xFF] = X86_OP_GROUP1(group4_5, E,v),
 };
 
+#ifdef TARGET_X86_64
+static const X86OpEntry opcodes_rex2_map0_A0toAF[16] = {
+};
+
+static void decode_REX2(DisasContext *s, CPUX86State *env, X86OpEntry *entry, uint8_t *b,
+                        const X86OpEntry **map)
+{
+    *b = x86_ldub_code(env, s);
+    const X86OpEntry *group = map[*b >> 4];
+    *entry = group ? group[*b & 15] : UNKNOWN_OPCODE;
+}
+
+static void decode_REX2_map0(DisasContext *s, CPUX86State *env, X86OpEntry *entry, uint8_t *b)
+{
+    static const X86OpEntry *opcode_rex2_map0[16] = {
+        &opcodes_root[0x00],
+        &opcodes_root[0x10],
+        &opcodes_root[0x20],
+        &opcodes_root[0x30],
+        NULL,
+        &opcodes_root[0x50],
+        &opcodes_root[0x60],
+        NULL,
+        &opcodes_root[0x80],
+        &opcodes_root[0x90],
+        opcodes_rex2_map0_A0toAF,
+        &opcodes_root[0xB0],
+        &opcodes_root[0xC0],
+        &opcodes_root[0xD0],
+        NULL,
+        &opcodes_root[0xF0],
+    };
+    decode_REX2(s, env, entry, b, opcode_rex2_map0);
+}
+
+static void decode_REX2_map1(DisasContext *s, CPUX86State *env, X86OpEntry *entry, uint8_t *b)
+{
+    static const X86OpEntry *opcode_rex2_map1[16] = {
+        &opcodes_0F[0x00],
+        &opcodes_0F[0x10],
+        &opcodes_0F[0x20],
+        NULL,
+        &opcodes_0F[0x40],
+        &opcodes_0F[0x50],
+        &opcodes_0F[0x60],
+        &opcodes_0F[0x70],
+        NULL,
+        &opcodes_0F[0x90],
+        &opcodes_0F[0xA0],
+        &opcodes_0F[0xB0],
+        &opcodes_0F[0xC0],
+        &opcodes_0F[0xD0],
+        &opcodes_0F[0xE0],
+        &opcodes_0F[0xF0],
+    };
+    decode_REX2(s, env, entry, b, opcode_rex2_map1);
+}
+#endif
+
 #undef mmx
 #undef vex1
 #undef vex2
@@ -2010,6 +2069,20 @@ static void decode_root(DisasContext *s, CPUX86State *env, X86OpEntry *entry, ui
     *entry = opcodes_root[*b];
 }
 
+static int reg_nb_mask(DisasContext *s, int unit)
+{
+    switch (unit) {
+    case X86_OP_MMX:
+        return 7;
+    case X86_OP_SSE:
+        return 15;
+        break;
+    default:
+        return 31;
+        break;
+    }
+}
+
 /* Decode the MODRM and SIB bytes into a register or memory operand.  */
 static void decode_modrm(DisasContext *s, CPUX86State *env,
                          X86DecodedInsn *decode, X86DecodedOp *op)
@@ -2020,10 +2093,7 @@ static void decode_modrm(DisasContext *s, CPUX86State *env,
     int sib = -1;
 
     if (mod == 3) {
-        op->n = rm;
-        if (op->unit != X86_OP_MMX) {
-            op->n |= REX_B(s);
-        }
+        op->n = (rm | REX_B(s)) & reg_nb_mask(s, op->unit);
 	return;
     }
 
@@ -2324,9 +2394,7 @@ static bool decode_op(DisasContext *s, CPUX86State *env, X86DecodedInsn *decode,
         }
     get_reg:
         op->n = ((s->modrm >> 3) & 7);
-        if (op->unit != X86_OP_MMX) {
-            op->n |= REX_R(s);
-        }
+        op->n |= REX_R(s) & reg_nb_mask(s, op->unit);
         break;
 
     case X86_TYPE_E:  /* ALU modrm operand */
@@ -2785,6 +2853,24 @@ static void dump_unknown_opcode(CPUX86State *env, DisasContext *s)
     }
 }
 
+/* MASK must have two bits set.  Bring the lowest just below the highest;
+ * for example if MASK == 0x11, bit 1 of value is moved to bit 3.  Clear
+ * every other bit in VALUE.
+ *
+ * Generally mask will be a constant, so that all of the first three
+ * lines disappear.  Likewise, if the bits in mask are already adjacent
+ * this becomes just "return value & mask".
+ */
+static inline uint8_t collapse_two_bits(uint8_t value, uint8_t mask)
+{
+    uint8_t high = mask & (mask - 1);
+    uint8_t low = mask & ~high;
+    uint8_t tweak = (high >> 1) - low;
+
+    value &= mask;
+    return (value + tweak) & (mask + tweak);
+}
+
 /*
  * Convert one instruction. s->base.is_jmp is set if the translation must
  * be stopped.
@@ -2880,6 +2966,20 @@ static void disas_insn(DisasContext *s, CPUState *cpu)
             goto next_byte_rex;
         }
         break;
+    case 0xd5: /* REX2 */
+        if (CODE64(s) && (s->flags & HF_APX_EN_MASK)) {
+            int rex2 = x86_ldub_code(env, s);
+            if (rex != -1) {
+                goto illegal_op;
+            }
+            s->prefix |= PREFIX_REX2;
+            s->rex_b = collapse_two_bits(rex2, 0x11);
+            s->rex_x = collapse_two_bits(rex2, 0x22) >> 1;
+            s->rex_r = collapse_two_bits(rex2, 0x44) >> 2;
+            s->vex_w = (rex2 >> 3) & 1;
+            decode_func = rex2 & 0x80 ? decode_REX2_map1 : decode_REX2_map0;
+        }
+        break;
 #endif
     case 0xc5: /* 2-byte VEX */
     case 0xc4: /* 3-byte VEX */
-- 
2.55.0


