Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E47C2C43458
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jul 2026 23:42:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1whFPj-0002WD-0l; Tue, 07 Jul 2026 19:41:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zycai@linux.ibm.com>)
 id 1whFPh-0002Vh-7a; Tue, 07 Jul 2026 19:41:17 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zycai@linux.ibm.com>)
 id 1whFPf-0006HE-Fg; Tue, 07 Jul 2026 19:41:16 -0400
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 667MmliG163932; Tue, 7 Jul 2026 23:41:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=nStmc5vxsOdakVCIB
 sGbr3+rfZbAyZIn0upH4bKFWrY=; b=IGNqRCGPsVXt5D/ZJ4kquueyne3MuKk4K
 N2hwn/9DQiC8uW1FeMoct8FUCTrTcZksSd59RFaZXt2lg6PjcTiQYKLCyy1rGX1A
 oTiMkbHeUEla+NYyPOdC3rg63sN6h2QJUYKrr67L5gFwUDYsow3NmiqvFI6EazPH
 92cC1qQmN3ekP+Q1mK7APH3JJxsz7S5kvT2USly3/tG2yOiRGlwd8apt87pSmaRH
 FQcCkecumKJJq08KXFolmlck/PddZHef48622+ziNX4buvgQay6NlOo2IE2aZ62X
 lGFgWOKIiLgtr0Z29xRwSQXDfn3t0c45B27EvS7ebT0x/uCbmKsCw==
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4f6stst6vh-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 07 Jul 2026 23:41:12 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 667NYZih019407;
 Tue, 7 Jul 2026 23:41:11 GMT
Received: from smtprelay04.wdc07v.mail.ibm.com ([172.16.1.71])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4f7f6y4t3a-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 07 Jul 2026 23:41:11 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (smtpav05.dal12v.mail.ibm.com
 [10.241.53.104])
 by smtprelay04.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 667Nf9xF64028946
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 7 Jul 2026 23:41:09 GMT
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 6FF0558052;
 Tue,  7 Jul 2026 23:41:09 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 8CA6858056;
 Tue,  7 Jul 2026 23:41:07 +0000 (GMT)
Received: from fedora-workstation.lan (unknown [9.61.116.2])
 by smtpav05.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Tue,  7 Jul 2026 23:41:07 +0000 (GMT)
From: Zhuoying Cai <zycai@linux.ibm.com>
To: qemu-s390x@nongnu.org, qemu-devel@nongnu.org
Cc: jrossi@linux.ibm.com, cohuck@redhat.com, berrange@redhat.com,
 richard.henderson@linaro.org, david@kernel.org, walling@linux.ibm.com,
 jjherne@linux.ibm.com, pasic@linux.ibm.com, borntraeger@linux.ibm.com,
 farman@linux.ibm.com, mjrosato@linux.ibm.com, iii@linux.ibm.com,
 eblake@redhat.com, armbru@redhat.com, zycai@linux.ibm.com,
 alifm@linux.ibm.com, brueckner@linux.ibm.com,
 pierrick.bouvier@oss.qualcomm.com, jdaley@linux.ibm.com
Subject: [PATCH v16 29/33] pc-bios/s390-ccw: Handle true secure IPL mode
Date: Tue,  7 Jul 2026 19:40:42 -0400
Message-ID: <20260707234047.2499921-10-zycai@linux.ibm.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260707234047.2499921-1-zycai@linux.ibm.com>
References: <20260707231132.2492104-1-zycai@linux.ibm.com>
 <20260707234047.2499921-1-zycai@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: WKMx7biHQf26SZppuWGCjsMpGcknxEDN
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA3MDIyOSBTYWx0ZWRfX4gKH/qJEmfwM
 ufDTL2fm5DOeZJX3YQj4s66TFrs6/PYz4BQjKbDNIxchbb+hg+nAwsPLDC5LjwX5Dj9PF+eiV36
 hYp5VPYbMmBknY8XaFsl0TJ+43dgbHA=
X-Authority-Analysis: v=2.4 cv=DKW/JSNb c=1 sm=1 tr=0 ts=6a4d8e98 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8 a=f2vt_NpQTvy9KJbTYrsA:9
X-Proofpoint-GUID: WKMx7biHQf26SZppuWGCjsMpGcknxEDN
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA3MDIyOSBTYWx0ZWRfXzxWXMlXG7jZt
 0pS7vocpstnDEz35jOCXPGivH18PiM5qxyw5A9cpj7vAwB9Zztnd64k4l2VKc2FUxS+DwlxPIk/
 M41QZUFOAkRnCEBptu3lYvIL/1Z4wo9WlCSI5CBymMEfagxOfKk4t8iLLzFOU0pZD40J9MYxvfi
 ZyZY2qqhMjBEulmRaREhilCZeT3KL3cmSY+/qN+K3bJ7jb1pgFGvDA1DYLOrm6kCOWJDaZlkzcy
 SXluM3ORcZ82ZZGch5v0Xao+6VmKUVF603aEIMjatsyRrYyXgYLrg3jbqKD4DzUcA6CpbJqVo/L
 70jvPYvsNA10wmI73PfM3atQVArxZk0cZSs1mbpQ5P67ORclMoDecBP5s0C04cXAda+MsrQxL2L
 DQtTmHF90uUjyitQ7YeIb4kK96LArpuSpaK4Sp0hm9QQJJYX6H5gv3QITW7YpcCK/Ul9Bk5ERyx
 JfZ1J2Zv49yJ8OqBTqQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-07_06,2026-07-06_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 bulkscore=0 clxscore=1015 phishscore=0 impostorscore=0
 priorityscore=1501 adultscore=0 lowpriorityscore=0 suspectscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607070229
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

When secure boot is enabled (-secure-boot on) and certificate(s) are
provided, the boot operates in True Secure IPL mode.

Any verification error during True Secure IPL mode will cause the
entire boot process to terminate.

Secure IPL in audit mode requires at least one certificate provided in
the key store along with necessary facilities. If secure boot is enabled
but no certificate is provided, the boot process will also terminate, as
this is not a valid secure boot configuration.

Note: True Secure IPL mode is implemented for the SCSI scheme of
virtio-blk/virtio-scsi devices.

Signed-off-by: Zhuoying Cai <zycai@linux.ibm.com>
Reviewed-by: Collin Walling <walling@linux.ibm.com>
Reviewed-by: Matthew Rosato <mjrosato@linux.ibm.com>
---
 docs/system/s390x/secure-ipl.rst | 13 +++++++++++++
 hw/s390x/ipl.c                   |  3 ++-
 pc-bios/s390-ccw/bootmap.c       |  6 +++++-
 pc-bios/s390-ccw/main.c          |  7 ++++++-
 pc-bios/s390-ccw/s390-ccw.h      |  1 +
 pc-bios/s390-ccw/secure-ipl.h    |  3 +++
 6 files changed, 30 insertions(+), 3 deletions(-)

diff --git a/docs/system/s390x/secure-ipl.rst b/docs/system/s390x/secure-ipl.rst
index 9e3955f8fc..c8fb887ac0 100644
--- a/docs/system/s390x/secure-ipl.rst
+++ b/docs/system/s390x/secure-ipl.rst
@@ -66,3 +66,16 @@ Configuration:
 .. code-block:: shell
 
     qemu-system-s390x -machine s390-ccw-virtio,boot-certs.0.path=/.../qemu/certs,boot-certs.1.path=/another/path/cert.pem ...
+
+Secure Mode
+^^^^^^^^^^^
+
+When the ``secure-boot=on`` option is set and certificates are provided,
+a secure boot is performed with error reporting enabled. The boot process aborts
+if any error occurs.
+
+Configuration:
+
+.. code-block:: shell
+
+    qemu-system-s390x -machine s390-ccw-virtio,secure-boot=on,boot-certs.0.path=/.../qemu/certs,boot-certs.1.path=/another/path/cert.pem ...
diff --git a/hw/s390x/ipl.c b/hw/s390x/ipl.c
index 08294af4d0..35bdfe03d8 100644
--- a/hw/s390x/ipl.c
+++ b/hw/s390x/ipl.c
@@ -851,7 +851,8 @@ void s390_ipl_prepare_cpu(S390CPU *cpu)
              * Secure IPL without specifying a boot device.
              * IPLB is not generated if no boot device is defined.
              */
-            if (s390_has_certificate() && !ipl->iplb_valid) {
+            if ((s390_has_certificate() || s390_secure_boot_enabled()) &&
+                !ipl->iplb_valid) {
                 error_report("No boot device defined for Secure IPL");
                 exit(1);
             }
diff --git a/pc-bios/s390-ccw/bootmap.c b/pc-bios/s390-ccw/bootmap.c
index 276080709d..a506a663a0 100644
--- a/pc-bios/s390-ccw/bootmap.c
+++ b/pc-bios/s390-ccw/bootmap.c
@@ -741,6 +741,7 @@ static int zipl_run(ScsiBlockPtr *pte)
     case ZIPL_BOOT_MODE_NORMAL:
         rc = zipl_run_normal(&entry, tmp_sec);
         break;
+    case ZIPL_BOOT_MODE_SECURE:
     case ZIPL_BOOT_MODE_SECURE_AUDIT:
         rc = zipl_run_secure(&entry, tmp_sec, &comp_list, &cert_list, &tmp_cert_buf);
         break;
@@ -760,7 +761,8 @@ static int zipl_run(ScsiBlockPtr *pte)
     /* should not return */
     write_reset_psw(entry->compdat.load_psw);
 
-    if (boot_mode == ZIPL_BOOT_MODE_SECURE_AUDIT) {
+    if (boot_mode == ZIPL_BOOT_MODE_SECURE ||
+        boot_mode == ZIPL_BOOT_MODE_SECURE_AUDIT) {
         update_cert_list(&cert_list);
         update_iirb(&comp_list, &cert_list);
         free(tmp_cert_buf);
@@ -1128,6 +1130,8 @@ ZiplBootMode get_boot_mode(uint8_t hdr_flags)
 
     if (!sipl_set && iplir_set) {
         return ZIPL_BOOT_MODE_SECURE_AUDIT;
+    } else if (sipl_set && iplir_set) {
+        return ZIPL_BOOT_MODE_SECURE;
     }
 
     return ZIPL_BOOT_MODE_NORMAL;
diff --git a/pc-bios/s390-ccw/main.c b/pc-bios/s390-ccw/main.c
index 520c448c2c..c5c093534c 100644
--- a/pc-bios/s390-ccw/main.c
+++ b/pc-bios/s390-ccw/main.c
@@ -402,15 +402,20 @@ void main(void)
 
     boot_mode = get_boot_mode(iplb->hdr_flags);
     switch (boot_mode) {
+    case ZIPL_BOOT_MODE_SECURE:
     case ZIPL_BOOT_MODE_SECURE_AUDIT:
         if (!secure_ipl_supported()) {
-            panic("Unable to boot in audit mode");
+            panic("Unable to boot in secure/audit mode");
         }
 
         vcssb_len = zipl_secure_get_vcssb();
         if (vcssb_len == 0) {
             panic("Failed to query certificate storage information!");
         }
+
+        if (vcssb_len == VCSSB_NO_VC) {
+            panic("Need at least one certificate for secure boot!");
+        }
         break;
     default:
         break;
diff --git a/pc-bios/s390-ccw/s390-ccw.h b/pc-bios/s390-ccw/s390-ccw.h
index ca2737054d..0ea4810f1f 100644
--- a/pc-bios/s390-ccw/s390-ccw.h
+++ b/pc-bios/s390-ccw/s390-ccw.h
@@ -90,6 +90,7 @@ void zipl_load(void);
 typedef enum ZiplBootMode {
     ZIPL_BOOT_MODE_NORMAL = 0,
     ZIPL_BOOT_MODE_SECURE_AUDIT = 1,
+    ZIPL_BOOT_MODE_SECURE = 2,
 } ZiplBootMode;
 
 extern ZiplBootMode boot_mode;
diff --git a/pc-bios/s390-ccw/secure-ipl.h b/pc-bios/s390-ccw/secure-ipl.h
index 25eaf9cea0..0ffb22b695 100644
--- a/pc-bios/s390-ccw/secure-ipl.h
+++ b/pc-bios/s390-ccw/secure-ipl.h
@@ -59,6 +59,9 @@ static inline void zipl_secure_error(const char *message)
     case ZIPL_BOOT_MODE_SECURE_AUDIT:
         printf("AUDIT MODE WARNING: %s\n", message);
         break;
+    case ZIPL_BOOT_MODE_SECURE:
+        panic(message);
+        break;
     default:
         break;
     }
-- 
2.54.0


