Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0AC4FD5CCB1
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Oct 2024 14:08:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t69MW-0003j9-RY; Wed, 30 Oct 2024 10:07:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <abelova@astralinux.ru>)
 id 1t69MT-0003i4-OD
 for qemu-devel@nongnu.org; Wed, 30 Oct 2024 10:07:49 -0400
Received: from mx.astralinux.ru ([89.232.161.68])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <abelova@astralinux.ru>)
 id 1t69MR-0000HO-Ac
 for qemu-devel@nongnu.org; Wed, 30 Oct 2024 10:07:49 -0400
Received: from gca-yc-ruca-srv-mail05.astralinux.ru ([10.177.185.111]
 helo=new-mail.astralinux.ru)
 by mx.astralinux.ru with esmtps (TLS1.3) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.94.2)
 (envelope-from <abelova@astralinux.ru>)
 id 1t69M9-005S6o-6n; Wed, 30 Oct 2024 17:07:29 +0300
Received: from MBP-Anastasia.astralinux.ru (unknown [10.198.14.135])
 by new-mail.astralinux.ru (Postfix) with ESMTPA id 4XdpqB6ks1z1c0mR;
 Wed, 30 Oct 2024 17:07:34 +0300 (MSK)
From: Anastasia Belova <abelova@astralinux.ru>
To: "Dr. David Alan Gilbert" <dave@treblig.org>
Cc: Anastasia Belova <abelova@astralinux.ru>, qemu-devel@nongnu.org,
 sdl.qemu@linuxtesting.org
Subject: [PATCH] monitor: fix cases in switch in memory_dump
Date: Wed, 30 Oct 2024 17:06:51 +0300
Message-ID: <20241030140656.36540-1-abelova@astralinux.ru>
X-Mailer: git-send-email 2.47.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-DrWeb-SpamScore: 0
X-DrWeb-SpamState: legit
X-DrWeb-SpamDetail: gggruggvucftvghtrhhoucdtuddrgedvfedrvdehuddgtddvucetufdoteggodetrfcurfhrohhfihhlvgemucfftfghgfeunecuuegrihhlohhuthemuceftddtnecunecujfgurhephffvvefufffkofgggfestdekredtredttdenucfhrhhomheptehnrghsthgrshhirgcuuegvlhhovhgruceorggsvghlohhvrgesrghsthhrrghlihhnuhigrdhruheqnecuggftrfgrthhtvghrnhepffdvvdeuheevvdfgiedvuedvudetueelgfefheeifffgheetuddtgfevfedvieehnecuffhomhgrihhnpehlihhnuhigthgvshhtihhnghdrohhrghenucfkphepuddtrdduleekrddugedrudefheenucfrrghrrghmpehhvghlohepofeurfdqtehnrghsthgrshhirgdrrghsthhrrghlihhnuhigrdhruhdpihhnvghtpedutddrudelkedrudegrddufeehmeehfeekkedvpdhmrghilhhfrhhomheprggsvghlohhvrgesrghsthhrrghlihhnuhigrdhruhdpnhgspghrtghpthhtohepgedprhgtphhtthhopegurghvvgesthhrvggslhhighdrohhrghdprhgtphhtthhopegrsggvlhhovhgrsegrshhtrhgrlhhinhhugidrrhhupdhrtghpthhtohepqhgvmhhuqdguvghvvghlsehnohhnghhnuhdrohhrghdprhgtphhtthhopehsughlrdhqvghmuheslhhinhhugihtvghsthhinhhgrdhorhhgnecuffhrrdghvggsucetnhhtihhsphgrmhemucenucfvrghgshem
X-DrWeb-SpamVersion: Dr.Web Antispam 1.0.8.202410220#1730287075
X-AntiVirus: Checked by Dr.Web [MailD: 11.1.19.2307031128,
 SE: 11.1.12.2210241838, Core engine: 7.00.65.05230, Virus records: 12230125,
 Updated: 2024-Oct-30 12:59:00 UTC]
Received-SPF: pass client-ip=89.232.161.68; envelope-from=abelova@astralinux.ru;
 helo=mx.astralinux.ru
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9,
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

default case has no condition. So if it is placed
higher that other cases, they are unreachable.

Move dafult case down.

Found by Linux Verification Center (linuxtesting.org)

Signed-off-by: Anastasia Belova <abelova@astralinux.ru>
---
 monitor/hmp-cmds-target.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/monitor/hmp-cmds-target.c b/monitor/hmp-cmds-target.c
index ff01cf9d8d..eea8ca047b 100644
--- a/monitor/hmp-cmds-target.c
+++ b/monitor/hmp-cmds-target.c
@@ -189,7 +189,6 @@ static void memory_dump(Monitor *mon, int count, int format, int wsize,
         i = 0;
         while (i < l) {
             switch(wsize) {
-            default:
             case 1:
                 v = ldub_p(buf + i);
                 break;
@@ -202,6 +201,9 @@ static void memory_dump(Monitor *mon, int count, int format, int wsize,
             case 8:
                 v = ldq_p(buf + i);
                 break;
+            default:
+                v = ldub_p(buf + i);
+                break;
             }
             monitor_printf(mon, " ");
             switch(format) {
-- 
2.47.0


