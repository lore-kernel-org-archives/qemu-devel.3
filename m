Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 557C4FD006A
	for <qemu-devel@archiver.kernel.org>; Sun,  1 Mar 2026 14:44:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vwi0e-0000Ms-M1; Sun, 01 Mar 2026 09:43:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vwi0W-0000LL-8y
 for qemu-devel@nongnu.org; Sun, 01 Mar 2026 09:43:00 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vwi0U-0005kZ-Cu
 for qemu-devel@nongnu.org; Sun, 01 Mar 2026 09:42:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1772376173;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=6r3NMYQKuV+j4cVljek0aI4LK4YmgmTfG1Jb4diEcjY=;
 b=P1ayPZnGFTOq6yXj5pzNkG1Fq49PEWHxc9XuDD/JSZ6HhvZ/bSpsX9tQebxZuXmtw5jxW9
 CpdZxyfO9ZPxSjFVg/Qh6ASAmr75p0RlUOh1xRcu45EEofUYhkT3DHGcWLVakuziZp2EH6
 WkBqfY76EJkql0qM7E9UE3FFC4pZy+U=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-42-dBUyEx8DMriVZdP_tQ5ZVw-1; Sun, 01 Mar 2026 09:42:51 -0500
X-MC-Unique: dBUyEx8DMriVZdP_tQ5ZVw-1
X-Mimecast-MFC-AGG-ID: dBUyEx8DMriVZdP_tQ5ZVw_1772376171
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-4837a71903aso21644395e9.1
 for <qemu-devel@nongnu.org>; Sun, 01 Mar 2026 06:42:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1772376170; x=1772980970; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=6r3NMYQKuV+j4cVljek0aI4LK4YmgmTfG1Jb4diEcjY=;
 b=Y9P+p7POlGcnA+rMiyqfFMXAuiM25NCQvH0Kd8gzV2l6LbAuJNrqk8uimIRkWSyrR5
 37Ti7krUY96Jg5Y3BLuJAV8xSmDApVMxdXjjDX39nhECZ8FaeRmvFoGIODaSWZKZikwf
 pRglWcvwcuFAtVb3drFNomYrmgA0SblZVOfe4L/NnPvvri0jjAX3mpqH6TzNDfEk1b3Y
 zfFyy3pt9oTBkO9x+bjfv7RaTgSTT2Myo9u739WjfNf0n/iwELkyHwKbVKcsGIaCQbro
 RnDeLr7/R/NkPGZK8n0B8UrLKjvCpso29LdrAKkd6hwymxaW4L2bKjI7sfG7ydsE9uVT
 LONg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772376170; x=1772980970;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=6r3NMYQKuV+j4cVljek0aI4LK4YmgmTfG1Jb4diEcjY=;
 b=pcRRizomTJj6qBPq1OrGsVP2lktiimp/FC+oaDrcTCHBUih8w6VBn9JGYLxk4tF5Vm
 TP+a1IwHeB2UnoOZ7JcGS1hN2V6FenEb+e/NxJbZFlEUH8cGu2wVSFikxUyBItpLjXQH
 tuSxMjWhpwcmXEVIicx+dW3A0++0tMgcnDD6ikmaTnjL4+eXQSx4SeLy8GxX9CPyz4hc
 4/icAvW9Oz3rl/AuVO2o0qBXvsGv5eahBaUncFE0/Lt0ZrSvtvC/2kcHVssEc9N3yOh4
 8/sACAB8yoMUiQDYPBpkQOjFu5reB04Ygvas2154ZkQgqxG/cX2RKeVhqaGWcYw5hg4Y
 Iubg==
X-Gm-Message-State: AOJu0YzEuMVBMzZUV2s+dOB5RX3dVKXkg6Wi/VzBZCFYjEGKcBECKlUF
 3dGYTJE5iroWdF7r6ZkIggnhB3zYHEf3qeFIJ5WntpOmf2EvY8juf6Wa2xSC6IN4LB+7/PzJSu1
 bdtDAfKyti1Sh9CFdxHitV/7/qo5fqfzf39T1SJMAXXIddCdXPtjfSO+expaFhdp0Ri3ZgoPaCw
 fQ+eSmztR/KkPJxlUwJWxBKpf7Rrp5luAZ0zz0sznx
X-Gm-Gg: ATEYQzzLxVjiUAiAZFgfhEuASUiE4393Teg5WHQMZYJMNUgAG5JXmXJYT8s3O8pCZan
 G489FypMAVSEAptAyx8nwoHPka/wBm5Nui5Nj+CBeU/7JgpWQEo7VLNSEO4MleOiOM5M+PpEdrt
 6uPxqDEI3IdgFBzkP+rnO/JrrNJb9MYM1KNBgpTwn+upr+K5EC0NJrF0WtbO8MrXN2v9hTK1WPS
 PhUyfgebP2fW7lH+VsWGF18x5IctYJU6PoSFQ875gglY+SVyFHC8//sAxLL+BHiFkTIcQs9gKa1
 BMWeH5QYDWbp3G4hJ1ukAYOPEXqB79RYQhcRCRRlGtkOwSq66ZeGDBaGkpcmWHxDszKwEB7PaEx
 IuqMrVZrYMdnH4U8rBa1QyL0w6qO85U7NkXjmllhW6iWelrgOvM8otUrMtvOtBzP9AOhJfCsg/8
 A997DJzoXrCacAMiUNOLuOhCDeKGA=
X-Received: by 2002:a05:600c:c16e:b0:482:e5d4:b7ca with SMTP id
 5b1f17b1804b1-483c9bbb8d3mr145755335e9.8.1772376169637; 
 Sun, 01 Mar 2026 06:42:49 -0800 (PST)
X-Received: by 2002:a05:600c:c16e:b0:482:e5d4:b7ca with SMTP id
 5b1f17b1804b1-483c9bbb8d3mr145754835e9.8.1772376168894; 
 Sun, 01 Mar 2026 06:42:48 -0800 (PST)
Received: from [192.168.10.48] ([151.95.144.138])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-483c3b4a121sm221976735e9.8.2026.03.01.06.42.47
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 01 Mar 2026 06:42:47 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 13/18] target/i386/tcg: add decode functionality for APX
Date: Sun,  1 Mar 2026 15:42:13 +0100
Message-ID: <20260301144218.458140-14-pbonzini@redhat.com>
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
index 8650b5ae7a0..1c7ed73c437 100644
--- a/target/i386/tcg/decode-new.h
+++ b/target/i386/tcg/decode-new.h
@@ -187,6 +187,9 @@ typedef enum X86InsnCheck {
 
     /* No 0x67 prefix allowed */
     X86_CHECK_no_adr = 16384,
+
+    /* EVEX.NF bit not allowed */
+    X86_CHECK_nf0 = 32768,
 } X86InsnCheck;
 
 typedef enum X86InsnSpecial {
@@ -274,6 +277,13 @@ typedef enum X86VEXSpecial {
     X86_VEX_AVX2_256,
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
index a74d9b0436e..75eeed81fbd 100644
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
index adb5595ddf3..c80c61befea 100644
--- a/target/i386/tcg/decode-new.c.inc
+++ b/target/i386/tcg/decode-new.c.inc
@@ -253,6 +253,10 @@
 #define vex11 .vex_class = 11,
 #define vex12 .vex_class = 12,
 #define vex13 .vex_class = 13,
+#define evex_apx .vex_class = X86_EVEX_APX,
+#define evex_apx_cmp .vex_class = X86_EVEX_APX_cmp,
+#define evex_apx_pp2 .vex_class = X86_EVEX_APX_pp2,
+#define evex_apx_zu .vex_class = X86_EVEX_APX_zu,
 
 #define chk(a) .check = X86_CHECK_##a,
 #define chk2(a, b) .check = X86_CHECK_##a | X86_CHECK_##b,
@@ -2528,9 +2532,23 @@ static bool validate_sse_prefix(DisasContext *s, X86OpEntry *e)
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
@@ -2602,7 +2620,35 @@ static bool extract_evex_params(DisasContext *s, X86DecodedInsn *decode)
      * Here, the position of RXB and (for AVX512) displacement multiplier
      * should be known.
      */
-    g_assert_not_reached();
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
@@ -2732,6 +2778,87 @@ static bool has_cpuid_feature(DisasContext *s, X86CPUIDFeature cpuid)
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
+        assert(e->s0 == e->s1);
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
+        assert(decode->e.special == 0 && !s->vex_ndd);
+        if (!CODE64(s) || !(s->flags & HF_APX_EN_MASK)) {
+            goto illegal;
+        }
+        if (s->vex_v != 0) {
+            goto illegal;
+        }
+        if (EVEX_APX_ND(s)) {
+            decode->e.special = X86_SPECIAL_Op0_ZU;
+        }
+        evex4_mask = 0x1C;
+        break;
+
+    case X86_EVEX_APX_pp2:
+        if (!CODE64(s) || !(s->flags & HF_APX_EN_MASK) ||
+            !EVEX_APX_ND(s) ||
+            (e->op0 != X86_TYPE_None && s->vex_v == ((decode->b & 7) | REX_B(s))) ||
+            ((decode->b & 7) | REX_B(s)) == 4 ||
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
@@ -2824,14 +2951,32 @@ static bool validate_vex(DisasContext *s, X86DecodedInsn *decode)
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
@@ -3193,6 +3338,9 @@ static void disas_insn(DisasContext *s, CPUState *cpu)
         if ((decode.e.check & X86_CHECK_W1) && !s->vex_w) {
             goto illegal_op;
         }
+        if ((decode.e.check & X86_CHECK_nf0) && EVEX_APX_NF(s)) {
+            goto illegal_op;
+        }
     }
 
     if (op_has_modrm(decode.e.op0) || op_has_modrm(decode.e.op1) ||
@@ -3338,6 +3486,18 @@ static void disas_insn(DisasContext *s, CPUState *cpu)
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
2.52.0


