Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B08AAC3DA5D
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jul 2024 18:18:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sUsBp-0005aF-5b; Fri, 19 Jul 2024 14:18:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <walling@linux.ibm.com>)
 id 1sUsBm-0005Nv-B8; Fri, 19 Jul 2024 14:18:42 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <walling@linux.ibm.com>)
 id 1sUsBk-0005o6-1O; Fri, 19 Jul 2024 14:18:42 -0400
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46JGswBE010878;
 Fri, 19 Jul 2024 18:18:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from
 :to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding; s=pp1; bh=cle9dYY/pZFJ0MYlnXA5HMiirX
 YCgNmyknx8fxz+r6Q=; b=UmAFHM8YrBQD/VJSTgPydx0/v7YusjzU+DSMfpz71j
 ywCVIXEqX9ys29OT3Ten8qe16ESVVFWqAIIznAnkHRYH1tBtidn92L5c3RASD2OE
 DtqLzJtyCcd5e8xCHUNa1AGn929ZrP+tTSPqdA96eFZF4PTeVU/bX6vKaRAYLLSV
 caMmsCE4h+mmbMB9t4Hs/c6lCKAUXIUTdJ16czCnNuWoaSP2fpzMTIlJf5svj8mQ
 49Yl8SgXOlpTB1dE8MqkLzFWGCCbBE4FFatWbH2kl0hVEWKGv9wXAxtW5R1EOCpn
 9nBWeT9ryhEr+H5E+Fst23nXyLD9BgIpTYifUNAeikPw==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 40fttj0gje-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 19 Jul 2024 18:18:29 +0000 (GMT)
Received: from m0353729.ppops.net (m0353729.ppops.net [127.0.0.1])
 by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 46JIISwE013137;
 Fri, 19 Jul 2024 18:18:28 GMT
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 40fttj0gja-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 19 Jul 2024 18:18:28 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 46JHotdM009594; Fri, 19 Jul 2024 18:18:27 GMT
Received: from smtprelay04.wdc07v.mail.ibm.com ([172.16.1.71])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 40dwkn0y4c-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 19 Jul 2024 18:18:27 +0000
Received: from smtpav03.wdc07v.mail.ibm.com (smtpav03.wdc07v.mail.ibm.com
 [10.39.53.230])
 by smtprelay04.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 46JIIOgC58523998
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 19 Jul 2024 18:18:26 GMT
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id BF86B5805D;
 Fri, 19 Jul 2024 18:18:24 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id B961558054;
 Fri, 19 Jul 2024 18:18:23 +0000 (GMT)
Received: from li-d664314c-3171-11b2-a85c-fa8047ef35bd.ibm.com.com (unknown
 [9.67.171.109]) by smtpav03.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Fri, 19 Jul 2024 18:18:23 +0000 (GMT)
From: Collin Walling <walling@linux.ibm.com>
To: qemu-s390x@nongnu.org, qemu-devel@nongnu.org
Cc: thuth@redhat.com, david@redhat.com, wangyanan55@huawei.com,
 philmd@linaro.org, marcel.apfelbaum@gmail.com, eduardo@habkost.net,
 armbru@redhat.com, Jiri Denemark <jdenemar@redhat.com>
Subject: [PATCH v3] target/s390x: filter deprecated properties based on model
 expansion type
Date: Fri, 19 Jul 2024 14:17:41 -0400
Message-ID: <20240719181741.35146-1-walling@linux.ibm.com>
X-Mailer: git-send-email 2.45.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: dkuC05gT2nwbi-GrrvX_8iW4Q7cC4zxm
X-Proofpoint-GUID: xYAqi1kR0nLnhkKVc4LPiWWSnNkERmKP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-19_06,2024-07-18_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0
 mlxlogscore=999 priorityscore=1501 phishscore=0 impostorscore=0 mlxscore=0
 spamscore=0 adultscore=0 bulkscore=0 clxscore=1015 lowpriorityscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2407110000 definitions=main-2407190134
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
---

Changelog:

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
 qapi/machine-target.json         |  5 +++--
 target/s390x/cpu_models_sysemu.c | 16 +++++++++-------
 2 files changed, 12 insertions(+), 9 deletions(-)

diff --git a/qapi/machine-target.json b/qapi/machine-target.json
index a8d9ec87f5..67086f006f 100644
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
index 977fbc6522..e28ecf7ab9 100644
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
2.45.1


