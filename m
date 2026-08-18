Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59CF3C5DF70
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Aug 2026 11:20:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wwHrF-0005Vo-0R; Tue, 18 Aug 2026 07:19:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wwHrD-0005Ml-Bj
 for qemu-devel@nongnu.org; Tue, 18 Aug 2026 07:19:51 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wwHrB-0006Rs-GT
 for qemu-devel@nongnu.org; Tue, 18 Aug 2026 07:19:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1787051989;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=RPcruoiWfQb//Iziqzwy/I1OFm7hs2mQYcnU85gOfKE=;
 b=cIcqH35F7T8it2YGoZ0dClMRp2TUHAgRdaG5foGY8hZLOK6xJnGkqNy/M/LPqsbPoC9XS1
 /7pUKaUA2U1kXW3cH4YQhAStOfXHP/Qlow2Xz1edUlEKu7yik9E3lhn3de+QoP7W3EGT9K
 +yLBWuUphVA/ML6yAgQTP46babbwADI=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-496--4WA-pPjNvyx08r9Mi5Wug-1; Tue,
 18 Aug 2026 07:19:45 -0400
X-MC-Unique: -4WA-pPjNvyx08r9Mi5Wug-1
X-Mimecast-MFC-AGG-ID: -4WA-pPjNvyx08r9Mi5Wug_1787051984
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 516DF1800848; Tue, 18 Aug 2026 11:19:44 +0000 (UTC)
Received: from localhost (headnet05.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.117])
 by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id CF4D5434; Tue, 18 Aug 2026 11:19:39 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Tue, 18 Aug 2026 15:10:56 +0400
Subject: [PATCH v3 29/74] ppc/spapr-caps: convert to QAPI-aware property
 registration
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260818-qom-qapi-v3-29-24b8bbbe3d86@redhat.com>
References: <20260818-qom-qapi-v3-0-24b8bbbe3d86@redhat.com>
In-Reply-To: <20260818-qom-qapi-v3-0-24b8bbbe3d86@redhat.com>
To: qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, 
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 Michael Roth <michael.roth@amd.com>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@mailo.com>, 
 Nicholas Piggin <npiggin@gmail.com>, 
 Harsh Prateek Bora <harshpb@linux.ibm.com>, qemu-ppc@nongnu.org
X-Developer-Signature: v=1; a=openpgp-sha256; l=6665;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=MtxWpL3jS0tdQScwSXFQevx3JX5MXkf3XyZVu0dDl2A=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqhD25jZ7WsY131VjwGBtmLX3X/GYVlhUtgCset
 uZhJrIpvm6JAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCaoQ9uQAKCRDa6OEJdZac
 5TQuEACuKEsnufgLrsGUd88zqzZG2J7GOmY0I6pzudN94/vv2zAFk6xFN/Oq9GrIxul6c7GLdNx
 bvocmxovi9zgCbd1J/fx+cjrNHfkX5g6OqjYjJ+lDpCM9kCRfc8hqh+JAQ8M3kH1R7DirhZ3ZjR
 BCPvMb+nhjBgXrYtO6vBbGsHDKVk8O+p+4NcmMKP1zIOY9de8EX1UBlfMHLte2Szm9NL8mANY8p
 sO+k424iTnEfnLfGjQVZyQMDHNDRmHpf1xI3Ks2Ai7JD+WaMT+sQHbSDUrgABrTMnwJ+NZke6/S
 1YjMagieSTZQBjv+4EBgzH/WiL8RAvsClkKvypIteWJIirl45e5WfyPdtBQ0cUoy3K3LvBtFtNk
 /3VRT4pzBS2vM0zE42XBunbuCzPL8cbRZIHTqXZBjAFe0FX/xq8OUw/br73MfsJFO8uwqk5MD34
 BPoG/kET63x48RjHjEFQ9h71yu5jQYDdg+VYsPnq6PYTj7kdTrgEkFoIAOYIcfT3xOCuEZGQtWP
 0OPd4DRD6AUlaMbOVLSELxEjQHrDd6Zeg12PIDvjZ4CWHbSrNgmBlK7W7eaXOoLrs1hI9pwm7Ld
 UU7UIT+tiW9ThG5pTJBYQJP/ZsGjuxW0XcZNyJQFqRA4+rbmBZrCOKb1kCj2O7aU7HrwXSrf1lR
 JTDw1kMiR4omMjg==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.343,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 hw/ppc/spapr_caps.c | 39 ++++++++++++++++++++-------------------
 1 file changed, 20 insertions(+), 19 deletions(-)

diff --git a/hw/ppc/spapr_caps.c b/hw/ppc/spapr_caps.c
index f4a26a85b504..779a5605a8ff 100644
--- a/hw/ppc/spapr_caps.c
+++ b/hw/ppc/spapr_caps.c
@@ -24,6 +24,7 @@
 
 #include "qemu/osdep.h"
 #include "qemu/error-report.h"
+#include "qapi/qapi-builtin-type-infos.h"
 #include "qapi/error.h"
 #include "qapi/visitor.h"
 #include "system/hw_accel.h"
@@ -59,7 +60,7 @@ typedef struct SpaprCapabilityInfo {
     /* Getter and Setter Function Pointers */
     ObjectPropertyAccessor *get;
     ObjectPropertyAccessor *set;
-    const char *type;
+    const QAPITypeInfo *type;
     /* Possible values if this is a custom string type */
     SpaprCapPossible *possible;
     /* Make sure the virtual hardware can support this capability */
@@ -725,7 +726,7 @@ SpaprCapabilityInfo capability_table[SPAPR_CAP_NUM] = {
         .index = SPAPR_CAP_HTM,
         .get = spapr_cap_get_bool,
         .set = spapr_cap_set_bool,
-        .type = "bool",
+        .type = &bool_type_info,
         .apply = cap_htm_apply,
     },
     [SPAPR_CAP_VSX] = {
@@ -734,7 +735,7 @@ SpaprCapabilityInfo capability_table[SPAPR_CAP_NUM] = {
         .index = SPAPR_CAP_VSX,
         .get = spapr_cap_get_bool,
         .set = spapr_cap_set_bool,
-        .type = "bool",
+        .type = &bool_type_info,
         .apply = cap_vsx_apply,
     },
     [SPAPR_CAP_DFP] = {
@@ -743,7 +744,7 @@ SpaprCapabilityInfo capability_table[SPAPR_CAP_NUM] = {
         .index = SPAPR_CAP_DFP,
         .get = spapr_cap_get_bool,
         .set = spapr_cap_set_bool,
-        .type = "bool",
+        .type = &bool_type_info,
         .apply = cap_dfp_apply,
     },
     [SPAPR_CAP_CFPC] = {
@@ -752,7 +753,7 @@ SpaprCapabilityInfo capability_table[SPAPR_CAP_NUM] = {
         .index = SPAPR_CAP_CFPC,
         .get = spapr_cap_get_string,
         .set = spapr_cap_set_string,
-        .type = "string",
+        .type = &str_type_info,
         .possible = &cap_cfpc_possible,
         .apply = cap_safe_cache_apply,
     },
@@ -762,7 +763,7 @@ SpaprCapabilityInfo capability_table[SPAPR_CAP_NUM] = {
         .index = SPAPR_CAP_SBBC,
         .get = spapr_cap_get_string,
         .set = spapr_cap_set_string,
-        .type = "string",
+        .type = &str_type_info,
         .possible = &cap_sbbc_possible,
         .apply = cap_safe_bounds_check_apply,
     },
@@ -774,7 +775,7 @@ SpaprCapabilityInfo capability_table[SPAPR_CAP_NUM] = {
         .index = SPAPR_CAP_IBS,
         .get = spapr_cap_get_string,
         .set = spapr_cap_set_string,
-        .type = "string",
+        .type = &str_type_info,
         .possible = &cap_ibs_possible,
         .apply = cap_safe_indirect_branch_apply,
     },
@@ -784,7 +785,7 @@ SpaprCapabilityInfo capability_table[SPAPR_CAP_NUM] = {
         .index = SPAPR_CAP_HPT_MAXPAGESIZE,
         .get = spapr_cap_get_pagesize,
         .set = spapr_cap_set_pagesize,
-        .type = "int",
+        .type = &size_type_info,
         .apply = cap_hpt_maxpagesize_apply,
         .cpu_apply = cap_hpt_maxpagesize_cpu_apply,
     },
@@ -794,7 +795,7 @@ SpaprCapabilityInfo capability_table[SPAPR_CAP_NUM] = {
         .index = SPAPR_CAP_NESTED_KVM_HV,
         .get = spapr_cap_get_bool,
         .set = spapr_cap_set_bool,
-        .type = "bool",
+        .type = &bool_type_info,
         .apply = cap_nested_kvm_hv_apply,
     },
     [SPAPR_CAP_NESTED_PAPR] = {
@@ -803,7 +804,7 @@ SpaprCapabilityInfo capability_table[SPAPR_CAP_NUM] = {
         .index = SPAPR_CAP_NESTED_PAPR,
         .get = spapr_cap_get_bool,
         .set = spapr_cap_set_bool,
-        .type = "bool",
+        .type = &bool_type_info,
         .apply = cap_nested_papr_apply,
     },
     [SPAPR_CAP_LARGE_DECREMENTER] = {
@@ -812,7 +813,7 @@ SpaprCapabilityInfo capability_table[SPAPR_CAP_NUM] = {
         .index = SPAPR_CAP_LARGE_DECREMENTER,
         .get = spapr_cap_get_bool,
         .set = spapr_cap_set_bool,
-        .type = "bool",
+        .type = &bool_type_info,
         .apply = cap_large_decr_apply,
         .cpu_apply = cap_large_decr_cpu_apply,
     },
@@ -822,7 +823,7 @@ SpaprCapabilityInfo capability_table[SPAPR_CAP_NUM] = {
         .index = SPAPR_CAP_CCF_ASSIST,
         .get = spapr_cap_get_bool,
         .set = spapr_cap_set_bool,
-        .type = "bool",
+        .type = &bool_type_info,
         .apply = cap_ccf_assist_apply,
     },
     [SPAPR_CAP_FWNMI] = {
@@ -831,7 +832,7 @@ SpaprCapabilityInfo capability_table[SPAPR_CAP_NUM] = {
         .index = SPAPR_CAP_FWNMI,
         .get = spapr_cap_get_bool,
         .set = spapr_cap_set_bool,
-        .type = "bool",
+        .type = &bool_type_info,
         .apply = cap_fwnmi_apply,
     },
     [SPAPR_CAP_RPT_INVALIDATE] = {
@@ -840,7 +841,7 @@ SpaprCapabilityInfo capability_table[SPAPR_CAP_NUM] = {
         .index = SPAPR_CAP_RPT_INVALIDATE,
         .get = spapr_cap_get_bool,
         .set = spapr_cap_set_bool,
-        .type = "bool",
+        .type = &bool_type_info,
         .apply = cap_rpt_invalidate_apply,
     },
     [SPAPR_CAP_AIL_MODE_3] = {
@@ -849,7 +850,7 @@ SpaprCapabilityInfo capability_table[SPAPR_CAP_NUM] = {
         .index = SPAPR_CAP_AIL_MODE_3,
         .get = spapr_cap_get_bool,
         .set = spapr_cap_set_bool,
-        .type = "bool",
+        .type = &bool_type_info,
         .apply = cap_ail_mode_3_apply,
     },
     [SPAPR_CAP_DAWR1] = {
@@ -858,7 +859,7 @@ SpaprCapabilityInfo capability_table[SPAPR_CAP_NUM] = {
         .index = SPAPR_CAP_DAWR1,
         .get = spapr_cap_get_bool,
         .set = spapr_cap_set_bool,
-        .type = "bool",
+        .type = &bool_type_info,
         .apply = cap_dawr1_apply,
     },
 };
@@ -1069,9 +1070,9 @@ void spapr_caps_add_properties(SpaprMachineClass *smc)
         g_autofree char *name = g_strdup_printf("cap-%s", cap->name);
         g_autofree char *desc = g_strdup(cap->description);
 
-        object_class_property_add(klass, name, cap->type,
-                                  cap->get, cap->set,
-                                  NULL, cap);
+        object_class_property_add_qapi(klass, name, cap->type,
+                                       cap->get, cap->set,
+                                       NULL, cap);
 
         object_class_property_set_description(klass, name, desc);
     }

-- 
2.55.0.543.g5ebe2ebe4ea8


