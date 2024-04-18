Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29748C4345F
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Apr 2024 19:24:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rxXM1-0006Sh-IC; Thu, 18 Apr 2024 15:23:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <raphael.poggi@lynxleap.co.uk>)
 id 1rxXFW-0004ax-3j
 for qemu-devel@nongnu.org; Thu, 18 Apr 2024 15:16:48 -0400
Received: from 6.mo582.mail-out.ovh.net ([87.98.177.69])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <raphael.poggi@lynxleap.co.uk>)
 id 1rxXFU-0005ee-Cx
 for qemu-devel@nongnu.org; Thu, 18 Apr 2024 15:16:45 -0400
Received: from director3.ghost.mail-out.ovh.net (unknown [10.109.140.131])
 by mo582.mail-out.ovh.net (Postfix) with ESMTP id 4VL6vd322Bz17TM
 for <qemu-devel@nongnu.org>; Thu, 18 Apr 2024 19:16:29 +0000 (UTC)
Received: from ghost-submission-6684bf9d7b-4h4mz (unknown [10.110.113.134])
 by director3.ghost.mail-out.ovh.net (Postfix) with ESMTPS id EBF2F1FD5B;
 Thu, 18 Apr 2024 19:16:28 +0000 (UTC)
Received: from lynxleap.co.uk ([37.59.142.109])
 by ghost-submission-6684bf9d7b-4h4mz with ESMTPSA
 id B3nUNYxxIWb1BwAAGjRT0g
 (envelope-from <raphael.poggi@lynxleap.co.uk>); Thu, 18 Apr 2024 19:16:28 +0000
Authentication-Results: garm.ovh; auth=pass
 (GARM-109S003c0c2ac64-ee81-4ecf-a791-ffc80ccacd0e,
 7D36A28102BF8EA446AFB9278237F9F63EFFF5A1)
 smtp.auth=raphael.poggi@lynxleap.co.uk
X-OVh-ClientIp: 2.28.204.171
From: Raphael Poggi <raphael.poggi@lynxleap.co.uk>
To: qemu-devel@nongnu.org
Cc: luc@lmichel.fr, damien.hedde@dahe.fr,
 Raphael Poggi <raphael.poggi@lynxleap.co.uk>
Subject: [PATCH] hw/core/clock: always iterate through childs in
 clock_propagate_period
Date: Thu, 18 Apr 2024 20:16:02 +0100
Message-ID: <20240418191602.2017-1-raphael.poggi@lynxleap.co.uk>
X-Mailer: git-send-email 2.44.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Ovh-Tracer-Id: 8182196098676629022
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: 0
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvledrudektddgudefgecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecunecujfgurhephffvvefufffkofgggfestdekredtredttdenucfhrhhomheptfgrphhhrggvlhcurfhoghhgihcuoehrrghphhgrvghlrdhpohhgghhisehlhihngihlvggrphdrtghordhukheqnecuggftrfgrthhtvghrnhepvdejjefghfduffdujeethfduheetgeetgeduudelkeetveeuheeuleegkeeuvedunecukfhppeduvdejrddtrddtrddupddvrddvkedrvddtgedrudejuddpfeejrdehledrudegvddruddtleenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpeduvdejrddtrddtrddupdhmrghilhhfrhhomheprhgrphhhrggvlhdrphhoghhgiheslhihnhiglhgvrghprdgtohdruhhkpdhnsggprhgtphhtthhopedupdhrtghpthhtohepqhgvmhhuqdguvghvvghlsehnohhnghhnuhdrohhrghdpoffvtefjohhsthepmhhoheekvddpmhhouggvpehsmhhtphhouhht
Received-SPF: pass client-ip=87.98.177.69;
 envelope-from=raphael.poggi@lynxleap.co.uk; helo=6.mo582.mail-out.ovh.net
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Thu, 18 Apr 2024 15:23:28 -0400
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

When dealing with few clocks depending with each others, sometimes
we might only want to update the multiplier/diviser on a specific clock
(cf clockB in drawing below) and call "clock_propagate(clockA)" to
update the childs period according to the potential new multiplier/diviser values.

+--------+     +--------+      +--------+
| clockA | --> | clockB |  --> | clockC |
+--------+     +--------+      +--------+

The actual code would not allow that because, since we cannot call
"clock_propagate" directly on a child, it would exit on the
first child has the period has not changed for clockB, only clockC is
impacted in our example.

Signed-off-by: Raphael Poggi <raphael.poggi@lynxleap.co.uk>
---
 hw/core/clock.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/hw/core/clock.c b/hw/core/clock.c
index a19c7db7df..85421f8b55 100644
--- a/hw/core/clock.c
+++ b/hw/core/clock.c
@@ -101,8 +101,9 @@ static void clock_propagate_period(Clock *clk, bool call_callbacks)
             if (call_callbacks) {
                 clock_call_callback(child, ClockUpdate);
             }
-            clock_propagate_period(child, call_callbacks);
         }
+
+        clock_propagate_period(child, call_callbacks);
     }
 }
 
-- 
2.44.0


