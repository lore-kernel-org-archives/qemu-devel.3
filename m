Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91356606A323
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Nov 2026 20:31:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tls.msk.ru header.i=@tls.msk.ru header.a=rsa-sha256 header.s=202602 header.b=wnIoVkH9
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xT3Kf-0007pA-UC; Mon, 16 Nov 2026 15:29:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1xT3KM-0007dv-92; Mon, 16 Nov 2026 15:29:23 -0500
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1xT3KI-0001eK-F1; Mon, 16 Nov 2026 15:29:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1794860765; bh=k6HtUgNF9SkA13nLKpSYgbzcdJj/60Dn3pLCFFTGQqA=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=wnIoVkH9164mzB2rr7MeUKMEt6SaetsQePVLC4u5l9ErjyiRDXjEP7cQnvxhJAbQL
 1SdSvkiY7r+cGbIQbr3sAuCVNdy7oJm0EFG/xbn4g9ISdt1u2Ls2Nhrv8wSKHuzBY4
 w+1e7kyDVeYY8ukUnKEPc9DEHCl0IMTVNRW5GvckQU+W/cwhZeEryOTxxbVBlzHI5t
 tLCxTjCp+VmDJJtDna3Sb++A9bkwKY1VvjfCDntJ9qgz3ud55aalvDOYM5htXlHS3Y
 hyeJ8JuTo9OSBfkr09CeOc+AYWieVNCpnp/xan0QEgdU0n2OgSrFrr+ed90Sa4vBqV
 ANWGkemlntciQ==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 4EE091E71B9;
 Mon, 16 Nov 2026 23:26:05 +0300 (MSK)
Received: from gandalf.tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id 4B59B45FBE5;
 Mon, 16 Nov 2026 23:26:05 +0300 (MSK)
Received: by gandalf.tls.msk.ru (Postfix, from userid 1000)
 id 310C5B8E8E; Mon, 16 Nov 2026 23:26:05 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Daniel Paziyski <danielpaziyski@gmail.com>,
 Michael S. Tsirkin <mst@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-11.1.4 36/63] pcie_sriov: perform additional checks after pci
 device realization
Date: Mon, 16 Nov 2026 23:25:15 +0300
Message-ID: <20261116202554.535325-36-mjt@tls.msk.ru>
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

Handle two cases after realization, which were implicitly handled back when PCI
SR-IOV device registration was done after PCI realization before commit
432ea8cc7d27 ("pcie_sriov: register user created virtual function before realizing it")

- If a device is a PF of user created VFs, make sure that it has initialized its
  list of VFs. This check seems to be superfluous, because the only way it can
  fail is:

  - if PCI device realization forgets to initialize the user created virtual
    functions via pcie_sriov_pf_init_from_user_created_vfs, despite having set
    sriov_vf_user_creatable in the device class;

  - if the pcie_sriov_pf_init_from_user_created_vfs function fails, but forgets
    to set errp (which does not happen), and the device specific realization
    code forgets to check and/or propagate if an error has happened.

  However, this check was present, so let's include it again for good measure.

- If a device is a user created VF, make sure that the device is still a
  PCI Express device. This edge case occurs on devices that before realization
  have the PCIe capability set, but then during realization they clear it for
  some reason. This only seems to happen to modern virtio-net-pci devices, which
  have their PCIe capability on, as any other modern virtio device, on object
  instantiation, but is then cleared in its realize function when it is located
  at the root complex or not in a PCIe bus.

Cc: qemu-stable@nongnu.org
Fixes: 432ea8cc7d27 ("pcie_sriov: register user created virtual function before realizing it")
Signed-off-by: Daniel Paziyski <danielpaziyski@gmail.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Message-ID: <20261101162132.147838-3-danielpaziyski@gmail.com>
(cherry picked from commit 36bc5a879e0f0993aaf95e0896cb35426a32249c)
(Fixes: 11ecc538c5b2 in 11.1.x)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/hw/pci/pci.c b/hw/pci/pci.c
index 51713451cb3..6242204a52c 100644
--- a/hw/pci/pci.c
+++ b/hw/pci/pci.c
@@ -2330,6 +2330,11 @@ static void pci_qdev_realize(DeviceState *qdev, Error **errp)
         }
     }
 
+    if (!pcie_sriov_check_after_realize(pci_dev, errp)) {
+        pci_qdev_unrealize(DEVICE(pci_dev));
+        return;
+    }
+
     /*
      * A PCIe Downstream Port that do not have ARI Forwarding enabled must
      * associate only Device 0 with the device attached to the bus
diff --git a/hw/pci/pcie_sriov.c b/hw/pci/pcie_sriov.c
index 69930c7b8cc..23a2a43af78 100644
--- a/hw/pci/pcie_sriov.c
+++ b/hw/pci/pcie_sriov.c
@@ -392,6 +392,25 @@ bool pcie_sriov_register_device(PCIDevice *dev, Error **errp)
     return true;
 }
 
+bool pcie_sriov_check_after_realize(PCIDevice *dev, Error **errp)
+{
+    if (!dev->exp.sriov_pf.vf && dev->qdev.id &&
+        pfs && g_hash_table_contains(pfs, dev->qdev.id)) {
+        error_setg(errp, "attaching user-created SR-IOV VF unsupported");
+        return false;
+    }
+
+    if (dev->sriov_pf) {
+        /* some devices might clear their PCIe capability during realization */
+        if (!pci_is_express(dev)) {
+            error_setg(errp, "PCI Express is required for SR-IOV VF");
+            return false;
+        }
+    }
+
+    return true;
+}
+
 void pcie_sriov_unregister_device(PCIDevice *dev)
 {
     if (dev->sriov_pf && pfs) {
diff --git a/include/hw/pci/pcie_sriov.h b/include/hw/pci/pcie_sriov.h
index b0ea6a62c74..00fe8c4ada3 100644
--- a/include/hw/pci/pcie_sriov.h
+++ b/include/hw/pci/pcie_sriov.h
@@ -57,6 +57,8 @@ int16_t pcie_sriov_pf_init_from_user_created_vfs(PCIDevice *dev,
 bool pcie_sriov_register_device(PCIDevice *dev, Error **errp);
 void pcie_sriov_unregister_device(PCIDevice *dev);
 
+bool pcie_sriov_check_after_realize(PCIDevice *dev, Error **errp);
+
 /*
  * Default (minimal) page size support values
  * as required by the SR/IOV standard:
-- 
2.47.3


