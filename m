Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B455C3DA4A
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jul 2024 20:34:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sS0U5-0002IT-R5; Thu, 11 Jul 2024 16:33:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <walling@linux.ibm.com>)
 id 1sS0U3-0002HH-Mg; Thu, 11 Jul 2024 16:33:43 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <walling@linux.ibm.com>)
 id 1sS0U1-0000NA-JE; Thu, 11 Jul 2024 16:33:43 -0400
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46BJBLwc012150;
 Thu, 11 Jul 2024 20:33:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from
 :to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding; s=pp1; bh=q2AIhYx9gmhXlsw9rjz+02bCMo
 Q44nwyVypLWboruPw=; b=eQgT1x6dT68CvUJJW/krTgCYCiTG5ZxDVwomijq/el
 9zq7FFvydAulsfhrqTliJLCi06VwZJWaSPuvk3DJ7XnxJIsRTO/027jSgSskhY+x
 tGCuh4AhFrSXtqfTgzXAEF2DqEJdMYQvDG8BZv3TcKRDsNVsdqMYZgyLpCy6mmQU
 zC00LgnePdy0bs/JdCOsEBOVSeWU7V4tCjcB7Lv4MZeNFpR17CgYblA22o4/bbWf
 +qVkJaq3CIdP9ExJQTBuFz3wDVpHwwBQMt+0YATgrzo7B2C6XAUMrcq8l1MbNb/u
 iZhG2ucpTi0ZQr0FxCJMCwcY6AC3fsa2daBMYwNinwyA==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 40ampx895q-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 11 Jul 2024 20:33:28 +0000 (GMT)
Received: from m0356516.ppops.net (m0356516.ppops.net [127.0.0.1])
 by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 46BKXSej007067;
 Thu, 11 Jul 2024 20:33:28 GMT
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 40ampx895m-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 11 Jul 2024 20:33:28 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 46BIa5sd014020; Thu, 11 Jul 2024 20:33:27 GMT
Received: from smtprelay02.wdc07v.mail.ibm.com ([172.16.1.69])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 407h8q2wju-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 11 Jul 2024 20:33:27 +0000
Received: from smtpav04.wdc07v.mail.ibm.com (smtpav04.wdc07v.mail.ibm.com
 [10.39.53.231])
 by smtprelay02.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 46BKXPW522545000
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 11 Jul 2024 20:33:27 GMT
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 394AB58045;
 Thu, 11 Jul 2024 20:33:25 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 3F42058056;
 Thu, 11 Jul 2024 20:33:24 +0000 (GMT)
Received: from li-d664314c-3171-11b2-a85c-fa8047ef35bd.pok.ibm.com (unknown
 [9.12.68.85]) by smtpav04.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Thu, 11 Jul 2024 20:33:24 +0000 (GMT)
From: Collin Walling <walling@linux.ibm.com>
To: qemu-s390x@nongnu.org, qemu-devel@nongnu.org
Cc: thuth@redhat.com, david@redhat.com, wangyanan55@huawei.com,
 philmd@linaro.org, marcel.apfelbaum@gmail.com, eduardo@habkost.net,
 armbru@redhat.com, Jiri Denemark <jdenemar@redhat.com>
Subject: [PATCH v1] target/s390x: filter deprecated features based on model
 expansion type
Date: Thu, 11 Jul 2024 16:32:54 -0400
Message-ID: <20240711203254.49018-1-walling@linux.ibm.com>
X-Mailer: git-send-email 2.45.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: ZMkhofpeoGHM3vgLq7YSEO-SpBQJBGMG
X-Proofpoint-ORIG-GUID: ptY7x_x9vKkOK6ww7UTCsT5_1SGCXQBv
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-11_15,2024-07-11_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 malwarescore=0
 impostorscore=0 spamscore=0 mlxscore=0 suspectscore=0 mlxlogscore=999
 bulkscore=0 lowpriorityscore=0 priorityscore=1501 clxscore=1011
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2406140001 definitions=main-2407110142
Received-SPF: pass client-ip=148.163.158.5; envelope-from=walling@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
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

It is beneficial to provide an interface to retrieve *all* deprecated
features in one go. Management applications will need this information
to determine which features need to be disabled regardless of the
host-model's capabilities.

To remedy this, deprecated features are only filtered during a static
expansion. All deperecated features are reported on a full expansion.

Suggested-by: Jiri Denemark <jdenemar@redhat.com>
Signed-off-by: Collin Walling <walling@linux.ibm.com>
---
 target/s390x/cpu_models_sysemu.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/target/s390x/cpu_models_sysemu.c b/target/s390x/cpu_models_sysemu.c
index 977fbc6522..76d15f2e4d 100644
--- a/target/s390x/cpu_models_sysemu.c
+++ b/target/s390x/cpu_models_sysemu.c
@@ -211,7 +211,15 @@ static void cpu_info_from_model(CpuModelInfo *info, const S390CPUModel *model,
     bitmap_zero(bitmap, S390_FEAT_MAX);
     s390_get_deprecated_features(bitmap);
 
-    bitmap_and(bitmap, bitmap, model->def->full_feat, S390_FEAT_MAX);
+    /*
+     * For static model expansion, filter out deprecated features that are
+     * not a subset of the model's feature set. Otherwise, report the entire 
+     * deprecated features list.
+     */
+    if (delta_changes) {
+        bitmap_and(bitmap, bitmap, model->def->full_feat, S390_FEAT_MAX);
+    }
+
     s390_feat_bitmap_to_ascii(bitmap, &info->deprecated_props, list_add_feat);
     info->has_deprecated_props = !!info->deprecated_props;
 }
-- 
2.45.1


