Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C768CC43458
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jul 2026 17:03:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wfhHQ-0001V0-OF; Fri, 03 Jul 2026 13:02:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zycai@linux.ibm.com>)
 id 1wfhHM-000154-Pr; Fri, 03 Jul 2026 13:02:16 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zycai@linux.ibm.com>)
 id 1wfhHK-0003SB-LR; Fri, 03 Jul 2026 13:02:16 -0400
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 663GImpn3236637; Fri, 3 Jul 2026 17:02:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=q/F8oskhqbM+ZYkGP
 /O6XSARqFPsB4v2VUvHiKnBaiU=; b=s4g++oDU11N5UXoI9m5q5H9+Qi9iIDYxE
 gkaCMfMaZe90r3jIfBi6ePweZ/y57evC8bckcoF0KRWrHQ43pwwfv+VV24+fhEDL
 CIZs139BBkukvYwygnjNS4yWWU+Ir36CSN0GCLyZD7rbbImK2jvfdLTc4cpKA85o
 TWwmi31sy1QpHPCTho5yMqcNrvKy0FeEvMZMCjribzinLdFD9z0dX4rFEGGgB8Bx
 Ap8RtcUr3McCJf8Ug75/MNyK3xhmQz8FM2ebIkUoQ4yDRvsJ6m2fKPjdDnV0+qiS
 +XKW10l22JqSZ7+q1asRvzRYvXN1OsxfFizSjVhgH3cOg+QlOTE/Q==
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4f26rffmhu-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 03 Jul 2026 17:02:11 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 663GnaSt019636;
 Fri, 3 Jul 2026 17:02:10 GMT
Received: from smtprelay06.wdc07v.mail.ibm.com ([172.16.1.73])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4f2ruqsy86-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 03 Jul 2026 17:02:10 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (smtpav03.wdc07v.mail.ibm.com
 [10.39.53.230])
 by smtprelay06.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 663H28o224707756
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 3 Jul 2026 17:02:08 GMT
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id BED3358054;
 Fri,  3 Jul 2026 17:02:08 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id AAFCE5805C;
 Fri,  3 Jul 2026 17:02:05 +0000 (GMT)
Received: from fedora-workstation.lan (unknown [9.61.75.28])
 by smtpav03.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Fri,  3 Jul 2026 17:02:05 +0000 (GMT)
From: Zhuoying Cai <zycai@linux.ibm.com>
To: qemu-s390x@nongnu.org, qemu-devel@nongnu.org
Cc: jrossi@linux.ibm.com, cohuck@redhat.com, berrange@redhat.com,
 richard.henderson@linaro.org, david@kernel.org, walling@linux.ibm.com,
 jjherne@linux.ibm.com, pasic@linux.ibm.com, borntraeger@linux.ibm.com,
 farman@linux.ibm.com, mjrosato@linux.ibm.com, iii@linux.ibm.com,
 eblake@redhat.com, armbru@redhat.com, zycai@linux.ibm.com,
 alifm@linux.ibm.com, brueckner@linux.ibm.com,
 pierrick.bouvier@oss.qualcomm.com, jdaley@linux.ibm.com
Subject: [PATCH v14 29/33] pc-bios/s390-ccw: Handle true secure IPL mode
Date: Fri,  3 Jul 2026 13:00:26 -0400
Message-ID: <20260703170032.1893204-30-zycai@linux.ibm.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260703170032.1893204-1-zycai@linux.ibm.com>
References: <20260703170032.1893204-1-zycai@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=a4kAM0SF c=1 sm=1 tr=0 ts=6a47eb13 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8 a=7NyXUy-cZM7U7AFZmwYA:9
X-Proofpoint-ORIG-GUID: svt8O4AGr1Eu4bLz27GWCv7bOGYxHC02
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzAzMDE2NyBTYWx0ZWRfX9Hf2voEGLxX0
 nYtv9Yk0Ktry1OQlDEx15M1Z4pFCvwfbxCZMjnrH0e+VYKmUwJYOxxI0+zXNROW71f2799Vecnb
 UNUdrGwhI7tDMxa6FgCHpd2BHPRRC6RQXiKU6mbOTuADOLkUfMa7XFSnjvyHEGjYQv5khAaVf/0
 dyjiebDr2BDQFZHSkhVNBGqRdsdqmhbqh+yrBeDxw0AEhAg12TFJXC8k+jHrJRkQc/pIb1OffB4
 gho25rpxG6FKhx+1qqPSia24oXQ90X71XRa+mpLZTw3pOUyJmFL8MBgMOlAHF6jQHowa5Y4w4jN
 Jz7f0dI+/ZmBAXuDM2FLanp0+ZGmJhvh0v8ijpdRLUAekxygIdu9H0X9xWPQLPtZMfmmp3afi8y
 R8jNBeNtjvKizKOdU9eATb1sDK1prxxjNTokNXqLaA1j4qasXpJLbsDckpZVz9HxSF2UKPFca8t
 8i6ct0cdYJYVuYSZ/9g==
X-Proofpoint-GUID: svt8O4AGr1Eu4bLz27GWCv7bOGYxHC02
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzAzMDE2NyBTYWx0ZWRfX8u8s1ZY9mGgQ
 5XZ/P1HsCNqa1FdQsWIIcB8n9dCUW1FhQGU0VcoxNtz7dImj9yZmNFjwnaklRn4c2LoqMXkvDqO
 TJGrjg6NJuceS9Aog7r+Xu5R4TyOIWM=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-03_03,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 bulkscore=0 suspectscore=0 lowpriorityscore=0 impostorscore=0
 spamscore=0 priorityscore=1501 adultscore=0 malwarescore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607030167
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
index 62a3c60530..a99d3e3306 100644
--- a/hw/s390x/ipl.c
+++ b/hw/s390x/ipl.c
@@ -849,7 +849,8 @@ void s390_ipl_prepare_cpu(S390CPU *cpu)
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
index 7cdeec7064..b2c9f4a7b9 100644
--- a/pc-bios/s390-ccw/bootmap.c
+++ b/pc-bios/s390-ccw/bootmap.c
@@ -738,6 +738,7 @@ static int zipl_run(ScsiBlockPtr *pte)
     case ZIPL_BOOT_MODE_NORMAL:
         rc = zipl_run_normal(&entry, tmp_sec);
         break;
+    case ZIPL_BOOT_MODE_SECURE:
     case ZIPL_BOOT_MODE_SECURE_AUDIT:
         rc = zipl_run_secure(&entry, tmp_sec, &comp_list, &cert_list, &tmp_cert_buf);
         break;
@@ -757,7 +758,8 @@ static int zipl_run(ScsiBlockPtr *pte)
     /* should not return */
     write_reset_psw(entry->compdat.load_psw);
 
-    if (boot_mode == ZIPL_BOOT_MODE_SECURE_AUDIT) {
+    if (boot_mode == ZIPL_BOOT_MODE_SECURE ||
+        boot_mode == ZIPL_BOOT_MODE_SECURE_AUDIT) {
         update_cert_list(&cert_list);
         update_iirb(&comp_list, &cert_list);
         free(tmp_cert_buf);
@@ -1125,6 +1127,8 @@ ZiplBootMode get_boot_mode(uint8_t hdr_flags)
 
     if (!sipl_set && iplir_set) {
         return ZIPL_BOOT_MODE_SECURE_AUDIT;
+    } else if (sipl_set && iplir_set) {
+        return ZIPL_BOOT_MODE_SECURE;
     }
 
     return ZIPL_BOOT_MODE_NORMAL;
diff --git a/pc-bios/s390-ccw/main.c b/pc-bios/s390-ccw/main.c
index b94a08e7bf..1bf77d1594 100644
--- a/pc-bios/s390-ccw/main.c
+++ b/pc-bios/s390-ccw/main.c
@@ -399,15 +399,20 @@ void main(void)
 
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
index 4030ef8480..b80533bc31 100644
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


