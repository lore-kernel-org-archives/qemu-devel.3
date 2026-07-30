Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55573C5516E
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jul 2026 20:11:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wpX5T-0004Uy-SV; Thu, 30 Jul 2026 16:10:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mikail.sadic@ibm.com>)
 id 1wpX5R-0004SC-Ol; Thu, 30 Jul 2026 16:10:37 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mikail.sadic@ibm.com>)
 id 1wpX5P-0001i4-GY; Thu, 30 Jul 2026 16:10:37 -0400
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66UJle9G3975760; Thu, 30 Jul 2026 20:09:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=8Aux4Nt9AqJZJwSbt
 1118cnbfcrSHGWwBveD1cl72L4=; b=eKU1QP189Hve0OkjCKq0TTpV94km0XP5W
 ozMfz/Z4X81qbdTg6DKT0Ofvqj8+jubkG47i0kpX1QspphScmdenblX0dBBzxW9U
 RpAx34l1VL8l+r6gS7T86LMnhMifipxt7UsFyKlx5L7eu9injFpB8jIJYBZJNwcT
 CPKP5yq+a7jmpmUWKY/zVQlR+rTfvni1wqsAUsJFSruLD0Uykft19wYsfC1+y6th
 jfZZRiG+vsJcqlscxlsLPHhv1VdDK2W1/J/cvEybCd5MiXHriAW6ez5oOuItmjBx
 tdtkso4nr32BO8SR3oZTQ5Wi3VlR4ipN2pJgG3LpzPOiC/shb5cDQ==
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fmv0y1qqg-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 30 Jul 2026 20:09:51 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66UJuGf4005613;
 Thu, 30 Jul 2026 20:09:50 GMT
Received: from smtprelay06.wdc07v.mail.ibm.com ([172.16.1.73])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fn8yhmv4j-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 30 Jul 2026 20:09:50 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (smtpav06.dal12v.mail.ibm.com
 [10.241.53.105])
 by smtprelay06.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 66UK9nb89896568
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 30 Jul 2026 20:09:49 GMT
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 44C4C58043;
 Thu, 30 Jul 2026 20:09:49 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id DF47E58059;
 Thu, 30 Jul 2026 20:09:48 +0000 (GMT)
Received: from IBM-MFS.atx-us.ibm.com (unknown [9.16.49.87])
 by smtpav06.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Thu, 30 Jul 2026 20:09:48 +0000 (GMT)
From: Mikail Sadic <mikail.sadic@ibm.com>
To: clg@kaod.org, peter.maydell@linaro.org
Cc: Mikail Sadic <mikail.sadic@ibm.com>, pbonzini@redhat.com,
 ninad@linux.ibm.com, titusr@google.com, jeuk20.kim@samsung.com,
 philmd@mailo.com, steven_lee@aspeedtech.com, leetroy@gmail.com,
 jamin_lin@aspeedtech.com, kane_chen@aspeedtech.com,
 andrew@codeconstruct.com.au, joel@jms.id.au, calebs@linux.ibm.com,
 milesg@linux.ibm.com, qemu-arm@nongnu.org, qemu-devel@nongnu.org
Subject: [PATCH v2 5/8] hw/sensor: Add UCD90320 model
Date: Thu, 30 Jul 2026 15:09:40 -0500
Message-ID: <20260730200945.1113936-6-mikail.sadic@ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260730200945.1113936-1-mikail.sadic@ibm.com>
References: <20260730200945.1113936-1-mikail.sadic@ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-GUID: Gdo-mcPwe46Wa9Bj2ydwhVwMQWf-aEgn
X-Proofpoint-ORIG-GUID: f-FEj2txod8zBAmV_phaVn5IrIpRRcV7
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzMwMDE0NSBTYWx0ZWRfXw5b/kJqe1rJT
 8RMv5edOauWikFumpzUo1be2QkleyflCL71fuyUp+BzIIBPd4Mt9TF4mk9fmi56C9ZHDr2dUeoL
 9Q1NlB1w3n5/BB1kY/QAd9ymCO/Z+iY=
X-Authority-Analysis: v=2.4 cv=dYuwG3Xe c=1 sm=1 tr=0 ts=6a6baf90 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8 a=YwPlQgHYUhtu6dumBzMA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzMwMDE0NSBTYWx0ZWRfXzvV6hLmdfO9h
 KWrWgKwXSwF1Z5qG0wZM6d914W+lFePYcuiQGnJB/FRVRhKn3aW94cvRaTavmmaSEGhHWiJG9qa
 clg+Fye2ZpGcFK+bUYWGI+44DIlVVaXnAF4y8XwsnDT3qWVg+S8j9ctnwXpqJ65V+U02LA/xjUN
 rnNf6G/UZRxZhbLdsfh7U8wl3T8oUgoS2uolTXEsF9JXijQr6Vx8kXUaqiXDA0x8B7y3wrMqYV+
 GM0TIe0L3HPzINNztkCNrz8eX57hCaxezelCBQK/rGCFYkUj1y+FbxZ/tN4yrZNkil7YoWQmEq6
 1vRfAf2rD90BL/iQp9D2qfgXOzKjyX0CptOQC5X1TkNonV4RFR0/JjIkR2+ARx9nvNt9bS2H9rg
 CoiV4xbTIRLJ+k2jiPCYa4sP0udVJhvVdcm39SM9KIiePkN/xl/gzjY7DGS4joU/+n7MaWb95FK
 gHoUNNg91ffOJw3WY0g==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-30_06,2026-07-30_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 clxscore=1015 phishscore=0 malwarescore=0
 spamscore=0 lowpriorityscore=0 bulkscore=0 suspectscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607300145
Received-SPF: pass client-ip=148.163.156.1; envelope-from=mikail.sadic@ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Add a PMBus device model for the TI-UCD90320 24-rail power
sequencer. Configures 24 pages with linear vout mode and responds to
the vendor-specific UCD9000_DEVICE_ID, NUM_PAGES, MONITOR_CONFIG, and
MFR_STATUS commands, allowing the Linux ucd9000 driver to bind and
create hwmon sysfs entries.

Signed-off-by: Mikail Sadic <mikail.sadic@ibm.com>
---
 MAINTAINERS             |   1 +
 docs/specs/index.rst    |   1 +
 docs/specs/ucd90320.rst |  36 +++++++++
 hw/sensor/ucd90320.c    | 169 ++++++++++++++++++++++++++++++++++++++++
 hw/arm/Kconfig          |   1 +
 hw/sensor/Kconfig       |   4 +
 hw/sensor/meson.build   |   1 +
 7 files changed, 213 insertions(+)
 create mode 100644 docs/specs/ucd90320.rst
 create mode 100644 hw/sensor/ucd90320.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 902db77218..ec415cb8e4 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -4063,6 +4063,7 @@ F: hw/i2c/pmbus_device.c
 F: hw/sensor/adm1272.c
 F: hw/sensor/isl_pmbus_vr.c
 F: hw/sensor/max34451.c
+F: hw/sensor/ucd90320.c
 F: include/hw/i2c/pmbus_device.h
 F: include/hw/sensor/isl_pmbus_vr.h
 F: tests/qtest/adm1272-test.c
diff --git a/docs/specs/index.rst b/docs/specs/index.rst
index b7909a108a..4de65e2fdf 100644
--- a/docs/specs/index.rst
+++ b/docs/specs/index.rst
@@ -39,4 +39,5 @@ guest hardware that is specific to QEMU.
    riscv-iommu
    riscv-aia
    aspeed-intc
+   ucd90320
    iommu-testdev
diff --git a/docs/specs/ucd90320.rst b/docs/specs/ucd90320.rst
new file mode 100644
index 0000000000..fdc0878c75
--- /dev/null
+++ b/docs/specs/ucd90320.rst
@@ -0,0 +1,36 @@
+Texas Instruments UCD90320 Power Sequencer
+==========================================
+
+The UCD90320 is a 24-rail PMBus power sequencer. QEMU models it as a PMBus
+device (``"ucd90320"``) so the Linux ``ucd9000`` driver can bind and create
+``hwmon`` sysfs entries.
+
+The model configures 24 PMBus pages (one per rail) with ``VOUT_MODE = 0x00``
+(linear, exponent 0). ``READ_VOUT`` and ``MFR_STATUS`` return zero on all
+pages.
+
+Vendor-specific commands handled:
+
++------+---------------------------+--------------------------------------------+
+| Code | Name                      | Response                                   |
++======+===========================+============================================+
+| 0xD5 | ``UCD9000_MONITOR_CONFIG``| Block: one byte ``0x00``                   |
++------+---------------------------+--------------------------------------------+
+| 0xD6 | ``UCD9000_NUM_PAGES``     | Byte: ``24``                               |
++------+---------------------------+--------------------------------------------+
+| 0xF3 | ``UCD9000_MFR_STATUS``    | Block: four bytes ``0x00 0x00 0x00 0x00``  |
++------+---------------------------+--------------------------------------------+
+| 0xFD | ``UCD9000_DEVICE_ID``     | Block: ASCII string ``"UCD90320"``         |
++------+---------------------------+--------------------------------------------+
+
+``DEVICE_ID`` uses the vendor-specific code ``0xFD`` rather than the standard
+``PMBUS_IC_DEVICE_ID`` (``0xAD``), matching the Linux ``ucd9000`` probe
+sequence.
+
+The UCD90320 is instantiated automatically in the ``huygens-bmc`` machine on
+I2C bus 5 at address ``0x11``. To instantiate on a different Aspeed machine:
+
+.. code-block:: c
+
+  i2c_slave_create_simple(aspeed_i2c_get_bus(&soc->i2c, 5),
+                          "ucd90320", 0x11);
diff --git a/hw/sensor/ucd90320.c b/hw/sensor/ucd90320.c
new file mode 100644
index 0000000000..6d4f828448
--- /dev/null
+++ b/hw/sensor/ucd90320.c
@@ -0,0 +1,169 @@
+/*
+ * Texas Instruments UCD90320 24-Rail PMBus Power Sequencer
+ *
+ * Copyright 2026 IBM Corp.
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include "qemu/osdep.h"
+#include "hw/i2c/pmbus_device.h"
+#include "migration/vmstate.h"
+#include "qemu/log.h"
+#include "qemu/module.h"
+
+#define TYPE_UCD90320 "ucd90320"
+
+/* UCD90320 has 24 sequenced power-rail pages */
+#define UCD90320_NUM_PAGES 24
+
+/* Vendor-specific command codes (not in the standard PMBus register table) */
+#define UCD9000_MONITOR_CONFIG  0xd5
+#define UCD9000_NUM_PAGES       0xd6
+#define UCD9000_MFR_STATUS      0xf3
+#define UCD9000_DEVICE_ID       0xfd
+
+#define UCD90320_DEVICE_ID_LEN     8
+#define UCD90320_MFR_STATUS_LEN    4
+
+typedef struct UCD90320State {
+    PMBusDevice parent;
+
+    /* Reset values for the vendor-specific block-read commands. */
+    uint8_t device_id[UCD90320_DEVICE_ID_LEN];
+    uint8_t monitor_config;
+    uint8_t mfr_status[UCD90320_MFR_STATUS_LEN];
+} UCD90320State;
+
+#define UCD90320(obj) OBJECT_CHECK(UCD90320State, (obj), TYPE_UCD90320)
+
+static void ucd90320_send_block(PMBusDevice *pmdev,
+                                const uint8_t *data, uint8_t len)
+{
+    int i;
+
+    pmdev->out_buf[len + pmdev->out_buf_len] = len;
+    for (i = len - 1; i >= 0; i--) {
+        pmdev->out_buf[i + pmdev->out_buf_len] = data[len - 1 - i];
+    }
+    pmdev->out_buf_len += len + 1;
+}
+
+static uint8_t ucd90320_read_byte(PMBusDevice *pmdev)
+{
+    UCD90320State *s = UCD90320(pmdev);
+
+    switch (pmdev->code) {
+    case UCD9000_DEVICE_ID:
+        ucd90320_send_block(pmdev, s->device_id, sizeof(s->device_id));
+        pmbus_idle(pmdev);
+        return 0;
+    case UCD9000_NUM_PAGES:
+        pmbus_send8(pmdev, UCD90320_NUM_PAGES);
+        pmbus_idle(pmdev);
+        return 0;
+
+    case UCD9000_MONITOR_CONFIG:
+        ucd90320_send_block(pmdev, &s->monitor_config,
+                            sizeof(s->monitor_config));
+        pmbus_idle(pmdev);
+        return 0;
+    case UCD9000_MFR_STATUS:
+        ucd90320_send_block(pmdev, s->mfr_status, sizeof(s->mfr_status));
+        pmbus_idle(pmdev);
+        return 0;
+    default:
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "%s: reading from unsupported register: 0x%02x\n",
+                      __func__, pmdev->code);
+        break;
+    }
+    return 0xFF;
+}
+
+static int ucd90320_write_data(PMBusDevice *pmdev, const uint8_t *buf,
+                               uint8_t len)
+{
+    if (len == 0) {
+        qemu_log_mask(LOG_GUEST_ERROR, "%s: writing empty data\n", __func__);
+        return -1;
+    }
+
+    pmdev->code = buf[0];
+
+    if (len == 1) {
+        return 0;
+    }
+
+    return 0;
+}
+
+static void ucd90320_exit_reset(Object *obj, ResetType type)
+{
+    PMBusDevice *pmdev = PMBUS_DEVICE(obj);
+    UCD90320State *s = UCD90320(obj);
+
+    pmdev->capability = 0x20; /* PEC supported */
+
+    for (int i = 0; i < UCD90320_NUM_PAGES; i++) {
+        pmdev->pages[i].operation     = 0x80; /* on */
+        pmdev->pages[i].on_off_config = 0x1a;
+        pmdev->pages[i].vout_mode     = 0x00; /* linear mode, exponent=0 */
+        pmdev->pages[i].read_vout     = 0;    /* rails off, pgood=0 */
+    }
+
+    memcpy(s->device_id, "UCD90320", sizeof(s->device_id));
+    s->monitor_config = 0x00;
+    memset(s->mfr_status, 0x00, sizeof(s->mfr_status));
+}
+
+static void ucd90320_init(Object *obj)
+{
+    PMBusDevice *pmdev = PMBUS_DEVICE(obj);
+    uint64_t flags = PB_HAS_VOUT | PB_HAS_VOUT_MODE |
+                     PB_HAS_STATUS_MFR_SPECIFIC;
+
+    for (int i = 0; i < UCD90320_NUM_PAGES; i++) {
+        pmbus_page_config(pmdev, i, flags);
+    }
+}
+
+static const VMStateDescription vmstate_ucd90320 = {
+    .name = TYPE_UCD90320,
+    .version_id = 0,
+    .minimum_version_id = 0,
+    .fields = (const VMStateField[]) {
+        VMSTATE_PMBUS_DEVICE(parent, UCD90320State),
+        VMSTATE_UINT8_ARRAY(device_id, UCD90320State, UCD90320_DEVICE_ID_LEN),
+        VMSTATE_UINT8(monitor_config, UCD90320State),
+        VMSTATE_UINT8_ARRAY(mfr_status, UCD90320State,
+                            UCD90320_MFR_STATUS_LEN),
+        VMSTATE_END_OF_LIST()
+    }
+};
+
+static void ucd90320_class_init(ObjectClass *klass, const void *data)
+{
+    ResettableClass *rc = RESETTABLE_CLASS(klass);
+    DeviceClass *dc = DEVICE_CLASS(klass);
+    PMBusDeviceClass *k = PMBUS_DEVICE_CLASS(klass);
+
+    dc->desc = "Texas Instruments UCD90320 24-Rail Power Sequencer";
+    dc->vmsd = &vmstate_ucd90320;
+    k->write_data = ucd90320_write_data;
+    k->receive_byte = ucd90320_read_byte;
+    k->device_num_pages = UCD90320_NUM_PAGES;
+    rc->phases.exit = ucd90320_exit_reset;
+}
+
+static const TypeInfo ucd90320_types[] = {
+    {
+        .name          = TYPE_UCD90320,
+        .parent        = TYPE_PMBUS_DEVICE,
+        .instance_size = sizeof(UCD90320State),
+        .instance_init = ucd90320_init,
+        .class_init    = ucd90320_class_init,
+    },
+};
+
+DEFINE_TYPES(ucd90320_types)
diff --git a/hw/arm/Kconfig b/hw/arm/Kconfig
index 82e0bc2e70..ac44740547 100644
--- a/hw/arm/Kconfig
+++ b/hw/arm/Kconfig
@@ -555,6 +555,7 @@ config ASPEED_SOC
     select LED
     select PMBUS
     select MAX31785
+    select UCD90320
     select FSI_APB2OPB_ASPEED
     select AT24C
     select PCI_EXPRESS
diff --git a/hw/sensor/Kconfig b/hw/sensor/Kconfig
index bc6331b4ab..135ffa7d5d 100644
--- a/hw/sensor/Kconfig
+++ b/hw/sensor/Kconfig
@@ -43,3 +43,7 @@ config ISL_PMBUS_VR
 config MAX31785
     bool
     depends on PMBUS
+
+config UCD90320
+    bool
+    depends on PMBUS
diff --git a/hw/sensor/meson.build b/hw/sensor/meson.build
index 420fdc3359..c0583161d3 100644
--- a/hw/sensor/meson.build
+++ b/hw/sensor/meson.build
@@ -8,3 +8,4 @@ system_ss.add(when: 'CONFIG_MAX34451', if_true: files('max34451.c'))
 system_ss.add(when: 'CONFIG_LSM303DLHC_MAG', if_true: files('lsm303dlhc_mag.c'))
 system_ss.add(when: 'CONFIG_ISL_PMBUS_VR', if_true: files('isl_pmbus_vr.c'))
 system_ss.add(when: 'CONFIG_MAX31785', if_true: files('max31785.c'))
+system_ss.add(when: 'CONFIG_UCD90320', if_true: files('ucd90320.c'))
-- 
2.53.0


