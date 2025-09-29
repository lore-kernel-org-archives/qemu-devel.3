Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A9C9CCA468
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Sep 2025 16:54:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v3H8A-0003IE-Hz; Mon, 29 Sep 2025 12:53:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1v3H7R-0002pB-MB
 for qemu-devel@nongnu.org; Mon, 29 Sep 2025 12:52:58 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1v3H7N-0002lP-QX
 for qemu-devel@nongnu.org; Mon, 29 Sep 2025 12:52:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1759164772;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ZhN+iR+ZF390fWQx/ABQD5ZU0M8Wt8Fgfqh6Toezzfg=;
 b=NbmoygWIgNnM8Z6K+iYlkOTuftoB50CsGihZM939Sy+YVIFN35SMqpA+wQzwYipc2GAL1X
 8K+L6RRn/dtwIei/3tbdi4cpgqs8pwWLHo8VpbtMFlIrGfQBm6tNvyN4TU8fMym5DzztZM
 flHeMlpzun/BP/5Zgn/of1lE26XiQF0=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-77-3lzaumJ_PMaAlBusMqgq1A-1; Mon,
 29 Sep 2025 12:52:49 -0400
X-MC-Unique: 3lzaumJ_PMaAlBusMqgq1A-1
X-Mimecast-MFC-AGG-ID: 3lzaumJ_PMaAlBusMqgq1A_1759164768
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 125A518005BE; Mon, 29 Sep 2025 16:52:46 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.44.32.27])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id DDC081800577; Mon, 29 Sep 2025 16:52:42 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: Kane-Chen-AS <kane_chen@aspeedtech.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 04/32] hw/nvram/aspeed_otp: Add 'drive' property to support
 block backend
Date: Mon, 29 Sep 2025 18:52:02 +0200
Message-ID: <20250929165230.797471-5-clg@redhat.com>
In-Reply-To: <20250929165230.797471-1-clg@redhat.com>
References: <20250929165230.797471-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.513,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Kane-Chen-AS <kane_chen@aspeedtech.com>

This patch introduces a 'drive' property to the Aspeed OTP device,
allowing it to be backed by a block device. Users can now preload
OTP data via QEMU CLI using a block backend.

Example usage:
  ./qemu-system-arm \
    -blockdev driver=file,filename=otpmem.img,node-name=otp \
    -global aspeed-otp.drive=otp \
    ...

If the drive is provided, its content will be loaded as the initial OTP
state. Otherwise, an internal memory buffer will be used.

Signed-off-by: Kane-Chen-AS <kane_chen@aspeedtech.com>
Reviewed-by: Cédric Le Goater <clg@redhat.com>
Link: https://lore.kernel.org/qemu-devel/20250812094011.2617526-5-kane_chen@aspeedtech.com
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 hw/nvram/aspeed_otp.c | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/hw/nvram/aspeed_otp.c b/hw/nvram/aspeed_otp.c
index e5b7ca96767c..abb37318231b 100644
--- a/hw/nvram/aspeed_otp.c
+++ b/hw/nvram/aspeed_otp.c
@@ -35,13 +35,25 @@ static bool aspeed_otp_init_storage(AspeedOTPState *s, Error **errp)
 {
     uint32_t *p;
     int i, num;
+    uint64_t perm;
 
+    if (s->blk) {
+        perm = BLK_PERM_CONSISTENT_READ |
+               (blk_supports_write_perm(s->blk) ? BLK_PERM_WRITE : 0);
+        if (blk_set_perm(s->blk, perm, BLK_PERM_ALL, errp) < 0) {
+            return false;
+        }
+        if (blk_pread(s->blk, 0, s->size, s->storage, 0) < 0) {
+            error_setg(errp, "Failed to read the initial flash content");
+            return false;
+        }
+    } else {
         num = s->size / sizeof(uint32_t);
         p = (uint32_t *)s->storage;
         for (i = 0; i < num; i++) {
             p[i] = (i % 2 == 0) ? 0x00000000 : 0xFFFFFFFF;
         }
-
+    }
     return true;
 }
 
@@ -75,6 +87,7 @@ static void aspeed_otp_realize(DeviceState *dev, Error **errp)
 
 static const Property aspeed_otp_properties[] = {
     DEFINE_PROP_UINT64("size", AspeedOTPState, size, 0),
+    DEFINE_PROP_DRIVE("drive", AspeedOTPState, blk),
 };
 
 static void aspeed_otp_class_init(ObjectClass *klass, const void *data)
-- 
2.51.0


