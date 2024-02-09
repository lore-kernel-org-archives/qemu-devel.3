Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 180F8C48297
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Feb 2024 13:59:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rYROM-0003HC-BD; Fri, 09 Feb 2024 08:58:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ruansy.fnst@fujitsu.com>)
 id 1rYPSi-0003FY-GV
 for qemu-devel@nongnu.org; Fri, 09 Feb 2024 06:54:32 -0500
Received: from esa7.hc1455-7.c3s2.iphmx.com ([139.138.61.252])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ruansy.fnst@fujitsu.com>)
 id 1rYPSc-0001eC-MS
 for qemu-devel@nongnu.org; Fri, 09 Feb 2024 06:54:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj2;
 t=1707479666; x=1739015666;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=MnCVUOG7QYKmV55TxRoyxRi+hfSu7P6Gu8B4tvl7vLQ=;
 b=FNdx+C7lQOEV2uKgcTNXYgI9dDTkzhx+TodioUYSvbURhm5VWt9CQ7Yy
 97fK5K8JE+FAx2aw8YMOpiogz4PCsWxxifWI34qfVaVk4zls/S3gESmtt
 jRmpbIwDKwyA3KlI0KxwWdzXEd7QIpHaXyQKlkvYOLe3moRKeOmXlGOOF
 DVCw5fBzYpSIktQQYiSNpj8Fno1PpVe3vFQDgL6sPwbxqOQ4jO3q8dZ8e
 5HZj4VZfVc9dSvnrtSSUxIHjMtJKOkhGnJRjKQnV8ShesHAoXPRxhEoP6
 wB9tCNcuZprqON+HPV9E+cDQ08JNw/S0yQatw9DCoYv2bVCfSfkqD4NYr Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10978"; a="127715629"
X-IronPort-AV: E=Sophos;i="6.05,256,1701097200"; d="scan'208";a="127715629"
Received: from unknown (HELO yto-r3.gw.nic.fujitsu.com) ([218.44.52.219])
 by esa7.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Feb 2024 20:54:22 +0900
Received: from yto-m3.gw.nic.fujitsu.com (yto-nat-yto-m3.gw.nic.fujitsu.com
 [192.168.83.66])
 by yto-r3.gw.nic.fujitsu.com (Postfix) with ESMTP id 77F9B2382C
 for <qemu-devel@nongnu.org>; Fri,  9 Feb 2024 20:54:20 +0900 (JST)
Received: from kws-ab3.gw.nic.fujitsu.com (kws-ab3.gw.nic.fujitsu.com
 [192.51.206.21])
 by yto-m3.gw.nic.fujitsu.com (Postfix) with ESMTP id BCA9BD20B6
 for <qemu-devel@nongnu.org>; Fri,  9 Feb 2024 20:54:19 +0900 (JST)
Received: from edo.cn.fujitsu.com (edo.cn.fujitsu.com [10.167.33.5])
 by kws-ab3.gw.nic.fujitsu.com (Postfix) with ESMTP id 3E44920097CF0
 for <qemu-devel@nongnu.org>; Fri,  9 Feb 2024 20:54:19 +0900 (JST)
Received: from irides.g08.fujitsu.local (unknown [10.167.226.114])
 by edo.cn.fujitsu.com (Postfix) with ESMTP id C63EB1A006A;
 Fri,  9 Feb 2024 19:54:18 +0800 (CST)
To: qemu-devel@nongnu.org,
	linux-cxl@vger.kernel.org
Cc: Jonathan.Cameron@huawei.com,
	dan.j.williams@intel.com
Subject: [RFC PATCH 1/5] cxl/core: correct length of DPA field masks
Date: Fri,  9 Feb 2024 19:54:13 +0800
Message-Id: <20240209115417.724638-4-ruansy.fnst@fujitsu.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240209115417.724638-1-ruansy.fnst@fujitsu.com>
References: <20240209115417.724638-1-ruansy.fnst@fujitsu.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-TM-AS-Product-Ver: IMSS-9.1.0.1417-9.0.0.1002-28180.007
X-TM-AS-User-Approved-Sender: Yes
X-TMASE-Version: IMSS-9.1.0.1417-9.0.1002-28180.007
X-TMASE-Result: 10--1.506000-10.000000
X-TMASE-MatchedRID: rMrifpT/n7G1UOlz1sLXchF4zyLyne+AVBDQSDMig9HHkH7uosEn7Hj6
 +0kG6ijw4vM1YF6AJba/IVneJQLBZQtuKBGekqUpnH7sbImOEBTlWfEpOEu2d1ro1J0HyADyuN2
 ViA1o+X1p8m481R42eL3i+dgqnYmih+XoUibFwoJARN3eHcDWfdeLTJRd5T2oJe7un0C4hwObDR
 BqS2n66yzP5xAyz9Oenvkw4sh/+PcMX5CwH5DTUmgGZNLBHGNe
X-TMASE-SNAP-Result: 1.821001.0001-0-1-22:0,33:0,34:0-0
Received-SPF: pass client-ip=139.138.61.252;
 envelope-from=ruansy.fnst@fujitsu.com; helo=esa7.hc1455-7.c3s2.iphmx.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Fri, 09 Feb 2024 08:57:58 -0500
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
Reply-to:  Shiyang Ruan <ruansy.fnst@fujitsu.com>
From:  Shiyang Ruan via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

The length of Physical Address in General Media Event Record/DRAM Event
Record is 64-bit, so the field mask should be defined as such length.

Signed-off-by: Shiyang Ruan <ruansy.fnst@fujitsu.com>
---
 drivers/cxl/core/trace.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/cxl/core/trace.h b/drivers/cxl/core/trace.h
index 89445435303a..388a87d972c2 100644
--- a/drivers/cxl/core/trace.h
+++ b/drivers/cxl/core/trace.h
@@ -253,11 +253,11 @@ TRACE_EVENT(cxl_generic_event,
  * DRAM Event Record
  * CXL rev 3.0 section 8.2.9.2.1.2; Table 8-44
  */
-#define CXL_DPA_FLAGS_MASK			0x3F
+#define CXL_DPA_FLAGS_MASK			0x3FULL
 #define CXL_DPA_MASK				(~CXL_DPA_FLAGS_MASK)
 
-#define CXL_DPA_VOLATILE			BIT(0)
-#define CXL_DPA_NOT_REPAIRABLE			BIT(1)
+#define CXL_DPA_VOLATILE			BIT_ULL(0)
+#define CXL_DPA_NOT_REPAIRABLE			BIT_ULL(1)
 #define show_dpa_flags(flags)	__print_flags(flags, "|",		   \
 	{ CXL_DPA_VOLATILE,			"VOLATILE"		}, \
 	{ CXL_DPA_NOT_REPAIRABLE,		"NOT_REPAIRABLE"	}  \
-- 
2.34.1


