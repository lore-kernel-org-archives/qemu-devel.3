Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1F96C0219B
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Feb 2025 14:35:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1thrL4-0006Wt-9e; Tue, 11 Feb 2025 09:34:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1thrL2-0006WU-E6
 for qemu-devel@nongnu.org; Tue, 11 Feb 2025 09:34:12 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1thrKx-0001ut-Lv
 for qemu-devel@nongnu.org; Tue, 11 Feb 2025 09:34:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1739284446;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=bPZVrbsgZOWeCoD7MxZMqgbjo9iKE+41P6bgZWofvF0=;
 b=Y3zkLdc3lDXAtZzYFySxiXMeSQAMb5hSS0s8Z/GBKSupLA9/nEhRvhkHjyakSaflVjgAxe
 GvGxGxxm8o3XTrgLXQgvdn4kOchEVL2JysLFsNkUZfoDsnIDndOfoTT47eb3IUkoYAfra8
 7E0Zynr62Q7dMPRe3QYbPtNRGeNaJqM=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-505-pE9c6MqJOMysVbgXbMPzRg-1; Tue,
 11 Feb 2025 09:34:05 -0500
X-MC-Unique: pE9c6MqJOMysVbgXbMPzRg-1
X-Mimecast-MFC-AGG-ID: pE9c6MqJOMysVbgXbMPzRg
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 832E21956086
 for <qemu-devel@nongnu.org>; Tue, 11 Feb 2025 14:34:04 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.45.224.39])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 97E391800873; Tue, 11 Feb 2025 14:34:02 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-devel@nongnu.org
Cc: Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 08/12] vfio: Rephrase comment in vfio_listener_region_add()
 error path
Date: Tue, 11 Feb 2025 15:33:36 +0100
Message-ID: <20250211143340.787996-9-clg@redhat.com>
In-Reply-To: <20250211143340.787996-1-clg@redhat.com>
References: <20250211143340.787996-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.54,
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

Reviewed-by: Alex Williamson <alex.williamson@redhat.com>
Link: https://lore.kernel.org/qemu-devel/20250206131438.1505542-4-clg@redhat.com
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


