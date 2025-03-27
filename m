Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F810C3600B
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Mar 2025 16:26:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1txq2L-0002C4-2H; Thu, 27 Mar 2025 12:24:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gerben@altlinux.org>)
 id 1txq2I-0002BB-0n; Thu, 27 Mar 2025 12:24:54 -0400
Received: from air.basealt.ru ([193.43.8.18])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gerben@altlinux.org>)
 id 1txq2F-00043a-Eo; Thu, 27 Mar 2025 12:24:53 -0400
Received: from boringlust.malta.altlinux.ru (obninsk.basealt.ru
 [217.15.195.17]) (Authenticated sender: rastyoginds)
 by air.basealt.ru (Postfix) with ESMTPSA id 771E023383;
 Thu, 27 Mar 2025 19:24:49 +0300 (MSK)
From: gerben@altlinux.org
To: qemu-block@nongnu.org,
	kwolf@redhat.com,
	hreitz@redhat.com
Cc: qemu-devel@nongnu.org, sdl.qemu@linuxtesting.org,
 Denis Rastyogin <gerben@altlinux.org>
Subject: [PATCH 4/4] qemu-img: improve queue depth validation in img_bench
Date: Thu, 27 Mar 2025 19:24:23 +0300
Message-ID: <20250327162423.25154-5-gerben@altlinux.org>
X-Mailer: git-send-email 2.42.2
In-Reply-To: <20250327162423.25154-1-gerben@altlinux.org>
References: <20250327162423.25154-1-gerben@altlinux.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=193.43.8.18; envelope-from=gerben@altlinux.org;
 helo=air.basealt.ru
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

From: Denis Rastyogin <gerben@altlinux.org>

This error was discovered by fuzzing qemu-img.

Currently, running `qemu-img bench -d 0` in img_bench is allowed,
which is a pointless operation and causes qemu-img to hang.

Signed-off-by: Denis Rastyogin <gerben@altlinux.org>
---
 qemu-img.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/qemu-img.c b/qemu-img.c
index 5cbf3d18d7..4817bd9b05 100644
--- a/qemu-img.c
+++ b/qemu-img.c
@@ -4581,7 +4581,7 @@ static int img_bench(int argc, char **argv)
         {
             unsigned long res;
 
-            if (qemu_strtoul(optarg, NULL, 0, &res) < 0 || res > INT_MAX) {
+            if (qemu_strtoul(optarg, NULL, 0, &res) <= 0 || res > INT_MAX) {
                 error_report("Invalid queue depth specified");
                 return 1;
             }
-- 
2.42.2


