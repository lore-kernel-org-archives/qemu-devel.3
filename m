Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E5E8E7717F
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Dec 2024 13:46:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tLjVz-0007YB-5U; Thu, 12 Dec 2024 08:46:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vkuznets@redhat.com>)
 id 1tLjVJ-0007SY-01
 for qemu-devel@nongnu.org; Thu, 12 Dec 2024 08:45:21 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vkuznets@redhat.com>)
 id 1tLjVF-0003bJ-6K
 for qemu-devel@nongnu.org; Thu, 12 Dec 2024 08:45:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1734011114;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=FgrIAgtzIrtHJdpkYfPPWSVKe6gR+OdzkpR3IyZST3E=;
 b=eMsKf6oGhaoxDQzsb20+ETr1kF0pamywjOwK+Q3hNGowK44uYQLZu0MKDUMMB3yCUdKZ72
 lpAVRnkKeL5bBBWnR258J3KKPsar+smASXK6hYnkooZN2ErKZF91yOuLhMJW/3KOch3IQo
 Kz4KPv85X8da1gQJuY+bw6EllDF/CUw=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-519-4CHZiw8WP8Kzxhj8lfT8zg-1; Thu,
 12 Dec 2024 08:45:12 -0500
X-MC-Unique: 4CHZiw8WP8Kzxhj8lfT8zg-1
X-Mimecast-MFC-AGG-ID: 4CHZiw8WP8Kzxhj8lfT8zg
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id D9861195419A; Thu, 12 Dec 2024 13:45:11 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.45.225.198])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id A9FD81955F41; Thu, 12 Dec 2024 13:45:09 +0000 (UTC)
From: Vitaly Kuznetsov <vkuznets@redhat.com>
To: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>, qemu-block@nongnu.org
Cc: Eric Blake <eblake@redhat.com>, Philippe Mathieu-Daude <philmd@linaro.org>
Subject: [PATCH v4 1/2] vpc: Split off vpc_ignore_current_size() helper
Date: Thu, 12 Dec 2024 14:45:03 +0100
Message-ID: <20241212134504.1983757-2-vkuznets@redhat.com>
In-Reply-To: <20241212134504.1983757-1-vkuznets@redhat.com>
References: <20241212134504.1983757-1-vkuznets@redhat.com>
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
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

In preparation to making changes to the logic deciding whether CHS or
'current_size' need to be used in determining the image size, split off
vpc_ignore_current_size() helper.

No functional change intended.

Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
---
 block/vpc.c | 67 +++++++++++++++++++++++++++++------------------------
 1 file changed, 37 insertions(+), 30 deletions(-)

diff --git a/block/vpc.c b/block/vpc.c
index d95a204612b7..fb0ded1c4344 100644
--- a/block/vpc.c
+++ b/block/vpc.c
@@ -216,6 +216,41 @@ static void vpc_parse_options(BlockDriverState *bs, QemuOpts *opts,
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
+ *  Known creator apps:
+ *      'vpc '  :  CHS              Virtual PC (uses disk geometry)
+ *      'qemu'  :  CHS              QEMU (uses disk geometry)
+ *      'qem2'  :  current_size     QEMU (uses current_size)
+ *      'win '  :  current_size     Hyper-V
+ *      'd2v '  :  current_size     Disk2vhd
+ *      'tap\0' :  current_size     XenServer
+ *      'CTXS'  :  current_size     XenConverter
+ *
+ *  The user can override the table values via drive options, however
+ *  even with an override we will still use current_size for images
+ *  that have CHS geometry of the maximum size.
+ */
+static bool vpc_ignore_current_size(VHDFooter *footer)
+{
+    return !!strncmp(footer->creator_app, "win ", 4) &&
+           !!strncmp(footer->creator_app, "qem2", 4) &&
+           !!strncmp(footer->creator_app, "d2v ", 4) &&
+           !!strncmp(footer->creator_app, "CTXS", 4) &&
+           !!memcmp(footer->creator_app, "tap", 4));
+}
+
 static int vpc_open(BlockDriverState *bs, QDict *options, int flags,
                     Error **errp)
 {
@@ -304,36 +339,8 @@ static int vpc_open(BlockDriverState *bs, QDict *options, int flags,
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
+    /* Use CHS or current_size to determine the image size. */
+    use_chs = vpc_ignore_current_size(footer) || s->force_use_chs;
 
     if (!use_chs || bs->total_sectors == VHD_MAX_GEOMETRY || s->force_use_sz) {
         bs->total_sectors = be64_to_cpu(footer->current_size) /
-- 
2.47.0


