Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32AF6C531FA
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jul 2026 09:24:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wnC8s-0007Xs-L5; Fri, 24 Jul 2026 05:24:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1wnC8o-0007S3-Sx
 for qemu-devel@nongnu.org; Fri, 24 Jul 2026 05:24:27 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1wnC8l-0001IS-VB
 for qemu-devel@nongnu.org; Fri, 24 Jul 2026 05:24:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1784885061;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=Qhsnhgo1BviKaIM56hsegpeQFVGCELZXvoY0iGeM2Ag=;
 b=a/hvk5KMIGbtFYlSaPcy1wnuP6VG20+CsYaVT8O/UwUkzuILtEeDRSvPKmh2oCU8sWeQ6c
 guvGbMn/umlTx/JduyLWz7Fn/F1dGt0XyXoPwLYFmq26B0J57IDiRy7plIN32G2aDaAKLB
 mIAAdNrtrTn0QnnR0xZ1oXbdnHc2Vzc=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-621-CEDN4ZgwNqC_vmgHF1wCow-1; Fri,
 24 Jul 2026 05:24:18 -0400
X-MC-Unique: CEDN4ZgwNqC_vmgHF1wCow-1
X-Mimecast-MFC-AGG-ID: CEDN4ZgwNqC_vmgHF1wCow_1784885057
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 381021809A27; Fri, 24 Jul 2026 09:24:17 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.44.48.11])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 6E51E1954226; Fri, 24 Jul 2026 09:24:15 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-devel@nongnu.org
Cc: Alex Williamson <alex@shazbot.org>, mcasquer@redhat.com,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PATCH] vfio/pci: Fix ROM load failure handling in vfio_rom_read()
Date: Fri, 24 Jul 2026 11:24:13 +0200
Message-ID: <20260724092413.348354-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.951,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

When vfio_pci_load_rom() fails, vdev->rom is NULL but the memcpy
still computes a source pointer from it, which is undefined behavior.
Guard the access and return a 0xff pattern instead, which is what
hardware returns for an absent ROM.

Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 hw/vfio/pci.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
index a3147d28665abd29fd804bd08bdffc3c7440033c..16d4f70ea58c9e5b174dd57950df55dc2ab91f6f 100644
--- a/hw/vfio/pci.c
+++ b/hw/vfio/pci.c
@@ -1176,8 +1176,13 @@ static uint64_t vfio_rom_read(void *opaque, hwaddr addr, unsigned size)
         }
     }
 
-    memcpy(&val, vdev->rom + addr,
-           (addr < vdev->rom_size) ? MIN(size, vdev->rom_size - addr) : 0);
+    /* If ROM loading failed, return 0xff pattern */
+    if (vdev->rom_read_failed) {
+        memset(&val, 0xff, sizeof(val));
+    } else {
+        memcpy(&val, vdev->rom + addr,
+               (addr < vdev->rom_size) ? MIN(size, vdev->rom_size - addr) : 0);
+    }
 
     switch (size) {
     case 1:
-- 
2.55.0


