Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C362EC83F26
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Jul 2025 10:08:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uesqe-0008Mg-Fj; Thu, 24 Jul 2025 06:06:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1uesqY-0008H3-4T; Thu, 24 Jul 2025 06:06:42 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1uesqV-0006cm-Dh; Thu, 24 Jul 2025 06:06:40 -0400
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56O0jEiP017409;
 Thu, 24 Jul 2025 10:06:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=n7XbFDFhwYbvpEOzP
 JQqvr8n+k3RG4rXQYUE6l7nV9I=; b=VEiiMTPXk/iADuaaC7T0siVPM3DToUaq5
 K1l+0gZcxpwm+SfKvIe9QUM0JJJ5tX87Crk8j0B3TEMaiEEjQuiFARsQCe6lgibC
 eTaxX68h185HnEQr5G0MFpK6TV/wWySw1J9WqDFZI8M6Ls1UAxxztxeU2On/vJBI
 tPzPBdWqAtwPcXGFlAZxOGGBfjiih2mrLoXNpuDI47lmYuEYs7QlTO0UnRuXdGPV
 TMPPLktScGV/knGZkVeIhJmmEIOMKUV8bwVnXZgPnITME5rEkjQd0r1KUm49QWTL
 oso7WnQf/3YNTv7eKuaU3avc+NScch/rfsJjDDoz+r7egjNiKPeIQ==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 482ff69xgp-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 24 Jul 2025 10:06:37 +0000 (GMT)
Received: from m0356516.ppops.net (m0356516.ppops.net [127.0.0.1])
 by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 56OA4eWC027622;
 Thu, 24 Jul 2025 10:06:36 GMT
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 482ff69xgn-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 24 Jul 2025 10:06:36 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 56O6hR7v004723;
 Thu, 24 Jul 2025 10:06:36 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 480u8g36d2-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 24 Jul 2025 10:06:35 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com
 [10.20.54.102])
 by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 56OA6Wce50725288
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 24 Jul 2025 10:06:32 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 0C3842006E;
 Thu, 24 Jul 2025 10:06:32 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 0EF5F2007A;
 Thu, 24 Jul 2025 10:06:30 +0000 (GMT)
Received: from li-1901474c-32f3-11b2-a85c-fc5ff2c001f3.in.ibm.com (unknown
 [9.109.242.24]) by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Thu, 24 Jul 2025 10:06:29 +0000 (GMT)
From: Harsh Prateek Bora <harshpb@linux.ibm.com>
To: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, npiggin@gmail.com,
 clg@redhat.com
Cc: danielhb413@gmail.com, fbarrat@linux.ibm.com, rathc@linux.ibm.com,
 adityag@linux.ibm.com, gautam@linux.ibm.com, philmd@linaro.org
Subject: [PATCH v2 1/5] MAINTAINERS: Adding myself as a co-maintainer for
 ppc/spapr
Date: Thu, 24 Jul 2025 15:36:15 +0530
Message-ID: <20250724100623.3071131-2-harshpb@linux.ibm.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20250724100623.3071131-1-harshpb@linux.ibm.com>
References: <20250724100623.3071131-1-harshpb@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzI0MDA3MSBTYWx0ZWRfX0Ao2e59WNE8o
 D+n+7I4LVmb20P2+5S+5jgD+VTRSug0YIBxNiBdKnDxjmYdcZSBw5eTVkoguOzLa3eefgTtVxpb
 pPj/V8WkJtovOv7eGSnXnzxoouHjNlO79ejqC3D+rRsiExvWQvP5CZK8HEt9VntBCCxm8glBRY2
 vKhhV+SJvl3epymhjNAQB2UHNvsw9IgGoyGk/7zkTO70pshMAERXwOHcQhNhn3pYNvwR4FEuKjt
 m0scxfBCY/sO60Ca4h9w8EDstOqGyrzK1uC6tkBFQtuZIzMsj/iuRRIHr7oApYEHY3MS/EKypCD
 3MVWbqhmPda8sBOi7hqMlQSH4yNdbc2574WS93yNc7SYHs2SixsN2IzH0bupsd4E/sTB/Ro9l6+
 BZJWMMHM2pgaKuLbICzMLATNpLjBOYA8cxRjOu8BWnRuR/pqzvzMvs6FyHveSgpHrkHc4/L5
X-Proofpoint-ORIG-GUID: zIYnX5ovil_gzxONufaLWzlQOc8npW_-
X-Proofpoint-GUID: q6uZogd6fJoxsdYPtgaep9dncMYu_X3d
X-Authority-Analysis: v=2.4 cv=TtbmhCXh c=1 sm=1 tr=0 ts=688205ad cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=Wb1JkmetP80A:10 a=f7IdgyKtn90A:10 a=VnNF1IyMAAAA:8 a=pGLkceISAAAA:8
 a=69wJf7TsAAAA:8 a=r9MvvrW2hgB5ZokijoUA:9 a=Fg1AiH1G6rFz08G2ETeA:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-24_01,2025-07-23_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxlogscore=611 suspectscore=0 impostorscore=0 malwarescore=0
 priorityscore=1501 clxscore=1015 mlxscore=0 lowpriorityscore=0 spamscore=0
 adultscore=0 phishscore=0 bulkscore=0 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2507240071
Received-SPF: pass client-ip=148.163.158.5; envelope-from=harshpb@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

Have been contributing in ppc/spapr and related areas for quite some
time as a contributor and reviewer. I think its time to step up as a
co-maintainer to help with maintainer activities.

Signed-off-by: Harsh Prateek Bora <harshpb@linux.ibm.com>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index a462345618..afc94e6e67 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1550,6 +1550,7 @@ F: tests/functional/test_ppc_40p.py
 
 sPAPR (pseries)
 M: Nicholas Piggin <npiggin@gmail.com>
+M: Harsh Prateek Bora <harshpb@linux.ibm.com>
 R: Daniel Henrique Barboza <danielhb413@gmail.com>
 R: Harsh Prateek Bora <harshpb@linux.ibm.com>
 L: qemu-ppc@nongnu.org
-- 
2.43.5


