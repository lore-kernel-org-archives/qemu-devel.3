Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0BD7C3DA59
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jul 2024 04:09:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sVkMJ-0002PM-Q9; Mon, 22 Jul 2024 00:09:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yaoxt.fnst@fujitsu.com>)
 id 1sVkMA-0002MR-BE
 for qemu-devel@nongnu.org; Mon, 22 Jul 2024 00:09:03 -0400
Received: from esa2.hc1455-7.c3s2.iphmx.com ([207.54.90.48])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yaoxt.fnst@fujitsu.com>)
 id 1sVkM8-0001rj-6O
 for qemu-devel@nongnu.org; Mon, 22 Jul 2024 00:09:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj2;
 t=1721621340; x=1753157340;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=UDslaKUR+DRFaE92mJx4H+c111qYhgBVTy9nFE54RmQ=;
 b=pynGatR1SmGG5p8yozX3uDbo63Q/L7B4oKTJ6AOeIRNJ536QySR3UaTn
 OVE85evbqY2BVIutMRDGZ/v09HqZgstfESEjpCgtsqyMZ/ZYR3j0l4ebk
 zGIGjaad/gUeH2GBFf1C7Ah/KibiFnzJOAxOVdL4dYqpg0GCG1WGyXtv6
 /CvRlXS3um6H7l9Fb3lkSZEtFD+I0CvsviKExtL1q+pXMo5nzzD85UxUi
 TWWkfcaetB6Uwutxs2tgFV/z2UBndPg+wobK0W4B7OGggt5CaAhAMcZaQ
 NXj/iaciG3R1QCdVebU/dd795eE8jHTVor5a7BR5kMPbHHjQMeIlpWLwG g==;
X-IronPort-AV: E=McAfee;i="6700,10204,11140"; a="168119006"
X-IronPort-AV: E=Sophos;i="6.09,227,1716217200"; d="scan'208";a="168119006"
Received: from unknown (HELO oym-r1.gw.nic.fujitsu.com) ([210.162.30.89])
 by esa2.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 Jul 2024 13:08:57 +0900
Received: from oym-m1.gw.nic.fujitsu.com (oym-nat-oym-m1.gw.nic.fujitsu.com
 [192.168.87.58])
 by oym-r1.gw.nic.fujitsu.com (Postfix) with ESMTP id DC4A2C1490
 for <qemu-devel@nongnu.org>; Mon, 22 Jul 2024 13:08:54 +0900 (JST)
Received: from kws-ab4.gw.nic.fujitsu.com (kws-ab4.gw.nic.fujitsu.com
 [192.51.206.22])
 by oym-m1.gw.nic.fujitsu.com (Postfix) with ESMTP id 2CC2AD8B83
 for <qemu-devel@nongnu.org>; Mon, 22 Jul 2024 13:08:54 +0900 (JST)
Received: from edo.cn.fujitsu.com (edo.cn.fujitsu.com [10.167.33.5])
 by kws-ab4.gw.nic.fujitsu.com (Postfix) with ESMTP id A7EA46BEE3
 for <qemu-devel@nongnu.org>; Mon, 22 Jul 2024 13:08:53 +0900 (JST)
Received: from localhost.localdomain (unknown [10.167.225.88])
 by edo.cn.fujitsu.com (Postfix) with ESMTP id 2116C1A000A;
 Mon, 22 Jul 2024 12:08:53 +0800 (CST)
To: qemu-devel@nongnu.org, Eric Auger <eric.auger@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Cc: Yao Xingtao <yaoxt.fnst@fujitsu.com>
Subject: [PATCH 01/13] range: Make ranges_overlap() return bool
Date: Mon, 22 Jul 2024 00:07:30 -0400
Message-ID: <20240722040742.11513-2-yaoxt.fnst@fujitsu.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240722040742.11513-1-yaoxt.fnst@fujitsu.com>
References: <20240722040742.11513-1-yaoxt.fnst@fujitsu.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-TM-AS-Product-Ver: IMSS-9.1.0.1417-9.0.0.1002-28544.004
X-TM-AS-User-Approved-Sender: Yes
X-TMASE-Version: IMSS-9.1.0.1417-9.0.1002-28544.004
X-TMASE-Result: 10--3.417800-10.000000
X-TMASE-MatchedRID: LS8Ewxiu6UeFWCPo3rDAcEhwlOfYeSqxwTlc9CcHMZerwqxtE531VCzy
 bVqWyY2NJJArHl5VS02AUraeY8ICeR8TzIzimOwP0C1sQRfQzEHEQdG7H66TyHEqm8QYBtMO9FJ
 AdpFUlrB2LtNrXJElM1Ksmmiq2t19j9BGIA5QpFP71ApFFkEr+ZdcdiYEU7jbm9sclzcg8O/reN
 M0X2JgtZcrrAYC2hl1W4wbpXTb5DJKKve1kh3RY37qSWrndbmQn0bOriG5BVc=
X-TMASE-SNAP-Result: 1.821001.0001-0-1-22:0,33:0,34:0-0
Received-SPF: pass client-ip=207.54.90.48; envelope-from=yaoxt.fnst@fujitsu.com;
 helo=esa2.hc1455-7.c3s2.iphmx.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_PASS=-0.001,
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

Just like range_overlaps_range(), use the returned bool value
to check whether 2 given ranges overlap.

Signed-off-by: Yao Xingtao <yaoxt.fnst@fujitsu.com>
---
 include/qemu/range.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/qemu/range.h b/include/qemu/range.h
index 4ce694a39831..d446ad885d2d 100644
--- a/include/qemu/range.h
+++ b/include/qemu/range.h
@@ -210,8 +210,8 @@ static inline int range_covers_byte(uint64_t offset, uint64_t len,
 
 /* Check whether 2 given ranges overlap.
  * Undefined if ranges that wrap around 0. */
-static inline int ranges_overlap(uint64_t first1, uint64_t len1,
-                                 uint64_t first2, uint64_t len2)
+static inline bool ranges_overlap(uint64_t first1, uint64_t len1,
+                                  uint64_t first2, uint64_t len2)
 {
     uint64_t last1 = range_get_last(first1, len1);
     uint64_t last2 = range_get_last(first2, len2);
-- 
2.41.0


