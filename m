Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D2B7CCD1BC
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Oct 2025 11:46:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vBtkk-0001cX-Oj; Thu, 23 Oct 2025 07:45:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1vBtkT-0001Jr-Hv
 for qemu-devel@nongnu.org; Thu, 23 Oct 2025 07:44:53 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1vBtkR-0001bP-2f
 for qemu-devel@nongnu.org; Thu, 23 Oct 2025 07:44:53 -0400
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59N71hbn027075;
 Thu, 23 Oct 2025 11:44:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=H+48uAYpotk2iY/Lw
 YGGOzuF9C4Vf0vGq+/I+DRjh38=; b=DXRUUnHH0npoVf8csRYvyp3R2CXeR63Gp
 3RTAhZJxaEWEJKJhwtIeshrI0DIXZZhMtGXDnmA50bP9SMwCnGs3Dn32pI826MbQ
 B94lNG9fe1AFqOqv0+nIWhLhqrCiyUgSIA0o2zfuw6VsMsDmlCJjp8X+1Y+ZM5PC
 eHjQP7bkN+RfcDVdmfeEy8n2C8a2d1muxIXQ3RKpEjwo64omELbY1ORWE2eVA0gS
 5wJDCRJna8jvwM/Lm6NzVoTAKldmlDFpWljNfCPDesDF2G2QiY3ez9HC2/RPcgRC
 0AHA3PaVx91K2s4G6IeOuqrl3sZwRM/rCK2VtTe0qgAQTj/RWgzAw==
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 49v31s9wa5-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 23 Oct 2025 11:44:46 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 59N8Inmq014658;
 Thu, 23 Oct 2025 11:44:46 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 49vn7sdpn9-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 23 Oct 2025 11:44:45 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com
 [10.20.54.105])
 by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 59NBiiMp51839446
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 23 Oct 2025 11:44:44 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 5825820049;
 Thu, 23 Oct 2025 11:44:44 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 959D520040;
 Thu, 23 Oct 2025 11:44:43 +0000 (GMT)
Received: from li-1901474c-32f3-11b2-a85c-fc5ff2c001f3.ibm.com.com (unknown
 [9.124.221.73]) by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Thu, 23 Oct 2025 11:44:43 +0000 (GMT)
From: Harsh Prateek Bora <harshpb@linux.ibm.com>
To: qemu-devel@nongnu.org
Cc: BALATON Zoltan <balaton@eik.bme.hu>
Subject: [PULL 12/32] ppc/amigaone: Free allocated struct
Date: Thu, 23 Oct 2025 17:13:59 +0530
Message-ID: <20251023114422.3675018-13-harshpb@linux.ibm.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20251023114422.3675018-1-harshpb@linux.ibm.com>
References: <20251023114422.3675018-1-harshpb@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 8oIS3WVz-f063-DFaV6g-QU1_m808P1E
X-Proofpoint-GUID: 8oIS3WVz-f063-DFaV6g-QU1_m808P1E
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDE4MDAyMiBTYWx0ZWRfXxDLz/BkzAMxI
 VvjUMLqT5z48r7dpUBoL6/6SSeCj44iPwHhC6OImBYgJTekIZgom7xIQM/GA0KjFPOBgnBeLGOg
 lgZoUHxVHVSfluBSG+s6RcTWSRirHw86ABLYPWmSlBvd/yxNYINCF7tl7esGDNOkWijvo04MdQA
 YI5PH16RGGns600Ob6PUB4WhR/QG94x4z7gwi/M3hZCPV20NKZjeGNJBC4Aln9LIgu5kP0955He
 yD5qaO6l98AIjmclwbQk1dI5EgleeX1ONXJtrXjdTkeHwBW/A30F+4XtQXHuRZizrZtdk3ZnU4H
 28Efko4B6/IFPEAoxK4W4AzWr6nGy7rwUevG5kR6uRbp959NTXuvXAll50jvBvunnUCdrhyB7s7
 3VcesrWdzbQwuNQfKJ1UD7NfTWYt4g==
X-Authority-Analysis: v=2.4 cv=IJYPywvG c=1 sm=1 tr=0 ts=68fa152e cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=x6icFKpwvdMA:10 a=f7IdgyKtn90A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8 a=F02M0vMrOoqODbYQAHQA:9
 a=oH34dK2VZjykjzsv8OSz:22 a=pHzHmUro8NiASowvMSCR:22 a=n87TN5wuljxrRezIQYnT:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-22_08,2025-10-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 lowpriorityscore=0 clxscore=1015 suspectscore=0 spamscore=0
 bulkscore=0 adultscore=0 impostorscore=0 malwarescore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510180022
Received-SPF: pass client-ip=148.163.156.1; envelope-from=harshpb@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
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

From: BALATON Zoltan <balaton@eik.bme.hu>

In create_bd_info function a bd_info struct is allocated but never
freed. Mark it g_autofree to avoid leaking it.

Fixes: 34f053d86b (ppc/amigaone: Add kernel and initrd support)
Resolves: Coverity CID 1641398
Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
Reviewed-by: Harsh Prateek Bora <harshpb@linux.ibm.com>
Link: https://lore.kernel.org/qemu-devel/20251022211649.9A09E5972E5@zero.eik.bme.hu
Signed-off-by: Harsh Prateek Bora <harshpb@linux.ibm.com>
---
 hw/ppc/amigaone.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/ppc/amigaone.c b/hw/ppc/amigaone.c
index 12279f42bc..47fb016b4a 100644
--- a/hw/ppc/amigaone.c
+++ b/hw/ppc/amigaone.c
@@ -221,7 +221,7 @@ struct bd_info {
 
 static void create_bd_info(hwaddr addr, ram_addr_t ram_size)
 {
-    struct bd_info *bd = g_new0(struct bd_info, 1);
+    g_autofree struct bd_info *bd = g_new0(struct bd_info, 1);
 
     bd->bi_memsize =    cpu_to_be32(ram_size);
     bd->bi_flashstart = cpu_to_be32(PROM_ADDR);
-- 
2.43.5


