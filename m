Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25D0DC43458
	for <qemu-devel@archiver.kernel.org>; Sat,  4 Jul 2026 21:44:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wg86W-0007lN-Mv; Sat, 04 Jul 2026 17:40:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zycai@linux.ibm.com>)
 id 1wg86U-0007gu-OC; Sat, 04 Jul 2026 17:40:50 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zycai@linux.ibm.com>)
 id 1wg86S-0008CN-RT; Sat, 04 Jul 2026 17:40:50 -0400
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 664KmUWj2446208; Sat, 4 Jul 2026 21:40:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=bZXLpTCRIet5K2tU2
 fLmGUZ3A8s/JQPRk7JCn2t/yA4=; b=khEpaHQ1u1xzyTrJ3cG69+/HvdUYPU7fN
 f6hn1m1QzOPg90JrBcATUJrmlu4HfAuP1viMSUU8K65PEbS/+buJhTDgtE90/j3o
 XojNeAz+OfT5GvbowKMnTgaoe6vfwUOvsG78jwlz+wUPK4g7JWUDhLOzBo+2G73N
 2U1LDsxix8hHFF8vX0QwaoXZx3jk75sQ7T0LBErykudw1690UXriKFNskdDUYp0u
 jC3wyCpedzrB5UcDokUZDlDNO3FqEuM1ae2doCafslORiE53sQJyuWpibTM0mVHt
 jLzmmOWVN8Xhqgr9b505qQAzckPWZCHLrT6FUkWncdKBsYqKAe96A==
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4f6rkdbc66-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Sat, 04 Jul 2026 21:40:44 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 664LYxxp010144;
 Sat, 4 Jul 2026 21:40:43 GMT
Received: from smtprelay07.dal12v.mail.ibm.com ([172.16.1.9])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4f2u2gxbtx-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Sat, 04 Jul 2026 21:40:43 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (smtpav04.wdc07v.mail.ibm.com
 [10.39.53.231])
 by smtprelay07.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 664LegxB9372264
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Sat, 4 Jul 2026 21:40:42 GMT
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 72ABC58056;
 Sat,  4 Jul 2026 21:40:42 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 4575958050;
 Sat,  4 Jul 2026 21:40:40 +0000 (GMT)
Received: from fedora-workstation.ibmuc.com (unknown [9.61.17.215])
 by smtpav04.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Sat,  4 Jul 2026 21:40:40 +0000 (GMT)
From: Zhuoying Cai <zycai@linux.ibm.com>
To: qemu-s390x@nongnu.org, qemu-devel@nongnu.org
Cc: jrossi@linux.ibm.com, cohuck@redhat.com, berrange@redhat.com,
 richard.henderson@linaro.org, david@kernel.org, walling@linux.ibm.com,
 jjherne@linux.ibm.com, pasic@linux.ibm.com, borntraeger@linux.ibm.com,
 farman@linux.ibm.com, mjrosato@linux.ibm.com, iii@linux.ibm.com,
 eblake@redhat.com, armbru@redhat.com, zycai@linux.ibm.com,
 alifm@linux.ibm.com, brueckner@linux.ibm.com,
 pierrick.bouvier@oss.qualcomm.com, jdaley@linux.ibm.com
Subject: [PATCH v15 22/33] pc-bios/s390-ccw: Introduce ZiplBootMode enum for
 IPL mode selection
Date: Sat,  4 Jul 2026 17:39:38 -0400
Message-ID: <20260704213950.2118823-23-zycai@linux.ibm.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260704213950.2118823-1-zycai@linux.ibm.com>
References: <20260704213950.2118823-1-zycai@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=M7J97Sws c=1 sm=1 tr=0 ts=6a497ddc cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8 a=6Ycx5JGYSpe9m2xj7koA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA0MDIyNCBTYWx0ZWRfX6RGmSCSz93b+
 B3LXYnojmdZzxt+ry3usyhYRV2pb7DzrTZg0XBs/FIlcBtScrHCUCCoylTJ0dNj4+tqJbCWvPq4
 0tdABQ2Wbn6kuBfvQx8GhRdYnJ16xG/iibAoIJUm5utnLAVsPA1tqUleoKGXANLsLI+BsBXQAKJ
 GpdXhjVh+Zq6ohkQp7LKh7FXtV2T5q8qIs8ibuI+TfTQaX1j+UqmvB9GWvT3pRffv9TAxHRbLzO
 VlQVM/rNjNRUjCK7Msdlp+62UZY4t6QnmywlIuPe8c7z/oNXxF/6t27uuWEyvLzRSSIywZ2RR4Z
 cij42rEK2CP6ystDSLQ1WyVz2eBTDQiHmWPYhwMKNYTu8zZfR5Douj7zveVwoKj2gJ2NApoYO6y
 DKu1LKkZkmtUYMaqgshVzDecweZviiwcYJYO9vefUdceUqaKbjYZO86Yqr/JS1lzVOvI1HFoAkp
 h+vKcInos/KcdsFVpkg==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA0MDIyNCBTYWx0ZWRfXy8JdAgaticHB
 PzzfDoBhzFXnnlvsMqjUrxnomP9bFjjachvk0zZXxGa7LxjzDps/uJK8g1GCwQZIxisIFMq4u7X
 xVSAThZKwSCfU+WRUqUYttUpwTD/bec=
X-Proofpoint-GUID: JHWdbNrIdFP4AMoKbJXbI8RWdogRzvov
X-Proofpoint-ORIG-GUID: JHWdbNrIdFP4AMoKbJXbI8RWdogRzvov
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-04_03,2026-07-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 lowpriorityscore=0 malwarescore=0 clxscore=1015 adultscore=0
 priorityscore=1501 bulkscore=0 spamscore=0 impostorscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607040224
Received-SPF: pass client-ip=148.163.158.5; envelope-from=zycai@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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

Add ZiplBootMode enumeration to support multiple IPL boot configurations.
Boot modes differentiate between normal boot and secure IPL operations,
enabled based on boot certificates specified via the boot-certs option.

Normal Mode: IPL when no certificates are provided. No signature
verification is performed.

This prepares for future secure IPL modes requiring signature
verification.

Signed-off-by: Zhuoying Cai <zycai@linux.ibm.com>
Reviewed-by: Collin Walling <walling@linux.ibm.com>
Reviewed-by: Jared Rossi <jrossi@linux.ibm.com>
---
 docs/system/s390x/secure-ipl.rst | 21 +++++++++++++++++++++
 pc-bios/s390-ccw/bootmap.c       | 16 +++++++++++++++-
 pc-bios/s390-ccw/main.c          |  6 ++++++
 pc-bios/s390-ccw/s390-ccw.h      |  6 ++++++
 4 files changed, 48 insertions(+), 1 deletion(-)

diff --git a/docs/system/s390x/secure-ipl.rst b/docs/system/s390x/secure-ipl.rst
index 88df52ce2f..9d7d33f5ed 100644
--- a/docs/system/s390x/secure-ipl.rst
+++ b/docs/system/s390x/secure-ipl.rst
@@ -18,3 +18,24 @@ Note: certificate files must have a .pem extension.
 .. code-block:: shell
 
     qemu-system-s390x -machine s390-ccw-virtio,boot-certs.0.path=/.../qemu/certs,boot-certs.1.path=/another/path/cert.pem ...
+
+
+IPL Modes
+---------
+
+Multiple IPL modes are available to differentiate between the various IPL
+configurations. These modes are mutually exclusive and enabled based on the
+``boot-certs`` option on the QEMU command line.
+
+Normal Mode
+^^^^^^^^^^^
+
+The absence of certificates will attempt to IPL a guest without secure IPL
+operations. No checks are performed, and no warnings/errors are reported.
+This is the default mode.
+
+Configuration:
+
+.. code-block:: shell
+
+    qemu-system-s390x -machine s390-ccw-virtio ...
diff --git a/pc-bios/s390-ccw/bootmap.c b/pc-bios/s390-ccw/bootmap.c
index d0ac97795d..7791ca179a 100644
--- a/pc-bios/s390-ccw/bootmap.c
+++ b/pc-bios/s390-ccw/bootmap.c
@@ -330,6 +330,9 @@ static int run_eckd_boot_script(block_number_t bmt_block_nr,
     /* The S1B block number is NULL_BLOCK_NR if and only if it's an LD-IPL */
     bool ldipl = (s1b_block_nr == NULL_BLOCK_NR);
 
+    IPL_assert((boot_mode == ZIPL_BOOT_MODE_NORMAL),
+                "Secure boot with the ECKD scheme is not supported!");
+
     if (menu_is_enabled_zipl() && !ldipl) {
         loadparm = eckd_get_boot_menu_index(s1b_block_nr);
     }
@@ -729,7 +732,14 @@ static int zipl_run(ScsiBlockPtr *pte)
     /* Load image(s) into RAM */
     entry = (ComponentEntry *)(&header[1]);
 
-    rc = zipl_run_normal(&entry, tmp_sec);
+    switch (boot_mode) {
+    case ZIPL_BOOT_MODE_NORMAL:
+        rc = zipl_run_normal(&entry, tmp_sec);
+        break;
+    default:
+        panic("Unknown boot mode");
+    }
+
     if (rc) {
         return rc;
     }
@@ -1101,12 +1111,16 @@ void zipl_load(void)
     VDev *vdev = virtio_get_device();
 
     if (vdev->is_cdrom) {
+        IPL_assert((boot_mode == ZIPL_BOOT_MODE_NORMAL),
+                   "Secure boot from ISO image is not supported!");
         ipl_iso_el_torito();
         puts("Failed to IPL this ISO image!");
         return;
     }
 
     if (virtio_get_device_type() == VIRTIO_ID_NET) {
+        IPL_assert((boot_mode == ZIPL_BOOT_MODE_NORMAL),
+                    "Virtio net boot device does not support secure boot!");
         netmain();
         puts("Failed to IPL from this network!");
         return;
diff --git a/pc-bios/s390-ccw/main.c b/pc-bios/s390-ccw/main.c
index b8f836c682..cd3d0776b0 100644
--- a/pc-bios/s390-ccw/main.c
+++ b/pc-bios/s390-ccw/main.c
@@ -30,6 +30,7 @@ IplParameterBlock *iplb;
 bool have_iplb;
 static uint16_t cutype;
 LowCore *lowcore; /* Yes, this *is* a pointer to address 0 */
+ZiplBootMode boot_mode;
 
 #define LOADPARM_PROMPT "PROMPT  "
 #define LOADPARM_EMPTY  "        "
@@ -303,6 +304,9 @@ static void ipl_ccw_device(void)
     switch (cutype) {
     case CU_TYPE_DASD_3990:
     case CU_TYPE_DASD_2107:
+        IPL_assert((boot_mode == ZIPL_BOOT_MODE_NORMAL),
+                    "Passthrough (vfio) CCW device does not support secure boot!");
+
         dasd_ipl(blk_schid, cutype);
         break;
     case CU_TYPE_VIRTIO:
@@ -390,6 +394,8 @@ void main(void)
         probe_boot_device();
     }
 
+    boot_mode = ZIPL_BOOT_MODE_NORMAL;
+
     while (have_iplb) {
         boot_setup();
         if (have_iplb && find_boot_device()) {
diff --git a/pc-bios/s390-ccw/s390-ccw.h b/pc-bios/s390-ccw/s390-ccw.h
index 1e1f71775e..5420443ad2 100644
--- a/pc-bios/s390-ccw/s390-ccw.h
+++ b/pc-bios/s390-ccw/s390-ccw.h
@@ -69,6 +69,12 @@ int sclp_read(char *str, size_t count);
 /* bootmap.c */
 void zipl_load(void);
 
+typedef enum ZiplBootMode {
+    ZIPL_BOOT_MODE_NORMAL = 0,
+} ZiplBootMode;
+
+extern ZiplBootMode boot_mode;
+
 /* jump2ipl.c */
 void write_reset_psw(uint64_t psw);
 int jump_to_IPL_code(uint64_t address);
-- 
2.54.0


