Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45591EA8118
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Feb 2026 13:42:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vpo02-00017J-Mm; Tue, 10 Feb 2026 08:41:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <saif.abrar@linux.vnet.ibm.com>)
 id 1vpnzu-00012k-Ri; Tue, 10 Feb 2026 08:41:47 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <saif.abrar@linux.vnet.ibm.com>)
 id 1vpnzt-00033d-2N; Tue, 10 Feb 2026 08:41:46 -0500
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 61A21Na43344155; Tue, 10 Feb 2026 13:41:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=9gsDkv
 Od86H0ynmtHAb3sWjiyDmjvmutki8NW5vzo0M=; b=Yu8stwK8KrgMmwjCmrl5Id
 EiqM4XwMFZ90tl+E6cC9ukEJP/y5oVOHT1QycF5PEDQvNZ8RoHxxp+S1KD17IQcS
 mK2Q3QdsVwcopI4Xcby1cT9YquijzXhYvIX3mF4vy+a7J4QM/Xbe0TldFKD8YXQQ
 m0uPl8UZG/HzeFDhNlg4/yxKW9YDN6EgO0AMgUZDDcntiwsmNUrqkwHIXjx6YRS4
 Z0j2FQwzfjq+1VE7DoIaS+2QpZ9M7hK5sUCvHsV7jpEQSnZcgk8/Frv1GtcDTu88
 xoL8Wg+1JCqB1VhT/X8qs6kvoByFkwlxam3IBa9YJTf72d7NL1k6wAPhjTNwgKYw
 ==
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4c696utavd-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 10 Feb 2026 13:41:30 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 61A9lJ2Y008413;
 Tue, 10 Feb 2026 13:41:29 GMT
Received: from smtprelay04.dal12v.mail.ibm.com ([172.16.1.6])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4c6g3y9k1h-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 10 Feb 2026 13:41:29 +0000
Received: from smtpav03.wdc07v.mail.ibm.com (smtpav03.wdc07v.mail.ibm.com
 [10.39.53.230])
 by smtprelay04.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 61ADfSqM28705466
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 10 Feb 2026 13:41:28 GMT
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 0CF7458054;
 Tue, 10 Feb 2026 13:41:28 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id CBAE25805C;
 Tue, 10 Feb 2026 13:41:26 +0000 (GMT)
Received: from gfwr526.rchland.ibm.com (unknown [9.10.239.119])
 by smtpav03.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Tue, 10 Feb 2026 13:41:26 +0000 (GMT)
From: Saif Abrar <saif.abrar@linux.vnet.ibm.com>
To: qemu-ppc@nongnu.org, qemu-devel@nongnu.org
Cc: clg@kaod.org, npiggin@gmail.com, fbarrat@linux.ibm.com, mst@redhat.com,
 marcel.apfelbaum@gmail.com, cohuck@redhat.com, pbonzini@redhat.com,
 thuth@redhat.com, lvivier@redhat.com, danielhb413@gmail.com,
 saif.abrar@linux.vnet.ibm.com
Subject: [PATCH v3 0/9] : pnv/phb4: Update PHB4 to the latest PHB5 spec
Date: Tue, 10 Feb 2026 07:40:50 -0600
Message-ID: <20260210134110.1515322-1-saif.abrar@linux.vnet.ibm.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251230102156.886288-1-saif.abrar@linux.vnet.ibm.com>
References: <20251230102156.886288-1-saif.abrar@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjEwMDExMiBTYWx0ZWRfX8qMLXYdHSTrO
 DDUzLwnPkDDlvQOUZKH5WffZ9Scj717rUAd5I7NJgic5VtrHoLk+SGdUi9rTJGSjth7GK06WQEN
 1HPnf3k5JSaoL8TWOKFl1nWnufg9RJbZQdlAk/V4VSprMauqQGJpG7F5Rvm/xvGW5VfP5ukOBL+
 a5bmrEWFDKoOiZzGtdjxTmLCgHW4Oj3akZU3D+t7CYgnbWm4hmOXbEQbWox3GzUnxP8MZS/uU3K
 wuk8CI2DhCtn9FmRdG4A5YEcfJZzpMtzsOXKhfSxuiChAp51OPJnIH3s2nO4GcntLRVkJKURiEi
 PU3HRocHJHu7x4wwjn3xy1c7rsSztMfwuKzzK7po9EetOLdoUgeTxCmuzUHwgwq6I07SbDiTSpG
 2V4YBl6pp3lzv17IHWj+5LTho4Nm6FIUZO2CEp0FF1pMjYdMvxI8Qygn4oPbsyTAnUikCn4LUmI
 e1LpmDX1tg1pn6HR31w==
X-Proofpoint-ORIG-GUID: lEB35GVerIytjcCJq1vzi9jkZJ2uYmpW
X-Proofpoint-GUID: gOPs8SXQYPhKZT_1w2lDspMnQFu5gumx
X-Authority-Analysis: v=2.4 cv=O+Y0fR9W c=1 sm=1 tr=0 ts=698b358a cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22 a=mDV3o1hIAAAA:8
 a=MPXgO6Mk5SgahTVVPB0A:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-10_01,2026-02-10_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 priorityscore=1501 phishscore=0 adultscore=0
 malwarescore=0 impostorscore=0 bulkscore=0 clxscore=1015 spamscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2602100112
Received-SPF: none client-ip=148.163.158.5;
 envelope-from=saif.abrar@linux.vnet.ibm.com; helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

Addressing the review comments for the series v2:
https://lists.gnu.org/archive/html/qemu-devel/2025-12/msg03768.html

This series updates the existing PHB4 model to the latest spec:
"Power Systems Host Bridge 5 (PHB5) Functional Specification Version 0.5_00".

Updates include the following:
- implemented sticky reset logic
- implemented read-only, write-only, W1C and WxC logic
- return all 1's on read to unimplemented registers
- update PCIE registers for link status, speed and width
- implement IODA PCT debug table without any functionality
- update LSI Source-ID register based on small/big PHB number of interrupts

Also, a new testbench for PHB4 model is added that does XSCOM read/writes
to various registers of interest and verifies the values.

Regards.

Saif Abrar (9):
  qtest/phb4: Add testbench for PHB4
  pnv/phb4: Add reset logic to PHB4
  pnv/phb4: Implement sticky reset logic in PHB4
  pnv/phb4: Implement read-only and write-only bits of registers
  pnv/phb4: Implement write-clear and return 1's on unimplemented reg read
  pnv/phb4: Set link-active status in HPSTAT and LMR registers
  pnv/phb4: Set link speed and width in the DLP training control register
  pnv/phb4: Implement IODA PCT table
  pnv/phb4: Mask off LSI Source-ID based on number of interrupts

 hw/pci-host/pnv_phb.c               |   1 +
 hw/pci-host/pnv_phb4.c              | 583 +++++++++++++++++++++++++---
 include/hw/pci-host/pnv_phb4.h      |  16 +-
 include/hw/pci-host/pnv_phb4_regs.h |  66 +++-
 tests/qtest/meson.build             |   1 +
 tests/qtest/pnv-phb4-test.c         | 228 +++++++++++
 6 files changed, 837 insertions(+), 58 deletions(-)
 create mode 100644 tests/qtest/pnv-phb4-test.c

-- 
2.47.3


