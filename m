Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91B44CCD184
	for <qemu-devel@archiver.kernel.org>; Sun,  5 Oct 2025 19:26:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v5UFi-0003yP-7S; Sun, 05 Oct 2025 15:18:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1v5UFN-0002OS-QF
 for qemu-devel@nongnu.org; Sun, 05 Oct 2025 15:18:18 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1v5UFB-0006aS-0g
 for qemu-devel@nongnu.org; Sun, 05 Oct 2025 15:18:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1759691882;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=g7mFYden9qH7zkZwD2EMTpua+ooliRaONw9JQmjB2ko=;
 b=AxQ8VOi+BzVCWVH3UMEczsiypLxcCaaysjV9hSO7HeuPrj2DbkLxOEQ85RfRDJUEDf5sHW
 nxO8Djli4BCSvR+/rgP/NcGgKD9hZLY3WxwuoCBhI/WN51TWHLozMzQhY3npFqG0Xt0r/i
 VtL9g54Cg+pfZ5DmUaMtqx3ihUntq0E=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-25-F_CEArV2PDC9HEqfPBzRJw-1; Sun, 05 Oct 2025 15:18:01 -0400
X-MC-Unique: F_CEArV2PDC9HEqfPBzRJw-1
X-Mimecast-MFC-AGG-ID: F_CEArV2PDC9HEqfPBzRJw_1759691881
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-3f030846a41so2461912f8f.2
 for <qemu-devel@nongnu.org>; Sun, 05 Oct 2025 12:18:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759691880; x=1760296680;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=g7mFYden9qH7zkZwD2EMTpua+ooliRaONw9JQmjB2ko=;
 b=wdR8y5cKQIzhEaNWRerWMaVXx5QsoQcEyRs7ii6vItzrrg3DysBCEdaZybvkg3yh4g
 R/C42rznUhy5vzKEKT1yiLMFmFVxgA+SQIQdMaEjuzb8F5310AUcOOB0JvQVpC4zQYLg
 3awUwsD3qYe7VLcyWRm7yHvYwn5Ft9XoRc3kvc6dWmEYQlWBEoSucg75yjCsSPoJKT8s
 ATbq1N6z3MktM0ef71SG8h/bjvaHPgtRWKX9STgQW/Dd5BqA8OODRi15L2ya4RTDZ+Q+
 GvwonSZE3W+oQXmwXfyKgxhH/jYaipTpNutkCXUdXPkCAxgDsJrirok2iwdGh7XC4cv4
 bEaQ==
X-Gm-Message-State: AOJu0Yw9fnkZ0o0psfN6iFqnandUnf5L9WvPIc4OUixu5QO2/u2vP5Hf
 GNQRvIFoPB+U50AMC79V3iVNcTf7je/EzGJuU/9/3zmrpy8LEyzQXygtvaGwZEH4xnFDPoSlgzk
 5I9bamP9cRRuGZ/eMzI9b7JaPAHIzPnfRwvlnNg+mlTOyYwTBSatmkpVZgfQdiagF9UMzpK6vWe
 HGwcG+CBsv/7h7t6vUhwPac8KHX9GOXT/4NQ==
X-Gm-Gg: ASbGncveilJzKqU4J8pKT+cc0KMbGxMnN1MgWI4s6SF/8K9+1NsoLP3V1Y0z4XKmCzH
 2uVK5vnN7KLz92Bqzie4ZJE42bsoERvj95o05gLZhLs1fkYIRm5lP1JRCZYLLm9cDuReeUDsz7k
 W0y8/lB/xjlYXwvghhE4AOGOyVb54QhDOUeM6PiL0Y1YySr6hOaqFjE9IcbJGrN9ko56bFvWqpW
 um3/NoOHkX3+ykrBdq+wKq4H/Xr+xDEXKBEdaABCEfdiGFAt+e/4eh5S3vD07TV7sqi/C2HeNkH
 pMBsHOK9vsfA3fYjc75PhkFrDSe0RoK24mpZ/Ns=
X-Received: by 2002:a05:6000:659:20b0:425:76a7:c910 with SMTP id
 ffacd0b85a97d-42576a7c9afmr1618742f8f.49.1759691880205; 
 Sun, 05 Oct 2025 12:18:00 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEGGMCet7TBxc+rHzmr1Clg90kIGH16rZZPlQDq/DINB1SyfCLEFRKIVL2Duo3Ki136rAHavQ==
X-Received: by 2002:a05:6000:659:20b0:425:76a7:c910 with SMTP id
 ffacd0b85a97d-42576a7c9afmr1618722f8f.49.1759691879679; 
 Sun, 05 Oct 2025 12:17:59 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:1518:6900:b69a:73e1:9698:9cd3])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4255d8e970esm17360456f8f.35.2025.10.05.12.17.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 05 Oct 2025 12:17:59 -0700 (PDT)
Date: Sun, 5 Oct 2025 15:17:57 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Alejandro Jimenez <alejandro.j.jimenez@oracle.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Subject: [PULL 52/75] amd_iommu: Reorder device and page table helpers
Message-ID: <03e4960124b64e6798b5727a08358b8bed12f4a4.1759691708.git.mst@redhat.com>
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

Move code related to Device Table and Page Table to an earlier location in
the file, where it does not require forward declarations to be used by the
various invalidation functions that will need to query the DTE and walk the
page table in upcoming changes.

This change consist of code movement only, no functional change intended.

Signed-off-by: Alejandro Jimenez <alejandro.j.jimenez@oracle.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Message-ID: <20250919213515.917111-4-alejandro.j.jimenez@oracle.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/i386/amd_iommu.c | 172 ++++++++++++++++++++++----------------------
 1 file changed, 86 insertions(+), 86 deletions(-)

diff --git a/hw/i386/amd_iommu.c b/hw/i386/amd_iommu.c
index 26be69bec8..3cbc9499db 100644
--- a/hw/i386/amd_iommu.c
+++ b/hw/i386/amd_iommu.c
@@ -438,6 +438,92 @@ static void amdvi_completion_wait(AMDVIState *s, uint64_t *cmd)
     trace_amdvi_completion_wait(addr, data);
 }
 
+static inline uint64_t amdvi_get_perms(uint64_t entry)
+{
+    return (entry & (AMDVI_DEV_PERM_READ | AMDVI_DEV_PERM_WRITE)) >>
+           AMDVI_DEV_PERM_SHIFT;
+}
+
+/* validate that reserved bits are honoured */
+static bool amdvi_validate_dte(AMDVIState *s, uint16_t devid,
+                               uint64_t *dte)
+{
+    if ((dte[0] & AMDVI_DTE_QUAD0_RESERVED) ||
+        (dte[1] & AMDVI_DTE_QUAD1_RESERVED) ||
+        (dte[2] & AMDVI_DTE_QUAD2_RESERVED) ||
+        (dte[3] & AMDVI_DTE_QUAD3_RESERVED)) {
+        amdvi_log_illegaldevtab_error(s, devid,
+                                      s->devtab +
+                                      devid * AMDVI_DEVTAB_ENTRY_SIZE, 0);
+        return false;
+    }
+
+    return true;
+}
+
+/* get a device table entry given the devid */
+static bool amdvi_get_dte(AMDVIState *s, int devid, uint64_t *entry)
+{
+    uint32_t offset = devid * AMDVI_DEVTAB_ENTRY_SIZE;
+
+    if (dma_memory_read(&address_space_memory, s->devtab + offset, entry,
+                        AMDVI_DEVTAB_ENTRY_SIZE, MEMTXATTRS_UNSPECIFIED)) {
+        trace_amdvi_dte_get_fail(s->devtab, offset);
+        /* log error accessing dte */
+        amdvi_log_devtab_error(s, devid, s->devtab + offset, 0);
+        return false;
+    }
+
+    *entry = le64_to_cpu(*entry);
+    if (!amdvi_validate_dte(s, devid, entry)) {
+        trace_amdvi_invalid_dte(entry[0]);
+        return false;
+    }
+
+    return true;
+}
+
+/* get pte translation mode */
+static inline uint8_t get_pte_translation_mode(uint64_t pte)
+{
+    return (pte >> AMDVI_DEV_MODE_RSHIFT) & AMDVI_DEV_MODE_MASK;
+}
+
+static inline uint64_t pte_override_page_mask(uint64_t pte)
+{
+    uint8_t page_mask = 13;
+    uint64_t addr = (pte & AMDVI_DEV_PT_ROOT_MASK) >> 12;
+    /* find the first zero bit */
+    while (addr & 1) {
+        page_mask++;
+        addr = addr >> 1;
+    }
+
+    return ~((1ULL << page_mask) - 1);
+}
+
+static inline uint64_t pte_get_page_mask(uint64_t oldlevel)
+{
+    return ~((1UL << ((oldlevel * 9) + 3)) - 1);
+}
+
+static inline uint64_t amdvi_get_pte_entry(AMDVIState *s, uint64_t pte_addr,
+                                          uint16_t devid)
+{
+    uint64_t pte;
+
+    if (dma_memory_read(&address_space_memory, pte_addr,
+                        &pte, sizeof(pte), MEMTXATTRS_UNSPECIFIED)) {
+        trace_amdvi_get_pte_hwerror(pte_addr);
+        amdvi_log_pagetab_error(s, devid, pte_addr, 0);
+        pte = 0;
+        return pte;
+    }
+
+    pte = le64_to_cpu(pte);
+    return pte;
+}
+
 /* log error without aborting since linux seems to be using reserved bits */
 static void amdvi_inval_devtab_entry(AMDVIState *s, uint64_t *cmd)
 {
@@ -894,92 +980,6 @@ static void amdvi_mmio_write(void *opaque, hwaddr addr, uint64_t val,
     }
 }
 
-static inline uint64_t amdvi_get_perms(uint64_t entry)
-{
-    return (entry & (AMDVI_DEV_PERM_READ | AMDVI_DEV_PERM_WRITE)) >>
-           AMDVI_DEV_PERM_SHIFT;
-}
-
-/* validate that reserved bits are honoured */
-static bool amdvi_validate_dte(AMDVIState *s, uint16_t devid,
-                               uint64_t *dte)
-{
-    if ((dte[0] & AMDVI_DTE_QUAD0_RESERVED) ||
-        (dte[1] & AMDVI_DTE_QUAD1_RESERVED) ||
-        (dte[2] & AMDVI_DTE_QUAD2_RESERVED) ||
-        (dte[3] & AMDVI_DTE_QUAD3_RESERVED)) {
-        amdvi_log_illegaldevtab_error(s, devid,
-                                      s->devtab +
-                                      devid * AMDVI_DEVTAB_ENTRY_SIZE, 0);
-        return false;
-    }
-
-    return true;
-}
-
-/* get a device table entry given the devid */
-static bool amdvi_get_dte(AMDVIState *s, int devid, uint64_t *entry)
-{
-    uint32_t offset = devid * AMDVI_DEVTAB_ENTRY_SIZE;
-
-    if (dma_memory_read(&address_space_memory, s->devtab + offset, entry,
-                        AMDVI_DEVTAB_ENTRY_SIZE, MEMTXATTRS_UNSPECIFIED)) {
-        trace_amdvi_dte_get_fail(s->devtab, offset);
-        /* log error accessing dte */
-        amdvi_log_devtab_error(s, devid, s->devtab + offset, 0);
-        return false;
-    }
-
-    *entry = le64_to_cpu(*entry);
-    if (!amdvi_validate_dte(s, devid, entry)) {
-        trace_amdvi_invalid_dte(entry[0]);
-        return false;
-    }
-
-    return true;
-}
-
-/* get pte translation mode */
-static inline uint8_t get_pte_translation_mode(uint64_t pte)
-{
-    return (pte >> AMDVI_DEV_MODE_RSHIFT) & AMDVI_DEV_MODE_MASK;
-}
-
-static inline uint64_t pte_override_page_mask(uint64_t pte)
-{
-    uint8_t page_mask = 13;
-    uint64_t addr = (pte & AMDVI_DEV_PT_ROOT_MASK) >> 12;
-    /* find the first zero bit */
-    while (addr & 1) {
-        page_mask++;
-        addr = addr >> 1;
-    }
-
-    return ~((1ULL << page_mask) - 1);
-}
-
-static inline uint64_t pte_get_page_mask(uint64_t oldlevel)
-{
-    return ~((1UL << ((oldlevel * 9) + 3)) - 1);
-}
-
-static inline uint64_t amdvi_get_pte_entry(AMDVIState *s, uint64_t pte_addr,
-                                          uint16_t devid)
-{
-    uint64_t pte;
-
-    if (dma_memory_read(&address_space_memory, pte_addr,
-                        &pte, sizeof(pte), MEMTXATTRS_UNSPECIFIED)) {
-        trace_amdvi_get_pte_hwerror(pte_addr);
-        amdvi_log_pagetab_error(s, devid, pte_addr, 0);
-        pte = 0;
-        return pte;
-    }
-
-    pte = le64_to_cpu(pte);
-    return pte;
-}
-
 static void amdvi_page_walk(AMDVIAddressSpace *as, uint64_t *dte,
                             IOMMUTLBEntry *ret, unsigned perms,
                             hwaddr addr)
-- 
MST


