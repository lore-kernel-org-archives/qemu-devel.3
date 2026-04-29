Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96E44CCFA13
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Apr 2026 18:34:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wI9je-0007qU-Sm; Wed, 29 Apr 2026 14:34:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1wI9jW-0007iF-Is
 for qemu-devel@nongnu.org; Wed, 29 Apr 2026 14:34:03 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1wI9jU-0007Cd-V4
 for qemu-devel@nongnu.org; Wed, 29 Apr 2026 14:34:02 -0400
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63TEMrrc811499
 for <qemu-devel@nongnu.org>; Wed, 29 Apr 2026 18:33:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=BZ1aXq
 TFCRKyV+wSFLk0m5qpLYkLGAYo8ftbmMo0h6w=; b=EmwZ7rTZFlNCaaTD9btY6N
 1xZpdN7TKVrbMc+w7CP8qXaxjQMkSY4/xSwud1eyg1yUSheAC3ZiYMFPBIJS9nk6
 T0cyspKFzH0tuhUxHm2vZ1YkoIRjC4yghYeGU4jN5hg3W++tai/TjaW0EIaTTpuI
 GisfQT06IJZsiH6hx4OiiUKxcH6mjO1hdhjhuljYCftyePIOOlr8n+c/IKDLyvXx
 sxob+RSQ4Ugiy1G4IufvKOtruKAwmLMU/bDRoaSZIJSYM9usrK6JQYMN6ICXlukF
 TgRZ+7HJro6SHv12wnYBrQFD7NkxM1SEdhTbAnXPn7m9u6+PHbeCNKs0y7XXgF5Q
 ==
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4drnb5c25y-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 29 Apr 2026 18:33:59 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 63TINov2006657
 for <qemu-devel@nongnu.org>; Wed, 29 Apr 2026 18:33:58 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4dsa5gfevn-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 29 Apr 2026 18:33:58 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com
 [10.20.54.105])
 by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 63TIXs5446465290
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 29 Apr 2026 18:33:54 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id B3C9F2004D;
 Wed, 29 Apr 2026 18:33:54 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 6CF4320040;
 Wed, 29 Apr 2026 18:33:52 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.39.31.77])
 by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Wed, 29 Apr 2026 18:33:52 +0000 (GMT)
From: Harsh Prateek Bora <harshpb@linux.ibm.com>
To: qemu-devel@nongnu.org
Cc: Aditya Gupta <adityag@linux.ibm.com>,
 Hari Bathini <hbathini@linux.ibm.com>,
 Sourabh Jain <sourabhjain@linux.ibm.com>,
 Shivang Upadhyay <shivangu@linux.ibm.com>
Subject: [PULL 10/13] MAINTAINERS: Add entry for MPIPL (PowerNV)
Date: Thu, 30 Apr 2026 00:03:00 +0530
Message-ID: <20260429183310.12455-11-harshpb@linux.ibm.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260429183310.12455-1-harshpb@linux.ibm.com>
References: <20260429183310.12455-1-harshpb@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=AqDeGu9P c=1 sm=1 tr=0 ts=69f24f17 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=f7IdgyKtn90A:10
 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22
 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8 a=KKAkSRfTAAAA:8 a=bbZZDkM4wAf7KGCsbpkA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDI5MDE4NCBTYWx0ZWRfX6lvGR6kHXkb4
 G4ktnGHwrRYuJ5vzOSoyDJsZF0uGUlZlb7jOSolN5gcWSPFWobEB0oodMKM4mVqWMlOQwJyt4To
 xVBEObZHNto7weZcaa5J/uv9vNlpA4QI3fEYEWk27wRZ4t49lK2d6go4x49qbmW39l4lGQaxaDo
 nJoJiQjF6Fq/mxi/HxO/sW/RaRe7sDuOSFq1ASQD8ZY41fxbamQ9ZFDpTR/6p6fz1g8loZuEp3u
 lG1512X9wulHKpHZGZftaO4Sfr2VioMdS2KMuueMnREA8e56H+1+0ABNcf0/UbhYc2CFtzAxciq
 NsNUEztFSejoND+BTjn47mXyBwYkPGbpsTaCN9N/24YVvOQ467NVdzC3N6h19NdQmkonVb5Bj2p
 G/ZFc0K2/bnC34hGSprvSQNDX9wBlr6naDqthr+aKYzzxoxAKdRRwYJQfXBg8FKr1GdWo0dbdp5
 gznDz/qdB8tGphDTo5g==
X-Proofpoint-GUID: eD9jJt5XwaJ8CNXwOrVncWuBRtHNxCqO
X-Proofpoint-ORIG-GUID: eD9jJt5XwaJ8CNXwOrVncWuBRtHNxCqO
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-29_01,2026-04-28_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 priorityscore=1501 phishscore=0 suspectscore=0 clxscore=1015
 lowpriorityscore=0 spamscore=0 bulkscore=0 impostorscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2604290184
Received-SPF: pass client-ip=148.163.156.1; envelope-from=harshpb@linux.ibm.com;
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

From: Aditya Gupta <adityag@linux.ibm.com>

Add maintainer and reviewer for MPIPL subsystem.

Reviewed-by: Hari Bathini <hbathini@linux.ibm.com>
Reviewed-by: Sourabh Jain <sourabhjain@linux.ibm.com>
Signed-off-by: Aditya Gupta <adityag@linux.ibm.com>
Tested-by: Shivang Upadhyay <shivangu@linux.ibm.com>
Link: https://lore.kernel.org/qemu-devel/20260424083837.214947-11-adityag@linux.ibm.com
Signed-off-by: Harsh Prateek Bora <harshpb@linux.ibm.com>
---
 MAINTAINERS | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index e41f0eb92c..0adc6bd6b8 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3285,6 +3285,15 @@ F: include/hw/ppc/spapr_fadump.h
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
2.52.0


