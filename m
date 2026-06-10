Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6DB22CD8CB9
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jun 2026 09:03:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wXEpq-0001g4-Bt; Wed, 10 Jun 2026 05:02:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <adityag@linux.ibm.com>)
 id 1wXEpo-0001fe-Tb; Wed, 10 Jun 2026 05:02:52 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <adityag@linux.ibm.com>)
 id 1wXEpm-0005fb-DG; Wed, 10 Jun 2026 05:02:51 -0400
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 659MMKo5957566; Wed, 10 Jun 2026 09:02:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=pp1; bh=ZyimXeVsmM/oQ/GLEd6J2r+9O12wxmgpZnQV0vd2E
 oQ=; b=LOJqaP+34/gIYhCJSpKfKuhTuR8SyhRONYyrDSv7ZlGnmd8IEXzPOvVHj
 kgBWYnQcUGFwPMsfCsov1d9aG6GCiwPFgoiS0QJBVmpZUXMPaphVQVVcG4EamX5Y
 SYzFY+RqvCwtZb+nQMptZWvoIitQlP8HAKcWZQO5oKNDwnE2osPwbU28z9T2ky8B
 ApgBLrFtMd6p7k5/VFOMmuMYtYM6sMhyht8PSJa1VS+zYv6YNn/N7P7zDM6huv3Q
 NJ36mQVi6oXk+SFO3AhEx/2IAR5XzrQCcirxflk1OTwjOAQEpA3MXVdqcr954nRA
 ifDUaZLB0v/w/DirsT0yfCJfuWqAg==
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4emb7qraf6-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 10 Jun 2026 09:02:46 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 65A8nlxw021727;
 Wed, 10 Jun 2026 09:02:45 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4en03g5re2-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 10 Jun 2026 09:02:45 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com
 [10.20.54.101])
 by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 65A92gbJ29491956
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 10 Jun 2026 09:02:42 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 5041B2004B;
 Wed, 10 Jun 2026 09:02:42 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 4A44520043;
 Wed, 10 Jun 2026 09:02:37 +0000 (GMT)
Received: from li-3c92a0cc-27cf-11b2-a85c-b804d9ca68fa.ibm.com (unknown
 [9.39.29.92]) by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Wed, 10 Jun 2026 09:02:36 +0000 (GMT)
From: Aditya Gupta <adityag@linux.ibm.com>
To: <qemu-devel@nongnu.org>, <qemu-ppc@nongnu.org>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>
Cc: Sourabh Jain <sourabhjain@linux.ibm.com>,
 Hari Bathini <hbathini@linux.ibm.com>, Nicholas Piggin <npiggin@gmail.com>,
 Miles Glenn <milesg@linux.ibm.com>, Fabiano Rosas <farosas@suse.de>,
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Misbah Anjum N <misanjum@linux.ibm.com>,
 Shivang Upadhyay <shivangu@linux.ibm.com>
Subject: [PATCH 0/4] Testcase improvements for PowerNV
Date: Wed, 10 Jun 2026 14:32:31 +0530
Message-ID: <20260610090235.3665904-1-adityag@linux.ibm.com>
X-Mailer: git-send-email 2.54.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=HppG3UTS c=1 sm=1 tr=0 ts=6a292837 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=uAbxVGIbfxUO_5tXvNgY:22 a=VwQbUJbxAAAA:8 a=20KFwNOVAAAA:8 a=p0WdMEafAAAA:8
 a=hsmDZ8wVZgm1UVAWWfEA:9
X-Proofpoint-GUID: rwKRmpsL9OqrqLrS8abi0A-UvSc06iUc
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjEwMDA4MSBTYWx0ZWRfX+wahtIyFCML/
 +jLMUNmEksx7Qm5QyJ4YlwYMKtrwKnV8I+ATkK9GDDVvcfiUWRpvZZdwHMluIob2qsyJqRFLh3y
 WuuYKf3RkjjFpzzDBL9hGEhpIDOvdnDTJKbG5x1+hl0tPakceLO4FzPcXIY1ct7s2ANhu5SIgjv
 hPVWs9nM4fxRB0S1m2xXGRkGi7pIAYJNwhpg1kuLEDXBJiL5g3UK1qpMSyfCid0hTGXD4wYp9Xf
 PiBXPkg2A80bRSe8whyZlK4h/eGIqpYCpsefiFAFomcpRlm7QaW5vozLJPb4AgaJjQ9OEv3gNo6
 3OfmiwaZbmMvU4o2KI3+lNXPL4yOuRqL3kSxcB2GkkPfgZkNUFDrVBI8SQ7K1pGslNP/TVl3yOy
 ZlSN7soCGzxZlB5fA5NFSRJWxMO/a3ApB3fhAn/tgMifR3uLZtAWzQAoVpYxP0h+L73jVG9zKCv
 4wwkuOla1P8xYQSNjQQ==
X-Proofpoint-ORIG-GUID: vCMwU6JiLQIsP4SdxHQsJr7AljyvLBqW
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-10_02,2026-06-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 adultscore=0 phishscore=0 malwarescore=0 impostorscore=0
 priorityscore=1501 clxscore=1015 bulkscore=0 spamscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606100081
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

Add a testcase to detect regression in remote interrupts when XIVE changes,
since such regression had occurred during Power11 XIVE changes:
https://lore.kernel.org/qemu-devel/baf6c854-832b-4a2e-922f-d34e6dadf821@redhat.com/

Also add Power11 chip and testcase in qtests, and fadump functional test

Testing
=======

* Gitlab Pipeline: https://gitlab.com/adi-g15-ibm/qemu/-/pipelines/2590337589

Aditya Gupta (4):
  tests/functional: Add remote interrupts test for PowerNV
  tests/qtest: Add Power11 chip & machine to qtests
  tests/qtest/pnv_spi: Test Power11 PNV_SPI
  tests/functional: Use default powernv machine instead of power10

 tests/functional/ppc64/test_fadump.py  |  2 +-
 tests/functional/ppc64/test_powernv.py | 65 ++++++++++++++++++++++++++
 tests/qtest/pnv-spi-seeprom-test.c     | 25 +++++++---
 tests/qtest/pnv-xscom-test.c           |  7 ++-
 tests/qtest/pnv-xscom.h                | 17 +++++--
 5 files changed, 105 insertions(+), 11 deletions(-)


base-commit: de5d8bfd6105d3dd3ae668df9762df244a6d1506
-- 
2.54.0


