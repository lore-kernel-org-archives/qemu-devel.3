Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C06E0C53219
	for <qemu-devel@archiver.kernel.org>; Sun, 26 Jul 2026 21:30:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wo6QQ-0000LQ-Rh; Sun, 26 Jul 2026 17:30:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1wo6QI-0008IQ-H6
 for qemu-devel@nongnu.org; Sun, 26 Jul 2026 17:30:14 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1wo6QG-0004au-47
 for qemu-devel@nongnu.org; Sun, 26 Jul 2026 17:30:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1785101411;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=s2B+8XrjK5nGScQeDmJaNHYJ46KW3Hmc7jfhpCVdjBg=;
 b=PuJH6LuuY3SYSFNlHvlyXNcIKfaQM6Rt+FYVerF8hhRTDQGKloM21OkiCiz93IZFVQx++L
 3MhzMCLohdr32oW0qpcRUqY9FU2QMhEI2Y6TluHhiuI0HFxNXq7akxnYYomO8Tvyb99eqD
 15IA/wrkm9aw+YtIBylLCxj5IEZzA00=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-634-G7617JLKMuOdw0qaPhO90g-1; Sun, 26 Jul 2026 17:30:10 -0400
X-MC-Unique: G7617JLKMuOdw0qaPhO90g-1
X-Mimecast-MFC-AGG-ID: G7617JLKMuOdw0qaPhO90g_1785101409
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-495517d39fbso11733765e9.2
 for <qemu-devel@nongnu.org>; Sun, 26 Jul 2026 14:30:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1785101409; x=1785706209; darn=nongnu.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :content-type:mime-version:references:message-id:subject:cc:to:from
 :date:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=s2B+8XrjK5nGScQeDmJaNHYJ46KW3Hmc7jfhpCVdjBg=;
 b=XEXC5j6aw8LaFNVI8VerXYzJ9mejl/o5H+77Y8LP/XKe7p1GWbiyQdVicnwi3J+APp
 uzvd9WPmrk+lKA1LjvE3ODAmlWqdjf4oao2XxzHYkb6v0Q91UjyXWdzRSMKEDOYJmFMC
 itoxr5lTvCl1Mmd0O8cXT9ilH8J5Issnng4CvFgRDzV/ti7j+9/lGB29b1qeTSOehVSC
 mgbQOZGTYJYZpDI9PaGNpFB9mgaQe2cq+yaF2VPrFXkrC9a7diXTpEtPwMzgg9BEqslV
 jU+sbA3hR0e0zgVZUozndQSpLI4TKt5DLxHLHo+nrJZyokxdEHPQwuP76E5Djy/n5AbE
 L6Ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785101409; x=1785706209;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :content-type:mime-version:references:message-id:subject:cc:to:from
 :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=s2B+8XrjK5nGScQeDmJaNHYJ46KW3Hmc7jfhpCVdjBg=;
 b=OJLjqhDvCh17MAR/h0o/B9IyloMYbAzhXO+V1W0xLL+XI+Us2KdnR4QWUu6dbSmr7I
 0JXBomyNYpmiN43dt7zVdE78Fq+uVHKXIUzXshTitMhBciwhQQ4ssT8E2UzXwLYHSV7N
 DB4YCbQvyKbPbLguBWgzeOWjGVIK0+BRPK/QdWN+t3NVs7GSjVkNyLc1MBX8rOoygQ4Y
 a+susPUyUjqs1zXeDxjqsvknTT9eSJWatx7kBrXwFrTy9Yu0B5KFWyiPnF8FE2BzyGss
 HoKo4sSz/rwIFAzwSMiflQdX/Rp7dvf3Rp95VDKx07miIeuLkPwDrGTUXhD9cdFGxYlF
 mrtQ==
X-Gm-Message-State: AOJu0YwSM0R/XYXH2CA5ndejEzvnlHgwmMJlKDtfKYugMShscSoWFaFu
 YWIMkd8Z6sl8R574ld2ycRo/76gy7mNY7xctS+SasHDXBU8GK2q+9go/jIOpjuwnu4ZTo4xcPBG
 zTM93h/WjMs4GppA4+s2NBgdEv1l+qHidUsVksZAmSm20BcGLyX/p1DbC+FNjQ5T4uJWx8sue7k
 2/et5lPc1+7OMieaxUYix3wA4LGP3qylCMbw==
X-Gm-Gg: AR+sD13kzscsTsp3FJ1dbw3yEBCf8usXHFlTJmsTS7DANrNCOOGH/Km77DhIuKyn75q
 pb37ETstJiZwSkb0pwmNZqRK80MnvOvQz3D9AIc2y26MSOmNXRBZEKiMY6ZUkXL2+qFS1p5LWQo
 Zr01l/ZeNMS5RmrIMQpoHlxahlRyU3oKaEneiNwyEjffSLsJ/BByk8vgh3nimUFUw5qMXJKvWJJ
 tTr9dm+EaEpMlpVwYS7x8Uys9ZuUQ1eSp8Jz8MtH9oxNvBIHSHskPafLP3fDSGYEMIeFUhob1cI
 KovGzBB+t9uR1ZTJ6iCYWWKe2tCdjfGEUhy0UGlFe8ZGjTE74VnTG7H8xDpecxd3vfZms71wXNe
 9J90rSsg8vfxRGfrVrBhAMQ==
X-Received: by 2002:a05:600c:198b:b0:495:48d7:f178 with SMTP id
 5b1f17b1804b1-496b899db56mr63019595e9.11.1785101408799; 
 Sun, 26 Jul 2026 14:30:08 -0700 (PDT)
X-Received: by 2002:a05:600c:198b:b0:495:48d7:f178 with SMTP id
 5b1f17b1804b1-496b899db56mr63019255e9.11.1785101408202; 
 Sun, 26 Jul 2026 14:30:08 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-37-66.inter.net.il. [80.230.37.66])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4957b816ef8sm173906485e9.1.2026.07.26.14.30.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 26 Jul 2026 14:30:07 -0700 (PDT)
Date: Sun, 26 Jul 2026 17:30:05 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 =?utf-8?Q?Cl=C3=A9ment?= MATHIEU--DRIF <clement.mathieu--drif@bull.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Zhenzhong Duan <zhenzhong.duan@intel.com>,
 Jason Wang <jasowangio@gmail.com>, Yi Liu <yi.l.liu@intel.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 27/30] intel_iommu: Check address mask before using it in
 pasid-based iotlb invalidation
Message-ID: <ef9798ed9d1913010b42670dc6ff094d3cfea81e.1785101237.git.mst@redhat.com>
References: <cover.1785101237.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover.1785101237.git.mst@redhat.com>
X-Mailer: git-send-email 2.51.2.2891.g4157995a80.dirty
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -36
X-Spam_score: -3.7
X-Spam_bar: ---
X-Spam_report: (-3.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.58,
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

Prevent a buggy driver to execute malformed invalidation operations.

Add the same assert as in vtd_iotlb_page_invalidate.

Link: https://gitlab.com/qemu-project/qemu/-/work_items/3619
Fixes: 6ebe6cf2a066 ("intel_iommu: Process PASID-based iotlb invalidation")
Signed-off-by: Clement Mathieu--Drif <clement.mathieu--drif@bull.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Reviewed-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Message-ID: <20260724111424.376680-1-clement.mathieu--drif@bull.com>
---
 hw/i386/intel_iommu.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
index d1af7a3135..82c3c3b2c3 100644
--- a/hw/i386/intel_iommu.c
+++ b/hw/i386/intel_iommu.c
@@ -3021,6 +3021,8 @@ static void vtd_piotlb_page_invalidate(IntelIOMMUState *s, uint16_t domain_id,
 {
     VTDIOTLBPageInvInfo info;
 
+    assert(am <= VTD_MAMV);
+
     info.domain_id = domain_id;
     info.pasid = pasid;
     info.addr = addr;
@@ -3060,6 +3062,13 @@ static bool vtd_process_piotlb_desc(IntelIOMMUState *s,
 
     case VTD_INV_DESC_PIOTLB_PSI_IN_PASID:
         am = VTD_INV_DESC_PIOTLB_AM(inv_desc->val[1]);
+        if (am > VTD_MAMV) {
+            error_report_once("%s: invalid piotlb inv desc: hi=0x%"PRIx64
+                              ", lo=0x%"PRIx64" (am=%u > VTD_MAMV=%llu)",
+                              __func__, inv_desc->val[1], inv_desc->val[0],
+                              am, VTD_MAMV);
+            return false;
+        }
         addr = (hwaddr) VTD_INV_DESC_PIOTLB_ADDR(inv_desc->val[1]);
         vtd_piotlb_page_invalidate(s, domain_id, pasid, addr, am,
                                    VTD_INV_DESC_PIOTLB_IH(inv_desc));
-- 
MST


