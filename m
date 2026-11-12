Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F12D6606A327
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Nov 2026 09:22:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=QhMNyxaK
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xRR0f-00034X-TP; Thu, 12 Nov 2026 04:22:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1xRR0X-000333-N2
 for qemu-devel@nongnu.org; Thu, 12 Nov 2026 04:22:14 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1xRR0V-00016F-5N
 for qemu-devel@nongnu.org; Thu, 12 Nov 2026 04:22:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1794475330;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=25broEDDCsRLrNipQdqkpQx7nKsbO7DEy+Pn/rPI6EU=;
 b=QhMNyxaKKWGwO3jaYKj7w/xMid4HJVAHjSk0+xXwHs0Wnkx4wWJpTiooDGMuA9RoPXx7zq
 MTOF9O/wbKI3wKrdN0XPX01lpWf0+UV1IstwZDUBKaM0mhgMUqxpTBkyiEinlMnv8mfnYR
 dO17eWZYlRErkZg+Pr9E9WG9A+dQz6c=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-607-1qhvtmuhMOyg2zhibPCIkA-1; Thu,
 12 Nov 2026 04:22:07 -0500
X-MC-Unique: 1qhvtmuhMOyg2zhibPCIkA-1
X-Mimecast-MFC-AGG-ID: 1qhvtmuhMOyg2zhibPCIkA_1794475326
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id D89321805ECF; Thu, 12 Nov 2026 09:22:05 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.44.48.83])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id BEE8418004FC; Thu, 12 Nov 2026 09:22:03 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>,
	qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Hanna Reitz <hreitz@redhat.com>,
 qemu-block@nongnu.org, Eric Blake <eblake@redhat.com>
Subject: [PATCH] block/vhdx: Add alignment checks for region tables
Date: Thu, 12 Nov 2026 10:22:01 +0100
Message-ID: <20261112092201.74651-1-thuth@redhat.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

According to the VHDX specification:

 "The FileOffset and Length fields specify the 64-bit byte offset and 32-bit
  byte length of the object within the file. The values must be a multiple of
  1 MB, and FileOffset must be at least 1 MB."

Thus let's add a sanity check to avoid that bad things could happen later.

Buglink: https://gitlab.com/qemu-project/qemu/-/work_items/3762
Reported-by: Daniel Wade <danjwade95@gmail.com>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 v2: Use QEMU_IS_ALIGNED() as suggested by Eric

 block/vhdx.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/block/vhdx.c b/block/vhdx.c
index 8013a90a1a4..21270988b5a 100644
--- a/block/vhdx.c
+++ b/block/vhdx.c
@@ -566,6 +566,16 @@ vhdx_open_region_tables(BlockDriverState *bs, BDRVVHDXState *s)
 
         vhdx_region_entry_le_import(&rt_entry);
 
+        /*
+         * According to the VHDX spec, offset and length must be multiple
+         * of 1 MiB and length must be at least 1 MiB.
+         */
+        if (!QEMU_IS_ALIGNED(rt_entry.file_offset, MiB) ||
+            !QEMU_IS_ALIGNED(rt_entry.length, MiB) || !rt_entry.length) {
+            ret = -EINVAL;
+            goto fail;
+        }
+
         /* check for region overlap between these entries, and any
          * other memory regions in the file */
         ret = vhdx_region_check(s, rt_entry.file_offset, rt_entry.length);
-- 
2.56.0


