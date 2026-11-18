Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 660DE606A31C
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Nov 2026 12:25:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=d6kGWRwW
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xTeiY-0002v4-Fx; Wed, 18 Nov 2026 07:24:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1xTeiG-0002Yo-Sg
 for qemu-devel@nongnu.org; Wed, 18 Nov 2026 07:24:33 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1xTeiE-00064y-Fu
 for qemu-devel@nongnu.org; Wed, 18 Nov 2026 07:24:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1795004669;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2l6sOKcI+l+kwQqZrnDx7wUAT24U5QDxJsnN6cl60yg=;
 b=d6kGWRwWK5uH9Z68BUjNfQ0QMTp3WH/zIVZ0nOv9TvKxcQWQx0Mo9pquVJpHEYnwr/eUa8
 kb+b23Qf9RAfy16polVdWhegnWAyKMxNU/H6Qkp5vcvB/ZIPpZFyXhlJUTc/vUSXh0OjHC
 j+yIuPsfAgKz2Okv3ypoUr4PYsRm0Fs=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-36-I175dQvxPhmRWYxG-WvF2Q-1; Wed,
 18 Nov 2026 12:24:28 +0000
X-MC-Unique: I175dQvxPhmRWYxG-WvF2Q-1
X-Mimecast-MFC-AGG-ID: I175dQvxPhmRWYxG-WvF2Q_1795004667
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 389421800372
 for <qemu-devel@nongnu.org>; Wed, 18 Nov 2026 12:24:27 +0000 (UTC)
Received: from pbonzini-thinkpadx1carbon6th.rmtit.csb
 (headnet04.pony-001.prod.iad2.dc.redhat.com [10.2.32.116])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 8B53518004FC
 for <qemu-devel@nongnu.org>; Wed, 18 Nov 2026 12:24:26 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [RFC PATCH 25/26] target/i386/tcg: remove checks obsoleted by the
 generated decoder
Date: Wed, 18 Nov 2026 13:23:56 +0100
Message-ID: <20261118122357.659634-26-pbonzini@redhat.com>
In-Reply-To: <20261118122357.659634-1-pbonzini@redhat.com>
References: <20261118122357.659634-1-pbonzini@redhat.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The following can be removed:

- checks on VEX.L, VEX.W, EVEX.NF are replaced by prefix syntax

- i64, o64, no_rex2 are implemented in the decision tree

- LIG clears vex_l in the bytecode

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/tcg/decode-new.h     | 39 ++-------------
 target/i386/tcg/decode-new.c.inc | 86 ++------------------------------
 target/i386/tcg/maketable.py     |  2 +-
 3 files changed, 10 insertions(+), 117 deletions(-)

diff --git a/target/i386/tcg/decode-new.h b/target/i386/tcg/decode-new.h
index f7424d4d33e..1173c0bc88f 100644
--- a/target/i386/tcg/decode-new.h
+++ b/target/i386/tcg/decode-new.h
@@ -42,8 +42,6 @@ typedef enum X86OpType {
     X86_TYPE_W, /* XMM/YMM modrm operand */
 
     /* Custom */
-    X86_TYPE_EM, /* modrm byte selects an ALU memory operand */
-    X86_TYPE_WM, /* modrm byte selects an XMM/YMM memory operand */
     X86_TYPE_I_unsigned, /* Immediate, zero-extended */
     X86_TYPE_nop, /* modrm operand decoded but not loaded into s->T{0,1} */
     X86_TYPE_2op, /* 2-operand RMW instruction */
@@ -127,6 +125,7 @@ typedef enum X86CPUIDFeature {
     X86_FEAT_VAES,
     X86_FEAT_XSAVE,
     X86_FEAT_XSAVEOPT,
+    X86_FEAT_NR,
 } X86CPUIDFeature;
 
 /* Execution flags */
@@ -149,10 +148,6 @@ typedef enum X86OpExt {
 } X86OpExt;
 
 typedef enum X86InsnCheck {
-    /* Illegal or exclusive to 64-bit mode */
-    X86_CHECK_i64 = 1,
-    X86_CHECK_o64 = 2,
-
     /* Fault in vm86 mode */
     X86_CHECK_no_vm86 = 4,
 
@@ -162,15 +157,6 @@ typedef enum X86InsnCheck {
     X86_CHECK_cpl_iopl = 32,
     X86_CHECK_iopl = X86_CHECK_cpl_iopl | X86_CHECK_vm86_iopl,
 
-    /* Fault if VEX.L=1 */
-    X86_CHECK_VEX128 = 64,
-
-    /* Fault if VEX.W=1 */
-    X86_CHECK_W0 = 128,
-
-    /* Fault if VEX.W=0 */
-    X86_CHECK_W1 = 256,
-
     /* Fault outside protected mode, possibly including vm86 mode */
     X86_CHECK_prot_or_vm86 = 512,
     X86_CHECK_prot = X86_CHECK_prot_or_vm86 | X86_CHECK_no_vm86,
@@ -182,14 +168,8 @@ typedef enum X86InsnCheck {
     X86_CHECK_i64_amd = 2048,
     X86_CHECK_o64_intel = 4096,
 
-    /* No REX2 prefix allowed */
-    X86_CHECK_no_rex2 = 8192,
-
     /* No 0x67 prefix allowed */
     X86_CHECK_no_adr = 16384,
-
-    /* EVEX.NF bit not allowed */
-    X86_CHECK_nf0 = 32768,
 } X86InsnCheck;
 
 typedef enum X86InsnSpecial {
@@ -274,12 +254,6 @@ typedef enum X86VEXSpecial {
      * operands, and thus handled by decode_op_size.
      */
     X86_VEX_AVX2_256,
-
-    /*
-     * Instructions that do not care about VEX.L; used for scalar operands, because
-     * they *should* be used only with VEX.L=0 but may accept VEX.L=1 on some machines.
-     */
-    X86_VEX_LIG,
 } X86VEXSpecial;
 
 typedef enum X86EVEXClass {
@@ -470,15 +444,12 @@ struct X86OpEntry {
     X86OpExt     ext0:2;
     X86OpExt     ext1:2;
     X86OpExt     ext2:2;
-    unsigned     :2;
-    X86CPUIDFeature cpuid:8;
-    unsigned     vex_class:8;
-    X86VEXSpecial vex_special:8;
-    unsigned     valid_prefix:16;
-    unsigned     check:16;
-    unsigned     intercept:8;
     bool         has_intercept:1;
     bool         is_decode:1;
+    unsigned     vex_class:8;
+    X86VEXSpecial vex_special:8;
+    unsigned     check:16;
+    unsigned     intercept:8;
 };
 
 typedef struct X86DecodedOp {
diff --git a/target/i386/tcg/decode-new.c.inc b/target/i386/tcg/decode-new.c.inc
index ff7235bc49f..c254ddfc7c3 100644
--- a/target/i386/tcg/decode-new.c.inc
+++ b/target/i386/tcg/decode-new.c.inc
@@ -567,7 +567,6 @@ static bool op_has_modrm(X86OpType type)
     case X86_TYPE_C:  /* REG in the modrm byte selects a control register */
     case X86_TYPE_D:  /* REG in the modrm byte selects a debug register */
     case X86_TYPE_E:  /* ALU modrm operand */
-    case X86_TYPE_EM:  /* modrm byte selects an ALU memory operand */
     case X86_TYPE_G:  /* REG in the modrm byte selects a GPR */
     case X86_TYPE_M:  /* modrm byte selects a memory operand */
     case X86_TYPE_nop:  /* modrm operand decoded but not fetched */
@@ -577,7 +576,6 @@ static bool op_has_modrm(X86OpType type)
     case X86_TYPE_R:  /* R/M in the modrm byte selects a register */
     case X86_TYPE_U:  /* R/M in the modrm byte selects an XMM/YMM register */
     case X86_TYPE_V:  /* reg in the modrm byte selects an XMM/YMM register */
-    case X86_TYPE_WM:  /* modrm byte selects an XMM/YMM memory operand */
     case X86_TYPE_W:  /* XMM/YMM modrm operand */
         return true;
     default:
@@ -686,23 +684,11 @@ static bool decode_op(DisasContext *s, CPUX86State *env, X86DecodedInsn *decode,
     case X86_TYPE_R:  /* R/M in the modrm byte selects a register */
         op->unit = X86_OP_INT;
     get_modrm_reg:
-        if ((s->modrm >> 6) != 3) {
-            return false;
-        }
+        assert((s->modrm >> 6) == 3);
         goto get_modrm;
 
-    case X86_TYPE_WM:  /* modrm byte selects an XMM/YMM memory operand */
-        op->unit = X86_OP_SSE;
-        goto get_modrm_mem;
-
-    case X86_TYPE_EM:  /* modrm byte selects an ALU memory operand */
-        op->unit = X86_OP_INT;
-        /* fall through */
     case X86_TYPE_M:  /* modrm byte selects a memory operand */
-    get_modrm_mem:
-        if ((s->modrm >> 6) == 3) {
-            return false;
-        }
+        assert((s->modrm >> 6) != 3);
         /* fall through */
     case X86_TYPE_nop:  /* modrm operand decoded but not fetched */
     get_modrm:
@@ -780,37 +766,6 @@ static bool decode_op(DisasContext *s, CPUX86State *env, X86DecodedInsn *decode,
     return true;
 }
 
-static bool validate_sse_prefix(DisasContext *s, X86OpEntry *e)
-{
-    uint16_t sse_prefixes;
-
-    switch (e->vex_class) {
-    case X86_EVEX_APX:
-    case X86_EVEX_APX_cmp:
-    case X86_EVEX_APX_pp2:
-    case X86_EVEX_APX_zu:
-        /* For APX-extended instructions, only EVEX versions check the prefix.  */
-        if (!(s->prefix & PREFIX_EVEX)) {
-            return true;
-        }
-
-        /* fallthrough */
-    default:
-        if (!e->valid_prefix) {
-            return true;
-        }
-    }
-
-    if (s->prefix & (PREFIX_REPZ | PREFIX_REPNZ)) {
-        /* In SSE instructions, 0xF3 and 0xF2 cancel 0x66.  */
-        s->prefix &= ~PREFIX_DATA;
-    }
-
-    /* Now, either zero or one bit is set in sse_prefixes.  */
-    sse_prefixes = s->prefix & (PREFIX_REPZ | PREFIX_REPNZ | PREFIX_DATA);
-    return e->valid_prefix & (1 << sse_prefixes);
-}
-
 static bool has_cpuid_feature(DisasContext *s, X86CPUIDFeature cpuid);
 
 #include "decode-table.h"
@@ -988,7 +943,7 @@ static bool extract_evex_params(DisasContext *s, X86DecodedInsn *decode)
         s->vex_v = ((~s->evex4 << 1) & 0x10) | ((~s->evex3 >> 3) & 15);
         break;
     default:
-        return false;
+        g_assert_not_reached();
     }
 
 #ifdef TARGET_X86_64
@@ -1262,10 +1217,6 @@ static bool validate_vex(DisasContext *s, X86DecodedInsn *decode)
     case X86_VEX_None:
         break;
 
-    case X86_VEX_LIG:
-        s->vex_l = 0;
-        break;
-
     case X86_VEX_REPScalar:
         /*
          * Instructions which differ between 00/66 and F2/F3 in the
@@ -1325,9 +1276,7 @@ static bool validate_vex(DisasContext *s, X86DecodedInsn *decode)
         /* fall through */
     case 6:
     case 11:
-        if (!(s->prefix & PREFIX_VEX)) {
-            goto illegal;
-        }
+        assert(!is_mmx(s, e) && (s->prefix & PREFIX_VEX));
         if (!(s->flags & HF_AVX_EN_MASK)) {
             goto illegal;
         }
@@ -1697,26 +1646,14 @@ static void disas_insn(DisasContext *s, CPUState *cpu)
     if (!decode_insn(s, env, map, &decode)) {
         goto unknown_op;
     }
-    if (!validate_sse_prefix(s, &decode.e)) {
-        goto illegal_op;
-    }
-    if (!has_cpuid_feature(s, decode.e.cpuid)) {
-        goto illegal_op;
-    }
 
     /* Checks that result in #UD come first.  */
     if (decode.e.check) {
         if (CODE64(s)) {
-            if (decode.e.check & X86_CHECK_i64) {
-                goto illegal_op;
-            }
             if ((decode.e.check & X86_CHECK_i64_amd) && !IS_INTEL_CPU(env)) {
                 goto illegal_op;
             }
         } else {
-            if (decode.e.check & X86_CHECK_o64) {
-                goto illegal_op;
-            }
             if ((decode.e.check & X86_CHECK_o64_intel) && IS_INTEL_CPU(env)) {
                 goto illegal_op;
             }
@@ -1727,24 +1664,9 @@ static void disas_insn(DisasContext *s, CPUState *cpu)
         if ((decode.e.check & X86_CHECK_no_vm86) && VM86(s)) {
             goto illegal_op;
         }
-        if ((decode.e.check & X86_CHECK_no_rex2) && (s->prefix & PREFIX_REX2)) {
-            goto illegal_op;
-        }
         if ((decode.e.check & X86_CHECK_no_adr) && (s->prefix & PREFIX_ADR)) {
             goto illegal_op;
         }
-        if ((decode.e.check & X86_CHECK_VEX128) && s->vex_l) {
-            goto illegal_op;
-        }
-        if ((decode.e.check & X86_CHECK_W0) && s->vex_w) {
-            goto illegal_op;
-        }
-        if ((decode.e.check & X86_CHECK_W1) && !s->vex_w) {
-            goto illegal_op;
-        }
-        if ((decode.e.check & X86_CHECK_nf0) && EVEX_APX_NF(s)) {
-            goto illegal_op;
-        }
     }
 
     if (op_has_modrm(decode.e.op0) || op_has_modrm(decode.e.op1) ||
diff --git a/target/i386/tcg/maketable.py b/target/i386/tcg/maketable.py
index 0fbdb3b8e32..4abbb0feb2a 100644
--- a/target/i386/tcg/maketable.py
+++ b/target/i386/tcg/maketable.py
@@ -452,7 +452,7 @@ def c_names(path: str, prefix: str) -> frozenset[str]:
 
 
 OPERAND_SIZES = c_names('decode-new.h', 'X86_SIZE_') - {'None'}
-CHECK_NAMES = c_names('decode-new.h', 'X86_CHECK_')
+CHECK_NAMES = frozenset([*c_names('decode-new.h', 'X86_CHECK_'), 'i64', 'o64', 'no_rex2'])
 CPUID_FEATURES = c_names('decode-new.h', 'X86_FEAT_') - {'None', 'NR'}
 SVM_EXITS = c_names('../svm.h', 'SVM_EXIT_')
 
-- 
2.56.0



