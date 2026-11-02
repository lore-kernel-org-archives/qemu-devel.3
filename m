Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E05C606B0E8
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Nov 2026 16:33:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=CEs1rino
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xNuvh-0006b0-2b; Mon, 02 Nov 2026 11:30:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1xNuvf-0006Y0-1c
 for qemu-devel@nongnu.org; Mon, 02 Nov 2026 11:30:39 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1xNuvd-0002KQ-E0
 for qemu-devel@nongnu.org; Mon, 02 Nov 2026 11:30:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1793637036;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+XQugaRBfml5Vb9+Qrv9Epr553UlwXnxz4Kp5QBOaL4=;
 b=CEs1rinoVv2XqbnRvjm0Zx3DeB7BIdE3BpHo0G6M4gw7vitKz3s7hPEvx3sW5w3RGnaeZj
 IBgSiQ8e43qOJyvaFTjISSgPb/Jk/ElGk+IR9P3hb+Jw22ETuROrLmeGVt2yp3EAv0B2gB
 B0epcUYIUm5foA7VHhcgtfIizOq0HUw=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-677-v147nTiYNSex_wkqilg68A-1; Mon,
 02 Nov 2026 11:30:33 -0500
X-MC-Unique: v147nTiYNSex_wkqilg68A-1
X-Mimecast-MFC-AGG-ID: v147nTiYNSex_wkqilg68A_1793637032
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 8629A1955DB4; Mon,  2 Nov 2026 16:30:32 +0000 (UTC)
Received: from merkur.fritz.box (unknown [10.44.32.164])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 3405D1956087; Mon,  2 Nov 2026 16:30:30 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com,
	richard.henderson@linaro.org,
	qemu-devel@nongnu.org
Subject: [PULL 15/17] block/vmdk: Don't preallocate full 64k for compressed
 data grains
Date: Mon,  2 Nov 2026 17:29:53 +0100
Message-ID: <20261102162955.268763-16-kwolf@redhat.com>
In-Reply-To: <20261102162955.268763-1-kwolf@redhat.com>
References: <20261102162955.268763-1-kwolf@redhat.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kwolf@redhat.com;
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
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Sanne Raymaekers <sraymaek@redhat.com>

For stream optimized disks the spec notes: "Each marker and its
associated block begin on a sector or 512‐byte boundary... There are
five types of markers: compressed grain markers,..." [^1]

This means that instead of pre-zeroing grains with their typical size
(64K), in stream optimized disks, only the real size of the compressed
grains should be written. Writing zeroes is not necessary and wasted
work, though usually the zeros are immediately overwritten with the next
compressed clusters and nothing is lost; near the end of the image, it
could mean that the image became larger than expected.

[^1] Virtual Disk Format 5.0 Technical Note.

Signed-off-by: Sanne Raymaekers <sraymaek@redhat.com>
Message-ID: <20261016123750.94769-2-sraymaek@redhat.com>
Reviewed-by: Kevin Wolf <kwolf@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 block/vmdk.c | 27 ++++++++++++++++++---------
 1 file changed, 18 insertions(+), 9 deletions(-)

diff --git a/block/vmdk.c b/block/vmdk.c
index cd8b4ec7c88..7ca030c5fe9 100644
--- a/block/vmdk.c
+++ b/block/vmdk.c
@@ -1730,16 +1730,25 @@ get_cluster_offset(BlockDriverState *bs, VmdkExtent *extent,
         cluster_sector = extent->next_cluster_sector;
         extent->next_cluster_sector += extent->cluster_sectors;
 
-        /* First of all we write grain itself, to avoid race condition
-         * that may to corrupt the image.
-         * This problem may occur because of insufficient space on host disk
-         * or inappropriate VM shutdown.
+        /*
+         * Stream optimized (compressed) extents do not have to be
+         * pre-allocated, as compressed writes always cover the whole
+         * cluster, and will align on 512 byte chunks.
          */
-        ret = get_whole_cluster(bs, extent, cluster_sector * BDRV_SECTOR_SIZE,
-                                offset, skip_start_bytes, skip_end_bytes,
-                                zeroed);
-        if (ret) {
-            return ret;
+        if (!extent->compressed) {
+            /*
+             * First of all we write grain itself, to avoid race condition
+             * that may to corrupt the image.
+             * This problem may occur because of insufficient space on host disk
+             * or inappropriate VM shutdown.
+             */
+            ret = get_whole_cluster(bs, extent,
+                                    cluster_sector * BDRV_SECTOR_SIZE,
+                                    offset, skip_start_bytes, skip_end_bytes,
+                                    zeroed);
+            if (ret) {
+                return ret;
+            }
         }
         if (m_data) {
             m_data->new_allocation = true;
-- 
2.56.0


