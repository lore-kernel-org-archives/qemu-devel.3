Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C6F0C83F1A
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Jul 2025 23:12:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ubSHg-0007Sq-RS; Mon, 14 Jul 2025 19:08:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1ubSH7-00064E-Ph
 for qemu-devel@nongnu.org; Mon, 14 Jul 2025 19:08:04 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1ubSH5-0005cH-P8
 for qemu-devel@nongnu.org; Mon, 14 Jul 2025 19:07:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1752534474;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=XprGgK2MBOB8+UJMgMLEb0m5O0TZWRbGViPuc5uwIx8=;
 b=ZdfGMS7Bk8PiuCWGnA6bRLoxqJZN+eToIwnTy9CsRlTVb7Vgcahcjzr866XCz/D33Esv1p
 55RbyLgKCE3nn6vH1LIC/qtLGik3cwlPZGiq4S+9Eoyo70+1//tyGl/pvPdF3ZJPyHV4hJ
 eCC9kJRvYcw0SGXOPFC3sBaBMG9jmwA=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-211-v_NTOkiaPeSoihPDCi9Qag-1; Mon, 14 Jul 2025 19:07:52 -0400
X-MC-Unique: v_NTOkiaPeSoihPDCi9Qag-1
X-Mimecast-MFC-AGG-ID: v_NTOkiaPeSoihPDCi9Qag_1752534471
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-455ea9cb0beso26554925e9.0
 for <qemu-devel@nongnu.org>; Mon, 14 Jul 2025 16:07:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752534471; x=1753139271;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XprGgK2MBOB8+UJMgMLEb0m5O0TZWRbGViPuc5uwIx8=;
 b=hiEbLBb1xOZ8KvDJ9YXWfOrL0OLiSB/Zc1WGCbAbHCAluI/Zt6F4FfOZOG2eZ4z/Jg
 SAZ+g8B9vbHbqojSp9uKrFLHJQOEZTOR/1i7MHNAOlWsgkdoj+NV4R9vTeogP9DCn5WB
 WoxZqDfofty9W91y8JRquXHBd6vXZNcyjaN4gyULoT+lIUn9PBrJVoG6wHQ2gXJFO2uQ
 eW8xOWCUhWePD27lqCcwOSaqVufDiLsbZLypQeTzmg4yvAkJA69GoX+ZxWj4LjLEyBE9
 z8oojhbNeDAiV9HOO3gSdPGKpHefZW8CRqHq5NSnntvzlSs1HV9ul9q6Gou8pYgZy2fF
 mz2Q==
X-Gm-Message-State: AOJu0YxJjTyKn7Xmt6UctV7LHucWF6kr/7twe05RI+OA6JMWP3O+5WMT
 u2MJUBWzLKxOCsh8I5IjLIKrrMOGeys7NgtBStTycQn4NSKD2gtRm89m26jcSc1OyxAQK/33KSQ
 CMPjcRvWRkqp8kkL1oTwI23JS61FwScu2A5T1HpRJVCtBlfJQTgaF55MHkpb3QbdeEOmif55wJB
 79fznav/UiHZxFAI9Q/kfvSQPjaFcLiVdHbw==
X-Gm-Gg: ASbGncsg+PwKn7MhzRZkNq2V0g7ymx1sQDzQ4/k3s2CiH0pPhFL8jeTeJhUnjMjuRYD
 O0pw/clvycju89ab6GaDn1XiDLdePJYoie902CGAyApMhmc3ezbIgxwM3xLsI+wqq5SA5yMnVev
 HtLVbIxlMGT6lMaCcip7jpTPIubRqt/UMzyskp2M11tme6ivKHZSoPB5Q5MAeyiRn/4C9xB8qAD
 IKL8qyB892q8KehyJukq3DS08QllUwXN9bMth5riOOZ6hJq6aF+gHAReaX2ENY7UZQKyIj0Xb9W
 3oP5JNNHr23NJwrpE+YeposCzvagOHSq
X-Received: by 2002:a05:600c:4f52:b0:43d:3df:42d8 with SMTP id
 5b1f17b1804b1-454ec14a5ebmr145453645e9.6.1752534471234; 
 Mon, 14 Jul 2025 16:07:51 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFdD0ZXD1NFDfHr54aO1LMhl3gRpQn2xa9zINZsX8G+lZZXrjrinX9Ijrzdz1wdAlu6iVXtIg==
X-Received: by 2002:a05:600c:4f52:b0:43d:3df:42d8 with SMTP id
 5b1f17b1804b1-454ec14a5ebmr145453395e9.6.1752534470755; 
 Mon, 14 Jul 2025 16:07:50 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:150d:fc00:de3:4725:47c6:6809])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b5e8dc21e7sm13562742f8f.36.2025.07.14.16.07.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Jul 2025 16:07:49 -0700 (PDT)
Date: Mon, 14 Jul 2025 19:07:47 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 CLEMENT MATHIEU--DRIF <clement.mathieu--drif@eviden.com>,
 Jason Wang <jasowang@redhat.com>, Yi Liu <yi.l.liu@intel.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>
Subject: [PULL 37/97] intel_iommu: Set address mask when a translation fails
 and adjust W permission
Message-ID: <74b9d1654d0eb89e7052d21bc861dc807a06b562.1752534227.git.mst@redhat.com>
References: <cover.1752534227.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1752534227.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: CLEMENT MATHIEU--DRIF <clement.mathieu--drif@eviden.com>

Implements the behavior defined in section 10.2.3.5 of PCIe spec rev 5.
This is needed by devices that support ATS.

Signed-off-by: Clement Mathieu--Drif <clement.mathieu--drif@eviden.com>
Message-Id: <20250628180226.133285-10-clement.mathieu--drif@eviden.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/i386/intel_iommu.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
index bff307b9bc..1b1b0b5632 100644
--- a/hw/i386/intel_iommu.c
+++ b/hw/i386/intel_iommu.c
@@ -2091,7 +2091,8 @@ static bool vtd_do_iommu_translate(VTDAddressSpace *vtd_as, PCIBus *bus,
     uint8_t bus_num = pci_bus_num(bus);
     VTDContextCacheEntry *cc_entry;
     uint64_t pte, page_mask;
-    uint32_t level, pasid = vtd_as->pasid;
+    uint32_t level = UINT32_MAX;
+    uint32_t pasid = vtd_as->pasid;
     uint16_t source_id = PCI_BUILD_BDF(bus_num, devfn);
     int ret_fr;
     bool is_fpd_set = false;
@@ -2250,14 +2251,19 @@ out:
     entry->iova = addr & page_mask;
     entry->translated_addr = vtd_get_pte_addr(pte, s->aw_bits) & page_mask;
     entry->addr_mask = ~page_mask;
-    entry->perm = access_flags;
+    entry->perm = (is_write ? access_flags : (access_flags & (~IOMMU_WO)));
     return true;
 
 error:
     vtd_iommu_unlock(s);
     entry->iova = 0;
     entry->translated_addr = 0;
-    entry->addr_mask = 0;
+    /*
+     * Set the mask for ATS (the range must be present even when the
+     * translation fails : PCIe rev 5 10.2.3.5)
+     */
+    entry->addr_mask = (level != UINT32_MAX) ?
+                       (~vtd_pt_level_page_mask(level)) : (~VTD_PAGE_MASK_4K);
     entry->perm = IOMMU_NONE;
     return false;
 }
-- 
MST


