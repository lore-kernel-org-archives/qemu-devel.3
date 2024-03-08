Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09B1AC5475B
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Mar 2024 11:26:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1riYN5-000529-B6; Fri, 08 Mar 2024 06:26:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1riYMa-0004xe-PQ; Fri, 08 Mar 2024 06:26:08 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1riYMX-0005Nr-5I; Fri, 08 Mar 2024 06:26:08 -0500
Received: from pps.filterd (m0353723.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 428ACLPD002815; Fri, 8 Mar 2024 11:25:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=from : to : cc : subject
 : date : message-id : in-reply-to : references : content-transfer-encoding
 : mime-version; s=pp1; bh=re78GFgqOiUHsdXUlCJXHD7vhA4SY6yHrzn2oCWEx94=;
 b=GqvgkP4wsM/auplfZrZ83ZK7d/OokEfvuevtEUTAKz4v0ep+VvoDp/w4osT7uoX7GoEK
 AzFC9gGJqKzWnxQS3w60wjLKYFtAowQL6kY+xCgaaNcZyqtuol7CcjHkwitK1eTg1VDd
 xzu51gjA+gfY6NdCUjJbbT+83WYRYQ7jtE8SJfqhPCtOcR+OCDRMGc2VyeIaF4ZLyqz0
 c7+7Q8pQ6Hjj25bmdCgN6h+IoDpSjJ5yfiUQsPQHpU1hRgJ56mURP7uKwPgpu06oR3PO
 QwdUFWL5ZKg5dWJ0WaZw+w9hMJo7WOANjjuWa1y2eAzo21sA9sscsFdHl/Zj9tIh9n4d Og== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3wr0qdhaqx-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 08 Mar 2024 11:25:53 +0000
Received: from m0353723.ppops.net (m0353723.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 428ALBIJ020189;
 Fri, 8 Mar 2024 11:25:53 GMT
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3wr0qdhaqr-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 08 Mar 2024 11:25:53 +0000
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 428ARvh1024204; Fri, 8 Mar 2024 11:20:52 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3wpjwsqajn-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 08 Mar 2024 11:20:52 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com
 [10.20.54.104])
 by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 428BKkHD30671314
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 8 Mar 2024 11:20:48 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id D1DF42004B;
 Fri,  8 Mar 2024 11:20:46 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 8F0EA2004F;
 Fri,  8 Mar 2024 11:20:44 +0000 (GMT)
Received: from li-1901474c-32f3-11b2-a85c-fc5ff2c001f3.ibm.com.com (unknown
 [9.171.30.1]) by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Fri,  8 Mar 2024 11:20:44 +0000 (GMT)
From: Harsh Prateek Bora <harshpb@linux.ibm.com>
To: npiggin@gmail.com, qemu-ppc@nongnu.org
Cc: clg@kaod.org, mikey@neuling.org, amachhiw@linux.vnet.ibm.com,
 vaibhav@linux.ibm.com, sbhat@linux.ibm.com, danielhb413@gmail.com,
 qemu-devel@nongnu.org
Subject: [PATCH v5 05/14] spapr: nested: Document Nested PAPR API
Date: Fri,  8 Mar 2024 16:49:31 +0530
Message-Id: <20240308111940.1617660-6-harshpb@linux.ibm.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20240308111940.1617660-1-harshpb@linux.ibm.com>
References: <20240308111940.1617660-1-harshpb@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: _T7XWMicVTKkI2Lkyo5GZwh1ddB3Wb1Z
X-Proofpoint-GUID: oCJIfHXpIrrfUt7UKz1Msh76CmuUZY0o
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-08_08,2024-03-06_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 bulkscore=0
 priorityscore=1501 phishscore=0 mlxscore=0 mlxlogscore=999
 lowpriorityscore=0 impostorscore=0 suspectscore=0 adultscore=0
 clxscore=1015 malwarescore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2311290000 definitions=main-2403080090
Received-SPF: pass client-ip=148.163.158.5; envelope-from=harshpb@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_MSPIKE_H4=0.001,
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

Adding initial documentation about Nested PAPR API to describe the set
of APIs and its usage. Also talks about the Guest State Buffer elements
and it's format which is used between L0/L1 to communicate L2 state.

Signed-off-by: Michael Neuling <mikey@neuling.org>
Signed-off-by: Harsh Prateek Bora <harshpb@linux.ibm.com>
---
 docs/devel/nested-papr.txt | 119 +++++++++++++++++++++++++++++++++++++
 1 file changed, 119 insertions(+)
 create mode 100644 docs/devel/nested-papr.txt

diff --git a/docs/devel/nested-papr.txt b/docs/devel/nested-papr.txt
new file mode 100644
index 0000000000..90943650db
--- /dev/null
+++ b/docs/devel/nested-papr.txt
@@ -0,0 +1,119 @@
+Nested PAPR API (aka KVM on PowerVM)
+====================================
+
+This API aims at providing support to enable nested virtualization with
+KVM on PowerVM. While the existing support for nested KVM on PowerNV was
+introduced with cap-nested-hv option, however, with a slight design change,
+to enable this on papr/pseries, a new cap-nested-papr option is added. eg:
+
+  qemu-system-ppc64 -cpu POWER10 -machine pseries,cap-nested-papr=true ...
+
+Work by:
+    Michael Neuling <mikey@neuling.org>
+    Vaibhav Jain <vaibhav@linux.ibm.com>
+    Jordan Niethe <jniethe5@gmail.com>
+    Harsh Prateek Bora <harshpb@linux.ibm.com>
+    Shivaprasad G Bhat <sbhat@linux.ibm.com>
+    Kautuk Consul <kconsul@linux.vnet.ibm.com>
+
+Below taken from the kernel documentation:
+
+Introduction
+============
+
+This document explains how a guest operating system can act as a
+hypervisor and run nested guests through the use of hypercalls, if the
+hypervisor has implemented them. The terms L0, L1, and L2 are used to
+refer to different software entities. L0 is the hypervisor mode entity
+that would normally be called the "host" or "hypervisor". L1 is a
+guest virtual machine that is directly run under L0 and is initiated
+and controlled by L0. L2 is a guest virtual machine that is initiated
+and controlled by L1 acting as a hypervisor. A significant design change
+wrt existing API is that now the entire L2 state is maintained within L0.
+
+Existing Nested-HV API
+======================
+
+Linux/KVM has had support for Nesting as an L0 or L1 since 2018
+
+The L0 code was added::
+
+   commit 8e3f5fc1045dc49fd175b978c5457f5f51e7a2ce
+   Author: Paul Mackerras <paulus@ozlabs.org>
+   Date:   Mon Oct 8 16:31:03 2018 +1100
+   KVM: PPC: Book3S HV: Framework and hcall stubs for nested virtualization
+
+The L1 code was added::
+
+   commit 360cae313702cdd0b90f82c261a8302fecef030a
+   Author: Paul Mackerras <paulus@ozlabs.org>
+   Date:   Mon Oct 8 16:31:04 2018 +1100
+   KVM: PPC: Book3S HV: Nested guest entry via hypercall
+
+This API works primarily using a signal hcall h_enter_nested(). This
+call made by the L1 to tell the L0 to start an L2 vCPU with the given
+state. The L0 then starts this L2 and runs until an L2 exit condition
+is reached. Once the L2 exits, the state of the L2 is given back to
+the L1 by the L0. The full L2 vCPU state is always transferred from
+and to L1 when the L2 is run. The L0 doesn't keep any state on the L2
+vCPU (except in the short sequence in the L0 on L1 -> L2 entry and L2
+-> L1 exit).
+
+The only state kept by the L0 is the partition table. The L1 registers
+it's partition table using the h_set_partition_table() hcall. All
+other state held by the L0 about the L2s is cached state (such as
+shadow page tables).
+
+The L1 may run any L2 or vCPU without first informing the L0. It
+simply starts the vCPU using h_enter_nested(). The creation of L2s and
+vCPUs is done implicitly whenever h_enter_nested() is called.
+
+In this document, we call this existing API the v1 API.
+
+New PAPR API
+===============
+
+The new PAPR API changes from the v1 API such that the creating L2 and
+associated vCPUs is explicit. In this document, we call this the v2
+API.
+
+h_enter_nested() is replaced with H_GUEST_VCPU_RUN().  Before this can
+be called the L1 must explicitly create the L2 using h_guest_create()
+and any associated vCPUs() created with h_guest_create_vCPU(). Getting
+and setting vCPU state can also be performed using h_guest_{g|s}et
+hcall.
+
+The basic execution flow is for an L1 to create an L2, run it, and
+delete it is:
+
+- L1 and L0 negotiate capabilities with H_GUEST_{G,S}ET_CAPABILITIES()
+  (normally at L1 boot time).
+
+- L1 requests the L0 to create an L2 with H_GUEST_CREATE() and receives a token
+
+- L1 requests the L0 to create an L2 vCPU with H_GUEST_CREATE_VCPU()
+
+- L1 and L0 communicate the vCPU state using the H_GUEST_{G,S}ET() hcall
+
+- L1 requests the L0 to run the vCPU using H_GUEST_RUN_VCPU() hcall
+
+- L1 deletes L2 with H_GUEST_DELETE()
+
+For more details, please refer:
+
+[1] Linux Kernel documentation (upstream documentation commit):
+
+commit 476652297f94a2e5e5ef29e734b0da37ade94110
+Author: Michael Neuling <mikey@neuling.org>
+Date:   Thu Sep 14 13:06:00 2023 +1000
+
+    docs: powerpc: Document nested KVM on POWER
+
+    Document support for nested KVM on POWER using the existing API as well
+    as the new PAPR API. This includes the new HCALL interface and how it
+    used by KVM.
+
+    Signed-off-by: Michael Neuling <mikey@neuling.org>
+    Signed-off-by: Jordan Niethe <jniethe5@gmail.com>
+    Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
+    Link: https://msgid.link/20230914030600.16993-12-jniethe5@gmail.com
-- 
2.39.3


