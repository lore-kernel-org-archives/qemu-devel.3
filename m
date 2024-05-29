Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7795EC25B75
	for <qemu-devel@archiver.kernel.org>; Wed, 29 May 2024 20:19:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sCPkn-0004fE-QL; Wed, 29 May 2024 16:18:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <namcao@linutronix.de>)
 id 1sCPkm-0004f2-Hq
 for qemu-devel@nongnu.org; Wed, 29 May 2024 16:18:32 -0400
Received: from galois.linutronix.de ([2a0a:51c0:0:12e:550::1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <namcao@linutronix.de>)
 id 1sCPki-0003XT-ND
 for qemu-devel@nongnu.org; Wed, 29 May 2024 16:18:31 -0400
From: Nam Cao <namcao@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
 s=2020; t=1717013904;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=7IxJc24fACtJXlyugdTpfcmj+Qk7md0pb0vnSv8vz5o=;
 b=H3SJB7kOImifqkRX5O91c3GSCGrrgBx7/TaMTbH0UxY74JkmgXtLReFXc3ec8aO2Gsa/v8
 qNVutdLfYw9uVi4E4MbmaMy2NEw5snS0be/nlgoSpMwVz12BlsITRUldIvtmtkFLwFqmqn
 LNfEVear2rYGz+WcythhQ4Ex8iq41fqRXjMrGqfnWAnDNyaIK/D3mV1hXWTeTwj6vZPtom
 1W1hQRELtpmLf1j4mjKjbO/+d9m6XPH1K7HvVplOklS+FwtaxK1ky0QZQ3pnaLTCDT5I1S
 SPmxvOtOzNGrYE+S9drRKmw1F8D3tjVDbZkby1fauXmj55hlcLxE39EY89pB/Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
 s=2020e; t=1717013904;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=7IxJc24fACtJXlyugdTpfcmj+Qk7md0pb0vnSv8vz5o=;
 b=bUuPe29GkQP6OnthIj9dvzKNCaQjuZWy5zfnE6IP8nghk46C/w4b9mKpyCHQTtT7kvQXGw
 NZ191Q3S7T+05vAA==
To: Alex Williamson <alex.williamson@redhat.com>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Nam Cao <namcao@linutronix.de>
Subject: [PATCH v2] pci-bridge/xio3130_downstream: fix invalid link speed and
 link width
Date: Wed, 29 May 2024 22:17:44 +0200
Message-Id: <20240529201744.15420-1-namcao@linutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a0a:51c0:0:12e:550::1;
 envelope-from=namcao@linutronix.de; helo=galois.linutronix.de
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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
v2: implement this in .realize() instead
---
 hw/pci-bridge/xio3130_downstream.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/hw/pci-bridge/xio3130_downstream.c b/hw/pci-bridge/xio3130_dow=
nstream.c
index 38a2361fa2..2df1ee203d 100644
--- a/hw/pci-bridge/xio3130_downstream.c
+++ b/hw/pci-bridge/xio3130_downstream.c
@@ -72,6 +72,9 @@ static void xio3130_downstream_realize(PCIDevice *d, Erro=
r **errp)
     pci_bridge_initfn(d, TYPE_PCIE_BUS);
     pcie_port_init_reg(d);
=20
+    s->speed =3D QEMU_PCI_EXP_LNK_2_5GT;
+    s->width =3D QEMU_PCI_EXP_LNK_X1;
+
     rc =3D msi_init(d, XIO3130_MSI_OFFSET, XIO3130_MSI_NR_VECTOR,
                   XIO3130_MSI_SUPPORTED_FLAGS & PCI_MSI_FLAGS_64BIT,
                   XIO3130_MSI_SUPPORTED_FLAGS & PCI_MSI_FLAGS_MASKBIT,
--=20
2.39.2


