Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00C30606A31B
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Oct 2026 13:01:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=dVCUL82D
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xKEtK-00086k-AK; Fri, 23 Oct 2026 09:01:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1xKEt3-000865-M7
 for qemu-devel@nongnu.org; Fri, 23 Oct 2026 09:00:47 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1xKEt0-0007ti-EC
 for qemu-devel@nongnu.org; Fri, 23 Oct 2026 09:00:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1792760441;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=sTGoqiuK4/8EaEgzHpGhtNJmB80Whzr3+A4iG+05RNE=;
 b=dVCUL82DWxAyvWBgto6W9Jts06W282AAGM/V1W+mDyShHYiA4i1u+wFKJOZ17o2vn8bXWx
 Y5PaNXnHZ1J8ms+TSlfsC8nwO9tXt9vZoatmMiRvPdD5sROj6zksluDDyTQIpsFp4hSEOm
 dccm1os39Lt1M8yaQCOYpyMpRJf5ZJg=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-251-l5jFM-urPQ6GJ4xy6ETQgw-1; Fri,
 23 Oct 2026 09:00:30 -0400
X-MC-Unique: l5jFM-urPQ6GJ4xy6ETQgw-1
X-Mimecast-MFC-AGG-ID: l5jFM-urPQ6GJ4xy6ETQgw_1792760429
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 43AF41953962; Fri, 23 Oct 2026 13:00:29 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.44.48.42])
 by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 6DB187E2; Fri, 23 Oct 2026 13:00:26 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org, qemu-block@nongnu.org,
 Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>
Cc: qemu-stable@nongnu.org
Subject: [PATCH] block/vhdx: Prevent out-of-bounds BAT accesses with malicious
 vhdx files
Date: Fri, 23 Oct 2026 15:00:23 +0200
Message-ID: <20261023130023.539252-1-thuth@redhat.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 2
X-Spam_score: 0.2
X-Spam_bar: /
X-Spam_report: (0.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.339,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
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
X-Spam-Status: No, score=-21.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

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
---
 block/vhdx.c | 6 ++++++
 1 file changed, 6 insertions(+)

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
2.56.0


