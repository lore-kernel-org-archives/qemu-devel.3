Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 483AAC25B74
	for <qemu-devel@archiver.kernel.org>; Thu, 16 May 2024 05:34:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s7TjO-00031v-Ah; Thu, 16 May 2024 01:32:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1s7TjK-00030k-4W; Thu, 16 May 2024 01:32:38 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1s7TjI-0005Qj-Bw; Thu, 16 May 2024 01:32:37 -0400
Received: from pps.filterd (m0353726.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 44G4KAQZ028101; Thu, 16 May 2024 05:32:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=from : to : cc : subject
 : date : message-id : in-reply-to : references : content-transfer-encoding
 : mime-version; s=pp1; bh=7+6ZYkuDsxu97IqM6559pWYH91/tr5mCeBbGgC0J33c=;
 b=KjDAEJdt+XFMxturO6IuHlQVn1Qkto2E6+P7/SSv9S4uAyboZ9Hdqce2vyMLED1m2rr0
 3/6f/LpLDJ7o1bxxqGdboFYj6GNBPKJL+ciGhOJie2G1l9b7eX/dJ6G+fNg4sjffTx0o
 lpPd9r1O5HUFmqF2BseQp+Q2pWLPiJd0RHigafIlF4DSv7sLTEm7yJt9kWCd0/bhpitF
 YiIGayvRsdZdzhtbF7dGQFh7Oi/ERrqWzrnEo97SPc1em3tmooZUd1/Wn4FVZOOC5R+n
 DPQB0UH8H65DvVN9O2jbc2oSI6xB3WN7mPP9RyeGbNN+S1gp24DeLUcNPgUuTLYLiDms Yw== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3y57aq0n2w-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 16 May 2024 05:32:31 +0000
Received: from m0353726.ppops.net (m0353726.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 44G5WVMG025709;
 Thu, 16 May 2024 05:32:31 GMT
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3y57aq0n2v-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 16 May 2024 05:32:31 +0000
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 44G2CoUi005721; Thu, 16 May 2024 05:32:30 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 3y2nq2yr6q-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 16 May 2024 05:32:30 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com
 [10.20.54.104])
 by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 44G5WO2349873272
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 16 May 2024 05:32:26 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id AAB9E20065;
 Thu, 16 May 2024 05:32:24 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id B15532004E;
 Thu, 16 May 2024 05:32:22 +0000 (GMT)
Received: from li-1901474c-32f3-11b2-a85c-fc5ff2c001f3.ibm.com (unknown
 [9.79.188.146]) by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Thu, 16 May 2024 05:32:22 +0000 (GMT)
From: Harsh Prateek Bora <harshpb@linux.ibm.com>
To: npiggin@gmail.com, qemu-ppc@nongnu.org, qemu-devel@nongnu.org
Cc: danielhb413@gmail.com, vaibhav@linux.ibm.com, sbhat@linux.ibm.com,
 salil.mehta@huawei.com
Subject: [PATCH v2 2/4] accel/kvm: Introduce kvm_create_and_park_vcpu() helper
Date: Thu, 16 May 2024 11:02:09 +0530
Message-Id: <20240516053211.145504-3-harshpb@linux.ibm.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20240516053211.145504-1-harshpb@linux.ibm.com>
References: <20240516053211.145504-1-harshpb@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: GZjtYHLh2iQJZ4l8qgEcOgs8MD5qh5RQ
X-Proofpoint-GUID: M4ebU-5ON3XXXkCLrk1j2I0wnPqqykbs
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-05-16_02,2024-05-15_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 malwarescore=0
 priorityscore=1501 mlxscore=0 impostorscore=0 phishscore=0 mlxlogscore=999
 clxscore=1015 spamscore=0 adultscore=0 lowpriorityscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2405010000
 definitions=main-2405160037
Received-SPF: pass client-ip=148.163.156.1; envelope-from=harshpb@linux.ibm.com;
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

There are distinct helpers for creating and parking a KVM vCPU.
However, there can be cases where a platform needs to create and
immediately park the vCPU during early stages of vcpu init which
can later be reused when vcpu thread gets initialized. This would
help detect failures with kvm_create_vcpu at an early stage.

Based on api refactoring to create/park vcpus introduced in 1/8 of patch series:
https://lore.kernel.org/qemu-devel/20240312020000.12992-2-salil.mehta@huawei.com/

Suggested-by: Nicholas Piggin <npiggin@gmail.com>
Signed-off-by: Harsh Prateek Bora <harshpb@linux.ibm.com>
---
 include/sysemu/kvm.h |  8 ++++++++
 accel/kvm/kvm-all.c  | 12 ++++++++++++
 2 files changed, 20 insertions(+)

diff --git a/include/sysemu/kvm.h b/include/sysemu/kvm.h
index fa3ec74442..221e6bd55b 100644
--- a/include/sysemu/kvm.h
+++ b/include/sysemu/kvm.h
@@ -450,6 +450,14 @@ int kvm_create_vcpu(CPUState *cpu);
  */
 void kvm_park_vcpu(CPUState *cpu);
 
+/**
+ * kvm_create_and_park_vcpu - Create and park a KVM vCPU
+ * @cpu: QOM CPUState object for which KVM vCPU has to be created and parked.
+ *
+ * @returns: 0 when success, errno (<0) when failed.
+ */
+int kvm_create_and_park_vcpu(CPUState *cpu);
+
 #endif /* COMPILING_PER_TARGET */
 
 void kvm_cpu_synchronize_state(CPUState *cpu);
diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
index 30d42847de..3d7e5eaf0b 100644
--- a/accel/kvm/kvm-all.c
+++ b/accel/kvm/kvm-all.c
@@ -381,6 +381,18 @@ int kvm_create_vcpu(CPUState *cpu)
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


