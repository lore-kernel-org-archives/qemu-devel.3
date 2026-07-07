Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93ABBC43458
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jul 2026 06:30:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wgzKA-0003Mt-MK; Tue, 07 Jul 2026 02:30:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1wgzK8-00036s-1l
 for qemu-devel@nongnu.org; Tue, 07 Jul 2026 02:30:28 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1wgzK5-0007F9-Q9
 for qemu-devel@nongnu.org; Tue, 07 Jul 2026 02:30:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1783405825;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=WECeFWui8FSkmR3NrFprq2XlEhAaMQcWIxEQ9Qc9tK8=;
 b=EvJE5dNqD2k31tealdAKYCtwcyUCrmSoaQ9hjlugDj37XxSU62/F792IgVMlTNgAEDRhnL
 jH1+C/K9NrQE6X+92SC97o+/o4clHyJOXFJpcfH2eUe+Zofisqt5hE/t3rciORIAT80oz9
 Tx5oA4T/GReyoi8XjXFn76e3X2mPy3I=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-553-W7rR6mYYN-ClMXx7e2z8Ag-1; Tue,
 07 Jul 2026 02:30:21 -0400
X-MC-Unique: W7rR6mYYN-ClMXx7e2z8Ag-1
X-Mimecast-MFC-AGG-ID: W7rR6mYYN-ClMXx7e2z8Ag_1783405820
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 828031954B1E; Tue,  7 Jul 2026 06:30:20 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.44.32.49])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id B3D20180065F; Tue,  7 Jul 2026 06:30:18 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Feifan Qian <bea1e@proton.me>, Alex Williamson <alex@shazbot.org>
Subject: [PULL 27/27] vfio/pci: Reject invalid MSI-X Table and PBA BIR values
Date: Tue,  7 Jul 2026 08:29:20 +0200
Message-ID: <20260707062920.317302-28-clg@redhat.com>
In-Reply-To: <20260707062920.317302-1-clg@redhat.com>
References: <20260707062920.317302-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 8
X-Spam_score: 0.8
X-Spam_bar: /
X-Spam_report: (0.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

The 3-bit MSI-X BIR fields permit values 0-7, but VFIOPCIDevice::bars[]
only contains BAR0-BAR5 (6 entries). An invalid BIR value of 6 or 7
can cause an out-of-bounds array access (CWE-129) in vfio_msix_early_setup().

Add range checks immediately after extracting the BIR values.

Reported-by: Feifan Qian <bea1e@proton.me>
Fixes: 65501a745dba ("vfio: vfio-pci device assignment driver")
Resolves: https://gitlab.com/qemu-project/qemu/-/issues/3878
Reviewed-by: Alex Williamson <alex@shazbot.org>
Link: https://lore.kernel.org/qemu-devel/20260706161334.2165482-1-clg@redhat.com
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 hw/vfio/pci.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
index e6d1adfd3655ce3c1baf8977c82223d23af9b770..c204706e63045c930bda7977adc8034f907b6890 100644
--- a/hw/vfio/pci.c
+++ b/hw/vfio/pci.c
@@ -1791,6 +1791,14 @@ static bool vfio_msix_early_setup(VFIOPCIDevice *vdev, Error **errp)
     msix->pba_offset = pba & ~PCI_MSIX_FLAGS_BIRMASK;
     msix->entries = (ctrl & PCI_MSIX_FLAGS_QSIZE) + 1;
 
+    if (msix->table_bar >= ARRAY_SIZE(vdev->bars) ||
+        msix->pba_bar >= ARRAY_SIZE(vdev->bars)) {
+        error_setg(errp, "invalid MSI-X BIR, table_bar=%d pba_bar=%d",
+                   msix->table_bar, msix->pba_bar);
+        g_free(msix);
+        return false;
+    }
+
     ret = vfio_device_get_irq_info(&vdev->vbasedev, VFIO_PCI_MSIX_IRQ_INDEX,
                                    &irq_info);
     if (ret < 0) {
-- 
2.54.0


