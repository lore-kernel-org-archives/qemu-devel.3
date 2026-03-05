Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0F48F513E6
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Mar 2026 22:44:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vyHOt-0001Ll-6X; Thu, 05 Mar 2026 17:42:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zycai@linux.ibm.com>)
 id 1vyHOr-0001JM-3P; Thu, 05 Mar 2026 17:42:33 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zycai@linux.ibm.com>)
 id 1vyHOp-00079w-Hj; Thu, 05 Mar 2026 17:42:32 -0500
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 625CLKpU614134; Thu, 5 Mar 2026 22:42:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=UBCSYTtcDtHUfnQP8
 FILzLzHhxGQip36GzVqspovLW4=; b=BLknBdlDpFOOTtwPLjMPMFKD08eqTm5gN
 K1TkHdh6PaDteJad1KArMYJrmvBlScm+EApbGYWPR3g244/shr1B7iZn8Q6L7d7d
 OZxiuzIHGKXVkDP6wWYgEaAfFQMQG7xiyXyRt0duAoGZ9f9uhs9HghzCRprUiIJf
 lFUCkwaE9KMkZrPG3C1DM5nKkdSaVK0FC2pON6Q5PCGWz2YW+pzqvMQ+qNxXXJV6
 t+eX0ImST5/6CGAcZxbm9U3rpEngM4AyJuRIloUowLNu8I3dLgppw7BPGKhVmktT
 cJFwvvQw0z4se6CNmPG1GmUVUB9PWWIOOr8y5pWNq0z27RPi6IjhQ==
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4ckssmwgmc-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 05 Mar 2026 22:42:28 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 625MBEGJ010305;
 Thu, 5 Mar 2026 22:42:27 GMT
Received: from smtprelay07.wdc07v.mail.ibm.com ([172.16.1.74])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4cmc6kdajr-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 05 Mar 2026 22:42:27 +0000
Received: from smtpav01.dal12v.mail.ibm.com (smtpav01.dal12v.mail.ibm.com
 [10.241.53.100])
 by smtprelay07.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 625MgPX962783876
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 5 Mar 2026 22:42:26 GMT
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id CCB8D5805D;
 Thu,  5 Mar 2026 22:42:25 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 9F9C658058;
 Thu,  5 Mar 2026 22:42:24 +0000 (GMT)
Received: from fedora-workstation.ibmuc.com (unknown [9.61.36.214])
 by smtpav01.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Thu,  5 Mar 2026 22:42:24 +0000 (GMT)
From: Zhuoying Cai <zycai@linux.ibm.com>
To: thuth@redhat.com, berrange@redhat.com, jrossi@linux.ibm.com,
 qemu-s390x@nongnu.org, qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org, pierrick.bouvier@linaro.org,
 david@kernel.org, walling@linux.ibm.com, jjherne@linux.ibm.com,
 pasic@linux.ibm.com, borntraeger@linux.ibm.com, farman@linux.ibm.com,
 mjrosato@linux.ibm.com, iii@linux.ibm.com, eblake@redhat.com,
 armbru@redhat.com, zycai@linux.ibm.com, alifm@linux.ibm.com,
 brueckner@linux.ibm.com, jdaley@linux.ibm.com
Subject: [PATCH v9 25/30] pc-bios/s390-ccw: Handle true secure IPL mode
Date: Thu,  5 Mar 2026 17:41:40 -0500
Message-ID: <20260305224146.664053-26-zycai@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260305224146.664053-1-zycai@linux.ibm.com>
References: <20260305224146.664053-1-zycai@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzA1MDE5NCBTYWx0ZWRfXwJ0UeOrqLKZ6
 4jEZM3Q3+l/mlPJNiDjPPAHfJrKjzIKuuM4+PrnBHNOH3kwVKp1MhCfb3lqHjsBH5cu65gJkjEK
 KZfqB5bqi1mpWy8IhgOxGnVd/SL8nhoN7XfK7dQYKu411z3AyLn34JJx3NWZuwwB1foarVpbyv/
 2fa6LPCaeCVdAF33K7rOj5ulRAYMbck/J065ewGBjCd0o0x5OkcsarOehNBq+zWck5moiWB3tn2
 QAeHlOnX1xEnh5B4xvNAw+q9buj+ko7884wfBNFlZ2RU+OBKwzCGpG16YNU9NYsoyCZS+LapzGR
 45IYTd9rlJVvX5+dOGJssL52x+Rpk6pineSCv0Uyc6mge2Fpzw04AaOIn2IiG3xvNHRx5CkCcQ6
 dDgWToPp/RQnNrVE/hom5qsBUH79Z4/Vl6BM6ZrX2PeVEmSOuSblVb4Nj8J9IDW/7z//odYXOh5
 ODO9qONnrJA347G2vjw==
X-Proofpoint-ORIG-GUID: d9vWOaX5znLegzPtUjSsvdHWngTTnvc5
X-Proofpoint-GUID: d9vWOaX5znLegzPtUjSsvdHWngTTnvc5
X-Authority-Analysis: v=2.4 cv=AobjHe9P c=1 sm=1 tr=0 ts=69aa06d4 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8 a=k4r5r3Nqz0X3HBfsuYAA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-05_06,2026-03-04_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 lowpriorityscore=0 bulkscore=0 impostorscore=0 malwarescore=0
 spamscore=0 clxscore=1015 suspectscore=0 adultscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2603050194
Received-SPF: pass client-ip=148.163.158.5; envelope-from=zycai@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -11
X-Spam_score: -1.2
X-Spam_bar: -
X-Spam_report: (-1.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.892, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.622,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
 pc-bios/s390-ccw/bootmap.c       |  8 ++++++++
 pc-bios/s390-ccw/main.c          |  3 +++
 pc-bios/s390-ccw/s390-ccw.h      |  2 ++
 pc-bios/s390-ccw/secure-ipl.c    |  4 ++++
 pc-bios/s390-ccw/secure-ipl.h    |  3 +++
 6 files changed, 33 insertions(+)

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
index 43a661325f..9a61e989e0 100644
--- a/pc-bios/s390-ccw/bootmap.c
+++ b/pc-bios/s390-ccw/bootmap.c
@@ -738,6 +738,7 @@ static int zipl_run(ScsiBlockPtr *pte)
     entry = (ComponentEntry *)(&header[1]);
 
     switch (boot_mode) {
+    case ZIPL_BOOT_MODE_SECURE:
     case ZIPL_BOOT_MODE_SECURE_AUDIT:
         rc = zipl_run_secure(&entry, tmp_sec);
         break;
@@ -1120,9 +1121,16 @@ ZiplBootMode get_boot_mode(uint8_t hdr_flags)
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
index 7d1a9d4acc..7092942280 100644
--- a/pc-bios/s390-ccw/s390-ccw.h
+++ b/pc-bios/s390-ccw/s390-ccw.h
@@ -96,8 +96,10 @@ int virtio_read(unsigned long sector, void *load_addr);
 void zipl_load(void);
 
 typedef enum ZiplBootMode {
+    ZIPL_BOOT_MODE_INVALID = -1,
     ZIPL_BOOT_MODE_NORMAL = 0,
     ZIPL_BOOT_MODE_SECURE_AUDIT = 1,
+    ZIPL_BOOT_MODE_SECURE = 2,
 } ZiplBootMode;
 
 extern ZiplBootMode boot_mode;
diff --git a/pc-bios/s390-ccw/secure-ipl.c b/pc-bios/s390-ccw/secure-ipl.c
index 840b88a699..76b72fc8f4 100644
--- a/pc-bios/s390-ccw/secure-ipl.c
+++ b/pc-bios/s390-ccw/secure-ipl.c
@@ -288,6 +288,10 @@ static bool check_sclab_presence(uint8_t *sclab_magic,
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
2.53.0


