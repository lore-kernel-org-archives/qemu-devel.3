Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8FC48C4345F
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Apr 2024 16:30:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rxr7t-0002Lw-Lg; Fri, 19 Apr 2024 12:30:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <raphael.poggi@lynxleap.co.uk>)
 id 1rxr7m-0002LJ-Bv
 for qemu-devel@nongnu.org; Fri, 19 Apr 2024 12:30:08 -0400
Received: from 18.mo582.mail-out.ovh.net ([46.105.73.110])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <raphael.poggi@lynxleap.co.uk>)
 id 1rxr7k-00061S-HW
 for qemu-devel@nongnu.org; Fri, 19 Apr 2024 12:30:05 -0400
Received: from director6.ghost.mail-out.ovh.net (unknown [10.109.176.101])
 by mo582.mail-out.ovh.net (Postfix) with ESMTP id 4VLg9441CQz1K45
 for <qemu-devel@nongnu.org>; Fri, 19 Apr 2024 16:30:00 +0000 (UTC)
Received: from ghost-submission-6684bf9d7b-n2d69 (unknown [10.110.168.217])
 by director6.ghost.mail-out.ovh.net (Postfix) with ESMTPS id E7B7E1FDFC;
 Fri, 19 Apr 2024 16:29:59 +0000 (UTC)
Received: from lynxleap.co.uk ([37.59.142.98])
 by ghost-submission-6684bf9d7b-n2d69 with ESMTPSA
 id gcxSNQecIma3QAcAW3t5XA
 (envelope-from <raphael.poggi@lynxleap.co.uk>); Fri, 19 Apr 2024 16:29:59 +0000
Authentication-Results: garm.ovh; auth=pass
 (GARM-98R00219c80315-19ae-417a-b2a8-dc37c0cc5b78,
 F65BB45773F307CC52C61DE7E0999B19AE952020)
 smtp.auth=raphael.poggi@lynxleap.co.uk
X-OVh-ClientIp: 2.28.204.171
From: Raphael Poggi <raphael.poggi@lynxleap.co.uk>
To: qemu-devel@nongnu.org
Cc: luc@lmichel.fr, damien.hedde@dahe.fr, peter.maydell@linaro.org,
 philmd@linaro.org, Raphael Poggi <raphael.poggi@lynxleap.co.uk>
Subject: [PATCH] hw/core/clock: remove assert in clock_propagate
Date: Fri, 19 Apr 2024 17:29:51 +0100
Message-ID: <20240419162951.23558-1-raphael.poggi@lynxleap.co.uk>
X-Mailer: git-send-email 2.44.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Ovh-Tracer-Id: 11243236472004025886
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: 0
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvledrudekvddguddtgecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecunecujfgurhephffvvefufffkofgggfestdekredtredttdenucfhrhhomheptfgrphhhrggvlhcurfhoghhgihcuoehrrghphhgrvghlrdhpohhgghhisehlhihngihlvggrphdrtghordhukheqnecuggftrfgrthhtvghrnhepvdejjefghfduffdujeethfduheetgeetgeduudelkeetveeuheeuleegkeeuvedunecukfhppeduvdejrddtrddtrddupddvrddvkedrvddtgedrudejuddpfeejrdehledrudegvddrleeknecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepuddvjedrtddrtddruddpmhgrihhlfhhrohhmpehrrghphhgrvghlrdhpohhgghhisehlhihngihlvggrphdrtghordhukhdpnhgspghrtghpthhtohepuddprhgtphhtthhopehqvghmuhdquggvvhgvlhesnhhonhhgnhhurdhorhhgpdfovfetjfhoshhtpehmohehkedvpdhmohguvgepshhmthhpohhuth
Received-SPF: pass client-ip=46.105.73.110;
 envelope-from=raphael.poggi@lynxleap.co.uk; helo=18.mo582.mail-out.ovh.net
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

This commit allows childs clock to propagate their new frequency,
for example, after setting a new multiplier/diviser.

Signed-off-by: Raphael Poggi <raphael.poggi@lynxleap.co.uk>
---
 hw/core/clock.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/hw/core/clock.c b/hw/core/clock.c
index 85421f8b55..174c8be095 100644
--- a/hw/core/clock.c
+++ b/hw/core/clock.c
@@ -109,7 +109,6 @@ static void clock_propagate_period(Clock *clk, bool call_callbacks)
 
 void clock_propagate(Clock *clk)
 {
-    assert(clk->source == NULL);
     trace_clock_propagate(CLOCK_PATH(clk));
     clock_propagate_period(clk, true);
 }
-- 
2.44.0


