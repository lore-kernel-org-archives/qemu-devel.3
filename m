Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F18C606A31C
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Oct 2026 17:12:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LzDVA/MM
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xMq8Y-0008Hu-UW; Fri, 30 Oct 2026 13:11:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cassel@kernel.org>)
 id 1xMq8N-0008Ev-7l; Fri, 30 Oct 2026 13:11:19 -0400
Received: from sea.source.kernel.org ([172.234.252.31])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cassel@kernel.org>)
 id 1xMq8L-0004Bk-I6; Fri, 30 Oct 2026 13:11:18 -0400
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 6CCB4417EB;
 Fri, 30 Oct 2026 17:11:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 432951F000C1;
 Fri, 30 Oct 2026 17:11:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793380275;
 bh=UErSnnkUu1JkkzeWqfaSga5T2xVGUThxr28ZOB8sx/k=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=LzDVA/MM3LzH9M8XI+qbSMEuRx3LaSQUVfTpwFCiaLfCL8ACCwDPyRPuA0XIq6WFf
 vHMeDIvsKKofAYFC/31SmeK2zJoc2kNw8lybd7onBhhZZL73H3kj5vRFe5r+DFCP2T
 uGYGCQYxHn/iGZf+b0Q/eHc8X8x1IDm+JRbLqJKlilqrAIYZT8I4XyfqEFtWM1rE3T
 UmtpLTz0e6JjEZe3jHFcddK6If9WGRQ2ZRdhWueATIuchvOiFw6NGy00zgdwse+Rv1
 FwVs4XxH8IHTfe04WY2Tndq2cvJ21Y/v6R0/TMlMibHxD7h25i5r0O7/Ad8cQWgApm
 ZQdbcS4+pxJNA==
From: Niklas Cassel <cassel@kernel.org>
To: qemu-devel@nongnu.org
Cc: Niklas Cassel <cassel@kernel.org>, dlemoal@kernel.org,
 Stefan Hajnoczi <stefanha@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 Eric Blake <eblake@redhat.com>, qemu-block@nongnu.org,
 Sam Li <faithilikerun@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Fam Zheng <fam@euphon.net>, Jeuk Kim <jeuk20.kim@samsung.com>,
 Daejun Park <daejun7.park@samsung.com>
Subject: [PATCH v16 8/9] block: add accessors for the zone model,
 capacity and open zone limit
Date: Fri, 30 Oct 2026 18:10:35 +0100
Message-ID: <20261030171038.702962-9-cassel@kernel.org>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261030171038.702962-1-cassel@kernel.org>
References: <20261030171038.702962-1-cassel@kernel.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=172.234.252.31; envelope-from=cassel@kernel.org;
 helo=sea.source.kernel.org
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Add the block-backend accessors blk_get_zone_model(),
blk_get_zone_capacity() and blk_get_max_open_zones(), which report the
zoned model, the zone capacity and the maximum number of open zones of
the backing device, mirroring the existing blk_get_zone_size(). This
lets device models query the zoned geometry without dereferencing
BlockDriverState internals.

Signed-off-by: Niklas Cassel <cassel@kernel.org>
---
 block/block-backend.c             | 33 +++++++++++++++++++++++++++++++
 include/system/block-backend-io.h |  3 +++
 2 files changed, 36 insertions(+)

diff --git a/block/block-backend.c b/block/block-backend.c
index 656c0aed67..397ec9ed5a 100644
--- a/block/block-backend.c
+++ b/block/block-backend.c
@@ -2338,6 +2338,39 @@ uint64_t blk_get_zone_size(BlockBackend *blk)
     return bs ? bs->bl.zone_size : 0;
 }
 
+/*
+ * Returns the zoned model of @blk (BLK_Z_HM, BLK_Z_HA), or BLK_Z_NONE if
+ * @blk does not present zoned geometry.
+ */
+BlockZoneModel blk_get_zone_model(BlockBackend *blk)
+{
+    BlockDriverState *bs = blk_bs(blk);
+    IO_CODE();
+    return bs ? bs->bl.zoned : BLK_Z_NONE;
+}
+
+/*
+ * Returns the maximum number of simultaneously open zones for a zoned
+ * backend, or 0 if there is no limit or @blk is not zoned.
+ */
+uint32_t blk_get_max_open_zones(BlockBackend *blk)
+{
+    BlockDriverState *bs = blk_bs(blk);
+    IO_CODE();
+    return bs ? bs->bl.max_open_zones : 0;
+}
+
+/*
+ * Returns how many bytes of each zone of @blk can be written (the zone
+ * capacity), or 0 if that is not known.
+ */
+uint64_t blk_get_zone_capacity(BlockBackend *blk)
+{
+    BlockDriverState *bs = blk_bs(blk);
+    IO_CODE();
+    return bs ? bs->bl.zone_capacity : 0;
+}
+
 /* Returns the optimal write zeroes alignment, in bytes; guaranteed nonzero */
 uint32_t blk_get_pwrite_zeroes_alignment(BlockBackend *blk)
 {
diff --git a/include/system/block-backend-io.h b/include/system/block-backend-io.h
index 78d410b8df..7c958843b4 100644
--- a/include/system/block-backend-io.h
+++ b/include/system/block-backend-io.h
@@ -122,6 +122,9 @@ uint32_t blk_get_pwrite_zeroes_alignment(BlockBackend *blk);
 uint32_t blk_get_max_transfer(BlockBackend *blk);
 uint64_t blk_get_max_hw_transfer(BlockBackend *blk);
 uint64_t blk_get_zone_size(BlockBackend *blk);
+BlockZoneModel blk_get_zone_model(BlockBackend *blk);
+uint32_t blk_get_max_open_zones(BlockBackend *blk);
+uint64_t blk_get_zone_capacity(BlockBackend *blk);
 
 int coroutine_fn blk_co_copy_range(BlockBackend *blk_in, int64_t off_in,
                                    BlockBackend *blk_out, int64_t off_out,
-- 
2.56.0


