Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1973C3ABCC
	for <qemu-devel@archiver.kernel.org>; Wed, 14 May 2025 13:08:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uFBjx-0007jD-Af; Wed, 14 May 2025 09:01:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1uFBhO-0003yK-P8; Wed, 14 May 2025 08:59:07 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1uFBhM-0007tJ-UF; Wed, 14 May 2025 08:59:02 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 5B6CC121AE6;
 Wed, 14 May 2025 15:57:49 +0300 (MSK)
Received: from think4mjt.tls.msk.ru (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by tsrv.corpit.ru (Postfix) with ESMTP id F134C20B854;
 Wed, 14 May 2025 15:57:58 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Marco Cavenati <Marco.Cavenati@eurecom.fr>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Michael Tokarev <mjt@tls.msk.ru>, Fabiano Rosas <farosas@suse.de>
Subject: [Stable-9.2.4 08/34] migration: fix SEEK_CUR offset calculation in
 qio_channel_block_seek
Date: Wed, 14 May 2025 15:57:30 +0300
Message-Id: <20250514125758.92030-8-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <qemu-stable-9.2.4-20250514155748@cover.tls.msk.ru>
References: <qemu-stable-9.2.4-20250514155748@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

From: Marco Cavenati <Marco.Cavenati@eurecom.fr>

The SEEK_CUR case in qio_channel_block_seek was incorrectly using the
'whence' parameter instead of the 'offset' parameter when calculating the
new position.

Fixes: 65cf200a51 ("migration: introduce a QIOChannel impl for BlockDriverState VMState")
Signed-off-by: Marco Cavenati <Marco.Cavenati@eurecom.fr>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Reviewed-by: Michael Tokarev <mjt@tls.msk.ru>
Message-ID: <20250326162230.3323199-1-Marco.Cavenati@eurecom.fr>
Signed-off-by: Fabiano Rosas <farosas@suse.de>
(cherry picked from commit c0b32426ce56182c1ce2a12904f3a702c2ecc460)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/migration/channel-block.c b/migration/channel-block.c
index fff8d87094..b0477f5b6d 100644
--- a/migration/channel-block.c
+++ b/migration/channel-block.c
@@ -123,7 +123,7 @@ qio_channel_block_seek(QIOChannel *ioc,
         bioc->offset = offset;
         break;
     case SEEK_CUR:
-        bioc->offset += whence;
+        bioc->offset += offset;
         break;
     case SEEK_END:
         error_setg(errp, "Size of VMstate region is unknown");
-- 
2.39.5


