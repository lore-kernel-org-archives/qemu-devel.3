Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5EB2FC3DA60
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jul 2024 09:08:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sUN7W-0002Ns-K7; Thu, 18 Jul 2024 05:08:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yaoxt.fnst@fujitsu.com>)
 id 1sUN7U-0002Gm-R8
 for qemu-devel@nongnu.org; Thu, 18 Jul 2024 05:08:12 -0400
Received: from esa12.hc1455-7.c3s2.iphmx.com ([139.138.37.100])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yaoxt.fnst@fujitsu.com>)
 id 1sUN7S-0005pu-Ua
 for qemu-devel@nongnu.org; Thu, 18 Jul 2024 05:08:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj2;
 t=1721293690; x=1752829690;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=sQE84ydqX+Xy8dQ61r646iNiJEY7sN61UA2G290//M0=;
 b=AYfo4el5pHHYU0e/iwfJkX0aGyWD3H6KhXpVQFnNkah6TzvXRICqDlPu
 +t3YDfL0z+CviqvbDclSxDD/1SEYVaMmerfpiPdb24idfw4hhmOva9G+o
 IQFsZg7CtUh/ijH4UcBd2gZAti38AJwEWtFBlI35VdQ6G0g3r4hi1j8gT
 vc7EfbrxnnTgiYsU0EbGl8RrFDilPebR0tPwTIgTUeF6vfPVcF/yOCR7l
 i093oLSHY7z3ud+f2S+/HdUjtjBv9ygqEJWXUgDvTLnYngx3RDyj5uPcS
 6/ENb9QPhirq+Z6GyW/nSGMt2gZLSAn3vPooAFdY9jVuaCMhAuzi5EXvB Q==;
X-IronPort-AV: E=McAfee;i="6700,10204,11136"; a="146763822"
X-IronPort-AV: E=Sophos;i="6.09,217,1716217200"; d="scan'208";a="146763822"
Received: from unknown (HELO oym-r2.gw.nic.fujitsu.com) ([210.162.30.90])
 by esa12.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Jul 2024 18:08:05 +0900
Received: from oym-m4.gw.nic.fujitsu.com (oym-nat-oym-m4.gw.nic.fujitsu.com
 [192.168.87.61])
 by oym-r2.gw.nic.fujitsu.com (Postfix) with ESMTP id 019D5D4255
 for <qemu-devel@nongnu.org>; Thu, 18 Jul 2024 18:08:03 +0900 (JST)
Received: from kws-ab3.gw.nic.fujitsu.com (kws-ab3.gw.nic.fujitsu.com
 [192.51.206.21])
 by oym-m4.gw.nic.fujitsu.com (Postfix) with ESMTP id 3DCDFD52F4
 for <qemu-devel@nongnu.org>; Thu, 18 Jul 2024 18:08:02 +0900 (JST)
Received: from edo.cn.fujitsu.com (edo.cn.fujitsu.com [10.167.33.5])
 by kws-ab3.gw.nic.fujitsu.com (Postfix) with ESMTP id C136620086129
 for <qemu-devel@nongnu.org>; Thu, 18 Jul 2024 18:08:01 +0900 (JST)
Received: from localhost.localdomain (unknown [10.167.225.88])
 by edo.cn.fujitsu.com (Postfix) with ESMTP id 1C47D1A000A;
 Thu, 18 Jul 2024 17:08:01 +0800 (CST)
To: jonathan.cameron@huawei.com,
	fan.ni@samsung.com
Cc: qemu-devel@nongnu.org,
	Yao Xingtao <yaoxt.fnst@fujitsu.com>
Subject: [PATCH] mem/cxl_type3: Fix overlapping region validation error
Date: Thu, 18 Jul 2024 05:07:53 -0400
Message-Id: <20240718090753.59163-1-yaoxt.fnst@fujitsu.com>
X-Mailer: git-send-email 2.37.3
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-TM-AS-Product-Ver: IMSS-9.1.0.1417-9.0.0.1002-28536.006
X-TM-AS-User-Approved-Sender: Yes
X-TMASE-Version: IMSS-9.1.0.1417-9.0.1002-28536.006
X-TMASE-Result: 10-0.623500-10.000000
X-TMASE-MatchedRID: WS7LLyBpFOP/R1NSMc2qCUz7FUUjXG1jwTlc9CcHMZerwqxtE531VOgV
 4TkxLE0x585VzGMOFzA870o9QRfzOwtuKBGekqUpIG4YlbCDECseyhETYMxMRvr0uieWRyKF8Ts
 JZXzG8uKK/Gy9WLZUeX2IiP6t7Gv04XkR6BoWo5M7Duqd1O+1bXCY7NY42rmqVzS7LFez63KTpH
 J0MYQg3hMBexWs+SIH3D94QFatAxc21XLFpkB2YKzp5y15pXcIftwZ3X11IV0=
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
┌───┬───────┬───┐
│a  │  b(a) │a  │
└───┴───────┴───┘
(a is a newly added region, b is an existing region, and b is a
 subregion of a)

Signed-off-by: Yao Xingtao <yaoxt.fnst@fujitsu.com>
---
 hw/mem/cxl_type3.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/hw/mem/cxl_type3.c b/hw/mem/cxl_type3.c
index 35ac59883a5b..8e32de327908 100644
--- a/hw/mem/cxl_type3.c
+++ b/hw/mem/cxl_type3.c
@@ -1331,9 +1331,7 @@ void qmp_cxl_inject_poison(const char *path, uint64_t start, uint64_t length,
     ct3d = CXL_TYPE3(obj);
 
     QLIST_FOREACH(p, &ct3d->poison_list, node) {
-        if (((start >= p->start) && (start < p->start + p->length)) ||
-            ((start + length > p->start) &&
-             (start + length <= p->start + p->length))) {
+        if ((start < p->start + p->length) && (start + length > p->start)) {
             error_setg(errp,
                        "Overlap with existing poisoned region not supported");
             return;
-- 
2.37.3


