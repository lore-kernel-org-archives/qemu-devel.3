Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F685D70DEB
	for <qemu-devel@archiver.kernel.org>; Thu, 28 Nov 2024 18:40:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tGjQb-00074g-M8; Thu, 28 Nov 2024 13:39:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@openvz.org>)
 id 1tGjQL-0006yL-Pr; Thu, 28 Nov 2024 13:39:34 -0500
Received: from relay.virtuozzo.com ([130.117.225.111])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@openvz.org>)
 id 1tGjQI-00060K-Fo; Thu, 28 Nov 2024 13:39:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=virtuozzo.com; s=relay; h=MIME-Version:Message-ID:Date:Subject:From:
 Content-Type; bh=T6/ShqNd7xJYNMPPHGpqxmzqmNhUuqpMqpttUwz93z0=; b=ky1fwoZwcM11
 +LcP5EwVPNYtlGv9rcvasmG6KQPrOz+u5adXCUBaQ52gQgUmCDZDybRdm/CRMcheovWYZ22ewi/l+
 Opg5qjOv9lhTbuUrxFqRDzoUtaGbMsIU5Nzs0z8X6X3GCxNJPyC9TK6lQ8GluiJq1Bo5Ok125wevM
 GIKbjDfHk4e9/ftP58hM9a/4iUn7rnJGR3fKhZSPop5Wg9O8xQDRsNU9HAoV5sT2OaTxLhUDk2Wrb
 VqJl7R9l7+n5gUf6PcaV6irj1uHP74gKuaVz2N5xLKjA+kzUqQJCwkeDzg7rdppbNnWR1+N9RBzec
 F20dx4nkIKomSBrxkK9q4g==;
Received: from ch-vpn.virtuozzo.com ([130.117.225.6] helo=iris.sw.ru)
 by relay.virtuozzo.com with esmtp (Exim 4.96)
 (envelope-from <den@openvz.org>) id 1tGjPn-00E2DN-33;
 Thu, 28 Nov 2024 19:39:09 +0100
To: qemu-block@nongnu.org,
	qemu-devel@nongnu.org
Cc: den@openvz.org, Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>,
 Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>
Subject: [PATCH 1/6] preallocate: truncate the image inside bdrv_inactivate()
Date: Thu, 28 Nov 2024 19:25:48 +0100
Message-ID: <20241128183911.837699-2-den@openvz.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241128183911.837699-1-den@openvz.org>
References: <20241128183911.837699-1-den@openvz.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=130.117.225.111; envelope-from=den@openvz.org;
 helo=relay.virtuozzo.com
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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
Reply-to:  "Denis V. Lunev" <den@openvz.org>
From:  "Denis V. Lunev" via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Let us assume that we have the following quite usual chain:
    QCOW2 -> preallocate-filter -> raw-file
In this case in the case of the migration over shared storage, f.e. NFS
we go through
    bdrv_inactivate()
    bdrv_inactivate_recurse()
        qcow2_inactivate() <- writes a lot of data, f.e. CBT

        bdrv_get_cumulative_perm(qcow2)
        qcow2->open_flags |= BDRV_O_INACTIVE;
        bdrv_refresh_perms(qcow2)

        bdrv_inactivate_recurse(preallocate)
            preallocate_inactivate()

            bdrv_get_cumulative_perm(preallocate)
            preallocate->open_flags |= BDRV_O_INACTIVE;
            bdrv_refresh_perms(preallocate)

Right now preallocate_set_perm() is called through
bdrv_refresh_perms(qcow2) and this is the only moment when permissions
for the entire chain could be changed. If we will deny write permissions
here for the sake of the next step, the only place left for a whole
set of permissions changes would be preallocate_inactivate() callback.
This is all looking really terrible.

In addition to this, we are in trouble due truncate() operation
requested inside prealloc_set_perm() would be in reality called seriously
later, potentially once we have returned from bdrv_inactivate() to the
caller and the control has been passed to the migration target.

This patch has truncated the image inside preallocate_inactivate() thus
making further work inside preallocate_drop_resize_bh() noop.

Signed-off-by: Denis V. Lunev <den@openvz.org>
CC: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
CC: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
CC: Kevin Wolf <kwolf@redhat.com>
CC: Hanna Reitz <hreitz@redhat.com>
---
 block/preallocate.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/block/preallocate.c b/block/preallocate.c
index d215bc5d6d..c14e6a530d 100644
--- a/block/preallocate.c
+++ b/block/preallocate.c
@@ -594,6 +594,11 @@ static void preallocate_child_perm(BlockDriverState *bs, BdrvChild *c,
     }
 }
 
+static int GRAPH_RDLOCK preallocate_inactivate(BlockDriverState *bs)
+{
+    return preallocate_drop_resize(bs, NULL);
+}
+
 static BlockDriver bdrv_preallocate_filter = {
     .format_name = "preallocate",
     .instance_size = sizeof(BDRVPreallocateState),
@@ -616,6 +621,8 @@ static BlockDriver bdrv_preallocate_filter = {
     .bdrv_set_perm = preallocate_set_perm,
     .bdrv_child_perm = preallocate_child_perm,
 
+    .bdrv_inactivate = preallocate_inactivate,
+
     .is_filter = true,
 };
 
-- 
2.45.2


