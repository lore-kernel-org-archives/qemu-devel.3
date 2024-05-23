Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A2DAC25B79
	for <qemu-devel@archiver.kernel.org>; Thu, 23 May 2024 07:27:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sA2qz-0007IP-NU; Thu, 23 May 2024 03:27:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1sA2qr-0007Ee-1u; Thu, 23 May 2024 03:27:02 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1sA2qp-0000Dw-6s; Thu, 23 May 2024 03:27:00 -0400
Received: from pps.filterd (m0353723.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 44N7QuSd012832; Thu, 23 May 2024 07:26:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=from : to : cc : subject
 : date : message-id : in-reply-to : references : content-transfer-encoding
 : mime-version; s=pp1; bh=eecTpgF0LB4D8lp1qu8Okw+yAaPhKYcSM4E7YMX+HOw=;
 b=AiCRisWkCwDZn7ia30QpxzVyYbkgp9Kreq4iRlTY2Zu4BDlw13ZH0oZhURMkj6+bdeHC
 8uc4VVVoHW1DUjhShtEicAYdjxhF7KEE24e6bZ0IgfqFpYUB/m/xUxFIVPclQm9ERWyO
 49kO93QAzhDR1d8GtSaQbhfLLwfmFGZbuAI/iZOCmcXZPuEhOv350nNfIxu7pFBS/i9y
 drkS3BwoYL+28PkTli1XwIdp9mX6mgd1DkLuAyekCR6dl1ZtzJsq2N31aFuTM5O1a0YF
 eAjkWr8JgU303kJt6cNigmzqLhH//hgDzMQFU54LlqFWGq2Cm7VodYVp35whpCX1IzO+ SA== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3ya0b685ba-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 23 May 2024 07:26:57 +0000
Received: from m0353723.ppops.net (m0353723.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 44N7QvmI012860;
 Thu, 23 May 2024 07:26:57 GMT
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3ya0b685aw-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 23 May 2024 07:26:57 +0000
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 44N63EAJ008226; Thu, 23 May 2024 07:26:43 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 3y78vm899m-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 23 May 2024 07:26:43 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com
 [10.20.54.102])
 by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 44N7QbWs57540978
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 23 May 2024 07:26:39 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id A8B672004B;
 Thu, 23 May 2024 07:26:37 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 7656920040;
 Thu, 23 May 2024 07:26:36 +0000 (GMT)
Received: from li-1901474c-32f3-11b2-a85c-fc5ff2c001f3.in.ibm.com (unknown
 [9.109.242.165])
 by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Thu, 23 May 2024 07:26:36 +0000 (GMT)
From: Harsh Prateek Bora <harshpb@linux.ibm.com>
To: npiggin@gmail.com, qemu-ppc@nongnu.org, qemu-devel@nongnu.org
Cc: danielhb413@gmail.com, vaibhav@linux.ibm.com, sbhat@linux.ibm.com
Subject: [PATCH v3 1/3] accel/kvm: Introduce kvm_create_and_park_vcpu() helper
Date: Thu, 23 May 2024 12:56:12 +0530
Message-Id: <20240523072614.256172-2-harshpb@linux.ibm.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20240523072614.256172-1-harshpb@linux.ibm.com>
References: <20240523072614.256172-1-harshpb@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: R8BVU_kRMjXwObOhj4gUOZl-aVEgpols
X-Proofpoint-ORIG-GUID: pJZtvgS-jiIU4JlhmrkkPEIco5AmrGJd
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.12.28.16
 definitions=2024-05-23_04,2024-05-22_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0
 lowpriorityscore=0 priorityscore=1501 bulkscore=0 impostorscore=0
 adultscore=0 mlxscore=0 suspectscore=0 phishscore=0 clxscore=1015
 mlxlogscore=999 spamscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2405010000 definitions=main-2405230048
Received-SPF: pass client-ip=148.163.158.5; envelope-from=harshpb@linux.ibm.com;
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

There are distinct helpers for creating and parking a KVM vCPU.
However, there can be cases where a platform needs to create and
immediately park the vCPU during early stages of vcpu init which
can later be reused when vcpu thread gets initialized. This would
help detect failures with kvm_create_vcpu at an early stage.

Based on api refactoring to create/park vcpus introduced in 1/8 of patch series:
https://lore.kernel.org/qemu-devel/20240522211111.232114-1-salil.mehta@huawei.com/

Suggested-by: Nicholas Piggin <npiggin@gmail.com>
Signed-off-by: Harsh Prateek Bora <harshpb@linux.ibm.com>
---
 accel/kvm/kvm-cpus.h |  8 ++++++++
 accel/kvm/kvm-all.c  | 12 ++++++++++++
 2 files changed, 20 insertions(+)

diff --git a/accel/kvm/kvm-cpus.h b/accel/kvm/kvm-cpus.h
index 2e6bb38b5d..00e534b3b9 100644
--- a/accel/kvm/kvm-cpus.h
+++ b/accel/kvm/kvm-cpus.h
@@ -46,4 +46,12 @@ void kvm_park_vcpu(CPUState *cpu);
  * @returns: KVM fd
  */
 int kvm_unpark_vcpu(KVMState *s, unsigned long vcpu_id);
+
+/**
+ *  * kvm_create_and_park_vcpu - Create and park a KVM vCPU
+ *   * @cpu: QOM CPUState object for which KVM vCPU has to be created and parked.
+ *    *
+ *     * @returns: 0 when success, errno (<0) when failed.
+ *      */
+int kvm_create_and_park_vcpu(CPUState *cpu);
 #endif /* KVM_CPUS_H */
diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
index fc30e5d5b8..d70ca62ff5 100644
--- a/accel/kvm/kvm-all.c
+++ b/accel/kvm/kvm-all.c
@@ -398,6 +398,18 @@ int kvm_create_vcpu(CPUState *cpu)
     return 0;
 }
 
+int kvm_create_and_park_vcpu(CPUState *cpu)
+{
+    int ret = 0;
+
+    ret = kvm_create_vcpu(cpu);
+    if (!ret) {
+        kvm_park_vcpu(cpu);
+    }
+
+    return ret;
+}
+
 static int do_kvm_destroy_vcpu(CPUState *cpu)
 {
     KVMState *s = kvm_state;
-- 
2.39.3


