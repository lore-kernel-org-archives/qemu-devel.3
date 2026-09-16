Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 829BDC88E77
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Sep 2026 10:37:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x6n0Y-0003Or-HU; Wed, 16 Sep 2026 06:36:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <asahu1x@linux.ibm.com>)
 id 1x6n0X-0003OE-5E; Wed, 16 Sep 2026 06:36:53 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <asahu1x@linux.ibm.com>)
 id 1x6n0V-0001fL-7y; Wed, 16 Sep 2026 06:36:52 -0400
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68FLVekl079058; Wed, 16 Sep 2026 10:36:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=pp1; bh=LMuD2aY5bTg1sUs5iAO/ZjyAiX0DQ79qy2+FvNtzq
 4o=; b=ZtOs3A/9r+GqYv9QpDYqzi2nqITca2phylCjrMoI+B9ECC5cBO30Me5aP
 dujSivRfbMkkhMce7rr24RLyKPJaOqPTkqre8o0t0LAADbwYaNG8EPl8JD2Bej1/
 P7XVxMFxbjnCpzZRgPvHhR1MuD49ePVPN1pjwIrowhx/Gg6EfjpFenA4WTtfx2up
 dO2vktISRzaAZqWoZTtjq8XRcFtkkudY/1u6KatTZ2AciDKUUR32TwbkQ/iAD/Es
 qGnrH5VeqWpB64Tc5KvLEeEjG0GQ5bIKFozByfifUYkC7vHFFuODuK5vN9wOGzmJ
 f7fj8z/wONChrgx9r5XUQELO4vgtg==
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gmxdqbyhh-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Wed, 16 Sep 2026 10:36:47 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id
 68G7k8FX1354805; Wed, 16 Sep 2026 10:36:47 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4gpw6d6d6g-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 16 Sep 2026 10:36:47 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com
 [10.20.54.101])
 by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 68GAahj833489374
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 16 Sep 2026 10:36:43 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 563DA20043;
 Wed, 16 Sep 2026 10:36:43 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id E041420040;
 Wed, 16 Sep 2026 10:36:39 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.39.21.121])
 by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTPS;
 Wed, 16 Sep 2026 10:36:39 +0000 (GMT)
From: Aniket Sahu <asahu1x@linux.ibm.com>
To: qemu-devel@nongnu.org, qemu-ppc@nongnu.org
Cc: npiggin@gmail.com, rathc@linux.ibm.com, milesg@linux.ibm.com,
 harshpb@linux.ibm.com, anushree.mathur@linux.ibm.com,
 misanjum@linux.ibm.com, adityag@linux.ibm.com, gautam@linux.ibm.com,
 thuth@redhat.com, asahu1x@linux.ibm.com
Subject: [PATCH v2 0/2] tests/functional/ppc64: extend ppc64 functional tests
Date: Wed, 16 Sep 2026 16:06:33 +0530
Message-ID: <20260916103635.7797-1-asahu1x@linux.ibm.com>
X-Mailer: git-send-email 2.52.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE2MDEzOCBTYWx0ZWRfXyIE+nwz75Gy7
 GiGCf/qWUoFj1noPyEtwqt2kYMXqOVfBR2cIOKVCKPdU4XgJBd+VAZzLiK7ZHRiCVDe3xLFgEjH
 gXfLel0pG3RWgCF4gfNooJmIyGyCev4SYRwRXZyHOuP/fxVZojTkPm8LnN9H2Uzkp9TJWNOmLF+
 Gr48Zeom0AD13AlooMTnptV2rxUpr3fAiiaeWmRhnfQKbbCcn0zDK9dv3FGf4xWOYsXnYFwDNjU
 LOVIcTkTGfS1w7DfEi+Uk+kywALnV678WOpfjMWiJQoCM20eOzxgvcdcLqblyT2heZsuoMFEOuK
 /mdyVQU1bmjdKV62mfqQsE3SyxODAJd7b4e6NQaV81VDXSWPfMRSedjIrvRk6em3z4W0y1BTPhp
 cAFZNSOL2qMgLap3LI6+ax9kmBHIIUiWud9kikjoFDOu7SGgPSDoPBbMPGv9g3nhXQW0Opf/nB6
 fODIhsm2wCKcW1x67DA==
X-Proofpoint-GUID: KkHNGlZtdKKpgdzKXsaG2vqJ_wbfEefH
X-Authority-Analysis: v=2.4 cv=DobDa2/+ c=1 sm=1 tr=0 ts=6aaa7140 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=uAbxVGIbfxUO_5tXvNgY:22 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8
 a=WP77DTfFEFgqxUSISpMA:9 a=O8hF6Hzn-FEA:10
X-Proofpoint-ORIG-GUID: cbdRgUr_HGs9ePL3TGw_fRRbRYeLry6B
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE2MDEzOCBTYWx0ZWRfXwB1FJi7cnvqF
 EYap6a6pxTaYsnp1D8Ai70N6GmeknqzmlDMuV/tEok/wtp2U1QE+IwJ5kFQwmaE6Xpki+OhoEel
 k9ot6hrQBeYi8bgenYyRro13LLVTv5A=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-15_05,2026-09-15_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 malwarescore=0 priorityscore=1501 suspectscore=0 impostorscore=0
 spamscore=0 clxscore=1015 adultscore=0 bulkscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609160138
Received-SPF: pass client-ip=148.163.156.1; envelope-from=asahu1x@linux.ibm.com;
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

Patch 1 extends pseries migration coverage by refactoring the existing
test_ppc64_linux_migration into a shared helper and adding two new tests
for the UNIX socket and exec (socat) transport paths, which were previously
untested for pseries. Referred to the mac99 migration tests for the same.

Patch 2 adds explicit console checks for NVMe, e1000e, and xHCI driver
probe messages in do_test_ppc64_powernv(). These are emitted synchronously
during PCI enumeration, after OPAL hands off to Linux, making them safe
to check without a separate test file.

Aniket Sahu (2):
  tests/functional/ppc64: extend pseries migration tests
  tests/functional/ppc64: extend ppc64 powernv net device tests

 tests/functional/ppc64/test_powernv.py |  7 +++--
 tests/functional/ppc64/test_pseries.py | 41 ++++++++++++++++++++++----
 2 files changed, 41 insertions(+), 7 deletions(-)

---
Changes in v2:
- Patch 1: Dropped test_pseries_migrate.py; UNIX and exec transport tests
  are now full-boot tests in test_pseries.py alongside the existing TCP
  test. (Review comments by Thomas Huth)
- Patch 2: Dropped test_powernv_devices.py; PCIe device checks are folded
  into the existing do_test_ppc64_powernv() helper instead.
  (Review comments by Thomas Huth)

v1: https://lore.kernel.org/qemu-devel/77e89fea-0284-4e19-8ee7-04b900b13749@linux.ibm.com/
-- 
2.52.0

