Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF446E77198
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jan 2025 16:19:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tTkOA-0005b9-3K; Fri, 03 Jan 2025 11:19:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chalapathi.v@linux.ibm.com>)
 id 1tTkO7-0005ZH-Vf; Fri, 03 Jan 2025 11:19:03 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chalapathi.v@linux.ibm.com>)
 id 1tTkO5-0001Yo-Fp; Fri, 03 Jan 2025 11:19:03 -0500
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50385ZC2002768;
 Fri, 3 Jan 2025 16:18:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=pp1; bh=QlAGJJTbR8Ilk4hn6hoF6gKb7Wr4cpNEEDX/LQYMt
 10=; b=jp95pU7Sg30nKGm8Q11rYm7ElLZrn9e1b44UKByvghrUBangdShzvQr0d
 I7r4BBNwvvfmb3YdLWPt8Ey9+38sOrUYwfMg+EbWdlqtGRsyP15kKxu8m68g/o1Z
 gQgDf82aIU9VdTwHQh5lNzozoFoCwrvnzAYCoJkvHZ87KamFgug8vGuMs8A6U2o3
 0/9m4GZdfMqZbi/OZUQgZOsRuGBs2xXgnGzQZ0TCdFfol1M2LChUbbspod/hTiyR
 zq8moJMhefC73agrYqdxSA4f0ClCu+ShA0W6T0WLFNgNRT4Np2mLi9ZwgHx8nxDJ
 F3oZ0s2l4Atg4X1EizCF3/fma/eBg==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 43xc32spq9-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 03 Jan 2025 16:18:47 +0000 (GMT)
Received: from m0360072.ppops.net (m0360072.ppops.net [127.0.0.1])
 by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 503GIk4n005875;
 Fri, 3 Jan 2025 16:18:46 GMT
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 43xc32spq6-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 03 Jan 2025 16:18:46 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 503GF4UA016763;
 Fri, 3 Jan 2025 16:18:45 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 43tw5kpv1g-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 03 Jan 2025 16:18:45 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com
 [10.20.54.105])
 by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 503GIftW15991068
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 3 Jan 2025 16:18:41 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 862002004B;
 Fri,  3 Jan 2025 16:18:41 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 549A520040;
 Fri,  3 Jan 2025 16:18:39 +0000 (GMT)
Received: from gfwr515.rchland.ibm.com (unknown [9.10.239.103])
 by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Fri,  3 Jan 2025 16:18:39 +0000 (GMT)
From: Chalapathi V <chalapathi.v@linux.ibm.com>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, fbarrat@linux.ibm.com, npiggin@gmail.com,
 clg@kaod.org, calebs@linux.ibm.com, chalapathi.v@ibm.com,
 chalapathi.v@linux.ibm.com, saif.abrar@linux.ibm.com,
 dantan@linux.vnet.ibm.com, milesg@linux.ibm.com, philmd@linaro.org,
 alistair@alistair23.me
Subject: [PATCH v5 0/4] hw/ssi/pnv_spi: Remove PnvXferBuffer and fix CID
 1558827
Date: Fri,  3 Jan 2025 10:18:20 -0600
Message-Id: <20250103161824.22469-1-chalapathi.v@linux.ibm.com>
X-Mailer: git-send-email 2.39.5
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: Dwo5ODgyuoMvFw4olAX_qUWjdy4IZR8G
X-Proofpoint-ORIG-GUID: v-vwbE_SKgvHw0-Rud3BQ-GXjJeidp3c
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 mlxscore=0
 phishscore=0 priorityscore=1501 impostorscore=0 clxscore=1015
 malwarescore=0 adultscore=0 suspectscore=0 mlxlogscore=801 bulkscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2501030137
Received-SPF: pass client-ip=148.163.158.5;
 envelope-from=chalapathi.v@linux.ibm.com; helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H2=-0.001, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
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

In this revision two new commits are added to address multi chip SPI issues.

Updates in V5:
1. Use of PnvXferBuffer results in a additonal process overhead due to
frequent dynamic allocations and hence use an existing Fifo8 buffer.
2. Use a local variable seq_index and use it with in while loop instead
of repeatedly calling get_seq_index() and make sure s->seq_op doesn't
overrun when seq_index is incremented.
3. Unique bus names are created for each controller in a socket so that
responders are attched to correct SPI controllers via CLI.
4. Enforce a limit on number RDR match failures so that SPI controller
doesn't get caught in an infinite execution loop querying the responder
for RDR match.

Tested:
passed make check and make check-avocado

Chalapathi V (4):
  hw/ssi/pnv_spi: Replace PnvXferBuffer with Fifo8 structure
  hw/ssi/pnv_spi: Coverity CID 1558827: Use local var seq_index instead
    of get_seq_index().
  hw/ssi/pnv_spi: Make bus names distinct for each controllers of a
    socket
  hw/ssi/pnv_spi: Put a limit to RDR match failures

 include/hw/ssi/pnv_spi.h           |   6 +-
 hw/ppc/pnv.c                       |   2 +
 hw/ssi/pnv_spi.c                   | 336 ++++++++++++-----------------
 tests/qtest/pnv-spi-seeprom-test.c |   2 +-
 4 files changed, 143 insertions(+), 203 deletions(-)

-- 
2.39.5


