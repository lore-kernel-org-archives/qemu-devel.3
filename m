Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1084BD58E6B
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Mar 2026 06:53:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vwxA2-0008Ar-1S; Mon, 02 Mar 2026 01:53:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1vwx9Y-00083k-5d
 for qemu-devel@nongnu.org; Mon, 02 Mar 2026 01:53:21 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1vwx9S-00027f-Uj
 for qemu-devel@nongnu.org; Mon, 02 Mar 2026 01:53:13 -0500
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6220sgxC2333658
 for <qemu-devel@nongnu.org>; Mon, 2 Mar 2026 06:53:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=RFC1BhE5QYgRVLNqV
 I3VflVhJa365rzjWQSSOiaSvgQ=; b=m9/pWt84YQiManjGs7SkSyZw49U1CG30z
 UekkFGBIrdN+PWH7YkEVFho2Hp2CXa8Na24+qRRAyakVfGYuJ7nIGNyHWh367RAV
 MB1+L8Yf46DLuJJ7Uo3BdXaGFxeYUFelEyJxT9MRMUlYdEsdGV8y2AdUTpBN6vmj
 q95y8bda4KA0B26DcM6uaql/tWFhP7ivZmUWRFI0tXMwUK6GzMQwoomqWFrcEHpA
 8pSnILcxLx2UzqFlZSTkMmv3IKIz5somVyXK6Hn5ebIRVecjZ5Km6jKHObAajt6c
 /k4Xj7Y8F54I3XU14Y1CdtGTMjh8f1DQL/5T7aytcraGuyG/685dQ==
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4cksjd59ky-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 02 Mar 2026 06:53:08 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 6225e9I8010335
 for <qemu-devel@nongnu.org>; Mon, 2 Mar 2026 06:53:07 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4cmc6jvkgx-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 02 Mar 2026 06:53:07 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com
 [10.20.54.102])
 by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 6226r33F61866362
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 2 Mar 2026 06:53:03 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 5568220079;
 Mon,  2 Mar 2026 06:53:03 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 031E620077;
 Mon,  2 Mar 2026 06:53:02 +0000 (GMT)
Received: from Mac.com (unknown [9.124.211.120])
 by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Mon,  2 Mar 2026 06:53:01 +0000 (GMT)
From: Harsh Prateek Bora <harshpb@linux.ibm.com>
To: qemu-devel@nongnu.org
Cc: Caleb Schlossin <calebs@linux.ibm.com>,
 Chalapathi V <chalapathi.v@linux.ibm.com>,
 Glenn Miles <milesg@linux.ibm.com>, Aditya Gupta <adityag@linux.ibm.com>
Subject: [PULL 2/4] ppc/pnv: Support for SECURITY_SWITCH XSCOM register access
Date: Mon,  2 Mar 2026 12:22:15 +0530
Message-ID: <20260302065230.56220-3-harshpb@linux.ibm.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260302065230.56220-1-harshpb@linux.ibm.com>
References: <20260302065230.56220-1-harshpb@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=M9BA6iws c=1 sm=1 tr=0 ts=69a533d4 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=Yq5XynenixoA:10 a=f7IdgyKtn90A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=rhZDsxdhWw0Yntd0-ucA:9
X-Proofpoint-ORIG-GUID: O4XpLFjRUwOXxVUc2vi9o1_tUvJuGuKS
X-Proofpoint-GUID: O4XpLFjRUwOXxVUc2vi9o1_tUvJuGuKS
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzAyMDA1NiBTYWx0ZWRfX9nbkqyjbdiOq
 ICjfJG+2MtUEMiBORu/T6NvXg03OMonr5npL6ac4HRMPdGnUeNwbrTuS71C40GK0JAfXgkXTqAn
 Yp150R5b+qSyduoIzeat9vp7McL7kVofjPHYhDT1Yb+NE04ADXFw0TkdOVdvyCZWq9leT421kBk
 ki4t+uejiYDB01lG5chkTsVXkS+TEbKodIP9aEgkOApKF4U+XDRae/Hoew2n7jQovc7V5dFNC7S
 H3bvKd+r2fUyMgPUMWqAj4aj2m7nCxSzB3HG1VrDANZqgPE33IfA1Pf2vD4+UIDq86BToOAiAqO
 tGixSQYD53Bg0HOHU/1lFqIoI0+bIfT7E4UBBAO+zXHr9esKSdUinHK+nhFCv9CRgr+idhQagVr
 FixYMHkxFbayHeI+C5+gXSnfNXIl0SxhlKLDz0H0nLJGoWEdrAJXGdwWfujWsK1tzILRRX/qI2C
 G5GlrJ35zxq+u+BXFJA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-02_02,2026-02-27_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 spamscore=0 adultscore=0 malwarescore=0
 bulkscore=0 lowpriorityscore=0 impostorscore=0 phishscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2603020056
Received-SPF: pass client-ip=148.163.156.1; envelope-from=harshpb@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -14
X-Spam_score: -1.5
X-Spam_bar: -
X-Spam_report: (-1.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.012, RCVD_IN_VALIDITY_RPBL_BLOCKED=1.188,
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

From: Caleb Schlossin <calebs@linux.ibm.com>

Power Hypervisor code requires access to the SECURITY_SWITCH
XSCOM register at MMIO address 0x80028 (scom address 0x10005).
Adding basic read support for now so that is doesn't cause
error messages to be posted.

Reviewed-by: Chalapathi V <chalapathi.v@linux.ibm.com>
Reviewed-by: Glenn Miles <milesg@linux.ibm.com>
Reviewed-by: Aditya Gupta <adityag@linux.ibm.com>
Signed-off-by: Glenn Miles <milesg@linux.ibm.com>
Signed-off-by: Caleb Schlossin <calebs@linux.ibm.com>
Link: https://lore.kernel.org/qemu-devel/20260210134647.2050821-2-calebs@linux.ibm.com
Signed-off-by: Harsh Prateek Bora <harshpb@linux.ibm.com>
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
2.52.0


