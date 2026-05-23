Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C931ECD5BAC
	for <qemu-devel@archiver.kernel.org>; Sat, 23 May 2026 16:28:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wQpCV-0007Xu-UO; Sat, 23 May 2026 12:27:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1wQpCU-0007Xk-1q
 for qemu-devel@nongnu.org; Sat, 23 May 2026 12:27:46 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1wQpCS-0001QF-1l
 for qemu-devel@nongnu.org; Sat, 23 May 2026 12:27:45 -0400
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64N8tsGp2390345
 for <qemu-devel@nongnu.org>; Sat, 23 May 2026 16:27:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=Oe9V5XlabHVqpt2HN
 W0H86Vow2iwQ/pa+acMxzFJuQ8=; b=P8NKxtZgn4I7oRVHj0APgwSgqhjjXPQsQ
 d7fRL/2JopSJfCDwjj1K5bDAOEKTYk3kFKwlUlSkhMWKPN9DZW1GaUYEdH7pfeIQ
 AXwhKTd43SMLKx/Awp8MjNRRWt5r+fVW+TrRiFw49bwRlGU9NtN0eKqKEj1VvvbB
 KagyNN0Kt0P/qBbJx8Ke3OuQrpnz74tdB6I7DBUj/Kjmu7Ja6znbO+fwF3maBDWV
 8bEmCtXJzoDoLb4hBgK8aRdfAf403JF0SqB2vHMzUS4MJPk8q/OhrNEJk/gMrYq3
 txKnpVPZd5FonOO7zIgtCVLu25OmejnDa5J5XwhxvMRMf8/x3vugQ==
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4eb4nu9hax-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Sat, 23 May 2026 16:27:42 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 64NGO4nH003879
 for <qemu-devel@nongnu.org>; Sat, 23 May 2026 16:27:41 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4eb4781rge-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Sat, 23 May 2026 16:27:41 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com
 [10.20.54.102])
 by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 64NGRadr36045262
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Sat, 23 May 2026 16:27:36 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 9E7E420040;
 Sat, 23 May 2026 16:27:36 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 45D6520043;
 Sat, 23 May 2026 16:27:34 +0000 (GMT)
Received: from Mac.com (unknown [9.124.217.135])
 by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Sat, 23 May 2026 16:27:34 +0000 (GMT)
From: Harsh Prateek Bora <harshpb@linux.ibm.com>
To: qemu-devel@nongnu.org
Cc: Shivang Upadhyay <shivangu@linux.ibm.com>,
 Sourabh Jain <sourabhjain@linux.ibm.com>,
 Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
 Anushree Mathur <anushree.mathur@linux.vnet.ibm.com>,
 Vishal Chourasia <vishalc@linux.ibm.com>
Subject: [PULL 1/5] ppc/spapr: Skip system reset for quiesced CPUs
Date: Sat, 23 May 2026 21:57:20 +0530
Message-ID: <20260523162724.95229-2-harshpb@linux.ibm.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260523162724.95229-1-harshpb@linux.ibm.com>
References: <20260523162724.95229-1-harshpb@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTIzMDE2NSBTYWx0ZWRfX54VEh9UX06+I
 Q+RivEkjWKGPOeHFJv/XTvIoaNZkxSOqoPspvSh2u/DnY6SKri/8DX2YkyGxrll6WSy5abOXX7Y
 ybHOgoWIH7bZU93OtMiPhkYYS5kRHSYsVkQHappr6y3M+FKf9UF8BY0dkJc+Enkv2f4VUyFjnTz
 1W0wN6lCxiCUI59wXykuW9YYm13rw6/y37c3oUbEcF0tFv4mW7sK3DZ1eZMFKzcNppyU/hYzAE3
 9PNMEMvnQM5B4vXU29F/1icF6u65oSDi3yTK/3RNLRVaIZMBOGmG5CZaMAA7lgtvVRRao8nyDtR
 YT1UoR/a3xLSFvbo+YLejWh2wyAkpYc+TOb22eBD3VSi09dSwBXznoD1SxHH1nSx8g40GADYUm8
 7h5acP6+zBLH071ucR+v4AAmO3Dzp9eo3Y6J1vbzhHEQc652LMwV+crmHA97v13rCMT2Z5eqVbg
 Tmzw2lKZ0OyAIyT8xzg==
X-Authority-Analysis: v=2.4 cv=UtJT8ewB c=1 sm=1 tr=0 ts=6a11d57e cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=NGcC8JguVDcA:10 a=f7IdgyKtn90A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=-KZa5ixkeG9fcCw7aOYA:9
X-Proofpoint-ORIG-GUID: iPcllYV6MawHWyiiYep01B5so4qWTfIH
X-Proofpoint-GUID: iPcllYV6MawHWyiiYep01B5so4qWTfIH
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-23_05,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 suspectscore=0 adultscore=0 clxscore=1015 bulkscore=0
 phishscore=0 impostorscore=0 malwarescore=0 lowpriorityscore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2605130000
 definitions=main-2605230165
Received-SPF: pass client-ip=148.163.156.1; envelope-from=harshpb@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
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

From: Shivang Upadhyay <shivangu@linux.ibm.com>

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
Link: https://lore.kernel.org/qemu-devel/20260511095055.82495-1-shivangu@linux.ibm.com
[harshpb: expanded comment to elobarate more on the rationale]
Signed-off-by: Harsh Prateek Bora <harshpb@linux.ibm.com>
---
 hw/ppc/spapr_hcall.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/hw/ppc/spapr_hcall.c b/hw/ppc/spapr_hcall.c
index 032805a8d0..60ba215e86 100644
--- a/hw/ppc/spapr_hcall.c
+++ b/hw/ppc/spapr_hcall.c
@@ -1105,6 +1105,15 @@ static target_ulong h_signal_sys_reset(PowerPCCPU *cpu,
                     continue;
                 }
             }
+
+            /* Skip quiesced CPUs - they are in RTAS stopped state and
+             * should not be reset. This prevents kdump hangs when CPUs
+             * are hotplugged but not yet started by the guest.
+             */
+            if (c->env.quiesced) {
+                continue;
+            }
+
             run_on_cpu(cs, spapr_do_system_reset_on_cpu, RUN_ON_CPU_NULL);
         }
         return H_SUCCESS;
-- 
2.52.0


