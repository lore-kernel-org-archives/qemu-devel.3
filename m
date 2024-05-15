Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93F33C25B75
	for <qemu-devel@archiver.kernel.org>; Wed, 15 May 2024 17:43:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s7Idw-0000zy-Cj; Wed, 15 May 2024 13:42:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chalapathi.v@linux.ibm.com>)
 id 1s7Idt-0000zQ-KF; Wed, 15 May 2024 13:42:17 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chalapathi.v@linux.ibm.com>)
 id 1s7Idr-0006Tz-I0; Wed, 15 May 2024 13:42:17 -0400
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 44FHbEkt025135; Wed, 15 May 2024 17:42:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=tITW5+dZoE+AgFBjFuhExr0kqZoQaFlCLtDdWHK+bsA=;
 b=HQJOg2EeZOYbMb8B7Dw8OOiCSY9MnoE2hRULSqoW2cDkC20LD8DPfciHXPptXLMX2ZYV
 YKYwMJiBp91CYuJ+4VLaDG+CMbFLG04zmS1p5mCeCYinzoG2YOxz6eEP3qXmOY8y56L2
 4LyNtmd6mx1GKCMyZoAcrnbryTxlhGUAxEBevFWLJ9sqf/9IwTyFnF5/sOSThslZmRxo
 SUFf4v9he2wyqkzZ5qJ6NMj+u9ds2jti+kmSSmYxKdke2BYecl6+rciFB1lV0ZL8Pus7
 o6crHReD5rkJVNGad8qCeGZjoGSTFc+2bxkCCpBbRdjbRN8XW5C6xyVzPjzhv7oOgCfW rg== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3y51kug09e-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 15 May 2024 17:42:04 +0000
Received: from m0356517.ppops.net (m0356517.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 44FHg390032233;
 Wed, 15 May 2024 17:42:03 GMT
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3y51kug09d-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 15 May 2024 17:42:03 +0000
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 44FFgTX9005986; Wed, 15 May 2024 17:42:02 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3y2mgmmvxj-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 15 May 2024 17:42:02 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com
 [10.20.54.101])
 by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 44FHfukW55837082
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 15 May 2024 17:41:58 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 1DAE42004E;
 Wed, 15 May 2024 17:41:56 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 3579C2004B;
 Wed, 15 May 2024 17:41:54 +0000 (GMT)
Received: from gfwr515.rchland.ibm.com (unknown [9.10.239.103])
 by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Wed, 15 May 2024 17:41:54 +0000 (GMT)
From: Chalapathi V <chalapathi.v@linux.ibm.com>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, fbarrat@linux.ibm.com, npiggin@gmail.com,
 clg@kaod.org, calebs@us.ibm.com, chalapathi.v@ibm.com,
 chalapathi.v@linux.ibm.com, saif.abrar@linux.vnet.ibm.com,
 dantan@us.ibm.com, milesg@linux.vnet.ibm.com
Subject: [PATCH v3 0/5] hw/ppc: SPI model
Date: Wed, 15 May 2024 12:41:44 -0500
Message-Id: <20240515174149.17713-1-chalapathi.v@linux.ibm.com>
X-Mailer: git-send-email 2.39.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: R0_3ZdE4xqD5b4J8EKXKQQF8KlarRXdw
X-Proofpoint-ORIG-GUID: arI6inhMMH7fNuOhKL6Yo7it7uh5s4de
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-05-15_10,2024-05-15_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 bulkscore=0
 lowpriorityscore=0 adultscore=0 mlxlogscore=618 malwarescore=0
 clxscore=1011 impostorscore=0 mlxscore=0 priorityscore=1501 spamscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2405010000 definitions=main-2405150125
Received-SPF: pass client-ip=148.163.156.1;
 envelope-from=chalapathi.v@linux.ibm.com; helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_MSPIKE_H4=0.001,
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

Thank You so much for reviewing patch v2.
In patch v3, most of Cedric's comments are addressed.
- PnvSPIBus model is removed and added SSIBus to PnvSpiController.
- Added trace-events and removed SPI_DEBUG macro.
- Added Microchip's 25csm04 device on top of m25p80 and create seeprom
  device from a command line.
- Use qdev_connect_gpio_out_named instead of sysbus_connect_irq to
  connect cs.

The new qom-tree looks like below.
(qemu) info qom-tree 
/machine (powernv10-machine)
  /chip[0] (power10_v2.0-pnv-chip)
    /pib_spic[0] (pnv-spi-controller)
      /pnv-spi-bus.0 (SSI)
      /xscom-spi-controller-regs[0] (memory-region)
    /pib_spic[1] (pnv-spi-controller)
      /pnv-spi-bus.1 (SSI)
      /xscom-spi-controller-regs[0] (memory-region)
    /pib_spic[2] (pnv-spi-controller)
      /pnv-spi-bus.2 (SSI)
      /xscom-spi-controller-regs[0] (memory-region)
    /pib_spic[3] (pnv-spi-controller)
      /pnv-spi-bus.3 (SSI)
      /xscom-spi-controller-regs[0] (memory-region)
    /pib_spic[4] (pnv-spi-controller)
      /pnv-spi-bus.4 (SSI)
      /xscom-spi-controller-regs[0] (memory-region)
    /pib_spic[5] (pnv-spi-controller)
      /pnv-spi-bus.5 (SSI)
      /xscom-spi-controller-regs[0] (memory-region)

(qemu) info qom-tree 
/machine (powernv10-machine)
  /peripheral-anon (container)
    /device[0] (25csm04)
      /WP#[0] (irq)
      /ssi-gpio-cs[0] (irq)

Patches overview in v3.
PATCH1: Create a SPI controller model and implement configuration unit
        to model SCOM registers. Move header files to include/hw/ssi/
PATCH2: SPI controller model: implement sequencer FSM and shift engine.
PATCH3: Add Microchip's SEEPROM 25csm04 model on top of m25p80.
PATCH4: Connect SPI controllers to p10 chip and connect cs lines.
PATCH5: Write a qtest pnv-spi-seeprom-test to check the SPI transactions
        between spi controller and seeprom device.

Test covered:
Ran make check.

Thank You,
Chalapathi

Chalapathi V (5):
  ppc/pnv: Add SPI controller model
  ppc/pnv: Extend SPI model
  hw/block: Add Microchip's 25CSM04 to m25p80
  hw/ppc: SPI controller wiring to P10 chip
  tests/qtest: Add pnv-spi-seeprom qtest

 include/hw/ppc/pnv_chip.h          |    3 +
 include/hw/ppc/pnv_xscom.h         |    3 +
 include/hw/ssi/pnv_spi.h           |   72 ++
 include/hw/ssi/pnv_spi_regs.h      |  114 +++
 hw/block/m25p80.c                  |    3 +
 hw/ppc/pnv.c                       |   21 +-
 hw/ppc/pnv_spi_controller.c        | 1310 ++++++++++++++++++++++++++++
 tests/qtest/pnv-spi-seeprom-test.c |  129 +++
 hw/ppc/Kconfig                     |    2 +
 hw/ppc/meson.build                 |    1 +
 hw/ppc/trace-events                |   21 +
 tests/qtest/meson.build            |    1 +
 12 files changed, 1679 insertions(+), 1 deletion(-)
 create mode 100644 include/hw/ssi/pnv_spi.h
 create mode 100644 include/hw/ssi/pnv_spi_regs.h
 create mode 100644 hw/ppc/pnv_spi_controller.c
 create mode 100644 tests/qtest/pnv-spi-seeprom-test.c

-- 
2.39.3


