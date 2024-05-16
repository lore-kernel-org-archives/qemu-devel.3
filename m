Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4296C41513
	for <qemu-devel@archiver.kernel.org>; Thu, 16 May 2024 05:33:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s7TjI-00030W-GX; Thu, 16 May 2024 01:32:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1s7TjG-0002zo-8C; Thu, 16 May 2024 01:32:34 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1s7TjD-0005LL-Uh; Thu, 16 May 2024 01:32:33 -0400
Received: from pps.filterd (m0353728.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 44G4tFAf032689; Thu, 16 May 2024 05:32:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=from : to : cc : subject
 : date : message-id : content-transfer-encoding : mime-version; s=pp1;
 bh=FoXInmx9YXA1bG+U1sBH9z1eKOiDxFPF4okLpsVFWcw=;
 b=ZK14/f11Ng7QMk6N8Is//9BYsqA8/7xQ6ZskclGycC/qvr04tEQk8qQd+zPp7335sT0Q
 TAXMryKbeA5cI49nic+h1uA8glntkJEqUB4eSxRgGQGFc9WZ24QCbo3+M8zVTGtzwoce
 Z/0BDkE2dkKNXzP34imkLAQe3AcWKKt4jLpHP4boHRHhluF9VCU7bGeB+YVI+N7G5YDX
 ifPh+yHHkTRDUL7geRLA+WQgoG0wW9cvBuvhx9sXWUKittop0RNZ7jPPwJE4CwkT1hS3
 8b09wxmCTUtBj7vglvyZ5QK3tiklHKfPNmcv8tp2Jhp90QBuzLLUFZrr1U71fqDd8AoM HQ== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3y59ca0ay0-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 16 May 2024 05:32:24 +0000
Received: from m0353728.ppops.net (m0353728.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 44G5WOVT001821;
 Thu, 16 May 2024 05:32:24 GMT
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3y59ca0axw-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 16 May 2024 05:32:24 +0000
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 44G3odPs020165; Thu, 16 May 2024 05:32:22 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3y2kd08arq-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 16 May 2024 05:32:22 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com
 [10.20.54.104])
 by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 44G5WHue47841646
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 16 May 2024 05:32:19 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 0055A2005A;
 Thu, 16 May 2024 05:32:16 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id EFF3D2004E;
 Thu, 16 May 2024 05:32:14 +0000 (GMT)
Received: from li-1901474c-32f3-11b2-a85c-fc5ff2c001f3.ibm.com (unknown
 [9.79.188.146]) by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Thu, 16 May 2024 05:32:14 +0000 (GMT)
From: Harsh Prateek Bora <harshpb@linux.ibm.com>
To: npiggin@gmail.com, qemu-ppc@nongnu.org, qemu-devel@nongnu.org
Cc: danielhb413@gmail.com, vaibhav@linux.ibm.com, sbhat@linux.ibm.com,
 salil.mehta@huawei.com
Subject: [PATCH v2 0/4] target/ppc: vcpu hotplug failure handling fixes
Date: Thu, 16 May 2024 11:02:07 +0530
Message-Id: <20240516053211.145504-1-harshpb@linux.ibm.com>
X-Mailer: git-send-email 2.39.3
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 1OJVgBynNNH93hd4__TsFmRdWng7hmYk
X-Proofpoint-ORIG-GUID: -44zPHQv-liFW-8cM5KlittzGnb1Lp_D
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-05-16_02,2024-05-15_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxscore=0 lowpriorityscore=0
 suspectscore=0 adultscore=0 priorityscore=1501 malwarescore=0
 mlxlogscore=754 phishscore=0 clxscore=1015 spamscore=0 bulkscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2405010000 definitions=main-2405160037
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

This series adds another helper to create and park vcpu (based on below
patch by Salil), exports cpu_get_free_index to be reused later and adds
ppc arch specfic handling for vcpu hotplug failure.

Based on api refactoring to create/park vcpus introduced in 1/8 of patch series:
https://lore.kernel.org/qemu-devel/20240312020000.12992-2-salil.mehta@huawei.com/

PS: I have just included patch 1 of above series after fixing a rebase
failure along with this series for better review purpose only.

Changelog:

v2: Addressed review comments from Nick
v1: Initial patch

Harsh Prateek Bora (3):
  accel/kvm: Introduce kvm_create_and_park_vcpu() helper
  cpu-common.c: export cpu_get_free_index to be reused later
  target/ppc: handle vcpu hotplug failure gracefully

Salil Mehta (1):
  accel/kvm: Extract common KVM vCPU {creation, parking} code

 include/exec/cpu-common.h |  2 ++
 include/sysemu/kvm.h      | 23 ++++++++++++
 accel/kvm/kvm-all.c       | 76 +++++++++++++++++++++++++++++++--------
 cpu-common.c              |  7 ++--
 target/ppc/kvm.c          | 24 +++++++++++++
 accel/kvm/trace-events    |  5 ++-
 6 files changed, 118 insertions(+), 19 deletions(-)

-- 
2.39.3


