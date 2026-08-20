Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8969BC5DF85
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Aug 2026 14:28:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wx3kh-0003Jx-BY; Thu, 20 Aug 2026 10:28:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rathc@linux.ibm.com>)
 id 1wx3kc-0003Dw-Lj; Thu, 20 Aug 2026 10:28:15 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rathc@linux.ibm.com>)
 id 1wx3kb-0002Fn-5x; Thu, 20 Aug 2026 10:28:14 -0400
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67K91ReE2794836; Thu, 20 Aug 2026 14:28:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=fXpwLenKIkbvzf7/W
 cR7Id3nYXwXQ9E2yiuOqalzSSo=; b=gFnM20ynAiI3lpOUtCaA/EIhQ2jOHkY4Y
 fHW4MMqUdKOo8I53V9f5jo6F64gWI83yQR7lMMtZlqDNNZqoYbyA23p+K1hEM4KJ
 xpvdVO+uu7m4N9m215g+w/Y6anUuzeox8TVzipLNJVz2P3ALQhAKFhvKG68z8n/n
 Z2TFNfoVTRBx2GSOzySIRHmyu9rb/w1et+pIrZmbrbjIDXoqMHJ6vGk7K6UfARpd
 XJIYcaxUA/Yv1FO0xW+dtbq1fsvaLIlF+P/PKn7cHg+J8pB1pourB7vXwOg1+zp4
 d9qMxVFGRh62IX4lhIMG4ECT1w9aDmBHXK5GDps5GomBzIx2YCQMA==
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4g4yu0aw4m-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 20 Aug 2026 14:28:11 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67KEQRD7001240;
 Thu, 20 Aug 2026 14:28:10 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4g32eqf6u1-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 20 Aug 2026 14:28:10 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com
 [10.20.54.105])
 by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 67KES6LK49086782
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 20 Aug 2026 14:28:06 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 59BC520040;
 Thu, 20 Aug 2026 14:28:06 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 7057F20049;
 Thu, 20 Aug 2026 14:28:02 +0000 (GMT)
Received: from li-18a0a34c-33fc-11b2-a85c-d9f1631c5692.ibm.com (unknown
 [9.39.17.115]) by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Thu, 20 Aug 2026 14:28:01 +0000 (GMT)
From: Chinmay Rath <rathc@linux.ibm.com>
To: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, harshpb@linux.ibm.com
Cc: npiggin@gmail.com, milesg@linux.ibm.com,
 Chinmay Rath <rathc@linux.ibm.com>,
 Tasmiya Nalatwad <tasmiya@linux.ibm.com>
Subject: [PATCH v2 7/7] target/ppc: Add ICBT support for ISA version 2.07
Date: Thu, 20 Aug 2026 19:57:04 +0530
Message-ID: <20260820142717.337686-8-rathc@linux.ibm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260820142717.337686-1-rathc@linux.ibm.com>
References: <20260820142717.337686-1-rathc@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-ORIG-GUID: s1oMSCpkF9HZ_QVM9ES6ujoAVP2hfI0y
X-Proofpoint-GUID: ARFD2c15Oy9OeGFUooKSVx9dsu895HJo
X-Authority-Analysis: v=2.4 cv=RoX16imK c=1 sm=1 tr=0 ts=6a870efb cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8 a=VhmWRyikh7PcAoWILYgA:9
X-Proofpoint-Spam-Info: AW1haW4tMjYwODIwMDEwNSBTYWx0ZWRfX7IRkMLWEJKxR
 D1pthgHthyXxzV6XxKacPlp3Kuiqa27R5O9N/co04EjC4ftuHJCgkOXuG1BCYO8BffQdZ3WUp/f
 rsu8K1p9BohOQNSUrGonLXCgsAHB6/8=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODIwMDEwNSBTYWx0ZWRfX/5DcwrOZNF5Z
 F8MgasDcue9EEIEGgRJ+bpTnPhnkAkdJt0kbKdsTEW3DSmPCyKp6WIiCxP3gYSXjuSI+1jR4g0z
 2ROucjDJ9JEktY+m7J9bhRgkcts/JpwQxXDd9Cq7+rdJmLRBEViF1OJ/3MmHNxdkr0rgnV+uyvP
 +emmnJlOP8LcLUKcx9ci7BMn/CS5YAjQn7XrW85LPe4zzcT4AmF8SWd37xXfPKzCW3NecW1Flfm
 xRSkDkoB0taioXxFTzzB+xQXHj0KwA9vvFDDQPS/j4VVqP+5LBlIIBsLn4DfGs1zAuwnDAx2yev
 SIu1/+/Od6M7wttt7bgl8mmBI+aI181Z+am97BNNtCb2jYgkcqlz0+zw5Cs6BYneDr+FdWaEnKj
 UZu0CqagFqFKVbE9C32NPFn9D31UN6T5mENqnntznnn8OuixLYNX1kuoHfglXGBH/oe4vu8uLBA
 m1alppDSJbAnJ8VoNJw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-19_06,2026-08-19_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 suspectscore=0 malwarescore=0 adultscore=0
 clxscore=1015 phishscore=0 spamscore=0 bulkscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608200105
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

The summary of changes in Power ISA version 2.07B mentions :
"ICBT instruction has been moved from the Embedded category
to the Base category".
Updating ICBT flag for the same.

While we are at it, correct the invalid mask as per the ISA as well.

Tested-by: Tasmiya Nalatwad <tasmiya@linux.ibm.com>
Reviewed-by: Glenn Miles <milesg@linux.ibm.com>
Signed-off-by: Chinmay Rath <rathc@linux.ibm.com>
---
 target/ppc/translate.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/target/ppc/translate.c b/target/ppc/translate.c
index bc23a71a2f..4208763e8a 100644
--- a/target/ppc/translate.c
+++ b/target/ppc/translate.c
@@ -4509,8 +4509,8 @@ GEN_HANDLER2_E(tlbilx_booke206, "tlbilx", 0x1F, 0x12, 0x00, 0x03800001,
 GEN_HANDLER(wrtee, 0x1F, 0x03, 0x04, 0x000FFC01, PPC_WRTEE),
 GEN_HANDLER(wrteei, 0x1F, 0x03, 0x05, 0x000E7C01, PPC_WRTEE),
 GEN_HANDLER(dlmzb, 0x1F, 0x0E, 0x02, 0x00000000, PPC_440_SPEC),
-GEN_HANDLER2_E(icbt_440, "icbt", 0x1F, 0x16, 0x00, 0x03E00001,
-               PPC_BOOKE, PPC2_BOOKE206),
+GEN_HANDLER2_E(icbt_440, "icbt", 0x1F, 0x16, 0x00, 0x02000001,
+               PPC_BOOKE, (PPC2_BOOKE206 | PPC2_ISA207)),
 GEN_HANDLER2(icbt_440, "icbt", 0x1F, 0x06, 0x08, 0x03E00001,
              PPC_440_SPEC),
 GEN_HANDLER(mfvscr, 0x04, 0x2, 0x18, 0x001ff800, PPC_ALTIVEC),
-- 
2.55.0


