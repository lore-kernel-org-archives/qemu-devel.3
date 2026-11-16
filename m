Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FFC5606A331
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Nov 2026 20:36:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tls.msk.ru header.i=@tls.msk.ru header.a=rsa-sha256 header.s=202602 header.b=iEczOC/2
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xT3Kk-0007sl-Gv; Mon, 16 Nov 2026 15:29:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1xT3KM-0007dw-Gz; Mon, 16 Nov 2026 15:29:23 -0500
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1xT3KH-0001cB-ID; Mon, 16 Nov 2026 15:29:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1794860765; bh=uykobFzFbJheWmjvIvfm7k2S7vLkwWrwewoOHM0aTVU=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=iEczOC/2C8+4Y90a7BOxtO9U/YYztt59k3NiTOLzvMRkk/D+2TbwuD2WQGdX1KrgS
 59mFEZiaMK3AJMHUg7lilAOdzJWXyMNwQaUVYdvH0oKSczgEVjUI1afa+b2fgs0M0P
 KdRn1e5NPcYuN3dGMslI1r1/BZLpSNq3VB5vlwaPtZwsC4njRQqwZMhfEuYLyB99av
 CuPjDZHmTvuwmQ6QuoW52xgz5cUr28T0QzhV/s9PRQ2PCB4n3rslQR0PFt9Bxnv+XW
 pkX3osEfDEeSjzRgpysL63qILg3bGoXcMeQB4Sdi4jk7tM0lOTU14Rw4ipH57nr92p
 NTsEmgpk5v2dg==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 47CCF1E71B8;
 Mon, 16 Nov 2026 23:26:05 +0300 (MSK)
Received: from gandalf.tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id 456F245FBE4;
 Mon, 16 Nov 2026 23:26:05 +0300 (MSK)
Received: by gandalf.tls.msk.ru (Postfix, from userid 1000)
 id 2E1E7B8E8C; Mon, 16 Nov 2026 23:26:05 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Daniel Paziyski <danielpaziyski@gmail.com>,
 Michael S. Tsirkin <mst@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-11.1.4 35/63] pci: fix null pointer dereference on pci device
 registration failure
Date: Mon, 16 Nov 2026 23:25:14 +0300
Message-ID: <20261116202554.535325-35-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-11.1.4-20261116212645@cover.tls.msk.ru>
References: <qemu-stable-11.1.4-20261116212645@cover.tls.msk.ru>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=212.248.84.144; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Daniel Paziyski <danielpaziyski@gmail.com>

When a PCI device fails to be registered using do_pci_register_device, which
takes the PCI device as one of its arguments, and returns the PCI device itself
on success or null on failure, the acpi index is forcefully released using
pci_unregister_acpi_index.

However, this causes a null pointer to be passed always on failure to
pci_unregister_acpi_index. Instead, do not reassign pci_dev from the return
value of do_pci_register_device, just check it.

Cc: qemu-stable@nongnu.org
Resolves: Coverity CID 1689947
Fixes: 432ea8cc7d27 ("pcie_sriov: register user created virtual function before realizing it")
Signed-off-by: Daniel Paziyski <danielpaziyski@gmail.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Message-ID: <20261101162132.147838-2-danielpaziyski@gmail.com>
(cherry picked from commit 7ecad9ed2e1c7fc7076cb23186c0e3b3317b6c4e)
(Fixes: 11ecc538c5b2 in 11.1.x)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/hw/pci/pci.c b/hw/pci/pci.c
index d4187293b1f..51713451cb3 100644
--- a/hw/pci/pci.c
+++ b/hw/pci/pci.c
@@ -2310,10 +2310,8 @@ static void pci_qdev_realize(DeviceState *qdev, Error **errp)
         pci_dev->cap_present |= QEMU_PCIE_CAP_CXL;
     }
 
-    pci_dev = do_pci_register_device(pci_dev,
-                                     object_get_typename(OBJECT(qdev)),
-                                     pci_dev->devfn, errp);
-    if (pci_dev == NULL) {
+    if (!do_pci_register_device(pci_dev, object_get_typename(OBJECT(qdev)),
+                                pci_dev->devfn, errp)) {
         pci_unregister_acpi_index(pci_dev);
         return;
     }
-- 
2.47.3


