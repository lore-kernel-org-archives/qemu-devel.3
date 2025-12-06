Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46A14D374BD
	for <qemu-devel@archiver.kernel.org>; Sat,  6 Dec 2025 05:59:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vRlJO-00045L-Qr; Sat, 06 Dec 2025 00:58:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <adityag@linux.ibm.com>)
 id 1vRlJK-00043c-PP; Sat, 06 Dec 2025 00:58:26 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <adityag@linux.ibm.com>)
 id 1vRlJJ-0005Ww-5U; Sat, 06 Dec 2025 00:58:26 -0500
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5B62uLKN010164;
 Sat, 6 Dec 2025 05:58:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=WXAbInoT68uGejwRc
 twGK6rViOYGNcdONtCfPHF5hx8=; b=NU+Cl2wxXZHztCSm+sSkEWQHZBvzLVSyC
 PE/1VAts9F73moA7n3t0RcMYWME+X0Sz8aDtncL9DfRT8Kz3lpxkOoVwGJ8z07UQ
 fz1Vrvi42wxxTqmbcM3y5/SFOeBsZJOgPP0OvcTttndwpl9qnD+ODSJym0Y1fni2
 xsA+SrVEPxSM+sd2jkh/xjSXSlFSElL/rr7bmB4fx1qXHK5mm26CieaqY3v8mShv
 OVzlKWgC+vcH/ZhFwAqUk8JdBUKjq7uOdbA6cmPcpgOpfnRhrIKsTPjn987i+6EI
 i3e9BNc3om2wcbrg/vZCFDohsT326wDo4LS9EtJy32DZp/HPMHsAQ==
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4avc530e6r-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Sat, 06 Dec 2025 05:58:23 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5B62t0tj003867;
 Sat, 6 Dec 2025 05:58:22 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4ardck8taq-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Sat, 06 Dec 2025 05:58:22 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com
 [10.20.54.102])
 by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 5B65wJuH57082258
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Sat, 6 Dec 2025 05:58:19 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 131F520043;
 Sat,  6 Dec 2025 05:58:19 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id CD40420040;
 Sat,  6 Dec 2025 05:58:16 +0000 (GMT)
Received: from li-3c92a0cc-27cf-11b2-a85c-b804d9ca68fa.ibm.com (unknown
 [9.39.31.93]) by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Sat,  6 Dec 2025 05:58:16 +0000 (GMT)
From: Aditya Gupta <adityag@linux.ibm.com>
To: <qemu-devel@nongnu.org>
Cc: <qemu-ppc@nongnu.org>, Hari Bathini <hbathini@linux.ibm.com>,
 Sourabh Jain <sourabhjain@linux.ibm.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>
Subject: [PATCH v2 1/9] hw/ppc: Move SBE host doorbell function to top of file
Date: Sat,  6 Dec 2025 11:26:40 +0530
Message-ID: <20251206055648.1908734-2-adityag@linux.ibm.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251206055648.1908734-1-adityag@linux.ibm.com>
References: <20251206055648.1908734-1-adityag@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjA2MDAyMCBTYWx0ZWRfX1MVWpgbLN3q7
 UAqlUM9bfdjkYoZgDD3nvbO9gLEMl5LU9NhRiudlj0WrOUi/h6CGejpKHIX4r95atOMD/JiMbZX
 kStnxJ/dPSN7mzpZVfAOgotkXwYix8GKlzsD/s/eSzbku9tLHhWYf9MATjVw2HEmhCc9DRglkl/
 8Ne2yKidPJdIML3wILpZB4mHsCp0i2f56+3QWybqMYVP4iERPaDFpYDHLOVQsesu/6kuurSGjch
 dhChRDCXgM2Le2mpxqzYDkjoZ2rlUSI98hxotuLc4RUfhuRmCkAFbBXM6cwt8GNt2PmJIIGQarA
 evyK6xWWkx/b9WxnxiFs+PtCN1zl3LRs3BYECJXqFUQzh/1QcIGi+SqmBM8MqVA2V6p3B11DB+k
 XDitNNvnBfPCx4VJbcBP8mMA3WvyxA==
X-Authority-Analysis: v=2.4 cv=S/DUAYsP c=1 sm=1 tr=0 ts=6933c5ff cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=wP3pNCr1ah4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=VnNF1IyMAAAA:8
 a=Cz7AoQ69vTHEakZR_RYA:9
X-Proofpoint-ORIG-GUID: 2OkVG0BBIofgT17B29lmCdQRqO9aClX_
X-Proofpoint-GUID: 2OkVG0BBIofgT17B29lmCdQRqO9aClX_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-06_01,2025-12-04_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 phishscore=0 clxscore=1015 impostorscore=0 suspectscore=0
 lowpriorityscore=0 adultscore=0 spamscore=0 bulkscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510240000 definitions=main-2512060020
Received-SPF: pass client-ip=148.163.158.5; envelope-from=adityag@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
index 34dc013d47bb..b9b28c5deaef 100644
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
2.52.0


