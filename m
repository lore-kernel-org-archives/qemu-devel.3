Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E704FCA16A
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Mar 2026 18:15:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vzf8G-0007RR-Ko; Mon, 09 Mar 2026 14:15:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1vzf8D-0007QN-BR
 for qemu-devel@nongnu.org; Mon, 09 Mar 2026 14:15:05 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1vzf8A-0008Dz-Dd
 for qemu-devel@nongnu.org; Mon, 09 Mar 2026 14:15:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1773080101;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=+9mgYnbUSzE3hHMpeCFGm4KApWZdtZgL8pwOnpPUrG4=;
 b=LsRqEVfVTX0HwNtIWSRMD20GrFc4dBlz5PQKJoe3ejFDkL0mvoctQzX6SwrM5xC+6y4008
 Xsh0G0R5An5qXNEsuuJd+/f6xSIjw0P/yLJmW7iQCknG3PsHMAIVWB9aGS3BrvYUrkfh1V
 +2suX/yoTEUW0fs1egOBNyDlsXlFQls=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-107-EmmJh1tYMY-oz6nzxSbVGQ-1; Mon,
 09 Mar 2026 14:14:57 -0400
X-MC-Unique: EmmJh1tYMY-oz6nzxSbVGQ-1
X-Mimecast-MFC-AGG-ID: EmmJh1tYMY-oz6nzxSbVGQ_1773080096
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 437521956094; Mon,  9 Mar 2026 18:14:56 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.44.34.113])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 77F0719560A6; Mon,  9 Mar 2026 18:14:54 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
	qemu-devel@nongnu.org
Cc: Artyom Tarasenko <atar4qemu@gmail.com>
Subject: [PATCH v2] hw/sparc64/sun4u: Mark unusable PCI busses as full to ease
 device plugging
Date: Mon,  9 Mar 2026 19:14:52 +0100
Message-ID: <20260309181452.83702-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -3
X-Spam_score: -0.4
X-Spam_bar: /
X-Spam_report: (-0.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

From: Thomas Huth <thuth@redhat.com>

When trying to plug a PCI device to a Sparc64 machine, you currently
have to specify the right bus ("bus=pciB"), otherwise you get this error:

 $ qemu-system-sparc64 -device virtio-scsi-pci
 qemu-system-sparc64: -device virtio-scsi-pci: PCI: no slot/function
 available for virtio-scsi-pci, all in use or reserved

This is quite annoying for the unexperienced users, and it also breaks
e.g. the iotests ("make check-block") when running with qemu-system-sparc64.

Mark the non-usable PCI busses as full now, so that QEMU can automatically
plug new PCI devices to the right "pciB" bus.

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 v2: Do the change in the machine code, not in the sabre device

 hw/sparc64/sun4u.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/hw/sparc64/sun4u.c b/hw/sparc64/sun4u.c
index b8bda1eb816..37539535c6c 100644
--- a/hw/sparc64/sun4u.c
+++ b/hw/sparc64/sun4u.c
@@ -723,6 +723,13 @@ static void sun4uv_init(MemoryRegion *address_space_mem,
     fw_cfg_add_i16(fw_cfg, FW_CFG_SPARC64_DEPTH, graphic_depth);
 
     qemu_register_boot_set(fw_cfg_boot_set, fw_cfg);
+
+    /*
+     * Mark internal PCI busses as full so that the plugging of additional
+     * PCI devices happens on the right bus that still has free slots:
+     */
+    qbus_mark_full(&pci_bus->qbus);
+    qbus_mark_full(&pci_busA->qbus);
 }
 
 enum {
-- 
2.53.0


