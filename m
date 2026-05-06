Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65B2ACD342C
	for <qemu-devel@archiver.kernel.org>; Wed,  6 May 2026 15:24:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wKe6l-0000uI-Kj; Wed, 06 May 2026 11:24:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1wKe6j-0000u5-Vi
 for qemu-devel@nongnu.org; Wed, 06 May 2026 11:24:18 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1wKe6i-0007B0-15
 for qemu-devel@nongnu.org; Wed, 06 May 2026 11:24:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1778081054;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=FBydjj9GPYbsUCjP79dQyaU/Ihw4FmFx/AlJNgbV18A=;
 b=K/UcgkrZLW5cy33xHB5X8XlnbSO07kQsoHkjjaWwFwe6NHBWhT3CTM2XfrfajU7Mi04+35
 T8YLN1Uc2XeV965KAHPZXqUQimu1YE/q7E6OR6/qyd/5Dzr6cNk6j4NCFcuSXOQzmJcc/n
 OpITrjHBIp9UKSkJEKEK2LvTKefemLM=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-90-R0t3ZNCKMCC7-NJB3qBApw-1; Wed,
 06 May 2026 11:24:10 -0400
X-MC-Unique: R0t3ZNCKMCC7-NJB3qBApw-1
X-Mimecast-MFC-AGG-ID: R0t3ZNCKMCC7-NJB3qBApw_1778081050
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id B92E918002F1; Wed,  6 May 2026 15:24:09 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.44.49.156])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 35D4519560A3; Wed,  6 May 2026 15:24:07 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-devel@nongnu.org
Cc: Alex Williamson <alex@shazbot.org>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PATCH] vfio/pci: Replace abort() with g_assert_not_reached()
Date: Wed,  6 May 2026 17:23:53 +0200
Message-ID: <20260506152353.1657838-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.443,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

This check was originally introduced in commit b3ebc10c373e
("vfio-pci: Add debug config options to disable MSI/X KVM support") as
part of a debug block to retrieve the MSI/MSIX message, and was later
moved by commit 0de70dc7bab1 ("vfio/pci: Rename MSI/X functions for
easier tracing") into the main interrupt handling path, becoming
production code.

Under normal conditions, this code path cannot be reached because the
BQL serializes all handler registration, vdev->interrupt updates, and
handler removal. Replace abort() with g_assert_not_reached(), which is
preferred nowdays, and add a comment clarifying the purpose.

Cc: Alex Williamson <alex@shazbot.org>
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 hw/vfio/pci.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
index 09acd3f6082b0a9c5223780bf7e9847b57424cf7..7ca2ff4e7c1cb570cd60d35454b33b5506dae36e 100644
--- a/hw/vfio/pci.c
+++ b/hw/vfio/pci.c
@@ -453,7 +453,12 @@ static void vfio_msi_interrupt(void *opaque)
         get_msg = msi_get_message;
         notify = msi_notify;
     } else {
-        abort();
+        /*
+         * Interrupt state transitions (MSI/MSI-X -> NONE/INTx) are
+         * protected by the BQL, and eventfd handlers are strictly
+         * unregistered before vdev->interrupt is modified.
+         */
+        g_assert_not_reached();
     }
 
     msg = get_msg(pdev, nr);
-- 
2.54.0


