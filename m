Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EBF6BC83F22
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Jul 2025 16:57:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ubiwV-0003Jz-Jj; Tue, 15 Jul 2025 12:55:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1ubieo-0006uN-25
 for qemu-devel@nongnu.org; Tue, 15 Jul 2025 12:37:30 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1ubiem-0003eA-4q
 for qemu-devel@nongnu.org; Tue, 15 Jul 2025 12:37:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1752597447;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=zBw0IywAQRqJPhdyEUhiI/DcTtnx//cepxucbpp+PEo=;
 b=R//2p4TxslNDISO649Q8F9f7/hC9g7WFkCzj0R1K5R/ObjWFsdneVz8/LU7zO3mggT2WgP
 wcI8kBf/E2zWj1asK0pphxqmXBO7+4ZA32zYVg1E5J6Nu++3BRuKIZbYVFRProIBD9BPx2
 Gkyb08aiIVlOhB3dKDbAyP3/IRkKa+8=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-400-dvghnk3YOaKg_qA5QNroCQ-1; Tue,
 15 Jul 2025 12:37:23 -0400
X-MC-Unique: dvghnk3YOaKg_qA5QNroCQ-1
X-Mimecast-MFC-AGG-ID: dvghnk3YOaKg_qA5QNroCQ_1752597443
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 052491800253; Tue, 15 Jul 2025 16:37:23 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.44.33.160])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 29E8630001A1; Tue, 15 Jul 2025 16:37:20 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-devel@nongnu.org
Cc: Alex Williamson <alex.williamson@redhat.com>,
 John Levon <john.levon@nutanix.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Mark Cave-Ayland <mark.caveayland@nutanix.com>
Subject: [PULL 4/7] hw/vfio-user: fix use of uninitialized variable
Date: Tue, 15 Jul 2025 18:37:00 +0200
Message-ID: <20250715163703.243975-5-clg@redhat.com>
In-Reply-To: <20250715163703.243975-1-clg@redhat.com>
References: <20250715163703.243975-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

From: John Levon <john.levon@nutanix.com>

Coverity reported:

CID 1611805:         Uninitialized variables

in vfio_user_dma_map(). This can occur in the happy path when
->async_ops was not set; as this doesn't typically happen, it wasn't
caught during testing.

Align both map and unmap implementations to initialize ret the same way
to resolve this.

Resolves: Coverity CID 1611805
Fixes: 18e899e6 ("vfio-user: implement VFIO_USER_DMA_MAP/UNMAP")
Reported-by: Cédric Le Goater <clg@redhat.com>
Signed-off-by: John Levon <john.levon@nutanix.com>
Reviewed-by: Cédric Le Goater <clg@redhat.com>
Reviewed-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
Link: https://lore.kernel.org/qemu-devel/20250715115954.515819-5-john.levon@nutanix.com
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 hw/vfio-user/container.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/hw/vfio-user/container.c b/hw/vfio-user/container.c
index d318e6a3395e8d48e3a6da69ed4bef454e70ba82..d589dd90f501bbb3442c7fdc263529501086510d 100644
--- a/hw/vfio-user/container.c
+++ b/hw/vfio-user/container.c
@@ -64,8 +64,6 @@ static int vfio_user_dma_unmap(const VFIOContainerBase *bcontainer,
                               0, &local_err)) {
             error_report_err(local_err);
             ret = -EFAULT;
-        } else {
-            ret = 0;
         }
     } else {
         if (!vfio_user_send_wait(container->proxy, &msgp->hdr, NULL,
@@ -92,7 +90,7 @@ static int vfio_user_dma_map(const VFIOContainerBase *bcontainer, hwaddr iova,
                                                 bcontainer);
     int fd = memory_region_get_fd(mrp);
     Error *local_err = NULL;
-    int ret;
+    int ret = 0;
 
     VFIOUserFDs *fds = NULL;
     VFIOUserDMAMap *msgp = g_malloc0(sizeof(*msgp));
@@ -135,8 +133,6 @@ static int vfio_user_dma_map(const VFIOContainerBase *bcontainer, hwaddr iova,
                               0, &local_err)) {
             error_report_err(local_err);
             ret = -EFAULT;
-        } else {
-            ret = 0;
         }
     } else {
         VFIOUserFDs local_fds = { 1, 0, &fd };
-- 
2.50.1


