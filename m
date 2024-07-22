Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A00F7C3DA5D
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jul 2024 04:12:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sVkMp-0004Jl-Sv; Mon, 22 Jul 2024 00:09:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yaoxt.fnst@fujitsu.com>)
 id 1sVkMf-0003Z6-Mn; Mon, 22 Jul 2024 00:09:35 -0400
Received: from esa5.hc1455-7.c3s2.iphmx.com ([68.232.139.130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yaoxt.fnst@fujitsu.com>)
 id 1sVkMd-0001ub-EU; Mon, 22 Jul 2024 00:09:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj2;
 t=1721621372; x=1753157372;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=3zVcKBQCKQbvaThp7mSbptK5oDFKcWVd925E3jJP5MQ=;
 b=pQbULxcYRTaCQ32QB3byZaYuFqU4f7gqwKiCS9tENFL32kYvJ6Yn83S0
 +ATCYzTMfyyi4xGE1xgr2SIawJZ5pA83CrTGCKP5WB/SHMfr1Y2+01D2a
 AgBFUNwLbvseHqS3gXieC/Sd9UjRx6kUVunexXCHlOBDdYOj+SNkO44G9
 MuxKF8dOF+H5YJDH+7WkVdV0AsfikKFY1sB0nQi64gWXG0MIxPdbA8HWx
 a+SlfrstXO7Sk81C+4v457u9qDy1/A5KRFRMabFwtf6oS2noDFZ2zlC01
 xq3eIYUIQ83WbgdizVGohksKeiLRaZwlLV7q7mwT5hy4iNggOetbaWb/y w==;
X-IronPort-AV: E=McAfee;i="6700,10204,11140"; a="167294580"
X-IronPort-AV: E=Sophos;i="6.09,227,1716217200"; d="scan'208";a="167294580"
Received: from unknown (HELO oym-r1.gw.nic.fujitsu.com) ([210.162.30.89])
 by esa5.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 Jul 2024 13:09:26 +0900
Received: from oym-m1.gw.nic.fujitsu.com (oym-nat-oym-m1.gw.nic.fujitsu.com
 [192.168.87.58])
 by oym-r1.gw.nic.fujitsu.com (Postfix) with ESMTP id 336F3E7521;
 Mon, 22 Jul 2024 13:09:24 +0900 (JST)
Received: from kws-ab3.gw.nic.fujitsu.com (kws-ab3.gw.nic.fujitsu.com
 [192.51.206.21])
 by oym-m1.gw.nic.fujitsu.com (Postfix) with ESMTP id 6493CD8B73;
 Mon, 22 Jul 2024 13:09:23 +0900 (JST)
Received: from edo.cn.fujitsu.com (edo.cn.fujitsu.com [10.167.33.5])
 by kws-ab3.gw.nic.fujitsu.com (Postfix) with ESMTP id E4DF220076D0B;
 Mon, 22 Jul 2024 13:09:22 +0900 (JST)
Received: from localhost.localdomain (unknown [10.167.225.88])
 by edo.cn.fujitsu.com (Postfix) with ESMTP id 70DC81A000A;
 Mon, 22 Jul 2024 12:09:22 +0800 (CST)
To: qemu-devel@nongnu.org,
	BALATON Zoltan <balaton@eik.bme.hu>
Cc: Yao Xingtao <yaoxt.fnst@fujitsu.com>,
	qemu-ppc@nongnu.org
Subject: [PATCH 05/13] display/sm501: make range overlap check more readable
Date: Mon, 22 Jul 2024 00:07:34 -0400
Message-ID: <20240722040742.11513-6-yaoxt.fnst@fujitsu.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240722040742.11513-1-yaoxt.fnst@fujitsu.com>
References: <20240722040742.11513-1-yaoxt.fnst@fujitsu.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-TM-AS-Product-Ver: IMSS-9.1.0.1417-9.0.0.1002-28544.005
X-TM-AS-User-Approved-Sender: Yes
X-TMASE-Version: IMSS-9.1.0.1417-9.0.1002-28544.005
X-TMASE-Result: 10-3.907200-10.000000
X-TMASE-MatchedRID: YE84GSk4VaxrFdvBEmTnvE7nLUqYrlslFIuBIWrdOePfUZT83lbkEHzG
 fWdtXBUcVgkik3UNgnmAMuqetGVetnyef22ep6XYxlblqLlYqXKnsjrxQufrpl/fbfaC05sQJgJ
 MYulwEmOxobjbDXd9COjQp20eagu8yA7p08E6TtS2npsOz8/fH1ODQFKIHmX6dhlnmRDifkgRZb
 RsQk5MBUB1QPq9bxnWZkAxAwjIrrMHz/H0kiLyEqGAtHMDjkk9
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

use ranges_overlap() instead of open-coding the overlap check to improve
the readability of the code.

Signed-off-by: Yao Xingtao <yaoxt.fnst@fujitsu.com>
---
 hw/display/sm501.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/hw/display/sm501.c b/hw/display/sm501.c
index 26dc8170d89b..c25b2574e447 100644
--- a/hw/display/sm501.c
+++ b/hw/display/sm501.c
@@ -823,15 +823,15 @@ static void sm501_2d_operation(SM501State *s)
             }
             /* If reverse blit do simple check for overlaps */
             if (rtl && src_base == dst_base && src_pitch == dst_pitch) {
-                overlap = (src_x < dst_x + width && src_x + width > dst_x &&
-                           src_y < dst_y + height && src_y + height > dst_y);
+                overlap = (ranges_overlap(src_x, width, dst_x, width) &&
+                           ranges_overlap(src_y, height, dst_y, height));
             } else if (rtl) {
-                unsigned int sb, se, db, de;
+                unsigned int sb, sl, db, dl;
                 sb = src_base + (src_x + src_y * src_pitch) * bypp;
-                se = sb + (width + (height - 1) * src_pitch) * bypp;
+                sl = (width + (height - 1) * src_pitch) * bypp;
                 db = dst_base + (dst_x + dst_y * dst_pitch) * bypp;
-                de = db + (width + (height - 1) * dst_pitch) * bypp;
-                overlap = (db < se && sb < de);
+                dl = (width + (height - 1) * dst_pitch) * bypp;
+                overlap = ranges_overlap(sb, sl, db, dl);
             }
 #ifdef CONFIG_PIXMAN
             if (overlap && (s->use_pixman & BIT(2))) {
-- 
2.41.0


