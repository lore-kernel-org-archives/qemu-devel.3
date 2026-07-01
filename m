Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E16F6C43458
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Jul 2026 20:51:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wf1u2-0007B3-S5; Wed, 01 Jul 2026 16:51:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zycai@linux.ibm.com>)
 id 1wf1ty-0006lY-Vm; Wed, 01 Jul 2026 16:51:23 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zycai@linux.ibm.com>)
 id 1wf1tw-0004VO-14; Wed, 01 Jul 2026 16:51:22 -0400
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 661GmZoV1398494; Wed, 1 Jul 2026 20:50:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=JDUqcBm9SbBu1IQ0Q
 VgtEHIzFbo/ae6DTp3QVtYW4Wg=; b=CZNSlSRWS5+YrbLxq41S2Wsw+cXi49dJ7
 V/QvG4EUjoCxes3F+xCpPHLWUV7nrfXiqY+8+TUxwArSRur6h0hVAeG6dYgSzhRe
 ANwlO7kvn7+L4CM8/HBXQQOZPCBU6uePkrV26HGWce7EkYK5OlIY5mJ5iZoXMhxI
 fZ+6ly4rpwh0khsLjB045lrIPms2LEOJxgejNfK9/Tq29xPYfmkUTbmbqtYo4VHh
 WgCFURC45qfn55K4p7IJ2ZZR1l/XjK/kJPoZsiFSsx3m5ASjgcbNXdZNSGxiyI9i
 cEgxD5V6lKeUPdxcVRDdNjOBUEAuwPEcbd1pQWEoBJTDDYf8Aml9A==
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4f26n5xntd-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 01 Jul 2026 20:50:56 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 661KnahO030797;
 Wed, 1 Jul 2026 20:50:55 GMT
Received: from smtprelay02.dal12v.mail.ibm.com ([172.16.1.4])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4f2u2ggxw8-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 01 Jul 2026 20:50:55 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (smtpav06.wdc07v.mail.ibm.com
 [10.39.53.233])
 by smtprelay02.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 661Kosrk29229776
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 1 Jul 2026 20:50:54 GMT
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 4F8F158056;
 Wed,  1 Jul 2026 20:50:54 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 7EF7F5803F;
 Wed,  1 Jul 2026 20:50:51 +0000 (GMT)
Received: from fedora-workstation.lan (unknown [9.61.149.234])
 by smtpav06.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Wed,  1 Jul 2026 20:50:51 +0000 (GMT)
From: Zhuoying Cai <zycai@linux.ibm.com>
To: qemu-s390x@nongnu.org, qemu-devel@nongnu.org
Cc: jrossi@linux.ibm.com, cohuck@redhat.com, berrange@redhat.com,
 richard.henderson@linaro.org, david@kernel.org, walling@linux.ibm.com,
 jjherne@linux.ibm.com, pasic@linux.ibm.com, borntraeger@linux.ibm.com,
 farman@linux.ibm.com, mjrosato@linux.ibm.com, iii@linux.ibm.com,
 eblake@redhat.com, armbru@redhat.com, zycai@linux.ibm.com,
 alifm@linux.ibm.com, brueckner@linux.ibm.com,
 pierrick.bouvier@oss.qualcomm.com, jdaley@linux.ibm.com
Subject: [PATCH v12 29/35] pc-bios/s390-ccw: Handle true secure IPL mode
Date: Wed,  1 Jul 2026 16:49:15 -0400
Message-ID: <20260701204922.1320349-30-zycai@linux.ibm.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260701204922.1320349-1-zycai@linux.ibm.com>
References: <20260701204922.1320349-1-zycai@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzAxMDIyMiBTYWx0ZWRfXwhNDzhX/uCfZ
 d0jw4IwbsawjYz28FEjP/s40Eb4FBHZZI84lMidayFsbx98XlAg3EV5l8cLYdUzL2ntmjQo17Rl
 so9nR9hYpugYmakqgvAe/Nqm+Sa9peRB9ZNknpZt/y7JKdhKqJ5M4ybzjTr/jmXxpqzdiG3qMR1
 gPuFrtGi/I+71npRI7f4YE8RA4djw5gGGLWKAeC7GE0BOayAL7eD/1OlDO9kkbcO/47RrxmI24T
 dHiYxQEm2fUgKWt261DyIPwXTJFrIQoSllMNdmuGj4a47vqDpqR46Hv89kOyYaS/vKA8tBYmHsL
 tj1CQruxZyedkyUaSFMDp/6IYievKawTO//80chmow6NBQ953WyHaZzLkidaL6+Uyc3ZHoClIt+
 50QDWlbyzwCPoeUHU4p8qkx2jNy4+1QmFKWXdN3318zcwtMeG1N4WLywgz2lrlVhj18dvbZW/df
 ELly6+0zPmX9kNZtKMw==
X-Authority-Analysis: v=2.4 cv=V45NF+ni c=1 sm=1 tr=0 ts=6a457db0 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8 a=D03tI8-wM19WNX2duQ4A:9
X-Proofpoint-ORIG-GUID: 0Ddhp7sZCGF0WhW9H2NSZ4FuMTcdrJuD
X-Proofpoint-GUID: 0Ddhp7sZCGF0WhW9H2NSZ4FuMTcdrJuD
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzAxMDIyMiBTYWx0ZWRfX2r50eMsGWFaM
 dGxG/2Uy8PIMmqSykc2WuvlletvSHaDLR1WCn5mstsC7qx4U1VZGDF345UN1dEXKvbMkDq+g3w+
 o4ntkQQxOW0I94b7/fLQLo0v+22gfM8=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-01_04,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 spamscore=0 suspectscore=0 lowpriorityscore=0 priorityscore=1501
 adultscore=0 clxscore=1015 impostorscore=0 malwarescore=0 bulkscore=0
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
 pc-bios/s390-ccw/bootmap.c       |  6 +++++-
 pc-bios/s390-ccw/main.c          |  7 ++++++-
 pc-bios/s390-ccw/s390-ccw.h      |  1 +
 pc-bios/s390-ccw/secure-ipl.h    |  3 +++
 5 files changed, 28 insertions(+), 2 deletions(-)

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
diff --git a/pc-bios/s390-ccw/bootmap.c b/pc-bios/s390-ccw/bootmap.c
index 1147124bd7..cbfbbfe35c 100644
--- a/pc-bios/s390-ccw/bootmap.c
+++ b/pc-bios/s390-ccw/bootmap.c
@@ -742,6 +742,7 @@ static int zipl_run(ScsiBlockPtr *pte)
     case ZIPL_BOOT_MODE_NORMAL:
         rc = zipl_run_normal(&entry, tmp_sec);
         break;
+    case ZIPL_BOOT_MODE_SECURE:
     case ZIPL_BOOT_MODE_SECURE_AUDIT:
         rc = zipl_run_secure(&entry, tmp_sec, &comp_list, &cert_list, &tmp_cert_buf);
         break;
@@ -761,7 +762,8 @@ static int zipl_run(ScsiBlockPtr *pte)
     /* should not return */
     write_reset_psw(entry->compdat.load_psw);
 
-    if (boot_mode == ZIPL_BOOT_MODE_SECURE_AUDIT) {
+    if (boot_mode == ZIPL_BOOT_MODE_SECURE ||
+        boot_mode == ZIPL_BOOT_MODE_SECURE_AUDIT) {
         update_cert_list(&cert_list);
         update_iirb(&comp_list, &cert_list);
         free(tmp_cert_buf);
@@ -1129,6 +1131,8 @@ ZiplBootMode get_boot_mode(uint8_t hdr_flags)
 
     if (!sipl_set && iplir_set) {
         return ZIPL_BOOT_MODE_SECURE_AUDIT;
+    } else if (sipl_set && iplir_set) {
+        return ZIPL_BOOT_MODE_SECURE;
     }
 
     return ZIPL_BOOT_MODE_NORMAL;
diff --git a/pc-bios/s390-ccw/main.c b/pc-bios/s390-ccw/main.c
index 7484429c9a..687946c471 100644
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
     default:
         break;
     }
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
index 1bacb4987a..da2e379ff3 100644
--- a/pc-bios/s390-ccw/secure-ipl.h
+++ b/pc-bios/s390-ccw/secure-ipl.h
@@ -60,6 +60,9 @@ static inline void zipl_secure_error(const char *message)
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


