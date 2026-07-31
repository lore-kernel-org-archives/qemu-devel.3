Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2781CC5516F
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Jul 2026 15:34:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wppEQ-0002Fc-3d; Fri, 31 Jul 2026 11:33:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <prod-mta-13.8631fc262581453bbf619ec5b2062170.19fb8ce47f6000e099@swg.vates.tech>)
 id 1wppEB-0002Ew-K6
 for qemu-devel@nongnu.org; Fri, 31 Jul 2026 11:32:53 -0400
Received: from prod-mta-13.swg-srv.net ([185.255.28.18])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from
 <prod-mta-13.8631fc262581453bbf619ec5b2062170.19fb8ce47f6000e099@swg.vates.tech>)
 id 1wppE5-00016p-MT
 for qemu-devel@nongnu.org; Fri, 31 Jul 2026 11:32:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vates.tech;
 q=dns/txt; s=selector1; bh=E74rtg7xvJElw5aFZgAvQQASAvQyMsRJ5/BdWO3+NuM=;
 h=from:subject:date:message-id:to:cc:mime-version:content-type:feedback-id;
 b=OXXqSlzdt6viKU+J7nfRqMblI2u3zBF4aslkCWfaoUYgp20l3sWe6GtWLVmTNlMOK6q1yPZIE
 cn8IwoJmr487pe9scHjs9Fh5qEKnXkvsFd6+jAPTZp6F9PF0jv7IOCd2QoWHCF4Jm7zC6ccU4qP
 b5WLmxuJ+YWjvwr/mO/yU8OsXVSSjssFuAXE53vWQ+87BiZaQqt0EadmpKddlz4NoUU3x5APcXK
 2dyE8rtP0dhbbamFEEKNhgwr89scFkgS6GGeK4AUPsOR3M/zdjkJcsvidTr2NyT+CN1lU1j/cCg
 AbXmB47PxdmJiCWJ7L5oRo/E/xNMrjBrUGGixPfAcP6g==
Received: from mail2.vates.fr ([37.26.189.201] mail2.vates.fr)
 (Authenticated sender:
 8631fc262581453bbf619ec5b2062170/smtp/7773de5a-2839-4720-82ee-e06722ae1d3e)
 by prod-mta-13.swg-srv.net (ZoneMTA - prod-mta-13) with ESMTPSA id
 19fb8ce47f6000e099.004 for <qemu-devel@nongnu.org>
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
 Fri, 31 Jul 2026 15:32:34 +0000
X-Zone-Loop: 5ed27483226ac31a6a422bd0663b7bdc17119e0a187a
x-campaign-type: default
x-transaction-id: 9f909b2e-e8c8-4401-a03f-22e9c3d40a6f
x-swg-uid: 01-3633f46f-e195-40f0-917d-8641eb31be36
X-Mailer: Sweego
Message-ID: <1785511954.8631fc262581453bbf619ec5b2062170.19fb8ce47f6000e099@vates.tech>
x-swg-bid: 1785511954.8631fc262581453bbf619ec5b2062170.19fb8ce47f6000e099
Feedback-ID: default:8631fc262581453bbf619ec5b2062170:Sweego
x-campaign-id: default
x-client-id: 8631fc262581453bbf619ec5b2062170
X-Originating-IP: [37.26.189.201]
Received: from l14.home (areims-651-1-80-194.w90-18.abo.wanadoo.fr
 [90.18.187.194]) (Authenticated sender: anthony.perard)
 by mail2.vates.fr (Postfix) with ESMTPSA id A2E4B8310E;
 Fri, 31 Jul 2026 17:32:33 +0200 (CEST)
From: Anthony PERARD <anthony.perard@vates.tech>
To: qemu-devel@nongnu.org
Cc: Anthony PERARD <anthony.perard@vates.tech>,
 Stefano Stabellini <sstabellini@kernel.org>,
 Anthony PERARD <anthony@xenproject.org>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 xen-devel@lists.xenproject.org
Subject: [PATCH] hw/xen-pt: Rework mapping of MSI-X related page
Date: Fri, 31 Jul 2026 17:32:05 +0200
MIME-Version: 1.0
X-BM-Disclaimer: Yes
Content-Type: multipart/alternative;
 boundary="-=Part.190d.85dbe06311ba886a.19fb8ce456c.58c1da0940306110=-"
X-Bm-Milter-Handled: 4ffbd6c1-ee69-4e1b-aabd-f977039bd3e2
X-Bm-Transport-Timestamp: 1785511953773
Received-SPF: pass client-ip=185.255.28.18;
 envelope-from=prod-mta-13.8631fc262581453bbf619ec5b2062170.19fb8ce47f6000e099@swg.vates.tech;
 helo=prod-mta-13.swg-srv.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 MSGID_FROM_MTA_HEADER=0.001, SPF_HELO_NONE=0.001,
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

---=Part.190d.85dbe06311ba886a.19fb8ce456c.58c1da0940306110=-
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

The mmap() call appears to only map the MSI-X entries but mmap will
map full pages, make that evident with ROUND_UP()=2E

pci_msix_read() will read past the current length given to mmap() as
the memory region "xen-pci-pt-msix" is been given a whole page as
size=2E

Also adjust the munmap() call to use the same length as used in
mmap()=2E And fix the pointer phys_iomem_base as it has been adjusted
with table_offset_adjust after the mmap() call=2E

Lastly, adjust the memory region "xen-pci-pt-msix" size with
msix->table_offset_adjust in case the offset isn't 0, and use ROUND_UP
instead of open coding it=2E

Signed-off-by: Anthony PERARD <anthony=2Eperard@vates=2Etech>
---
 hw/xen/xen_pt_msi=2Ec | 23 ++++++++++++++---------
 1 file changed, 14 insertions(+), 9 deletions(-)

diff --git a/hw/xen/xen_pt_msi=2Ec b/hw/xen/xen_pt_msi=2Ec
index df15ccf0d030=2E=2Ef94f1adcd576 100644
--- a/hw/xen/xen_pt_msi=2Ec
+++ b/hw/xen/xen_pt_msi=2Ec
@@ -561,12 +561,6 @@ int xen_pt_msix_init(XenPCIPassthroughState *s, uint3=
2_t base)
         msix->msix_entry[i]=2Epirq =3D XEN_PT_UNASSIGNED_PIRQ;
     }
=20
-    memory_region_init_io(&msix->mmio, OBJECT(s), &pci_msix_ops,
-                          s, "xen-pci-pt-msix",
-                          (total_entries * PCI_MSIX_ENTRY_SIZE
-                           + XC_PAGE_SIZE - 1)
-                          & XC_PAGE_MASK);
-
     rc =3D xen_host_pci_get_long(hd, base + PCI_MSIX_TABLE, &table_off);
     if (rc) {
         XEN_PT_ERR(d, "Failed to read PCI_MSIX_TABLE field\n");
@@ -588,7 +582,9 @@ int xen_pt_msix_init(XenPCIPassthroughState *s, uint32=
_t base)
     msix->table_offset_adjust =3D table_off & 0x0fff;
     msix->phys_iomem_base =3D
         mmap(NULL,
-             total_entries * PCI_MSIX_ENTRY_SIZE + msix->table_offset_adj=
ust,
+             ROUND_UP(total_entries * PCI_MSIX_ENTRY_SIZE
+                      + msix->table_offset_adjust,
+                      XC_PAGE_SIZE),
              PROT_READ,
              MAP_SHARED | MAP_LOCKED,
              fd,
@@ -605,6 +601,13 @@ int xen_pt_msix_init(XenPCIPassthroughState *s, uint3=
2_t base)
     XEN_PT_LOG(d, "mapping physical MSI-X table to %p\n",
                msix->phys_iomem_base);
=20
+    memory_region_init_io(&msix->mmio, OBJECT(s), &pci_msix_ops,
+                          s, "xen-pci-pt-msix",
+                          ROUND_UP(total_entries * PCI_MSIX_ENTRY_SIZE
+                                   + msix->table_offset_adjust,
+                                   XC_PAGE_SIZE)
+                          - msix->table_offset_adjust);
+
     memory_region_add_subregion_overlap(&s->bar[bar_index], table_off,
                                         &msix->mmio,
                                         2); /* Priority: pci default + 1 =
*/
@@ -629,8 +632,10 @@ void xen_pt_msix_unmap(XenPCIPassthroughState *s)
     if (msix->phys_iomem_base) {
         XEN_PT_LOG(&s->dev, "unmapping physical MSI-X table from %p\n",
                    msix->phys_iomem_base);
-        munmap(msix->phys_iomem_base, msix->total_entries * PCI_MSIX_ENTR=
Y_SIZE
-               + msix->table_offset_adjust);
+        munmap(msix->phys_iomem_base - msix->table_offset_adjust,
+               ROUND_UP(msix->total_entries * PCI_MSIX_ENTRY_SIZE
+                        + msix->table_offset_adjust,
+                        XC_PAGE_SIZE));
     }
=20
     memory_region_del_subregion(&s->bar[msix->bar_index], &msix->mmio);


-- 
Anthony Perard | Vates XCP-ng Developer

XCP-ng & Xen Orchestra - Vate=
s solutions

web: https://vates=2Etech
---=Part.190d.85dbe06311ba886a.19fb8ce456c.58c1da0940306110=---

