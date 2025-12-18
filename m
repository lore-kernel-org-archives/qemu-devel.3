Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7CCCBD711A3
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Dec 2025 20:04:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vWKEW-0005R9-P0; Thu, 18 Dec 2025 15:04:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <calebs@linux.ibm.com>)
 id 1vWKEI-0005NO-QR; Thu, 18 Dec 2025 15:04:09 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <calebs@linux.ibm.com>)
 id 1vWKEH-00084G-6f; Thu, 18 Dec 2025 15:04:06 -0500
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5BIJm2cG009899;
 Thu, 18 Dec 2025 20:04:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=QCHr7wh/M1pwrrHRP
 PKSET60zsQsctfyDm+VTTG/IZg=; b=p64s9UybvnyydznL4NAtgYUc3aEzrj5D6
 3R4e1LM7GATzDaPrxXSkEUfnZK145TrKRrumle4Ph3l2bDXnM2I47UlAPCpznoS2
 xzlHo0YnDQDKs7EnkIfk4ze3HmEqwEcqrF95khQhCNkFHeJHSXIGn4d3k2GWP1n4
 N0qpZpqwe/ZA9w+7Fy1FauRpJTbxxJAh3OMPHcMouezK/GKrUU5FPu6yK4/kC8vg
 Ifc5VwUPP58EVnKikb1hKp+ax3YVPhVQcjE1bon4B2sHba1Vzw+sONAzTsHBTL0v
 u89Tg/W4wbhgL0pX3G5ZttMeyfkxsBjBSyWycS+YblKtoeEBL9GnA==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4b4r3b02y9-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 18 Dec 2025 20:04:03 +0000 (GMT)
Received: from m0353725.ppops.net (m0353725.ppops.net [127.0.0.1])
 by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 5BIK0bio004152;
 Thu, 18 Dec 2025 20:04:03 GMT
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4b4r3b02y5-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 18 Dec 2025 20:04:03 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5BIJXsbo006164;
 Thu, 18 Dec 2025 20:04:02 GMT
Received: from smtprelay03.wdc07v.mail.ibm.com ([172.16.1.70])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4b4qvqg4kw-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 18 Dec 2025 20:04:02 +0000
Received: from smtpav06.dal12v.mail.ibm.com (smtpav06.dal12v.mail.ibm.com
 [10.241.53.105])
 by smtprelay03.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 5BIK3jJK31654456
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 18 Dec 2025 20:03:45 GMT
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 5A32958043;
 Thu, 18 Dec 2025 20:04:01 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id E69A658055;
 Thu, 18 Dec 2025 20:04:00 +0000 (GMT)
Received: from gfwr532.rchland.ibm.com (unknown [9.10.239.133])
 by smtpav06.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Thu, 18 Dec 2025 20:04:00 +0000 (GMT)
From: Caleb Schlossin <calebs@linux.ibm.com>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, npiggin@gmail.com, adityag@linux.ibm.com,
 milesg@linux.ibm.com, chalapathi.v@linux.ibm.com, calebs@linux.ibm.com
Subject: [PATCH 2/4] ppc/pnv: Support for SECURITY_SWITCH XSCOM register access
Date: Thu, 18 Dec 2025 14:03:51 -0600
Message-ID: <20251218200353.301866-3-calebs@linux.ibm.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251218200353.301866-1-calebs@linux.ibm.com>
References: <20251218200353.301866-1-calebs@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjE4MDE2NCBTYWx0ZWRfX/EExGydf+EWK
 LKETNLIoPjvpiCwJmC7aHyAhWLngCtng9irVl+iFaUKdnsdanqnp+7/qa/oDuMRKIJZNVy7SW28
 UdecgM5XhD8UMeciJ90mlYzTrhGs9FHQhoXQVxya9XqPPAt+9bECna2lPfLRNjXf0MhiddukoAP
 wfBA4swjSYRZtiPinQsarWAprlPnpm+IyYpA+51OxUZJ8KPxPjhnpTv+QyV1E/hWAr7zS8Kjw7A
 u1ryx248sCoYHCZUZVQySWrKl9tdkroDdvpk3ajzLTfKaOvy+XsaLD3pNpk3LFu6F7MNjZwQXPV
 hHjKntzzm3gLc9pNOV79AzHBjEG+UMnk+ePL4HqSy+g4moml3q6Vj1sVU2EpKNb/aMVSkVluqUv
 wWSLqbGcFUcZrkcJrDuiMblZ7q9KDVZ8X5uolUWLmnBwMr6TqZsGFleLC2/pBumHPtdLLIVnEp+
 yjzIgk0btNoAPD2kCMQ==
X-Proofpoint-ORIG-GUID: 7-9nNQMoEOU-3Rz9jjfjPHTIhHw_5pWY
X-Proofpoint-GUID: rYoutBMcZJvB0V3wTZoYKvpmp_1rwLyF
X-Authority-Analysis: v=2.4 cv=KqJAGGWN c=1 sm=1 tr=0 ts=69445e33 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=wP3pNCr1ah4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=VnNF1IyMAAAA:8
 a=_ttvAf2Y2UeZ28-z6QkA:9 a=ZXulRonScM0A:10 a=zZCYzV9kfG8A:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-18_03,2025-12-17_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 clxscore=1015 phishscore=0 malwarescore=0 bulkscore=0
 adultscore=0 impostorscore=0 lowpriorityscore=0 suspectscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2512120000 definitions=main-2512180164
Received-SPF: pass client-ip=148.163.158.5; envelope-from=calebs@linux.ibm.com;
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

Power Hypervisor code requires access to the SECURITY_SWITCH
XSCOM register at MMIO address 0x80028 (scom address 0x10005).
Adding basic read support for now so that is doesn't cause
error messages to be posted.

Signed-off-by: Glenn Miles <milesg@linux.ibm.com>
Signed-off-by: Caleb Schlossin <calebs@linux.ibm.com>
---
 hw/ppc/pnv_xscom.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/hw/ppc/pnv_xscom.c b/hw/ppc/pnv_xscom.c
index fbfec829d5..308430def7 100644
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


