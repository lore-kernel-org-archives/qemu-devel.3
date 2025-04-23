Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BDA03C369CB
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Apr 2025 09:42:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u7WcH-0005Ye-J0; Wed, 23 Apr 2025 05:42:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1u7Wbc-0004Iw-Qu
 for qemu-devel@nongnu.org; Wed, 23 Apr 2025 05:41:26 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1u7Wba-0008Kx-R3
 for qemu-devel@nongnu.org; Wed, 23 Apr 2025 05:41:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1745401282;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8/rvwJVad1cY0ORJShycpekQ7ix1S94anraVKJmTQDI=;
 b=bT+LcAou8P+MXecU0A/KG3LZBDhgBVqF2MkKb1xMSg2UGhxY8RfcJID+2hSwLbGG17UJXX
 GBrR/AxxRoLDN6yNDojyIo0YVTuRGypUiA36S8tmXI9zOhFgUAPAQmfl6w1QSLRa0hO77T
 enjeP4MaqnFCiIvIYUmJ4AxrBJcIa9o=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-629-xBjH7FbMN-6UZo5CfaEqww-1; Wed, 23 Apr 2025 05:41:19 -0400
X-MC-Unique: xBjH7FbMN-6UZo5CfaEqww-1
X-Mimecast-MFC-AGG-ID: xBjH7FbMN-6UZo5CfaEqww_1745401278
Received: by mail-ej1-f69.google.com with SMTP id
 a640c23a62f3a-ac6caf952d7so581881466b.3
 for <qemu-devel@nongnu.org>; Wed, 23 Apr 2025 02:41:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745401278; x=1746006078;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=8/rvwJVad1cY0ORJShycpekQ7ix1S94anraVKJmTQDI=;
 b=sOZgekkupMkEUmIn/btzhr9Kas5FKfmxe3GmqGNy03IlQZouOjGHvQsfl1LA643zwH
 wi++C6HwaScxlHWyBAENz0aYUWZeZggbOPtOvKT8wjyWf1ARvMc7xgCZLUp8lIrDRHnn
 AtiDxGlDJ9y51wG9v8a6Ma+Jja2LKTWzQorYrsUjb8fIqs5uCfAekU1mfEkUzDGMRu54
 DR5h1m05wv14y3Emgxtiz9o4Vn/MZO6t5bBFJcz3PDW/lRoorwp40ajgNdCWCyIUdZdI
 d9e1D+HNS+LsuPFtzKeDXWKobjIcw9uam26c7aMmmr0KK2ohjN1gX7Msn1mnePl3wieL
 h6CA==
X-Gm-Message-State: AOJu0YxDnBvE9bs8RbANKHZgqu8kvnDIWO9kNI/TM5yNLAJ+oyzPb8K5
 c6RpYbBnhaW3xwnTdxs0ukULGo4DoNcK+uq+482no7iyCZfv+xMYYcZz0KNO/hhk3Luih2CttYh
 15PcmjUsl8c6Z1FuBux1kQtI4GFWeMB3VgBBTFI+jyXrKE+2flOj15JFf9QMb88ltFHg5637RpI
 J4Brf4NQfoQSZ0dmVs0vvOsYJ3S82u9AKKC3gh
X-Gm-Gg: ASbGncuLOFj6dNAe3l6oYMShH/lrA/Z3LAyo6Y6VqyCA81oDFxC3JOK+anJKb3+CRBq
 sOHGXJEG8KHQyoA+LL0c7wdA9QA3xbteNS7R5pFJUDlWZNnpt8jSSu5pL5ou7ZPowDIRJAN33mZ
 l0SoBFVBjhRRANHj8jH89vAsRwKP0qESnpGpaFSIXVRcRlRzEhUTwuwf0yK5Mz2YWOnsWQ1e/2P
 BnSloqOGuCCUkCWFxTORC9M5Ghdt9u0Z2wX/ntziXUivV6jLQhK9JOdtVH3JOuDt7S4e6xGF5jo
 MjsEDNEpn6I8ZZnf
X-Received: by 2002:a17:907:9414:b0:aca:c4a6:cd90 with SMTP id
 a640c23a62f3a-acb74af5538mr1679373866b.5.1745401277776; 
 Wed, 23 Apr 2025 02:41:17 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE5GOifzCfYNL0q5rpKyA31HLDMlL94QQdXfxVAt1CE1vsOvMw/Jn2t7LlJTEbycFM2a/31uA==
X-Received: by 2002:a17:907:9414:b0:aca:c4a6:cd90 with SMTP id
 a640c23a62f3a-acb74af5538mr1679370666b.5.1745401277308; 
 Wed, 23 Apr 2025 02:41:17 -0700 (PDT)
Received: from [192.168.10.48] ([151.49.233.241])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-acb6ec10ed0sm775229966b.36.2025.04.23.02.41.14
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Apr 2025 02:41:14 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 05/34] target/i386: special case ADC/SBB x,0 and SBB x,x
Date: Wed, 23 Apr 2025 11:40:35 +0200
Message-ID: <20250423094105.40692-6-pbonzini@redhat.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250423094105.40692-1-pbonzini@redhat.com>
References: <20250423094105.40692-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.411,
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

Avoid the three-operand CC_OP_ADD and CC_OP_ADC in these relatively
common cases.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/tcg/translate.c | 20 +++++++++++
 target/i386/tcg/emit.c.inc  | 71 +++++++++++++++++++++++++++++++++----
 2 files changed, 85 insertions(+), 6 deletions(-)

diff --git a/target/i386/tcg/translate.c b/target/i386/tcg/translate.c
index a8935f487aa..aee33428989 100644
--- a/target/i386/tcg/translate.c
+++ b/target/i386/tcg/translate.c
@@ -1183,6 +1183,26 @@ static CCPrepare gen_prepare_cc(DisasContext *s, int b, TCGv reg)
     return cc;
 }
 
+static void gen_neg_setcc(DisasContext *s, int b, TCGv reg)
+{
+    CCPrepare cc = gen_prepare_cc(s, b, reg);
+
+    if (cc.no_setcond) {
+        if (cc.cond == TCG_COND_EQ) {
+            tcg_gen_addi_tl(reg, cc.reg, -1);
+        } else {
+            tcg_gen_neg_tl(reg, cc.reg);
+        }
+        return;
+    }
+
+    if (cc.use_reg2) {
+        tcg_gen_negsetcond_tl(cc.cond, reg, cc.reg, cc.reg2);
+    } else {
+        tcg_gen_negsetcondi_tl(cc.cond, reg, cc.reg, cc.imm);
+    }
+}
+
 static void gen_setcc(DisasContext *s, int b, TCGv reg)
 {
     CCPrepare cc = gen_prepare_cc(s, b, reg);
diff --git a/target/i386/tcg/emit.c.inc b/target/i386/tcg/emit.c.inc
index 0fa1664a24f..f477a2da992 100644
--- a/target/i386/tcg/emit.c.inc
+++ b/target/i386/tcg/emit.c.inc
@@ -1170,11 +1170,28 @@ static void gen_AAS(DisasContext *s, X86DecodedInsn *decode)
     assume_cc_op(s, CC_OP_EFLAGS);
 }
 
+static void gen_ADD(DisasContext *s, X86DecodedInsn *decode);
 static void gen_ADC(DisasContext *s, X86DecodedInsn *decode)
 {
     MemOp ot = decode->op[1].ot;
-    TCGv c_in = tcg_temp_new();
+    TCGv c_in;
 
+    /*
+     * Try to avoid CC_OP_ADC by transforming as follows:
+     * CC_ADC: src1 = dst + c_in, src2 = 0, src3 = c_in
+     * CC_ADD: src1 = dst + c_in, src2 = c_in (no src3)
+     *
+     * In general src2 vs. src3 matters when computing AF and OF, but not here:
+     * - AF is bit 4 of dst^src1^src2, which is bit 4 of dst^src1 in both cases
+     * - OF is a function of the two MSBs, and in both cases they are zero for src2
+     */
+    if (decode->e.op2 == X86_TYPE_I && decode->immediate == 0) {
+        gen_compute_eflags_c(s, s->T1);
+        gen_ADD(s, decode);
+        return;
+    }
+
+    c_in = tcg_temp_new();
     gen_compute_eflags_c(s, c_in);
     if (s->prefix & PREFIX_LOCK) {
         tcg_gen_add_tl(s->T0, c_in, s->T1);
@@ -3830,22 +3847,64 @@ static void gen_SARX(DisasContext *s, X86DecodedInsn *decode)
     tcg_gen_sar_tl(s->T0, s->T0, s->T1);
 }
 
+static void gen_SUB(DisasContext *s, X86DecodedInsn *decode);
 static void gen_SBB(DisasContext *s, X86DecodedInsn *decode)
 {
     MemOp ot = decode->op[0].ot;
-    TCGv c_in = tcg_temp_new();
+    TCGv c_in;
 
+    /*
+     * Try to avoid CC_OP_SBB by transforming as follows:
+     * CC_SBB: src1 = dst + c_in, src2 = 0, src3 = c_in
+     * CC_SUB: src1 = dst + c_in, src2 = c_in (no src3)
+     *
+     * In general src2 vs. src3 matters when computing AF and OF, but not here:
+     * - AF is bit 4 of dst^src1^src2, which is bit 4 of dst^src1 in both cases
+     * - OF is a function of the two MSBs, and in both cases they are zero for src2
+     */
+    if (decode->e.op2 == X86_TYPE_I && decode->immediate == 0) {
+        gen_compute_eflags_c(s, s->T1);
+        gen_SUB(s, decode);
+        return;
+    }
+
+    c_in = tcg_temp_new();
     gen_compute_eflags_c(s, c_in);
+
+    /*
+     * Here the change is as follows:
+     * CC_SBB: src1 = T0, src2 = T0, src3 = c_in
+     * CC_SUB: src1 = 0, src2 = c_in (no src3)
+     *
+     * The difference also does not matter:
+     * - AF is bit 4 of dst^src1^src2, but bit 4 of src1^src2 is zero in both cases
+     *   therefore AF comes straight from dst (in fact it is c_in)
+     * - for OF, src1 and src2 have the same sign in both cases, meaning there
+     *   can be no overflow
+     */
+    if (decode->e.op2 != X86_TYPE_I && !decode->op[0].has_ea && decode->op[0].n == decode->op[2].n) {
+        if (s->cc_op == CC_OP_DYNAMIC) {
+            tcg_gen_neg_tl(s->T0, c_in);
+        } else {
+            /*
+             * Do not negate c_in because it will often be dead and only the
+             * instruction generated by negsetcond will survive.
+             */
+            gen_neg_setcc(s, JCC_B << 1, s->T0);
+        }
+        tcg_gen_movi_tl(s->cc_srcT, 0);
+        decode->cc_src = c_in;
+        decode->cc_dst = s->T0;
+        decode->cc_op = CC_OP_SUBB + ot;
+        return;
+    }
+
     if (s->prefix & PREFIX_LOCK) {
         tcg_gen_add_tl(s->T0, s->T1, c_in);
         tcg_gen_neg_tl(s->T0, s->T0);
         tcg_gen_atomic_add_fetch_tl(s->T0, s->A0, s->T0,
                                     s->mem_index, ot | MO_LE);
     } else {
-        /*
-         * TODO: SBB reg, reg could use gen_prepare_eflags_c followed by
-         * negsetcond, and CC_OP_SUBB as the cc_op.
-         */
         tcg_gen_sub_tl(s->T0, s->T0, s->T1);
         tcg_gen_sub_tl(s->T0, s->T0, c_in);
     }
-- 
2.49.0


