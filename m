Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7EC46C3DA59
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jul 2024 04:12:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sVkMr-0004Yv-Vl; Mon, 22 Jul 2024 00:09:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yaoxt.fnst@fujitsu.com>)
 id 1sVkMn-00048k-Hh
 for qemu-devel@nongnu.org; Mon, 22 Jul 2024 00:09:41 -0400
Received: from esa7.hc1455-7.c3s2.iphmx.com ([139.138.61.252])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yaoxt.fnst@fujitsu.com>)
 id 1sVkMl-0001wx-PE
 for qemu-devel@nongnu.org; Mon, 22 Jul 2024 00:09:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj2;
 t=1721621379; x=1753157379;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=GA4nPORIGQjzZVaVYEJiQuZjbCyqq1kZkMjn0l4f0HM=;
 b=rJ3FcGhDZ0penx6139hdWFVrVi7+PiwT/8qAoo6Z3k35Yp6lrt+V+Duk
 naEL5u3OSplpGfQ3VYrZZV28yiH84l4/oYQwTe+Ec0ynR9kdeOvlmZ5KC
 dIRls92pGaZj9pyq7A0OnAOMCEgUfcwHTqOI1I9XFl82I+UJWfmNj+IzF
 0GrY74DOsnJPMhwOaLLzfZCIqJoGpfcrnnvjfGZVHgtJMCeaYVZA+pQQz
 k1+Za3Ethhw15ju5OV9LzToTVqevMuGchasPnorMob34sf92LbjSiYVjG
 WowCEGc5O/hjXY6PK469fkP9h0dVlU6Sc7xZ9GPsjFXkoIPf2xZHc9VYz A==;
X-IronPort-AV: E=McAfee;i="6700,10204,11140"; a="146958168"
X-IronPort-AV: E=Sophos;i="6.09,227,1716217200"; d="scan'208";a="146958168"
Received: from unknown (HELO oym-r2.gw.nic.fujitsu.com) ([210.162.30.90])
 by esa7.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 Jul 2024 13:09:37 +0900
Received: from oym-m2.gw.nic.fujitsu.com (oym-nat-oym-m2.gw.nic.fujitsu.com
 [192.168.87.59])
 by oym-r2.gw.nic.fujitsu.com (Postfix) with ESMTP id CAD05D9223
 for <qemu-devel@nongnu.org>; Mon, 22 Jul 2024 13:09:35 +0900 (JST)
Received: from kws-ab3.gw.nic.fujitsu.com (kws-ab3.gw.nic.fujitsu.com
 [192.51.206.21])
 by oym-m2.gw.nic.fujitsu.com (Postfix) with ESMTP id 0F7F1BF3C5
 for <qemu-devel@nongnu.org>; Mon, 22 Jul 2024 13:09:25 +0900 (JST)
Received: from edo.cn.fujitsu.com (edo.cn.fujitsu.com [10.167.33.5])
 by kws-ab3.gw.nic.fujitsu.com (Postfix) with ESMTP id 9642F20076D0D
 for <qemu-devel@nongnu.org>; Mon, 22 Jul 2024 13:09:24 +0900 (JST)
Received: from localhost.localdomain (unknown [10.167.225.88])
 by edo.cn.fujitsu.com (Postfix) with ESMTP id BB8B81A000A;
 Mon, 22 Jul 2024 12:09:23 +0800 (CST)
To: qemu-devel@nongnu.org, Alexander Bulekov <alxndr@bu.edu>,
 Paolo Bonzini <pbonzini@redhat.com>, Bandan Das <bsd@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Darren Kenny <darren.kenny@oracle.com>, Qiuhao Li <Qiuhao.Li@outlook.com>,
 Laurent Vivier <lvivier@redhat.com>
Cc: Yao Xingtao <yaoxt.fnst@fujitsu.com>
Subject: [PATCH 07/13] qtest/fuzz: make range overlap check more readable
Date: Mon, 22 Jul 2024 00:07:36 -0400
Message-ID: <20240722040742.11513-8-yaoxt.fnst@fujitsu.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240722040742.11513-1-yaoxt.fnst@fujitsu.com>
References: <20240722040742.11513-1-yaoxt.fnst@fujitsu.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-TM-AS-Product-Ver: IMSS-9.1.0.1417-9.0.0.1002-28544.005
X-TM-AS-User-Approved-Sender: Yes
X-TMASE-Version: IMSS-9.1.0.1417-9.0.1002-28544.005
X-TMASE-Result: 10-0.713900-10.000000
X-TMASE-MatchedRID: alxK4aWrxwlrFdvBEmTnvDyjd/AizytBAZn/4A9db2TAuQ0xDMaXkH4q
 tYI9sRE/3BlBvFCka9sboCivyaDEEgdrD3O6lkawngIgpj8eDcBpkajQR5gb3mn0m688Eo38Kra
 uXd3MZDVhghmdIrP4RYGHOnE1bLKai1k/2x9BxsnjSkboDGTSyiplNLSwFcg5nYfGVyys98Q+/a
 BNVcwpcBVYRtxXPf7JWHxhTISq8s7/I8o6mB5zERXFEH92Kf64nTtPxlIuIBW9Hzj86YHXBCnif
 x5AGfCL
X-TMASE-SNAP-Result: 1.821001.0001-0-1-22:0,33:0,34:0-0
Received-SPF: pass client-ip=139.138.61.252;
 envelope-from=yaoxt.fnst@fujitsu.com; helo=esa7.hc1455-7.c3s2.iphmx.com
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
 tests/qtest/fuzz/generic_fuzz.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tests/qtest/fuzz/generic_fuzz.c b/tests/qtest/fuzz/generic_fuzz.c
index ec842e03c5e6..d107a496da63 100644
--- a/tests/qtest/fuzz/generic_fuzz.c
+++ b/tests/qtest/fuzz/generic_fuzz.c
@@ -11,6 +11,7 @@
  */
 
 #include "qemu/osdep.h"
+#include "qemu/range.h"
 
 #include <wordexp.h>
 
@@ -211,7 +212,7 @@ void fuzz_dma_read_cb(size_t addr, size_t len, MemoryRegion *mr)
          i < dma_regions->len && (avoid_double_fetches || qtest_log_enabled);
          ++i) {
         region = g_array_index(dma_regions, address_range, i);
-        if (addr < region.addr + region.size && addr + len > region.addr) {
+        if (ranges_overlap(addr, len, region.addr, region.size)) {
             double_fetch = true;
             if (addr < region.addr
                 && avoid_double_fetches) {
-- 
2.41.0


