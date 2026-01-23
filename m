Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08BC5D7237B
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Jan 2026 11:47:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vjFag-0005ge-Q3; Fri, 23 Jan 2026 06:44:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <freude@linux.ibm.com>)
 id 1vjFZS-00050Q-0s; Fri, 23 Jan 2026 06:43:28 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <freude@linux.ibm.com>)
 id 1vjFZN-0006xq-UU; Fri, 23 Jan 2026 06:43:21 -0500
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 60N62owM006505;
 Fri, 23 Jan 2026 11:43:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=pp1; bh=HswyrgQScDyv5GcXczOqmrQbptGtKzfrWrqCEGup+
 Qg=; b=hLRKyTxrBFWoSRHWdjfdYu2y8EillmVIsIs0gZqS4OdtY+wO0OnP6C+Q6
 9dDy2YuJnzyh3lY8TL7A0bxVqCazeiw9LNV7XXN0yK/sB59HZZBI6FXIfVUPcrlf
 xTTiX5KfeRpLEIjkl+boNvxaOsJnRrdsItbLItte8r3q2eiwQ1VSo6RZwvJcawaW
 PwJRLw4MicshXNJKhjSD2kLTCpbphbuAQ9n5/njx0ROcozou4EiBc5/x1Dz23KiY
 e6Td+B7Rr0+cypUQsd2vAu5yZ1Y38rlpBsJ718wpKRmsIg8+/2VmeCt7Ct49keDP
 tt9H59iTZMnSXwYVPp+E4s5Z54sFA==
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4bus1puxvh-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 23 Jan 2026 11:43:14 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 60NBQnlm009291;
 Fri, 23 Jan 2026 11:43:13 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4brp8krrjh-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 23 Jan 2026 11:43:12 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com
 [10.20.54.102])
 by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 60NBh8Br55968190
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 23 Jan 2026 11:43:08 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id AFD8B2004B;
 Fri, 23 Jan 2026 11:43:08 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 97C4720043;
 Fri, 23 Jan 2026 11:43:08 +0000 (GMT)
Received: from funtu2.ibm.com (unknown [9.111.163.22])
 by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Fri, 23 Jan 2026 11:43:08 +0000 (GMT)
From: Harald Freudenberger <freude@linux.ibm.com>
To: pbonzini@redhat.com
Cc: qemu-s390x@nongnu.org, qemu-devel@nongnu.org, borntraeger@linux.ibm.com,
 frankja@linux.ibm.com
Subject: [PATCH v3 00/14] s390: Extend qemu cpacf support
Date: Fri, 23 Jan 2026 12:42:54 +0100
Message-ID: <20260123114308.19401-1-freude@linux.ibm.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: vUOBjwumdT6_JxdHRRqirUmtj6Az8PDZ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTIzMDA5MiBTYWx0ZWRfX0jm2rAAvVd5s
 bgw/iKLwlMFIiCYzj7usn4t+H05OVU4SKFt12XgET6JH1pFtdNaxM2WhyGUDJVktnzAJ0Qg2Qyk
 1WhcHgGh9WFVHUSRLJ8rgDWlqD1xvHdjgUE7IfcA9DUh7FFTi/PIuypoU9eXAVbvvQLGLsk9yyq
 mP88x+FUYP1lb0cZ0b/KSLfl6algCa+KcoxDh6911SoLUbYUUGF8ntCdFr2iuUinT3wcmFE0znX
 NHNF7wjbvUKUMxLWSfE8FEG7jF8tuPAFE/kzvRQwKUtJ6pKa5kC/I0lH2UL8Nxp9PLH/vSG9Sa+
 R/JSfho53nZPApX8R7O2n7EbsGGGB5H0Y+gk3g+7q2PZa1UgkYaTuFpSCd9Mwranm9Um9f+PDDz
 +RbHi5rYV8kY26GXsZDH5hRyALu3J0EhTaPCNZqaW58U44H4AkY1F1DR0XEeeL8ZDnMISoOGQVR
 Gsfc2ylqXa9lo/WQKeQ==
X-Proofpoint-GUID: vUOBjwumdT6_JxdHRRqirUmtj6Az8PDZ
X-Authority-Analysis: v=2.4 cv=GY8aXAXL c=1 sm=1 tr=0 ts=69735ed2 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=vUbySO9Y5rIA:10 a=VkNPw1HP01LnGYTKEx00:22 a=-FayQTajyVMizGJ5Pn4A:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.20,FMLib:17.12.100.49
 definitions=2026-01-23_02,2026-01-22_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 impostorscore=0 phishscore=0 lowpriorityscore=0 spamscore=0
 malwarescore=0 priorityscore=1501 bulkscore=0 adultscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2601150000 definitions=main-2601230092
Received-SPF: pass client-ip=148.163.158.5; envelope-from=freude@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

This patch series extends the s390 qemu cpacf support to be able to
run a subset of the cpacf instruction cross platform. Eric Biggers and
others have asked to be able to verify our s390 cpacf exploitation
code. So here now is a set of patches verified on x86 and s390 which
over (slow but working) support for a subset of the subfunctions of
some of the cpacf instructions.

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
    - Minimal protected key AES-XTS support for cpacf PCC.
    - Support protected key AES-XTS.
    - Support AES-CTR.
    - Support protected key AES-CTR.
v3: - Reordered patches as suggested by Finn.
    - One small bug fix in cpacf_aes.c related to address translation.

Harald Freudenberger (14):
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

 target/s390x/gen-features.c      |  31 +
 target/s390x/tcg/cpacf.h         |  51 ++
 target/s390x/tcg/cpacf_aes.c     | 969 +++++++++++++++++++++++++++++++
 target/s390x/tcg/cpacf_sha256.c  | 229 ++++++++
 target/s390x/tcg/cpacf_sha512.c  | 241 ++++++++
 target/s390x/tcg/crypto_helper.c | 416 +++++++------
 target/s390x/tcg/insn-data.h.inc |   1 +
 target/s390x/tcg/meson.build     |   3 +
 target/s390x/tcg/translate.c     |   7 +
 9 files changed, 1734 insertions(+), 214 deletions(-)
 create mode 100644 target/s390x/tcg/cpacf.h
 create mode 100644 target/s390x/tcg/cpacf_aes.c
 create mode 100644 target/s390x/tcg/cpacf_sha256.c
 create mode 100644 target/s390x/tcg/cpacf_sha512.c

--
2.43.0


