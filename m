Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8AACBCD3436
	for <qemu-devel@archiver.kernel.org>; Mon,  4 May 2026 20:33:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wJzyG-0004BV-Mm; Mon, 04 May 2026 16:32:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanb@linux.ibm.com>)
 id 1wJzyB-0004AM-00
 for qemu-devel@nongnu.org; Mon, 04 May 2026 16:32:48 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanb@linux.ibm.com>)
 id 1wJzy6-0000Ok-To
 for qemu-devel@nongnu.org; Mon, 04 May 2026 16:32:46 -0400
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 644Etbmx3285137; Mon, 4 May 2026 20:32:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=LtRw2GAR98T6FSwBV
 3CXRo/Qs9gVckpJu3bwrImAdtc=; b=Vnw2gmJscd6ENbOxwEsIJuGnMHF6B4vcc
 XBXCXLEukg5yOX/I27aWKszfuYJWSt4wWFsoDGDSGKAhBLV91WM+LwJReCWZ5j3/
 BbFOpRHER0mlEQu/Ske+GnQRualqVfaEngRDd4ziZmjXkiGozv/mkgQSt0IUKnfw
 Dnc5Q5rEUpB6cP2ZYXXUplfQkJaNHnov+6xb0diEYLSybDDiXvevGGVzF7ZbUrII
 Ao9TJK/FCik+L1Lyaz1oMSurNfyI7ghnKbNiaRKQr6Ye1xhq7BKoXNaklB8wPxdi
 /hZT7Y0t/ptUpF8HE/NTgl8WWkFtVgdE6/9XXPoo2Q1dfOX+uKTYQ==
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4dw9xxghjr-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 04 May 2026 20:32:41 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 644KOVer000511;
 Mon, 4 May 2026 20:32:40 GMT
Received: from smtprelay04.dal12v.mail.ibm.com ([172.16.1.6])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4dwwtg6jqu-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 04 May 2026 20:32:40 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (smtpav06.dal12v.mail.ibm.com
 [10.241.53.105])
 by smtprelay04.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 644KWevs63242710
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 4 May 2026 20:32:40 GMT
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 0B4BF58059;
 Mon,  4 May 2026 20:32:40 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id AFE1F58043;
 Mon,  4 May 2026 20:32:39 +0000 (GMT)
Received: from mycroft-2.pok.ibm.com (unknown [9.47.158.222])
 by smtpav06.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Mon,  4 May 2026 20:32:39 +0000 (GMT)
From: Stefan Berger <stefanb@linux.ibm.com>
To: qemu-devel@nongnu.org
Cc: marcandre.lureau@redhat.com, armenon@redhat.com,
 Stefan Berger <stefanb@linux.ibm.com>
Subject: [PATCH 3/5] tpm: Extend TPM TIS buffer size to 8kb for machines >=
 v11.1
Date: Mon,  4 May 2026 20:32:26 +0000
Message-ID: <20260504203228.886578-4-stefanb@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260504203228.886578-1-stefanb@linux.ibm.com>
References: <20260504203228.886578-1-stefanb@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTA0MDE4NSBTYWx0ZWRfX84uaO4y5rAuo
 5nIZnNWh8C/ac/jl4Nm/1MfA1vlJ0DiCB6LgcCtl6cEgrPYhzFSf1oEmKid6OB3gfy0IUobe+e/
 jguRtxPL+DYh9pUx+EJBXmJEGgEU+6lpkt5+Ktgfcgf+CVzr9Ptz+EoIZ8lLL1QPDNf0IxhaxdA
 iEwXXQoCN3aVVy4E3ArAlcckrStgX8qlfJUHd1O8UnFqDotNI4wipJk6JqcHu+3olkInMbpS4/U
 M+J5/scN0Yoc0aNuNmVEgjznpekKiMlPxMFWOoo4AxbHAzSiXnIN5MT1igWc4B9ifZqSuL+YGZD
 nsQrPR6FNl3N4dK/xQBJMM6UIzBvDxF0V61RViNGo2CzX7hEm2zrAR4xsiWRl+yeUxITD1nedpW
 hONYHJS4FvgDdu9qM5QZhcbumjrvd8kZ0w2kVzVl9af7Bw/VSoj1JWLqF0xzEZZDDP4AWPVfWw/
 SCJ3aOUj8xRsCAmJUog==
X-Proofpoint-ORIG-GUID: ZDFpY5rl1Js8WFfwWwhPHF8bU7bF1nLd
X-Proofpoint-GUID: ZDFpY5rl1Js8WFfwWwhPHF8bU7bF1nLd
X-Authority-Analysis: v=2.4 cv=ctWrVV4i c=1 sm=1 tr=0 ts=69f90269 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8 a=20KFwNOVAAAA:8
 a=Wo29ovGD9mfFeX1JBq8A:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-04_05,2026-04-30_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 lowpriorityscore=0 adultscore=0 clxscore=1015
 suspectscore=0 impostorscore=0 spamscore=0 malwarescore=0 phishscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2604200000
 definitions=main-2605040185
Received-SPF: pass client-ip=148.163.158.5; envelope-from=stefanb@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Extend the TIS buffer size to 8kb for machines >= v11.1 and store the first
4096 bytes using VMSTATE_PARTIAL_BUFFER and the rest using
VMSTATE_BUFFER_START_MIDDLE when necessary. It is necessary to store the
buffer beyond the original 4096 bytes when:

 - the user has written more than 4096 bytes to the buffer
 - the TPM 2 response is larger than 4096 bytes

Use the .needed function of the VMStateDescription interface to check
whether the bytes in the buffer beyond 4096 bytes needed to be saved.
The .pre_save function is called before the .needed function so that we
can be sure to have received any response packet from the TPM.

Limit the buffer size for machines older than 11.1 to 4096 so that they
have the old buffer size as before.

Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
Signed-off-by: Arun Menon <armenon@redhat.com>
---
 hw/core/machine.c       |  3 +++
 hw/tpm/tpm_tis.h        | 12 +++++++++++-
 hw/tpm/tpm_tis_common.c | 33 ++++++++++++++++++++++++++++++++-
 hw/tpm/tpm_tis_i2c.c    | 28 +++++++++++++++++++++++++++-
 hw/tpm/tpm_tis_isa.c    | 28 +++++++++++++++++++++++++++-
 hw/tpm/tpm_tis_sysbus.c | 28 +++++++++++++++++++++++++++-
 6 files changed, 127 insertions(+), 5 deletions(-)

diff --git a/hw/core/machine.c b/hw/core/machine.c
index 30464b21ac..42ea231b91 100644
--- a/hw/core/machine.c
+++ b/hw/core/machine.c
@@ -42,6 +42,9 @@
 GlobalProperty hw_compat_11_0[] = {
     { "tpm-crb", "cap-chunk", "off" },
     { "tpm-crb", "x-allow-chunk-migration", "off" },
+    { "tpm-tis", "x-allow-ext-buffer", "off" },
+    { "tpm-tis-i2c", "x-allow-ext-buffer", "off" },
+    { "tpm-tis-device", "x-allow-ext-buffer", "off" },
 };
 const size_t hw_compat_11_0_len = G_N_ELEMENTS(hw_compat_11_0);
 
diff --git a/hw/tpm/tpm_tis.h b/hw/tpm/tpm_tis.h
index 1531620bf9..99cc2f5068 100644
--- a/hw/tpm/tpm_tis.h
+++ b/hw/tpm/tpm_tis.h
@@ -33,7 +33,7 @@
 
 #define TPM_TIS_IS_VALID_LOCTY(x)   ((x) < TPM_TIS_NUM_LOCALITIES)
 
-#define TPM_TIS_BUFFER_MAX          4096
+#define TPM_TIS_BUFFER_MAX          8192
 
 typedef enum {
     TPM_TIS_STATE_IDLE = 0,
@@ -54,10 +54,13 @@ typedef struct TPMLocality {
 } TPMLocality;
 
 typedef struct TPMState {
+    const char *devname;
+
     MemoryRegion mmio;
 
     unsigned char buffer[TPM_TIS_BUFFER_MAX];
     uint16_t rw_offset;
+    bool allow_ext_buffer;
 
     uint8_t active_locty;
     uint8_t aborting_locty;
@@ -89,4 +92,11 @@ uint32_t tpm_tis_read_data(TPMState *s, hwaddr addr, unsigned size);
 void tpm_tis_write_data(TPMState *s, hwaddr addr, uint64_t val, uint32_t size);
 uint16_t tpm_tis_get_checksum(TPMState *s);
 
+bool tpm_tis_ext_buffer_migration_needed(struct TPMState *s);
+void tpm_tis_unset_migration_blocker(struct TPMState *s);
+
+#define MIGRATION_BLOCKER_MESSAGE \
+   "The %s device does not support extended buffer migration with " \
+   "machine version less than 11.1"
+
 #endif /* TPM_TPM_TIS_H */
diff --git a/hw/tpm/tpm_tis_common.c b/hw/tpm/tpm_tis_common.c
index a134d5c205..99efadf77d 100644
--- a/hw/tpm/tpm_tis_common.c
+++ b/hw/tpm/tpm_tis_common.c
@@ -33,6 +33,7 @@
 #include "hw/acpi/tpm.h"
 #include "hw/pci/pci_ids.h"
 #include "hw/core/qdev-properties.h"
+#include "migration/blocker.h"
 #include "migration/vmstate.h"
 #include "system/tpm_backend.h"
 #include "system/tpm_util.h"
@@ -676,6 +677,7 @@ static void tpm_tis_mmio_write(void *opaque, hwaddr addr,
 
             case TPM_TIS_STATE_COMPLETION:
                 s->rw_offset = 0;
+
                 /* shortcut to ready state with C/R set */
                 s->loc[locty].state = TPM_TIS_STATE_READY;
                 if (!(s->loc[locty].sts & TPM_TIS_STS_COMMAND_READY)) {
@@ -815,11 +817,16 @@ enum TPMVersion tpm_tis_get_tpm_version(TPMState *s)
  */
 void tpm_tis_reset(TPMState *s, bool ppi_enabled)
 {
+    size_t limit = TPM_TIS_BUFFER_MAX;
     int c;
 
     s->be_tpm_version = tpm_backend_get_tpm_version(s->be_driver);
+
+    if (!s->allow_ext_buffer) {
+        limit = 4096;
+    }
     s->be_buffer_size = MIN(tpm_backend_get_buffer_size(s->be_driver),
-                            TPM_TIS_BUFFER_MAX);
+                            limit);
 
     if (ppi_enabled) {
         tpm_ppi_reset(&s->ppi);
@@ -890,3 +897,27 @@ const VMStateDescription vmstate_locty = {
     }
 };
 
+bool tpm_tis_ext_buffer_migration_needed(struct TPMState *s)
+{
+    if (!TPM_TIS_IS_VALID_LOCTY(s->active_locty)) {
+        return false;
+    }
+
+    switch (s->loc[s->active_locty].state) {
+    case TPM_TIS_STATE_IDLE:
+    case TPM_TIS_STATE_READY:
+        return false;
+    case TPM_TIS_STATE_RECEPTION:
+        return s->rw_offset >= 4096;
+    case TPM_TIS_STATE_EXECUTION:
+        /*
+         * TPM is executing: we cannot know the size of TPM response.
+         * .pre_save must have been called before (should never get here).
+         */
+        return false;
+    case TPM_TIS_STATE_COMPLETION:
+        return (tpm_cmd_get_size(&s->buffer) >= 4096);
+    }
+    return false;
+}
+
diff --git a/hw/tpm/tpm_tis_i2c.c b/hw/tpm/tpm_tis_i2c.c
index b4f258c7bc..d747a37b54 100644
--- a/hw/tpm/tpm_tis_i2c.c
+++ b/hw/tpm/tpm_tis_i2c.c
@@ -110,13 +110,31 @@ static int tpm_tis_i2c_post_load(void *opaque, int version_id)
     return 0;
 }
 
+static bool tpm_tis_ext_buffer_migration_needed_i2c(void *opaque)
+{
+    TPMStateI2C *i2cst = opaque;
+
+    return tpm_tis_ext_buffer_migration_needed(&i2cst->state);
+}
+
+static const VMStateDescription vmstate_tpm_tis_ext_buffer_i2c = {
+    .name = "tpm-tis/ext_buffer",
+    .version_id = 0,
+    .needed = tpm_tis_ext_buffer_migration_needed_i2c,
+    .pre_save = tpm_tis_i2c_pre_save,
+    .fields = (const VMStateField[]) {
+        VMSTATE_BUFFER_START_MIDDLE(state.buffer, TPMStateI2C, 4096),
+        VMSTATE_END_OF_LIST()
+    }
+};
+
 static const VMStateDescription vmstate_tpm_tis_i2c = {
     .name = "tpm-tis-i2c",
     .version_id = 0,
     .pre_save  = tpm_tis_i2c_pre_save,
     .post_load  = tpm_tis_i2c_post_load,
     .fields = (const VMStateField[]) {
-        VMSTATE_BUFFER(state.buffer, TPMStateI2C),
+        VMSTATE_PARTIAL_BUFFER(state.buffer, TPMStateI2C, 4096),
         VMSTATE_UINT16(state.rw_offset, TPMStateI2C),
         VMSTATE_UINT8(state.active_locty, TPMStateI2C),
         VMSTATE_UINT8(state.aborting_locty, TPMStateI2C),
@@ -133,6 +151,10 @@ static const VMStateDescription vmstate_tpm_tis_i2c = {
         VMSTATE_UINT8(csum_enable, TPMStateI2C),
 
         VMSTATE_END_OF_LIST()
+    },
+    .subsections = (const VMStateDescription *const[]) {
+        &vmstate_tpm_tis_ext_buffer_i2c,
+        NULL,
     }
 };
 
@@ -489,6 +511,8 @@ static int tpm_tis_i2c_send(I2CSlave *i2c, uint8_t data)
 
 static const Property tpm_tis_i2c_properties[] = {
     DEFINE_PROP_TPMBE("tpmdev", TPMStateI2C, state.be_driver),
+    DEFINE_PROP_BOOL("x-allow-ext-buffer", TPMStateI2C,
+                     state.allow_ext_buffer, true),
 };
 
 static void tpm_tis_i2c_realizefn(DeviceState *dev, Error **errp)
@@ -511,6 +535,8 @@ static void tpm_tis_i2c_realizefn(DeviceState *dev, Error **errp)
         error_setg(errp, "'tpmdev' property is required");
         return;
     }
+
+    s->devname = "tpm-tis-i2c";
 }
 
 static void tpm_tis_i2c_reset(DeviceState *dev)
diff --git a/hw/tpm/tpm_tis_isa.c b/hw/tpm/tpm_tis_isa.c
index 2b1267133a..68d77358f8 100644
--- a/hw/tpm/tpm_tis_isa.c
+++ b/hw/tpm/tpm_tis_isa.c
@@ -49,12 +49,30 @@ static int tpm_tis_pre_save_isa(void *opaque)
     return tpm_tis_pre_save(&isadev->state);
 }
 
+static bool tpm_tis_ext_buffer_migration_needed_isa(void *opaque)
+{
+    TPMStateISA *isadev = opaque;
+
+    return tpm_tis_ext_buffer_migration_needed(&isadev->state);
+}
+
+static const VMStateDescription vmstate_tpm_tis_ext_buffer_isa = {
+    .name = "tpm-tis/ext_buffer",
+    .version_id = 0,
+    .needed = tpm_tis_ext_buffer_migration_needed_isa,
+    .pre_save = tpm_tis_pre_save_isa,
+    .fields = (const VMStateField[]) {
+        VMSTATE_BUFFER_START_MIDDLE(state.buffer, TPMStateISA, 4096),
+        VMSTATE_END_OF_LIST()
+    }
+};
+
 static const VMStateDescription vmstate_tpm_tis_isa = {
     .name = "tpm-tis",
     .version_id = 0,
     .pre_save  = tpm_tis_pre_save_isa,
     .fields = (const VMStateField[]) {
-        VMSTATE_BUFFER(state.buffer, TPMStateISA),
+        VMSTATE_PARTIAL_BUFFER(state.buffer, TPMStateISA, 4096),
         VMSTATE_UINT16(state.rw_offset, TPMStateISA),
         VMSTATE_UINT8(state.active_locty, TPMStateISA),
         VMSTATE_UINT8(state.aborting_locty, TPMStateISA),
@@ -64,6 +82,10 @@ static const VMStateDescription vmstate_tpm_tis_isa = {
                              vmstate_locty, TPMLocality),
 
         VMSTATE_END_OF_LIST()
+    },
+    .subsections = (const VMStateDescription *const[]) {
+        &vmstate_tpm_tis_ext_buffer_isa,
+        NULL,
     }
 };
 
@@ -94,6 +116,8 @@ static void tpm_tis_isa_reset(DeviceState *dev)
 static const Property tpm_tis_isa_properties[] = {
     DEFINE_PROP_UINT32("irq", TPMStateISA, state.irq_num, TPM_TIS_IRQ),
     DEFINE_PROP_TPMBE("tpmdev", TPMStateISA, state.be_driver),
+    DEFINE_PROP_BOOL("x-allow-ext-buffer", TPMStateISA,
+                     state.allow_ext_buffer, true),
 };
 
 static void tpm_tis_isa_initfn(Object *obj)
@@ -133,6 +157,8 @@ static void tpm_tis_isa_realizefn(DeviceState *dev, Error **errp)
 
     tpm_ppi_init(&s->ppi, isa_address_space(ISA_DEVICE(dev)),
                  TPM_PPI_ADDR_BASE, OBJECT(dev));
+
+    s->devname = "tpm-tis";
 }
 
 static void build_tpm_tis_isa_aml(AcpiDevAmlIf *adev, Aml *scope)
diff --git a/hw/tpm/tpm_tis_sysbus.c b/hw/tpm/tpm_tis_sysbus.c
index 6bec30c36f..88f1805372 100644
--- a/hw/tpm/tpm_tis_sysbus.c
+++ b/hw/tpm/tpm_tis_sysbus.c
@@ -49,12 +49,30 @@ static int tpm_tis_pre_save_sysbus(void *opaque)
     return tpm_tis_pre_save(&sbdev->state);
 }
 
+static bool tpm_tis_ext_buffer_migration_needed_sysbus(void *opaque)
+{
+    TPMStateSysBus *sbdev = opaque;
+
+    return tpm_tis_ext_buffer_migration_needed(&sbdev->state);
+}
+
+static const VMStateDescription vmstate_tpm_tis_ext_buffer_sysbus = {
+    .name = "tpm-tis/ext_buffer",
+    .version_id = 0,
+    .needed = tpm_tis_ext_buffer_migration_needed_sysbus,
+    .pre_save  = tpm_tis_pre_save_sysbus,
+    .fields = (const VMStateField[]) {
+        VMSTATE_BUFFER_START_MIDDLE(state.buffer, TPMStateSysBus, 4096),
+        VMSTATE_END_OF_LIST()
+    }
+};
+
 static const VMStateDescription vmstate_tpm_tis_sysbus = {
     .name = "tpm-tis",
     .version_id = 0,
     .pre_save  = tpm_tis_pre_save_sysbus,
     .fields = (const VMStateField[]) {
-        VMSTATE_BUFFER(state.buffer, TPMStateSysBus),
+        VMSTATE_PARTIAL_BUFFER(state.buffer, TPMStateSysBus, 4096),
         VMSTATE_UINT16(state.rw_offset, TPMStateSysBus),
         VMSTATE_UINT8(state.active_locty, TPMStateSysBus),
         VMSTATE_UINT8(state.aborting_locty, TPMStateSysBus),
@@ -64,6 +82,10 @@ static const VMStateDescription vmstate_tpm_tis_sysbus = {
                              0, vmstate_locty, TPMLocality),
 
         VMSTATE_END_OF_LIST()
+    },
+    .subsections = (const VMStateDescription *const[]) {
+        &vmstate_tpm_tis_ext_buffer_sysbus,
+        NULL,
     }
 };
 
@@ -94,6 +116,8 @@ static void tpm_tis_sysbus_reset(DeviceState *dev)
 static const Property tpm_tis_sysbus_properties[] = {
     DEFINE_PROP_UINT32("irq", TPMStateSysBus, state.irq_num, TPM_TIS_IRQ),
     DEFINE_PROP_TPMBE("tpmdev", TPMStateSysBus, state.be_driver),
+    DEFINE_PROP_BOOL("x-allow-ext-buffer", TPMStateSysBus,
+                     state.allow_ext_buffer, true),
 };
 
 static void tpm_tis_sysbus_initfn(Object *obj)
@@ -132,6 +156,8 @@ static void tpm_tis_sysbus_realizefn(DeviceState *dev, Error **errp)
     }
 
     vmstate_register_ram(&s->ppi.ram, dev);
+
+    s->devname = "tpm-tis-device";
 }
 
 static void tpm_tis_sysbus_class_init(ObjectClass *klass, const void *data)
-- 
2.53.0


