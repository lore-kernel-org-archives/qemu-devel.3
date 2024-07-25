Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0FF2C3DA49
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jul 2024 18:41:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sX3O6-00018U-9U; Thu, 25 Jul 2024 14:40:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <walling@linux.ibm.com>)
 id 1sX3O4-00016m-9x; Thu, 25 Jul 2024 14:40:24 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <walling@linux.ibm.com>)
 id 1sX3O1-0007t2-MT; Thu, 25 Jul 2024 14:40:23 -0400
Received: from pps.filterd (m0353728.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46PHQrGD022901;
 Thu, 25 Jul 2024 18:40:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from
 :to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding; s=pp1; bh=zVw/1jjcrq5KkbIwaIDmQitWEP
 jDG8TdcNcCBjqpgtQ=; b=MuYNKOCgBz2ZD4nRgijqKv1dtOXRyNBWHi90i0aewS
 IXEXf5pebVRlu29YsHHyR/RaXRDZ8KteV/6jCtN8RExpmBNZCEy6PTHi0IdCncQd
 JlgazPSs33bVe64JT6Wrb7Gz6qC6IifwxjXnworIVjSfiAdVUoxa/ErTBia9hUl8
 aEmH9zYnoNGB5f7xF5U6NFX2M651pYP2ZLsIqv5bbQqiCcprI9OrW2/tlOu/pYSc
 2Mr75sRNZh/qRDx1WHgLKvk5ObtLS1BpaK1Xi3LwFAbyfrmmN6+iT/9COq9APLbF
 TJ3WTzLiDsr69OQeyFfHffUEV7N/XQFmWyEIQAYl5CtA==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 40kjbghhxd-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 25 Jul 2024 18:40:10 +0000 (GMT)
Received: from m0353728.ppops.net (m0353728.ppops.net [127.0.0.1])
 by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 46PIeAGV014665;
 Thu, 25 Jul 2024 18:40:10 GMT
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 40kjbghhx8-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 25 Jul 2024 18:40:10 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 46PHkEjL007093; Thu, 25 Jul 2024 18:40:09 GMT
Received: from smtprelay02.wdc07v.mail.ibm.com ([172.16.1.69])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 40gx72y5jf-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 25 Jul 2024 18:40:09 +0000
Received: from smtpav05.wdc07v.mail.ibm.com (smtpav05.wdc07v.mail.ibm.com
 [10.39.53.232])
 by smtprelay02.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 46PIe6rE27918976
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 25 Jul 2024 18:40:08 GMT
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id C6CB15806F;
 Thu, 25 Jul 2024 18:40:04 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id EC0C158066;
 Thu, 25 Jul 2024 18:40:03 +0000 (GMT)
Received: from li-d664314c-3171-11b2-a85c-fa8047ef35bd.pok.ibm.com (unknown
 [9.12.68.85]) by smtpav05.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Thu, 25 Jul 2024 18:40:03 +0000 (GMT)
From: Collin Walling <walling@linux.ibm.com>
To: qemu-s390x@nongnu.org, qemu-devel@nongnu.org
Cc: thuth@redhat.com, david@redhat.com, wangyanan55@huawei.com,
 philmd@linaro.org, marcel.apfelbaum@gmail.com, eduardo@habkost.net,
 armbru@redhat.com, Jiri Denemark <jdenemar@redhat.com>
Subject: [PATCH v4] target/s390x: filter deprecated properties based on model
 expansion type
Date: Thu, 25 Jul 2024 14:39:09 -0400
Message-ID: <20240725183909.24144-1-walling@linux.ibm.com>
X-Mailer: git-send-email 2.45.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: b4Ne8WA4I1mCbaZwpgiDAuIvSzc5_f_D
X-Proofpoint-GUID: T1zkmn_2K5lgY1y4o3gfSBGVgVq7hNST
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-25_18,2024-07-25_03,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 bulkscore=0
 lowpriorityscore=0 spamscore=0 impostorscore=0 mlxscore=0
 priorityscore=1501 malwarescore=0 suspectscore=0 adultscore=0
 mlxlogscore=999 phishscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2407110000 definitions=main-2407250126
Received-SPF: pass client-ip=148.163.156.1; envelope-from=walling@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_MSPIKE_H3=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Currently, there is no way to execute the query-cpu-model-expansion
command to retrieve a comprehenisve list of deprecated properties, as
the result is dependent per-model. To enable this, the expansion output
is modified as such:

When reporting a "static" CPU model, the command will only show
deprecated properties that are a subset of the model's *enabled*
properties. This is more accurate than how the query was handled
before, which blindly reported properties that were never introduced
for certain models.

When reporting a "full" CPU model, show the *entire* list of deprecated
properties regardless if they are supported on the model. A full
expansion outputs all known CPU model properties anyway, so it makes
sense to report all deprecated properties here too. This allows
management apps to query a single model (e.g. host) to acquire the
full list of deprecated properties.

Additionally, the @deprecated-props array has been moved from the
CpuModelInfo struct to the CpuModelExpansionInfo struct, since the data
did not belong in the former.

Acked-by: David Hildenbrand <david@redhat.com>
Suggested-by: Jiri Denemark <jdenemar@redhat.com>
Signed-off-by: Collin Walling <walling@linux.ibm.com>
---

Changelog:

    v4
    - @deprecated-props moved to CpuModelExpansionInfo
    - deprecated features code moved from cpu_info_from_model to 
        qmp_query_cpu_model_expansion function
    - reorganized commit message to mention "static" first and "full"
        second, akin to how it's documented in the QAPI doc

    v3
    - Removed the 'note' and cleaned up documentation
    - Revised commit message

    v2
    - Changed commit message
    - Added documentation reflecting this change
    - Made code changes that more accurately filter the deprecated
        properties based on expansion type.  This change makes it
        so that the deprecated-properties reported for a static model
        expansion are a subset of the model's properties instead of
        the model's full-definition properties.

---
 qapi/machine-target.json         | 17 ++++++++++-------
 target/s390x/cpu_models_sysemu.c | 27 +++++++++++++++++++--------
 2 files changed, 29 insertions(+), 15 deletions(-)

diff --git a/qapi/machine-target.json b/qapi/machine-target.json
index a8d9ec87f5..3e711d4178 100644
--- a/qapi/machine-target.json
+++ b/qapi/machine-target.json
@@ -20,16 +20,11 @@
 #
 # @props: a dictionary of QOM properties to be applied
 #
-# @deprecated-props: a list of properties that are flagged as deprecated
-#     by the CPU vendor.  These props are a subset of the full model's
-#     definition list of properties. (since 9.1)
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
@@ -247,10 +242,18 @@
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
+            '*deprecated-props': ['str'] },
   'if': { 'any': [ 'TARGET_S390X',
                    'TARGET_I386',
                    'TARGET_ARM',
diff --git a/target/s390x/cpu_models_sysemu.c b/target/s390x/cpu_models_sysemu.c
index 977fbc6522..44e7587acb 100644
--- a/target/s390x/cpu_models_sysemu.c
+++ b/target/s390x/cpu_models_sysemu.c
@@ -206,14 +206,6 @@ static void cpu_info_from_model(CpuModelInfo *info, const S390CPUModel *model,
     } else {
         info->props = QOBJECT(qdict);
     }
-
-    /* features flagged as deprecated */
-    bitmap_zero(bitmap, S390_FEAT_MAX);
-    s390_get_deprecated_features(bitmap);
-
-    bitmap_and(bitmap, bitmap, model->def->full_feat, S390_FEAT_MAX);
-    s390_feat_bitmap_to_ascii(bitmap, &info->deprecated_props, list_add_feat);
-    info->has_deprecated_props = !!info->deprecated_props;
 }
 
 CpuModelExpansionInfo *qmp_query_cpu_model_expansion(CpuModelExpansionType type,
@@ -224,6 +216,7 @@ CpuModelExpansionInfo *qmp_query_cpu_model_expansion(CpuModelExpansionType type,
     CpuModelExpansionInfo *expansion_info = NULL;
     S390CPUModel s390_model;
     bool delta_changes = false;
+    S390FeatBitmap deprecated_feats;
 
     /* convert it to our internal representation */
     cpu_model_from_info(&s390_model, model, "model", &err);
@@ -243,6 +236,24 @@ CpuModelExpansionInfo *qmp_query_cpu_model_expansion(CpuModelExpansionType type,
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
+    expansion_info->has_deprecated_props = !!expansion_info->deprecated_props;
+
     return expansion_info;
 }
 
-- 
2.45.1


