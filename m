Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2F21C36008
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Mar 2025 16:40:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1txTnK-00005u-QJ; Wed, 26 Mar 2025 12:39:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Marco.Cavenati@eurecom.fr>)
 id 1txTXO-0005kT-4E; Wed, 26 Mar 2025 12:23:30 -0400
Received: from smtp.eurecom.fr ([193.55.113.210])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Marco.Cavenati@eurecom.fr>)
 id 1txTXI-00042J-AP; Wed, 26 Mar 2025 12:23:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=eurecom.fr; i=@eurecom.fr; q=dns/txt; s=default;
 t=1743006204; x=1774542204;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=ib5IvQ3tvyGQ/iuonjN8bNwSr8FqBwTNLajh/EN271E=;
 b=S3vFjzJzJXdqy/23e9UfQ8iSBDMHcnO8RxalXsWA6pkn4dA6gf/aEoiP
 wv/WDSK5d+1onWAN50PTnXOTwJfwOAfn48Yr9xziCNk6XPwslUrJ98Sht
 5B+n83JbH3E/DXuSw07nPqKdcfmP3Del1BwEQCq3G87pQyHex+iiM1DNX o=;
X-CSE-ConnectionGUID: +wusofiwQ2ySHDERDtzK8Q==
X-CSE-MsgGUID: 4yUF5vo4R0Gwuh1tm1NJGA==
X-IronPort-AV: E=Sophos;i="6.14,278,1736809200"; 
   d="scan'208";a="547941"
Received: from waha.eurecom.fr (HELO smtps.eurecom.fr) ([10.3.2.236])
 by drago1i.eurecom.fr with ESMTP; 26 Mar 2025 17:23:19 +0100
Received: from marco-eurecom-desktop.s3.eurecom.fr (unknown [193.55.114.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by smtps.eurecom.fr (Postfix) with ESMTPSA id F11D027CF;
 Wed, 26 Mar 2025 17:23:18 +0100 (CET)
From: Marco Cavenati <Marco.Cavenati@eurecom.fr>
To: Peter Xu <peterx@redhat.com>,
	Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org, Marco Cavenati <Marco.Cavenati@eurecom.fr>,
 qemu-trivial@nongnu.org
Subject: [PATCH] migration: fix SEEK_CUR offset calculation in
 qio_channel_block_seek
Date: Wed, 26 Mar 2025 17:22:30 +0100
Message-ID: <20250326162230.3323199-1-Marco.Cavenati@eurecom.fr>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=193.55.113.210;
 envelope-from=Marco.Cavenati@eurecom.fr; helo=smtp.eurecom.fr
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Wed, 26 Mar 2025 12:39:54 -0400
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

The SEEK_CUR case in qio_channel_block_seek was incorrectly using the
'whence' parameter instead of the 'offset' parameter when calculating the
new position.

Fixes: 65cf200a51ddc6d0a28ecceac30dc892233cddd7 ("migration: introduce a QIOChannel impl for BlockDriverState VMState")

Signed-off-by: Marco Cavenati <Marco.Cavenati@eurecom.fr>
---
 migration/channel-block.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

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
2.43.0


