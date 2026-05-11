Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14378CD37B5
	for <qemu-devel@archiver.kernel.org>; Mon, 11 May 2026 09:52:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wMNIT-0002MU-GE; Mon, 11 May 2026 05:51:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shivangu@linux.ibm.com>)
 id 1wMNII-00019z-Pl; Mon, 11 May 2026 05:51:22 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shivangu@linux.ibm.com>)
 id 1wMNIG-0004IW-Hp; Mon, 11 May 2026 05:51:22 -0400
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64B6urjL2232584; Mon, 11 May 2026 09:51:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=MlV7SnLwADaKPO313
 8kKInD8wFMfgwDamRknduAav4s=; b=g15BgJ/X+1vg+jtmc3Zo/jl3nBA7yS08X
 vxNu6m8qE8acmNmiag3p/NF9vGjOXmF0Q5K2nrZ9chx8VYCHeQzqNEHlpvDczmE8
 /TSXeIJCzE/5Deu05emUFjrN8rkDUgJqT0wPjvxFF6jh0+QPOhAsMgca+0DZmsRA
 YUEFHjBizXaCu9Dkd3+Wkf3ogf1jicUXbJUH0wI1s0ohAT+cWhf1qqpOlq8PuEMb
 BV9V8yKn48FhqomLbKxGpIySXj1tkJlaxXTTtld2C6GTvZ3w9eecbaZxc9WX07LB
 MrKw3dt5OgvAaKUc28P82yd7lFuC2+peE/dG/dA05ujm2JTnehflg==
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4e1tbhqc2p-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 11 May 2026 09:51:18 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 64B9h6H7000376;
 Mon, 11 May 2026 09:51:18 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4e2g8jvp4j-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 11 May 2026 09:51:17 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com
 [10.20.54.106])
 by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 64B9pCMa43778474
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 11 May 2026 09:51:12 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 9D2DE20043;
 Mon, 11 May 2026 09:51:12 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 1488720040;
 Mon, 11 May 2026 09:51:11 +0000 (GMT)
Received: from shivang.bl1-in.ibm.com (unknown [9.123.12.247])
 by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Mon, 11 May 2026 09:51:10 +0000 (GMT)
From: Shivang Upadhyay <shivangu@linux.ibm.com>
To: qemu-devel@nongnu.org, qemu-ppc@nongnu.org
Cc: shivangu@linux.ibm.com, anushree.mathur@linux.vnet.ibm.com,
 harshpb@linux.ibm.com, mahesh@linux.ibm.com, sourabhjain@linux.ibm.com,
 vishalc@linux.ibm.com
Subject: [PATCH v2] ppc/spapr: Skip system reset for quiesced CPUs
Date: Mon, 11 May 2026 15:20:55 +0530
Message-ID: <20260511095055.82495-1-shivangu@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260430085409.680930-1-shivangu@linux.ibm.com>
References: <20260430085409.680930-1-shivangu@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=ZdQt8MVA c=1 sm=1 tr=0 ts=6a01a696 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8
 a=i00pLCdPjY8cvlh5Y4gA:9
X-Proofpoint-ORIG-GUID: aE2GTTynZFXLVhp8F4QuexyKoDYpr0iF
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTExMDEwNSBTYWx0ZWRfX0BOPSaQJSc3T
 CzIiXn8ISjVHggVq49Hg7IvuqM0gwLwVSk9tOdpCXDMX8iwxaQhJTdd+Oj0uEMQCBlxyV45IrbL
 71YDjsHt3bFnh9faaualy/j8uiVZYWv1jzrPOH1ILu/+SLTsAYHmGwc3mp9EdEUBqQlGo172TDe
 hUdiC4D6oTDWg1lYyNpr10J/2uaIvDy3IlOeR7QfJTdfvNAng56/7ppsrapNuJChXJ7iCKgsulJ
 FD+naAvL0nnbO9KjvXIqMQP4raTDXrhkzFaCd+/PzuwGKHSbHO9EH0tOxyZerfrpXC/MWiRrPne
 BnJ7vopQYTzA9lgH69FW+l3oeIia1Tstz2YDb+oPZn5tPfhPS1ATE5Chfn/yA7Ex+pVGcrC3vvo
 ws1o6lt2qFpEWOHjtd7wD+2a1H0wGhsPK8H78lYJEyRNwHzmnTzqvC4ER1KgQdeklJi3obqxgUn
 dce06Yhx9776hd4faMg==
X-Proofpoint-GUID: aE2GTTynZFXLVhp8F4QuexyKoDYpr0iF
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-11_03,2026-05-08_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 spamscore=0 phishscore=0 lowpriorityscore=0 bulkscore=0
 priorityscore=1501 malwarescore=0 suspectscore=0 clxscore=1015 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2605110105
Received-SPF: pass client-ip=148.163.158.5;
 envelope-from=shivangu@linux.ibm.com; helo=mx0b-001b2d01.pphosted.com
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
Reviewed-by: Vishal Chourasia <vishalc@linux.ibm.com>
Signed-off-by: Shivang Upadhyay <shivangu@linux.ibm.com>
---
Changelog:

v2:
 * added braces to adhere to style guide.
 * rebase to master

v1:
 * https://lore.kernel.org/all/20260430085409.680930-1-shivangu@linux.ibm.com/
---
 hw/ppc/spapr_hcall.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/hw/ppc/spapr_hcall.c b/hw/ppc/spapr_hcall.c
index 032805a8d0..613dd893bb 100644
--- a/hw/ppc/spapr_hcall.c
+++ b/hw/ppc/spapr_hcall.c
@@ -1105,6 +1105,12 @@ static target_ulong h_signal_sys_reset(PowerPCCPU *cpu,
                     continue;
                 }
             }
+
+            /* Skip quiesced CPUs */
+            if (c->env.quiesced) {
+                continue;
+            }
+
             run_on_cpu(cs, spapr_do_system_reset_on_cpu, RUN_ON_CPU_NULL);
         }
         return H_SUCCESS;
-- 
2.53.0


