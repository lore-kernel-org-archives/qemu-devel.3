Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6572BC0218B
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jan 2025 09:47:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tbGFf-0006pf-GF; Fri, 24 Jan 2025 04:45:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tbGFa-0006iu-7r
 for qemu-devel@nongnu.org; Fri, 24 Jan 2025 04:45:18 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tbGFV-0003sB-Gi
 for qemu-devel@nongnu.org; Fri, 24 Jan 2025 04:45:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1737711912;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Yk4DzKWKZjZoPnJ42L2/nSatLr8j0v2WzIzFpqrdX2Y=;
 b=D49+SAw3h0FLnyo0f8fgSDbIVVL5Fm7Iy+3/8A/dE6IPCFdMWshLQD6OSwym3ZR5WnZHqj
 Uii15PINFQZer5kwsW+uuPvG4Cy5Ti2aELusbIo4h7e6+OslfU/inIbt1q36VOwvV+SuQt
 8CFnAQlv+9QBlUhlJCXq+W7OD5cHtEg=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-201-WHxuJMA0MAGyIPtkmAZTbg-1; Fri, 24 Jan 2025 04:45:10 -0500
X-MC-Unique: WHxuJMA0MAGyIPtkmAZTbg-1
X-Mimecast-MFC-AGG-ID: WHxuJMA0MAGyIPtkmAZTbg
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-385ded5e92aso813512f8f.3
 for <qemu-devel@nongnu.org>; Fri, 24 Jan 2025 01:45:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737711908; x=1738316708;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Yk4DzKWKZjZoPnJ42L2/nSatLr8j0v2WzIzFpqrdX2Y=;
 b=ir7AYU7PQGVCkb9x4PfIO7ZKIA77+q6zrSX1e3anGZjYFp6qXfLNiOpn6RJDUwBOew
 ytU6d+SG+4RKJvVkI+hjogGmvdoYRq1IPUwx0x3WVJR3vFGnBoNGxnMSe2FR3veH+d3x
 O8+i4yK/2cGckHz4+fnx6CAlD1NuFWs5hiRK+RMRkL5HflDYy648WGd0yO4xmIwZCGoP
 hHYeVIXt8LC8Ne/mYl5oVVwCUhqdIGxRReLCLjrQnqTdVD6tz6WF6ol5QVhi+lLZmebl
 lZ7ovmFzB4g5i5C7WYiQZjgEKu0+DaV5E2/3uLXqbZDmX25sJUlAgMnqJ+tX/AzmblQe
 I0Hg==
X-Gm-Message-State: AOJu0YyV9YdxY1MtrSVY22s7PbiyPLJwT6tJRNfcaZAk9vR6MWiuDVOS
 7hBKUsxrUAH2DMDYjqkp2cuMWShS0dAmP9kXq5e0+PN/EjiAZErLtPxID8CDyagpDY+t2nU3hHl
 sClM9sXDkPhIUzZ90fbRSCyYuLhQ/qVpnxXPuYztevFFLrFZYKZ1MFr3RpK+FmT6kK96UtSMw1v
 iPmV/PsZSw8jLgGyiRRCk1K/oyAkQZDBJartBJmfE=
X-Gm-Gg: ASbGnctsNut5Cj+L0l8O88S13QYraIKTKl7pWAhJoQOHlSF9KqfgCTXE5I5sVoA6HpR
 bDWGJcugM0qmKYlrhG1ukSA2gUoNG/KDyzclImWE0CEVPjlm41XsLTwIvuBm2SmBd/S/7URl9fm
 pxFhs42hDqP+Wm0Znx/diH/5goaNPM9viLv3IuQ3cEp++0NMKrv++G2thxXbtnbljTyBW1UK4Ce
 pPPUKPF0fUy3E84Ubnp4jBGqVQXxNDKb3vG44U0bTHf5xrvfCvztfqMvn14xnMG/T89Eg0mQA==
X-Received: by 2002:a5d:6d86:0:b0:385:e38f:8cc with SMTP id
 ffacd0b85a97d-38bf59e1e56mr35363882f8f.38.1737711908417; 
 Fri, 24 Jan 2025 01:45:08 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEnIfF1UxOmHuBFjiWF5YXRiyfqdrcpt11qlvrfCoPPUpbwqSgW4o/9DLAtFvT7S3RgsetV9g==
X-Received: by 2002:a5d:6d86:0:b0:385:e38f:8cc with SMTP id
 ffacd0b85a97d-38bf59e1e56mr35363841f8f.38.1737711907893; 
 Fri, 24 Jan 2025 01:45:07 -0800 (PST)
Received: from [192.168.10.48] ([151.95.59.125])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38c2a17650esm2197739f8f.12.2025.01.24.01.45.06
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 24 Jan 2025 01:45:07 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 12/48] target/i386: execute multiple REP/REPZ iterations
 without leaving TB
Date: Fri, 24 Jan 2025 10:44:06 +0100
Message-ID: <20250124094442.13207-13-pbonzini@redhat.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250124094442.13207-1-pbonzini@redhat.com>
References: <20250124094442.13207-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -50
X-Spam_score: -5.1
X-Spam_bar: -----
X-Spam_report: (-5.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.996,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Use a TCG loop so that it is not necessary to go through the setup steps
of REP and through the I/O check on every iteration.  Interestingly, this
is not a particularly effective optimization on its own, though it avoids
the cost of correct RF emulation that was added in the previous patch.
The main benefit lies in allowing the hoisting of loop invariants outside
the loop, which will happen separately.

The loop exits when the low 16 bits of CX/ECX/RCX are zero (so generally
speaking the string operation runs in 65536 iteration batches) to give
the main loop an opportunity to pick up interrupts.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Link: https://lore.kernel.org/r/20241215090613.89588-12-pbonzini@redhat.com
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/tcg/translate.c | 55 +++++++++++++++++++++++++++++++++----
 1 file changed, 49 insertions(+), 6 deletions(-)

diff --git a/target/i386/tcg/translate.c b/target/i386/tcg/translate.c
index 0a8f3c89514..991baf5d829 100644
--- a/target/i386/tcg/translate.c
+++ b/target/i386/tcg/translate.c
@@ -1333,13 +1333,28 @@ static void gen_outs(DisasContext *s, MemOp ot)
     gen_bpt_io(s, s->tmp2_i32, ot);
 }
 
+#define REP_MAX 65535
+
 static void do_gen_rep(DisasContext *s, MemOp ot,
                        void (*fn)(DisasContext *s, MemOp ot),
                        bool is_repz_nz)
 {
+    TCGLabel *last = gen_new_label();
+    TCGLabel *loop = gen_new_label();
     TCGLabel *done = gen_new_label();
+
     target_ulong cx_mask = MAKE_64BIT_MASK(0, 8 << s->aflag);
     TCGv cx_next = tcg_temp_new();
+
+    /*
+     * Check if we must translate a single iteration only.  Normally, HF_RF_MASK
+     * would also limit translation blocks to one instruction, so that gen_eob
+     * can reset the flag; here however RF is set throughout the repetition, so
+     * we can plow through until CX/ECX/RCX is zero.
+     */
+    bool can_loop =
+        (!(tb_cflags(s->base.tb) & (CF_USE_ICOUNT | CF_SINGLE_STEP))
+	 && !(s->flags & (HF_TF_MASK | HF_INHIBIT_IRQ_MASK)));
     bool had_rf = s->flags & HF_RF_MASK;
 
     /*
@@ -1364,19 +1379,29 @@ static void do_gen_rep(DisasContext *s, MemOp ot,
     /* Any iteration at all?  */
     tcg_gen_brcondi_tl(TCG_COND_TSTEQ, cpu_regs[R_ECX], cx_mask, done);
 
-    fn(s, ot);
-
-    tcg_gen_subi_tl(cx_next, cpu_regs[R_ECX], 1);
-
     /*
-     * Write back cx_next to CX/ECX/RCX.  There can be no carry, so zero
-     * extend if needed but do not do expensive deposit operations.
+     * From now on we operate on the value of CX/ECX/RCX that will be written
+     * back, which is stored in cx_next.  There can be no carry, so we can zero
+     * extend here if needed and not do any expensive deposit operations later.
      */
+    tcg_gen_subi_tl(cx_next, cpu_regs[R_ECX], 1);
 #ifdef TARGET_X86_64
     if (s->aflag == MO_32) {
         tcg_gen_ext32u_tl(cx_next, cx_next);
+        cx_mask = ~0;
     }
 #endif
+
+    /*
+     * The last iteration is handled outside the loop, so that cx_next
+     * can never underflow.
+     */
+    if (can_loop) {
+        tcg_gen_brcondi_tl(TCG_COND_TSTEQ, cx_next, cx_mask, last);
+    }
+
+    gen_set_label(loop);
+    fn(s, ot);
     tcg_gen_mov_tl(cpu_regs[R_ECX], cx_next);
     gen_update_cc_op(s);
 
@@ -1388,6 +1413,12 @@ static void do_gen_rep(DisasContext *s, MemOp ot,
 	assert(!s->cc_op_dirty);
     }
 
+    if (can_loop) {
+        tcg_gen_subi_tl(cx_next, cx_next, 1);
+        tcg_gen_brcondi_tl(TCG_COND_TSTNE, cx_next, REP_MAX, loop);
+        tcg_gen_brcondi_tl(TCG_COND_TSTEQ, cx_next, cx_mask, last);
+    }
+
     /*
      * Traps or interrupts set RF_MASK if they happen after any iteration
      * but the last.  Set it here before giving the main loop a chance to
@@ -1400,6 +1431,18 @@ static void do_gen_rep(DisasContext *s, MemOp ot,
     /* Go to the main loop but reenter the same instruction.  */
     gen_jmp_rel_csize(s, -cur_insn_len(s), 0);
 
+    if (can_loop) {
+        /*
+         * The last iteration needs no conditional jump, even if is_repz_nz,
+         * because the repeats are ending anyway.
+         */
+        gen_set_label(last);
+        set_cc_op(s, CC_OP_DYNAMIC);
+        fn(s, ot);
+        tcg_gen_mov_tl(cpu_regs[R_ECX], cx_next);
+        gen_update_cc_op(s);
+    }
+
     /* CX/ECX/RCX is zero, or REPZ/REPNZ broke the repetition.  */
     gen_set_label(done);
     set_cc_op(s, CC_OP_DYNAMIC);
-- 
2.48.1


