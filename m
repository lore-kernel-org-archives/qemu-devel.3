Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D859BC61DC2
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2026 12:31:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wyqIA-0004p3-DP; Tue, 25 Aug 2026 08:30:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1wyqI8-0004o5-Hm
 for qemu-devel@nongnu.org; Tue, 25 Aug 2026 08:30:12 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1wyqI5-0000iO-Rx
 for qemu-devel@nongnu.org; Tue, 25 Aug 2026 08:30:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1787661009;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=MCU/Z/Qgmg0aHgmJBeUL3IjPajAZQAUHQQKbxDBwU8Y=;
 b=UXPu5wv/sDC5NhAOZr2iqPsqBC3zOkG+gCMuVb3hhg/qF0rBt4b7zaVpDZlXHRfzcq0eap
 ILT/sQA9FpcbIUMnf8lJxmgrezMIvweaHVhJxHEo3IgOl5PxkJbawJFKy1YAJBlWPDyUo1
 u6nmjY4SXVDolvpUxpxjprNGIaZtjm4=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-694-v-ooD2OXNv6dIjYUewvMlQ-1; Tue, 25 Aug 2026 08:30:06 -0400
X-MC-Unique: v-ooD2OXNv6dIjYUewvMlQ-1
X-Mimecast-MFC-AGG-ID: v-ooD2OXNv6dIjYUewvMlQ_1787661005
Received: by mail-ej1-f69.google.com with SMTP id
 a640c23a62f3a-c15ceb17a28so355782266b.3
 for <qemu-devel@nongnu.org>; Tue, 25 Aug 2026 05:30:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1787661005; x=1788265805; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=MCU/Z/Qgmg0aHgmJBeUL3IjPajAZQAUHQQKbxDBwU8Y=;
 b=bcs4yWkHoj7eFFyZktqndJ3XpxzfNTj7wZl0gpPebxhSPLk0uI1oWeL49s1DSwGzm7
 m1k1zeJQPWHHDSY4Tm0Oy5Ic1WjFJbCom4O2k1AGYIcN+l1vlqn54z/BbWQMByyz2eUq
 zGyqpXADDhWGCjbP0lU3++ri7j3cIrARJaYg3WQ0ru9hicNC/juzZe1YqHLwS4DVU3VC
 6N794wLgcEjmN7OnY/Fcp4XhVfyd4xxjbLFvAz8n/I4tYLIAGfbBGqE5EYSsrDRC+lb+
 2DvCEqrlwy5369bxYwCFHE3L2kGTqNgYJgeOjiyRZ9wSTsWa68PmqnzenqG7kSgQuea7
 Bkbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787661005; x=1788265805;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=MCU/Z/Qgmg0aHgmJBeUL3IjPajAZQAUHQQKbxDBwU8Y=;
 b=WgdwT/sPNNe3S/N/4VylWPQuYJFaZyc9rMBIrrRE5HR1EEcIWYDquaxqG8embuTTYS
 JBCo+bDEWTIHHc/Ryd2QaJB+9Ii8BxNTLn7jiMfSLhcTx72nBq8MUSRdcPQSCOW1tqEF
 L631OC+k4aMbDZN34jijrXKPJklX10MdiYgKy/WI0xWOs1D/51NYZPfHxJiNZ3xVs8ia
 fZykLbYK0nteYa5pd8XiRt0PbObCqE9lMYvpzoYI6a50ylLWhxHgieAZzSEcE3PlZtBZ
 xXTlSp4cIXVovQzF53+AlmIkIAhdlAxlUNfooIUrelTR0dnK5r3d6k7hl1NFpV2tsJiA
 2kOA==
X-Gm-Message-State: AFuF++lJ3OL0hlk7J9OrU/oO++kcTtIZEjNOzYE5AHO9qASbjcOEtqpJ
 T3Auq6dWRNvcIHBBaeFe7iGvblVon3Xq9KQ5nuUoqFzR2gJLqriySt7Fs4ijqTqTnpovJl/PCYJ
 Fi7/FM2SACT+PxGipufgaUM+4LnyAyjFcsZow9TPX1fKjY6qO6aRxMLCrumf7AKJWBDXwGjIitL
 UB46Yi6mkgxnhMLvmZwDauyV1DcaohzJzBz9VLHxXj
X-Gm-Gg: AR+sD11qTcQAyS5GBGTTooA64QY0Qu8eP4KvzJdSAw8SMaBdTYgfIblRuQf5QsUY3z+
 tuq1wX0hZjPFCHZM21ToY5SeQvzxSfgnN6muVZJctZzc4PimBm19ssT8BvGoNfX04hyNF+mFmzy
 n77oVIO5gM0q/duzC3VGcJc/bCWXfw5t5JO67xEg6Nks05lzoWRRmurJ9AxhGRokAaij1Ss0DbL
 BRy9GIPAQu86qTO0zhVbsYoyEYy/Bz3GSJNfL0iXEVwKI/jO5e+0eNCcU00XU7WfuH94NgIxJpr
 Rr9gLJ86QD88dB0Mrkiq07L7aD6rt1TJosmN0dfXamFSCr0hu2eQ9JyQQ/XjljuLfE6RUgw0cPs
 n9rvxH37Ou+aekQpAfmaCri+BmUZhvuNrzhRmnv0X76SAxkBWpdkwsgt0fd8nN+kdnLqrwK92qt
 buFhc=
X-Received: by 2002:a17:907:7241:b0:c24:457b:86fc with SMTP id
 a640c23a62f3a-c24e5bf345cmr703963166b.21.1787661004246; 
 Tue, 25 Aug 2026 05:30:04 -0700 (PDT)
X-Received: by 2002:a17:907:7241:b0:c24:457b:86fc with SMTP id
 a640c23a62f3a-c24e5bf345cmr703943566b.21.1787661003188; 
 Tue, 25 Aug 2026 05:30:03 -0700 (PDT)
Received: from [192.168.10.48] ([151.95.34.92])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c24966f8f2asm1855615866b.36.2026.08.25.05.30.01
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 25 Aug 2026 05:30:01 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 17/20] target/i386/tcg: implement CCMP/CTEST
Date: Tue, 25 Aug 2026 14:29:18 +0200
Message-ID: <20260825122921.431739-18-pbonzini@redhat.com>
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
 target/i386/tcg/translate.c              |  69 ++++++++++++
 target/i386/tcg/decode-new.c.inc         |  30 ++---
 target/i386/tcg/emit.c.inc               | 138 ++++++++++++++++++++++-
 6 files changed, 247 insertions(+), 16 deletions(-)

diff --git a/target/i386/cpu.h b/target/i386/cpu.h
index dc5d48aceea..87f857f9bcb 100644
--- a/target/i386/cpu.h
+++ b/target/i386/cpu.h
@@ -1606,6 +1606,11 @@ typedef enum {
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
index 770a05f7d8d..42213e38962 100644
--- a/target/i386/tcg/translate.c
+++ b/target/i386/tcg/translate.c
@@ -286,6 +286,11 @@ enum {
     JCC_LE,
 };
 
+enum {
+    CCMP_T = JCC_P << 1,
+    CCMP_F,
+};
+
 enum {
     USES_CC_DST  = 1,
     USES_CC_SRC  = 2,
@@ -309,6 +314,7 @@ static const uint8_t cc_op_live_[] = {
     [CC_OP_SARB ... CC_OP_SARQ] = USES_CC_DST | USES_CC_SRC,
     [CC_OP_BMILGB ... CC_OP_BMILGQ] = USES_CC_DST | USES_CC_SRC,
     [CC_OP_BLSIB ... CC_OP_BLSIQ] = USES_CC_DST | USES_CC_SRC,
+    [CC_OP_CCMPB ... CC_OP_CCMPQ] = USES_CC_DST | USES_CC_SRC | USES_CC_SRC2,
     [CC_OP_ADCX] = USES_CC_DST | USES_CC_SRC,
     [CC_OP_ADOX] = USES_CC_SRC | USES_CC_SRC2,
     [CC_OP_ADCOX] = USES_CC_DST | USES_CC_SRC | USES_CC_SRC2,
@@ -908,6 +914,7 @@ static CCPrepare gen_prepare_eflags_c(DisasContext *s, TCGv reg)
                              .rhs_type = CC_PREPARE_DIRECT };
 
     case CC_OP_SHLB ... CC_OP_SHLQ:
+    case CC_OP_CCMPB ... CC_OP_CCMPQ:
         /* (CC_SRC >> (DATA_BITS - 1)) & 1 */
         size = cc_op_size(s->cc_op);
         return gen_prepare_sign_nz(cpu_cc_src, size);
@@ -975,6 +982,8 @@ static CCPrepare gen_prepare_eflags_s(DisasContext *s, TCGv reg)
                              .imm = CC_S };
     case CC_OP_POPCNT:
         return (CCPrepare) { .cond = TCG_COND_NEVER };
+    case CC_OP_CCMPB ... CC_OP_CCMPQ:
+        return gen_prepare_sign_nz(cpu_cc_src2, cc_op_size(s->cc_op));
     default:
         return gen_prepare_sign_nz(cpu_cc_dst, cc_op_size(s->cc_op));
     }
@@ -994,6 +1003,20 @@ static CCPrepare gen_prepare_eflags_o(DisasContext *s, TCGv reg)
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
@@ -1076,6 +1099,52 @@ static CCPrepare gen_prepare_cc(DisasContext *s, int b, TCGv reg)
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
+                goto ccmp_or_zf;
+            }
+            cc = gen_prepare_sign_nz(reg, size);
+            break;
+
+        case JCC_BE:
+            if (!reg) {
+                reg = tcg_temp_new();
+            }
+            tcg_gen_mov_tl(reg, cpu_cc_src);
+        ccmp_or_zf:
+            /* OR ZF into CF: if CPU_CC_DST is zero, set reg to all ones.  */
+            zf = gen_prepare_val_nz(cpu_cc_dst, size, true);
+            if (zf.rhs_type != CC_PREPARE_REG) {
+                zf.reg2 = tcg_constant_tl(zf.imm);
+            }
+            tcg_gen_movcond_tl(zf.cond, reg, zf.reg, zf.reg2, tcg_constant_tl(-1), reg);
+            cc = gen_prepare_sign_nz(reg, size);
+            break;
+
+        default:
+            goto slow_jcc;
+        }
+        break;
+
     case CC_OP_LOGICB ... CC_OP_LOGICQ:
         /* Mostly used for test+jump */
         size = s->cc_op - CC_OP_LOGICB;
diff --git a/target/i386/tcg/decode-new.c.inc b/target/i386/tcg/decode-new.c.inc
index ebbfa4f6592..33d366769e7 100644
--- a/target/i386/tcg/decode-new.c.inc
+++ b/target/i386/tcg/decode-new.c.inc
@@ -1580,7 +1580,7 @@ static void decode_63(DisasContext *s, CPUX86State *env, X86OpEntry *entry, uint
 static void decode_group1(DisasContext *s, CPUX86State *env, X86OpEntry *entry, uint8_t *b)
 {
     static const X86GenFunc group1_gen[8] = {
-        gen_ADD, gen_OR, gen_ADC, gen_SBB, gen_AND, gen_SUB, gen_XOR, gen_SUB,
+        gen_ADD, gen_OR, gen_ADC, gen_SBB, gen_AND, gen_SUB, gen_XOR, gen_CMP,
     };
     int op = (get_modrm(s, env) >> 3) & 7;
     entry->gen = group1_gen[op];
@@ -1627,8 +1627,8 @@ static void decode_group3(DisasContext *s, CPUX86State *env, X86OpEntry *entry,
 {
     static const X86OpEntry opcodes_grp3[16] = {
         /* 0xf6 */
-        [0x00] = X86_OP_ENTRYrr(AND, E,b, I,b),
-        [0x01] = X86_OP_ENTRYrr(AND, E,b, I,b),
+        [0x00] = X86_OP_ENTRYrr(TEST, E,b, I,b),
+        [0x01] = X86_OP_ENTRYrr(TEST, E,b, I,b),
         [0x02] = X86_OP_ENTRY1(NOT,  E,b,      lock),
         [0x03] = X86_OP_ENTRY1(NEG,  E,b,      lock),
         [0x04] = X86_OP_ENTRYrr(MUL, E,b, 0,b, zextT0),
@@ -1637,8 +1637,8 @@ static void decode_group3(DisasContext *s, CPUX86State *env, X86OpEntry *entry,
         [0x07] = X86_OP_ENTRYr(IDIV, E,b),
 
         /* 0xf7 */
-        [0x08] = X86_OP_ENTRYrr(AND, E,v, I,z),
-        [0x09] = X86_OP_ENTRYrr(AND, E,v, I,z),
+        [0x08] = X86_OP_ENTRYrr(TEST, E,v, I,z),
+        [0x09] = X86_OP_ENTRYrr(TEST, E,v, I,z),
         [0x0a] = X86_OP_ENTRY1(NOT,  E,v,      lock),
         [0x0b] = X86_OP_ENTRY1(NEG,  E,v,      lock),
         [0x0c] = X86_OP_ENTRYrr(MUL, E,v, 0,v, zextT0),
@@ -1777,8 +1777,8 @@ static const X86OpEntry opcodes_root[256] = {
     [0x81] = X86_OP_GROUP2(group1, E,v, I,z),
     [0x82] = X86_OP_GROUP2(group1, E,b, I,b, chk(i64)),
     [0x83] = X86_OP_GROUP2(group1, E,v, I,b),
-    [0x84] = X86_OP_ENTRYrr(AND, E,b, G,b),
-    [0x85] = X86_OP_ENTRYrr(AND, E,v, G,v),
+    [0x84] = X86_OP_ENTRYrr(TEST, E,b, G,b),
+    [0x85] = X86_OP_ENTRYrr(TEST, E,v, G,v),
     [0x86] = X86_OP_ENTRY2(XCHG, E,b, G,b, xchg),
     [0x87] = X86_OP_ENTRY2(XCHG, E,v, G,v, xchg),
 
@@ -1869,12 +1869,12 @@ static const X86OpEntry opcodes_root[256] = {
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
 
@@ -1933,8 +1933,8 @@ static const X86OpEntry opcodes_root[256] = {
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
index 8c8adcf3255..48181182aa7 100644
--- a/target/i386/tcg/emit.c.inc
+++ b/target/i386/tcg/emit.c.inc
@@ -1649,6 +1649,117 @@ static void gen_CMOVcc(DisasContext *s, X86DecodedInsn *decode)
     gen_cmovcc(s, decode->b & 0xf, s->T0, s->T1);
 }
 
+/* Convert the repurposed V bits of CCMP or CTEST instructions to
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
+/* If the condition COND is false, fill CC_DST/SRC/SRC2 with values that
+ * produce the flag values in DFV for CC_OP_CCMP*.  If instead COND is true,
+ * set up the flag values from CC_DST and COUT.
+ *
+ * On input, CC_DST contains the result of the subtraction or AND, which
+ * ends up in CC_DST and CC_SRC2 as well.  COUT is non-NULL for CCMP, and will
+ * be used for the output CC_SRC if COND is true; it is NULL for CTEST and
+ * will result in CC_SRC==0 (resulting in CF=AF=OF=0) is COND is true.
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
+     * optimization below in some extra cases (e.g. dfv == CC_P).
+     *
+     * Note dst is either 0 or -1 so it has even parity.
+     */
+    src2 = dst & 3;
+    src2 ^= (dfv & CC_P) ? 0 : 1;
+    src2 ^= (dfv & CC_S) ? -1 : 0;
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
+    int cond = (s->prefix & PREFIX_EVEX) ? s->evex4 & 0x0f : CCMP_T;
+    uint32_t dfv = evex_to_eflags(s);
+    MemOp ot = decode->op[1].ot;
+    TCGv cout;
+
+    switch (cond) {
+    case CCMP_T:
+        gen_SUB(s, decode);
+        return;
+    case CCMP_F:
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
@@ -3857,7 +3968,6 @@ static void gen_SARX(DisasContext *s, X86DecodedInsn *decode)
     tcg_gen_sar_tl(s->T0, s->T0, s->T1);
 }
 
-static void gen_SUB(DisasContext *s, X86DecodedInsn *decode);
 static void gen_SBB(DisasContext *s, X86DecodedInsn *decode)
 {
     MemOp ot = decode->op[0].ot;
@@ -4172,6 +4282,32 @@ static void gen_SYSRET(DisasContext *s, X86DecodedInsn *decode)
     s->base.is_jmp = DISAS_EOB_RECHECK_TF;
 }
 
+static void gen_TEST(DisasContext *s, X86DecodedInsn *decode)
+{
+    int cond = (s->prefix & PREFIX_EVEX) ? s->evex4 & 0x0f : CCMP_T;
+    uint32_t dfv = evex_to_eflags(s);
+    MemOp ot = decode->op[1].ot;
+
+    switch (cond) {
+    case CCMP_T:
+        gen_AND(s, decode);
+        return;
+    case CCMP_F:
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
2.55.0


