Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF4E3C83F26
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Jul 2025 10:07:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uesqg-0008QE-NZ; Thu, 24 Jul 2025 06:06:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1uesqe-0008Ln-4W; Thu, 24 Jul 2025 06:06:48 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1uesqc-0006e3-JR; Thu, 24 Jul 2025 06:06:47 -0400
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56NNpX6L015882;
 Thu, 24 Jul 2025 10:06:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=wxucr8
 5iTffjs2wR5br9P+oXx0KQV3JK8t2aUp5oVWg=; b=icfjQwCwEyU9b3KuNAZ79X
 sAoybXiAKaBv9KGStw76G1PUBRw8DtDtJ6iIoGysYFPOhq5gE2Q6ZgOjZm834Lbc
 gQFiEQVgj6z+sdve643tRggWHcxehbnJckYAQaoD+TJWrzzXaNI5xAGX2cdJh2ax
 iK7hOvT8IBGWQwK3epLhIDNPEFtfmXsV7QNEQx3E7lcgzF0q4uISjfzvQttjVvV0
 zoc8viEgYMgPbWq4yht80dQ8CJbNEdVUuAGry52pax2+cKIeQGKIP5eIwh0G+krd
 WRltNZBUy0nT5JmJuV0quxhNwfENPBpSU9bkXzUFswgRQ6DrIv3As4cOp4dXRGnQ
 ==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 482ff69xh7-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 24 Jul 2025 10:06:44 +0000 (GMT)
Received: from m0356516.ppops.net (m0356516.ppops.net [127.0.0.1])
 by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 56OA58d4028931;
 Thu, 24 Jul 2025 10:06:43 GMT
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 482ff69xh5-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 24 Jul 2025 10:06:43 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 56O6WPQ6014324;
 Thu, 24 Jul 2025 10:06:43 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 480pppc0ks-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 24 Jul 2025 10:06:42 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com
 [10.20.54.102])
 by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 56OA6dXC53543380
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 24 Jul 2025 10:06:39 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 0F3D220079;
 Thu, 24 Jul 2025 10:06:39 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 0B62120076;
 Thu, 24 Jul 2025 10:06:37 +0000 (GMT)
Received: from li-1901474c-32f3-11b2-a85c-fc5ff2c001f3.in.ibm.com (unknown
 [9.109.242.24]) by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Thu, 24 Jul 2025 10:06:36 +0000 (GMT)
From: Harsh Prateek Bora <harshpb@linux.ibm.com>
To: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, npiggin@gmail.com,
 clg@redhat.com
Cc: danielhb413@gmail.com, fbarrat@linux.ibm.com, rathc@linux.ibm.com,
 adityag@linux.ibm.com, gautam@linux.ibm.com, philmd@linaro.org
Subject: [PATCH v2 4/5] MAINTAINERS: Add myself as a reviewer of PowerNV
 emulation
Date: Thu, 24 Jul 2025 15:36:18 +0530
Message-ID: <20250724100623.3071131-5-harshpb@linux.ibm.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20250724100623.3071131-1-harshpb@linux.ibm.com>
References: <20250724100623.3071131-1-harshpb@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzI0MDA3MSBTYWx0ZWRfXx4zrCiJiWJjq
 em2SAp/qWW2Q0wsO95RPkK/1E1kWp2nBDAa3yBGmEj1za+07hdyJTShkkPtuA2KProfY+QLlNgs
 +repJZis7USiq4jVL4j3S2gGADxg6uSHi/9qSwhLCtc8Fu8WtFtm9MazvEYnKV+mryin4OvKejL
 lol73c3y7VCRKGZBTCx4xT5t15kW5NveFNDKK7tP9SgZMbDmlkZP5rSoxeoVMN4brAO71AWc/0h
 r8NSFqbK6toh4XFn/XWXyP5Z5ROhUal65hmYAAKQrj/78+QR4tshkMdLWtlZfqFcRBA87+v6CmL
 0oCI/ZQJ9LTuwG3x14wa4TM3XmpF+RLbPP533VHGU0SEv0CCuGBuXmp/pGiV2uv9/MeOzBLGjgM
 4j1ReH0gBgcy2bKeHZ6dAoi4ug8ljy0203QGi1udasY0dh1wI1XHE4CZXC9eHlmF+Setz977
X-Proofpoint-ORIG-GUID: q_Z2iQSOhUc13-dtH-5M9mmuH656ZPhg
X-Proofpoint-GUID: 0M7VM7UJfpGQTPTcui-7_K4bOF6VJqd-
X-Authority-Analysis: v=2.4 cv=TtbmhCXh c=1 sm=1 tr=0 ts=688205b4 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=f7IdgyKtn90A:10 a=VnNF1IyMAAAA:8
 a=aow-egSQAAAA:8 a=pGLkceISAAAA:8 a=69wJf7TsAAAA:8 a=G3fZWRzZ_yYB3P_MiQsA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=gFNbaldVC-z-bsjSTzMo:22
 a=Fg1AiH1G6rFz08G2ETeA:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-24_01,2025-07-23_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxlogscore=825 suspectscore=0 impostorscore=0 malwarescore=0
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

From: Aditya Gupta <adityag@linux.ibm.com>

Proposing myself as a reviewer in the PowerNV emulation in QEMU

Have been working on PowerNV QEMU for sometime, with contributions in
Power11, MPIPL and minor fixes and things such as dtb support

Cc: Cédric Le Goater <clg@kaod.org>
Cc: Frédéric Barrat <fbarrat@linux.ibm.com>
Cc: Mahesh J Salgaonkar <mahesh@linux.ibm.com>
Cc: Madhavan Srinivasan <maddy@linux.ibm.com>
Cc: Nicholas Piggin <npiggin@gmail.com>
Signed-off-by: Aditya Gupta <adityag@linux.ibm.com>
Signed-off-by: Harsh Prateek Bora <harshpb@linux.ibm.com>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 31bcb82e93..1ba161d75b 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1579,6 +1579,7 @@ F: tests/functional/test_ppc64_tuxrun.py
 PowerNV (Non-Virtualized)
 M: Nicholas Piggin <npiggin@gmail.com>
 R: Frédéric Barrat <fbarrat@linux.ibm.com>
+R: Aditya Gupta <adityag@linux.ibm.com>
 L: qemu-ppc@nongnu.org
 S: Odd Fixes
 F: docs/system/ppc/powernv.rst
-- 
2.43.5


