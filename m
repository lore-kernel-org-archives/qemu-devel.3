Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C0FEC41513
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jul 2024 17:34:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sTm3W-00068q-9T; Tue, 16 Jul 2024 13:33:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <walling@linux.ibm.com>)
 id 1sTm3O-00065l-36; Tue, 16 Jul 2024 13:33:30 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <walling@linux.ibm.com>)
 id 1sTm3L-0002r4-Fj; Tue, 16 Jul 2024 13:33:29 -0400
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46GGx3WD027107;
 Tue, 16 Jul 2024 17:33:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from
 :to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding; s=pp1; bh=CyXkRjxt2L5UTAQ3Qjd074WqZr
 qtT3JqJAy5WiL3wgk=; b=X7iWMSoeGWfoGpYSsGfJoGffPhZBfHMpC95aT4ckP5
 xDX9jY9BFLAxtRsRgJa8TKtNplkQssulfMZ6nuGe5ES+q9LCP/4JMNCdlAoR4grG
 DAHSmwArF561OVQ2n0nxU+jYJhGAuWNdyya4eaue0tdyenMkYnoK34JPjOpudy2n
 fUzjg+rjzIpV3WLBh/bQCzF/p4EWIEIBVJ7aQ1+HH6oivo4Qe86ZxWv5BvPAaWLr
 7hXl3Sp+iZI9TzAXfW/vQun5gJ5/sJcwagnUob3v26eD5mTDoJ6x60dM1BpInptY
 vvzKZ0zNo4vnOVzd+qF4xlX6UCIUrarOdrZIiZWaTjMQ==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 40dvupr2j5-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 16 Jul 2024 17:33:15 +0000 (GMT)
Received: from m0353729.ppops.net (m0353729.ppops.net [127.0.0.1])
 by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 46GHVgEl008115;
 Tue, 16 Jul 2024 17:33:15 GMT
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 40dvupr2hy-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 16 Jul 2024 17:33:15 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 46GGu41s030523; Tue, 16 Jul 2024 17:33:13 GMT
Received: from smtprelay07.wdc07v.mail.ibm.com ([172.16.1.74])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 40c4a0namx-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 16 Jul 2024 17:33:13 +0000
Received: from smtpav06.dal12v.mail.ibm.com (smtpav06.dal12v.mail.ibm.com
 [10.241.53.105])
 by smtprelay07.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 46GHXBQ564422172
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 16 Jul 2024 17:33:13 GMT
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 0F64C5806D;
 Tue, 16 Jul 2024 17:33:11 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 76D1A5805D;
 Tue, 16 Jul 2024 17:33:10 +0000 (GMT)
Received: from li-d664314c-3171-11b2-a85c-fa8047ef35bd.pok.ibm.com (unknown
 [9.12.68.85]) by smtpav06.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Tue, 16 Jul 2024 17:33:10 +0000 (GMT)
From: Collin Walling <walling@linux.ibm.com>
To: qemu-s390x@nongnu.org, qemu-devel@nongnu.org
Cc: thuth@redhat.com, david@redhat.com, wangyanan55@huawei.com,
 philmd@linaro.org, marcel.apfelbaum@gmail.com, eduardo@habkost.net,
 armbru@redhat.com, Jiri Denemark <jdenemar@redhat.com>
Subject: [PATCH v2] target/s390x: filter deprecated properties based on model
 expansion type
Date: Tue, 16 Jul 2024 13:32:53 -0400
Message-ID: <20240716173253.28533-1-walling@linux.ibm.com>
X-Mailer: git-send-email 2.45.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: PKPI-_0YAJmn66XKkltmsz5dFjN6wC2Z
X-Proofpoint-ORIG-GUID: skxeCEK7bzUCKg2Q99t3QLMqU8hTbLEG
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-15_19,2024-07-16_02,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 malwarescore=0
 spamscore=0 mlxscore=0 impostorscore=0 suspectscore=0 bulkscore=0
 lowpriorityscore=0 priorityscore=1501 mlxlogscore=999 phishscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2406140001 definitions=main-2407160127
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

As s390 CPU models progress and deprecated properties are dropped
outright, it will be cumbersome for management apps to query the host
for a comprehensive list of deprecated properties that will need to be
disabled on older models. To remedy this, the query-cpu-model-expansion
output now behaves by filtering deprecated properties based on the
expansion type instead of filtering based off of the model's full set
of features:

When reporting a static CPU model, only show deprecated properties that
are a subset of the model's enabled features.

When reporting a full CPU model, show the entire list of deprecated
properties regardless if they are supported on the model.

Suggested-by: Jiri Denemark <jdenemar@redhat.com>
Signed-off-by: Collin Walling <walling@linux.ibm.com>
---

Changelog:

    v2
    - Changed commit message
    - Added documentation reflecting this change
    - Made code changes that more accurately filter the deprecated
        properties based on expansion type.  This change makes it
        so that the deprecated-properties reported for a static model
        expansion are a subset of the model's properties instead of
        the model's full-definition properties.

        For example:

        Previously, the z900 static model would report 'bpb' in the
        list of deprecated-properties.  However, this prop is *not*
        a part of the model's feature set, leading to some inaccuracy
        (albeit harmless).

        Now, this feature will not show during a static expansion.
        It will, however, show up in a full expansion (along with
        the rest of the list: 'csske', 'te', 'cte').

@David, I've elected to respectully forgo adding your ack-by on this
iteration since I have changed the code (and therefore the behavior)
between this version and the previous in case you do not agree with
these adjustments.

---
 qapi/machine-target.json         |  8 ++++++--
 target/s390x/cpu_models_sysemu.c | 16 +++++++++-------
 2 files changed, 15 insertions(+), 9 deletions(-)

diff --git a/qapi/machine-target.json b/qapi/machine-target.json
index a8d9ec87f5..d151504f25 100644
--- a/qapi/machine-target.json
+++ b/qapi/machine-target.json
@@ -21,8 +21,12 @@
 # @props: a dictionary of QOM properties to be applied
 #
 # @deprecated-props: a list of properties that are flagged as deprecated
-#     by the CPU vendor.  These props are a subset of the full model's
-#     definition list of properties. (since 9.1)
+#     by the CPU vendor.  (since 9.1).
+#
+# .. note:: Since 9.1, the list of deprecated props were always a subset
+#    of the model's full-definition list of properites. Now, this list is
+#    populated with the model's enabled property set when delta changes
+#    are applied. All deprecated properties are reported otherwise.
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
+        /* deprecated features that are a subset of the model's features */
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


