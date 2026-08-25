Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4E5EC61DB9
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2026 20:58:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wyyDd-000154-NE; Tue, 25 Aug 2026 16:58:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cassel@kernel.org>)
 id 1wyyDc-000149-6R; Tue, 25 Aug 2026 16:58:04 -0400
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cassel@kernel.org>)
 id 1wyyDa-000379-Lo; Tue, 25 Aug 2026 16:58:03 -0400
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id C155760053;
 Tue, 25 Aug 2026 20:58:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B53DF1F000E9;
 Tue, 25 Aug 2026 20:57:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1787691480;
 bh=4qCZ5806sp3O28Ci7LEsz346P1orFWcCswMIuQ/hzc8=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=Yi0K3Tg4/36wLr5XwAJWGfB58OaMrJ5YUZ2U0UOrSroMCIhjizwfDVbkiKwG3o5NP
 iFdYxJ5SV6HfUNeJHBIewOUhueTRWu8RSQK60yFizVSZnDPINk5HVCTHNtAIkQ9nyd
 7DQy+HX04jSi4YmquCTGDpOZcXUqZEhPX2NLtWumcA184VRss4LFCd3L3N8mY+a71T
 d0C9hKsY6MGCIyRbPZpZSFDRPufPbrDtfBHA3T9ei0IB+ULMcTz/QXcf5/qXKTdtgA
 zhDqUikhaoaS22lwIacHd7CO8e6BCHJIlMh5alFiRk2e2udOlMU29Kl8jJYK0hzIk3
 0Wk9Gyz6lnmRA==
From: Niklas Cassel <cassel@kernel.org>
To: Stefan Hajnoczi <stefanha@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>
Cc: Sam Li <faithilikerun@gmail.com>, Damien Le Moal <dlemoal@kernel.org>,
 Niklas Cassel <cassel@kernel.org>, qemu-block@nongnu.org,
 qemu-devel@nongnu.org
Subject: [PATCH 01/12] block: widen BlockLimits.zone_size to uint64_t
Date: Tue, 25 Aug 2026 22:57:36 +0200
Message-ID: <20260825205748.679968-2-cassel@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260825205748.679968-1-cassel@kernel.org>
References: <20260825205748.679968-1-cassel@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2600:3c04:e001:324:0:1991:8:25;
 envelope-from=cassel@kernel.org; helo=tor.source.kernel.org
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
Signed-off-by: Niklas Cassel <cassel@kernel.org>
---
 block/file-posix.c               | 2 +-
 include/block/block_int-common.h | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/block/file-posix.c b/block/file-posix.c
index 01037f4b5c..dd9e3d4c37 100644
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


