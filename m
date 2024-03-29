Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D437C6FD1F
	for <qemu-devel@archiver.kernel.org>; Fri, 29 Mar 2024 06:36:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rq5qp-0004XK-Rp; Fri, 29 Mar 2024 02:36:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ruansy.fnst@fujitsu.com>)
 id 1rq5qj-0004VI-F8
 for qemu-devel@nongnu.org; Fri, 29 Mar 2024 02:36:25 -0400
Received: from esa11.hc1455-7.c3s2.iphmx.com ([207.54.90.137])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ruansy.fnst@fujitsu.com>)
 id 1rq5qh-0002VK-IR
 for qemu-devel@nongnu.org; Fri, 29 Mar 2024 02:36:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj2;
 t=1711694184; x=1743230184;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=Om0rTA9WbsSAo7t6tlUEm6jtC04fsfKD+Idi78A3PwY=;
 b=qVkeJmGDqC4AGU51faOF30bODFPUqTCERvkm3Rh/n6r7MkROd8rmQq9M
 OCzz50EfejF0D0rpYKCXt3JEUStbmaW2zyUbmar8DVcrYEgRuP69AkMFN
 Z7p753tIEusvtkKPMWNeYnZbMHKDTYxUYyora/1qD2nzXn0419R0xyCKx
 WI1zVg5vY8bkfLWrNKIejegig9FTvnFI303YEGQYVOGYQB790r6IrsVBS
 ALYMQisbA2+pSsSrzXFXkkB/NFWuTHm2lkxzXxGlK7Q8LwRUKSZS5pgHS
 44KLnTMVdmlDFxD0VznYREs5W4WyCN5yAgMcwAqS9WQpwC2sulGQpD0JR g==;
X-IronPort-AV: E=McAfee;i="6600,9927,11027"; a="133107776"
X-IronPort-AV: E=Sophos;i="6.07,164,1708354800"; d="scan'208";a="133107776"
Received: from unknown (HELO oym-r4.gw.nic.fujitsu.com) ([210.162.30.92])
 by esa11.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 Mar 2024 15:36:20 +0900
Received: from oym-m3.gw.nic.fujitsu.com (oym-nat-oym-m3.gw.nic.fujitsu.com
 [192.168.87.60])
 by oym-r4.gw.nic.fujitsu.com (Postfix) with ESMTP id B8D6FDCC08
 for <qemu-devel@nongnu.org>; Fri, 29 Mar 2024 15:36:17 +0900 (JST)
Received: from kws-ab3.gw.nic.fujitsu.com (kws-ab3.gw.nic.fujitsu.com
 [192.51.206.21])
 by oym-m3.gw.nic.fujitsu.com (Postfix) with ESMTP id E30E715620
 for <qemu-devel@nongnu.org>; Fri, 29 Mar 2024 15:36:16 +0900 (JST)
Received: from edo.cn.fujitsu.com (edo.cn.fujitsu.com [10.167.33.5])
 by kws-ab3.gw.nic.fujitsu.com (Postfix) with ESMTP id 7EC08200A7F0B
 for <qemu-devel@nongnu.org>; Fri, 29 Mar 2024 15:36:16 +0900 (JST)
Received: from irides.g08.fujitsu.local (unknown [10.167.226.114])
 by edo.cn.fujitsu.com (Postfix) with ESMTP id 24B0C1A006D;
 Fri, 29 Mar 2024 14:36:16 +0800 (CST)
To: qemu-devel@nongnu.org,
	linux-cxl@vger.kernel.org
Cc: Jonathan.Cameron@huawei.com, dan.j.williams@intel.com, dave@stgolabs.net,
 ira.weiny@intel.com
Subject: [RFC PATCH v2 4/6] cxl/core: report poison when injecting from debugfs
Date: Fri, 29 Mar 2024 14:36:12 +0800
Message-Id: <20240329063614.362763-5-ruansy.fnst@fujitsu.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240329063614.362763-1-ruansy.fnst@fujitsu.com>
References: <20240329063614.362763-1-ruansy.fnst@fujitsu.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-TM-AS-Product-Ver: IMSS-9.1.0.1417-9.0.0.1002-28282.003
X-TM-AS-User-Approved-Sender: Yes
X-TMASE-Version: IMSS-9.1.0.1417-9.0.1002-28282.003
X-TMASE-Result: 10--1.096700-10.000000
X-TMASE-MatchedRID: It5tpevY7hTR6RKL7TRTbhF4zyLyne+ATJDl9FKHbrnLBiiIoKf6r6PF
 jJEFr+olKE0Je8DR/D4NXwNUB3oA790H8LFZNFG76sBnwpOylLOGGOXsAst2EY71S6fa2jIEbbi
 ume7ndEjAl7InEAdrZfsQLJr4C1gANHYsYoI80lgKm9Bb+04k3Mw0hF8jARVgyLf0xPiHr9ghya
 dlGFXHKsTgfCdKUS4cicSkmYsAV+kLUU1zqiphVX7cGd19dSFd
X-TMASE-SNAP-Result: 1.821001.0001-0-1-22:0,33:0,34:0-0
Received-SPF: pass client-ip=207.54.90.137;
 envelope-from=ruansy.fnst@fujitsu.com; helo=esa11.hc1455-7.c3s2.iphmx.com
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

Poison injection from debugfs is silent too.  Add calling
cxl_mem_report_poison() to make it able to do memory_failure().

Signed-off-by: Shiyang Ruan <ruansy.fnst@fujitsu.com>
---
 drivers/cxl/core/memdev.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/cxl/core/memdev.c b/drivers/cxl/core/memdev.c
index e976141ca4a9..b0dcbe6f1004 100644
--- a/drivers/cxl/core/memdev.c
+++ b/drivers/cxl/core/memdev.c
@@ -366,6 +366,7 @@ int cxl_inject_poison(struct cxl_memdev *cxlmd, u64 dpa)
 		.length = cpu_to_le32(1),
 	};
 	trace_cxl_poison(cxlmd, cxlr, &record, 0, 0, CXL_POISON_TRACE_INJECT);
+	cxl_mem_report_poison(cxlmd, cxlr, &record);
 out:
 	up_read(&cxl_dpa_rwsem);
 	up_read(&cxl_region_rwsem);
-- 
2.34.1


