Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61D02C61DC2
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Aug 2026 14:14:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wzaru-0002j6-MI; Thu, 27 Aug 2026 10:14:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1wzarn-0002iW-BM
 for qemu-devel@nongnu.org; Thu, 27 Aug 2026 10:14:08 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1wzarg-0005o7-Q1
 for qemu-devel@nongnu.org; Thu, 27 Aug 2026 10:14:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1787840040;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0E5fVFz6zV3sS1HX0vK91r7SG/PL2NnfhxsF2uS4Xsk=;
 b=ZLTQSgO2No7d6M1ibZrwT8RBdvDJS5SiFwZHY5Dh2vVP7z4f21fBkkZBZKaHCnScCNKDPU
 nZ4xEvHNr2kciawo9wK5/N8A8Q3pD3STDEzDRiWJQzGPxYY1juNqstFYXDI7OTwHvpG6IC
 kIjjFP8oHl5whE7dhsa1G1nMkTfrGBQ=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-609-R3mhEER_NHKZn16iCjowfA-1; Thu, 27 Aug 2026 10:13:57 -0400
X-MC-Unique: R3mhEER_NHKZn16iCjowfA-1
X-Mimecast-MFC-AGG-ID: R3mhEER_NHKZn16iCjowfA_1787840036
Received: by mail-ej1-f72.google.com with SMTP id
 a640c23a62f3a-c24ae1a510cso63955266b.3
 for <qemu-devel@nongnu.org>; Thu, 27 Aug 2026 07:13:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1787840036; x=1788444836; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=0E5fVFz6zV3sS1HX0vK91r7SG/PL2NnfhxsF2uS4Xsk=;
 b=roPCfNcV+1y+jZUdnzTC56jnK+4blRM+1PQ2YvHzlh0b/SvlpsM5UcpnHBE2pYdLUE
 gIm+PlMUQWisv/mkiNKzDK7Ygjxph+VFgyRhvh6jcwQ1exPxJsIFwpq4KSQNtyScfRdi
 q3dXFZe1qoXw//ovNqfPaKvIlR8YLpTXvL9WcQxUm6z6XPfdHAfKbOiQBdxYTGg47g9k
 vVCovr4c77ysnI1yghdjAY/tq2Mfqelnt/9sN+ttgLi5Zz2kYT7ULCkeL5wpQG9yxFIq
 idCnPPeN5CvkDVhKO1s6kmkf33zXIh9B32SqMYdbzo+0TAJYLFwx3DjYyRl+AIBeS6ue
 xNag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787840036; x=1788444836;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=0E5fVFz6zV3sS1HX0vK91r7SG/PL2NnfhxsF2uS4Xsk=;
 b=KLhtSHIZ4ch2rZsFmzNsUkXkEcmniBdG4JWcM7uE8n3R6GYIdJFhtqQqwF+6LspvWp
 myEgL4Zrc6FzS9SCnl0ei4TJEZ+hXJttPKxh94c08sdfFYT6gDIMJ6FTfh4MvposbPVZ
 LmV3vIxztor5cutlbCQFuWYUG7eIhQrRYk8BDdxrsT+RmDRLiUpVHwWDVsxHnIgXtzSz
 NataXqLRHYx/u4nmWwq087zdpBPqKHEU1i0k55xO0PwPdKeSyxZkac2gDxwfzyHtXIl7
 uOXPMMS3EiIRzsQNmlU8ZCnrxudLI8W4kSA2qNT3R7/ef5nFlanJsRMW1O/iRfcNiEJw
 0w9g==
X-Gm-Message-State: AFuF++m+Rl98S6EFFvO5ixb/L23+C6ACnrz4uJnAFLr5OLTo5DurOUKC
 cRgqgknFeUJyqoeVSk8M4UywsJ8QzXcddrbJpmmILcOOaHO3O7pvfY5u0G27GfTZlNbI0HsNu7c
 8v2E6IEb1jeE7LVYonUvw1TfqeTJrtlAYmSTRfgWKnsKTqcfRQXCUkgUjeNzutp2QDLtTlZodSZ
 l1qv8CMFDAteiOR6+aS+bRbBwoJssIW2WPUXFFsfi+
X-Gm-Gg: AR+sD12IQcXBkPMjpxLdvjhcB28GUK8omzW+1TPaBMOkptjpNYpnDeyWV8zUvk6hTQC
 lZa4n+wCnf0FiP0lkUTMTyyzA7GMLLX04cbdZ10rl/60B+EJ37pp/Yag+7JOivJgO37n3KoqYgg
 eXkHi5qnyG29fvZqBEkows6zuAfx93O+K10o0r1aEUVC9h4NZULxZZe8GFlswVDRXMzaXc0Z+eJ
 7T84Ib164vreHXju7lWybCVkcWMGODEp49IDMkr/6NyUJfHr+tshlMUDK1FRgIPxVBTIhrVgijc
 8nWunxHeHvWYpZPrRZMLov98Mr2X6k49YxFOk86GqKsO8S+CsYfdeDeEWApA6/jEzxQr9VqcywQ
 zh/PBQ3pAVAcPbHIegqFLH5TzVo8VaozNicqdyV5O8WmJnkdfwr3T6tWNwHz2BNWZDkrSSRYIuC
 wKZso=
X-Received: by 2002:a17:907:ea8b:b0:c20:3402:bd35 with SMTP id
 a640c23a62f3a-c250c330f70mr1501947366b.12.1787840035995; 
 Thu, 27 Aug 2026 07:13:55 -0700 (PDT)
X-Received: by 2002:a17:907:ea8b:b0:c20:3402:bd35 with SMTP id
 a640c23a62f3a-c250c330f70mr1501944266b.12.1787840035445; 
 Thu, 27 Aug 2026 07:13:55 -0700 (PDT)
Received: from [192.168.10.48] ([151.95.151.49])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c2550ef8a3csm4855766b.20.2026.08.27.07.13.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 27 Aug 2026 07:13:53 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 13/23] target/i386/tcg: do not reuse cc_srcT
Date: Thu, 27 Aug 2026 16:13:01 +0200
Message-ID: <20260827141314.1099352-14-pbonzini@redhat.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260827141314.1099352-1-pbonzini@redhat.com>
References: <20260827141314.1099352-1-pbonzini@redhat.com>
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

Use a different temporary for every instruction that uses it in the
translation block.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/tcg/translate.c |  6 ++++--
 target/i386/tcg/emit.c.inc  | 11 +++++++----
 2 files changed, 11 insertions(+), 6 deletions(-)

diff --git a/target/i386/tcg/translate.c b/target/i386/tcg/translate.c
index 2115c5cd24b..d1791550772 100644
--- a/target/i386/tcg/translate.c
+++ b/target/i386/tcg/translate.c
@@ -342,7 +342,7 @@ static void set_cc_op_1(DisasContext *s, CCOp op, bool dirty)
         tcg_gen_discard_tl(cpu_cc_src2);
     }
     if (dead & USES_CC_SRCT) {
-        tcg_gen_discard_tl(s->cc_srcT);
+        s->cc_srcT = NULL;
     }
 
     if (dirty && s->cc_op == CC_OP_DYNAMIC) {
@@ -1236,6 +1236,7 @@ static void gen_lods(DisasContext *s, MemOp ot, TCGv dshift)
 
 static void gen_scas(DisasContext *s, MemOp ot, TCGv dshift)
 {
+    s->cc_srcT = tcg_temp_new();
     gen_string_movl_A0_EDI(s);
     gen_op_ld_v(s, ot, s->T1, s->A0);
     tcg_gen_mov_tl(cpu_cc_src, s->T1);
@@ -1248,6 +1249,7 @@ static void gen_scas(DisasContext *s, MemOp ot, TCGv dshift)
 
 static void gen_cmps(DisasContext *s, MemOp ot, TCGv dshift)
 {
+    s->cc_srcT = tcg_temp_new();
     gen_string_movl_A0_EDI(s);
     gen_op_ld_v(s, ot, s->T1, s->A0);
     gen_string_movl_A0_ESI(s);
@@ -3484,7 +3486,7 @@ static void i386_tr_init_disas_context(DisasContextBase *dcbase, CPUState *cpu)
     dc->T1 = tcg_temp_new();
     dc->A0 = tcg_temp_new();
 
-    dc->cc_srcT = tcg_temp_new();
+    dc->cc_srcT = NULL;
 }
 
 static void i386_tr_tb_start(DisasContextBase *db, CPUState *cpu)
diff --git a/target/i386/tcg/emit.c.inc b/target/i386/tcg/emit.c.inc
index 473f415766f..968abd47a73 100644
--- a/target/i386/tcg/emit.c.inc
+++ b/target/i386/tcg/emit.c.inc
@@ -1699,6 +1699,7 @@ static void gen_CMPccXADD(DisasContext *s, X86DecodedInsn *decode)
      * - s->cc_srcT: memory operand (lhs for comparison)
      * - cmpv: rhs for comparison
      */
+    s->cc_srcT = tcg_temp_new();
     gen_set_label(label_top);
     gen_op_ld_v(s, ot_full, s->cc_srcT, s->A0);
     tcg_gen_sub_tl(s->T0, s->cc_srcT, cmpv);
@@ -1800,11 +1801,12 @@ static void gen_CMPXCHG(DisasContext *s, X86DecodedInsn *decode)
     dest = gen_op_deposit_reg_v(s, ot, R_EAX, s->T0, oldv);
     tcg_gen_movcond_tl(TCG_COND_NE, dest, oldv, cmpv, s->T0, dest);
 
-    tcg_gen_mov_tl(s->cc_srcT, cmpv);
-    tcg_gen_sub_tl(cmpv, cmpv, oldv);
-    decode->cc_dst = cmpv;
+    s->cc_srcT = cmpv;
+    decode->cc_dst = tcg_temp_new();
     decode->cc_src = oldv;
     decode->cc_op = CC_OP_SUBB + ot;
+
+    tcg_gen_sub_tl(decode->cc_dst, cmpv, oldv);
 }
 
 static void gen_CMPXCHG16B(DisasContext *s, X86DecodedInsn *decode)
@@ -2722,7 +2724,7 @@ static void gen_NEG(DisasContext *s, X86DecodedInsn *decode)
 
     decode->cc_dst = s->T0;
     decode->cc_src = oldv;
-    tcg_gen_movi_tl(s->cc_srcT, 0);
+    s->cc_srcT = tcg_constant_tl(0);
     decode->cc_op = CC_OP_SUBB + ot;
 }
 
@@ -4114,6 +4116,7 @@ static void gen_SUB(DisasContext *s, X86DecodedInsn *decode)
 {
     MemOp ot = decode->op[1].ot;
 
+    s->cc_srcT = tcg_temp_new();
     if (s->prefix & PREFIX_LOCK) {
         tcg_gen_neg_tl(s->T0, s->T1);
         tcg_gen_atomic_fetch_add_tl(s->cc_srcT, s->A0, s->T0,
-- 
2.55.0


