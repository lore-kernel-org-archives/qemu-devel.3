Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91E60FF886F
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2026 08:55:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wINAd-0005HB-K4; Thu, 30 Apr 2026 04:54:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shivangu@linux.ibm.com>)
 id 1wINAH-0005GD-BO; Thu, 30 Apr 2026 04:54:34 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shivangu@linux.ibm.com>)
 id 1wINAF-00011j-Jd; Thu, 30 Apr 2026 04:54:33 -0400
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63TLU0DV2980335; Thu, 30 Apr 2026 08:54:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=pp1; bh=VxRae1HQC2CYuXasuQKwTR+evDo63C89Io5E48FhD
 O0=; b=D2cpdBE0Cmeg0EyBNKIlzyNDSfWguuk9F7dEE0dUJy6srkorMzNfUIFI9
 D8biSV+IVUDbrv5oi7rIGcGwiBHERYSeq31F20wy2m2XalDEHKLqZzLzbglEBJz6
 x6+2Q4Zw2NtqcVWWCwxT1Gshg5fzrPZKu560dnMtgdFUpf+40HNva0TV+n3zHDp3
 g4uAuFUD3u+4WcUJECKcu6zVOlYXv8qgMpsCBd7bX9MyrzkpgsdmqDBH05hQLtNx
 IiuYJFEFgmPPnC1DFNzJhhYFhFuhVVsMufpSpbvB2vE+jBLX4ctZhuTAhB8wkX+z
 lpFuSLpAdi672PSTLNysKi4nEKBHg==
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4drnb5esp0-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 30 Apr 2026 08:54:27 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 63U8ruRI028929;
 Thu, 30 Apr 2026 08:54:26 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4ds7xqja7w-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 30 Apr 2026 08:54:26 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com
 [10.20.54.106])
 by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 63U8sMrb29360404
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 30 Apr 2026 08:54:22 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 3334A20043;
 Thu, 30 Apr 2026 08:54:22 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id E8F6020040;
 Thu, 30 Apr 2026 08:54:19 +0000 (GMT)
Received: from shivang.com (unknown [9.123.12.247])
 by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Thu, 30 Apr 2026 08:54:19 +0000 (GMT)
From: Shivang Upadhyay <shivangu@linux.ibm.com>
To: qemu-ppc@nongnu.org, qemu-devel@nongnu.org
Cc: Shivang Upadhyay <shivangu@linux.ibm.com>,
 Sourabh Jain <sourabhjain@linux.ibm.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
 Anushree Mathur <anushree.mathur@linux.vnet.ibm.com>,
 Vishal Chourasia <vishalc@linux.ibm.com>
Subject: [PATCH] ppc/spapr: Skip system reset for quiesced CPUs
Date: Thu, 30 Apr 2026 14:24:09 +0530
Message-ID: <20260430085409.680930-1-shivangu@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=AqDeGu9P c=1 sm=1 tr=0 ts=69f318c3 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8 a=792TYEGmVTkjWTrGcAYA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDMwMDA4NyBTYWx0ZWRfXy5MMaPBh1Prj
 N2i/mcvICBPkmYilXvuX8Q0h/QWnvANVdJXi2kho5Wq19Cu+teJMfkm3ZXa99Qpacofai4r3d0D
 f+QPlqXcoEjyhsMu80eoMMPdUzXvvfe72b1zULsbgmHsuQtYCVcVOnWKZS7rrGArdL/3+avZsrC
 Wo1+vsZNRLmfCgDkV0cRnijO2InsTxJntek68jkZOImPNVlcgKvjmC/E8cGu97JksNRG5lGhFxR
 ShV6t/+zDZh3hECrdc1gE4/ReYD/LQdMr/efW37h6WkJD7rHrZ9BjqmV1B7crA6u7aqMXHNhpwI
 yfQIknkc6glrjUFHbxe8QrRoBMQyWWyKbVsOjKYRKjUxLP94BhRVio0t/HeoRbQHUfeTQ4dN6ks
 L1v9w7XW1W+JqDqEbirjzVpx1IvSITs584pDi4G7wNpDwt+XFMr7DIL7wdOqFHl8FQ9DqrBk56J
 6r9GGO5jvw9YNH4pbmw==
X-Proofpoint-GUID: RlCB-gKURb2FDNLNWEUhaYE8cEGnzqBX
X-Proofpoint-ORIG-GUID: RlCB-gKURb2FDNLNWEUhaYE8cEGnzqBX
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-30_02,2026-04-28_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 priorityscore=1501 phishscore=0 suspectscore=0 clxscore=1015
 lowpriorityscore=0 spamscore=0 bulkscore=0 impostorscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2604300087
Received-SPF: pass client-ip=148.163.156.1;
 envelope-from=shivangu@linux.ibm.com; helo=mx0a-001b2d01.pphosted.com
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

During DLPAR CPU hotplug, newly added CPUs start in RTAS stopped state
(quiesced). If a kexec crash occurs before the guest starts these CPUs
via start-cpu RTAS call, H_SIGNAL_SYS_RESET_ALL_OTHERS will reset them
anyway, causing the kdump kernel to hang:

  [    5.519483][    T1] Processor 0 is stuck.
  [   11.089481][    T1] Processor 1 is stuck.

The hypervisor should only reset CPUs that the guest has started. The
cpu->env.quiesced flag tracks RTAS stopped state - CPUs in this state
are already inactive and should not be reset.

Skip system reset for quiesced CPUs to prevent kdump hangs during CPU
hotplug operations.

Cc: Sourabh Jain <sourabhjain@linux.ibm.com>
Cc: Harsh Prateek Bora <harshpb@linux.ibm.com>
Cc: Mahesh J Salgaonkar <mahesh@linux.ibm.com>
Reported-by: Anushree Mathur <anushree.mathur@linux.vnet.ibm.com>
Suggested-by: Vishal Chourasia <vishalc@linux.ibm.com>
Signed-off-by: Shivang Upadhyay <shivangu@linux.ibm.com>
---
 hw/ppc/spapr_hcall.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/hw/ppc/spapr_hcall.c b/hw/ppc/spapr_hcall.c
index 032805a8d0..e63ec24f0c 100644
--- a/hw/ppc/spapr_hcall.c
+++ b/hw/ppc/spapr_hcall.c
@@ -1105,6 +1105,10 @@ static target_ulong h_signal_sys_reset(PowerPCCPU *cpu,
                     continue;
                 }
             }
+
+            /* Skip quiesced CPUs */
+            if (c->env.quiesced) continue;
+
             run_on_cpu(cs, spapr_do_system_reset_on_cpu, RUN_ON_CPU_NULL);
         }
         return H_SUCCESS;
-- 
2.53.0


