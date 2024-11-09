Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 577E3D5E368
	for <qemu-devel@archiver.kernel.org>; Sat,  9 Nov 2024 12:42:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t9kQH-0007s7-PW; Sat, 09 Nov 2024 07:18:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1t9kOk-0005Hb-F3; Sat, 09 Nov 2024 07:17:08 -0500
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1t9kOi-0005D9-VV; Sat, 09 Nov 2024 07:17:02 -0500
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id EFAA9A163E;
 Sat,  9 Nov 2024 15:08:07 +0300 (MSK)
Received: from tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with SMTP id B645F167FC5;
 Sat,  9 Nov 2024 15:09:02 +0300 (MSK)
Received: (nullmailer pid 3296191 invoked by uid 1000);
 Sat, 09 Nov 2024 12:09:01 -0000
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Stefan Weil <sw@weilnetz.de>,
 Zhang Chen <chen.zhang@intel.com>, Jason Wang <jasowang@redhat.com>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-9.1.2 21/58] Fix calculation of minimum in colo_compare_tcp
Date: Sat,  9 Nov 2024 15:08:22 +0300
Message-Id: <20241109120901.3295995-21-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <qemu-stable-9.1.2-20241109150812@cover.tls.msk.ru>
References: <qemu-stable-9.1.2-20241109150812@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=86.62.121.231; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -68
X-Spam_score: -6.9
X-Spam_bar: ------
X-Spam_report: (-6.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_HI=-5,
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

From: Stefan Weil <sw@weilnetz.de>

GitHub's CodeQL reports a critical error which is fixed by using the MIN macro:

    Unsigned difference expression compared to zero

Signed-off-by: Stefan Weil <sw@weilnetz.de>
Cc: qemu-stable@nongnu.org
Reviewed-by: Zhang Chen <chen.zhang@intel.com>
Signed-off-by: Jason Wang <jasowang@redhat.com>
(cherry picked from commit e29bc931e1699a98959680f6776b48673825762b)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

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
2.39.5


