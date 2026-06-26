Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 357A5CDE008
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jun 2026 11:23:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wd4e8-0007qC-PG; Fri, 26 Jun 2026 07:22:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shivangu@linux.ibm.com>)
 id 1wd4e5-0007nT-T9; Fri, 26 Jun 2026 07:22:53 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shivangu@linux.ibm.com>)
 id 1wd4e4-0008GB-5S; Fri, 26 Jun 2026 07:22:53 -0400
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65QAIQHG2761136; Fri, 26 Jun 2026 11:22:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=NFu2Egy5Ekq+ziIOf
 tuPJKGbaXLtFWCIrfdJ/xHPMSI=; b=M2LupXjVfXvyR7AMuxSiWBdvDkzFsgO9O
 GYpO5wvB2Lntr5a0wnpk5kqCnWvv793ft8PABnPNLKdlaNMm0VrwD0km4xqy4mtt
 p60XlGYLXUGPZteTFFRHbZxoUmN4fD7j+P5+LTUD5bS44zx23WgE1tuCgjXDdWnZ
 9YRLBYMlIn3yYhMX/r8IUb3pQX9UGgdt6Zneq9l/H4oV3zZiCdMCpSDtxL5Q3NNN
 cAxBKNBAq4QUGduzEzdpsy/7Lp69PecODoHbBJN42kLwiwjcx5Kn2H6aaNro/NWU
 gt2ZIR3djg9vY+Whd3RdBQ9Gmi7xWsUBDzOhRtcT8PaEuHD5vaOug==
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4ewjc3xt3n-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 26 Jun 2026 11:22:48 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 65QBJhem029462;
 Fri, 26 Jun 2026 11:22:47 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4ex56qu1wt-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 26 Jun 2026 11:22:47 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com
 [10.20.54.105])
 by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 65QBMh3v29885100
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 26 Jun 2026 11:22:43 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 4694A2004D;
 Fri, 26 Jun 2026 11:22:43 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 8A76A2004B;
 Fri, 26 Jun 2026 11:22:41 +0000 (GMT)
Received: from shivang.bl1-in.ibm.com (unknown [9.123.12.247])
 by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Fri, 26 Jun 2026 11:22:41 +0000 (GMT)
From: Shivang Upadhyay <shivangu@linux.ibm.com>
To: shivangu@linux.ibm.com
Cc: adityag@linux.ibm.com, harshpb@linux.ibm.com, milesg@linux.ibm.com,
 npiggin@gmail.com, qemu-devel@nongnu.org, qemu-ppc@nongnu.org
Subject: [PATCH v2 0/2] ppc/pnv: fixing external dtb
Date: Fri, 26 Jun 2026 16:52:37 +0530
Message-ID: <20260626112239.177191-1-shivangu@linux.ibm.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260623063156.1110370-1-shivangu@linux.ibm.com>
References: <20260623063156.1110370-1-shivangu@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=X4Ni7mTe c=1 sm=1 tr=0 ts=6a3e6108 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8
 a=HK4ePdA0MMetCi7OCQ0A:9
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjI2MDA5MiBTYWx0ZWRfXwk4NeSMxEnaY
 s+x+qugxqQdhy+F5cPc2U35ollQEUdjlWx17j4fOcZN7/MAgstiH2btcIMOvNH2kJFWeYCKEVp6
 51qGs11KpVNd2M5sDAiANAiHgbFxkYk=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjI2MDA5MiBTYWx0ZWRfXzRrASoB24caR
 dE+U2XoaQFQRtuu9bsvD1VUATCyaWmA0AGRNpxvBs9jzmGFfmaLtsVBl2/EzXVhfi+2ga8GV/ks
 MJtYMzZDl9UHq4WtymW8Y4NjXW8SVjfnZK2b6a8Fs/sb2Y4zGdl7DdB0HqKeIgFWa92zwhNF7Z5
 eNT4alUVwwqv8zum1gUhER5ILUR5gfL0XOsBg4LpgowLhqzLK1gBPpXgpzNyNrNt4TMCmcls1Q8
 FxcREMpJ0yNPd0OVlKu6k66fpFI4FnZdBwR1f8woEqoUeaDZRhzd21c+77AYMfUPH3W2HTec9nH
 eRESnm/YQXrqE6GgiIImWjxNUzdHwpx5TEAcntH11Uz0mVZ727+Bq1UE97iW2dCP3DSzKQg+QAp
 YsqILqAryY0cbpRLGxW519IDASL8at7BgaSMR/0bTntKFo0eM2neFwPn/m69hOPONlFDzf+YSlx
 XN3R4pxFRfXp/pB/KHA==
X-Proofpoint-ORIG-GUID: V8w_9qKb4YFNJ50MfIcrCaUPRU6MTx5M
X-Proofpoint-GUID: E1fdBxM1vY_DtKNRkGPIfHLyRmrdKh63
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-26_03,2026-06-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 bulkscore=0 suspectscore=0 spamscore=0 priorityscore=1501
 impostorscore=0 malwarescore=0 clxscore=1015 adultscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606260092
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

Currently powerpc pnv machines doesnt respect `-dtb`
argument passed from outside. During cpu start content of
machine->fdt is overwritten by `pnv_dt_create`.

This was previously found and fixed, during the discussion
for dumpdtb issue [1]. But reintroduced in MPIPL support
[2]. Saddly it skipped in the review phase [3].

Adding a functional test for checking the external dtb case
in powernv11.

[1] https://lore.kernel.org/all/20260323231612.GA2637687@ax162/
[2] https://lore.kernel.org/qemu-devel/20260310124619.3909045-8-adityag@linux.ibm.com/
[3] https://lore.kernel.org/qemu-devel/abAmBV7g_bGNw0Ax@shivang.upadyay/

Changelog
* V1: https://lore.kernel.org/all/20260623063156.1110370-1-shivangu@linux.ibm.com/
  - change dtb from power10 to power11
  - refactored pnv_reset code to not `load_device_tree` on each iteration.
  - added commit message body.

Shivang Upadhyay (2):
  ppc/pnv: avoid regenerating DTB if external DTB is present
  ppc/pnv: add test to verify external DTB is honored

 hw/ppc/pnv.c                           | 10 +++++++---
 tests/functional/ppc64/test_powernv.py | 19 +++++++++++++++++++
 2 files changed, 26 insertions(+), 3 deletions(-)

-- 
2.54.0


