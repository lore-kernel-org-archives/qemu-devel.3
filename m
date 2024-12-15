Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 365ABE7716A
	for <qemu-devel@archiver.kernel.org>; Sun, 15 Dec 2024 09:08:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tMkaH-0004X9-T2; Sun, 15 Dec 2024 04:06:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tMkaD-0004WF-Hy
 for qemu-devel@nongnu.org; Sun, 15 Dec 2024 04:06:37 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tMkaB-0006y3-Tz
 for qemu-devel@nongnu.org; Sun, 15 Dec 2024 04:06:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1734253594;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Dafbs10xKmoTxtWUtvU8S+9K7XsF2B4JhpZ07ZD6dXY=;
 b=AQOrrpV55OSwGrT2KjGzsjtvs6ZxV5MEC8rGr/dkRA/DjkgiV+Kdw1WAUhc43HBn+bLHxW
 sKFdszGLb851A3qcqXla8aDTrApmPkjUXNuGelxDdSYHD7sceKATKQhc8xd4FuUPQxxffy
 WpBOo9TvpYx23GtPF7IHJEtRBcAvnII=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-515-ckfCmBejMeqgN3rEE8NQSA-1; Sun, 15 Dec 2024 04:06:33 -0500
X-MC-Unique: ckfCmBejMeqgN3rEE8NQSA-1
X-Mimecast-MFC-AGG-ID: ckfCmBejMeqgN3rEE8NQSA
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-3878ad4bf8cso1918126f8f.1
 for <qemu-devel@nongnu.org>; Sun, 15 Dec 2024 01:06:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734253591; x=1734858391;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Dafbs10xKmoTxtWUtvU8S+9K7XsF2B4JhpZ07ZD6dXY=;
 b=rqwGJTuGeKi3g0NBf/Ja7W7HdjMhjIMEDPlcovcc1J3q+Pfm72MmnM94yl0JNn38Bg
 iT2BWWoZcX+TOWJLtZDBOFGfbgE9uvKC0WC/yVu9dpFE7tcYyIiGG7RYZhoc+vrRiPHn
 Xlz4pPqUayg47UX4zEgN48AcKtKq/CBi1Za59le7zFSUr+r6RfB+2Zurj3/sGmv+JXn9
 RZZupop5so7hVKuFYvp2R/o976hb441RnKz96taT8OdyEMANlIigHucpdSXUI6m7W2h5
 a6KBWxUu9AkEhAU4jG3pAeguX24cj+Na6f05P2aUB2hAwKOXEiMhVY+v07JPEhpqGGlS
 8LPg==
X-Gm-Message-State: AOJu0YylUUlCaF+h2bEJs4k2QF46EBD+JJdPGZ+tyymmf5pIu5ow29C1
 x4k1M48Uz0tvF1JQV4aXmSCUPBId2MAIm5MDCgr3gcUH/Ryi73lDe5Rfi0VoWlTOnvykysicaUp
 nKk2Z4mvKmm2fJE4sG+wOVuEXAYq738svivM/jidPKDAKuSittXdq00Nkvc6GuYH0M1ukKZbpd4
 /48oBl18uu0WtS+ejxCf4R+VCRKIl4na41RLyB
X-Gm-Gg: ASbGncuq70vnOWZvhla01y2URM0nsnBiZBQI5anHw6GbKV3Miay+OoLL2Jnw/qXQVwq
 UDsObJD2U7Ot61PlD9oFcVPxAt2pZ9nSVxYlZmjoai3bebdu53g5UFgs4OaLVibtzZGOPZo/XVK
 mNi45Q9eJ4Ijgyi94y27KQcItAnV1MvQvZ3Yq+AfcvzRDRR7H5Z37hOVqAAXihbjMDMjmBjCcx+
 5evAZdfrMEpzmvQoncaveEDoGyxwguxy1NahlemplD/giajdopRS0R1LxA=
X-Received: by 2002:a05:6000:4b1b:b0:385:dedb:a156 with SMTP id
 ffacd0b85a97d-38880af1254mr7564526f8f.6.1734253590910; 
 Sun, 15 Dec 2024 01:06:30 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGAAtuyechW2rSVsAkbBjZvvBUMuQKGDwGU5oAA6RJetN8vKCWSSb9todVJ0OSDiEce0V9oyw==
X-Received: by 2002:a05:6000:4b1b:b0:385:dedb:a156 with SMTP id
 ffacd0b85a97d-38880af1254mr7564488f8f.6.1734253590433; 
 Sun, 15 Dec 2024 01:06:30 -0800 (PST)
Received: from [192.168.10.3] ([151.81.118.45])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-388c80602a1sm4695991f8f.97.2024.12.15.01.06.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 15 Dec 2024 01:06:28 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org
Subject: [PATCH 05/13] target/i386: reorganize ops emitted by do_gen_rep,
 drop repz_opt
Date: Sun, 15 Dec 2024 10:06:04 +0100
Message-ID: <20241215090613.89588-6-pbonzini@redhat.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241215090613.89588-1-pbonzini@redhat.com>
References: <20241215090613.89588-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.292,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

The condition for optimizing repeat instruction is more or less the
opposite of what you imagine: almost always the string instruction
was _not_ optimized and optimizing the loop relied on goto_tb.
This is obviously not great for performance, due to the cost of the
exit-to-main-loop check, but also wrong.  In fact, after expanding
dc->jmp_opt and simplifying "!!x" to "x", the condition for looping used
to be:

   ((cflags & CF_NO_GOTO_TB) ||
    (flags & (HF_RF_MASK | HF_TF_MASK | HF_INHIBIT_IRQ_MASK))) && !(cflags & CF_USE_ICOUNT)

In other words, setting aside RF (it requires special handling for REP
instructions and it was completely missing), repeat instruction were
being optimized if TF or inhibit IRQ flags were set.  This is certainly
wrong for TF, because string instructions trap after every execution,
and probably for interrupt shadow too.

Get rid of repz_opt completely.  The next patches will reintroduce the
optimization, applying it in the common case instead of the unlikely
and wrong one.

While at it, place the CX/ECX/RCX=0 case is at the end of the function,
which saves a label and is clearer when reading the generated ops.
For clarity, mark the cc_op explicitly as DYNAMIC even if at the end
of the translation block; the cc_op can come from either the previous
instruction or the string instruction, and currently we rely on
a gen_update_cc_op() that is hidden in the bowels of gen_jcc() to
spill cc_op and mark it clean.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/tcg/translate.c | 60 ++++++++-----------------------------
 1 file changed, 13 insertions(+), 47 deletions(-)

diff --git a/target/i386/tcg/translate.c b/target/i386/tcg/translate.c
index 63a39d9f15a..3732d05d5f5 100644
--- a/target/i386/tcg/translate.c
+++ b/target/i386/tcg/translate.c
@@ -112,7 +112,6 @@ typedef struct DisasContext {
 #endif
     bool vex_w; /* used by AVX even on 32-bit processors */
     bool jmp_opt; /* use direct block chaining for direct jumps */
-    bool repz_opt; /* optimize jumps within repz instructions */
     bool cc_op_dirty;
 
     CCOp cc_op;  /* current CC operation */
@@ -1205,23 +1204,6 @@ static inline void gen_jcc(DisasContext *s, int b, TCGLabel *l1)
     }
 }
 
-/* XXX: does not work with gdbstub "ice" single step - not a
-   serious problem.  The caller can jump to the returned label
-   to stop the REP but, if the flags have changed, it has to call
-   gen_update_cc_op before doing so.  */
-static TCGLabel *gen_jz_ecx_string(DisasContext *s)
-{
-    TCGLabel *l1 = gen_new_label();
-    TCGLabel *l2 = gen_new_label();
-
-    gen_update_cc_op(s);
-    gen_op_jnz_ecx(s, l1);
-    gen_set_label(l2);
-    gen_jmp_rel_csize(s, 0, 1);
-    gen_set_label(l1);
-    return l2;
-}
-
 static void gen_stos(DisasContext *s, MemOp ot)
 {
     gen_string_movl_A0_EDI(s);
@@ -1313,27 +1295,25 @@ static void do_gen_rep(DisasContext *s, MemOp ot,
                        void (*fn)(DisasContext *s, MemOp ot),
                        bool is_repz_nz)
 {
-    TCGLabel *l2;
-    l2 = gen_jz_ecx_string(s);
+    TCGLabel *done = gen_new_label();
+
+    gen_update_cc_op(s);
+    gen_op_jz_ecx(s, done);
+
     fn(s, ot);
     gen_op_add_reg_im(s, s->aflag, R_ECX, -1);
     if (is_repz_nz) {
         int nz = (s->prefix & PREFIX_REPNZ) ? 1 : 0;
-        gen_jcc(s, (JCC_Z << 1) | (nz ^ 1), l2);
+        gen_jcc(s, (JCC_Z << 1) | (nz ^ 1), done);
     }
-    /*
-     * A loop would cause two single step exceptions if ECX = 1
-     * before rep string_insn
-     */
-    if (s->repz_opt) {
-        gen_op_jz_ecx(s, l2);
-    }
-    /*
-     * For CMPS/SCAS there is no need to set CC_OP_DYNAMIC: only one iteration
-     * is done at a time, so the translation block ends unconditionally after
-     * this instruction and there is no control flow junction.
-     */
+
+    /* Go to the main loop but reenter the same instruction.  */
     gen_jmp_rel_csize(s, -cur_insn_len(s), 0);
+
+    /* CX/ECX/RCX is zero, or REPZ/REPNZ broke the repetition.  */
+    gen_set_label(done);
+    set_cc_op(s, CC_OP_DYNAMIC);
+    gen_jmp_rel_csize(s, 0, 1);
 }
 
 static void gen_repz(DisasContext *s, MemOp ot,
@@ -3664,20 +3644,6 @@ static void i386_tr_init_disas_context(DisasContextBase *dcbase, CPUState *cpu)
     dc->cpuid_xsave_features = env->features[FEAT_XSAVE];
     dc->jmp_opt = !((cflags & CF_NO_GOTO_TB) ||
                     (flags & (HF_RF_MASK | HF_TF_MASK | HF_INHIBIT_IRQ_MASK)));
-    /*
-     * If jmp_opt, we want to handle each string instruction individually.
-     * For icount also disable repz optimization so that each iteration
-     * is accounted separately.
-     *
-     * FIXME: this is messy; it makes REP string instructions a lot less
-     * efficient than they should be and it gets in the way of correct
-     * handling of RF (interrupts or traps arriving after any iteration
-     * of a repeated string instruction but the last should set RF to 1).
-     * Perhaps it would be more efficient if REP string instructions were
-     * always at the beginning of the TB, or even their own TB?  That
-     * would even allow accounting up to 64k iterations at once for icount.
-     */
-    dc->repz_opt = !dc->jmp_opt && !(cflags & CF_USE_ICOUNT);
 
     dc->T0 = tcg_temp_new();
     dc->T1 = tcg_temp_new();
-- 
2.47.1


