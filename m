Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D635CC3ABDA
	for <qemu-devel@archiver.kernel.org>; Thu, 15 May 2025 02:31:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uFOMh-0007gd-Hw; Wed, 14 May 2025 22:30:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1uFOM5-0007JO-3d
 for qemu-devel@nongnu.org; Wed, 14 May 2025 22:29:53 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1uFOM3-000496-51
 for qemu-devel@nongnu.org; Wed, 14 May 2025 22:29:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1747276190;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=HY2BKYaenOdkHXGj0SC+xO/i13qFKsY5KdzAoAHdnGc=;
 b=hi5YYlv5e23/TwrsUFiRiuF33flDCxZ3iyH2WCXrDC2fWsXLaLqIjPNZjaTl2v9a55ZD5h
 zsIaZrbdE2gxeuhIyfD0cT2zJkviIC8naCYV49Im1GhlwQ9Espzl98lGp2klYip/s2o0nw
 oJlEnHmYT/mFqRTpNaqhdfzihkTBS9s=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-125-jv_9tFhfNqO_9obOcca1Hg-1; Wed,
 14 May 2025 22:29:46 -0400
X-MC-Unique: jv_9tFhfNqO_9obOcca1Hg-1
X-Mimecast-MFC-AGG-ID: jv_9tFhfNqO_9obOcca1Hg_1747276185
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 31757180045C; Thu, 15 May 2025 02:29:45 +0000 (UTC)
Received: from green.redhat.com (unknown [10.2.16.66])
 by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 698971955F24; Thu, 15 May 2025 02:29:43 +0000 (UTC)
From: Eric Blake <eblake@redhat.com>
To: qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>, John Snow <jsnow@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 qemu-block@nongnu.org (open list:Block Jobs)
Subject: [PULL 14/14] mirror: Reduce I/O when destination is
 detect-zeroes:unmap
Date: Wed, 14 May 2025 21:28:57 -0500
Message-ID: <20250515022904.575509-30-eblake@redhat.com>
In-Reply-To: <20250515022904.575509-16-eblake@redhat.com>
References: <20250515022904.575509-16-eblake@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15
Received-SPF: pass client-ip=170.10.129.124; envelope-from=eblake@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -37
X-Spam_score: -3.8
X-Spam_bar: ---
X-Spam_report: (-3.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.686,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

If we are going to punch holes in the mirror destination even for the
portions where the source image is unallocated, it is nicer to treat
the entire image as dirty and punch as we go, rather than pre-zeroing
the entire image just to re-do I/O to the allocated portions of the
image.

Signed-off-by: Eric Blake <eblake@redhat.com>
Message-ID: <20250513220142.535200-2-eblake@redhat.com>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 block/mirror.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/block/mirror.c b/block/mirror.c
index 724318f0371..c2c5099c951 100644
--- a/block/mirror.c
+++ b/block/mirror.c
@@ -920,11 +920,16 @@ static int coroutine_fn GRAPH_UNLOCKED mirror_dirty_init(MirrorBlockJob *s)
          * zeroing happened externally (ret > 0) or if we have a fast
          * way to pre-zero the image (the dirty bitmap will be
          * populated later by the non-zero portions, the same as for
-         * TOP mode).  If pre-zeroing is not fast, then our only
-         * recourse is to mark the entire image dirty.  The act of
-         * pre-zeroing will populate the zero bitmap.
+         * TOP mode).  If pre-zeroing is not fast, or we need to visit
+         * the entire image in order to punch holes even in the
+         * non-allocated regions of the source, then just mark the
+         * entire image dirty and leave the zero bitmap clear at this
+         * point in time.  Otherwise, it can be faster to pre-zero the
+         * image now, even if we re-write the allocated portions of
+         * the disk later, and the pre-zero pass will populate the
+         * zero bitmap.
          */
-        if (!bdrv_can_write_zeroes_with_unmap(target_bs)) {
+        if (!bdrv_can_write_zeroes_with_unmap(target_bs) || punch_holes) {
             bdrv_set_dirty_bitmap(s->dirty_bitmap, 0, s->bdev_length);
             return 0;
         }
-- 
2.49.0


