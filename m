Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C3ADE77180
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Dec 2024 12:26:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tLiG3-0002OB-Tt; Thu, 12 Dec 2024 07:25:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vkuznets@redhat.com>)
 id 1tLiG0-0002NJ-Nx
 for qemu-devel@nongnu.org; Thu, 12 Dec 2024 07:25:30 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vkuznets@redhat.com>)
 id 1tLiFx-0002iA-D8
 for qemu-devel@nongnu.org; Thu, 12 Dec 2024 07:25:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1734006319;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=AjGgD+MJ/PyoAb90y0Ao1Ic/UOIyMLqM/fFKOy4FyAQ=;
 b=ZFBJYV277+N+LwTtGMy7TNZhN9L56dbdYFQ12AiFLCVTkqmPTrIMfR+MX1nDyZy9w7Jv+h
 Lc50eJ0HDI/Q8hcToWkHFZF1+TcwIwOdd/aOAGLFT9bwWf7Ec4RTpe0z6oPgerBlG1KVmn
 9Ne/6eV/1Ma3oiipmyz3MQPTGdS2gr4=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-85-70eNxFPKO-CNJJSk4r1r_w-1; Thu,
 12 Dec 2024 07:25:16 -0500
X-MC-Unique: 70eNxFPKO-CNJJSk4r1r_w-1
X-Mimecast-MFC-AGG-ID: 70eNxFPKO-CNJJSk4r1r_w
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 850E21955F3E; Thu, 12 Dec 2024 12:25:15 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.45.225.198])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 895851956052; Thu, 12 Dec 2024 12:25:13 +0000 (UTC)
From: Vitaly Kuznetsov <vkuznets@redhat.com>
To: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>, qemu-block@nongnu.org
Cc: Eric Blake <eblake@redhat.com>
Subject: [PATCH v3] vpc: Read images exported from Azure correctly
Date: Thu, 12 Dec 2024 13:25:12 +0100
Message-ID: <20241212122512.1974242-1-vkuznets@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124; envelope-from=vkuznets@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.496,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

It was found that 'qemu-nbd' is not able to work with some disk images
exported from Azure. Looking at the 512b footer (which contains VPC
metadata):

00000000  63 6f 6e 65 63 74 69 78  00 00 00 02 00 01 00 00  |conectix........|
00000010  ff ff ff ff ff ff ff ff  2e c7 9b 96 77 61 00 00  |............wa..|
00000020  00 07 00 00 57 69 32 6b  00 00 00 01 40 00 00 00  |....Wi2k....@...|
00000030  00 00 00 01 40 00 00 00  28 a2 10 3f 00 00 00 02  |....@...(..?....|
00000040  ff ff e7 47 8c 54 df 94  bd 35 71 4c 94 5f e5 44  |...G.T...5qL._.D|
00000050  44 53 92 1a 00 00 00 00  00 00 00 00 00 00 00 00  |DS..............|
00000060  00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  |................|

we can see that Azure uses a different 'Creator application' --
'wa\0\0' (offset 0x1c, likely reads as 'Windows Azure') and QEMU uses this
field to determine how it can get image size. Apparently, Azure uses 'new'
method, just like Hyper-V.

Overall, it seems that only VPC and old QEMUs need to be ignored as all new
creator apps seem to have reliable current_size. Invert the logic and make
'current_size' method the default to avoid adding every new creator app to
the list.

Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
---
Changes since v1/v2: invert the logic and make 'vpc' and 'qemu' use CHS
while defaulting to current_size.
---
 block/vpc.c | 65 ++++++++++++++++++++++++++++-------------------------
 1 file changed, 35 insertions(+), 30 deletions(-)

diff --git a/block/vpc.c b/block/vpc.c
index d95a204612b7..e22d4bfe3fc1 100644
--- a/block/vpc.c
+++ b/block/vpc.c
@@ -216,6 +216,39 @@ static void vpc_parse_options(BlockDriverState *bs, QemuOpts *opts,
     }
 }
 
+/*
+ * Microsoft Virtual PC and Microsoft Hyper-V produce and read
+ * VHD image sizes differently.  VPC will rely on CHS geometry,
+ * while Hyper-V and disk2vhd use the size specified in the footer.
+ *
+ * We use a couple of approaches to try and determine the correct method:
+ * look at the Creator App field, and look for images that have CHS
+ * geometry that is the maximum value.
+ *
+ * If the CHS geometry is the maximum CHS geometry, then we assume that
+ * the size is the footer->current_size to avoid truncation.  Otherwise,
+ * we follow the table based on footer->creator_app:
+ *
+ *  Currently known creator apps:
+ *      'vpc '  :  CHS              Virtual PC (uses disk geometry)
+ *      'qemu'  :  CHS              QEMU (uses disk geometry)
+ *      'qem2'  :  current_size     QEMU (uses current_size)
+ *      'win '  :  current_size     Hyper-V
+ *      'd2v '  :  current_size     Disk2vhd
+ *      'tap\0' :  current_size     XenServer
+ *      'CTXS'  :  current_size     XenConverter
+ *      'wa\0\0':  current_size     Azure
+ *
+ *  The user can override the table values via drive options, however
+ *  even with an override we will still use current_size for images
+ *  that have CHS geometry of the maximum size.
+ */
+static bool vpc_ignore_current_size(VHDFooter *footer)
+{
+    return !strncmp(footer->creator_app, "vpc ", 4) ||
+        !strncmp(footer->creator_app, "qemu", 4);
+}
+
 static int vpc_open(BlockDriverState *bs, QDict *options, int flags,
                     Error **errp)
 {
@@ -304,36 +337,8 @@ static int vpc_open(BlockDriverState *bs, QDict *options, int flags,
     bs->total_sectors = (int64_t)
         be16_to_cpu(footer->cyls) * footer->heads * footer->secs_per_cyl;
 
-    /* Microsoft Virtual PC and Microsoft Hyper-V produce and read
-     * VHD image sizes differently.  VPC will rely on CHS geometry,
-     * while Hyper-V and disk2vhd use the size specified in the footer.
-     *
-     * We use a couple of approaches to try and determine the correct method:
-     * look at the Creator App field, and look for images that have CHS
-     * geometry that is the maximum value.
-     *
-     * If the CHS geometry is the maximum CHS geometry, then we assume that
-     * the size is the footer->current_size to avoid truncation.  Otherwise,
-     * we follow the table based on footer->creator_app:
-     *
-     *  Known creator apps:
-     *      'vpc '  :  CHS              Virtual PC (uses disk geometry)
-     *      'qemu'  :  CHS              QEMU (uses disk geometry)
-     *      'qem2'  :  current_size     QEMU (uses current_size)
-     *      'win '  :  current_size     Hyper-V
-     *      'd2v '  :  current_size     Disk2vhd
-     *      'tap\0' :  current_size     XenServer
-     *      'CTXS'  :  current_size     XenConverter
-     *
-     *  The user can override the table values via drive options, however
-     *  even with an override we will still use current_size for images
-     *  that have CHS geometry of the maximum size.
-     */
-    use_chs = (!!strncmp(footer->creator_app, "win ", 4) &&
-               !!strncmp(footer->creator_app, "qem2", 4) &&
-               !!strncmp(footer->creator_app, "d2v ", 4) &&
-               !!strncmp(footer->creator_app, "CTXS", 4) &&
-               !!memcmp(footer->creator_app, "tap", 4)) || s->force_use_chs;
+    /* Use CHS or current_size to determine the image size */
+    use_chs = vpc_ignore_current_size(footer) || s->force_use_chs;
 
     if (!use_chs || bs->total_sectors == VHD_MAX_GEOMETRY || s->force_use_sz) {
         bs->total_sectors = be64_to_cpu(footer->current_size) /
-- 
2.47.0


