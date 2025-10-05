Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39BD2CAC5BB
	for <qemu-devel@archiver.kernel.org>; Sun,  5 Oct 2025 19:26:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v5UFg-0003hD-Ue; Sun, 05 Oct 2025 15:18:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1v5UFa-00036k-Fc
 for qemu-devel@nongnu.org; Sun, 05 Oct 2025 15:18:30 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1v5UFX-0006e1-G4
 for qemu-devel@nongnu.org; Sun, 05 Oct 2025 15:18:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1759691906;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=7VfnG8rVkzTSwB5pyBpyj7JN89vPRfbgI61K8aW5ts8=;
 b=T6c2mqjvh/ZlvSfAPKkKmVTckjTEM9qlnfPhI67h12r091ez+nI8sdjNdTDMjcu5hY1dJz
 Y93W0xCHpCqDXtMwHD3XFmcmd2hO9XrTWjSiAUudojlGj2NHS2VVFj6ouFWPlHPoY3S9zq
 qpBlaXdGG/eEhdFOzEnUPZ0zacBFMuo=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-532-KiecCtItOUumD0y_oIvSlg-1; Sun, 05 Oct 2025 15:18:25 -0400
X-MC-Unique: KiecCtItOUumD0y_oIvSlg-1
X-Mimecast-MFC-AGG-ID: KiecCtItOUumD0y_oIvSlg_1759691904
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-4256fae4b46so848999f8f.0
 for <qemu-devel@nongnu.org>; Sun, 05 Oct 2025 12:18:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759691904; x=1760296704;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7VfnG8rVkzTSwB5pyBpyj7JN89vPRfbgI61K8aW5ts8=;
 b=J6aSoA5fhIBVhTsnhUhNN3xDslUwDBrDMwBcvH6Q5g/ppmntGC3wWXGEEfEnKduMN3
 NkXeQYw9PGVcUD7SXDIFE/JaLo1k5Bq4mKphr2oMqJdoBfMVBHpX8o+cmYQzfNw3wjTi
 dchj+dKAFeJHn69T00/p0Qa0KeGVDd7n3lLwdqpduuUcPSzaaCq1KpjpesS4BR3soA1m
 HFRe5aL9b6cRouPDu5spIUJLrFmV3XwsfRVyxbctgxx3f9kkiou3JHa8LguVLCl1hpNI
 EdBHanBMsk0qz6J+226OED+aLJzecG8P4v2MCyDku/qP9QSw89fMdpGYcJebtVJ1gd3s
 u2Hw==
X-Gm-Message-State: AOJu0YyG9JriEOslw7J5am32JBNHxZezoYCpBJNVqXdWdflIODwaUasI
 DMbpJtL085/aTU4Zypyi7bmSjedFbFR/Tj1VxBeUK5RBo1yuR0hIGXj6BtfWNalb+hRRz6OmzTD
 pvdZYKXV+VIe/0pqLAkWIIbi5rvYls6YVd6nF/jJUaXmz5sWz0R3TIDr9QGG9DvEz64AgRs7pWt
 CiZlqQn/Nzma8pi/IeElWKbf7wT3leG++rnQ==
X-Gm-Gg: ASbGncuMXg4qYZxiH1fSuf9jr4hJ/6ABkf/HqVt7/uZz3FWnrGl+AnTzIRrYUlCl4rC
 p2XfZfHkVmQCnSANmQXdV1bZLS3EPiMi/1Mi1n2sLP8Iz8dw/rHX1x3ysNu8+FAgtbjppt9IP1v
 pWaQCtwENTx6Jg2kSqVjJGgCKzqFHKHmvq/czwasA0slbs8uyLtaPEK1gZMq3RJ7RfN0xBsisFV
 32SdQkH/rPdh34PX6TtsFoVIvY0oMzou5Ere0/dePWN3seLcxIEHoXxILn8reo4ysVMWJ3+yy57
 6pE6QOMBaNGKeNSEy2kF7usDRzDhSctH6oxT+5M=
X-Received: by 2002:a05:600c:64c4:b0:46d:45e:3514 with SMTP id
 5b1f17b1804b1-46e7114310amr81618325e9.17.1759691903992; 
 Sun, 05 Oct 2025 12:18:23 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHYy9J2pPqOK7HUQemuxKAFiedY9kKOHYQvCRO2hjIuJOlpQcg9wOAEEzEGXZMHC62Z6SL8Zw==
X-Received: by 2002:a05:600c:64c4:b0:46d:45e:3514 with SMTP id
 5b1f17b1804b1-46e7114310amr81618115e9.17.1759691903388; 
 Sun, 05 Oct 2025 12:18:23 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:1518:6900:b69a:73e1:9698:9cd3])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-46e61a4161bsm234336385e9.16.2025.10.05.12.18.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 05 Oct 2025 12:18:22 -0700 (PDT)
Date: Sun, 5 Oct 2025 15:18:21 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Alejandro Jimenez <alejandro.j.jimenez@oracle.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Subject: [PULL 63/75] amd_iommu: Invalidate address translations on
 INVALIDATE_IOMMU_ALL
Message-ID: <560e604db9d55a1d7fde5a8b6de001367b8376f8.1759691708.git.mst@redhat.com>
References: <cover.1759691708.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1759691708.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.43,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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

When the kernel IOMMU driver issues an INVALIDATE_IOMMU_ALL, the address
translation and interrupt remapping information must be cleared for all
Device IDs and all domains. Introduce a helper to sync the shadow page table
for all the address spaces with registered notifiers, which replays both MAP
and UNMAP events.

Signed-off-by: Alejandro Jimenez <alejandro.j.jimenez@oracle.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Message-ID: <20250919213515.917111-15-alejandro.j.jimenez@oracle.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/i386/amd_iommu.c | 48 +++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 48 insertions(+)

diff --git a/hw/i386/amd_iommu.c b/hw/i386/amd_iommu.c
index 9027f7c054..d74d42b3dd 100644
--- a/hw/i386/amd_iommu.c
+++ b/hw/i386/amd_iommu.c
@@ -941,6 +941,47 @@ static void amdvi_iommu_replay(IOMMUMemoryRegion *iommu_mr, IOMMUNotifier *n)
     amdvi_sync_shadow_page_table_range(as, &dte[0], 0, UINT64_MAX, false);
 }
 
+static void amdvi_address_space_sync(AMDVIAddressSpace *as)
+{
+    IOMMUNotifier *n;
+    uint64_t dte[4] = { 0 };
+
+    /* If only UNMAP notifiers are registered, drop all existing mappings */
+    if (!(as->notifier_flags & IOMMU_NOTIFIER_MAP)) {
+        IOMMU_NOTIFIER_FOREACH(n, &as->iommu) {
+            /*
+             * Directly calling memory_region_unmap_iommu_notifier_range() does
+             * not guarantee that the addr_mask eventually passed as parameter
+             * to the notifier is valid. Use amdvi_address_space_unmap() which
+             * ensures the notifier range is divided into properly aligned
+             * regions, and issues notifications for each one.
+             */
+            amdvi_address_space_unmap(as, n);
+        }
+        return;
+    }
+
+    if (amdvi_as_to_dte(as, dte)) {
+        return;
+    }
+
+    amdvi_sync_shadow_page_table_range(as, &dte[0], 0, UINT64_MAX, true);
+}
+
+/*
+ * This differs from the replay() method in that it issues both MAP and UNMAP
+ * notifications since it is called after global invalidation events in order to
+ * re-sync all address spaces.
+ */
+static void amdvi_iommu_address_space_sync_all(AMDVIState *s)
+{
+    AMDVIAddressSpace *as;
+
+    QLIST_FOREACH(as, &s->amdvi_as_with_notifiers, next) {
+        amdvi_address_space_sync(as);
+    }
+}
+
 /* log error without aborting since linux seems to be using reserved bits */
 static void amdvi_inval_devtab_entry(AMDVIState *s, uint64_t *cmd)
 {
@@ -983,6 +1024,13 @@ static void amdvi_inval_all(AMDVIState *s, uint64_t *cmd)
     amdvi_intremap_inval_notify_all(s, true, 0, 0);
 
     amdvi_iotlb_reset(s);
+
+    /*
+     * Fully replay the address space i.e. send both UNMAP and MAP events in
+     * order to synchronize guest and host IO page tables tables.
+     */
+    amdvi_iommu_address_space_sync_all(s);
+
     trace_amdvi_all_inval();
 }
 
-- 
MST


