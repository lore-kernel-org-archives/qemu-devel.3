Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE362C4345F
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Apr 2024 22:18:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rzkwq-0007YO-TB; Wed, 24 Apr 2024 18:18:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <walling@linux.ibm.com>)
 id 1rzkwj-0007Sl-Pj; Wed, 24 Apr 2024 18:18:33 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <walling@linux.ibm.com>)
 id 1rzkwh-0002ZT-Mz; Wed, 24 Apr 2024 18:18:33 -0400
Received: from pps.filterd (m0353722.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 43OM2sA3005420; Wed, 24 Apr 2024 22:18:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=2XfM2XsAqIeQjsMBhA4cwH8vbilT8U7tjV8WGvYU0TU=;
 b=g/kvmi6pB3kBbS8LchQLAdMNSfStV+Y/gJCjNve0cXqP9wi9jigeGi5nOzNUSeX8hbK+
 32NA0QylIQMrbN6xy0XB2HDnArdUM6p1UulvKyee5YFWzqRbPYlwRwPAgk8JxYJiTfMm
 fvIMR1u+WAge9QRZvrM1rMZLRYr24DdDRuITPLHHMhosOSlxcjRhf53achj9zxtRqeCB
 2zXgutzxtaJV+9J3NeTaC9XQI46dGn4i+FbLjDCq23j+wTF7HLGcz2uM70/kfrFYhe7v
 UTlfSOgv6S2Tl/qMqn4F+qc7/7Uij6cYrkxvuxtQ/AXtl4Bg2aU7xydt4oph2zK58XIx pw== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3xqah8g14m-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 24 Apr 2024 22:18:25 +0000
Received: from m0353722.ppops.net (m0353722.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 43OMIOqD028826;
 Wed, 24 Apr 2024 22:18:24 GMT
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3xqah8g14k-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 24 Apr 2024 22:18:24 +0000
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 43OLu0iI015289; Wed, 24 Apr 2024 21:57:12 GMT
Received: from smtprelay06.dal12v.mail.ibm.com ([172.16.1.8])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3xmshme2vh-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 24 Apr 2024 21:57:12 +0000
Received: from smtpav04.dal12v.mail.ibm.com (smtpav04.dal12v.mail.ibm.com
 [10.241.53.103])
 by smtprelay06.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 43OLv9pg34669272
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 24 Apr 2024 21:57:11 GMT
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 85DD058063;
 Wed, 24 Apr 2024 21:57:09 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 0237458052;
 Wed, 24 Apr 2024 21:57:09 +0000 (GMT)
Received: from li-d664314c-3171-11b2-a85c-fa8047ef35bd.pok.ibm.com (unknown
 [9.12.68.85]) by smtpav04.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Wed, 24 Apr 2024 21:57:08 +0000 (GMT)
From: Collin Walling <walling@linux.ibm.com>
To: qemu-s390x@nongnu.org, qemu-devel@nongnu.org
Cc: thuth@redhat.com, david@redhat.com, wangyanan55@huawei.com,
 philmd@linaro.org, marcel.apfelbaum@gmail.com, eduardo@habkost.net,
 armbru@redhat.com, Collin Walling <walling@linux.ibm.com>
Subject: [PATCH v3 1/2] target/s390x: report deprecated-props in
 cpu-model-expansion reply
Date: Wed, 24 Apr 2024 17:56:32 -0400
Message-ID: <20240424215633.48906-2-walling@linux.ibm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240424215633.48906-1-walling@linux.ibm.com>
References: <20240424215633.48906-1-walling@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: BlSuWXB5aTmnabh589I_BODB2l0nzgdh
X-Proofpoint-ORIG-GUID: OUkLzrt85j16EiuXcx8Jb9fsGN6QQMoI
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-04-24_19,2024-04-24_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 impostorscore=0
 mlxscore=0 spamscore=0 priorityscore=1501 malwarescore=0 mlxlogscore=999
 suspectscore=0 lowpriorityscore=0 phishscore=0 bulkscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2404010000
 definitions=main-2404240114
Received-SPF: pass client-ip=148.163.158.5; envelope-from=walling@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
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
explicitly disabled to ensure compatability with future hardware.

Signed-off-by: Collin Walling <walling@linux.ibm.com>
---
 qapi/machine-target.json         |  5 ++++-
 target/s390x/cpu_features.c      | 14 ++++++++++++++
 target/s390x/cpu_features.h      |  1 +
 target/s390x/cpu_models_sysemu.c |  6 ++++++
 4 files changed, 25 insertions(+), 1 deletion(-)

diff --git a/qapi/machine-target.json b/qapi/machine-target.json
index 29e695aa06..3799a60e3d 100644
--- a/qapi/machine-target.json
+++ b/qapi/machine-target.json
@@ -20,11 +20,14 @@
 #
 # @props: a dictionary of QOM properties to be applied
 #
+# @deprecated-props: a list of QOM properties that are flagged as deprecated
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
index 2d99218069..307e3885f4 100644
--- a/target/s390x/cpu_models_sysemu.c
+++ b/target/s390x/cpu_models_sysemu.c
@@ -206,6 +206,12 @@ static void cpu_info_from_model(CpuModelInfo *info, const S390CPUModel *model,
     } else {
         info->props = QOBJECT(qdict);
     }
+
+    bitmap_zero(bitmap, S390_FEAT_MAX);
+    s390_get_deprecated_features(bitmap);
+    s390_feat_bitmap_to_ascii(bitmap, &info->deprecated_props,
+                              list_add_feat);
+    info->has_deprecated_props = !!info->deprecated_props;
 }
 
 CpuModelExpansionInfo *qmp_query_cpu_model_expansion(CpuModelExpansionType type,
-- 
2.43.0


