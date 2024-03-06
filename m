Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C71B2C54E41
	for <qemu-devel@archiver.kernel.org>; Wed,  6 Mar 2024 14:29:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rhsG7-0000XM-QA; Wed, 06 Mar 2024 09:28:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1rhsG5-0000Wo-KK
 for qemu-devel@nongnu.org; Wed, 06 Mar 2024 09:28:37 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1rhsG4-00043v-36
 for qemu-devel@nongnu.org; Wed, 06 Mar 2024 09:28:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1709735314;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=oO47nNdCbFfOr1QhJsTJLn777GWhWY/TMXW8pMn2RiA=;
 b=ad3srxEkGwpuPt2KnYKC1G+kdu6+BLtBHAHxoXZ/eRv5kWjLYzVQgvw39/ApitLy1UBJA6
 NiweoJfCszImBaySM+0Lmywqh90V+nfUgTEuXa4sH0E5mIPawhhMpW3tJKPZFM6O1BCJw3
 +QITkVbQIEAixlOeNyFS/JDO54Md4wU=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-319-lKMjwvlEPweFXZbmOGkp_A-1; Wed, 06 Mar 2024 09:28:32 -0500
X-MC-Unique: lKMjwvlEPweFXZbmOGkp_A-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
 [10.11.54.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 726DC852008;
 Wed,  6 Mar 2024 14:28:32 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.3])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 4FDEA111DD03;
 Wed,  6 Mar 2024 14:28:32 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 5413F21E6A24; Wed,  6 Mar 2024 15:28:31 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: kwolf@redhat.com, hreitz@redhat.com, qemu-block@nongnu.org,
 qemu-trivial@nongnu.org
Subject: [PATCH] blockdev: Fix blockdev-snapshot-sync error reporting for no
 medium
Date: Wed,  6 Mar 2024 15:28:31 +0100
Message-ID: <20240306142831.2514431-1-armbru@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.3
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.365,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

When external_snapshot_abort() rejects a BlockDriverState without a
medium, it creates an error like this:

        error_setg(errp, "Device '%s' has no medium", device);

Trouble is @device can be null.  My system formats null as "(null)",
but other systems might crash.  Reproducer:

1. Create a block device without a medium

    -> {"execute": "blockdev-add", "arguments": {"driver": "host_cdrom", "node-name": "blk0", "filename": "/dev/sr0"}}
    <- {"return": {}}

3. Attempt to snapshot it

    -> {"execute":"blockdev-snapshot-sync", "arguments": { "node-name": "blk0", "snapshot-file":"/tmp/foo.qcow2","format":"qcow2"}}
    <- {"error": {"class": "GenericError", "desc": "Device '(null)' has no medium"}}

Broken when commit 0901f67ecdb made @device optional.

Use bdrv_get_device_or_node_name() instead.  Now it fails as it
should:

    <- {"error": {"class": "GenericError", "desc": "Device 'blk0' has no medium"}}

Fixes: 0901f67ecdb7 (qmp: Allow to take external snapshots on bs graphs node.)
Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 blockdev.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/blockdev.c b/blockdev.c
index d8fb3399f5..057601dcf0 100644
--- a/blockdev.c
+++ b/blockdev.c
@@ -1395,7 +1395,8 @@ static void external_snapshot_action(TransactionAction *action,
     bdrv_drained_begin(state->old_bs);
 
     if (!bdrv_is_inserted(state->old_bs)) {
-        error_setg(errp, QERR_DEVICE_HAS_NO_MEDIUM, device);
+        error_setg(errp, QERR_DEVICE_HAS_NO_MEDIUM,
+                   bdrv_get_device_or_node_name(state->old_bs));
         return;
     }
 
-- 
2.44.0


