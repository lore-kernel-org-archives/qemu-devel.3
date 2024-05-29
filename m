Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8CA73C3DA40
	for <qemu-devel@archiver.kernel.org>; Wed, 29 May 2024 13:34:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sCJRZ-0003dy-Sj; Wed, 29 May 2024 09:34:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <namcao@linutronix.de>)
 id 1sCJFZ-0004mf-B9
 for qemu-devel@nongnu.org; Wed, 29 May 2024 09:21:53 -0400
Received: from galois.linutronix.de ([193.142.43.55])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <namcao@linutronix.de>)
 id 1sCJFX-00058S-8v
 for qemu-devel@nongnu.org; Wed, 29 May 2024 09:21:52 -0400
From: Nam Cao <namcao@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
 s=2020; t=1716988900;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=N1YiYJh4DycAIpYKRbdaGLipVBYIk22sylcUCCHc7SY=;
 b=1EA0acUHxAPQSvjT+kLPR2Emv1atv3ozL0ypdFNYTpdC0BlGj92ykE42qfKKvGyKBWNwCq
 LksijuPjW7mbAuqVNXrXkfkxlGlc+R5nF6NgkM+S7bgkyeZPW1PXezP/45PeohRf/XOeuz
 zAIRsKe83n5MiPVCh/aEXJuc45iAeCuyM6k1hMRWvWrIcQe5F0k1eBneBEZMWI04THTpz6
 gVDewRszV0aljF/X2C4B7tDj8Lbdmw1UIh0K7iRfmZoOhXSSnxeWEPORO06sq7De0afrXl
 bclhm4sLjrN2ZR50GD4F8bV3uDEAP8d4+rn4gLfFaNNRs6E/8Gt7q+qpoOlvwA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
 s=2020e; t=1716988900;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=N1YiYJh4DycAIpYKRbdaGLipVBYIk22sylcUCCHc7SY=;
 b=NNW8ThIyClrZFuHLtnyNOW/BivpVOmFxq0unajADPFxy1rhMHPyKdQyf3hM/5RuZJNvZcw
 6iI007AYJp2VUHCw==
To: Alex Williamson <alex.williamson@redhat.com>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, qemu-devel@nongnu.org
Cc: Nam Cao <namcao@linutronix.de>
Subject: [PATCH] pci-bridge/xio3130_downstream: fix invalid link speed and
 link width
Date: Wed, 29 May 2024 15:21:25 +0200
Message-Id: <20240529132125.106790-1-namcao@linutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=193.142.43.55; envelope-from=namcao@linutronix.de;
 helo=galois.linutronix.de
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Wed, 29 May 2024 09:34:10 -0400
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

Set link width to x1 and link speed to 2.5 Gb/s as specified by the
datasheet. Without this, these fields in the link status register read
zero, which is incorrect.

This problem appeared since 3d67447fe7c2 ("pcie: Fill PCIESlot link fields
to support higher speeds and widths"), which allows PCIe slot to set link
width and link speed. However, if PCIe slot does not explicitly set these
properties, they will be zero. Before this commit, the width and speed
default to x1 and 2.5 Gb/s.

Fixes: 3d67447fe7c2 ("pcie: Fill PCIESlot link fields to support higher spe=
eds and widths")
Signed-off-by: Nam Cao <namcao@linutronix.de>
---
 hw/pci-bridge/xio3130_downstream.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/hw/pci-bridge/xio3130_downstream.c b/hw/pci-bridge/xio3130_dow=
nstream.c
index 38a2361fa2..d949431191 100644
--- a/hw/pci-bridge/xio3130_downstream.c
+++ b/hw/pci-bridge/xio3130_downstream.c
@@ -172,10 +172,18 @@ static void xio3130_downstream_class_init(ObjectClass=
 *klass, void *data)
     device_class_set_props(dc, xio3130_downstream_props);
 }
=20
+static void xio3130_downstream_instance_post_init(Object *obj)
+{
+    PCIESlot *s =3D PCIE_SLOT(obj);
+    s->speed =3D QEMU_PCI_EXP_LNK_2_5GT;
+    s->width =3D QEMU_PCI_EXP_LNK_X1;
+}
+
 static const TypeInfo xio3130_downstream_info =3D {
     .name          =3D TYPE_XIO3130_DOWNSTREAM,
     .parent        =3D TYPE_PCIE_SLOT,
     .class_init    =3D xio3130_downstream_class_init,
+    .instance_post_init =3D xio3130_downstream_instance_post_init,
     .interfaces =3D (InterfaceInfo[]) {
         { INTERFACE_PCIE_DEVICE },
         { }
--=20
2.39.2


