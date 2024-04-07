Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A50C6CD1284
	for <qemu-devel@archiver.kernel.org>; Sun,  7 Apr 2024 03:08:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rtIsp-0008NB-N4; Sat, 06 Apr 2024 23:07:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yaoxt.fnst@fujitsu.com>)
 id 1rtIsn-0008N0-9i
 for qemu-devel@nongnu.org; Sat, 06 Apr 2024 23:07:49 -0400
Received: from esa3.hc1455-7.c3s2.iphmx.com ([207.54.90.49])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yaoxt.fnst@fujitsu.com>)
 id 1rtIsk-0006Ev-LU
 for qemu-devel@nongnu.org; Sat, 06 Apr 2024 23:07:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj2;
 t=1712459264; x=1743995264;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=TQOrXxVannumsVoHDhFB7VYp5NHkQwkKSHhgNKqzLNI=;
 b=UFHkjlnF/eXkMk3nSzRfUzP5DL3NKFYs4LCgksDnmhHbazu4Ow1DBhIj
 zGQkXiO37k4/Gf7Zttax1hwCKCBBvYQI3x2mFKZSR5247/liwXgAPlfzu
 la2GJX0MFrAz1u77WaNGABlbm5/SXnIR+MpfhE3cEQA+Tsht5Xq5rj30A
 2mS+Zjkb1ldu10bof9Ry7ZzY/rzuEiHiokB2I1BJlHZQB15wDvQ8UdqFF
 7uIOCkrkGbC+Mx+R+i0Ie7UbVJo0YUCT5WA4wurmNYZUL98Gx9Emed2eZ
 CbBivA04bgofyselUx79RNB+dcKV+qEBYmOHnWYsDg7fNToQjNtR9h7d2 g==;
X-IronPort-AV: E=McAfee;i="6600,9927,11036"; a="154790421"
X-IronPort-AV: E=Sophos;i="6.07,184,1708354800"; d="scan'208";a="154790421"
Received: from unknown (HELO yto-r2.gw.nic.fujitsu.com) ([218.44.52.218])
 by esa3.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Apr 2024 12:07:39 +0900
Received: from yto-m1.gw.nic.fujitsu.com (yto-nat-yto-m1.gw.nic.fujitsu.com
 [192.168.83.64])
 by yto-r2.gw.nic.fujitsu.com (Postfix) with ESMTP id 099022A1C3B
 for <qemu-devel@nongnu.org>; Sun,  7 Apr 2024 12:07:39 +0900 (JST)
Received: from kws-ab3.gw.nic.fujitsu.com (kws-ab3.gw.nic.fujitsu.com
 [192.51.206.21])
 by yto-m1.gw.nic.fujitsu.com (Postfix) with ESMTP id 4E09ACFBB4
 for <qemu-devel@nongnu.org>; Sun,  7 Apr 2024 12:07:38 +0900 (JST)
Received: from edo.cn.fujitsu.com (edo.cn.fujitsu.com [10.167.33.5])
 by kws-ab3.gw.nic.fujitsu.com (Postfix) with ESMTP id C3885200501B3
 for <qemu-devel@nongnu.org>; Sun,  7 Apr 2024 12:07:37 +0900 (JST)
Received: from localhost.localdomain (unknown [10.167.225.88])
 by edo.cn.fujitsu.com (Postfix) with ESMTP id 274F41A000C;
 Sun,  7 Apr 2024 11:07:37 +0800 (CST)
To: jonathan.cameron@huawei.com,
	fan.ni@samsung.com
Cc: qemu-devel@nongnu.org,
	Yao Xingtao <yaoxt.fnst@fujitsu.com>
Subject: [PATCH v2] mem/cxl_type3: support 3, 6, 12 and 16 interleave ways
Date: Sat,  6 Apr 2024 23:06:42 -0400
Message-Id: <20240407030642.24861-1-yaoxt.fnst@fujitsu.com>
X-Mailer: git-send-email 2.37.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-TM-AS-Product-Ver: IMSS-9.1.0.1417-9.0.0.1002-28302.004
X-TM-AS-User-Approved-Sender: Yes
X-TMASE-Version: IMSS-9.1.0.1417-9.0.1002-28302.004
X-TMASE-Result: 10-1.243000-10.000000
X-TMASE-MatchedRID: 6atTV52QVSeROBVNmXUDuMIkzTqL3E/Wm0H2L3kjQgrn3ZLCt3rRSSNM
 v5a0AeBD77BjzUhRJQ6Ekl9vR6Agi4KeFxulmNWzCKFDk1kJexL4qCLIu0mtIMC5DTEMxpeQfiq
 1gj2xET8qqtDuUtwyfGuaZ0FmNdhIehY/DCk+INEdahq+rGDn/1K6+0HOVoSoLEzDQUyQGVmDhN
 38ME2RU7sWFv4pmSytnagtny7ZPcQfE8yM4pjsDwtuKBGekqUpnH7sbImOEBSc3i3mRmT5CmO6c
 nkZhdEeMhPmyJ78bM8iUTw6fgXIfuyxz+RSU6YXLwR4ex5wFyMy4qGi+Sd41OJEorgIJZ0Eod57
 7dl+JEmbDRBqS2n66yzP5xAyz9Oenvkw4sh/+PcMX5CwH5DTUmgGZNLBHGNe
X-TMASE-SNAP-Result: 1.821001.0001-0-1-22:0,33:0,34:0-0
Received-SPF: pass client-ip=207.54.90.49; envelope-from=yaoxt.fnst@fujitsu.com;
 helo=esa3.hc1455-7.c3s2.iphmx.com
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
 hw/mem/cxl_type3.c | 18 ++++++++++++++----
 1 file changed, 14 insertions(+), 4 deletions(-)

diff --git a/hw/mem/cxl_type3.c b/hw/mem/cxl_type3.c
index b0a7e9f11b..d6ef784e96 100644
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
@@ -906,6 +913,9 @@ static void ct3d_reset(DeviceState *dev)
     uint32_t *write_msk = ct3d->cxl_cstate.crb.cache_mem_regs_write_mask;
 
     cxl_component_register_init_common(reg_state, write_msk, CXL2_TYPE3_DEVICE);
+    ARRAY_FIELD_DP32(reg_state, CXL_HDM_DECODER_CAPABILITY, 3_6_12_WAY, 1);
+    ARRAY_FIELD_DP32(reg_state, CXL_HDM_DECODER_CAPABILITY, 16_WAY, 1);
+
     cxl_device_register_init_t3(ct3d);
 
     /*
-- 
2.37.3


