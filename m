Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B08C0606A324
	for <qemu-devel@archiver.kernel.org>; Sun,  1 Nov 2026 10:00:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=KsqCU5F/
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xNSLA-0006il-R0; Sun, 01 Nov 2026 04:59:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1xNSL9-0006iH-7d
 for qemu-devel@nongnu.org; Sun, 01 Nov 2026 04:59:03 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1xNSL7-0007tM-2M
 for qemu-devel@nongnu.org; Sun, 01 Nov 2026 04:59:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1793527140;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=MXlMczLzvRR9ZND8zGlwgX4KpmxI/vZ9RId1nS5XNPs=;
 b=KsqCU5F//XVQSIm4GWgLt+EsAqOmovez2H9+TIu/4VO1Hp5+2zW0EYobCKNNNkNmMeyRGB
 STbGmg2wN761Glz2HPV3GFq/cYCs2ENz9NHNPL+vAchhr0hupGJWZ+4uHJm6jZXO7kWhm6
 YuxyCdmnAMD0Udn7g7vdf42yH/eraB8=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-407-JD_hLogGN-yl2m8O0glXkA-1; Sun,
 01 Nov 2026 04:58:58 -0500
X-MC-Unique: JD_hLogGN-yl2m8O0glXkA-1
X-Mimecast-MFC-AGG-ID: JD_hLogGN-yl2m8O0glXkA_1793527138
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id EC2C81955F37
 for <qemu-devel@nongnu.org>; Sun,  1 Nov 2026 09:58:57 +0000 (UTC)
Received: from pbonzini-thinkpadx1carbon6th.rmtit.csb
 (headnet04.pony-001.prod.iad2.dc.redhat.com [10.2.32.116])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 462C01800446
 for <qemu-devel@nongnu.org>; Sun,  1 Nov 2026 09:58:57 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 03/10] target/i386/tcg: inline gen_leave
Date: Sun,  1 Nov 2026 10:58:44 +0100
Message-ID: <20261101095851.1557351-4-pbonzini@redhat.com>
In-Reply-To: <20261101095851.1557351-1-pbonzini@redhat.com>
References: <20261101095851.1557351-1-pbonzini@redhat.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 5
X-Spam_score: 0.5
X-Spam_bar: /
X-Spam_report: (0.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The function is a vestige of the old switch-based decoder and does
not add anything these days.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/tcg/translate.c | 14 --------------
 target/i386/tcg/emit.c.inc  | 11 ++++++++++-
 2 files changed, 10 insertions(+), 15 deletions(-)

diff --git a/target/i386/tcg/translate.c b/target/i386/tcg/translate.c
index b2cbce046cb..3d542acd975 100644
--- a/target/i386/tcg/translate.c
+++ b/target/i386/tcg/translate.c
@@ -2005,20 +2005,6 @@ static void gen_enter(DisasContext *s, int esp_addend, int level)
     gen_op_mov_reg_v(s, a_ot, R_ESP, s->T1);
 }
 
-static void gen_leave(DisasContext *s)
-{
-    MemOp d_ot = mo_pushpop(s, s->dflag);
-    MemOp a_ot = mo_stacksize(s);
-
-    gen_lea_ss_ofs(s, s->A0, cpu_regs[R_EBP], 0);
-    gen_op_ld_v(s, d_ot, s->T0, s->A0);
-
-    tcg_gen_addi_tl(s->T1, cpu_regs[R_EBP], 1 << d_ot);
-
-    gen_op_mov_reg_v(s, d_ot, R_EBP, s->T0);
-    gen_op_mov_reg_v(s, a_ot, R_ESP, s->T1);
-}
-
 /* an interrupt is different from an exception because of the
    privilege checks */
 static void gen_interrupt(DisasContext *s, uint8_t intno)
diff --git a/target/i386/tcg/emit.c.inc b/target/i386/tcg/emit.c.inc
index ed56edf8a3a..a1ae5821746 100644
--- a/target/i386/tcg/emit.c.inc
+++ b/target/i386/tcg/emit.c.inc
@@ -2559,7 +2559,16 @@ static void gen_LEA(DisasContext *s, X86DecodedInsn *decode)
 
 static void gen_LEAVE(DisasContext *s, X86DecodedInsn *decode)
 {
-    gen_leave(s);
+    MemOp d_ot = mo_pushpop(s, s->dflag);
+    MemOp a_ot = mo_stacksize(s);
+
+    gen_lea_ss_ofs(s, s->A0, cpu_regs[R_EBP], 0);
+    gen_op_ld_v(s, d_ot, s->T0, s->A0);
+
+    tcg_gen_addi_tl(s->T1, cpu_regs[R_EBP], 1 << d_ot);
+
+    gen_op_mov_reg_v(s, d_ot, R_EBP, s->T0);
+    gen_op_mov_reg_v(s, a_ot, R_ESP, s->T1);
 }
 
 static void gen_LES(DisasContext *s, X86DecodedInsn *decode)
-- 
2.56.0



