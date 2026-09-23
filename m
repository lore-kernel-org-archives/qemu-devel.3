Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1DF2CC982FA
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Sep 2026 08:34:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x9IQr-00055Q-Kx; Wed, 23 Sep 2026 04:34:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <frankja@linux.ibm.com>)
 id 1x9IQq-00054q-6q; Wed, 23 Sep 2026 04:34:24 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <frankja@linux.ibm.com>)
 id 1x9IQo-0006iQ-Ik; Wed, 23 Sep 2026 04:34:23 -0400
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68N77VVj1551385; Wed, 23 Sep 2026 08:34:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=pp1; bh=rh6fDzJYIA5oCV1BTa1JmHaF0CnX/wjwDzB3ew1cz
 gg=; b=ne9fA1qW+nGGmxvq6kIT4PDekBqmZQ1yFRTL6zvh8GMzZ7dSq1y6GCngz
 sHMhCP17Da1IKdJ2x+pRw2izkv2d4/Yz2CBYNoDtLwvN9Nar3RLiI1yXsTGN9hiR
 BuLk/3dvMf1VeSQBU3WSyedthVnbX3FeGF3jFRNs3NziZDe5LQu2vd54UzZS5dTa
 iFyfe4d7XWtzjFeVVsaWvGlw2TE8qiUFG+9sgmgMRT6ooLvvIjAeuVbPB0dnION5
 n09ev72GFpc1Gdcl3OW6BwNSYJo3RvyOYtlnEANDwrnREmU9Es2L/61BLVT6E/MC
 g3cyTyDku1rhwP3b7Y3TzonpYAghA==
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gskgqhkv5-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Wed, 23 Sep 2026 08:34:18 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id
 68N8IIEY2891810; Wed, 23 Sep 2026 08:34:18 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4gu5bkg0h6-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 23 Sep 2026 08:34:17 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com
 [10.20.54.104])
 by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 68N8YCII53281180
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 23 Sep 2026 08:34:12 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 1A2D32004D;
 Wed, 23 Sep 2026 08:34:12 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id DE08320043;
 Wed, 23 Sep 2026 08:34:11 +0000 (GMT)
Received: from b46lp25.lnxne.boe (unknown [9.87.84.240])
 by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Wed, 23 Sep 2026 08:34:11 +0000 (GMT)
From: Janosch Frank <frankja@linux.ibm.com>
To: qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, brueckner@linux.ibm.com, borntraeger@de.ibm.com,
 cohuck@redhat.com, farman@linux.ibm.com, david@kernel.org,
 iii@linux.ibm.com, richard.henderson@linaro.org
Subject: [PATCH] s390x: Expose pv attribute in QOM
Date: Wed, 23 Sep 2026 08:33:58 +0000
Message-ID: <20260923083406.64128-1-frankja@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=G+OJgNk5 c=1 sm=1 tr=0 ts=6ab38f0a cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8 a=In-Fd3IUtSA43TycysQA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTIzMDAzMSBTYWx0ZWRfX3UgKpzeW+cwy
 fBmYzIdIOWZZp3yMER7J+GhlPG6pj3hLNO/9VbdfQgjrq9e6bu+UxnZQC1xj3+r7/yRDvxPbHi+
 LlLcq4rc9anedCt2cPHfpKK/HtFfJO7p7SwCfispZBdUyCwV0Q4oweGodiz1XiijX4J7h6j24Fm
 ywZ5ApYuaouyct21LYXbpRLEpPwDml2ZSGAFSivOLWIpcmJwudVifI10Ha0Yz+e/mk9NeFbBHtm
 PgSUDYADK4dv9eKYOIqMPCgT7Zj9kJ07cYi+hRBaSczGc65S0Bai28ECPJTX73c2U9rNKrIYdOp
 xqGhypbqdsgbEDQFldtVXdum6wOFc8JY3fOpCwMOZ3lCFmnxIyYLpot+euryONdkvfpSQn4UXW3
 uoBjGCEgsYQNz+z6vnkK/GcAXmyf9HCltRLawNRKJC9X30YQ+dlSF7a9gRyIe4ZIuLjFauwwIkb
 JaEocFDpND+9nKiIHQw==
X-Proofpoint-ORIG-GUID: 3b4A4DCRgJzDfponprf5BjSKRkovFFsN
X-Proofpoint-GUID: 3b4A4DCRgJzDfponprf5BjSKRkovFFsN
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTIzMDAzMSBTYWx0ZWRfXzzJYyvh3qQb3
 AbwdQ4h4ggIAp61oWHHYqR9DJDKXXVQI3NBpMHKw888oMM18vRlnBJFVc2UhsjyRO38uir5xcYw
 3CNQ3S1TpuyYqOX3fbz4nPYEuOUoACI=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-23_03,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0 phishscore=0 lowpriorityscore=0 impostorscore=0
 bulkscore=0 priorityscore=1501 clxscore=1015 spamscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609230031
Received-SPF: pass client-ip=148.163.158.5; envelope-from=frankja@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

People doing VM management requested a way to query if a VM is in PV
or not. This of course does never replace attestation, it's merely
QEMU's view of the situation.

Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
CC: Hendrik Brueckner <brueckner@linux.ibm.com>
---
 hw/s390x/s390-virtio-ccw.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/hw/s390x/s390-virtio-ccw.c b/hw/s390x/s390-virtio-ccw.c
index 7fb78d8fa1..42ecfa59f3 100644
--- a/hw/s390x/s390-virtio-ccw.c
+++ b/hw/s390x/s390-virtio-ccw.c
@@ -838,6 +838,13 @@ static inline void machine_set_secure_boot(Object *obj, bool value,
     ms->secure_boot = value;
 }
 
+static inline bool machine_get_pv(Object *obj, Error **errp)
+{
+    S390CcwMachineState *ms = S390_CCW_MACHINE(obj);
+
+    return ms->pv;
+}
+
  /*
   * S390x-specific global compatibility properties.
   *
@@ -919,6 +926,12 @@ static void ccw_machine_class_init(ObjectClass *oc, const void *data)
                                    machine_set_secure_boot);
     object_class_property_set_description(oc, "secure-boot",
             "enable/disable secure boot");
+
+    object_class_property_add_bool(oc, "pv",
+                                   machine_get_pv,
+                                   NULL);
+    object_class_property_set_description(oc, "pv",
+            "protected virtualization state (read-only)");
 }
 
 static inline void s390_machine_initfn(Object *obj)
-- 
2.53.0


