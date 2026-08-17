Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E68BC5DF70
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Aug 2026 10:30:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wvuaT-0000ws-Cb; Mon, 17 Aug 2026 06:29:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <uverma@linux.ibm.com>)
 id 1wvuaR-0000ut-K0; Mon, 17 Aug 2026 06:28:59 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <uverma@linux.ibm.com>)
 id 1wvuaP-0008Hv-LY; Mon, 17 Aug 2026 06:28:59 -0400
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67GLW3iU1866406; Mon, 17 Aug 2026 10:28:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=mfdJHUrTQxafnSGAc
 SMA3Yz/CXNjZmizE5um/uP4BzA=; b=T+rJoIV2XvhlIP3BipH2rzcI2dRQX0qEq
 po8N//PoqhHz5N2Qs2RJzxpo+VUYj0fVq5pnkkYnYmfCKISuyoeZ/YwedVB0/anh
 /x61dNJxQnaWmEIOrrQlF8ZiVlAtsHVumvfIvXzpwByiDXi/WJm3OaEUrWJtwgrO
 RBT1SRvkqgW/qcEPNB/g5Csk4fcZWk1RJUVGPwTfykAbV3m3W5FiWLVbaPL87MZ/
 BPojv44q2RSFVW/0NtzMOewQbSUsItNchJaUOiseF+bUT0qwrdTe6K9oC0FSqs76
 FE4iBUuFJGCUye0odQz2hJu+I7TCauyvASVNXWS1IYszjmjB01SlA==
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4g2fsqhqhy-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 17 Aug 2026 10:28:52 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67HAQKTR000845;
 Mon, 17 Aug 2026 10:28:52 GMT
Received: from smtprelay06.dal12v.mail.ibm.com ([172.16.1.8])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4g34ng5e1f-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 17 Aug 2026 10:28:52 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (smtpav02.wdc07v.mail.ibm.com
 [10.39.53.229])
 by smtprelay06.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 67HASodV32506470
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 17 Aug 2026 10:28:51 GMT
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id BF47D5805B;
 Mon, 17 Aug 2026 10:28:50 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 96F1058058;
 Mon, 17 Aug 2026 10:28:43 +0000 (GMT)
Received: from li-bd0dea4c-2912-11b2-a85c-e84940f94d2e.ibmuc.com (unknown
 [9.124.212.152])
 by smtpav02.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Mon, 17 Aug 2026 10:28:43 +0000 (GMT)
From: uverma@linux.ibm.com
To: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, aik@ozlabs.ru
Cc: pbonzini@redhat.com, th.huth@posteo.eu, nnmlinux@linux.ibm.com,
 sbhat@linux.ibm.com, harshpb@linux.ibm.com, amachhiw@linux.ibm.com,
 rathc@linux.ibm.com, balaton@eik.bme.hu, philmd@oss.qualcomm.com,
 npiggin@gmail.com, marcandre.lureau@redhat.com, fam@euphon.net,
 Utkarsh Verma <uverma@linux.ibm.com>
Subject: [RFC PATCH 4/8] ppc/spapr: add VTY backend support to OF
 read/write/open services
Date: Mon, 17 Aug 2026 15:57:21 +0530
Message-ID: <20260817102733.605346-5-uverma@linux.ibm.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260817102733.605346-1-uverma@linux.ibm.com>
References: <20260817102733.605346-1-uverma@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE3MDA3NCBTYWx0ZWRfX+d0g/rhqHJxE
 RFyVHTN163QS3+IdhfFN2nbvhFqPFKu6Edxslsb0jmj55iEHuZnCRLIldFdNiJT9GeKfWs9qGyq
 UdspeKLuK1bkUgpriExItMwX8y5A3A1wFhXdTlnDPxHj6EMxEHFc6wjf5zwSSsIFb0InKcPAz3w
 rp6BRzCPn8cQOlfMz301MMzwyIf128P5+JE7jqn/NAhmU6GD99nlZFl0aI1QiFBwdtnVnJnh+Ww
 JvR0BtJIs6hzzuRzwzdLHql4tFLX0+rJdXPRsuB1KCs7JckKqHypwMXX/ZBWjJrVQgKYf5j22SY
 FZyuxpHl5MqD7tZQWVXJoeqPWd1fRDkHIB8K3Aaf1tUrHfuHMIRAjKpvegssSaqTSm3R/2cOoSJ
 3hwWTlb40mJRXLrWXURNQHBAaym8tcjfTcidGlw7c7xzcPk+WLHCPg/dKuzid9BCmxtJkPqb7+P
 7OEoRmdNPvwkSOP84yg==
X-Proofpoint-ORIG-GUID: 4Vqchfvbgp5zyA4WyCMngUwKlVZwAkIP
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE3MDA3NCBTYWx0ZWRfX1/7gwI3n5QQ6
 hgcEjDja87CYqf/yfHQbUmyqC5gvulKLh7E9AURVi5cgXfMajiLG/bxGAi4TYmGpjrJzK9DDBbr
 R40xVuevPhTU9GcvYZhObhmvnXuGg8Q=
X-Authority-Analysis: v=2.4 cv=DJe/JSNb c=1 sm=1 tr=0 ts=6a82e265 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8 a=P1mcZCzRt2f-fA_eBAMA:9
X-Proofpoint-GUID: WoboZ-pXtkhkSIRWMs2eEqRmjWk22bSZ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-16_06,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 spamscore=0 clxscore=1015 bulkscore=0
 suspectscore=0 malwarescore=0 phishscore=0 adultscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608170074
Received-SPF: pass client-ip=148.163.156.1; envelope-from=uverma@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01, SPF_HELO_NONE=0.001,
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

From: Utkarsh Verma <uverma@linux.ibm.com>

Extend the VOF client interface to support console I/O through the sPAPR VTY
device, which is needed by bootloaders such as GRUB during disk boot.

Add vof_read() to implement the OpenFirmware "read" client service, which was
previously missing.

Route the OF read and write services backed by vty_getchars() and vty_putchars()

Make vty_getchars() public similar to vty_putchars().

AI-used-for: code
Signed-off-by: Utkarsh Verma <uverma@linux.ibm.com>
---
 hw/char/spapr_vty.c        |  2 +-
 hw/ppc/spapr_vof.c         |  2 +
 hw/ppc/trace-events        |  2 +
 hw/ppc/vof.c               | 84 ++++++++++++++++++++++++++++++++++++++
 include/hw/ppc/spapr_vio.h |  1 +
 5 files changed, 90 insertions(+), 1 deletion(-)

diff --git a/hw/char/spapr_vty.c b/hw/char/spapr_vty.c
index 1dd9fb155c..2c97e0e027 100644
--- a/hw/char/spapr_vty.c
+++ b/hw/char/spapr_vty.c
@@ -52,7 +52,7 @@ static void vty_receive(void *opaque, const uint8_t *buf, int size)
     }
 }
 
-static int vty_getchars(SpaprVioDevice *sdev, uint8_t *buf, int max)
+int vty_getchars(SpaprVioDevice *sdev, uint8_t *buf, int max)
 {
     SpaprVioVty *dev = VIO_SPAPR_VTY_DEVICE(sdev);
     int n = 0;
diff --git a/hw/ppc/spapr_vof.c b/hw/ppc/spapr_vof.c
index 5bf9613005..a08d45c6a5 100644
--- a/hw/ppc/spapr_vof.c
+++ b/hw/ppc/spapr_vof.c
@@ -74,6 +74,8 @@ void spapr_vof_client_dt_finalize(SpaprMachineState *spapr, void *fdt)
     if (stdout_path) {
         _FDT(vof_client_open_store(fdt, spapr->vof, "/chosen", "stdout",
                                    stdout_path));
+        _FDT(vof_client_open_store(fdt, spapr->vof, "/chosen", "stdin",
+                                   stdout_path));
     }
 }
 
diff --git a/hw/ppc/trace-events b/hw/ppc/trace-events
index 1f125ce841..dbdcfada26 100644
--- a/hw/ppc/trace-events
+++ b/hw/ppc/trace-events
@@ -79,6 +79,7 @@ vof_error_unknown_method(const char *method) "\"%s\""
 vof_error_unknown_ihandle_close(uint32_t ih) "ih=0x%x"
 vof_error_unknown_path(const char *path) "\"%s\""
 vof_error_write(uint32_t ih) "ih=0x%x"
+vof_error_read(uint32_t ih) "ih=0x%x"
 vof_finddevice(const char *path, uint32_t ph) "\"%s\" => ph=0x%x"
 vof_claim(uint32_t virt, uint32_t size, uint32_t align, uint32_t ret) "virt=0x%x size=0x%x align=0x%x => 0x%x"
 vof_release(uint32_t virt, uint32_t size, uint32_t ret) "virt=0x%x size=0x%x => 0x%x"
@@ -92,6 +93,7 @@ vof_package_to_path(uint32_t ph, const char *tmp, int ret) "ph=0x%x => %s len=%d
 vof_instance_to_path(uint32_t ih, uint32_t ph, const char *tmp, int ret) "ih=0x%x ph=0x%x => %s len=%d"
 vof_instance_to_package(uint32_t ih, uint32_t ph) "ih=0x%x => ph=0x%x"
 vof_write(uint32_t ih, unsigned cb, const char *msg) "ih=0x%x [%u] \"%s\""
+vof_read(uint32_t ih, unsigned cb, const char *msg) "ih=0x%x [%u] \"%s\""
 vof_avail(uint64_t start, uint64_t end, uint64_t size) "0x%"PRIx64"..0x%"PRIx64" size=0x%"PRIx64
 vof_claimed(uint64_t start, uint64_t end, uint64_t size) "0x%"PRIx64"..0x%"PRIx64" size=0x%"PRIx64
 
diff --git a/hw/ppc/vof.c b/hw/ppc/vof.c
index a78bb1f116..45c197df9f 100644
--- a/hw/ppc/vof.c
+++ b/hw/ppc/vof.c
@@ -9,6 +9,7 @@
  * SPDX-License-Identifier: GPL-2.0-or-later
  */
 
+#include CONFIG_DEVICES /* CONFIG_PSERIES */
 #include "qemu/osdep.h"
 #include "qemu/timer.h"
 #include "qemu/range.h"
@@ -22,6 +23,7 @@
 #include "qom/qom-qobject.h"
 #include "trace.h"
 
+#include "hw/ppc/spapr_vio.h"
 #include <libfdt.h>
 
 /*
@@ -44,6 +46,7 @@ typedef struct {
 typedef struct {
     char *path; /* the path used to open the instance */
     uint32_t phandle;
+    void *vty;
 } OfInstance;
 
 static int readstr(hwaddr pa, char *buf, int size)
@@ -458,6 +461,28 @@ static uint32_t vof_do_open(void *fdt, Vof *vof, int offset, const char *path)
     ++vof->of_instance_last;
 
     inst->path = g_strdup(path);
+    inst->vty = NULL;
+
+#ifdef CONFIG_PSERIES
+    const char *node_name = fdt_get_name(fdt, offset, NULL);
+    if (node_name && strncmp(node_name, "vty", 3) == 0) {
+        uint8_t discard_buf[VOF_VTY_BUF_SIZE];
+        MachineState *ms = MACHINE(qdev_get_machine());
+        SpaprMachineState *spapr = SPAPR_MACHINE(ms);
+
+        if (spapr && spapr->vio_bus) {
+            inst->vty = spapr_vty_get_default(spapr->vio_bus);
+            if (inst->vty) {
+                /* Flush any stale data from the VTY input buffer */
+                while (vty_getchars(inst->vty, discard_buf,
+                                    sizeof(discard_buf)) > 0) {
+                    /* discard */
+                }
+            }
+        }
+    }
+#endif
+
     g_hash_table_insert(vof->of_instances,
                         GINT_TO_POINTER(vof->of_instance_last),
                         inst);
@@ -576,6 +601,23 @@ static uint32_t vof_write(Vof *vof, uint32_t ihandle, uint32_t buf,
         return PROM_ERROR;
     }
 
+#ifdef CONFIG_PSERIES
+    if (inst->vty) {
+        uint32_t total_written = 0;
+
+        for ( ; len > 0; len -= cb) {
+            cb = MIN(len, sizeof(tmp));
+            if (VOF_MEM_READ(buf, tmp, cb) != MEMTX_OK) {
+                return PROM_ERROR;
+            }
+            vty_putchars(inst->vty, (uint8_t *)tmp, cb);
+            buf += cb;
+            total_written += cb;
+        }
+        return total_written;
+    }
+#endif
+
     for ( ; len > 0; len -= cb) {
         cb = MIN(len, sizeof(tmp) - 1);
         if (VOF_MEM_READ(buf, tmp, cb) != MEMTX_OK) {
@@ -593,6 +635,46 @@ static uint32_t vof_write(Vof *vof, uint32_t ihandle, uint32_t buf,
     return len;
 }
 
+static uint32_t vof_read(Vof *vof, uint32_t ihandle, uint32_t buf,
+                         uint32_t len)
+{
+    OfInstance *inst = (OfInstance *)
+        g_hash_table_lookup(vof->of_instances, GINT_TO_POINTER(ihandle));
+
+    if (!inst) {
+        trace_vof_error_read(ihandle);
+        return PROM_ERROR;
+    }
+
+#ifdef CONFIG_PSERIES
+    if (inst->vty) {
+        uint8_t tmp[VOF_VTY_BUF_SIZE];
+        unsigned cb = MIN(len, sizeof(tmp));
+        uint32_t bytes_read = vty_getchars(inst->vty, tmp, cb);
+        if (bytes_read > 0) {
+            if (VOF_MEM_WRITE(buf, tmp, bytes_read) != MEMTX_OK) {
+                trace_vof_error_read(ihandle);
+                return PROM_ERROR;
+            }
+        }
+        if (trace_event_get_state(TRACE_VOF_READ) &&
+            qemu_loglevel_mask(LOG_TRACE)) {
+            char trace_buf[VOF_VTY_BUF_SIZE + 1];
+            memcpy(trace_buf, tmp, bytes_read);
+            trace_buf[bytes_read] = '\0';
+            trace_vof_read(ihandle, bytes_read, trace_buf);
+        }
+        return bytes_read;
+    }
+#endif
+
+    /*
+     * For other devices, return 0 to indicate no data available.
+     * This allows GRUB to continue without blocking on input.
+     */
+    return 0;
+}
+
 static void vof_claimed_dump(GArray *claimed)
 {
     int i;
@@ -905,6 +987,8 @@ static uint32_t vof_client_handle(MachineState *ms, void *fdt, Vof *vof,
         ret = vof_instance_to_path(fdt, vof, args[0], args[1], args[2]);
     } else if (cmpserv("write", 3, 1)) {
         ret = vof_write(vof, args[0], args[1], args[2]);
+    } else if (cmpserv("read", 3, 1)) {
+        ret = vof_read(vof, args[0], args[1], args[2]);
     } else if (cmpserv("claim", 3, 1)) {
         uint64_t ret64 = vof_claim(vof, args[0], args[1], args[2]);
 
diff --git a/include/hw/ppc/spapr_vio.h b/include/hw/ppc/spapr_vio.h
index 0ea0dbae8b..81e7c0b91b 100644
--- a/include/hw/ppc/spapr_vio.h
+++ b/include/hw/ppc/spapr_vio.h
@@ -136,6 +136,7 @@ static inline int spapr_vio_dma_set(SpaprVioDevice *dev, uint64_t taddr,
 int spapr_vio_send_crq(SpaprVioDevice *dev, uint8_t *crq);
 
 SpaprVioDevice *vty_lookup(SpaprMachineState *spapr, target_ulong reg);
+int vty_getchars(SpaprVioDevice *sdev, uint8_t *buf, int max);
 void vty_putchars(SpaprVioDevice *sdev, uint8_t *buf, int len);
 void spapr_vty_create(SpaprVioBus *bus, Chardev *chardev);
 void spapr_vlan_create(SpaprVioBus *bus, NICInfo *nd);
-- 
2.54.0


