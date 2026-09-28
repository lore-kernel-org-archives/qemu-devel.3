Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C847CCA5FA2
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Sep 2026 13:04:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xBB17-0005Xc-Vy; Mon, 28 Sep 2026 09:03:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1xBB0s-0005KX-3Q
 for qemu-devel@nongnu.org; Mon, 28 Sep 2026 09:03:26 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1xBB0q-0004Nq-GI
 for qemu-devel@nongnu.org; Mon, 28 Sep 2026 09:03:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1790600599;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cMOlQlahvgMSuFSsGvR4hLZ/4OhA3DTiUtO96EFCceM=;
 b=BjuYaM01Bbx5j0r60GR1NQU5jJJZLDKMSr1XusPUNPS/i6cgzIGIGVFLTA493JR1EBaUkV
 c656nrgnbzmuJTLOj6KtZ7UN9I9t0dJRGMJJx5h5iDGIfd+XKb3/+XbcA7E20hVDNwonnD
 44xrLpmc71MEB7wnrCoYza60n4JO75I=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-641-Wfn-91iVM_idn1XJXQaKIA-1; Mon, 28 Sep 2026 09:03:17 -0400
X-MC-Unique: Wfn-91iVM_idn1XJXQaKIA-1
X-Mimecast-MFC-AGG-ID: Wfn-91iVM_idn1XJXQaKIA_1790600597
Received: by mail-ed1-f69.google.com with SMTP id
 4fb4d7f45d1cf-6a5d7e3ac13so3282314a12.3
 for <qemu-devel@nongnu.org>; Mon, 28 Sep 2026 06:03:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1790600597; x=1791205397; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=cMOlQlahvgMSuFSsGvR4hLZ/4OhA3DTiUtO96EFCceM=;
 b=jj77GKZw/2BIAYLfbkqxJadh6GK15GXVzzCDA0o/7fKGqgfihOMSKO2RGfMMgIrJuH
 XQK2eEJuItNOTiAoV0Di3SWvx57wLf6ORDc6tdQY/FoPHJp5tKh3JBzu+O3FiCZU5UE0
 +w6IHYY1ynz7p+EKaOqrkp57pBanTf19n/CfzNmXe+YtKbE1jIbe9SqCyu6C6owej/xh
 /8vgt0VEZU/N17z25T9wpSRkwIOiM5ZWqGPZDB2NwmAvWFyDNe26AdCB0suf5MKbcvWP
 cKrkT9+BqBK/x++puQGVhaGehRKnl3KnvGF1v/I+PlkNChmj49RbLXY9pGr0qP13D4Rs
 M2EA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790600597; x=1791205397;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=cMOlQlahvgMSuFSsGvR4hLZ/4OhA3DTiUtO96EFCceM=;
 b=K6dfVq4QJ+51Aox4tN2Y6XURDac1T0bq7yEcU8wupBME0mbUd96KVPTAdCjJ2FGew4
 /m+WVu3lraQfMALECA7dRDlnWADFHWP2YAyhmLz/htwtWHBIld0HUpoPrCH1o/J1ddna
 bFi49Ikhv1+QbLsRA5rEUVaJt8XERP93I/kyyxJx1a6JLcNwhPFZN5TNpoRsklk79YmM
 Yygr9TBHLh9Zcsc2Qpq8EDqjSYaxNk7DFjc4vrXkTlAA9GIw6SZR8p5coDkwDCN2m7eK
 /DH9FrwPTRufCHF9LBGxrN61NvpAPcPLyKhoX5QvaSEJdqINNb5FurTxahas3CfU3kxQ
 0EYQ==
X-Gm-Message-State: AFq9FYJmerXXSxrKDmr25SzmSKK3M80QxqKygRB65Q0JtO3+DTeaXQZD
 SiKj/05idF6Lc8bVglJ0oUgj0UJAJeWSgiHoJzqL5yf88fwZ1Um2MyvYIVuG32NnMsWnamk50fU
 xKrYwzhd7keRAuSLj6Tt8HEATCoW9HJ13iTDFGRUEYBWj9ZIV8x5Aa0LpImRLHUV/9MhfQXVgfd
 Xf+TnZZXNPVBzILBkljpqnSEB8zNeVPvRFctx8T8ih
X-Gm-Gg: AYBFou3VVYHHTF28NFEnlwNOGscqMbiWN/HQlZnqmv/81lldfpxZqKNNRrb3SUv8r3C
 YKu0P0OwqVYjrzQrGBYShP6fPxGmpl2/P3CrPA/kZG5WNHSDqT9IJ6YB511Gu4CVuNzlK3ryJQ9
 yadxNyaS9pqg9EmchIV6rSkhw6Y/zHT/TZ92JhqfHK+XwT2o6RoP/miaC6+ijlUnuiWIHPJeY4Y
 Xu5WlTKwji3c1OPF70NOCsAXjpvL+kZUmSAY9f0X/vt2iXpDPjNXqa7dVFKIAueuUswJTBTye4H
 s3h5iRXrhReNG1CRBwLj3N57i4uezO0iqdIzXt1xLvFbJakaAmi2zl/LwV+tNHZAeJIU+94yLrm
 iYMdf8K78gLlYHlFW78VYWglWb/dp/lUSIdVibOVsxbT9elkzwsnaMIgZoAm0z1pXfjoT6+7ZsH
 9ysaqr
X-Received: by 2002:a05:6402:a00d:b0:6ab:1c2:967e with SMTP id
 4fb4d7f45d1cf-6ab01c29bf6mr4204482a12.32.1790600596540; 
 Mon, 28 Sep 2026 06:03:16 -0700 (PDT)
X-Received: by 2002:a05:6402:a00d:b0:6ab:1c2:967e with SMTP id
 4fb4d7f45d1cf-6ab01c29bf6mr4204460a12.32.1790600596036; 
 Mon, 28 Sep 2026 06:03:16 -0700 (PDT)
Received: from [192.168.10.48] ([151.49.232.249])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-6ab5be60872sm2744523a12.34.2026.09.28.06.03.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 28 Sep 2026 06:03:12 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 14/30] target/i386/tcg: use zextT1 for CMPXCHG
Date: Mon, 28 Sep 2026 15:02:12 +0200
Message-ID: <20260928130228.877003-15-pbonzini@redhat.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260928130228.877003-1-pbonzini@redhat.com>
References: <20260928130228.877003-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.238,
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

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/tcg/decode-new.c.inc | 4 ++--
 target/i386/tcg/emit.c.inc       | 5 ++---
 2 files changed, 4 insertions(+), 5 deletions(-)

diff --git a/target/i386/tcg/decode-new.c.inc b/target/i386/tcg/decode-new.c.inc
index 3acac68977d..8394924a7ed 100644
--- a/target/i386/tcg/decode-new.c.inc
+++ b/target/i386/tcg/decode-new.c.inc
@@ -1365,8 +1365,8 @@ static const X86OpEntry opcodes_0F[256] = {
     [0xa4] = X86_OP_ENTRY4(SHLD,  E,v, 2op,v, G,v),
     [0xa5] = X86_OP_ENTRY3(SHLD,  E,v, 2op,v, G,v),
 
-    [0xb0] = X86_OP_ENTRY2(CMPXCHG,E,b, G,b, lock),
-    [0xb1] = X86_OP_ENTRY2(CMPXCHG,E,v, G,v, lock),
+    [0xb0] = X86_OP_ENTRY2(CMPXCHG,E,b, G,b, lock zextT1),
+    [0xb1] = X86_OP_ENTRY2(CMPXCHG,E,v, G,v, lock zextT1),
     [0xb2] = X86_OP_ENTRY3(LSS,    G,v, EM,p, None, None),
     [0xb3] = X86_OP_ENTRY2(BTR,    E,v, G,v,             btEvGv),
     [0xb4] = X86_OP_ENTRY3(LFS,    G,v, EM,p, None, None),
diff --git a/target/i386/tcg/emit.c.inc b/target/i386/tcg/emit.c.inc
index abf40123035..e4700473c9f 100644
--- a/target/i386/tcg/emit.c.inc
+++ b/target/i386/tcg/emit.c.inc
@@ -1760,11 +1760,10 @@ static void gen_CMPXCHG(DisasContext *s, X86DecodedInsn *decode)
     MemOp ot = decode->op[2].ot;
     TCGv cmpv = tcg_temp_new();
     TCGv oldv = tcg_temp_new();
-    TCGv newv = tcg_temp_new();
+    TCGv newv = s->T1;
     TCGv dest;
 
     tcg_gen_ext_tl(cmpv, cpu_regs[R_EAX], ot);
-    tcg_gen_ext_tl(newv, s->T1, ot);
     if (s->prefix & PREFIX_LOCK) {
         tcg_gen_atomic_cmpxchg_tl(oldv, s->A0, cmpv, newv,
                                   s->mem_index, ot | MO_LE);
@@ -1787,7 +1786,7 @@ static void gen_CMPXCHG(DisasContext *s, X86DecodedInsn *decode)
              * not zero-extending it on 64-bit processors.  So, precompute
              * the result of a successful writeback and perform the movcond
              * directly on cpu_regs.  In case rm is part of RAX, note that this
-             * movcond and the one below are mutually exclusive is executed.
+             * movcond and the one below are mutually exclusive.
              */
             dest = gen_op_deposit_reg_v(s, ot, decode->op[0].n, newv, newv);
             tcg_gen_movcond_tl(TCG_COND_EQ, dest, oldv, cmpv, newv, dest);
-- 
2.55.0


