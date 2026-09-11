Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9EEEC88E50
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Sep 2026 09:08:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x4xBD-0007IB-Dq; Fri, 11 Sep 2026 05:04:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1x4xAi-0004Ye-1A
 for qemu-devel@nongnu.org; Fri, 11 Sep 2026 05:03:48 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1x4xAd-0008Lf-Au
 for qemu-devel@nongnu.org; Fri, 11 Sep 2026 05:03:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1789117422;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Ztrp18hGYXHuUYyUKf9DJwGmlf0B2MNBYEJ6m3HjUYc=;
 b=K5TOptzF8xfjd/1pvTECgU5JBMAW5mYsO0Qyog7DWUSYbMKvMJNFVZYha5lx/j2Yrry/JG
 Y2zN+XkKe8V0r6TIEj8/SXPXELZXVdeX1SKcmHwvAGIMrHLh1DTQwv3sTVdxUNG3E4o6uQ
 gCqhMXogmo3qyStUDPXKb5Sx5FYS4aQ=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-408-UQCYyze0PkWGAZCQoPq5YA-1; Fri, 11 Sep 2026 05:03:41 -0400
X-MC-Unique: UQCYyze0PkWGAZCQoPq5YA-1
X-Mimecast-MFC-AGG-ID: UQCYyze0PkWGAZCQoPq5YA_1789117420
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-49e6683d48fso1182315e9.0
 for <qemu-devel@nongnu.org>; Fri, 11 Sep 2026 02:03:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1789117420; x=1789722220; darn=nongnu.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :content-type:mime-version:references:message-id:subject:cc:to:from
 :date:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=Ztrp18hGYXHuUYyUKf9DJwGmlf0B2MNBYEJ6m3HjUYc=;
 b=HgqKQn/E6SXkO1dGT/UTqZ6wUAUrlG8OvQephdbvnEkuHeQVqrPUBibWOXO4s01VqA
 nUPoqXrwW2idvNIDnu6SU5bbvjHdq93P/sW7jSyIEpBF8VNMXw6wMiPG9AYi5y6FFm94
 Z95y4kKFX1/ocLwmt2ZDioD89DkNfsA3T8xyLsAzzMNKWHCoT1wSj/N2irDFGb5ti2Ny
 JdXA/SnDvWBWLqljJEAW5N3zlO/CZPZZbFvlqbs+NSZkGD+zjyTmIyFZJyY37tOAARsc
 6h9NVMujVESG9KksPPhloADOWvl6x+0XNFk1R9qVyNcFN5A4sDZw6ISpnZXwy+wQz8Iz
 aiCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789117420; x=1789722220;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :content-type:mime-version:references:message-id:subject:cc:to:from
 :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=Ztrp18hGYXHuUYyUKf9DJwGmlf0B2MNBYEJ6m3HjUYc=;
 b=BRZZfW+z4ov/LFs0+komL4P812Y/LqGX/fpMNpxARY5/wLiezYx5dnx0juslAOpUug
 0959zsRjHjKw674MObkwB1VgjC1QrnvZfLP50A9hB5zHOBr2vsfvWv5O7auweoEg8XZ9
 LlMGZ7i3mFAXkii/Mo2ye6h415FwJr6llPSOPZtA+7VsemiyWdlF7HgwPqJF13tVLVDE
 WSrvfNb5ZzAkQhPb7fV/qx7uC1boSx1tzKSvtb0n21NeQKaT3hP7PGN62IqcNU7As9sp
 qfNoQ1czlh/rtSgRLoLAJ4DDHvfvxO7JXw49OM7fkd6zV04fZ8SigsqAJt59n4jYbW+t
 xXFg==
X-Gm-Message-State: AFuF++kUlqP6W/nqnV8nI6/GU/e5mYQugkVDeUVMMf/D/g4SyX5YtaWt
 Opr5s1kfsi4lTiAtWnfgC26n8QYwTsMMCpYqq6FW43UNPi/gHmmGMdCLlrPiyCdSivGd1yLIoJa
 MKlZJrFWct7xFbr8GXYTd4QTi9AeRZRyHUvtyeAAgRdfkdDE83v0b8Gm5thjNfz8x/wQBE2V6tv
 jelNBrASCmiuNOFnlbVmZl8ggwNl5hoTJPaA==
X-Gm-Gg: AYBFou0TClHiv2kiuCj8QeyTY8KPzmC6yczFfVaVMOSjhJbztsFa3hRAMqkWKcqWc11
 QUeyMXEJVIRhhv/f9LXyOwRAZ1ptteI4+LkBZJk3+KDpnHLaHSMXCSDjZczNWIMLhMR09aua5q/
 Rku+qOo8cpTXF/SfzZGy6JrH4Q2E5fuWmDyLltyqRCs2aVLjYxASOwuvjUiGPZRvU92wtpdU0lM
 /6xVfoIduj9ORShF6bE1sjTAX+6DeV6dDrrtg/H5DiJAzUKyHQghhcy3r7uCUyd9BFxmv7Q0ZmE
 gK4ygDrZMXjI/TDlX5gLjUbkgeEi9zNd5wJvE+Rlpl4XolkbucYouSmxnP6lqysWtT7K4xAxoEh
 vJYi0pRccsPmR2Ihbdqt7oE4=
X-Received: by 2002:a05:600d:8445:10b0:49c:cf18:494e with SMTP id
 5b1f17b1804b1-49e6198a3b2mr25032055e9.12.1789117420111; 
 Fri, 11 Sep 2026 02:03:40 -0700 (PDT)
X-Received: by 2002:a05:600d:8445:10b0:49c:cf18:494e with SMTP id
 5b1f17b1804b1-49e6198a3b2mr25031285e9.12.1789117419514; 
 Fri, 11 Sep 2026 02:03:39 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-79-236.inter.net.il. [80.230.79.236])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49e60a8a89esm59342745e9.1.2026.09.11.02.03.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 11 Sep 2026 02:03:39 -0700 (PDT)
Date: Fri, 11 Sep 2026 05:03:37 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 =?utf-8?Q?Cl=C3=A9ment?= MATHIEU--DRIF <clement.mathieu--drif@bull.com>,
 Yi Liu <yi.l.liu@intel.com>, Zhenzhong Duan <zhenzhong.duan@intel.com>,
 Jason Wang <jasowangio@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL v2 59/75] intel_iommu: Always write all the flags passed to
 vtd_set_flag_in_pte
Message-ID: <79ce20146054de5a120f550b195ef236e6f02bf8.1789117222.git.mst@redhat.com>
References: <cover.1789117222.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover.1789117222.git.mst@redhat.com>
X-Mailer: git-send-email 2.51.2.2891.g4157995a80.dirty
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

From: Clément MATHIEU--DRIF <clement.mathieu--drif@bull.com>

This function was initially designed to write a single flag in a pte.
The current implementation expects it to set several flags.

Fixes: 65c4f0999991 ("intel_iommu: Set accessed and dirty bits during stage-1 translation")
Signed-off-by: Clement Mathieu--Drif <clement.mathieu--drif@bull.com>
Reviewed-by: Yi Liu <yi.l.liu@intel.com>
Reviewed-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Message-ID: <20260903150649.2281104-3-clement.mathieu--drif@bull.com>
---
 hw/i386/intel_iommu.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
index eccb16346c..91ab549dbf 100644
--- a/hw/i386/intel_iommu.c
+++ b/hw/i386/intel_iommu.c
@@ -1964,13 +1964,13 @@ static bool vtd_iova_fs_check_canonical(IntelIOMMUState *s, uint64_t iova,
     }
 }
 
-static MemTxResult vtd_set_flag_in_pte(dma_addr_t base_addr, uint32_t index,
-                                       uint64_t pte, uint64_t flag)
+static MemTxResult vtd_set_flags_in_pte(dma_addr_t base_addr, uint32_t index,
+                                       uint64_t pte, uint64_t flags)
 {
-    if (pte & flag) {
+    if ((pte & flags) == flags) {
         return MEMTX_OK;
     }
-    pte |= flag;
+    pte |= flags;
     pte = cpu_to_le64(pte);
     return dma_memory_write(&address_space_memory,
                             base_addr + index * sizeof(pte),
@@ -2043,7 +2043,7 @@ static int vtd_iova_to_fspte(IntelIOMMUState *s, VTDContextEntry *ce,
             flag_ad |= VTD_FS_D;
         }
 
-        if (vtd_set_flag_in_pte(addr, offset, fspte, flag_ad) != MEMTX_OK) {
+        if (vtd_set_flags_in_pte(addr, offset, fspte, flag_ad) != MEMTX_OK) {
             return -VTD_FR_FS_BIT_UPDATE_FAILED;
         }
 
-- 
MST


