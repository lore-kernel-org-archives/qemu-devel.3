Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47750606A320
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2026 20:42:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=c/Yjlzts
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xLnyW-00015p-VC; Tue, 27 Oct 2026 16:40:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1xLny6-0000tT-Ma
 for qemu-devel@nongnu.org; Tue, 27 Oct 2026 16:40:29 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1xLny0-0001Pn-Th
 for qemu-devel@nongnu.org; Tue, 27 Oct 2026 16:40:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1793133605;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8K+grF7NHxQmwden51rqzd/5a+Fq+kZE7nG0xxS+Yi0=;
 b=c/Yjlzts3qUkEE9+L33/AOEKZMNdqHpmmliPw0dBEQl3mrmg2vp631NnFYL31tjMcGHEeq
 /mdfFhdPSKErVi5cHeGsLBJuTA0vtUJLHxzDXR9QDizWSQRnP3oqXNFFMe7vlPCvMg0gY+
 ZSdkEO2uYdyLyfwv4ms7R+nRx/Kj/Vk=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-256-1CAS6er4PWGOLRjZEir7Tw-1; Tue,
 27 Oct 2026 16:40:01 -0400
X-MC-Unique: 1CAS6er4PWGOLRjZEir7Tw-1
X-Mimecast-MFC-AGG-ID: 1CAS6er4PWGOLRjZEir7Tw_1793133600
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 2316F1805A24; Tue, 27 Oct 2026 20:40:00 +0000 (UTC)
Received: from localhost (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id CDF20300019F; Tue, 27 Oct 2026 20:39:59 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, John Snow <jsnow@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, Fam Zheng <fam@euphon.net>,
 Hanna Reitz <hreitz@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Stefan Hajnoczi <stefanha@redhat.com>, "Denis V. Lunev" <den@openvz.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, Zhao Liu <zhao1.liu@intel.com>,
 Niklas Cassel <cassel@kernel.org>
Subject: [PULL 15/15] block: do not use CoroutineIOCompletion to hold a return
 value
Date: Tue, 27 Oct 2026 16:39:33 -0400
Message-ID: <20261027203933.1066759-16-stefanha@redhat.com>
In-Reply-To: <20261027203933.1066759-1-stefanha@redhat.com>
References: <20261027203933.1066759-1-stefanha@redhat.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

bdrv_co_zone_report(), bdrv_co_zone_mgmt() and bdrv_co_zone_append() each
declare a CoroutineIOCompletion in order to use its ret field, and never
touch the coroutine field that the rest of the structure exists for.

That structure is for a request which completes through
bdrv_co_io_em_complete(), where the callback has to store the result
somewhere and wake the coroutine that is waiting for it. These three call
into the driver directly and are already running in the coroutine that
wants the result, so there is nothing to wake and nowhere else for the
value to live.

Use a plain int. bdrv_co_zone_append() already has one.

Suggested-by: Stefan Hajnoczi <stefanha@redhat.com>
Signed-off-by: Niklas Cassel <cassel@kernel.org>
Message-id: 20260921142819.2916043-16-cassel@kernel.org
Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 block/io.c | 29 +++++++++++------------------
 1 file changed, 11 insertions(+), 18 deletions(-)

diff --git a/block/io.c b/block/io.c
index c86f96bd612..06b1fc13b9f 100644
--- a/block/io.c
+++ b/block/io.c
@@ -3308,40 +3308,36 @@ int coroutine_fn bdrv_co_zone_report(BlockDriverState *bs, int64_t offset,
                         BlockZoneDescriptor *zones)
 {
     BlockDriver *drv = bs->drv;
-    CoroutineIOCompletion co = {
-            .coroutine = qemu_coroutine_self(),
-    };
+    int ret;
     IO_CODE();
 
     bdrv_inc_in_flight(bs);
     if (!drv || !drv->bdrv_co_zone_report || bs->bl.zoned == BLK_Z_NONE) {
-        co.ret = -ENOTSUP;
+        ret = -ENOTSUP;
         goto out;
     }
-    co.ret = drv->bdrv_co_zone_report(bs, offset, nr_zones, zones);
+    ret = drv->bdrv_co_zone_report(bs, offset, nr_zones, zones);
 out:
     bdrv_dec_in_flight(bs);
-    return co.ret;
+    return ret;
 }
 
 int coroutine_fn bdrv_co_zone_mgmt(BlockDriverState *bs, BlockZoneOp op,
         int64_t offset, int64_t len)
 {
     BlockDriver *drv = bs->drv;
-    CoroutineIOCompletion co = {
-            .coroutine = qemu_coroutine_self(),
-    };
+    int ret;
     IO_CODE();
 
     bdrv_inc_in_flight(bs);
     if (!drv || !drv->bdrv_co_zone_mgmt || bs->bl.zoned == BLK_Z_NONE) {
-        co.ret = -ENOTSUP;
+        ret = -ENOTSUP;
         goto out;
     }
-    co.ret = drv->bdrv_co_zone_mgmt(bs, op, offset, len);
+    ret = drv->bdrv_co_zone_mgmt(bs, op, offset, len);
 out:
     bdrv_dec_in_flight(bs);
-    return co.ret;
+    return ret;
 }
 
 int coroutine_fn bdrv_co_zone_append(BlockDriverState *bs, int64_t *offset,
@@ -3350,9 +3346,6 @@ int coroutine_fn bdrv_co_zone_append(BlockDriverState *bs, int64_t *offset,
 {
     int ret;
     BlockDriver *drv = bs->drv;
-    CoroutineIOCompletion co = {
-            .coroutine = qemu_coroutine_self(),
-    };
     IO_CODE();
 
     ret = bdrv_check_qiov_request(*offset, qiov->size, qiov, 0, NULL);
@@ -3384,13 +3377,13 @@ int coroutine_fn bdrv_co_zone_append(BlockDriverState *bs, int64_t *offset,
 
     bdrv_inc_in_flight(bs);
     if (!drv || !drv->bdrv_co_zone_append || bs->bl.zoned == BLK_Z_NONE) {
-        co.ret = -ENOTSUP;
+        ret = -ENOTSUP;
         goto out;
     }
-    co.ret = drv->bdrv_co_zone_append(bs, offset, qiov, flags);
+    ret = drv->bdrv_co_zone_append(bs, offset, qiov, flags);
 out:
     bdrv_dec_in_flight(bs);
-    return co.ret;
+    return ret;
 }
 
 uint32_t bdrv_zone_index(BlockDriverState *bs, uint64_t offset)
-- 
2.56.0


