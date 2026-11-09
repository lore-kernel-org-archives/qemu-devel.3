Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB92E606A326
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Nov 2026 16:48:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=gL7rkN8P
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xQSVw-0002PC-72; Mon, 09 Nov 2026 11:46:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1xQSVK-0002As-2s
 for qemu-devel@nongnu.org; Mon, 09 Nov 2026 11:46:09 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1xQSVG-0000yz-3T
 for qemu-devel@nongnu.org; Mon, 09 Nov 2026 11:45:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1794242753;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=P3VryJo/cSAJFOqxKKDoYnUYv3iURSnr67b/YAslESI=;
 b=gL7rkN8PMmM3vMLsMpz/wAj9M82zQiLbiSbSUV69KsEkDJZvXz5WcVsGWuzwwmnKXEjXlX
 4XAjetkUzCN2bzVoFKMDFkEML0WDhgFN6JAbUUyal+OJuSPIDycao68CMDiZEgB3MctHfh
 DcJxTqIHf+BHhZx7q08i1OzL0fpQM+E=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-445-jsAxoTbwP3exlSjpyPlIrw-1; Mon,
 09 Nov 2026 11:45:49 -0500
X-MC-Unique: jsAxoTbwP3exlSjpyPlIrw-1
X-Mimecast-MFC-AGG-ID: jsAxoTbwP3exlSjpyPlIrw_1794242748
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id D6A1D180064F; Mon,  9 Nov 2026 16:45:48 +0000 (UTC)
Received: from merkur.fritz.box (unknown [10.44.32.41])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 861E03001DA5; Mon,  9 Nov 2026 16:45:47 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com,
	richard.henderson@linaro.org,
	qemu-devel@nongnu.org
Subject: [PULL 06/11] block/vmdk: Avoid overflowing multiplication in
 vmdk_open_vmdk4()
Date: Mon,  9 Nov 2026 17:45:28 +0100
Message-ID: <20261109164533.293487-7-kwolf@redhat.com>
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

From: Peter Maydell <peter.maydell@linaro.org>

In vmdk_open_vmdk4() we set the uint32_t l1_entry_sectors with:
    l1_entry_sectors = le32_to_cpu(header.num_gtes_per_gt)
                        * le64_to_cpu(header.granularity);

We have checked that num_gtes_per_gt is at most 512, but the
header.granularity has not been checked at this point, and so the
multiply can overflow the 32-bit variable.  This overflow is harmless
beacuse we're about to call vmdk_add_extent(), which will fail if the
header.granularity (cluster_sectors) is more than 0x20_0000, but it's
a potential trap for the future if code that relies on the
l1_entry_sectors value gets added between where we set it and where
we make that check.

Check for overlarge granularity at the point of multiplication so
it's clear we can't overflow.

Cc: qemu-stable@nongnu.org
Reported-by: Tristan <https://gitlab.com/TristanInSec>
Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/4029
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Message-ID: <20261103143516.2182626-6-peter.maydell@linaro.org>
Reviewed-by: Kevin Wolf <kwolf@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 block/vmdk.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/block/vmdk.c b/block/vmdk.c
index d7e23ae8098..a9bd8a4245f 100644
--- a/block/vmdk.c
+++ b/block/vmdk.c
@@ -1052,7 +1052,10 @@ vmdk_open_vmdk4(BlockDriverState *bs, BdrvChild *file, int flags,
         error_setg(errp, "L2 table size too big");
         return -EINVAL;
     }
-
+    if (le64_to_cpu(header.granularity) > 0x200000) {
+        error_setg(errp, "Invalid granularity, image may be corrupt");
+        return -EFBIG;
+    }
     l1_entry_sectors = le32_to_cpu(header.num_gtes_per_gt)
                         * le64_to_cpu(header.granularity);
     if (l1_entry_sectors == 0) {
-- 
2.56.0


