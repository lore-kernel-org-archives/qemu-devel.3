Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33F98C43458
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jul 2026 23:57:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1whFee-0001qq-N5; Tue, 07 Jul 2026 19:56:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zycai@linux.ibm.com>)
 id 1whFec-0001oq-5P; Tue, 07 Jul 2026 19:56:42 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zycai@linux.ibm.com>)
 id 1whFeY-0002kW-PB; Tue, 07 Jul 2026 19:56:41 -0400
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 667Mn3Kt822434; Tue, 7 Jul 2026 23:56:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
 content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=nStmc5vxsOdakVCIB
 sGbr3+rfZbAyZIn0upH4bKFWrY=; b=TdD22m8aoOG6bgQeL65mHOumYZ2QNNLGU
 DotsXfePOboBxxQkeRV3vBg0Vy64/H3o1IN+SczvNk0gJmvONzmVwx897tLSmLNo
 KVS+xbZMBQ+6y2z5H9fIJZAk0VqPnMpE7ln9ONawxv+SpkfzPtRWn/wOkTSBEPZC
 SkwrmBpBvsbbdYp2+ZMyLQJbfrjoXdz+QfaoDYVqraPUGzNGMyiNbmf17XwOQGNC
 +8FIhi3hDxH70s65z9IChsN/615k9zqIc8KOC4OYbqk8gHB66MqXmlSTw0sDoRtx
 JDFopk8bHi93wFNO9d0SbZdctDj63Q7yLOcvHRu1912yENiq/yDPg==
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4f6sw4sufd-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 07 Jul 2026 23:56:22 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 667NnbPF016092;
 Tue, 7 Jul 2026 23:56:21 GMT
Received: from smtprelay05.dal12v.mail.ibm.com ([172.16.1.7])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4f7cvw5bcc-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 07 Jul 2026 23:56:21 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (smtpav04.dal12v.mail.ibm.com
 [10.241.53.103])
 by smtprelay05.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 667NuLjW29819426
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 7 Jul 2026 23:56:21 GMT
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 0482B58052;
 Tue,  7 Jul 2026 23:56:21 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id A066458056;
 Tue,  7 Jul 2026 23:56:20 +0000 (GMT)
Received: from fedora-workstation.lan (unknown [9.61.116.2])
 by smtpav04.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Tue,  7 Jul 2026 23:56:20 +0000 (GMT)
From: Zhuoying Cai <zycai@linux.ibm.com>
To: qemu-s390x@nongnu.org, qemu-devel@nongnu.org
Subject: [PATCH v16 29/33] pc-bios/s390-ccw: Handle true secure IPL mode
Date: Tue,  7 Jul 2026 19:56:03 -0400
Message-ID: <20260707235615.2513487-9-zycai@linux.ibm.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260707231132.2492104-1-zycai@linux.ibm.com>
References: <20260707231132.2492104-1-zycai@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 5UVaA6DmmwJ5GJyFIHWK-2UuQi2dLqqV
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA3MDIzMyBTYWx0ZWRfX4VnspN8LRE4l
 O7imNk7XGXYmzhRdhLnJ7DBkYH7wY/UxU3vgPfpRmiF2n10FfwK/XBydOyrXnK75eERI+SMvAuF
 uHVZjLGLYeydjU1GTGsFe33YD1XXMhbShqCP8mMwxyUu8DhGZBKIkt1AXFrDTrAEkv+ukPZTg6e
 i4nXFRy4T6O94Vk/+AbKOLQqsjtK86/wN4bUVNnYXrfpZPsbnuEVKSZG9Ai0azJuAiwsg7O0eB0
 kP5QtsmNesujlCPSqM7mi55wCLbW5Q1m0HWTm+Y/+Jh2TZV0/M8/eooI0nbKskLra/hZL1PQHjG
 4aQW5+Or6OQIcqmBLPFF3k2kiNUGQWU94knU9BSguFXaeT73xtxMbP5aigVyyp6X1WxiKudERxj
 bmHEI+rYXy2fYQyiaoEoO/ciCDVIdq97ZhMhl11DZ1hXF87FRKCG2oHOYr+4KilAwoVQNK3/RAi
 DM+WXGeVp747rpitLEw==
X-Proofpoint-ORIG-GUID: 5UVaA6DmmwJ5GJyFIHWK-2UuQi2dLqqV
X-Authority-Analysis: v=2.4 cv=FqQ1OWrq c=1 sm=1 tr=0 ts=6a4d9226 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8 a=f2vt_NpQTvy9KJbTYrsA:9
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA3MDIzMyBTYWx0ZWRfXxwLumw041e57
 g3Hqk29+cze2gj9+X79DB4epdunoXh/AdKDDDhSKhKZrs6jN3Rn667130bqXRvddlSY/chIoh9W
 qYg3nDrgTQ1MFVaYfFNZjPfSAv/KlfI=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-07_06,2026-07-06_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 impostorscore=0 clxscore=1015 malwarescore=0 lowpriorityscore=0
 priorityscore=1501 bulkscore=0 suspectscore=0 spamscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607070233
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


