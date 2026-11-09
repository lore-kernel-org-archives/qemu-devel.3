Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 523FB606A331
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Nov 2026 16:48:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=OCf/5OUX
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xQSXY-0003cT-IC; Mon, 09 Nov 2026 11:48:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1xQSVd-0002FP-Q9
 for qemu-devel@nongnu.org; Mon, 09 Nov 2026 11:46:17 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1xQSVP-00010f-Rs
 for qemu-devel@nongnu.org; Mon, 09 Nov 2026 11:46:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1794242760;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=DBKDqEoZNFkoy/7MSmGe2wzjuiTObfL/xphWX0fYDK0=;
 b=OCf/5OUXs/f7OZR5misefe3QVg2dLStaS9LHT79TVkvYOqYO6ZCUWT8SSXfngA3wLMipzD
 cgNZ+BriflAPBp7vMC8ffmaAYDobTjeBKkqRYzU65hxGOYaU4CTBdy8LyzQ4tFeYLxeAvF
 +QnpLO/eOOQ1vLfPztq+cerQisvOagw=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-365-BvZuN_C4MUeWc7zUcruLJQ-1; Mon,
 09 Nov 2026 11:45:58 -0500
X-MC-Unique: BvZuN_C4MUeWc7zUcruLJQ-1
X-Mimecast-MFC-AGG-ID: BvZuN_C4MUeWc7zUcruLJQ_1794242757
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id CC27D18001F8; Mon,  9 Nov 2026 16:45:57 +0000 (UTC)
Received: from merkur.fritz.box (unknown [10.44.32.41])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 7BCE930000E5; Mon,  9 Nov 2026 16:45:56 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com,
	richard.henderson@linaro.org,
	qemu-devel@nongnu.org
Subject: [PULL 11/11] block/vhdx: Prevent out-of-bounds BAT accesses with
 malicious vhdx files
Date: Mon,  9 Nov 2026 17:45:33 +0100
Message-ID: <20261109164533.293487-12-kwolf@redhat.com>
In-Reply-To: <20261109164533.293487-1-kwolf@redhat.com>
References: <20261109164533.293487-1-kwolf@redhat.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
X-Spam-Status: No, score=-20.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
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


