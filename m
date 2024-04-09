Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C862BC67861
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Apr 2024 17:58:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ruFiw-0007jj-7y; Tue, 09 Apr 2024 13:57:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chalapathi.v@linux.ibm.com>)
 id 1ruFik-0007iv-7p; Tue, 09 Apr 2024 13:57:22 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chalapathi.v@linux.ibm.com>)
 id 1ruFih-0004Sb-Gf; Tue, 09 Apr 2024 13:57:22 -0400
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 439HWY5U015948; Tue, 9 Apr 2024 17:57:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=77SlLTFw9mI524PnS3v5Y6Hj1bEaI8ph+rKdHmm2pPQ=;
 b=efGdc8jquzsUVFQv2GCDE4vNWMlEOKdTpBVHZCg63OryBihXFomDqF2kbP5o4THO6A1/
 sgIz0H3b8UCu5r/b6NaPRmbdr0w9x3hDbz0ywi5CqxZW604xl5P2vcixrHve6Eu5rljT
 BO1+8JeNvfOoAC7qU/OsMxcWp8eSE8h4cr6dzKIaL0/x8tPTLZ86woAf4MIcDn7Oqt01
 r2D4ulIW5cI3Fd/kPpzo3DCHP6MVQBaUQ7JCeGQhW5otf5ROX3r8J5Ujmsx27x99VCg8
 ZMED3OMP4JUQNa2kxacATxt6bsJsMmO+wAuuo82PPSY7pXfSFFp1F9+ffMQZdGAI/Pni JQ== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3xda5hr1qf-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 09 Apr 2024 17:57:13 +0000
Received: from m0356517.ppops.net (m0356517.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 439HvCEa021187;
 Tue, 9 Apr 2024 17:57:12 GMT
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3xda5hr1qe-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 09 Apr 2024 17:57:12 +0000
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 439H2CO4013544; Tue, 9 Apr 2024 17:57:11 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 3xbgqtg3ck-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 09 Apr 2024 17:57:11 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com
 [10.20.54.101])
 by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 439Hv6pI38339044
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 9 Apr 2024 17:57:08 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 34DCA2006F;
 Tue,  9 Apr 2024 17:57:06 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 7821420040;
 Tue,  9 Apr 2024 17:57:04 +0000 (GMT)
Received: from gfwr515.rchland.ibm.com (unknown [9.10.239.103])
 by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Tue,  9 Apr 2024 17:57:04 +0000 (GMT)
From: Chalapathi V <chalapathi.v@linux.ibm.com>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, fbarrat@linux.ibm.com, npiggin@gmail.com,
 clg@kaod.org, calebs@us.ibm.com, chalapathi.v@ibm.com,
 chalapathi.v@linux.ibm.com, saif.abrar@linux.vnet.ibm.com,
 dantan@us.ibm.com
Subject: [PATCH v2 0/6] hw/ppc: SPI model
Date: Tue,  9 Apr 2024 12:56:54 -0500
Message-Id: <20240409175700.27535-1-chalapathi.v@linux.ibm.com>
X-Mailer: git-send-email 2.39.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: hgXU3BkBABf-WkbuBouoOOH2ONRbbg75
X-Proofpoint-GUID: kA5ScnOv0DyGWAmGuxUo4yif8xIp3q3q
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-09_12,2024-04-09_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 mlxlogscore=628
 priorityscore=1501 bulkscore=0 adultscore=0 clxscore=1011 mlxscore=0
 impostorscore=0 suspectscore=0 spamscore=0 malwarescore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2404010000 definitions=main-2404090118
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

Thank You so much for reviewing patchset V1.

In PATCHSET V2, removed the PNV_SPI_RESPONDER model and an existing
QEMU SSI framework is used to model SPI BUS and SEEPROM model and
also most of Steve's comments have been addressed.
Also added the pnv-spi-seeprom qtest is added to test to check SPI
traffic between SPI controller and it's attached SEEPROM device.

The new qom-tree looks like below.
(qemu) info qom-tree 
/machine (powernv10-machine)
  /chip[0] (power10_v2.0-pnv-chip)
    /pib_spic[0] (pnv-spi-controller)
      /bus (pnv-spi-bus)
        /pnv-spi-bus.0 (SSI)
      /xscom-spi-controller-regs[0] (memory-region)
    /pib_spic[1] (pnv-spi-controller)
      /bus (pnv-spi-bus)
        /pnv-spi-bus.1 (SSI)
      /xscom-spi-controller-regs[0] (memory-region)
    /pib_spic[2] (pnv-spi-controller)
      /bus (pnv-spi-bus)
        /pnv-spi-bus.2 (SSI)
      /xscom-spi-controller-regs[0] (memory-region)
    /pib_spic[3] (pnv-spi-controller)
      /bus (pnv-spi-bus)
        /pnv-spi-bus.3 (SSI)
      /xscom-spi-controller-regs[0] (memory-region)
    /pib_spic[4] (pnv-spi-controller)
      /bus (pnv-spi-bus)
        /pnv-spi-bus.4 (SSI)
      /xscom-spi-controller-regs[0] (memory-region)
    /pib_spic[5] (pnv-spi-controller)
      /bus (pnv-spi-bus)
        /pnv-spi-bus.5 (SSI)
      /xscom-spi-controller-regs[0] (memory-region)

  /unattached (container)
    /device[7] (seeprom-25csm04)
      /ssi-gpio-cs[0] (irq)

Patches overview in V2.
PATCH1: Remove SPI responder model and used SSI framework instead.
PATCH2: Create a SPI controller model and implement configuration unit
        to model SCOM registers. Move register constants to a seperate
        header file pnv_spi_controller_regs.h
PATCH3: SPI controller model: implement sequencer FSM and shift engine.
PATCH4: Create a Microchip's SEEPROM 25csm04 model using SSI framework and
        move it hw/misc as it is not a power specific device. 
PATCH5: Connect SPI controllers to p10 chip and create keystore seeprom
        device of type "seeprom-25csm04" and connect cs line PIB_SPIC[2].
PATCH6: Write a qtest pnv-spi-seeprom-test to check the SPI transactions
        between spi controller and seeprom device.

Test covered:
Ran make check.

Thank You,
Chalapathi

Chalapathi V (6):
  hw/ppc: remove SPI responder model
  hw/ppc: SPI controller model - registers implementation
  hw/ppc: SPI controller model - sequencer and shifter
  hw/misc: Microchip's 25CSM04 SEEPROM model
  hw/ppc: SPI controller wiring to P10 chip and create seeprom device
  tests/qtest: Add pnv-spi-seeprom qtest

 include/hw/misc/seeprom_25csm04.h        |   48 +
 include/hw/ppc/pnv_chip.h                |    3 +
 include/hw/ppc/pnv_spi_controller.h      |  127 ++
 include/hw/ppc/pnv_spi_controller_regs.h |  114 ++
 include/hw/ppc/pnv_xscom.h               |    3 +
 hw/misc/seeprom_25csm04.c                |  780 +++++++++++
 hw/ppc/pnv.c                             |   36 +-
 hw/ppc/pnv_spi_controller.c              | 1587 ++++++++++++++++++++++
 tests/qtest/pnv-spi-seeprom-test.c       |  126 ++
 hw/misc/Kconfig                          |    3 +
 hw/misc/meson.build                      |    1 +
 hw/ppc/Kconfig                           |    2 +
 hw/ppc/meson.build                       |    1 +
 tests/qtest/meson.build                  |    1 +
 14 files changed, 2831 insertions(+), 1 deletion(-)
 create mode 100644 include/hw/misc/seeprom_25csm04.h
 create mode 100644 include/hw/ppc/pnv_spi_controller.h
 create mode 100644 include/hw/ppc/pnv_spi_controller_regs.h
 create mode 100644 hw/misc/seeprom_25csm04.c
 create mode 100644 hw/ppc/pnv_spi_controller.c
 create mode 100644 tests/qtest/pnv-spi-seeprom-test.c

-- 
2.39.3


