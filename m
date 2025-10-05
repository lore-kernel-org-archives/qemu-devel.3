Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48013CAC5BB
	for <qemu-devel@archiver.kernel.org>; Sun,  5 Oct 2025 19:23:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v5UF8-0000iA-St; Sun, 05 Oct 2025 15:18:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1v5UEe-000891-3E
 for qemu-devel@nongnu.org; Sun, 05 Oct 2025 15:17:32 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1v5UEa-0006Uw-Mx
 for qemu-devel@nongnu.org; Sun, 05 Oct 2025 15:17:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1759691843;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=n5WvGc63Ugvtn6YJdDflpDJWvjGDbZWJM3c/1ewQ4RE=;
 b=ZroAUGUzXWqsXKrjOPAM0S4LX4giC5XfW5Snm9hemrkNQ9qxsZajfia31eIvy3B2D4tFR9
 MGZ2V68EHw5/uBJrj1Hj0llwSOVOv/KkPwTgxEwzTbgvUUC/61FiUbvvbL5WEuAsf4TISj
 VsjKzLx0C7KqqI5XQt6qu2i0/F90uNE=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-619-3M6dB2fxNvq-Z3OeXYfx3A-1; Sun, 05 Oct 2025 15:17:22 -0400
X-MC-Unique: 3M6dB2fxNvq-Z3OeXYfx3A-1
X-Mimecast-MFC-AGG-ID: 3M6dB2fxNvq-Z3OeXYfx3A_1759691841
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-3ed9557f976so2674309f8f.3
 for <qemu-devel@nongnu.org>; Sun, 05 Oct 2025 12:17:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759691841; x=1760296641;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=n5WvGc63Ugvtn6YJdDflpDJWvjGDbZWJM3c/1ewQ4RE=;
 b=gxp5Es/pD5Fu3g9i8h60YQpwPPiM+fhPsWVW9JpHxRt+ErXcodar39380PYuDl+kc7
 corFHpDCK6fKLFvJW48vTitZR+uq9e40BoZj42M/deSOwld1DrZSW+QuLxd2UkFy7PoE
 Y78r7MLfEKrg9DB62BYi+fwwW2vUmwcxSZG2wLJXZtFmlxaB/NiWcfSnGtWZb5IhOCTw
 oGcyrHRQDValz7tBY4aUPtpcYM+VGOmzwjgb6/Fr+04Uce7Uv/HRbCEB8EVYuUyvni9d
 EAsnITPAouxYC2Iuzlpd94sez+L0fxoTVYXqR2hh0N8a9OD4cbqTpvoyrkQZ8qrezgOC
 K/1w==
X-Gm-Message-State: AOJu0YxI6TamIHFPC5adCOOh7mA8DBHSCgbZyQgMY/sTS0RDV/KwOqAn
 MhIWXDTzJSaucr7tIuzl/inncMnJ6jZoz3vC68SJFwnToPQJbTmj2h15vTWi9G+gidm2xYI1nxy
 Cxzs2Cm6Njra245yCIYW3qt46XjrdLf+BLh4hcK6nVlyU/cWqIQfUp0VO+3n33xjoWdxj5wMyO5
 1Kg3Bzc/9Sz7Gus+kTvXMzSoCRJxjs151Y8w==
X-Gm-Gg: ASbGncuqynYMmpTAj2ICokBKz1qfe4lgK/uqREAJazKkEuOuMXtZqRB2JKpLPkibJ9b
 lh3QZQ6b/A5Sp0vED9Za+1LZyczdIMQdzoI/tLzoKFqcgQkaKILOZQJoDWZVZOlgQlflIuUySqy
 TpxmWlWv7Wrmuor/k0c8e8y2n2KOhwKAp0NEosNyLm+XXjy/b2LSPOkLm8/BMK/1w6x6FfZvojT
 vO3mJWISz9gDPUcawW3vHHiDZdnMY9YgXm3xOldlA6PTZ4HinSe4q6GnBd216uzBpwlJJLGblvq
 42XdwzSTO0ZQDc+D2k98cXk94ui0/n2kf66xMyM=
X-Received: by 2002:a05:6000:2289:b0:411:3c14:3aac with SMTP id
 ffacd0b85a97d-4256713be79mr5871227f8f.7.1759691840608; 
 Sun, 05 Oct 2025 12:17:20 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE27CTVi53eXQm7AWxxDMWA9CZFQp5U0Lv8gyfXCy4U7U2VzH60ccOncgr7hbITZIZ3ACyHmw==
X-Received: by 2002:a05:6000:2289:b0:411:3c14:3aac with SMTP id
 ffacd0b85a97d-4256713be79mr5871203f8f.7.1759691839805; 
 Sun, 05 Oct 2025 12:17:19 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:1518:6900:b69a:73e1:9698:9cd3])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4255d8f45e9sm17822998f8f.51.2025.10.05.12.17.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 05 Oct 2025 12:17:19 -0700 (PDT)
Date: Sun, 5 Oct 2025 15:17:17 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Damien Bergamini <damien.bergamini@eviden.com>,
 Clement Mathieu--Drif <clement.mathieu--drif@eviden.com>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>,
 Jason Wang <jasowang@redhat.com>, Keith Busch <kbusch@kernel.org>,
 Klaus Jensen <its@irrelevant.dk>,
 Jesper Devantier <foss@defmacro.it>, qemu-block@nongnu.org
Subject: [PULL 34/75] pcie_sriov: Fix broken MMIO accesses from SR-IOV VFs
Message-ID: <2e54e5fda779a7ba45578884276dca62462f7a06.1759691708.git.mst@redhat.com>
References: <cover.1759691708.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1759691708.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.43,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Damien Bergamini <damien.bergamini@eviden.com>

Starting with commit cab1398a60eb, SR-IOV VFs are realized as soon as
pcie_sriov_pf_init() is called.  Because pcie_sriov_pf_init() must be
called before pcie_sriov_pf_init_vf_bar(), the VF BARs types won't be
known when the VF realize function calls pcie_sriov_vf_register_bar().

This breaks the memory regions of the VFs (for instance with igbvf):

$ lspci
...
    Region 0: Memory at 281a00000 (64-bit, prefetchable) [virtual] [size=16K]
    Region 3: Memory at 281a20000 (64-bit, prefetchable) [virtual] [size=16K]

$ info mtree
...
address-space: pci_bridge_pci_mem
  0000000000000000-ffffffffffffffff (prio 0, i/o): pci_bridge_pci
    0000000081a00000-0000000081a03fff (prio 1, i/o): igbvf-mmio
    0000000081a20000-0000000081a23fff (prio 1, i/o): igbvf-msix

and causes MMIO accesses to fail:

    Invalid write at addr 0x281A01520, size 4, region '(null)', reason: rejected
    Invalid read at addr 0x281A00C40, size 4, region '(null)', reason: rejected

To fix this, VF BARs are now registered with pci_register_bar() which
has a type parameter and pcie_sriov_vf_register_bar() is removed.

Fixes: cab1398a60eb ("pcie_sriov: Reuse SR-IOV VF device instances")
Signed-off-by: Damien Bergamini <damien.bergamini@eviden.com>
Signed-off-by: Clement Mathieu--Drif <clement.mathieu--drif@eviden.com>
Reviewed-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Message-ID: <20250901151314.1038020-1-clement.mathieu--drif@eviden.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 docs/pcie_sriov.txt         |  5 ++---
 include/hw/pci/pcie_sriov.h |  4 ----
 hw/net/igbvf.c              |  6 ++++--
 hw/nvme/ctrl.c              |  8 ++------
 hw/pci/pci.c                |  3 ---
 hw/pci/pcie_sriov.c         | 11 -----------
 6 files changed, 8 insertions(+), 29 deletions(-)

diff --git a/docs/pcie_sriov.txt b/docs/pcie_sriov.txt
index ab2142807f..00d7bd93fd 100644
--- a/docs/pcie_sriov.txt
+++ b/docs/pcie_sriov.txt
@@ -72,8 +72,7 @@ setting up a BAR for a VF.
 2) Similarly in the implementation of the virtual function, you need to
    make it a PCI Express device and add a similar set of capabilities
    except for the SR/IOV capability. Then you need to set up the VF BARs as
-   subregions of the PFs SR/IOV VF BARs by calling
-   pcie_sriov_vf_register_bar() instead of the normal pci_register_bar() call:
+   subregions of the PFs SR/IOV VF BARs by calling pci_register_bar():
 
    pci_your_vf_dev_realize( ... )
    {
@@ -83,7 +82,7 @@ setting up a BAR for a VF.
       pcie_ari_init(d, 0x100);
       ...
       memory_region_init(mr, ... )
-      pcie_sriov_vf_register_bar(d, bar_nr, mr);
+      pci_register_bar(d, bar_nr, bar_type, mr);
       ...
    }
 
diff --git a/include/hw/pci/pcie_sriov.h b/include/hw/pci/pcie_sriov.h
index aeaa38cf34..b0ea6a62c7 100644
--- a/include/hw/pci/pcie_sriov.h
+++ b/include/hw/pci/pcie_sriov.h
@@ -37,10 +37,6 @@ void pcie_sriov_pf_exit(PCIDevice *dev);
 void pcie_sriov_pf_init_vf_bar(PCIDevice *dev, int region_num,
                                uint8_t type, dma_addr_t size);
 
-/* Instantiate a bar for a VF */
-void pcie_sriov_vf_register_bar(PCIDevice *dev, int region_num,
-                                MemoryRegion *memory);
-
 /**
  * pcie_sriov_pf_init_from_user_created_vfs() - Initialize PF with user-created
  *                                              VFs, adding ARI to PF
diff --git a/hw/net/igbvf.c b/hw/net/igbvf.c
index 31d72c4977..9b0db8f841 100644
--- a/hw/net/igbvf.c
+++ b/hw/net/igbvf.c
@@ -251,10 +251,12 @@ static void igbvf_pci_realize(PCIDevice *dev, Error **errp)
 
     memory_region_init_io(&s->mmio, OBJECT(dev), &mmio_ops, s, "igbvf-mmio",
         IGBVF_MMIO_SIZE);
-    pcie_sriov_vf_register_bar(dev, IGBVF_MMIO_BAR_IDX, &s->mmio);
+    pci_register_bar(dev, IGBVF_MMIO_BAR_IDX, PCI_BASE_ADDRESS_MEM_TYPE_64 |
+                     PCI_BASE_ADDRESS_MEM_PREFETCH, &s->mmio);
 
     memory_region_init(&s->msix, OBJECT(dev), "igbvf-msix", IGBVF_MSIX_SIZE);
-    pcie_sriov_vf_register_bar(dev, IGBVF_MSIX_BAR_IDX, &s->msix);
+    pci_register_bar(dev, IGBVF_MSIX_BAR_IDX, PCI_BASE_ADDRESS_MEM_TYPE_64 |
+                     PCI_BASE_ADDRESS_MEM_PREFETCH, &s->msix);
 
     ret = msix_init(dev, IGBVF_MSIX_VEC_NUM, &s->msix, IGBVF_MSIX_BAR_IDX, 0,
         &s->msix, IGBVF_MSIX_BAR_IDX, 0x2000, 0x70, errp);
diff --git a/hw/nvme/ctrl.c b/hw/nvme/ctrl.c
index f5ee6bf260..cd81f73997 100644
--- a/hw/nvme/ctrl.c
+++ b/hw/nvme/ctrl.c
@@ -8708,12 +8708,8 @@ static bool nvme_init_pci(NvmeCtrl *n, PCIDevice *pci_dev, Error **errp)
                               msix_table_offset);
         memory_region_add_subregion(&n->bar0, 0, &n->iomem);
 
-        if (pci_is_vf(pci_dev)) {
-            pcie_sriov_vf_register_bar(pci_dev, 0, &n->bar0);
-        } else {
-            pci_register_bar(pci_dev, 0, PCI_BASE_ADDRESS_SPACE_MEMORY |
-                             PCI_BASE_ADDRESS_MEM_TYPE_64, &n->bar0);
-        }
+        pci_register_bar(pci_dev, 0, PCI_BASE_ADDRESS_SPACE_MEMORY |
+                         PCI_BASE_ADDRESS_MEM_TYPE_64, &n->bar0);
 
         ret = msix_init(pci_dev, nr_vectors,
                         &n->bar0, 0, msix_table_offset,
diff --git a/hw/pci/pci.c b/hw/pci/pci.c
index c3df9d6656..4854d3d618 100644
--- a/hw/pci/pci.c
+++ b/hw/pci/pci.c
@@ -1491,9 +1491,6 @@ void pci_register_bar(PCIDevice *pci_dev, int region_num,
                         : pci_get_bus(pci_dev)->address_space_mem;
 
     if (pci_is_vf(pci_dev)) {
-        PCIDevice *pf = pci_dev->exp.sriov_vf.pf;
-        assert(!pf || type == pf->exp.sriov_pf.vf_bar_type[region_num]);
-
         r->addr = pci_bar_address(pci_dev, region_num, r->type, r->size);
         if (r->addr != PCI_BAR_UNMAPPED) {
             memory_region_add_subregion_overlap(r->address_space,
diff --git a/hw/pci/pcie_sriov.c b/hw/pci/pcie_sriov.c
index 8a4bf0d6f7..29474d749a 100644
--- a/hw/pci/pcie_sriov.c
+++ b/hw/pci/pcie_sriov.c
@@ -242,17 +242,6 @@ void pcie_sriov_pf_init_vf_bar(PCIDevice *dev, int region_num,
     dev->exp.sriov_pf.vf_bar_type[region_num] = type;
 }
 
-void pcie_sriov_vf_register_bar(PCIDevice *dev, int region_num,
-                                MemoryRegion *memory)
-{
-    uint8_t type;
-
-    assert(dev->exp.sriov_vf.pf);
-    type = dev->exp.sriov_vf.pf->exp.sriov_pf.vf_bar_type[region_num];
-
-    return pci_register_bar(dev, region_num, type, memory);
-}
-
 static gint compare_vf_devfns(gconstpointer a, gconstpointer b)
 {
     return (*(PCIDevice **)a)->devfn - (*(PCIDevice **)b)->devfn;
-- 
MST


