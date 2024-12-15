Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 769B0E7716A
	for <qemu-devel@archiver.kernel.org>; Sun, 15 Dec 2024 09:07:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tMkaV-0004eE-MB; Sun, 15 Dec 2024 04:06:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tMkaU-0004dn-PV
 for qemu-devel@nongnu.org; Sun, 15 Dec 2024 04:06:54 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tMkaT-0006zY-6E
 for qemu-devel@nongnu.org; Sun, 15 Dec 2024 04:06:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1734253611;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=acGgMB4ZUdKs37fWXnZnKDTObj/dNL285Lmn4GAtSdY=;
 b=LlpphGMKIxiMQ7cXYoT0m3idjCowk7Z70ZPCAldQKZFQEtVPpQwuDTG5n0geAri7n0oil8
 dn5wMsXiTEnczXphnCqO8nYxdshnOIFDrelIhuQXEpzf4qLyR1DOdVr4v0k4d9mKZAmbSS
 ZgwM2btFutmPLhPiHU/TkQQ/CnLQyfw=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-663-o2un7vbGNLC61w5WYgSFxA-1; Sun, 15 Dec 2024 04:06:50 -0500
X-MC-Unique: o2un7vbGNLC61w5WYgSFxA-1
X-Mimecast-MFC-AGG-ID: o2un7vbGNLC61w5WYgSFxA
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-43582d49dacso27609815e9.2
 for <qemu-devel@nongnu.org>; Sun, 15 Dec 2024 01:06:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734253608; x=1734858408;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=acGgMB4ZUdKs37fWXnZnKDTObj/dNL285Lmn4GAtSdY=;
 b=Q9KSHEYbIcSYZ9V08RHIllz4TBrn3TmihDU6K6G19J4MmgHClmRXeFvfEop/9xoKjI
 zrNXC6PKa0MLDbOmaM/pyvqfTZkbbRxSkhJHi1j8jmF+TkGLUVj2/aOs2gK7qwCRNM9S
 1Tz6ZmcPrDXq8hOFnxAfG7wWvJfK2L45EvMS0ZdXk+BWCAg9oPzDz1X1RvolG3dHGWJh
 5bPJ/0UB/2QSfJGpPG0QFNLzm0yl3/A1MsDKjFROEW335yRAQIYQuYLfCgeqYGGitKsy
 9wa2xmajxRtuhb/6A7UhLUmpBJwWtEA6qkCs2vfB8hdLPN6Mm25TkQCF0Pae0qQ24bnZ
 TFtA==
X-Gm-Message-State: AOJu0YxKA+wtgPgzXisdnvowdu+xv9qHiiJP67Wn5TDkG1Yt2f8iGq5A
 PMRlpCnVDuoLvykq8QUXVfHzEJVxRam4TuNMdLgIUCXlWPMNaXwdoU0mtxayOOjCCNbCpu72pnz
 b9eHd4iQmgWuqSbRmCJdFUSndWXRM3GXLbnIdYew6wAD9hcTbzjilMDebF/0yMafJlMmlVLqL2z
 1o7QQEQt4Uxlbjtnznyxn5RolqDX33tLjAmXZI
X-Gm-Gg: ASbGncsLpNWo7Il+OqSngq5EAN0bw9HaiAdCnNX5jOfRqs9Y4ImiR1WK0BMONhDsj4r
 lteZdXRmXMa/hxUv5N9XdvZ6fJTqZ0Xrz/W0k9OyzVocQgmbNZ+Aymwsedo2JnnYEL7GkuGe5m+
 ++DmUonBFLTPzcAzqa3y8h9O/Qk2r1U0oIdB/UYiZ03Y88zA10SsJh9ILVnN/aYHx6hc+kgqtS2
 Z8bJSIJFGd4+qCL1WFWJswGYNFdXyg/tmmsX9mdxfZ5TYVWsxVHOrKfBXc=
X-Received: by 2002:a5d:59a6:0:b0:385:e5d8:3ec2 with SMTP id
 ffacd0b85a97d-38880ada81amr5975211f8f.28.1734253607979; 
 Sun, 15 Dec 2024 01:06:47 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG8dLJJHHNe/eEwhUHzLWm75h30pKMYt44IkH6wsgF6P8LfDHX6+SSXRUw2OpQWUOXhLhwp4w==
X-Received: by 2002:a5d:59a6:0:b0:385:e5d8:3ec2 with SMTP id
 ffacd0b85a97d-38880ada81amr5975187f8f.28.1734253607439; 
 Sun, 15 Dec 2024 01:06:47 -0800 (PST)
Received: from [192.168.10.3] ([151.81.118.45])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-388c805d489sm4767112f8f.88.2024.12.15.01.06.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 15 Dec 2024 01:06:45 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org
Subject: [PATCH 11/13] target/i386: execute multiple REP/REPZ iterations
 without leaving TB
Date: Sun, 15 Dec 2024 10:06:10 +0100
Message-ID: <20241215090613.89588-12-pbonzini@redhat.com>
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
---
 target/i386/tcg/translate.c | 55 +++++++++++++++++++++++++++++++++----
 1 file changed, 49 insertions(+), 6 deletions(-)

diff --git a/target/i386/tcg/translate.c b/target/i386/tcg/translate.c
index 2ea8a418612..e0f9f7748bc 100644
--- a/target/i386/tcg/translate.c
+++ b/target/i386/tcg/translate.c
@@ -1331,13 +1331,28 @@ static void gen_outs(DisasContext *s, MemOp ot)
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
@@ -1362,19 +1377,29 @@ static void do_gen_rep(DisasContext *s, MemOp ot,
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
 
@@ -1384,6 +1409,12 @@ static void do_gen_rep(DisasContext *s, MemOp ot,
         gen_jcc_noeob(s, (JCC_Z << 1) | (nz ^ 1), done);
     }
 
+    if (can_loop) {
+        tcg_gen_subi_tl(cx_next, cpu_regs[R_ECX], 1);
+        tcg_gen_brcondi_tl(TCG_COND_TSTNE, cx_next, REP_MAX, loop);
+        tcg_gen_brcondi_tl(TCG_COND_TSTEQ, cx_next, cx_mask, last);
+    }
+
     /*
      * Traps or interrupts set RF_MASK if they happen after any iteration
      * but the last.  Set it here before giving the main loop a chance to
@@ -1396,6 +1427,18 @@ static void do_gen_rep(DisasContext *s, MemOp ot,
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
2.47.1


