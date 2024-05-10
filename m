Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 504A4C25B10
	for <qemu-devel@archiver.kernel.org>; Fri, 10 May 2024 06:41:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s5JwA-0001LC-Tf; Fri, 10 May 2024 02:40:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1s5Jvc-00017V-Oz
 for qemu-devel@nongnu.org; Fri, 10 May 2024 02:40:27 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1s5JvU-0001YX-7z
 for qemu-devel@nongnu.org; Fri, 10 May 2024 02:40:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1715323214;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=6xpWUrTrwmb2sPbB/T2wVkMw6wkiEdIERa3LN5Dp9G8=;
 b=fX8eXKcdO7t6dXpZKNiEZckNhnEWuu9ImRlpZP/+Ix/reK7lm8l5ihMpkd7S99OYcE6NoB
 Plif9uWjFp/1xQcDiIvGmEbz4I+7vOudkx4FjnTrwvVpFojSrSbOSLGQ0nHIr5xngP8u45
 VQH518YltCVwNZlaRxMxEk7R8VFdi0w=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-121-AY87wLXuO9-lB1ZvE_pTJw-1; Fri,
 10 May 2024 02:40:12 -0400
X-MC-Unique: AY87wLXuO9-lB1ZvE_pTJw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
 [10.11.54.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 800E01C05145;
 Fri, 10 May 2024 06:40:12 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.39.192.229])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 30D042079267;
 Fri, 10 May 2024 06:40:11 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org,
	Richard Henderson <richard.henderson@linaro.org>
Cc: Collin Walling <walling@linux.ibm.com>,
 Markus Armbruster <armbru@redhat.com>, David Hildenbrand <david@redhat.com>
Subject: [PULL 5/8] target/s390x: report deprecated-props in
 cpu-model-expansion reply
Date: Fri, 10 May 2024 08:39:58 +0200
Message-ID: <20240510064001.26002-6-thuth@redhat.com>
In-Reply-To: <20240510064001.26002-1-thuth@redhat.com>
References: <20240510064001.26002-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.581,
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

Retain a list of deprecated features disjoint from any particular
CPU model. A query-cpu-model-expansion reply will now provide a list of
properties (i.e. features) that are flagged as deprecated. Example:

    {
      "return": {
        "model": {
          "name": "z14.2-base",
          "deprecated-props": [
            "bpb",
            "csske"
          ],
          "props": {
            "pfmfi": false,
            "exrl": true,
            ...a lot more props...
            "skey": false,
            "vxpdeh2": false
          }
        }
      }
    }

It is recommended that s390 guests operate with these features
explicitly disabled to ensure compatibility with future hardware.

Signed-off-by: Collin Walling <walling@linux.ibm.com>
Acked-by: Markus Armbruster <armbru@redhat.com>
Reviewed-by: David Hildenbrand <david@redhat.com>
Message-ID: <20240429191059.11806-2-walling@linux.ibm.com>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 qapi/machine-target.json         |  7 ++++++-
 target/s390x/cpu_features.h      |  1 +
 target/s390x/cpu_features.c      | 14 ++++++++++++++
 target/s390x/cpu_models_sysemu.c |  8 ++++++++
 4 files changed, 29 insertions(+), 1 deletion(-)

diff --git a/qapi/machine-target.json b/qapi/machine-target.json
index 29e695aa06..2942853092 100644
--- a/qapi/machine-target.json
+++ b/qapi/machine-target.json
@@ -20,11 +20,16 @@
 #
 # @props: a dictionary of QOM properties to be applied
 #
+# @deprecated-props: a list of properties that are flagged as deprecated
+#     by the CPU vendor.  These props are a subset of the full model's
+#     definition list of properties. (since 9.1)
+#
 # Since: 2.8
 ##
 { 'struct': 'CpuModelInfo',
   'data': { 'name': 'str',
-            '*props': 'any' } }
+            '*props': 'any',
+            '*deprecated-props': ['str'] } }
 
 ##
 # @CpuModelExpansionType:
diff --git a/target/s390x/cpu_features.h b/target/s390x/cpu_features.h
index a9bd68a2e1..661a8cd6db 100644
--- a/target/s390x/cpu_features.h
+++ b/target/s390x/cpu_features.h
@@ -69,6 +69,7 @@ void s390_add_from_feat_block(S390FeatBitmap features, S390FeatType type,
                           uint8_t *data);
 void s390_feat_bitmap_to_ascii(const S390FeatBitmap features, void *opaque,
                                void (*fn)(const char *name, void *opaque));
+void s390_get_deprecated_features(S390FeatBitmap features);
 
 /* Definition of a CPU feature group */
 typedef struct {
diff --git a/target/s390x/cpu_features.c b/target/s390x/cpu_features.c
index d28eb65845..efafc9711c 100644
--- a/target/s390x/cpu_features.c
+++ b/target/s390x/cpu_features.c
@@ -212,6 +212,20 @@ void s390_feat_bitmap_to_ascii(const S390FeatBitmap features, void *opaque,
     };
 }
 
+void s390_get_deprecated_features(S390FeatBitmap features)
+{
+    static const int feats[] = {
+         /* CSSKE is deprecated on newer generations */
+         S390_FEAT_CONDITIONAL_SSKE,
+         S390_FEAT_BPB,
+    };
+    int i;
+
+    for (i = 0; i < ARRAY_SIZE(feats); i++) {
+        set_bit(feats[i], features);
+    }
+}
+
 #define FEAT_GROUP_INIT(_name, _group, _desc)        \
     {                                                \
         .name = _name,                               \
diff --git a/target/s390x/cpu_models_sysemu.c b/target/s390x/cpu_models_sysemu.c
index 15be729c3d..977fbc6522 100644
--- a/target/s390x/cpu_models_sysemu.c
+++ b/target/s390x/cpu_models_sysemu.c
@@ -206,6 +206,14 @@ static void cpu_info_from_model(CpuModelInfo *info, const S390CPUModel *model,
     } else {
         info->props = QOBJECT(qdict);
     }
+
+    /* features flagged as deprecated */
+    bitmap_zero(bitmap, S390_FEAT_MAX);
+    s390_get_deprecated_features(bitmap);
+
+    bitmap_and(bitmap, bitmap, model->def->full_feat, S390_FEAT_MAX);
+    s390_feat_bitmap_to_ascii(bitmap, &info->deprecated_props, list_add_feat);
+    info->has_deprecated_props = !!info->deprecated_props;
 }
 
 CpuModelExpansionInfo *qmp_query_cpu_model_expansion(CpuModelExpansionType type,
-- 
2.45.0


