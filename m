Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBB90606A31A
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2026 20:43:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=hWFxfrWP
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xLnyD-0000p4-82; Tue, 27 Oct 2026 16:40:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1xLnxS-0000lG-Q6
 for qemu-devel@nongnu.org; Tue, 27 Oct 2026 16:39:50 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1xLnxQ-0001KE-V6
 for qemu-devel@nongnu.org; Tue, 27 Oct 2026 16:39:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1793133584;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=FuqqbT/Qb7zoiD/kCKmaVZ0FPJac9h+BFWocoh4j6KA=;
 b=hWFxfrWPlMaHv8vVsFQPkC4pSPp+2l22SXI1EmJ/jP8wLd9QNdmOAeIQcnVpDCmCz8Eecr
 MjlyE1CUJMTMiT/xBwqCKBy4pQJZsP4E5stKCHk3DLKEEG4aUZXosfG43F4ZwRLwmdl9TK
 zht82dULK27rjFtLL8bD8wUUDqlPHw4=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-164-k-8CfBwiODK--VoMTFc4vA-1; Tue,
 27 Oct 2026 16:39:40 -0400
X-MC-Unique: k-8CfBwiODK--VoMTFc4vA-1
X-Mimecast-MFC-AGG-ID: k-8CfBwiODK--VoMTFc4vA_1793133578
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 585C31805A22; Tue, 27 Oct 2026 20:39:38 +0000 (UTC)
Received: from localhost (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 5AFF8410; Tue, 27 Oct 2026 20:39:37 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, John Snow <jsnow@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, Fam Zheng <fam@euphon.net>,
 Hanna Reitz <hreitz@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Stefan Hajnoczi <stefanha@redhat.com>, "Denis V. Lunev" <den@openvz.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, Zhao Liu <zhao1.liu@intel.com>,
 Sam Li <faithilikerun@gmail.com>, Niklas Cassel <cassel@kernel.org>,
 Damien Le Moal <dlemoal@kernel.org>
Subject: [PULL 01/15] block: widen BlockLimits.zone_size to uint64_t
Date: Tue, 27 Oct 2026 16:39:19 -0400
Message-ID: <20261027203933.1066759-2-stefanha@redhat.com>
In-Reply-To: <20261027203933.1066759-1-stefanha@redhat.com>
References: <20261027203933.1066759-1-stefanha@redhat.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95
Received-SPF: pass client-ip=170.10.133.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Sam Li <faithilikerun@gmail.com>

The zone-size field in BlockLimits is currently uint32_t, capping
expressible zone sizes at 4 GiB. Real zoned-device protocols
like NVMe ZNS allow larger zones. Widen BlockLimits.zone_size to
uint64_t to match.

Signed-off-by: Sam Li <faithilikerun@gmail.com>
Reviewed-by: Niklas Cassel <cassel@kernel.org>
Reviewed-by: Damien Le Moal <dlemoal@kernel.org>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Signed-off-by: Niklas Cassel <cassel@kernel.org>
Message-id: 20260921142819.2916043-2-cassel@kernel.org
Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 include/block/block_int-common.h | 2 +-
 block/file-posix.c               | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/block/block_int-common.h b/include/block/block_int-common.h
index 46428b034de..b227ff34a18 100644
--- a/include/block/block_int-common.h
+++ b/include/block/block_int-common.h
@@ -902,7 +902,7 @@ typedef struct BlockLimits {
     BlockZoneModel zoned;
 
     /* zone size expressed in bytes */
-    uint32_t zone_size;
+    uint64_t zone_size;
 
     /* total number of zones */
     uint32_t nr_zones;
diff --git a/block/file-posix.c b/block/file-posix.c
index df117f35d48..df8ca4e88fa 100644
--- a/block/file-posix.c
+++ b/block/file-posix.c
@@ -3617,7 +3617,7 @@ raw_co_zone_append(BlockDriverState *bs,
 
     if (*offset & zone_size_mask) {
         error_report("sector offset %" PRId64 " is not aligned to zone size "
-                     "%" PRId32 "", *offset / 512, bs->bl.zone_size / 512);
+                     "%" PRId64 "", *offset / 512, bs->bl.zone_size / 512);
         return -EINVAL;
     }
 
-- 
2.56.0


