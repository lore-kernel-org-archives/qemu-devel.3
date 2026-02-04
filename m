Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C520EEA7942
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Feb 2026 19:08:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vniA4-00070l-7p; Wed, 04 Feb 2026 14:03:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1vniA1-0006qm-VR
 for qemu-devel@nongnu.org; Wed, 04 Feb 2026 14:03:33 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1vniA0-0007mk-C4
 for qemu-devel@nongnu.org; Wed, 04 Feb 2026 14:03:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1770231811;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=+939riydvwDd27jqC2atSYgpM2eosXh2uo/JqY9/3xU=;
 b=HyecGc8Hs1fN/wpGI7XhtzgU2pnzZUq4YfNyfzv3e2LnjeCotTnC7Uuyrfr2RPEBCyfQ3O
 pKqzHJ9gqvqnh3peDlC8vmDHKsV/ytojx1bKX2QxswlPhUHrz7Zg+ahSmpVouWjibmDyfZ
 CdaQePwSfGarPEtrZXYeg0OSmaZ6KbI=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-376-yhLOvfY0Pc2jld7g4joNVw-1; Wed, 04 Feb 2026 14:03:30 -0500
X-MC-Unique: yhLOvfY0Pc2jld7g4joNVw-1
X-Mimecast-MFC-AGG-ID: yhLOvfY0Pc2jld7g4joNVw_1770231809
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-4358f90fe8dso118238f8f.0
 for <qemu-devel@nongnu.org>; Wed, 04 Feb 2026 11:03:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1770231809; x=1770836609; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=+939riydvwDd27jqC2atSYgpM2eosXh2uo/JqY9/3xU=;
 b=OJB8UaUyFl2O2t/5fqdE/OPMVOS6YoIoW9FV/e2TN6vPZhg8i6Vehg/FFs12sqAPfc
 V/j737omikb3+SnB2OGBhgTXYPnfUXgnBloxO210tPQPX94kH1G2AtIISaYuEGy7F4vK
 gdR/00oqzbIa4oF+bsbB2zMb69gp34HRpANnXMk51yBnjBqi71CVDbsAsJk+aeZATLHC
 sSA7Q19c7BjsjC67XXn0DSJIY0D4556inTcVw2q8fUlCWTI3pgae23tJZR+sNulRtFcT
 N0vS7BPmQ5dSlCeCiwBMcYjbmXVCHsM+zIozW523KoiNmGJzSyUtWNAcHxzh0NS9Drrp
 00/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770231809; x=1770836609;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+939riydvwDd27jqC2atSYgpM2eosXh2uo/JqY9/3xU=;
 b=IUoQNSQzMU5MQk7FPXPxZ13x7x2my75ESbKWoHRveLcfpzMLFLbMwRbaWBeEjX0N6r
 jXlj1eaZFByroD1VdLq64y5R04yFLcrcXVcfnyNHpH4qmHpOCOKZx0n3CNqmdbHrSdjc
 hwH7g7wDBPr38E0nGx8kwYVebOjl8Jvmpa7mkPG+sFLo2HvJRLlb1cLdV2TKQXXDXhVm
 kNa6u2aLa/8oeVN8j4mlx/JlVi9/CqzCNIenTczUedKP7zDz4hRpPq2lTmucAS+IraGw
 boSMC0r44t8+PVx1kU2u2S7G8oJd51euvdAMMQXw2i2EUoUhd4fDuwuBU1P4BKSYWceG
 d+ow==
X-Gm-Message-State: AOJu0Yzf5WQG2PAao72jZH41SupKSEb+4Fu/ZCXUojSFOP09zwNtxChJ
 VSYVVEN8PNTvBQrkMwM2G7cJQJm9vSj0Dnrkg52BUUY7XwGVu4/DlBMDTQd3VArDH1DhAyguOvA
 4VpbnNHQjUM27lzf4vkGiwWHXMkm5/m/btOhJsKYQOc4XE8QWIud/G/Fr/87I25X1sH1mokfeWz
 qEd9LiDwcXT+rqUOPZazEK88lXH+1wSbMAIg==
X-Gm-Gg: AZuq6aLWZzTgSYh4Pj0AeEQr6VNCxGWlcR2+0X1Uie58w9RTPSgyAlO2mCi41NnxOR1
 1DDm6F3vJwyxcPoLwQ69TtZaJgeWGlQdwhe0DNwIylrBuSlvWM6VUM7mOXbjg4qWdMwxGWjrWZX
 1QHZzYF1L47E+PWx4mzE/74qSagA5s88KsjxQFYWwqzPYYlM/eqq2bgWwNj+p/lk2coVI/BRtO+
 uw729bkPX9+XZopZW/Q0O2HdvBFfhDLz4I/FWnnFr87EcFWUmeEeC40ra7ySUnMxKkdEEUQuRnu
 5BANsjr3OvJxWsc6GGFQAs2p+O8tjkmcBA0EanZf7C8pfNduAJTsKXpz5K7Pk8T6bPQvTFEglfa
 3GHb7GzFJCYFJUqXyXJO+IlLU+byfqApyuw==
X-Received: by 2002:a05:6000:250a:b0:432:88c4:e180 with SMTP id
 ffacd0b85a97d-436209bfc2cmr593190f8f.15.1770231809004; 
 Wed, 04 Feb 2026 11:03:29 -0800 (PST)
X-Received: by 2002:a05:6000:250a:b0:432:88c4:e180 with SMTP id
 ffacd0b85a97d-436209bfc2cmr593133f8f.15.1770231808502; 
 Wed, 04 Feb 2026 11:03:28 -0800 (PST)
Received: from redhat.com (IGLD-80-230-34-155.inter.net.il. [80.230.34.155])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43617e25d47sm7489588f8f.5.2026.02.04.11.03.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Feb 2026 11:03:28 -0800 (PST)
Date: Wed, 4 Feb 2026 14:03:26 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 CLEMENT MATHIEU--DRIF <clement.mathieu--drif@eviden.com>,
 Jason Wang <jasowang@redhat.com>, Yi Liu <yi.l.liu@intel.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Subject: [PULL 16/51] intel_iommu: Handle insufficient permissions during
 translation requests
Message-ID: <86c5072181002ea6160c716e0524105900c40dc2.1770231744.git.mst@redhat.com>
References: <cover.1770231744.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1770231744.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: CLEMENT MATHIEU--DRIF <clement.mathieu--drif@eviden.com>

ATS translations should not fail when the write permission is not set.

Signed-off-by: Clement Mathieu--Drif <clement.mathieu--drif@eviden.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Message-Id: <20251029105137.1097933-6-clement.mathieu--drif@eviden.com>
---
 hw/i386/intel_iommu.c          | 14 ++++++++------
 hw/i386/intel_iommu_internal.h |  3 ++-
 2 files changed, 10 insertions(+), 7 deletions(-)

diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
index 7e7c31cb55..6ba1c1676b 100644
--- a/hw/i386/intel_iommu.c
+++ b/hw/i386/intel_iommu.c
@@ -1998,7 +1998,7 @@ static int vtd_iova_to_fspte(IntelIOMMUState *s, VTDContextEntry *ce,
                              uint64_t iova, bool is_write,
                              uint64_t *fsptep, uint32_t *fspte_level,
                              bool *reads, bool *writes, uint8_t aw_bits,
-                             uint32_t pasid)
+                             uint32_t pasid, int iommu_idx)
 {
     dma_addr_t addr = vtd_get_iova_pgtbl_base(s, ce, pasid);
     uint32_t offset;
@@ -2039,7 +2039,8 @@ static int vtd_iova_to_fspte(IntelIOMMUState *s, VTDContextEntry *ce,
 
         *reads = true;
         *writes = (*writes) && (fspte & VTD_FS_RW);
-        if (is_write && !(fspte & VTD_FS_RW)) {
+        /* ATS should not fail when the write permission is not set */
+        if (is_write && !(fspte & VTD_FS_RW) && iommu_idx != VTD_IDX_ATS) {
             return -VTD_FR_SM_WRITE;
         }
         if (vtd_fspte_nonzero_rsvd(fspte, *fspte_level)) {
@@ -2098,7 +2099,7 @@ static void vtd_report_fault(IntelIOMMUState *s,
  */
 static bool vtd_do_iommu_translate(VTDAddressSpace *vtd_as, PCIBus *bus,
                                    uint8_t devfn, hwaddr addr, bool is_write,
-                                   IOMMUTLBEntry *entry)
+                                   IOMMUTLBEntry *entry, int iommu_idx)
 {
     IntelIOMMUState *s = vtd_as->iommu_state;
     VTDContextEntry ce;
@@ -2204,7 +2205,8 @@ static bool vtd_do_iommu_translate(VTDAddressSpace *vtd_as, PCIBus *bus,
 
     if (s->fsts && s->root_scalable) {
         ret_fr = vtd_iova_to_fspte(s, &ce, addr, is_write, &pte, &level,
-                                   &reads, &writes, s->aw_bits, pasid);
+                                   &reads, &writes, s->aw_bits, pasid,
+                                   iommu_idx);
         pgtt = VTD_SM_PASID_ENTRY_FST;
     } else {
         ret_fr = vtd_iova_to_sspte(s, &ce, addr, is_write, &pte, &level,
@@ -4033,7 +4035,7 @@ static IOMMUTLBEntry vtd_iommu_translate(IOMMUMemoryRegion *iommu, hwaddr addr,
             }
         } else {
             success = vtd_do_iommu_translate(vtd_as, vtd_as->bus, vtd_as->devfn,
-                                            addr, is_write, &iotlb);
+                                            addr, is_write, &iotlb, iommu_idx);
         }
     } else {
         /* DMAR disabled, passthrough, use 4k-page*/
@@ -5196,7 +5198,7 @@ static IOMMUTLBEntry vtd_iommu_ats_do_translate(IOMMUMemoryRegion *iommu,
         vtd_prepare_error_entry(&entry);
         entry.target_as = &address_space_memory;
     } else {
-        entry = vtd_iommu_translate(iommu, addr, flags, VTD_IDX_UNTRANSLATED);
+        entry = vtd_iommu_translate(iommu, addr, flags, VTD_IDX_ATS);
     }
 
     return entry;
diff --git a/hw/i386/intel_iommu_internal.h b/hw/i386/intel_iommu_internal.h
index be757c290d..18d50191d2 100644
--- a/hw/i386/intel_iommu_internal.h
+++ b/hw/i386/intel_iommu_internal.h
@@ -692,7 +692,8 @@ typedef struct VTDPIOTLBInvInfo {
 typedef enum VTDIOMMUIndex {
     VTD_IDX_UNTRANSLATED = 0, /* Default */
     VTD_IDX_TRANSLATED = 1,
-    VTD_IDX_COUNT = 2, /* Number of supported indexes */
+    VTD_IDX_ATS = 2,
+    VTD_IDX_COUNT = 3, /* Number of supported indexes */
 } VTDIOMMUIndex;
 
 typedef struct VTDHostIOMMUDevice {
-- 
MST


