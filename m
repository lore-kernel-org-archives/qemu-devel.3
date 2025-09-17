Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2817CAC59A
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Sep 2025 23:24:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uz1Tq-0005sY-Tq; Wed, 17 Sep 2025 19:22:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zycai@linux.ibm.com>)
 id 1uz1Tl-0005mr-Tv; Wed, 17 Sep 2025 19:22:26 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zycai@linux.ibm.com>)
 id 1uz1Th-0002Sb-Ql; Wed, 17 Sep 2025 19:22:24 -0400
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58HHKTTs023755;
 Wed, 17 Sep 2025 23:22:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=e31pZ3afPn1LIjsNt
 VL3PA6fwiZvIdh5y/Wkr3dqLEQ=; b=gIagEDWBoS7Prbw9TeMx6Xmwcdya1vORo
 AqftRKq1dAdBiJTscKNBhf+qkSk68h+RAG1232oFWsJEVrMWxum7qVl9iIgANv/G
 2s8/NZxmuEPMOJ/Hs6LcSrH9Q0wjjLvuYOD+7d4T2t/2c18bwqCxumAvs0JRGpL1
 iwJGL8gzpTMLgVOuxCMo1y2Wj2Gum6is61OfadmU2eX1d0/4Fpc6RWa9pDLLTB8i
 OCf2oeGIrrRvb2aAnzvF8DInNtaBzlJ1opzRtY1oNu1tiGbHH0eNUSGhx1n2jDJ/
 HTb6d73u/9g1C+YW6hIAauPnnEN1zr9vCl1RJ8tlmNh3Obyzks5rA==
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 497g4qpf2f-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 17 Sep 2025 23:21:59 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 58HKOOB6029472;
 Wed, 17 Sep 2025 23:21:59 GMT
Received: from smtprelay06.dal12v.mail.ibm.com ([172.16.1.8])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 495kb140k6-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 17 Sep 2025 23:21:59 +0000
Received: from smtpav02.dal12v.mail.ibm.com (smtpav02.dal12v.mail.ibm.com
 [10.241.53.101])
 by smtprelay06.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 58HNLvrY21693128
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 17 Sep 2025 23:21:57 GMT
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id A52E95805A;
 Wed, 17 Sep 2025 23:21:57 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 9214158051;
 Wed, 17 Sep 2025 23:21:56 +0000 (GMT)
Received: from fedora-workstation.ibmuc.com (unknown [9.61.34.172])
 by smtpav02.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Wed, 17 Sep 2025 23:21:56 +0000 (GMT)
From: Zhuoying Cai <zycai@linux.ibm.com>
To: thuth@redhat.com, berrange@redhat.com, richard.henderson@linaro.org,
 david@redhat.com, jrossi@linux.ibm.com, qemu-s390x@nongnu.org,
 qemu-devel@nongnu.org
Cc: walling@linux.ibm.com, jjherne@linux.ibm.com, pasic@linux.ibm.com,
 borntraeger@linux.ibm.com, farman@linux.ibm.com,
 mjrosato@linux.ibm.com, iii@linux.ibm.com, eblake@redhat.com,
 armbru@redhat.com, zycai@linux.ibm.com, alifm@linux.ibm.com
Subject: [PATCH v6 21/28] pc-bios/s390-ccw: Add additional security checks for
 secure boot
Date: Wed, 17 Sep 2025 19:21:23 -0400
Message-ID: <20250917232131.495848-22-zycai@linux.ibm.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250917232131.495848-1-zycai@linux.ibm.com>
References: <20250917232131.495848-1-zycai@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: GqZpKJew718sJIUL9qzYfhdxlRyp2I2y
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTE2MDIwNCBTYWx0ZWRfXx0tAqA4ObW36
 tXB88iFq4QEDQlLwVEa3S67MYO977UTeH/EWeV9nqFyblFg9IFS/LB+48yyOexIQNYSIUw5toOj
 YMOMgRyhQdnAJI+TH6Ev/+WVgWwaswrlo0fgCpP9KdizIps8a8HvB25noJ5j3krBDJoQ5JF82B3
 tGj8OXNlHQYCMk2NYD8dzXzG0JQ3DQGdGsrd8iuLmdPl0SFo2bpiA1CZuv84Sm1k+4JdYVHfUsC
 d2ZrJt1JzukoReWGTNGPF6cqaUzZFlRQ4mjgViWf78dTdmYAXjFZ8LUDUiCyF3nkiZlGKy2pa6G
 4YUW7xsvmVu935hNdkoKa6Pjv/UC4V3nYpXw7uRLCRwwND7hAMBM0MVruNOlSpJf7AHg2hY7Ji+
 ie7kL4sI
X-Authority-Analysis: v=2.4 cv=R8oDGcRX c=1 sm=1 tr=0 ts=68cb4297 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=yJojWOMRYYMA:10 a=VnNF1IyMAAAA:8 a=-PzWCFmcDqgEtY6oAzcA:9
X-Proofpoint-GUID: GqZpKJew718sJIUL9qzYfhdxlRyp2I2y
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-17_01,2025-09-17_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 suspectscore=0 malwarescore=0 bulkscore=0 spamscore=0
 adultscore=0 impostorscore=0 priorityscore=1501 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509160204
Received-SPF: pass client-ip=148.163.158.5; envelope-from=zycai@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
 pc-bios/s390-ccw/iplb.h       |  26 ++-
 pc-bios/s390-ccw/s390-ccw.h   |   1 +
 pc-bios/s390-ccw/sclp.c       |   8 +
 pc-bios/s390-ccw/sclp.h       |   1 +
 pc-bios/s390-ccw/secure-ipl.c | 412 +++++++++++++++++++++++++++++++++-
 pc-bios/s390-ccw/secure-ipl.h | 110 +++++++++
 6 files changed, 553 insertions(+), 5 deletions(-)

diff --git a/pc-bios/s390-ccw/iplb.h b/pc-bios/s390-ccw/iplb.h
index 11302e004d..41cec91a68 100644
--- a/pc-bios/s390-ccw/iplb.h
+++ b/pc-bios/s390-ccw/iplb.h
@@ -32,11 +32,19 @@ struct IplInfoReportBlockHeader {
 } __attribute__ ((packed));
 typedef struct IplInfoReportBlockHeader IplInfoReportBlockHeader;
 
+#define S390_IPL_INFO_IIEI_NO_SIGNED_COMP      0x8000 /* bit 0 */
+#define S390_IPL_INFO_IIEI_NO_SCLAB            0x4000 /* bit 1 */
+#define S390_IPL_INFO_IIEI_NO_GLOBAL_SCLAB     0x2000 /* bit 2 */
+#define S390_IPL_INFO_IIEI_MORE_GLOBAL_SCLAB   0x1000 /* bit 3 */
+#define S390_IPL_INFO_IIEI_FOUND_UNSIGNED_COMP 0x800 /* bit 4 */
+#define S390_IPL_INFO_IIEI_MORE_SIGNED_COMP    0x400 /* bit 5 */
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
 
@@ -60,13 +68,27 @@ typedef struct IplSignatureCertificateList IplSignatureCertificateList;
 #define S390_IPL_COMPONENT_FLAG_SC  0x80
 #define S390_IPL_COMPONENT_FLAG_CSV 0x40
 
+#define S390_IPL_COMPONENT_CEI_INVALID_SCLAB             0x80000000 /* bit 0 */
+#define S390_IPL_COMPONENT_CEI_INVALID_SCLAB_LEN         0x40000000 /* bit 1 */
+#define S390_IPL_COMPONENT_CEI_INVALID_SCLAB_FORMAT      0x20000000 /* bit 2 */
+#define S390_IPL_COMPONENT_CEI_UNMATCHED_SCLAB_LOAD_ADDR 0x10000000 /* bit 3 */
+#define S390_IPL_COMPONENT_CEI_UNMATCHED_SCLAB_LOAD_PSW  0x8000000  /* bit 4 */
+#define S390_IPL_COMPONENT_CEI_INVALID_LOAD_PSW          0x4000000  /* bit 5 */
+#define S390_IPL_COMPONENT_CEI_NUC_NOT_IN_GLOBAL_SCLA    0x2000000  /* bit 6 */
+#define S390_IPL_COMPONENT_CEI_SCLAB_OLA_NOT_ONE         0x1000000  /* bit 7 */
+#define S390_IPL_COMPONENT_CEI_SC_NOT_IN_GLOBAL_SCLAB    0x800000   /* bit 8 */
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
 
diff --git a/pc-bios/s390-ccw/s390-ccw.h b/pc-bios/s390-ccw/s390-ccw.h
index c2ba40d067..6d51d07c90 100644
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
index 8eab19cb09..cd798c1198 100644
--- a/pc-bios/s390-ccw/secure-ipl.c
+++ b/pc-bios/s390-ccw/secure-ipl.c
@@ -202,6 +202,12 @@ static bool secure_ipl_supported(void)
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
 
@@ -214,6 +220,393 @@ static void init_lists(IplDeviceComponentList *comps, IplSignatureCertificateLis
     certs->ipl_info_header.len = sizeof(certs->ipl_info_header);
 }
 
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
+    if (addr_range_index > MAX_CERTIFICATES - 1) {
+        return;
+    }
+
+    comp_addr_range[addr_range_index].is_signed = is_signed;
+    comp_addr_range[addr_range_index].start_addr = start_addr;
+    comp_addr_range[addr_range_index].end_addr = end_addr;
+}
+
+static void check_unsigned_addr(uint64_t load_addr, IplDeviceComponentList *comps,
+                                int comp_index)
+{
+    uint32_t flag;
+    const char *msg;
+    bool valid;
+
+    valid = validate_unsigned_addr(load_addr);
+    if (!valid) {
+        flag = S390_IPL_COMPONENT_CEI_INVALID_UNSIGNED_ADDR;
+        msg = "Load address is less than 0x2000";
+        set_cei_with_log(comps, comp_index, flag, msg);
+    }
+}
+
+static void addr_overlap_check(SecureIplCompAddrRange *comp_addr_range,
+                               int *addr_range_index,
+                               uint64_t start_addr, uint64_t end_addr, bool is_signed)
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
+        zipl_secure_handle("Component addresses overlap");
+    }
+}
+
+static bool check_sclab_presence(uint8_t *sclab_magic,
+                                 IplDeviceComponentList *comps, int comp_index)
+{
+    if (!validate_sclab_magic(sclab_magic)) {
+        comps->device_entries[comp_index].cei |= S390_IPL_COMPONENT_CEI_INVALID_SCLAB;
+
+        /* a missing SCLAB will not be reported in audit mode */
+        return false;
+    }
+
+    return true;
+}
+
+static void check_sclab_length(uint16_t sclab_len,
+                               IplDeviceComponentList *comps, int comp_index)
+{
+    const char *msg;
+    uint32_t flag;
+    bool valid;
+
+    valid = validate_sclab_length(sclab_len);
+    if (!valid) {
+        flag = S390_IPL_COMPONENT_CEI_INVALID_SCLAB_LEN |
+               S390_IPL_COMPONENT_CEI_INVALID_SCLAB;
+        msg = "Invalid SCLAB length";
+        set_cei_with_log(comps, comp_index, flag, msg);
+    }
+}
+
+static void check_sclab_format(uint8_t sclab_format,
+                               IplDeviceComponentList *comps, int comp_index)
+{
+    const char *msg;
+    uint32_t flag;
+    bool valid;
+
+    valid = validate_sclab_format(sclab_format);
+    if (!valid) {
+        flag = S390_IPL_COMPONENT_CEI_INVALID_SCLAB_FORMAT;
+        msg = "Format-0 SCLAB is not being use";
+        set_cei_with_log(comps, comp_index, flag, msg);
+    }
+}
+
+static void check_sclab_opsw(SecureCodeLoadingAttributesBlock *sclab,
+                             SecureIplSclabInfo *sclab_info,
+                             IplDeviceComponentList *comps, int comp_index)
+{
+    const char *msg;
+    uint32_t flag;
+    bool is_opsw_set;
+    bool valid;
+
+    is_opsw_set = is_sclab_flag_set(sclab->flags, S390_SECURE_IPL_SCLAB_FLAG_OPSW);
+    if (!is_opsw_set) {
+        valid = validate_sclab_opsw_zero(sclab->load_psw);
+        if (!valid) {
+            flag = S390_IPL_COMPONENT_CEI_SCLAB_LOAD_PSW_NOT_ZERO;
+            msg = "Load PSW is not zero when Override PSW bit is zero";
+            set_cei_with_log(comps, comp_index, flag, msg);
+        }
+    } else {
+        /* OPSW = 1 indicating global SCLAB */
+        valid = validate_sclab_opsw_one(sclab->flags);
+        if (!valid) {
+            flag = S390_IPL_COMPONENT_CEI_SCLAB_OLA_NOT_ONE;
+            msg = "Override Load Address bit is not set to one in the global SCLAB";
+            set_cei_with_log(comps, comp_index, flag, msg);
+        }
+
+        sclab_info->global_count += 1;
+        if (sclab_info->global_count == 1) {
+            sclab_info->load_psw = sclab->load_psw;
+            sclab_info->flags = sclab->flags;
+        }
+    }
+}
+
+static void check_sclab_ola(SecureCodeLoadingAttributesBlock *sclab,
+                            uint64_t load_addr, IplDeviceComponentList *comps,
+                            int comp_index)
+{
+    const char *msg;
+    uint32_t flag;
+    bool is_ola_set;
+    bool valid;
+
+    is_ola_set = is_sclab_flag_set(sclab->flags, S390_SECURE_IPL_SCLAB_FLAG_OLA);
+    if (!is_ola_set) {
+        valid = validate_sclab_ola_zero(sclab->load_addr);
+        if (!(valid)) {
+            flag = S390_IPL_COMPONENT_CEI_SCLAB_LOAD_ADDR_NOT_ZERO;
+            msg = "Load Address is not zero when Override Load Address bit is zero";
+            set_cei_with_log(comps, comp_index, flag, msg);
+        }
+
+    } else {
+        valid = validate_sclab_ola_one(sclab->load_addr, load_addr);
+        if (!valid) {
+            flag = S390_IPL_COMPONENT_CEI_UNMATCHED_SCLAB_LOAD_ADDR;
+            msg = "Load Address does not match with component load address";
+            set_cei_with_log(comps, comp_index, flag, msg);
+        }
+    }
+}
+
+static void check_sclab_nuc(uint16_t sclab_flags, IplDeviceComponentList *comps,
+                            int comp_index)
+{
+    const char *msg;
+    uint32_t flag;
+    bool is_nuc_set;
+    bool is_global_sclab;
+
+    is_nuc_set = is_sclab_flag_set(sclab_flags, S390_SECURE_IPL_SCLAB_FLAG_NUC);
+    is_global_sclab = is_sclab_flag_set(sclab_flags, S390_SECURE_IPL_SCLAB_FLAG_OPSW);
+    if (is_nuc_set && !is_global_sclab) {
+        flag = S390_IPL_COMPONENT_CEI_NUC_NOT_IN_GLOBAL_SCLA;
+        msg = "No Unsigned Components bit is set, but not in the global SCLAB";
+        set_cei_with_log(comps, comp_index, flag, msg);
+    }
+}
+
+static void check_sclab_sc(uint16_t sclab_flags, IplDeviceComponentList *comps,
+                           int comp_index)
+{
+    const char *msg;
+    uint32_t flag;
+    bool is_sc_set;
+    bool is_global_sclab;
+
+    is_sc_set = is_sclab_flag_set(sclab_flags, S390_SECURE_IPL_SCLAB_FLAG_SC);
+    is_global_sclab = is_sclab_flag_set(sclab_flags, S390_SECURE_IPL_SCLAB_FLAG_OPSW);
+    if (is_sc_set && !is_global_sclab) {
+        flag = S390_IPL_COMPONENT_CEI_SC_NOT_IN_GLOBAL_SCLAB;
+        msg = "Single Component bit is set, but not in the global SCLAB";
+        set_cei_with_log(comps, comp_index, flag, msg);
+    }
+}
+
+static bool is_psw_valid(uint64_t psw, SecureIplCompAddrRange *comp_addr_range,
+                         int range_index)
+{
+    uint32_t addr = psw & 0x3FFFFFFF;
+
+    /* PSW points within a signed binary code component */
+    for (int i = 0; i < range_index; i++) {
+        if (comp_addr_range[i].is_signed &&
+            addr >= comp_addr_range[i].start_addr &&
+            addr <= comp_addr_range[i].end_addr) {
+            return true;
+       }
+    }
+
+    return false;
+}
+
+static void check_load_psw(SecureIplCompAddrRange *comp_addr_range,
+                           int addr_range_index, uint64_t sclab_load_psw,
+                           uint64_t load_psw, IplDeviceComponentList *comps,
+                           int comp_index)
+{
+    uint32_t flag;
+    const char *msg;
+    bool valid;
+
+    valid = is_psw_valid(sclab_load_psw, comp_addr_range, addr_range_index) &&
+            is_psw_valid(load_psw, comp_addr_range, addr_range_index);
+    if (!valid) {
+        flag = S390_IPL_COMPONENT_CEI_INVALID_LOAD_PSW;
+        msg = "Invalid PSW";
+        set_cei_with_log(comps, comp_index, flag, msg);
+    }
+
+    valid = validate_lpsw(sclab_load_psw, load_psw);
+    if (!valid) {
+        flag = S390_IPL_COMPONENT_CEI_UNMATCHED_SCLAB_LOAD_PSW;
+        msg = "Load PSW does not match with PSW in component";
+        set_cei_with_log(comps, comp_index, flag, msg);
+    }
+}
+
+static void check_nuc(uint16_t global_sclab_flags, int unsigned_count,
+                      IplDeviceComponentList *comps)
+{
+    uint16_t flag;
+    const char *msg;
+    bool is_nuc_set;
+
+    is_nuc_set = is_sclab_flag_set(global_sclab_flags, S390_SECURE_IPL_SCLAB_FLAG_NUC);
+    if (is_nuc_set && unsigned_count > 0) {
+        flag = S390_IPL_INFO_IIEI_FOUND_UNSIGNED_COMP;
+        msg = "Unsigned components are not allowed";
+        set_iiei_with_log(comps, flag, msg);
+    }
+}
+
+static void check_sc(uint16_t global_sclab_flags, int signed_count,
+                     IplDeviceComponentList *comps)
+{
+    uint16_t flag;
+    const char *msg;
+    bool is_sc_set;
+
+    is_sc_set = is_sclab_flag_set(global_sclab_flags, S390_SECURE_IPL_SCLAB_FLAG_SC);
+    if (is_sc_set && signed_count != 1) {
+        flag = S390_IPL_INFO_IIEI_MORE_SIGNED_COMP;
+        msg = "Only one signed component is allowed";
+        set_iiei_with_log(comps, flag, msg);
+    }
+}
+
+void check_global_sclab(SecureIplSclabInfo sclab_info,
+                        SecureIplCompAddrRange *comp_addr_range,
+                        int addr_range_index, uint64_t load_psw,
+                        int unsigned_count, int signed_count,
+                        IplDeviceComponentList *comps, int comp_index)
+{
+    uint16_t flag;
+    const char *msg;
+
+    if (sclab_info.count == 0) {
+        return;
+    }
+
+    if (sclab_info.global_count == 0) {
+        flag = S390_IPL_INFO_IIEI_NO_GLOBAL_SCLAB;
+        msg = "Global SCLAB does not exists";
+        set_iiei_with_log(comps, flag, msg);
+        return;
+    }
+
+    if (sclab_info.global_count > 1) {
+        flag = S390_IPL_INFO_IIEI_MORE_GLOBAL_SCLAB;
+        msg = "More than one global SCLAB";
+        set_iiei_with_log(comps, flag, msg);
+        return;
+    }
+
+    if (sclab_info.load_psw) {
+        /* Verify PSW from the final component entry with PSW from the global SCLAB */
+        check_load_psw(comp_addr_range, addr_range_index,
+                          sclab_info.load_psw, load_psw,
+                          comps, comp_index);
+    }
+
+    if (sclab_info.flags) {
+        /* Unsigned components are not allowed if NUC flag is set in the global SCLAB */
+        check_nuc(sclab_info.flags, unsigned_count, comps);
+
+        /* Only one signed component is allowed is SC flag is set in the global SCLAB */
+        check_sc(sclab_info.flags, signed_count, comps);
+    }
+}
+
+static void check_signed_comp(int signed_count, IplDeviceComponentList *comps)
+{
+    uint16_t flag;
+    const char *msg;
+
+    if (signed_count > 0) {
+        return;
+    }
+
+    flag =  S390_IPL_INFO_IIEI_NO_SIGNED_COMP;
+    msg = "Secure boot is on, but components are not signed";
+    set_iiei_with_log(comps, flag, msg);
+}
+
+static void check_sclab_count(int count, IplDeviceComponentList *comps)
+{
+    uint16_t flag;
+    const char *msg;
+
+    if (count > 0) {
+        return;
+    }
+
+    flag = S390_IPL_INFO_IIEI_NO_SCLAB;
+    msg = "No recognizable SCLAB";
+    set_iiei_with_log(comps, flag, msg);
+}
+
+static void check_unsigned_comp(uint64_t comp_addr, IplDeviceComponentList *comps,
+                                int comp_index, int cert_index, uint64_t comp_len)
+{
+    check_unsigned_addr(comp_addr, comps, comp_index);
+
+    comp_list_add(comps, comp_index, cert_index, comp_addr, comp_len, 0x00);
+}
+
+static void check_sclab(uint64_t comp_addr, IplDeviceComponentList *comps,
+                        uint64_t comp_len, int comp_index, SecureIplSclabInfo *sclab_info)
+{
+    SclabOriginLocator *sclab_locator;
+    SecureCodeLoadingAttributesBlock *sclab;
+    bool exist;
+    bool valid;
+
+    sclab_locator = (SclabOriginLocator *)(comp_addr + comp_len - 8);
+
+    /* return early if sclab does not exist */
+    exist = check_sclab_presence(sclab_locator->magic, comps, comp_index);
+    if (!exist) {
+        return;
+    }
+
+    check_sclab_length(sclab_locator->len, comps, comp_index);
+
+    /* return early if sclab is invalid */
+    valid = (comps->device_entries[comp_index].cei &
+             S390_IPL_COMPONENT_CEI_INVALID_SCLAB) == 0;
+    if (!valid) {
+        return;
+    }
+
+    sclab_info->count += 1;
+    sclab = (SecureCodeLoadingAttributesBlock *)(comp_addr + comp_len -
+                                                    sclab_locator->len);
+
+    check_sclab_format(sclab->format, comps, comp_index);
+    check_sclab_opsw(sclab, sclab_info, comps, comp_index);
+    check_sclab_ola(sclab, comp_addr, comps, comp_index);
+    check_sclab_nuc(sclab->flags, comps, comp_index);
+    check_sclab_sc(sclab->flags, comps, comp_index);
+}
+
 static uint32_t zipl_load_signature(ComponentEntry *entry, uint64_t sig_sec)
 {
     uint32_t sig_len;
@@ -278,7 +671,11 @@ int zipl_run_secure(ComponentEntry **entry_ptr, uint8_t *tmp_sec)
      * cert_table value: index of cert entry in cert list that contains the certificate
      */
     int cert_table[MAX_CERTIFICATES] = { [0 ... MAX_CERTIFICATES - 1] = -1};
+    SecureIplCompAddrRange comp_addr_range[MAX_CERTIFICATES];
+    int addr_range_index = 0;
     int signed_count = 0;
+    int unsigned_count = 0;
+    SecureIplSclabInfo sclab_info = { 0 };
 
     if (!secure_ipl_supported()) {
         return -1;
@@ -308,10 +705,17 @@ int zipl_run_secure(ComponentEntry **entry_ptr, uint8_t *tmp_sec)
                 goto out;
             }
 
+            addr_overlap_check(comp_addr_range, &addr_range_index,
+                               comp_addr, comp_addr + comp_len, sig_len > 0);
+
             if (!sig_len) {
+                check_unsigned_comp(comp_addr, &comps, comp_index, cert_index, comp_len);
+                unsigned_count += 1;
+                comp_index++;
                 break;
             }
 
+            check_sclab(comp_addr, &comps, comp_len, comp_index, &sclab_info);
             verified = verify_signature(comp_len, comp_addr, sig_len, (uint64_t)sig,
                                         &cert_len, &cert_idx);
 
@@ -351,9 +755,11 @@ int zipl_run_secure(ComponentEntry **entry_ptr, uint8_t *tmp_sec)
         }
     }
 
-    if (signed_count == 0) {
-        zipl_secure_handle("Secure boot is on, but components are not signed");
-    }
+    check_signed_comp(signed_count, &comps);
+    check_sclab_count(sclab_info.count, &comps);
+    check_global_sclab(sclab_info, comp_addr_range, addr_range_index,
+                       entry->compdat.load_psw, unsigned_count, signed_count,
+                       &comps, comp_index);
 
     if (update_iirb(&comps, &certs)) {
         zipl_secure_handle("Failed to write IPL Information Report Block");
diff --git a/pc-bios/s390-ccw/secure-ipl.h b/pc-bios/s390-ccw/secure-ipl.h
index a264a44349..87aa6e1465 100644
--- a/pc-bios/s390-ccw/secure-ipl.h
+++ b/pc-bios/s390-ccw/secure-ipl.h
@@ -16,6 +16,42 @@
 VCStorageSizeBlock *zipl_secure_get_vcssb(void);
 int zipl_run_secure(ComponentEntry **entry_ptr, uint8_t *tmp_sec);
 
+#define S390_SECURE_IPL_SCLAB_FLAG_OPSW    0x8000
+#define S390_SECURE_IPL_SCLAB_FLAG_OLA     0x4000
+#define S390_SECURE_IPL_SCLAB_FLAG_NUC     0x2000
+#define S390_SECURE_IPL_SCLAB_FLAG_SC      0x1000
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
+typedef struct SecureIplCompAddrRange {
+    bool is_signed;
+    uint64_t start_addr;
+    uint64_t end_addr;
+} SecureIplCompAddrRange;
+
+typedef struct SecureIplSclabInfo {
+    int count;
+    int global_count;
+    uint64_t load_psw;
+    uint16_t flags;
+} SecureIplSclabInfo;
+
 static inline void zipl_secure_handle(const char *message)
 {
     switch (boot_mode) {
@@ -27,6 +63,80 @@ static inline void zipl_secure_handle(const char *message)
     }
 }
 
+static inline bool is_sclab_flag_set(uint16_t sclab_flags, uint16_t flag)
+{
+    return (sclab_flags & flag) != 0;
+}
+
+static inline bool validate_unsigned_addr(uint64_t comp_load_addr)
+{
+    /* usigned load address must be greater than or equal to 0x2000 */
+    return comp_load_addr >= 0x2000;
+}
+
+static inline bool validate_sclab_magic(uint8_t *sclab_magic)
+{
+    /* identifies the presence of SCLAB */
+    return magic_match(sclab_magic, ZIPL_MAGIC);
+}
+
+static inline bool validate_sclab_length(uint16_t sclab_len)
+{
+    /* minimum SCLAB length is 32 bytes */
+    return sclab_len >= 32;
+}
+
+static inline bool validate_sclab_format(uint8_t sclab_format)
+{
+    /* SCLAB format must set to zero, indicating a format-0 SCLAB being used */
+    return sclab_format == 0;
+}
+
+static inline bool validate_sclab_ola_zero(uint64_t sclab_load_addr)
+{
+    /* Load address field in SCLAB must contain zeros */
+    return sclab_load_addr == 0;
+}
+
+static inline bool validate_sclab_ola_one(uint64_t sclab_load_addr,
+                                          uint64_t comp_load_addr)
+{
+   /* Load address field must match storage address of the component */
+   return sclab_load_addr == comp_load_addr;
+}
+
+static inline bool validate_sclab_opsw_zero(uint64_t sclab_load_psw)
+{
+    /* Load PSW field in SCLAB must contain zeros */
+    return sclab_load_psw == 0;
+}
+
+static inline bool validate_sclab_opsw_one(uint16_t sclab_flags)
+{
+   /* OLA must set to one */
+   return is_sclab_flag_set(sclab_flags, S390_SECURE_IPL_SCLAB_FLAG_OLA);
+}
+
+static inline bool validate_lpsw(uint64_t sclab_load_psw, uint64_t comp_load_psw)
+{
+    /* compare load PSW with the PSW specified in component */
+    return sclab_load_psw == comp_load_psw;
+}
+
+static inline void set_cei_with_log(IplDeviceComponentList *comps, int comp_index,
+                                    uint32_t flag, const char *message)
+{
+    comps->device_entries[comp_index].cei |= flag;
+    zipl_secure_handle(message);
+}
+
+static inline void set_iiei_with_log(IplDeviceComponentList *comps, uint16_t flag,
+                                     const char *message)
+{
+    comps->ipl_info_header.iiei |= flag;
+    zipl_secure_handle(message);
+}
+
 static inline uint64_t diag320(void *data, unsigned long subcode)
 {
     register unsigned long addr asm("0") = (unsigned long)data;
-- 
2.50.1


