Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9823104891F
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Feb 2026 22:32:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vw6Nh-0004BJ-9H; Fri, 27 Feb 2026 17:32:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shiju.jose@huawei.com>)
 id 1vw6Nf-0004Ab-UH
 for qemu-devel@nongnu.org; Fri, 27 Feb 2026 17:32:19 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shiju.jose@huawei.com>)
 id 1vw6Ne-0001k9-C2
 for qemu-devel@nongnu.org; Fri, 27 Feb 2026 17:32:19 -0500
Received: from mail.maildlp.com (unknown [172.18.224.150])
 by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4fN32Z0PKZzHnGfC;
 Sat, 28 Feb 2026 06:31:18 +0800 (CST)
Received: from dubpeml500008.china.huawei.com (unknown [7.214.146.94])
 by mail.maildlp.com (Postfix) with ESMTPS id B1FF44056E;
 Sat, 28 Feb 2026 06:32:04 +0800 (CST)
Received: from P_UKIT01-A7bmah.china.huawei.com (10.126.175.34) by
 dubpeml500008.china.huawei.com (7.214.146.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Fri, 27 Feb 2026 22:32:03 +0000
To: <qemu-devel@nongnu.org>, <linux-cxl@vger.kernel.org>, <mst@redhat.com>,
 <peter.maydell@linaro.org>, <jonathan.cameron@huawei.com>,
 <dave@stgolabs.net>
CC: <linuxarm@huawei.com>, <shiju.jose@huawei.com>
Subject: [PATCH 3/3] hw/cxl/events: Fixes for component id in event records
 generation
Date: Fri, 27 Feb 2026 22:32:06 +0000
Message-ID: <20260227223207.972-4-shiju.jose@huawei.com>
X-Mailer: git-send-email 2.43.0.windows.1
In-Reply-To: <20260227223207.972-1-shiju.jose@huawei.com>
References: <20260227223207.972-1-shiju.jose@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.175.34]
X-ClientProxiedBy: lhrpeml100012.china.huawei.com (7.191.174.184) To
 dubpeml500008.china.huawei.com (7.214.146.94)
Received-SPF: pass client-ip=185.176.79.56; envelope-from=shiju.jose@huawei.com;
 helo=frasgout.his.huawei.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.706, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.401,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Reply-to:  <shiju.jose@huawei.com>
From: shiju.jose--- via qemu development <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

From: Shiju Jose <shiju.jose@huawei.com>

Component id in CXL events is 16 bytes data, but event record generation copy
15 bytes only from the qmp "component-id" field using strncpy.
Replace strncpy with memcpy and change length of data to copy to the size of the
component_id array (16 bytes).

Signed-off-by: Shiju Jose <shiju.jose@huawei.com>
---
 hw/mem/cxl_type3.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/hw/mem/cxl_type3.c b/hw/mem/cxl_type3.c
index 3cb1096e16..03a5d1751f 100644
--- a/hw/mem/cxl_type3.c
+++ b/hw/mem/cxl_type3.c
@@ -1895,8 +1895,7 @@ void qmp_cxl_inject_general_media_event(const char *path, CxlEventLog log,
     }
 
     if (component_id) {
-        strncpy((char *)gem.component_id, component_id,
-                sizeof(gem.component_id) - 1);
+        memcpy(gem.component_id, component_id, sizeof(gem.component_id));
         valid_flags |= CXL_GMER_VALID_COMPONENT;
         if (has_comp_id_pldm && is_comp_id_pldm) {
             valid_flags |= CXL_GMER_VALID_COMPONENT_ID_FORMAT;
@@ -2066,8 +2065,7 @@ void qmp_cxl_inject_dram_event(const char *path, CxlEventLog log,
     }
 
     if (component_id) {
-        strncpy((char *)dram.component_id, component_id,
-                sizeof(dram.component_id) - 1);
+        memcpy(dram.component_id, component_id, sizeof(dram.component_id));
         valid_flags |= CXL_DRAM_VALID_COMPONENT;
         if (has_comp_id_pldm && is_comp_id_pldm) {
             valid_flags |= CXL_DRAM_VALID_COMPONENT_ID_FORMAT;
@@ -2185,8 +2183,7 @@ void qmp_cxl_inject_memory_module_event(const char *path, CxlEventLog log,
              corrected_persist_error_count);
 
     if (component_id) {
-        strncpy((char *)module.component_id, component_id,
-                sizeof(module.component_id) - 1);
+        memcpy(module.component_id, component_id, sizeof(module.component_id));
         valid_flags |= CXL_MMER_VALID_COMPONENT;
         if (has_comp_id_pldm && is_comp_id_pldm) {
             valid_flags |= CXL_MMER_VALID_COMPONENT_ID_FORMAT;
-- 
2.43.0


