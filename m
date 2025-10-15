Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31561CCD192
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Oct 2025 14:23:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v92OM-0001zU-UM; Wed, 15 Oct 2025 10:22:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>)
 id 1v92O9-0001xl-6I; Wed, 15 Oct 2025 10:22:01 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>)
 id 1v92Ny-0003Eg-RA; Wed, 15 Oct 2025 10:21:59 -0400
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59FDhDNp012319;
 Wed, 15 Oct 2025 14:21:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=pp1; bh=g2iljmQPeaXc+evUDfnQ6HT6BuSZoDg00I2Re6HCA
 uQ=; b=Rj7mP+8UV4oZIXfi+u3J5TaHGPi67fv1WdmkQJS/511jiTnUoIvSmhfbp
 u7XXYTycpGaWp7+P/UaFiErAH5e/8aBskJdeWPayNTeAxhknEc3ieVZWRlYbbFsA
 aqZAPMMC0fphcdsr9TxrjSYKp/k3ArMy5DqocrgHcdAhsdsjcqTN85/2u+DpMH0J
 LssoOBk3C9/7GJKLAv4nKn5ZPOvpNMVkdpcQ92IeZcmqSq+cKc4Kqsa/zOa84MB+
 1jUCSilwZbMmcxWfh7UZuVvDWjg1DvgaCYwS53fL1SrOnWQCoFG1YeyFvINDRMhD
 6mXIxFIANxgDWhBSS/ToFeDSwj4cA==
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 49qcnrcgj0-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 15 Oct 2025 14:21:46 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 59FD1PMn015190;
 Wed, 15 Oct 2025 14:21:45 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 49r1js911c-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 15 Oct 2025 14:21:45 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com
 [10.20.54.101])
 by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 59FELhlX41550214
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 15 Oct 2025 14:21:43 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id A69B620108;
 Wed, 15 Oct 2025 14:21:43 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 310CA20104;
 Wed, 15 Oct 2025 14:21:43 +0000 (GMT)
Received: from heavy.ibm.com (unknown [9.87.134.59])
 by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Wed, 15 Oct 2025 14:21:43 +0000 (GMT)
From: Ilya Leoshkevich <iii@linux.ibm.com>
To: Thomas Huth <thuth@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 David Hildenbrand <david@redhat.com>
Cc: qemu-s390x@nongnu.org, qemu-devel@nongnu.org,
 Ilya Leoshkevich <iii@linux.ibm.com>
Subject: [PATCH v2 0/3] target/s390x: Fix missing clock-comparator interrupts
Date: Wed, 15 Oct 2025 16:21:03 +0200
Message-ID: <20251015142141.3238-1-iii@linux.ibm.com>
X-Mailer: git-send-email 2.51.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=M5ZA6iws c=1 sm=1 tr=0 ts=68efadfa cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8
 a=wulB5n37dczb7JW1nh8A:9 a=HhbK4dLum7pmb74im6QT:22 a=cPQSjfK2_nFv0Q5t_7PE:22
 a=pHzHmUro8NiASowvMSCR:22 a=Ew2E2A-JSTLzCXPT_086:22
X-Proofpoint-GUID: biPr-3Er0pQ5axM-1QZDiI2MuyjkQ1zs
X-Proofpoint-ORIG-GUID: biPr-3Er0pQ5axM-1QZDiI2MuyjkQ1zs
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDEwMDE0MCBTYWx0ZWRfX1+sWVrMbaJ9+
 vIdoGWt/puihVgq4Q3B47ErLsB8U5rWcRNrKgdutjMqmrcngmtbd9Tanl8iRsjdWfICb7CPbHvt
 Hch9nqlvfnzWcngwSFRjArqJ7ePFHzuvejC3/ZgkR/UAYFyubnM+NHFJNIkPW3Kkvr6/+K4yvpg
 GDRv4Abij8iHPWZtMsLgBE+Cc3WBEiM7v/klYdOacHEtFsdgrp3FM/qVs95wOQOY4bbFm300jtZ
 UgRgzP6Jl+DAbQMzmRyTBXBgFsi2pvmz5LlldPcE2X+hIHtc4eJB3R9dKbRD2TeSyf+gcuc+wTO
 so3WcDzWurJTdA3Bk/7gZOGoXxR2DVgs5YJQ0nT8xmY5JC518yR6m3yZYSVroZEYx58dUYc0SF1
 XzOZC8WgFbR4oiJllxudqyvHVeElJg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-15_05,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 bulkscore=0 spamscore=0 clxscore=1015 impostorscore=0
 phishscore=0 adultscore=0 suspectscore=0 priorityscore=1501
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2510020000
 definitions=main-2510100140
Received-SPF: pass client-ip=148.163.158.5; envelope-from=iii@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

v1: https://lore.kernel.org/qemu-devel/20251014160743.398093-1-iii@linux.ibm.com/
v1 -> v2: Add Thomas' R-b.
          Cc: stable (Michael).
          Improve formatting, commit messages, and test (Ilya).

Hi,

While trying to (so far unsuccessfully) reproduce [1], I found two bugs
in the clock comparator handling. This series fixes both and adds a
test.

[1] https://lore.kernel.org/lkml/ab3131a2-c42a-47ff-bf03-e9f68ac053c0@t-8ch.de/

Best regards,
Ilya

Ilya Leoshkevich (3):
  target/s390x: Fix missing interrupts for small CKC values
  target/s390x: Fix missing clock-comparator interrupts after reset
  tests/tcg/s390x: Test SET CLOCK COMPARATOR

 hw/s390x/s390-virtio-ccw.c              |  6 +--
 target/s390x/cpu.c                      |  8 ++++
 target/s390x/tcg/misc_helper.c          | 12 ++++--
 tests/tcg/s390x/Makefile.softmmu-target |  1 +
 tests/tcg/s390x/sckc.S                  | 55 +++++++++++++++++++++++++
 5 files changed, 75 insertions(+), 7 deletions(-)
 create mode 100644 tests/tcg/s390x/sckc.S

-- 
2.51.0


