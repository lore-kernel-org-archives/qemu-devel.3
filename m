Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2FA0DC53209
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jul 2026 19:21:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1woQt4-0001i5-Mt; Mon, 27 Jul 2026 15:21:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1woQsT-0000j4-3S
 for qemu-devel@nongnu.org; Mon, 27 Jul 2026 15:20:41 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1woQsR-0000fI-5Y
 for qemu-devel@nongnu.org; Mon, 27 Jul 2026 15:20:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1785180038;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0MxmzfN26C9n4Ays3a2bCnXLUUqqhyEZkzXAkW/X4jw=;
 b=HgwBKSlmoxv4UtKWg2JbAVcnGHeoZApSFRfGJideSciMYs1Ya2YZdTJkekFnSReqJY+drn
 HkSk9wR1+Aao5TpRe/SH47Ab8xihr4e0PU7sktICeeivSDgbKXbpBA7jdPPUsmnzoItn1X
 qBsa2lfFiYfWuEUszveurgnj5L3fGp0=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-311-qDStU4weNZy075WgB2o-TA-1; Mon, 27 Jul 2026 15:20:36 -0400
X-MC-Unique: qDStU4weNZy075WgB2o-TA-1
X-Mimecast-MFC-AGG-ID: qDStU4weNZy075WgB2o-TA_1785180036
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-47f6d70223dso1995948f8f.1
 for <qemu-devel@nongnu.org>; Mon, 27 Jul 2026 12:20:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1785180036; x=1785784836; darn=nongnu.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :content-type:mime-version:references:message-id:subject:cc:to:from
 :date:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=0MxmzfN26C9n4Ays3a2bCnXLUUqqhyEZkzXAkW/X4jw=;
 b=Lvn6MGnZmH7W04TBlh+tVyhhk2xNdEwWNe/9hCTRAn0IDtvoF25Bd6TLMLFEqhKKZv
 46f39CxakpQDh+hInYOYg586hpPqfM0nIa39a+KBV6/5wV3XqfyyehtU/qfOnD/ih4z6
 yvweUBBBBuwN6tzl4S1Yxeum+U/oD0qWCqCg8QJArT4RxnvDTCQyR8Hg7A+4xsqdtsxX
 KlVZGoQjke30Z2NHDbQkwW2JXZTVcYIYl7iU6n/CrB8L5VTf1w8EQJ0i86+HosIX00dM
 dl4cJBLWwwGK3wvwXiLRqJsQ9GgpvtyycSbDDphWa87/xMvqWHLIRlEmO8yyJUlqNXBh
 0yYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785180036; x=1785784836;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :content-type:mime-version:references:message-id:subject:cc:to:from
 :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=0MxmzfN26C9n4Ays3a2bCnXLUUqqhyEZkzXAkW/X4jw=;
 b=gAyWFGrU43tFUeMHbYWwYtdyqsxJOv6rGJQTcxzPScFebB1w6aAzZCGoIoJivFJWP3
 WM6jLgR+CpHfi8cNeSpmawcnw9emEXR2tUAfHaqrptK6JEXuyu7m28V5mjUPVvNvhzzK
 vgYBJLoXByYyR5mgdu+m2cz7rDCx+YeMWJQJKos1BipkNGdiouB527XXNpTQpsa6hrrT
 OQY9UO4rtEJtY8SeIRCbUwqzdJKJlgvUAfVIw/DWNOrm9nOH3iX7kOTlE+jnMcSyQqcF
 FKXTq2zwNS6HcY2mcILDWPTkn8kMhqntFIr+cQpk8GTZBZa7oSUXeJ6bllmKBOjiayIW
 cueA==
X-Gm-Message-State: AOJu0Yz8x9b7KTWhvCXCs5a05ZgW3SGidlbSwHJ1UxPqnaSs8vf/6L1E
 uQUQOhT0E9lv/gP+skYpSKc85TEaPhuWNVp7zP5o8R86aMmFW2sWiUbuAHvVETdtQ5CKyu9J6PL
 S0wQ6ALsfZVk7w09WUACdiiB5/5V8fiIbJ67+Y01KMSM+XQCG/BTzZTCSAJkd4fjzCt598fnMKI
 dVwaIkJ0Mh0C73cnaRRueQ+RsQRqIVcxvgQA==
X-Gm-Gg: AR+sD13wmsFY0GGSeuYAN859iQgxT0IgpZvxSZmvbclhfHbI3sZTOjf0gW29v3EfsG5
 a5l15qrRSVUS/SV16qLNZ+xXRbRw93xYwGs+NYiOTarO0JKZCF82gi7rxEn8JDEmgRVJRuEPU5t
 IQf+c09UjNsoCRgACr0JAklWSqLlr9h5ZP6sju1j2poVLq0lJ1xCW+0YtBHnUFofHnLWYusGOdB
 rvwDJcO8VgwEpDMKjO+sIfROWXZPRRmDaAYFTIl5JtYPTyazf18Z1pP8dZFmzHd/KzEG2aMGTfX
 G73L8lOuRXWHlGTfXhPayPlPVep82UiJCzCqcmNg3JNP+8bp/AajjppPAqdz1x9lla+uPsGl2fx
 AoMW3Gjuyx4jnpK6vXPZVfg==
X-Received: by 2002:a5d:5888:0:b0:47f:9cc2:ddd2 with SMTP id
 ffacd0b85a97d-47fafa88458mr441437f8f.35.1785180035504; 
 Mon, 27 Jul 2026 12:20:35 -0700 (PDT)
X-Received: by 2002:a5d:5888:0:b0:47f:9cc2:ddd2 with SMTP id
 ffacd0b85a97d-47fafa88458mr441395f8f.35.1785180034799; 
 Mon, 27 Jul 2026 12:20:34 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-28-14.inter.net.il. [80.230.28.14])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47f85bb5127sm48274196f8f.10.2026.07.27.12.20.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 Jul 2026 12:20:34 -0700 (PDT)
Date: Mon, 27 Jul 2026 15:20:32 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 =?utf-8?Q?Cl=C3=A9ment?= MATHIEU--DRIF <clement.mathieu--drif@bull.com>,
 huntr bubble <bubblehuntr@gmail.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Zhenzhong Duan <zhenzhong.duan@intel.com>,
 Jason Wang <jasowangio@gmail.com>, Yi Liu <yi.l.liu@intel.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL v2 26/30] intel_iommu: Check address mask before using it in
 pasid-based iotlb invalidation
Message-ID: <0691bb257a7cbfd62127208b49988705bfa2dfe8.1785179875.git.mst@redhat.com>
References: <cover.1785179875.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover.1785179875.git.mst@redhat.com>
X-Mailer: git-send-email 2.51.2.2891.g4157995a80.dirty
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -36
X-Spam_score: -3.7
X-Spam_bar: ---
X-Spam_report: (-3.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.58,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_PASS=-0.001,
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

From: Clément MATHIEU--DRIF <clement.mathieu--drif@bull.com>

Prevent a buggy driver to execute malformed invalidation operations.

Add the same assert as in vtd_iotlb_page_invalidate.

Link: https://gitlab.com/qemu-project/qemu/-/work_items/3619
Fixes: 6ebe6cf2a066 ("intel_iommu: Process PASID-based iotlb invalidation")
Reported-by: huntr bubble <bubblehuntr@gmail.com>
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


