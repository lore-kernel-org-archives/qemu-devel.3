Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 802A1C25B75
	for <qemu-devel@archiver.kernel.org>; Thu, 23 May 2024 07:27:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sA2ql-0007AL-6Z; Thu, 23 May 2024 03:26:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1sA2qj-00079T-3K; Thu, 23 May 2024 03:26:53 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1sA2qh-00008d-BB; Thu, 23 May 2024 03:26:52 -0400
Received: from pps.filterd (m0353727.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 44N7IUGB022733; Thu, 23 May 2024 07:26:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=u7t5/AqU71PS3fk3TudCv8Nw3kUnartbBsM+VxyIwOY=;
 b=R0jBpLGV8Cb0yPx96foUdxNd/iiej3JeX18dfWl2rKUZUB4QuryUBPLi0CCqd6fZV6Rh
 mzrRNDx/PXx8XHtB6CMFtAFTUevuIdWnVAUqvdylZwO71C+rlXL59vzzcvuNKvVHb3EZ
 OFTlD4D9wWqPZXc8No5AdImIwf9eSlxLo4h0rv/krhw6Mvrvrcb+L3NcRo6NXLytK6Uw
 ozKM2Y7IXnxKzJHhgxh0kLuSSP0eILsUPR3OpO3J9J2CIuD0dVFBNUmFDFumWfqHtX7W
 KbbLVDb08DXf88WaQ/KafcUpqY+F76ppHtdEIg0ygrt/SbnPB+2YytPPRixNQGyqkiCr Hw== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3ya19a00mr-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 23 May 2024 07:26:49 +0000
Received: from m0353727.ppops.net (m0353727.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 44N7QnD4002962;
 Thu, 23 May 2024 07:26:49 GMT
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3ya19a00mn-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 23 May 2024 07:26:49 +0000
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 44N6bZQ4000923; Thu, 23 May 2024 07:26:46 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3y7720gugq-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 23 May 2024 07:26:46 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com
 [10.20.54.102])
 by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 44N7QeXo30212854
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 23 May 2024 07:26:42 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id AA2CF20043;
 Thu, 23 May 2024 07:26:40 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 787302004F;
 Thu, 23 May 2024 07:26:39 +0000 (GMT)
Received: from li-1901474c-32f3-11b2-a85c-fc5ff2c001f3.in.ibm.com (unknown
 [9.109.242.165])
 by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Thu, 23 May 2024 07:26:39 +0000 (GMT)
From: Harsh Prateek Bora <harshpb@linux.ibm.com>
To: npiggin@gmail.com, qemu-ppc@nongnu.org, qemu-devel@nongnu.org
Cc: danielhb413@gmail.com, vaibhav@linux.ibm.com, sbhat@linux.ibm.com
Subject: [PATCH v3 3/3] target/ppc: handle vcpu hotplug failure gracefully
Date: Thu, 23 May 2024 12:56:14 +0530
Message-Id: <20240523072614.256172-4-harshpb@linux.ibm.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20240523072614.256172-1-harshpb@linux.ibm.com>
References: <20240523072614.256172-1-harshpb@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: klkwyRq9VPNrSXLz3V2t5tJrskE6seTZ
X-Proofpoint-GUID: cW-4UysHJjP57rj4rWzhdX-bTD2FarjR
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.12.28.16
 definitions=2024-05-23_04,2024-05-22_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 bulkscore=0
 clxscore=1015 impostorscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 malwarescore=0 suspectscore=0 lowpriorityscore=0 priorityscore=1501
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2405010000 definitions=main-2405230048
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

On ppc64, the PowerVM hypervisor runs with limited memory and a VCPU
creation during hotplug may fail during kvm_ioctl for KVM_CREATE_VCPU,
leading to termination of guest since errp is set to &error_fatal while
calling kvm_init_vcpu. This unexpected behaviour can be avoided by
pre-creating and parking vcpu on success or return error otherwise.
This enables graceful error delivery for any vcpu hotplug failures while
the guest can keep running.

Also introducing KVM AccelCPUClass to init cpu_target_realize for kvm.

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
 target/ppc/kvm.c | 41 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 41 insertions(+)

diff --git a/target/ppc/kvm.c b/target/ppc/kvm.c
index 63930d4a77..8e5a7c3d2d 100644
--- a/target/ppc/kvm.c
+++ b/target/ppc/kvm.c
@@ -48,6 +48,8 @@
 #include "qemu/mmap-alloc.h"
 #include "elf.h"
 #include "sysemu/kvm_int.h"
+#include "accel/kvm/kvm-cpus.h"
+#include "hw/core/accel-cpu.h"
 
 #define PROC_DEVTREE_CPU      "/proc/device-tree/cpus/"
 
@@ -2339,6 +2341,25 @@ static void alter_insns(uint64_t *word, uint64_t flags, bool on)
     }
 }
 
+static bool kvmppc_cpu_realize(CPUState *cs, Error **errp)
+{
+    int ret;
+    const char *vcpu_str = (cs->parent_obj.hotplugged == true) ?
+                           "hotplug" : "create";
+    cs->cpu_index = cpu_get_free_index();
+
+    POWERPC_CPU(cs)->vcpu_id = cs->cpu_index;
+
+    /* create and park to fail gracefully in case vcpu hotplug fails */
+    ret = kvm_create_and_park_vcpu(cs);
+    if (ret) {
+        error_setg(errp, "%s: vcpu %s failed with %d",
+                         __func__, vcpu_str, ret);
+        return false;
+    }
+    return true;
+}
+
 static void kvmppc_host_cpu_class_init(ObjectClass *oc, void *data)
 {
     PowerPCCPUClass *pcc = POWERPC_CPU_CLASS(oc);
@@ -2959,3 +2980,23 @@ void kvmppc_set_reg_tb_offset(PowerPCCPU *cpu, int64_t tb_offset)
 void kvm_arch_accel_class_init(ObjectClass *oc)
 {
 }
+
+static void kvm_cpu_accel_class_init(ObjectClass *oc, void *data)
+{
+    AccelCPUClass *acc = ACCEL_CPU_CLASS(oc);
+
+    acc->cpu_target_realize = kvmppc_cpu_realize;
+}
+
+static const TypeInfo kvm_cpu_accel_type_info = {
+    .name = ACCEL_CPU_NAME("kvm"),
+
+    .parent = TYPE_ACCEL_CPU,
+    .class_init = kvm_cpu_accel_class_init,
+    .abstract = true,
+};
+static void kvm_cpu_accel_register_types(void)
+{
+    type_register_static(&kvm_cpu_accel_type_info);
+}
+type_init(kvm_cpu_accel_register_types);
-- 
2.39.3


