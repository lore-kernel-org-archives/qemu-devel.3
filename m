Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A66DC4828F
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Feb 2024 13:59:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rYROO-0003Hl-O0; Fri, 09 Feb 2024 08:58:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ruansy.fnst@fujitsu.com>)
 id 1rYPSi-0003FJ-8z
 for qemu-devel@nongnu.org; Fri, 09 Feb 2024 06:54:32 -0500
Received: from esa2.hc1455-7.c3s2.iphmx.com ([207.54.90.48])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ruansy.fnst@fujitsu.com>)
 id 1rYPSc-0001e8-Jq
 for qemu-devel@nongnu.org; Fri, 09 Feb 2024 06:54:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj2;
 t=1707479667; x=1739015667;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=gc1QJi8tjO2QU5afLszjKGpMkpijLoZiKrlgk9mPnlY=;
 b=FgNbAMrbzFGsdYViNMYTYZ4qXSILMGJzAacThieJ0kQ/d6bO/t4G56TY
 34lRVBIK8Vf1vhP/HoTJxupC5LHZWWmdicce1o4/doXFOo2lQ8RHac77I
 ekIHhoRG4dDRpn8Ie/n+GV20OsZqs2EADsxoN6mkZoe5gIhyM7j25as2h
 NbQ3wPqYEf4dRE9K+zFbFqxitmiUwd71Y6s7n1vcSftOhkJpFBy01dpia
 5yY0HzqBPErisMcBFfzytXsP/XanFv0wZmvYhFjFNXd5Qcw5XUFWo79YN
 xwmQs94gTb1fkOnrmUh4VbgEZ6gL3Dh4PusqVH5QQjaKjGGSkr9r/z5/t A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10978"; a="148950465"
X-IronPort-AV: E=Sophos;i="6.05,256,1701097200"; d="scan'208";a="148950465"
Received: from unknown (HELO oym-r2.gw.nic.fujitsu.com) ([210.162.30.90])
 by esa2.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Feb 2024 20:54:22 +0900
Received: from oym-m3.gw.nic.fujitsu.com (oym-nat-oym-m3.gw.nic.fujitsu.com
 [192.168.87.60])
 by oym-r2.gw.nic.fujitsu.com (Postfix) with ESMTP id 1C6A1F2D56
 for <qemu-devel@nongnu.org>; Fri,  9 Feb 2024 20:54:20 +0900 (JST)
Received: from kws-ab4.gw.nic.fujitsu.com (kws-ab4.gw.nic.fujitsu.com
 [192.51.206.22])
 by oym-m3.gw.nic.fujitsu.com (Postfix) with ESMTP id 521F9D6237
 for <qemu-devel@nongnu.org>; Fri,  9 Feb 2024 20:54:19 +0900 (JST)
Received: from edo.cn.fujitsu.com (edo.cn.fujitsu.com [10.167.33.5])
 by kws-ab4.gw.nic.fujitsu.com (Postfix) with ESMTP id E86D21E9568
 for <qemu-devel@nongnu.org>; Fri,  9 Feb 2024 20:54:18 +0900 (JST)
Received: from irides.g08.fujitsu.local (unknown [10.167.226.114])
 by edo.cn.fujitsu.com (Postfix) with ESMTP id 794861A00A1;
 Fri,  9 Feb 2024 19:54:18 +0800 (CST)
To: qemu-devel@nongnu.org,
	linux-cxl@vger.kernel.org
Cc: Jonathan.Cameron@huawei.com,
	dan.j.williams@intel.com
Subject: [RFC PATCH 2/2] hw/cxl/type3: send a GMER while injecting poison
Date: Fri,  9 Feb 2024 19:54:12 +0800
Message-Id: <20240209115417.724638-3-ruansy.fnst@fujitsu.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240209115417.724638-1-ruansy.fnst@fujitsu.com>
References: <20240209115417.724638-1-ruansy.fnst@fujitsu.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-TM-AS-Product-Ver: IMSS-9.1.0.1417-9.0.0.1002-28180.007
X-TM-AS-User-Approved-Sender: Yes
X-TMASE-Version: IMSS-9.1.0.1417-9.0.1002-28180.007
X-TMASE-Result: 10--6.213600-10.000000
X-TMASE-MatchedRID: QDRvHZvo+kv1zRJIGToPzk7nLUqYrlslFIuBIWrdOePfUZT83lbkEIJd
 /Yi3ky8jb7vhAFDgsdNFiEGX44FuA+UWmx8yAzoMfUkgDiuGxn99LQinZ4QefOYQ3zcXToXr+gt
 Hj7OwNO2OhzOa6g8KrQIvbT/YA/9KBTgUwp2Sy8TyO2GUnhfHBQyliSfkl61FtbbmxzTU8Oc=
X-TMASE-SNAP-Result: 1.821001.0001-0-1-22:0,33:0,34:0-0
Received-SPF: pass client-ip=207.54.90.48;
 envelope-from=ruansy.fnst@fujitsu.com; helo=esa2.hc1455-7.c3s2.iphmx.com
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

Send a signal to OS to let it able to handle the poison range.

TODO: This is an rough draft, will add more parameters for
qmp_cxl_inject_poison() to set to GMER.

Signed-off-by: Shiyang Ruan <ruansy.fnst@fujitsu.com>
---
 hw/mem/cxl_type3.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/hw/mem/cxl_type3.c b/hw/mem/cxl_type3.c
index d8fb63b1de..813f7f2175 100644
--- a/hw/mem/cxl_type3.c
+++ b/hw/mem/cxl_type3.c
@@ -1116,6 +1116,11 @@ void qmp_cxl_inject_poison(const char *path, uint64_t start, uint64_t length,
 
     QLIST_INSERT_HEAD(&ct3d->poison_list, p, node);
     ct3d->poison_list_cnt++;
+
+    /* Emit an GMER event, let os handle it */
+    qmp_cxl_inject_general_media_event(path, CXL_EVENT_LOG_FAILURE, 0, start,
+                                       0, 0, 4, false, 0, false, 0,
+                                       false, 0, NULL, errp);
 }
 
 /* For uncorrectable errors include support for multiple header recording */
-- 
2.34.1


