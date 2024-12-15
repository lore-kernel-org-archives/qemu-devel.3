Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4CA90E7716A
	for <qemu-devel@archiver.kernel.org>; Sun, 15 Dec 2024 09:08:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tMkaD-0004W8-Hq; Sun, 15 Dec 2024 04:06:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tMka4-0004Sy-To
 for qemu-devel@nongnu.org; Sun, 15 Dec 2024 04:06:30 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tMka3-0006wy-6S
 for qemu-devel@nongnu.org; Sun, 15 Dec 2024 04:06:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1734253585;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=I/9GAD92u+pnNvpDHvZE6faR5pj8MJQ9gNr1CMb/few=;
 b=cqv+SSN4rvOftyHZgdba8U/1Dh2KJ3aVM9u/ZZY8rAo6jaa1tQjZEij5+xJ0bvFTjf09ga
 WR6XbCEq7/UG36m8n3fwPxC6LTA0eB/cZdjVEMs4oTYFGjURpq69k3nUUPOeunklLoMyHm
 S6SCIx8gyHyPH29VcAoiHURiIldc6zU=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-120-aVYUh56fNbC2qZgn8qwjaw-1; Sun, 15 Dec 2024 04:06:23 -0500
X-MC-Unique: aVYUh56fNbC2qZgn8qwjaw-1
X-Mimecast-MFC-AGG-ID: aVYUh56fNbC2qZgn8qwjaw
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-43627bb20b5so22286545e9.1
 for <qemu-devel@nongnu.org>; Sun, 15 Dec 2024 01:06:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734253581; x=1734858381;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=I/9GAD92u+pnNvpDHvZE6faR5pj8MJQ9gNr1CMb/few=;
 b=ZtWg0iMLXmH7dRiNgmJQ2W/vh6uFkjp93H71zIJmdoFZYpxywdpb+MFvv+T3cTZzDa
 B+a5oO0KnCL8kPBYTIT/n6RL56g8GmbxtxUTHEOVvaeKW8UMIyvO8pV8yXZT4SIylfjW
 wa6SCwvBMLhT5nKij8Uk7jK4l6Ya8fCpo+ZFTgNzevQGc/bK3jjoWwHK6Z4RY1USKUZD
 K560QhYCX9IHo9ACCgoCLHxFVJcbJyE3zxdmQ0pYX5IWL0N7khBIGp/hZxpZInhmt9Wt
 t0PSJvYNvjKmhf2+y89Ph5L5vwgKRlhU8uDtKfe6XosMotivE9/VsEoEAwMT5mWkoFsr
 lThA==
X-Gm-Message-State: AOJu0Yx9JolFzOjXeReS5bHGPgzj9KKgkwynTmmMmrvGwz1E+sfs64K0
 pttyIuL0lM0BfcD3SZ72QvOEZ3d+Q+UFBbWFNo7Gi2ETFY+It3QbhRTySfIGDDQXwGhFIjtDzqE
 esCJTe/b/2palhHgbWXjgX8hUxR38wmXJkQDgSIgXraMLVCWxuWbYcZgzHlbtKspKAMtc5nBpeD
 nvrCsNktkkc87JCklQ6GspZ8Lq5aoTKV7hhg/T
X-Gm-Gg: ASbGncsi2hfpJ/46KDuzxbleZFHv9AqTu/W0FtVSBklDiUTlp7luHFK+P8/u2WxQfoh
 fUIyZDnfLBLk3KhVwXf66BEP4Nz4DQaUOwiB+rhXHoswHt/T2AQ1l1Wdqru8X4J3BCp1soxzv9e
 eJpMV8GR/raolGyJbKZuXZHfrjipei0rWm/nrlcNmqSPQh8O7NW9rhkW+ugXjAUurImu9dSN5E0
 A7Vi8QTnfYABivCJPRuORjSdmQAyk2B4qwgHbn8+vIng0/0sHIskVQBMS0=
X-Received: by 2002:a05:600c:c11:b0:431:93d8:e1a1 with SMTP id
 5b1f17b1804b1-4362aaa8cfemr73916815e9.27.1734253581279; 
 Sun, 15 Dec 2024 01:06:21 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHUoODYly/7cDX3sVJr7w75qJhLu0P/ojvrYjucCC4sH3SlFfJTO+KxQcfP3P6/bMg5BveOiQ==
X-Received: by 2002:a05:600c:c11:b0:431:93d8:e1a1 with SMTP id
 5b1f17b1804b1-4362aaa8cfemr73916465e9.27.1734253580802; 
 Sun, 15 Dec 2024 01:06:20 -0800 (PST)
Received: from [192.168.10.3] ([151.81.118.45])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-436362b6841sm48046295e9.28.2024.12.15.01.06.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 15 Dec 2024 01:06:19 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org
Subject: [PATCH 02/13] target/i386: remove trailing 1 from gen_{j, cmov,
 set}cc1
Date: Sun, 15 Dec 2024 10:06:01 +0100
Message-ID: <20241215090613.89588-3-pbonzini@redhat.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241215090613.89588-1-pbonzini@redhat.com>
References: <20241215090613.89588-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
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

This is not needed anymore now that gen_jcc has been eliminated
(merged into the similarly-named gen_Jcc, where the uppercase letter
gives away that it is an emission function).

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/tcg/translate.c | 14 +++++++-------
 target/i386/tcg/emit.c.inc  | 10 +++++-----
 2 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/target/i386/tcg/translate.c b/target/i386/tcg/translate.c
index 298842d46b6..99e989d4b22 100644
--- a/target/i386/tcg/translate.c
+++ b/target/i386/tcg/translate.c
@@ -1147,7 +1147,7 @@ static CCPrepare gen_prepare_cc(DisasContext *s, int b, TCGv reg)
     return cc;
 }
 
-static void gen_setcc1(DisasContext *s, int b, TCGv reg)
+static void gen_setcc(DisasContext *s, int b, TCGv reg)
 {
     CCPrepare cc = gen_prepare_cc(s, b, reg);
 
@@ -1169,12 +1169,12 @@ static void gen_setcc1(DisasContext *s, int b, TCGv reg)
 
 static inline void gen_compute_eflags_c(DisasContext *s, TCGv reg)
 {
-    gen_setcc1(s, JCC_B << 1, reg);
+    gen_setcc(s, JCC_B << 1, reg);
 }
 
 /* generate a conditional jump to label 'l1' according to jump opcode
    value 'b'. In the fast case, T0 is guaranteed not to be used. */
-static inline void gen_jcc1_noeob(DisasContext *s, int b, TCGLabel *l1)
+static inline void gen_jcc_noeob(DisasContext *s, int b, TCGLabel *l1)
 {
     CCPrepare cc = gen_prepare_cc(s, b, NULL);
 
@@ -1189,7 +1189,7 @@ static inline void gen_jcc1_noeob(DisasContext *s, int b, TCGLabel *l1)
    value 'b'. In the fast case, T0 is guaranteed not to be used.
    One or both of the branches will call gen_jmp_rel, so ensure
    cc_op is clean.  */
-static inline void gen_jcc1(DisasContext *s, int b, TCGLabel *l1)
+static inline void gen_jcc(DisasContext *s, int b, TCGLabel *l1)
 {
     CCPrepare cc = gen_prepare_cc(s, b, NULL);
 
@@ -1336,7 +1336,7 @@ static void gen_repz_nz(DisasContext *s, MemOp ot,
     l2 = gen_jz_ecx_string(s);
     fn(s, ot);
     gen_op_add_reg_im(s, s->aflag, R_ECX, -1);
-    gen_jcc1(s, (JCC_Z << 1) | (nz ^ 1), l2);
+    gen_jcc(s, (JCC_Z << 1) | (nz ^ 1), l2);
     if (s->repz_opt) {
         gen_op_jz_ecx(s, l2);
     }
@@ -1846,7 +1846,7 @@ static void gen_conditional_jump_labels(DisasContext *s, target_long diff,
     gen_jmp_rel(s, s->dflag, diff, 0);
 }
 
-static void gen_cmovcc1(DisasContext *s, int b, TCGv dest, TCGv src)
+static void gen_cmovcc(DisasContext *s, int b, TCGv dest, TCGv src)
 {
     CCPrepare cc = gen_prepare_cc(s, b, NULL);
 
@@ -2855,7 +2855,7 @@ static void gen_x87(DisasContext *s, X86DecodedInsn *decode)
                 }
                 op1 = fcmov_cc[op & 3] | (((op >> 3) & 1) ^ 1);
                 l1 = gen_new_label();
-                gen_jcc1_noeob(s, op1, l1);
+                gen_jcc_noeob(s, op1, l1);
                 gen_helper_fmov_ST0_STN(tcg_env,
                                         tcg_constant_i32(opreg));
                 gen_set_label(l1);
diff --git a/target/i386/tcg/emit.c.inc b/target/i386/tcg/emit.c.inc
index 8d18407facf..a05ba019026 100644
--- a/target/i386/tcg/emit.c.inc
+++ b/target/i386/tcg/emit.c.inc
@@ -1613,7 +1613,7 @@ static void gen_CMC(DisasContext *s, X86DecodedInsn *decode)
 
 static void gen_CMOVcc(DisasContext *s, X86DecodedInsn *decode)
 {
-    gen_cmovcc1(s, decode->b & 0xf, s->T0, s->T1);
+    gen_cmovcc(s, decode->b & 0xf, s->T0, s->T1);
 }
 
 static void gen_CMPccXADD(DisasContext *s, X86DecodedInsn *decode)
@@ -2279,7 +2279,7 @@ static void gen_Jcc(DisasContext *s, X86DecodedInsn *decode)
     TCGLabel *taken = gen_new_label();
 
     gen_bnd_jmp(s);
-    gen_jcc1(s, decode->b & 0xf, taken);
+    gen_jcc(s, decode->b & 0xf, taken);
     gen_conditional_jump_labels(s, decode->immediate, NULL, taken);
 
 }
@@ -2431,7 +2431,7 @@ static void gen_LOOPE(DisasContext *s, X86DecodedInsn *decode)
     gen_update_cc_op(s);
     gen_op_add_reg_im(s, s->aflag, R_ECX, -1);
     gen_op_jz_ecx(s, not_taken);
-    gen_jcc1(s, (JCC_Z << 1), taken); /* jz taken */
+    gen_jcc(s, (JCC_Z << 1), taken); /* jz taken */
     gen_conditional_jump_labels(s, decode->immediate, not_taken, taken);
 }
 
@@ -2443,7 +2443,7 @@ static void gen_LOOPNE(DisasContext *s, X86DecodedInsn *decode)
     gen_update_cc_op(s);
     gen_op_add_reg_im(s, s->aflag, R_ECX, -1);
     gen_op_jz_ecx(s, not_taken);
-    gen_jcc1(s, (JCC_Z << 1) | 1, taken); /* jnz taken */
+    gen_jcc(s, (JCC_Z << 1) | 1, taken); /* jnz taken */
     gen_conditional_jump_labels(s, decode->immediate, not_taken, taken);
 }
 
@@ -3868,7 +3868,7 @@ static void gen_SCAS(DisasContext *s, X86DecodedInsn *decode)
 
 static void gen_SETcc(DisasContext *s, X86DecodedInsn *decode)
 {
-    gen_setcc1(s, decode->b & 0xf, s->T0);
+    gen_setcc(s, decode->b & 0xf, s->T0);
 }
 
 static void gen_SFENCE(DisasContext *s, X86DecodedInsn *decode)
-- 
2.47.1


