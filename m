Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9683BC9830E
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Sep 2026 19:45:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xABqI-0005NI-LO; Fri, 25 Sep 2026 15:44:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farman@linux.ibm.com>)
 id 1xABqG-0005Li-K2; Fri, 25 Sep 2026 15:44:20 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farman@linux.ibm.com>)
 id 1xABqE-0002Mx-78; Fri, 25 Sep 2026 15:44:20 -0400
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68PJ5iKD1899557; Fri, 25 Sep 2026 19:44:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=pp1; bh=D+1vvzjseyd9Xs06cqtpeDrUjyUfnUVfzcc0GVWFy
 Ok=; b=WhjDKjTrN0WzlE1gU0BCVgwR5uxXi6aZTnR5c0S1Bl+hLebZTGyQwGB+e
 7+FNzxE9g2p6vrlkl8g16dNZKf7f8fg2zcGSqR1Tv/8npupXbe0Cyn6ZBoM4dmFR
 9ssQMwzAWU6BU9Zw5myRCHUCejsQYDpSrzJBiz54W/MyTXaYf8jr8Sp9bVOwaPxI
 7uo6a5U5PI5aB7k6mm0h1JQwaUFzn5kwVgoBx9jJhD4060vlwuogEDBWOSdTTxTe
 KYnEayXvcXapiDVNx+M2h2K0oJ9HfaHZVYKo3Vcug/ppup03LzrqZSKC8lzkJfpo
 Av+WhanQdYfojZbFGocx+1v19mXrg==
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gskg312rv-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Fri, 25 Sep 2026 19:44:15 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id
 68PJM7HF214526; Fri, 25 Sep 2026 19:44:14 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4gwy27825b-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 25 Sep 2026 19:44:14 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com
 [10.20.54.106])
 by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 68PJiBfN26083832
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 25 Sep 2026 19:44:11 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 010B220043;
 Fri, 25 Sep 2026 19:44:11 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id D827A20040;
 Fri, 25 Sep 2026 19:44:10 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
 by smtpav07.fra02v.mail.ibm.com (Postfix) with SMTP;
 Fri, 25 Sep 2026 19:44:10 +0000 (GMT)
Received: by tuxmaker.boeblingen.de.ibm.com (Postfix, from userid 4958)
 id C0768161BE1; Fri, 25 Sep 2026 21:44:10 +0200 (CEST)
From: Eric Farman <farman@linux.ibm.com>
To: Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org,
 Matthew Rosato <mjrosato@linux.ibm.com>, eblake@redhat.com,
 Eric Farman <farman@linux.ibm.com>
Subject: [PATCH v4 0/5] iotests fixes
Date: Fri, 25 Sep 2026 21:44:04 +0200
Message-ID: <20260925194409.716498-1-farman@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: YtzJ2owIkN0Wj6MpuTL2tmTvB-395C8_
X-Authority-Analysis: v=2.4 cv=I43w19gg c=1 sm=1 tr=0 ts=6ab6cf0f cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8
 a=o2q82kuwiiqPszx3tzsA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI1MDA3OCBTYWx0ZWRfX0oB3/Nww4Oec
 7c4PYahaqRFqB3otimPrtFLUehF1R7WDjnSPUbBBybulAvCA8MoFwSLYXfx1YQL2whb2dI+/Sk0
 yTYYAjflyxUr3NbOgHLtzg//JWIFkKmKJS6NxZW8x2tparwv9zyGUX1rI+MGsY1/Z2vLZzrEebK
 nrFyQ0BU7GyFuIzz4UdFZiuOOXJDuzXvCElCsi88uffWfSdaFzR5XKyPBgF+xaR/PyfHNSex/hU
 aPrQeIFH+90ML0xT8FfZqALqnP2Hen6/1cUZI45e5MnoVRi4HhyvgVApgoNVhiQn39OTYaFYEdp
 N4U5Jxhnd7PGbjdPb9B1aXhz8kx9gj29Cpfi+5EQdOEB2mMUlfwitxSBVz+fPRQrh5Db/jlCRh/
 mATXwqMYz1CxXqgPg/5SR1HK0hgCyycle4e5cflG/4UKgd7Kr6IV8KE3Rs16MhUwW0LHfbob+dI
 6bH/XweEiUnkVNoclmQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI1MDA3OCBTYWx0ZWRfXyDz9eRfp3gqT
 wwD6XctFJcqwaq2hehHE8WAO6+yvZTgpDiCBIBPXCecGdaH6/qYQs25Bc+QZ1NCMxq36SLM90a1
 FZQL2CHh3sYpp8dOAgXeyq4cct1ySgY=
X-Proofpoint-GUID: YtzJ2owIkN0Wj6MpuTL2tmTvB-395C8_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-25_04,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 clxscore=1015 adultscore=0 suspectscore=0 impostorscore=0
 lowpriorityscore=0 bulkscore=0 phishscore=0 priorityscore=1501 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609250078
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

Hi Kevin, Hanna,

Here is a new version of iotests fixes from our s390x systems.
They aren't related, just came up walking through the failures.

I saw you asked Eric Blake about the nbd-in-qcow2-chain patch.
I left it as-is, but I am fine with skipping it if that's easier.

I added a new patch at the end of this series, which skips the last remai=
ning
failure I can create out-of-the-box on s390. I had hoped that I could get
that one to work, but it doesn't appear to be trivial.

Regardless, I now get a clean run on an s390 host:

  Not run: 045 059 064 070 075 076 077 078 081 083 084 088 092 093 094 10=
1 106 108 109 113 116 118 119 123 128 131 135 136 146 147 148 149 160 162=
 171 172 173 175 181 185 186 192 201 205 207 210 211 212 213 221 225 231 =
233 237 239 241 253 259 266 282 288 294 296 301 308 block-status-cache fi=
le-io-error fuse-allow-other fuse-mmap-shared fuse-truncate iothreads-nbd=
-export iov-padding loop-create-file luks-detached-header migration-permi=
ssions mirror-top-perms nbd-commands nbd-multiconn nbd-tls-iothread paral=
lels-bitmap parallels-checks resize-below-raw vvfat write-zeroes-unmap zo=
ned
  Some cases not run in: /home/farman/git/qemu/tests/qemu-iotests/151 /ho=
me/farman/git/qemu/tests/qemu-iotests/297
  Passed all 261 iotests

I look forward to your feedback...

v1: https://lore.kernel.org/r/20260725125651.3896151-1-farman@linux.ibm.c=
om/
v2: https://lore.kernel.org/r/20260728192644.2879028-1-farman@linux.ibm.c=
om/
v3: https://lore.kernel.org/r/20260813183740.3503107-1-farman@linux.ibm.c=
om/
v3->v4:
 - [KW] Rework patch 4 to use --daemonize and _notrun_on_fuse_error()
 - [EF] Add patch 5 to skip iothread-nbd-export on s390

Eric Farman (5):
  iotests/nbd-in-qcow2-chain: use default machine
  iotests/nbd-tls-iothread: skip on non-x86 hardware
  iotests/fuse-truncate: skip if FUSE is not usable
  iotests/108: skip if fuse is unusable
  iotests/iothreads-nbd-export: Skip on s390

 tests/qemu-iotests/108                        | 20 +++++++++++++++++++
 tests/qemu-iotests/tests/fuse-truncate        |  9 ++++++---
 tests/qemu-iotests/tests/iothreads-nbd-export |  5 +++++
 tests/qemu-iotests/tests/nbd-in-qcow2-chain   |  2 +-
 tests/qemu-iotests/tests/nbd-tls-iothread     |  4 ++++
 5 files changed, 36 insertions(+), 4 deletions(-)

--=20
2.53.0


