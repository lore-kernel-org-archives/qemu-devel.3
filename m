Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89117D2CDFF
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Oct 2024 16:51:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t3I4e-0000QX-01; Tue, 22 Oct 2024 12:49:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1t3I4b-0000KE-5t
 for qemu-devel@nongnu.org; Tue, 22 Oct 2024 12:49:33 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1t3I4X-00065n-9M
 for qemu-devel@nongnu.org; Tue, 22 Oct 2024 12:49:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1729615767;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0s2NzQAkVXUXjzpQCMdLxQHeBTEoVVx/FCeKoPNe9Qw=;
 b=a8qJcXMcpAlFAhYrlqQ+y9xFRfghZuI2tOtFdlxsjuUkVDG7Q3nLX490RJXttpTnh8BKjd
 JWHMgioEeXa3DuNuGeM2GdiZPnRgzKnA+mhc9O5QbU7xGVrJX4VLfUdmolfesA4A84w2Dy
 5M8B5yANXX27YOpTYNudFlflPM/Buck=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-10-X46m07fuMb-7huM5XCIdmg-1; Tue,
 22 Oct 2024 12:49:23 -0400
X-MC-Unique: X46m07fuMb-7huM5XCIdmg-1
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 011A419560BA; Tue, 22 Oct 2024 16:49:22 +0000 (UTC)
Received: from merkur.fritz.box (unknown [10.39.194.70])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id D463A1955EA3; Tue, 22 Oct 2024 16:49:19 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com,
	qemu-devel@nongnu.org
Subject: [PULL 4/9] block/vdi.c: Make SECTOR_SIZE constant 64-bits
Date: Tue, 22 Oct 2024 18:48:58 +0200
Message-ID: <20241022164903.282174-5-kwolf@redhat.com>
In-Reply-To: <20241022164903.282174-1-kwolf@redhat.com>
References: <20241022164903.282174-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.519,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

From: Peter Maydell <peter.maydell@linaro.org>

Make the VDI SECTOR_SIZE define be a 64-bit constant; this matches
how we define BDRV_SECTOR_SIZE.  The benefit is that it means that we
don't need to carefully cast to 64-bits when doing operations like
"n_sectors * SECTOR_SIZE" to avoid doing a 32x32->32 multiply, which
might overflow, and which Coverity and other static analysers tend to
warn about.

The specific potential overflow Coverity is highlighting is the one
at the end of vdi_co_pwritev() where we write out n_sectors sectors
to the block map.  This is very unlikely to actually overflow, since
the block map has 4 bytes per block and the maximum number of blocks
in the image must fit into a 32-bit integer.  So this commit is not
fixing a real-world bug.

An inspection of all the places currently using SECTOR_SIZE in the
file shows none which care about the change in its type, except for
one call to error_setg() which needs the format string adjusting.

Resolves: Coverity CID 1508076
Suggested-by: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20241008164708.2966400-5-peter.maydell@linaro.org>
Reviewed-by: Kevin Wolf <kwolf@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 block/vdi.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/block/vdi.c b/block/vdi.c
index 149e15c831..26f7638f1f 100644
--- a/block/vdi.c
+++ b/block/vdi.c
@@ -87,7 +87,7 @@
 /* Command line option for static images. */
 #define BLOCK_OPT_STATIC "static"
 
-#define SECTOR_SIZE 512
+#define SECTOR_SIZE 512ULL
 #define DEFAULT_CLUSTER_SIZE 1048576
 /* Note: can't use 1 * MiB, because it's passed to stringify() */
 
@@ -442,7 +442,7 @@ static int vdi_open(BlockDriverState *bs, QDict *options, int flags,
         goto fail;
     } else if (header.sector_size != SECTOR_SIZE) {
         error_setg(errp, "unsupported VDI image (sector size %" PRIu32
-                   " is not %u)", header.sector_size, SECTOR_SIZE);
+                   " is not %llu)", header.sector_size, SECTOR_SIZE);
         ret = -ENOTSUP;
         goto fail;
     } else if (header.block_size != DEFAULT_CLUSTER_SIZE) {
-- 
2.47.0


