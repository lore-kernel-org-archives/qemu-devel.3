Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E43D606A331
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Nov 2026 20:36:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tls.msk.ru header.i=@tls.msk.ru header.a=rsa-sha256 header.s=202602 header.b=IKVI6oH9
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xT3Pq-0006rQ-Cz; Mon, 16 Nov 2026 15:35:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1xT3NF-0002LN-LM; Mon, 16 Nov 2026 15:32:24 -0500
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1xT3N8-0004rq-1g; Mon, 16 Nov 2026 15:32:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1794860768; bh=v1HEYKETll5n1Q1aMF9F9C79VCTWhO92FQz4vBphGBc=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=IKVI6oH9tvklU70KMRsiJmT8tyfK8GSmnoIPXqZzGI241ISaPKlWvq3giHJ9X+Azh
 uP92oDbP+eUWYJcn9zvFUtJtrsHRH3En+1ULAKq9YWQDWdfWGCADy8w+le/uSsMAl9
 HSzq/SRLKZUzz6WkviBQtqISsdN2uQokYrJqKgCImgTnHkLgUvWXparqBtlenRN5jo
 l3GaJE4IciL3POUivFnvr21qpAuKS24YoBCJs5O7YXmWJpBZc85mHO9FzJTXRl+lSI
 eaIS36ArazvLc5MDoOfbGT/K29v3NIwUDOvOU8sm9YdeyuYHQIivexovaJQX3X1O9d
 tSrrjfu4TCv5A==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 0D9681E71CE;
 Mon, 16 Nov 2026 23:26:08 +0300 (MSK)
Received: from gandalf.tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id 0B36445FBF9;
 Mon, 16 Nov 2026 23:26:08 +0300 (MSK)
Received: by gandalf.tls.msk.ru (Postfix, from userid 1000)
 id EFA23B8EB6; Mon, 16 Nov 2026 23:26:07 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Thomas Huth <thuth@redhat.com>,
 Daniel Wade <danjwade95@gmail.com>, Kevin Wolf <kwolf@redhat.com>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-11.1.4 56/63] block/vhdx: Prevent out-of-bounds BAT accesses
 with malicious vhdx files
Date: Mon, 16 Nov 2026 23:25:35 +0300
Message-ID: <20261116202554.535325-56-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-11.1.4-20261116212645@cover.tls.msk.ru>
References: <qemu-stable-11.1.4-20261116212645@cover.tls.msk.ru>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=212.248.84.144; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, SPF_HELO_NONE=0.001,
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
X-Spam-Status: No, score=-23.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Thomas Huth <thuth@redhat.com>

virtual_disk_size is read directly from a VHDX image's metadata region
and never checked for sane sizes.  The 64 TiB limit (VHDX_MAX_IMAGE_SIZE)
is only enforced in vhdx_co_create(), so it limits images QEMU creates
but never images QEMU opens.

Without the bound, vhdx_calc_bat_entries() computes the block count
into a uint32_t, so a huge image size gets truncated and the BAT is
undersized relative to total_sectors.
vhdx_block_translate() then converts sector numbers into BAT indices
with no bounds check, allowing out-of-bounds access on the BAT array
from both the read and write paths.

To fix the problem, add a VHDX_MAX_IMAGE_SIZE check to vhdx_parse_metadata()
so images opened for reading are subject to the same limit as images
created by QEMU.
With this limit, the calculation in vhdx_calc_bat_entries() cannot get
truncated anymore (block_size is at least 1 MiB):

 VHDX_MAX_IMAGE_SIZE / block_size = 64 TiB / 1 MiB = 64 MiB

... and 64 MiB fit nicely into 32 bits.

To be really on the safe side, let's also add an assertion in
vhdx_block_translate() to catch accesses that exceeds the allocated
entry count.

Buglink: https://gitlab.com/qemu-project/qemu/-/work_items/3762
Reported-by: Daniel Wade <danjwade95@gmail.com>
Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/4470
Reported-by: Mayank Jangid (OpenSec)
Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/4487
Reported-by: Ken Hsu, Royce Lu, and Bo Qu of Palo Alto Networks
Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/4638
Reported-by: Thai Duong (Calif.io)
Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/4733
Reported-by: Xiang Chen
Signed-off-by: Thomas Huth <thuth@redhat.com>
Message-ID: <20261023130023.539252-1-thuth@redhat.com>
Reviewed-by: Kevin Wolf <kwolf@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
(cherry picked from commit 67198583a1ef3432c784f2802c5cda914bc14ca8)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/block/vhdx.c b/block/vhdx.c
index c16e4a00c8d..8013a90a1a4 100644
--- a/block/vhdx.c
+++ b/block/vhdx.c
@@ -815,6 +815,11 @@ vhdx_parse_metadata(BlockDriverState *bs, BDRVVHDXState *s)
     }
 
     s->virtual_disk_size = le64_to_cpu(s->virtual_disk_size);
+    if (s->virtual_disk_size > VHDX_MAX_IMAGE_SIZE) {
+        ret = -EFBIG;
+        goto exit;
+    }
+
     s->logical_sector_size = le32_to_cpu(s->logical_sector_size);
     s->physical_sector_size = le32_to_cpu(s->physical_sector_size);
 
@@ -1149,6 +1154,7 @@ static void vhdx_block_translate(BDRVVHDXState *s, int64_t sector_num,
 
     sinfo->bytes_avail = sinfo->sectors_avail << s->logical_sector_size_bits;
 
+    assert(sinfo->bat_idx < s->bat_entries);
     sinfo->file_offset = s->bat[sinfo->bat_idx] & VHDX_BAT_FILE_OFF_MASK;
 
     sinfo->block_offset = block_offset << s->logical_sector_size_bits;
-- 
2.47.3


