Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75EACC43458
	for <qemu-devel@archiver.kernel.org>; Sat,  4 Jul 2026 21:42:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wg86a-0007na-KM; Sat, 04 Jul 2026 17:40:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zycai@linux.ibm.com>)
 id 1wg86Z-0007mT-62; Sat, 04 Jul 2026 17:40:55 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zycai@linux.ibm.com>)
 id 1wg86V-0008E9-Qo; Sat, 04 Jul 2026 17:40:54 -0400
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 664KmDFq2513132; Sat, 4 Jul 2026 21:40:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=qzaE6Fe9dh8Hdm1kX
 yhtZCoS1vrF02JLoyQefDTO/yg=; b=EEDG4XhjEfP+J+g5m2Ztr46nQQ9pnY17R
 PMGhaGn38VGp1Lyvn6+E/TEjKSaRMxnCZo2du2bp5lqhjXXM6sBPiSTv1WbrH8hY
 KgFwT0iGzS1SE8HWITvgfdOPKMDMHB5ERaLyh/LM6RMBvRj0rtJDKU69Uai/PAfO
 iwi+ld8AkAm3MG5t5NjsrIkW4J7mlW6LMmD0vNEKTq9WKdmUUARMP6Mf61SO6PTb
 Rz8BxMxy+d3in3Fq4csGhP54ir9nBp7tvzduGMphuvn39Fsya536dO3iCgp2rOnG
 JrD9m6YJ9pBQ8J78O307ndED58Mrsg6gjwVHNI13FxkZ304SqRT/A==
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4f6sw4b7np-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Sat, 04 Jul 2026 21:40:47 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 664LYbLk011929;
 Sat, 4 Jul 2026 21:40:46 GMT
Received: from smtprelay02.wdc07v.mail.ibm.com ([172.16.1.69])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4f2sukpgnk-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Sat, 04 Jul 2026 21:40:46 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (smtpav04.wdc07v.mail.ibm.com
 [10.39.53.231])
 by smtprelay02.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 664Leigx21627420
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Sat, 4 Jul 2026 21:40:44 GMT
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id B76F558045;
 Sat,  4 Jul 2026 21:40:44 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id AE30958050;
 Sat,  4 Jul 2026 21:40:42 +0000 (GMT)
Received: from fedora-workstation.ibmuc.com (unknown [9.61.17.215])
 by smtpav04.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Sat,  4 Jul 2026 21:40:42 +0000 (GMT)
From: Zhuoying Cai <zycai@linux.ibm.com>
To: qemu-s390x@nongnu.org, qemu-devel@nongnu.org
Cc: jrossi@linux.ibm.com, cohuck@redhat.com, berrange@redhat.com,
 richard.henderson@linaro.org, david@kernel.org, walling@linux.ibm.com,
 jjherne@linux.ibm.com, pasic@linux.ibm.com, borntraeger@linux.ibm.com,
 farman@linux.ibm.com, mjrosato@linux.ibm.com, iii@linux.ibm.com,
 eblake@redhat.com, armbru@redhat.com, zycai@linux.ibm.com,
 alifm@linux.ibm.com, brueckner@linux.ibm.com,
 pierrick.bouvier@oss.qualcomm.com, jdaley@linux.ibm.com
Subject: [PATCH v15 23/33] pc-bios/s390-ccw: Add signature verification for
 secure IPL in audit mode
Date: Sat,  4 Jul 2026 17:39:39 -0400
Message-ID: <20260704213950.2118823-24-zycai@linux.ibm.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260704213950.2118823-1-zycai@linux.ibm.com>
References: <20260704213950.2118823-1-zycai@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: l1GSBfIfvW4QTUbOcD5P1-ywMbvGN8lO
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA0MDIyNCBTYWx0ZWRfX/gDfNdE66Fmi
 zZ+vI2ADRGFPTI16fLYRvdd9ni/rDeLPIdQxm9GWDPCy+wG9I104QmFq+BI90h8QkgEsciOIEKq
 vht6Pb/0N/SnQdy9lm3n3djMwrHenX58XrA3ORUCl//RUmFy4OEFAojS0/F80OU56YuawPDvQsD
 QRyEzhf9z/34OJzO9KPAx24NdaiPwfOBWL5FLyURygL0QETEKni2rZ63yqrk3LW11Z2daNLguqZ
 j6/n42ViVAJonT2gkS6J2pltlbFlED16GfjAJ6aUt5Ywzjz/4KDz8Ax9XJpkEASJCkuYW5dBjiY
 XXj2wcIwLVXXhNcVNA5SsMHqh5QLtE6swhhCufTgtsoEdZIiqdA4B2U3wRvj/y6TofO6vtyEx+N
 gC6Xrek4M84OV+klqASpVlrBg1B1zQxr0qkxS0hAz9+YMajOgKlaxXJ6qpw9g5XunNpntSVo4YC
 VmLvNrhA8HMjYXXzs/w==
X-Proofpoint-ORIG-GUID: l1GSBfIfvW4QTUbOcD5P1-ywMbvGN8lO
X-Authority-Analysis: v=2.4 cv=FqQ1OWrq c=1 sm=1 tr=0 ts=6a497ddf cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8 a=Tktb4ypIQN7ojq7NPMkA:9
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA0MDIyNCBTYWx0ZWRfX6c4V0iHijeyp
 /+vfZIUNlFaUbcttTPVR8Ic0AWaTJE5FomeQnlSZA/FMynt+8LPKZaZQd+aLQMvvcR4eT2hj+yh
 0Qh5z7X/RVuaTqykgJgqrBBYa6FW3k0=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-04_03,2026-07-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 impostorscore=0 clxscore=1015 malwarescore=0 lowpriorityscore=0
 priorityscore=1501 bulkscore=0 suspectscore=0 spamscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607040224
Received-SPF: pass client-ip=148.163.156.1; envelope-from=zycai@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
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

Enable secure IPL in audit mode, which performs signature verification,
but any error does not terminate the boot process. Only warnings will be
logged to the console instead.

Secure IPL in audit mode requires at least one certificate provided in
the key store along with necessary facilities (Secure IPL Facility,
Certificate Store Facility and secure IPL extension support).

Note: Secure IPL in audit mode is implemented for the SCSI scheme of
virtio-blk/virtio-scsi devices.

Signed-off-by: Zhuoying Cai <zycai@linux.ibm.com>
Reviewed-by: Eric Farman <farman@linux.ibm.com>
---
 docs/system/s390x/secure-ipl.rst |  15 ++
 hw/s390x/ipl.c                   |   9 +
 pc-bios/s390-ccw/Makefile        |   2 +-
 pc-bios/s390-ccw/bootmap.c       |  27 +++
 pc-bios/s390-ccw/bootmap.h       |   9 +
 pc-bios/s390-ccw/jump2ipl.c      |   7 +
 pc-bios/s390-ccw/main.c          |  19 +-
 pc-bios/s390-ccw/s390-ccw.h      |  20 ++
 pc-bios/s390-ccw/sclp.c          |  27 +++
 pc-bios/s390-ccw/sclp.h          |   6 +
 pc-bios/s390-ccw/secure-ipl.c    | 363 +++++++++++++++++++++++++++++++
 pc-bios/s390-ccw/secure-ipl.h    | 115 ++++++++++
 12 files changed, 617 insertions(+), 2 deletions(-)
 create mode 100644 pc-bios/s390-ccw/secure-ipl.c
 create mode 100644 pc-bios/s390-ccw/secure-ipl.h

diff --git a/docs/system/s390x/secure-ipl.rst b/docs/system/s390x/secure-ipl.rst
index 9d7d33f5ed..cf6ccf5d57 100644
--- a/docs/system/s390x/secure-ipl.rst
+++ b/docs/system/s390x/secure-ipl.rst
@@ -39,3 +39,18 @@ Configuration:
 .. code-block:: shell
 
     qemu-system-s390x -machine s390-ccw-virtio ...
+
+Audit Mode
+^^^^^^^^^^
+
+When the certificate store is populated with at least one certificate
+and no additional secure IPL parameters are provided on the command
+line, then secure IPL will proceed in "audit mode". All secure IPL
+operations will be performed with signature verification errors reported
+as non-disruptive warnings.
+
+Configuration:
+
+.. code-block:: shell
+
+    qemu-system-s390x -machine s390-ccw-virtio,boot-certs.0.path=/.../qemu/certs,boot-certs.1.path=/another/path/cert.pem ...
diff --git a/hw/s390x/ipl.c b/hw/s390x/ipl.c
index 8dbabb1c2b..ee251d03a8 100644
--- a/hw/s390x/ipl.c
+++ b/hw/s390x/ipl.c
@@ -827,6 +827,15 @@ void s390_ipl_prepare_cpu(S390CPU *cpu)
         cpu->env.psw.addr = ipl->bios_start_addr;
         if (!ipl->iplb_valid) {
             ipl->iplb_valid = s390_init_all_iplbs(ipl);
+
+            /*
+             * Secure IPL without specifying a boot device.
+             * IPLB is not generated if no boot device is defined.
+             */
+            if (s390_has_certificate() && !ipl->iplb_valid) {
+                error_report("No boot device defined for Secure IPL");
+                exit(1);
+            }
         } else {
             ipl->qipl.chain_len = 0;
         }
diff --git a/pc-bios/s390-ccw/Makefile b/pc-bios/s390-ccw/Makefile
index 3e5dfb64d5..2109d16781 100644
--- a/pc-bios/s390-ccw/Makefile
+++ b/pc-bios/s390-ccw/Makefile
@@ -35,7 +35,7 @@ QEMU_DGFLAGS = -MMD -MP -MT $@ -MF $(@D)/$(*F).d
 
 OBJECTS = start.o main.o bootmap.o jump2ipl.o sclp.o menu.o netmain.o \
 	  virtio.o virtio-net.o virtio-scsi.o virtio-blkdev.o cio.o dasd-ipl.o \
-	  virtio-ccw.o clp.o pci.o virtio-pci.o
+	  virtio-ccw.o clp.o pci.o virtio-pci.o secure-ipl.o
 
 SLOF_DIR := $(SRC_PATH)/../../roms/SLOF
 
diff --git a/pc-bios/s390-ccw/bootmap.c b/pc-bios/s390-ccw/bootmap.c
index 7791ca179a..276080709d 100644
--- a/pc-bios/s390-ccw/bootmap.c
+++ b/pc-bios/s390-ccw/bootmap.c
@@ -10,11 +10,13 @@
 
 #include <string.h>
 #include <stdio.h>
+#include <stdlib.h>
 #include "s390-ccw.h"
 #include "s390-arch.h"
 #include "bootmap.h"
 #include "virtio.h"
 #include "bswap.h"
+#include "secure-ipl.h"
 
 #ifdef DEBUG
 /* #define DEBUG_FALLBACK */
@@ -710,6 +712,9 @@ static int zipl_run(ScsiBlockPtr *pte)
     ComponentHeader *header;
     ComponentEntry *entry;
     uint8_t tmp_sec[MAX_SECTOR_SIZE];
+    IplDeviceComponentList comp_list = { 0 };
+    IplSignatureCertificateList cert_list = { 0 };
+    uint8_t *tmp_cert_buf = NULL;
     int rc;
 
     if (virtio_read(pte->blockno, tmp_sec)) {
@@ -736,6 +741,9 @@ static int zipl_run(ScsiBlockPtr *pte)
     case ZIPL_BOOT_MODE_NORMAL:
         rc = zipl_run_normal(&entry, tmp_sec);
         break;
+    case ZIPL_BOOT_MODE_SECURE_AUDIT:
+        rc = zipl_run_secure(&entry, tmp_sec, &comp_list, &cert_list, &tmp_cert_buf);
+        break;
     default:
         panic("Unknown boot mode");
     }
@@ -751,6 +759,13 @@ static int zipl_run(ScsiBlockPtr *pte)
 
     /* should not return */
     write_reset_psw(entry->compdat.load_psw);
+
+    if (boot_mode == ZIPL_BOOT_MODE_SECURE_AUDIT) {
+        update_cert_list(&cert_list);
+        update_iirb(&comp_list, &cert_list);
+        free(tmp_cert_buf);
+    }
+
     jump_to_IPL_code(0);
     return -1;
 }
@@ -1106,6 +1121,18 @@ static int zipl_load_vscsi(void)
  * IPL starts here
  */
 
+ZiplBootMode get_boot_mode(uint8_t hdr_flags)
+{
+    bool sipl_set = hdr_flags & DIAG308_IPIB_FLAGS_SIPL;
+    bool iplir_set = hdr_flags & DIAG308_IPIB_FLAGS_IPLIR;
+
+    if (!sipl_set && iplir_set) {
+        return ZIPL_BOOT_MODE_SECURE_AUDIT;
+    }
+
+    return ZIPL_BOOT_MODE_NORMAL;
+}
+
 void zipl_load(void)
 {
     VDev *vdev = virtio_get_device();
diff --git a/pc-bios/s390-ccw/bootmap.h b/pc-bios/s390-ccw/bootmap.h
index 40580600b5..e1f4130752 100644
--- a/pc-bios/s390-ccw/bootmap.h
+++ b/pc-bios/s390-ccw/bootmap.h
@@ -88,9 +88,18 @@ typedef struct BootMapTable {
     BootMapPointer entry[];
 } __attribute__ ((packed)) BootMapTable;
 
+#define DER_SIGNATURE_FORMAT 1
+
+typedef struct SignatureInformation {
+    uint8_t format;
+    uint8_t reserved[3];
+    uint32_t sig_len;
+} SignatureInformation;
+
 typedef union ComponentEntryData {
     uint64_t load_psw;
     uint64_t load_addr;
+    SignatureInformation sig_info;
 } ComponentEntryData;
 
 typedef struct ComponentEntry {
diff --git a/pc-bios/s390-ccw/jump2ipl.c b/pc-bios/s390-ccw/jump2ipl.c
index fa2ca5cbe1..8e87c566f9 100644
--- a/pc-bios/s390-ccw/jump2ipl.c
+++ b/pc-bios/s390-ccw/jump2ipl.c
@@ -75,6 +75,13 @@ int jump_to_IPL_code(uint64_t address)
                  "diag %%r1,%%r1,0x308\n\t"
                  : : : "1", "memory");
     puts("IPL code jump failed");
+
+    /*
+     * A failed jump only occurs in extreme conditions, so abort the IPL entirely.
+     * This also prevents attempts to boot from the chain area if it has been
+     * overwritten with component data.
+     */
+    qipl.chain_len = 0;
     return -1;
 }
 
diff --git a/pc-bios/s390-ccw/main.c b/pc-bios/s390-ccw/main.c
index cd3d0776b0..b94a08e7bf 100644
--- a/pc-bios/s390-ccw/main.c
+++ b/pc-bios/s390-ccw/main.c
@@ -20,6 +20,7 @@
 #include "dasd-ipl.h"
 #include "clp.h"
 #include "virtio-pci.h"
+#include "secure-ipl.h"
 
 static SubChannelId blk_schid = { .one = 1 };
 static char loadparm_str[LOADPARM_LEN + 1];
@@ -383,6 +384,8 @@ static void probe_boot_device(void)
 
 void main(void)
 {
+    int vcssb_len;
+
     iplb = &ipl_blocks.iplb;
 
     copy_qipl();
@@ -394,7 +397,21 @@ void main(void)
         probe_boot_device();
     }
 
-    boot_mode = ZIPL_BOOT_MODE_NORMAL;
+    boot_mode = get_boot_mode(iplb->hdr_flags);
+    switch (boot_mode) {
+    case ZIPL_BOOT_MODE_SECURE_AUDIT:
+        if (!secure_ipl_supported()) {
+            panic("Unable to boot in audit mode");
+        }
+
+        vcssb_len = zipl_secure_get_vcssb();
+        if (vcssb_len == 0) {
+            panic("Failed to query certificate storage information!");
+        }
+        break;
+    default:
+        break;
+    }
 
     while (have_iplb) {
         boot_setup();
diff --git a/pc-bios/s390-ccw/s390-ccw.h b/pc-bios/s390-ccw/s390-ccw.h
index 5420443ad2..ca2737054d 100644
--- a/pc-bios/s390-ccw/s390-ccw.h
+++ b/pc-bios/s390-ccw/s390-ccw.h
@@ -40,6 +40,22 @@ typedef unsigned long long u64;
                             ((b) == 0 ? (a) : (MIN(a, b))))
 #endif
 
+/*
+ * Round number down to multiple. Requires that d be a power of 2.
+ * Works even if d is a smaller type than n.
+ */
+#ifndef ROUND_DOWN
+#define ROUND_DOWN(n, d) ((n) & -(0 ? (n) : (d)))
+#endif
+
+/*
+ * Round number up to multiple. Requires that d be a power of 2.
+ * Works even if d is a smaller type than n.
+ */
+#ifndef ROUND_UP
+#define ROUND_UP(n, d) ROUND_DOWN((n) + (d) - 1, (d))
+#endif
+
 #define ARRAY_SIZE(a) (sizeof(a) / sizeof((a)[0]))
 
 #include "cio.h"
@@ -64,6 +80,8 @@ void sclp_print(const char *string);
 void sclp_set_write_mask(uint32_t receive_mask, uint32_t send_mask);
 void sclp_setup(void);
 void sclp_get_loadparm_ascii(char *loadparm);
+bool sclp_is_diag320_on(void);
+bool sclp_is_fac_ipl_flag_on(uint16_t fac_ipl_flag);
 int sclp_read(char *str, size_t count);
 
 /* bootmap.c */
@@ -71,9 +89,11 @@ void zipl_load(void);
 
 typedef enum ZiplBootMode {
     ZIPL_BOOT_MODE_NORMAL = 0,
+    ZIPL_BOOT_MODE_SECURE_AUDIT = 1,
 } ZiplBootMode;
 
 extern ZiplBootMode boot_mode;
+ZiplBootMode get_boot_mode(uint8_t hdr_flags);
 
 /* jump2ipl.c */
 void write_reset_psw(uint64_t psw);
diff --git a/pc-bios/s390-ccw/sclp.c b/pc-bios/s390-ccw/sclp.c
index 4a07de018d..48bdfedf1f 100644
--- a/pc-bios/s390-ccw/sclp.c
+++ b/pc-bios/s390-ccw/sclp.c
@@ -113,6 +113,33 @@ void sclp_get_loadparm_ascii(char *loadparm)
     }
 }
 
+bool sclp_is_diag320_on(void)
+{
+    ReadInfo *sccb = (void *)_sccb;
+
+    memset((char *)_sccb, 0, sizeof(ReadInfo));
+    sccb->h.length = SCCB_SIZE;
+    if (!sclp_service_call(SCLP_CMDW_READ_SCP_INFO, sccb)) {
+        return sccb->fac134 & SCCB_FAC134_DIAG320_BIT;
+    }
+
+    return 0;
+}
+
+/* check if specified IPL facility flag is enabled */
+bool sclp_is_fac_ipl_flag_on(uint16_t fac_ipl_flag)
+{
+    ReadInfo *sccb = (void *)_sccb;
+
+    memset((char *)_sccb, 0, sizeof(ReadInfo));
+    sccb->h.length = SCCB_SIZE;
+    if (!sclp_service_call(SCLP_CMDW_READ_SCP_INFO, sccb)) {
+        return sccb->fac_ipl & fac_ipl_flag;
+    }
+
+    return 0;
+}
+
 int sclp_read(char *str, size_t count)
 {
     ReadEventData *sccb = (void *)_sccb;
diff --git a/pc-bios/s390-ccw/sclp.h b/pc-bios/s390-ccw/sclp.h
index 64b53cad29..a8a41cd004 100644
--- a/pc-bios/s390-ccw/sclp.h
+++ b/pc-bios/s390-ccw/sclp.h
@@ -50,6 +50,8 @@ typedef struct SCCBHeader {
 } __attribute__((packed)) SCCBHeader;
 
 #define SCCB_DATA_LEN (SCCB_SIZE - sizeof(SCCBHeader))
+#define SCCB_FAC134_DIAG320_BIT 0x4
+#define SCCB_FAC_IPL_SIPL_BIT   0x4000
 
 typedef struct ReadInfo {
     SCCBHeader h;
@@ -57,6 +59,10 @@ typedef struct ReadInfo {
     uint8_t rnsize;
     uint8_t reserved[13];
     uint8_t loadparm[LOADPARM_LEN];
+    uint8_t reserved1[102];
+    uint8_t fac134;
+    uint8_t reserved2;
+    uint16_t fac_ipl;
 } __attribute__((packed)) ReadInfo;
 
 typedef struct SCCB {
diff --git a/pc-bios/s390-ccw/secure-ipl.c b/pc-bios/s390-ccw/secure-ipl.c
new file mode 100644
index 0000000000..1ab41e5543
--- /dev/null
+++ b/pc-bios/s390-ccw/secure-ipl.c
@@ -0,0 +1,363 @@
+/*
+ * S/390 Secure IPL
+ *
+ * Functions to support IPL in secure boot mode (DIAG 320, DIAG 508,
+ * signature verification, and certificate handling).
+ *
+ * For secure IPL overview: docs/system/s390x/secure-ipl.rst
+ * For secure IPL technical: docs/specs/s390x-secure-ipl.rst
+ *
+ * Copyright 2025 IBM Corp.
+ * Author(s): Zhuoying Cai <zycai@linux.ibm.com>
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include <stdlib.h>
+#include <string.h>
+#include <stdio.h>
+#include "s390-ccw.h"
+#include "sclp.h"
+#include "secure-ipl.h"
+
+static VCStorageSizeBlock vcssb __attribute__((__aligned__(8)));
+
+#define for_each_rb_entry(entry, list) \
+    for (entry = (void *)(list) + sizeof((list)->ipl_info_header); \
+         (void *)(entry) + sizeof(*(entry)) <= \
+         (void *)(list) + (list)->ipl_info_header.len; \
+         entry++)
+
+int zipl_secure_get_vcssb(void)
+{
+    /* avoid retrieving vcssb multiple times */
+    if (vcssb.length == VCSSB_LEN_VALID) {
+        goto out;
+    }
+
+    vcssb.length = VCSSB_LEN_VALID;
+    if (_diag320(&vcssb, DIAG_320_SUBC_QUERY_VCSI) != DIAG_320_RC_OK) {
+        vcssb.length = 0;
+    }
+
+out:
+    return vcssb.length;
+}
+
+static uint32_t request_certificate(uint8_t *cert_buf, uint8_t index)
+{
+    VCEntryHeader *vce_hdr;
+    struct vcb {
+        VCBlockHeader vcb_hdr;
+        struct vce {
+            VCEntryHeader vce_hdr;
+            uint8_t cert_buf[CERT_BUF_MAX_LEN];
+        } vce;
+    } __attribute__((__aligned__(PAGE_SIZE))) vcb = { 0 };
+
+    /*
+     * Request single entry
+     * Fill input fields of single-entry VCB
+     *
+     * First and last index must be equal because only one
+     * VCE per VCB is currently supported
+     */
+    vcb.vcb_hdr.in_len = ROUND_UP(vcssb.max_single_vcb_len, PAGE_SIZE);
+    vcb.vcb_hdr.first_vc_index = index;
+    vcb.vcb_hdr.last_vc_index = index;
+
+    if (_diag320(&vcb, DIAG_320_SUBC_STORE_VC) != DIAG_320_RC_OK) {
+        puts("Could not get certificate");
+        return 0;
+    }
+
+    if (vcb.vcb_hdr.out_len == sizeof(VCBlockHeader)) {
+        puts("No certificate entry");
+        return 0;
+    }
+
+    if (vcb.vcb_hdr.remain_ct != 0) {
+        panic("Not enough memory to store requested certificate");
+    }
+
+    vce_hdr = &vcb.vce.vce_hdr;
+    if (!(vce_hdr->flags & DIAG_320_VCE_FLAGS_VALID)) {
+        puts("Invalid certificate");
+        return 0;
+    }
+
+    memcpy(cert_buf, (uint8_t *)&vcb.vce + vce_hdr->cert_offset, vce_hdr->cert_len);
+
+    return vce_hdr->cert_len;
+}
+
+static int cert_list_add(IplSignatureCertificateList *cert_list,
+                         IplSignatureCertificateEntry cert_entry)
+{
+    int cert_entry_idx;
+
+    cert_entry_idx = (cert_list->ipl_info_header.len - sizeof(IplInfoBlockHeader)) /
+                     sizeof(IplSignatureCertificateEntry);
+
+    cert_list->cert_entries[cert_entry_idx] = cert_entry;
+    cert_list->ipl_info_header.len += sizeof(IplSignatureCertificateEntry);
+
+    return cert_entry_idx;
+}
+
+static void comp_list_add(IplDeviceComponentList *comp_list,
+                          IplDeviceComponentEntry comp_entry)
+{
+    int comp_entry_idx;
+
+    comp_entry_idx = (comp_list->ipl_info_header.len - sizeof(IplInfoBlockHeader)) /
+                     sizeof(IplDeviceComponentEntry);
+    if (comp_entry_idx > MAX_COMP_ENTRIES - 1) {
+        printf("Warning: only %d component entries are supported\n",
+                MAX_COMP_ENTRIES);
+        panic("The device component list has reached its maximum capacity");
+    }
+
+    comp_list->device_entries[comp_entry_idx] = comp_entry;
+    comp_list->ipl_info_header.len += sizeof(IplDeviceComponentEntry);
+}
+
+void update_iirb(IplDeviceComponentList *comp_list,
+                 IplSignatureCertificateList *cert_list)
+{
+    IplInfoReportBlock *iirb;
+    IplDeviceComponentList *iirb_comps;
+    IplSignatureCertificateList *iirb_certs;
+    uint32_t iirb_hdr_len;
+    uint32_t comps_len;
+    uint32_t certs_len;
+
+    if (iplb->len % 8 != 0) {
+        panic("IPL parameter block length field value is not multiple of 8 bytes");
+    }
+
+    iirb_hdr_len = sizeof(IplInfoReportBlockHeader);
+    comps_len = comp_list->ipl_info_header.len;
+    certs_len = cert_list->ipl_info_header.len;
+    if ((comps_len + certs_len + iirb_hdr_len) > sizeof(IplInfoReportBlock)) {
+        panic("Not enough space to hold all components and certificates in IIRB");
+    }
+
+    /* IIRB immediately follows IPLB */
+    iirb = &ipl_blocks.iirb;
+    iirb->hdr.len = iirb_hdr_len;
+
+    /* Copy IPL device component list after IIRB Header */
+    iirb_comps = (IplDeviceComponentList *) iirb->info_blks;
+    memcpy(iirb_comps, comp_list, comps_len);
+
+    /* Update IIRB length */
+    iirb->hdr.len += comps_len;
+
+    /* Copy IPL sig cert list after IPL device component list */
+    iirb_certs = (IplSignatureCertificateList *) (iirb->info_blks +
+                                                  iirb_comps->ipl_info_header.len);
+    memcpy(iirb_certs, cert_list, certs_len);
+
+    /* Update IIRB length */
+    iirb->hdr.len += certs_len;
+}
+
+bool secure_ipl_supported(void)
+{
+    if (!sclp_is_fac_ipl_flag_on(SCCB_FAC_IPL_SIPL_BIT)) {
+        puts("Secure IPL Facility is not supported by the hypervisor!");
+        return false;
+    }
+
+    if (!is_signature_verif_supported()) {
+        puts("Secure IPL extensions are not supported by the hypervisor!");
+        return false;
+    }
+
+    if (!is_cert_store_facility_supported()) {
+        puts("Certificate Store Facility is not supported by the hypervisor!");
+        return false;
+    }
+
+    return true;
+}
+
+static void init_lists(IplDeviceComponentList *comp_list,
+                       IplSignatureCertificateList *cert_list)
+{
+    comp_list->ipl_info_header.type = IPL_INFO_BLOCK_TYPE_COMPONENTS;
+    comp_list->ipl_info_header.len = sizeof(IplInfoBlockHeader);
+
+    cert_list->ipl_info_header.type = IPL_INFO_BLOCK_TYPE_CERTIFICATES;
+    cert_list->ipl_info_header.len = sizeof(IplInfoBlockHeader);
+}
+
+static int zipl_load_signature(ComponentEntry *entry, uint64_t sig)
+{
+    if (entry->compdat.sig_info.format != DER_SIGNATURE_FORMAT) {
+        puts("Signature is not in DER format");
+        return -1;
+    }
+
+    if (zipl_load_segment(entry->data.blockno, sig) < 0) {
+        return -1;
+    }
+
+    return entry->compdat.sig_info.sig_len;
+}
+
+void update_cert_list(IplSignatureCertificateList *cert_list)
+{
+    IplSignatureCertificateEntry *cert_entry;
+    uint8_t *cert_buf;
+
+    /* Recover the original base address of ipl_data for cert storage */
+    cert_buf = (uint8_t *)qipl.ipl_data - qipl.index * sizeof(IplParameterBlock);
+
+    for_each_rb_entry(cert_entry, cert_list) {
+        memcpy(cert_buf, (uint8_t *)cert_entry->addr, cert_entry->len);
+        cert_entry->addr = (uint64_t)cert_buf;
+        cert_buf += cert_entry->len;
+    }
+}
+
+int zipl_run_secure(ComponentEntry **entry_ptr, const uint8_t *tmp_sec,
+                    IplDeviceComponentList *comp_list,
+                    IplSignatureCertificateList *cert_list,
+                    uint8_t **tmp_cert_buf)
+{
+    /*
+     * Keep track of which certificate store indices correspond to the
+     * certificate data entries within the IplSignatureCertificateList to
+     * prevent allocating space for the same certificate multiple times.
+     *
+     * The array index corresponds to the certificate's cert-store index.
+     *
+     * The array value corresponds to the certificate's entry within the
+     * IplSignatureCertificateList (with a value of -1 denoting no entry
+     * exists for the certificate).
+     */
+    int cert_list_table[vcssb.total_vc_ct + 1];
+    IplSignatureCertificateEntry sig_entry = { 0 };
+    IplSignatureCertificateEntry cert_entry;
+    IplDeviceComponentEntry comp_entry;
+    ComponentEntry *entry = *entry_ptr;
+    int rc = -1;
+    int sig_len = 0;
+    int comp_len;
+    int cert_entry_idx;
+    uint64_t comp_addr;
+    uint8_t cert_table_idx;
+    uint8_t *tmp_buf;
+    bool verified;
+    bool signed_found = false;
+
+    if ((MAX_SIGNED_COMP * CERT_BUF_MAX_LEN) > CERT_BUF_SIZE) {
+        panic("Not enough memory to store certificates");
+    }
+    *tmp_cert_buf = malloc(CERT_BUF_SIZE);
+    tmp_buf = *tmp_cert_buf;
+
+    init_lists(comp_list, cert_list);
+    sig_entry.addr = (uint64_t)malloc(MAX_SECTOR_SIZE);
+    memset(cert_list_table, -1, sizeof(cert_list_table));
+
+    while (entry->component_type != ZIPL_COMP_ENTRY_EXEC) {
+        switch (entry->component_type) {
+        case ZIPL_COMP_ENTRY_SIGNATURE:
+            if (sig_entry.len) {
+                goto error;
+            }
+
+            sig_len = zipl_load_signature(entry, sig_entry.addr);
+            if (sig_len < 0) {
+                goto error;
+            }
+
+            sig_entry.len = sig_len;
+            break;
+        case ZIPL_COMP_ENTRY_LOAD:
+            comp_addr = entry->compdat.load_addr;
+            comp_len = zipl_load_segment(entry->data.blockno, comp_addr);
+            if (comp_len < 0) {
+                goto error;
+            }
+
+            comp_entry = (IplDeviceComponentEntry){ 0 };
+            comp_entry.addr = comp_addr;
+            comp_entry.len = (uint64_t)comp_len;
+
+            /* no signature present (unsigned component) */
+            if (!sig_entry.len) {
+                comp_list_add(comp_list, comp_entry);
+                break;
+            }
+
+            /*
+             * Initialize with SC flag (signed component)
+             * CSV flag set upon successful verification
+             */
+            comp_entry.flags = S390_IPL_DEV_COMP_FLAG_SC;
+            signed_found = true;
+
+            cert_entry = (IplSignatureCertificateEntry) { 0 };
+            verified = verify_signature(comp_entry, sig_entry,
+                                        &cert_entry.len, &cert_table_idx);
+
+            if (verified) {
+                if (cert_list_table[cert_table_idx] == -1) {
+                    if (!request_certificate(tmp_buf, cert_table_idx)) {
+                        puts("Could not get certificate");
+                        goto error;
+                    }
+
+                    cert_entry.addr = (uint64_t)tmp_buf;
+                    cert_entry_idx = cert_list_add(cert_list, cert_entry);
+                    /* map cert-store index to cert-list entry index */
+                    cert_list_table[cert_table_idx] = cert_entry_idx;
+                    /* increment for the next certificate */
+                    tmp_buf += cert_entry.len;
+                }
+
+                comp_entry.cert_index = cert_list_table[cert_table_idx];
+                comp_entry.flags |= S390_IPL_DEV_COMP_FLAG_CSV;
+                puts("Verified component");
+            } else {
+                zipl_secure_error("Could not verify component");
+            }
+
+            comp_list_add(comp_list, comp_entry);
+
+            /* After a signature is used another new one can be accepted */
+            sig_entry.len = 0;
+            break;
+        default:
+            puts("Unknown component entry type");
+            goto error;
+        }
+
+        entry++;
+
+        if ((uint8_t *)(&entry[1]) > tmp_sec + MAX_SECTOR_SIZE) {
+            puts("Wrong entry value");
+            rc = -EINVAL;
+            goto error;
+        }
+    }
+
+    if (!signed_found) {
+        zipl_secure_error("Secure boot is on, but components are not signed");
+    }
+
+    *entry_ptr = entry;
+    free((void *)sig_entry.addr);
+
+    return 0;
+error:
+    free(*tmp_cert_buf);
+    *tmp_cert_buf = NULL;
+    free((void *)sig_entry.addr);
+
+    return rc;
+}
diff --git a/pc-bios/s390-ccw/secure-ipl.h b/pc-bios/s390-ccw/secure-ipl.h
new file mode 100644
index 0000000000..e192f8b61d
--- /dev/null
+++ b/pc-bios/s390-ccw/secure-ipl.h
@@ -0,0 +1,115 @@
+/*
+ * S/390 Secure IPL
+ *
+ * Copyright 2025 IBM Corp.
+ * Author(s): Zhuoying Cai <zycai@linux.ibm.com>
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#ifndef _PC_BIOS_S390_CCW_SECURE_IPL_H
+#define _PC_BIOS_S390_CCW_SECURE_IPL_H
+
+#include "bootmap.h"
+#include <diag320.h>
+#include <diag508.h>
+
+#define MAX_SIGNED_COMP     3
+
+int zipl_secure_get_vcssb(void);
+bool secure_ipl_supported(void);
+void update_iirb(IplDeviceComponentList *comp_list,
+                 IplSignatureCertificateList *cert_list);
+void update_cert_list(IplSignatureCertificateList *cert_list);
+int zipl_run_secure(ComponentEntry **entry_ptr, const uint8_t *tmp_sec,
+                    IplDeviceComponentList *comp_list,
+                    IplSignatureCertificateList *cert_list,
+                    uint8_t **tmp_cert_buf);
+
+static inline void zipl_secure_error(const char *message)
+{
+    switch (boot_mode) {
+    case ZIPL_BOOT_MODE_SECURE_AUDIT:
+        printf("AUDIT MODE WARNING: %s\n", message);
+        break;
+    default:
+        break;
+    }
+}
+
+static inline uint64_t _diag320(void *data, unsigned long subcode)
+{
+    register unsigned long addr asm("0") = (unsigned long)data;
+    register unsigned long rc asm("1") = 0;
+
+    asm volatile ("diag %0,%2,0x320\n"
+                  : "+d" (addr), "+d" (rc)
+                  : "d" (subcode)
+                  : "memory", "cc");
+    return rc;
+}
+
+static inline bool is_cert_store_facility_supported(void)
+{
+    uint32_t d320_ism;
+
+    if (!sclp_is_diag320_on()) {
+        return false;
+    }
+
+    if (_diag320(&d320_ism, DIAG_320_SUBC_QUERY_ISM) != DIAG_320_RC_OK) {
+        return false;
+    }
+
+    return d320_ism & (DIAG_320_ISM_QUERY_VCSI | DIAG_320_ISM_STORE_VC);
+}
+
+static inline uint64_t _diag508(void *data, unsigned long subcode)
+{
+    register unsigned long addr asm("0") = (unsigned long)data;
+    register unsigned long rc asm("1") = 0;
+
+    asm volatile ("diag %0,%2,0x508\n"
+                  : "+d" (addr), "+d" (rc)
+                  : "d" (subcode)
+                  : "memory", "cc");
+    return rc;
+}
+
+static inline bool is_signature_verif_supported(void)
+{
+    uint64_t d508_subcodes;
+
+    d508_subcodes = _diag508(NULL, DIAG_508_SUBC_QUERY_SUBC);
+    return d508_subcodes & DIAG_508_SUBC_SIG_VERIF;
+}
+
+static inline bool verify_signature(IplDeviceComponentEntry comp_entry,
+                                    IplSignatureCertificateEntry sig_entry,
+                                    uint64_t *cert_len, uint8_t *cert_idx)
+{
+    Diag508SigVerifBlock svb;
+
+    svb.length = sizeof(Diag508SigVerifBlock);
+    svb.version = 0;
+    svb.comp_len = comp_entry.len;
+    svb.comp_addr = comp_entry.addr;
+    svb.sig_len = sig_entry.len;
+    svb.sig_addr = sig_entry.addr;
+
+    if (_diag508(&svb, DIAG_508_SUBC_SIG_VERIF) == DIAG_508_RC_OK) {
+        *cert_len = svb.cert_len;
+        /*
+         * DIAG 508 utilizes an index origin of 0 when indexing the cert store.
+         * The cert_idx will be used for DIAG 320 data structures, which expects
+         * an index origin of 1. Account for the offset here so it's easier to
+         * manage later.
+         */
+        *cert_idx = svb.cert_store_index + 1;
+        return true;
+    }
+
+    return false;
+}
+
+#endif /* _PC_BIOS_S390_CCW_SECURE_IPL_H */
-- 
2.54.0


