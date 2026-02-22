Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0BD2C6369F
	for <qemu-devel@archiver.kernel.org>; Sun, 22 Feb 2026 14:30:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vuASk-00005k-M7; Sun, 22 Feb 2026 09:29:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1vuASU-0008EJ-DD
 for qemu-devel@nongnu.org; Sun, 22 Feb 2026 09:29:19 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1vuASS-0006ql-AD
 for qemu-devel@nongnu.org; Sun, 22 Feb 2026 09:29:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1771770555;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=shJs6+uDrl1OnFwGXeXwGM3eD68HLZ/4D3ywa0biSus=;
 b=LPr7prZaagWd/dstOgdYxrbkxQ9iIt6WDjEcHfTPt3H350a65/vdCmvFXkFl/GUfy22Wmp
 OQL8g2mU08LpchE8zgjWGy2JF/d73WJ0Wqh1zIFvlxu08clQZBmVvbQCN9AdPpm1q2SD6D
 Tj0OFgHwlsw39q44lloJDQCcHo3G+1k=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-680-85liheLGMoKVZiY0yWq5Tw-1; Sun, 22 Feb 2026 09:29:13 -0500
X-MC-Unique: 85liheLGMoKVZiY0yWq5Tw-1
X-Mimecast-MFC-AGG-ID: 85liheLGMoKVZiY0yWq5Tw_1771770553
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-4837907ec88so44656285e9.0
 for <qemu-devel@nongnu.org>; Sun, 22 Feb 2026 06:29:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1771770552; x=1772375352; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=shJs6+uDrl1OnFwGXeXwGM3eD68HLZ/4D3ywa0biSus=;
 b=jDaDdapq+1V9tAAvHP3fnJqjWnYYHcbmQ3NofP3yWAS8WKG1hyojdT0hAOjTFuVovF
 yqXSiGUCUrIMdlVG7U0N7E+a7p+N/h/ez8SqJD6ZdXsSP4OKCkgL9cBA+qTtvnGDFlRL
 aZEH9f0E7pnhk6q5nBk5DhC4RPgI+tiUAATtY6S8VKaLBaWt+KQygBK8d5AJOfmMqlkS
 rmOu9sRznWfynWIezBB1FeDr3NcLA5NSkbObtmJqpbZdC4OpofSBOIxHnggYM4yaueez
 6aALUzG62Ys9W2TnLrCKVkYYrFR+ct7KMZEo5bzazp8uiq/n8AjmfC2EYzMJQz+/TQ2U
 cHIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771770552; x=1772375352;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=shJs6+uDrl1OnFwGXeXwGM3eD68HLZ/4D3ywa0biSus=;
 b=TWr+gEV5TvkqobUp7PAqiXzqYyPQymSqE2AkvZEpwgWREELIT+t6afHwbOAG3mjU9e
 xI/kQFhsfUoOtHM7Hwsr0ra+XJl6onWQoENUd0zhFHbpJ4+gxMVyaPWgd0yqaT3bAfn+
 0u/pjXruccC52corWs/lHLDC1C/3wE5T31fvG2FSNGGUGO9iCNk9KtiGZw7wmfAFbtbU
 SAPcdWWY8IvbsIXipYx4dv97OqB83nKU/eJ/c1AIkb0U3X4ekA73+wS+DoNwc46mgEff
 KzpQgD0P33TUkHcBOex4TB82UCJ3x8OWXW84j4WsZ3aQeNLAHbDqyMXp1OaKXfWmQb2F
 Hzcg==
X-Gm-Message-State: AOJu0YzjwConszmcknUaPvqbEYfNSf+Y1D4HnQDhizvu6WXa8j/P84f4
 DtkownnTFQL+fdswvzc5ib5s7cOI9dYnDmCtsCCmSetX+b/so9EqXjZbvAwOxf3lEaRdFJQN6vz
 vHEBayqBNiJ5E4llqza4gaeqMPLgvLJI8OAazcyK+rY4NEEGssuMPZ9WjK+FwZG2/htrrcBTsgb
 JgB/8Hcn4m38X8341ra8pKSwRIyVGKVHzFLA==
X-Gm-Gg: AZuq6aKDccNDh7+zKWmJu5Q0yYAXLX5a3xUQzQhbIcxJvG9d6Xhg6G7fofnsGPA6BqD
 4RnM/api9drbrffq9ADfADgrIS5VP9yexbV/93jVGUqSBSoFFyrA6BC7wKwZ89uWJIJxP5IRk2a
 g78CxzXlQEjmFzFPzpJvuCD1eGCk0CJzQsew5gpkI8bYetExnNTRo8CxA9thFmuoA/hnkEUKP9d
 m5tjviftsdHKOHBrkO+pABWgtZOVNswNwt02Y+0Zozjyg68U6daB2c268xVEr8JofOEFJKXNDLf
 kBlar4mWpb2+TGwwm0sZgzF4SnSypHRLuw3315nXyQNJFEp3SfFTEIqQe3qlKinyQhTCWXFFXx+
 t1CMeOUbEuEwgnn6VNBoeJZnbAjfqwYGVDIjzcnhLvUJtnw==
X-Received: by 2002:a05:600c:4f8a:b0:480:1d0b:2d32 with SMTP id
 5b1f17b1804b1-483a95beb5bmr103361425e9.12.1771770552413; 
 Sun, 22 Feb 2026 06:29:12 -0800 (PST)
X-Received: by 2002:a05:600c:4f8a:b0:480:1d0b:2d32 with SMTP id
 5b1f17b1804b1-483a95beb5bmr103360835e9.12.1771770551794; 
 Sun, 22 Feb 2026 06:29:11 -0800 (PST)
Received: from redhat.com (IGLD-80-230-79-166.inter.net.il. [80.230.79.166])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43970d54a73sm13140195f8f.37.2026.02.22.06.29.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 22 Feb 2026 06:29:11 -0800 (PST)
Date: Sun, 22 Feb 2026 09:29:09 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Clement Mathieu--Drif <clement.mathieu--drif@eviden.com>,
 Zhenzhong Duan <zhenzhong.duan@intel.com>,
 Jason Wang <jasowang@redhat.com>, Yi Liu <yi.l.liu@intel.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>
Subject: [PULL 23/33] intel_iommu: Do not report recoverable faults to host
Message-ID: <a6e6a91c2ad1d5c9a770997a2ac3aad46a8e418c.1771770471.git.mst@redhat.com>
References: <cover.1771770471.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1771770471.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -14
X-Spam_score: -1.5
X-Spam_bar: -
X-Spam_report: (-1.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.798, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.79,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

From: Clement Mathieu--Drif <clement.mathieu--drif@eviden.com>

Signed-off-by: Clement Mathieu--Drif <clement.mathieu--drif@eviden.com>
Reviewed-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Message-Id: <20260208082252.288-1-clement.mathieu--drif@eviden.com>
---
 hw/i386/intel_iommu.c | 26 ++++++++++++++++++++++++--
 1 file changed, 24 insertions(+), 2 deletions(-)

diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
index 92a367d657..4924aa4375 100644
--- a/hw/i386/intel_iommu.c
+++ b/hw/i386/intel_iommu.c
@@ -1857,6 +1857,21 @@ static const bool vtd_qualified_faults[] = {
     [VTD_FR_MAX] = false,
 };
 
+static const bool vtd_recoverable_faults[] = {
+    [VTD_FR_WRITE] = true,
+    [VTD_FR_READ] = true,
+    [VTD_FR_PASID_DIR_ENTRY_P] = true,
+    [VTD_FR_PASID_ENTRY_P] = true,
+    [VTD_FR_FS_PAGING_ENTRY_INV] = true,
+    [VTD_FR_FS_PAGING_ENTRY_P] = true,
+    [VTD_FR_FS_PAGING_ENTRY_RSVD] = true,
+    [VTD_FR_PASID_ENTRY_FSPTPTR_INV] = true,
+    [VTD_FR_FS_NON_CANONICAL] = true,
+    [VTD_FR_FS_PAGING_ENTRY_US] = true,
+    [VTD_FR_SM_WRITE] = true,
+    [VTD_FR_MAX] = false,
+};
+
 /* To see if a fault condition is "qualified", which is reported to software
  * only if the FPD field in the context-entry used to process the faulting
  * request is 0.
@@ -1866,6 +1881,11 @@ static inline bool vtd_is_qualified_fault(VTDFaultReason fault)
     return vtd_qualified_faults[fault];
 }
 
+static inline bool vtd_is_recoverable_fault(VTDFaultReason fault, int iommu_idx)
+{
+    return iommu_idx == VTD_IDX_ATS && vtd_recoverable_faults[fault];
+}
+
 static inline bool vtd_is_interrupt_addr(hwaddr addr)
 {
     return VTD_INTERRUPT_ADDR_FIRST <= addr && addr <= VTD_INTERRUPT_ADDR_LAST;
@@ -2237,8 +2257,10 @@ static bool vtd_do_iommu_translate(VTDAddressSpace *vtd_as, PCIBus *bus,
     }
 
     if (ret_fr) {
-        vtd_report_fault(s, -ret_fr, is_fpd_set, source_id,
-                         addr, is_write, pasid != PCI_NO_PASID, pasid);
+        if (!vtd_is_recoverable_fault(-ret_fr, iommu_idx)) {
+            vtd_report_fault(s, -ret_fr, is_fpd_set, source_id,
+                            addr, is_write, pasid != PCI_NO_PASID, pasid);
+        }
         goto error;
     }
 
-- 
MST


