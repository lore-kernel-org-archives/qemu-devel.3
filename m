Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40EB2606A31E
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2026 20:42:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=UNfGpUmt
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xLnz6-0001kJ-P2; Tue, 27 Oct 2026 16:41:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1xLny1-0000qY-8O
 for qemu-devel@nongnu.org; Tue, 27 Oct 2026 16:40:29 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1xLnxg-0001MG-2F
 for qemu-devel@nongnu.org; Tue, 27 Oct 2026 16:40:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1793133597;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=gzc4yJnLMxv0rqRnpa6vbRfcQJ6xJOM52g37zaoLQ1w=;
 b=UNfGpUmtww3R9A6dRF9Z+/OnAuHxL0iWGxwGvkUo5qZbKcjnNWtNxq3nnzO+QNGk5uuWcZ
 p8Eo1TVmGqCce1IF/JnmILUFAYlUFE6PU2p52zT8OJNrllICoJ5HJSYWA3erzqPQtq6Tw7
 NSCat6MX3C9zrobLrkpczM3uLgkRBdQ=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-534-oYHP6Ci7P0K6nnpE7WhVFQ-1; Tue,
 27 Oct 2026 16:39:53 -0400
X-MC-Unique: oYHP6Ci7P0K6nnpE7WhVFQ-1
X-Mimecast-MFC-AGG-ID: oYHP6Ci7P0K6nnpE7WhVFQ_1793133592
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 242F71955BF9; Tue, 27 Oct 2026 20:39:52 +0000 (UTC)
Received: from localhost (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id B6E2118005B7; Tue, 27 Oct 2026 20:39:51 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, John Snow <jsnow@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, Fam Zheng <fam@euphon.net>,
 Hanna Reitz <hreitz@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Stefan Hajnoczi <stefanha@redhat.com>, "Denis V. Lunev" <den@openvz.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, Zhao Liu <zhao1.liu@intel.com>,
 Niklas Cassel <cassel@kernel.org>
Subject: [PULL 09/15] block: reject a zone append that is larger than a zone
Date: Tue, 27 Oct 2026 16:39:27 -0400
Message-ID: <20261027203933.1066759-10-stefanha@redhat.com>
In-Reply-To: <20261027203933.1066759-1-stefanha@redhat.com>
References: <20261027203933.1066759-1-stefanha@redhat.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 5
X-Spam_score: 0.5
X-Spam_bar: /
X-Spam_report: (0.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-16.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Niklas Cassel <cassel@kernel.org>

A zone append cannot cross a zone boundary, so a request larger than a
zone can never be carried out.

Nothing rejects one. The block layer does not look at the length at all,
and raw_co_zone_append() writes qiov->size bytes at the write pointer
once it has validated the offset, so the write runs past the end of the
zone: on a disk with 8 MiB zones, an append of 8 MiB plus one block
fills the zone and advances the write pointer of the zone after it.

virtio-blk does compare the length, but against
BlockLimits.max_append_sectors, which is how much the backend takes in
one command and not how large a zone is. For a Linux block device that
value is never larger than a zone, so virtio-blk is protected by what
the backend happens to report rather than by the check it makes.

Check the length in bdrv_co_zone_append(), next to the check that an
append is a multiple of the sector size. Both are conditions of the
operation rather than of a medium, so the block layer is where they hold
for every caller and where no driver has to repeat them.

The exact bound is tighter: a request also has to fit in the part of the
zone that is still writable, which depends on the write pointer and so
stays with the drivers.

Signed-off-by: Niklas Cassel <cassel@kernel.org>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Message-id: 20260921142819.2916043-10-cassel@kernel.org
Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 block/io.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/block/io.c b/block/io.c
index f6de0588868..eaca8850d01 100644
--- a/block/io.c
+++ b/block/io.c
@@ -3370,6 +3370,18 @@ int coroutine_fn bdrv_co_zone_append(BlockDriverState *bs, int64_t *offset,
         return -EINVAL;
     }
 
+    /*
+     * An append cannot cross a zone boundary, so one that is larger than a
+     * zone can never be carried out, wherever the write pointer of the zone
+     * is. The exact bound is the part of the zone that is still writable,
+     * which only a driver can check, as only it holds the write pointer.
+     * zone_size is zero when the device is not zoned, which is reported as
+     * unsupported below.
+     */
+    if (bs->bl.zone_size && qiov->size > bs->bl.zone_size) {
+        return -EINVAL;
+    }
+
     bdrv_inc_in_flight(bs);
     if (!drv || !drv->bdrv_co_zone_append || bs->bl.zoned == BLK_Z_NONE) {
         co.ret = -ENOTSUP;
-- 
2.56.0


