Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26F07C54E66
	for <qemu-devel@archiver.kernel.org>; Wed, 13 Mar 2024 15:30:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rkQXE-0003mX-EL; Wed, 13 Mar 2024 11:28:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1rkQX6-0003j6-Ac; Wed, 13 Mar 2024 11:28:44 -0400
Received: from forwardcorp1a.mail.yandex.net ([178.154.239.72])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1rkQWz-0002kX-Sn; Wed, 13 Mar 2024 11:28:42 -0400
Received: from mail-nwsmtp-smtp-corp-main-69.vla.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-69.vla.yp-c.yandex.net
 [IPv6:2a02:6b8:c2a:3dc:0:640:1e66:0])
 by forwardcorp1a.mail.yandex.net (Yandex) with ESMTPS id 1103660C43;
 Wed, 13 Mar 2024 18:28:32 +0300 (MSK)
Received: from vsementsov-lin.. (unknown [2a02:6b8:b081:7318::1:20])
 by mail-nwsmtp-smtp-corp-main-69.vla.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id OSpDOX0Xl4Y0-cthBkX4m; Wed, 13 Mar 2024 18:28:31 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1710343711;
 bh=Beqqvkr9H2C67AWO4YL7VkuxAYFA36Y2edAiukFs7/A=;
 h=Message-Id:Date:In-Reply-To:Cc:Subject:References:To:From;
 b=itFsvP3req0fNiEgVrtrBAxHSHJQE/se7qn4a+Cve+iQxdCbuWOgRaBp+nV8u4C5G
 J9Vdg0wAmgK5QR10YZaOGrGndZT7GA7fi+nuRhvu7qkzwl/fIbs1963TX11zgFVlhX
 jENEENoVeJxdbbBwcr01VuL86OEy3+qYxIECqsRM=
Authentication-Results: mail-nwsmtp-smtp-corp-main-69.vla.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, armbru@redhat.com, eblake@redhat.com,
 xiechanglong.d@gmail.com, wencongyang2@huawei.com, hreitz@redhat.com,
 kwolf@redhat.com, vsementsov@yandex-team.ru, jsnow@redhat.com,
 f.ebner@proxmox.com
Subject: [PATCH v4 2/5] block/copy-before-write: support unligned
 snapshot-discard
Date: Wed, 13 Mar 2024 18:28:19 +0300
Message-Id: <20240313152822.626493-3-vsementsov@yandex-team.ru>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240313152822.626493-1-vsementsov@yandex-team.ru>
References: <20240313152822.626493-1-vsementsov@yandex-team.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=178.154.239.72;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1a.mail.yandex.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

First thing that crashes on unligned access here is
bdrv_reset_dirty_bitmap(). Correct way is to align-down the
snapshot-discard request.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Reviewed-by: Fiona Ebner <f.ebner@proxmox.com>
Tested-by: Fiona Ebner <f.ebner@proxmox.com>
---
 block/copy-before-write.c | 16 +++++++++++++---
 1 file changed, 13 insertions(+), 3 deletions(-)

diff --git a/block/copy-before-write.c b/block/copy-before-write.c
index 3e3af30c08..6d89af0b29 100644
--- a/block/copy-before-write.c
+++ b/block/copy-before-write.c
@@ -325,14 +325,24 @@ static int coroutine_fn GRAPH_RDLOCK
 cbw_co_pdiscard_snapshot(BlockDriverState *bs, int64_t offset, int64_t bytes)
 {
     BDRVCopyBeforeWriteState *s = bs->opaque;
+    uint32_t cluster_size = block_copy_cluster_size(s->bcs);
+    int64_t aligned_offset = QEMU_ALIGN_UP(offset, cluster_size);
+    int64_t aligned_end = QEMU_ALIGN_DOWN(offset + bytes, cluster_size);
+    int64_t aligned_bytes;
+
+    if (aligned_end <= aligned_offset) {
+        return 0;
+    }
+    aligned_bytes = aligned_end - aligned_offset;
 
     WITH_QEMU_LOCK_GUARD(&s->lock) {
-        bdrv_reset_dirty_bitmap(s->access_bitmap, offset, bytes);
+        bdrv_reset_dirty_bitmap(s->access_bitmap, aligned_offset,
+                                aligned_bytes);
     }
 
-    block_copy_reset(s->bcs, offset, bytes);
+    block_copy_reset(s->bcs, aligned_offset, aligned_bytes);
 
-    return bdrv_co_pdiscard(s->target, offset, bytes);
+    return bdrv_co_pdiscard(s->target, aligned_offset, aligned_bytes);
 }
 
 static void GRAPH_RDLOCK cbw_refresh_filename(BlockDriverState *bs)
-- 
2.34.1


