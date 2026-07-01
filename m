Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9D50C43327
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Jul 2026 20:55:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wf1tW-0004m8-Aw; Wed, 01 Jul 2026 16:50:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zycai@linux.ibm.com>)
 id 1wf1tS-0004au-Bx; Wed, 01 Jul 2026 16:50:50 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zycai@linux.ibm.com>)
 id 1wf1tQ-0004Qt-27; Wed, 01 Jul 2026 16:50:50 -0400
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 661GmvrP1456449; Wed, 1 Jul 2026 20:50:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=8yCO8HXepI8L6Mfc1
 F1ks6KgBp51E/YNG/ZXlsH6+xY=; b=eFcgEhDNj8tey5ILsIpBxEUE+7JuLXKyV
 5XVJQ5Yf0Hk2fzBvn53Ciy5M/MntPX1pnhMs/PLubCCZiRVaSFuB81//cpB/n/kH
 yC3ZpbX/lPmankvfnSq9lBaUK4yFP4wloxnbI20Fs4kqPD9eTFINF7ZhOUn+cGw/
 hxpdDdJsT2pmpGOSVNVAW1NNl1SABu7qJIt0bGdhYnfEXxNlZM37S0SI6Wp59UQV
 gGsFBBUMbnVzlraFIthyx4YItHZ8exWKCnEWcMFFs3yoDVQo7Qp857/tNWD7EjNI
 tx8RJ9oJyGNe660F8GEFbe1uU9HwqpMIHe19ME8ZuDdXsbjD6ISCw==
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4f26pe6q5e-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 01 Jul 2026 20:50:35 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 661KneuT006304;
 Wed, 1 Jul 2026 20:50:34 GMT
Received: from smtprelay07.dal12v.mail.ibm.com ([172.16.1.9])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4f2uhygu6q-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 01 Jul 2026 20:50:34 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (smtpav06.wdc07v.mail.ibm.com
 [10.39.53.233])
 by smtprelay07.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 661KoXYb24969972
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 1 Jul 2026 20:50:33 GMT
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 511B45803F;
 Wed,  1 Jul 2026 20:50:33 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 92A6F5804E;
 Wed,  1 Jul 2026 20:50:30 +0000 (GMT)
Received: from fedora-workstation.lan (unknown [9.61.149.234])
 by smtpav06.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Wed,  1 Jul 2026 20:50:30 +0000 (GMT)
From: Zhuoying Cai <zycai@linux.ibm.com>
To: qemu-s390x@nongnu.org, qemu-devel@nongnu.org
Cc: jrossi@linux.ibm.com, cohuck@redhat.com, berrange@redhat.com,
 richard.henderson@linaro.org, david@kernel.org, walling@linux.ibm.com,
 jjherne@linux.ibm.com, pasic@linux.ibm.com, borntraeger@linux.ibm.com,
 farman@linux.ibm.com, mjrosato@linux.ibm.com, iii@linux.ibm.com,
 eblake@redhat.com, armbru@redhat.com, zycai@linux.ibm.com,
 alifm@linux.ibm.com, brueckner@linux.ibm.com,
 pierrick.bouvier@oss.qualcomm.com, jdaley@linux.ibm.com
Subject: [PATCH v12 22/35] pc-bios/s390-ccw: Introduce ZiplBootMode enum for
 IPL mode selection
Date: Wed,  1 Jul 2026 16:49:08 -0400
Message-ID: <20260701204922.1320349-23-zycai@linux.ibm.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260701204922.1320349-1-zycai@linux.ibm.com>
References: <20260701204922.1320349-1-zycai@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: vVNH0qcm9es8rMnDKUJ0evZ1LtMhmTDI
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzAxMDIyMiBTYWx0ZWRfXzcOd1X+V6SqA
 j7+nwPmuXtR2tlhb/Om9S8WaGutxKuSBtlCMnRBJ7m41kEngyqbw6Lf0U5h2y1TC2ATupUIxlZv
 LI3iI4PacTGc7MrW7GiO6XM2k/9/81Y=
X-Authority-Analysis: v=2.4 cv=edsNubEH c=1 sm=1 tr=0 ts=6a457d9b cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8 a=OEmD_Q5Wy55prwwHBkMA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzAxMDIyMiBTYWx0ZWRfX8A3MX3/YDWph
 mP5tG/vep0Ij4zxG7HUcHYQJKZvKPknK7GhbSXYX/z5ZedQyp3TKlSsJJhTQObwI9ucCnLYpkRN
 DwIHok/jQ7Bo/TcxYwRjBpsrcjyxbFK7jSnU3l5MGCRaSPyTBd6mjrVLWzFnasl0nYlzxCryMUT
 W0NpcPOkaRceIdkeYgzwI8NsSd4JAnKrGke21GVH7gACll5di0egGX5oKL0Mj9s1KUrzuIollE3
 WcwaLLmIBZ5Eo47gNVm18wSHwD0WIPhUYtuZftuydYs2nCtHrVhB/eZR10AigmuvyfJofLyOUzs
 fczExqdpSG6Q14DoaG4tlHzFQhkJYbosccCCFotVdd5bihEzxIaKo3ZIbSBLoxYop4c0MZyp1KI
 E7fWW3maL6LSn2TXID/fhHliDceljWdWzWwMJcsmpmQSBoYExASQdd9UpNi1F//+UOPhtL5q2Ah
 Gde8dOmOYEPdrd/dvsQ==
X-Proofpoint-ORIG-GUID: vVNH0qcm9es8rMnDKUJ0evZ1LtMhmTDI
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-01_04,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 malwarescore=0 adultscore=0 impostorscore=0 bulkscore=0
 spamscore=0 suspectscore=0 clxscore=1015 lowpriorityscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607010222
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

Add ZiplBootMode enumeration to support multiple IPL boot configurations.
Boot modes differentiate between normal boot and secure IPL operations,
enabled based on boot certificates specified via the boot-certs option.

Normal Mode: IPL when no certificates are provided. No signature
verification is performed.

This prepares for future secure IPL modes requiring signature
verification.

Signed-off-by: Zhuoying Cai <zycai@linux.ibm.com>
Reviewed-by: Collin Walling <walling@linux.ibm.com>
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
index b19981feb1..667a69f80d 100644
--- a/pc-bios/s390-ccw/bootmap.c
+++ b/pc-bios/s390-ccw/bootmap.c
@@ -733,7 +733,14 @@ static int zipl_run(ScsiBlockPtr *pte)
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
@@ -1105,12 +1112,16 @@ void zipl_load(void)
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
@@ -1121,6 +1132,9 @@ void zipl_load(void)
         return;
     }
 
+    IPL_assert((boot_mode == ZIPL_BOOT_MODE_NORMAL),
+                "Secure boot with the ECKD scheme is not supported!");
+
     switch (virtio_get_device_type()) {
     case VIRTIO_ID_BLOCK:
         zipl_load_vblk();
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


