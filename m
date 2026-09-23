Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21E53C9830B
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Sep 2026 17:32:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x9QpJ-00079l-T6; Wed, 23 Sep 2026 13:32:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1x9Qo1-0006nV-SJ
 for qemu-devel@nongnu.org; Wed, 23 Sep 2026 13:31:00 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1x9Qnz-0003k6-4H
 for qemu-devel@nongnu.org; Wed, 23 Sep 2026 13:30:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1790184650;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=QKDSIFWp43Gs/ApqacofjIfIteR2AUxMhDKogSwDmdQ=;
 b=OqgLn2fIwAs6zkponOxsKGwgiNbx0hl/b/MK/QNU3l5U8y2bjYkowOyWyGVlvaISNpZufU
 ZUhzmxbWSE0LLTwdySQXEaxBGO4zVFk79wN9HE7OfRaRdm6/mJ+vheb5sYzFxJj46oSFHv
 Hm84C9urA/FXI6AXKDlbpa4IogkaLwU=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-10-N-EahUTCMxq-__rZqSyidw-1; Wed, 23 Sep 2026 13:30:48 -0400
X-MC-Unique: N-EahUTCMxq-__rZqSyidw-1
X-Mimecast-MFC-AGG-ID: N-EahUTCMxq-__rZqSyidw_1790184648
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-49e6862e924so8683555e9.0
 for <qemu-devel@nongnu.org>; Wed, 23 Sep 2026 10:30:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1790184647; x=1790789447; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=QKDSIFWp43Gs/ApqacofjIfIteR2AUxMhDKogSwDmdQ=;
 b=YgMAsI8B4/M7/T+9utjHaLemDrl/x62+yI7tOCVuXU180lEgRFkZ0pW2JaPEZVFh6B
 FPYdpJL/cEeekKZVsrj2wFr7j31S6t4J4aqZh5F7tMFYwSCIeMegrfB/hFL96YgkpyLd
 oq4bQVTuuISoGUTUamuGkmVxbvOQqoEElAkEWi9vZA3MuLdnervBxR+1KzDNwiYyoooC
 uplurN9OKlRg/OpSIVud4Uzx5Na8f6Qdu67WwcDmUrydVlUEgbDuieJOdG3Xl/0jDypB
 pV4dilwpg6GNpf2fUzZjPW0hoH6uesC7hd31U9T4uxTFUCwU5nIpuHzb36bNiuX2pL4E
 97zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790184647; x=1790789447;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=QKDSIFWp43Gs/ApqacofjIfIteR2AUxMhDKogSwDmdQ=;
 b=RSM4YeUs042iveibOb5qO17vcef7+yiCytSko4YBuG9DficabBTGEIqriLY37SS5c6
 eNzU2iHO2XW1ifxrba8n6K8vmWuHU0i8j7WCyohnKZacGORy+P4f/lw9bsYD4N8ppFwb
 8K0TahR+EBa1B1/KA17awldb2UhruHxnXhKnmH9lbSAUGxtngtRkqKJQcJcqSiL7siC5
 IlSI22d4GsuHL1TuHDyhsgh5scKzP/TChI6M1HlnLhBGWpc3bmmROVx76DsTiF8g+gPM
 nObLSLqUf4arYSWwy1uvPqlbZn3bPbyUs5Sbowf+qSqWTY8IPLtZ8Y50tLK+DqrwzB91
 HrOA==
X-Gm-Message-State: AFuF++lKqpgrM492og6esGJxGcdlviAPREbvqZZ2HK9KXRvqe9kzMNwA
 FgkCN3X76DpS6+bO2pHCRZs7ynVL8E6whoJ0KS18Ira+EPDlbbdZL2nx3VRcAwuheLmkTsBWcNl
 hhXQa/i3rNuH/FdLbLBbg31PGygIyTsmNI7dr3OyngqQaErv6AnUysxZuPrCerAFhdC0umU1qo2
 ltHdxf1qNd7b/rIaE9toBDXMECJpD+I6CZQC46BySv
X-Gm-Gg: AYBFou0tiBw66OpaIhZ4R6JE0Z3QHf4P+gwhOFleOnwP+jklFubZEZyOV/iUP7tuA56
 Zg8W++NZgRSa/QvCfNkQ4GwOTsJq0eCR6O5SmQ5pz+krx/BS/xIS+vwIKQajJVrCbuRXENxAyYx
 xXuo5ivMYMl9sn4rqoSnEYZn/cM3jSaertNUAzUTApwXA1uWvp2l+Gy4qbTMbsGciatBUEaFK47
 RYVennOJmj5zUpq9jdKbr+0HtvXuCNtQX1JqEC4kkydXu8GYulIyGxkvCrxPvxLMvRpJ7o0ULti
 wt8hfjWgo1R80ZTEGmZ2Oo0Ub55eqetzBEd2sMbquwfgCwCz6CCubCJJSq1V+KZzd/6HxUzPcAG
 2VND1/11z60ATIt8BjA+peHKkHWDZoJ9kl5TKFhc/n2GuXLgRE0F22jl9ggaM8p3d0NnJ91mVQG
 p1eToL
X-Received: by 2002:a05:600c:1f90:b0:49e:7c4b:1753 with SMTP id
 5b1f17b1804b1-49fdf0fc3a0mr42589015e9.12.1790184647486; 
 Wed, 23 Sep 2026 10:30:47 -0700 (PDT)
X-Received: by 2002:a05:600c:1f90:b0:49e:7c4b:1753 with SMTP id
 5b1f17b1804b1-49fdf0fc3a0mr42588585e9.12.1790184646957; 
 Wed, 23 Sep 2026 10:30:46 -0700 (PDT)
Received: from [192.168.10.48] ([151.49.232.249])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49fe5df44f9sm1101065e9.11.2026.09.23.10.30.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Sep 2026 10:30:45 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: chang.seok.bae@intel.com,
	zhao1.liu@intel.com
Subject: [PATCH 09/17] target/i386/tcg: decode REX2 prefix
Date: Wed, 23 Sep 2026 19:30:13 +0200
Message-ID: <20260923173021.317809-10-pbonzini@redhat.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260923173021.317809-1-pbonzini@redhat.com>
References: <20260923173021.317809-1-pbonzini@redhat.com>
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

The REX2 prefix has two main complications: it does not apply
to vector registers, and it disables or mutates some opcodes
(thus needing separate decoding functions instead of decode_root
and decode_0F).  Otherwise, all it does is extend s->rex_r,
s->rex_w and s->rex_b to two bits.

Since REX2 provides the ability to access r16...r31, extend
cpu_regs[] to CPU_NB_EREGS elements.

Reviewed-by: Chang S. Bae <chang.seok.bae@intel.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/tcg/translate.c      |  22 +++++-
 target/i386/tcg/decode-new.c.inc | 114 +++++++++++++++++++++++++++++--
 2 files changed, 126 insertions(+), 10 deletions(-)

diff --git a/target/i386/tcg/translate.c b/target/i386/tcg/translate.c
index b8e8991163f..edef866a24b 100644
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
@@ -3337,7 +3337,7 @@ static void gen_multi0F(DisasContext *s, X86DecodedInsn *decode)
 
 void tcg_x86_init(void)
 {
-    static const char reg_names[CPU_NB_REGS][4] = {
+    static const char reg_names[CPU_NB_EREGS][4] = {
 #ifdef TARGET_X86_64
         [R_EAX] = "rax",
         [R_EBX] = "rbx",
@@ -3355,6 +3355,22 @@ void tcg_x86_init(void)
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
@@ -3399,7 +3415,7 @@ void tcg_x86_init(void)
                                      "cc_src2");
     cpu_eip = tcg_global_mem_new(tcg_env, offsetof(CPUX86State, eip), eip_name);
 
-    for (i = 0; i < CPU_NB_REGS; ++i) {
+    for (i = 0; i < CPU_NB_EREGS; ++i) {
         cpu_regs[i] = tcg_global_mem_new(tcg_env,
                                          offsetof(CPUX86State, regs[i]),
                                          reg_names[i]);
diff --git a/target/i386/tcg/decode-new.c.inc b/target/i386/tcg/decode-new.c.inc
index bcb23c6fae1..c2b252c01be 100644
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


