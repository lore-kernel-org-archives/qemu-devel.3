Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC5E5C27C52
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Jun 2024 09:54:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sF9oP-0000B2-QL; Thu, 06 Jun 2024 05:53:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1sF9oN-0000A8-IY
 for qemu-devel@nongnu.org; Thu, 06 Jun 2024 05:53:35 -0400
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1sF9oM-0002Gw-4x
 for qemu-devel@nongnu.org; Thu, 06 Jun 2024 05:53:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ilande.co.uk; s=20220518; h=Subject:Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:To:From:Sender:Reply-To:Cc:
 Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
 bh=Nu2pAJRYDWOZ5hIejNAvJsFAvpoE55P+bBs+0I2hTn8=; b=GRm/j1zeSir1rHaQAwR+MyNlfs
 iKFbbIKUuYJFJ9qJJbQ9dkFsrxCab+zqdfysxXLckTLdovLzbaugWuxf4gDcjEHKVX95R7S+meHsy
 MQaSIyw39zT9+t4lnmWMx0WYhX9v91dWRqGyvnNkMjBGjr8fLwuz33nJDPESxHtJ1rhBAW1H5KrnO
 lcT4mPORgY7wC6R+ZJ3vyCqr2CqyIFHQmbtRkUm7dq+310eXMSDAyKJBKA4zv8qpTEGsFA5GNBgMm
 eaq0WBbIHw4PgEMCy3a1JZklLgcEL7xuNXaOrJTus64kNDDrybFIbIh/So1i1hHJ/pF14M65C4pcE
 qE4e31UrNbsCI7IxABTlTwBjxZwgYieZAkV04yM38FivBldroGG4/S2EC7hQ5KRWsWUD/YQC3uPKB
 K+wsVTUZLEBCZJCtmwpTAOZtOb5uyKcxnnHT8RZbj4Ptzv55JkWFEDjsWWTICWxDwnyEkcy0mFV/d
 o09+n9IiRVlraA7r6Il+eOJD6FKEP7E6I50gpwuHF2RHD2lmCodj3dqtx4GoMbYoszjh3Be4vmajC
 VHtpAZ1NLTD9jSaRw9IcY3hwZMq3rXFRLpnP4RlfJvYv4n6+IY0EY4VBr/fZ8EhYIEqHtEvhKUxUv
 qUmjUvOWSe3xb2791BvsjzSoFP9z0R/cr+nXtADCw=;
Received: from [2a02:8012:c93d:0:260e:bf57:a4e9:8142]
 (helo=cheesecake.fritz.box)
 by mail.ilande.co.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.92) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1sF9n3-0004cT-D1; Thu, 06 Jun 2024 10:52:17 +0100
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
To: pbonzini@redhat.com,
	qemu-devel@nongnu.org
Date: Thu,  6 Jun 2024 10:53:16 +0100
Message-Id: <20240606095319.229650-2-mark.cave-ayland@ilande.co.uk>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240606095319.229650-1-mark.cave-ayland@ilande.co.uk>
References: <20240606095319.229650-1-mark.cave-ayland@ilande.co.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a02:8012:c93d:0:260e:bf57:a4e9:8142
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: [PATCH 1/4] target/i386: use local X86DecodedOp in gen_POP()
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on mail.ilande.co.uk)
Received-SPF: pass client-ip=2001:41c9:1:41f::167;
 envelope-from=mark.cave-ayland@ilande.co.uk; helo=mail.ilande.co.uk
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

This will make subsequent changes a little easier to read.

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
---
 target/i386/tcg/emit.c.inc | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/target/i386/tcg/emit.c.inc b/target/i386/tcg/emit.c.inc
index e990141454..a89f8e0ebb 100644
--- a/target/i386/tcg/emit.c.inc
+++ b/target/i386/tcg/emit.c.inc
@@ -2564,11 +2564,13 @@ static void gen_PMOVMSKB(DisasContext *s, CPUX86State *env, X86DecodedInsn *deco
 
 static void gen_POP(DisasContext *s, CPUX86State *env, X86DecodedInsn *decode)
 {
+    X86DecodedOp *op = &decode->op[0];
     MemOp ot = gen_pop_T0(s);
-    if (decode->op[0].has_ea) {
+
+    if (op->has_ea) {
         /* NOTE: order is important for MMU exceptions */
         gen_op_st_v(s, ot, s->T0, s->A0);
-        decode->op[0].unit = X86_OP_SKIP;
+        op->unit = X86_OP_SKIP;
     }
     /* NOTE: writing back registers after update is important for pop %sp */
     gen_pop_update(s, ot);
-- 
2.39.2


