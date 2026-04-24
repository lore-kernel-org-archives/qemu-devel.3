Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05D36FB44D6
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Apr 2026 08:40:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wGC4y-0005MQ-SD; Fri, 24 Apr 2026 04:40:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <adityag@linux.ibm.com>)
 id 1wGC4h-0004uR-F4; Fri, 24 Apr 2026 04:39:52 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <adityag@linux.ibm.com>)
 id 1wGC4f-0005Zu-Fg; Fri, 24 Apr 2026 04:39:47 -0400
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63O5dT64651504; Fri, 24 Apr 2026 08:39:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=t3USfH
 l5ZY0uImY4yVc/mb0OxDrXezZ1AyeryFDPsGc=; b=TTS4VRGPrAAwSEOatymvLV
 0kqwG9lDJGZHvBOgyLJgj6YKK4yZAUl9ntBbnolcjd3jp0ud+putT72d7CUTiKhs
 9hIc5AlDVyqfWwEktmUWWr7r1xOiWpOrTR8ZoLXs3TYqW8mFtHD37gj4CuSBiMcc
 RnHP/4KXk7ecFBdc+E9lUqUUGfmXt0GECMPAHgEDjwUAXsnaOuxdVgRSn4d76GAw
 F3oNeIi+t9jHD5o7bXIxo9eyrMwvNOUgu0c7Wo7i1ygq0Skmw2OG/4m+QKP0nmFA
 u9HYGyOaSfpw0qZWOG7Vr0ypIOiUS7Xe4waxraCUn94YmlqnCFg+rxehghKCINoQ
 ==
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4dpeu2cxmb-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 24 Apr 2026 08:39:43 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 63O8ZbGF028199;
 Fri, 24 Apr 2026 08:39:42 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4dpjkyj359-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 24 Apr 2026 08:39:42 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com
 [10.20.54.105])
 by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 63O8dcss47120888
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 24 Apr 2026 08:39:38 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id A2E7A20049;
 Fri, 24 Apr 2026 08:39:38 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id D2D7E20040;
 Fri, 24 Apr 2026 08:39:33 +0000 (GMT)
Received: from li-3c92a0cc-27cf-11b2-a85c-b804d9ca68fa.ibm.com (unknown
 [9.39.31.230]) by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Fri, 24 Apr 2026 08:39:33 +0000 (GMT)
From: Aditya Gupta <adityag@linux.ibm.com>
To: <qemu-devel@nongnu.org>
Cc: <qemu-ppc@nongnu.org>, Hari Bathini <hbathini@linux.ibm.com>,
 Sourabh Jain <sourabhjain@linux.ibm.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Nicholas Piggin <npiggin@gmail.com>,
 Miles Glenn <milesg@linux.ibm.com>, Chinmay Rath <rathc@linux.ibm.com>,
 Shivang Upadhyay <shivangu@linux.ibm.com>
Subject: [PATCH v6 10/10] MAINTAINERS: Add entry for MPIPL (PowerNV)
Date: Fri, 24 Apr 2026 14:08:37 +0530
Message-ID: <20260424083837.214947-11-adityag@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260424083837.214947-1-adityag@linux.ibm.com>
References: <20260424083837.214947-1-adityag@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDI0MDA3NiBTYWx0ZWRfX0PL4CZz9Fmjx
 KQIudotxmCArjdUfwtZIvhxL+97ZMByXS5LguS3uht0Ws9qa1WqB801WEe5V3Ymya9T5DgA1nhu
 Xry/HDOso4xLtRxE0XC8VzGSr+cP9Xpx/DWqn+w7KpBgLQpKqdndl+ZmjMvtVV8JDvRVhkcspCg
 2ayBKhYc9+dO812+vKJGLo9iNro3fb76DUHGlttSsDuSVBYFVur7EugxjPh0DjhdOWKuXTYpNIH
 8ePnxsEKhP2SP+VCOlS7uuSVL6RVrsgicmqsOVUUHbmepVWo1GDkkNexG3FpBpT/JT2t9MAxnhO
 w3hdztHHB0XGS7++U/Rue/oYLwtdq+YjdWAq0ITAeClREku2FZJXnD4woz6f+GDMIgBQnCRm3LZ
 p/1HK/jjzrsnv8Y/ZRP4Zn+7yLKKAbNYeW1UZsqwWDHzjDMcwQot+qDq5ghyzD6r8UpYQeL+a1E
 0lJd74tEIezb5PBnLgg==
X-Proofpoint-ORIG-GUID: 6BRQGiuGuVasjEBJot-1aKNUDircYUyd
X-Proofpoint-GUID: giAzy3muQuRAy9x7xXyOJi59OMhtAq3B
X-Authority-Analysis: v=2.4 cv=XMUAjwhE c=1 sm=1 tr=0 ts=69eb2c4f cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8
 a=KKAkSRfTAAAA:8 a=xAhUsU6pBgj2HNqxJKAA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-23_03,2026-04-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 clxscore=1015 priorityscore=1501 impostorscore=0 bulkscore=0
 spamscore=0 lowpriorityscore=0 phishscore=0 adultscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2604240076
Received-SPF: pass client-ip=148.163.156.1; envelope-from=adityag@linux.ibm.com;
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

Add maintainer and reviewer for MPIPL subsystem.

Reviewed-by: Hari Bathini <hbathini@linux.ibm.com>
Reviewed-by: Sourabh Jain <sourabhjain@linux.ibm.com>
Signed-off-by: Aditya Gupta <adityag@linux.ibm.com>
---
 MAINTAINERS | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 0a90204ae936..00ea1f13acf1 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3296,6 +3296,15 @@ F: include/hw/ppc/spapr_fadump.h
 F: hw/ppc/spapr_fadump.c
 F: tests/functional/ppc64/test_fadump.py
 
+Memory-Preserving Initial Program Load (MPIPL) for PowerNV
+M: Aditya Gupta <adityag@linux.ibm.com>
+R: Hari Bathini <hbathini@linux.ibm.com>
+R: Sourabh <sourabhjain@linux.ibm.com>
+S: Maintained
+F: include/hw/ppc/pnv_mpipl.h
+F: hw/ppc/pnv_mpipl.c
+F: tests/functional/ppc64/test_fadump.py
+
 GDB stub
 M: Alex Bennée <alex.bennee@linaro.org>
 R: Philippe Mathieu-Daudé <philmd@linaro.org>
-- 
2.53.0


