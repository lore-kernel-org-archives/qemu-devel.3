Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E193FC3DA61
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jul 2024 08:10:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sYhuz-0007qs-Nr; Tue, 30 Jul 2024 04:09:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1sYhuy-0007pR-Gq
 for qemu-devel@nongnu.org; Tue, 30 Jul 2024 04:09:12 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1sYhuw-0000pc-Ib
 for qemu-devel@nongnu.org; Tue, 30 Jul 2024 04:09:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1722326949;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0Za8N01neFRYJ+Ybu7cI0fTPx1xYupGwphv8Z+jK6eY=;
 b=hyqp3vhvoEHCgI6SS6i2X/QrKnErc6/civiKzVpHDn39BlFtvjzb2pYQKGE4UGjr2szv0I
 uQB22HwTsmeqI9O91XKBcMjRZWTMQs3qdInRw/iHpdA/1L1vH78fUieigacoT6x0UtAYWq
 V8V/RPVzMcZL0F+aWU7cO813pRXSXPE=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-151-ZlVUb6sfOSOekBwPfKR-lw-1; Tue,
 30 Jul 2024 04:09:03 -0400
X-MC-Unique: ZlVUb6sfOSOekBwPfKR-lw-1
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id D820A1955D48; Tue, 30 Jul 2024 08:09:01 +0000 (UTC)
Received: from t14s.redhat.com (unknown [10.39.193.34])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 13A4B1955F3B; Tue, 30 Jul 2024 08:08:58 +0000 (UTC)
From: David Hildenbrand <david@redhat.com>
To: qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, Richard Henderson <richard.henderson@linaro.org>,
 Thomas Huth <thuth@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Collin Walling <walling@linux.ibm.com>,
 David Hildenbrand <david@redhat.com>
Subject: [PULL 1/1] target/s390x: move @deprecated-props to CpuModelExpansion
 Info
Date: Tue, 30 Jul 2024 10:08:52 +0200
Message-ID: <20240730080852.649251-2-david@redhat.com>
In-Reply-To: <20240730080852.649251-1-david@redhat.com>
References: <20240730080852.649251-1-david@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124; envelope-from=david@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.125,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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

From: Collin Walling <walling@linux.ibm.com>

CpuModelInfo is used both as command argument and in command
returns.

Its @deprecated-props array does not make any sense in arguments,
and is silently ignored.  We actually want it only as return value
of query-cpu-model-expansion.

Move it from CpuModelInfo to CpuModelExpansionType, and document
its dependence on expansion type property.

This was identified late during review [1] and we have to fix it up
while it's not part of an official QEMU release yet.

[1] https://lore.kernel.org/qemu-devel/20240719181741.35146-1-walling@linux.ibm.com/

Message-ID: <20240726203646.20279-1-walling@linux.ibm.com>
Fixes: eed0e8ffa38f ("target/s390x: filter deprecated properties based on model expansion type")
Signed-off-by: Collin Walling <walling@linux.ibm.com>
[ david: - add "Fixes", adjust description, reference v3 instead
         - make property s390x-only and non-optional
         - fixup "populate" vs. "populated" ]
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 qapi/machine-target.json         | 19 +++++++++++--------
 target/s390x/cpu_models_sysemu.c | 29 ++++++++++++++++++-----------
 2 files changed, 29 insertions(+), 19 deletions(-)

diff --git a/qapi/machine-target.json b/qapi/machine-target.json
index a552e2b0ce..00bbecc905 100644
--- a/qapi/machine-target.json
+++ b/qapi/machine-target.json
@@ -20,17 +20,11 @@
 #
 # @props: a dictionary of QOM properties to be applied
 #
-# @deprecated-props: a list of properties that are flagged as deprecated
-#     by the CPU vendor.  These properties are either a subset of the
-#     properties enabled on the CPU model, or a set of properties
-#     deprecated across all models for the architecture.
-#
 # Since: 2.8
 ##
 { 'struct': 'CpuModelInfo',
   'data': { 'name': 'str',
-            '*props': 'any',
-            '*deprecated-props': ['str'] } }
+            '*props': 'any' } }
 
 ##
 # @CpuModelExpansionType:
@@ -248,10 +242,19 @@
 #
 # @model: the expanded CpuModelInfo.
 #
+# @deprecated-props: a list of properties that are flagged as deprecated
+#     by the CPU vendor.  The list depends on the CpuModelExpansionType:
+#     "static" properties are a subset of the enabled-properties for
+#     the expanded model; "full" properties are a set of properties
+#     that are deprecated across all models for the architecture.
+#     (since: 9.1).
+#
 # Since: 2.8
 ##
 { 'struct': 'CpuModelExpansionInfo',
-  'data': { 'model': 'CpuModelInfo' },
+  'data': { 'model': 'CpuModelInfo',
+            'deprecated-props' : { 'type': ['str'],
+                                   'if': 'TARGET_S390X' } },
   'if': { 'any': [ 'TARGET_S390X',
                    'TARGET_I386',
                    'TARGET_ARM',
diff --git a/target/s390x/cpu_models_sysemu.c b/target/s390x/cpu_models_sysemu.c
index 94dd798b4c..f6df691b66 100644
--- a/target/s390x/cpu_models_sysemu.c
+++ b/target/s390x/cpu_models_sysemu.c
@@ -174,15 +174,11 @@ static void cpu_info_from_model(CpuModelInfo *info, const S390CPUModel *model,
                                 bool delta_changes)
 {
     QDict *qdict = qdict_new();
-    S390FeatBitmap bitmap, deprecated;
+    S390FeatBitmap bitmap;
 
     /* always fallback to the static base model */
     info->name = g_strdup_printf("%s-base", model->def->name);
 
-    /* features flagged as deprecated */
-    bitmap_zero(deprecated, S390_FEAT_MAX);
-    s390_get_deprecated_features(deprecated);
-
     if (delta_changes) {
         /* features deleted from the base feature set */
         bitmap_andnot(bitmap, model->def->base_feat, model->features,
@@ -197,9 +193,6 @@ static void cpu_info_from_model(CpuModelInfo *info, const S390CPUModel *model,
         if (!bitmap_empty(bitmap, S390_FEAT_MAX)) {
             s390_feat_bitmap_to_ascii(bitmap, qdict, qdict_add_enabled_feat);
         }
-
-        /* deprecated features that are a subset of the model's enabled features */
-        bitmap_and(deprecated, deprecated, model->features, S390_FEAT_MAX);
     } else {
         /* expand all features */
         s390_feat_bitmap_to_ascii(model->features, qdict,
@@ -213,9 +206,6 @@ static void cpu_info_from_model(CpuModelInfo *info, const S390CPUModel *model,
     } else {
         info->props = QOBJECT(qdict);
     }
-
-    s390_feat_bitmap_to_ascii(deprecated, &info->deprecated_props, list_add_feat);
-    info->has_deprecated_props = !!info->deprecated_props;
 }
 
 CpuModelExpansionInfo *qmp_query_cpu_model_expansion(CpuModelExpansionType type,
@@ -226,6 +216,7 @@ CpuModelExpansionInfo *qmp_query_cpu_model_expansion(CpuModelExpansionType type,
     CpuModelExpansionInfo *expansion_info = NULL;
     S390CPUModel s390_model;
     bool delta_changes = false;
+    S390FeatBitmap deprecated_feats;
 
     /* convert it to our internal representation */
     cpu_model_from_info(&s390_model, model, "model", &err);
@@ -245,6 +236,22 @@ CpuModelExpansionInfo *qmp_query_cpu_model_expansion(CpuModelExpansionType type,
     expansion_info = g_new0(CpuModelExpansionInfo, 1);
     expansion_info->model = g_malloc0(sizeof(*expansion_info->model));
     cpu_info_from_model(expansion_info->model, &s390_model, delta_changes);
+
+    /* populate list of deprecated features */
+    bitmap_zero(deprecated_feats, S390_FEAT_MAX);
+    s390_get_deprecated_features(deprecated_feats);
+
+    if (delta_changes) {
+        /*
+         * Only populate deprecated features that are a
+         * subset of the features enabled on the CPU model.
+         */
+        bitmap_and(deprecated_feats, deprecated_feats,
+                   s390_model.features, S390_FEAT_MAX);
+    }
+
+    s390_feat_bitmap_to_ascii(deprecated_feats,
+                              &expansion_info->deprecated_props, list_add_feat);
     return expansion_info;
 }
 
-- 
2.45.2


