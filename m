Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EE12606A31F
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2026 20:43:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=N2UFch7j
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xLnz1-0001UG-80; Tue, 27 Oct 2026 16:41:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1xLnxy-0000q8-Jn
 for qemu-devel@nongnu.org; Tue, 27 Oct 2026 16:40:27 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1xLnxc-0001Ld-EP
 for qemu-devel@nongnu.org; Tue, 27 Oct 2026 16:40:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1793133593;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=G2vzvwuHxGQYdBj3J31fcTuztNmOOkaMldS/Bb8poG0=;
 b=N2UFch7jm7l0ddZojj+59uwEX1DuiFjsAcNT7DvUQdlCUI0UBv6RYN1ROoySwXxQn8nYtR
 Ps/+Xn2RCBm5Kjv8NxD5f9RKP5wRlgP4KGzJ8i63Ovxyq/C9Ynj2yyRUrAKLO4T8H0HkXC
 ISU9hEYoNT6v3emSqFtVNBvOcGxCgHs=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-676-U7DiufsqPGO3FzCX_p7psA-1; Tue,
 27 Oct 2026 16:39:52 -0400
X-MC-Unique: U7DiufsqPGO3FzCX_p7psA-1
X-Mimecast-MFC-AGG-ID: U7DiufsqPGO3FzCX_p7psA_1793133590
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id CFF15195422F; Tue, 27 Oct 2026 20:39:50 +0000 (UTC)
Received: from localhost (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 3C6031800586; Tue, 27 Oct 2026 20:39:50 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, John Snow <jsnow@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, Fam Zheng <fam@euphon.net>,
 Hanna Reitz <hreitz@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Stefan Hajnoczi <stefanha@redhat.com>, "Denis V. Lunev" <den@openvz.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, Zhao Liu <zhao1.liu@intel.com>,
 Niklas Cassel <cassel@kernel.org>, Damien Le Moal <dlemoal@kernel.org>
Subject: [PULL 08/15] block: reject zone appends that are not a multiple of
 the sector size
Date: Tue, 27 Oct 2026 16:39:26 -0400
Message-ID: <20261027203933.1066759-9-stefanha@redhat.com>
In-Reply-To: <20261027203933.1066759-1-stefanha@redhat.com>
References: <20261027203933.1066759-1-stefanha@redhat.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
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

Zone write pointers are tracked and reported in units of
BDRV_SECTOR_SIZE, so an append whose data size is not a multiple of it
would leave a write pointer that cannot be represented, neither in a
BlockZoneDescriptor nor in the virtio and NVMe zone reports derived from
one.

Nothing states that invariant. file-posix, the only driver that carries
out an append itself, does enforce it, but only as a side effect of
checking each iovec against BlockLimits.write_granularity, which is never
smaller than the sector size. That conflates two constraints: the sector
granularity holds for every driver, whereas write_granularity describes a
coarser requirement of the medium below a driver, and only a driver that
has such a medium should express it.

Check the invariant once in bdrv_co_zone_append(), so that it no longer
rests on a driver that happens to have a granularity of its own to
report.

This is a lower bound, not the alignment that a guest has to observe. The
block layer cannot know that one, because it also depends on the logical
block size the device is configured with, which is a property of the
frontend. The alignment that applies to a guest is the larger of the two,
and it is the frontend that reports it, that validates requests against
it, and that has to refuse a device whose write pointers do not satisfy
it.

Reviewed-by: Damien Le Moal <dlemoal@kernel.org>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Signed-off-by: Niklas Cassel <cassel@kernel.org>
Message-id: 20260921142819.2916043-9-cassel@kernel.org
Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 block/io.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/block/io.c b/block/io.c
index d08956105c2..f6de0588868 100644
--- a/block/io.c
+++ b/block/io.c
@@ -3360,6 +3360,16 @@ int coroutine_fn bdrv_co_zone_append(BlockDriverState *bs, int64_t *offset,
         return ret;
     }
 
+    /*
+     * Zone write pointers are kept and reported in units of BDRV_SECTOR_SIZE,
+     * so an append that would leave a write pointer at a finer granularity
+     * cannot be represented. Drivers may impose a coarser granularity of their
+     * own, see BlockLimits.write_granularity.
+     */
+    if (!QEMU_IS_ALIGNED(qiov->size, BDRV_SECTOR_SIZE)) {
+        return -EINVAL;
+    }
+
     bdrv_inc_in_flight(bs);
     if (!drv || !drv->bdrv_co_zone_append || bs->bl.zoned == BLK_Z_NONE) {
         co.ret = -ENOTSUP;
-- 
2.56.0


