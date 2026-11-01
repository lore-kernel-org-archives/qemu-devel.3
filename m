Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF14F606A325
	for <qemu-devel@archiver.kernel.org>; Sun,  1 Nov 2026 20:19:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=LzBwVojE
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xNc0V-0005SS-W8; Sun, 01 Nov 2026 15:18:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1xNbzn-0004yF-Mt
 for qemu-devel@nongnu.org; Sun, 01 Nov 2026 15:17:39 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1xNbze-0007CL-Dd
 for qemu-devel@nongnu.org; Sun, 01 Nov 2026 15:17:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1793564249;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=YmZMc9TQwrpq/2MUPnUA00TMj+1dqZbLt5kf6ZI3Qqw=;
 b=LzBwVojEJo9+2b3C1/GjKd1GiRMYtWpN6l3F2Iygj6NaMOxNTexT5e73foA/awh7T9iZDk
 wfJMm0FyL33dU8uI3JijhGmsp56PF9UOP4aLOwXf+ct8Y1GSBbQE7gevr3WFGYEqykEEHD
 2AVgXJA8xfNEQpgYjG3ydxdgPgDGO5U=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-466-yBJa6u0gM6mziFNvjXEf0A-1; Sun,
 01 Nov 2026 15:17:28 -0500
X-MC-Unique: yBJa6u0gM6mziFNvjXEf0A-1
X-Mimecast-MFC-AGG-ID: yBJa6u0gM6mziFNvjXEf0A_1793564247
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 8D2CD1954AEF; Sun,  1 Nov 2026 20:17:26 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.44.22.2])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id D869D3000B7A; Sun,  1 Nov 2026 20:17:25 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 301EE21E68A5; Sun, 01 Nov 2026 21:17:18 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: marcandre.lureau@redhat.com, pbonzini@redhat.com, berrange@redhat.com,
 Amit Machhiwal <amachhiw@linux.ibm.com>
Subject: [PATCH v8 32/56] ppc/spapr-caps: convert to QAPI-aware property
 registration
Date: Sun,  1 Nov 2026 21:16:53 +0100
Message-ID: <20261101201717.3911097-33-armbru@redhat.com>
In-Reply-To: <20261101201717.3911097-1-armbru@redhat.com>
References: <20261101201717.3911097-1-armbru@redhat.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 5
X-Spam_score: 0.5
X-Spam_bar: /
X-Spam_report: (0.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Marc-André Lureau <marcandre.lureau@redhat.com>

Add QAPITypeInfo to SpaprCapabilityInfo, and make
spapr_caps_add_properties() pass it to object_class_property_add().

Reviewed-by: Amit Machhiwal <amachhiw@linux.ibm.com>
Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 hw/ppc/spapr_caps.c | 19 ++++++++++++++++++-
 1 file changed, 18 insertions(+), 1 deletion(-)

diff --git a/hw/ppc/spapr_caps.c b/hw/ppc/spapr_caps.c
index b8c48bca8a..79b1cc2e1d 100644
--- a/hw/ppc/spapr_caps.c
+++ b/hw/ppc/spapr_caps.c
@@ -24,6 +24,7 @@
 
 #include "qemu/osdep.h"
 #include "qemu/error-report.h"
+#include "qapi/qapi-builtin-type-infos.h"
 #include "qapi/error.h"
 #include "qapi/visitor.h"
 #include "system/hw_accel.h"
@@ -60,6 +61,7 @@ typedef struct SpaprCapabilityInfo {
     ObjectPropertyAccessor *get;
     ObjectPropertyAccessor *set;
     const char *type;
+    const QAPITypeInfo *qapi_type;
     /* Possible values if this is a custom string type */
     SpaprCapPossible *possible;
     /* Make sure the virtual hardware can support this capability */
@@ -726,6 +728,7 @@ SpaprCapabilityInfo capability_table[SPAPR_CAP_NUM] = {
         .get = spapr_cap_get_bool,
         .set = spapr_cap_set_bool,
         .type = "bool",
+        .qapi_type = &bool_type_info,
         .apply = cap_htm_apply,
     },
     [SPAPR_CAP_VSX] = {
@@ -735,6 +738,7 @@ SpaprCapabilityInfo capability_table[SPAPR_CAP_NUM] = {
         .get = spapr_cap_get_bool,
         .set = spapr_cap_set_bool,
         .type = "bool",
+        .qapi_type = &bool_type_info,
         .apply = cap_vsx_apply,
     },
     [SPAPR_CAP_DFP] = {
@@ -744,6 +748,7 @@ SpaprCapabilityInfo capability_table[SPAPR_CAP_NUM] = {
         .get = spapr_cap_get_bool,
         .set = spapr_cap_set_bool,
         .type = "bool",
+        .qapi_type = &bool_type_info,
         .apply = cap_dfp_apply,
     },
     [SPAPR_CAP_CFPC] = {
@@ -753,6 +758,7 @@ SpaprCapabilityInfo capability_table[SPAPR_CAP_NUM] = {
         .get = spapr_cap_get_string,
         .set = spapr_cap_set_string,
         .type = "string",
+        .qapi_type = &str_type_info,
         .possible = &cap_cfpc_possible,
         .apply = cap_safe_cache_apply,
     },
@@ -763,6 +769,7 @@ SpaprCapabilityInfo capability_table[SPAPR_CAP_NUM] = {
         .get = spapr_cap_get_string,
         .set = spapr_cap_set_string,
         .type = "string",
+        .qapi_type = &str_type_info,
         .possible = &cap_sbbc_possible,
         .apply = cap_safe_bounds_check_apply,
     },
@@ -775,6 +782,7 @@ SpaprCapabilityInfo capability_table[SPAPR_CAP_NUM] = {
         .get = spapr_cap_get_string,
         .set = spapr_cap_set_string,
         .type = "string",
+        .qapi_type = &str_type_info,
         .possible = &cap_ibs_possible,
         .apply = cap_safe_indirect_branch_apply,
     },
@@ -785,6 +793,7 @@ SpaprCapabilityInfo capability_table[SPAPR_CAP_NUM] = {
         .get = spapr_cap_get_pagesize,
         .set = spapr_cap_set_pagesize,
         .type = "int",
+        .qapi_type = &size_type_info,
         .apply = cap_hpt_maxpagesize_apply,
         .cpu_apply = cap_hpt_maxpagesize_cpu_apply,
     },
@@ -795,6 +804,7 @@ SpaprCapabilityInfo capability_table[SPAPR_CAP_NUM] = {
         .get = spapr_cap_get_bool,
         .set = spapr_cap_set_bool,
         .type = "bool",
+        .qapi_type = &bool_type_info,
         .apply = cap_nested_kvm_hv_apply,
     },
     [SPAPR_CAP_NESTED_PAPR] = {
@@ -804,6 +814,7 @@ SpaprCapabilityInfo capability_table[SPAPR_CAP_NUM] = {
         .get = spapr_cap_get_bool,
         .set = spapr_cap_set_bool,
         .type = "bool",
+        .qapi_type = &bool_type_info,
         .apply = cap_nested_papr_apply,
     },
     [SPAPR_CAP_LARGE_DECREMENTER] = {
@@ -813,6 +824,7 @@ SpaprCapabilityInfo capability_table[SPAPR_CAP_NUM] = {
         .get = spapr_cap_get_bool,
         .set = spapr_cap_set_bool,
         .type = "bool",
+        .qapi_type = &bool_type_info,
         .apply = cap_large_decr_apply,
         .cpu_apply = cap_large_decr_cpu_apply,
     },
@@ -823,6 +835,7 @@ SpaprCapabilityInfo capability_table[SPAPR_CAP_NUM] = {
         .get = spapr_cap_get_bool,
         .set = spapr_cap_set_bool,
         .type = "bool",
+        .qapi_type = &bool_type_info,
         .apply = cap_ccf_assist_apply,
     },
     [SPAPR_CAP_FWNMI] = {
@@ -832,6 +845,7 @@ SpaprCapabilityInfo capability_table[SPAPR_CAP_NUM] = {
         .get = spapr_cap_get_bool,
         .set = spapr_cap_set_bool,
         .type = "bool",
+        .qapi_type = &bool_type_info,
         .apply = cap_fwnmi_apply,
     },
     [SPAPR_CAP_RPT_INVALIDATE] = {
@@ -841,6 +855,7 @@ SpaprCapabilityInfo capability_table[SPAPR_CAP_NUM] = {
         .get = spapr_cap_get_bool,
         .set = spapr_cap_set_bool,
         .type = "bool",
+        .qapi_type = &bool_type_info,
         .apply = cap_rpt_invalidate_apply,
     },
     [SPAPR_CAP_AIL_MODE_3] = {
@@ -850,6 +865,7 @@ SpaprCapabilityInfo capability_table[SPAPR_CAP_NUM] = {
         .get = spapr_cap_get_bool,
         .set = spapr_cap_set_bool,
         .type = "bool",
+        .qapi_type = &bool_type_info,
         .apply = cap_ail_mode_3_apply,
     },
     [SPAPR_CAP_DAWR1] = {
@@ -859,6 +875,7 @@ SpaprCapabilityInfo capability_table[SPAPR_CAP_NUM] = {
         .get = spapr_cap_get_bool,
         .set = spapr_cap_set_bool,
         .type = "bool",
+        .qapi_type = &bool_type_info,
         .apply = cap_dawr1_apply,
     },
 };
@@ -1069,7 +1086,7 @@ void spapr_caps_add_properties(SpaprMachineClass *smc)
         g_autofree char *name = g_strdup_printf("cap-%s", cap->name);
         g_autofree char *desc = g_strdup(cap->description);
 
-        object_class_property_add(klass, name, cap->type, NULL,
+        object_class_property_add(klass, name, cap->type, cap->qapi_type,
                                   cap->get, cap->set,
                                   NULL, cap);
 
-- 
2.55.0


