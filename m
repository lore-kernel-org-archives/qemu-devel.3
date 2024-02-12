Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A58DC4829E
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Feb 2024 04:16:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rZNif-0002wm-HZ; Sun, 11 Feb 2024 23:15:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1rZNid-0002vz-Bx; Sun, 11 Feb 2024 23:14:59 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1rZNib-0008S6-LZ; Sun, 11 Feb 2024 23:14:59 -0500
Received: from pps.filterd (m0353726.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 41C40jsA007412; Mon, 12 Feb 2024 04:14:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=I4YjlxznhR/yUVIOsxPoz/GvGsv1RZRoXc3BOzWQerQ=;
 b=THF84UVng0XE/QYb2QmkN45oGnyPLNLcABXmIn4bJT2LXMxoWRY5JrZFIB05LT9mwpI1
 12Ji+Wj5aLNd9UTjmNIxR8zWv9/wUYjk1KQcYL63GaP2rFKJRpxctrFQylMCu+32RAdv
 cglcJc/rDTK6J98DgUhBKf5Vfiierv1nZ84W9w5gBeOZ5Dm712d86iy+e9+n7FI6IQKI
 Mn4gAl2j62xojCTnBFwzVZuuDEgrqoWvJGc+Vy/W2GknWOrYVGx7jFwCN6pDQLEatNSQ
 nZ6MptmwUucQIvnUl+LXC/yfOnVZPmjViATObAU0D8hLdDiEzUM2sSrKRmMvmHQ2atpc Og== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3w7bwxr635-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 12 Feb 2024 04:14:45 +0000
Received: from m0353726.ppops.net (m0353726.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 41C40l7W007506;
 Mon, 12 Feb 2024 04:14:44 GMT
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3w7bwxr62r-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 12 Feb 2024 04:14:44 +0000
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 41C2LnQB004258; Mon, 12 Feb 2024 04:14:43 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3w6kuyxhsj-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 12 Feb 2024 04:14:43 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com
 [10.20.54.100])
 by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 41C4EdOl66453870
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 12 Feb 2024 04:14:41 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 3137820043;
 Mon, 12 Feb 2024 04:14:39 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 883CE20040;
 Mon, 12 Feb 2024 04:14:37 +0000 (GMT)
Received: from li-1901474c-32f3-11b2-a85c-fc5ff2c001f3.ibm.com.com (unknown
 [9.179.18.54]) by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Mon, 12 Feb 2024 04:14:37 +0000 (GMT)
From: Harsh Prateek Bora <harshpb@linux.ibm.com>
To: npiggin@gmail.com, qemu-ppc@nongnu.org
Cc: kowsjois@linux.ibm.com, clg@kaod.org, danielhb413@gmail.com,
 david@gibson.dropbear.id.au, qemu-devel@nongnu.org
Subject: [PATCH v4 2/2] ppc/spapr: Initialize max_cpus limit to
 SPAPR_IRQ_NR_IPIS.
Date: Mon, 12 Feb 2024 09:44:23 +0530
Message-Id: <20240212041423.293085-3-harshpb@linux.ibm.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20240212041423.293085-1-harshpb@linux.ibm.com>
References: <20240212041423.293085-1-harshpb@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: CLO3VlXiZbEE6OuLES4uvJTCOD-fZFRE
X-Proofpoint-GUID: Xdcr0rOZmQHVX5xHWp1dINNbd6LZRVOP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-12_02,2024-02-08_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 spamscore=0
 adultscore=0 malwarescore=0 priorityscore=1501 bulkscore=0 mlxlogscore=999
 phishscore=0 impostorscore=0 mlxscore=0 lowpriorityscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2402120031
Received-SPF: pass client-ip=148.163.156.1; envelope-from=harshpb@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_MSPIKE_H3=-0.01,
 RCVD_IN_MSPIKE_WL=-0.01, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

Initialize the machine specific max_cpus limit as per the maximum range
of CPU IPIs available. Keeping between 4096 to 8192 will throw IRQ not
free error due to XIVE/XICS limitation and keeping beyond 8192 will hit
assert in tcg_region_init or spapr_xive_claim_irq.

Logs:

Without patch fix:

[root@host build]# qemu-system-ppc64 -accel tcg -smp 10,maxcpus=4097
qemu-system-ppc64: IRQ 4096 is not free
[root@host build]#

On LPAR:
[root@host build]# qemu-system-ppc64 -accel tcg -smp 10,maxcpus=8193
**
ERROR:../tcg/region.c:774:tcg_region_init: assertion failed:
(region_size >= 2 * page_size)
Bail out! ERROR:../tcg/region.c:774:tcg_region_init: assertion failed:
(region_size >= 2 * page_size)
Aborted (core dumped)
[root@host build]#

On x86:
[root@host build]# qemu-system-ppc64 -accel tcg -smp 10,maxcpus=8193
qemu-system-ppc64: ../hw/intc/spapr_xive.c:596: spapr_xive_claim_irq:
Assertion `lisn < xive->nr_irqs' failed.
Aborted (core dumped)
[root@host build]#

With patch fix:
[root@host build]# qemu-system-ppc64 -accel tcg -smp 10,maxcpus=4097
qemu-system-ppc64: Invalid SMP CPUs 4097. The max CPUs supported by
machine 'pseries-8.2' is 4096
[root@host build]#

Reported-by: Kowshik Jois <kowsjois@linux.ibm.com>
Tested-by: Kowshik Jois <kowsjois@linux.ibm.com>
Signed-off-by: Harsh Prateek Bora <harshpb@linux.ibm.com>
---
 hw/ppc/spapr.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index 0d72d286d8..0028ce0b67 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -4639,13 +4639,10 @@ static void spapr_machine_class_init(ObjectClass *oc, void *data)
     mc->block_default_type = IF_SCSI;
 
     /*
-     * Setting max_cpus to INT32_MAX. Both KVM and TCG max_cpus values
-     * should be limited by the host capability instead of hardcoded.
-     * max_cpus for KVM guests will be checked in kvm_init(), and TCG
-     * guests are welcome to have as many CPUs as the host are capable
-     * of emulate.
+     * While KVM determines max cpus in kvm_init() using kvm_max_vcpus(),
+     * In TCG the limit is restricted by the range of CPU IPIs available.
      */
-    mc->max_cpus = INT32_MAX;
+    mc->max_cpus = SPAPR_IRQ_NR_IPIS;
 
     mc->no_parallel = 1;
     mc->default_boot_order = "";
-- 
2.39.3


