Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DBD6CC27C4F
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Jun 2024 08:25:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sJU8z-0004sG-6U; Tue, 18 Jun 2024 04:24:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1sJU8x-0004rJ-DA; Tue, 18 Jun 2024 04:24:43 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1sJU8V-0000Tn-3L; Tue, 18 Jun 2024 04:24:43 -0400
Received: from pps.filterd (m0353726.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45I6kcZR007297;
 Tue, 18 Jun 2024 08:24:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from
 :to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding; s=pp1; bh=PqSXuBSNBrku3
 V7L4tbKgSoe2ubv6nZ9E/lWxRlEFGM=; b=IahB7HBd0JjIEmzj6QggoCZkC7iMh
 jklVkgwgCGR5cjTcENPz5mtR79lQ2m9qs+SK9C3IcYD4hG0AsUoyXMEMOqP29el3
 6r64Q+EFqn5jGOiE+R4iKFOdveB9yjaXh1JEmoBcVax+gcDDYAHN55JmVFLQaQd2
 r2B33SJiNesip9Q+RHhSGrCutNpo/tBD8sd+Zuan+7aotdzrLG9EzYztmiTB3s2n
 sSO9sPuTcSxBEzc+VGxBbn8+09azPfX80+4uAX8R/7ffqj3G5mHXVoDHVzNwz9Xi
 vm6Wj59J+Q76yFl26QqQLX8tNlmNZZglIHOC6WuWhUnO6OcLZaXmq2KPA==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3yu59087x5-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 18 Jun 2024 08:24:09 +0000 (GMT)
Received: from m0353726.ppops.net (m0353726.ppops.net [127.0.0.1])
 by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 45I8O8ao032625;
 Tue, 18 Jun 2024 08:24:08 GMT
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3yu59087wx-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 18 Jun 2024 08:24:08 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 45I6K26W006227; Tue, 18 Jun 2024 08:24:07 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 3ysn9uhg83-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 18 Jun 2024 08:24:07 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com
 [10.20.54.102])
 by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 45I8O2fP43844012
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 18 Jun 2024 08:24:04 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 5FDFB20043;
 Tue, 18 Jun 2024 08:24:02 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id E8A962004B;
 Tue, 18 Jun 2024 08:24:00 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.109.242.165])
 by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Tue, 18 Jun 2024 08:24:00 +0000 (GMT)
From: Harsh Prateek Bora <harshpb@linux.ibm.com>
To: npiggin@gmail.com, pbonzini@redhat.com, qemu-ppc@nongnu.org,
 qemu-devel@nongnu.org
Cc: danielhb413@gmail.com, vaibhav@linux.ibm.com, sbhat@linux.ibm.com
Subject: [PATCH v4 1/3] accel/kvm: Introduce kvm_create_and_park_vcpu() helper
Date: Tue, 18 Jun 2024 13:53:52 +0530
Message-ID: <20240618082354.13919-2-harshpb@linux.ibm.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240618082354.13919-1-harshpb@linux.ibm.com>
References: <20240618082354.13919-1-harshpb@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: Owe5KcOEDuD4iO6Gn1xepU5IuQ0J-oMV
X-Proofpoint-ORIG-GUID: YQ-Z_2XcVUTHyHdHXyzT7Q82_IRtz5yX
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-18_02,2024-06-17_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0
 lowpriorityscore=0 priorityscore=1501 suspectscore=0 mlxlogscore=999
 malwarescore=0 impostorscore=0 phishscore=0 adultscore=0 clxscore=1015
 mlxscore=0 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2405170001 definitions=main-2406180061
Received-SPF: pass client-ip=148.163.156.1; envelope-from=harshpb@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_MSPIKE_H3=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Suggested-by: Nicholas Piggin <npiggin@gmail.com>
Reviewed-by: Nicholas Piggin <npiggin@gmail.com>
Signed-off-by: Harsh Prateek Bora <harshpb@linux.ibm.com>

---
Based on: <20240607115649.214622-1-salil.mehta@huawei.com>
---
---
 include/sysemu/kvm.h |  8 ++++++++
 accel/kvm/kvm-all.c  | 12 ++++++++++++
 2 files changed, 20 insertions(+)

diff --git a/include/sysemu/kvm.h b/include/sysemu/kvm.h
index c4a914b3d8..9cf14ca3d5 100644
--- a/include/sysemu/kvm.h
+++ b/include/sysemu/kvm.h
@@ -338,6 +338,14 @@ void kvm_park_vcpu(CPUState *cpu);
  */
 int kvm_unpark_vcpu(KVMState *s, unsigned long vcpu_id);
 
+/**
+ * kvm_create_and_park_vcpu - Create and park a KVM vCPU
+ * @cpu: QOM CPUState object for which KVM vCPU has to be created and parked.
+ *
+ * @returns: 0 when success, errno (<0) when failed.
+ */
+int kvm_create_and_park_vcpu(CPUState *cpu);
+
 /* Arch specific hooks */
 
 extern const KVMCapabilityInfo kvm_arch_required_capabilities[];
diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
index 4c5f521583..c0cbb6d480 100644
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
2.45.1


