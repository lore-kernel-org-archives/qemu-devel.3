Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10AACFD006E
	for <qemu-devel@archiver.kernel.org>; Sun,  1 Mar 2026 14:45:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vwi1k-0001GS-6x; Sun, 01 Mar 2026 09:44:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vwi0Y-0000LV-7J
 for qemu-devel@nongnu.org; Sun, 01 Mar 2026 09:43:00 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vwi0V-0005kf-Jh
 for qemu-devel@nongnu.org; Sun, 01 Mar 2026 09:42:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1772376174;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cmC+aGM6B+RmqG1UXe6locEGxQuZMZOjQykwsERH2FE=;
 b=MUfZ9KJg2KXi4xyVsKyNR5h2vr+AIpKayTqZJYLM00QWhqBbig4N5uKnQb3ApDAb73dMN6
 OS1DCJFau9Jg0vMEFiXTqWWOwe4KJAoqmuAt5y/Qj1KrUmSZB6J9KqCwP76R6Gs/0gwK+I
 f2i5NxX3uFJai37RIgUA8LJYa/+kr9s=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-278-Zl1-uXVcMsq9_k6Vu85lug-1; Sun, 01 Mar 2026 09:42:53 -0500
X-MC-Unique: Zl1-uXVcMsq9_k6Vu85lug-1
X-Mimecast-MFC-AGG-ID: Zl1-uXVcMsq9_k6Vu85lug_1772376173
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-439b5511d5aso224488f8f.1
 for <qemu-devel@nongnu.org>; Sun, 01 Mar 2026 06:42:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1772376172; x=1772980972; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=cmC+aGM6B+RmqG1UXe6locEGxQuZMZOjQykwsERH2FE=;
 b=rSFuUTdOKUJZ5yhQL0PkANRs/KmF90RiZN6JzijGqaJiRd15GG6eUSSUYM24wrp4yM
 8GAQFfZtRppTin3Y8M/qwbst2mzNAw0GC3NYLLbkWQ4JD1Ubh9hSIBrxHafTglh5StVM
 13aOxwWzVats81SO585k+/+lzHvvN83aYemCs0o2KxH1j+8FEE7gdstLOuDqrYxdCYtI
 yPjRJ7v1SPSnFJx5vu+KcW1jUe2W8oMj1xWfvlKqABPUAvJQWlEbkMEQpvcI99F8hmBA
 daMZ9v9E0xciBymxegSz4IVhetMeJfnRP3DXm6C2M9XzquxuqxQ/emWHWfokH7OBXWGH
 SL5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772376172; x=1772980972;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=cmC+aGM6B+RmqG1UXe6locEGxQuZMZOjQykwsERH2FE=;
 b=bTINwExHGcWBWBl1tKZzzzYTn08k9Q1qJVOAiRkLcG0H7XbbauwYn2lppf8N36uiAU
 Ra7mfnHL56GEODs129l+E09AGxi3boD+kB4ohO1mL0W7P/3ChUeD5phCR3uJXtHN4+iP
 WtqxI4Gp+lsAJREQY/1O2bYJjIj/mTfsDRX0X+Ii2/hM3MS8ThASRyaQjuD4Fy77m2vz
 s+n/KAkXWmANQGofnCvd1Z7aRSaxbzg9ttd4sJZimbkvvXvOlM3oeO/wOEu8jxRupnEH
 Xo96MsmdkjH83ZvwTj7nVse3Wr6vNSX0WRnCExvHJWmo1alJFgnWTRnCz92DF5UVPiYr
 z1kw==
X-Gm-Message-State: AOJu0YwEWrmIcQ9Kwhf4FtoGgx4FyjbEFrv1h9LCqU8kZfEuJIB2dwfH
 HdwqO+tVJQHNQPmrimXdIIaP0MqSj2wVzQL4gcy0sv5oCsqI7tJoKd4vq7D37RxWLHh+3uR9gcK
 Q56yCNFk9PHu4MNJQaib9fkkw9RgCIqjDI+h9w8du7TolhjC1DRZTIaiMljpDsS3XTPqcYvbIUD
 pciJYpR2ijKCcLhMs6t7nCEFnaH6jVLj6fDJ55u3bs
X-Gm-Gg: ATEYQzxiGOx9ArCka6AzhJwTb9jYi8DYF0do1S+6f3X/lBK+P2rRNbdz99LZHK9xZVP
 tJRP9C8SK9kdgLUrA/bBzXlFGukaFqjfYVI2f1FGGgHETNrHGkuJkXMbYi1XAneFaGbX9OTQ4gv
 U7v4JAggGKv0BaRoiZmx6pHFBoCYc8L8cyM2cl9IZam0+Mvkn2dD9KBcx+l2GtSVXdGUkbQ/Bml
 IKm9Owh58RpuX+0/XxEAl8OQAL1/T/rStQXNR93GnW7lKsfmOrdpBx+L+nNRD9JL0pvMD0ftZr+
 vRLZ4aFw49h9Veq3G0cIU1tHTPe8I1xOMWLEiISFp+SUNfXqOBYneVvIFXNkyAOPKElK/RFiImH
 E0+Uk+WJSfCu/Xxi9nOIxCBPGEXEUeV77qnkaLiayHwXt7Vtgl+m4ddTk2lH1Nso/VELyz86STj
 ACTqr5FIkIXa70z4SLsd+tM+ghX3s=
X-Received: by 2002:a05:6000:144e:b0:439:9605:7daf with SMTP id
 ffacd0b85a97d-4399de2d8afmr16180574f8f.55.1772376171538; 
 Sun, 01 Mar 2026 06:42:51 -0800 (PST)
X-Received: by 2002:a05:6000:144e:b0:439:9605:7daf with SMTP id
 ffacd0b85a97d-4399de2d8afmr16180488f8f.55.1772376170477; 
 Sun, 01 Mar 2026 06:42:50 -0800 (PST)
Received: from [192.168.10.48] ([151.95.144.138])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-439b1b97927sm5640925f8f.28.2026.03.01.06.42.49
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 01 Mar 2026 06:42:49 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 14/18] target/i386/tcg: implement CCMP/CTEST
Date: Sun,  1 Mar 2026 15:42:14 +0100
Message-ID: <20260301144218.458140-15-pbonzini@redhat.com>
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

CCMP/CTEST are new instructions that will either perform a CMP/TEST
or set EFLAGS to a predetermined value.  To support this double
functionality without using CC_OP_DYNAMIC, introduce a new CCOp that
is inspired by x86_flags.h.

By shifting the carry computation part of compute_aco_sub* to TCG ops,
it provides enough flexibility that the result of a subtraction,
the result of an AND, and any value of EFLAGS can be encoded with a
single CCOp.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/cpu.h                        |   5 +
 target/i386/tcg/cc_helper_template.h.inc |  11 ++
 target/i386/tcg/cc_helper.c              |  10 ++
 target/i386/tcg/translate.c              |  63 +++++++++++
 target/i386/tcg/decode-new.c.inc         |  26 ++---
 target/i386/tcg/emit.c.inc               | 137 ++++++++++++++++++++++-
 6 files changed, 238 insertions(+), 14 deletions(-)

diff --git a/target/i386/cpu.h b/target/i386/cpu.h
index 7586ea0ed8d..a542a8b250c 100644
--- a/target/i386/cpu.h
+++ b/target/i386/cpu.h
@@ -1582,6 +1582,11 @@ typedef enum {
     CC_OP_BLSIL,
     CC_OP_BLSIQ,
 
+    CC_OP_CCMPB, /* Z via CC_DST, P,S via CC_SRC2, carry-out in CC_SRC */
+    CC_OP_CCMPW,
+    CC_OP_CCMPL,
+    CC_OP_CCMPQ,
+
     /*
      * Note that only CC_OP_POPCNT (i.e. the one with MO_TL size)
      * is used or implemented, because the translation needs
diff --git a/target/i386/tcg/cc_helper_template.h.inc b/target/i386/tcg/cc_helper_template.h.inc
index af58c2409f7..8ec449fd3ff 100644
--- a/target/i386/tcg/cc_helper_template.h.inc
+++ b/target/i386/tcg/cc_helper_template.h.inc
@@ -60,6 +60,17 @@ static uint32_t glue(compute_aco_cout, SUFFIX)(DATA_TYPE carries)
     return af_cf + of;
 }
 
+static uint32_t glue(compute_all_ccmp, SUFFIX)(DATA_TYPE dst, DATA_TYPE src1, DATA_TYPE src2)
+{
+    uint32_t pf, zf, sf;
+
+    /* Compute all bits here because PF and SF do not come from DST.  */
+    zf = dst == 0 ? CC_Z : 0;
+    pf = compute_pf(src2);
+    sf = lshift(src2, 8 - DATA_BITS) & CC_S;
+    return pf + zf + sf + glue(compute_aco_cout, SUFFIX)(src1);
+}
+
 static uint32_t glue(compute_aco_add, SUFFIX)(DATA_TYPE dst, DATA_TYPE src1)
 {
     DATA_TYPE src2 = dst - src1;
diff --git a/target/i386/tcg/cc_helper.c b/target/i386/tcg/cc_helper.c
index 6ddd64fcb07..a43b42badc0 100644
--- a/target/i386/tcg/cc_helper.c
+++ b/target/i386/tcg/cc_helper.c
@@ -111,6 +111,13 @@ target_ulong helper_cc_compute_all(target_ulong dst, target_ulong src1,
     case CC_OP_ADCOX:
         return compute_all_adcox(dst, src1, src2);
 
+    case CC_OP_CCMPB:
+        return compute_all_ccmpb(dst, src1, src2);
+    case CC_OP_CCMPW:
+        return compute_all_ccmpw(dst, src1, src2);
+    case CC_OP_CCMPL:
+        return compute_all_ccmpl(dst, src1, src2);
+
     case CC_OP_MULB:
         flags = compute_aco_mul(src1);
         goto psz_b;
@@ -232,6 +239,9 @@ target_ulong helper_cc_compute_all(target_ulong dst, target_ulong src1,
         goto psz_l;
 
 #ifdef TARGET_X86_64
+    case CC_OP_CCMPQ:
+        return compute_all_ccmpq(dst, src1, src2);
+
     case CC_OP_MULQ:
         flags = compute_aco_mul(src1);
         goto psz_q;
diff --git a/target/i386/tcg/translate.c b/target/i386/tcg/translate.c
index 75eeed81fbd..b8e5bc55ad9 100644
--- a/target/i386/tcg/translate.c
+++ b/target/i386/tcg/translate.c
@@ -282,6 +282,7 @@ enum {
     JCC_BE,
     JCC_S,
     JCC_P,
+    CCMP_T = JCC_P,
     JCC_L,
     JCC_LE,
 };
@@ -309,6 +310,7 @@ static const uint8_t cc_op_live_[] = {
     [CC_OP_SARB ... CC_OP_SARQ] = USES_CC_DST | USES_CC_SRC,
     [CC_OP_BMILGB ... CC_OP_BMILGQ] = USES_CC_DST | USES_CC_SRC,
     [CC_OP_BLSIB ... CC_OP_BLSIQ] = USES_CC_DST | USES_CC_SRC,
+    [CC_OP_CCMPB ... CC_OP_CCMPQ] = USES_CC_DST | USES_CC_SRC | USES_CC_SRC2,
     [CC_OP_ADCX] = USES_CC_DST | USES_CC_SRC,
     [CC_OP_ADOX] = USES_CC_SRC | USES_CC_SRC2,
     [CC_OP_ADCOX] = USES_CC_DST | USES_CC_SRC | USES_CC_SRC2,
@@ -906,6 +908,7 @@ static CCPrepare gen_prepare_eflags_c(DisasContext *s, TCGv reg)
                              .no_setcond = true };
 
     case CC_OP_SHLB ... CC_OP_SHLQ:
+    case CC_OP_CCMPB ... CC_OP_CCMPQ:
         /* (CC_SRC >> (DATA_BITS - 1)) & 1 */
         size = cc_op_size(s->cc_op);
         return gen_prepare_sign_nz(cpu_cc_src, size);
@@ -973,6 +976,8 @@ static CCPrepare gen_prepare_eflags_s(DisasContext *s, TCGv reg)
                              .imm = CC_S };
     case CC_OP_POPCNT:
         return (CCPrepare) { .cond = TCG_COND_NEVER };
+    case CC_OP_CCMPB ... CC_OP_CCMPQ:
+        return gen_prepare_sign_nz(cpu_cc_src2, cc_op_size(s->cc_op));
     default:
         return gen_prepare_sign_nz(cpu_cc_dst, cc_op_size(s->cc_op));
     }
@@ -992,6 +997,20 @@ static CCPrepare gen_prepare_eflags_o(DisasContext *s, TCGv reg)
         return (CCPrepare) { .cond = TCG_COND_NEVER };
     case CC_OP_MULB ... CC_OP_MULQ:
         return (CCPrepare) { .cond = TCG_COND_NE, .reg = cpu_cc_src };
+
+    case CC_OP_CCMPB ... CC_OP_CCMPQ:
+        if (!reg) {
+            reg = tcg_temp_new();
+        }
+        /*
+         * Sum the carry-out vector and the value of the bit below the MSB;
+         * the XOR of the top two carry bits ends up in the sign bit.
+         */
+        int size = cc_op_size(s->cc_op);
+        target_ulong adj = 1ull << ((8 << size) - 2);
+        tcg_gen_add_tl(reg, cpu_cc_src, tcg_constant_tl(adj));
+        return gen_prepare_sign_nz(reg, size);
+
     default:
         gen_compute_eflags(s);
         return (CCPrepare) { .cond = TCG_COND_TSTNE, .reg = cpu_cc_src,
@@ -1074,6 +1093,50 @@ static CCPrepare gen_prepare_cc(DisasContext *s, int b, TCGv reg)
         }
         goto slow_jcc;
 
+    case CC_OP_CCMPB ... CC_OP_CCMPQ:
+        size = cc_op_size(s->cc_op);
+        switch (jcc_op) {
+            CCPrepare zf;
+
+        case JCC_L:
+        case JCC_LE:
+            if (!reg) {
+                reg = tcg_temp_new();
+            }
+            /*
+             * Sum the carry-out vector and the value of the bit below the MSB;
+             * the XOR of the top two carry bits ends up in the sign bit.
+             */
+            size = s->cc_op - CC_OP_CCMPB;
+            target_ulong adj = 1ull << ((8 << size) - 2);
+            tcg_gen_add_tl(reg, cpu_cc_src, tcg_constant_tl(adj));
+            /* Now XOR in SF too.  */
+            tcg_gen_xor_tl(reg, reg, cpu_cc_src2);
+            /* And possibly OR the zero flag...  */
+            if (jcc_op == JCC_LE) {
+                zf = gen_prepare_val_nz(cpu_cc_dst, size, true);
+                assert(!zf.use_reg2);
+                /* If CPU_CC_DST is zero, set reg to all ones.  */
+                tcg_gen_movcond_tl(zf.cond, reg, zf.reg, tcg_constant_tl(zf.imm),
+                                   tcg_constant_tl(-1), reg);
+            }
+            return gen_prepare_sign_nz(reg, size);
+
+        case JCC_BE:
+            if (!reg) {
+                reg = tcg_temp_new();
+            }
+            /* OR ZF into CF: if CPU_CC_DST is zero, set reg to all ones.  */
+            zf = gen_prepare_val_nz(cpu_cc_dst, size, true);
+            assert(!zf.use_reg2);
+            tcg_gen_movcond_tl(zf.cond, reg, zf.reg, tcg_constant_tl(zf.imm),
+                               tcg_constant_tl(-1), cpu_cc_src);
+            return gen_prepare_sign_nz(reg, size);
+        default:
+            goto slow_jcc;
+        }
+        break;
+
     case CC_OP_LOGICB ... CC_OP_LOGICQ:
         /* Mostly used for test+jump */
         size = s->cc_op - CC_OP_LOGICB;
diff --git a/target/i386/tcg/decode-new.c.inc b/target/i386/tcg/decode-new.c.inc
index c80c61befea..5e559d6ecb5 100644
--- a/target/i386/tcg/decode-new.c.inc
+++ b/target/i386/tcg/decode-new.c.inc
@@ -1581,7 +1581,7 @@ static void decode_63(DisasContext *s, CPUX86State *env, X86OpEntry *entry, uint
 static void decode_group1(DisasContext *s, CPUX86State *env, X86OpEntry *entry, uint8_t *b)
 {
     static const X86GenFunc group1_gen[8] = {
-        gen_ADD, gen_OR, gen_ADC, gen_SBB, gen_AND, gen_SUB, gen_XOR, gen_SUB,
+        gen_ADD, gen_OR, gen_ADC, gen_SBB, gen_AND, gen_SUB, gen_XOR, gen_CMP,
     };
     int op = (get_modrm(s, env) >> 3) & 7;
     entry->gen = group1_gen[op];
@@ -1628,7 +1628,7 @@ static void decode_group3(DisasContext *s, CPUX86State *env, X86OpEntry *entry,
 {
     static const X86OpEntry opcodes_grp3[16] = {
         /* 0xf6 */
-        [0x00] = X86_OP_ENTRYrr(AND, E,b, I,b),
+        [0x00] = X86_OP_ENTRYrr(TEST, E,b, I,b),
         [0x02] = X86_OP_ENTRY1(NOT,  E,b,      lock),
         [0x03] = X86_OP_ENTRY1(NEG,  E,b,      lock),
         [0x04] = X86_OP_ENTRYrr(MUL, E,b, 0,b, zextT0),
@@ -1637,7 +1637,7 @@ static void decode_group3(DisasContext *s, CPUX86State *env, X86OpEntry *entry,
         [0x07] = X86_OP_ENTRYr(IDIV, E,b),
 
         /* 0xf7 */
-        [0x08] = X86_OP_ENTRYrr(AND, E,v, I,z),
+        [0x08] = X86_OP_ENTRYrr(TEST, E,v, I,z),
         [0x0a] = X86_OP_ENTRY1(NOT,  E,v,      lock),
         [0x0b] = X86_OP_ENTRY1(NEG,  E,v,      lock),
         [0x0c] = X86_OP_ENTRYrr(MUL, E,v, 0,v, zextT0),
@@ -1776,8 +1776,8 @@ static const X86OpEntry opcodes_root[256] = {
     [0x81] = X86_OP_GROUP2(group1, E,v, I,z),
     [0x82] = X86_OP_GROUP2(group1, E,b, I,b, chk(i64)),
     [0x83] = X86_OP_GROUP2(group1, E,v, I,b),
-    [0x84] = X86_OP_ENTRYrr(AND, E,b, G,b),
-    [0x85] = X86_OP_ENTRYrr(AND, E,v, G,v),
+    [0x84] = X86_OP_ENTRYrr(TEST, E,b, G,b),
+    [0x85] = X86_OP_ENTRYrr(TEST, E,v, G,v),
     [0x86] = X86_OP_ENTRY2(XCHG, E,b, G,b, xchg),
     [0x87] = X86_OP_ENTRY2(XCHG, E,v, G,v, xchg),
 
@@ -1868,12 +1868,12 @@ static const X86OpEntry opcodes_root[256] = {
     [0x2E] = {},
     [0x2F] = X86_OP_ENTRY0(DAS, chk(i64)),
 
-    [0x38] = X86_OP_ENTRYrr(SUB, E,b, G,b),
-    [0x39] = X86_OP_ENTRYrr(SUB, E,v, G,v),
-    [0x3A] = X86_OP_ENTRYrr(SUB, G,b, E,b),
-    [0x3B] = X86_OP_ENTRYrr(SUB, G,v, E,v),
-    [0x3C] = X86_OP_ENTRYrr(SUB, 0,b, I,b),   /* AL, Ib */
-    [0x3D] = X86_OP_ENTRYrr(SUB, 0,v, I,z),   /* rAX, Iz */
+    [0x38] = X86_OP_ENTRYrr(CMP, E,b, G,b),
+    [0x39] = X86_OP_ENTRYrr(CMP, E,v, G,v),
+    [0x3A] = X86_OP_ENTRYrr(CMP, G,b, E,b),
+    [0x3B] = X86_OP_ENTRYrr(CMP, G,v, E,v),
+    [0x3C] = X86_OP_ENTRYrr(CMP, 0,b, I,b),   /* AL, Ib */
+    [0x3D] = X86_OP_ENTRYrr(CMP, 0,v, I,z),   /* rAX, Iz */
     [0x3E] = {},
     [0x3F] = X86_OP_ENTRY0(AAS, chk(i64)),
 
@@ -1932,8 +1932,8 @@ static const X86OpEntry opcodes_root[256] = {
     [0x9E] = X86_OP_ENTRY0(SAHF),
     [0x9F] = X86_OP_ENTRY0(LAHF),
 
-    [0xA8] = X86_OP_ENTRYrr(AND, 0,b, I,b),   /* AL, Ib */
-    [0xA9] = X86_OP_ENTRYrr(AND, 0,v, I,z),   /* rAX, Iz */
+    [0xA8] = X86_OP_ENTRYrr(TEST, 0,b, I,b),   /* AL, Ib */
+    [0xA9] = X86_OP_ENTRYrr(TEST, 0,v, I,z),   /* rAX, Iz */
     [0xAA] = X86_OP_ENTRYwr(STOS, Y,b, 0,b),
     [0xAB] = X86_OP_ENTRYwr(STOS, Y,v, 0,v),
     /* Manual writeback because REP LODS (!) has to write EAX/RAX after every LODS.  */
diff --git a/target/i386/tcg/emit.c.inc b/target/i386/tcg/emit.c.inc
index 94a2bb49172..685972060c0 100644
--- a/target/i386/tcg/emit.c.inc
+++ b/target/i386/tcg/emit.c.inc
@@ -1649,6 +1649,116 @@ static void gen_CMOVcc(DisasContext *s, X86DecodedInsn *decode)
     gen_cmovcc(s, decode->b & 0xf, s->T0, s->T1);
 }
 
+/* Convert the repurposed V bits from CCMP or CTEST instructions to
+ * an EFLAGS value.
+ */
+static inline uint32_t evex_to_eflags(DisasContext *s)
+{
+    uint16_t eflags = 0;
+    eflags |= (s->evex3 & 0x08 ? CC_C | CC_P : 0);
+    eflags |= (s->evex3 & 0x10 ? CC_Z : 0);
+    eflags |= (s->evex3 & 0x20 ? CC_S : 0);
+    eflags |= (s->evex3 & 0x40 ? CC_O : 0);
+    return eflags;
+}
+
+/* Conditionally fill CC_DST/SRC/SRC2 with values that produce the flag values
+ * in DFV, leaving the output of CCMP/CTEST in place if the condition code
+ * COND is true.  On input, CC_DST contains the result of the subtraction or
+ * AND.  If COND is true, CC_SRC will be loaded with COUT if it is non-NULL,
+ * otherwise with zero (resulting in CF=AF=OF=0).
+ */
+static void gen_dfv_movcond(DisasContext *s, X86DecodedInsn *decode, int cond, uint32_t dfv,
+                            MemOp ot, TCGv cout)
+{
+    target_ulong dst, src, src2;
+    CCPrepare cc = gen_prepare_cc(s, cond, NULL);
+
+    /* ZF from dst */
+    dst = (dfv & CC_Z) ? 0 : -1;
+
+    /* CF is the high bit of SRC, OF the XOR of the high two bits */
+    src = deposit64(0, (8 << ot) - 2, 1, !!(dfv & CC_O));
+    src ^= (dfv & CC_C) ? -1 : 0;
+
+    /*
+     * SF is the high bit of SRC2, PF the parity of the low byte.  But also
+     * ensure the value is nonzero if dfv requests zf=0.  This triggers the
+     * optimization below in some extra cases (e.g. dfv == CC_P)
+     */
+    src2 = dst & 3;
+    src2 ^= (dfv & CC_P) ? 0 : 1;
+    src2 ^= (dfv & CC_S) ? -1 : 0;
+
+    if (!cc.use_reg2) {
+        cc.reg2 = tcg_constant_tl(cc.imm);
+    }
+
+    if (cout) {
+        decode->cc_src = cout;
+        tcg_gen_movcond_tl(cc.cond, decode->cc_src, cc.reg, cc.reg2,
+                           decode->cc_src, tcg_constant_tl(src));
+    } else if (src) {
+        decode->cc_src = tcg_temp_new();
+        tcg_gen_movcond_tl(cc.cond, decode->cc_src, cc.reg, cc.reg2,
+                           tcg_constant_tl(0), tcg_constant_tl(src));
+    } else {
+        decode->cc_src = tcg_constant_tl(0);
+    }
+
+    if (!!dst == !!src2) {
+        /*
+         * When an actual CMP or TEST result is stored, DST will be
+         * equal to SRC2, and when the default flag value is stored,
+         * only zero/nonzero matters for DST.  If DST and SRC2
+         * are equally zero/non-zero, use the same value for both.
+         */
+        decode->cc_src2 = decode->cc_dst;
+        dst = src2;
+    } else {
+        decode->cc_src2 = tcg_temp_new();
+        tcg_gen_movcond_tl(cc.cond, decode->cc_src2, cc.reg, cc.reg2,
+                           decode->cc_dst, tcg_constant_tl(src2));
+    }
+    tcg_gen_movcond_tl(cc.cond, decode->cc_dst, cc.reg, cc.reg2,
+                       decode->cc_dst, tcg_constant_tl(dst));
+}
+
+static void gen_SUB(DisasContext *s, X86DecodedInsn *decode);
+static void gen_CMP(DisasContext *s, X86DecodedInsn *decode)
+{
+    int cond = (s->prefix & PREFIX_EVEX) ? s->evex4 & 0x0f : CCMP_T << 1;
+    uint32_t dfv = evex_to_eflags(s);
+    MemOp ot = decode->op[1].ot;
+    TCGv cout;
+
+    switch (cond) {
+    case CCMP_T << 1:
+        gen_SUB(s, decode);
+        return;
+    case (CCMP_T << 1) | 1:
+        decode->cc_op = CC_OP_EFLAGS;
+        decode->cc_src = tcg_constant_tl(dfv);
+        return;
+    default:
+        break;
+    }
+
+    decode->cc_op = CC_OP_CCMPB + ot;
+    decode->cc_dst = tcg_temp_new();
+    cout = tcg_temp_new();
+    tcg_gen_sub_tl(decode->cc_dst, s->T0, s->T1);
+
+    /* Compute carry-out vector of subtraction.  */
+    tcg_gen_xor_tl(cout, s->T1, decode->cc_dst);
+    tcg_gen_xor_tl(s->T0, s->T0, s->T1);
+    tcg_gen_and_tl(cout, cout, s->T0);
+    tcg_gen_xor_tl(cout, cout, decode->cc_dst);
+
+    /* src2 == dst if cond is true.  */
+    gen_dfv_movcond(s, decode, cond, dfv, ot, cout);
+}
+
 static void gen_CMPccXADD(DisasContext *s, X86DecodedInsn *decode)
 {
     TCGLabel *label_top = gen_new_label();
@@ -3844,7 +3954,6 @@ static void gen_SARX(DisasContext *s, X86DecodedInsn *decode)
     tcg_gen_sar_tl(s->T0, s->T0, s->T1);
 }
 
-static void gen_SUB(DisasContext *s, X86DecodedInsn *decode);
 static void gen_SBB(DisasContext *s, X86DecodedInsn *decode)
 {
     MemOp ot = decode->op[0].ot;
@@ -4158,6 +4267,32 @@ static void gen_SYSRET(DisasContext *s, X86DecodedInsn *decode)
     s->base.is_jmp = DISAS_EOB_RECHECK_TF;
 }
 
+static void gen_TEST(DisasContext *s, X86DecodedInsn *decode)
+{
+    int cond = (s->prefix & PREFIX_EVEX) ? s->evex4 & 0x0f : CCMP_T << 1;
+    uint32_t dfv = evex_to_eflags(s);
+    MemOp ot = decode->op[1].ot;
+
+    switch (cond) {
+    case CCMP_T << 1:
+        gen_AND(s, decode);
+        return;
+    case (CCMP_T << 1) | 1:
+        decode->cc_op = CC_OP_EFLAGS;
+        decode->cc_src = tcg_constant_tl(dfv);
+        return;
+    default:
+        break;
+    }
+
+    decode->cc_op = CC_OP_CCMPB + ot;
+    decode->cc_dst = tcg_temp_new();
+    tcg_gen_and_tl(decode->cc_dst, s->T0, s->T1);
+
+    /* src=0, src2 == dst if cond is true.  */
+    gen_dfv_movcond(s, decode, cond, dfv, ot, NULL);
+}
+
 static void gen_TZCNT(DisasContext *s, X86DecodedInsn *decode)
 {
     MemOp ot = decode->op[0].ot;
-- 
2.52.0


