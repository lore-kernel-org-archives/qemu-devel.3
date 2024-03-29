Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C438CCD1283
	for <qemu-devel@archiver.kernel.org>; Fri, 29 Mar 2024 06:37:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rq5qr-0004Yf-KS; Fri, 29 Mar 2024 02:36:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ruansy.fnst@fujitsu.com>)
 id 1rq5qk-0004Va-Qp
 for qemu-devel@nongnu.org; Fri, 29 Mar 2024 02:36:26 -0400
Received: from esa2.hc1455-7.c3s2.iphmx.com ([207.54.90.48])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ruansy.fnst@fujitsu.com>)
 id 1rq5qh-0002VX-TK
 for qemu-devel@nongnu.org; Fri, 29 Mar 2024 02:36:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj2;
 t=1711694183; x=1743230183;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=bCrcdq4lNI8kIJNZkx/SfFaA95id3/KBVLHFuh8UmNU=;
 b=NaZD9niW6exL69BYWNvbL2hUoZ9qHvx2HT1SpXlz8kXicJY6lEMS0XcR
 oELsM4iSicnADNzGZvyPKbUgXdzWh/PF2/0g+ZhNbRre7Ma1hE5XK9A5g
 LTPkBN90MyJvU1fmYlRzPWD8sGOGFRNeWMRPgtQo+LVmJHV3rZgFrhyD0
 TDw5bzy1G81ehjHcPVoszxvdR7DUpjDXBvWMIOps6EKXB8BguUlKqT/v0
 p7rM7dGt3xBSfMuut/UbLbwVOI1+koxhF9un1r/NpVwgr3mMpgrHH2aAM
 aUqSJYku0j7MFVcFsREHrv7x3qaT74pnwKYiLQGv5Sxt4EQJcwXNSCsO9 A==;
X-IronPort-AV: E=McAfee;i="6600,9927,11027"; a="153769248"
X-IronPort-AV: E=Sophos;i="6.07,164,1708354800"; d="scan'208";a="153769248"
Received: from unknown (HELO yto-r2.gw.nic.fujitsu.com) ([218.44.52.218])
 by esa2.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 Mar 2024 15:36:20 +0900
Received: from yto-m3.gw.nic.fujitsu.com (yto-nat-yto-m3.gw.nic.fujitsu.com
 [192.168.83.66])
 by yto-r2.gw.nic.fujitsu.com (Postfix) with ESMTP id 23A1EC680C
 for <qemu-devel@nongnu.org>; Fri, 29 Mar 2024 15:36:18 +0900 (JST)
Received: from kws-ab4.gw.nic.fujitsu.com (kws-ab4.gw.nic.fujitsu.com
 [192.51.206.22])
 by yto-m3.gw.nic.fujitsu.com (Postfix) with ESMTP id 5DD50C7261
 for <qemu-devel@nongnu.org>; Fri, 29 Mar 2024 15:36:17 +0900 (JST)
Received: from edo.cn.fujitsu.com (edo.cn.fujitsu.com [10.167.33.5])
 by kws-ab4.gw.nic.fujitsu.com (Postfix) with ESMTP id E64C6224612
 for <qemu-devel@nongnu.org>; Fri, 29 Mar 2024 15:36:16 +0900 (JST)
Received: from irides.g08.fujitsu.local (unknown [10.167.226.114])
 by edo.cn.fujitsu.com (Postfix) with ESMTP id 783B21A006A;
 Fri, 29 Mar 2024 14:36:16 +0800 (CST)
To: qemu-devel@nongnu.org,
	linux-cxl@vger.kernel.org
Cc: Jonathan.Cameron@huawei.com, dan.j.williams@intel.com, dave@stgolabs.net,
 ira.weiny@intel.com
Subject: [RFC PATCH v2 5/6] cxl: add definition for transaction types
Date: Fri, 29 Mar 2024 14:36:13 +0800
Message-Id: <20240329063614.362763-6-ruansy.fnst@fujitsu.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240329063614.362763-1-ruansy.fnst@fujitsu.com>
References: <20240329063614.362763-1-ruansy.fnst@fujitsu.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-TM-AS-Product-Ver: IMSS-9.1.0.1417-9.0.0.1002-28282.003
X-TM-AS-User-Approved-Sender: Yes
X-TMASE-Version: IMSS-9.1.0.1417-9.0.1002-28282.003
X-TMASE-Result: 10--4.520000-10.000000
X-TMASE-MatchedRID: NuUGwdOZh4ZkQckJEC3Q2tyBRU/cKn69F4r8H5YrEqxOeMm3G6m0Tb8F
 Hrw7frluf146W0iUu2tR9er5wo4xLchblrt58TvtqdwbW9Wx9tAv5vY1YvMqbuUlKuNFfcJqo8W
 MkQWv6iV3LAytsQR4e42j49Ftap9ExlblqLlYqXJt4l4q/wnikovCfpj71RK4UrGm7aSNDOJYJI
 xPFhImJcZoZKsx29ZV9DCWgDRvWseCgKQPezcuADwdpcMIVCZT+OYGlmIZze4RZbRsQk5MBUB1Q
 Pq9bxnWZkAxAwjIrrMHz/H0kiLyEqGAtHMDjkk9
X-TMASE-SNAP-Result: 1.821001.0001-0-1-22:0,33:0,34:0-0
Received-SPF: pass client-ip=207.54.90.48;
 envelope-from=ruansy.fnst@fujitsu.com; helo=esa2.hc1455-7.c3s2.iphmx.com
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
Reply-to:  Shiyang Ruan <ruansy.fnst@fujitsu.com>
From:  Shiyang Ruan via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

The transaction types are defined in General Media Event Record/DRAM Event
per CXL rev 3.0 Section 8.2.9.2.1.1; Table 8-43 and
Section 8.2.9.2.1.2; Table 8-44.  Add them for Event Record handler use.

Signed-off-by: Shiyang Ruan <ruansy.fnst@fujitsu.com>
---
 include/linux/cxl-event.h | 17 +++++++++++++++--
 1 file changed, 15 insertions(+), 2 deletions(-)

diff --git a/include/linux/cxl-event.h b/include/linux/cxl-event.h
index 03fa6d50d46f..0a50754fc330 100644
--- a/include/linux/cxl-event.h
+++ b/include/linux/cxl-event.h
@@ -23,6 +23,19 @@ struct cxl_event_generic {
 	u8 data[CXL_EVENT_RECORD_DATA_LENGTH];
 } __packed;
 
+/*
+ * CXL rev 3.0 Section 8.2.9.2.1.1; Table 8-43
+ */
+enum cxl_event_transaction_type {
+	CXL_EVENT_TRANSACTION_UNKNOWN = 0X00,
+	CXL_EVENT_TRANSACTION_READ,
+	CXL_EVENT_TRANSACTION_WRITE,
+	CXL_EVENT_TRANSACTION_SCAN_MEDIA,
+	CXL_EVENT_TRANSACTION_INJECT_POISON,
+	CXL_EVENT_TRANSACTION_MEDIA_SCRUB,
+	CXL_EVENT_TRANSACTION_MEDIA_MANAGEMENT,
+};
+
 /*
  * General Media Event Record
  * CXL rev 3.0 Section 8.2.9.2.1.1; Table 8-43
@@ -33,7 +46,7 @@ struct cxl_event_gen_media {
 	__le64 phys_addr;
 	u8 descriptor;
 	u8 type;
-	u8 transaction_type;
+	u8 transaction_type;	/* enum cxl_event_transaction_type */
 	u8 validity_flags[2];
 	u8 channel;
 	u8 rank;
@@ -52,7 +65,7 @@ struct cxl_event_dram {
 	__le64 phys_addr;
 	u8 descriptor;
 	u8 type;
-	u8 transaction_type;
+	u8 transaction_type;	/* enum cxl_event_transaction_type */
 	u8 validity_flags[2];
 	u8 channel;
 	u8 rank;
-- 
2.34.1


