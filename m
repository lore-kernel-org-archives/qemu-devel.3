Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E21A7D13C16
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Jan 2026 13:56:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vkN49-0002ST-1z; Mon, 26 Jan 2026 08:55:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <calebs@linux.ibm.com>)
 id 1vkN3t-0002IS-5d; Mon, 26 Jan 2026 08:55:27 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <calebs@linux.ibm.com>)
 id 1vkN3q-0004uE-M8; Mon, 26 Jan 2026 08:55:24 -0500
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 60PFFtht021821;
 Mon, 26 Jan 2026 13:55:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=tonqQxpDYymXiBUyk
 0RFFwd1nyWBs1fbOrHzGLAxTyQ=; b=YNhhBusKI4ME6/11jKQp2tQH8AFr7o1Tr
 VZOoc55woNmumkbADiqdMsuLtDcIPQrRjJ5BCzyWQM7gdOlnIsU8CBkZfgd+AOX4
 WE5Q2PZam2q9dcg0DVxIl9nZbl7LWVfdTMlO0YXkji+OMyvdBB3Y7yLjrg5A7VBG
 tGRyAvPcV+Fldghfjcfy/k0MZBwqOjyMMWNWFLLT1HrxP0amVnOTZ/h1bM832pDN
 2L/Wt27f8apojyngLAEYHQCmsgw3+iJXj0uQ54tAPz5WSdvRihHdtkQ+fvUzKCfF
 gmtVXze/mJp13ovCN4abhW3ofIftKb6YCv2MeFaOUV4Gd8hcjrM1g==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4bvnrt87hc-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 26 Jan 2026 13:55:19 +0000 (GMT)
Received: from m0353729.ppops.net (m0353729.ppops.net [127.0.0.1])
 by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 60QDtJkc019601;
 Mon, 26 Jan 2026 13:55:19 GMT
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4bvnrt87h9-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 26 Jan 2026 13:55:19 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 60QB5MC2019653;
 Mon, 26 Jan 2026 13:55:18 GMT
Received: from smtprelay04.wdc07v.mail.ibm.com ([172.16.1.71])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4bw9dmvs95-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 26 Jan 2026 13:55:18 +0000
Received: from smtpav06.dal12v.mail.ibm.com (smtpav06.dal12v.mail.ibm.com
 [10.241.53.105])
 by smtprelay04.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 60QDtG2C62849348
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 26 Jan 2026 13:55:16 GMT
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 8EC3858043;
 Mon, 26 Jan 2026 13:55:16 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 1DF7C58055;
 Mon, 26 Jan 2026 13:55:16 +0000 (GMT)
Received: from gfwr532.rchland.ibm.com (unknown [9.10.239.133])
 by smtpav06.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Mon, 26 Jan 2026 13:55:16 +0000 (GMT)
From: Caleb Schlossin <calebs@linux.ibm.com>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, npiggin@gmail.com, adityag@linux.ibm.com,
 milesg@linux.ibm.com, chalapathi.v@linux.ibm.com,
 harshpb@linux.ibm.com, calebs@linux.ibm.com
Subject: [PATCH v2 1/3] ppc/pnv: Support for SECURITY_SWITCH XSCOM register
 access
Date: Mon, 26 Jan 2026 07:55:05 -0600
Message-ID: <20260126135507.771552-2-calebs@linux.ibm.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260126135507.771552-1-calebs@linux.ibm.com>
References: <20260126135507.771552-1-calebs@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 7rI2w7wc0AledHXZTDGyjGlmXi_gnZY4
X-Authority-Analysis: v=2.4 cv=Uptu9uwB c=1 sm=1 tr=0 ts=69777247 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=vUbySO9Y5rIA:10 a=VkNPw1HP01LnGYTKEx00:22 a=VnNF1IyMAAAA:8
 a=rhZDsxdhWw0Yntd0-ucA:9
X-Proofpoint-ORIG-GUID: UYN78KtHMrqYy4Z0N-fTMZJoEXsFMgad
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTI2MDExNyBTYWx0ZWRfX+US4qQ9U9Vjf
 QqTxhBRjY5w9WskP96QjV6BxSeaSrOBci3U58rclOTM1e+sovEgf0z8KWM1xHs5NjIR1VO6XIG8
 O9uOPkg8B7kCpGFXlh9dFL6aMOW3KfOvW7pbr3YzY/xHxrZL3yTerB2hQdcgLBTV6wcjesw6Ys+
 53A3rbMCWFlqat9VaQUsjZ5gcKI+4Ea2b2NsLQ7amj9kfoACtTu75e97dh0hDzsb8Tg09PvJ5iE
 eFJYJjPmoaRawMrhXDRwQNyizMRCigRFXObbca/mUNdFE5U6Yu297M+ItCxDPYJllpL2I55lqj6
 MuFuOqwT+Q5sA/5ANZ2S/4hbzcFL6wiMTq1g7Y6bF5GXNlxpBADLr31zQkh6TQzwkBxrXzWiwbk
 mlymIZMgLEm4O8GvwxI2dIQh4sYsxmns3rLluT2QKov6TG5w3gj1QKU00kbBK04xuYfFHBCbCfe
 kXZWKtI3THQ5MF1yuSQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.20,FMLib:17.12.100.49
 definitions=2026-01-26_03,2026-01-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 priorityscore=1501 clxscore=1015 lowpriorityscore=0
 phishscore=0 adultscore=0 impostorscore=0 bulkscore=0 spamscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2601150000
 definitions=main-2601260117
Received-SPF: pass client-ip=148.163.156.1; envelope-from=calebs@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
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


