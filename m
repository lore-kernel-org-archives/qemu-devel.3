Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 351CDC61DC7
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2026 12:30:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wyqHq-0004je-V2; Tue, 25 Aug 2026 08:29:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1wyqHm-0004iY-VX
 for qemu-devel@nongnu.org; Tue, 25 Aug 2026 08:29:51 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1wyqHk-0000Ls-1V
 for qemu-devel@nongnu.org; Tue, 25 Aug 2026 08:29:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1787660987;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=9iMnCach2KZ49hnmyEOviYi8sDL27YHmctXR6GdAi7s=;
 b=EngBlvbs3vC6/XhbxE+VqsaAjc2v7ni1hzm5WAhasPv0bomPRfUBxsYTaks/HqVxX8dGv5
 dC/JRU+OC1xKKoF6KBX1ijt+4D0UXqnXzVKqvsnfFR32t/pB7wEJG4x80bLBY01dqWKNoh
 QSslxmRT3ZcX8xPkavSkCu37CzdOAT8=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-626-cEo3uvZbPU2sECSP15lWwA-1; Tue, 25 Aug 2026 08:29:46 -0400
X-MC-Unique: cEo3uvZbPU2sECSP15lWwA-1
X-Mimecast-MFC-AGG-ID: cEo3uvZbPU2sECSP15lWwA_1787660985
Received: by mail-ej1-f72.google.com with SMTP id
 a640c23a62f3a-c1686e23b9cso400472166b.0
 for <qemu-devel@nongnu.org>; Tue, 25 Aug 2026 05:29:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1787660985; x=1788265785; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=9iMnCach2KZ49hnmyEOviYi8sDL27YHmctXR6GdAi7s=;
 b=PRl64GsF5omU4mqhybqY5WDrC5X8AtB9QqhgmavUC/quoy3ZZVCDc9OOD8iB3YHTAr
 ghE2KeB6KNWwDQ2eK5K9Ou9RfgQgTQwOJxfucFpGlKQ1MkbNXZD0xLSC8CZQInL7sGZW
 8uG8CivHML/4FO8+5SBzEd1Zl4yirl7OH5+UnOvn1VJM7718nQkxGud9TNsLrYaIYo+k
 IdoCFVzetmJQy187NptxFD5ozGGa+1GUbEOeexeLLrTjp6P2crOiqFd1FqJ5H6JFCM5M
 aNB2ZBujjTzOJcNri0OUpHganNGqk7727ukivRHZwRc7H+frQREdClODOK3ZIhxST3Ee
 Q6XA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787660985; x=1788265785;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=9iMnCach2KZ49hnmyEOviYi8sDL27YHmctXR6GdAi7s=;
 b=SwmQbh6uxOdUSlCDP+weTcKWk1Od/rM9RSUFy4ymSvXP6eSIfl5bobEa7AWZLURy3F
 kxJrJ2UUQw4y92cxe4EUO+7yxY8VDiGVVq9O+luOEqHm+jgzzaeK9jpMwcBIbLSwax/B
 I5Z7tdFp95HqA8zleEGv9MFAqmr46hs8/Dw6pfswA3HOibE/1Cv7Se20KEUM7/VrDyCR
 nAlTPqvbEZIZDUymywDV6RkY38PqDVhMAmjzCNFH/qeisJZF6TFqqOooXpAT3dUJ/q8r
 9guwAJOdiIs6GtlzB9K1XifI2DZUfU5EH5g40TCwdUG9LeP//0C+NzqlrTqm/Tf8jHIq
 9QTw==
X-Gm-Message-State: AFuF++kedj988TK3wuj652gq8oY9Htft9cE92MbPtuQ9aYmMQTPwF4AR
 hRw4LQlBpeUbCfwZmCltvtKNQjlK7vlxH4G+wVuFDTzl0H2Pc8GQDE8GjYouJAyOxu8l2D/tyMr
 tJaZiWgboOBjWn627YI9Pkj23Y06g7obnGL26xQvqJEMf3YEi6HyC5ZBiWQRru+6uqZVr9pyisr
 86AOlV9Q2NYE/TG6BPrpcxgGvEXy96kNp/4wuKTJJT
X-Gm-Gg: AR+sD13ztgpXHBm2aB20IzHP6zWDqACMzCyoq0hDi3dVE/aOXLV3PKGqs/6eMJXf5NE
 s4nXk2GpkCFq/YuHC0aZRDM6b9v0xPEktQo/Z4IZiB2D5xB36cpzWEd11vl6MiHjE+FSniWgP9A
 BCtOIom8Vo9UF30XbPugp8z29oa5Cis6lE1eUSrwYOfkgQc/gMAzjsyJ2L9hmbUTX0VVu//d0fQ
 Fy4SsLP27E/yfWCkJUnV45t+RFCk3R01vz3iBhTlSssxe7zBLqCRYplFzXqdJSHxlx2ykTaBJ2s
 4KujV/41kxiz4QAErE55R922vlHaZ8k6fPKus02FXWbdZsu0tPSsc/CwEzt0V+Mo9AWwOUrDfHZ
 qAwGMGeRJ9Wj42YRpuJeQuS7Z36OpIDcvvThAAnJHc1vLrVCSWaVRwkWRF7wiah4wNY0/npF1Y6
 jtIvI=
X-Received: by 2002:a17:907:c20:b0:c1f:b883:ed3b with SMTP id
 a640c23a62f3a-c246a2cf2d0mr3858091566b.4.1787660984574; 
 Tue, 25 Aug 2026 05:29:44 -0700 (PDT)
X-Received: by 2002:a17:907:c20:b0:c1f:b883:ed3b with SMTP id
 a640c23a62f3a-c246a2cf2d0mr3858085366b.4.1787660983983; 
 Tue, 25 Aug 2026 05:29:43 -0700 (PDT)
Received: from [192.168.10.48] ([151.95.34.92])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c24968abf18sm1882336266b.61.2026.08.25.05.29.43
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 25 Aug 2026 05:29:43 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 09/20] target/i386/tcg: decode REX2 prefix
Date: Tue, 25 Aug 2026 14:29:10 +0200
Message-ID: <20260825122921.431739-10-pbonzini@redhat.com>
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

The REX2 prefix has two main complications: it does not apply
to vector registers, and it disables or mutates some opcodes
(thus needing separate decoding functions instead of decode_root
and decode_0F).  Otherwise, all it does is extend s->rex_r,
s->rex_w and s->rex_b to two bits.

Since REX2 provides the ability to access r16...r31, extend
cpu_regs[] to CPU_NB_EREGS elements.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/tcg/translate.c      |  22 +++++-
 target/i386/tcg/decode-new.c.inc | 114 +++++++++++++++++++++++++++++--
 2 files changed, 126 insertions(+), 10 deletions(-)

diff --git a/target/i386/tcg/translate.c b/target/i386/tcg/translate.c
index 2b94f4163d9..ea70e9a5568 100644
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
@@ -3336,7 +3336,7 @@ static void gen_multi0F(DisasContext *s, X86DecodedInsn *decode)
 
 void tcg_x86_init(void)
 {
-    static const char reg_names[CPU_NB_REGS][4] = {
+    static const char reg_names[CPU_NB_EREGS][4] = {
 #ifdef TARGET_X86_64
         [R_EAX] = "rax",
         [R_EBX] = "rbx",
@@ -3354,6 +3354,22 @@ void tcg_x86_init(void)
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
@@ -3398,7 +3414,7 @@ void tcg_x86_init(void)
                                      "cc_src2");
     cpu_eip = tcg_global_mem_new(tcg_env, offsetof(CPUX86State, eip), eip_name);
 
-    for (i = 0; i < CPU_NB_REGS; ++i) {
+    for (i = 0; i < CPU_NB_EREGS; ++i) {
         cpu_regs[i] = tcg_global_mem_new(tcg_env,
                                          offsetof(CPUX86State, regs[i]),
                                          reg_names[i]);
diff --git a/target/i386/tcg/decode-new.c.inc b/target/i386/tcg/decode-new.c.inc
index a7e3ecec8a2..1f59fd665f7 100644
--- a/target/i386/tcg/decode-new.c.inc
+++ b/target/i386/tcg/decode-new.c.inc
@@ -1989,6 +1989,65 @@ static const X86OpEntry opcodes_root[256] = {
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
@@ -2008,6 +2067,20 @@ static void decode_root(DisasContext *s, CPUX86State *env, X86OpEntry *entry, ui
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
@@ -2019,10 +2092,7 @@ static void decode_modrm(DisasContext *s, CPUX86State *env,
     int sib = -1;
 
     if (mod == 3) {
-        op->n = rm;
-        if (op->unit != X86_OP_MMX) {
-            op->n |= REX_B(s);
-        }
+        op->n = (rm | REX_B(s)) & reg_nb_mask(s, op->unit);
 	return;
     }
 
@@ -2301,9 +2371,7 @@ static bool decode_op(DisasContext *s, CPUX86State *env, X86DecodedInsn *decode,
         }
     get_reg:
         op->n = ((get_modrm(s, env) >> 3) & 7);
-        if (op->unit != X86_OP_MMX) {
-            op->n |= REX_R(s);
-        }
+        op->n |= REX_R(s) & reg_nb_mask(s, op->unit);
         break;
 
     case X86_TYPE_E:  /* ALU modrm operand */
@@ -2750,6 +2818,24 @@ static void dump_unknown_opcode(CPUX86State *env, DisasContext *s)
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
@@ -2842,6 +2928,20 @@ static void disas_insn(DisasContext *s, CPUState *cpu)
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


