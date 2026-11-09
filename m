Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D1B8606A339
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Nov 2026 12:14:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=WU8zUL8m
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xQOGK-0005Xh-DD; Mon, 09 Nov 2026 07:14:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1xQOGI-0005XY-1N
 for qemu-devel@nongnu.org; Mon, 09 Nov 2026 07:14:10 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1xQOGG-0004WR-H1
 for qemu-devel@nongnu.org; Mon, 09 Nov 2026 07:14:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1794226447;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=rC/EOpTqexdmxDsQj9wiRn7TF9WwxFeBmH5DHHcG48Q=;
 b=WU8zUL8m6r2+lwE27uQZInG1DeJr7ip9EVHO6Lu1ohsNtq0XDhoM5nx7SKxdWAvhsANpXz
 SNgs8OrDctscO2PgDuxVUIcNnJEkZ7DBWp6G5V9r+bPGjet0c+x7Gng0pc0bC737qMClv5
 WuJFJ+neNGcd4PpnrAkzgYQkdGu/XKo=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-144-_Kll6WbFOwusya7-EgEijA-1; Mon,
 09 Nov 2026 07:14:06 -0500
X-MC-Unique: _Kll6WbFOwusya7-EgEijA-1
X-Mimecast-MFC-AGG-ID: _Kll6WbFOwusya7-EgEijA_1794226445
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id E96A4180047B; Mon,  9 Nov 2026 12:14:04 +0000 (UTC)
Received: from circe.redhat.com (unknown [10.44.32.4])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 5029B1956087; Mon,  9 Nov 2026 12:14:02 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-devel@nongnu.org
Cc: Alex Williamson <alex@shazbot.org>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PATCH] vfio/pci: Fix crash when BAR has zero size
Date: Mon,  9 Nov 2026 13:14:01 +0100
Message-ID: <20261109121401.973836-1-clg@redhat.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

When the host kernel fails to assign a BAR (broken BIOS "Above 4G
Decoding" or ReBAR configuration), the VFIO kernel interface reports
a zero size. In that case, vfio_region_setup() skips allocating
region->mem, leaving it NULL.

Then, vfio_bar_quirk_setup() calls the BAR quirk probes and passes
a NULL region->mem pointer to memory_region_add_subregion_overlap(),
causing a segfault in memory_region_update_container_subregions().

Skip quirk setup in vfio_realize() for zero size regions.

Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2732
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 hw/vfio/pci.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
index aa03927bb783..765326b755f4 100644
--- a/hw/vfio/pci.c
+++ b/hw/vfio/pci.c
@@ -1852,7 +1852,9 @@ static void vfio_pci_realize(PCIDevice *pdev, Error **errp)
     }
 
     for (i = 0; i < PCI_ROM_SLOT; i++) {
-        vfio_bar_quirk_setup(vdev, i);
+        if (vdev->bars[i].size) {
+            vfio_bar_quirk_setup(vdev, i);
+        }
     }
 
     if (!vfio_pci_irq_setup(vdev, errp)) {
-- 
2.56.0


