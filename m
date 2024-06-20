Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9935BC2BBCA
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Jun 2024 09:56:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sKEVV-0002lA-Ff; Thu, 20 Jun 2024 05:55:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sKEVP-0002dO-FZ
 for qemu-devel@nongnu.org; Thu, 20 Jun 2024 05:55:00 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sKEVN-0005Wd-RV
 for qemu-devel@nongnu.org; Thu, 20 Jun 2024 05:54:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1718877297;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=EbIvh5b7KQ5TRyXSWuEts9KNlhisXZ5PWf3o2CP+6Cg=;
 b=Ns1jD6YRgQfyry2V1qoEMhUH4YDymE1Qtz1DS9ZLl/rcPf6FYIBgKRgwXU+NLViq0bb1mw
 aOP9xzSEESz7YKh4TD2iluQ0JePuqnkSZCFyoQnZ+qGcZxha0Mx2QgYhVQrpBuL7CnvizQ
 YvS3STDG/ZPeZbXYUM23HgCtUPq/Kvs=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-252-IxVW090qPyypyXcdt51uWA-1; Thu, 20 Jun 2024 05:54:51 -0400
X-MC-Unique: IxVW090qPyypyXcdt51uWA-1
Received: by mail-ed1-f72.google.com with SMTP id
 4fb4d7f45d1cf-57d1f998b44so704719a12.0
 for <qemu-devel@nongnu.org>; Thu, 20 Jun 2024 02:54:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718877289; x=1719482089;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=EbIvh5b7KQ5TRyXSWuEts9KNlhisXZ5PWf3o2CP+6Cg=;
 b=S7vbSgGpsW0T6+Z2blnR4+2l/m9SLekgLPaxdBZdFOwSzgf6dr1/ifxdYXXDzI4OE1
 7YLvdkKaGeCT93N+fUqWB76oj2PXdlikX9Yy5j1Ljddvf+I2VB2gyHb/TJnGG0S1wzgV
 o1Pi+OnLbfVoz+Jxf85NJOPUGXDcnA4UzG2oJJfCJFgUKOl8c05embG3Us8/d+zULI2/
 WE03IuqZl167I800Gquu/S0IEpzM3XgMOwhcmLPGgo4+fuCJwS7H55HPOOtewxDziAHj
 Mq4b35i1pxlA1kCGVKQZCvGUew5+XlDDzCR+ku3IdaBBHjztfEBpD0OCuQVC6htrQrVV
 fJsw==
X-Gm-Message-State: AOJu0YyEreathH2tlZhEKEllgX4K8ezV8mRdLleEhBSKN+aw6ygUstG/
 do1nVnQ0tgRiRWPpyzxyIEDoNdMx1+dXDB5sB5myehcGVgbtbb9ZPsNxjHr0gYNOU/P7OQAdqeV
 Fjie5zQt/47NcethihjdFwoZQuj5JD4G10ePEcxI+NPoDMIAK/jxWYQwdMNSr/Gtc+86fC1qE/W
 HnWm9RAl90etrzwag9zTh+u41iuts83KhEaRLZ
X-Received: by 2002:aa7:c315:0:b0:57d:1b21:1a25 with SMTP id
 4fb4d7f45d1cf-57d1b211a76mr2045144a12.15.1718877289075; 
 Thu, 20 Jun 2024 02:54:49 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFL68UWU2cO0MkRCzMl81MIIDL9bH37FneN/XgDJ5P76z5w1ELkfC/vQnB5fnlMuJp+NR1fIw==
X-Received: by 2002:aa7:c315:0:b0:57d:1b21:1a25 with SMTP id
 4fb4d7f45d1cf-57d1b211a76mr2045133a12.15.1718877288732; 
 Thu, 20 Jun 2024 02:54:48 -0700 (PDT)
Received: from avogadro.local ([151.62.196.71])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-57cb743890dsm9466090a12.83.2024.06.20.02.54.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 20 Jun 2024 02:54:48 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH 10/10] target/i386: remove gen_ext_tl
Date: Thu, 20 Jun 2024 11:54:19 +0200
Message-ID: <20240620095419.386958-11-pbonzini@redhat.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240620095419.386958-1-pbonzini@redhat.com>
References: <20240620095419.386958-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.144,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

With the introduction of tcg_gen_ext_tl, most uses can be converted directly
because they do not have a NULL destination.  tcg_gen_ext_tl is able to drop
no-ops like "tcg_gen_ext_tl(tcgv, tcgv, MO_TL)" just fine, and the only thing
that gen_ext_tl was adding on top was avoiding the creation of a useless
temporary.  This can be done in the only place where it matters, which is
gen_op_j_ecx.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/tcg/translate.c | 41 +++++++++++++++----------------------
 1 file changed, 17 insertions(+), 24 deletions(-)

diff --git a/target/i386/tcg/translate.c b/target/i386/tcg/translate.c
index d11c5e1dc13..5c9c992400e 100644
--- a/target/i386/tcg/translate.c
+++ b/target/i386/tcg/translate.c
@@ -697,23 +697,16 @@ static inline TCGv gen_compute_Dshift(DisasContext *s, MemOp ot)
     return dshift;
 };
 
-static TCGv gen_ext_tl(TCGv dst, TCGv src, MemOp size, bool sign)
-{
-    if (size == MO_TL) {
-        return src;
-    }
-    if (!dst) {
-        dst = tcg_temp_new();
-    }
-    tcg_gen_ext_tl(dst, src, size | (sign ? MO_SIGN : 0));
-    return dst;
-}
-
 static void gen_op_j_ecx(DisasContext *s, TCGCond cond, TCGLabel *label1)
 {
-    TCGv tmp = gen_ext_tl(NULL, cpu_regs[R_ECX], s->aflag, false);
-
-    tcg_gen_brcondi_tl(cond, tmp, 0, label1);
+    TCGv lhs;
+    if (s->aflag == MO_TL) {
+        lhs = cpu_regs[R_ECX];
+    } else {
+        lhs = tcg_temp_new();
+        tcg_gen_ext_tl(lhs, cpu_regs[R_ECX], s->aflag);
+    }
+    tcg_gen_brcondi_tl(cond, lhs, 0, label1);
 }
 
 static inline void gen_op_jz_ecx(DisasContext *s, TCGLabel *label1)
@@ -886,16 +879,16 @@ static CCPrepare gen_prepare_eflags_c(DisasContext *s, TCGv reg)
     case CC_OP_SUBB ... CC_OP_SUBQ:
         /* (DATA_TYPE)CC_SRCT < (DATA_TYPE)CC_SRC */
         size = s->cc_op - CC_OP_SUBB;
-        gen_ext_tl(s->cc_srcT, s->cc_srcT, size, false);
-        gen_ext_tl(cpu_cc_src, cpu_cc_src, size, false);
+        tcg_gen_ext_tl(s->cc_srcT, s->cc_srcT, size);
+        tcg_gen_ext_tl(cpu_cc_src, cpu_cc_src, size);
         return (CCPrepare) { .cond = TCG_COND_LTU, .reg = s->cc_srcT,
                              .reg2 = cpu_cc_src, .use_reg2 = true };
 
     case CC_OP_ADDB ... CC_OP_ADDQ:
         /* (DATA_TYPE)CC_DST < (DATA_TYPE)CC_SRC */
         size = s->cc_op - CC_OP_ADDB;
-        gen_ext_tl(cpu_cc_dst, cpu_cc_dst, size, false);
-        gen_ext_tl(cpu_cc_src, cpu_cc_src, size, false);
+        tcg_gen_ext_tl(cpu_cc_dst, cpu_cc_dst, size);
+        tcg_gen_ext_tl(cpu_cc_src, cpu_cc_src, size);
         return (CCPrepare) { .cond = TCG_COND_LTU, .reg = cpu_cc_dst,
                              .reg2 = cpu_cc_src, .use_reg2 = true };
 
@@ -920,7 +913,7 @@ static CCPrepare gen_prepare_eflags_c(DisasContext *s, TCGv reg)
 
     case CC_OP_BMILGB ... CC_OP_BMILGQ:
         size = s->cc_op - CC_OP_BMILGB;
-        gen_ext_tl(cpu_cc_src, cpu_cc_src, size, false);
+        tcg_gen_ext_tl(cpu_cc_src, cpu_cc_src, size);
         return (CCPrepare) { .cond = TCG_COND_EQ, .reg = cpu_cc_src };
 
     case CC_OP_ADCX:
@@ -1050,8 +1043,8 @@ static CCPrepare gen_prepare_cc(DisasContext *s, int b, TCGv reg)
         size = s->cc_op - CC_OP_SUBB;
         switch (jcc_op) {
         case JCC_BE:
-            gen_ext_tl(s->cc_srcT, s->cc_srcT, size, false);
-            gen_ext_tl(cpu_cc_src, cpu_cc_src, size, false);
+            tcg_gen_ext_tl(s->cc_srcT, s->cc_srcT, size);
+            tcg_gen_ext_tl(cpu_cc_src, cpu_cc_src, size);
             cc = (CCPrepare) { .cond = TCG_COND_LEU, .reg = s->cc_srcT,
                                .reg2 = cpu_cc_src, .use_reg2 = true };
             break;
@@ -1061,8 +1054,8 @@ static CCPrepare gen_prepare_cc(DisasContext *s, int b, TCGv reg)
         case JCC_LE:
             cond = TCG_COND_LE;
         fast_jcc_l:
-            gen_ext_tl(s->cc_srcT, s->cc_srcT, size, true);
-            gen_ext_tl(cpu_cc_src, cpu_cc_src, size, true);
+            tcg_gen_ext_tl(s->cc_srcT, s->cc_srcT, size | MO_SIGN);
+            tcg_gen_ext_tl(cpu_cc_src, cpu_cc_src, size | MO_SIGN);
             cc = (CCPrepare) { .cond = cond, .reg = s->cc_srcT,
                                .reg2 = cpu_cc_src, .use_reg2 = true };
             break;
-- 
2.45.2


