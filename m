Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C08E8C3DA61
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jul 2024 08:14:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sYhwl-0005XI-1j; Tue, 30 Jul 2024 04:11:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1sYhwi-0005N7-Ma
 for qemu-devel@nongnu.org; Tue, 30 Jul 2024 04:11:00 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1sYhwa-0001H9-H9
 for qemu-devel@nongnu.org; Tue, 30 Jul 2024 04:11:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1722327051;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=DV7+EVWYFbrbaXV5c6Y9cFzbPTN8d8JAt36ne5Q5Nhc=;
 b=cIBdOUH2l5j2yHyzuGkuxF009lTIMbaQw9qOhMiOoOHZRD9cgQa32VclnRMfNFV9OdcHlg
 CPnA7Iq6X15GX9nUtBerRwPPa7IVlLxSFR3OVlPINuIEmZtcnNONYllmkuJEXScrIw0M4J
 WWXiMlOjO7/yo9sCyQnyouEJQXkYgxs=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-663-HO2voRrbNwuPaRTmjAxVvQ-1; Tue,
 30 Jul 2024 04:10:47 -0400
X-MC-Unique: HO2voRrbNwuPaRTmjAxVvQ-1
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id AD9A819560B0; Tue, 30 Jul 2024 08:10:42 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.65])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 9168E300018D; Tue, 30 Jul 2024 08:10:41 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id E265121F4B94; Tue, 30 Jul 2024 10:10:32 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, andrew@codeconstruct.com.au, andrew@daynix.com,
 arei.gonglei@huawei.com, berrange@redhat.com, berto@igalia.com,
 borntraeger@linux.ibm.com, clg@kaod.org, david@redhat.com, den@openvz.org,
 eblake@redhat.com, eduardo@habkost.net, farman@linux.ibm.com,
 farosas@suse.de, hreitz@redhat.com, idryomov@gmail.com, iii@linux.ibm.com,
 jamin_lin@aspeedtech.com, jasowang@redhat.com, joel@jms.id.au,
 jsnow@redhat.com, kwolf@redhat.com, leetroy@gmail.com,
 marcandre.lureau@redhat.com, marcel.apfelbaum@gmail.com,
 michael.roth@amd.com, mst@redhat.com, mtosatti@redhat.com,
 nsg@linux.ibm.com, pasic@linux.ibm.com, pbonzini@redhat.com,
 peter.maydell@linaro.org, peterx@redhat.com, philmd@linaro.org,
 pizhenwei@bytedance.com, pl@dlhnet.de, richard.henderson@linaro.org,
 stefanha@redhat.com, steven_lee@aspeedtech.com, thuth@redhat.com,
 vsementsov@yandex-team.ru, wangyanan55@huawei.com,
 yuri.benditovich@daynix.com, zhao1.liu@intel.com, qemu-block@nongnu.org,
 qemu-arm@nongnu.org, qemu-s390x@nongnu.org, kvm@vger.kernel.org
Subject: [PATCH 07/18] qapi/machine: Drop temporary 'prefix'
Date: Tue, 30 Jul 2024 10:10:21 +0200
Message-ID: <20240730081032.1246748-8-armbru@redhat.com>
In-Reply-To: <20240730081032.1246748-1-armbru@redhat.com>
References: <20240730081032.1246748-1-armbru@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.125,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
constant prefix from HMATLB_DATA_TYPE to HMAT_LB_DATA_TYPE.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 qapi/machine.json            | 1 -
 hw/core/numa.c               | 4 ++--
 hw/pci-bridge/cxl_upstream.c | 4 ++--
 3 files changed, 4 insertions(+), 5 deletions(-)

diff --git a/qapi/machine.json b/qapi/machine.json
index 5514450e12..fcfd249e2d 100644
--- a/qapi/machine.json
+++ b/qapi/machine.json
@@ -712,7 +712,6 @@
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
2.45.0


