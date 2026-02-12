Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33A1DEEA84F
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Feb 2026 20:47:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vqdYO-00013A-Nb; Thu, 12 Feb 2026 15:44:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zycai@linux.ibm.com>)
 id 1vqdYN-00011T-0b; Thu, 12 Feb 2026 15:44:47 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zycai@linux.ibm.com>)
 id 1vqdYK-00085g-H0; Thu, 12 Feb 2026 15:44:46 -0500
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 61CJt1dQ451836; Thu, 12 Feb 2026 20:44:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=cIgVhZ9btDTwnYhfJ
 kIfjg+vv6+OiuOgjFGBYmtDbeo=; b=tH+T9U79LWqjUl26JyuKhiiYLxVIAWMmo
 Mn3z9+u4bBmi/M8UelvBv1wTHVdgY3C2qPpXhBZ8+bueIeKvM/0dU/otsnntsbZ0
 gkKuC/M3ildGzXWkMBvtF5mRhIA9Yj3ZDBUNVCk9ZNZObXE5MsvGRo6bDxB67ibH
 1knAs0xNSYpgB7s+F+WS/hlYOhXHtJ8kOps59MhA2jNN+cc6ijvVfZ9xPGDslBoh
 DPp4mRKCZJ9B4OgXxMVKhODCJLzXOTQ4ZS98xoL6aA3KuBLe5JyoCBXAivdGgwnU
 y4aiLTiO4Uu8784Odl5zCPazW8v2oG8z/skO0skE1hEmNjIT+BClQ==
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4c696ur4ds-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 12 Feb 2026 20:44:39 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 61CJjjSO002548;
 Thu, 12 Feb 2026 20:44:39 GMT
Received: from smtprelay05.dal12v.mail.ibm.com ([172.16.1.7])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4c6fqsvbk2-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 12 Feb 2026 20:44:39 +0000
Received: from smtpav06.wdc07v.mail.ibm.com (smtpav06.wdc07v.mail.ibm.com
 [10.39.53.233])
 by smtprelay05.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 61CKiboI32113222
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 12 Feb 2026 20:44:38 GMT
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 9DECD5804E;
 Thu, 12 Feb 2026 20:44:37 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id DC37D58054;
 Thu, 12 Feb 2026 20:44:35 +0000 (GMT)
Received: from fedora-workstation.ibmuc.com (unknown [9.61.112.15])
 by smtpav06.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Thu, 12 Feb 2026 20:44:35 +0000 (GMT)
From: Zhuoying Cai <zycai@linux.ibm.com>
To: thuth@redhat.com, berrange@redhat.com, richard.henderson@linaro.org,
 jrossi@linux.ibm.com, qemu-s390x@nongnu.org, qemu-devel@nongnu.org
Cc: david@kernel.org, walling@linux.ibm.com, jjherne@linux.ibm.com,
 pasic@linux.ibm.com, borntraeger@linux.ibm.com, farman@linux.ibm.com,
 mjrosato@linux.ibm.com, iii@linux.ibm.com, eblake@redhat.com,
 armbru@redhat.com, zycai@linux.ibm.com, alifm@linux.ibm.com,
 brueckner@linux.ibm.com
Subject: [PATCH v8 22/30] pc-bios/s390-ccw: Add additional security checks for
 secure boot
Date: Thu, 12 Feb 2026 15:43:43 -0500
Message-ID: <20260212204352.1044699-23-zycai@linux.ibm.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260212204352.1044699-1-zycai@linux.ibm.com>
References: <20260212204352.1044699-1-zycai@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=YZiwJgRf c=1 sm=1 tr=0 ts=698e3bb8 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22 a=Mpw57Om8IfrbqaoTuvik:22
 a=GgsMoib0sEa3-_RKJdDe:22 a=VnNF1IyMAAAA:8 a=IaLYFdo72UbvXhH_9PYA:9
X-Proofpoint-ORIG-GUID: LM2gbbcrdFCXQK1eD4AdwQSlv9iWPfHQ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjEyMDE1NyBTYWx0ZWRfX3lkLfwY2Bf7T
 r4CEXNeCtFFvGCibE+LxHzkq1MIzxADmbjVbCkQHhtFmp0gX6tBH9gmTUC088co1KEzMUTigEDp
 24eDibAOeVCkWPWnr/W2xnPcGi8cZZKgIZJZirBRrzRQt5peUXFEW50NfcnKJLQ6uL7zd8S+UQt
 Fs8g3Ov7pnRVMgQiexysVRp2YmHZPYIwVr4n+z+sDmR13hGSfjneBbVDFZ3ZSMewx21HZu1e7Py
 bF2r4JlCCQW3w46TSDXqbxXfixBp784kLar9QmnEa2wYjeuk4DcOE7Tm8anymKIok3oN+bUyRA2
 YKFAMYmy+5Q59HbLIcanTrhb5ejPuBYBHtCcBonYBKzHpdV+5NAjzhKVGjJ+3Or2m8BaFiCUcX4
 0dUmiAmynEZfIVFRmlq3DqFvSno5grLPbjRpdp9dSlPPxNrRXacQGF949hkLLZyYrxXltpFB6SZ
 5cG9R9Y6pkJWrk4TLXw==
X-Proofpoint-GUID: LM2gbbcrdFCXQK1eD4AdwQSlv9iWPfHQ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-12_05,2026-02-12_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 impostorscore=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 adultscore=0 clxscore=1015 lowpriorityscore=0
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

Add additional checks to ensure that components do not overlap with
signed components when loaded into memory.

Add additional checks to ensure the load addresses of unsigned components
are greater than or equal to 0x2000.

When the secure IPL code loading attributes facility (SCLAF) is installed,
all signed components must contain a secure code loading attributes block
(SCLAB).

The SCLAB provides further validation of information on where to load the
signed binary code from the load device, and where to start the execution
of the loaded OS code.

When SCLAF is installed, its content must be evaluated during secure IPL.
However, a missing SCLAB will not be reported in audit mode. The SCALB
checking will be skipped in this case.

Add IPL Information Error Indicators (IIEI) and Component Error
Indicators (CEI) for IPL Information Report Block (IIRB).

When SCLAF is installed, additional secure boot checks are performed
during zipl and store results of verification into IIRB.

Signed-off-by: Zhuoying Cai <zycai@linux.ibm.com>
---
 include/hw/s390x/ipl/qipl.h   |  29 +++-
 pc-bios/s390-ccw/s390-ccw.h   |   1 +
 pc-bios/s390-ccw/sclp.c       |   8 +
 pc-bios/s390-ccw/sclp.h       |   1 +
 pc-bios/s390-ccw/secure-ipl.c | 318 +++++++++++++++++++++++++++++++++-
 pc-bios/s390-ccw/secure-ipl.h |  42 +++++
 6 files changed, 395 insertions(+), 4 deletions(-)

diff --git a/include/hw/s390x/ipl/qipl.h b/include/hw/s390x/ipl/qipl.h
index 1b6cb3231d..9518fcb1dc 100644
--- a/include/hw/s390x/ipl/qipl.h
+++ b/include/hw/s390x/ipl/qipl.h
@@ -136,10 +136,20 @@ struct IplInfoReportBlockHeader {
 };
 typedef struct IplInfoReportBlockHeader IplInfoReportBlockHeader;
 
+/* IPL Info Error Indicators */
+#define S390_IIEI_NO_SIGNED_COMP      0x8000 /* bit 0 */
+#define S390_IIEI_NO_SCLAB            0x4000 /* bit 1 */
+#define S390_IIEI_NO_GLOBAL_SCLAB     0x2000 /* bit 2 */
+#define S390_IIEI_MORE_GLOBAL_SCLAB   0x1000 /* bit 3 */
+#define S390_IIEI_FOUND_UNSIGNED_COMP 0x800 /* bit 4 */
+#define S390_IIEI_MORE_SIGNED_COMP    0x400 /* bit 5 */
+
 struct IplInfoBlockHeader {
     uint32_t len;
     uint8_t  type;
-    uint8_t  reserved1[11];
+    uint8_t  reserved1[3];
+    uint16_t iiei;
+    uint8_t  reserved2[6];
 };
 typedef struct IplInfoBlockHeader IplInfoBlockHeader;
 
@@ -163,13 +173,28 @@ typedef struct IplSignatureCertificateList IplSignatureCertificateList;
 #define S390_IPL_DEV_COMP_FLAG_SC  0x80
 #define S390_IPL_DEV_COMP_FLAG_CSV 0x40
 
+/* IPL Device Component Error Indicators */
+#define S390_CEI_INVALID_SCLAB             0x80000000 /* bit 0 */
+#define S390_CEI_INVALID_SCLAB_LEN         0x40000000 /* bit 1 */
+#define S390_CEI_INVALID_SCLAB_FORMAT      0x20000000 /* bit 2 */
+#define S390_CEI_UNMATCHED_SCLAB_LOAD_ADDR 0x10000000 /* bit 3 */
+#define S390_CEI_UNMATCHED_SCLAB_LOAD_PSW  0x8000000  /* bit 4 */
+#define S390_CEI_INVALID_LOAD_PSW          0x4000000  /* bit 5 */
+#define S390_CEI_NUC_NOT_IN_GLOBAL_SCLA    0x2000000  /* bit 6 */
+#define S390_CEI_SCLAB_OLA_NOT_ONE         0x1000000  /* bit 7 */
+#define S390_CEI_SC_NOT_IN_GLOBAL_SCLAB    0x800000   /* bit 8 */
+#define S390_CEI_SCLAB_LOAD_ADDR_NOT_ZERO  0x400000   /* bit 9 */
+#define S390_CEI_SCLAB_LOAD_PSW_NOT_ZERO   0x200000   /* bit 10 */
+#define S390_CEI_INVALID_UNSIGNED_ADDR     0x100000   /* bit 11 */
+
 struct IplDeviceComponentEntry {
     uint64_t addr;
     uint64_t len;
     uint8_t  flags;
     uint8_t  reserved1[5];
     uint16_t cert_index;
-    uint8_t  reserved2[8];
+    uint32_t cei;
+    uint8_t  reserved2[4];
 };
 typedef struct IplDeviceComponentEntry IplDeviceComponentEntry;
 
diff --git a/pc-bios/s390-ccw/s390-ccw.h b/pc-bios/s390-ccw/s390-ccw.h
index 1b43817af9..8dbfb846d2 100644
--- a/pc-bios/s390-ccw/s390-ccw.h
+++ b/pc-bios/s390-ccw/s390-ccw.h
@@ -69,6 +69,7 @@ void sclp_setup(void);
 void sclp_get_loadparm_ascii(char *loadparm);
 bool sclp_is_diag320_on(void);
 bool sclp_is_sipl_on(void);
+bool sclp_is_sclaf_on(void);
 int sclp_read(char *str, size_t count);
 
 /* virtio.c */
diff --git a/pc-bios/s390-ccw/sclp.c b/pc-bios/s390-ccw/sclp.c
index f7514b0245..e7aea51d5b 100644
--- a/pc-bios/s390-ccw/sclp.c
+++ b/pc-bios/s390-ccw/sclp.c
@@ -156,6 +156,14 @@ bool sclp_is_sipl_on(void)
     return fac_ipl & SCCB_FAC_IPL_SIPL_BIT;
 }
 
+bool sclp_is_sclaf_on(void)
+{
+    uint16_t fac_ipl = 0;
+
+    sclp_get_fac_ipl(&fac_ipl);
+    return fac_ipl & SCCB_FAC_IPL_SCLAF_BIT;
+}
+
 int sclp_read(char *str, size_t count)
 {
     ReadEventData *sccb = (void *)_sccb;
diff --git a/pc-bios/s390-ccw/sclp.h b/pc-bios/s390-ccw/sclp.h
index cf147f4634..3441020d6b 100644
--- a/pc-bios/s390-ccw/sclp.h
+++ b/pc-bios/s390-ccw/sclp.h
@@ -52,6 +52,7 @@ typedef struct SCCBHeader {
 #define SCCB_DATA_LEN (SCCB_SIZE - sizeof(SCCBHeader))
 #define SCCB_FAC134_DIAG320_BIT 0x4
 #define SCCB_FAC_IPL_SIPL_BIT 0x4000
+#define SCCB_FAC_IPL_SCLAF_BIT 0x1000
 
 typedef struct ReadInfo {
     SCCBHeader h;
diff --git a/pc-bios/s390-ccw/secure-ipl.c b/pc-bios/s390-ccw/secure-ipl.c
index 27d2833642..54e41ec11c 100644
--- a/pc-bios/s390-ccw/secure-ipl.c
+++ b/pc-bios/s390-ccw/secure-ipl.c
@@ -197,6 +197,12 @@ static bool secure_ipl_supported(void)
         return false;
     }
 
+    if (!sclp_is_sclaf_on()) {
+        puts("Secure IPL Code Loading Attributes Facility is not supported by"
+             " the hypervisor!");
+        return false;
+    }
+
     return true;
 }
 
@@ -259,6 +265,290 @@ static void addr_overlap_check(SecureIplCompAddrRange *comp_addr_range,
     *addr_range_index += 1;
 }
 
+static void check_unsigned_addr(uint64_t load_addr, IplDeviceComponentEntry *comp_entry)
+{
+    /* unsigned load address must be greater than or equal to 0x2000 */
+    if (load_addr >= 0x2000) {
+        return;
+    }
+
+    set_comp_cei_with_log(comp_entry, S390_CEI_INVALID_UNSIGNED_ADDR,
+                          "Load address is less than 0x2000");
+}
+
+static bool check_sclab_presence(uint8_t *sclab_magic,
+                                 IplDeviceComponentEntry *comp_entry)
+{
+    /* identifies the presence of SCLAB */
+    if (magic_match(sclab_magic, ZIPL_MAGIC)) {
+        return true;
+    }
+
+    if (comp_entry) {
+        comp_entry->cei |= S390_CEI_INVALID_SCLAB;
+    }
+
+    /* a missing SCLAB will not be reported in audit mode */
+    return false;
+}
+
+static void check_sclab_length(uint16_t sclab_len, IplDeviceComponentEntry *comp_entry)
+{
+    if (sclab_len >= S390_SECURE_IPL_SCLAB_MIN_LEN) {
+        return;
+    }
+
+    set_comp_cei_with_log(comp_entry,
+                          S390_CEI_INVALID_SCLAB_LEN | S390_CEI_INVALID_SCLAB,
+                          "Invalid SCLAB length");
+}
+
+static void check_sclab_format(uint8_t sclab_format, IplDeviceComponentEntry *comp_entry)
+{
+    /* SCLAB format must set to zero, indicating a format-0 SCLAB being used */
+    if (sclab_format == 0) {
+        return;
+    }
+
+    set_comp_cei_with_log(comp_entry, S390_CEI_INVALID_SCLAB_FORMAT,
+                          "Format-0 SCLAB is not being used");
+}
+
+static void check_sclab_opsw(SecureCodeLoadingAttributesBlock *sclab,
+                             SecureIplSclabInfo *sclab_info,
+                             IplDeviceComponentEntry *comp_entry)
+{
+    const char *msg;
+    uint32_t cei_flag = 0;
+
+    if (!(sclab->flags & S390_SECURE_IPL_SCLAB_FLAG_OPSW)) {
+        /* OPSW = 0 - Load PSW field in SCLAB must contain zeros */
+        if (sclab->load_psw != 0) {
+            cei_flag |= S390_CEI_SCLAB_LOAD_PSW_NOT_ZERO;
+            msg = "Load PSW is not zero when Override PSW bit is zero";
+        }
+    } else {
+        /* OPSW = 1 indicating global SCLAB */
+        sclab_info->global_count += 1;
+        if (sclab_info->global_count == 1) {
+            sclab_info->load_psw = sclab->load_psw;
+            sclab_info->flags = sclab->flags;
+        }
+
+        /* OLA must set to one */
+        if (!(sclab->flags & S390_SECURE_IPL_SCLAB_FLAG_OLA)) {
+            cei_flag |= S390_CEI_SCLAB_OLA_NOT_ONE;
+            msg = "Override Load Address bit is not set to one in the global SCLAB";
+        }
+    }
+
+    if (!cei_flag) {
+        return;
+    }
+
+    set_comp_cei_with_log(comp_entry, cei_flag, msg);
+}
+
+static void check_sclab_ola(SecureCodeLoadingAttributesBlock *sclab, uint64_t load_addr,
+                            IplDeviceComponentEntry *comp_entry)
+{
+    const char *msg;
+    uint32_t cei_flag = 0;
+
+    if (!(sclab->flags & S390_SECURE_IPL_SCLAB_FLAG_OLA)) {
+        /* OLA = 0 - Load address field in SCLAB must contain zeros */
+        if (sclab->load_addr != 0) {
+            cei_flag |= S390_CEI_SCLAB_LOAD_ADDR_NOT_ZERO;
+            msg = "Load Address is not zero when Override Load Address bit is zero";
+        }
+    } else {
+        /* OLA = 1 - Load address field must match storage address of the component */
+        if (sclab->load_addr != load_addr) {
+            cei_flag |= S390_CEI_UNMATCHED_SCLAB_LOAD_ADDR;
+            msg = "Load Address does not match with component load address";
+        }
+    }
+
+    if (!cei_flag) {
+        return;
+    }
+
+    set_comp_cei_with_log(comp_entry, cei_flag, msg);
+}
+
+static void check_sclab_nuc(uint16_t sclab_flags, IplDeviceComponentEntry *comp_entry)
+{
+    const char *msg;
+    bool is_nuc_set;
+    bool is_global_sclab;
+
+    is_nuc_set = sclab_flags & S390_SECURE_IPL_SCLAB_FLAG_NUC;
+    is_global_sclab = sclab_flags & S390_SECURE_IPL_SCLAB_FLAG_OPSW;
+    if (is_nuc_set && !is_global_sclab) {
+        msg = "No Unsigned Components bit is set, but not in the global SCLAB";
+        set_comp_cei_with_log(comp_entry, S390_CEI_NUC_NOT_IN_GLOBAL_SCLA, msg);
+    }
+}
+
+static void check_sclab_sc(uint16_t sclab_flags, IplDeviceComponentEntry *comp_entry)
+{
+    const char *msg;
+    bool is_sc_set;
+    bool is_global_sclab;
+
+    is_sc_set = sclab_flags & S390_SECURE_IPL_SCLAB_FLAG_SC;
+    is_global_sclab = sclab_flags & S390_SECURE_IPL_SCLAB_FLAG_OPSW;
+    if (is_sc_set && !is_global_sclab) {
+        msg = "Single Component bit is set, but not in the global SCLAB";
+        set_comp_cei_with_log(comp_entry, S390_CEI_SC_NOT_IN_GLOBAL_SCLAB, msg);
+    }
+}
+
+static bool is_psw_valid(uint64_t psw, SecureIplCompAddrRange *comp_addr_range,
+                         int range_index)
+{
+    uint32_t addr = psw & 0x7fffffff;
+
+    /* PSW points within a signed binary code component */
+    for (int i = 0; i < range_index; i++) {
+        if (comp_addr_range[i].is_signed &&
+            addr >= comp_addr_range[i].start_addr &&
+            addr <= comp_addr_range[i].end_addr - 2) {
+            return true;
+       }
+    }
+
+    return false;
+}
+
+static void check_load_psw(SecureIplCompAddrRange *comp_addr_range,
+                           int addr_range_index, uint64_t sclab_load_psw,
+                           uint64_t load_psw, IplDeviceComponentEntry *comp_entry)
+{
+    bool valid;
+
+    valid = is_psw_valid(sclab_load_psw, comp_addr_range, addr_range_index) &&
+            is_psw_valid(load_psw, comp_addr_range, addr_range_index);
+    if (!valid) {
+        set_comp_cei_with_log(comp_entry, S390_CEI_INVALID_LOAD_PSW, "Invalid PSW");
+    }
+
+    /* compare load PSW with the PSW specified in component */
+    if (sclab_load_psw != load_psw) {
+        set_comp_cei_with_log(comp_entry, S390_CEI_UNMATCHED_SCLAB_LOAD_PSW,
+                              "Load PSW does not match with PSW in component");
+    }
+}
+
+static void check_nuc(uint16_t global_sclab_flags, int unsigned_count,
+                      IplDeviceComponentList *comp_list)
+{
+    bool is_nuc_set;
+
+    is_nuc_set = global_sclab_flags & S390_SECURE_IPL_SCLAB_FLAG_NUC;
+    if (is_nuc_set && unsigned_count > 0) {
+        comp_list->ipl_info_header.iiei |= S390_IIEI_FOUND_UNSIGNED_COMP;
+        zipl_secure_handle("Unsigned components are not allowed");
+    }
+}
+
+static void check_sc(uint16_t global_sclab_flags,
+                     int signed_count, int unsigned_count,
+                     IplDeviceComponentList *comp_list)
+{
+    bool is_sc_set;
+
+    is_sc_set = global_sclab_flags & S390_SECURE_IPL_SCLAB_FLAG_SC;
+    if (is_sc_set && signed_count != 1 && unsigned_count >= 0) {
+        comp_list->ipl_info_header.iiei |= S390_IIEI_MORE_SIGNED_COMP;
+        zipl_secure_handle("Only one signed component is allowed");
+    }
+}
+
+void check_global_sclab(SecureIplSclabInfo sclab_info,
+                        int unsigned_count, int signed_count,
+                        IplDeviceComponentList *comp_list)
+{
+    if (sclab_info.count == 0) {
+        return;
+    }
+
+    if (sclab_info.global_count == 0) {
+        comp_list->ipl_info_header.iiei |= S390_IIEI_NO_GLOBAL_SCLAB;
+        zipl_secure_handle("Global SCLAB does not exists");
+        return;
+    }
+
+    if (sclab_info.global_count > 1) {
+        comp_list->ipl_info_header.iiei |= S390_IIEI_MORE_GLOBAL_SCLAB;
+        zipl_secure_handle("More than one global SCLAB");
+        return;
+    }
+
+    if (sclab_info.flags) {
+        /* Unsigned components are not allowed if NUC flag is set in the global SCLAB */
+        check_nuc(sclab_info.flags, unsigned_count, comp_list);
+
+        /* Only one signed component is allowed is SC flag is set in the global SCLAB */
+        check_sc(sclab_info.flags, signed_count, unsigned_count, comp_list);
+    }
+}
+
+static void check_signed_comp(int signed_count, IplDeviceComponentList *comp_list)
+{
+    if (signed_count > 0) {
+        return;
+    }
+
+    comp_list->ipl_info_header.iiei |= S390_IIEI_NO_SIGNED_COMP;
+    zipl_secure_handle("Secure boot is on, but components are not signed");
+}
+
+static void check_sclab_count(int count, IplDeviceComponentList *comp_list)
+{
+    if (count > 0) {
+        return;
+    }
+
+    comp_list->ipl_info_header.iiei |= S390_IIEI_NO_SCLAB;
+    zipl_secure_handle("No recognizable SCLAB");
+}
+
+static void check_sclab(uint64_t comp_addr, uint64_t comp_len,
+                        IplDeviceComponentEntry *comp_entry,
+                        SecureIplSclabInfo *sclab_info)
+{
+    SclabOriginLocator *sclab_locator;
+    SecureCodeLoadingAttributesBlock *sclab;
+    bool exist;
+
+    /* sclab locator is located at the last 8 bytes of the signed comp */
+    sclab_locator = (SclabOriginLocator *)(comp_addr + comp_len - 8);
+
+    /* return early if sclab does not exist */
+    exist = check_sclab_presence(sclab_locator->magic, comp_entry);
+    if (!exist) {
+        return;
+    }
+
+    check_sclab_length(sclab_locator->len, comp_entry);
+
+    /* return early if sclab is invalid */
+    if (comp_entry && (comp_entry->cei & S390_CEI_INVALID_SCLAB)) {
+        return;
+    }
+
+    sclab_info->count += 1;
+    sclab = (SecureCodeLoadingAttributesBlock *)(comp_addr + comp_len -
+                                                 sclab_locator->len);
+
+    check_sclab_format(sclab->format, comp_entry);
+    check_sclab_opsw(sclab, sclab_info, comp_entry);
+    check_sclab_ola(sclab, comp_addr, comp_entry);
+    check_sclab_nuc(sclab->flags, comp_entry);
+    check_sclab_sc(sclab->flags, comp_entry);
+}
+
 static int zipl_load_signature(ComponentEntry *entry, uint64_t sig_sec)
 {
     if (zipl_load_segment(entry, sig_sec) < 0) {
@@ -305,6 +595,9 @@ int zipl_run_secure(ComponentEntry **entry_ptr, uint8_t *tmp_sec)
     SecureIplCompAddrRange comp_addr_range[MAX_CERTIFICATES];
     int addr_range_index = 0;
     int signed_count = 0;
+    int unsigned_count = 0;
+    SecureIplSclabInfo sclab_info = { 0 };
+    IplDeviceComponentEntry *comp_entry;
 
     if (!secure_ipl_supported()) {
         return -1;
@@ -336,10 +629,21 @@ int zipl_run_secure(ComponentEntry **entry_ptr, uint8_t *tmp_sec)
             addr_overlap_check(comp_addr_range, &addr_range_index,
                                comp_addr, comp_addr + comp_len, sig_len > 0);
 
+            comp_entry = (comp_entry_idx < MAX_CERTIFICATES) ?
+                         &comp_list.device_entries[comp_entry_idx] : NULL;
+
             if (!sig_len) {
+                check_unsigned_addr(comp_addr, comp_entry);
+                comp_list_add(&comp_list, comp_entry_idx, cert_entry_idx,
+                              comp_addr, comp_len, 0x00);
+
+                unsigned_count += 1;
+                comp_entry_idx++;
                 break;
             }
 
+            check_sclab(comp_addr, comp_len,
+                        &comp_list.device_entries[comp_entry_idx], &sclab_info);
             verified = verify_signature(comp_len, comp_addr, sig_len, (uint64_t)sig,
                                         &cert_len, &cert_table_idx);
 
@@ -392,10 +696,20 @@ int zipl_run_secure(ComponentEntry **entry_ptr, uint8_t *tmp_sec)
         }
     }
 
-    if (signed_count == 0) {
-        zipl_secure_handle("Secure boot is on, but components are not signed");
+    /* validate load PSW with PSW specified in the final entry */
+    if (sclab_info.load_psw) {
+        comp_entry = (comp_entry_idx < MAX_CERTIFICATES) ?
+                     &comp_list.device_entries[comp_entry_idx] : NULL;
+        check_load_psw(comp_addr_range, addr_range_index,
+                       sclab_info.load_psw, entry->compdat.load_psw, comp_entry);
+        comp_list_add(&comp_list, comp_entry_idx, -1,
+                      entry->compdat.load_psw, 0, 0x00);
     }
 
+    check_signed_comp(signed_count, &comp_list);
+    check_sclab_count(sclab_info.count, &comp_list);
+    check_global_sclab(sclab_info, unsigned_count, signed_count, &comp_list);
+
     update_iirb(&comp_list, &cert_list);
 
     *entry_ptr = entry;
diff --git a/pc-bios/s390-ccw/secure-ipl.h b/pc-bios/s390-ccw/secure-ipl.h
index 69edfce241..4e9f4f08b9 100644
--- a/pc-bios/s390-ccw/secure-ipl.h
+++ b/pc-bios/s390-ccw/secure-ipl.h
@@ -16,6 +16,38 @@
 VCStorageSizeBlock *zipl_secure_get_vcssb(void);
 int zipl_run_secure(ComponentEntry **entry_ptr, uint8_t *tmp_sec);
 
+#define S390_SECURE_IPL_SCLAB_FLAG_OPSW    0x8000
+#define S390_SECURE_IPL_SCLAB_FLAG_OLA     0x4000
+#define S390_SECURE_IPL_SCLAB_FLAG_NUC     0x2000
+#define S390_SECURE_IPL_SCLAB_FLAG_SC      0x1000
+
+#define S390_SECURE_IPL_SCLAB_MIN_LEN      32
+
+struct SecureCodeLoadingAttributesBlock {
+    uint8_t  format;
+    uint8_t  reserved1;
+    uint16_t flags;
+    uint8_t  reserved2[4];
+    uint64_t load_psw;
+    uint64_t load_addr;
+    uint64_t reserved3[];
+} __attribute__ ((packed));
+typedef struct SecureCodeLoadingAttributesBlock SecureCodeLoadingAttributesBlock;
+
+struct SclabOriginLocator {
+    uint8_t reserved[2];
+    uint16_t len;
+    uint8_t magic[4];
+} __attribute__ ((packed));
+typedef struct SclabOriginLocator SclabOriginLocator;
+
+typedef struct SecureIplSclabInfo {
+    int count;
+    int global_count;
+    uint64_t load_psw;
+    uint16_t flags;
+} SecureIplSclabInfo;
+
 typedef struct SecureIplCompAddrRange {
     bool is_signed;
     uint64_t start_addr;
@@ -33,6 +65,16 @@ static inline void zipl_secure_handle(const char *message)
     }
 }
 
+static inline void set_comp_cei_with_log(IplDeviceComponentEntry *comp_entry,
+                                         uint32_t flag, const char *message)
+{
+    if (comp_entry) {
+        comp_entry->cei |= flag;
+    }
+
+    zipl_secure_handle(message);
+}
+
 static inline uint64_t diag320(void *data, unsigned long subcode)
 {
     register unsigned long addr asm("0") = (unsigned long)data;
-- 
2.52.0


