Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D36A1C531C9
	for <qemu-devel@archiver.kernel.org>; Sat, 25 Jul 2026 12:57:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wnbwB-0006bn-6h; Sat, 25 Jul 2026 08:57:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farman@linux.ibm.com>)
 id 1wnbw6-0006aK-Ez; Sat, 25 Jul 2026 08:57:02 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farman@linux.ibm.com>)
 id 1wnbw3-0005ZC-R6; Sat, 25 Jul 2026 08:57:02 -0400
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66PBA58T508629; Sat, 25 Jul 2026 12:56:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=pp1; bh=9KPy9EfBxNR34+ruxRuXz7KsalU/ZtFe3CEorS4mD
 IU=; b=qlTep1iObNVQmniagepa1+Tj0+3uqxuuQSvz76yHEZRag2smzWF4jIbyv
 5zN/J6fpzkgG40Bk5ZMasvvFpGrijE7Lw7OwyJvk4Wp52H6dJyT48MgAgUcujUnG
 4V4ziIqAigGXy+u4xXcWbqfYmwDHza6jV+nqXUQcaXNd2H7aAnTQHK8zpGPBQqj9
 C5bigiM7vzctnaEEM8WdeHeZT6J+C/k/wDSF9YxHxnI+KA8bEacPy3Z2bu9Drxh/
 LwOo/f+hxdPphh+djgMLtfTDSvvDyRzW4N+r3ChZR5+oTtjpgBJwhnRZs/Xk5dwT
 rEdqJ2mUbL0nKPEt4xTcovt4V9qUA==
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fmv0x8842-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Sat, 25 Jul 2026 12:56:57 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66PCuFZk028235;
 Sat, 25 Jul 2026 12:56:56 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fmn2c1an2-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Sat, 25 Jul 2026 12:56:56 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com
 [10.20.54.100])
 by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 66PCuq7h42271210
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Sat, 25 Jul 2026 12:56:52 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 94766200E4;
 Sat, 25 Jul 2026 12:56:52 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 7563F200E1;
 Sat, 25 Jul 2026 12:56:52 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
 by smtpav01.fra02v.mail.ibm.com (Postfix) with SMTP;
 Sat, 25 Jul 2026 12:56:52 +0000 (GMT)
Received: by tuxmaker.boeblingen.de.ibm.com (Postfix, from userid 4958)
 id 5A11416267D; Sat, 25 Jul 2026 14:56:52 +0200 (CEST)
From: Eric Farman <farman@linux.ibm.com>
To: Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org,
 Matthew Rosato <mjrosato@linux.ibm.com>, Eric Farman <farman@linux.ibm.com>
Subject: [PATCH v1 0/3] io_tests fuse fixes
Date: Sat, 25 Jul 2026 14:56:48 +0200
Message-ID: <20260725125651.3896151-1-farman@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 0cjmQq4DW-J9uT6POW65dJynN6aqkCgr
X-Proofpoint-ORIG-GUID: 0cjmQq4DW-J9uT6POW65dJynN6aqkCgr
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI1MDEyMCBTYWx0ZWRfX6imRwW05VBLZ
 INSXHLxco9kHdf+LuT0NdZ5JR14SJrGrQrwPpib8FLJaSEPWbYrODw5/e/r2ye54CIyzBf1mD+u
 LnmMKZvRVIXyf112o2Nl9YbqXNNoM18=
X-Authority-Analysis: v=2.4 cv=dYuwG3Xe c=1 sm=1 tr=0 ts=6a64b29a cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=U7nrCbtTmkRpXpFmAIza:22 a=WCoifLCfz-S1XxkA7B8A:9 a=zZCYzV9kfG8A:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI1MDEyMCBTYWx0ZWRfX1zW1OUzTzxCo
 CnxDGG0SXyNS0hY9p8BsP1/AJIfoNztBSBl5yG3vp3dHxjQ1nBevn4wF4JlxuJGMoIl7/FtWxg5
 KyB3ePFPDiBG/2ErLOZWEhmruMhAvsTmtLFlotg3qIv0WNn/SDhiDTwyJZr53HniY0wInfFqt7I
 Gd2OufMCD6KfiuUePNhBdIZzE1QD2klS+7MXjB7dtqumr1fjk9QVj4INBBu+5f51yVJ6pjyj004
 1MloWSzYKqQDXAW7FwJ4C4mSQEMdwNxcRQq4+FkrMKTTAxKIXQzZWiPHns7aQeAwN2gSuDEHiTS
 fyI/PjKQzj0ta1lR+ijLtqCqMJ70+Sw2imS6HnwUc++wdbc2FMM3UAAPV9JvdFmB6ouKg8XOuta
 W0ioki5ghtuUn3vesjtvA9xDvjGZ6ZYZepOiKzkDGbRGFfUjSruv5zF4Hw4MgHxYvEDZps659UP
 kp6aKg2qraovXXe7sGA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-25_03,2026-07-24_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 clxscore=1015 phishscore=0 malwarescore=0
 spamscore=0 lowpriorityscore=0 bulkscore=0 suspectscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607250120
Received-SPF: pass client-ip=148.163.156.1; envelope-from=farman@linux.ibm.com;
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

Hi,

The following are three small fixes against some of the qemu iotests
to avoid some errors that should prevent the tests from running in
the first place. We noticed these on an s390 host, but I don't
believe that to be relevant. My hunch is the messages are slightly
different based on distro, because the tests (correctly) skip for
me running Fedora on s390 or x86_64 while they fail under Ubuntu 26.04.

Eric Farman (3):
  iotests/108: skip test if cannot access /dev/fuse
  iotests/file-io-error: complete permission denied check
  iotests/fuse-mmap-shared: complete permission denied check

 tests/qemu-iotests/108                    | 2 +-
 tests/qemu-iotests/tests/file-io-error    | 3 +++
 tests/qemu-iotests/tests/fuse-mmap-shared | 7 +++++--
 3 files changed, 9 insertions(+), 3 deletions(-)

--=20
2.53.0


