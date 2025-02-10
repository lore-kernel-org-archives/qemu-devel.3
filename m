Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9213BC02198
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Feb 2025 16:14:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1thWNY-0006Zr-3A; Mon, 10 Feb 2025 11:11:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1thWNE-0006TJ-8C
 for qemu-devel@nongnu.org; Mon, 10 Feb 2025 11:11:13 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1thWN7-0000xF-QG
 for qemu-devel@nongnu.org; Mon, 10 Feb 2025 11:11:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1739203856;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=kFNGidE30MaZvbRSHY3+xwV9NxjgF4Gq1g8MJJg3i38=;
 b=A3eUFB5+LBlup+Av5PdnbSagPgtq8ZqgY10N8rPZeJGsNsQ92RKEym0nglP5LrqaWir6t3
 lW9ugCj6/49xhb/dKmAawJgsz1fQivyTh1x/XjSe82XpNpe1EVj5SZtWhO/u21K5nVyX0o
 E0HWE9HFd1j7EWgtMb0T+bwLZjlV3ic=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-86-6xZOOS0lMo-KcCz4NseF0Q-1; Mon,
 10 Feb 2025 11:10:54 -0500
X-MC-Unique: 6xZOOS0lMo-KcCz4NseF0Q-1
X-Mimecast-MFC-AGG-ID: 6xZOOS0lMo-KcCz4NseF0Q
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id D75681800877; Mon, 10 Feb 2025 16:10:52 +0000 (UTC)
Received: from merkur.fritz.box (unknown [10.45.225.156])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 9209D195608D; Mon, 10 Feb 2025 16:10:51 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com,
	qemu-devel@nongnu.org
Subject: [PULL 01/25] vpc: Split off vpc_ignore_current_size() helper
Date: Mon, 10 Feb 2025 17:10:10 +0100
Message-ID: <20250210161034.76494-2-kwolf@redhat.com>
In-Reply-To: <20250210161034.76494-1-kwolf@redhat.com>
References: <20250210161034.76494-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -34
X-Spam_score: -3.5
X-Spam_bar: ---
X-Spam_report: (-3.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.388,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

From: Vitaly Kuznetsov <vkuznets@redhat.com>

In preparation to making changes to the logic deciding whether CHS or
'current_size' need to be used in determining the image size, split off
vpc_ignore_current_size() helper.

No functional change intended.

Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
Message-ID: <20241212134504.1983757-2-vkuznets@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Kevin Wolf <kwolf@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 block/vpc.c | 67 +++++++++++++++++++++++++++++------------------------
 1 file changed, 37 insertions(+), 30 deletions(-)

diff --git a/block/vpc.c b/block/vpc.c
index 6489ee756a..cb0773914c 100644
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
2.48.1


