Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 353EBC2BB9A
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Jun 2024 16:56:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sJFdF-00082d-D8; Mon, 17 Jun 2024 12:55:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chalapathi.v@linux.ibm.com>)
 id 1sJFd5-000804-Oo; Mon, 17 Jun 2024 12:54:53 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chalapathi.v@linux.ibm.com>)
 id 1sJFd2-0000bG-9A; Mon, 17 Jun 2024 12:54:51 -0400
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45HGaPPM002028;
 Mon, 17 Jun 2024 16:54:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from
 :to:cc:subject:date:message-id:mime-version:content-type
 :content-transfer-encoding; s=pp1; bh=pxYChU6mAZ/I2vESvvTIwLyGMz
 TnrcZfUZ4poCH+QoA=; b=AdMIAArOi7WjdaVehigx8FcmQ6BE7Mhc9NSzbvGniq
 +crKY73HPBgykGYXWpS+8eMl0AFf2leU9QiihDjNEQI7E9VmDZhLvG9EhVSlisW1
 veyaWWY7p6UsgqU7oOh4Iwb+dY4OVH9oUK5eLfK/wlqzFC3i6j9ZM/81cNQILQXH
 aQQB13Xnv7RKjk8oNHmUjzbB9O3xUhLIhicMdWhGynDK6s85RzXfJOMD23iKXdt2
 9anMUcXXvAdx6UMaI/GQNLwCFGELM2D6KD7rj80fOOOjH6f5uaU+wH7Bz9kZ7PED
 r8PpKN2QA0DNao5ornl6lSw2Bh+g8sa0jrGrUknt8pGw==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3ytrpyg2m6-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 17 Jun 2024 16:54:37 +0000 (GMT)
Received: from m0356516.ppops.net (m0356516.ppops.net [127.0.0.1])
 by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 45HGrO1x031664;
 Mon, 17 Jun 2024 16:54:37 GMT
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3ytrpyg2m2-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 17 Jun 2024 16:54:37 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 45HFHxSJ019670; Mon, 17 Jun 2024 16:54:36 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3ysnp0v2y9-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 17 Jun 2024 16:54:36 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com
 [10.20.54.105])
 by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 45HGsUVo41681326
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 17 Jun 2024 16:54:32 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id A3E4920040;
 Mon, 17 Jun 2024 16:54:30 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id C9ECC20049;
 Mon, 17 Jun 2024 16:54:28 +0000 (GMT)
Received: from gfwr527.rchland.ibm.com (unknown [9.10.239.127])
 by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Mon, 17 Jun 2024 16:54:28 +0000 (GMT)
From: Chalapathi V <chalapathi.v@linux.ibm.com>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, fbarrat@linux.ibm.com, npiggin@gmail.com,
 clg@kaod.org, calebs@us.ibm.com, chalapathi.v@ibm.com,
 chalapathi.v@linux.ibm.com, saif.abrar@linux.ibm.com,
 dantan@us.ibm.com, milesg@linux.ibm.com
Subject: [PATCH v4 0/5] hw/ppc: SPI model
Date: Mon, 17 Jun 2024 11:54:14 -0500
Message-Id: <20240617165419.8388-1-chalapathi.v@linux.ibm.com>
X-Mailer: git-send-email 2.39.3
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: R1FlyxAWin6xSXwZFS0TaYxT08ZyUS9T
X-Proofpoint-GUID: 9oTh7EYIUPtEtqpdgXen1Ay9yNw3OpPN
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-17_14,2024-06-17_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 bulkscore=0
 clxscore=1015 mlxlogscore=603 spamscore=0 impostorscore=0 phishscore=0
 priorityscore=1501 adultscore=0 mlxscore=0 suspectscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2405170001 definitions=main-2406170131
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

Thank You so much for reviewing patch v3.
In patch v4, 
- Renamed hw/ppc/pnv_spi_controller.c to /hw/ssi/pnv_spi.c
- To improve the readability register/field names is shortened.
- SPI registers are put in array to simplify read/write method.
- In seeprom qtest generated the tmp_image to test SPI transactions
  between spi controller and seeprom device

The new qom-tree looks like below.
(qemu) info qom-tree 
/machine (powernv10-machine)
  /chip[0] (power10_v2.0-pnv-chip)
    /pib_spic[0] (pnv-spi)
      /pnv-spi-bus.0 (SSI)
      /xscom-spi-regs[0] (memory-region)
    /pib_spic[1] (pnv-spi)
      /pnv-spi-bus.1 (SSI)
      /xscom-spi-regs[0] (memory-region)
    /pib_spic[2] (pnv-spi)
      /pnv-spi-bus.2 (SSI)
      /xscom-spi-regs[0] (memory-region)
    /pib_spic[3] (pnv-spi)
      /pnv-spi-bus.3 (SSI)
      /xscom-spi-regs[0] (memory-region)
    /pib_spic[4] (pnv-spi)
      /pnv-spi-bus.4 (SSI)
      /xscom-spi-regs[0] (memory-region)
    /pib_spic[5] (pnv-spi)
      /pnv-spi-bus.5 (SSI)
      /xscom-spi-regs[0] (memory-region)

(qemu) info qom-tree 
/machine (powernv10-machine)
  /peripheral-anon (container)
    /device[0] (25csm04)
      /WP#[0] (irq)
      /ssi-gpio-cs[0] (irq)

Patches overview in v4.
PATCH1: Create a PNV SPI model and implement configuration unit
        to model SCOM registers.
PATCH2: Extend PNV SPI model: implement sequencer FSM and shift engine.
PATCH3: Add Microchip's SEEPROM 25csm04 model on top of m25p80.
PATCH4: Connect SPI controllers to p10 chip and connect cs lines.
PATCH5: Write a qtest pnv-spi-seeprom-test to check the SPI transactions
        between spi controller and seeprom device.

Test covered:
make check
make check-avocado

Thank You,
Chalapathi

Chalapathi V (5):
  ppc/pnv: Add SPI model
  ppc/pnv: Extend SPI model
  hw/block: Add Microchip's 25CSM04 to m25p80
  hw/ppc: SPI controller wiring to P10 chip
  tests/qtest: Add pnv-spi-seeprom qtest

 include/hw/ppc/pnv_chip.h          |    3 +
 include/hw/ppc/pnv_xscom.h         |    5 +-
 include/hw/ssi/pnv_spi.h           |   86 ++
 include/hw/ssi/pnv_spi_regs.h      |  114 +++
 hw/block/m25p80.c                  |    3 +
 hw/ppc/pnv.c                       |   21 +-
 hw/ssi/pnv_spi.c                   | 1249 ++++++++++++++++++++++++++++
 tests/qtest/pnv-spi-seeprom-test.c |  110 +++
 hw/ppc/Kconfig                     |    3 +
 hw/ssi/Kconfig                     |    4 +
 hw/ssi/meson.build                 |    1 +
 hw/ssi/trace-events                |   21 +
 tests/qtest/meson.build            |    1 +
 13 files changed, 1619 insertions(+), 2 deletions(-)
 create mode 100644 include/hw/ssi/pnv_spi.h
 create mode 100644 include/hw/ssi/pnv_spi_regs.h
 create mode 100644 hw/ssi/pnv_spi.c
 create mode 100644 tests/qtest/pnv-spi-seeprom-test.c

-- 
2.39.3


