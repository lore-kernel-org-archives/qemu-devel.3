Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A69E1EDE9A6
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Sep 2024 16:47:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1so41Z-0006oK-W9; Tue, 10 Sep 2024 12:47:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1so41X-0006js-G7
 for qemu-devel@nongnu.org; Tue, 10 Sep 2024 12:47:27 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1so41U-0007Yv-M9
 for qemu-devel@nongnu.org; Tue, 10 Sep 2024 12:47:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1725986843;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=mIrpcTitkOc4K2UB5YyHsO9cfr2Gf4P39jPxeVVxCG8=;
 b=PHeWtE/Gq8zsstOgdjofzAVqT6RG1BAAfuFfsKjdhQ9E1seghVUy3Bqgd6qWEFMtSEAdMB
 axIehzgXz0Siogm/sLkw/OTKgT2eO/8mmX3DBCtxTJafniyoYepKJjautwYBkxUAIIFhaj
 Pb93zXvDSdW2AIfKJ6CefJqqDP5bU84=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-179-4j1Ak-sZNSex-qEkHyk4yA-1; Tue,
 10 Sep 2024 12:47:20 -0400
X-MC-Unique: 4j1Ak-sZNSex-qEkHyk4yA-1
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 9B1A119560A7; Tue, 10 Sep 2024 16:47:19 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.112])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 3E08E1956048; Tue, 10 Sep 2024 16:47:19 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 8814621E68B2; Tue, 10 Sep 2024 18:47:14 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org,
	Zhao Liu <zhao1.liu@intel.com>
Subject: [PULL 07/19] qapi/machine: Drop temporary 'prefix'
Date: Tue, 10 Sep 2024 18:47:02 +0200
Message-ID: <20240910164714.1993531-8-armbru@redhat.com>
In-Reply-To: <20240910164714.1993531-1-armbru@redhat.com>
References: <20240910164714.1993531-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.145,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Recent commit "qapi: Smarter camel_to_upper() to reduce need for
'prefix'" added a temporary 'prefix' to delay changing the generated
code.

Revert it.  This improves HmatLBDataType's generated enumeration
constant prefix from HMATLB_DATA_TYPE to HMAT_LB_DATA_TYPE, and
HmatLBMemoryHierarchy's from HMATLB_MEMORY_HIERARCHY to
HMAT_LB_MEMORY_HIERARCHY.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
Reviewed-by: Zhao Liu <zhao1.liu@intel.com>
Message-ID: <20240904111836.3273842-8-armbru@redhat.com>
---
 qapi/machine.json            | 2 --
 hw/core/numa.c               | 4 ++--
 hw/pci-bridge/cxl_upstream.c | 4 ++--
 3 files changed, 4 insertions(+), 6 deletions(-)

diff --git a/qapi/machine.json b/qapi/machine.json
index 552d1c20e9..d4317435e7 100644
--- a/qapi/machine.json
+++ b/qapi/machine.json
@@ -686,7 +686,6 @@
 # Since: 5.0
 ##
 { 'enum': 'HmatLBMemoryHierarchy',
-  'prefix': 'HMATLB_MEMORY_HIERARCHY', # TODO drop
   'data': [ 'memory', 'first-level', 'second-level', 'third-level' ] }
 
 ##
@@ -713,7 +712,6 @@
 # Since: 5.0
 ##
 { 'enum': 'HmatLBDataType',
-  'prefix': 'HMATLB_DATA_TYPE', # TODO drop
   'data': [ 'access-latency', 'read-latency', 'write-latency',
             'access-bandwidth', 'read-bandwidth', 'write-bandwidth' ] }
 
diff --git a/hw/core/numa.c b/hw/core/numa.c
index f8ce332cfe..fb81c1ed51 100644
--- a/hw/core/numa.c
+++ b/hw/core/numa.c
@@ -249,7 +249,7 @@ void parse_numa_hmat_lb(NumaState *numa_state, NumaHmatLBOptions *node,
     lb_data.initiator = node->initiator;
     lb_data.target = node->target;
 
-    if (node->data_type <= HMATLB_DATA_TYPE_WRITE_LATENCY) {
+    if (node->data_type <= HMAT_LB_DATA_TYPE_WRITE_LATENCY) {
         /* Input latency data */
 
         if (!node->has_latency) {
@@ -313,7 +313,7 @@ void parse_numa_hmat_lb(NumaState *numa_state, NumaHmatLBOptions *node,
             numa_info[node->target].lb_info_provided |= BIT(0);
         }
         lb_data.data = node->latency;
-    } else if (node->data_type >= HMATLB_DATA_TYPE_ACCESS_BANDWIDTH) {
+    } else if (node->data_type >= HMAT_LB_DATA_TYPE_ACCESS_BANDWIDTH) {
         /* Input bandwidth data */
         if (!node->has_bandwidth) {
             error_setg(errp, "Missing 'bandwidth' option");
diff --git a/hw/pci-bridge/cxl_upstream.c b/hw/pci-bridge/cxl_upstream.c
index e51221a5f3..f3e46f0651 100644
--- a/hw/pci-bridge/cxl_upstream.c
+++ b/hw/pci-bridge/cxl_upstream.c
@@ -234,7 +234,7 @@ static int build_cdat_table(CDATSubHeader ***cdat_table, void *priv)
                 .type = CDAT_TYPE_SSLBIS,
                 .length = sslbis_size,
             },
-            .data_type = HMATLB_DATA_TYPE_ACCESS_LATENCY,
+            .data_type = HMAT_LB_DATA_TYPE_ACCESS_LATENCY,
             .entry_base_unit = 10000,
         },
     };
@@ -254,7 +254,7 @@ static int build_cdat_table(CDATSubHeader ***cdat_table, void *priv)
                 .type = CDAT_TYPE_SSLBIS,
                 .length = sslbis_size,
             },
-            .data_type = HMATLB_DATA_TYPE_ACCESS_BANDWIDTH,
+            .data_type = HMAT_LB_DATA_TYPE_ACCESS_BANDWIDTH,
             .entry_base_unit = 1024,
         },
     };
-- 
2.46.0


