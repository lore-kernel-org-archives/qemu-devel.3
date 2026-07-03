Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E330C43458
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jul 2026 02:31:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wfTfz-0000pu-0X; Thu, 02 Jul 2026 22:30:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zycai@linux.ibm.com>)
 id 1wfTfv-0000fZ-KI; Thu, 02 Jul 2026 22:30:43 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zycai@linux.ibm.com>)
 id 1wfTfs-0003f4-No; Thu, 02 Jul 2026 22:30:43 -0400
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6631IHWE1257309; Fri, 3 Jul 2026 02:30:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=vdZZKOYiWvpkQl9kx
 vUTE0HZxDwdCYMIc+1mj6I28NQ=; b=UFGI1AdK1UeBBG+5n1gxI5onbn8+MexqQ
 fzEyrfzUne2Ko+8zv9z5lK/RMyq9a/fm891OUNOOathlDfsMFwlj7mv0gfuCMRPe
 G1vPATCDomQg7HAUW+Wm/dAzkvMqkZmAAeuxxTEHEROLsKFevIKj4n5x8iNcpVcK
 dOWuKY/q3IAPPSnOJRol/2wH1zig4rp0ppads4m+l8qD1eIQDSUTgwXgIteycWTC
 bwd9YLDRmj9ChhUNg7AFnaUKqHMMJIxUwMl1yKFznN6Zy5nPlfvj0iHSy12+4D+o
 4QxvfrU2R8UKg0kLzJ7h+SPubZU92/6ek+lcwT6GOv+Gh10oqOaJw==
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4f26n650m8-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 03 Jul 2026 02:30:36 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 6632JfgZ021814;
 Fri, 3 Jul 2026 02:30:35 GMT
Received: from smtprelay02.wdc07v.mail.ibm.com ([172.16.1.69])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4f2sukes2v-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 03 Jul 2026 02:30:35 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (smtpav04.dal12v.mail.ibm.com
 [10.241.53.103])
 by smtprelay02.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 6632UXpK13435456
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 3 Jul 2026 02:30:34 GMT
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 986F458063;
 Fri,  3 Jul 2026 02:30:33 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id B57E858052;
 Fri,  3 Jul 2026 02:30:31 +0000 (GMT)
Received: from fedora-workstation.lan (unknown [9.61.151.121])
 by smtpav04.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Fri,  3 Jul 2026 02:30:31 +0000 (GMT)
From: Zhuoying Cai <zycai@linux.ibm.com>
To: qemu-s390x@nongnu.org, qemu-devel@nongnu.org
Cc: jrossi@linux.ibm.com, cohuck@redhat.com, berrange@redhat.com,
 richard.henderson@linaro.org, david@kernel.org, walling@linux.ibm.com,
 jjherne@linux.ibm.com, pasic@linux.ibm.com, borntraeger@linux.ibm.com,
 farman@linux.ibm.com, mjrosato@linux.ibm.com, iii@linux.ibm.com,
 eblake@redhat.com, armbru@redhat.com, zycai@linux.ibm.com,
 alifm@linux.ibm.com, brueckner@linux.ibm.com,
 pierrick.bouvier@oss.qualcomm.com, jdaley@linux.ibm.com
Subject: [PATCH v13 26/33] pc-bios/s390-ccw: Add additional security checks
 for secure boot
Date: Thu,  2 Jul 2026 22:29:24 -0400
Message-ID: <20260703022933.1805010-27-zycai@linux.ibm.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260703022933.1805010-1-zycai@linux.ibm.com>
References: <20260703022933.1805010-1-zycai@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzAzMDAyMCBTYWx0ZWRfX+dZL9z8X34Gd
 CvKFZF681EDwIKR5EHuwP9wtW1poup8VZc8FzVQVPGQEuzhcvwKwNu8NUM1UDDJijYvGeb7fKUC
 6ocC4G+7YYgVIbDP5zRpiMBFSVO7+LM70bgvOWRFA2m8sWA1RO+hUe8+gS+i87TdtIM9LARb2sT
 F2MqIAg0k1HfPZvDWYiZmqBELmY7Nmd7E5HgsVaTSOWVg9MKEXDuGRWWuCYjlB0XRiWmv62drfo
 hAFV/4fuqYOLB0TshEVLXWnGlP7qH4WW1DdFxqjugOMY8W/3ST5Ndz2Iug92PeGoKAMig+Ty9wF
 LDAFNI610Quq219LagZw0rua9sjhjYQ/qbgoVQhmCIOYLXs9n5EttX3tt5GkoyiR6kfWfAJWs6a
 wz2vYFQWRe2BfbNFC+PVOFO2e5ve17AMkojeiWEzpv+KbIYgs0OA2eLP2PaJZYcYQWb2Abp0HQD
 lTX04PGXONLk1/2jp2g==
X-Authority-Analysis: v=2.4 cv=V45NF+ni c=1 sm=1 tr=0 ts=6a471ecc cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8 a=s9pCXNYtFNHZQuK5kQYA:9
X-Proofpoint-ORIG-GUID: qMHkEzBWKZyFw7dKO4wlOqG596v-1UCG
X-Proofpoint-GUID: qMHkEzBWKZyFw7dKO4wlOqG596v-1UCG
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzAzMDAyMCBTYWx0ZWRfX356CjjGg54Fu
 Tg+XNnbCyB8MbssaJoiaVT0p1UkJ7V9z1TTu5F8KJSs6+Zyrtp1I68cRIGKdqynpFrblV1WPcPZ
 C2vos/bd2GnkCWof9ZiMFy3SUBoqPU8=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-03_01,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 spamscore=0 suspectscore=0 lowpriorityscore=0 priorityscore=1501
 adultscore=0 clxscore=1015 impostorscore=0 malwarescore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607030020
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

Add IPL Information Error Indicators (IIEI) and Component Error
Indicators (CEI) for IPL Information Report Block (IIRB).

When SCLAF is installed, additional secure boot checks are performed
during zipl and store results of verification into IIRB.

Signed-off-by: Zhuoying Cai <zycai@linux.ibm.com>
---
 include/hw/s390x/ipl/qipl.h   |  29 +++++-
 pc-bios/s390-ccw/sclp.h       |   1 +
 pc-bios/s390-ccw/secure-ipl.c | 179 +++++++++++++++++++++++++++++++++-
 pc-bios/s390-ccw/secure-ipl.h |  51 ++++++++++
 4 files changed, 255 insertions(+), 5 deletions(-)

diff --git a/include/hw/s390x/ipl/qipl.h b/include/hw/s390x/ipl/qipl.h
index 58329fb5bc..61e4ac40f9 100644
--- a/include/hw/s390x/ipl/qipl.h
+++ b/include/hw/s390x/ipl/qipl.h
@@ -168,10 +168,20 @@ struct IplInfoReportBlockHeader {
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
 
@@ -195,13 +205,28 @@ typedef struct IplSignatureCertificateList IplSignatureCertificateList;
 #define S390_IPL_DEV_COMP_FLAG_SC  0x80
 #define S390_IPL_DEV_COMP_FLAG_CSV 0x40
 
+/* IPL Device Component Error Indicators */
+#define S390_CEI_INVALID_SCLAB             0x80000000 /* bit 0 */
+#define S390_CEI_INVALID_SCLAB_LEN         0x40000000 /* bit 1 */
+#define S390_CEI_INVALID_SCLAB_FORMAT      0x20000000 /* bit 2 */
+#define S390_CEI_UNMATCHED_SCLAB_LOAD_ADDR 0x10000000 /* bit 3 */
+#define S390_CEI_UNMATCHED_SCLAB_LOAD_PSW  0x8000000  /* bit 4 */
+#define S390_CEI_INVALID_LOAD_PSW          0x4000000  /* bit 5 */
+#define S390_CEI_NUC_NOT_IN_GLOBAL_SCLAB   0x2000000  /* bit 6 */
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
 
diff --git a/pc-bios/s390-ccw/sclp.h b/pc-bios/s390-ccw/sclp.h
index a8a41cd004..cae65b29b5 100644
--- a/pc-bios/s390-ccw/sclp.h
+++ b/pc-bios/s390-ccw/sclp.h
@@ -52,6 +52,7 @@ typedef struct SCCBHeader {
 #define SCCB_DATA_LEN (SCCB_SIZE - sizeof(SCCBHeader))
 #define SCCB_FAC134_DIAG320_BIT 0x4
 #define SCCB_FAC_IPL_SIPL_BIT   0x4000
+#define SCCB_FAC_IPL_SCLAF_BIT  0x1000
 
 typedef struct ReadInfo {
     SCCBHeader h;
diff --git a/pc-bios/s390-ccw/secure-ipl.c b/pc-bios/s390-ccw/secure-ipl.c
index e731926e4d..5629707ea1 100644
--- a/pc-bios/s390-ccw/secure-ipl.c
+++ b/pc-bios/s390-ccw/secure-ipl.c
@@ -180,6 +180,12 @@ bool secure_ipl_supported(void)
         return false;
     }
 
+    if (!sclp_is_fac_ipl_flag_on(SCCB_FAC_IPL_SCLAF_BIT)) {
+        puts("Secure IPL Code Loading Attributes Facility is not supported by"
+             " the hypervisor!");
+        return false;
+    }
+
     return true;
 }
 
@@ -210,6 +216,156 @@ static void check_comp_overlap(IplDeviceComponentList *comp_list,
     }
 }
 
+static bool is_psw_valid(uint64_t psw, IplDeviceComponentEntry *comp)
+{
+    uint32_t addr = psw & 0x7fffffff;
+
+    /*
+     * PSW points within a signed binary code component
+     *
+     * Check addr falls within [comp->addr, comp->addr + comp->len - 2],
+     * ensuring at least 2 bytes (minimum instruction length) remain.
+     */
+    return intersects(addr, 1, comp->addr, comp->len - 1);
+}
+
+void check_global_sclab(const SclaBlock *global_sclab,
+                        IplDeviceComponentEntry *comp_entry,
+                        IplDeviceComponentList *comp_list)
+{
+    bool psw_valid = false;
+    bool global_psw_valid = false;
+    int signed_count = 0;
+    int unsigned_count = 0;
+    IplDeviceComponentEntry *comp;
+
+    if (!global_sclab) {
+        comp_list->ipl_info_header.iiei |= S390_IIEI_NO_GLOBAL_SCLAB;
+        zipl_secure_error("Global SCLAB does not exist");
+        return;
+    }
+
+    for_each_rb_entry(comp, comp_list) {
+        if (comp->flags & S390_IPL_DEV_COMP_FLAG_SC) {
+            psw_valid |= is_psw_valid(comp_entry->addr, comp);
+            global_psw_valid |= is_psw_valid(global_sclab->load_psw, comp);
+            signed_count += 1;
+        } else {
+            unsigned_count += 1;
+        }
+    }
+
+    /* validate load PSW with PSW specified in the final entry */
+    zipl_secure_validate(psw_valid && global_psw_valid, &comp_entry->cei,
+                         S390_CEI_INVALID_LOAD_PSW, "Invalid PSW");
+
+    /* compare load PSW with the PSW specified in component */
+    zipl_secure_validate(global_sclab->load_psw == comp_entry->addr,
+                         &comp_entry->cei, S390_CEI_UNMATCHED_SCLAB_LOAD_PSW,
+                         "Load PSW does not match with PSW in component");
+
+    /* Unsigned components are not allowed if NUC flag is set in the global SCLAB */
+    if ((global_sclab->flags & S390_SCLAB_NUC) && unsigned_count > 0) {
+        comp_list->ipl_info_header.iiei |= S390_IIEI_FOUND_UNSIGNED_COMP;
+        zipl_secure_error("Unsigned components are not allowed");
+    }
+
+    /*
+     * Only one signed component is allowed if SC flag is set in the global SCLAB
+     * More than one component in the component table is not allowed
+     */
+    if ((global_sclab->flags & S390_SCLAB_SC) &&
+        (signed_count != 1 || unsigned_count != 0)) {
+        comp_list->ipl_info_header.iiei |= S390_IIEI_MORE_SIGNED_COMP;
+        zipl_secure_error("Only one signed component is allowed");
+    }
+}
+
+static void check_sclab(SclaBlock **global_sclab,
+                        IplDeviceComponentEntry *comp_entry,
+                        IplInfoBlockHeader *comp_list_hdr)
+{
+    SclabOriginLocator *sclab_locator;
+    SclaBlock *sclab;
+
+    /* must be large enough to locate the sclab locator, else implies invalid SCLAB */
+    zipl_secure_validate(comp_entry->len >= 8, &comp_entry->cei,
+                         S390_CEI_INVALID_SCLAB,
+                         "Signed component too short to contain SCLAB locator");
+
+    if (comp_entry->cei & S390_CEI_INVALID_SCLAB) {
+        return;
+    }
+
+    /* sclab locator is located at the last 8 bytes of the signed comp */
+    sclab_locator = (SclabOriginLocator *)(comp_entry->addr +
+                                           comp_entry->len - 8);
+
+    /* return early if sclab does not exist */
+    zipl_secure_validate(magic_match(sclab_locator->magic, ZIPL_MAGIC),
+                         &comp_entry->cei, S390_CEI_INVALID_SCLAB,
+                         "Magic does not match. SCLAB does not exist");
+
+    if (comp_entry->cei & S390_CEI_INVALID_SCLAB) {
+        return;
+    }
+
+    zipl_secure_validate(sclab_locator->len >= S390_SCLAB_MIN_LEN, &comp_entry->cei,
+                         S390_CEI_INVALID_SCLAB_LEN | S390_CEI_INVALID_SCLAB,
+                         "Invalid SCLAB length");
+
+    /* return early if sclab is invalid */
+    if (comp_entry->cei & S390_CEI_INVALID_SCLAB) {
+        return;
+    }
+
+    sclab = (SclaBlock *)(comp_entry->addr + comp_entry->len -
+                          sclab_locator->len);
+
+    zipl_secure_validate(sclab->format == 0, &comp_entry->cei,
+                         S390_CEI_INVALID_SCLAB_FORMAT,
+                         "Format-0 SCLAB is not being used");
+
+    if (!(sclab->flags & S390_SCLAB_OPSW)) {
+        /* OPSW = 0 - Load PSW field in SCLAB must contain zeros */
+        zipl_secure_validate(sclab->load_psw == 0, &comp_entry->cei,
+                             S390_CEI_SCLAB_LOAD_PSW_NOT_ZERO,
+                             "Load PSW is not zero when Override PSW bit is zero");
+    } else {
+        /* OPSW = 1 indicating global SCLAB */
+        if (*global_sclab) {
+            comp_list_hdr->iiei |= S390_IIEI_MORE_GLOBAL_SCLAB;
+            zipl_secure_error("More than one global SCLAB");
+        }
+        *global_sclab = sclab;
+
+        /* override load address flag must set to one */
+        zipl_secure_validate(sclab->flags & S390_SCLAB_OLA, &comp_entry->cei,
+                             S390_CEI_SCLAB_OLA_NOT_ONE,
+                             "OLA flag is not set to one in the global SCLAB");
+    }
+
+    if (!(sclab->flags & S390_SCLAB_OLA)) {
+        /* OLA = 0 - Load address field in SCLAB must contain zeros */
+        zipl_secure_validate(sclab->load_addr == 0, &comp_entry->cei,
+                             S390_CEI_SCLAB_LOAD_ADDR_NOT_ZERO,
+                             "Load Address is not zero when OLA flag is zero");
+    } else {
+        /* OLA = 1 - Load address field must match storage address of the component */
+        zipl_secure_validate(sclab->load_addr == comp_entry->addr, &comp_entry->cei,
+                             S390_CEI_UNMATCHED_SCLAB_LOAD_ADDR,
+                             "Load Address does not match with component load address");
+    }
+
+    zipl_secure_validate(~sclab->flags & S390_SCLAB_NUC || sclab->flags & S390_SCLAB_OPSW,
+                         &comp_entry->cei, S390_CEI_NUC_NOT_IN_GLOBAL_SCLAB,
+                         "NUC bit is set, but not in the global SCLAB");
+
+    zipl_secure_validate(~sclab->flags & S390_SCLAB_SC || sclab->flags & S390_SCLAB_OPSW,
+                         &comp_entry->cei, S390_CEI_SC_NOT_IN_GLOBAL_SCLAB,
+                         "SC bit is set, but not in the global SCLAB");
+}
+
 static int zipl_load_signature(ComponentEntry *entry, uint64_t sig)
 {
     if (entry->compdat.sig_info.format != DER_SIGNATURE_FORMAT) {
@@ -269,6 +425,8 @@ int zipl_run_secure(ComponentEntry **entry_ptr, uint8_t *tmp_sec,
     uint8_t *tmp_buf;
     bool verified;
     bool signed_found = false;
+    bool sclab_found = false;
+    SclaBlock *global_sclab = NULL;
 
     if ((MAX_SIGNED_COMP * CERT_BUF_MAX_LEN) > CERT_BUF_SIZE) {
         panic("Not enough memory to store certificates");
@@ -309,6 +467,10 @@ int zipl_run_secure(ComponentEntry **entry_ptr, uint8_t *tmp_sec,
 
             /* no signature present (unsigned component) */
             if (!sig_entry.len) {
+                zipl_secure_validate(comp_entry.addr >= S390_UNSIGNED_MIN_ADDR,
+                            &comp_entry.cei, S390_CEI_INVALID_UNSIGNED_ADDR,
+                            "Load address for unsigned component is less than 0x2000");
+
                 comp_list_add(comp_list, comp_entry);
                 break;
             }
@@ -320,6 +482,9 @@ int zipl_run_secure(ComponentEntry **entry_ptr, uint8_t *tmp_sec,
             comp_entry.flags = S390_IPL_DEV_COMP_FLAG_SC;
             signed_found = true;
 
+            check_sclab(&global_sclab, &comp_entry, &comp_list->ipl_info_header);
+            sclab_found |= !(comp_entry.cei & S390_CEI_INVALID_SCLAB);
+
             cert_entry = (IplSignatureCertificateEntry) { 0 };
             verified = verify_signature(comp_entry, sig_entry,
                                         &cert_entry.len, &cert_table_idx);
@@ -365,9 +530,17 @@ int zipl_run_secure(ComponentEntry **entry_ptr, uint8_t *tmp_sec,
         }
     }
 
-    if (!signed_found) {
-        zipl_secure_error("Secure boot is on, but components are not signed");
-    }
+    zipl_secure_validate(signed_found, &comp_list->ipl_info_header.iiei,
+                         S390_IIEI_NO_SIGNED_COMP,
+                         "Secure boot is on, but components are not signed");
+
+    zipl_secure_validate(sclab_found, &comp_list->ipl_info_header.iiei,
+                         S390_IIEI_NO_SCLAB, "No recognizable SCLAB");
+
+    comp_entry = (IplDeviceComponentEntry){ 0 };
+    comp_entry.addr = entry->compdat.load_psw;
+    check_global_sclab(global_sclab, &comp_entry, comp_list);
+    comp_list_add(comp_list, comp_entry);
 
     *entry_ptr = entry;
     free((void *)sig_entry.addr);
diff --git a/pc-bios/s390-ccw/secure-ipl.h b/pc-bios/s390-ccw/secure-ipl.h
index ae4bb8bc56..18313104fa 100644
--- a/pc-bios/s390-ccw/secure-ipl.h
+++ b/pc-bios/s390-ccw/secure-ipl.h
@@ -26,6 +26,33 @@ int zipl_run_secure(ComponentEntry **entry_ptr, uint8_t *tmp_sec,
                     IplSignatureCertificateList *cert_list,
                     uint8_t **tmp_cert_buf);
 
+#define S390_SCLAB_OPSW    0x8000   /* override PSW flag */
+#define S390_SCLAB_OLA     0x4000   /* override load address flag */
+#define S390_SCLAB_NUC     0x2000   /* no unsigned components flag */
+#define S390_SCLAB_SC      0x1000   /* single component flag */
+
+#define S390_SCLAB_MIN_LEN      32
+#define S390_UNSIGNED_MIN_ADDR  0x2000
+
+/* Secure Code Loading Attributes Block */
+struct SclaBlock {
+    uint8_t  format;
+    uint8_t  reserved1;
+    uint16_t flags;
+    uint8_t  reserved2[4];
+    uint64_t load_psw;
+    uint64_t load_addr;
+    uint64_t reserved3[];
+} __attribute__ ((packed));
+typedef struct SclaBlock SclaBlock;
+
+struct SclabOriginLocator {
+    uint8_t reserved[2];
+    uint16_t len;
+    uint8_t magic[4];
+} __attribute__ ((packed));
+typedef struct SclabOriginLocator SclabOriginLocator;
+
 static inline void zipl_secure_error(const char *message)
 {
     switch (boot_mode) {
@@ -37,6 +64,30 @@ static inline void zipl_secure_error(const char *message)
     }
 }
 
+static inline void zipl_secure_validate_u16(bool condition, uint16_t *flags,
+                                            uint16_t flag, const char *message)
+{
+    if (!condition) {
+        *flags |= flag;
+        zipl_secure_error(message);
+    }
+}
+
+static inline void zipl_secure_validate_u32(bool condition, uint32_t *flags,
+                                            uint32_t flag, const char *message)
+{
+    if (!condition) {
+        *flags |= flag;
+        zipl_secure_error(message);
+    }
+}
+
+#define zipl_secure_validate(condition, flags, flag, message)   \
+    _Generic((flags),                                           \
+        uint16_t * : zipl_secure_validate_u16,                  \
+        uint32_t * : zipl_secure_validate_u32                   \
+    )(condition, flags, flag, message)
+
 static inline uint64_t _diag320(void *data, unsigned long subcode)
 {
     register unsigned long addr asm("0") = (unsigned long)data;
-- 
2.54.0


