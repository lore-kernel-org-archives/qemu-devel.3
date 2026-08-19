Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A067C5DF81
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Aug 2026 19:39:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wwm7C-0004EQ-0s; Wed, 19 Aug 2026 15:38:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shivangu@linux.ibm.com>)
 id 1wwm78-0004AB-UU; Wed, 19 Aug 2026 15:38:18 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shivangu@linux.ibm.com>)
 id 1wwm76-0007HJ-I9; Wed, 19 Aug 2026 15:38:18 -0400
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67JI1dpa4162565; Wed, 19 Aug 2026 19:38:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=PRZRXcVeOXSZAn/mw
 CTV09MevSLNF7pJpoEh+0Jncoc=; b=esLZgFaxIipfQee1YqQImg+xlA1Oowl7q
 jM/LgUkhkfzn3ODB5+p3OR2tgxuSfNr+ggJwxG7lbGOcIQs1dNsB8wXec3oQNBHe
 NuIn/awM1o8o/QlJ6Bxc8oLknqVUo3REU+qzhzOt9XRm3Wddgu1VIQ/dvozzZ82p
 3VDLgaSjFB+WQLyUhutxy+NskEGlxEBIg8otWtJ1r0nkB2dasbqzeTI7cUOnmpkT
 zyaihbi1t/DLkEko1lDgVg9SZqtwKX0sFOIR58KZHgKJta0eqsS5xKShLFL3FldO
 NKXFlJfH9pGSO5W7mKLiVexjtRqVRw71B8XvJlOhriEb5lukgFOug==
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4g4yu1dujs-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 19 Aug 2026 19:38:14 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67JJQI0S027835;
 Wed, 19 Aug 2026 19:38:13 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4g33xhajqy-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 19 Aug 2026 19:38:13 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com
 [10.20.54.104])
 by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 67JJc9BL40632770
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 19 Aug 2026 19:38:09 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 3C37E20043;
 Wed, 19 Aug 2026 19:38:09 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 5C21920040;
 Wed, 19 Aug 2026 19:38:06 +0000 (GMT)
Received: from shivang.com (unknown [9.39.17.34])
 by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Wed, 19 Aug 2026 19:38:06 +0000 (GMT)
From: Shivang Upadhyay <shivangu@linux.ibm.com>
To: qemu-devel@nongnu.org, qemu-ppc@nongnu.org
Cc: shivangu@linux.ibm.com, adityag@linux.ibm.com, harshpb@linux.ibm.com,
 hbathini@linux.ibm.com, mahesh@linux.ibm.com, npiggin@gmail.com,
 rathc@linux.ibm.com, sourabhjain@linux.ibm.com, vaibhav@linux.ibm.com
Subject: [PATCH v3 2/2] MAINTAINERS: add self as reviewer for PowerPC RAS
Date: Thu, 20 Aug 2026 01:07:55 +0530
Message-ID: <20260819193757.1072909-3-shivangu@linux.ibm.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260819193757.1072909-1-shivangu@linux.ibm.com>
References: <20260819193757.1072909-1-shivangu@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=LsCiDHdc c=1 sm=1 tr=0 ts=6a860626 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8 a=69wJf7TsAAAA:8
 a=WK6P9NOuF5wEigxtcgcA:9 a=Fg1AiH1G6rFz08G2ETeA:22
X-Proofpoint-GUID: xN6ID3LARaJxIa2lWp9hkEKKU-pyYobQ
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE5MDE1MSBTYWx0ZWRfXyCfvGF5LgkjT
 c74IxJMawCAbE27oTuABPemfRE+rNKAIZP0EiQjOI8/Qdq9vaHssmU9GJExRvjCdGzrXeRNBE1m
 E3Zz9O21k2Cgtj9uj2Mz/QotzYDpsdY=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE5MDE1MSBTYWx0ZWRfX4sRXWPwxTawb
 H4FmtWfbKNX68Mu55c3DOlx9R+Ep9hCOEPAxuy9TsVRXVgkYB3Mt9x2y815eP44BNjoBc7XY/bx
 go8t2rT19gGRy6VHmyVODBl9TIJzah1tzAGr7Iemda9B6/fY4N/0Li214ShA7Q+sg5zYSFTK4es
 +AZz52uusheaeFxcT8qy1fNe20O+OQj9rzjKDlBpB1j/K/+Htfg8rg3w4O9HpuHuByeyyIm1PlB
 jl4EeqRT23FwQjNy9eL+GlBb0HTZVzrzRRSsvTpuQmxR0lcdyCvtCycV3BZiBObSpQBgjSTAYHk
 jMIG8o6RegkuM6f8W9Y2x5FAkWK1uo2tyhGjmYcifYMIQDB4iFISGjj49OrIUTu74OBk14ilYIg
 S6hx31iNfw8HBh67HgZnPIkz4nU0oJ9Chc6enDZPpBF2tYEqnguoTMpAJ5JYWS0DiNAsHZBBNkk
 kTu7BvO/onBesrISZ2Q==
X-Proofpoint-ORIG-GUID: VABqa5CKdUZ56qEq-mlasX_CIB1SB3O5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-19_05,2026-08-19_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 spamscore=0 priorityscore=1501 lowpriorityscore=0 bulkscore=0
 adultscore=0 suspectscore=0 impostorscore=0 clxscore=1015 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608190151
Received-SPF: pass client-ip=148.163.156.1;
 envelope-from=shivangu@linux.ibm.com; helo=mx0a-001b2d01.pphosted.com
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

I have been contributing to Fadump, MPIPL as well as PowerNV for quite
some time, and my daily work responsibilities includes taking care of
PowerPC RAS features. I, therefore would like to step up as a reviewer
to get notified of incoming changes in this area and help reviewing
them.

Acked-by: Aditya Gupta <adityag@linux.ibm.com>
Signed-off-by: Shivang Upadhyay <shivangu@linux.ibm.com>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index a2a80c789c..b06dd5c486 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1766,6 +1766,7 @@ PowerPC RAS (Reliability, Availability and Serviceability)
 M: Aditya Gupta <adityag@linux.ibm.com>
 R: Sourabh Jain <sourabhjain@linux.ibm.com>
 R: Hari Bathini <hbathini@linux.ibm.com>
+R: Shivang Upadhyay <shivangu@linux.ibm.com>
 L: qemu-ppc@nongnu.org
 S: Maintained
 F: hw/ppc/spapr_events.c
-- 
2.54.0


