Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91AB0CAC5B8
	for <qemu-devel@archiver.kernel.org>; Sun,  5 Oct 2025 19:24:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v5UG5-00050t-MS; Sun, 05 Oct 2025 15:19:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1v5UFS-0002a1-QP
 for qemu-devel@nongnu.org; Sun, 05 Oct 2025 15:18:22 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1v5UFP-0006cG-Hi
 for qemu-devel@nongnu.org; Sun, 05 Oct 2025 15:18:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1759691898;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=QCxFKVOHL0at5yB+6ueybckR1t9fum92R8jP7usSf1w=;
 b=RErLm0MbVQ+ceR/4kcLYnxX11QfgCl5VgnHFVHA5oli9H2XPD+XEuDYFPpyd1HoUii1+Ou
 oYLid6v8EHwK3cSzAHZoGqd+frr5HOQO84hLSNcS025IyCzznkZGTitoLJzMeJ5EPCSP3l
 WY3z0dV6hIAt3GhUzQagIsbMTLE9GjY=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-591-scn8RFuyNw2BaCeDrmvDaw-1; Sun, 05 Oct 2025 15:18:17 -0400
X-MC-Unique: scn8RFuyNw2BaCeDrmvDaw-1
X-Mimecast-MFC-AGG-ID: scn8RFuyNw2BaCeDrmvDaw_1759691896
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-46e3e177893so22925895e9.2
 for <qemu-devel@nongnu.org>; Sun, 05 Oct 2025 12:18:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759691896; x=1760296696;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QCxFKVOHL0at5yB+6ueybckR1t9fum92R8jP7usSf1w=;
 b=UVSOj78+dXYPLi36eeR1qplceAXBY6GLskI/5ihIkM1haNNn/ctI9XkVgrVWsXo6dM
 0T1rezHKEJLPez/bhbVxQ/y5XKktrvLsXgzw9/Yzp9RuE7SpVYgiAoSgjLCiFrIdAE//
 e3/9Z4FeuvO4Pbtv4XZ7DFLSthVEwtwtWDzjAsqHb7Y3AuapoLrMNyWkXp0FcU52rHrw
 E+uJWuEkyjZdlPa0FaUxaBs+GjxFPOBSf6wxOy96AriWnVILPubsHI81GLiqdWl3GyaF
 D9dNmA8xD4DldxLI5UKQ4AAk8xshNql4mDlpRTxwZQn3e20JEuEgPKghBO9TOHy7+DbP
 NKag==
X-Gm-Message-State: AOJu0YzdQqK5kN7HCukwwcIGlHM2RAKAq6CqGLb/5fudxr9kQqsBcFtW
 C+zyB57CHGGYVwWs1m8zl6twyoF0vcLqSnfaJG/Elz6NxivDM1NNhtiqZxw0AT8kt//8PrJyiTF
 6rczNJVE7k8+1vgKXH3J2kBKg8D+8EFh/xBpGWHkKCqzDVD10AFlqHvOZiXpvds9LdGakdigAw4
 MJu8WKjTaqYKsBrO38E0pieFd+gXryb6DOQw==
X-Gm-Gg: ASbGncus8ZHpr/VzxwO3yU2U4UfM3Z6ahWe+Q72lf7qkYwgDIEM+QnJKHjOXM0rM2Mc
 cA+3mywB/q/pXmOD0LelSldPls3ZhEuqWjdQ9OsEIqw714TB2CinDc8+pViSmoYAZd4K2u4KB9L
 FaVQrepPcrjNoRqKvl8DtUeEW0Nwb736zZdBgtYIvpEtbQT2m1MrkLnc9EN2D+MaoMrb2u3DuUK
 tzr/274a8kMtbqFvUHobicS7l29A66mAcm0016HYFRjNHtFkXs2AyLc/geedIDXchAAqIOWr0ZE
 npLzlhzoXF+AMjUQC6HmOe6FX02PBJsnPZ69gLA=
X-Received: by 2002:a05:6000:2dc8:b0:3cd:ef83:a9a1 with SMTP id
 ffacd0b85a97d-42567152194mr6125495f8f.20.1759691895890; 
 Sun, 05 Oct 2025 12:18:15 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEW6DC+RF4gILeNWVekpqJNJ+21AFTqBaRzRGNy33JIpOzr6tk0+z+l/NsC1CwcNtBtDo4mpA==
X-Received: by 2002:a05:6000:2dc8:b0:3cd:ef83:a9a1 with SMTP id
 ffacd0b85a97d-42567152194mr6125473f8f.20.1759691895182; 
 Sun, 05 Oct 2025 12:18:15 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:1518:6900:b69a:73e1:9698:9cd3])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4255d8e980dsm18750958f8f.36.2025.10.05.12.18.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 05 Oct 2025 12:18:14 -0700 (PDT)
Date: Sun, 5 Oct 2025 15:18:13 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Alejandro Jimenez <alejandro.j.jimenez@oracle.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Subject: [PULL 59/75] amd_iommu: Sync shadow page tables on page invalidation
Message-ID: <ad598027a226624c2abe79129b032215906c3478.1759691708.git.mst@redhat.com>
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

From: Alejandro Jimenez <alejandro.j.jimenez@oracle.com>

When the guest issues an INVALIDATE_IOMMU_PAGES command, decode the address
and size of the invalidation and sync the guest page table state with the
host. This requires walking the guest page table and calling notifiers
registered for address spaces matching the domain ID encoded in the command.

Signed-off-by: Alejandro Jimenez <alejandro.j.jimenez@oracle.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Message-ID: <20250919213515.917111-11-alejandro.j.jimenez@oracle.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/i386/amd_iommu.c | 82 ++++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 74 insertions(+), 8 deletions(-)

diff --git a/hw/i386/amd_iommu.c b/hw/i386/amd_iommu.c
index d8a451b3a5..caae65c4b3 100644
--- a/hw/i386/amd_iommu.c
+++ b/hw/i386/amd_iommu.c
@@ -591,9 +591,8 @@ static uint64_t large_pte_page_size(uint64_t pte)
  *      page table walk. This means that the DTE has valid data, but one of the
  *      lower level entries in the Page Table could not be read.
  */
-static int __attribute__((unused))
-fetch_pte(AMDVIAddressSpace *as, hwaddr address, uint64_t dte, uint64_t *pte,
-          hwaddr *page_size)
+static uint64_t fetch_pte(AMDVIAddressSpace *as, hwaddr address, uint64_t dte,
+                          uint64_t *pte, hwaddr *page_size)
 {
     IOMMUAccessFlags perms = amdvi_get_perms(dte);
 
@@ -691,9 +690,9 @@ fetch_pte(AMDVIAddressSpace *as, hwaddr address, uint64_t dte, uint64_t *pte,
  * notifiers to sync the shadow page tables in the host.
  * Must be called with a valid DTE for DMA remapping i.e. V=1,TV=1
  */
-static void __attribute__((unused))
-amdvi_sync_shadow_page_table_range(AMDVIAddressSpace *as, uint64_t *dte,
-                                   hwaddr addr, uint64_t size, bool send_unmap)
+static void amdvi_sync_shadow_page_table_range(AMDVIAddressSpace *as,
+                                               uint64_t *dte, hwaddr addr,
+                                               uint64_t size, bool send_unmap)
 {
     IOMMUTLBEvent event;
 
@@ -835,8 +834,7 @@ static gboolean amdvi_iotlb_remove_by_domid(gpointer key, gpointer value,
  * first zero at bit 51 or larger is a request to invalidate the entire address
  * space.
  */
-static uint64_t __attribute__((unused))
-amdvi_decode_invalidation_size(hwaddr addr, uint16_t flags)
+static uint64_t amdvi_decode_invalidation_size(hwaddr addr, uint16_t flags)
 {
     uint64_t size = AMDVI_PAGE_SIZE;
     uint8_t fzbit = 0;
@@ -853,10 +851,76 @@ amdvi_decode_invalidation_size(hwaddr addr, uint16_t flags)
     return size;
 }
 
+/*
+ * Synchronize the guest page tables with the shadow page tables kept in the
+ * host for the specified range.
+ * The invalidation command issued by the guest and intercepted by the VMM
+ * does not specify a device, but a domain, since all devices in the same domain
+ * share the same page tables. However, vIOMMU emulation creates separate
+ * address spaces per device, so it is necessary to traverse the list of all of
+ * address spaces (i.e. devices) that have notifiers registered in order to
+ * propagate the changes to the host page tables.
+ * We cannot return early from this function once a matching domain has been
+ * identified and its page tables synced (based on the fact that all devices in
+ * the same domain share the page tables). The reason is that different devices
+ * (i.e. address spaces) could have different notifiers registered, and by
+ * skipping address spaces that appear later on the amdvi_as_with_notifiers list
+ * their notifiers (which could differ from the ones registered for the first
+ * device/address space) would not be invoked.
+ */
+static void amdvi_sync_domain(AMDVIState *s, uint16_t domid, uint64_t addr,
+                              uint16_t flags)
+{
+    AMDVIAddressSpace *as;
+
+    uint64_t size = amdvi_decode_invalidation_size(addr, flags);
+
+    if (size == AMDVI_INV_ALL_PAGES) {
+        addr = 0;       /* Set start address to 0 and invalidate entire AS */
+    } else {
+        addr &= ~(size - 1);
+    }
+
+    /*
+     * Call notifiers that have registered for each address space matching the
+     * domain ID, in order to sync the guest pagetable state with the host.
+     */
+    QLIST_FOREACH(as, &s->amdvi_as_with_notifiers, next) {
+
+        uint64_t dte[4] = { 0 };
+
+        /*
+         * Retrieve the Device Table entry for the devid corresponding to the
+         * current address space, and verify the DomainID matches i.e. the page
+         * tables to be synced belong to devices in the domain.
+         */
+        if (amdvi_as_to_dte(as, dte)) {
+            continue;
+        }
+
+        /* Only need to sync the Page Tables for a matching domain */
+        if (domid != (dte[1] & AMDVI_DEV_DOMID_ID_MASK)) {
+            continue;
+        }
+
+        /*
+         * We have determined that there is a valid Device Table Entry for a
+         * device matching the DomainID in the INV_IOMMU_PAGES command issued by
+         * the guest. Walk the guest page table to sync shadow page table.
+         */
+        if (as->notifier_flags & IOMMU_NOTIFIER_MAP) {
+            /* Sync guest IOMMU mappings with host */
+            amdvi_sync_shadow_page_table_range(as, &dte[0], addr, size, true);
+        }
+    }
+}
+
 /* we don't have devid - we can't remove pages by address */
 static void amdvi_inval_pages(AMDVIState *s, uint64_t *cmd)
 {
     uint16_t domid = cpu_to_le16((uint16_t)extract64(cmd[0], 32, 16));
+    uint64_t addr = cpu_to_le64(extract64(cmd[1], 12, 52)) << 12;
+    uint16_t flags = cpu_to_le16((uint16_t)extract64(cmd[1], 0, 3));
 
     if (extract64(cmd[0], 20, 12) || extract64(cmd[0], 48, 12) ||
         extract64(cmd[1], 3, 9)) {
@@ -866,6 +930,8 @@ static void amdvi_inval_pages(AMDVIState *s, uint64_t *cmd)
 
     g_hash_table_foreach_remove(s->iotlb, amdvi_iotlb_remove_by_domid,
                                 &domid);
+
+    amdvi_sync_domain(s, domid, addr, flags);
     trace_amdvi_pages_inval(domid);
 }
 
-- 
MST


