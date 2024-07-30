Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8FF45C3DA49
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jul 2024 17:24:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sYqa9-0003uf-9h; Tue, 30 Jul 2024 13:24:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chalapathi.v@linux.ibm.com>)
 id 1sYqa7-0003nH-4b; Tue, 30 Jul 2024 13:24:15 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chalapathi.v@linux.ibm.com>)
 id 1sYqa5-0006Kt-0t; Tue, 30 Jul 2024 13:24:14 -0400
Received: from pps.filterd (m0353726.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46UGQsMW017830;
 Tue, 30 Jul 2024 17:23:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from
 :to:cc:subject:date:message-id:mime-version:content-type
 :content-transfer-encoding; s=pp1; bh=9OhhQEAQT9u+cigoCOk2ZkY4P1
 yYi3PjmEYz0zY0c+E=; b=cz5ahfXqXBnMLlTQZgzfpEY4eqLrArcgCBpCT57yo0
 XhiGBSVyrqDbycoZudKp2E3CyABD2/1LXIdDW0SIHENzsGRqEypUKI2fP5WPKwMX
 oyB3v6s2COVDgeb0DcX60/lcgrH+JwHaaiJ/yEIYmq6gMWZRqmMs/1qpjmk0syb3
 6oeVRQp/PIlopNbSpDN5zANlwGpyBBOCI0pFIK0T6YNcoSbcHy7Ur2etLtr3cIW9
 7Pm+EMzgpQWeFBfy1V3cx5RYU8qa5/rCaKMlcCZ4O9Aj+6eI+Xkh3jBWduMccWRY
 pZ0Msk6cNsgYxA9b66S/IpPPuXCI5FWazTtVVmVudXbQ==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 40prr3aar5-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 30 Jul 2024 17:23:59 +0000 (GMT)
Received: from m0353726.ppops.net (m0353726.ppops.net [127.0.0.1])
 by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 46UHNxhj015599;
 Tue, 30 Jul 2024 17:23:59 GMT
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 40prr3aar1-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 30 Jul 2024 17:23:59 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 46UGUe1j007470; Tue, 30 Jul 2024 17:23:58 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 40nb7u6ch9-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 30 Jul 2024 17:23:58 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com
 [10.20.54.101])
 by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 46UHNqRm54984966
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 30 Jul 2024 17:23:54 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 8D39420043;
 Tue, 30 Jul 2024 17:23:52 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id A404920040;
 Tue, 30 Jul 2024 17:23:50 +0000 (GMT)
Received: from gfwr527.rchland.ibm.com (unknown [9.10.239.127])
 by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Tue, 30 Jul 2024 17:23:50 +0000 (GMT)
From: Chalapathi V <chalapathi.v@linux.ibm.com>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, fbarrat@linux.ibm.com, npiggin@gmail.com,
 clg@kaod.org, calebs@linux.ibm.com, chalapathi.v@ibm.com,
 chalapathi.v@linux.ibm.com, saif.abrar@linux.ibm.com,
 dantan@us.ibm.com, milesg@linux.ibm.com
Subject: [PATCH v6 0/6] hw/ppc: SPI model
Date: Tue, 30 Jul 2024 12:23:37 -0500
Message-Id: <20240730172343.5818-1-chalapathi.v@linux.ibm.com>
X-Mailer: git-send-email 2.39.3
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 2zWCp9WnhF1BvndFHgXqJ4udZadm26zE
X-Proofpoint-GUID: Usk9CuuvZLlXFrkzUts_z8oLrOIC1DhQ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-30_13,2024-07-30_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 impostorscore=0
 malwarescore=0 adultscore=0 mlxlogscore=531 suspectscore=0 bulkscore=0
 mlxscore=0 lowpriorityscore=0 clxscore=1015 phishscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2407110000 definitions=main-2407300115
Received-SPF: pass client-ip=148.163.156.1;
 envelope-from=chalapathi.v@linux.ibm.com; helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_MSPIKE_H3=-0.01,
 RCVD_IN_MSPIKE_WL=-0.01, SPF_HELO_NONE=0.001,
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

In patch v6 below issues detected during Coverity Scan were fixed.
- CID 1558831:  Resource leaks  (RESOURCE_LEAK)
  Variable "rsp_payload" going out of scope leaks the storage it points to.
- CID 1558827:    (OVERRUN)
  Overrunning array "s->seq_op" of 8 bytes at byte offset 16 using index
  "get_seq_index(s) + 1" (which evaluates to 16).

The qom-tree looks like below.
(qemu) info qom-tree 
/machine (powernv10-machine)
  /chip[0] (power10_v2.0-pnv-chip)
    /pib_spic[0] (pnv-spi)
      /pnv-spi-bus.0 (SSI)
      /xscom-spi[0] (memory-region)
    /pib_spic[1] (pnv-spi)
      /pnv-spi-bus.1 (SSI)
      /xscom-spi[0] (memory-region)
    /pib_spic[2] (pnv-spi)
      /pnv-spi-bus.2 (SSI)
      /xscom-spi[0] (memory-region)
    /pib_spic[3] (pnv-spi)
      /pnv-spi-bus.3 (SSI)
      /xscom-spi[0] (memory-region)
    /pib_spic[4] (pnv-spi)
      /pnv-spi-bus.4 (SSI)
      /xscom-spi[0] (memory-region)
    /pib_spic[5] (pnv-spi)
      /pnv-spi-bus.5 (SSI)
      /xscom-spi[0] (memory-region)

(qemu) info qom-tree 
/machine (powernv10-machine)
  /peripheral-anon (container)
    /device[0] (25csm04)
      /WP#[0] (irq)
      /ssi-gpio-cs[0] (irq)

Patches overview in v6.
PATCH1: Remove ppc target dependency from include/hw/ppc/pnv_xscom.h so
        that pnv_xscom.h can be included in hw/ssi/pnv_spi.c in PATCH2.
PATCH2: Create a PNV SPI model and implement configuration unit
        to model SCOM registers.
PATCH3: Extend PNV SPI model: implement sequencer FSM and shift engine.
PATCH4: Add Microchip's SEEPROM 25csm04 model on top of m25p80.
PATCH5: Connect SPI controllers to p10 chip and connect cs lines.
PATCH6: Write a qtest pnv-spi-seeprom-test to check the SPI transactions
        between spi controller and seeprom device.

Test covered:
make check
make check-avocado

Thank You,
Chalapathi

Chalapathi V (6):
  ppc/pnv: Remove ppc target dependency from pnv_xscom.h
  hw/ssi: Add SPI model
  hw/ssi: Extend SPI model
  hw/block: Add Microchip's 25CSM04 to m25p80
  hw/ppc: SPI controller wiring to P10 chip
  tests/qtest: Add pnv-spi-seeprom qtest

 include/hw/ppc/pnv_chip.h          |    3 +
 include/hw/ppc/pnv_xscom.h         |    5 +-
 include/hw/ssi/pnv_spi.h           |   67 ++
 include/hw/ssi/pnv_spi_regs.h      |  133 +++
 hw/block/m25p80.c                  |    3 +
 hw/ppc/pnv.c                       |   21 +-
 hw/ssi/pnv_spi.c                   | 1269 ++++++++++++++++++++++++++++
 tests/qtest/pnv-spi-seeprom-test.c |  110 +++
 hw/ppc/Kconfig                     |    3 +
 hw/ssi/Kconfig                     |    4 +
 hw/ssi/meson.build                 |    1 +
 hw/ssi/trace-events                |   21 +
 tests/qtest/meson.build            |    1 +
 13 files changed, 1639 insertions(+), 2 deletions(-)
 create mode 100644 include/hw/ssi/pnv_spi.h
 create mode 100644 include/hw/ssi/pnv_spi_regs.h
 create mode 100644 hw/ssi/pnv_spi.c
 create mode 100644 tests/qtest/pnv-spi-seeprom-test.c

-- 
2.39.3


