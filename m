Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3843C30659
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Jun 2024 09:06:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sMObF-0005nq-U1; Wed, 26 Jun 2024 05:05:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chalapathi.v@linux.ibm.com>)
 id 1sMObD-0005mc-H3; Wed, 26 Jun 2024 05:05:55 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chalapathi.v@linux.ibm.com>)
 id 1sMObB-0005oK-5m; Wed, 26 Jun 2024 05:05:55 -0400
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45Q8x9hA024415;
 Wed, 26 Jun 2024 09:05:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from
 :to:cc:subject:date:message-id:mime-version:content-type
 :content-transfer-encoding; s=pp1; bh=HP2FJm2c0CHWB1ddiJW5gN563V
 xWA/IughUqY9mcjUo=; b=f/pdQKfaXd352rIzkNYnlqaSDuFrpVpm46Ha11Etcd
 7hNuRZaMfc1ZW+af0oTKWSO9nZKcSNPSX3UlQFBGeQ+fuDkUBAv7O5LNJdN0ZFWF
 DXZUJ9yYdJGYEbLsGcGUP6hEXd4us5YBTSG5xQAZo1vJwleEBSSFk/G9nKaa4AFG
 yM47Z4mTwBA+eHJMa38YtY/BH58OmWz+ipVa9djJpx5JyZjQlqkFGFCNwUZy+ZUm
 D3kL5yhN96NB6/nedduFi7zILmAG60adeRmaBYpbk8NAoB5jxgEjC2ihk/8NeuoY
 l4AK2W3CbcQLFOoijYh2G/Q9g9NEtsvtMzen4z55ugBg==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 400fx9g0jk-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 26 Jun 2024 09:05:41 +0000 (GMT)
Received: from m0353729.ppops.net (m0353729.ppops.net [127.0.0.1])
 by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 45Q95ep3002552;
 Wed, 26 Jun 2024 09:05:40 GMT
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 400fx9g0jh-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 26 Jun 2024 09:05:40 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 45Q71nL6032373; Wed, 26 Jun 2024 09:05:40 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 3yxbn3ax4g-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 26 Jun 2024 09:05:39 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com
 [10.20.54.104])
 by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 45Q95YMA10551794
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 26 Jun 2024 09:05:36 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 405CD2004D;
 Wed, 26 Jun 2024 09:05:34 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 632242004B;
 Wed, 26 Jun 2024 09:05:32 +0000 (GMT)
Received: from gfwr527.rchland.ibm.com (unknown [9.10.239.127])
 by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Wed, 26 Jun 2024 09:05:32 +0000 (GMT)
From: Chalapathi V <chalapathi.v@linux.ibm.com>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, fbarrat@linux.ibm.com, npiggin@gmail.com,
 clg@kaod.org, calebs@us.ibm.com, chalapathi.v@ibm.com,
 chalapathi.v@linux.ibm.com, saif.abrar@linux.ibm.com,
 dantan@us.ibm.com, milesg@linux.ibm.com
Subject: [PATCH v5 0/6] hw/ppc: SPI model
Date: Wed, 26 Jun 2024 04:05:22 -0500
Message-Id: <20240626090528.812-1-chalapathi.v@linux.ibm.com>
X-Mailer: git-send-email 2.39.3
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: lDv0H6Uc24BN9FPiERmLVOVMnCrfv52E
X-Proofpoint-ORIG-GUID: mHp2tPWBFBg9l8SootWwYPIgd11Cw6tq
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-26_03,2024-06-25_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxlogscore=560 spamscore=0
 suspectscore=0 lowpriorityscore=0 phishscore=0 impostorscore=0
 malwarescore=0 priorityscore=1501 mlxscore=0 bulkscore=0 clxscore=1015
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2406140001 definitions=main-2406260062
Received-SPF: pass client-ip=148.163.156.1;
 envelope-from=chalapathi.v@linux.ibm.com; helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_MSPIKE_H3=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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

Thank You so much for reviewing patch v4.
In patch v5,
- Added a new commit to remove the dependency from include/hw/ppc/pnv_xscom.h
so that pnv_xscom.h can be included in hw/ssi/pnv_spi.c in PATCH2.
- General comments from Cedric and Glenn were addressed.

The new qom-tree looks like below.
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

Patches overview in v4.
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
 hw/ssi/pnv_spi.c                   | 1267 ++++++++++++++++++++++++++++
 tests/qtest/pnv-spi-seeprom-test.c |  110 +++
 hw/ppc/Kconfig                     |    3 +
 hw/ssi/Kconfig                     |    4 +
 hw/ssi/meson.build                 |    1 +
 hw/ssi/trace-events                |   21 +
 tests/qtest/meson.build            |    1 +
 13 files changed, 1637 insertions(+), 2 deletions(-)
 create mode 100644 include/hw/ssi/pnv_spi.h
 create mode 100644 include/hw/ssi/pnv_spi_regs.h
 create mode 100644 hw/ssi/pnv_spi.c
 create mode 100644 tests/qtest/pnv-spi-seeprom-test.c

-- 
2.39.3


