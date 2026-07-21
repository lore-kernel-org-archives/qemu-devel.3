Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2DCDDC4451C
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jul 2026 17:07:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wmDv0-0004t7-8O; Tue, 21 Jul 2026 13:06:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1wmDuo-0004qg-G5
 for qemu-devel@nongnu.org; Tue, 21 Jul 2026 13:06:00 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1wmDuk-00076i-1q
 for qemu-devel@nongnu.org; Tue, 21 Jul 2026 13:05:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1784653551;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=SUl4Ek+CVqxAEoPgmkJ0rxZazVa5azFI4RJVdQd6Lmw=;
 b=HkDOQI5abdTWN0RYXamemrqboRWnynPAHOrphNjKj06xEc44SUDe68vTKdx/azL8ZCtOEF
 sWSd/wyKVa+W0bTZiicGWme4mltHZnY5QZqWGCDc9ww/KOA3xHv22W0rhqIy/rJkS62lGJ
 y24s911xEW+CUWC7jlOp1gZ63Af+BUw=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-106-ABtxV4eZNUiMaAr1R6RU0A-1; Tue,
 21 Jul 2026 13:05:40 -0400
X-MC-Unique: ABtxV4eZNUiMaAr1R6RU0A-1
X-Mimecast-MFC-AGG-ID: ABtxV4eZNUiMaAr1R6RU0A_1784653531
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id F05E6180067C; Tue, 21 Jul 2026 17:05:30 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.44.48.82])
 by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 424F71598; Tue, 21 Jul 2026 17:05:29 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-devel@nongnu.org
Cc: "Denis V. Lunev" <den@openvz.org>, Alex Williamson <alex@shazbot.org>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Subject: [PULL 04/13] vfio/pci: reject invalid PCI_INTERRUPT_PIN values
Date: Tue, 21 Jul 2026 19:05:09 +0200
Message-ID: <20260721170518.4160785-5-clg@redhat.com>
In-Reply-To: <20260721170518.4160785-1-clg@redhat.com>
References: <20260721170518.4160785-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95
Received-SPF: permerror client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_PASS=-0.001, T_SPF_PERMERROR=0.01 autolearn=ham autolearn_force=no
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

From: "Denis V. Lunev" <den@openvz.org>

qemu-kvm aborts a few seconds after starting a VM with a
passed-through GPU whose PCI_INTERRUPT_PIN comes back as an
out-of-range value: vfio_intx_enable() only guards against pin == 0
and stores vdev->intx.pin = pin - 1 with no upper-bound check. That
value later reaches pci_irq_handler()'s
assert(0 <= irq_num && irq_num < PCI_NUM_PINS) via
pci_irq_deassert() -> pci_set_irq(), aborting the process.

Legal PCI_INTERRUPT_PIN values are 0 (no legacy interrupt) or
1-PCI_NUM_PINS (INTA-INTD); reject anything else before it reaches
vdev->intx.pin, whether the out-of-range value came from a read
failure (now caught by the previous commit) or was handed back as
data by the device itself.

Signed-off-by: Denis V. Lunev <den@openvz.org>
CC: Alex Williamson <alex@shazbot.org>
CC: Cédric Le Goater <clg@redhat.com>
Link: https://lore.kernel.org/qemu-devel/20260717122232.468955-3-den@openvz.org
Reviewed-by: Cédric Le Goater <clg@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 hw/vfio/pci.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
index b8c937d4be50091691875f2253c4d03ba83df704..380dd8c15f8d5bb98b725075978eef2e4e1e6c2d 100644
--- a/hw/vfio/pci.c
+++ b/hw/vfio/pci.c
@@ -338,6 +338,11 @@ static bool vfio_intx_enable(VFIOPCIDevice *vdev, Error **errp)
         return true;
     }
 
+    if (pin > PCI_NUM_PINS) {
+        error_setg(errp, "invalid PCI interrupt pin %d", pin);
+        return false;
+    }
+
     /*
      * Do not alter interrupt state during vfio_realize and cpr load.
      * The incoming state is cleared thereafter.
-- 
2.55.0


