Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5BDA5CA5FF1
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2026 06:08:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xEKng-0002HM-0p; Wed, 07 Oct 2026 02:07:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rathc@linux.ibm.com>)
 id 1xEG8E-0000oQ-OL; Tue, 06 Oct 2026 21:08:10 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rathc@linux.ibm.com>)
 id 1xEG84-0002lo-44; Tue, 06 Oct 2026 21:07:36 -0400
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 696A5mp63478315; Tue, 6 Oct 2026 10:57:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=DU98F/M+S6rA6wXmn
 Ymh2pI0MiwUACHVA3jGmFRNZoI=; b=I+dJ9OMi/ahA6Aj2NqcphoM7/TYp06LgL
 Y6GqxMVpxZcRHl5Qn3QVche2KhwMtr/VsViaA7pfQjgY1ELT59fag09KuOW/Fruz
 1FY5D84CFiEW1TQtGuhE/CFCDZ8ZrUBm8U6gnUtM2EDvk72b/1QjCo1c1l2GpkJz
 9cGpjZvesNyCWeXhm5F/PHKb6CoTSFjOiyJ/NUH5IyheFOV9PAMM3wxWld5XZAB9
 lw5dA2WlVbArPJWpFv9FMVpgsDEtCoBf0Lo4fO7X0WGbEmF1/oWZtKpyrjZaHr31
 cTG6LCzqSFc1K/yyiZfdht8+a2vGIl2fFWyhyytxlZO3G9215O43A==
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4h2s74qkdv-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Tue, 06 Oct 2026 10:57:23 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id
 696A6O8x175155; Tue, 6 Oct 2026 10:57:22 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4h3dhgsg3v-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 06 Oct 2026 10:57:22 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com
 [10.20.54.102])
 by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 696AvIHt34669044
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 6 Oct 2026 10:57:18 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 02CC72004D;
 Tue,  6 Oct 2026 10:57:18 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id BA19320040;
 Tue,  6 Oct 2026 10:57:15 +0000 (GMT)
Received: from li-18a0a34c-33fc-11b2-a85c-d9f1631c5692.ibm.com (unknown
 [9.87.135.85]) by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Tue,  6 Oct 2026 10:57:15 +0000 (GMT)
From: Chinmay Rath <rathc@linux.ibm.com>
To: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, harshpb@linux.ibm.com
Cc: npiggin@gmail.com, amachhiw@linux.ibm.com, uverma@linux.ibm.com,
 milesg@linux.ibm.com, Chinmay Rath <rathc@linux.ibm.com>
Subject: [RFC PATCH 4/8] target/ppc: Add FSSIR spr for ISA 3.2
Date: Tue,  6 Oct 2026 16:26:15 +0530
Message-ID: <20261006105650.189752-5-rathc@linux.ibm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261006105650.189752-1-rathc@linux.ibm.com>
References: <20261006105650.189752-1-rathc@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-ORIG-GUID: YRLU9TLscrmsY0DBUVnOadwXiorBbyEQ
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA2MDA0MiBTYWx0ZWRfX/ZLGGw/Ku0Z1
 HTFUZ09nSL0nzxL6Crorkk7n95WCJt/Zz88eQTd++PGjPsBfu6Hymtb15xCw3D9iclbhWuLvLMY
 7v+dx/rVhPYFxONFTi9fP8bawDu9HKM=
X-Proofpoint-GUID: krCrhJrAXh_QrihmE4ZxPK1iyHnFVtBG
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA2MDA0MiBTYWx0ZWRfX8tMNFTSZCSQz
 GtauRqtSV/Ki+hiSNmGz8mUEBkQjBBVZ5MLFlORFhOckaT7zhJOfxT8cIeQ+jHeorny0RhxLvKn
 PjR5NM1Q2KLFwVe8pwCNGxdCYRWrOsDABTpvpukfvD16BCtXXS//xwxT7lf68ql1ffAPRnON0Av
 iTXID251Ufe4BTU0hiUnmuIwm8F9ZzB5CnMDxUOMB9pHB8x9aqsAb5ArS18ujcPwl5ZmExHxsHb
 4/+WSUOZyD0I406td/kcU/015ADKwMnndoih8eCR5ntUAFnt5pNq/9MlwA3Bwum1Q2pXlGUQYOy
 ru/epSDJZWys1ogAsPh3PJemF8Na8i9MYF12DSUgwBpamcgXhYXIsO6Ec9QCJPDRjHqpWOSvKde
 yKnsAGXn+6C9sbpsMa9/FMlvt70FvYOqgAidGjkwz2slGpFCixcArLDf+B4ko5d07QxWBWvxgsc
 jq1rCZ0j6XE4Nczcy+g==
X-Authority-Analysis: v=2.4 cv=fM2sTpae c=1 sm=1 tr=0 ts=6ac4d413 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8 a=MWpyoRvI5OTVfYSV0dgA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-06_03,2026-10-05_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 bulkscore=0 priorityscore=1501 spamscore=0 lowpriorityscore=0
 phishscore=0 adultscore=0 malwarescore=0 clxscore=1015 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2610060042
Received-SPF: pass client-ip=148.163.156.1; envelope-from=rathc@linux.ibm.com;
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

RFC 02653 for Power ISA 3.2 adds FSSIR spr to indicate if DMF has any
unsaved state. Defining this SPR.

Signed-off-by: Chinmay Rath <rathc@linux.ibm.com>
---
 target/ppc/cpu.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/target/ppc/cpu.h b/target/ppc/cpu.h
index 7221868793..53b7a929d7 100644
--- a/target/ppc/cpu.h
+++ b/target/ppc/cpu.h
@@ -2179,6 +2179,7 @@ void ppc_compat_add_property(Object *obj, const char *name,
 #define SPR_UDEXCR            (0x32C)
 #define SPR_TAR               (0x32F)
 #define SPR_ASDR              (0x330)
+#define SPR_FSSIR             (0x33B)
 #define SPR_DEXCR             (0x33C)
 #define SPR_IC                (0x350)
 #define SPR_VTB               (0x351)
-- 
2.55.0


