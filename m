Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1603FCD4F54
	for <qemu-devel@archiver.kernel.org>; Wed, 20 May 2026 07:21:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wPbF2-0006Fj-Pg; Wed, 20 May 2026 03:21:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <freude@linux.ibm.com>)
 id 1wPbEq-0006DC-RW; Wed, 20 May 2026 03:21:08 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <freude@linux.ibm.com>)
 id 1wPbEn-0002Sw-Tg; Wed, 20 May 2026 03:21:08 -0400
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64K0FQVv3229693; Wed, 20 May 2026 07:20:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=pp1; bh=CWHW4G+bJiTkGDASW5s9yGbHzHVPCvGWmzAONejON
 rw=; b=oLogdzRMZChaDFUeC0+9Dc+2e1+VbqvJhVl5QhDdERPKZJ6C1Rtse5W2l
 CJ7DRO1WgCqbi2K0bbgdU/hKchDCy4fCRDfouPG0yUUaxgVJ3jJYJuXhkFkY2qo1
 WL0VOZz55KFMrfrxYs00Mkwzrd+Quhc7w6l1OK/ozL5QHtjQowYmZOk0upzTTxQL
 UUnaEyU3XPYWEV2kPIZnaxMEofhVtVBjUJtSfKKedTRf/P3EmVeuCGe6t7J1xnqn
 XrcQsq+psOFitWFqI0hoVIjuUKBgP/2CYITbTJ8/8Q7XVgAKAs1O+Bp4ugO0U0WH
 tfj7sP11/zGNgTStfOagDDYNW8/Pg==
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4e6h750vkc-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 20 May 2026 07:20:59 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 64K7965q029961;
 Wed, 20 May 2026 07:20:58 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4e754ge2t4-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 20 May 2026 07:20:58 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com
 [10.20.54.104])
 by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 64K7Kt9V53477838
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 20 May 2026 07:20:55 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 0390A20043;
 Wed, 20 May 2026 07:20:55 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id D731B20040;
 Wed, 20 May 2026 07:20:54 +0000 (GMT)
Received: from funtu2.fritz.box (unknown [9.111.209.15])
 by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Wed, 20 May 2026 07:20:54 +0000 (GMT)
From: Harald Freudenberger <freude@linux.ibm.com>
To: richard.henderson@linaro.org, iii@linux.ibm.com, david@kernel.org,
 thuth@redhat.com
Cc: qemu-s390x@nongnu.org, qemu-devel@nongnu.org, dengler@linux.ibm.com,
 borntraeger@linux.ibm.com
Subject: [PATCH v5 00/15] target/s390x: Extend qemu CPACF support
Date: Wed, 20 May 2026 09:20:39 +0200
Message-ID: <20260520072054.293306-1-freude@linux.ibm.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=ffCdDUQF c=1 sm=1 tr=0 ts=6a0d60db cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=U7nrCbtTmkRpXpFmAIza:22 a=aEsR2f9HNtEaKEkkzVYA:9
X-Proofpoint-ORIG-GUID: 6tEmlsjZBJcar1agVR0J9cBgtzyUIGS9
X-Proofpoint-GUID: 6tEmlsjZBJcar1agVR0J9cBgtzyUIGS9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTIwMDA2NyBTYWx0ZWRfXxdCgytV9Y8sh
 JjkxMAJ6XgCFu6Doe6LTHJ6hdSKvFgyD/B6Y8e11oiSyWHXkmUYrtUTT9QACZSOR0A/XRbh4OSj
 BE1IXhHSZHDKH2StsdK6GwvbCS+df+NL+DsheCkVN0ETUrtPJBIbr3mqjshzvyr7DuYUmbJ98ho
 KVh5DJDZ952SzeHnzqX4WgvFw1tuEexzJY7dRD/OnB9y4xoKqoys0ks4vbcfyT0cuKSS8CaCL0R
 K+wlEh4XSSyfhzs3lyJrHz9cc2u8viemDjlPihcnvKtgjD2ePTQv+gRsM5v/U4zglvyLIk6zRCz
 Ck9P8YT6u9503gyrXo/fEcO6jQ7XhDVhuMiWas89/x3bBnIun35K0wYuBzq5Qcj8U/EdyPChjxf
 pGYXsV4BkBqVnPD+y+wk7PM9VhzJyJaw/RtCid4DjNzI169B/72V1KqQxgIK70uAjlqYMfxKWoL
 cYY/yHjmlE8TdYuyMhA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-20_01,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 phishscore=0 suspectscore=0 adultscore=0
 clxscore=1011 impostorscore=0 lowpriorityscore=0 bulkscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605200067
Received-SPF: pass client-ip=148.163.156.1; envelope-from=freude@linux.ibm.com;
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

This patch series extends the s390 qemu CPACF support to be able to
run a subset of the CPACF instruction cross platform. There have been
requests on the kernel crypto mailing list about a way to test
s390 specific crypto implementations. For example a way to test
s390 CPACF exploitation code like the s390_aes.ko kernel module.

So here now is a set of patches verified on x86 and s390 which
over (slow but working) support for a subset of the subfunctions of
some of the CPACF instructions.

Test: As this series is more or less complete, a full blown linux
can be run and the 'usual' in-kernel crpyto modules will be
automatically loaded which run a bunch of test cases. So there
is now support for these kernel modules:
* sha256_s390x (autoloaded, sha256)
* sha512_s390x (autoloaded, sha512)
* aes_s390x (autoloaded, clear key aes ecb, cbc, ctr, xts)
* pkey_pckmo (autoloaded, derive AES protected key from clear key)
* paes_s390x (not autoloaded, protected key aes ecb, cbc, ctr, xts)
All these modules run selftests if configured by the kernel (which is
enabled by default). Failures are reported via syslog. Additionally
the aes testcases from libica can be run either inside such an qemu
environment or with a static build executed with the qemu tcg
application qemu-s390x --cpu max <static-build-libica-test>.

Changelog:
v1: Initial version with
    - Related code restructured
    - Support KIMD SHA512 and thus SHA256
    - Support KMC AES-128, AES-192 and AES-256 and thus have basic AES
      support (ECB mode) enabled.
    - Support PCC Compute-XTS-Parameter-AES-128 and
      Compute-XTS-Parameter-AES-256 but only for block sequence number
      0. This is a requirement for the next step:
    - Support KM XTS-AES-128 and KM XTS-AES-256. Together with the
      minimal PCC support this enables AES-XTS CPACF acceleration.
v2: - Basic PCKMO support to be able to 'derive' an AES protected key
      from clear key. See header details.
    - Support protected key AES-ECB.
    - Support protected key AES-CBC.
    - Minimal protected key AES-XTS support for CPACF PCC.
    - Support protected key AES-XTS.
    - Support AES-CTR.
    - Support protected key AES-CTR.
v3: - Reordered patches as suggested by Finn.
    - One small bug fix in CPACF_aes.c related to address translation.
v4: - Rename of the parameters based on feedback from Janosch to
      make clear these are registers or ptrs to registers.
      Added Tested by from Holger. Fixed typo "face" -> "fake".
v5: - Add documentation file docs/system/s390x/cpacf.rst which
      describes the state of the CPACF instructions and which
      functions are covered when this series is applied.
      First version sent to public mailing list qemu-s390x.

Harald Freudenberger (15):
  target/s390x: Rework s390 cpacf implementations
  target/s390x: Move cpacf sha512 code into a new file
  target/s390x: Support cpacf sha256
  target/s390x: Support AES ECB for cpacf km instruction
  target/s390x: Support AES CBC for cpacf kmc instruction
  target/s390x: Support AES CTR for cpacf kmctr instruction
  target/s390x: Minimal AES XTS support for cpacf pcc instruction
  target/s390x: Support AES XTS for cpacf km instruction
  target/s390x: Support pckmo encrypt AES subfunctions
  target/s390x: Support protected key AES ECB for cpacf km instruction
  target/s390x: Support protected key AES CBC for cpacf kmc instruction
  target/s390x: Support protected key AES CTR for cpacf kmctr
    instruction
  target/s390x: Minimal protected key AES XTS support for cpacf pcc
    instruction
  target/s390x: Support protected key AES XTS for cpacf km instruction
  docs/s390: Document CPACF instructions support

 docs/system/s390x/cpacf.rst      | 109 ++++
 target/s390x/gen-features.c      |  31 +
 target/s390x/tcg/cpacf.h         |  59 ++
 target/s390x/tcg/cpacf_aes.c     | 992 +++++++++++++++++++++++++++++++
 target/s390x/tcg/cpacf_sha256.c  | 229 +++++++
 target/s390x/tcg/cpacf_sha512.c  | 241 ++++++++
 target/s390x/tcg/crypto_helper.c | 416 +++++++------
 target/s390x/tcg/insn-data.h.inc |   1 +
 target/s390x/tcg/meson.build     |   3 +
 target/s390x/tcg/translate.c     |   2 +
 10 files changed, 1869 insertions(+), 214 deletions(-)
 create mode 100644 docs/system/s390x/cpacf.rst
 create mode 100644 target/s390x/tcg/cpacf.h
 create mode 100644 target/s390x/tcg/cpacf_aes.c
 create mode 100644 target/s390x/tcg/cpacf_sha256.c
 create mode 100644 target/s390x/tcg/cpacf_sha512.c


base-commit: 9c23f2a7b0b45277693a14074b1aaa827eecdb92
--
2.43.0


