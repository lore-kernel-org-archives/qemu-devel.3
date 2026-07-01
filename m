Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0645BC43458
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Jul 2026 05:24:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wenQy-0005Kq-1X; Wed, 01 Jul 2026 01:24:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <amachhiw@linux.ibm.com>)
 id 1wenQq-0005HP-Ed; Wed, 01 Jul 2026 01:24:20 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <amachhiw@linux.ibm.com>)
 id 1wenQo-0006vA-Rd; Wed, 01 Jul 2026 01:24:20 -0400
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6613ITPv3867661; Wed, 1 Jul 2026 05:24:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=DvUNM2yInTrMM5EIJ
 za3iZuXRbSUIN7ITRWGH8qgp5w=; b=AL+w5b2V8SbcNO8waMNtCWbLSYVEMQaba
 fCPyWipDINFw7LEygHrCTKpjb/MvVYaCvthzyTFoD8SSicGvTck9xNcW5XtgYN6i
 3DqBlUm5YQssE2zmqtI5nPI43fR7PSTDIQh9Gvm12d5hnkM9BZJ2ekJ9cULcPKKA
 1qq9Hm6AwdzmZfP6dkWN4FbD30Ktk7Jx+X0rR8/MrUKsRh/OnkYBZQK9j1qiYC7s
 Ni7euZBIpTJQP1f/X+vFvuv2kwi8E4thBhtV4D2i8j7LHrajEupJIOQDxBNqVs0k
 f1Wn86KIMGso0ojAKmVcrYC65hUTr0n5TPAJYspvLI4DUYUlZCkFw==
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4f26n5tp9d-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 01 Jul 2026 05:24:16 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 6615JrWK013686;
 Wed, 1 Jul 2026 05:24:15 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4f2u2gdmav-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 01 Jul 2026 05:24:15 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com
 [10.20.54.105])
 by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 6615OC6v43778380
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 1 Jul 2026 05:24:12 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 11A9E20049;
 Wed,  1 Jul 2026 05:24:12 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 5EF5520040;
 Wed,  1 Jul 2026 05:24:09 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.124.211.190])
 by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Wed,  1 Jul 2026 05:24:09 +0000 (GMT)
From: Amit Machhiwal <amachhiw@linux.ibm.com>
To: qemu-ppc@nongnu.org, Harsh Prateek Bora <harshpb@linux.ibm.com>
Cc: Amit Machhiwal <amachhiw@linux.ibm.com>,
 Vaibhav Jain <vaibhav@linux.ibm.com>, Nicholas Piggin <npiggin@gmail.com>,
 Chinmay Rath <rathc@linux.ibm.com>, Glenn Miles <milesg@linux.ibm.com>,
 Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org,
 qemu-devel@nongnu.org
Subject: [PATCH v4 3/3] target/ppc/kvm: Use host compatibility mode for nested
 guests
Date: Wed,  1 Jul 2026 10:53:41 +0530
Message-ID: <20260701052341.62289-4-amachhiw@linux.ibm.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260701052341.62289-1-amachhiw@linux.ibm.com>
References: <20260701052341.62289-1-amachhiw@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzAxMDA1MiBTYWx0ZWRfX5jSXwfx9kSox
 3x46C58zdm+ZokOp0SHPIksr/cq0+GYs4O5I5SSpusbiybarJy6I1Cj0HT5RF9kgEZKfgFzNtds
 M94G82q808fsR0Pq7Ic2BVzGj34PeKmGW4DvYQmEcFxUezUHaKNB0ETajhS6Pd4EUCA0r7yy/++
 AjGCGJtv6Rzq/gQ6vfcCDERaxyyaINWT6SUINv/55ZR4+cp++QyqFQW1aZnPWZLuwc417/4P92B
 PEKHLjLGVgvMZ8EvtNc923vrPi3LSqptJIqvR10DVer0WcGI9Ljt2c/0sbH8G4b12Ud35PiGoBp
 OOwSPeMiwa1ULSh9zKuR27h4TCHONlQaV8JVOelw/AhXHTxTUfqqMKo+avoQCkVk5b6UAboswG9
 nV3C0JB7pe4WE0fvRsrCEEYPoy++dXOEneczOxvRYruuqf8a1JUIf3HQ48tKQ7ES1A72w4V9orl
 uBfkYx1iaiyWksRdgIg==
X-Authority-Analysis: v=2.4 cv=V45NF+ni c=1 sm=1 tr=0 ts=6a44a481 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8 a=tLWNhYkk1iXv8su3ZXkA:9
X-Proofpoint-ORIG-GUID: jcaUA9SlAEktDljjTf_IrN-n87U3FoFk
X-Proofpoint-GUID: Tnr6WQQhpftfhf4iWK7RLncCxdx15OGK
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzAxMDA1MiBTYWx0ZWRfXwKVhQ8cLwaLC
 iGBJP6gh1lFSyiU1KSBH6v5YBPSpeUnJfzZ2GOJAfQTP/gJhAv9ZyuW9zKo0v+P63JCXenj47ko
 GMLjEidqis0PtEDxVxtFWfx6vHvkIsg=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-01_01,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 spamscore=0 suspectscore=0 lowpriorityscore=0 priorityscore=1501
 adultscore=0 clxscore=1015 impostorscore=0 malwarescore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607010052
Received-SPF: pass client-ip=148.163.156.1;
 envelope-from=amachhiw@linux.ibm.com; helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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

On POWER systems, the host CPU may run in a compatibility mode (e.g.,
a Power11 processor operating in Power10 compatibility mode). When
running nested KVM guests, QEMU currently derives the host CPU type
using mfpvr(), which reflects the physical processor version. This can
result in a mismatch between the CPU model used by QEMU and the
compatibility mode enforced by the host, leading to guest boot failures
such as "KVM-NESTEDv2: couldn't set guest wide elements".

Update kvm_ppc_get_host_cpu_class() to check if the host is running in
a compatibility mode using kvm_ppc_host_compat_pvr(). When available,
use the compatibility PVR instead of the raw hardware PVR when selecting
the CPU model. This ensures that QEMU selects a CPU model consistent
with the host compatibility mode, allowing nested guests to boot
correctly.

The guard uses #if defined(TARGET_PPC64) to prevent build breakage on
ppc32 targets where the POWER9/10/11 PVR constants are not defined.

Signed-off-by: Amit Machhiwal <amachhiw@linux.ibm.com>
---
Changes in v4:
- Updated commit log
- Added a #ifndef CONFIG_KVM compile-time assertion inside the
  TARGET_PPC64 guard as a sanity check, since kvm_ppc_get_host_cpu_class()
  is only ever built with CONFIG_KVM=y.

 target/ppc/kvm.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/target/ppc/kvm.c b/target/ppc/kvm.c
index b1b596f004ef..105b838cdef9 100644
--- a/target/ppc/kvm.c
+++ b/target/ppc/kvm.c
@@ -2682,6 +2682,18 @@ PowerPCCPUClass *kvm_ppc_get_host_cpu_class(void)
     uint32_t host_pvr = mfpvr();
     PowerPCCPUClass *pvr_pcc;
 
+#if defined(TARGET_PPC64)
+#ifndef CONFIG_KVM
+#error "CONFIG_KVM is not enabled"
+#endif
+    uint32_t compat_host_pvr;
+
+    compat_host_pvr = kvm_ppc_host_compat_pvr();
+    if (compat_host_pvr) {
+        host_pvr = compat_host_pvr;
+    }
+#endif /* TARGET_PPC64 */
+
     pvr_pcc = ppc_cpu_class_by_pvr(host_pvr);
     if (pvr_pcc == NULL) {
         pvr_pcc = ppc_cpu_class_by_pvr_mask(host_pvr);
-- 
2.50.1 (Apple Git-155)


