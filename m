Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B3D4CD98CD
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jun 2026 09:09:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wXEvR-00055T-Rb; Wed, 10 Jun 2026 05:08:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <adityag@linux.ibm.com>)
 id 1wXEvQ-00054v-95; Wed, 10 Jun 2026 05:08:40 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <adityag@linux.ibm.com>)
 id 1wXEvO-0000hV-MH; Wed, 10 Jun 2026 05:08:40 -0400
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65A58QsP3475344; Wed, 10 Jun 2026 09:08:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=pp1; bh=KI8J/kvZgcd9IVk11qYaApT/ziioMMz1qP0/hRi1I
 K8=; b=egCEvB7+ZaaIAqASxLFKYgyOLoCutExb9A1NgPoUzpHBq/f9ufBsj5lQ7
 wjXsA2MT1LRFFqTO2BO40la1WQZUYq2SE2oVEzrB1FcQh8s68Ao4hTnuqbJ0HU4r
 dlx6345jjSy9q3DbP3hqfhxul/26jy/Ne9qXhYnP/MtD01mnSI8RhmUD7zV0BaA0
 PgrScqUBj8pr8FlNPQ2oszBy9kEmFdxxagGZs7w2KPfHj9LeJELkIeSDNxEV4nFJ
 mfpT91P30wn7QRNx0J92K5i93CkL4w4cssuBDvymuTFQrCrtsgFzvCTJAzYXUUdY
 sEBGL5CfDATmNf9lZwehOWY31PIWw==
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4em8yj05sc-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 10 Jun 2026 09:08:25 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 65A94a1d009446;
 Wed, 10 Jun 2026 09:08:25 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4emwvq64c3-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 10 Jun 2026 09:08:24 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com
 [10.20.54.103])
 by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 65A98LOY25625036
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 10 Jun 2026 09:08:21 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 478F02004D;
 Wed, 10 Jun 2026 09:08:21 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 0E0012004B;
 Wed, 10 Jun 2026 09:08:16 +0000 (GMT)
Received: from li-3c92a0cc-27cf-11b2-a85c-b804d9ca68fa.ibm.com (unknown
 [9.39.29.92]) by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Wed, 10 Jun 2026 09:08:15 +0000 (GMT)
From: Aditya Gupta <adityag@linux.ibm.com>
To: <qemu-devel@nongnu.org>, <qemu-ppc@nongnu.org>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>
Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Nicholas Piggin <npiggin@gmail.com>,
 Miles Glenn <milesg@linux.ibm.com>, Fabiano Rosas <farosas@suse.de>,
 Laurent Vivier <lvivier@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, devel@lists.libvirt.org,
 kvm@vger.kernel.org, Misbah Anjum N <misanjum@linux.ibm.com>,
 Shivang Upadhyay <shivangu@linux.ibm.com>
Subject: [PATCH 0/4] Remove deprecated Power8E and 8NVL CPUs
Date: Wed, 10 Jun 2026 14:37:56 +0530
Message-ID: <20260610090800.3672832-1-adityag@linux.ibm.com>
X-Mailer: git-send-email 2.54.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjEwMDA4NiBTYWx0ZWRfX3F96cGIPeAnn
 S9wnVd8XQD3odJHkOG3DwhXGrENszx1NzYkfMNrWdgJ9/Y0sdDZyoWZOWHHE/TwGUBakEGBtsCf
 7WyYJcQwe5PyM1I0xUKUn83M9zN2u5HlIU8bpH/NqURJqjXsCv2Zm/jYgH72UnjQtgsbGbL/+4c
 ayi33h1cdctpIAvcoZHFcgl2bczF5juJ7UWSCJYWfxgvTdoOS7HGNrMS8f8eqyqLe9tdYIlsNM5
 rhQsq1k2IlNFIDprKgwlapRwToY8YDTV5Z9byJfLWAlzpO9kNokrw2Z6GMysZlw20OigmNW7RAx
 PQq41mOF6aSQikvIlTLhUftQJtxyXK3uGsSaqw0D5XZl7iu+tXSkIUKpI0bIgEyPneaZYPvVJe6
 vBaZ+CyPOcwme0VUJgfpt8BMtDH36xeBP0oL7uMIkauFmqPV2986serMAC2CwZkAamTT9AvlUoc
 doc0qgfxrg3csDdsNag==
X-Authority-Analysis: v=2.4 cv=HvFG3UTS c=1 sm=1 tr=0 ts=6a29298a cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8
 a=ZVU-iFHBdA2WAzVyw6oA:9
X-Proofpoint-ORIG-GUID: 6PvToHLtHDcG3YRtqiRCWNl65v0sksfK
X-Proofpoint-GUID: mrjOKFOn9R0oyWy4GEiU7k2BOprC5KnC
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-10_02,2026-06-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 clxscore=1011 lowpriorityscore=0 adultscore=0 suspectscore=0
 spamscore=0 priorityscore=1501 phishscore=0 malwarescore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606100086
Received-SPF: pass client-ip=148.163.158.5; envelope-from=adityag@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, TVD_SUBJ_WIPE_DEBT=1.004 autolearn=no autolearn_force=no
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

Power8E and Power8NVL were deprecated since QEMU 10.1, with
commit 264a604e7163 ("target/ppc: Deprecate Power8E and Power8NVL")

Hence, remove usage (chip and core types) of Power8E and 8NVL from PowerNV,
PSeries as well as testcases.

NOTE: PRE-REQUISITE: Requires following "Testcase improvements for PowerNV" to be
merged first:

  https://lore.kernel.org/qemu-devel/20260610090235.3665904-1-adityag@linux.ibm.com/T/#t

Aditya Gupta (4):
  ppc/pnv: Replace Power8E with Power11 for 'none' machine test
  ppc/pnv: Remove Power8E and Power8NVL pnv chips
  ppc/pnv: Remove Power8E and Power8NVL spapr cores
  ppc/pnv: Remove Power8E and Power8NVL CPUs

 docs/about/deprecated.rst       |  9 -----
 docs/system/ppc/powernv.rst     |  2 +-
 docs/system/ppc/pseries.rst     |  2 +-
 hw/ppc/pnv.c                    | 62 ---------------------------------
 hw/ppc/pnv_core.c               |  2 --
 hw/ppc/spapr_cpu_core.c         |  2 --
 include/hw/ppc/pnv.h            |  8 -----
 target/ppc/cpu-models.c         |  6 ----
 target/ppc/cpu-models.h         |  4 ---
 target/ppc/cpu_init.c           |  6 ----
 target/ppc/kvm.c                |  4 +--
 tests/qtest/machine-none-test.c |  2 +-
 tests/qtest/pnv-xscom.h         |  9 -----
 13 files changed, 4 insertions(+), 114 deletions(-)


base-commit: de5d8bfd6105d3dd3ae668df9762df244a6d1506
-- 
2.54.0


