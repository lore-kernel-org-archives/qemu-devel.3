Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73D45ECE589
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Sep 2024 20:44:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1snlE7-0002DI-Kw; Mon, 09 Sep 2024 16:43:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefan@weilnetz.de>)
 id 1snlE1-0002CL-Kt
 for qemu-devel@nongnu.org; Mon, 09 Sep 2024 16:43:05 -0400
Received: from mail.weilnetz.de ([37.120.169.71]
 helo=mail.v2201612906741603.powersrv.de)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <stefan@weilnetz.de>)
 id 1snlDz-00085L-4I
 for qemu-devel@nongnu.org; Mon, 09 Sep 2024 16:43:04 -0400
Received: from qemu.weilnetz.de (qemu.weilnetz.de [188.68.58.204])
 by mail.v2201612906741603.powersrv.de (Postfix) with ESMTP id 016B7DA0552;
 Mon,  9 Sep 2024 22:42:59 +0200 (CEST)
Authentication-Results: mail.v2201612906741603.powersrv.de; dkim=none;
 dmarc=fail reason="No valid SPF, No valid DKIM" header.from=weilnetz.de
 (policy=none); 
 spf=softfail (mail.v2201612906741603.powersrv.de: 188.68.58.204 is neither
 permitted nor denied by domain of stefan@weilnetz.de)
 smtp.mailfrom=stefan@weilnetz.de
Received: by qemu.weilnetz.de (Postfix, from userid 1000)
 id 862AD460030; Mon,  9 Sep 2024 22:42:58 +0200 (CEST)
To: Zhang Chen <chen.zhang@intel.com>, Li Zhijian <lizhijian@fujitsu.com>,
 Jason Wang <jasowang@redhat.com>
Cc: qemu-devel@nongnu.org,
	Stefan Weil <sw@weilnetz.de>
Subject: [PATCH] Fix calculation of minimum in colo_compare_tcp
Date: Mon,  9 Sep 2024 22:42:54 +0200
Message-Id: <20240909204254.1446800-1-sw@weilnetz.de>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 016B7DA0552
X-Spamd-Bar: ++
X-Spamd-Result: default: False [2.50 / 14.00]; VIOLATED_DIRECT_SPF(3.50)[];
 BAYES_HAM(-3.00)[99.99%]; MID_CONTAINS_FROM(1.00)[];
 R_MISSING_CHARSET(0.50)[];
 FORGED_SENDER(0.30)[sw@weilnetz.de,stefan@weilnetz.de];
 RCVD_NO_TLS_LAST(0.10)[];
 DMARC_POLICY_SOFTFAIL(0.10)[weilnetz.de : No valid SPF, No valid
 DKIM,quarantine,sampled_out]; MIME_GOOD(-0.10)[text/plain];
 ONCE_RECEIVED(0.10)[]; MIME_TRACE(0.00)[0:+];
 ASN(0.00)[asn:197540, ipnet:188.68.56.0/22, country:DE];
 RCVD_COUNT_ONE(0.00)[1]; TO_DN_SOME(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[weilnetz.de:mid,weilnetz.de:email];
 R_DKIM_NA(0.00)[]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_FIVE(0.00)[5];
 FROM_NEQ_ENVFROM(0.00)[sw@weilnetz.de,stefan@weilnetz.de];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; R_SPF_SOFTFAIL(0.00)[~all];
 ARC_NA(0.00)[]
X-Rspamd-Server: v2201612906741603
X-Rspamd-Action: no action
Received-SPF: pass client-ip=37.120.169.71; envelope-from=stefan@weilnetz.de;
 helo=mail.v2201612906741603.powersrv.de
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
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
Reply-to:  Stefan Weil <sw@weilnetz.de>
From:  Stefan Weil via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

GitHub's CodeQL reports a critical error which is fixed by using the MIN macro:

    Unsigned difference expression compared to zero

Signed-off-by: Stefan Weil <sw@weilnetz.de>
---
 net/colo-compare.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/net/colo-compare.c b/net/colo-compare.c
index c4ad0ab71f..39f90c4065 100644
--- a/net/colo-compare.c
+++ b/net/colo-compare.c
@@ -412,8 +412,7 @@ static void colo_compare_tcp(CompareState *s, Connection *conn)
      * can ensure that the packet's payload is acknowledged by
      * primary and secondary.
     */
-    uint32_t min_ack = conn->pack - conn->sack > 0 ?
-                       conn->sack : conn->pack;
+    uint32_t min_ack = MIN(conn->pack, conn->sack);
 
 pri:
     if (g_queue_is_empty(&conn->primary_list)) {
-- 
2.39.3 (Apple Git-146)


