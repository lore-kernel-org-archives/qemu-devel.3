Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AFE8606A330
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Nov 2026 16:48:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=SETrX5Cg
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xQSWo-0002uV-DY; Mon, 09 Nov 2026 11:47:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1xQSVK-0002Au-2v
 for qemu-devel@nongnu.org; Mon, 09 Nov 2026 11:46:09 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1xQSVF-0000yF-IP
 for qemu-devel@nongnu.org; Mon, 09 Nov 2026 11:45:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1794242749;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=QbGEdXAUtqumOcFjpDX55Qd+K7L869gfapjJ/VMHGFc=;
 b=SETrX5Cgkvy0G4pkQLqDAFEaVexZV3/evtod2RxctKEOdBa14L4NQOK8BAIApC6Q+yIuVs
 8l+sOqVqHWu0GCpswFeoHw2ISBH/AH12KYCqAjzX3El8a+T1K5ePGNNhG45ghmCSqkEKnz
 fzuNU26nWWcON2w08tvGFvzdOZorLPM=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-331-tIPy53fuMYG3RUeHoF4z6A-1; Mon,
 09 Nov 2026 11:45:48 -0500
X-MC-Unique: tIPy53fuMYG3RUeHoF4z6A-1
X-Mimecast-MFC-AGG-ID: tIPy53fuMYG3RUeHoF4z6A_1794242747
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 20D201955DBE; Mon,  9 Nov 2026 16:45:47 +0000 (UTC)
Received: from merkur.fritz.box (unknown [10.44.32.41])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id C495E30000E5; Mon,  9 Nov 2026 16:45:45 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com,
	richard.henderson@linaro.org,
	qemu-devel@nongnu.org
Subject: [PULL 05/11] block/vmdk: Reject a zero cluster_sectors parameter
Date: Mon,  9 Nov 2026 17:45:27 +0100
Message-ID: <20261109164533.293487-6-kwolf@redhat.com>
In-Reply-To: <20261109164533.293487-1-kwolf@redhat.com>
References: <20261109164533.293487-1-kwolf@redhat.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 5
X-Spam_score: 0.5
X-Spam_bar: /
X-Spam_report: (0.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

From: Peter Maydell <peter.maydell@linaro.org>

In vmdk_add_extent() we reject image files with an excessively large
cluster_sectors parameter, but have no lower bound.  In particular,
if the cluster_sectors is 0 then we will set l1_entry_sectors also to
0, and later crash with a SIGFPE for division by zero.

Reject a zero cluster_sectors value, unless this is a flat extent (in
which case cluster_sectors isn't relevant and the callsite always
passes us zero).

The worst case here is a self-denial-of-service with a QEMU crash,
so this is a hardening bug.

Cc: qemu-stable@nongnu.org
Fixes: b3976d3c8b89 ("VMDK: introduce VmdkExtent")
Reported-by: Tristan <https://gitlab.com/TristanInSec>
Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/4017
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Message-ID: <20261103143516.2182626-5-peter.maydell@linaro.org>
Reviewed-by: Kevin Wolf <kwolf@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 block/vmdk.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/block/vmdk.c b/block/vmdk.c
index bd18d32085f..d7e23ae8098 100644
--- a/block/vmdk.c
+++ b/block/vmdk.c
@@ -552,6 +552,11 @@ static int vmdk_add_extent(BlockDriverState *bs,
     BDRVVmdkState *s = bs->opaque;
     int64_t nb_sectors;
 
+    if (!flat && cluster_sectors == 0) {
+        error_setg(errp, "Invalid zero granularity, image may be corrupt");
+        return -EINVAL;
+    }
+
     if (cluster_sectors > 0x200000) {
         /* 0x200000 * 512Bytes = 1GB for one cluster is unrealistic */
         error_setg(errp, "Invalid granularity, image may be corrupt");
-- 
2.56.0


