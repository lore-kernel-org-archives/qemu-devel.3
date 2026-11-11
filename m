Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 423DB606A33E
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Nov 2026 15:08:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Ml/mcy8Y
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xR9vI-0007Tl-FB; Wed, 11 Nov 2026 10:07:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1xR9uu-0007LG-6U
 for qemu-devel@nongnu.org; Wed, 11 Nov 2026 10:07:20 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1xR9uq-0000t3-BE
 for qemu-devel@nongnu.org; Wed, 11 Nov 2026 10:07:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1794409625;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=UFrM4WpSySpasTj+U73aZBoiXT47gy/wAfaPfKr5U48=;
 b=Ml/mcy8YUmLuzLtNpYrkqK1a0RSWpDMOzfqpsYE72mwd5yzROW/Vk91MDLpo4XKZ9alZp1
 r0WBVhmLBNtNMkWv9gy8W9VFHHImT9H2pJawYZ4ujsh/Rpdqd0HuTbPEBfWr7hwf+7qFgg
 fdSfLcluUhOWvdW7tT7/OK3UDQDZx8w=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-596-4FcVdOIrNYq1Y-kkfgNXWg-1; Wed,
 11 Nov 2026 10:07:03 -0500
X-MC-Unique: 4FcVdOIrNYq1Y-kkfgNXWg-1
X-Mimecast-MFC-AGG-ID: 4FcVdOIrNYq1Y-kkfgNXWg_1794409622
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 9BE4F195398E; Wed, 11 Nov 2026 15:07:02 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.44.32.37])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id BBF71195608B; Wed, 11 Nov 2026 15:07:00 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>,
	qemu-devel@nongnu.org
Cc: Hanna Reitz <hreitz@redhat.com>,
	qemu-block@nongnu.org
Subject: [PATCH] block/vhdx-log: Improve sanity checks to avoid OOB accesses
 with bad images
Date: Wed, 11 Nov 2026 16:06:59 +0100
Message-ID: <20261111150659.253918-1-thuth@redhat.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 5
X-Spam_score: 0.5
X-Spam_bar: /
X-Spam_report: (0.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
X-Spam-Status: No, score=-20.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The multiplication "hdr->descriptor_count * sizeof(VHDXLogDescriptor)" in
vhdx_log_hdr_is_valid() can overflow on 32-bit systems, so this function
could mark bad images as valid when the truncated result is smaller than
hdr->entry_length. Switch to a division on the right hand side instead to
avoid the overflow problems.

The second problem is in vhdx_log_read_desc(): desc_sectors is a 32-bit
value, thus the multiplication "desc_sectors * VHDX_LOG_SECTOR_SIZE" is
also done with 32 bit arithmetics, and the result is used as "size_t"
parameter for qemu_try_blockalign(), i.e. the parameter here is also
only 32 bits on 32-bit systems. Let's add a sanity check here to avoid
the overflow problem that could lead to trouble later.

Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3860
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 block/vhdx-log.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/block/vhdx-log.c b/block/vhdx-log.c
index 4385a2d4f62..5c20468e1e6 100644
--- a/block/vhdx-log.c
+++ b/block/vhdx-log.c
@@ -246,7 +246,7 @@ static bool vhdx_log_hdr_is_valid(VHDXLogEntries *log, VHDXLogEntryHeader *hdr,
         goto exit;
     }
 
-    if (hdr->descriptor_count * sizeof(VHDXLogDescriptor) > hdr->entry_length) {
+    if (hdr->descriptor_count > hdr->entry_length / sizeof(VHDXLogDescriptor)) {
         goto exit;
     }
 
@@ -360,6 +360,10 @@ vhdx_log_read_desc(BlockDriverState *bs, BDRVVHDXState *s, VHDXLogEntries *log,
     }
 
     desc_sectors = vhdx_compute_desc_sectors(hdr.descriptor_count);
+    if (desc_sectors > UINT32_MAX / VHDX_LOG_SECTOR_SIZE) {
+        ret = -EINVAL;
+        goto exit;
+    }
     desc_entries = qemu_try_blockalign(bs->file->bs,
                                        desc_sectors * VHDX_LOG_SECTOR_SIZE);
     if (desc_entries == NULL) {
-- 
2.56.0


