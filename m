Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B9BEC4828D
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Feb 2024 16:10:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rXkTz-0003d9-Pz; Wed, 07 Feb 2024 11:09:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chalapathi.v@linux.ibm.com>)
 id 1rXkTy-0003cW-J7; Wed, 07 Feb 2024 11:09:06 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chalapathi.v@linux.ibm.com>)
 id 1rXkTx-0000cJ-2b; Wed, 07 Feb 2024 11:09:06 -0500
Received: from pps.filterd (m0353723.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 417FTiEH018520; Wed, 7 Feb 2024 16:08:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=HYZEQs2+hlaIXt6gfP6+BJ104LBMfnN57cpmzTyu2Ns=;
 b=TxGGzy88aWbF4FjQYpAg8uC+wzP1HwEFZW2n/JDJtWnXOmJG33gNbrQ7NlmmIl4/kWY8
 zUr3ONjv7+RDupUz1Jr6nibcY5f3gzzdlgU0SQRaUaMPhMMo3CxDQm8xsH2JMYG19xXW
 iIzo4J6PH0piyiNb62FsA/FyAv4Sp9CdmxVZwhcFmOrt0WgmLZDKKBevXT0Jq+K6GHFA
 UUuxYlJd62WyIfi2Vm+vZTBreA1Byk+wzTLFYgDp3p9Ff0/QcnhGIH52RvtxQzepysy5
 p1MX6myyN5LbWKkZWq2hTxxlGaI/E0JsMOrBQ0QEXvH+KiJ/NoTfvGAa5sPgbefAVeHa Rw== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3w4cj6h4kk-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 07 Feb 2024 16:08:49 +0000
Received: from m0353723.ppops.net (m0353723.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 417FTu0W019733;
 Wed, 7 Feb 2024 16:08:48 GMT
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3w4cj6h4kb-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 07 Feb 2024 16:08:48 +0000
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 417E3Tuh014761; Wed, 7 Feb 2024 16:08:48 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3w20tnxqje-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 07 Feb 2024 16:08:48 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com
 [10.20.54.100])
 by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 417G8isB28508890
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 7 Feb 2024 16:08:45 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id DF81E2004B;
 Wed,  7 Feb 2024 16:08:44 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 3DBAA20040;
 Wed,  7 Feb 2024 16:08:43 +0000 (GMT)
Received: from gfwr515.rchland.ibm.com (unknown [9.10.239.103])
 by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Wed,  7 Feb 2024 16:08:43 +0000 (GMT)
From: Chalapathi V <chalapathi.v@linux.ibm.com>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, fbarrat@linux.ibm.com, npiggin@gmail.com,
 clg@kaod.org, calebs@us.ibm.com, chalapathi.v@ibm.com,
 chalapathi.v@linux.ibm.com, saif.abrar@linux.vnet.ibm.com
Subject: [PATCH v1 0/5] hw/ppc: SPI model
Date: Wed,  7 Feb 2024 10:08:28 -0600
Message-Id: <20240207160833.3437779-1-chalapathi.v@linux.ibm.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: zrCBmPI5JvXmlJ0Db-YzOhXry2D8oJ55
X-Proofpoint-ORIG-GUID: QDGOYR1b1F4cM9ISPSovHRKwNrtxFJ-N
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-07_06,2024-02-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=17
 clxscore=1011 mlxscore=17
 lowpriorityscore=0 impostorscore=0 mlxlogscore=69 priorityscore=1501
 suspectscore=0 spamscore=17 adultscore=0 malwarescore=0 bulkscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2402070119
Received-SPF: pass client-ip=148.163.158.5;
 envelope-from=chalapathi.v@linux.ibm.com; helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

In this series of patchset, SPI controller and responder models
for Power10 processor are modelled.

Serial peripheral interface provides full-duplex synchronous serial
communication between single controller and multiple responder devices.

The current configuration supports a single SPI controller reside on the
SPI bus. In p10, SPI controller device model supports a connection to a
single SPI responder such as SPI seeproms, TPM, flash device and an ADC
controller.

SPI controller model is divided into configuration unit, sequencer FSM
and shifter engine. All SPI function control is mapped into the SPI register
space to enable full control by firmware.

SPI configuration component is modelled which contains all SPI configuration
and status registers as well as the hold registers for data to be sent or
having been received.
Shift engine performs serialization and de-serialization according to the
control by the sequencer and according to the setup defined in the
configuration registers.
Sequencer implements the main control logic and
FSM to handle data transmit and data receive control of the shift engine.

Microchip's 25CSM04 SEEPROM device is modelled and connected to SPI bus
"spi_bus2" of SPI controller "PIB_SPIC[2]".

Patches overview in V1.
PATCH1: Create a SPI responder model which includes responder methods
        and SPI bus implementation.
PATCH2: Create a SPI controller model and implement configuration unit
        to model SCOM registers.
PATCH3: SPI controller model: implement sequencer FSM and shift engine.
PATCH4: create SPI SEEPROM model.
PATCH5: Connect SPI controllers to p10 chip and create keystore seeprom
        device on spi_bus2 of PIB_SPIC[2].

Thank You,
Chalapathi

Chalapathi V (5):
  hw/ppc: SPI responder model
  hw/ppc: SPI controller model - registers implementation
  hw/ppc: SPI controller model - sequencer and shifter
  hw/ppc: SPI SEEPROM model
  hw/ppc: SPI controller wiring to P10 chip and create seeprom device

 include/hw/ppc/pnv_chip.h           |    4 +
 include/hw/ppc/pnv_spi_controller.h |  101 ++
 include/hw/ppc/pnv_spi_responder.h  |  109 ++
 include/hw/ppc/pnv_spi_seeprom.h    |   70 ++
 include/hw/ppc/pnv_xscom.h          |    3 +
 hw/ppc/pnv.c                        |   32 +
 hw/ppc/pnv_spi_controller.c         | 1609 +++++++++++++++++++++++++++
 hw/ppc/pnv_spi_responder.c          |  166 +++
 hw/ppc/pnv_spi_seeprom.c            |  989 ++++++++++++++++
 hw/ppc/meson.build                  |    3 +
 10 files changed, 3086 insertions(+)
 create mode 100644 include/hw/ppc/pnv_spi_controller.h
 create mode 100644 include/hw/ppc/pnv_spi_responder.h
 create mode 100644 include/hw/ppc/pnv_spi_seeprom.h
 create mode 100644 hw/ppc/pnv_spi_controller.c
 create mode 100644 hw/ppc/pnv_spi_responder.c
 create mode 100644 hw/ppc/pnv_spi_seeprom.c

-- 
2.31.1


