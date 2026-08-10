Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED00EC5B569
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Aug 2026 19:00:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wtVCZ-0001UH-Nt; Mon, 10 Aug 2026 14:58:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mikail.sadic@ibm.com>)
 id 1wtVCY-0001Tf-4A; Mon, 10 Aug 2026 14:58:22 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mikail.sadic@ibm.com>)
 id 1wtVCV-0003Qj-VJ; Mon, 10 Aug 2026 14:58:21 -0400
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67AGW6WL2192690; Mon, 10 Aug 2026 18:57:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=8Aux4Nt9AqJZJwSbt
 1118cnbfcrSHGWwBveD1cl72L4=; b=awwU7fIwy1OVQvXz67bOBBtgMoE5v5DGA
 NN2Kdx4fIsLZV3M5+/ZveGPUVdkQXff3g4xecj6QwTR2hs9PAX1ePpO22AKGK2JO
 QWEgxE/rdioREsDfPPavXmglNf9y2tjhfq/5YOgPvOviXv5sCFbp6+SoGR125D1w
 bWULwBJ68Rgg+8T17Ujtkp2gWbsP8eH7o56WxNAtNj5GOFZ7gcNNsjaCzIYJSvBb
 0RzxDO5ZxN48G672X9bQSN5bUhUJIlUXz1UDjSXaFVQS0Xo6iGgW2SqW43nIWFui
 8DCHJXkEYomShE540doWWoY2KRB745sd3OcsCzN9FJRax4WBwcTiQ==
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fwvnw15jt-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 10 Aug 2026 18:57:57 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67AIQHG9026180;
 Mon, 10 Aug 2026 18:57:56 GMT
Received: from smtprelay06.wdc07v.mail.ibm.com ([172.16.1.73])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fxespx752-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 10 Aug 2026 18:57:56 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (smtpav02.dal12v.mail.ibm.com
 [10.241.53.101])
 by smtprelay06.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 67AIvtQ062980358
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 10 Aug 2026 18:57:55 GMT
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id D867C5805E;
 Mon, 10 Aug 2026 18:57:54 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 3ED805805C;
 Mon, 10 Aug 2026 18:57:54 +0000 (GMT)
Received: from IBM-MFS.ibm.com (unknown [9.61.24.176])
 by smtpav02.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Mon, 10 Aug 2026 18:57:54 +0000 (GMT)
From: Mikail Sadic <mikail.sadic@ibm.com>
To: clg@kaod.org, peter.maydell@linaro.org
Cc: Mikail Sadic <mikail.sadic@ibm.com>, pbonzini@redhat.com,
 ninad@linux.ibm.com, titusr@google.com, jeuk20.kim@samsung.com,
 philmd@mailo.com, steven_lee@aspeedtech.com, leetroy@gmail.com,
 jamin_lin@aspeedtech.com, kane_chen@aspeedtech.com,
 andrew@codeconstruct.com.au, joel@jms.id.au, calebs@linux.ibm.com,
 milesg@linux.ibm.com, qemu-arm@nongnu.org, qemu-devel@nongnu.org
Subject: [PATCH v3 5/8] hw/sensor: Add UCD90320 model
Date: Mon, 10 Aug 2026 13:57:43 -0500
Message-ID: <20260810185748.1253-6-mikail.sadic@ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260810185748.1253-1-mikail.sadic@ibm.com>
References: <20260810185748.1253-1-mikail.sadic@ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=RsP16imK c=1 sm=1 tr=0 ts=6a7a1f36 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8 a=YwPlQgHYUhtu6dumBzMA:9
X-Proofpoint-GUID: T9LReHCHUiwlAihAjN5wwiCjx_iRjM6Z
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODEwMDE1OCBTYWx0ZWRfXxCZGFH4GF5r/
 L5+Tge5KQFeyKrN73uCCek/kivQG91ePbLPeoFokIsxHBACMJEkRdE2U6VYh3OjGr4kk/Pxq+sG
 0KMhkUaV4CGFrmYTOQcs3zzHmteMjqadgU/Q6jINkukLnxEs9cRNw26MNk3ZQLNMQeI8X9LkLpP
 DXH4/ErqgGX/gpBDFHBBhxrNrsjWexKW9X8GpHeVPQofB3IIJfXEKI08scUOzW/7eX9uGujMF0r
 Eu/3Hmgvoef23MEx7MMc6PdUhMo3Rl2WjtxiPLTxKP93z9y/mYxeOmEN0SW8PpL8MRpCFOKZ3MM
 51alEO8IBHzgrCI6nxLlkcL2BYmG6CqqVEtVIm4w4LbC1GVX04YVlGX6WoIUoF9wen9p4wmK4L5
 gOg/vbQKi4TB0AhsBpQcKaWcSUkidKZAoDMXHWzFweB9GPYrbTniEURrttvcPRrdju8HQVRIPDF
 nClOGTNkGVUwSVxqOzw==
X-Proofpoint-ORIG-GUID: CzwbI_GKIspHmWRyQBxa2DC92CaoWqpU
X-Proofpoint-Spam-Info: AW1haW4tMjYwODEwMDE1OCBTYWx0ZWRfX4l9alsNNbun7
 221ihhFrGhJBNnSz1cKko/nx8hfjAZ8TEytiEEqn5cjn2p4p6qbcyuYJwUQqb0+CUNm3oUIxu+W
 duEWcZhFjyAH1hh7YRLelke8Awqiqh0=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-10_04,2026-08-10_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 impostorscore=0 suspectscore=0 clxscore=1015 malwarescore=0
 phishscore=0 adultscore=0 lowpriorityscore=0 priorityscore=1501 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608100158
Received-SPF: pass client-ip=148.163.158.5; envelope-from=mikail.sadic@ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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


