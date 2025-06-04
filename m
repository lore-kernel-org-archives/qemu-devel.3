Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3DA1C5B549
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Jun 2025 22:02:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uMw8V-0004HO-Tm; Wed, 04 Jun 2025 17:59:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zycai@linux.ibm.com>)
 id 1uMw7j-00033G-E8; Wed, 04 Jun 2025 17:58:19 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zycai@linux.ibm.com>)
 id 1uMw7f-00073K-K2; Wed, 04 Jun 2025 17:58:14 -0400
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 554Hvjk6032643;
 Wed, 4 Jun 2025 21:58:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=pZ9wl2Bhzh8gPInKx
 PDfVsxW6sms8hIJoUMji7bnf40=; b=K06mStzLm+mJ/LHxOXA7sDQ1XH22kRShW
 tKQIdTv88/dvAxhmrcnkQs52W+r5fm8o6hbMCeWVvyPxQhq9Jr6oqGWA/mEuXZhs
 w+2W18qzpYkJHhmdfTV4Qct4ODLrsFD2P1I0uwC7XO33MgDu9tP2I+6NLu4TRS+Y
 tOvdk47PyJVsaDPev0N+jlRmXIMBx0nxaQENi9djoCpksOfmvGd4ULMDox/X8qrH
 ETXLE0D+ueOb2szwcjWh4fladP/8xFdxHVENOS6i3DTUmEVAtGxEw8S09aGaBido
 npJCHJpeFlJwlvvNrLrRaCT/tqwQmsOze7AynZ6CrCrrM3rcAvUAQ==
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 471geyw6mc-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 04 Jun 2025 21:58:04 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 554J8LXL022569;
 Wed, 4 Jun 2025 21:58:04 GMT
Received: from smtprelay02.wdc07v.mail.ibm.com ([172.16.1.69])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 470c3tj1sd-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 04 Jun 2025 21:58:03 +0000
Received: from smtpav04.wdc07v.mail.ibm.com (smtpav04.wdc07v.mail.ibm.com
 [10.39.53.231])
 by smtprelay02.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 554Lw2dB28705364
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 4 Jun 2025 21:58:02 GMT
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 3EAB858050;
 Wed,  4 Jun 2025 21:58:02 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 6D33C58052;
 Wed,  4 Jun 2025 21:58:00 +0000 (GMT)
Received: from fedora-workstation.ibmuc.com (unknown [9.61.31.211])
 by smtpav04.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Wed,  4 Jun 2025 21:58:00 +0000 (GMT)
From: Zhuoying Cai <zycai@linux.ibm.com>
To: thuth@redhat.com, berrange@redhat.com, richard.henderson@linaro.org,
 david@redhat.com, pbonzini@redhat.com
Cc: walling@linux.ibm.com, jjherne@linux.ibm.com, jrossi@linux.ibm.com,
 pasic@linux.ibm.com, borntraeger@linux.ibm.com, farman@linux.ibm.com,
 iii@linux.ibm.com, eblake@redhat.com, armbru@redhat.com,
 qemu-s390x@nongnu.org, qemu-devel@nongnu.org, zycai@linux.ibm.com
Subject: [PATCH v3 25/28] pc-bios/s390-ccw: Handle true secure IPL mode
Date: Wed,  4 Jun 2025 17:56:53 -0400
Message-ID: <20250604215657.528142-26-zycai@linux.ibm.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250604215657.528142-1-zycai@linux.ibm.com>
References: <20250604215657.528142-1-zycai@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: n3WLInsCMmn-6R7wEdNByvCWSO_siPA3
X-Proofpoint-ORIG-GUID: n3WLInsCMmn-6R7wEdNByvCWSO_siPA3
X-Authority-Analysis: v=2.4 cv=X4dSKHTe c=1 sm=1 tr=0 ts=6840c16c cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=6IFa9wvqVegA:10 a=VnNF1IyMAAAA:8 a=HAb4tJrf35NjsZj3bCIA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjA0MDE3NSBTYWx0ZWRfXw+1wKCen1u8N
 aUanllO/HBH8C8MnFDY3lkq/5h/X+knrQtHgVFsPUS7KGJmFUGRmH95nXOMuLJBrXncweKYwWO7
 zCHXlOuLfNbx8KRWrw168qWzBrBrM0Eryo8Yk8FyoEDATWns9Cycenw2ZVEPQZ5uBHG5svOFrXj
 XhynxzOd6w1dkNW1qGVOvxTohRVhBuhUeQvLIIE1KazAWWtIx50lTVFnNV+39I45/StLyk5Qrv2
 WjIZwKgb5piWBuHToDLnSJvg3XYCuP65rmzHgQUIIpIX0cPBbYbTXEoesII792mcz4i7JmsF89a
 FPyJfqbDiFMHU8nDOuPhqBYC47WosiVvS5jRDvp8cfz5FE9msYZ5WSn7bEGJih2CZQJTdglfzx1
 dea9r68FgjyNmCzyx1x5GwXnCZ9V+YQiacKf8G2DLyzqja2wsYeGf0565bZ4xhshcRWwjt7T
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-04_04,2025-06-03_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0
 priorityscore=1501 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=900 adultscore=0 clxscore=1015 phishscore=0 bulkscore=0
 malwarescore=0 spamscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2506040175
Received-SPF: pass client-ip=148.163.158.5; envelope-from=zycai@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
 pc-bios/s390-ccw/secure-ipl.c |  5 +++++
 pc-bios/s390-ccw/secure-ipl.h |  3 +++
 5 files changed, 28 insertions(+), 4 deletions(-)

diff --git a/pc-bios/s390-ccw/bootmap.c b/pc-bios/s390-ccw/bootmap.c
index cc851c476f..64abf8164d 100644
--- a/pc-bios/s390-ccw/bootmap.c
+++ b/pc-bios/s390-ccw/bootmap.c
@@ -932,6 +932,9 @@ static int zipl_run(ScsiBlockPtr *pte)
     entry = (ComponentEntry *)(&header[1]);
 
     switch (boot_mode) {
+    case ZIPL_SECURE_INVALID_MODE:
+        return -1;
+    case ZIPL_SECURE_MODE:
     case ZIPL_SECURE_AUDIT_MODE:
         if (zipl_run_secure(entry, tmp_sec)) {
             return -1;
@@ -1304,9 +1307,16 @@ ZiplBootMode zipl_mode(uint8_t hdr_flags)
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
@@ -1317,7 +1327,7 @@ void zipl_load(void)
     VDev *vdev = virtio_get_device();
 
     if (vdev->is_cdrom) {
-        if (boot_mode == ZIPL_SECURE_AUDIT_MODE) {
+        if (boot_mode == ZIPL_SECURE_AUDIT_MODE || boot_mode == ZIPL_SECURE_MODE) {
             panic("Secure boot from ISO image is not supported!");
         }
         ipl_iso_el_torito();
@@ -1326,7 +1336,7 @@ void zipl_load(void)
     }
 
     if (virtio_get_device_type() == VIRTIO_ID_NET) {
-        if (boot_mode == ZIPL_SECURE_AUDIT_MODE) {
+        if (boot_mode == ZIPL_SECURE_AUDIT_MODE || boot_mode == ZIPL_SECURE_MODE) {
             panic("Virtio net boot device does not support secure boot!");
         }
         netmain();
@@ -1339,7 +1349,7 @@ void zipl_load(void)
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
index 3ae568e4f3..ceb038e803 100644
--- a/pc-bios/s390-ccw/secure-ipl.c
+++ b/pc-bios/s390-ccw/secure-ipl.c
@@ -248,6 +248,11 @@ static void valid_sclab_check(SclabOriginLocator *sclab_locator,
         comps->device_entries[comp_index].cei |= S390_IPL_COMPONENT_CEI_INVALID_SCLAB;
 
         /* a missing SCLAB will not be reported in audit mode */
+        if (boot_mode == ZIPL_SECURE_MODE) {
+            zipl_secure_print(is_magic_match,
+                              "Magic is not matched. SCLAB does not exist");
+         }
+
         return;
     }
 
diff --git a/pc-bios/s390-ccw/secure-ipl.h b/pc-bios/s390-ccw/secure-ipl.h
index 9a260981fd..79b80a551d 100644
--- a/pc-bios/s390-ccw/secure-ipl.h
+++ b/pc-bios/s390-ccw/secure-ipl.h
@@ -52,6 +52,9 @@ static inline void zipl_secure_print(bool term, const char *message)
     case ZIPL_SECURE_AUDIT_MODE:
         IPL_check(term, message);
         break;
+    case ZIPL_SECURE_MODE:
+        IPL_assert(term, message);
+        break;
     default:
         break;
     }
-- 
2.49.0


