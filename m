Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55DCBC9830B
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Sep 2026 17:32:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x9Qp6-000755-Uo; Wed, 23 Sep 2026 13:32:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1x9Qo9-0006oL-0V
 for qemu-devel@nongnu.org; Wed, 23 Sep 2026 13:31:05 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1x9Qo7-0003l1-1o
 for qemu-devel@nongnu.org; Wed, 23 Sep 2026 13:31:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1790184658;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=F0rnhZMIzJhXSttL3UzDH4bY1vhB2QsysEjw18vtlHw=;
 b=DfBw5gZyt5Uu4A3JlJI/+S9myieXfV+xWtexPeog3gpp0IcH76MbvgEK/edI4pV/5lb0tT
 TNlmzv5UsfVGU7t6knvKZJywS1C3GwyGl5efGhh7uCPwpoptQwJ9tQDXokwGBcOAi+5Ftn
 1zQhpTr3SkdKaD2AAHlATg9ohRGUNqE=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-517-KAE8_LcpOemnHOuftkDTZQ-1; Wed, 23 Sep 2026 13:30:56 -0400
X-MC-Unique: KAE8_LcpOemnHOuftkDTZQ-1
X-Mimecast-MFC-AGG-ID: KAE8_LcpOemnHOuftkDTZQ_1790184655
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-49cd83ca361so16546095e9.1
 for <qemu-devel@nongnu.org>; Wed, 23 Sep 2026 10:30:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1790184655; x=1790789455; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=F0rnhZMIzJhXSttL3UzDH4bY1vhB2QsysEjw18vtlHw=;
 b=b4EYQkIm1Hmd7PjxdV0sKhQ2AqMSUTORL6/tA9nF6s7en/I3BKg0WvBVnpbMK97jgq
 mDQmoHX9OAWStSw0eNd7JLDzjW8xRAlsW3PeuvbpbaSsu/k0vBaUGfprA/+qguQANPXF
 YYMn2tu/wn/Sfe1U7pIrHf9H0z4MDDJguzlaD68fCpcWhXb2qYLvjN0ujZntq6JUDrfR
 1vNpX4za0KtjasD8rueQkzgnPT8YgAXqPaMFD3xmz20wuo629D3cJVdS3j3tnAnFsFZJ
 Ch+YhVQt9Krw5Y5MCCsyefR6g1EtQlcd7F8wKrd6mhFl6ZMhCrSBT1TZ673p9+k2YgJL
 8cUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790184655; x=1790789455;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=F0rnhZMIzJhXSttL3UzDH4bY1vhB2QsysEjw18vtlHw=;
 b=R/3j65FcsJA5acEURbqhb/E8v3i5Z0FtP6GQMvDY2CQo+gREwLjDx9V1QvzNh9ll2S
 DI0S4fFlXqeB05qpXpI8HPen3a81xlwfn1rV5oRYVb4yX7yIcPw1YBPWOeI79R3DOgP3
 D6oqbdSACXYEySJVpQSlvaOhtJQZky41Ps7NoQ9RXDDuGiccDbzjNOiKRpCIyPpuAtC7
 XmJve5yCHJpXY0vf5zI0/tjlyq4UbY/vAuMTc+RURiw6MBwZiFceABpPSjUCaB8YhvRC
 PMFlcFeOTF8J1HiVXlOSgHiX6jKZaUNIbbdsccECxP9Q0uUpm9lzz3qLv0JYKHL4DlqK
 Ovgg==
X-Gm-Message-State: AFuF++m1iZfXV6c9jorI3TgSOVlc/NwEzzeh8hOPqPq0ZzpJ+iNGzbr0
 Y0yWmBMo8italkOpzI5Eg44/rh8qhi2dazdyUEoh8wJBUdSsKu4vFv/jdV5GV8kStSK6tHgqKxW
 9Xv+qlfAuQjhK9gTHePs8lvzQHU5+0gVrTI53OPD/oUIpoae9udBsvZI0v8Y3kPWxuBs+NZd3SL
 qRRLXF+JHxkKzHZ/V81HSlgtk/zIhmq14J3DTeSBhH
X-Gm-Gg: AYBFou0NPsyuXoxbJ5FvSl80ypj7A0d7EsZ5PTAcmkvzi+1USwj7dyih6ki/un/NQZs
 4uEKgdYSXrerNARPFxXGSvj8IGxqpUEvo9Zp+zuFD16lcbuekUlCxE93zHQ1LuXOkG8GE9vEa8H
 9PwEbEpAsiBpcPjMHrLvZvMOjolmcRgEpS9HJrCOhm7Dq3iKK5jnqOldZUxpbTZHYkoX/wByyP9
 2HKjuAMBR2iS8KiEDyPIIvcRGoXd2Tw4hVd9JzRO46SayFk1MPsfEw5z0OcVUQNgKediOBLb/oz
 CEEa1FHo3eC6kpFhgDy4dEkkxazWSsu/Lz6nvWuFBGwmJ9AmJ8M6tnSey0XhfU6CPTtt8rZnH60
 +82HZKxCHUz5+EFNgiiLrZOz4xrNe5l8kOArifRJVrHK/XF2wyIUA8KBZaLg0FCvMMv5NuZ4z16
 FgYapv
X-Received: by 2002:a05:600c:190a:b0:49f:c331:39e4 with SMTP id
 5b1f17b1804b1-49fdee0a0e0mr55361885e9.7.1790184654826; 
 Wed, 23 Sep 2026 10:30:54 -0700 (PDT)
X-Received: by 2002:a05:600c:190a:b0:49f:c331:39e4 with SMTP id
 5b1f17b1804b1-49fdee0a0e0mr55361515e9.7.1790184654409; 
 Wed, 23 Sep 2026 10:30:54 -0700 (PDT)
Received: from [192.168.10.48] ([151.49.232.249])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-488684863d9sm8391738f8f.12.2026.09.23.10.30.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Sep 2026 10:30:53 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: chang.seok.bae@intel.com,
	zhao1.liu@intel.com
Subject: [PATCH 12/17] target/i386/tcg: decode EVEX prefix
Date: Wed, 23 Sep 2026 19:30:16 +0200
Message-ID: <20260923173021.317809-13-pbonzini@redhat.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260923173021.317809-1-pbonzini@redhat.com>
References: <20260923173021.317809-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/tcg/translate.c      |  8 ++-
 target/i386/tcg/decode-new.c.inc | 89 +++++++++++++++++++++++++++++---
 2 files changed, 87 insertions(+), 10 deletions(-)

diff --git a/target/i386/tcg/translate.c b/target/i386/tcg/translate.c
index 1901d9372bb..c28cd9809e9 100644
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
index b3873043b16..10c6833bb3c 100644
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
@@ -2598,6 +2602,15 @@ static bool decode_insn(DisasContext *s, CPUX86State *env, X86DecodeFunc decode_
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


