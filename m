Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4870AC4345F
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Apr 2024 21:08:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rzNMw-0006VI-KH; Tue, 23 Apr 2024 17:08:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <walling@linux.ibm.com>)
 id 1rzNMa-0006RH-M4; Tue, 23 Apr 2024 17:07:41 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <walling@linux.ibm.com>)
 id 1rzNMY-0006Zn-8K; Tue, 23 Apr 2024 17:07:40 -0400
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 43NKS0uR018359; Tue, 23 Apr 2024 21:07:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=545sj9a7A9I8Uwccefn0NuYhkRfF6SeQaOyFAC7LTe8=;
 b=YcKnJL3vvf5LyUZ1FrMVUKRxbLvj6uPEVAKxfgiVRhkKw/H8NSKpE2NZIA0yOKtH9xUy
 0LqRAgxA/mVJPghInRBGJMKO3f6XPPWM/x0uV/GtQtvRrs4VZATYeJYv5yOHHHrid4Wp
 n3EF3fU1Vh4RC4efG2v5gCgV58Auh8NHnv1tATZGVvCtAxZOLq84Nh6UndVvEzjzIKDj
 +7OvJBcHSnFaQYXhfsbmllwJyNuRN5ReH1rK/yRjJTxnV6d7kXwAB3VycTqgARifpvmG
 LftjgxRVlqWWFEX/cid7uYoDeisOEvA7ZaPaM5RdLWn/btOytbuyfnoTfwQFr5YSkMsi 9w== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3xpm1mg391-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 23 Apr 2024 21:07:27 +0000
Received: from m0353729.ppops.net (m0353729.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 43NL7Ria013895;
 Tue, 23 Apr 2024 21:07:27 GMT
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3xpm1mg38v-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 23 Apr 2024 21:07:27 +0000
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 43NK8jv7023012; Tue, 23 Apr 2024 21:07:26 GMT
Received: from smtprelay05.wdc07v.mail.ibm.com ([172.16.1.72])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3xms1p006n-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 23 Apr 2024 21:07:26 +0000
Received: from smtpav04.dal12v.mail.ibm.com (smtpav04.dal12v.mail.ibm.com
 [10.241.53.103])
 by smtprelay05.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 43NL7NDY58655032
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 23 Apr 2024 21:07:25 GMT
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 776AF5805E;
 Tue, 23 Apr 2024 21:07:23 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id E9F6B5805A;
 Tue, 23 Apr 2024 21:07:22 +0000 (GMT)
Received: from li-d664314c-3171-11b2-a85c-fa8047ef35bd.pok.ibm.com (unknown
 [9.12.68.85]) by smtpav04.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Tue, 23 Apr 2024 21:07:22 +0000 (GMT)
From: Collin Walling <walling@linux.ibm.com>
To: qemu-s390x@nongnu.org, qemu-devel@nongnu.org
Cc: thuth@redhat.com, david@redhat.com, wangyanan55@huawei.com,
 philmd@linaro.org, marcel.apfelbaum@gmail.com, eduardo@habkost.net,
 armbru@redhat.com, Collin Walling <walling@linux.ibm.com>
Subject: [PATCH v2 1/3] cpu-models: add "disable-deprecated-feats" option to
 cpu model expansion
Date: Tue, 23 Apr 2024 17:06:53 -0400
Message-ID: <20240423210655.66656-2-walling@linux.ibm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240423210655.66656-1-walling@linux.ibm.com>
References: <20240423210655.66656-1-walling@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: BD2B6rlEIiQt0jCNe_ac3knP1BKRxJzP
X-Proofpoint-ORIG-GUID: J5qpejMGOqip3wjAggPTRUATcFaS3xXX
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

This optional parameter for query-cpu-model-expansion enables CPU
model features flagged as deprecated to appear in the resulting
list of properties.

This commit does not add support beyond adding a new argument
to the query. All queries with this option present will result
in an error claiming this option is not supported.

Signed-off-by: Collin Walling <walling@linux.ibm.com>
---
 qapi/machine-target.json         | 7 ++++++-
 target/arm/arm-qmp-cmds.c        | 7 +++++++
 target/i386/cpu-sysemu.c         | 7 +++++++
 target/s390x/cpu_models_sysemu.c | 7 +++++++
 4 files changed, 27 insertions(+), 1 deletion(-)

diff --git a/qapi/machine-target.json b/qapi/machine-target.json
index 29e695aa06..b9da284d2d 100644
--- a/qapi/machine-target.json
+++ b/qapi/machine-target.json
@@ -285,6 +285,10 @@
 #
 # @type: expansion type, specifying how to expand the CPU model
 #
+# @disable-deprecated-feats: include CPU model features that are
+#     flagged as deprecated. If supported, these features will appear
+#     in the properties list paired with false.
+#
 # Returns: a CpuModelExpansionInfo describing the expanded CPU model
 #
 # Errors:
@@ -298,7 +302,8 @@
 ##
 { 'command': 'query-cpu-model-expansion',
   'data': { 'type': 'CpuModelExpansionType',
-            'model': 'CpuModelInfo' },
+            'model': 'CpuModelInfo',
+            '*disable-deprecated-feats': 'bool' },
   'returns': 'CpuModelExpansionInfo',
   'if': { 'any': [ 'TARGET_S390X',
                    'TARGET_I386',
diff --git a/target/arm/arm-qmp-cmds.c b/target/arm/arm-qmp-cmds.c
index 3cc8cc738b..1010d654e3 100644
--- a/target/arm/arm-qmp-cmds.c
+++ b/target/arm/arm-qmp-cmds.c
@@ -100,6 +100,8 @@ static const char *cpu_model_advertised_features[] = {
 
 CpuModelExpansionInfo *qmp_query_cpu_model_expansion(CpuModelExpansionType type,
                                                      CpuModelInfo *model,
+                                                     bool has_disable_deprecated_feats,
+                                                     bool disable_deprecated_feats,
                                                      Error **errp)
 {
     CpuModelExpansionInfo *expansion_info;
@@ -110,6 +112,11 @@ CpuModelExpansionInfo *qmp_query_cpu_model_expansion(CpuModelExpansionType type,
     const char *name;
     int i;
 
+    if (has_disable_deprecated_feats) {
+        error_setg(&err, "Unsupported option 'disable-deprecated-feats'");
+        return NULL;
+    }
+
     if (type != CPU_MODEL_EXPANSION_TYPE_FULL) {
         error_setg(errp, "The requested expansion type is not supported");
         return NULL;
diff --git a/target/i386/cpu-sysemu.c b/target/i386/cpu-sysemu.c
index 3f9093d285..c15786fb66 100644
--- a/target/i386/cpu-sysemu.c
+++ b/target/i386/cpu-sysemu.c
@@ -196,6 +196,8 @@ out:
 CpuModelExpansionInfo *
 qmp_query_cpu_model_expansion(CpuModelExpansionType type,
                                                       CpuModelInfo *model,
+                                                      bool has_disable_deprecated_feats,
+                                                      bool disable_deprecated_feats,
                                                       Error **errp)
 {
     X86CPU *xc = NULL;
@@ -204,6 +206,11 @@ qmp_query_cpu_model_expansion(CpuModelExpansionType type,
     QDict *props = NULL;
     const char *base_name;
 
+    if (has_disable_deprecated_feats) {
+        error_setg(&err, "Unsupported option 'disable-deprecated-feats'");
+        goto out;
+    }
+
     xc = x86_cpu_from_model(model->name, model->props, "model.props", &err);
     if (err) {
         goto out;
diff --git a/target/s390x/cpu_models_sysemu.c b/target/s390x/cpu_models_sysemu.c
index 2d99218069..ef9fa80efd 100644
--- a/target/s390x/cpu_models_sysemu.c
+++ b/target/s390x/cpu_models_sysemu.c
@@ -210,6 +210,8 @@ static void cpu_info_from_model(CpuModelInfo *info, const S390CPUModel *model,
 
 CpuModelExpansionInfo *qmp_query_cpu_model_expansion(CpuModelExpansionType type,
                                                       CpuModelInfo *model,
+                                                      bool has_disable_deprecated_feats,
+                                                      bool disable_deprecated_feats,
                                                       Error **errp)
 {
     Error *err = NULL;
@@ -217,6 +219,11 @@ CpuModelExpansionInfo *qmp_query_cpu_model_expansion(CpuModelExpansionType type,
     S390CPUModel s390_model;
     bool delta_changes = false;
 
+    if (has_disable_deprecated_feats) {
+        error_setg(&err, "Unsupported option 'disable-deprecated-feats'");
+        return NULL;
+    }
+
     /* convert it to our internal representation */
     cpu_model_from_info(&s390_model, model, "model", &err);
     if (err) {
-- 
2.43.0


