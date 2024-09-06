Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5A94CE7B02
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Sep 2024 11:17:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1smWuU-0001Oe-9Q; Fri, 06 Sep 2024 07:13:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1smWuQ-000173-M1; Fri, 06 Sep 2024 07:13:46 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1smWuP-0007i0-0J; Fri, 06 Sep 2024 07:13:46 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 22D738C47A;
 Fri,  6 Sep 2024 14:12:07 +0300 (MSK)
Received: from tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with SMTP id 2C0C51336E4;
 Fri,  6 Sep 2024 14:13:25 +0300 (MSK)
Received: (nullmailer pid 353572 invoked by uid 1000);
 Fri, 06 Sep 2024 11:13:24 -0000
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Zhao Liu <zhao1.liu@intel.com>,
 Li Zhijian <lizhijian@fujitsu.com>, Xingtao Yao <yaoxt.fnst@fujitsu.com>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 "Michael S . Tsirkin" <mst@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-9.0.3 10/69] hw/cxl/cxl-host: Fix segmentation fault when
 getting cxl-fmw property
Date: Fri,  6 Sep 2024 14:12:19 +0300
Message-Id: <20240906111324.353230-10-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <qemu-stable-9.0.3-20240906141259@cover.tls.msk.ru>
References: <qemu-stable-9.0.3-20240906141259@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=86.62.121.231; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -68
X-Spam_score: -6.9
X-Spam_bar: ------
X-Spam_report: (-6.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_HI=-5,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

From: Zhao Liu <zhao1.liu@intel.com>

QEMU crashes (Segmentation fault) when getting cxl-fmw property via
qmp:

(QEMU) qom-get path=machine property=cxl-fmw

This issue is caused by accessing wrong callback (opaque) type in
machine_get_cfmw().

cxl_machine_init() sets the callback as `CXLState *` type but
machine_get_cfmw() treats the callback as
`CXLFixedMemoryWindowOptionsList **`.

Fix this error by casting opaque to `CXLState *` type in
machine_get_cfmw().

Fixes: 03b39fcf64bc ("hw/cxl: Make the CXL fixed memory window setup a machine parameter.")
Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
Reviewed-by: Li Zhijian <lizhijian@fujitsu.com>
Reviewed-by: Xingtao Yao <yaoxt.fnst@fujitsu.com>
Link: https://lore.kernel.org/r/20240704093404.1848132-1-zhao1.liu@linux.intel.com
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Message-Id: <20240705113956.941732-2-Jonathan.Cameron@huawei.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
(cherry picked from commit a207d5f87d66f7933b50677e047498fc4af63e1f)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/hw/cxl/cxl-host.c b/hw/cxl/cxl-host.c
index c5f5fcfd64..e9f2543c43 100644
--- a/hw/cxl/cxl-host.c
+++ b/hw/cxl/cxl-host.c
@@ -315,7 +315,8 @@ static void machine_set_cxl(Object *obj, Visitor *v, const char *name,
 static void machine_get_cfmw(Object *obj, Visitor *v, const char *name,
                              void *opaque, Error **errp)
 {
-    CXLFixedMemoryWindowOptionsList **list = opaque;
+    CXLState *state = opaque;
+    CXLFixedMemoryWindowOptionsList **list = &state->cfmw_list;
 
     visit_type_CXLFixedMemoryWindowOptionsList(v, name, list, errp);
 }
-- 
2.39.2


