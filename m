Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CAFE2C10F1A
	for <qemu-devel@archiver.kernel.org>; Wed,  8 May 2024 00:54:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s4VZJ-0003R1-Oy; Tue, 07 May 2024 20:54:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yaoxt.fnst@fujitsu.com>)
 id 1s4VZ1-0003F1-SF
 for qemu-devel@nongnu.org; Tue, 07 May 2024 20:53:45 -0400
Received: from esa5.hc1455-7.c3s2.iphmx.com ([68.232.139.130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yaoxt.fnst@fujitsu.com>)
 id 1s4VYz-0003KN-L3
 for qemu-devel@nongnu.org; Tue, 07 May 2024 20:53:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj2;
 t=1715129621; x=1746665621;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=Zl5gLii4NnwGLwqVkepmmSn5NlN9z7y1E/Dp0UH+HaM=;
 b=aMsLGh0N1fCz74TJXge8TwEYH3Nv4s1Hh0fgNXlgiIGEwf2dKjLZvIsa
 1/v/WRBQ8WhGQc3+33gzzfcS/efA+glPhGxjV00+Ux39KLDJUD1rnj4Qb
 PrF7rzQGv8hGo6oqzClH3F9IqhyOORNh6+l630+PuMvxaVxRaQe4u5yuJ
 ZKYcRu0Y5L3dyZEEaWZ08qd8tU5DnjZqUMufqGzrMswsUmm1qtcQGyv61
 h4fAVRnLn28XDp76MfYu+b/MnDWPnfTbX3VMbX7J/F56N1GhRz8fK/jjV
 +eGkk3sQfXfttCBtBjZXi+xOVRbJHJxpIIVOeRT9yOyC/dkPA07Zg6OkS Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,11066"; a="157021519"
X-IronPort-AV: E=Sophos;i="6.08,143,1712588400"; d="scan'208";a="157021519"
Received: from unknown (HELO oym-r4.gw.nic.fujitsu.com) ([210.162.30.92])
 by esa5.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 May 2024 09:53:35 +0900
Received: from oym-m2.gw.nic.fujitsu.com (oym-nat-oym-m2.gw.nic.fujitsu.com
 [192.168.87.59])
 by oym-r4.gw.nic.fujitsu.com (Postfix) with ESMTP id 8A00AD9DB9
 for <qemu-devel@nongnu.org>; Wed,  8 May 2024 09:53:33 +0900 (JST)
Received: from kws-ab4.gw.nic.fujitsu.com (kws-ab4.gw.nic.fujitsu.com
 [192.51.206.22])
 by oym-m2.gw.nic.fujitsu.com (Postfix) with ESMTP id B14CFBDCB0
 for <qemu-devel@nongnu.org>; Wed,  8 May 2024 09:53:32 +0900 (JST)
Received: from edo.cn.fujitsu.com (edo.cn.fujitsu.com [10.167.33.5])
 by kws-ab4.gw.nic.fujitsu.com (Postfix) with ESMTP id 45CE523EA7C
 for <qemu-devel@nongnu.org>; Wed,  8 May 2024 09:53:32 +0900 (JST)
Received: from localhost.localdomain (unknown [10.167.225.88])
 by edo.cn.fujitsu.com (Postfix) with ESMTP id 9BEF11A000B;
 Wed,  8 May 2024 08:53:31 +0800 (CST)
To: jonathan.cameron@huawei.com,
	fan.ni@samsung.com
Cc: qemu-devel@nongnu.org,
	Yao Xingtao <yaoxt.fnst@fujitsu.com>
Subject: [PATCH v3] mem/cxl_type3: support 3, 6, 12 and 16 interleave ways
Date: Tue,  7 May 2024 20:53:23 -0400
Message-Id: <20240508005323.28811-1-yaoxt.fnst@fujitsu.com>
X-Mailer: git-send-email 2.37.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-TM-AS-Product-Ver: IMSS-9.1.0.1417-9.0.0.1002-28368.003
X-TM-AS-User-Approved-Sender: Yes
X-TMASE-Version: IMSS-9.1.0.1417-9.0.1002-28368.003
X-TMASE-Result: 10--1.421000-10.000000
X-TMASE-MatchedRID: Ugxu9kqXWxKROBVNmXUDuMIkzTqL3E/Wm0H2L3kjQgrn3ZLCt3rRSSNM
 v5a0AeBD77BjzUhRJQ6Ekl9vR6Agi4KeFxulmNWzCKFDk1kJexL4qCLIu0mtIDoUdFbHYUawvwU
 evDt+uW5/XjpbSJS7a8uO56bqT71TobdjeDI8cBERW4LR41Fi8gK0ZgbTOeKUCgyP/UnUGw2sk5
 e3FzGIt6GvCFqoKSwTgDLqnrRlXrZ8nn9tnqel2MZW5ai5WKlyRPmeB2fP7cVXsITydO8Kq8yZM
 0/Lon4PsWTG2IJ/oZuJPdn4GCUY/9intcvwyXiQndQdE21ZNlhZGP6RUrd0AlCVnYtH3p+QEWW0
 bEJOTAVAdUD6vW8Z1mZAMQMIyK6zB8/x9JIi8hKhgLRzA45JPQ==
X-TMASE-SNAP-Result: 1.821001.0001-0-1-22:0,33:0,34:0-0
Received-SPF: pass client-ip=68.232.139.130;
 envelope-from=yaoxt.fnst@fujitsu.com; helo=esa5.hc1455-7.c3s2.iphmx.com
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

Since the kernel does not check the interleave capability, a
3-way, 6-way, 12-way or 16-way region can be create normally.

Applications can access the memory of 16-way region normally because
qemu can convert hpa to dpa correctly for the power of 2 interleave
ways, after kernel implementing the check, this kind of region will
not be created any more.

For non power of 2 interleave ways, applications could not access the
memory normally and may occur some unexpected behaviors, such as
segmentation fault.

So implements this feature is needed.

Link: https://lore.kernel.org/linux-cxl/3e84b919-7631-d1db-3e1d-33000f3f3868@fujitsu.com/
Signed-off-by: Yao Xingtao <yaoxt.fnst@fujitsu.com>
---
 hw/cxl/cxl-component-utils.c |  9 +++++++--
 hw/mem/cxl_type3.c           | 15 +++++++++++----
 2 files changed, 18 insertions(+), 6 deletions(-)

diff --git a/hw/cxl/cxl-component-utils.c b/hw/cxl/cxl-component-utils.c
index cd116c0401..473895948b 100644
--- a/hw/cxl/cxl-component-utils.c
+++ b/hw/cxl/cxl-component-utils.c
@@ -243,8 +243,13 @@ static void hdm_init_common(uint32_t *reg_state, uint32_t *write_msk,
     ARRAY_FIELD_DP32(reg_state, CXL_HDM_DECODER_CAPABILITY, INTERLEAVE_4K, 1);
     ARRAY_FIELD_DP32(reg_state, CXL_HDM_DECODER_CAPABILITY,
                      POISON_ON_ERR_CAP, 0);
-    ARRAY_FIELD_DP32(reg_state, CXL_HDM_DECODER_CAPABILITY, 3_6_12_WAY, 0);
-    ARRAY_FIELD_DP32(reg_state, CXL_HDM_DECODER_CAPABILITY, 16_WAY, 0);
+    if (type == CXL2_TYPE3_DEVICE) {
+        ARRAY_FIELD_DP32(reg_state, CXL_HDM_DECODER_CAPABILITY, 3_6_12_WAY, 1);
+        ARRAY_FIELD_DP32(reg_state, CXL_HDM_DECODER_CAPABILITY, 16_WAY, 1);
+    } else {
+        ARRAY_FIELD_DP32(reg_state, CXL_HDM_DECODER_CAPABILITY, 3_6_12_WAY, 0);
+        ARRAY_FIELD_DP32(reg_state, CXL_HDM_DECODER_CAPABILITY, 16_WAY, 0);
+    }
     ARRAY_FIELD_DP32(reg_state, CXL_HDM_DECODER_CAPABILITY, UIO, 0);
     ARRAY_FIELD_DP32(reg_state, CXL_HDM_DECODER_CAPABILITY,
                      UIO_DECODER_COUNT, 0);
diff --git a/hw/mem/cxl_type3.c b/hw/mem/cxl_type3.c
index 3e42490b6c..b755318838 100644
--- a/hw/mem/cxl_type3.c
+++ b/hw/mem/cxl_type3.c
@@ -804,10 +804,17 @@ static bool cxl_type3_dpa(CXLType3Dev *ct3d, hwaddr host_addr, uint64_t *dpa)
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


