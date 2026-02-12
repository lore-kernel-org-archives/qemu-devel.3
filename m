Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11337EEA84E
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Feb 2026 20:45:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vqdYK-0000xV-88; Thu, 12 Feb 2026 15:44:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zycai@linux.ibm.com>)
 id 1vqdYI-0000vF-CW; Thu, 12 Feb 2026 15:44:42 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zycai@linux.ibm.com>)
 id 1vqdYG-0007y3-Mb; Thu, 12 Feb 2026 15:44:42 -0500
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 61CATNBx2909620; Thu, 12 Feb 2026 20:44:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=YK26wOI8KJ8VL+HS6
 uBGdporIfQDPpN1DKk+mG4JcTo=; b=BaDScCPzdeo2vH/rJ21Z78zcsgMJzi9HT
 XnpLVE1r252cxwYJbYkGhKIHTNVqpY/+V6zlI+gj/OYfQXAdxDHWohIIsUE43a4t
 tE9e87WN6z28tH9AhfqjJvvK8yG/EBN2cT+woBSFHzC0+57cWXkAw92OCcfGXK2N
 ZRLo/cXuGie08rYL4mNl41w1/y0LXESxrIyWmKDi86UBtTaXdWLYCZPgqOCFDFuN
 x1L/zPGEp1aAmKBKiu6V89EQuIDXr/s9J0bPAekEZ38Ity8nACvwt6Us0P16iGKw
 bmviIEirbtOfZwbEQSoOglLptLRzNrT53RRLC2f2HQq1734r4Svgg==
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4c696ur4de-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 12 Feb 2026 20:44:36 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 61CI0dKS012626;
 Thu, 12 Feb 2026 20:44:35 GMT
Received: from smtprelay07.wdc07v.mail.ibm.com ([172.16.1.74])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4c6h7km15b-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 12 Feb 2026 20:44:35 +0000
Received: from smtpav06.wdc07v.mail.ibm.com (smtpav06.wdc07v.mail.ibm.com
 [10.39.53.233])
 by smtprelay07.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 61CKiXAC30999166
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 12 Feb 2026 20:44:34 GMT
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id D37BD5804E;
 Thu, 12 Feb 2026 20:44:33 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 1D91558055;
 Thu, 12 Feb 2026 20:44:32 +0000 (GMT)
Received: from fedora-workstation.ibmuc.com (unknown [9.61.112.15])
 by smtpav06.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Thu, 12 Feb 2026 20:44:32 +0000 (GMT)
From: Zhuoying Cai <zycai@linux.ibm.com>
To: thuth@redhat.com, berrange@redhat.com, richard.henderson@linaro.org,
 jrossi@linux.ibm.com, qemu-s390x@nongnu.org, qemu-devel@nongnu.org
Cc: david@kernel.org, walling@linux.ibm.com, jjherne@linux.ibm.com,
 pasic@linux.ibm.com, borntraeger@linux.ibm.com, farman@linux.ibm.com,
 mjrosato@linux.ibm.com, iii@linux.ibm.com, eblake@redhat.com,
 armbru@redhat.com, zycai@linux.ibm.com, alifm@linux.ibm.com,
 brueckner@linux.ibm.com
Subject: [PATCH v8 20/30] pc-bios/s390-ccw: Add signed component address
 overlap checks
Date: Thu, 12 Feb 2026 15:43:41 -0500
Message-ID: <20260212204352.1044699-21-zycai@linux.ibm.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260212204352.1044699-1-zycai@linux.ibm.com>
References: <20260212204352.1044699-1-zycai@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=YZiwJgRf c=1 sm=1 tr=0 ts=698e3bb4 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22 a=Mpw57Om8IfrbqaoTuvik:22
 a=GgsMoib0sEa3-_RKJdDe:22 a=VnNF1IyMAAAA:8 a=qRwRlr6pIYMFea3-13gA:9
X-Proofpoint-ORIG-GUID: wrI3Ng8RA4eD50_s36-k8Yj_18d5Xg1J
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjEyMDE1NyBTYWx0ZWRfX5T4i7JMxxQBE
 lkJyoNlRJJOoKpl89g3Vkr5P5WiERrjJy9yD1ljUTzN02GipoFONJD4JBSkQy4TMcWBstZeQfMn
 uCnp8bYGLTwg9ESskyrTDr8eqSBOoI5rsuY89D5tjcOzco+naAC/mVr1S2z2iwrKGM06Fqmpyw/
 YVuwquwDT1y3cv/sWSaZ47rbyc2wkiURdaVsHPBmAkCeBJ8BG+SHYTFMRcw1/ZTuKapK7HLn0Vv
 TcDXH0+n/sSCoTRgj/rZaw+pgP75YLn5rN776mf/44S8miHE2YvILrUNBqcw5zkG0OmGXg2ihwO
 gqWNy7789JHSg1GMCg3a8yESimniqQkRU5fYvYdgCn1igusgsYFXrUvnwMNLMHUfRpzKRV3WKSv
 NEhLx9xALhsTAqTYjoxVJlxGT8QMUDq5DFr2jAlno59JbbA8uPEZFDCz9Q0ZyFS4G7mBFVTj206
 DnJyjQRyd8FRK9EcpaQ==
X-Proofpoint-GUID: wrI3Ng8RA4eD50_s36-k8Yj_18d5Xg1J
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

Add address range tracking and overlap checks to ensure that no
component overlaps with a signed component during secure IPL.

Signed-off-by: Zhuoying Cai <zycai@linux.ibm.com>
---
 pc-bios/s390-ccw/secure-ipl.c | 54 +++++++++++++++++++++++++++++++++++
 pc-bios/s390-ccw/secure-ipl.h |  6 ++++
 2 files changed, 60 insertions(+)

diff --git a/pc-bios/s390-ccw/secure-ipl.c b/pc-bios/s390-ccw/secure-ipl.c
index 1d5c2d40ce..27d2833642 100644
--- a/pc-bios/s390-ccw/secure-ipl.c
+++ b/pc-bios/s390-ccw/secure-ipl.c
@@ -210,6 +210,55 @@ static void init_lists(IplDeviceComponentList *comp_list,
     cert_list->ipl_info_header.len = sizeof(cert_list->ipl_info_header);
 }
 
+static bool is_comp_overlap(SecureIplCompAddrRange *comp_addr_range,
+                            int addr_range_index,
+                            uint64_t start_addr, uint64_t end_addr)
+{
+    /* neither a signed nor an unsigned component can overlap with a signed component */
+    for (int i = 0; i < addr_range_index; i++) {
+        if ((comp_addr_range[i].start_addr < end_addr &&
+            start_addr < comp_addr_range[i].end_addr) &&
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
+    if (addr_range_index >= MAX_CERTIFICATES) {
+        printf("Warning: Ignoring component address range index [%d]"
+               " because the maximum supported index is %d\n",
+               addr_range_index, MAX_CERTIFICATES - 1);
+        return;
+    }
+
+    comp_addr_range[addr_range_index].is_signed = is_signed;
+    comp_addr_range[addr_range_index].start_addr = start_addr;
+    comp_addr_range[addr_range_index].end_addr = end_addr;
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
+    if (overlap) {
+        zipl_secure_handle("Component addresses overlap");
+    }
+
+    comp_addr_range_add(comp_addr_range, *addr_range_index, is_signed,
+                        start_addr, end_addr);
+    *addr_range_index += 1;
+}
+
 static int zipl_load_signature(ComponentEntry *entry, uint64_t sig_sec)
 {
     if (zipl_load_segment(entry, sig_sec) < 0) {
@@ -253,6 +302,8 @@ int zipl_run_secure(ComponentEntry **entry_ptr, uint8_t *tmp_sec)
      * exists for the certificate).
      */
     int cert_list_table[MAX_CERTIFICATES] = { [0 ... MAX_CERTIFICATES - 1] = -1 };
+    SecureIplCompAddrRange comp_addr_range[MAX_CERTIFICATES];
+    int addr_range_index = 0;
     int signed_count = 0;
 
     if (!secure_ipl_supported()) {
@@ -282,6 +333,9 @@ int zipl_run_secure(ComponentEntry **entry_ptr, uint8_t *tmp_sec)
                 goto out;
             }
 
+            addr_overlap_check(comp_addr_range, &addr_range_index,
+                               comp_addr, comp_addr + comp_len, sig_len > 0);
+
             if (!sig_len) {
                 break;
             }
diff --git a/pc-bios/s390-ccw/secure-ipl.h b/pc-bios/s390-ccw/secure-ipl.h
index eb5ba0ed47..69edfce241 100644
--- a/pc-bios/s390-ccw/secure-ipl.h
+++ b/pc-bios/s390-ccw/secure-ipl.h
@@ -16,6 +16,12 @@
 VCStorageSizeBlock *zipl_secure_get_vcssb(void);
 int zipl_run_secure(ComponentEntry **entry_ptr, uint8_t *tmp_sec);
 
+typedef struct SecureIplCompAddrRange {
+    bool is_signed;
+    uint64_t start_addr;
+    uint64_t end_addr;
+} SecureIplCompAddrRange;
+
 static inline void zipl_secure_handle(const char *message)
 {
     switch (boot_mode) {
-- 
2.52.0


