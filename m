Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71317C61DD3
	for <qemu-devel@archiver.kernel.org>; Mon, 31 Aug 2026 12:32:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x119i-0003PG-Ek; Mon, 31 Aug 2026 08:30:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <saif.abrar@linux.ibm.com>)
 id 1x119g-0003OO-M7; Mon, 31 Aug 2026 08:30:28 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <saif.abrar@linux.ibm.com>)
 id 1x119e-00065S-Pl; Mon, 31 Aug 2026 08:30:28 -0400
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67VBVqbu956712; Mon, 31 Aug 2026 12:30:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=pp1; bh=NQj+ZALlDelLlaWTAxiC9MHzcZNi
 Ot6/ViZBU+vRO1Q=; b=Va+738j9dS5FHSi1lPeY5hB2ZGCJEhPnz9zON6qGjkBC
 hMuthbSoPhydG4phK/sABbXYF1vDiGKYV4IhGZJ0tTzFG1U9I5FG8SV3ZJ1QrzBu
 MqXfTv1jsWjx5GljfG1GC65VLP28RFLOpdmEeg1ilNX4KmKCKgW5pcFgbDpPXtGt
 q833kHvpLKFwm0suBKHtoQu34Prq3+v/xEju0+JcXvSVRtmHrDQEchAyJfrWWi2b
 9TuVd587uqcxwPg4/S2R2y+DwX+lYbGes9PZeVzSbsesJbzY9a0MYaIQaAXnayB/
 F3hY00LzYj3c/2stehqL657oZ2Z0MRs83znm0bIVxw==
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gbnudh6mp-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 31 Aug 2026 12:30:17 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67VCQGWO021506;
 Mon, 31 Aug 2026 12:30:16 GMT
Received: from smtprelay07.dal12v.mail.ibm.com ([172.16.1.9])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4gcarjwtm6-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 31 Aug 2026 12:30:16 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (smtpav01.dal12v.mail.ibm.com
 [10.241.53.100])
 by smtprelay07.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 67VCUFlw26084028
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 31 Aug 2026 12:30:15 GMT
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id AE8C458057;
 Mon, 31 Aug 2026 12:30:15 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id B074458058;
 Mon, 31 Aug 2026 12:30:14 +0000 (GMT)
Received: from gfwr526.rchland.ibm.com (unknown [9.10.239.119])
 by smtpav01.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Mon, 31 Aug 2026 12:30:14 +0000 (GMT)
From: Saif Abrar <saif.abrar@linux.ibm.com>
To: qemu-ppc@nongnu.org, qemu-devel@nongnu.org
Cc: harshpb@linux.ibm.com, clg@kaod.org, npiggin@gmail.com,
 fbarrat@linux.ibm.com, mst@redhat.com, marcel.apfelbaum@gmail.com,
 cohuck@redhat.com, pbonzini@redhat.com, thuth@redhat.com,
 lvivier@redhat.com, danielhb413@gmail.com, kowal@linux.ibm.com,
 chalapathi.v@linux.ibm.com, calebs@linux.ibm.com, milesg@linux.ibm.com,
 jishnuvw@linux.ibm.com, adityag@linux.ibm.com, amachhiw@linux.ibm.com
Subject: [PATCH v6 0/9] pnv/phb5: Update PHB4 to the latest PHB5 spec
Date: Mon, 31 Aug 2026 07:29:56 -0500
Message-ID: <20260831123005.1485518-1-saif.abrar@linux.ibm.com>
X-Mailer: git-send-email 2.52.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-GUID: QsiRYTyjiNxcG6PMntlnuXmvhg-uk8xO
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODMxMDEwNCBTYWx0ZWRfXx1WVA5wPBSaX
 /lNLOTepFHu5vTvvGnzqhVHyNlq1g27vgLFUDpLn+NXTmXi6tUENE0ZpzuJVxyO+To61UrP9L34
 zPJyPvakh4LZ8L2G8HKLoU3VlVBuYg7u1FROIwuGoocAXWYXAdUKwEBGzkQcN5A2yMiDPsjUjMh
 ONHSlMEQVXSPHthZFCF9JhQHT1/KbsekzD90zvwnJJdfIVUykrnVK1lvzn/4SoysfhuMB8oLmNF
 /XYy7PgFoYm1mf+FHt49glucH5g8RsQO70QvuaOfFriCgEfkM7BRZhFFsWSA6rpw6+SZfQjqQ/0
 JDGLfsjLmG/V3IIc7hc2g5IZb860PuLI6MZQQ2jmlwLzhmJn+gtxI3a3SxBq7wD2Cf+FUYlVoma
 aAi7y0M2dr1BGq/3CWUdDZGcNw9HArOYXVhmQNdH1DGnOmmENK5wXkMX0uzsPgwANE8dzdOB2rd
 JfEAhI3gQfulS6ZEEXQ==
X-Proofpoint-ORIG-GUID: Xz3jiNSMWdNRfrdiD7ApjNe8Aid03e0m
X-Proofpoint-Spam-Info: AW1haW4tMjYwODMxMDEwNCBTYWx0ZWRfX8N+wgfe0W8po
 aQ5Wat3G7n2cseAGaNc5qUPJySDKyqyQ1YUPxwfIZ9rCkqCKNM8hoOitibkJsF0mVtByuJRMgvI
 9QvWBBdqHYtwb189UEzHhMtXRdF6nU4=
X-Authority-Analysis: v=2.4 cv=B92JFutM c=1 sm=1 tr=0 ts=6a9573d9 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=PcF9DXbwBLoWbXR-UTsA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-31_04,2026-08-27_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 spamscore=0 clxscore=1011 suspectscore=0 phishscore=0
 lowpriorityscore=0 bulkscore=0 priorityscore=1501 impostorscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608310104
Received-SPF: pass client-ip=148.163.158.5;
 envelope-from=saif.abrar@linux.ibm.com; helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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

Hello,
This patchset resolves the review comments for v5:
https://lore.kernel.org/qemu-devel/20260617095058.652789-1-saif.abrar@linux.ibm.com/

Major updates include the following:
- Separate reset and register read/write methods for PHB5.
- PHB4 and PHB5 specific reset values.
- Read/write logic for registers added and removed in PHB5.
- General cleanups.

Tested with 'make check' and 'make check-functional-ppc64'.

Regards.

Saif Abrar (9):
  qtest/phb5: Add testbench for PHB
  pnv/phb5: Add reset logic to PHB5
  pnv/phb5: Implement sticky reset logic in PHB5
  pnv/phb5: Implement read-only and write-only bits of registers
  pnv/phb5: Implement write-clear and return 1's on unimplemented reg
    read
  pnv/phb5: Set link-active status in HPSTAT and LMR registers
  pnv/phb5: Set link speed and width in the DLP training control
    register
  pnv/phb5: Implement IODA PCT table
  pnv/phb5: Mask off LSI Source-ID based on number of interrupts

 hw/pci-host/pnv_phb.c               |  20 +-
 hw/pci-host/pnv_phb4.c              | 552 +++++++++++++++++++++++++---
 hw/pci-host/pnv_phb4_pec.c          |   2 +-
 hw/pci-host/pnv_phb5.c              | 197 +++++++++-
 hw/pci-host/pnv_phb5_pec.c          |   1 +
 hw/ppc/pnv.c                        |   1 +
 include/hw/pci-host/pnv_phb4.h      |  43 ++-
 include/hw/pci-host/pnv_phb4_regs.h |  58 ++-
 include/hw/pci-host/pnv_phb5.h      |  52 +++
 tests/qtest/meson.build             |   1 +
 tests/qtest/pnv-host-i2c-test.c     |  13 +-
 tests/qtest/pnv-phb-test.c          | 235 ++++++++++++
 tests/qtest/pnv-qtest-common.h      |  24 ++
 tests/qtest/pnv-xive2-common.h      |   7 +-
 14 files changed, 1102 insertions(+), 104 deletions(-)
 create mode 100644 include/hw/pci-host/pnv_phb5.h
 create mode 100644 tests/qtest/pnv-phb-test.c
 create mode 100644 tests/qtest/pnv-qtest-common.h

-- 
2.52.0


