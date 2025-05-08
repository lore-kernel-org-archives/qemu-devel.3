Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A7D7C3ABBE
	for <qemu-devel@archiver.kernel.org>; Thu,  8 May 2025 22:52:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uDA60-0004qR-JZ; Thu, 08 May 2025 18:52:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zycai@linux.ibm.com>)
 id 1uDA5w-0004gq-22; Thu, 08 May 2025 18:52:00 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zycai@linux.ibm.com>)
 id 1uDA5t-0006Yo-5Q; Thu, 08 May 2025 18:51:59 -0400
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 548LgSw8031903;
 Thu, 8 May 2025 22:51:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=qZ2IAc2czkusbQtI5
 J4b3kC9TN1Tw+v9FkOfj8mSKhI=; b=UosSO0MTUKZEMnQ04O/dUgD6Roxp51x4i
 5biGcgn3m3nH8Rc8zBuxFea0dVtw222z/3wWXavaiXzE5DGbCy9oMPDhFMoqme1n
 nfJMaEPHgOYj+SKbNzp/igedvN/9iaE01SGGmvuosJbOOO2TSOp+aUDM4LbbyGPV
 duzt1SiBjoUZaJ70LwgsQspybyCUOF7Ph3pkA1GtRsuH3wXtd1T1107jBDO18SnO
 5pRRYYiAi8+tDpJuCyM8LKnGnTwEjYq1cabLU0I9mDQnyDKED5lS8+ayvz6Djwea
 7r7EP+p0QsfD6M5WqN6pydUQ3doN1yIA2vTa5lVVipe6QWurQOZmQ==
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 46h4rw87yq-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 08 May 2025 22:51:55 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 548JKl9e014082;
 Thu, 8 May 2025 22:51:54 GMT
Received: from smtprelay03.dal12v.mail.ibm.com ([172.16.1.5])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 46dypkyuye-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 08 May 2025 22:51:54 +0000
Received: from smtpav01.wdc07v.mail.ibm.com (smtpav01.wdc07v.mail.ibm.com
 [10.39.53.228])
 by smtprelay03.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 548Mprgm31851130
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 8 May 2025 22:51:53 GMT
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 5ED8258063;
 Thu,  8 May 2025 22:51:53 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id DD05E5804B;
 Thu,  8 May 2025 22:51:51 +0000 (GMT)
Received: from fedora-workstation.ibmuc.com (unknown [9.61.11.238])
 by smtpav01.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Thu,  8 May 2025 22:51:51 +0000 (GMT)
From: Zhuoying Cai <zycai@linux.ibm.com>
To: thuth@redhat.com, richard.henderson@linaro.org, david@redhat.com,
 pbonzini@redhat.com
Cc: walling@linux.ibm.com, jjherne@linux.ibm.com, jrossi@linux.ibm.com,
 fiuczy@linux.ibm.com, pasic@linux.ibm.com, borntraeger@linux.ibm.com,
 farman@linux.ibm.com, iii@linux.ibm.com, qemu-s390x@nongnu.org,
 qemu-devel@nongnu.org, zycai@linux.ibm.com
Subject: [PATCH v2 19/25] pc-bios/s390-ccw: Add additional security checks for
 secure boot
Date: Thu,  8 May 2025 18:50:35 -0400
Message-ID: <20250508225042.313672-20-zycai@linux.ibm.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250508225042.313672-1-zycai@linux.ibm.com>
References: <20250508225042.313672-1-zycai@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=QIxoRhLL c=1 sm=1 tr=0 ts=681d358b cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=dt9VzEwgFbYA:10 a=VnNF1IyMAAAA:8 a=v9_7xbZuii4DBXc9P7YA:9
X-Proofpoint-GUID: 2i5LFKee5fFIy7ys4F7M_srbavWiB1uN
X-Proofpoint-ORIG-GUID: 2i5LFKee5fFIy7ys4F7M_srbavWiB1uN
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTA4MDIwNSBTYWx0ZWRfXymy/Z6UywkcD
 IW8FfTf0BAKlggTza5Oezsjuij6FpiAAvDzYb+YitTXwDfRILboRNiiNoMLE9CWtqvbqYHJPhO5
 F4/O3ne+FyEC7kR7JfDj7G1K+gVb315wZJXP6ZXzDMAjx23DPWZlIZ9uvUxMf8o0eMaBl+lnqGJ
 ZZ5Lz27h8EwrlSg3lDSrze0QZQXuDEIKyDpnqtVMthRg9ETbAmxvKHjnm1xOffHCAhCQhctueZW
 +ZBBmcQWVl2VoZBggiZe0rXK/VzackJjWVBEyQpvzfn2Xz1clGqW3hPfXSYpU4H7kE8gEpSE+xo
 D1GgBjF9h/9XiDrkPRA3XJGM1uWUH25rpnlVl/pGE5IbRYJXmLqugdP6ondwMOj6K1woGpOuYYY
 6ord4hWbbikWdLBM89jPKQ9Hq4urDyAp0uq970+jQXH8ZMn9cYxo7/KSJSw3oJGBjrD5GVrM
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-08_07,2025-05-08_04,2025-02-21_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 mlxscore=0
 suspectscore=0 lowpriorityscore=0 phishscore=0 clxscore=1015
 malwarescore=0 bulkscore=0 adultscore=0 mlxlogscore=999 spamscore=0
 priorityscore=1501 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2504070000
 definitions=main-2505080205
Received-SPF: pass client-ip=148.163.158.5; envelope-from=zycai@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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
 pc-bios/s390-ccw/bootmap.c    |  44 ++++++-
 pc-bios/s390-ccw/iplb.h       |  43 ++++++-
 pc-bios/s390-ccw/s390-ccw.h   |   1 +
 pc-bios/s390-ccw/sclp.c       |   8 ++
 pc-bios/s390-ccw/sclp.h       |   1 +
 pc-bios/s390-ccw/secure-ipl.c | 232 ++++++++++++++++++++++++++++++++++
 pc-bios/s390-ccw/secure-ipl.h |  20 +++
 7 files changed, 345 insertions(+), 4 deletions(-)

diff --git a/pc-bios/s390-ccw/bootmap.c b/pc-bios/s390-ccw/bootmap.c
index 06cea0929a..24356820ca 100644
--- a/pc-bios/s390-ccw/bootmap.c
+++ b/pc-bios/s390-ccw/bootmap.c
@@ -747,6 +747,14 @@ static int zipl_run_secure(ComponentEntry *entry, uint8_t *tmp_sec)
      * cert_table value: index of cert entry in cert list that contains the certificate
      */
     int cert_table[MAX_CERTIFICATES] = { [0 ... MAX_CERTIFICATES - 1] = -1};
+
+    int sclab_count = 0;
+    int global_sclab_count = 0;
+    uint64_t sclab_load_psw = 0;
+
+    SecureIplCompAddrRange comp_addr_range[MAX_CERTIFICATES];
+    int addr_range_index = 0;
+
     zipl_secure_print_func = zipl_secure_get_print_func(boot_mode);
 
     if (!zipl_secure_ipl_supported()) {
@@ -778,7 +786,17 @@ static int zipl_run_secure(ComponentEntry *entry, uint8_t *tmp_sec)
                 return -1;
             }
 
-            if (have_sig) {
+            zipl_secure_addr_overlap_check(comp_addr_range, &addr_range_index,
+                                           comp_addr, comp_addr + comp_len, have_sig);
+
+            if (!have_sig) {
+                zipl_secure_check_unsigned_comp(comp_addr, &comps, comp_index,
+                                                cert_index, comp_len);
+            } else {
+                zipl_secure_check_sclab(comp_addr, &comps, comp_len, comp_index,
+                                        &sclab_count, &sclab_load_psw,
+                                        &global_sclab_count);
+
                 verified = verify_signature(comp_len, comp_addr,
                                             sig_len, (uint64_t)sig_sec,
                                             &cert_len, &cert_idx);
@@ -800,11 +818,12 @@ static int zipl_run_secure(ComponentEntry *entry, uint8_t *tmp_sec)
                     zipl_secure_print_func(verified, "Could not verify component");
                 }
 
-                comp_index++;
                 found_signature = true;
                 /* After a signature is used another new one can be accepted */
                 have_sig = false;
             }
+
+            comp_index++;
         }
 
         entry++;
@@ -821,8 +840,29 @@ static int zipl_run_secure(ComponentEntry *entry, uint8_t *tmp_sec)
     }
 
     if (!found_signature) {
+        comps.ipl_info_header.iiei |= S390_IPL_INFO_IIEI_NO_SIGED_COMP;
         zipl_secure_print_func(found_signature,
                                "Secure boot is on, but components are not signed");
+    } else {
+        if (sclab_count == 0) {
+            comps.ipl_info_header.iiei |= S390_IPL_INFO_IIEI_NO_SCLAB;
+            zipl_secure_print_func(false, "No recognizable SCLAB");
+        }
+
+        /* Verify PSW from the final component entry with PSW from the global SCLAB. */
+        if ((comps.ipl_info_header.iiei & S390_IPL_INFO_IIEI_NO_SCLAB) == 0) {
+            if (global_sclab_count == 0) {
+                comps.ipl_info_header.iiei |= S390_IPL_INFO_IIEI_NO_GLOBAL_SCLAB;
+                zipl_secure_print_func(false, "Global SCLAB does not exists");
+            } else if (global_sclab_count == 1 && sclab_load_psw) {
+                zipl_secure_load_psw_check(comp_addr_range, addr_range_index,
+                                           sclab_load_psw, entry->compdat.load_psw,
+                                           &comps, comp_index);
+            } else {
+                /* Program will only reach here in audit mode */
+                puts("Multiple global SCLABs");
+            }
+        }
     }
 
     if (zipl_secure_update_iirb(&comps, &certs)) {
diff --git a/pc-bios/s390-ccw/iplb.h b/pc-bios/s390-ccw/iplb.h
index 11302e004d..566e5f78b6 100644
--- a/pc-bios/s390-ccw/iplb.h
+++ b/pc-bios/s390-ccw/iplb.h
@@ -32,11 +32,17 @@ struct IplInfoReportBlockHeader {
 } __attribute__ ((packed));
 typedef struct IplInfoReportBlockHeader IplInfoReportBlockHeader;
 
+#define S390_IPL_INFO_IIEI_NO_SIGED_COMP       0x8000 /* bit 0 */
+#define S390_IPL_INFO_IIEI_NO_SCLAB            0x4000 /* bit 1 */
+#define S390_IPL_INFO_IIEI_NO_GLOBAL_SCLAB     0x2000 /* bit 2 */
+#define S390_IPL_INFO_IIEI_MORE_GLOBAL_SCLAB   0x1000 /* bit 3 */
+
 struct IplInfoBlockHeader {
     uint32_t len;
     uint8_t  ibt;
     uint8_t  reserved1[3];
-    uint8_t  reserved2[8];
+    uint16_t iiei;
+    uint8_t  reserved2[6];
 } __attribute__ ((packed));
 typedef struct IplInfoBlockHeader IplInfoBlockHeader;
 
@@ -60,13 +66,25 @@ typedef struct IplSignatureCertificateList IplSignatureCertificateList;
 #define S390_IPL_COMPONENT_FLAG_SC  0x80
 #define S390_IPL_COMPONENT_FLAG_CSV 0x40
 
+#define S390_IPL_COMPONENT_CEI_INVALID_SCLAB             0x80000000 /* bit 0 */
+#define S390_IPL_COMPONENT_CEI_INVALID_SCLAB_LEN         0x40000000 /* bit 1 */
+#define S390_IPL_COMPONENT_CEI_INVALID_SCLAB_FORMAT      0x20000000 /* bit 2 */
+#define S390_IPL_COMPONENT_CEI_UNMATCHED_SCLAB_LOAD_ADDR 0x10000000 /* bit 3 */
+#define S390_IPL_COMPONENT_CEI_UNMATCHED_SCLAB_LOAD_PSW  0x8000000  /* bit 4 */
+#define S390_IPL_COMPONENT_CEI_INVALID_LOAD_PSW          0x4000000  /* bit 5 */
+#define S390_IPL_COMPONENT_CEI_SCLAB_OLA_NOT_ONE         0x1000000  /* bit 7 */
+#define S390_IPL_COMPONENT_CEI_SCLAB_LOAD_ADDR_NOT_ZERO  0x400000   /* bit 9 */
+#define S390_IPL_COMPONENT_CEI_SCLAB_LOAD_PSW_NOT_ZERO   0x200000   /* bit 10 */
+#define S390_IPL_COMPONENT_CEI_INVALID_UNSIGNED_ADDR     0x100000   /* bit 11 */
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
 } __attribute__ ((packed));
 typedef struct IplDeviceComponentEntry IplDeviceComponentEntry;
 
@@ -93,6 +111,27 @@ typedef struct IplBlocks IplBlocks;
 
 extern IplBlocks ipl_data __attribute__((__aligned__(PAGE_SIZE)));
 
+#define S390_IPL_SCLAB_FLAG_OPSW    0x8000
+#define S390_IPL_SCLAB_FLAG_OLA     0x4000
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
 #define S390_IPL_TYPE_FCP 0x00
 #define S390_IPL_TYPE_CCW 0x02
 #define S390_IPL_TYPE_QEMU_SCSI 0xff
diff --git a/pc-bios/s390-ccw/s390-ccw.h b/pc-bios/s390-ccw/s390-ccw.h
index 648f407dc5..85f92685f6 100644
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
index 0b03c3164f..16f973dde8 100644
--- a/pc-bios/s390-ccw/sclp.c
+++ b/pc-bios/s390-ccw/sclp.c
@@ -157,6 +157,14 @@ bool sclp_is_sipl_on(void)
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
index da795079f4..6e91ec95a8 100644
--- a/pc-bios/s390-ccw/secure-ipl.c
+++ b/pc-bios/s390-ccw/secure-ipl.c
@@ -9,6 +9,7 @@
 
 #include <string.h>
 #include <stdio.h>
+#include "bootmap.h"
 #include "s390-ccw.h"
 #include "secure-ipl.h"
 
@@ -161,6 +162,12 @@ bool zipl_secure_ipl_supported(void)
         return false;
     }
 
+    if (!sclp_is_sclaf_on()) {
+        puts("Secure IPL Code Loading Attributes Facility is not supported by" \
+             " the hypervisor!");
+        return false;
+    }
+
     return true;
 }
 
@@ -173,3 +180,228 @@ void zipl_secure_init_lists(IplDeviceComponentList *comps,
     certs->ipl_info_header.ibt = IPL_IBT_CERTIFICATES;
     certs->ipl_info_header.len = sizeof(certs->ipl_info_header);
 }
+
+static bool is_comp_overlap(SecureIplCompAddrRange *comp_addr_range, int addr_range_index,
+                            uint64_t start_addr, uint64_t end_addr)
+{
+    /* neither a signed nor an unsigned component can overlap with a signed component */
+    for (int i = 0; i < addr_range_index; i++) {
+        if ((comp_addr_range[i].start_addr <= end_addr &&
+            start_addr <= comp_addr_range[i].end_addr) &&
+            comp_addr_range[i].is_signed) {
+            return true;
+       }
+    }
+
+    return false;
+}
+
+static void comp_addr_range_add(SecureIplCompAddrRange *comp_addr_range,
+                                int addr_range_index, bool is_signed,
+                                uint64_t start_addr, uint64_t end_addr)
+{
+    comp_addr_range[addr_range_index].is_signed = is_signed;
+    comp_addr_range[addr_range_index].start_addr = start_addr;
+    comp_addr_range[addr_range_index].end_addr = end_addr;
+}
+
+static void unsigned_addr_check(uint64_t load_addr, IplDeviceComponentList *comps,
+                                int comp_index)
+{
+    bool is_addr_valid;
+
+    is_addr_valid = load_addr >= 0x2000;
+    if (!is_addr_valid) {
+        comps->device_entries[comp_index].cei |=
+        S390_IPL_COMPONENT_CEI_INVALID_UNSIGNED_ADDR;
+        zipl_secure_print_func(is_addr_valid, "Load address is less than 0x2000");
+    }
+}
+
+void zipl_secure_addr_overlap_check(SecureIplCompAddrRange *comp_addr_range,
+                                    int *addr_range_index,
+                                    uint64_t start_addr, uint64_t end_addr,
+                                    bool is_signed)
+{
+    bool overlap;
+
+    overlap = is_comp_overlap(comp_addr_range, *addr_range_index,
+                              start_addr, end_addr);
+    if (!overlap) {
+        comp_addr_range_add(comp_addr_range, *addr_range_index, is_signed,
+                            start_addr, end_addr);
+        *addr_range_index += 1;
+    } else {
+        zipl_secure_print_func(!overlap, "Component addresses overlap");
+    }
+}
+
+static void valid_sclab_check(SclabOriginLocator *sclab_locator,
+                              IplDeviceComponentList *comps, int comp_index)
+{
+    bool is_magic_match;
+    bool is_len_valid;
+
+    /* identifies the presence of SCLAB */
+    is_magic_match = magic_match(sclab_locator->magic, ZIPL_MAGIC);
+    if (!is_magic_match) {
+        comps->device_entries[comp_index].cei |= S390_IPL_COMPONENT_CEI_INVALID_SCLAB;
+
+        /* a missing SCLAB will not be reported in audit mode */
+        return;
+    }
+
+    is_len_valid = sclab_locator->len >= 32;
+    if (!is_len_valid) {
+        comps->device_entries[comp_index].cei |= S390_IPL_COMPONENT_CEI_INVALID_SCLAB_LEN;
+        comps->device_entries[comp_index].cei |= S390_IPL_COMPONENT_CEI_INVALID_SCLAB;
+        zipl_secure_print_func(is_len_valid, "Invalid SCLAB length");
+    }
+}
+
+static void sclab_format_check(SecureCodeLoadingAttributesBlock *sclab,
+                               IplDeviceComponentList *comps, int comp_index)
+{
+    bool valid_format;
+
+    valid_format = sclab->format == 0;
+    if (!valid_format) {
+        comps->device_entries[comp_index].cei |=
+        S390_IPL_COMPONENT_CEI_INVALID_SCLAB_FORMAT;
+    }
+    zipl_secure_print_func(valid_format, "Format-0 SCLAB is not being used");
+}
+
+static void sclab_opsw_check(SecureCodeLoadingAttributesBlock *sclab,
+                             int *global_sclab_count, uint64_t *sclab_load_psw,
+                             IplDeviceComponentList *comps, int comp_index)
+{
+    bool is_load_psw_zero;
+    bool is_ola_on;
+    bool has_one_glob_sclab;
+
+    /* OPSW is zero */
+    if (!(sclab->flags & S390_IPL_SCLAB_FLAG_OPSW)) {
+        is_load_psw_zero = sclab->load_psw == 0;
+        if (!is_load_psw_zero) {
+            comps->device_entries[comp_index].cei |=
+            S390_IPL_COMPONENT_CEI_SCLAB_LOAD_PSW_NOT_ZERO;
+            zipl_secure_print_func(is_load_psw_zero,
+                       "Load PSW is not zero when Override PSW bit is zero");
+        }
+    } else {
+        is_ola_on = sclab->flags & S390_IPL_SCLAB_FLAG_OLA;
+        if (!is_ola_on) {
+            comps->device_entries[comp_index].cei |=
+            S390_IPL_COMPONENT_CEI_SCLAB_OLA_NOT_ONE;
+            zipl_secure_print_func(is_ola_on,
+                       "Override Load Address bit is not set to one in the global SCLAB");
+        }
+
+        *global_sclab_count += 1;
+        if (*global_sclab_count == 1) {
+            *sclab_load_psw = sclab->load_psw;
+        } else {
+            has_one_glob_sclab = false;
+            comps->ipl_info_header.iiei |= S390_IPL_INFO_IIEI_MORE_GLOBAL_SCLAB;
+            zipl_secure_print_func(has_one_glob_sclab, "More than one global SCLAB");
+        }
+    }
+}
+
+static void sclab_ola_check(SecureCodeLoadingAttributesBlock *sclab,
+                            uint64_t load_addr, IplDeviceComponentList *comps,
+                            int comp_index)
+{
+    bool is_load_addr_zero;
+    bool is_matched;
+
+    /* OLA is zero */
+    if (!(sclab->flags & S390_IPL_SCLAB_FLAG_OLA)) {
+        is_load_addr_zero = sclab->load_addr == 0;
+        if (!is_load_addr_zero) {
+            comps->device_entries[comp_index].cei |=
+            S390_IPL_COMPONENT_CEI_SCLAB_LOAD_ADDR_NOT_ZERO;
+            zipl_secure_print_func(is_load_addr_zero,
+                       "Load Address is not zero when Override Load Address bit is zero");
+        }
+    } else {
+        is_matched = sclab->load_addr == load_addr;
+        if (!is_matched) {
+            comps->device_entries[comp_index].cei |=
+            S390_IPL_COMPONENT_CEI_UNMATCHED_SCLAB_LOAD_ADDR;
+            zipl_secure_print_func(is_matched,
+                       "Load Address does not match with component load address");
+        }
+    }
+}
+
+static bool is_psw_valid(uint64_t psw, SecureIplCompAddrRange *comp_addr_range,
+                         int range_index)
+{
+    uint32_t addr = psw & 0x3FFFFFFF;
+
+    /* PSW points to the beginning of a signed binary code component */
+    for (int i = 0; i < range_index; i++) {
+        if (comp_addr_range[i].is_signed && comp_addr_range[i].start_addr == addr) {
+            return true;
+       }
+    }
+
+    return false;
+}
+
+void zipl_secure_load_psw_check(SecureIplCompAddrRange *comp_addr_range,
+                                int addr_range_index, uint64_t sclab_load_psw,
+                                uint64_t load_psw, IplDeviceComponentList *comps,
+                                int comp_index)
+{
+    bool is_valid;
+    bool is_matched;
+
+    is_valid = is_psw_valid(sclab_load_psw, comp_addr_range, addr_range_index) &&
+               is_psw_valid(load_psw, comp_addr_range, addr_range_index);
+    if (!is_valid) {
+        comps->device_entries[comp_index].cei |= S390_IPL_COMPONENT_CEI_INVALID_LOAD_PSW;
+        zipl_secure_print_func(is_valid, "Invalid PSW");
+    }
+
+    is_matched = load_psw == sclab_load_psw;
+    if (!is_matched) {
+        comps->device_entries[comp_index].cei |=
+        S390_IPL_COMPONENT_CEI_UNMATCHED_SCLAB_LOAD_PSW;
+        zipl_secure_print_func(is_matched,
+                               "Load PSW does not match with PSW in component");
+    }
+}
+
+void zipl_secure_check_unsigned_comp(uint64_t comp_addr, IplDeviceComponentList *comps,
+                                     int comp_index, int cert_index, uint64_t comp_len)
+{
+    unsigned_addr_check(comp_addr, comps, comp_index);
+
+    zipl_secure_comp_list_add(comps, comp_index, cert_index, comp_addr, comp_len, 0x00);
+}
+
+void zipl_secure_check_sclab(uint64_t comp_addr, IplDeviceComponentList *comps,
+                             uint64_t comp_len, int comp_index, int *sclab_count,
+                             uint64_t *sclab_load_psw, int *global_sclab_count)
+{
+    SclabOriginLocator *sclab_locator;
+    SecureCodeLoadingAttributesBlock *sclab;
+
+    sclab_locator = (SclabOriginLocator *)(comp_addr + comp_len - 8);
+    valid_sclab_check(sclab_locator, comps, comp_index);
+
+    if ((comps->device_entries[comp_index].cei &
+         S390_IPL_COMPONENT_CEI_INVALID_SCLAB) == 0) {
+        *sclab_count += 1;
+        sclab = (SecureCodeLoadingAttributesBlock *)(comp_addr + comp_len -
+                                                     sclab_locator->len);
+
+        sclab_format_check(sclab, comps, comp_index);
+        sclab_opsw_check(sclab, global_sclab_count, sclab_load_psw,
+                         comps, comp_index);
+        sclab_ola_check(sclab, comp_addr, comps, comp_index);
+    }
+}
diff --git a/pc-bios/s390-ccw/secure-ipl.h b/pc-bios/s390-ccw/secure-ipl.h
index 4e2328840b..713491671f 100644
--- a/pc-bios/s390-ccw/secure-ipl.h
+++ b/pc-bios/s390-ccw/secure-ipl.h
@@ -26,6 +26,26 @@ bool zipl_secure_ipl_supported(void);
 void zipl_secure_init_lists(IplDeviceComponentList *comps,
                             IplSignatureCertificateList *certs);
 
+typedef struct SecureIplCompAddrRange {
+    bool is_signed;
+    uint64_t start_addr;
+    uint64_t end_addr;
+} SecureIplCompAddrRange;
+
+void zipl_secure_addr_overlap_check(SecureIplCompAddrRange *comp_addr_range,
+                                    int *addr_range_index,
+                                    uint64_t start_addr, uint64_t end_addr,
+                                    bool is_signed);
+void zipl_secure_load_psw_check(SecureIplCompAddrRange *comp_addr_range,
+                                int addr_range_index, uint64_t sclab_load_psw,
+                                uint64_t load_psw, IplDeviceComponentList *comps,
+                                int comp_index);
+void zipl_secure_check_unsigned_comp(uint64_t comp_addr, IplDeviceComponentList *comps,
+                                     int comp_index, int cert_index, uint64_t comp_len);
+void zipl_secure_check_sclab(uint64_t comp_addr, IplDeviceComponentList *comps,
+                             uint64_t comp_len, int comp_index, int *sclab_count,
+                             uint64_t *sclab_load_psw, int *global_sclab_count);
+
 typedef void (*ipl_print_func_t)(bool, const char *);
 
 static inline ipl_print_func_t zipl_secure_get_print_func(ZiplBootMode boot_mode)
-- 
2.49.0


