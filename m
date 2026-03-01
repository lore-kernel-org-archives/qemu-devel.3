Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A36BDFD0057
	for <qemu-devel@archiver.kernel.org>; Sun,  1 Mar 2026 14:45:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vwi0c-0000Mq-HF; Sun, 01 Mar 2026 09:43:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vwi0Q-0000Kj-Bb
 for qemu-devel@nongnu.org; Sun, 01 Mar 2026 09:42:50 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vwi0O-0005jw-Gg
 for qemu-devel@nongnu.org; Sun, 01 Mar 2026 09:42:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1772376167;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4eBK8AnVwgKx0FlEmo7EO5eeaEg2CsCP5eW4vx1Ig1o=;
 b=DNYOFHoz7HnbfRbjLP7xB1NUkyfL6fJ+3WsE08KMFnQ2arqFuWd6AItBYddSclwUBSrPR4
 86SXjaCKQ4KlY27899TJeH01E6/LH2aHEukpXX1TtTT2HlON6n15H8kILWk3gf+UE791aN
 G+RVbmVZQR47cHvYOf+ERbiUnqL3vVs=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-8-kRm9wHI1OJap-l_2mSLaMg-1; Sun, 01 Mar 2026 09:42:46 -0500
X-MC-Unique: kRm9wHI1OJap-l_2mSLaMg-1
X-Mimecast-MFC-AGG-ID: kRm9wHI1OJap-l_2mSLaMg_1772376165
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-439b6c9766aso61750f8f.0
 for <qemu-devel@nongnu.org>; Sun, 01 Mar 2026 06:42:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1772376165; x=1772980965; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=4eBK8AnVwgKx0FlEmo7EO5eeaEg2CsCP5eW4vx1Ig1o=;
 b=te3hKW5zEwMjk/Q/AEpljrprBhp9nGOoTTlTNt5/CEEipKqADKPcqOWXWIoipzJtpB
 P/YeUPPIZQ+wpAbq6bQRu1YQedBkK10DTXYiNVhG0e8EoefRSt895Jxs34HILrxdXm33
 sElM47LNb+rPEGC/5QTSX7FuwhLdhrF1gkcSvpLUgXki3j5BXXiFZwEawPlYtDejTDUu
 MzIAg/UiHD52zyxuU0QVML6GbKOFEIjNvGdrVgLKAU+159xSl5Cgdw3bFAe4KDs9sAu7
 j+2VcA5Yytuo0aKFHaZfALA4sVFDPBo3WTJvlFsLmdwaaMFOHjcCqFmLCQpcuQzXz//a
 9qsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772376165; x=1772980965;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=4eBK8AnVwgKx0FlEmo7EO5eeaEg2CsCP5eW4vx1Ig1o=;
 b=S6qeJeT5YPA/LGG/VdxiO2XaIHxLTP6bpCBIkN74MWKOo9anavPZ3A+jlqarbqEp97
 MgpSvefC/qazjqWgExi/AxAgja1l64J9ejRneWxKQzms4a7/pj7hTXAOf0sDOyFKf502
 kUVsjG57gL07ojSjBR0kQGyTpb03Dv5a4OawW7JXzddrMuPEW8KBvpXkGRHsGaKtkzDl
 CoywEgiWwap8usqtofcNNGENUCdlR2HrOO08QGyTHld+cpCoajKNO37go7fPOD+4eG+C
 9DVjAdRqhjFNIpVyZjd5CtPr5uD89eyt0KL22DPwNCT2OEjE0zLr2uNOc4ZPskLj/q3d
 uspA==
X-Gm-Message-State: AOJu0YwZXw/hAHNfr7Qiv/uxeewuQcBpksPKMVnLJozwbECQ2jEJgSCD
 mGwQTcT2SQ1mGZ7HIr0ne4KvYbeUmHGxWYPpsIheAy3bcCV2GKgSaCSXA96uZzi6kFr4E1Hmj7f
 7s5+PdqA9tolknHswZjrQeJIRcG4ogxqlDNVQhUobLHYqHkxM73TeaO2gRca2h7dwQckF3+DBDS
 JIqW/oXlj520OINja9uANOvHat1OUjvXfAzC88sJCm
X-Gm-Gg: ATEYQzyOFla5hGkebZEWkpcunE+WuRH05Hy76GvsZAUcvZp396v66qvRdS3FaRPneiU
 BbgBnd4WCleFGLUCYlDnyjmnExYBThcEDJpMdXQXKd5bLnAEa6Te/rA5bmSPjHAQlt/Nn63vguF
 vVB6Yx4v9syZJ94RebV9pbQ68yNQsEauJCkvcpzmkQ3sXOR2VuAQPVSUhJpFB9UMDdqULTBMqTJ
 NJw4gBU2c16U6TwLELilO3WKPiUOZyIIp/8M7HRExnDjdgwM3bDphD98WIQ26mPbK19Mm5HISsj
 bDfCibTnrwtKTMdBlP9oTkWJdAWNYgu2XyaoPnuwTfAHWeKihDuR+FTgL6aOhMpvNaGowNtahRT
 ogt9fbrxWxD4BxGPDZ5U/TM9DQeUUgEUhKBRQQcvggkkaeLXrnkHvLRWBBwRoXg8r0vpDZf9tPy
 ChP2BYZz/ftG2oG/zEn8gboaRf/eA=
X-Received: by 2002:a05:600c:4ece:b0:480:69ae:f0e9 with SMTP id
 5b1f17b1804b1-483c9bbbf04mr175563525e9.16.1772376164606; 
 Sun, 01 Mar 2026 06:42:44 -0800 (PST)
X-Received: by 2002:a05:600c:4ece:b0:480:69ae:f0e9 with SMTP id
 5b1f17b1804b1-483c9bbbf04mr175562925e9.16.1772376164022; 
 Sun, 01 Mar 2026 06:42:44 -0800 (PST)
Received: from [192.168.10.48] ([151.95.144.138])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-439b41831easm4344357f8f.12.2026.03.01.06.42.43
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 01 Mar 2026 06:42:43 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 11/18] target/i386/tcg: decode EVEX prefix
Date: Sun,  1 Mar 2026 15:42:11 +0100
Message-ID: <20260301144218.458140-12-pbonzini@redhat.com>
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

EVEX is really messy and the exact position of the fields is spread all
over the place.  For now store the three data bytes of the prefix in
DisasContext, later the EVEX instruction classes for APX will be added
to extract_evex_params and validate_vex.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/tcg/translate.c      |  8 +++-
 target/i386/tcg/decode-new.c.inc | 80 ++++++++++++++++++++++++++++++--
 2 files changed, 81 insertions(+), 7 deletions(-)

diff --git a/target/i386/tcg/translate.c b/target/i386/tcg/translate.c
index 9bf4a1fd516..a74d9b0436e 100644
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
index b7988c64f86..c14a07be5ff 100644
--- a/target/i386/tcg/decode-new.c.inc
+++ b/target/i386/tcg/decode-new.c.inc
@@ -2046,6 +2046,11 @@ static void decode_REX2_map1(DisasContext *s, CPUX86State *env, X86OpEntry *entr
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
@@ -2073,8 +2078,7 @@ static int reg_nb_mask(DisasContext *s, int unit)
     case X86_OP_MMX:
         return 7;
     case X86_OP_SSE:
-        return 15;
-        break;
+        return s->prefix & PREFIX_EVEX ? 31 : 15;
     default:
         return 31;
         break;
@@ -2592,6 +2596,15 @@ static bool decode_insn(DisasContext *s, CPUX86State *env, X86DecodeFunc decode_
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
@@ -2730,6 +2743,9 @@ static bool validate_vex(DisasContext *s, X86DecodedInsn *decode)
             s->vex_ndd = true;
         }
     }
+    if ((s->prefix & PREFIX_EVEX) && !extract_evex_params(s, decode)) {
+        goto illegal;
+    }
 
     switch (e->vex_special) {
     case X86_VEX_None:
@@ -2873,6 +2889,10 @@ static inline uint8_t collapse_two_bits(uint8_t value, uint8_t mask)
     return value + (value > low ? tweak : 0);
 }
 
+static const int pp_prefix[4] = {
+    0, PREFIX_DATA, PREFIX_REPZ, PREFIX_REPNZ
+};
+
 /*
  * Convert one instruction. s->base.is_jmp is set if the translation must
  * be stopped.
@@ -2898,6 +2918,9 @@ static void disas_insn(DisasContext *s, CPUState *cpu)
     s->vex_v = 0;
     s->vex_w = false;
     s->vex_ndd = false;
+    s->evex2 = 0;
+    s->evex3 = 0;
+    s->evex4 = 0;
     s->has_modrm = false;
     s->prefix = 0;
 
@@ -2973,6 +2996,56 @@ static void disas_insn(DisasContext *s, CPUState *cpu)
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
@@ -2980,9 +3053,6 @@ static void disas_insn(DisasContext *s, CPUState *cpu)
          * Otherwise the instruction is LES or LDS.  Not allowed in real mode.
          */
         if (PE(s) && !VM86(s)) {
-            static const int pp_prefix[4] = {
-                0, PREFIX_DATA, PREFIX_REPZ, PREFIX_REPNZ
-            };
             int vex3, vex2 = x86_ldub_code(env, s);
 
             if (!CODE64(s) && (vex2 & 0xc0) != 0xc0) {
-- 
2.52.0


