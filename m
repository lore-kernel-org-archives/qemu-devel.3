Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62AFCC83F1A
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Jul 2025 21:16:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uaL2L-0000yJ-5t; Fri, 11 Jul 2025 17:12:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zycai@linux.ibm.com>)
 id 1uaL2E-0000qQ-Ju; Fri, 11 Jul 2025 17:11:59 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zycai@linux.ibm.com>)
 id 1uaL2C-00032c-Ji; Fri, 11 Jul 2025 17:11:58 -0400
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56BGD0ri031999;
 Fri, 11 Jul 2025 21:11:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=n2yITmcDHU7mQ6vh8
 YPIa1Dq0so42lDfbvnsSij2H4U=; b=GEOD3XK/6z5ZyknwFFhLWVTh5FaJ4iLjE
 3Jjjs5R7AGLxnPnztQ5TNE0UUFhVWEvbPq+oaNVdwe9y+xnBbSWjDed2lw8aRfGx
 5OPLLjUU92TskFFPlJ9K+XKofiOYkLzHsAraM3ajRTtBy9xDXMCw6KdZpsKa9U1M
 0Rh2qhtutDd/kyljp8cNlaMY/Zrs2uWcjecoFYGWyIiB8abnat1ukKO4XjNKqdcE
 c3gUDG3+OQgV6UrbCCNZQU4BwDYYjpBpd5yQJcchlQDpBGSyZ2Jgkz6q51haRZMJ
 2MV9OvjokUqznE40dGb4AtoPxRVyHWibqtgIkbsA1IGpmAoJV6JYg==
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 47u5x819qq-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 11 Jul 2025 21:11:53 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 56BIDYm0021531;
 Fri, 11 Jul 2025 21:11:52 GMT
Received: from smtprelay03.dal12v.mail.ibm.com ([172.16.1.5])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 47qecu4rvu-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 11 Jul 2025 21:11:52 +0000
Received: from smtpav02.wdc07v.mail.ibm.com (smtpav02.wdc07v.mail.ibm.com
 [10.39.53.229])
 by smtprelay03.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 56BLBpEt2294512
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 11 Jul 2025 21:11:51 GMT
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 6DC735805B;
 Fri, 11 Jul 2025 21:11:51 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id EF85A58059;
 Fri, 11 Jul 2025 21:11:49 +0000 (GMT)
Received: from fedora-workstation.ibmuc.com (unknown [9.61.25.251])
 by smtpav02.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Fri, 11 Jul 2025 21:11:49 +0000 (GMT)
From: Zhuoying Cai <zycai@linux.ibm.com>
To: thuth@redhat.com, berrange@redhat.com, richard.henderson@linaro.org,
 david@redhat.com, pbonzini@redhat.com, jrossi@linux.ibm.com,
 qemu-s390x@nongnu.org, qemu-devel@nongnu.org
Cc: walling@linux.ibm.com, jjherne@linux.ibm.com, pasic@linux.ibm.com,
 borntraeger@linux.ibm.com, farman@linux.ibm.com,
 mjrosato@linux.ibm.com, iii@linux.ibm.com, zycai@linux.ibm.com
Subject: [PATCH v4 25/28] pc-bios/s390-ccw: Handle true secure IPL mode
Date: Fri, 11 Jul 2025 17:11:01 -0400
Message-ID: <20250711211105.439554-26-zycai@linux.ibm.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250711211105.439554-1-zycai@linux.ibm.com>
References: <20250711211105.439554-1-zycai@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=LfI86ifi c=1 sm=1 tr=0 ts=68717e19 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=Wb1JkmetP80A:10 a=VnNF1IyMAAAA:8 a=HAb4tJrf35NjsZj3bCIA:9
X-Proofpoint-GUID: 4eNQvNGbt1xNMPwDOfHNT9bvI0KWNO3j
X-Proofpoint-ORIG-GUID: 4eNQvNGbt1xNMPwDOfHNT9bvI0KWNO3j
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzExMDE1NiBTYWx0ZWRfX4tWQlE1/1cYN
 YTzjXkWdUXrC+AGDph0RxqhKnzjIIIMr29V5gXQQIrfCBsoPExPZF918YNddDzh7Q8FMhkYSnlH
 mSAh0baQZmDr+dj9tuAYrpZ6vvFGuS8lyR1yKzvh/Wj0z/ZoBgkTmj/3eoHuuuJXyoTQLc+SybC
 IDwW35xmPSG0bFdeGz5KOK5L9CxL2g3UAA53pzF/jU7unJPISZu3sEcQQrW0GWsXNcZ/+dJLMYd
 B4IZ9z/RC4IT1msfXaXM08Hi4vpTv2ShQtjLBJF99HGiw7wi0mYeEgY0Id3t0P3lfc+dXkAp4U9
 UHcQlFw42K6wyvYU5zOVdrx611toQlSxdULyUVJSSyImG31QQ7xZll22kjKoYLWAUddQBcPupcy
 ijPMVy9XK613sqbamFd4gS7pOiq/nO5yR2ijeSkurUdkXz64aY8DMUfmEjr+/0+rzXTugpaK
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-11_06,2025-07-09_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxscore=0 clxscore=1015
 mlxlogscore=826 malwarescore=0 lowpriorityscore=0 spamscore=0
 impostorscore=0 bulkscore=0 adultscore=0 phishscore=0 suspectscore=0
 priorityscore=1501 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507110156
Received-SPF: pass client-ip=148.163.156.1; envelope-from=zycai@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
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
 pc-bios/s390-ccw/bootmap.c    | 16 +++++++++++++---
 pc-bios/s390-ccw/main.c       |  6 +++++-
 pc-bios/s390-ccw/s390-ccw.h   |  2 ++
 pc-bios/s390-ccw/secure-ipl.c |  4 ++++
 pc-bios/s390-ccw/secure-ipl.h |  3 +++
 5 files changed, 27 insertions(+), 4 deletions(-)

diff --git a/pc-bios/s390-ccw/bootmap.c b/pc-bios/s390-ccw/bootmap.c
index eae8dfa113..b2a0fb2201 100644
--- a/pc-bios/s390-ccw/bootmap.c
+++ b/pc-bios/s390-ccw/bootmap.c
@@ -911,6 +911,9 @@ static int zipl_run(ScsiBlockPtr *pte)
     entry = (ComponentEntry *)(&header[1]);
 
     switch (boot_mode) {
+    case ZIPL_SECURE_INVALID_MODE:
+        return -1;
+    case ZIPL_SECURE_MODE:
     case ZIPL_SECURE_AUDIT_MODE:
         if (zipl_run_secure(entry, tmp_sec)) {
             return -1;
@@ -1283,9 +1286,16 @@ ZiplBootMode zipl_mode(uint8_t hdr_flags)
 {
     bool sipl_set = hdr_flags & DIAG308_IPIB_FLAGS_SIPL;
     bool iplir_set = hdr_flags & DIAG308_IPIB_FLAGS_IPLIR;
+    VCStorageSizeBlock *vcssb;
 
     if (!sipl_set && iplir_set) {
         return ZIPL_SECURE_AUDIT_MODE;
+    } else if (sipl_set && iplir_set) {
+        vcssb = zipl_secure_get_vcssb();
+        if (vcssb == NULL || vcssb->length == 4) {
+            return ZIPL_SECURE_INVALID_MODE;
+        }
+        return ZIPL_SECURE_MODE;
     }
 
     return ZIPL_NORMAL_MODE;
@@ -1296,7 +1306,7 @@ void zipl_load(void)
     VDev *vdev = virtio_get_device();
 
     if (vdev->is_cdrom) {
-        if (boot_mode == ZIPL_SECURE_AUDIT_MODE) {
+        if (boot_mode == ZIPL_SECURE_AUDIT_MODE || boot_mode == ZIPL_SECURE_MODE) {
             panic("Secure boot from ISO image is not supported!");
         }
         ipl_iso_el_torito();
@@ -1305,7 +1315,7 @@ void zipl_load(void)
     }
 
     if (virtio_get_device_type() == VIRTIO_ID_NET) {
-        if (boot_mode == ZIPL_SECURE_AUDIT_MODE) {
+        if (boot_mode == ZIPL_SECURE_AUDIT_MODE || boot_mode == ZIPL_SECURE_MODE) {
             panic("Virtio net boot device does not support secure boot!");
         }
         netmain();
@@ -1318,7 +1328,7 @@ void zipl_load(void)
         return;
     }
 
-    if (boot_mode == ZIPL_SECURE_AUDIT_MODE) {
+    if (boot_mode == ZIPL_SECURE_AUDIT_MODE || boot_mode == ZIPL_SECURE_MODE) {
         panic("ECKD boot device does not support secure boot!");
     }
 
diff --git a/pc-bios/s390-ccw/main.c b/pc-bios/s390-ccw/main.c
index 38962da1dd..3e17550854 100644
--- a/pc-bios/s390-ccw/main.c
+++ b/pc-bios/s390-ccw/main.c
@@ -277,10 +277,14 @@ static void ipl_boot_device(void)
         boot_mode = zipl_mode(iplb->hdr_flags);
     }
 
+    if (boot_mode == ZIPL_SECURE_INVALID_MODE) {
+        panic("Need at least one certificate for secure boot!");
+    }
+
     switch (cutype) {
     case CU_TYPE_DASD_3990:
     case CU_TYPE_DASD_2107:
-        if (boot_mode == ZIPL_SECURE_AUDIT_MODE) {
+        if (boot_mode == ZIPL_SECURE_AUDIT_MODE || boot_mode == ZIPL_SECURE_MODE) {
             panic("Passthrough (vfio) device does not support secure boot!");
         }
 
diff --git a/pc-bios/s390-ccw/s390-ccw.h b/pc-bios/s390-ccw/s390-ccw.h
index 85f92685f6..bf20efe88e 100644
--- a/pc-bios/s390-ccw/s390-ccw.h
+++ b/pc-bios/s390-ccw/s390-ccw.h
@@ -83,8 +83,10 @@ int virtio_read(unsigned long sector, void *load_addr);
 void zipl_load(void);
 
 typedef enum ZiplBootMode {
+    ZIPL_SECURE_INVALID_MODE = -1,
     ZIPL_NORMAL_MODE = 1,
     ZIPL_SECURE_AUDIT_MODE = 2,
+    ZIPL_SECURE_MODE = 3,
 } ZiplBootMode;
 
 extern ZiplBootMode boot_mode;
diff --git a/pc-bios/s390-ccw/secure-ipl.c b/pc-bios/s390-ccw/secure-ipl.c
index 2586c81d01..d7ca766058 100644
--- a/pc-bios/s390-ccw/secure-ipl.c
+++ b/pc-bios/s390-ccw/secure-ipl.c
@@ -264,6 +264,10 @@ static bool check_sclab_presence(uint8_t *sclab_magic,
         comps->device_entries[comp_index].cei |= S390_IPL_COMPONENT_CEI_INVALID_SCLAB;
 
         /* a missing SCLAB will not be reported in audit mode */
+        if (boot_mode == ZIPL_SECURE_MODE) {
+            zipl_secure_print("Magic is not matched. SCLAB does not exist");
+         }
+
         return false;
     }
 
diff --git a/pc-bios/s390-ccw/secure-ipl.h b/pc-bios/s390-ccw/secure-ipl.h
index d6c1a21a98..2e30b55437 100644
--- a/pc-bios/s390-ccw/secure-ipl.h
+++ b/pc-bios/s390-ccw/secure-ipl.h
@@ -86,6 +86,9 @@ static inline void zipl_secure_print(const char *message)
     case ZIPL_SECURE_AUDIT_MODE:
         IPL_check(false, message);
         break;
+    case ZIPL_SECURE_MODE:
+        IPL_assert(false, message);
+        break;
     default:
         break;
     }
-- 
2.49.0


