Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E66F6C369A2
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Apr 2025 16:23:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u2BeH-0006tS-QJ; Tue, 08 Apr 2025 12:18:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zycai@linux.ibm.com>)
 id 1u2BJ3-0005cQ-DO; Tue, 08 Apr 2025 11:56:15 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zycai@linux.ibm.com>)
 id 1u2BIy-0005xk-KQ; Tue, 08 Apr 2025 11:56:08 -0400
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53897Y14025761;
 Tue, 8 Apr 2025 15:56:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=W6uFC1Ag4lY8FMpTw
 P6Oy8YVgSFhTO2kGzA4DKE8eR4=; b=kvozh6ZlPgAkTKkHS9Tf6qJYBte/7lIts
 oo34mNZco1GYrUDjvV+F3M4czFN7pJmHdBepMv72v1YunD+Qmq37L9Bh0Oo1mqsL
 pYTaTo0Xyn+BKz6XB1MQ2kjwRCRhdpR57i8OL+VEzhgPWJ4ZnmAr0GerCZnz7nmo
 CYfxiGej5f7dy7gt8TCh/tdshL2GzPwelTOulHYcS/NXmfbfbx2oF/rJl6+kuYve
 BR5SWwVZBXCd98aeS/qWKsa82waM0Mzt7MEEUMataMMQZhxvIBtAaRHIn3HWKFqj
 8l40C3qtKC3q8AwiYkjGy0G6eb3Zgy2LmXu4NE6Dqw89DsBgRdcjw==
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 45vnvq4hxh-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 08 Apr 2025 15:56:02 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 538Cg1CG013858;
 Tue, 8 Apr 2025 15:56:02 GMT
Received: from smtprelay07.wdc07v.mail.ibm.com ([172.16.1.74])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 45ufunkbav-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 08 Apr 2025 15:56:02 +0000
Received: from smtpav06.wdc07v.mail.ibm.com (smtpav06.wdc07v.mail.ibm.com
 [10.39.53.233])
 by smtprelay07.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 538Fu1Um31261290
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 8 Apr 2025 15:56:01 GMT
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 0283F5803F;
 Tue,  8 Apr 2025 15:56:01 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 8C62E58055;
 Tue,  8 Apr 2025 15:55:59 +0000 (GMT)
Received: from fedora-workstation.ibmuc.com (unknown [9.61.125.94])
 by smtpav06.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Tue,  8 Apr 2025 15:55:59 +0000 (GMT)
From: Zhuoying Cai <zycai@linux.ibm.com>
To: thuth@redhat.com, richard.henderson@linaro.org, david@redhat.com,
 pbonzini@redhat.com
Cc: walling@linux.ibm.com, jjherne@linux.ibm.com, jrossi@linux.ibm.com,
 fiuczy@linux.ibm.com, pasic@linux.ibm.com, borntraeger@linux.ibm.com,
 farman@linux.ibm.com, iii@linux.ibm.com, qemu-s390x@nongnu.org,
 qemu-devel@nongnu.org, zycai@linux.ibm.com
Subject: [PATCH v1 19/24] pc-bios/s390-ccw: Add additional security checks for
 secure boot
Date: Tue,  8 Apr 2025 11:55:21 -0400
Message-ID: <20250408155527.123341-20-zycai@linux.ibm.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250408155527.123341-1-zycai@linux.ibm.com>
References: <20250408155527.123341-1-zycai@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: nS6mHauDaxkkYpog2bKXW90ckDFXWAz-
X-Proofpoint-ORIG-GUID: nS6mHauDaxkkYpog2bKXW90ckDFXWAz-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-08_06,2025-04-08_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 spamscore=0
 mlxscore=0 lowpriorityscore=0 adultscore=0 suspectscore=0 mlxlogscore=999
 malwarescore=0 priorityscore=1501 clxscore=1015 bulkscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502280000 definitions=main-2504080107
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
X-Mailman-Approved-At: Tue, 08 Apr 2025 12:17:35 -0400
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
 pc-bios/s390-ccw/bootmap.c  | 281 +++++++++++++++++++++++++++++++++++-
 pc-bios/s390-ccw/iplb.h     |  43 +++++-
 pc-bios/s390-ccw/s390-ccw.h |   1 +
 pc-bios/s390-ccw/sclp.c     |   8 +
 pc-bios/s390-ccw/sclp.h     |   1 +
 5 files changed, 331 insertions(+), 3 deletions(-)

diff --git a/pc-bios/s390-ccw/bootmap.c b/pc-bios/s390-ccw/bootmap.c
index bdbd6ccd96..4bc6311802 100644
--- a/pc-bios/s390-ccw/bootmap.c
+++ b/pc-bios/s390-ccw/bootmap.c
@@ -683,6 +683,207 @@ static int zipl_load_segment(ComponentEntry *entry, uint64_t address)
     return comp_len;
 }
 
+typedef struct SecureIplCompAddrRange {
+    bool is_signed;
+    uint64_t start_addr;
+    uint64_t end_addr;
+} SecureIplCompAddrRange;
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
+                                int comp_index, void (*print_func)(bool, const char *))
+{
+    bool is_addr_valid;
+
+    is_addr_valid = load_addr >= 0x2000;
+    if (!is_addr_valid) {
+        comps->device_entries[comp_index].cei |=
+        S390_IPL_COMPONENT_CEI_INVALID_UNSIGNED_ADDR;
+        print_func(is_addr_valid, "Load address is less than 0x2000");
+    }
+}
+
+static void addr_overlap_check(SecureIplCompAddrRange *comp_addr_range,
+                               int *addr_range_index,
+                               uint64_t start_addr, uint64_t end_addr,
+                               bool is_signed, void (*print_func)(bool, const char *))
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
+        print_func(!overlap, "Component addresses overlap");
+    }
+}
+
+static void valid_sclab_check(SclabOriginLocator *sclab_locator,
+                         IplDeviceComponentList *comps, int comp_index,
+                         void (*print_func)(bool, const char *))
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
+        print_func(is_len_valid, "Invalid SCLAB length");
+    }
+}
+
+static void sclab_format_check(SecureCodeLoadingAttributesBlock *sclab,
+                       IplDeviceComponentList *comps, int comp_index,
+                       void (*print_func)(bool, const char *))
+{
+    bool valid_format;
+
+    valid_format = sclab->format == 0;
+    if (!valid_format) {
+        comps->device_entries[comp_index].cei |=
+        S390_IPL_COMPONENT_CEI_INVALID_SCLAB_FORMAT;
+    }
+    print_func(valid_format, "Format-0 SCLAB is not being used");
+}
+
+static void sclab_opsw_check(SecureCodeLoadingAttributesBlock *sclab,
+                             int *global_sclab_count, uint64_t *sclab_load_psw,
+                             IplDeviceComponentList *comps, int comp_index,
+                             void (*print_func)(bool, const char *))
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
+            print_func(is_load_psw_zero,
+                       "Load PSW is not zero when Override PSW bit is zero");
+        }
+    } else {
+        is_ola_on = sclab->flags & S390_IPL_SCLAB_FLAG_OLA;
+        if (!is_ola_on) {
+            comps->device_entries[comp_index].cei |=
+            S390_IPL_COMPONENT_CEI_SCLAB_OLA_NOT_ONE;
+            print_func(is_ola_on,
+                       "Override Load Address bit is not set to one in the global SCLAB");
+        }
+
+        *global_sclab_count += 1;
+        if (*global_sclab_count == 1) {
+            *sclab_load_psw = sclab->load_psw;
+        } else {
+            has_one_glob_sclab = false;
+            comps->ipl_info_header.iiei |= S390_IPL_INFO_IIEI_MORE_GLOBAL_SCLAB;
+            print_func(has_one_glob_sclab, "More than one global SCLAB");
+        }
+    }
+}
+
+static void sclab_ola_check(SecureCodeLoadingAttributesBlock *sclab,
+                            uint64_t load_addr, IplDeviceComponentList *comps,
+                            int comp_index, void (*print_func)(bool, const char *))
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
+            print_func(is_load_addr_zero,
+                       "Load Address is not zero when Override Load Address bit is zero");
+        }
+    } else {
+        is_matched = sclab->load_addr == load_addr;
+        if (!is_matched) {
+            comps->device_entries[comp_index].cei |=
+            S390_IPL_COMPONENT_CEI_UNMATCHED_SCLAB_LOAD_ADDR;
+            print_func(is_matched,
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
+    return false;
+}
+
+static void load_psw_check(SecureIplCompAddrRange *comp_addr_range, int addr_range_index,
+                           uint64_t sclab_load_psw, uint64_t load_psw,
+                           IplDeviceComponentList *comps, int comp_index,
+                           void (*print_func)(bool, const char *))
+{
+    bool is_valid;
+    bool is_matched;
+
+    is_valid = is_psw_valid(sclab_load_psw, comp_addr_range, addr_range_index) &&
+               is_psw_valid(load_psw, comp_addr_range, addr_range_index);
+    if (!is_valid) {
+        comps->device_entries[comp_index].cei |= S390_IPL_COMPONENT_CEI_INVALID_LOAD_PSW;
+        print_func(is_valid, "Invalid PSW");
+    }
+
+    is_matched = load_psw == sclab_load_psw;
+    if (!is_matched) {
+        comps->device_entries[comp_index].cei |=
+        S390_IPL_COMPONENT_CEI_UNMATCHED_SCLAB_LOAD_PSW;
+        print_func(is_matched, "Load PSW does not match with PSW in component");
+    }
+}
+
 int get_vcssb(VerificationCertificateStorageSizeBlock *vcssb)
 {
     int rc;
@@ -833,6 +1034,12 @@ static bool secure_ipl_supported(void)
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
 
@@ -899,6 +1106,39 @@ static int perform_sig_verf(uint64_t comp_addr, uint64_t comp_len, uint64_t sig_
     return 0;
 }
 
+static void check_unsigned_comp(uint64_t comp_addr, struct IplDeviceComponentList *comps,
+                               int comp_index, int cert_index, uint64_t comp_len,
+                               void (*print_func)(bool, const char *))
+{
+    unsigned_addr_check(comp_addr, comps, comp_index, print_func);
+
+    comp_list_add(comps, comp_index, cert_index, comp_addr, comp_len, 0x00);
+}
+
+static void check_sclab(uint64_t comp_addr, struct IplDeviceComponentList *comps,
+                       uint64_t comp_len, int comp_index, int *sclab_count,
+                       uint64_t *sclab_load_psw, int *global_sclab_count,
+                       void (*print_func)(bool, const char *))
+{
+    SclabOriginLocator *sclab_locator;
+    SecureCodeLoadingAttributesBlock *sclab;
+
+    sclab_locator = (SclabOriginLocator *)(comp_addr + comp_len - 8);
+    valid_sclab_check(sclab_locator, comps, comp_index, print_func);
+
+    if ((comps->device_entries[comp_index].cei &
+         S390_IPL_COMPONENT_CEI_INVALID_SCLAB) == 0) {
+        *sclab_count += 1;
+        sclab = (SecureCodeLoadingAttributesBlock *)(comp_addr + comp_len -
+                                                     sclab_locator->len);
+
+        sclab_format_check(sclab, comps, comp_index, print_func);
+        sclab_opsw_check(sclab, global_sclab_count, sclab_load_psw,
+                         comps, comp_index, print_func);
+        sclab_ola_check(sclab, comp_addr, comps, comp_index, print_func);
+    }
+}
+
 static int zipl_run_secure(ComponentEntry *entry, uint8_t *tmp_sec)
 {
     bool found_signature = false;
@@ -916,6 +1156,13 @@ static int zipl_run_secure(ComponentEntry *entry, uint8_t *tmp_sec)
      */
     uint64_t *cert_table[MAX_CERTIFICATES];
 
+    int sclab_count = 0;
+    int global_sclab_count = 0;
+    uint64_t sclab_load_psw = 0;
+
+    SecureIplCompAddrRange comp_addr_range[MAX_CERTIFICATES];
+    int addr_range_index = 0;
+
     void (*print_func)(bool, const char *) = NULL;
     print_func = &IPL_check;
 
@@ -939,8 +1186,19 @@ static int zipl_run_secure(ComponentEntry *entry, uint8_t *tmp_sec)
             if (comp_len < 0) {
                 return -1;
             }
+            addr_overlap_check(comp_addr_range, &addr_range_index,
+                               entry->compdat.load_addr,
+                               entry->compdat.load_addr + comp_len, valid_sig,
+                               print_func);
+
+            if (!valid_sig) {
+                check_unsigned_comp(entry->compdat.load_addr, &comps, comp_index,
+                                    cert_index, comp_len, print_func);
+            } else {
+                check_sclab(entry->compdat.load_addr, &comps, comp_len, comp_index,
+                            &sclab_count, &sclab_load_psw, &global_sclab_count,
+                            print_func);
 
-            if (valid_sig) {
                 perform_sig_verf(entry->compdat.load_addr, comp_len, sig_len, cert_table,
                                  &cert, &comps, &certs, comp_index, cert_index,
                                  print_func);
@@ -970,8 +1228,29 @@ static int zipl_run_secure(ComponentEntry *entry, uint8_t *tmp_sec)
         return -EINVAL;
     }
 
+    if (sclab_count == 0) {
+        comps.ipl_info_header.iiei |= S390_IPL_INFO_IIEI_NO_SCLAB;
+        print_func(false, "No recognizable SCLAB");
+    }
+
     if (!found_signature) {
+        comps.ipl_info_header.iiei |= S390_IPL_INFO_IIEI_NO_SIGED_COMP;
         print_func(found_signature, "Secure boot is on, but components are not signed");
+    } else {
+        /* Verify PSW from the final component entry with PSW from the global SCLAB. */
+        if ((comps.ipl_info_header.iiei & S390_IPL_INFO_IIEI_NO_SCLAB) == 0) {
+            if (global_sclab_count == 0) {
+                comps.ipl_info_header.iiei |= S390_IPL_INFO_IIEI_NO_GLOBAL_SCLAB;
+                print_func(false, "Global SCLAB does not exists");
+            } else if (global_sclab_count == 1 && sclab_load_psw) {
+                load_psw_check(comp_addr_range, addr_range_index,
+                            sclab_load_psw, entry->compdat.load_psw,
+                            &comps, comp_index, print_func);
+            } else {
+                /* Program will only reach here in audit mode */
+                puts("Multiple global SCLABs");
+            }
+        }
     }
 
     if (update_iirb(&comps, &certs)) {
diff --git a/pc-bios/s390-ccw/iplb.h b/pc-bios/s390-ccw/iplb.h
index 8d9fdde30a..42a9e081fe 100644
--- a/pc-bios/s390-ccw/iplb.h
+++ b/pc-bios/s390-ccw/iplb.h
@@ -35,11 +35,17 @@ struct IplInfoReportBlockHeader {
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
 
@@ -63,13 +69,25 @@ typedef struct IplSignatureCertificateList IplSignatureCertificateList;
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
 
@@ -96,6 +114,27 @@ typedef struct IplBlocks IplBlocks;
 
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
index 68ffbf7bc8..20d6827a4c 100644
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
index fd25c83387..ffdcdd7b16 100644
--- a/pc-bios/s390-ccw/sclp.c
+++ b/pc-bios/s390-ccw/sclp.c
@@ -156,6 +156,14 @@ bool sclp_is_sipl_on(void)
     return cbl & SCCB_CBL_SIPL_BIT;
 }
 
+bool sclp_is_sclaf_on(void)
+{
+    uint16_t cbl = 0;
+
+    sclp_get_cbl(&cbl);
+    return cbl & SCCB_CBL_SCLAF_BIT;
+}
+
 int sclp_read(char *str, size_t count)
 {
     ReadEventData *sccb = (void *)_sccb;
diff --git a/pc-bios/s390-ccw/sclp.h b/pc-bios/s390-ccw/sclp.h
index de4141cb86..ad34fac20d 100644
--- a/pc-bios/s390-ccw/sclp.h
+++ b/pc-bios/s390-ccw/sclp.h
@@ -52,6 +52,7 @@ typedef struct SCCBHeader {
 #define SCCB_DATA_LEN (SCCB_SIZE - sizeof(SCCBHeader))
 #define SCCB_FAC134_DIAG320_BIT 0x4
 #define SCCB_CBL_SIPL_BIT 0x4000
+#define SCCB_CBL_SCLAF_BIT 0x1000
 
 typedef struct ReadInfo {
     SCCBHeader h;
-- 
2.49.0


