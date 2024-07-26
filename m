Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B614C3DA49
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jul 2024 20:38:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sXRhV-0003Aq-MI; Fri, 26 Jul 2024 16:38:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <walling@linux.ibm.com>)
 id 1sXRhS-00039a-KC; Fri, 26 Jul 2024 16:38:02 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <walling@linux.ibm.com>)
 id 1sXRhQ-0002YZ-3E; Fri, 26 Jul 2024 16:38:02 -0400
Received: from pps.filterd (m0353726.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46QK3t1A005466;
 Fri, 26 Jul 2024 20:37:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from
 :to:cc:subject:date:message-id:content-transfer-encoding
 :mime-version; s=pp1; bh=oCndrv/EExFAZMW2o9cevTtsOTllR5m/LhFS6Ue
 bw7k=; b=hvuwEYVs3Pm/+0Os7c6wbz1Sk+N29cDsbCUVkws71GIitBUwwPFhwMp
 7btTrOhKff7hTVFbDMO1Ud9y8E3peE1le9LdmBmcIyru1YJwmAur38iS2Ns6HPgA
 PzL3TuM6fg0EARHVHWfn8F+an5KHOsyxlZQ/G9/Yxqe8P5U45vNCAyfnwMoGqdoO
 C5LsDwN7mO2lkCQA7SoIhM4hU8KD2BW4Nn65FtDRg+QwJJbL9kLddNTLxpmZSlCZ
 T9yJtqdP9Ns8vFZcU/yI7TiGCoBBiSAKcnRMpjHN5uyzdSp2glfXPXZU4z/eJCdS
 p9+0trqDrb9RBM0vGpZiSn2vfALlceA==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 40m8b01upy-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 26 Jul 2024 20:37:02 +0000 (GMT)
Received: from m0353726.ppops.net (m0353726.ppops.net [127.0.0.1])
 by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 46QKb1CZ027508;
 Fri, 26 Jul 2024 20:37:01 GMT
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 40m8b01upv-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 26 Jul 2024 20:37:01 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 46QHxiar006208; Fri, 26 Jul 2024 20:37:00 GMT
Received: from smtprelay01.wdc07v.mail.ibm.com ([172.16.1.68])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 40gqjuxh03-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 26 Jul 2024 20:37:00 +0000
Received: from smtpav06.dal12v.mail.ibm.com (smtpav06.dal12v.mail.ibm.com
 [10.241.53.105])
 by smtprelay01.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 46QKaveZ41484756
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 26 Jul 2024 20:36:59 GMT
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 7FE7A5806A;
 Fri, 26 Jul 2024 20:36:57 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 09FD45806B;
 Fri, 26 Jul 2024 20:36:57 +0000 (GMT)
Received: from li-d664314c-3171-11b2-a85c-fa8047ef35bd.pok.ibm.com (unknown
 [9.12.68.85]) by smtpav06.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Fri, 26 Jul 2024 20:36:56 +0000 (GMT)
From: Collin Walling <walling@linux.ibm.com>
To: qemu-s390x@nongnu.org, qemu-devel@nongnu.org
Cc: thuth@redhat.com, david@redhat.com, wangyanan55@huawei.com,
 philmd@linaro.org, marcel.apfelbaum@gmail.com, eduardo@habkost.net,
 armbru@redhat.com
Subject: [PATCH v1] target/s390x: move @deprecated-props to CpuModelExpansion
 Info
Date: Fri, 26 Jul 2024 16:36:46 -0400
Message-ID: <20240726203646.20279-1-walling@linux.ibm.com>
X-Mailer: git-send-email 2.45.1
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 91x2vxiL8OAjPjW_cntQfqSKG4pGp2XF
X-Proofpoint-GUID: HKKRcFW6c8MmX8Tq7GF4M0CM-peQa_aC
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-26_12,2024-07-26_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0
 priorityscore=1501 bulkscore=0 adultscore=0 clxscore=1015
 lowpriorityscore=0 phishscore=0 suspectscore=0 mlxscore=0 mlxlogscore=999
 malwarescore=0 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2407110000 definitions=main-2407260139
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

The @deprecated-props array did not make any sense to be a member of the
CpuModelInfo struct, since this field would only be populated by a
query-cpu-model-expansion response and ignored otherwise. Move this
field to the CpuModelExpansionInfo struct where is makes more sense.

References:
 - https://lists.gnu.org/archive/html/qemu-devel/2024-07/msg05996.html
 - commit eed0e8ffa38f0695c0519508f6e4f5a3297cbd67

Signed-off-by: Collin Walling <walling@linux.ibm.com>
---

@David, the previous commit header did not align with the changes made
here, so I tagged this as a "v1" but added the previous conversation as
a reference.  I hope this is appropriate?

---
 qapi/machine-target.json         | 18 ++++++++++--------
 target/s390x/cpu_models_sysemu.c | 31 ++++++++++++++++++++-----------
 2 files changed, 30 insertions(+), 19 deletions(-)

diff --git a/qapi/machine-target.json b/qapi/machine-target.json
index a552e2b0ce..09dec2b9bb 100644
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
@@ -248,10 +242,18 @@
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
index 94dd798b4c..44e7587acb 100644
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
@@ -245,6 +236,24 @@ CpuModelExpansionInfo *qmp_query_cpu_model_expansion(CpuModelExpansionType type,
     expansion_info = g_new0(CpuModelExpansionInfo, 1);
     expansion_info->model = g_malloc0(sizeof(*expansion_info->model));
     cpu_info_from_model(expansion_info->model, &s390_model, delta_changes);
+
+    /* populated list of deprecated features */
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


