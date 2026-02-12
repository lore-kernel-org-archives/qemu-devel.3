Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93248EEA84E
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Feb 2026 20:48:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vqdYn-0001fY-UO; Thu, 12 Feb 2026 15:45:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zycai@linux.ibm.com>)
 id 1vqdYl-0001di-U7; Thu, 12 Feb 2026 15:45:11 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zycai@linux.ibm.com>)
 id 1vqdYk-0008Eq-4x; Thu, 12 Feb 2026 15:45:11 -0500
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 61CIJ0xE462104; Thu, 12 Feb 2026 20:44:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=sJlDmEVzqk18K10Pp
 AMkOQDM7T7FDhqU6WidqRyAs+M=; b=Ih/Fs46AquMlH0Sf1vL82CNRpM0kvPq4Q
 9iS4SYzVOtAxM5m4c+wbQng+gx7XkEs9VZ/o813hWrHeVnUrTEkyjUmiaEOBxrSu
 7fC0/ZMCgDtz+aXKmh0uTHf88O6KPj8lQGv+QyuF0nVg+3GzJFYWvCCnhFOQVhOB
 AiUZfkzAtysGxAKh84+XnM7a8+K4mRPvDWu3LnKrGIrJ3eZ7dYBqePhs/EUkeefi
 E7bp5vY51nuYJTAuH6AkBjo7p6LG7330UlQlSgPgNep4A/bLxYKFYuv35vvkKuoF
 Iny9m7Dx41MZbdi73ArzUo9b5iN/TdWuLApw5/+NGGPAPWy7Ltj3Q==
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4c696ur7xy-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 12 Feb 2026 20:44:46 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 61CHRXX3019336;
 Thu, 12 Feb 2026 20:44:45 GMT
Received: from smtprelay04.wdc07v.mail.ibm.com ([172.16.1.71])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4c6hxkbyww-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 12 Feb 2026 20:44:45 +0000
Received: from smtpav06.wdc07v.mail.ibm.com (smtpav06.wdc07v.mail.ibm.com
 [10.39.53.233])
 by smtprelay04.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 61CKih2w41222676
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 12 Feb 2026 20:44:43 GMT
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 5ED035804E;
 Thu, 12 Feb 2026 20:44:43 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 8C3C858054;
 Thu, 12 Feb 2026 20:44:41 +0000 (GMT)
Received: from fedora-workstation.ibmuc.com (unknown [9.61.112.15])
 by smtpav06.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Thu, 12 Feb 2026 20:44:41 +0000 (GMT)
From: Zhuoying Cai <zycai@linux.ibm.com>
To: thuth@redhat.com, berrange@redhat.com, richard.henderson@linaro.org,
 jrossi@linux.ibm.com, qemu-s390x@nongnu.org, qemu-devel@nongnu.org
Cc: david@kernel.org, walling@linux.ibm.com, jjherne@linux.ibm.com,
 pasic@linux.ibm.com, borntraeger@linux.ibm.com, farman@linux.ibm.com,
 mjrosato@linux.ibm.com, iii@linux.ibm.com, eblake@redhat.com,
 armbru@redhat.com, zycai@linux.ibm.com, alifm@linux.ibm.com,
 brueckner@linux.ibm.com
Subject: [PATCH v8 25/30] pc-bios/s390-ccw: Handle true secure IPL mode
Date: Thu, 12 Feb 2026 15:43:46 -0500
Message-ID: <20260212204352.1044699-26-zycai@linux.ibm.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260212204352.1044699-1-zycai@linux.ibm.com>
References: <20260212204352.1044699-1-zycai@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=KZnfcAYD c=1 sm=1 tr=0 ts=698e3bbe cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22 a=Mpw57Om8IfrbqaoTuvik:22
 a=GgsMoib0sEa3-_RKJdDe:22 a=VnNF1IyMAAAA:8 a=k4r5r3Nqz0X3HBfsuYAA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjEyMDE1NyBTYWx0ZWRfX1dITRvjDQjo8
 4TNKmqlds/G8MvbhpmANuJquuvLeLl2T8x/Ra3hU6O1GlGf+btFHHPItx7hGAvXwbpeqkpphXSd
 rAXkOiQVs69kGQiKu/qNTER+7Ec2BuHIvt/o3phhIHUMp52tfWDIqoj3hjmdRSIuYI8R2Cs98Ar
 oI8gt6u2LmFtE8thJPr07nPba4W2iq6/4pZLG0rPc2c+dkMgXly+dNcvD0mTPVRhk0F4x0NaunE
 Cr17pExU9K+9mF+/ISgQI7Zmqk2cVBCm7BOuioUi6fg0g1+e3VDqdIFp/J59W8059L0ETcaL3Dd
 9lj54ZSzw2L6btME1yrpXrqLDXgVf/NiQMuw3jQOQxeM5BculNQYaRF28vMnbYNWz9nOmIOU2cG
 4aA3OT5W5mpCTyAkLD2PzoYK/pDcfRpT+hsNEUZw5StL9uEwwCqhE0SsZkiyw+Z0cQ4WEbPenKr
 f6FrmF6cCR9PPaMInXw==
X-Proofpoint-ORIG-GUID: U5UsW-G73wLOf4neOaleb8y8VaqCtZ0m
X-Proofpoint-GUID: U5UsW-G73wLOf4neOaleb8y8VaqCtZ0m
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-12_05,2026-02-12_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 impostorscore=0 bulkscore=0 priorityscore=1501 adultscore=0
 clxscore=1015 suspectscore=0 phishscore=0 malwarescore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2602120157
Received-SPF: pass client-ip=148.163.156.1; envelope-from=zycai@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
---
 docs/system/s390x/secure-ipl.rst | 13 +++++++++++++
 pc-bios/s390-ccw/bootmap.c       | 11 +++++++++++
 pc-bios/s390-ccw/main.c          |  3 +++
 pc-bios/s390-ccw/s390-ccw.h      |  2 ++
 pc-bios/s390-ccw/secure-ipl.c    |  4 ++++
 pc-bios/s390-ccw/secure-ipl.h    |  3 +++
 6 files changed, 36 insertions(+)

diff --git a/docs/system/s390x/secure-ipl.rst b/docs/system/s390x/secure-ipl.rst
index 2465f8b26d..e0af086c38 100644
--- a/docs/system/s390x/secure-ipl.rst
+++ b/docs/system/s390x/secure-ipl.rst
@@ -65,3 +65,16 @@ Configuration:
 .. code-block:: shell
 
     qemu-system-s390x -machine s390-ccw-virtio,boot-certs.0.path=/.../qemu/certs,boot-certs.1.path=/another/path/cert.pem ...
+
+Secure Mode
+-----------
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
diff --git a/pc-bios/s390-ccw/bootmap.c b/pc-bios/s390-ccw/bootmap.c
index 43a661325f..699ef981e2 100644
--- a/pc-bios/s390-ccw/bootmap.c
+++ b/pc-bios/s390-ccw/bootmap.c
@@ -738,12 +738,16 @@ static int zipl_run(ScsiBlockPtr *pte)
     entry = (ComponentEntry *)(&header[1]);
 
     switch (boot_mode) {
+    case ZIPL_BOOT_MODE_SECURE:
     case ZIPL_BOOT_MODE_SECURE_AUDIT:
         rc = zipl_run_secure(&entry, tmp_sec);
         break;
     case ZIPL_BOOT_MODE_NORMAL:
         rc = zipl_run_normal(&entry, tmp_sec);
         break;
+    case ZIPL_BOOT_MODE_INVALID:
+        rc = -1;
+        break;
     default:
         puts("Unknown boot mode");
         rc = -1;
@@ -1120,9 +1124,16 @@ ZiplBootMode get_boot_mode(uint8_t hdr_flags)
 {
     bool sipl_set = hdr_flags & DIAG308_IPIB_FLAGS_SIPL;
     bool iplir_set = hdr_flags & DIAG308_IPIB_FLAGS_IPLIR;
+    VCStorageSizeBlock *vcssb;
 
     if (!sipl_set && iplir_set) {
         return ZIPL_BOOT_MODE_SECURE_AUDIT;
+    } else if (sipl_set && iplir_set) {
+        vcssb = zipl_secure_get_vcssb();
+        if (vcssb == NULL || vcssb->length == VCSSB_NO_VC) {
+            return ZIPL_BOOT_MODE_INVALID;
+        }
+        return ZIPL_BOOT_MODE_SECURE;
     }
 
     return ZIPL_BOOT_MODE_NORMAL;
diff --git a/pc-bios/s390-ccw/main.c b/pc-bios/s390-ccw/main.c
index 106cdf9dec..1678ede8fb 100644
--- a/pc-bios/s390-ccw/main.c
+++ b/pc-bios/s390-ccw/main.c
@@ -329,6 +329,9 @@ void main(void)
     }
 
     boot_mode = get_boot_mode(iplb->hdr_flags);
+    if (boot_mode == ZIPL_BOOT_MODE_INVALID) {
+        panic("Need at least one certificate for secure boot!");
+    }
 
     while (have_iplb) {
         boot_setup();
diff --git a/pc-bios/s390-ccw/s390-ccw.h b/pc-bios/s390-ccw/s390-ccw.h
index 8dbfb846d2..4038d5007b 100644
--- a/pc-bios/s390-ccw/s390-ccw.h
+++ b/pc-bios/s390-ccw/s390-ccw.h
@@ -83,8 +83,10 @@ int virtio_read(unsigned long sector, void *load_addr);
 void zipl_load(void);
 
 typedef enum ZiplBootMode {
+    ZIPL_BOOT_MODE_INVALID = -1,
     ZIPL_BOOT_MODE_NORMAL = 0,
     ZIPL_BOOT_MODE_SECURE_AUDIT = 1,
+    ZIPL_BOOT_MODE_SECURE = 2,
 } ZiplBootMode;
 
 extern ZiplBootMode boot_mode;
diff --git a/pc-bios/s390-ccw/secure-ipl.c b/pc-bios/s390-ccw/secure-ipl.c
index 54e41ec11c..3dfac62ccf 100644
--- a/pc-bios/s390-ccw/secure-ipl.c
+++ b/pc-bios/s390-ccw/secure-ipl.c
@@ -289,6 +289,10 @@ static bool check_sclab_presence(uint8_t *sclab_magic,
     }
 
     /* a missing SCLAB will not be reported in audit mode */
+    if (boot_mode == ZIPL_BOOT_MODE_SECURE) {
+        zipl_secure_handle("Magic does not match. SCLAB does not exist");
+    }
+
     return false;
 }
 
diff --git a/pc-bios/s390-ccw/secure-ipl.h b/pc-bios/s390-ccw/secure-ipl.h
index 4e9f4f08b9..1e736d53fe 100644
--- a/pc-bios/s390-ccw/secure-ipl.h
+++ b/pc-bios/s390-ccw/secure-ipl.h
@@ -60,6 +60,9 @@ static inline void zipl_secure_handle(const char *message)
     case ZIPL_BOOT_MODE_SECURE_AUDIT:
         IPL_check(false, message);
         break;
+    case ZIPL_BOOT_MODE_SECURE:
+        panic(message);
+        break;
     default:
         break;
     }
-- 
2.52.0


