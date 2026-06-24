Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 712C4CDB47F
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jun 2026 20:02:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wcTlR-0005fM-7O; Wed, 24 Jun 2026 16:00:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <adityag@linux.ibm.com>)
 id 1wcTlJ-0005cH-H7; Wed, 24 Jun 2026 15:59:55 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <adityag@linux.ibm.com>)
 id 1wcTlF-00086a-IQ; Wed, 24 Jun 2026 15:59:52 -0400
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65OJmIIR2056159; Wed, 24 Jun 2026 19:59:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=pp1; bh=1FC7h/Tf3tea9aTJqa/h6+iCZDtV
 kupvE0BRfZZyGcA=; b=Gi/EuNtVlAoDv+/57wuZWYkxJbPBLL1NRkXlEqhe5414
 4AgaU8Jzfi9dkM5ujLebsiXNUaThMyXEbc/ToQJYgZmpbsOaUgPolgMKkr/n+ls7
 O9kctEZCOQny3l56btdxLF9hjSF0BjPIcgTxCe3sm2lBD4TewBQuO3Om6yddlcNW
 Yukf/FNQRk2BrAb+kiRj771Py/otOXABS18AtKmoa5/h2dmKaE0zeanLSoNyVxLS
 agXf7oXR10LarzeJXmsXWu57m7WB6ZjJA2KOaN0n9VQJAgGg7VFJWWpuiHrLfVyf
 sbfeZkINmkF0KzHY6Ci/7yL9139jQrZYUXxQgK0QDQ==
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4ewjc3paaj-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 24 Jun 2026 19:59:41 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 65OJnxHD025071;
 Wed, 24 Jun 2026 19:59:40 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4ex7vyt78w-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 24 Jun 2026 19:59:40 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com
 [10.20.54.106])
 by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 65OJxasv26149202
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 24 Jun 2026 19:59:36 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 5B27220043;
 Wed, 24 Jun 2026 19:59:36 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id E430020040;
 Wed, 24 Jun 2026 19:59:26 +0000 (GMT)
Received: from li-3c92a0cc-27cf-11b2-a85c-b804d9ca68fa.ibm.com (unknown
 [9.39.20.104]) by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Wed, 24 Jun 2026 19:59:26 +0000 (GMT)
From: Aditya Gupta <adityag@linux.ibm.com>
To: <qemu-devel@nongnu.org>, <qemu-ppc@nongnu.org>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Shivang Upadhyay <shivangu@linux.ibm.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Cc: Sourabh Jain <sourabhjain@linux.ibm.com>,
 Hari Bathini <hbathini@linux.ibm.com>, Nicholas Piggin <npiggin@gmail.com>,
 Miles Glenn <milesg@linux.ibm.com>, Fabiano Rosas <farosas@suse.de>,
 Laurent Vivier <lvivier@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, devel@lists.libvirt.org,
 Misbah Anjum N <misanjum@linux.ibm.com>,
 Anushree Mathur <anushree.mathur@linux.ibm.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 kvm@vger.kernel.org, Gautam Menghani <gautam@linux.ibm.com>,
 Chinmay Rath <rathc@linux.ibm.com>
Subject: [PATCH v2 0/8] Testcase improvements and Power8E/NVL removal
Date: Thu, 25 Jun 2026 01:29:16 +0530
Message-ID: <20260624195924.1422821-1-adityag@linux.ibm.com>
X-Mailer: git-send-email 2.54.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=X4Ni7mTe c=1 sm=1 tr=0 ts=6a3c372d cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VwQbUJbxAAAA:8
 a=20KFwNOVAAAA:8 a=p0WdMEafAAAA:8 a=MdZrTe2ayghipT-8awEA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjI0MDE2NiBTYWx0ZWRfX7MOPVq/MB9PP
 PBQXAqIzJskOZv9CZE08TCsQEsXGbScSkXtBuJG8mKaYxwDHdPiacBUg04Q9L0c2EV3LSW+t/ww
 C8t4Khvg16su+FK2T+gLdtvK2kUnNaI=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjI0MDE2NiBTYWx0ZWRfX0r2tQm0RaqlW
 xBibd5k6HbQef7gcmZtSv/EPO7POuUXyFEx0InstWnI0hG60W3uOHwq+1IhxkSr2Hbpb8bVrqJ7
 +gUXUV2cis0k8NLL2ganWjPhAXvc+GdBgwb4fXCrwlHentMT8oVZaJuwYZrOzUBGKyZPM1Mv/K/
 FnT3/UY/Zqw+sA4OqKstvKM/QWXFCzBJZBojvKOfsSk4TpYTBjAKpDWOlizLBRsfwW1i49/Hjbi
 kZDLq7q20psnjmYScPiDLOP8YhZxXf0kO1NcXyK5V9Fyz7XYJhFMu0w7wUxyEmY9PYTElDkRyhR
 g/GmuHkGQvs1WuFUmAdUcr8vSM3k+pSt2MdMm0e4VP99MiLXsaoBbrVRMCo8duXUyZjF32Ld//E
 ZhaSHbAfHoCkmgrGzZ9Chhu3TdHV8DuFmpojg9/KfNiwvtyaXG9zrxCk7BD7p91C5WcSiZ9i0qa
 f+yQ4zSJ5t03sPc8ZPg==
X-Proofpoint-ORIG-GUID: HS3hx3_UBkhfXpMaFfw8uxTqJdORti6S
X-Proofpoint-GUID: v5Ecg5_6Jx1xtDTQhoTA0QQDqGKMSc0P
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-24_04,2026-06-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 bulkscore=0 suspectscore=0 spamscore=0 priorityscore=1501
 impostorscore=0 malwarescore=0 clxscore=1015 adultscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606240166
Received-SPF: pass client-ip=148.163.156.1; envelope-from=adityag@linux.ibm.com;
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

Overview
========

This patch series merged two patch series sent earlier:
	"Testcase improvements for PowerNV"
	"Remove deprecated Power8E and 8NVL CPUs"
since the Power8E removal series depended on the former due to pnv-spi test

Broadly contains 3 changes:
1. Testcase improvements:
    Add a testcase to detect regression in remote interrupts when XIVE changes,
    since such regression had occurred during Power11 XIVE changes:
    https://lore.kernel.org/qemu-devel/baf6c854-832b-4a2e-922f-d34e6dadf821@redhat.com/

    Also add Power11 chip and testcase in qtests, and fadump functional test

2. Power8E/Power8NVL removal
    Power8E and Power8NVL were deprecated since QEMU 10.1, with
    commit 264a604e7163 ("target/ppc: Deprecate Power8E and Power8NVL")
    
    Hence, remove usage (chip and core types) of Power8E and 8NVL from PowerNV,
    PSeries as well as testcases.

3. Maintainer changes
    Add myself as maintainer for PowerNV machine

Testing
=======

* Git tree for testing: https://gitlab.com/adi-g15-ibm/qemu/tree/feat_maintainer-v2
* Gitlab pipeline: https://gitlab.com/adi-g15-ibm/qemu/-/pipelines/2627063408 
* Successful ppc64 functional tests, qtests, boot tests, builds at all commits

Changelog
=========
v2:
+ #1: put e1000e on socket 1, and disable it's cpu, as suggested by cedric
+ #1: pull out command fail checks into a helper, as suggested by shivang
+ #2: use g_autofree, suggested by cedric
+ #3: use g_autofree in tests updated
+ #8: remove G:, as suggested by daniel
+ rebased to upstream

from previous split series:
+ #1: added checks to see if network is up and interrupts happened, based on shivang's review
+ #3: replaced common if-else-if check for machine type with pnv_get_machine_type
+ #7: added doc in removed-features, as suggested by cedric
+ #6,7: added rb from philippe
+ #8: new patch, maintainer change

Aditya Gupta (8):
  tests/functional: Add remote interrupts test for PowerNV
  tests/qtest/pnv_spi: Test Power11 PNV_SPI
  tests/qtest: Add Power11 chip & machine to qtests
  tests/functional: Use default powernv machine instead of power10
  ppc/pnv: Replace Power8E with Power11 for 'none' machine test
  ppc/pnv: Remove Power8E and Power8NVL pnv chips
  ppc/pnv: Remove Power8E and Power8NVL CPUs
  MAINTAINERS: Add self as maintainer for PowerNV

 MAINTAINERS                            |  2 +-
 docs/about/deprecated.rst              |  9 ---
 docs/about/removed-features.rst        |  8 +++
 docs/system/ppc/powernv.rst            |  2 +-
 docs/system/ppc/pseries.rst            |  2 +-
 hw/ppc/pnv.c                           | 62 -----------------
 hw/ppc/pnv_core.c                      |  2 -
 hw/ppc/spapr_cpu_core.c                |  2 -
 include/hw/ppc/pnv.h                   |  8 ---
 target/ppc/cpu-models.c                |  6 --
 target/ppc/cpu-models.h                |  4 --
 target/ppc/cpu_init.c                  |  6 --
 target/ppc/kvm.c                       |  4 +-
 tests/functional/ppc64/test_fadump.py  |  2 +-
 tests/functional/ppc64/test_powernv.py | 95 ++++++++++++++++++++++++++
 tests/qtest/machine-none-test.c        |  2 +-
 tests/qtest/pnv-host-i2c-test.c        | 10 ++-
 tests/qtest/pnv-spi-seeprom-test.c     | 20 ++++--
 tests/qtest/pnv-xive2-test.c           |  2 +-
 tests/qtest/pnv-xscom-test.c           | 22 ++----
 tests/qtest/pnv-xscom.h                | 42 ++++++++----
 21 files changed, 163 insertions(+), 149 deletions(-)


base-commit: b83371668192a705b878e909c5ae9c1233cbd5fb
-- 
2.54.0


