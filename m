Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48E83CD98E2
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jun 2026 09:51:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wZmvl-0005VK-K6; Wed, 17 Jun 2026 05:51:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <saif.abrar@linux.ibm.com>)
 id 1wZmvi-0005Uv-Ro; Wed, 17 Jun 2026 05:51:30 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <saif.abrar@linux.ibm.com>)
 id 1wZmvW-0003vL-9r; Wed, 17 Jun 2026 05:51:28 -0400
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65H8mgGT4022210; Wed, 17 Jun 2026 09:51:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=pp1; bh=gnEORLfWbXOe6Mmb29kHwoSmVMne
 Jm35UC5J1N+Oj0c=; b=JkWtD4wpSJpd+0T73gVHqneCEBS67oNKHYbnn3n5Bugx
 h5JgoCxmDZjED4oWiSi66fJJygXUTV0wDKOhnGN/xXSj28yVc9E8Y6r82PiYx0A9
 Z5ScA9/JybTRgZH/kuLJIWz5oUNy8ygiRHIQabYYwEcsiJ8/hTwKWPa+YIdeM67X
 Asf44SI1CG2ENJOM3omxFo7NwBV2/cmssiHYZqaiaQRzqMMuKgW/dg+LhTVeVHn2
 aeUWDPSPFTSF+rkqKlkrZq0PAkkuzJAABzMccPWWV6lSK7eO+thsAL/pEvOSEJxD
 jByC/g8iS08OqRiQEnypS0XYNQOVs+cGNUo429Gxkw==
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4eueqx28jj-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 17 Jun 2026 09:51:09 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 65H9ndWB023719;
 Wed, 17 Jun 2026 09:51:08 GMT
Received: from smtprelay07.dal12v.mail.ibm.com ([172.16.1.9])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4eudvaah6v-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 17 Jun 2026 09:51:08 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (smtpav01.wdc07v.mail.ibm.com
 [10.39.53.228])
 by smtprelay07.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 65H9p7KA26673704
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 17 Jun 2026 09:51:07 GMT
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 5806C58063;
 Wed, 17 Jun 2026 09:51:07 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id B358358059;
 Wed, 17 Jun 2026 09:51:05 +0000 (GMT)
Received: from gfwr526.rchland.ibm.com (unknown [9.10.239.119])
 by smtpav01.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Wed, 17 Jun 2026 09:51:05 +0000 (GMT)
From: Saif Abrar <saif.abrar@linux.ibm.com>
To: qemu-ppc@nongnu.org, qemu-devel@nongnu.org
Cc: harshpb@linux.ibm.com, clg@kaod.org, npiggin@gmail.com,
 fbarrat@linux.ibm.com, mst@redhat.com, marcel.apfelbaum@gmail.com,
 cohuck@redhat.com, pbonzini@redhat.com, thuth@redhat.com,
 lvivier@redhat.com, danielhb413@gmail.com, kowal@linux.ibm.com,
 chalapathi.v@linux.ibm.com, calebs@linux.ibm.com, milesg@linux.ibm.com,
 jishnuvw@linux.ibm.com, adityag@linux.ibm.com, amachhiw@linux.ibm.com
Subject: [PATCH v5 0/9] pnv/phb5: Update PHB4 to the latest PHB5 spec
Date: Wed, 17 Jun 2026 04:50:49 -0500
Message-ID: <20260617095058.652789-1-saif.abrar@linux.ibm.com>
X-Mailer: git-send-email 2.52.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE3MDA5MiBTYWx0ZWRfX+YH24C9elUeW
 /nhRsQGQySdjFwFzMv+XPd39lSJKKawdairYFqs/ovYqDOYbvuH+JQujtaz0GGAcXPmuCql6+GL
 IIA0q6JSmkXjmuNQ8dtdcEHYzrSm8ebuD179c3WS8FK5Ov2deUbpXua4HodD3joJELq639f6F34
 DHS1dEYPw80DwiiMXSWTuBe4CpKZz1+BhrLex8BYfYO39Xdn1SSx96RFyjkapPz6wYtBjPg8vVP
 S3sHM0PYcaJG+bxsfzEEmUvrulJqjESSQ0q4rRdlKotGctXIJidcMZVDIogfSVg5WINzRpFchUz
 o4o5y4Oc1KtgOdrX55HvsHLJL3KDWa8LOj55/N1akYV0sDWMIk9fhPDmLkOjC4/TTApFGGof6tz
 aHVCMlQ76dr3d2/3iVra71GJAlH805h31j32SqKIwKhMfP6oMBEh6YfwdgelxcRC5b9+iUbToet
 DoRHbnsfRyTmGyERqbg==
X-Proofpoint-GUID: PJw4pMvtWpmJEWlX-Rqkr-m8QUOaCUUX
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE3MDA5MiBTYWx0ZWRfXw3uwvy4Witk9
 Bpbe+BNpLz9UXvcyWIMLKETfWAUpoJg/TCdRwGxP58z56KXPRUliE5MAC9FCwgK8BkXjyC66qHe
 RMJkJpTC3ccV2ctGohBYlOIs8l3jPuM=
X-Proofpoint-ORIG-GUID: UqgeVVQ7PkIEfaulfMwRPsdQ6mzuoQYf
X-Authority-Analysis: v=2.4 cv=auGCzyZV c=1 sm=1 tr=0 ts=6a326e0d cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=_cohlwQBYvYmm-68XhQA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-17_01,2026-06-16_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 clxscore=1015 priorityscore=1501 suspectscore=0 impostorscore=0
 spamscore=0 lowpriorityscore=0 adultscore=0 malwarescore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606170092
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
This patchset resolves the review comments for v4:
https://lore.kernel.org/qemu-devel/20260305060923.3753402-1-saif.abrar@linux.vnet.ibm.com/

Thanks to all the reviewers for their efforts.

Major updates include the following:
- Rename to phb5.
- New file for common definitions used in tests/qtest/pnv-* files.
- Initializing PnvPHB4Class members within class_init method.
- Updated IODA3 PCT table max size to 128, each with 2 entries.
- Multiple general cleanups.

Tested with 'make check-qtest' , 'make check-functional-ppc64' and 'make check'.

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

 hw/pci-host/pnv_phb.c               |   1 +
 hw/pci-host/pnv_phb4.c              | 581 +++++++++++++++++++++++++---
 include/hw/pci-host/pnv_phb4.h      |  16 +-
 include/hw/pci-host/pnv_phb4_regs.h |  66 +++-
 tests/qtest/meson.build             |   1 +
 tests/qtest/pnv-host-i2c-test.c     |  13 +-
 tests/qtest/pnv-phb-test.c          | 235 +++++++++++
 tests/qtest/pnv-qtest-common.h      |  24 ++
 tests/qtest/pnv-xive2-common.h      |   7 +-
 9 files changed, 868 insertions(+), 76 deletions(-)
 create mode 100644 tests/qtest/pnv-phb-test.c
 create mode 100644 tests/qtest/pnv-qtest-common.h

-- 
2.52.0


