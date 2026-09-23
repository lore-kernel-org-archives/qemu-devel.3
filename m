Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04DBBC98302
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Sep 2026 17:33:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x9Qpx-0008Tm-II; Wed, 23 Sep 2026 13:32:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1x9QoB-0006sm-Sl
 for qemu-devel@nongnu.org; Wed, 23 Sep 2026 13:31:07 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1x9Qo9-0003lF-MQ
 for qemu-devel@nongnu.org; Wed, 23 Sep 2026 13:31:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1790184660;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=jgOMb7SjXuk3u4/2YZ1h0BpaB3cHG3WQBao057QStLA=;
 b=IImzkS1d8+MhkVFvB5wUnoSo3YaM+Et/RjbklRTfpqd8vbaBLsRwy2UB8S+BoUj26rlFuF
 RYegEZoOayFqBGwYacpnV97bx/t8/lFOWkOryKcVH5KVgmUtSM/lKKMAswgx7iJbgaOF3t
 aLJvgrWUM6Jqx8bYYooUlezxn5JNhcE=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-593-tk7Qd-nnNA6pvndv_tKnVQ-1; Wed, 23 Sep 2026 13:30:58 -0400
X-MC-Unique: tk7Qd-nnNA6pvndv_tKnVQ-1
X-Mimecast-MFC-AGG-ID: tk7Qd-nnNA6pvndv_tKnVQ_1790184657
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-48701401090so1039312f8f.3
 for <qemu-devel@nongnu.org>; Wed, 23 Sep 2026 10:30:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1790184657; x=1790789457; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=jgOMb7SjXuk3u4/2YZ1h0BpaB3cHG3WQBao057QStLA=;
 b=a1w93VxGgcUPnzuDqR4sAM7dbXxeo6XCPXucc28M/QrVEEAeq8LK9T90ueSA/TKZho
 +OLWx4EstHqpR3yFz5R8jTVqFF+F6sz2Y4xXYbTGhDbu1I83HNg6Xl3eYaXG56ulGVz4
 Hl5gCz5YUuDbusHssBJYwiLaXqLPnrdRHEuONhk8yagaG3C653mx63sZILEB/ZFpG87Z
 zYs3MF3/R+h9Emagn0M5C7tLhMv1iHh8yYvoDqdz+/t3twY9DSn+pQkZRIun9tTHpnBg
 GmKdpeVHLn80GRVCoN204Na1S3MIZF/LRGDMVTMq+JX08ek64TPy7UUIIhgcRK2lksw3
 3Vvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790184657; x=1790789457;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=jgOMb7SjXuk3u4/2YZ1h0BpaB3cHG3WQBao057QStLA=;
 b=MFFYH8JSKSVW7KhZQKX+hd6WRo32lVE7mzmFbKhmX78jXnfkpT8iy7+DzJRgOX6/nE
 YdPRP+clqVlQ3mjek7F5dWMY9SGKnhk47WtWfmOLT6Kmezx36gTH/+X3HiDfuLIannKG
 xbOxSX3zQabB42cz9qmyAAQcEh+rSOuWRc+X8t0lvuuifBLv15sZvHZbcPMzcCTsjI+6
 Hjov2bQVEXcERqC/nioffYtOTSwQf9GbO6BczGWio8YfeTCI4TKGJ6PUOoF82znKJNR5
 BaUu1KXsBKbL7u5jNd7KL0LjnJ/ptc3pttunMV7g2H7jWJ1vKx6Uqtevr/TPCOHxdyk4
 mllQ==
X-Gm-Message-State: AFuF++lO7j8UwF8x0IZIhF+sjQm9KW3jzoQ8YdxXt/qmMy+P4D/3anjO
 Oxu9ONBIqdeq+noWIoOP/BnhZ22uN/kVsD7LxcEu3D5XBApTePTlNEhYQL9XIQQC8JFmzrVOgv/
 cumZiNpGAdo39CMu+05zzz96R0+FbHOmV63h4rIe3A5H6MDrKKtry9CVUsMbRS/W9OdRyceCoH8
 xJ22sXm3pB3pmM4DqDT3+jA/cwmm5wfq3dEaprOmlC
X-Gm-Gg: AYBFou0RH0U+YkhR+NVwr/YEKKKqLgVzRln8iiyRr7b+Gr1tw4FfC85oZ/JB2SHZe1g
 c9dNYK34SvTU6A8Y6xZ1shHPTdpBtEKq2nXGz7aiii3rBxI3Y7WAwjqp8Q2EYa38Cu/E3TrwIOa
 wZGTog6//CLA/f5Eq1h8i/fW2FdXnG1Yyqw8tT0pwGPvgWTfPQ8njvR6FWErEkoVCYh3kqFLEVq
 leueEjDnqYzJOf14aYzRcOHnvfoHdUEEzaQtNWY4mv/Z+QXAU1y9ESBwjfgP6dBHThX+Jjyn+5l
 6o3towz1udFIScDqCwkjK4TUH45CSN6h5DWTnj5hfd0/esBUjc/I44jNxSYvZBdRHA1ckMeHCfY
 mXZGXW59KOu7+7rPplfyeGyKjCoJ6hPkP817w2XWyfy9jEBXUH6Pbp14zDzlzv6HCZN8PnTfUZ2
 S06mL3JxrO7YsIlhw=
X-Received: by 2002:a05:6000:710:b0:487:27f9:840 with SMTP id
 ffacd0b85a97d-488670a09d6mr6102010f8f.53.1790184657108; 
 Wed, 23 Sep 2026 10:30:57 -0700 (PDT)
X-Received: by 2002:a05:6000:710:b0:487:27f9:840 with SMTP id
 ffacd0b85a97d-488670a09d6mr6101960f8f.53.1790184656570; 
 Wed, 23 Sep 2026 10:30:56 -0700 (PDT)
Received: from [192.168.10.48] ([151.49.232.249])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4886876c64dsm8470023f8f.21.2026.09.23.10.30.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Sep 2026 10:30:56 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: chang.seok.bae@intel.com,
	zhao1.liu@intel.com
Subject: [PATCH 13/17] target/i386/tcg: add decode functionality for APX
Date: Wed, 23 Sep 2026 19:30:17 +0200
Message-ID: <20260923173021.317809-14-pbonzini@redhat.com>
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
index cbc85498a1c..ec65ae5d75b 100644
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
index c28cd9809e9..c35869ab500 100644
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
index 10c6833bb3c..b2e6dd3a488 100644
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
@@ -2608,7 +2626,35 @@ static bool extract_evex_params(DisasContext *s, X86DecodedInsn *decode)
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
@@ -2834,14 +2961,32 @@ static bool validate_vex(DisasContext *s, X86DecodedInsn *decode)
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
@@ -3217,6 +3362,9 @@ static void disas_insn(DisasContext *s, CPUState *cpu)
         if ((decode.e.check & X86_CHECK_W1) && !s->vex_w) {
             goto illegal_op;
         }
+        if ((decode.e.check & X86_CHECK_nf0) && EVEX_APX_NF(s)) {
+            goto illegal_op;
+        }
     }
 
     if (op_has_modrm(decode.e.op0) || op_has_modrm(decode.e.op1) ||
@@ -3352,6 +3500,18 @@ static void disas_insn(DisasContext *s, CPUState *cpu)
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


