Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A774606A31E
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2026 20:41:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=hBxWB/AO
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xLnyP-00013J-0d; Tue, 27 Oct 2026 16:40:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1xLny1-0000qS-66
 for qemu-devel@nongnu.org; Tue, 27 Oct 2026 16:40:29 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1xLnxg-0001Mf-3c
 for qemu-devel@nongnu.org; Tue, 27 Oct 2026 16:40:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1793133599;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=PqkQQvp/vNM9bI0E0N8gi3g2ERwb+7178kZaVEn8CJE=;
 b=hBxWB/AO0iQaaPuTUUv9g3MKFJAaYA09UwbthVgREgrvIXZ+8F4P/MMACeKcdbyTpeQ+jA
 k8dmWoEIpB5d781ecYEX6fLVYa8yw9xJHmyeQLCFLndJ4JJ19Ij3CQOlsCNQesJr0j3GTj
 ghBkqJZ7X9CdmCGIHK0vN/ZUbvfVY5I=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-449-f1eRO3YRMnu2sKmVpCmtTQ-1; Tue,
 27 Oct 2026 16:39:57 -0400
X-MC-Unique: f1eRO3YRMnu2sKmVpCmtTQ-1
X-Mimecast-MFC-AGG-ID: f1eRO3YRMnu2sKmVpCmtTQ_1793133595
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id BB36E195411E; Tue, 27 Oct 2026 20:39:55 +0000 (UTC)
Received: from localhost (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 70C2F1800586; Tue, 27 Oct 2026 20:39:55 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, John Snow <jsnow@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, Fam Zheng <fam@euphon.net>,
 Hanna Reitz <hreitz@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Stefan Hajnoczi <stefanha@redhat.com>, "Denis V. Lunev" <den@openvz.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, Zhao Liu <zhao1.liu@intel.com>,
 Niklas Cassel <cassel@kernel.org>
Subject: [PULL 12/15] block: remove BlockLimits.max_append_sectors
Date: Tue, 27 Oct 2026 16:39:30 -0400
Message-ID: <20261027203933.1066759-13-stefanha@redhat.com>
In-Reply-To: <20261027203933.1066759-1-stefanha@redhat.com>
References: <20261027203933.1066759-1-stefanha@redhat.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
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

The field described the largest zone append that a backend accepts. It
had one writer and one reader, and neither is left.

file-posix filled it from the zone_append_max_bytes queue attribute,
which bounds REQ_OP_ZONE_APPEND, an operation it never issues: Linux has
no userspace interface for one, so raw_co_zone_append() substitutes the
write pointer of the zone for the offset and the request reaches the
host as a plain pwritev().

The transfer limit does not apply either, no more than it does to an
ordinary write. This driver reports max_hw_transfer but never sets
BlockLimits.max_transfer, which is what bdrv_aligned_pwritev() splits
by, so a request of any size goes to the host kernel whole and is split
there: on a null_blk device whose zone_append_max_bytes is 130560, a
16 MiB append completes and advances the write pointer by 16 MiB. That
is safe for a sequential zone, as Linux issues the fragments of a split
write in order, with zone write plugging since 6.10 and zone write
locking before that.

virtio-blk was the reader, and now takes what it reports to a guest from
a property instead.

Remove the field and the assignment that filled it. Keeping it would be
worse than not having it: a driver that set it, believing something
enforced it, would be silently ignored.

Signed-off-by: Niklas Cassel <cassel@kernel.org>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Message-id: 20260921142819.2916043-13-cassel@kernel.org
Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 include/block/block_int-common.h | 3 ---
 block/file-posix.c               | 5 -----
 2 files changed, 8 deletions(-)

diff --git a/include/block/block_int-common.h b/include/block/block_int-common.h
index 6bfdcbfe86b..0c7746a5441 100644
--- a/include/block/block_int-common.h
+++ b/include/block/block_int-common.h
@@ -914,9 +914,6 @@ typedef struct BlockLimits {
     /* total number of zones */
     uint32_t nr_zones;
 
-    /* maximum sectors of a zone append write operation */
-    uint32_t max_append_sectors;
-
     /* maximum number of open zones */
     uint32_t max_open_zones;
 
diff --git a/block/file-posix.c b/block/file-posix.c
index 703ec686a35..4749d965865 100644
--- a/block/file-posix.c
+++ b/block/file-posix.c
@@ -1508,11 +1508,6 @@ static void raw_refresh_zoned_limits(BlockDriverState *bs, struct stat *st,
     }
     bs->bl.nr_zones = ret;
 
-    ret = get_sysfs_long_val(st, "zone_append_max_bytes");
-    if (ret > 0) {
-        bs->bl.max_append_sectors = ret >> BDRV_SECTOR_BITS;
-    }
-
     ret = get_sysfs_long_val(st, "zone_write_granularity");
     if (ret >= 0) {
         bs->bl.write_granularity = ret;
-- 
2.56.0


