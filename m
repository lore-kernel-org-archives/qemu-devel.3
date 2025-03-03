Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 873A3C282CD
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Mar 2025 14:15:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tp6Yx-0003GY-9H; Mon, 03 Mar 2025 09:14:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chalapathi.v@linux.ibm.com>)
 id 1tp6YN-000391-HR; Mon, 03 Mar 2025 09:14:02 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chalapathi.v@linux.ibm.com>)
 id 1tp6YK-0006Tt-Ke; Mon, 03 Mar 2025 09:13:54 -0500
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5239DJ0b002207;
 Mon, 3 Mar 2025 14:13:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=pp1; bh=aI2YTtKfIKxH3tu86RTyojcaGAjS1BgWTN64RBv30
 HQ=; b=gjlFyjGkL5SRne1GAG+iRWsDqu5ZcA/sCjZvhTMTehfU5vtkwZbPAYQge
 nurxAV/5J1Msr3tEMAF/mGg1e7rDb0v5pn25e0hZW+QqwXbl+YcWLuvL8jqc34l4
 ydceOmIAFBgLSA8GE9w7cpzs5ulALIsJODfMcq5yHzvk+8vdSBHg/19nc9F4pzB7
 N2s90gS7MnEvzRKs3iwiItBitbFl73EEbUPhXv/oxNPhugKGg7E3nKJx1lwp4U7P
 n1BeU0vxR64C4AhSEeYF9BObCOWyQwXtwEeAN9IGgUKnO5Mx/i8fAgWSwuIG+87X
 slv0FAVKYKKV1PVkxAdrOUUe1/Hlw==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 454xr4uv34-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 03 Mar 2025 14:13:39 +0000 (GMT)
Received: from m0360072.ppops.net (m0360072.ppops.net [127.0.0.1])
 by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 523E76MR006275;
 Mon, 3 Mar 2025 14:13:38 GMT
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 454xr4uv2p-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 03 Mar 2025 14:13:38 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 523C3Ace013772;
 Mon, 3 Mar 2025 14:13:38 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 454e2kfhtr-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 03 Mar 2025 14:13:37 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com
 [10.20.54.100])
 by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 523EDYNL36438470
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 3 Mar 2025 14:13:34 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 3A7E42004B;
 Mon,  3 Mar 2025 14:13:34 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 04A0720040;
 Mon,  3 Mar 2025 14:13:32 +0000 (GMT)
Received: from gfwr515.rchland.ibm.com (unknown [9.10.239.103])
 by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Mon,  3 Mar 2025 14:13:31 +0000 (GMT)
From: Chalapathi V <chalapathi.v@linux.ibm.com>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, fbarrat@linux.ibm.com, npiggin@gmail.com,
 clg@kaod.org, calebs@linux.ibm.com, chalapathi.v@ibm.com,
 chalapathi.v@linux.ibm.com, saif.abrar@linux.ibm.com,
 dantan@linux.vnet.ibm.com, milesg@linux.ibm.com, philmd@linaro.org,
 alistair@alistair23.me
Subject: [PATCH v6 0/4] hw/ssi/pnv_spi: Remove PnvXferBuffer and other
 improvements
Date: Mon,  3 Mar 2025 08:13:24 -0600
Message-Id: <20250303141328.23991-1-chalapathi.v@linux.ibm.com>
X-Mailer: git-send-email 2.39.5
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: zwAG-VcVYiS9W73nheCzjZ4zdTL2Mhn_
X-Proofpoint-ORIG-GUID: ORNv5SvcRsc3vpunrqEfJJ_3Owxkpoej
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-03_07,2025-03-03_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxlogscore=742
 priorityscore=1501 lowpriorityscore=0 clxscore=1015 bulkscore=0
 adultscore=0 suspectscore=0 phishscore=0 spamscore=0 impostorscore=0
 malwarescore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502100000 definitions=main-2503030107
Received-SPF: pass client-ip=148.163.158.5;
 envelope-from=chalapathi.v@linux.ibm.com; helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H2=-0.01, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

Hello,

In this revision comments from patch V5 are addressed.

Updates in V6:
1. Improve error logging when there is an overflow or underflow of
   Fifo8 structure
2. Add comments about local variable seq_index.
3. Update the bus name to chipX.spi.<busnum>, X = 0..<num_sockets>
4. keep fail_count in PnvSpi so that each instance of spi has its own
   count.

Updates in V5:
1. Use of PnvXferBuffer results in a additional process overhead due to
frequent dynamic allocations and hence use an existing Fifo8 buffer.
2. Use a local variable seq_index and use it with in while loop instead
of repeatedly calling get_seq_index() and make sure s->seq_op doesn't
overrun when seq_index is incremented.
3. Unique bus names are created for each controller in a socket so that
responders are attached to correct SPI controllers via CLI.
4. Enforce a limit on number RDR match failures so that SPI controller
doesn't get caught in an infinite execution loop querying the responder
for RDR match.

Tested:
passed make check and make check-avocado

Chalapathi V (4):
  hw/ssi/pnv_spi: Replace PnvXferBuffer with Fifo8 structure
  hw/ssi/pnv_spi: Use local var seq_index instead of get_seq_index().
  hw/ssi/pnv_spi: Make bus names distinct for each controllers of a
    socket
  hw/ssi/pnv_spi: Put a limit to RDR match failures

 include/hw/ssi/pnv_spi.h           |   7 +-
 hw/ppc/pnv.c                       |   2 +
 hw/ssi/pnv_spi.c                   | 366 +++++++++++++----------------
 tests/qtest/pnv-spi-seeprom-test.c |   2 +-
 4 files changed, 174 insertions(+), 203 deletions(-)

-- 
2.39.5


