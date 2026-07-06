Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2FC22C43458
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jul 2026 16:56:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wgmau-0006M2-4H; Mon, 06 Jul 2026 12:54:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>) id 1wgmas-0006Li-Uz
 for qemu-devel@nongnu.org; Mon, 06 Jul 2026 12:54:55 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>) id 1wgmar-0002yj-6X
 for qemu-devel@nongnu.org; Mon, 06 Jul 2026 12:54:54 -0400
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 666FIJQ14049902; Mon, 6 Jul 2026 16:54:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=pp1; bh=fsAfS5KCS6YiRYvXpr+9OUBQCIBFdIeXPEjaudfQO
 5o=; b=bq//OG5U96ARMv7n56IEhbckjX7LYLob66qSsaPVQqq0d65ycIGCkD9E3
 3bYXy3XmVA82zHE3GalNcQ7EPpQiuxUQozU4fJN7yZ/7fCtrNVO2GXgwfmnz6t3I
 Jz7uzyTKHb1ssK/jhtHypxgQcVmS4MlawQMJJRiiHx4STu0MnjUULSUIaxJ263zk
 lNRcOGgsIeFc/ayPGE2+6z6PuY1c07y/YyPuozIaZuL4TLRO1G7QAPC0dOF7t4sU
 Xi349VvU7CNNTnUB5FHAsuPB+ub567u+XdM8zwIXhEm5zYGR7uZQZkVKF4G21py5
 sEzh/F49CUAerpoLylgNfHgjFZyuQ==
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4f6stsk088-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 06 Jul 2026 16:54:51 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 666Gne32001794;
 Mon, 6 Jul 2026 16:54:50 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4f7dgjxf1x-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 06 Jul 2026 16:54:50 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com
 [10.20.54.101])
 by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 666Gsm8i54133082
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 6 Jul 2026 16:54:48 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 84EB620043;
 Mon,  6 Jul 2026 16:54:48 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 3A97220040;
 Mon,  6 Jul 2026 16:54:48 +0000 (GMT)
Received: from heavy.ibm.com (unknown [9.111.23.52])
 by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Mon,  6 Jul 2026 16:54:48 +0000 (GMT)
From: Ilya Leoshkevich <iii@linux.ibm.com>
To: Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, Ilya Leoshkevich <iii@linux.ibm.com>
Subject: [PATCH v2 0/3] accel/tcg: Make PageFlagsNodes' start and last
 immutable
Date: Mon,  6 Jul 2026 18:51:22 +0200
Message-ID: <20260706165445.57418-1-iii@linux.ibm.com>
X-Mailer: git-send-email 2.54.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 2rEftGYxPwV48-EXcvkuirPLwI2wq9Tg
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA2MDE3MCBTYWx0ZWRfX8/qlo+oFdtub
 JMpHC9vyqmvSeH0F9Mi2AnDFwNjnPDu7GnF8q7JQP6gWQFEndyLyR5Px4u+zVmOv3/E1Q3ASY7h
 N4tBtOc1RjcMWViNUMIFSue/Qd2h318=
X-Authority-Analysis: v=2.4 cv=DKW/JSNb c=1 sm=1 tr=0 ts=6a4bdddb cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=RzCfie-kr_QcCd8fBx8p:22 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8
 a=9CNncO525tPuSrLx_s4A:9
X-Proofpoint-GUID: 2rEftGYxPwV48-EXcvkuirPLwI2wq9Tg
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA2MDE3MCBTYWx0ZWRfXzf76B7g3IDHn
 IMjNCfxqT19LcLE5NIMMynZXTopSh+fzj5KpmMXJYVXltfDqMK9M0pZgQDif+GUcFLyPxkdVC3Y
 QJb9ndMTBpyovGW53ZKgImnQVAfVjbGGzszGJ7M7YyKSZq9rB76U3tg+RrRnMFuRS7/MP3txKVS
 D0B3VP1Q0hzbbIQ8GvWEBmLZeUAdcIkU4yP1zub7DtSIwrlYZYkekrd+b2h9xMsBog5RvdC1vnX
 X2xrRj50OVjMxxHK6uitD/re0d5bQ38Azsqo29HDPEfhvXyvCE9mvZBnvEpu7Pd6jFzlDtl+qPQ
 24tUQ16kz+GMOrCP0/fZS92TYNLijyQWKaco0fBugmC8ntQF9+BNJ2gCEQJeNAlYT1mV2vWUhGX
 nxxeU4ZO8DbjLrZ9n4ObWPdDfZmNUR7g9TJuLKzDqL6gSJnJQj7QMVAGzZaewlBE70CDEE2naWN
 RVmO7sEkrRBsQdnZ62g==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-06_02,2026-07-06_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 bulkscore=0 clxscore=1015 phishscore=0 impostorscore=0
 priorityscore=1501 adultscore=0 lowpriorityscore=0 suspectscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607060170
Received-SPF: pass client-ip=148.163.158.5; envelope-from=iii@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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

v1: https://lore.kernel.org/qemu-devel/20260706110330.4150026-1-iii@linux.ibm.com/T/#t
v1 -> v2: Use a new approach: immutability.

Hi,

This series fixes the ancient vma-pthread test failures. It was sparked
by a bug report by wasmtime project. The patch seems to fix all issues -
I could run vma-pthread for an hour, while previously it would fail
reliably in under a minute.

Best regards,
Ilya


Ilya Leoshkevich (3):
  accel/tcg: Make PageFlagsNodes' start and last immutable
  tests/tcg/multiarch: Improve mutator randomness
  Revert "tests/tcg: skip the vma-pthread test on CI"

 accel/tcg/user-exec.c               | 37 ++++++++++++++++-------------
 tests/tcg/multiarch/Makefile.target |  9 -------
 tests/tcg/multiarch/vma-pthread.c   |  3 ++-
 3 files changed, 23 insertions(+), 26 deletions(-)

-- 
2.54.0


