Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 874D0C44508
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jul 2026 16:37:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wk2ar-0006lg-1W; Wed, 15 Jul 2026 12:36:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mikail.sadic@ibm.com>)
 id 1wk1tF-00007m-R9; Wed, 15 Jul 2026 11:51:17 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mikail.sadic@ibm.com>)
 id 1wk1tE-0004jK-2Y; Wed, 15 Jul 2026 11:51:17 -0400
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66FEBvbP314457; Wed, 15 Jul 2026 15:50:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=pp1; bh=hFGDO3ZMaYdrWtJTAcz1EgqImz7gcwtMHtAeWh3Ea
 wk=; b=RdbGCl2ZvWGsbDwRXcTRqiMcdQ0vhOv5jRyXEDyswtHq+YG4NwO/oBrJk
 AAtezQI6LZVlKoKHVXDHt4lkLTfUv/ZklTn7Ks470/65BVQEBh10x68nS3JR/mj4
 8ss8QcBu0liido4g2EW9XsGPtNirr0FQJY1A3MiXxA1UoXsTNMShnFfMxanIqa+s
 zANTf7zzR9e2oJjTa4kx50Yb6gxS6Z8022OheTF5eJ7NybUTkBWnyvIzGElUtjcY
 pqIPNE3LFGH7Mhk1x/F7t55pb7Q/y0x4wxxNUNgoAzyU5prT85Vp8gRL0A6CadLK
 6i5ZmwdKl997bqWE/u77EkkV9hifw==
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fbexwuqt9-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 15 Jul 2026 15:50:46 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66FFYbwI008977;
 Wed, 15 Jul 2026 15:50:46 GMT
Received: from smtprelay05.wdc07v.mail.ibm.com ([172.16.1.72])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fc1nhgnfb-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 15 Jul 2026 15:50:46 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (smtpav01.wdc07v.mail.ibm.com
 [10.39.53.228])
 by smtprelay05.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 66FFoip950463224
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 15 Jul 2026 15:50:44 GMT
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 128D558059;
 Wed, 15 Jul 2026 15:50:44 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 2793158055;
 Wed, 15 Jul 2026 15:50:43 +0000 (GMT)
Received: from IBM-MFS.atx-us.ibm.com (unknown [9.16.53.88])
 by smtpav01.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Wed, 15 Jul 2026 15:50:43 +0000 (GMT)
From: Mikail Sadic <mikail.sadic@ibm.com>
To: clg@kaod.org, peter.maydell@linaro.org
Cc: Mikail Sadic <mikail.sadic@ibm.com>, pbonzini@redhat.com,
 ninad@linux.ibm.com, titusr@google.com, jeuk20.kim@samsung.com,
 philmd@mailo.com, steven_lee@aspeedtech.com, leetroy@gmail.com,
 jamin_lin@aspeedtech.com, kane_chen@aspeedtech.com,
 andrew@codeconstruct.com.au, joel@jms.id.au, calebs@us.ibm.com,
 milesg@ibm.com, qemu-arm@nongnu.org, qemu-devel@nongnu.org
Subject: [PATCH v1 0/5] Add IBM Huygens BMC machine for AST2700
Date: Wed, 15 Jul 2026 10:50:31 -0500
Message-ID: <20260715155037.2237011-1-mikail.sadic@ibm.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-GUID: k982-p2dgIIbfZJA4LFVz_nd48xqbRcO
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE1MDE1NiBTYWx0ZWRfXxtBovsUDf8IF
 kQhXvqzsVdIKQy0uZm8CPi3we4Z+0f6AjNG11nigc3/6tK4tknfNTZpT1bblfn16mxIIrc0tlqq
 uNXA+6sgCqfWlIOi9WYXdKwpBnrRNrT571PZLcougxzAMbgPW750wcZ/sT9vud2zv7SckHVO7B4
 jTRlqXmppKmhMBSdchCxWvvTUqMcKAm85URy5sV0jM9IRJ594BRtmBaid/Y5Ekz8urIxKpzgzFu
 bmTkPmUA9mhCvuIPg1yPXkfjc5MojoOskZRQ1K+GBD8VHuZRLewo7hMA+eG1JQc03QYkTPsqcsB
 Y4Z9Ujy0IO0wMnngVGaepfEE5gF3uQOtXoXhs5hefuVTT9xSnz6Fp1Az6NUhS3AIEQAsjf2Qlyj
 V1gHFPPXsl2kMOyQ+V05Hvym6iPfD+zMJiALhEnVcSrOKa5oSNDbzT2uO5v1b5YTgKbMG+ClQQZ
 OHPSk7MPogNMmfp27yA==
X-Authority-Analysis: v=2.4 cv=XJoAjwhE c=1 sm=1 tr=0 ts=6a57ac57 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=V8glGbnc2Ofi9Qvn3v5h:22 a=7IsaZwO8Vybgm6Ii5y0A:9
X-Proofpoint-ORIG-GUID: COk_Im2iC_VaMtzPeJcSswnBxdzxchuE
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE1MDE1NiBTYWx0ZWRfX08TPIBXnT0ha
 QInKTl70nEpxbZ7IbZw/QE6rkyttYveg+iT2qRp2rBSVjbE4m1aA3S2rss8VyAGHlvageWZgtb4
 frhNuiaXbNQ8qeelo2xzQm2PSB2FC9E=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-15_03,2026-07-15_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0 bulkscore=0 phishscore=0 lowpriorityscore=0
 priorityscore=1501 impostorscore=0 clxscore=1011 spamscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607150156
Received-SPF: pass client-ip=148.163.158.5; envelope-from=mikail.sadic@ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Wed, 15 Jul 2026 12:36:14 -0400
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

This series adds initial support for the IBM Huygens BMC platform based
on the ASPEED AST2700 A2 SoC.

The series introduces a new Huygens machine model, adds a dedicated
CFAM-S implementation for the AST2700 FSI responder framework, provides
a PMBus model for the TI UCD90320 power sequencer, and implements the
AST2700 UFS host controller required for booting from UFS storage.
It also includes an initial functional test covering the Huygens boot 
flow.

Patch summary:

1. Add the AST2700 Huygens machine.
2. Add the CFAM-S model for AST2700.
3. Add the TI UCD90320 PMBus device model.
4. Add the AST2700 UFS host controller.
5. Add an initial Huygens functional boot test.

Testing done:

* Booted OpenBMC using UFS storage.
* Verified OpenBMC reaches the login prompt & Active/Ready state.
* Verified `make check` test cases all pass.

Note: checkpatch has some warns about MAINTAINERS for patches 1, 2, 
and 5, but the new files should already be covered by existing 
wildcard entries in the ASPEED BMCs and FSI sections.

Mikail Sadic (5):
  arm/aspeed: Add AST2700 Huygens machine
  fsi/cfam: Add CFAM-S model for AST2700
  hw/sensor: Add UCD90320 model
  ufs/aspeed: Add AST2700 UFS host controller
  tests/functional: Add Huygens BMC boot test

 MAINTAINERS                                   |    2 +
 docs/specs/aspeed-ufs.rst                     |   69 ++
 docs/specs/fsi.rst                            |   58 +
 docs/specs/index.rst                          |    2 +
 docs/specs/ucd90320.rst                       |   36 +
 docs/system/arm/aspeed.rst                    |   41 +-
 include/hw/arm/aspeed_soc.h                   |    3 +
 include/hw/fsi/cfam-s.h                       |   26 +
 include/hw/fsi/fsi-master.h                   |    2 +
 include/hw/ufs/aspeed_ufs.h                   |   66 +
 hw/arm/aspeed.c                               |   12 +
 hw/arm/aspeed_ast27x0.c                       |   31 +
 hw/arm/aspeed_ast27x0_huygens.c               |  242 ++++
 hw/fsi/cfam-s.c                               |  145 +++
 hw/fsi/fsi-master.c                           |   10 +-
 hw/i2c/aspeed_i2c.c                           |    7 +
 hw/sensor/ucd90320.c                          |  144 +++
 hw/ufs/aspeed_ufs.c                           | 1095 +++++++++++++++++
 hw/arm/Kconfig                                |    1 +
 hw/arm/meson.build                            |    1 +
 hw/fsi/meson.build                            |    2 +-
 hw/sensor/Kconfig                             |    4 +
 hw/sensor/meson.build                         |    1 +
 hw/ufs/meson.build                            |    1 +
 tests/functional/aarch64/meson.build          |    2 +
 .../functional/aarch64/test_aspeed_huygens.py |   49 +
 26 files changed, 2047 insertions(+), 5 deletions(-)
 create mode 100644 docs/specs/aspeed-ufs.rst
 create mode 100644 docs/specs/ucd90320.rst
 create mode 100644 include/hw/fsi/cfam-s.h
 create mode 100644 include/hw/ufs/aspeed_ufs.h
 create mode 100644 hw/arm/aspeed_ast27x0_huygens.c
 create mode 100644 hw/fsi/cfam-s.c
 create mode 100644 hw/sensor/ucd90320.c
 create mode 100644 hw/ufs/aspeed_ufs.c
 create mode 100755 tests/functional/aarch64/test_aspeed_huygens.py

-- 
2.53.0


