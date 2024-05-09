Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D3BFC10F1A
	for <qemu-devel@archiver.kernel.org>; Thu,  9 May 2024 03:29:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s4uRl-0003cu-RD; Wed, 08 May 2024 23:27:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lizhijian@fujitsu.com>)
 id 1s4uRk-0003cG-7x
 for qemu-devel@nongnu.org; Wed, 08 May 2024 23:27:52 -0400
Received: from esa5.hc1455-7.c3s2.iphmx.com ([68.232.139.130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lizhijian@fujitsu.com>)
 id 1s4uRh-000463-4H
 for qemu-devel@nongnu.org; Wed, 08 May 2024 23:27:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj2;
 t=1715225267; x=1746761267;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=GVmhNWvYuMl+TRo5ZwhycrsRqLYEmLmpGwmGYuDtGvM=;
 b=jJ0h6GwR0BkFSVpgGrNAL59Lu7qRvlLh0OpwvUJZL5hHUHSe2AmIwtwE
 puUdr1KiBKDmYJ59AfFnWAcjyJ+9GhkyvvODgeHecQ4/y4STOYKSi9f4K
 KGiCrH6Vjj8s3h9YQxA7Re4mMPYS6xTEGU4OQkg2L5BFzz5TXfV9aTC0r
 9hY6j6SaHbVGVelIjz7TZpejMnnWb+gCUvYNZl/GoGJCPiw+Uovk65+Uc
 oQiovGIPgy++UN5tYS2bxoLqtDRINFF+5gdUcCEAFlLkwaLWv+0yfUWyI
 JdV+4phj2+4QCqixU0g2F50Qif/vIiDhaBQWOBn3LUStg+0q5On8PxJWv g==;
X-IronPort-AV: E=McAfee;i="6600,9927,11067"; a="157165426"
X-IronPort-AV: E=Sophos;i="6.08,146,1712588400"; d="scan'208";a="157165426"
Received: from unknown (HELO oym-r1.gw.nic.fujitsu.com) ([210.162.30.89])
 by esa5.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 May 2024 12:27:42 +0900
Received: from oym-m2.gw.nic.fujitsu.com (oym-nat-oym-m2.gw.nic.fujitsu.com
 [192.168.87.59])
 by oym-r1.gw.nic.fujitsu.com (Postfix) with ESMTP id BF6C4E8E1C
 for <qemu-devel@nongnu.org>; Thu,  9 May 2024 12:27:41 +0900 (JST)
Received: from kws-ab4.gw.nic.fujitsu.com (kws-ab4.gw.nic.fujitsu.com
 [192.51.206.22])
 by oym-m2.gw.nic.fujitsu.com (Postfix) with ESMTP id F2D7CBDB6A
 for <qemu-devel@nongnu.org>; Thu,  9 May 2024 12:27:40 +0900 (JST)
Received: from edo.cn.fujitsu.com (edo.cn.fujitsu.com [10.167.33.5])
 by kws-ab4.gw.nic.fujitsu.com (Postfix) with ESMTP id 8A5262C666F
 for <qemu-devel@nongnu.org>; Thu,  9 May 2024 12:27:40 +0900 (JST)
Received: from localhost.localdomain (unknown [10.167.226.45])
 by edo.cn.fujitsu.com (Postfix) with ESMTP id E98651A000D;
 Thu,  9 May 2024 11:27:39 +0800 (CST)
To: Peter Xu <peterx@redhat.com>,
	Fabiano Rosas <farosas@suse.de>
Cc: Hailiang Zhang <zhanghailiang@xfusion.com>, qemu-devel@nongnu.org,
 Zhang Chen <chen.zhang@intel.com>, Li Zhijian <lizhijian@fujitsu.com>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [PATCH 3/3] migration/colo: Tidy up bql_unlock() around
 bdrv_activate_all()
Date: Thu,  9 May 2024 11:31:06 +0800
Message-Id: <20240509033106.1321880-3-lizhijian@fujitsu.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20240509033106.1321880-1-lizhijian@fujitsu.com>
References: <20240509033106.1321880-1-lizhijian@fujitsu.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-TM-AS-Product-Ver: IMSS-9.1.0.1417-9.0.0.1002-28372.002
X-TM-AS-User-Approved-Sender: Yes
X-TMASE-Version: IMSS-9.1.0.1417-9.0.1002-28372.002
X-TMASE-Result: 10--4.358700-10.000000
X-TMASE-MatchedRID: 9IrrHbNZyfpTorztX3wKRDBgCmbnj9JmwTlc9CcHMZerwqxtE531VNnf
 JrUSEbFDNYCBzzxsUnthuO+F4DLKpT+7nvNv6fe6ngIgpj8eDcBpkajQR5gb3savT21DsLD/UEh
 Wy9W70AEnRE+fI6etkmyD8trkO9mdwWwytO4EycIFdnSoTuV8apA1918zzYNWEwNF9ZEUYf9/da
 oMYxPppOWbgU3/1d0vmuemDR7HHuUf7ftDL+jmBcBgvHuudtHysNDybdOqCWh6WkJecb4mO8MYF
 nUbyvVJ/YPqDH/SjOk=
X-TMASE-SNAP-Result: 1.821001.0001-0-1-22:0,33:0,34:0-0
Received-SPF: pass client-ip=68.232.139.130;
 envelope-from=lizhijian@fujitsu.com; helo=esa5.hc1455-7.c3s2.iphmx.com
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
Reply-to:  Li Zhijian <lizhijian@fujitsu.com>
From:  Li Zhijian via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Make the code more tight.

Cc: Michael Tokarev <mjt@tls.msk.ru>
Signed-off-by: Li Zhijian <lizhijian@fujitsu.com>
---
This change/comment suggested by "Michael Tokarev <mjt@tls.msk.ru>" came
a bit late at that time, let's update it together in these minor set
this time.
---
 migration/colo.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/migration/colo.c b/migration/colo.c
index 991806c06a..1b6d9da1c8 100644
--- a/migration/colo.c
+++ b/migration/colo.c
@@ -838,12 +838,11 @@ static void *colo_process_incoming_thread(void *opaque)
     /* Make sure all file formats throw away their mutable metadata */
     bql_lock();
     bdrv_activate_all(&local_err);
+    bql_unlock();
     if (local_err) {
-        bql_unlock();
         error_report_err(local_err);
         return NULL;
     }
-    bql_unlock();
 
     failover_init_state();
 
-- 
2.31.1


