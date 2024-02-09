Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91763C48297
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Feb 2024 13:59:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rYROI-0003GS-Qb; Fri, 09 Feb 2024 08:58:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ruansy.fnst@fujitsu.com>)
 id 1rYPSi-0003FH-6r
 for qemu-devel@nongnu.org; Fri, 09 Feb 2024 06:54:32 -0500
Received: from esa5.hc1455-7.c3s2.iphmx.com ([68.232.139.130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ruansy.fnst@fujitsu.com>)
 id 1rYPSc-0001eE-MC
 for qemu-devel@nongnu.org; Fri, 09 Feb 2024 06:54:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj2;
 t=1707479667; x=1739015667;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=DqknUnBjZ5fwkO5WCjpRr3I7mOyqFTJUsVXnrEI3Vh4=;
 b=t1B+iePWhZnyOIcqXsNS+viRRLaj3aikkHJGiM9XKJjXJWJGLiw8O5Oy
 nx/gkJR/Y0AvnC8sWTSe/3txNAjPrFL9ztebyA6yH8bWqUcTAdnfHnTZL
 F6nsFD1kAZrfxBwS9UOypRIJTFsJP3Ftb60Z5ZoUYr+t9Bw71pKznJ4Uu
 wkVpFZ73V4GRW27SnlNc74SGd8R0U44E95fTEJ69Gb+8IyXoRDjD4pYrk
 n7Doc8lwRfkG74BLwk+Jr50PbzqF1Sq3fORzCvd9Zbi9kb3tr6bWoz2f3
 C0ctaCwe3oPbXj3QgmviuFNbI3BT2uQgkfUAsHgebW7nKzhlHsZJfRJUy Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10978"; a="148405991"
X-IronPort-AV: E=Sophos;i="6.05,256,1701097200"; d="scan'208";a="148405991"
Received: from unknown (HELO oym-r1.gw.nic.fujitsu.com) ([210.162.30.89])
 by esa5.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Feb 2024 20:54:23 +0900
Received: from oym-m1.gw.nic.fujitsu.com (oym-nat-oym-m1.gw.nic.fujitsu.com
 [192.168.87.58])
 by oym-r1.gw.nic.fujitsu.com (Postfix) with ESMTP id 82D5CD4801
 for <qemu-devel@nongnu.org>; Fri,  9 Feb 2024 20:54:20 +0900 (JST)
Received: from kws-ab4.gw.nic.fujitsu.com (kws-ab4.gw.nic.fujitsu.com
 [192.51.206.22])
 by oym-m1.gw.nic.fujitsu.com (Postfix) with ESMTP id BDA76FD9B8
 for <qemu-devel@nongnu.org>; Fri,  9 Feb 2024 20:54:19 +0900 (JST)
Received: from edo.cn.fujitsu.com (edo.cn.fujitsu.com [10.167.33.5])
 by kws-ab4.gw.nic.fujitsu.com (Postfix) with ESMTP id 5D42A1EB690
 for <qemu-devel@nongnu.org>; Fri,  9 Feb 2024 20:54:19 +0900 (JST)
Received: from irides.g08.fujitsu.local (unknown [10.167.226.114])
 by edo.cn.fujitsu.com (Postfix) with ESMTP id 1AF471A009A;
 Fri,  9 Feb 2024 19:54:19 +0800 (CST)
To: qemu-devel@nongnu.org,
	linux-cxl@vger.kernel.org
Cc: Jonathan.Cameron@huawei.com,
	dan.j.williams@intel.com
Subject: [RFC PATCH 2/5] cxl/core: introduce cxl_memdev_dpa_to_hpa()
Date: Fri,  9 Feb 2024 19:54:14 +0800
Message-Id: <20240209115417.724638-5-ruansy.fnst@fujitsu.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240209115417.724638-1-ruansy.fnst@fujitsu.com>
References: <20240209115417.724638-1-ruansy.fnst@fujitsu.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-TM-AS-Product-Ver: IMSS-9.1.0.1417-9.0.0.1002-28180.007
X-TM-AS-User-Approved-Sender: Yes
X-TMASE-Version: IMSS-9.1.0.1417-9.0.1002-28180.007
X-TMASE-Result: 10--0.230400-10.000000
X-TMASE-MatchedRID: E/JbUmZTmPmNrFmNgJn2XRFbgtHjUWLyBPY4SegK3jyCFz9ikiaZRugo
 SvaKsl/kIvrftAIhWmLy9zcRSkKatWk5Fql3Faa7GYJhRh6ssevxKR2kbb+f18jKFxQAxz7go8W
 MkQWv6iXBcIE78YqRWo6HM5rqDwqtDOrGF7ZOho2UDWJ+gGA8HODB/FnLVeD/eq3AljACGEWBY1
 kgr1igAyCXLsbqmC2GIHzy4kLR1fJvckC7hSyyXDMdHQ58xd4CFcG3+ZRETICP9kUX1Z+buE3Lu
 mkbQiNwVCqTSPu8tVR7AxIEOt4h2Q==
X-TMASE-SNAP-Result: 1.821001.0001-0-1-22:0,33:0,34:0-0
Received-SPF: pass client-ip=68.232.139.130;
 envelope-from=ruansy.fnst@fujitsu.com; helo=esa5.hc1455-7.c3s2.iphmx.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Fri, 09 Feb 2024 08:57:57 -0500
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

When a memdev is assigned to a region, its Device Physical Address will be
mapped to Host Physical Address.  Introduce this helper function to
translate HPA from a given memdev and its DPA.

Signed-off-by: Shiyang Ruan <ruansy.fnst@fujitsu.com>
---
 drivers/cxl/core/memdev.c | 12 ++++++++++++
 drivers/cxl/cxlmem.h      |  1 +
 2 files changed, 13 insertions(+)

diff --git a/drivers/cxl/core/memdev.c b/drivers/cxl/core/memdev.c
index dae8802ecdb0..c304e709ef0e 100644
--- a/drivers/cxl/core/memdev.c
+++ b/drivers/cxl/core/memdev.c
@@ -319,6 +319,18 @@ static int cxl_validate_poison_dpa(struct cxl_memdev *cxlmd, u64 dpa)
 	return 0;
 }
 
+phys_addr_t cxl_memdev_dpa_to_hpa(struct cxl_memdev *cxlmd, u64 dpa)
+{
+	struct cxl_region *cxlr = cxl_dpa_to_region(cxlmd, dpa);
+
+	if (cxlr)
+		return cxlr->params.res->start + dpa;
+	else {
+		dev_dbg(&cxlmd->dev, "device belongs to no region.\n");
+		return 0;
+	}
+}
+
 int cxl_inject_poison(struct cxl_memdev *cxlmd, u64 dpa)
 {
 	struct cxl_memdev_state *mds = to_cxl_memdev_state(cxlmd->cxlds);
diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
index 5303d6942b88..97ddab421e63 100644
--- a/drivers/cxl/cxlmem.h
+++ b/drivers/cxl/cxlmem.h
@@ -833,6 +833,7 @@ int cxl_poison_state_init(struct cxl_memdev_state *mds);
 int cxl_mem_get_poison(struct cxl_memdev *cxlmd, u64 offset, u64 len,
 		       struct cxl_region *cxlr);
 int cxl_trigger_poison_list(struct cxl_memdev *cxlmd);
+phys_addr_t cxl_memdev_dpa_to_hpa(struct cxl_memdev *cxlmd, u64 dpa);
 int cxl_inject_poison(struct cxl_memdev *cxlmd, u64 dpa);
 int cxl_clear_poison(struct cxl_memdev *cxlmd, u64 dpa);
 
-- 
2.34.1


