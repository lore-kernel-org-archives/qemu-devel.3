Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F207FD375E
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Feb 2026 12:48:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vvEI4-0007FD-SY; Wed, 25 Feb 2026 07:46:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <adityag@linux.ibm.com>)
 id 1vvEHy-0007EY-5j; Wed, 25 Feb 2026 07:46:50 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <adityag@linux.ibm.com>)
 id 1vvEHv-0002EA-ON; Wed, 25 Feb 2026 07:46:49 -0500
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 61PARMpW2221454; Wed, 25 Feb 2026 12:46:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=BKxcgizA4DIj9X+uz
 wnck18v9OQtI1/RI+V75J4O23w=; b=k1ZqUcXLX/r0NjEKeFu2KJVcG6CTOYYpW
 NCtp0XGfzKb8vX8oOZHo6rsGrkTXuDAr4i+wgIxjH4u3JFVS42JOGiJdPdsWFvf8
 f/8zHOKmQ48t7r7VdjQDCLxDBH8FsDoiAtJENoC+BqJ8uKE9LjApdH1j9v+/djHN
 ft7rkIi5jQLNRn3Vup11TMYyFzdKkbwKp5nG1OjUlQCTIHSiV6s0spjtowGfiWQp
 hJ4uGVxDx+19N/HD2gFggT/pSl+y+xmrJYxc9l5Ol2Nmql8l1ysJf5EQaKhK5MQJ
 nQC71PxGRSJajS9226DG5bFCDdzlqKYQDfL3BgdVUzvV4mBJWh/hg==
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4cf34c7gp7-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 25 Feb 2026 12:46:45 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 61PCMQxa013438;
 Wed, 25 Feb 2026 12:46:45 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4cfqdy5d4k-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 25 Feb 2026 12:46:45 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com
 [10.20.54.103])
 by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 61PCkfPk55706106
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 25 Feb 2026 12:46:41 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 30CC020043;
 Wed, 25 Feb 2026 12:46:41 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id EE20B20040;
 Wed, 25 Feb 2026 12:46:38 +0000 (GMT)
Received: from li-3c92a0cc-27cf-11b2-a85c-b804d9ca68fa.ibm.com (unknown
 [9.124.222.235])
 by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Wed, 25 Feb 2026 12:46:38 +0000 (GMT)
From: Aditya Gupta <adityag@linux.ibm.com>
To: <qemu-devel@nongnu.org>
Cc: <qemu-ppc@nongnu.org>, Hari Bathini <hbathini@linux.ibm.com>,
 Sourabh Jain <sourabhjain@linux.ibm.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Nicholas Piggin <npiggin@gmail.com>,
 Miles Glenn <milesg@linux.ibm.com>, Chinmay Rath <rathc@linux.ibm.com>,
 Shivang Upadhyay <shivangu@linux.ibm.com>
Subject: [PATCH v3 01/10] ppc/pnv: Move SBE host doorbell function to top of
 file
Date: Wed, 25 Feb 2026 18:16:23 +0530
Message-ID: <20260225124633.1841222-2-adityag@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260225124633.1841222-1-adityag@linux.ibm.com>
References: <20260225124633.1841222-1-adityag@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjI1MDEyMyBTYWx0ZWRfXxwPV7jZ7didH
 WzHjWALdk1ntPUUVGMnULvR6cZppnqHxEMSf+zj8Vbjr14HbIfQMvm2TVCLYuqWEMcceY+0a9VD
 O4oNn+vlwpDEaDIP0feWOXkj+QoZKKPcRhv61BJQbJWGUIDXUQBjMvJ9Y/vVALtBdu4ZQC3TiLs
 C3B1HxYzCfFoVM0eg18g92zNEV4saVjDGsac18j2Nt7r8bzusZIVbx6qFJ74fOP8Qr2ldrhE9+9
 Npc/zVQVPM8fP2lIME1eCR09HrER6O/TIbynUsp+2dRa3Qkah9K6LJUjxQtlgqvYxzKA13PcKIe
 VBt0fTGxnngF02uRflJmbtQ3hFoRjgR2ImGN+VwfmXp9xJl8FGu+leXiNkoXALlLPzrppqqmaSE
 LHkDbaWEHRdGufKtqNPohF0S8BsXvW5yH3fGw490Iki55vF98AMb5UJXcFIgUq8vOWfxa7MmKKP
 AFAHJ8flTQbNcp7Hv1Q==
X-Proofpoint-ORIG-GUID: IBQFhDLVafLp-bpjtVuh8QWWCjjgM3gy
X-Authority-Analysis: v=2.4 cv=F9lat6hN c=1 sm=1 tr=0 ts=699eef36 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22 a=Mpw57Om8IfrbqaoTuvik:22
 a=GgsMoib0sEa3-_RKJdDe:22 a=VnNF1IyMAAAA:8 a=Cz7AoQ69vTHEakZR_RYA:9
X-Proofpoint-GUID: AgquUIh7ZlyYPUww4-t3SmPB9P28O79p
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-24_03,2026-02-25_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 phishscore=0 bulkscore=0 adultscore=0 spamscore=0
 clxscore=1015 suspectscore=0 malwarescore=0 lowpriorityscore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2602250123
Received-SPF: pass client-ip=148.163.158.5; envelope-from=adityag@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -11
X-Spam_score: -1.2
X-Spam_bar: -
X-Spam_report: (-1.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.734, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.78,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Moved 'pnv_sbe_set_host_doorbell' as-it-is to above
'pnv_sbe_power9_xscom_ctrl_write'.

This is done since in a future patch, S0 interrupt implementation uses
'pnv_sbe_set_host_doorbell', hence the host doorbell function needs to
be declared/defined before 'pnv_sbe_power9_xscom_ctrl_write' where we
implement the S0 interrupt.

No functional change.

Signed-off-by: Aditya Gupta <adityag@linux.ibm.com>
---
 hw/ppc/pnv_sbe.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/hw/ppc/pnv_sbe.c b/hw/ppc/pnv_sbe.c
index 27383ce6837e..247617338a0d 100644
--- a/hw/ppc/pnv_sbe.c
+++ b/hw/ppc/pnv_sbe.c
@@ -80,6 +80,15 @@
 #define SBE_CONTROL_REG_S0              PPC_BIT(14)
 #define SBE_CONTROL_REG_S1              PPC_BIT(15)
 
+static void pnv_sbe_set_host_doorbell(PnvSBE *sbe, uint64_t val)
+{
+    val &= SBE_HOST_RESPONSE_MASK; /* Is this right? What does HW do? */
+    sbe->host_doorbell = val;
+
+    trace_pnv_sbe_reg_set_host_doorbell(val);
+    qemu_set_irq(sbe->psi_irq, !!val);
+}
+
 struct sbe_msg {
     uint64_t reg[4];
 };
@@ -125,15 +134,6 @@ static const MemoryRegionOps pnv_sbe_power9_xscom_ctrl_ops = {
     .endianness = DEVICE_BIG_ENDIAN,
 };
 
-static void pnv_sbe_set_host_doorbell(PnvSBE *sbe, uint64_t val)
-{
-    val &= SBE_HOST_RESPONSE_MASK; /* Is this right? What does HW do? */
-    sbe->host_doorbell = val;
-
-    trace_pnv_sbe_reg_set_host_doorbell(val);
-    qemu_set_irq(sbe->psi_irq, !!val);
-}
-
 /* SBE Target Type */
 #define SBE_TARGET_TYPE_PROC            0x00
 #define SBE_TARGET_TYPE_EX              0x01
-- 
2.53.0


