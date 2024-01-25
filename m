Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F7D7C47258
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jan 2024 22:49:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rT8Wn-00074e-4q; Thu, 25 Jan 2024 17:48:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <milesg@linux.vnet.ibm.com>)
 id 1rT8Wl-00074M-6N; Thu, 25 Jan 2024 17:48:55 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <milesg@linux.vnet.ibm.com>)
 id 1rT8Wj-0000ND-Bk; Thu, 25 Jan 2024 17:48:54 -0500
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 40PMR7Bn026397; Thu, 25 Jan 2024 22:48:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=from : to : cc : subject
 : date : message-id : mime-version : content-type :
 content-transfer-encoding; s=pp1;
 bh=bVbceKt4SqlyC9nkzIWub92dMHSmnrI5MtUJ9MQoy/M=;
 b=RR/gvTFvLeMj+NkuURqXkAz2lB66AGY/GwqP03HzKbdc2TDlGOC29mg0UEBodCylwcPW
 wEhZcSp1Ozo38/TngsOxDIl8oFqudOQEC1nJyYgKBiFz5r6sLk4Z1iRHGMVe96Gl50t7
 YlvvNoCKeBjZFup5PKgFJVkv7IcXVUVW33SGEHNXd+qb7ShE/r1c59z9NzbJ6nnnOhk6
 +bBDLbiQXBe2pKo/njaykgU45/g2Wt3DpXNQN2LtVxEqlidMmgeXlSzs9s85RRv3aJbB
 fV2WK3tQVRdd+ObCZ4/YCjXVJlG9sVMAIn3iaJRKtxiKmpVNM61rVz+u1BMhQ74TCtgW Iw== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3vv0eq0e8p-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 25 Jan 2024 22:48:47 +0000
Received: from m0356517.ppops.net (m0356517.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 40PMRBqQ026428;
 Thu, 25 Jan 2024 22:48:47 GMT
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3vv0eq0e8b-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 25 Jan 2024 22:48:46 +0000
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 40PK5AF1028240; Thu, 25 Jan 2024 22:48:46 GMT
Received: from smtprelay04.dal12v.mail.ibm.com ([172.16.1.6])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 3vru72xnr5-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 25 Jan 2024 22:48:46 +0000
Received: from smtpav01.dal12v.mail.ibm.com (smtpav01.dal12v.mail.ibm.com
 [10.241.53.100])
 by smtprelay04.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 40PMmjId10486354
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 25 Jan 2024 22:48:45 GMT
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 7509458057;
 Thu, 25 Jan 2024 22:48:45 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 494DA58058;
 Thu, 25 Jan 2024 22:48:45 +0000 (GMT)
Received: from mamboa4.aus.stglabs.ibm.com (unknown [9.3.84.87])
 by smtpav01.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Thu, 25 Jan 2024 22:48:45 +0000 (GMT)
From: Glenn Miles <milesg@linux.vnet.ibm.com>
To: qemu-devel@nongnu.org, qemu-ppc@nongnu.org
Cc: Glenn Miles <milesg@linux.vnet.ibm.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Nicholas Piggin <npiggin@gmail.com>,
 =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Barrat?= <fbarrat@linux.ibm.com>,
 Reza Arbab <arbab@linux.ibm.com>
Subject: [PATCH v7 0/9] Add powernv10 I2C devices and tests
Date: Thu, 25 Jan 2024 16:48:09 -0600
Message-Id: <20240125224818.146499-1-milesg@linux.vnet.ibm.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: tmEvvO5n8rnciOkBJPdhP6VX5nY1Nldr
X-Proofpoint-ORIG-GUID: 7RMJFrbwROLVBUu4U2E8WrrV1a4nsj3G
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-25_14,2024-01-25_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 impostorscore=0
 suspectscore=0 priorityscore=1501 clxscore=1011 adultscore=0 mlxscore=0
 spamscore=0 mlxlogscore=832 malwarescore=0 phishscore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2401250164
Received-SPF: none client-ip=148.163.156.1;
 envelope-from=milesg@linux.vnet.ibm.com; helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001, SPF_NONE=0.001,
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

This series of patches includes support, tests and fixes for
adding PCA9552 and PCA9554 I2C devices to the powernv10 chip.

The PCA9552 device is used for PCIe slot hotplug power control
and monitoring, while the PCA9554 device is used for presence
detection of IBM CableCard devices.  Both devices are required
by the Power Hypervisor Firmware on the Power10 Ranier platform.

Changes from previous version:
  - Made several changes to commit 9/9 to address comments from
    Cédric.
  - Added new PnvI2cCtlr struct to commit 9/9 for convenience in
    passing parameters.

Glenn Miles (9):
  misc/pca9552: Fix inverted input status
  misc/pca9552: Let external devices set pca9552 inputs
  ppc/pnv: New powernv10-rainier machine type
  ppc/pnv: Add pca9552 to powernv10-rainier for PCIe hotplug power
    control
  ppc/pnv: Wire up pca9552 GPIO pins for PCIe hotplug power control
  ppc/pnv: Use resettable interface to reset child I2C buses
  misc: Add a pca9554 GPIO device model
  ppc/pnv: Add a pca9554 I2C device to powernv10-rainier
  ppc/pnv: Test pnv i2c master and connected devices

 MAINTAINERS                     |  10 +-
 hw/misc/Kconfig                 |   4 +
 hw/misc/meson.build             |   1 +
 hw/misc/pca9552.c               |  58 +++-
 hw/misc/pca9554.c               | 328 +++++++++++++++++++++
 hw/ppc/Kconfig                  |   2 +
 hw/ppc/pnv.c                    |  67 ++++-
 hw/ppc/pnv_i2c.c                | 146 +---------
 include/hw/i2c/pnv_i2c_regs.h   | 143 ++++++++++
 include/hw/misc/pca9552.h       |   3 +-
 include/hw/misc/pca9554.h       |  36 +++
 include/hw/misc/pca9554_regs.h  |  19 ++
 include/hw/ppc/pnv.h            |   1 +
 tests/qtest/meson.build         |   1 +
 tests/qtest/pca9552-test.c      |   6 +-
 tests/qtest/pnv-host-i2c-test.c | 491 ++++++++++++++++++++++++++++++++
 tests/qtest/pnv-xscom-test.c    |  61 +---
 tests/qtest/pnv-xscom.h         |  80 ++++++
 18 files changed, 1251 insertions(+), 206 deletions(-)
 create mode 100644 hw/misc/pca9554.c
 create mode 100644 include/hw/i2c/pnv_i2c_regs.h
 create mode 100644 include/hw/misc/pca9554.h
 create mode 100644 include/hw/misc/pca9554_regs.h
 create mode 100644 tests/qtest/pnv-host-i2c-test.c
 create mode 100644 tests/qtest/pnv-xscom.h

-- 
2.31.1


