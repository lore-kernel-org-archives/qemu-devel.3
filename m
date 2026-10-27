Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF954606A31D
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2026 20:42:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=cuUY2pOa
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xLnyz-0001OJ-89; Tue, 27 Oct 2026 16:41:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1xLny6-0000tY-Ok
 for qemu-devel@nongnu.org; Tue, 27 Oct 2026 16:40:33 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1xLny0-0001Ns-Th
 for qemu-devel@nongnu.org; Tue, 27 Oct 2026 16:40:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1793133604;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=UNEaGhMzMG45HUZH7cB/WbS/zchDc6QOm5Qw7cyNxYY=;
 b=cuUY2pOaicztjJlU4ayk9h5u/bBna9rYFvmk0N/0wIKKUtrBslEGYr19YhoucZvHeVh5Gw
 VQ2XWhFC7st/I9bmLxnvfuS8aB7W99gghb4FU9FR5OnzrXX2Ji8TWAaC2x9bbjwMwOQGVw
 xlRtVgcyd7PRExzfanTzFoTRP5V6Fs0=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-408-y9An_H1OP1mhLCiSvIkpCg-1; Tue,
 27 Oct 2026 16:39:58 -0400
X-MC-Unique: y9An_H1OP1mhLCiSvIkpCg-1
X-Mimecast-MFC-AGG-ID: y9An_H1OP1mhLCiSvIkpCg_1793133597
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 66DE31954107; Tue, 27 Oct 2026 20:39:57 +0000 (UTC)
Received: from localhost (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id A2DBF433; Tue, 27 Oct 2026 20:39:56 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, John Snow <jsnow@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, Fam Zheng <fam@euphon.net>,
 Hanna Reitz <hreitz@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Stefan Hajnoczi <stefanha@redhat.com>, "Denis V. Lunev" <den@openvz.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, Zhao Liu <zhao1.liu@intel.com>,
 Niklas Cassel <cassel@kernel.org>, Damien Le Moal <dlemoal@kernel.org>
Subject: [PULL 13/15] file-posix: reject a zone append past the device capacity
Date: Tue, 27 Oct 2026 16:39:31 -0400
Message-ID: <20261027203933.1066759-14-stefanha@redhat.com>
In-Reply-To: <20261027203933.1066759-1-stefanha@redhat.com>
References: <20261027203933.1066759-1-stefanha@redhat.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95
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

raw_co_zone_append() checks that the offset it is given is aligned to the
zone size, but not that it names a zone of the device. raw_co_prw() then
derives a zone index from it and reads that entry of the write pointer
array, so an offset past the end of the device reads past the end of the
array.

bdrv_co_zone_append() does not catch it either: bdrv_check_qiov_request()
bounds the request against BDRV_MAX_LENGTH, which has nothing to do with
the size of this device. A guest cannot reach it, because
check_zoned_request() in virtio-blk rejects an out of range offset first,
but qemu-io and any other caller of blk_co_zone_append() can:

  $ qemu-io --image-opts -n driver=host_device,filename=/dev/nullb0 \
        -c "zap -p 0x100000000000 0x1000"
  Segmentation fault

On a null_blk device with 1000 zones of 256 MiB, that offset yields zone
index 65536 and reads 512 KiB beyond an 8000 byte allocation.

Reject an offset that lies outside the device. That also bounds the
zone index that raw_co_prw() derives from it, so its write pointer
lookup stays inside the array.

Fixes: 4751d09adcc3 ("block: introduce zone append write for zoned devices")
Reviewed-by: Damien Le Moal <dlemoal@kernel.org>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Signed-off-by: Niklas Cassel <cassel@kernel.org>
Message-id: 20260921142819.2916043-14-cassel@kernel.org
Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 block/file-posix.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/block/file-posix.c b/block/file-posix.c
index 4749d965865..f87afffa40d 100644
--- a/block/file-posix.c
+++ b/block/file-posix.c
@@ -3606,8 +3606,15 @@ raw_co_zone_append(BlockDriverState *bs,
                    QEMUIOVector *qiov,
                    BdrvRequestFlags flags) {
     assert(flags == 0);
+    int64_t capacity = bs->total_sectors << BDRV_SECTOR_BITS;
     int64_t zone_size_mask = bs->bl.zone_size - 1;
 
+    if (*offset >= capacity) {
+        error_report("*offset %" PRId64 " is equal to or greater than the "
+                     "device capacity %" PRId64 "", *offset, capacity);
+        return -ENOSPC;
+    }
+
     if (*offset & zone_size_mask) {
         error_report("sector offset %" PRId64 " is not aligned to zone size "
                      "%" PRId64 "", *offset / 512, bs->bl.zone_size / 512);
-- 
2.56.0


