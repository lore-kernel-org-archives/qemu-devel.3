Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 694F9C5DF97
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Aug 2026 12:56:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wzD8c-0000m5-3M; Wed, 26 Aug 2026 08:53:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farman@linux.ibm.com>)
 id 1wzD8E-0000AA-OM; Wed, 26 Aug 2026 08:53:31 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farman@linux.ibm.com>)
 id 1wzD83-0002sJ-Cx; Wed, 26 Aug 2026 08:53:30 -0400
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67QCW8Oj3978118; Wed, 26 Aug 2026 12:52:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=gRwwb9Uo9FhtQS+4J
 jYZs+X0fYv3wIvAS3wKJpD9uv4=; b=ZYgXlTvQZjSTWEnlU0Q4xFjSGixqEkXqM
 6ghE2FPE1j3ewwlQPTIgXWMUJjnowvUqqNeXH8ITaOpgrcKEJIzJZg7BYX+ZmP6Y
 86fQaHyGLG0wJtH6tsyWygb8yP4hdbHYnJNBspYraIDFRtl7u98ioHbHgS9H/uhP
 6XE7mH7jv/uZxi7lnwrDlWtrSTe/I8Ky/Db912XI7rhP9msN1AK1mLFNgd0n1Eel
 hlCZRVxYSdCRxDNR2jue+FqIauhZlqmohMkR6JzDBobXF+2wJCOkAKywTdq22k/9
 fVAIe3BRTvrXgrAyeibpbujJuZ57OlDlYNjhfvYktYP+HKX/3KlJw==
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4g73946pdn-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 26 Aug 2026 12:52:57 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67QCfPiP006769;
 Wed, 26 Aug 2026 12:52:56 GMT
Received: from smtprelay02.wdc07v.mail.ibm.com ([172.16.1.69])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4g7pfwa2ub-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 26 Aug 2026 12:52:56 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (smtpav02.wdc07v.mail.ibm.com
 [10.39.53.229])
 by smtprelay02.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 67QCqthA31457914
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 26 Aug 2026 12:52:55 GMT
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 0A83F5805B;
 Wed, 26 Aug 2026 12:52:55 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 252AA58059;
 Wed, 26 Aug 2026 12:52:54 +0000 (GMT)
Received: from li-479af74c-31f9-11b2-a85c-e4ddee11713b.ibm.com.com (unknown
 [9.61.78.161]) by smtpav02.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Wed, 26 Aug 2026 12:52:54 +0000 (GMT)
From: Eric Farman <farman@linux.ibm.com>
To: qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, Matthew Rosato <mjrosato@linux.ibm.com>,
 Cornelia Huck <cohuck@redhat.com>, Zhuoying Cai <zycai@linux.ibm.com>,
 Collin Walling <walling@linux.ibm.com>, Eric Farman <farman@linux.ibm.com>
Subject: [PULL 31/37] pc-bios/s390-ccw: Handle true secure IPL mode
Date: Wed, 26 Aug 2026 08:52:06 -0400
Message-ID: <20260826125213.1901252-32-farman@linux.ibm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260826125213.1901252-1-farman@linux.ibm.com>
References: <20260826125213.1901252-1-farman@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 56GG81ghafrSPUlMnzIyua0v3dDSJ1cn
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI2MDEwNCBTYWx0ZWRfX2B+Yp+yMnAXU
 peRn4F1ikS1rgyq3TZH3dKNOx0Z+S2X2gbqr4rMEyel/BiypLfRnbOqFjkQQqCfVTUdU5STNq4C
 NobduQEeNGe4joD1ckoJGhC4Qp+GqOjOjrKz62DdeZf8SHBYC+1STKCFpbq3+fGbje9/HT7xcye
 7pua6kz4OD2Vf7YvT9b9Cxqlkv3UViidc8UR+biLu6C5p1DyJHrMrHVrnnFaJ3rBMQG4J2O2fPl
 Ps5KbAFK/3EXCqACA6xxvi923UzPMw7uppYokX7JJSB3DAH9O3tIE8VO0cmAxdGOMz+GXKfdvNI
 DyYeeTBPpUFf2c/9KMBN2iEpTNfx0pdCeAMTcESOD/jQN0ojMpqNDuuwJ/ihuxuYD5wRQPm+gxO
 kOq70FDditJiK2Agb9RIXby4tXYqyA9TLfGPNWpfPnjEjdyaJN82NCiz0Yna9j/80b5xC/rZJxc
 TjPDv1vCcJ46mK9RfvA==
X-Authority-Analysis: v=2.4 cv=Y/nIdBeN c=1 sm=1 tr=0 ts=6a8ee1a9 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8
 a=f2vt_NpQTvy9KJbTYrsA:9
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI2MDEwNCBTYWx0ZWRfX7K2O/Hnrx5PV
 VBYbiOM/B3K6XZNJRJjfxbAUVZ/D1EzfoI+QpNNjddyF51xTiWr/woyLBEZqKOALqxEUkHRWIx0
 RJnLrzNad+IFLXwCb3BRLk2X3SP3ePw=
X-Proofpoint-ORIG-GUID: 56GG81ghafrSPUlMnzIyua0v3dDSJ1cn
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-26_03,2026-08-26_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 impostorscore=0 priorityscore=1501 adultscore=0 bulkscore=0
 suspectscore=0 malwarescore=0 clxscore=1015 lowpriorityscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608260104
Received-SPF: pass client-ip=148.163.156.1; envelope-from=farman@linux.ibm.com;
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

From: Zhuoying Cai <zycai@linux.ibm.com>

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
Link: https://lore.kernel.org/qemu-devel/20260730214624.2328883-30-zycai@linux.ibm.com
Signed-off-by: Eric Farman <farman@linux.ibm.com>
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
index 16c20313c8..9e0890f38d 100644
--- a/pc-bios/s390-ccw/bootmap.c
+++ b/pc-bios/s390-ccw/bootmap.c
@@ -743,6 +743,7 @@ static int zipl_run(ScsiBlockPtr *pte)
     case ZIPL_BOOT_MODE_NORMAL:
         rc = zipl_run_normal(&entry, tmp_sec);
         break;
+    case ZIPL_BOOT_MODE_SECURE:
     case ZIPL_BOOT_MODE_SECURE_AUDIT:
         rc = zipl_run_secure(&entry, tmp_sec, &comp_list, &cert_list, &tmp_cert_buf);
         break;
@@ -762,7 +763,8 @@ static int zipl_run(ScsiBlockPtr *pte)
 
     write_reset_psw(entry->compdat.load_psw);
 
-    if (boot_mode == ZIPL_BOOT_MODE_SECURE_AUDIT) {
+    if (boot_mode == ZIPL_BOOT_MODE_SECURE ||
+        boot_mode == ZIPL_BOOT_MODE_SECURE_AUDIT) {
         update_cert_list(&cert_list);
         update_iirb(&comp_list, &cert_list);
         free(tmp_cert_buf);
@@ -1130,6 +1132,8 @@ ZiplBootMode get_boot_mode(uint8_t hdr_flags)
 
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
index 64584dc8a7..b2afc155d2 100644
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
index ce354b4d6a..4908245b9b 100644
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
         /*
          * Errors are intentionally ignored in non-secure boot modes.
-- 
2.55.0


