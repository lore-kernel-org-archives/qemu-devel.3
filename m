Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7DE97C982E1
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Sep 2026 08:11:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x8Z6r-0004wm-In; Mon, 21 Sep 2026 04:10:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <asahu1x@linux.ibm.com>)
 id 1x8Z6i-0004tm-9X; Mon, 21 Sep 2026 04:10:39 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <asahu1x@linux.ibm.com>)
 id 1x8Z6X-0000Iy-Mg; Mon, 21 Sep 2026 04:10:30 -0400
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68L7ZUv1818926; Mon, 21 Sep 2026 08:10:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=pp1; bh=w/DX+oOvSWBGOE7rhctiMmpLCK9nXsmMjWvm2Aix/
 JI=; b=b++8v2YOMHaCTLHnEX95U/lvajwzdBFfVoSSfk3g2I89uFbPH+xmbaToG
 8aH49feeQ0Nfg5YR+sPFOvcO1pVBAUqnkfhWUm7Euo7O353ThuQdGLANQyrWFcQm
 yrOoI8x/ZnjBe5WYnQ0uYUawUUr4zuTqxAQHh3tJgcQJ2m15ZcumNoGBkuIEr6WX
 YxHMm+d+ymG31MBAIAlDwbin9KFm++BOsCzRER4sZ3ArRbALNueENbQNR97boq7U
 IbMJ+hDGi/3QTPTRKDXr0UrOQpalN0RJVwnd4C9Yv8uKxaJoMG6v7VJxaRI7XIA1
 M3xksvk/2qtmBPvIFybjcnsVXza5A==
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gskg27f54-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Mon, 21 Sep 2026 08:10:22 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id
 68L7Ha4n1835409; Mon, 21 Sep 2026 08:10:21 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4gt7dy45kb-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 21 Sep 2026 08:10:21 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com
 [10.20.54.104])
 by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 68L8AHIH53215698
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 21 Sep 2026 08:10:17 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id A917F2004B;
 Mon, 21 Sep 2026 08:10:17 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 9617920040;
 Mon, 21 Sep 2026 08:10:13 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.39.18.112])
 by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Mon, 21 Sep 2026 08:10:13 +0000 (GMT)
From: Aniket Sahu <asahu1x@linux.ibm.com>
To: qemu-devel@nongnu.org, qemu-ppc@nongnu.org
Cc: peterx@redhat.com, farosas@suse.de, npiggin@gmail.com,
 adityag@linux.ibm.com, milesg@linux.ibm.com, harshpb@linux.ibm.com,
 rathc@linux.ibm.com, anushree.mathur@linux.ibm.com,
 misanjum@linux.ibm.com, gautam@linux.ibm.com, thuth@redhat.com,
 amachhiw@linux.ibm.com, asahu1x@linux.ibm.com
Subject: [PATCH v3 0/2] tests/functional/ppc64: extend ppc64 functional tests
Date: Mon, 21 Sep 2026 13:40:08 +0530
Message-ID: <20260921081010.31778-1-asahu1x@linux.ibm.com>
X-Mailer: git-send-email 2.52.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-ORIG-GUID: FqrXyQ54URnVjzBNppwqNLElQ9t8q5HP
X-Authority-Analysis: v=2.4 cv=I43w19gg c=1 sm=1 tr=0 ts=6ab0e66e cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8
 a=WP77DTfFEFgqxUSISpMA:9 a=O8hF6Hzn-FEA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTIxMDExNSBTYWx0ZWRfX+QhTN0hJju9H
 xBprqc9+lDNfYAOwlTsW/f6Nn3aCkAZjO+xoahmtmzwop83DTA3BVtE927U9BvVTtI0Ap6b3Hu0
 mmm52cxRXpqZb19RAXdYm8+2E3HEILGR0P+8zMDl4hSk6eNaZPDF0CiAqmzcQZmGg9zsRf18YpK
 MzK1t058GEeaBqMoBi0qRacVTwHdtbKq9wQbrH5xmV8YOA0xkalCErnRPihL+qefabO2dMuLsp+
 3VfkQcXoe6uh1z3aSl5i3MmTliQwHy/+YlwosJWjU3uJ/GN0LTCZkfR+z1a2d4ocJR8fJFilCcZ
 d1HPK6gZEw3bd2ilkIqOpggze9NF7UlwCjqttJWmUTrbyCvSY3nosNg1KWpdYSMqclm5ajy/4G8
 Uhn5x+qRLwY4WY5OTSB6yhJDoIsc4w7XGQR6dc8rg0oZS7llvEDVb119GI8t+zdsiPgORv+SnRI
 zNBytOc+nwyeT4rGUqg==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTIxMDExNSBTYWx0ZWRfX72J7RwMJYT+9
 0nbetaYm39Yb/NXqhzOE/pqTX3DYWnVZRQJb9mH1nIxFU5IDhgPGeY/VQb0J2pWNkAK72fu6zJ+
 NJt9SCo1qeL85sTcXA3Kfjks8AM2K/o=
X-Proofpoint-GUID: 1MCUFO5aBxh1DfSHkOwEVu8VFnP2sSBr
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-21_03,2026-09-16_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 clxscore=1011 adultscore=0 suspectscore=0 impostorscore=0
 lowpriorityscore=0 bulkscore=0 phishscore=0 priorityscore=1501 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609210115
Received-SPF: pass client-ip=148.163.156.1; envelope-from=asahu1x@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01, SPF_HELO_NONE=0.001,
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

Patch 1 switches the UNIX socket and exec (socat) migration tests in
test_migration.py from mac99 to pseries.  All three transports were
already covered for mac99; this change exercises the same transports
against the pseries vmstate not present in mac99. The TCP test is left
on mac99 since pseries TCP migration is already covered by the full-boot
test_ppc64_linux_migration in test_pseries.py.

Patch 2 adds explicit console checks for NVMe, e1000e, and xHCI driver
probe messages in do_test_ppc64_powernv(). These are emitted
synchronously during PCI enumeration after OPAL hands off to Linux,
making them safe to assert without a separate test file.

Aniket Sahu (2):
  tests/functional/ppc64: extend pseries migration tests
  tests/functional/ppc64: extend ppc64 powernv net device tests

 tests/functional/ppc64/test_migration.py | 4 ++--
 tests/functional/ppc64/test_powernv.py   | 7 +++++--
 2 files changed, 7 insertions(+), 4 deletions(-)

---
Changes in v3:
- Patch 1: Dropped the full-boot UNIX/exec tests from test_pseries.py.
  Instead, switched the existing no-boot UNIX and exec tests in
  test_migration.py from mac99 to pseries, exercising the pseries vmstate
  on all three transport paths with minimal CI cost.
  (Suggested by Amit and Thomas Huth.)
- Patch 2: No change from v2.

Changes in v2:
- Patch 1: Dropped test_pseries_migrate.py; UNIX and exec transport tests
  were moved to test_pseries.py as full-boot tests alongside the existing
  TCP test. (Suggested by Thomas Huth.)
- Patch 2: Dropped test_powernv_devices.py; PCIe device checks were folded
  into the existing do_test_ppc64_powernv() helper instead.
  (Suggested by Thomas Huth.)

---
v2: https://lore.kernel.org/qemu-devel/20260916103635.7797-1-asahu1x@linux.ibm.com/#t
v1: https://lore.kernel.org/qemu-devel/77e89fea-0284-4e19-8ee7-04b900b13749@linux.ibm.com/
-- 
2.52.0

