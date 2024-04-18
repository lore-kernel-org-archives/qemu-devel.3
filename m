Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B566C4345F
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Apr 2024 20:58:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rxYpF-0002ht-23; Thu, 18 Apr 2024 16:57:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1rxYpC-0002hV-JT
 for qemu-devel@nongnu.org; Thu, 18 Apr 2024 16:57:42 -0400
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1rxYpA-0006UV-V8
 for qemu-devel@nongnu.org; Thu, 18 Apr 2024 16:57:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ilande.co.uk; s=20220518; h=Subject:Content-Transfer-Encoding:MIME-Version:
 Message-Id:Date:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=eOjuinlV/LiYCPnvSB5nx3iRMuwdhTKb8X/RlR6dsdM=; b=NTfVvNdJRyQTXhl9rcBmSNYt8T
 7LGSt6oOxGpQABZ1xkmsdLV+nQ3oGTsqB6kYHcqRFE5kmEND8/4QbtB557RNbKBCRlZvaVfAyUvdf
 kRDyLv7uleYRKRF3mt7jkq/UNx+rRS5j4nGP9F38JjJPGFpNZFDPBM6Vi5JucrjWFRiMChG1IzVHh
 P6uuVG7hySdepJq6Zo50QdOp/Yr2Vegr6huNtcraUyKjDsrGaTiqxpU13Bz3xKKWuBzk3qUwTGiVR
 9xvyVurvM+I9YmYL2BwZQQ2Gb6BLpjcq+L9kDtzqRPrTrYrmz0bRZylFG4OnD1NGVsaM9up244aOV
 tADiQxAzqcFq4TfTHFvVzHrM3YfGvwqddsUqzFO5hMHdWPrTExYw/ijSLk5QBeyCgCb/2Ex0dpSoR
 UZ9lHiI7OG/it3ZU5cly0ZzkQMCtdM2UFXQ8wv4eszEVACZmQcEU9HwP+5d1241hxNrseRsDa5PSN
 QoWNHCAFrANV9bEklD6YsxaxlzOVff76fj7rpxSnxLajxYNMZ6bzp9ZzVR+g6gKjfZDGaVTtYXw4r
 m1xBn5WPiH2A6fkCCDszZ0amb5q1xmOcdikwYv6uLWEWepUIUxFQHlBB+HLFvh77Fy5keyzkDLnPS
 2xiKRZ69YhlykJBlmlwUS0x1iwWu5BEAVc+aLeWko=;
Received: from [2a00:23c4:8bb4:4000:aae1:b0e7:6998:7ece]
 (helo=localhost.localdomain)
 by mail.ilande.co.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.92) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1rxYo7-0006TV-4x; Thu, 18 Apr 2024 21:56:39 +0100
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
To: qemu-devel@nongnu.org,
	thorpej@me.com
Date: Thu, 18 Apr 2024 21:57:30 +0100
Message-Id: <20240418205730.31396-1-mark.cave-ayland@ilande.co.uk>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a00:23c4:8bb4:4000:aae1:b0e7:6998:7ece
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: [PATCH] hw/sparc64: set iommu_platform=on for virtio devices attached
 to the sun4u machine
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on mail.ilande.co.uk)
Received-SPF: pass client-ip=2001:41c9:1:41f::167;
 envelope-from=mark.cave-ayland@ilande.co.uk; helo=mail.ilande.co.uk
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

The sun4u machine has an IOMMU and therefore it is possible to program it such
that the virtio-device IOVA does not map directly to the CPU physical address.

This is not a problem with Linux which always maps the IOVA directly to the CPU
physical address, however it is required for the NetBSD virtio driver where this
is not the case.

Set the sun4u machine defaults for all virtio devices so that disable-legacy=on
and iommu_platform=on to ensure a default configuration will allow virtio
devices to function correctly on both Linux and NetBSD.

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
---
 hw/sparc64/sun4u.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/hw/sparc64/sun4u.c b/hw/sparc64/sun4u.c
index cff6d5abaf..4ece1ac1ff 100644
--- a/hw/sparc64/sun4u.c
+++ b/hw/sparc64/sun4u.c
@@ -793,6 +793,12 @@ static void sun4v_init(MachineState *machine)
     sun4uv_init(get_system_memory(), machine, &hwdefs[1]);
 }
 
+static GlobalProperty hw_compat_sparc64[] = {
+    { "virtio-pci", "disable-legacy", "on", .optional = true },
+    { "virtio-device", "iommu_platform", "on" },
+};
+static const size_t hw_compat_sparc64_len = G_N_ELEMENTS(hw_compat_sparc64);
+
 static void sun4u_class_init(ObjectClass *oc, void *data)
 {
     MachineClass *mc = MACHINE_CLASS(oc);
@@ -810,6 +816,7 @@ static void sun4u_class_init(ObjectClass *oc, void *data)
     mc->default_nic = "sunhme";
     mc->no_parallel = !module_object_class_by_name(TYPE_ISA_PARALLEL);
     fwc->get_dev_path = sun4u_fw_dev_path;
+    compat_props_add(mc->compat_props, hw_compat_sparc64, hw_compat_sparc64_len);
 }
 
 static const TypeInfo sun4u_type = {
-- 
2.39.2


