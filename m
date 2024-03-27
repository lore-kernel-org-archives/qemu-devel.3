Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0751C54E67
	for <qemu-devel@archiver.kernel.org>; Wed, 27 Mar 2024 01:50:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rpIPb-0001Dy-MR; Tue, 26 Mar 2024 21:49:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yaoxt.fnst@fujitsu.com>)
 id 1rpIPZ-0001C8-Vl
 for qemu-devel@nongnu.org; Tue, 26 Mar 2024 21:49:06 -0400
Received: from esa8.hc1455-7.c3s2.iphmx.com ([139.138.61.253])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yaoxt.fnst@fujitsu.com>)
 id 1rpIPX-0007cW-Kg
 for qemu-devel@nongnu.org; Tue, 26 Mar 2024 21:49:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj2;
 t=1711504143; x=1743040143;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=s0o8X7fjTNmD0jtLGMsQhDQj/68MmQ2vnCIgb63wpjc=;
 b=sLyD+Xlu0u171iyHtX8QGjcZ1OxN8kZZcpZAjAuspahWF+NdnA7TFthW
 YPhe9rA1s1kuudfahJdCBQRJUNbGUBWW6e20KG86uqYPBKTEjFdiL0hje
 DnbUWilkCk70wZSp38i9TKwtWHs7fs6KoZeMpAGOxPUfChRTKbfsrUgVJ
 aRKCl9+f7vJQ3xGR7aJorqfyyV927HDIihnCO++65SUFj2y9lm7qZRDeA
 EoFV6SJl5bXkTLst1ZzofMjRfwCClxF4DQAX3GKcKLsC1aKf7dL/llcZN
 RYm+s+YEm2WarWOm270JVrcxDHHCfQi/70QDGBZno9rkAr5U0dwrGRWa7 g==;
X-IronPort-AV: E=McAfee;i="6600,9927,11025"; a="141447538"
X-IronPort-AV: E=Sophos;i="6.07,157,1708354800"; d="scan'208";a="141447538"
Received: from unknown (HELO yto-r3.gw.nic.fujitsu.com) ([218.44.52.219])
 by esa8.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Mar 2024 10:48:58 +0900
Received: from yto-m2.gw.nic.fujitsu.com (yto-nat-yto-m2.gw.nic.fujitsu.com
 [192.168.83.65])
 by yto-r3.gw.nic.fujitsu.com (Postfix) with ESMTP id 0DAD1E9667
 for <qemu-devel@nongnu.org>; Wed, 27 Mar 2024 10:48:57 +0900 (JST)
Received: from kws-ab4.gw.nic.fujitsu.com (kws-ab4.gw.nic.fujitsu.com
 [192.51.206.22])
 by yto-m2.gw.nic.fujitsu.com (Postfix) with ESMTP id 464202FCD8
 for <qemu-devel@nongnu.org>; Wed, 27 Mar 2024 10:48:56 +0900 (JST)
Received: from edo.cn.fujitsu.com (edo.cn.fujitsu.com [10.167.33.5])
 by kws-ab4.gw.nic.fujitsu.com (Postfix) with ESMTP id C1443E477F
 for <qemu-devel@nongnu.org>; Wed, 27 Mar 2024 10:48:55 +0900 (JST)
Received: from localhost.localdomain (unknown [10.167.225.88])
 by edo.cn.fujitsu.com (Postfix) with ESMTP id 1C56F1A006A;
 Wed, 27 Mar 2024 09:48:55 +0800 (CST)
To: jonathan.cameron@huawei.com,
	fan.ni@samsung.com
Cc: qemu-devel@nongnu.org, caoqq@fujitsu.com,
 Yao Xingtao <yaoxt.fnst@fujitsu.com>
Subject: [PATCH] mem/cxl_type3: fix hpa to dpa logic
Date: Tue, 26 Mar 2024 21:46:53 -0400
Message-Id: <20240327014653.26623-1-yaoxt.fnst@fujitsu.com>
X-Mailer: git-send-email 2.37.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-TM-AS-Product-Ver: IMSS-9.1.0.1417-9.0.0.1002-28276.004
X-TM-AS-User-Approved-Sender: Yes
X-TMASE-Version: IMSS-9.1.0.1417-9.0.1002-28276.004
X-TMASE-Result: 10--5.770800-10.000000
X-TMASE-MatchedRID: jaDo7zRnnqv1FjL5pOozBZjnsVPBNMvRSdIdCi8Ba4BS0AMoK8LL122H
 WvR90BF1AgbxNXiHGCrmXDJ/lmD292FqPXSLpNdArMZ+BqQt2NrBOVz0Jwcxl6vCrG0TnfVU2d8
 mtRIRsUNUj8yB4G09vCgwkKeWenB43wMRFjEYq7yeAiCmPx4NwGmRqNBHmBve8JnRnNG2x81JKW
 4mDlJsMSAHAopEd76vqPNMeBJRJB/XmLnbMMUB+dZ1ux/9VlJ1AvWh//MRLJShBFoQLCG/3g==
X-TMASE-SNAP-Result: 1.821001.0001-0-1-22:0,33:0,34:0-0
Received-SPF: pass client-ip=139.138.61.253;
 envelope-from=yaoxt.fnst@fujitsu.com; helo=esa8.hc1455-7.c3s2.iphmx.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Reply-to:  Yao Xingtao <yaoxt.fnst@fujitsu.com>
From:  Yao Xingtao via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

In 3, 6, 12 interleave ways, we could not access cxl memory properly,
and when the process is running on it, a 'segmentation fault' error will
occur.

According to the CXL specification '8.2.4.20.13 Decoder Protection',
there are two branches to convert HPA to DPA:
b1: Decoder[m].IW < 8 (for 1, 2, 4, 8, 16 interleave ways)
b2: Decoder[m].IW >= 8 (for 3, 6, 12 interleave ways)

but only b1 has been implemented.

To solve this issue, we should implement b2:
  DPAOffset[51:IG+8]=HPAOffset[51:IG+IW] / 3
  DPAOffset[IG+7:0]=HPAOffset[IG+7:0]
  DPA=DPAOffset + Decoder[n].DPABase

Links: https://lore.kernel.org/linux-cxl/3e84b919-7631-d1db-3e1d-33000f3f3868@fujitsu.com/
Signed-off-by: Yao Xingtao <yaoxt.fnst@fujitsu.com>
---
 hw/mem/cxl_type3.c | 15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

diff --git a/hw/mem/cxl_type3.c b/hw/mem/cxl_type3.c
index b0a7e9f11b..2c1218fb12 100644
--- a/hw/mem/cxl_type3.c
+++ b/hw/mem/cxl_type3.c
@@ -805,10 +805,17 @@ static bool cxl_type3_dpa(CXLType3Dev *ct3d, hwaddr host_addr, uint64_t *dpa)
             continue;
         }
 
-        *dpa = dpa_base +
-            ((MAKE_64BIT_MASK(0, 8 + ig) & hpa_offset) |
-             ((MAKE_64BIT_MASK(8 + ig + iw, 64 - 8 - ig - iw) & hpa_offset)
-              >> iw));
+        if (iw < 8) {
+            *dpa = dpa_base +
+                ((MAKE_64BIT_MASK(0, 8 + ig) & hpa_offset) |
+                 ((MAKE_64BIT_MASK(8 + ig + iw, 64 - 8 - ig - iw) & hpa_offset)
+                  >> iw));
+        } else {
+            *dpa = dpa_base +
+                ((MAKE_64BIT_MASK(0, 8 + ig) & hpa_offset) |
+                 ((((MAKE_64BIT_MASK(ig + iw, 64 - ig - iw) & hpa_offset)
+                   >> (ig + iw)) / 3) << (ig + 8)));
+        }
 
         return true;
     }
-- 
2.37.3


