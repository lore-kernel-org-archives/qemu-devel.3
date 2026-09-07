Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6333C79F99
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Sep 2026 11:09:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x3XDL-0003um-De; Mon, 07 Sep 2026 07:08:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cassel@kernel.org>)
 id 1x3XD2-0003Ug-8r; Mon, 07 Sep 2026 07:08:20 -0400
Received: from tor.source.kernel.org ([172.105.4.254])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cassel@kernel.org>)
 id 1x3XD0-0003wQ-Sz; Mon, 07 Sep 2026 07:08:20 -0400
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 071A460D83;
 Mon,  7 Sep 2026 11:08:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DBBC41F00A3A;
 Mon,  7 Sep 2026 11:08:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1788779297;
 bh=TO+F2pc2vn4cH6gj+eUGA+TbOU46rfxX7z+qzRTHsOk=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=L2PqapXgWMZapQJF9IbCljAymd6CCIu6Na9j7I3smc1uZfcFSQhW1LGiGeULm4cty
 u2J3JI6c0o6HECx1TomdGBqlWvk9KO/lmDFWep9GLa6qstwBZCRNcfg5ImeFXIyEoo
 pen/JVHhuQHqhL/bG63Nt7RSu4+34HCWFUleSEP3yjZGhqzPp0K7FOn0t1gbEi4SIx
 N62SB71uH7A4Com+tw49dqPAoLgSChotMRE8mJtG9yLmlYjeUE0N7hs+mWXwS93hzf
 L7pXPHjscj25oFUM7h7CmRPLM9PFdgf2cACPA8rzXIkzOc2Kia6edznMIWwtGQr0P0
 0HP1opd/GpB9A==
From: Niklas Cassel <cassel@kernel.org>
To: Stefan Hajnoczi <stefanha@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>
Cc: Sam Li <faithilikerun@gmail.com>, Damien Le Moal <dlemoal@kernel.org>,
 Niklas Cassel <cassel@kernel.org>, qemu-block@nongnu.org,
 qemu-devel@nongnu.org
Subject: [PATCH v4 01/12] block: widen BlockLimits.zone_size to uint64_t
Date: Mon,  7 Sep 2026 13:07:36 +0200
Message-ID: <20260907110748.1868714-2-cassel@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260907110748.1868714-1-cassel@kernel.org>
References: <20260907110748.1868714-1-cassel@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=172.105.4.254; envelope-from=cassel@kernel.org;
 helo=tor.source.kernel.org
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

From: Sam Li <faithilikerun@gmail.com>

The zone-size field in BlockLimits is currently uint32_t, capping
expressible zone sizes at 4 GiB. Real zoned-device protocols
like NVMe ZNS allow larger zones. Widen BlockLimits.zone_size to
uint64_t to match.

Signed-off-by: Sam Li <faithilikerun@gmail.com>
Reviewed-by: Niklas Cassel <cassel@kernel.org>
Reviewed-by: Damien Le Moal <dlemoal@kernel.org>
Signed-off-by: Niklas Cassel <cassel@kernel.org>
---
 block/file-posix.c               | 2 +-
 include/block/block_int-common.h | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/block/file-posix.c b/block/file-posix.c
index 9aad156aad..c0d6ee30e4 100644
--- a/block/file-posix.c
+++ b/block/file-posix.c
@@ -3598,7 +3598,7 @@ raw_co_zone_append(BlockDriverState *bs,
 
     if (*offset & zone_size_mask) {
         error_report("sector offset %" PRId64 " is not aligned to zone size "
-                     "%" PRId32 "", *offset / 512, bs->bl.zone_size / 512);
+                     "%" PRId64 "", *offset / 512, bs->bl.zone_size / 512);
         return -EINVAL;
     }
 
diff --git a/include/block/block_int-common.h b/include/block/block_int-common.h
index 147c08155f..7571ed9968 100644
--- a/include/block/block_int-common.h
+++ b/include/block/block_int-common.h
@@ -901,7 +901,7 @@ typedef struct BlockLimits {
     BlockZoneModel zoned;
 
     /* zone size expressed in bytes */
-    uint32_t zone_size;
+    uint64_t zone_size;
 
     /* total number of zones */
     uint32_t nr_zones;
-- 
2.55.0


