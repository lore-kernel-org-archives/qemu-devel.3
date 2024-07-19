Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EEFCBC3DA61
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jul 2024 01:28:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sUcQ1-0000Ef-Vx; Thu, 18 Jul 2024 21:28:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yaoxt.fnst@fujitsu.com>)
 id 1sUcQ0-0000E2-4Z
 for qemu-devel@nongnu.org; Thu, 18 Jul 2024 21:28:20 -0400
Received: from esa12.hc1455-7.c3s2.iphmx.com ([139.138.37.100])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yaoxt.fnst@fujitsu.com>)
 id 1sUcPx-00082K-UV
 for qemu-devel@nongnu.org; Thu, 18 Jul 2024 21:28:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj2;
 t=1721352497; x=1752888497;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=QxejN7Ryx8FcdgGMpFvpkWis4gu0dubWD5AR2lgNLk4=;
 b=AWKcfu50ZO5lFdrV4kATflpoEYewLYLgTWVfo4XOl4sLPbYYn9zHR3Vu
 S0LAwgKyf9QXv31FNjKP08XQq9MpUMfQsJSetGT43q3pKMVLzSaheFofU
 Wy6kBj7tH/Lr/MuWS60SnTjjmDeM+cWMCwo32Ozu+f1/dLzILS4y60nfl
 3z/jFiiUjc8vUP1O6iH0qWgym/UpD6mKUYOVXZEsskx5AiY6Wku6hC4U3
 8WVrh5OMD4j+AemcwZ2n+L9dOstqHAFIlfZEVR2lujjrzwN+TbMXBk7T/
 qf98VmRI550UqALtn2JAx3xUHK/o14hAWDo65VXd8RcmbRfi0+IRYTaZ4 A==;
X-IronPort-AV: E=McAfee;i="6700,10204,11137"; a="146840686"
X-IronPort-AV: E=Sophos;i="6.09,219,1716217200"; d="scan'208";a="146840686"
Received: from unknown (HELO yto-r1.gw.nic.fujitsu.com) ([218.44.52.217])
 by esa12.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Jul 2024 10:28:13 +0900
Received: from yto-m3.gw.nic.fujitsu.com (yto-nat-yto-m3.gw.nic.fujitsu.com
 [192.168.83.66])
 by yto-r1.gw.nic.fujitsu.com (Postfix) with ESMTP id 646A3DB3C3
 for <qemu-devel@nongnu.org>; Fri, 19 Jul 2024 10:28:11 +0900 (JST)
Received: from kws-ab4.gw.nic.fujitsu.com (kws-ab4.gw.nic.fujitsu.com
 [192.51.206.22])
 by yto-m3.gw.nic.fujitsu.com (Postfix) with ESMTP id B364CD21D9
 for <qemu-devel@nongnu.org>; Fri, 19 Jul 2024 10:28:10 +0900 (JST)
Received: from edo.cn.fujitsu.com (edo.cn.fujitsu.com [10.167.33.5])
 by kws-ab4.gw.nic.fujitsu.com (Postfix) with ESMTP id 39AD2227A8A
 for <qemu-devel@nongnu.org>; Fri, 19 Jul 2024 10:28:10 +0900 (JST)
Received: from localhost.localdomain (unknown [10.167.225.88])
 by edo.cn.fujitsu.com (Postfix) with ESMTP id 745601A0002;
 Fri, 19 Jul 2024 09:28:09 +0800 (CST)
To: jonathan.cameron@huawei.com,
	fan.ni@samsung.com
Cc: qemu-devel@nongnu.org, Yao Xingtao <yaoxt.fnst@fujitsu.com>,
 Jonathan Cameron <Jonathan.Cameron@huwei.com>,
 Peter Maydell <peter.maydell@linaro.org>
Subject: [PATCH v2] mem/cxl_type3: Fix overlapping region validation error
Date: Thu, 18 Jul 2024 21:28:07 -0400
Message-Id: <20240719012807.70715-1-yaoxt.fnst@fujitsu.com>
X-Mailer: git-send-email 2.37.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-TM-AS-Product-Ver: IMSS-9.1.0.1417-9.0.0.1002-28538.002
X-TM-AS-User-Approved-Sender: Yes
X-TMASE-Version: IMSS-9.1.0.1417-9.0.1002-28538.002
X-TMASE-Result: 10--2.496400-10.000000
X-TMASE-MatchedRID: BlFNdihulab/R1NSMc2qCUz7FUUjXG1jaU4+utsGZqAR34ro7k23nT13
 GoPFA1HFIvrftAIhWmLy9zcRSkKatb7wtKKw5QU3ngIgpj8eDcBpkajQR5gb3lQwtQm7iV5jKra
 uXd3MZDUMFsa+1wyh/CyiErhmmuHL1BEngT04oiB5fHFSiasHxtRJ3rUDwULCb3C0R+B8BRjHp9
 j5FeOHAzozN6l4R1b+/qonAaaQ0YB24AN5YdP/mxXBt/mUREyAj/ZFF9Wfm7hNy7ppG0IjcFQqk
 0j7vLVUewMSBDreIdk=
X-TMASE-SNAP-Result: 1.821001.0001-0-1-22:0,33:0,34:0-0
Received-SPF: pass client-ip=139.138.37.100;
 envelope-from=yaoxt.fnst@fujitsu.com; helo=esa12.hc1455-7.c3s2.iphmx.com
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

When injecting a new poisoned region through qmp_cxl_inject_poison(),
the newly injected region should not overlap with existing poisoned
regions.

The current validation method does not consider the following
overlapping region:
+---+-------+---+
| a | b(a)  | a |
+---+-------+---+

(a is a newly added region, b is an existing region, and b is a
 subregion of a)

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huwei.com>
Suggested-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Yao Xingtao <yaoxt.fnst@fujitsu.com>

---
V1[1] -> V2:
 - Use ranges_overlap() to improve code readability
 - Replace the ASCII extended graph to ASCII basic in comment.

[1] https://lore.kernel.org/qemu-devel/20240718090753.59163-1-yaoxt.fnst@fujitsu.com
---
 hw/mem/cxl_type3.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/hw/mem/cxl_type3.c b/hw/mem/cxl_type3.c
index 35ac59883a5b..b2f3e2090b57 100644
--- a/hw/mem/cxl_type3.c
+++ b/hw/mem/cxl_type3.c
@@ -1331,9 +1331,7 @@ void qmp_cxl_inject_poison(const char *path, uint64_t start, uint64_t length,
     ct3d = CXL_TYPE3(obj);
 
     QLIST_FOREACH(p, &ct3d->poison_list, node) {
-        if (((start >= p->start) && (start < p->start + p->length)) ||
-            ((start + length > p->start) &&
-             (start + length <= p->start + p->length))) {
+        if (ranges_overlap(start, length, p->start, p->length)) {
             error_setg(errp,
                        "Overlap with existing poisoned region not supported");
             return;
-- 
2.37.3


