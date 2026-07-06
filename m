Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84FAEC43458
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jul 2026 14:32:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wgkMY-0003A1-Bf; Mon, 06 Jul 2026 10:31:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1wgkMD-00035k-Nu
 for qemu-devel@nongnu.org; Mon, 06 Jul 2026 10:31:44 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1wgkMB-0001gL-6a
 for qemu-devel@nongnu.org; Mon, 06 Jul 2026 10:31:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1783348293;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=jiDYWh7JO1eJtEteXy4ZLg2tv+Cm6iedtFcGZy0HTI8=;
 b=XkWao8xdw5abHVU7F+LGuYo1KuwLafl7KJBMV9wZD/WL3kbQOW04bYOpiCZwYC7su7cRCZ
 KZCOhOo6/DXk/ecgSpwiUOmYx8B/J8o7Dk6SL2EnN4Vy8J1JixH9CP0L4bAVTcPmjDcJuz
 ksccABawyjbe8Yxlu9xX4pmaxIfd3y8=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-104-BJbYRE5vNZO5-xjqqh8OkA-1; Mon,
 06 Jul 2026 10:31:30 -0400
X-MC-Unique: BJbYRE5vNZO5-xjqqh8OkA-1
X-Mimecast-MFC-AGG-ID: BJbYRE5vNZO5-xjqqh8OkA_1783348289
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id F25911800844; Mon,  6 Jul 2026 14:31:28 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.44.32.54])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 31AB218005A2; Mon,  6 Jul 2026 14:31:26 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-devel@nongnu.org
Cc: Alex Williamson <alex@shazbot.org>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Feifan Qian <bea1e@proton.me>
Subject: [PATCH] vfio/pci: Reject invalid MSI-X Table and PBA BIR values
Date: Mon,  6 Jul 2026 16:31:24 +0200
Message-ID: <20260706143124.2076256-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

The 3-bit MSI-X BIR fields permit values 0-7, but VFIOPCIDevice::bars[]
only contains BAR0-BAR5 (6 entries). An invalid BIR value of 6 or 7
can cause an out-of-bounds array access (CWE-129) in vfio_msix_early_setup().

Add range checks immediately after extracting the BIR values.

Reported-by: Feifan Qian <bea1e@proton.me>
Fixes: 65501a745dba ("vfio: vfio-pci device assignment driver")
Resolves: https://gitlab.com/qemu-project/qemu/-/issues/3878
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 hw/vfio/pci.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
index 67d9d9e846446577e8de7a8c588165c6f38c3bee..324e3f5d98206ccb64963ee232f69d3ada422ef5 100644
--- a/hw/vfio/pci.c
+++ b/hw/vfio/pci.c
@@ -1762,6 +1762,14 @@ static bool vfio_msix_early_setup(VFIOPCIDevice *vdev, Error **errp)
     msix->pba_offset = pba & ~PCI_MSIX_FLAGS_BIRMASK;
     msix->entries = (ctrl & PCI_MSIX_FLAGS_QSIZE) + 1;
 
+    if (msix->table_bar >= PCI_NUM_REGIONS - 1 ||
+        msix->pba_bar >= PCI_NUM_REGIONS - 1) {
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


