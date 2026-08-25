Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E050C61DBD
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2026 12:31:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wyqI2-0004mt-Nc; Tue, 25 Aug 2026 08:30:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1wyqHy-0004lo-TF
 for qemu-devel@nongnu.org; Tue, 25 Aug 2026 08:30:04 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1wyqHw-0000Qj-2t
 for qemu-devel@nongnu.org; Tue, 25 Aug 2026 08:30:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1787660999;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=vVFRI1J3A+WiSvoLF13U1p5+7NI4QDvzMzms0Z8Ogmg=;
 b=UyhULefKEWBUVp1lY9ejKE3MUNhjE6R22Ruo+0Nf74CwNpXMi3/CoDrrFfARfDVrfnDl29
 kJtVjeKqDfys4L3dFRCgzXMipMF0ZN10yjYUBXShvbFe+WU8cJ0Qk3jo8vf+w3Q6lPxRUR
 e4/pZXq5Jx+5yhw52MDS4r76FDsUOjY=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-498-srLdHUYPOe26GEtS7PzoXQ-1; Tue, 25 Aug 2026 08:29:58 -0400
X-MC-Unique: srLdHUYPOe26GEtS7PzoXQ-1
X-Mimecast-MFC-AGG-ID: srLdHUYPOe26GEtS7PzoXQ_1787660996
Received: by mail-ej1-f69.google.com with SMTP id
 a640c23a62f3a-c20262b5e10so557633766b.1
 for <qemu-devel@nongnu.org>; Tue, 25 Aug 2026 05:29:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1787660996; x=1788265796; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=vVFRI1J3A+WiSvoLF13U1p5+7NI4QDvzMzms0Z8Ogmg=;
 b=jTwiz//KTGWDCp5Dabg9mff4M0bPROmcviWo+jdHQ1CdqEeGWCAZNXf9Wy4/gxjaVW
 uifsR1tyGQ+0pA5clHdxBzn5k0q3lDnzDHqKjJsNCHNMwkzqMiNd+uiz2yaBL/CLDa0/
 w5ygomKodvUAlW45mRQnLk624wDEQ8VDExf1QCafMYWcUWi5iv1Ohmkgz5ZKJHCnOJ1A
 EpfHPFxLoaJ4KZqFQgV66a7p3oIUlrez4286k+cjOhihzCSNnOBmHPgObCv82lHVKKt8
 q+Eqwb1RfBTGsuqOuytw7TJY1X3CHb/cV/1EwC1DDwSxeqxXUrUp3u2DVliUk/Lr+C8k
 lAow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787660996; x=1788265796;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=vVFRI1J3A+WiSvoLF13U1p5+7NI4QDvzMzms0Z8Ogmg=;
 b=GT4bxRH70d9WetWKRj3W+LqeEyaVhtcQdD8jjn+4+37fcvHtZ/uO13HqCSFjhOWCPH
 0bRgFtM0Czn0wjWhDBsvok4NGZtP7H86KDS5bnJ/XpOEFaJxHHaw7U6EaWfJS3otaVip
 6xhHok09IKLR9dwP5jQyqYKYoJDnE8E2bOj6CtfBtsFl9Y1k07qVk2KFwJP4/U7/TzIv
 PvPIjK4xsuGY7Zxrf3QTz4QTo+IP1pk0EN3fQol+peGwNd2o+wYAEGNsuOHd1ngwYqS+
 1p+feG6IApmrOBmoxpfpo9KqQgKFtorVPeD6cwSutWt26gl7gobAslRel76gLVQer2pn
 xdyw==
X-Gm-Message-State: AFuF++l+ds1a2IjrICIHvTsippPY+moOuLqw7Ozw1x5ZBRmBG/74e48o
 I3nHZfbZyTSc9yB4S+S56gAL361954Y6ooGbMD8C+MvgWNEJ0/8RbJ55CXE7kIoDdvlHY1v/IpI
 Vffuw4x3cwNxRtDjtPVvusCH3E1Kzo5CxG4T3Rish6mvsL+Enm6pR/CjDksQcv/byLrh/pp9Rfr
 +4nYElf6R6A933jQJbb/XU6kxUQPE7VkP+HDw194Vp
X-Gm-Gg: AR+sD12YuFUoCdlQPVsxzzI79F4cv8G4ylHHfbf7Ly7ZGAG2+bJPFHr7dO3wMvh2OUa
 Gn39LzelD4In+QOWH8++n4kkPNc43dpxrxiyPI0rf/LfpenYbwWBaKrUbUggRoyyGrLN/ZLC1o0
 A/X8AZgebghepmUgsk41tRpdL6u7RNpyEwIdWpuFK2p6RxicyfW6mdgxIKZqGHkFw23L+hwpaZL
 CBdFDxFxMarwwpys9e60H5qS9AM4U5CfKWnZ0TVz89yt9wpvzo6OPS+D34usQtUGwZn5QN+J8yH
 59m+cVxNdfFzgfRopNnRW3HDgNGguB/95t5mTjXAGtz64TjiIRoMJ8EwhQNn4f7r6I0INoYyKBy
 z7f9hIQvGwQfV77njFI5uotKa5unKuJu6h3ifLJa1cpqk/2+dNFCnCyYcXvR4uiYpploqDsadW3
 N7NQ==
X-Received: by 2002:a17:906:f246:b0:c21:61a6:8821 with SMTP id
 a640c23a62f3a-c246a6cd384mr3155055666b.23.1787660995625; 
 Tue, 25 Aug 2026 05:29:55 -0700 (PDT)
X-Received: by 2002:a17:906:f246:b0:c21:61a6:8821 with SMTP id
 a640c23a62f3a-c246a6cd384mr3155045666b.23.1787660994903; 
 Tue, 25 Aug 2026 05:29:54 -0700 (PDT)
Received: from [192.168.10.48] ([151.95.34.92])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c249685c573sm2240958166b.51.2026.08.25.05.29.54
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 25 Aug 2026 05:29:54 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 14/20] target/i386/tcg: decode EVEX prefix
Date: Tue, 25 Aug 2026 14:29:15 +0200
Message-ID: <20260825122921.431739-15-pbonzini@redhat.com>
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

EVEX is really messy and the exact position of the fields is spread all
over the place.  For now store the three data bytes of the prefix in
DisasContext, later the EVEX instruction classes for APX will be added
to extract_evex_params and validate_vex.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/tcg/translate.c      |  8 ++-
 target/i386/tcg/decode-new.c.inc | 86 +++++++++++++++++++++++++++++---
 2 files changed, 84 insertions(+), 10 deletions(-)

diff --git a/target/i386/tcg/translate.c b/target/i386/tcg/translate.c
index 7e50cf2355f..1d6714f3c6c 100644
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
index 08f1fdddf16..37245570751 100644
--- a/target/i386/tcg/decode-new.c.inc
+++ b/target/i386/tcg/decode-new.c.inc
@@ -2047,6 +2047,11 @@ static void decode_REX2_map1(DisasContext *s, CPUX86State *env, X86OpEntry *entr
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
@@ -2074,8 +2079,7 @@ static int reg_nb_mask(DisasContext *s, int unit)
     case X86_OP_MMX:
         return 7;
     case X86_OP_SSE:
-        return 15;
-        break;
+        return s->prefix & PREFIX_EVEX ? 31 : 15;
     default:
         return 31;
         break;
@@ -2467,7 +2471,7 @@ static bool decode_op(DisasContext *s, CPUX86State *env, X86DecodedInsn *decode,
         op->unit = X86_OP_SSE;
     get_vex_v:
         if (s->vex_ndd) {
-            assert(s->prefix & PREFIX_VEX);
+            assert(s->prefix & (PREFIX_VEX | PREFIX_EVEX));
             op->n = s->vex_v;
             break;
         }
@@ -2593,6 +2597,15 @@ static bool decode_insn(DisasContext *s, CPUX86State *env, X86DecodeFunc decode_
     return true;
 }
 
+static bool extract_evex_params(DisasContext *s, X86DecodedInsn *decode)
+{
+    /*
+     * Here, the position of RXB and (for AVX512) displacement multiplier
+     * should be known.
+     */
+    g_assert_not_reached();
+}
+
 static bool decode_ops(DisasContext *s, CPUX86State *env, X86DecodeFunc decode_func,
                        X86DecodedInsn *decode)
 {
@@ -2724,13 +2737,16 @@ static bool validate_vex(DisasContext *s, X86DecodedInsn *decode)
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
@@ -2874,6 +2890,10 @@ static inline uint8_t collapse_two_bits(uint8_t value, uint8_t mask)
     return (value + tweak) & (mask + tweak);
 }
 
+static const int pp_prefix[4] = {
+    0, PREFIX_DATA, PREFIX_REPZ, PREFIX_REPNZ
+};
+
 /*
  * Convert one instruction. s->base.is_jmp is set if the translation must
  * be stopped.
@@ -2899,6 +2919,9 @@ static void disas_insn(DisasContext *s, CPUState *cpu)
     s->vex_v = 0;
     s->vex_w = false;
     s->vex_ndd = false;
+    s->evex2 = 0;
+    s->evex3 = 0;
+    s->evex4 = 0;
     s->has_modrm = false;
     s->prefix = 0;
 
@@ -2982,6 +3005,56 @@ static void disas_insn(DisasContext *s, CPUState *cpu)
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
+            case 0x04:
+#ifdef TARGET_X86_64
+                decode_func = decode_EVEX_map4;
+                break;
+#else
+                goto illegal_op;
+#endif
+            default:   /* Reserved for future use.  */
+                goto unknown_op;
+            }
+        }
+        break;
     case 0xc5: /* 2-byte VEX */
     case 0xc4: /* 3-byte VEX */
         /*
@@ -2989,9 +3062,6 @@ static void disas_insn(DisasContext *s, CPUState *cpu)
          * Otherwise the instruction is LES or LDS.  Not allowed in real mode.
          */
         if (PE(s) && !VM86(s)) {
-            static const int pp_prefix[4] = {
-                0, PREFIX_DATA, PREFIX_REPZ, PREFIX_REPNZ
-            };
             int vex3, vex2 = x86_ldub_code(env, s);
 
             if (!CODE64(s) && (vex2 & 0xc0) != 0xc0) {
@@ -3140,7 +3210,7 @@ static void disas_insn(DisasContext *s, CPUState *cpu)
     }
 
     if (decode.e.vex_class == 0) {
-        if (s->prefix & PREFIX_VEX) {
+        if (s->prefix & (PREFIX_VEX | PREFIX_EVEX)) {
             goto illegal_op;
         }
     } else {
-- 
2.55.0


