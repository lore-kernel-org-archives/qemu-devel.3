Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2AB76C4345F
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Apr 2024 21:12:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rzNQi-0001NB-4k; Tue, 23 Apr 2024 17:11:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <walling@linux.ibm.com>)
 id 1rzNQg-0001L8-OD; Tue, 23 Apr 2024 17:11:54 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <walling@linux.ibm.com>)
 id 1rzNQe-0007ZX-OG; Tue, 23 Apr 2024 17:11:54 -0400
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 43NKRaKM018069; Tue, 23 Apr 2024 21:11:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=I1Hq77wTuHn2ILswR7l/yj/W9IpNy1UxIHJQoDt9WpI=;
 b=eOLx2LcuL4csmaI5NSIgqHcQpYilqH2ADgdtTZJT8O0+bAmA5oBkkYKw80kBVjBwBveP
 KJ8k0Cl+x9U5qGmTPfmlKkPNLL+oQN1jYxqEjoabf4reNWwmKK+HnhbomEgQgUTJh0xc
 pyk2Ccb+JYY+I6hDg0Xg+QQ/obmveOeHOaHiDWN8epeKY4x/esGztBUwRFQ1I/fKOmFS
 XoIIVKHBfhJnB/NKXE6v9eWsK9fkKX18PSCEQB9Flwlf0Pes7H02aSsuVUeuZqnjuZHk
 DunwhKOA+LYZMNOASCm7HTaapLVFHKxbBTqGe7EHfAtGIhTQRVE7JwFP9TTPLxoILfbC Xw== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3xpm1mg3nu-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 23 Apr 2024 21:11:44 +0000
Received: from m0353729.ppops.net (m0353729.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 43NLBEsm020446;
 Tue, 23 Apr 2024 21:11:43 GMT
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3xpm1mg3nq-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 23 Apr 2024 21:11:43 +0000
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 43NKaTvd023051; Tue, 23 Apr 2024 21:07:26 GMT
Received: from smtprelay06.wdc07v.mail.ibm.com ([172.16.1.73])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3xms1p006p-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 23 Apr 2024 21:07:26 +0000
Received: from smtpav04.dal12v.mail.ibm.com (smtpav04.dal12v.mail.ibm.com
 [10.241.53.103])
 by smtprelay06.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 43NL7O2s24380072
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 23 Apr 2024 21:07:26 GMT
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 1A42558056;
 Tue, 23 Apr 2024 21:07:24 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 8C4C75805A;
 Tue, 23 Apr 2024 21:07:23 +0000 (GMT)
Received: from li-d664314c-3171-11b2-a85c-fa8047ef35bd.pok.ibm.com (unknown
 [9.12.68.85]) by smtpav04.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Tue, 23 Apr 2024 21:07:23 +0000 (GMT)
From: Collin Walling <walling@linux.ibm.com>
To: qemu-s390x@nongnu.org, qemu-devel@nongnu.org
Cc: thuth@redhat.com, david@redhat.com, wangyanan55@huawei.com,
 philmd@linaro.org, marcel.apfelbaum@gmail.com, eduardo@habkost.net,
 armbru@redhat.com, Collin Walling <walling@linux.ibm.com>
Subject: [PATCH v2 2/3] target/s390x: add support for
 "disable-deprecated-feats" expansion option
Date: Tue, 23 Apr 2024 17:06:54 -0400
Message-ID: <20240423210655.66656-3-walling@linux.ibm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240423210655.66656-1-walling@linux.ibm.com>
References: <20240423210655.66656-1-walling@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: yT9jFdOeRDUlINjwNVURPqL9PEcnQD4d
X-Proofpoint-ORIG-GUID: 5qKomWfABW_BWAQ3KAM93gOTC4TO60qQ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-04-23_16,2024-04-23_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 mlxlogscore=999
 adultscore=0 priorityscore=1501 impostorscore=0 spamscore=0 bulkscore=0
 lowpriorityscore=0 mlxscore=0 malwarescore=0 phishscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2404010000
 definitions=main-2404230053
Received-SPF: pass client-ip=148.163.156.1; envelope-from=walling@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_MSPIKE_H4=0.001,
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

Retain a list of deprecated features disjoint from any particular
CPU model. When a query-cpu-model-expansion is provided with the
"disable-deprecated-feats" option set, the resulting properties list
will include all deprecated features paired with false. Example:

	{ ... "bpb": false, "csske": false, ...}

It is recommended that s390 guests operate with these features
explicitly disabled to ensure compatability with future hardware.

Signed-off-by: Collin Walling <walling@linux.ibm.com>
---
 target/s390x/cpu_features.c      | 14 ++++++++++++++
 target/s390x/cpu_features.h      |  1 +
 target/s390x/cpu_models_sysemu.c | 20 ++++++++++++--------
 3 files changed, 27 insertions(+), 8 deletions(-)

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
diff --git a/target/s390x/cpu_models_sysemu.c b/target/s390x/cpu_models_sysemu.c
index ef9fa80efd..b002819188 100644
--- a/target/s390x/cpu_models_sysemu.c
+++ b/target/s390x/cpu_models_sysemu.c
@@ -171,7 +171,8 @@ static void qdict_add_enabled_feat(const char *name, void *opaque)
 
 /* convert S390CPUDef into a static CpuModelInfo */
 static void cpu_info_from_model(CpuModelInfo *info, const S390CPUModel *model,
-                                bool delta_changes)
+                                bool delta_changes,
+                                bool disable_deprecated_feats)
 {
     QDict *qdict = qdict_new();
     S390FeatBitmap bitmap;
@@ -201,6 +202,13 @@ static void cpu_info_from_model(CpuModelInfo *info, const S390CPUModel *model,
         s390_feat_bitmap_to_ascii(bitmap, qdict, qdict_add_disabled_feat);
     }
 
+    /* features flagged as deprecated */
+    if (disable_deprecated_feats) {
+        bitmap_zero(bitmap, S390_FEAT_MAX);
+        s390_get_deprecated_features(bitmap);
+        s390_feat_bitmap_to_ascii(bitmap, qdict, qdict_add_disabled_feat);
+    }
+
     if (!qdict_size(qdict)) {
         qobject_unref(qdict);
     } else {
@@ -219,11 +227,6 @@ CpuModelExpansionInfo *qmp_query_cpu_model_expansion(CpuModelExpansionType type,
     S390CPUModel s390_model;
     bool delta_changes = false;
 
-    if (has_disable_deprecated_feats) {
-        error_setg(&err, "Unsupported option 'disable-deprecated-feats'");
-        return NULL;
-    }
-
     /* convert it to our internal representation */
     cpu_model_from_info(&s390_model, model, "model", &err);
     if (err) {
@@ -241,7 +244,8 @@ CpuModelExpansionInfo *qmp_query_cpu_model_expansion(CpuModelExpansionType type,
     /* convert it back to a static representation */
     expansion_info = g_new0(CpuModelExpansionInfo, 1);
     expansion_info->model = g_malloc0(sizeof(*expansion_info->model));
-    cpu_info_from_model(expansion_info->model, &s390_model, delta_changes);
+    cpu_info_from_model(expansion_info->model, &s390_model,
+                        delta_changes, disable_deprecated_feats);
     return expansion_info;
 }
 
@@ -390,7 +394,7 @@ CpuModelBaselineInfo *qmp_query_cpu_model_baseline(CpuModelInfo *infoa,
 
     baseline_info = g_new0(CpuModelBaselineInfo, 1);
     baseline_info->model = g_malloc0(sizeof(*baseline_info->model));
-    cpu_info_from_model(baseline_info->model, &model, true);
+    cpu_info_from_model(baseline_info->model, &model, true, false);
     return baseline_info;
 }
 
-- 
2.43.0


