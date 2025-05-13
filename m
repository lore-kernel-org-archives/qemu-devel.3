Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8D79C3ABC9
	for <qemu-devel@archiver.kernel.org>; Tue, 13 May 2025 22:02:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uExhG-00081U-EG; Tue, 13 May 2025 18:01:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1uExhE-000813-3K
 for qemu-devel@nongnu.org; Tue, 13 May 2025 18:01:56 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1uExhC-0005Np-G4
 for qemu-devel@nongnu.org; Tue, 13 May 2025 18:01:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1747173712;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=eIwUbbxvZtyrs3r5pJVeB+15CG/JHTG5ekitzrl8Y+A=;
 b=cw8JkV4Diiok8Yku+awKqMVT4IMVVi4Azu24T0P3uX4Gdei8CFY6i/3+RGXMRzedR1uX3I
 da3Z9sAE7/49EFh1AFeWb5Evcs1owzoi+RWMRf7mLwIoJojqxFp/NsignMogZ19gxS4J0L
 SnC2niwwkX2pZ6Glwd+L6Dedpn15Xlg=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-648-N5AONUY_M2WbHck4z2tjvQ-1; Tue,
 13 May 2025 18:01:49 -0400
X-MC-Unique: N5AONUY_M2WbHck4z2tjvQ-1
X-Mimecast-MFC-AGG-ID: N5AONUY_M2WbHck4z2tjvQ_1747173708
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 9C0DF1800446; Tue, 13 May 2025 22:01:47 +0000 (UTC)
Received: from green.redhat.com (unknown [10.2.16.81])
 by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 4783219560A3; Tue, 13 May 2025 22:01:44 +0000 (UTC)
From: Eric Blake <eblake@redhat.com>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, sunnyzhyy@qq.com, stefanha@redhat.com,
 vsementsov@yandex-team.ru, John Snow <jsnow@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>
Subject: [PATCH v4 14/13] mirror: Reduce I/O when destination is
 detect-zeroes:unmap
Date: Tue, 13 May 2025 17:00:45 -0500
Message-ID: <20250513220142.535200-2-eblake@redhat.com>
In-Reply-To: <20250509204341.3553601-15-eblake@redhat.com>
References: <20250509204341.3553601-15-eblake@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
Received-SPF: pass client-ip=170.10.133.124; envelope-from=eblake@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.549,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

If we are going to punch holes in the mirror destination even for the
portions where the source image is unallocated, it is nicer to treat
the entire image as dirty and punch as we go, rather than pre-zeroing
the entire image just to re-do I/O to the allocated portions of the
image.

Signed-off-by: Eric Blake <eblake@redhat.com>
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


