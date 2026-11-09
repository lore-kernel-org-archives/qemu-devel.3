Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5953A606A321
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Nov 2026 16:47:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=bOIk1xyN
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xQSVx-0002Pp-0e; Mon, 09 Nov 2026 11:46:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1xQSVK-0002At-3R
 for qemu-devel@nongnu.org; Mon, 09 Nov 2026 11:46:09 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1xQSVF-0000yH-Iu
 for qemu-devel@nongnu.org; Mon, 09 Nov 2026 11:45:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1794242749;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=MeDDsJssyC0bwtmAJUpoNaSHTNemXIsk0GtOAXciUiY=;
 b=bOIk1xyN6xoUyFEn+pJBg3xKY5G3H1YU4riBasd/CCCOqXXGHAAycgyi0k8qZTXUqg1WG3
 PEaZPo6qPURMt5bYACf3w63CXovwBWLxh0bZD1DHlLpukyB+CyZ4Vwn3TGyGYZYbzq+i6b
 SnxB37KarMBmeL2VDo47ngOA3cKo+3s=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-113-wPlHntxHOlSzdTOdVbCGDg-1; Mon,
 09 Nov 2026 11:45:46 -0500
X-MC-Unique: wPlHntxHOlSzdTOdVbCGDg-1
X-Mimecast-MFC-AGG-ID: wPlHntxHOlSzdTOdVbCGDg_1794242745
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 5F41B197731B; Mon,  9 Nov 2026 16:45:45 +0000 (UTC)
Received: from merkur.fritz.box (unknown [10.44.32.41])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 0E12B3001DA5; Mon,  9 Nov 2026 16:45:43 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com,
	richard.henderson@linaro.org,
	qemu-devel@nongnu.org
Subject: [PULL 04/11] block/vmdk: Use larger types for byte counts in
 vmdk_read_extent()
Date: Mon,  9 Nov 2026 17:45:26 +0100
Message-ID: <20261109164533.293487-5-kwolf@redhat.com>
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

In vmdk_read_extent() we use 'int' for cluster_bytes and buf_bytes.
However, cluster_bytes is extent->cluster_sectors * 512 and buf_bytes
is cluster_bytes * 2.  The maximum value for extent->cluster_sectors
(enforced in vmdk_add_extent()) is 0x20_0000, and so the worst case
for buf_bytes is 0x8000_0000, which overflows a signed int.

Make the variable types here int64_t, which matches the type used by
bdrv_co_pread()'s bytes argument and by extent->cluster_sectors.

The worst case thing that a malicious VMDK image could do is cause us
to try to g_malloc() 0xffffffff80000000, which will cause QEMU to
abort(), so this is a self-denial-of-service only, and so a hardening
bug rather than a security issue.

Cc: qemu-stable@nongnu.org
Fixes: 2b2c8c5dec6ba ("VMDK: read/write compressed extent")
Reported-by: boy juju <agx1657748706@gmail.com>
Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3843
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Message-ID: <20261103143516.2182626-4-peter.maydell@linaro.org>
Reviewed-by: Kevin Wolf <kwolf@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 block/vmdk.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/block/vmdk.c b/block/vmdk.c
index 6e4e0423dc9..bd18d32085f 100644
--- a/block/vmdk.c
+++ b/block/vmdk.c
@@ -1940,7 +1940,7 @@ vmdk_read_extent(VmdkExtent *extent, int64_t cluster_offset,
                  int64_t offset_in_cluster, QEMUIOVector *qiov, int bytes)
 {
     int ret;
-    int cluster_bytes, buf_bytes;
+    int64_t cluster_bytes, buf_bytes;
     uint8_t *cluster_buf, *compressed_data;
     uint8_t *uncomp_buf;
     uint32_t data_len;
-- 
2.56.0


