Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AFAEBC25B74
	for <qemu-devel@archiver.kernel.org>; Thu, 16 May 2024 03:47:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s7S4Z-0001oE-7n; Wed, 15 May 2024 23:46:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lizhijian@fujitsu.com>)
 id 1s7S4S-0001Wh-CH
 for qemu-devel@nongnu.org; Wed, 15 May 2024 23:46:23 -0400
Received: from esa12.hc1455-7.c3s2.iphmx.com ([139.138.37.100])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lizhijian@fujitsu.com>)
 id 1s7S4O-0003Ih-C4
 for qemu-devel@nongnu.org; Wed, 15 May 2024 23:46:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj2;
 t=1715831176; x=1747367176;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=U9YYjJMtyPUoxkp85p3yIZTMu8Bf1O1cCDyTXHtYi2E=;
 b=d/rjpF5nqZ/vh3C2Ocxn66mTCSeKtrfPXamq3cjn6lsivKyJZVaATr+p
 2oG6J3kl50DhNyWOdsOq3ZRZKAStNF46IHd/2DzrmKtwufhvCHMQtX0zY
 3JOqy0OLYIwJ9b6oINE8reXCpnpyCqau+pJw4mOXR06CG0Q6V1RrOMynS
 phjy6AEHjNqRIWYIwlnj74DzO7JQAhnppBq6HREYr2f8WBxQk5xPswXtV
 PF/8gyOh8+CTtfmA7qlSeyig2PS+V7j9C01abmaGoVhY+9amYKiafGPNm
 6zahXw4I6LLTgYv23ctPuEMxlJTOhJO2yewycV9ln/RsNg5c6/bJaOMLj w==;
X-IronPort-AV: E=McAfee;i="6600,9927,11074"; a="137733514"
X-IronPort-AV: E=Sophos;i="6.08,163,1712588400"; d="scan'208";a="137733514"
Received: from unknown (HELO yto-r3.gw.nic.fujitsu.com) ([218.44.52.219])
 by esa12.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 May 2024 12:46:05 +0900
Received: from yto-m1.gw.nic.fujitsu.com (yto-nat-yto-m1.gw.nic.fujitsu.com
 [192.168.83.64])
 by yto-r3.gw.nic.fujitsu.com (Postfix) with ESMTP id 701D7C2ABD
 for <qemu-devel@nongnu.org>; Thu, 16 May 2024 12:46:03 +0900 (JST)
Received: from kws-ab3.gw.nic.fujitsu.com (kws-ab3.gw.nic.fujitsu.com
 [192.51.206.21])
 by yto-m1.gw.nic.fujitsu.com (Postfix) with ESMTP id A54F0D1714
 for <qemu-devel@nongnu.org>; Thu, 16 May 2024 12:46:02 +0900 (JST)
Received: from edo.cn.fujitsu.com (edo.cn.fujitsu.com [10.167.33.5])
 by kws-ab3.gw.nic.fujitsu.com (Postfix) with ESMTP id 32C5F20094AC3
 for <qemu-devel@nongnu.org>; Thu, 16 May 2024 12:46:02 +0900 (JST)
Received: from localhost.localdomain (unknown [10.167.226.45])
 by edo.cn.fujitsu.com (Postfix) with ESMTP id 95AFF1A000D;
 Thu, 16 May 2024 11:46:01 +0800 (CST)
To: Peter Xu <peterx@redhat.com>,
	Fabiano Rosas <farosas@suse.de>
Cc: Hailiang Zhang <zhanghailiang@xfusion.com>, qemu-devel@nongnu.org,
 Zhang Chen <chen.zhang@intel.com>, Li Zhijian <lizhijian@fujitsu.com>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [PATCH v2 3/3] migration/colo: Tidy up bql_unlock() around
 bdrv_activate_all()
Date: Thu, 16 May 2024 11:45:17 +0800
Message-Id: <20240516034517.1353664-3-lizhijian@fujitsu.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20240516034517.1353664-1-lizhijian@fujitsu.com>
References: <20240516034517.1353664-1-lizhijian@fujitsu.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-TM-AS-Product-Ver: IMSS-9.1.0.1417-9.0.0.1002-28390.004
X-TM-AS-User-Approved-Sender: Yes
X-TMASE-Version: IMSS-9.1.0.1417-9.0.1002-28390.004
X-TMASE-Result: 10--4.358700-10.000000
X-TMASE-MatchedRID: I1wtkSt6/wJTorztX3wKRDBgCmbnj9JmwTlc9CcHMZerwqxtE531VNnf
 JrUSEbFDNYCBzzxsUnthuO+F4DLKpT+7nvNv6fe6ngIgpj8eDcBpkajQR5gb3mn0m688Eo38Kra
 uXd3MZDXfhHcYdCBpjrxlGH8RZ8oGWC6H7V7TWa/romzRDvR5XHuCIRNxgi+MRUwpR/yl+NVeku
 7gWn86oV76bnOAkrpj+mA1sGeD9pUYigD+WO05IRXFEH92Kf64nTtPxlIuIBW9Hzj86YHXBCnif
 x5AGfCL
X-TMASE-SNAP-Result: 1.821001.0001-0-1-22:0,33:0,34:0-0
Received-SPF: pass client-ip=139.138.37.100;
 envelope-from=lizhijian@fujitsu.com; helo=esa12.hc1455-7.c3s2.iphmx.com
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

Suggested-by: Michael Tokarev <mjt@tls.msk.ru>
Reviewed-by: Peter Xu <peterx@redhat.com>
Reviewed-by: Zhang Chen <chen.zhang@intel.com>
Signed-off-by: Li Zhijian <lizhijian@fujitsu.com>
---
V2: Collected reviewed-by tags
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


