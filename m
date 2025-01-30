Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24A41C0218A
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jan 2025 13:45:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tdUpv-0000j7-0Q; Thu, 30 Jan 2025 08:44:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1tdUps-0000iB-Ql
 for qemu-devel@nongnu.org; Thu, 30 Jan 2025 08:44:01 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1tdUpr-0003Or-CZ
 for qemu-devel@nongnu.org; Thu, 30 Jan 2025 08:44:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1738244638;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=08fbyKhZ36Cf9CIMyEWusAbI9TdQnp+cgrMz0jjM9ZM=;
 b=Xa02KnfBQIaz2C4kJhyl6x6bUjLCQ3wHWdhx/iVVUSFxUWHyTt6PV8di7brSlsIIGwmwIZ
 j+aCv1VTbDj8QsWaaT0m8UWSEDjozL6wcvBVR1USXLkxPnccZnlX56mCqBHZTnjIKxlloW
 JIyeUtZe4kzfqJPC7afBPuEYjfxBv/0=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-445-qrhIDAVkM62v1XSG83Q1JQ-1; Thu,
 30 Jan 2025 08:43:57 -0500
X-MC-Unique: qrhIDAVkM62v1XSG83Q1JQ-1
X-Mimecast-MFC-AGG-ID: qrhIDAVkM62v1XSG83Q1JQ
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 6F4F8180034D
 for <qemu-devel@nongnu.org>; Thu, 30 Jan 2025 13:43:56 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.39.192.105])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 46F981800965; Thu, 30 Jan 2025 13:43:55 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-devel@nongnu.org
Cc: Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PATCH v2 3/9] vfio: Rephrase comment in vfio_listener_region_add()
 error path
Date: Thu, 30 Jan 2025 14:43:40 +0100
Message-ID: <20250130134346.1754143-4-clg@redhat.com>
In-Reply-To: <20250130134346.1754143-1-clg@redhat.com>
References: <20250130134346.1754143-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -33
X-Spam_score: -3.4
X-Spam_bar: ---
X-Spam_report: (-3.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.3,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Rephrase a bit the ending comment about how errors are handled
depending on the phase in which vfio_listener_region_add() is called.

Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 hw/vfio/common.c | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/hw/vfio/common.c b/hw/vfio/common.c
index f7499a9b7447a7593198e1523c50858b70a8bd85..62af1216fc5a9089fc718c2afe3a405d9381db32 100644
--- a/hw/vfio/common.c
+++ b/hw/vfio/common.c
@@ -683,12 +683,13 @@ fail:
         error_reportf_err(err, "PCI p2p may not work: ");
         return;
     }
-    /*
-     * On the initfn path, store the first error in the container so we
-     * can gracefully fail.  Runtime, there's not much we can do other
-     * than throw a hardware error.
-     */
+
     if (!bcontainer->initialized) {
+        /*
+         * At machine init time or when the device is attached to the
+         * VM, store the first error in the container so we can
+         * gracefully fail the device realize routine.
+         */
         if (!bcontainer->error) {
             error_propagate_prepend(&bcontainer->error, err,
                                     "Region %s: ",
@@ -697,6 +698,10 @@ fail:
             error_free(err);
         }
     } else {
+        /*
+         * At runtime, there's not much we can do other than throw a
+         * hardware error.
+         */
         error_report_err(err);
         hw_error("vfio: DMA mapping failed, unable to continue");
     }
-- 
2.48.1


