Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48455EA8115
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Feb 2026 13:47:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vpo54-0007T3-41; Tue, 10 Feb 2026 08:47:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <calebs@linux.ibm.com>)
 id 1vpo4w-0007RQ-Vp; Tue, 10 Feb 2026 08:47:00 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <calebs@linux.ibm.com>)
 id 1vpo4v-00052K-59; Tue, 10 Feb 2026 08:46:58 -0500
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 61A8sVcX130324; Tue, 10 Feb 2026 13:46:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=tonqQxpDYymXiBUyk
 0RFFwd1nyWBs1fbOrHzGLAxTyQ=; b=XtYT1a27YL47bbLb5C8vbmfe0NtjbAIDe
 0ku/QQketosQwZ560C/Dno2OOhLsXorJD83o+JY2yIKqcNFkNVYJVQNJa3L1J0Be
 6Qmmceph1W0cSK5DxzwW4TaJ+cA26bWM5ivexZh0115GsRt+kU5xksqC3aqaNrpG
 8la6qb0MBL8/upeVINt2qXcYUOtJTurilylZyJZq3PLYwhYqRX8YdQVMq5bPrXdl
 hYUEKiOdhVoNBlSd8FD6cSuXtDDVykCanl/ZK8bUrOdHNVCtK8N3nMwyeGrDgmJI
 yWUdjyByadNBSbdIYe4NEpIVEB2I+aNCsJLvPSoF2KhWWS6qPxIFA==
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4c696utbfn-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 10 Feb 2026 13:46:55 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 61AAeELR019277;
 Tue, 10 Feb 2026 13:46:54 GMT
Received: from smtprelay06.dal12v.mail.ibm.com ([172.16.1.8])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4c6hxk1a92-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 10 Feb 2026 13:46:54 +0000
Received: from smtpav04.wdc07v.mail.ibm.com (smtpav04.wdc07v.mail.ibm.com
 [10.39.53.231])
 by smtprelay06.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 61ADkrCC21234324
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 10 Feb 2026 13:46:53 GMT
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 6E0055805E;
 Tue, 10 Feb 2026 13:46:53 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id AFA8E58045;
 Tue, 10 Feb 2026 13:46:52 +0000 (GMT)
Received: from gfwr532.rchland.ibm.com (unknown [9.10.239.133])
 by smtpav04.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Tue, 10 Feb 2026 13:46:52 +0000 (GMT)
From: Caleb Schlossin <calebs@linux.ibm.com>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, npiggin@gmail.com, adityag@linux.ibm.com,
 milesg@linux.ibm.com, chalapathi.v@linux.ibm.com,
 harshpb@linux.ibm.com, calebs@linux.ibm.com
Subject: [PATCH v2 1/3] ppc/pnv: Support for SECURITY_SWITCH XSCOM register
 access
Date: Tue, 10 Feb 2026 07:46:45 -0600
Message-ID: <20260210134647.2050821-2-calebs@linux.ibm.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260210134647.2050821-1-calebs@linux.ibm.com>
References: <20260210134647.2050821-1-calebs@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjEwMDExNiBTYWx0ZWRfX7wbsLaSdOnxx
 YC5uJ2rmz+bImplO7PFj0uG6+JryJj+tVSSuKi5BJ1k7N6a1tHYGygDaMAZ26/YWzgU2k1Dka5h
 KDLkSzmLvS8/SABuuA3NUBcVObtCDqFdFkK+G7vKu7OIohLFEIi2IaXhY1OoqIJ+++WBwtNlW8n
 Wwv3eD/oGk1/g5dZXYlt9Fa6a6cEoZHq0IG5yCF7FKpaTIBrGiRKEIRZAIVCZ5k18QwlrarlXg2
 UGnJGRBnhUP3LMC2dVacKYnOmcueQxv2zOgTKBtL0bQVeUpewCLwshDMGe3iPW7RWxQR8fKVpaF
 BsZJpiqt7FEPshZ+gCZm0nexMJ0w00Qr5Ng7cWrHYLvyy9g/v8RI3CGol0Sw6MWx2C+GbiZmUSn
 9MNGz2m/ruICwK4eANLvScWsYoDOXMV2ZXFU4AZKdZ+/sF67WiYrB1copBzaFv781RIQBxqj6oo
 EpVRxzx7vma/gYBKFjw==
X-Proofpoint-ORIG-GUID: V9vowU9I9BHDtQikhvkrIXerbbBGdcF_
X-Proofpoint-GUID: C_xsFp1Wr18dDadrAuth9nyB2bIIGZGf
X-Authority-Analysis: v=2.4 cv=O+Y0fR9W c=1 sm=1 tr=0 ts=698b36cf cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22 a=Mpw57Om8IfrbqaoTuvik:22
 a=GgsMoib0sEa3-_RKJdDe:22 a=VnNF1IyMAAAA:8 a=rhZDsxdhWw0Yntd0-ucA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-10_01,2026-02-10_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 priorityscore=1501 phishscore=0 adultscore=0
 malwarescore=0 impostorscore=0 bulkscore=0 clxscore=1015 spamscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2602100116
Received-SPF: pass client-ip=148.163.158.5; envelope-from=calebs@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Power Hypervisor code requires access to the SECURITY_SWITCH
XSCOM register at MMIO address 0x80028 (scom address 0x10005).
Adding basic read support for now so that is doesn't cause
error messages to be posted.

Reviewed-by: Chalapathi V <chalapathi.v@linux.ibm.com>
Reviewed-by: Glenn Miles <milesg@linux.ibm.com>
Reviewed-by: Aditya Gupta <adityag@linux.ibm.com>
Signed-off-by: Glenn Miles <milesg@linux.ibm.com>
Signed-off-by: Caleb Schlossin <calebs@linux.ibm.com>
---
 hw/ppc/pnv_xscom.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/hw/ppc/pnv_xscom.c b/hw/ppc/pnv_xscom.c
index 8557b560ae..dc1ffc6c01 100644
--- a/hw/ppc/pnv_xscom.c
+++ b/hw/ppc/pnv_xscom.c
@@ -61,6 +61,8 @@ static uint32_t pnv_xscom_pcba(PnvChip *chip, uint64_t addr)
 static uint64_t xscom_read_default(PnvChip *chip, uint32_t pcba)
 {
     switch (pcba) {
+    case 0x10005:       /* SECURITY SWITCH */
+        return 0;
     case 0xf000f:
         return PNV_CHIP_GET_CLASS(chip)->chip_cfam_id;
     case 0x18002:       /* ECID2 */
-- 
2.47.3


