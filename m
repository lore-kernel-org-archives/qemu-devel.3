Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93540FD006A
	for <qemu-devel@archiver.kernel.org>; Sun,  1 Mar 2026 14:43:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vwi0H-0000IP-CD; Sun, 01 Mar 2026 09:42:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vwi0F-0000I0-Gu
 for qemu-devel@nongnu.org; Sun, 01 Mar 2026 09:42:39 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vwi0D-0005ip-PS
 for qemu-devel@nongnu.org; Sun, 01 Mar 2026 09:42:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1772376157;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=hUfyV+BSh7CpYKLSHL/QcDrpwX+PfQmoNiEbN3lORPA=;
 b=BX96wFP1IomqNYUu4mEgVy3tG55BrcX+F/YQ/gLzBO0GWTDzug7SLxPKCufCygAaJ8e1f8
 amZnPB//sLRreug/5bWt3dPj1g9asXxP+hSMJu/bvQkCZTEG/MymhJJZQCYtAK1xb+KBFq
 eK5sk5wtc/Hw0yiR7UdYkLU2FoonPJY=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-84-ctnGWU_iPTCF_dOn_ZvT7A-1; Sun, 01 Mar 2026 09:42:36 -0500
X-MC-Unique: ctnGWU_iPTCF_dOn_ZvT7A-1
X-Mimecast-MFC-AGG-ID: ctnGWU_iPTCF_dOn_ZvT7A_1772376155
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-4837b6f6b93so22444635e9.3
 for <qemu-devel@nongnu.org>; Sun, 01 Mar 2026 06:42:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1772376154; x=1772980954; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=hUfyV+BSh7CpYKLSHL/QcDrpwX+PfQmoNiEbN3lORPA=;
 b=Uhbwrx801Hz73GjkyHc8dDh2Pih+BH+tDvD3OopjqwlJizN8rtSikIvNubEb32QQBu
 CBFBO9P4F629Ak0U5gOE0pQqNzYwyduD+SBfYYiUwIVuy5+4BFPIuoamHisJiFr4w0KV
 hHyrkjlFOWESTwsNTwfZb5sIhtsPNUxN4k9brQbrUNsYIrQqeuLzdRcG9/5+JaI2N2JC
 ITmiijx4kWrwUDhpJnmHYOG56IRapA+IvWcIkkCYHY4+aLFiGIrzcqcETsQ4L5GjMdu2
 nR0pCt9B3QjQfL3MFfgktN5ApMqhIB8O0ARr4uFLsa+xFOJKUqYtOWqxyqccJ9C2eFdX
 Q6sQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772376154; x=1772980954;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=hUfyV+BSh7CpYKLSHL/QcDrpwX+PfQmoNiEbN3lORPA=;
 b=KWmRagxJ62NVKlCPnX6DreLLETfRkGRi0yRa6Tqm3F4d5xtN7KUowZgcdD8m1KJTt6
 9A43KZ8dKsIVHrl96hdVZalxDGmtaL6ly0WHXUKVgmCfslGizsiKDos3d5lnIeSGwCZL
 l+Yxcqnj9ImpHK+ZGiFQUdD6b1pWW6oZLdCGE7DnDwYY0Mgha0ZB5mzs/Q42CS7URcnh
 YNOkng8ZrmKVVDFnSO0CgL9QkqHJqcGSVj86UJmB0V9zIeS9kXCyt8PHIhzlflBVeu9q
 SAPmv2h8LjzFz4+E5Vhq7EEpqlQXKcq0eAUERVwqjWtMioUmmZu+7iNNAJG7STrALRIt
 YArA==
X-Gm-Message-State: AOJu0Ywkkt88weY9z1LxdqdbapDSRk8DRLbdOYTNEW7xo2Qcm4yc5JHP
 f/VAIFKXETg3OIQrGfHRI2khcTo426N1Af+0DyAANQVBZxzFE9ifp5XyK4Q1gobxFdfabTulF3c
 Hde+bu+8lSrJOEFL0CSdlYvrtIDZIdB/tq1MPnBgPXdZd1BE8C+1Dhb5noV4KdTUkEQBWvUe4Md
 ULTd9tIB/0quCxrO1HIdxM5+RYFKE2OAOPUPhjghdC
X-Gm-Gg: ATEYQzzXEJ9AZuMr9fiEvc88lDEzO/JlnYT4Gyv2MuFIimTdKpZt4Uj83Oz4eGdwHY8
 /1PSZ1zpQ/vz5FJROtLaMwBLXQ35saitBz9MM+V6+7TQaO4J4TrcBN3i7jtxJCsb0c6ihl10KWn
 C+qolRXQYWk4thhfm5/QZlz1hauXuTSnIE6LUvvA471ZGVPwNIooOLy21j0aX1MJMJ7Y1tyYLqx
 WfRj4rLydFrLhIBBDpzRdjEKS8hfiH9EcphHSshb8hfi579+xeGAHP3WALDGlqIQEiq0/JJtLAD
 sGyE78FzGpHTN6kHmAMvDD3bc8V2AgvIe0u4jEtN3WgU++KBGc/isJrKsp/okcD7N0xMVTUCM8Q
 ZUX4b6XKncYFQZ0iI4cilDbfW07noUDSXLUmOu+kR9NVNDzAjSc5DYbaLv6bN0d6noYRyao8h5Q
 bBfy85N0Y4E39yiJ0GZZjR+CbOG2A=
X-Received: by 2002:a05:600c:4f0e:b0:483:702f:4641 with SMTP id
 5b1f17b1804b1-483c9b94367mr156241955e9.3.1772376154032; 
 Sun, 01 Mar 2026 06:42:34 -0800 (PST)
X-Received: by 2002:a05:600c:4f0e:b0:483:702f:4641 with SMTP id
 5b1f17b1804b1-483c9b94367mr156241315e9.3.1772376153364; 
 Sun, 01 Mar 2026 06:42:33 -0800 (PST)
Received: from [192.168.10.48] ([151.95.144.138])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-483bfccad8esm109406605e9.22.2026.03.01.06.42.31
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 01 Mar 2026 06:42:32 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 06/18] target/i386/tcg: decode REX2 prefix
Date: Sun,  1 Mar 2026 15:42:06 +0100
Message-ID: <20260301144218.458140-7-pbonzini@redhat.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260301144218.458140-1-pbonzini@redhat.com>
References: <20260301144218.458140-1-pbonzini@redhat.com>
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
index 061adcb7221..47eef81ba05 100644
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
@@ -3349,7 +3349,7 @@ static void gen_multi0F(DisasContext *s, X86DecodedInsn *decode)
 
 void tcg_x86_init(void)
 {
-    static const char reg_names[CPU_NB_REGS][4] = {
+    static const char reg_names[CPU_NB_EREGS][4] = {
 #ifdef TARGET_X86_64
         [R_EAX] = "rax",
         [R_EBX] = "rbx",
@@ -3367,6 +3367,22 @@ void tcg_x86_init(void)
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
@@ -3411,7 +3427,7 @@ void tcg_x86_init(void)
                                      "cc_src2");
     cpu_eip = tcg_global_mem_new(tcg_env, offsetof(CPUX86State, eip), eip_name);
 
-    for (i = 0; i < CPU_NB_REGS; ++i) {
+    for (i = 0; i < CPU_NB_EREGS; ++i) {
         cpu_regs[i] = tcg_global_mem_new(tcg_env,
                                          offsetof(CPUX86State, regs[i]),
                                          reg_names[i]);
diff --git a/target/i386/tcg/decode-new.c.inc b/target/i386/tcg/decode-new.c.inc
index b968db2b8ad..9ee69564ab1 100644
--- a/target/i386/tcg/decode-new.c.inc
+++ b/target/i386/tcg/decode-new.c.inc
@@ -1988,6 +1988,65 @@ static const X86OpEntry opcodes_root[256] = {
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
@@ -2007,6 +2066,20 @@ static void decode_root(DisasContext *s, CPUX86State *env, X86OpEntry *entry, ui
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
@@ -2018,10 +2091,7 @@ static void decode_modrm(DisasContext *s, CPUX86State *env,
     int sib = -1;
 
     if (mod == 3) {
-        op->n = rm;
-        if (op->unit != X86_OP_MMX) {
-            op->n |= REX_B(s);
-        }
+        op->n = (rm | REX_B(s)) & reg_nb_mask(s, op->unit);
 	return;
     }
 
@@ -2300,9 +2370,7 @@ static bool decode_op(DisasContext *s, CPUX86State *env, X86DecodedInsn *decode,
         }
     get_reg:
         op->n = ((get_modrm(s, env) >> 3) & 7);
-        if (op->unit != X86_OP_MMX) {
-            op->n |= REX_R(s);
-        }
+        op->n |= REX_R(s) & reg_nb_mask(s, op->unit);
         break;
 
     case X86_TYPE_E:  /* ALU modrm operand */
@@ -2749,6 +2817,24 @@ static void dump_unknown_opcode(CPUX86State *env, DisasContext *s)
     }
 }
 
+/* MASK must have two bits set.  Bring the highest next to the lowest;
+ * for example if MASK == 0x11, bit 4 of value is moved to bit 1.  Clear
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
+    uint8_t tweak = (low << 1) - high;
+
+    value &= mask;
+    return value + (value > low ? tweak : 0);
+}
+
 /*
  * Convert one instruction. s->base.is_jmp is set if the translation must
  * be stopped.
@@ -2833,6 +2919,20 @@ static void disas_insn(DisasContext *s, CPUState *cpu)
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
+            s->rex_b = collapse_two_bits(rex2, 0x11) << 3;
+            s->rex_x = collapse_two_bits(rex2, 0x22) << 2;
+            s->rex_r = collapse_two_bits(rex2, 0x44) << 1;
+            s->vex_w = (rex2 >> 3) & 1;
+            decode_func = rex2 & 0x80 ? decode_REX2_map1 : decode_REX2_map0;
+        }
+        break;
 #endif
     case 0xc5: /* 2-byte VEX */
     case 0xc4: /* 3-byte VEX */
-- 
2.52.0


