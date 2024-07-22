Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 292E2C3DA64
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jul 2024 12:03:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sVrk5-0004DD-1s; Mon, 22 Jul 2024 08:02:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1sVrjS-0000to-UV
 for qemu-devel@nongnu.org; Mon, 22 Jul 2024 08:01:44 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1sVrjR-0006ca-AB
 for qemu-devel@nongnu.org; Mon, 22 Jul 2024 08:01:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1721649692;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Do2mT8dvAEeD4SVkrarJHyrbkBSoqOxoGbUZB5E1UEc=;
 b=Ld2/FU+7vh95Xc4jH1dIciqI6WdwNedoyK8yl7GIqppGi31gDQqvu5e51KPWelS99YbU2D
 twfYaP8OD37UnmVWf3VX1E24JysZiJ31b9U7iEMkEUbHdFRnZzgCGPx0g+tYTm5nopjKjv
 iTaSI6G6US9vGEuphp9/Rv+3Qp6Ul1A=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-402-pjC0wl9SNr6XGX4Y_Ws44w-1; Mon,
 22 Jul 2024 08:01:29 -0400
X-MC-Unique: pjC0wl9SNr6XGX4Y_Ws44w-1
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 91E76190599A; Mon, 22 Jul 2024 12:01:21 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.39.194.179])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id B27251955DC8; Mon, 22 Jul 2024 12:01:01 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org
Subject: [PULL 12/12] target/s390x: filter deprecated properties based on
 model expansion type
Date: Mon, 22 Jul 2024 14:00:26 +0200
Message-ID: <20240722120026.675449-13-thuth@redhat.com>
In-Reply-To: <20240722120026.675449-1-thuth@redhat.com>
References: <20240722120026.675449-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.133,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Currently, there is no way to execute the query-cpu-model-expansion
command to retrieve a comprehenisve list of deprecated properties, as
the result is dependent per-model. To enable this, the expansion output
is modified as such:

When reporting a "full" CPU model, show the *entire* list of deprecated
properties regardless if they are supported on the model. A full
expansion outputs all known CPU model properties anyway, so it makes
sense to report all deprecated properties here too.

This allows management apps to query a single model (e.g. host) to
acquire the full list of deprecated properties.

Additionally, when reporting a "static" CPU model, the command will
only show deprecated properties that are a subset of the model's
*enabled* properties. This is more accurate than how the query was
handled before, which blindly reported deprecated properties that
were never otherwise introduced for certain models.

Acked-by: David Hildenbrand <david@redhat.com>
Suggested-by: Jiri Denemark <jdenemar@redhat.com>
Signed-off-by: Collin Walling <walling@linux.ibm.com>
Message-ID: <20240719181741.35146-1-walling@linux.ibm.com>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 qapi/machine-target.json         |  5 +++--
 target/s390x/cpu_models_sysemu.c | 16 +++++++++-------
 2 files changed, 12 insertions(+), 9 deletions(-)

diff --git a/qapi/machine-target.json b/qapi/machine-target.json
index 7edb876b5c..a552e2b0ce 100644
--- a/qapi/machine-target.json
+++ b/qapi/machine-target.json
@@ -21,8 +21,9 @@
 # @props: a dictionary of QOM properties to be applied
 #
 # @deprecated-props: a list of properties that are flagged as deprecated
-#     by the CPU vendor.  These props are a subset of the full model's
-#     definition list of properties. (since 9.1)
+#     by the CPU vendor.  These properties are either a subset of the
+#     properties enabled on the CPU model, or a set of properties
+#     deprecated across all models for the architecture.
 #
 # Since: 2.8
 ##
diff --git a/target/s390x/cpu_models_sysemu.c b/target/s390x/cpu_models_sysemu.c
index 977fbc6522..94dd798b4c 100644
--- a/target/s390x/cpu_models_sysemu.c
+++ b/target/s390x/cpu_models_sysemu.c
@@ -174,11 +174,15 @@ static void cpu_info_from_model(CpuModelInfo *info, const S390CPUModel *model,
                                 bool delta_changes)
 {
     QDict *qdict = qdict_new();
-    S390FeatBitmap bitmap;
+    S390FeatBitmap bitmap, deprecated;
 
     /* always fallback to the static base model */
     info->name = g_strdup_printf("%s-base", model->def->name);
 
+    /* features flagged as deprecated */
+    bitmap_zero(deprecated, S390_FEAT_MAX);
+    s390_get_deprecated_features(deprecated);
+
     if (delta_changes) {
         /* features deleted from the base feature set */
         bitmap_andnot(bitmap, model->def->base_feat, model->features,
@@ -193,6 +197,9 @@ static void cpu_info_from_model(CpuModelInfo *info, const S390CPUModel *model,
         if (!bitmap_empty(bitmap, S390_FEAT_MAX)) {
             s390_feat_bitmap_to_ascii(bitmap, qdict, qdict_add_enabled_feat);
         }
+
+        /* deprecated features that are a subset of the model's enabled features */
+        bitmap_and(deprecated, deprecated, model->features, S390_FEAT_MAX);
     } else {
         /* expand all features */
         s390_feat_bitmap_to_ascii(model->features, qdict,
@@ -207,12 +214,7 @@ static void cpu_info_from_model(CpuModelInfo *info, const S390CPUModel *model,
         info->props = QOBJECT(qdict);
     }
 
-    /* features flagged as deprecated */
-    bitmap_zero(bitmap, S390_FEAT_MAX);
-    s390_get_deprecated_features(bitmap);
-
-    bitmap_and(bitmap, bitmap, model->def->full_feat, S390_FEAT_MAX);
-    s390_feat_bitmap_to_ascii(bitmap, &info->deprecated_props, list_add_feat);
+    s390_feat_bitmap_to_ascii(deprecated, &info->deprecated_props, list_add_feat);
     info->has_deprecated_props = !!info->deprecated_props;
 }
 
-- 
2.45.2


