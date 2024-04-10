Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A5E2CD1296
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Apr 2024 07:27:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ruSKs-0005DK-0E; Wed, 10 Apr 2024 03:25:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1ruSKG-00040o-U3; Wed, 10 Apr 2024 03:24:58 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1ruSKD-0004E4-TV; Wed, 10 Apr 2024 03:24:56 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 2A6465D687;
 Wed, 10 Apr 2024 10:25:04 +0300 (MSK)
Received: from tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with SMTP id C3CAAB02C8;
 Wed, 10 Apr 2024 10:23:05 +0300 (MSK)
Received: (nullmailer pid 4191718 invoked by uid 1000);
 Wed, 10 Apr 2024 07:23:04 -0000
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 "Michael S . Tsirkin" <mst@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-8.2.3 24/87] hmat acpi: Fix out of bounds access due to
 missing use of indirection
Date: Wed, 10 Apr 2024 10:21:57 +0300
Message-Id: <20240410072303.4191455-24-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <qemu-stable-8.2.3-20240410085155@cover.tls.msk.ru>
References: <qemu-stable-8.2.3-20240410085155@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=86.62.121.231; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -68
X-Spam_score: -6.9
X-Spam_bar: ------
X-Spam_report: (-6.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_HI=-5,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

With a numa set up such as

-numa nodeid=0,cpus=0 \
-numa nodeid=1,memdev=mem \
-numa nodeid=2,cpus=1

and appropriate hmat_lb entries the initiator list is correctly
computed and writen to HMAT as 0,2 but then the LB data is accessed
using the node id (here 2), landing outside the entry_list array.

Stash the reverse lookup when writing the initiator list and use
it to get the correct array index index.

Fixes: 4586a2cb83 ("hmat acpi: Build System Locality Latency and Bandwidth Information Structure(s)")
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Message-Id: <20240307160326.31570-3-Jonathan.Cameron@huawei.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
(cherry picked from commit 74e2845c5f95b0c139c79233ddb65bb17f2dd679)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/hw/acpi/hmat.c b/hw/acpi/hmat.c
index 3042d223c8..2f3a2362bd 100644
--- a/hw/acpi/hmat.c
+++ b/hw/acpi/hmat.c
@@ -78,6 +78,7 @@ static void build_hmat_lb(GArray *table_data, HMAT_LB_Info *hmat_lb,
                           uint32_t *initiator_list)
 {
     int i, index;
+    uint32_t initiator_to_index[MAX_NODES] = {};
     HMAT_LB_Data *lb_data;
     uint16_t *entry_list;
     uint32_t base;
@@ -121,6 +122,8 @@ static void build_hmat_lb(GArray *table_data, HMAT_LB_Info *hmat_lb,
     /* Initiator Proximity Domain List */
     for (i = 0; i < num_initiator; i++) {
         build_append_int_noprefix(table_data, initiator_list[i], 4);
+        /* Reverse mapping for array possitions */
+        initiator_to_index[initiator_list[i]] = i;
     }
 
     /* Target Proximity Domain List */
@@ -132,7 +135,8 @@ static void build_hmat_lb(GArray *table_data, HMAT_LB_Info *hmat_lb,
     entry_list = g_new0(uint16_t, num_initiator * num_target);
     for (i = 0; i < hmat_lb->list->len; i++) {
         lb_data = &g_array_index(hmat_lb->list, HMAT_LB_Data, i);
-        index = lb_data->initiator * num_target + lb_data->target;
+        index = initiator_to_index[lb_data->initiator] * num_target +
+            lb_data->target;
 
         entry_list[index] = (uint16_t)(lb_data->data / hmat_lb->base);
     }
-- 
2.39.2


