Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B83AAC79F82
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Sep 2026 20:01:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x2a54-0002MY-Ha; Fri, 04 Sep 2026 16:00:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1x2a53-0002I4-C7
 for qemu-devel@nongnu.org; Fri, 04 Sep 2026 16:00:09 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1x2a50-0008Dh-FQ
 for qemu-devel@nongnu.org; Fri, 04 Sep 2026 16:00:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1788552005;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=fIy5L6MZ2eAComYkK2Fb1gRtzJWseYqDPFDIG6vfhF0=;
 b=Fe0eDHxPxzutQL8MieK27lMjvaGjzWoT3BbziJFSIfeG2CjnFpSIimBiK2OVs5SOo1LpSJ
 VnqSZ/IfHf5cRLzSUhO0IDHD68ubhkQKeWWO0uMOgJxF1EkY4RtTbqNUWi/mTrOuU+X1fU
 X9YfHppcmOJG8U1BRxLy3y022nn22oQ=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-623-gv1EyEoTNgOztiVAIM3dOA-1; Fri,
 04 Sep 2026 16:00:02 -0400
X-MC-Unique: gv1EyEoTNgOztiVAIM3dOA-1
X-Mimecast-MFC-AGG-ID: gv1EyEoTNgOztiVAIM3dOA_1788551999
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 9339018E9B2C; Fri,  4 Sep 2026 19:59:59 +0000 (UTC)
Received: from localhost (headnet05.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.117])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id BA9541955F01; Fri,  4 Sep 2026 19:59:58 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Fri, 04 Sep 2026 23:58:13 +0400
Subject: [PATCH v4 30/75] ppc/spapr-caps: convert to QAPI-aware property
 registration
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260904-qom-qapi-v4-30-a985f168e938@redhat.com>
References: <20260904-qom-qapi-v4-0-a985f168e938@redhat.com>
In-Reply-To: <20260904-qom-qapi-v4-0-a985f168e938@redhat.com>
To: qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, 
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 Michael Roth <michael.roth@amd.com>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>, 
 Nicholas Piggin <npiggin@gmail.com>, 
 Harsh Prateek Bora <harshpb@linux.ibm.com>, 
 Amit Machhiwal <amachhiw@linux.ibm.com>, qemu-ppc@nongnu.org
X-Developer-Signature: v=1; a=openpgp-sha256; l=6665;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=fKax/bnWammaZosq8mXn1u3ZuVEpU9ijyyuMaCxA/Gg=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqmyLJA7QqSXxUBypbjk7AXG/r7x+48iRsw2039
 kAJdsrKbPCJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCapsiyQAKCRDa6OEJdZac
 5QfWD/97igbzMNx8aty9ODbtRhW848+/GhTjyyhexWlmer76XWvA/1t/sDQOYrNvD1/u3XuCTcg
 h8q7FTYYu/L632sA9oGf6GGvdAcaKAvK7vbFeBupFJ4oKvqeEla5Orn+lHIrZtyLZG8jAYRNp1A
 fQHvN6IcEb4EbmLtwJF+1VeiY4DQlr/9qlehRFCT/Kt09nX4imLD8sEfwNXVnqAS5cjJJ/jFxwX
 Altq2gauBxFaIYg6mzcSnFtZDGBPelVnTKhLMzTaxlAKv/09H3p1LM/U+qYuj5NRG+W+7R3K9QS
 saHyAIO5MzFzzNPEYeUqPHNpKKHGOXxYjwsGFnLVCEjRFFMkSDUw/re8tZ4CBmzFSefYpxBKNGz
 HxASX12H3ySsAKKZv5Ev8KvYi0959pgC1zsmrS3NvK4PgMGyO6mw5hJGspEKr6xGlzuqTB4/6hL
 k8LoNz6TLUGmNsI3f1Z+7UTPJZ14gfMe86B6W8fdY3J0YU52zhXLGcuyTXU+WQhWxma80IWfR69
 LFyXLtYRX+wj1roxHxjBKeltEpg7ce0ki+c3oNPRA18fs6yjG7SqlGTZdak9/2sYu/egUxvhDjb
 x0a8mzRoP3TXNpFvwONOyDL80eaklq7SNZhdmwQ/TRIgLyl9I6+6nXEFc5J9QBjuMXiIY5+7DE0
 RLCUtIgunFKTDew==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
index 0d659e9b0251..e622c79eb52a 100644
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


