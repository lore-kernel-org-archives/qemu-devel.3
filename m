Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11B57606A31D
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2026 20:42:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=GIecTTVo
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xLnym-00017W-SZ; Tue, 27 Oct 2026 16:41:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1xLny1-0000qW-8R
 for qemu-devel@nongnu.org; Tue, 27 Oct 2026 16:40:29 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1xLnxg-0001MY-EM
 for qemu-devel@nongnu.org; Tue, 27 Oct 2026 16:40:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1793133599;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=pI13v8K1NV9+OoZdtuZMTcUEL0RdLi1V+8XfoQvaFNg=;
 b=GIecTTVocetaPaUwoqc/vMVKU08a6GhOS4ILOC+lqY1DpZjE8d0XEphLiMaafuMZPagM0V
 BcD8lazP6lzTvgJ47lMpaKAwaajyRlqqfSg34MFDQ/jbpzafWV0g9bPmH8YSZXw+hZyjuy
 fOLh3XDNVph04VvRbfUTRAvS4K6f8Dw=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-261-PHFbgJAqO2iJydzeHLw2aA-1; Tue,
 27 Oct 2026 16:39:54 -0400
X-MC-Unique: PHFbgJAqO2iJydzeHLw2aA-1
X-Mimecast-MFC-AGG-ID: PHFbgJAqO2iJydzeHLw2aA_1793133593
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 400C61954B23; Tue, 27 Oct 2026 20:39:53 +0000 (UTC)
Received: from localhost (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id EA44F410; Tue, 27 Oct 2026 20:39:52 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, John Snow <jsnow@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, Fam Zheng <fam@euphon.net>,
 Hanna Reitz <hreitz@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Stefan Hajnoczi <stefanha@redhat.com>, "Denis V. Lunev" <den@openvz.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, Zhao Liu <zhao1.liu@intel.com>,
 Niklas Cassel <cassel@kernel.org>, Damien Le Moal <dlemoal@kernel.org>
Subject: [PULL 10/15] file-posix: remove the zone append write granularity
 check
Date: Tue, 27 Oct 2026 16:39:28 -0400
Message-ID: <20261027203933.1066759-11-stefanha@redhat.com>
In-Reply-To: <20261027203933.1066759-1-stefanha@redhat.com>
References: <20261027203933.1066759-1-stefanha@redhat.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95
Received-SPF: pass client-ip=170.10.129.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 5
X-Spam_score: 0.5
X-Spam_bar: /
X-Spam_report: (0.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

The check rejects a zone append whose individual iovec lengths are not
multiples of the zone write granularity. That is stricter than the
constraint it is meant to enforce, which applies to the size of the
request as a whole. A request whose total is properly aligned but which
is split across, say, a 512 byte and a 3584 byte iovec is refused here,
even though the iovec boundaries do not survive into the scatter gather
list that reaches the device.

Nor is the driver the right place to enforce it. The granularity that
holds for every backend is the sector granularity, which is now checked
once in bdrv_co_zone_append(). The coarser granularity that a guest has
to observe depends on the logical block size that the device was
configured with, so only a frontend can know it, and a frontend both
reports it to its guest and validates requests against it.

Drop the check. BlockLimits.write_granularity is then set in one place,
by this driver from the zone_write_granularity queue attribute, and read
in one place, where a device whose granularity the configured block sizes
cannot express is refused.

Reviewed-by: Damien Le Moal <dlemoal@kernel.org>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Signed-off-by: Niklas Cassel <cassel@kernel.org>
Message-id: 20260921142819.2916043-11-cassel@kernel.org
Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 block/file-posix.c | 16 +---------------
 1 file changed, 1 insertion(+), 15 deletions(-)

diff --git a/block/file-posix.c b/block/file-posix.c
index 48ae785639e..703ec686a35 100644
--- a/block/file-posix.c
+++ b/block/file-posix.c
@@ -3612,8 +3612,6 @@ raw_co_zone_append(BlockDriverState *bs,
                    BdrvRequestFlags flags) {
     assert(flags == 0);
     int64_t zone_size_mask = bs->bl.zone_size - 1;
-    int64_t iov_len = 0;
-    int64_t len = 0;
 
     if (*offset & zone_size_mask) {
         error_report("sector offset %" PRId64 " is not aligned to zone size "
@@ -3621,20 +3619,8 @@ raw_co_zone_append(BlockDriverState *bs,
         return -EINVAL;
     }
 
-    int64_t wg = bs->bl.write_granularity;
-    int64_t wg_mask = wg - 1;
-    for (int i = 0; i < qiov->niov; i++) {
-        iov_len = qiov->iov[i].iov_len;
-        if (iov_len & wg_mask) {
-            error_report("len of IOVector[%d] %" PRId64 " is not aligned to "
-                         "block size %" PRId64 "", i, iov_len, wg);
-            return -EINVAL;
-        }
-        len += iov_len;
-    }
-
     trace_zbd_zone_append(bs, *offset >> BDRV_SECTOR_BITS);
-    return raw_co_prw(bs, offset, len, qiov, QEMU_AIO_ZONE_APPEND, 0);
+    return raw_co_prw(bs, offset, qiov->size, qiov, QEMU_AIO_ZONE_APPEND, 0);
 }
 #endif
 
-- 
2.56.0


