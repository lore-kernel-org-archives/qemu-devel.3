Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24273C61DB6
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2026 09:10:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wynAI-0003FG-9t; Tue, 25 Aug 2026 05:09:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shivangu@linux.ibm.com>)
 id 1wynAG-0003D2-9A; Tue, 25 Aug 2026 05:09:52 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shivangu@linux.ibm.com>)
 id 1wynAE-0004k9-Gh; Tue, 25 Aug 2026 05:09:52 -0400
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67P8WARe2650217; Tue, 25 Aug 2026 09:09:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=pp1; bh=uRhMhjfUdEp+T4uR/ALFaOjHZwUE1XWZbdYuM4of/
 ok=; b=rUqG+/HWCkPCT0/ol3kUbWgwspTT+qD+jqTq6cgepDjP6CiuU7009hUIR
 /Di00azLxFplTc6Rc3IdJm74CSO6yC+K/DaxL2mXgVieKzZOOqFQLvCxL+M/CUtk
 2AKruoltrh9gnFw+cV0YIMRDtIAzX7+7Mfp58LRaHE009b1UQbdIsi/hGkhz3SRd
 kDF5jlWu3ywF3L607FJYOGQJpK4gOYQaOynybKNyuqpL3lqzIizR9QUwB68zlV4E
 nVGqSMc1A8Gx6a4hFpBQHhiFQ1SL0j27GC+yWTTi1ymz3vhYEXgHZHLnVmEIB0dP
 c33OK7bvppnWK3+luC/S6Y5LtZCzQ==
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4g73eqq3x1-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 25 Aug 2026 09:09:47 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67P8uHZk016508;
 Tue, 25 Aug 2026 09:09:46 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4g7q3jub8w-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 25 Aug 2026 09:09:43 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com
 [10.20.54.105])
 by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 67P99dob43844044
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 25 Aug 2026 09:09:39 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id DB37A2004B;
 Tue, 25 Aug 2026 09:09:38 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id AF08720049;
 Tue, 25 Aug 2026 09:09:35 +0000 (GMT)
Received: from shivang.com (unknown [9.39.21.24])
 by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Tue, 25 Aug 2026 09:09:35 +0000 (GMT)
From: Shivang Upadhyay <shivangu@linux.ibm.com>
To: shivangu@linux.ibm.com, qemu-devel@nongnu.org, qemu-ppc@nongnu.org
Cc: adityag@linux.ibm.com, anushree.mathur@linux.vnet.ibm.com,
 harshpb@linux.ibm.com, mahesh@linux.ibm.com, sourabhjain@linux.ibm.com,
 amachhiw@linux.ibm.com, hbathini@linux.ibm.com, npiggin@gmail.com
Subject: [PATCH v3 0/1] hw/ppc/fadump: Fix CPU_STATE_DATA region reported size
Date: Tue, 25 Aug 2026 14:39:31 +0530
Message-ID: <20260825090932.1748581-1-shivangu@linux.ibm.com>
X-Mailer: git-send-email 2.54.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-GUID: 7d5xjXoLviR3FXt12WmzNm_5qEsT3UVs
X-Proofpoint-ORIG-GUID: uvjli2COGPSdou4XEpm7Wf8xjGJjhERq
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI1MDA3NiBTYWx0ZWRfXwUCGUd/UMmKM
 mAq7LhfRZONgfeSg4UlrROfPnrawXNQxz5tbWfFPahpjiUAxGUxxeXT2rP1MOLfM4n4jbwSr4Gl
 ZUxS6MXT3+oqdqsOBwL95IfLcVl/8XEIP3+GwkQqR6Fn9EfCLXN+VEc6CPcmD4HrZTdQCcMO4Th
 DRUDBsySEFstQSNPk2ibihF3zH1aw8C0B5Y9wnErQgzqz0aKrM1eJ77oQvHhyyUvwqzGZ0onUv1
 uvzsf8tVS2vb79isi3a/EXQKOnDKCuEHszR+rcIRnsNBDRd569HfqzbgMBD0Hzvww6RyPSiEgZ8
 BdcfSY9s2OsCPOQIgMarU/nXUkRK9sQ5M172OFc81iYp6lEW6FCX1HzP/z4dEtGEssjddrXZY4a
 ikiN6waZTVNltkw86NZogv9X8DtEuh+hFpE2AuPgNQ0Jtk3rWIUQRzHXylatvAaF4d1yVrmru1v
 t8XhAp+OY+tya1wILdg==
X-Authority-Analysis: v=2.4 cv=QsRuG1yd c=1 sm=1 tr=0 ts=6a8d5bdb cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=uAbxVGIbfxUO_5tXvNgY:22 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8
 a=qWSFGm0LHDTrzJZ27iMA:9
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI1MDA3NiBTYWx0ZWRfX+3GqOus+tv5F
 XqIBjZt9r+5sb4dqPnTlwPX73Uxi6UV4kZwSMKIR5MJQgO/GLdC3CB9BJer1aHAh0pHKwkosRN1
 2MA5q/IYlGavInYqlyC4m+FuJwsNRSo=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-25_02,2026-08-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 adultscore=0 suspectscore=0 priorityscore=1501 impostorscore=0
 spamscore=0 lowpriorityscore=0 clxscore=1015 bulkscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608250076
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

Fadump is unable to collect dump, when qemu is started with maxcpus option.
This bug was also disucssed on linux side here [1]. But We could not find a way
to mitigate all the ambiguity around the fadump region error reporting. It is
assumed that if allocated size and dumped size dont match, then data copy must
have failed. So Replicating the Phyp's behaviour here.

The following behaviour is observed with Phyp.

 1. Registers entries are only filled for online CPUs.
 2. regNum is set as number of currently online CPUs.
 3. CPU_STATE_DATA's bytes_dumped always equals source_len.

Qemu already have, same behaviour for 1 and 2. Fixing the 3rd behaviour in this patch.

[1] https://lore.kernel.org/all/20260714173010.615682-1-shivangu@linux.ibm.com/
--
Changelog:
v3: Removing the fake entries population. Kernel handles this case by default.

v2: https://lore.kernel.org/qemu-devel/20260429065127.366813-1-shivangu@linux.ibm.com/
--
Shivang Upadhyay (1):
  hw/ppc/fadump: report CPU_STATE_DATA dumped_bytes as source_len

 hw/ppc/spapr_fadump.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

-- 
2.54.0


