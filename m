Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64D78C25B75
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Jun 2024 09:53:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sF9oT-0000Bh-Gm; Thu, 06 Jun 2024 05:53:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1sF9oR-0000BE-Of
 for qemu-devel@nongnu.org; Thu, 06 Jun 2024 05:53:39 -0400
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1sF9oQ-0002HL-CJ
 for qemu-devel@nongnu.org; Thu, 06 Jun 2024 05:53:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ilande.co.uk; s=20220518; h=Subject:Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:To:From:Sender:Reply-To:Cc:
 Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
 bh=bttw7K2H5mg9CQnXOSbUNkw+zy9h+sWjVSbA7kuAYOQ=; b=gL9Iuc8lbShAcv28+J3QAtebqi
 ZqcTkHtApvPiJFrADnW9DEWaqZZhTVSHCdmE3ypiRYE4Tw/idIbirsEdOCbcdK+YFH9sjwafoW2l7
 j2GMLZY6bvMlGFy0WH6k7YjuHbYwIndO47WPWh+4DHb/hTlpa9rPQDeMzqdORnrpagSWL2j3NZ3N3
 lEWOb8Fo1jBJF0OWDYOgdo71/oTvTmJW3IX+vh4Y/zvfwLHSKHMpBQYvFEXqYH+4tBCZwEds/T/mo
 0S5OpsUxegEcW8jEIvFSeGltgx6MReqQ+AxEyhS+QAG4nA7yvv0DjYsBry4HftKkR58z+vBynS570
 D+sdunsSr0QPNgSzbcYTccqVFX6f4ATHCFxXkBNX9p2beC5Wg2jXv3lKSw3reGbqRRqqHagYkksdU
 fYSDtwZ/tE6qxokbxsSNNtn7pynTQbGmurumqupro/Le7e7WjgAwnnkp0zHBzFWr+TX4S2udx2pJQ
 s4zokyFjnu5/GJbXJc3zYSWDa7hdti6xUU9PFom5EgJ9mXXqna0oLUxT+zSTs9ULrY9grkufdl/Lj
 JRduaEZAu5oS6xbPDhTlFIQF9sjzTLlrKHAWMPaTcOFx4XXMsBoUeGIhUgbQ5RsvjbLa/5TlK8N+w
 PnohkY2vSvGkz5wLnqCZ7uF66kB66pT6ZofV7lL3U=;
Received: from [2a02:8012:c93d:0:260e:bf57:a4e9:8142]
 (helo=cheesecake.fritz.box)
 by mail.ilande.co.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.92) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1sF9n7-0004cT-Mk; Thu, 06 Jun 2024 10:52:21 +0100
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
To: pbonzini@redhat.com,
	qemu-devel@nongnu.org
Date: Thu,  6 Jun 2024 10:53:17 +0100
Message-Id: <20240606095319.229650-3-mark.cave-ayland@ilande.co.uk>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240606095319.229650-1-mark.cave-ayland@ilande.co.uk>
References: <20240606095319.229650-1-mark.cave-ayland@ilande.co.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a02:8012:c93d:0:260e:bf57:a4e9:8142
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: [PATCH 2/4] target/i386: use gen_writeback() within gen_POP()
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

Instead of directly implementing the writeback using gen_op_st_v(), use the
existing gen_writeback() function.

Suggested-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
---
 target/i386/tcg/emit.c.inc | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/i386/tcg/emit.c.inc b/target/i386/tcg/emit.c.inc
index a89f8e0ebb..2d5dc11548 100644
--- a/target/i386/tcg/emit.c.inc
+++ b/target/i386/tcg/emit.c.inc
@@ -2569,7 +2569,7 @@ static void gen_POP(DisasContext *s, CPUX86State *env, X86DecodedInsn *decode)
 
     if (op->has_ea) {
         /* NOTE: order is important for MMU exceptions */
-        gen_op_st_v(s, ot, s->T0, s->A0);
+        gen_writeback(s, decode, 0, s->T0);
         op->unit = X86_OP_SKIP;
     }
     /* NOTE: writing back registers after update is important for pop %sp */
-- 
2.39.2


