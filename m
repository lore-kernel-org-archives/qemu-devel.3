Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0025E6F083
	for <qemu-devel@archiver.kernel.org>; Fri,  1 Nov 2024 18:59:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t6wr7-000081-La; Fri, 01 Nov 2024 14:58:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dantan@linux.vnet.ibm.com>)
 id 1t6wqk-0008MQ-D7; Fri, 01 Nov 2024 14:58:22 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dantan@linux.vnet.ibm.com>)
 id 1t6wqf-0000h8-Gl; Fri, 01 Nov 2024 14:58:20 -0400
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4A1EDBA5009800;
 Fri, 1 Nov 2024 18:58:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=/Ire+iRT6u4Xu8Mox
 /MonYXMU7+liJcoBxBsK6HtmsY=; b=afgAPF1LixpbSLcODafMJNW6wsQo9ZmWk
 oauqh9wAAf1k3YSmLV7eekkQj89Mpy0VZ7FsYNDffiW1+2/paWMhLGKB+8Y72Yj3
 fkF1s7tAorv8MUVdqJUON1x/Jme+163ZWx0lwyHg0aBlo505FSRUMst58rR0nMUQ
 BKXk6INGSkXAJAxxjD//2pXah0VomAWCMis568UU8k7IGnI86DOaL6Fl2oYipHP8
 FUy6J1bevIVJA5ILNiXqToizIee23CaUH0vVqxHeVDg1M+UmFJWjrxwW54Cd8XvO
 aBWld8qd7IpJxzd2XmPU76xP1kgGZG86JRY4WcsCszHlJzW/M1G7g==
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 42mvp221e2-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 01 Nov 2024 18:58:08 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 4A1H7ogL015807;
 Fri, 1 Nov 2024 18:58:07 GMT
Received: from smtprelay03.dal12v.mail.ibm.com ([172.16.1.5])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 42hdf1tq3k-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 01 Nov 2024 18:58:07 +0000
Received: from smtpav05.wdc07v.mail.ibm.com (smtpav05.wdc07v.mail.ibm.com
 [10.39.53.232])
 by smtprelay03.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 4A1Iw7jX46727528
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 1 Nov 2024 18:58:07 GMT
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 122E458043;
 Fri,  1 Nov 2024 18:58:07 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 97D4958059;
 Fri,  1 Nov 2024 18:58:06 +0000 (GMT)
Received: from gfwa829.aus.stglabs.ibm.com (unknown [9.3.84.19])
 by smtpav05.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Fri,  1 Nov 2024 18:58:06 +0000 (GMT)
From: dan tan <dantan@linux.vnet.ibm.com>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, stefanb@linux.vnet.ibm.com, pbonzini@redhat.com,
 farosas@suse.de, lvivier@redhat.com, clg@kaod.org
Subject: [PATCH v3 4/5] tpm/tpm_tis_spi: Support TPM for SPI (rev 3)
Date: Fri,  1 Nov 2024 13:57:17 -0500
Message-Id: <20241101185718.5847-5-dantan@linux.vnet.ibm.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241101185718.5847-1-dantan@linux.vnet.ibm.com>
References: <20241101185718.5847-1-dantan@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: DK9MwrArQ6Mmmrg0WHpc5XfZCNb1eXqz
X-Proofpoint-GUID: DK9MwrArQ6Mmmrg0WHpc5XfZCNb1eXqz
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0
 impostorscore=0 mlxlogscore=999 spamscore=0 clxscore=1015 malwarescore=0
 phishscore=0 priorityscore=1501 lowpriorityscore=0 mlxscore=0 adultscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2411010134
Received-SPF: none client-ip=148.163.158.5;
 envelope-from=dantan@linux.vnet.ibm.com; helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

- moved variable tis_addr from TPMStateSPI struct to local
- added the VM suspend/resume support:
  - added vmstate_tpm_tis_spi declaration
  - added tpm_tis_spi_pre_save() function
- fixed trace formatting string

Signed-off-by: dan tan <dantan@linux.vnet.ibm.com>
---
 hw/tpm/tpm_tis_spi.c | 50 ++++++++++++++++++++++++++++++++++++--------
 hw/tpm/trace-events  |  8 +++----
 2 files changed, 45 insertions(+), 13 deletions(-)

diff --git a/hw/tpm/tpm_tis_spi.c b/hw/tpm/tpm_tis_spi.c
index f8a78a5cfb..4aee1c6d6c 100644
--- a/hw/tpm/tpm_tis_spi.c
+++ b/hw/tpm/tpm_tis_spi.c
@@ -17,6 +17,7 @@
 #include "trace.h"
 #include "tpm_tis.h"
 #include "hw/ssi/ssi.h"
+#include "migration/vmstate.h"
 
 typedef struct TPMStateSPI {
     /*< private >*/
@@ -26,7 +27,6 @@ typedef struct TPMStateSPI {
     uint8_t     wait_state_cnt;  /* wait state counter */
     uint8_t     xfer_size;       /* data size of transfer */
     uint32_t    reg_addr;        /* register address of transfer */
-    uint32_t    tis_addr;        /* tis address including locty */
 
     uint8_t     spi_state;       /* READ / WRITE / IDLE */
 #define SPI_STATE_IDLE   0
@@ -46,14 +46,47 @@ typedef struct TPMStateSPI {
 
 DECLARE_INSTANCE_CHECKER(TPMStateSPI, TPM_TIS_SPI, TYPE_TPM_TIS_SPI)
 
+static int tpm_tis_spi_pre_save(void *opaque)
+{
+    TPMStateSPI *spist = opaque;
+
+    return tpm_tis_pre_save(&spist->tpm_state);
+}
+
+static const VMStateDescription vmstate_tpm_tis_spi = {
+     .name = "tpm-tis-spi",
+     .version_id = 0,
+     .pre_save  = tpm_tis_spi_pre_save,
+     .fields = (const VMStateField[]) {
+         VMSTATE_BUFFER(tpm_state.buffer, TPMStateSPI),
+         VMSTATE_UINT16(tpm_state.rw_offset, TPMStateSPI),
+         VMSTATE_UINT8(tpm_state.active_locty, TPMStateSPI),
+         VMSTATE_UINT8(tpm_state.aborting_locty, TPMStateSPI),
+         VMSTATE_UINT8(tpm_state.next_locty, TPMStateSPI),
+
+         VMSTATE_STRUCT_ARRAY(tpm_state.loc, TPMStateSPI,
+                              TPM_TIS_NUM_LOCALITIES, 0,
+                              vmstate_locty, TPMLocality),
+
+         /* spi specifics */
+         VMSTATE_UINT8(byte_offset, TPMStateSPI),
+         VMSTATE_UINT8(wait_state_cnt, TPMStateSPI),
+         VMSTATE_UINT8(xfer_size, TPMStateSPI),
+         VMSTATE_UINT32(reg_addr, TPMStateSPI),
+         VMSTATE_UINT8(spi_state, TPMStateSPI),
+         VMSTATE_BOOL(command, TPMStateSPI),
+
+         VMSTATE_END_OF_LIST()
+     }
+};
+
 static inline void tpm_tis_spi_clear_data(TPMStateSPI *spist)
 {
-    spist->spi_state = 0;
+    spist->spi_state = SPI_STATE_IDLE;
     spist->byte_offset = 0;
     spist->wait_state_cnt = 0;
     spist->xfer_size = 0;
     spist->reg_addr = 0;
-    spist->tis_addr = 0xffffffff;
 
     return;
 }
@@ -126,6 +159,7 @@ static uint32_t tpm_transfer(SSIPeripheral *ss, uint32_t tx)
     uint8_t byte;       /* reversed byte value */
     uint8_t offset = 0; /* offset of byte in payload */
     uint8_t index;      /* index of data byte in transfer */
+    uint32_t tis_addr;  /* tis address including locty */
 
     /* new transfer or not */
     if (spist->command) {   /* new transfer start */
@@ -230,11 +264,11 @@ static uint32_t tpm_transfer(SSIPeripheral *ss, uint32_t tx)
                     trace_tpm_tis_spi_transfer_event("index exceeds xfer_size");
                     return rx;
                 }
-                spist->tis_addr = spist->reg_addr + (index % 4);
+                tis_addr = spist->reg_addr + (index % 4);
                 if (spist->spi_state == SPI_STATE_WRITE) {
-                    tpm_tis_spi_write(spist, spist->tis_addr, byte);
+                    tpm_tis_spi_write(spist, tis_addr, byte);
                 } else {
-                    byte = tpm_tis_spi_read(spist, spist->tis_addr);
+                    byte = tpm_tis_spi_read(spist, tis_addr);
                     rx = rx | (byte << (24 - offset * 8));
                     trace_tpm_tis_spi_transfer_data("byte added to response",
                                                      byte);
@@ -271,9 +305,6 @@ static void tpm_realize(SSIPeripheral *dev, Error **errp)
     TPMStateSPI *spist = TPM_TIS_SPI(dev);
     TPMState *s = &spist->tpm_state;
 
-    spist->command = true;
-    spist->spi_state = SPI_STATE_IDLE;
-
     if (!tpm_find()) {
         error_setg(errp, "at most one TPM device is permitted");
         return;
@@ -303,6 +334,7 @@ static void tpm_tis_spi_class_init(ObjectClass *klass, void *data)
     set_bit(DEVICE_CATEGORY_MISC, dc->categories);
 
     dc->desc = "SPI TPM";
+    dc->vmsd = &vmstate_tpm_tis_spi;
 
     tc->model = TPM_MODEL_TPM_TIS;
     tc->request_completed = tpm_tis_spi_request_completed;
diff --git a/hw/tpm/trace-events b/hw/tpm/trace-events
index 4b39be13e2..0324ceb6d0 100644
--- a/hw/tpm/trace-events
+++ b/hw/tpm/trace-events
@@ -44,8 +44,8 @@ tpm_tis_i2c_event(const char *event) "TPM I2C event: %s"
 tpm_tis_i2c_send_reg(const char *name, int reg) "TPM I2C write register: %s(0x%X)"
 
 # tpm_tis_spi.c
-tpm_tis_spi_write(uint32_t addr, uint8_t val) "TPM SPI write - addr:0x%X 0x%x"
-tpm_tis_spi_read(uint32_t addr, uint8_t val) "TPM SPI read - addr:0x%X 0x%x"
+tpm_tis_spi_write(uint32_t addr, uint8_t val) "TPM SPI write - addr:0x%08X 0x%02x"
+tpm_tis_spi_read(uint32_t addr, uint8_t val) "TPM SPI read - addr:0x%08X 0x%02x"
 tpm_tis_spi_transfer_event(const char *event) "TPM SPI XFER event: %s"
-tpm_tis_spi_transfer_data(const char *name, uint8_t val) "TPM SPI XFER: %s = 0x%x"
-tpm_tis_spi_transfer_addr(const char *name, uint8_t val) "TPM SPI XFER: %s = 0x%08x"
+tpm_tis_spi_transfer_data(const char *name, uint8_t val) "TPM SPI XFER: %s = 0x%02x"
+tpm_tis_spi_transfer_addr(const char *name, uint32_t addr) "TPM SPI XFER: %s = 0x%08x"
-- 
2.39.5


