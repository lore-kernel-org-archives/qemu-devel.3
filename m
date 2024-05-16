Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C2DEC25B74
	for <qemu-devel@archiver.kernel.org>; Thu, 16 May 2024 05:33:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s7Tjo-00034l-IH; Thu, 16 May 2024 01:33:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1s7TjS-00032u-N4; Thu, 16 May 2024 01:32:47 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1s7TjQ-0005hX-R5; Thu, 16 May 2024 01:32:46 -0400
Received: from pps.filterd (m0353722.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 44G5Wb1o016518; Thu, 16 May 2024 05:32:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=from : to : cc : subject
 : date : message-id : in-reply-to : references : content-transfer-encoding
 : mime-version; s=pp1; bh=I678dacXl261lVS013lYkynLZKJvHEkh8s0YU1N4Tbs=;
 b=gkHPOrspRojecnzpsQl/UXUv9qpPX3EAOp+BhC0ZMtD/IDX6rHpiEDnjmluUFHiiY2Qn
 +vvc+Q9VlFEtnKIA7j3uW8mSr0dosQ2SL3Phop9vvONO8LBNWcERY7jRNQsoiXj8hu3p
 8k22uGRr1ay0E8xOry9E5TViU6K07FQS1RQfrVt7A6+XUWO0YtJCRtw8/SfQeHW+kUhl
 d1P0dBXITTbHeMkxofgoCqhpC2wA0qTYNaAOcrXyUoK/wSJkxp1Z3Hi/tliv6RR0fNfy
 EERskEv7P9gEZJoM0p3m+FB1hCnHo8fUT6p8A1GRubJztyL036c9H1hesDh1FosdFkhM Ew== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3y5c36000c-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 16 May 2024 05:32:36 +0000
Received: from m0353722.ppops.net (m0353722.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 44G5WZOF016506;
 Thu, 16 May 2024 05:32:35 GMT
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3y5c36000b-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 16 May 2024 05:32:35 +0000
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 44G5AQkp005504; Thu, 16 May 2024 05:32:35 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 3y2nq2yr79-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 16 May 2024 05:32:35 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com
 [10.20.54.104])
 by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 44G5WTWn55968038
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 16 May 2024 05:32:31 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id AD7012004F;
 Thu, 16 May 2024 05:32:29 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 9B39C2004D;
 Thu, 16 May 2024 05:32:27 +0000 (GMT)
Received: from li-1901474c-32f3-11b2-a85c-fc5ff2c001f3.ibm.com (unknown
 [9.79.188.146]) by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Thu, 16 May 2024 05:32:27 +0000 (GMT)
From: Harsh Prateek Bora <harshpb@linux.ibm.com>
To: npiggin@gmail.com, qemu-ppc@nongnu.org, qemu-devel@nongnu.org
Cc: danielhb413@gmail.com, vaibhav@linux.ibm.com, sbhat@linux.ibm.com,
 salil.mehta@huawei.com
Subject: [PATCH v2 4/4] target/ppc: handle vcpu hotplug failure gracefully
Date: Thu, 16 May 2024 11:02:11 +0530
Message-Id: <20240516053211.145504-5-harshpb@linux.ibm.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20240516053211.145504-1-harshpb@linux.ibm.com>
References: <20240516053211.145504-1-harshpb@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: x_uuvj0dm4zseI3ohVxygHQX-5bz1bA3
X-Proofpoint-GUID: x8Oznjey9MFLd8ou0UZJX-KKJJmyCfYW
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-05-16_02,2024-05-15_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 clxscore=1015
 adultscore=0 suspectscore=0 impostorscore=0 priorityscore=1501
 mlxlogscore=999 mlxscore=0 malwarescore=0 phishscore=0 bulkscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2405010000 definitions=main-2405160037
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

On ppc64, the PowerVM hypervisor runs with limited memory and a VCPU
creation during hotplug may fail during kvm_ioctl for KVM_CREATE_VCPU,
leading to termination of guest since errp is set to &error_fatal while
calling kvm_init_vcpu. This unexpected behaviour can be avoided by
pre-creating and parking vcpu on success or return error otherwise.
This enables graceful error delivery for any vcpu hotplug failures while
the guest can keep running.

Based on api refactoring to create/park vcpus introduced in 1/8 of patch series:
https://lore.kernel.org/qemu-devel/20240312020000.12992-2-salil.mehta@huawei.com/

Tested OK by repeatedly doing a hotplug/unplug of vcpus as below:

 #virsh setvcpus hotplug 40
 #virsh setvcpus hotplug 70
error: internal error: unable to execute QEMU command 'device_add':
kvmppc_cpu_realize: vcpu hotplug failed with -12

Reported-by: Anushree Mathur <anushree.mathur@linux.vnet.ibm.com>
Suggested-by: Shivaprasad G Bhat <sbhat@linux.ibm.com>
Suggested-by: Vaibhav Jain <vaibhav@linux.ibm.com>
Signed-off by: Harsh Prateek Bora <harshpb@linux.ibm.com>
Tested-by: Anushree Mathur <anushree.mathur@linux.vnet.ibm.com>
---
 target/ppc/kvm.c | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/target/ppc/kvm.c b/target/ppc/kvm.c
index 63930d4a77..25f0cf0ba8 100644
--- a/target/ppc/kvm.c
+++ b/target/ppc/kvm.c
@@ -48,6 +48,8 @@
 #include "qemu/mmap-alloc.h"
 #include "elf.h"
 #include "sysemu/kvm_int.h"
+#include "sysemu/kvm.h"
+#include "hw/core/accel-cpu.h"
 
 #define PROC_DEVTREE_CPU      "/proc/device-tree/cpus/"
 
@@ -2339,6 +2341,26 @@ static void alter_insns(uint64_t *word, uint64_t flags, bool on)
     }
 }
 
+static bool kvmppc_cpu_realize(CPUState *cs, Error **errp)
+{
+    int ret;
+
+    cs->cpu_index = cpu_get_free_index();
+
+    POWERPC_CPU(cs)->vcpu_id = cs->cpu_index;
+
+    if (cs->parent_obj.hotplugged) {
+        /* create and park to fail gracefully in case vcpu hotplug fails */
+        ret = kvm_create_and_park_vcpu(cs);
+        if (ret) {
+            error_setg(errp, "%s: vcpu hotplug failed with %d",
+                             __func__, ret);
+            return false;
+        }
+    }
+    return true;
+}
+
 static void kvmppc_host_cpu_class_init(ObjectClass *oc, void *data)
 {
     PowerPCCPUClass *pcc = POWERPC_CPU_CLASS(oc);
@@ -2958,4 +2980,6 @@ void kvmppc_set_reg_tb_offset(PowerPCCPU *cpu, int64_t tb_offset)
 
 void kvm_arch_accel_class_init(ObjectClass *oc)
 {
+    AccelClass *ac = ACCEL_CLASS(oc);
+    ac->cpu_common_realize = kvmppc_cpu_realize;
 }
-- 
2.39.3


