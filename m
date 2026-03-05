Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED7EAF513E6
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Mar 2026 22:46:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vyHOn-0001HH-1u; Thu, 05 Mar 2026 17:42:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zycai@linux.ibm.com>)
 id 1vyHOl-0001Fc-Ab; Thu, 05 Mar 2026 17:42:27 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zycai@linux.ibm.com>)
 id 1vyHOj-000792-LU; Thu, 05 Mar 2026 17:42:27 -0500
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 625IapKN2517891; Thu, 5 Mar 2026 22:42:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=7BibOTBwTdwZqCXi9
 LlSG0HpdUL4Nqdxj1fRa54T7zc=; b=C9ZX8vOBPItnEPTSWqq+vy8/BXrfpeltk
 1fp05DFIuEX7ak6Z0TJzaaL0AGhy9VPs0noIQHlONGIAkllQjV4zDao4NuqcAK0Y
 Z8exR1ijwIrBWXG2C40fgh8CQjbDntYPQXFq/y4tWEbuzd6c1xgCfH2LWvn/+p+P
 5ibh+EL/McKxwGtH9mUKgpoBVYz2FAzqyv2mOXP/ZG8JBu2EAjmnz1J2Lcg05B+Q
 l4gkjvIlGaKQQKbrb1UKFCYz0Tkv6QYTFR9oPY7ISKawJHy5+1TKMZl8Eq7lM0Yj
 DmpLdFRWJGgpbmBDtawbDkx3lZOIvbba3Va0pC4f8k0enRqWQ0/7g==
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4cksrje0ps-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 05 Mar 2026 22:42:21 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 625JCudM008803;
 Thu, 5 Mar 2026 22:42:20 GMT
Received: from smtprelay04.dal12v.mail.ibm.com ([172.16.1.6])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4cmdd1n3st-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 05 Mar 2026 22:42:20 +0000
Received: from smtpav01.dal12v.mail.ibm.com (smtpav01.dal12v.mail.ibm.com
 [10.241.53.100])
 by smtprelay04.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 625MgJDs32113228
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 5 Mar 2026 22:42:19 GMT
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 46EBB58057;
 Thu,  5 Mar 2026 22:42:19 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 1531C58059;
 Thu,  5 Mar 2026 22:42:18 +0000 (GMT)
Received: from fedora-workstation.ibmuc.com (unknown [9.61.36.214])
 by smtpav01.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Thu,  5 Mar 2026 22:42:17 +0000 (GMT)
From: Zhuoying Cai <zycai@linux.ibm.com>
To: thuth@redhat.com, berrange@redhat.com, jrossi@linux.ibm.com,
 qemu-s390x@nongnu.org, qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org, pierrick.bouvier@linaro.org,
 david@kernel.org, walling@linux.ibm.com, jjherne@linux.ibm.com,
 pasic@linux.ibm.com, borntraeger@linux.ibm.com, farman@linux.ibm.com,
 mjrosato@linux.ibm.com, iii@linux.ibm.com, eblake@redhat.com,
 armbru@redhat.com, zycai@linux.ibm.com, alifm@linux.ibm.com,
 brueckner@linux.ibm.com, jdaley@linux.ibm.com
Subject: [PATCH v9 20/30] pc-bios/s390-ccw: Add signed component address
 overlap checks
Date: Thu,  5 Mar 2026 17:41:35 -0500
Message-ID: <20260305224146.664053-21-zycai@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260305224146.664053-1-zycai@linux.ibm.com>
References: <20260305224146.664053-1-zycai@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=Rp/I7SmK c=1 sm=1 tr=0 ts=69aa06cd cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8 a=qRwRlr6pIYMFea3-13gA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzA1MDE5NCBTYWx0ZWRfXxVw6mM+AjjUi
 hbBifduEsgrKfiE3fa0mO8t5yzlVgd8zlhfVmjl29rmv9dPTtPQwDxocNG5LrqvHrBAx00xyLtU
 +SjGSzcZynquJUG1+r4aVSYF8WGR3o70OviTnUrGZ8U2Zq3s1px8ul/MnO/cFSqsmfL8EOTYS+F
 NEDqugAJBOJBxdlNVy/zpMxpfLQ5jYDBRlG6JpC7lM1XfJKaM5Y1KSyDYO9sm7bqvlJZB820H0c
 WOEM18qCS8RWRhmoSp7u8fSzlcNgaCqo16eFK7Sxa6brz2GsS40wgxg5GvCUCfTmovjfTr1lFaU
 O9nVzDJsdLr0/HTNkFAYhfEAGGAfXUFEL2G5Mrw5lyMjK5UfdpejHswunHKhPJo89z7g0/58/G3
 3X/jfd794T9+dJQZkgDonKxdCWV2IYewwxabMT4KEAnX31QcmChxlUGObi9gdn4jUe24nk8qFzf
 KpXn/wLU/wSmSivPUYg==
X-Proofpoint-GUID: rR-_Es05I04tJW0ADJ_uYUgzl5Qljj22
X-Proofpoint-ORIG-GUID: rR-_Es05I04tJW0ADJ_uYUgzl5Qljj22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-05_06,2026-03-04_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 priorityscore=1501 spamscore=0 phishscore=0 adultscore=0
 bulkscore=0 clxscore=1015 impostorscore=0 malwarescore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2603050194
Received-SPF: pass client-ip=148.163.156.1; envelope-from=zycai@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
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

Add address range tracking and overlap checks to ensure that no
component overlaps with a signed component during secure IPL.

Signed-off-by: Zhuoying Cai <zycai@linux.ibm.com>
---
 pc-bios/s390-ccw/secure-ipl.c | 52 +++++++++++++++++++++++++++++++++++
 pc-bios/s390-ccw/secure-ipl.h |  6 ++++
 2 files changed, 58 insertions(+)

diff --git a/pc-bios/s390-ccw/secure-ipl.c b/pc-bios/s390-ccw/secure-ipl.c
index 8d281c1cea..68596491c5 100644
--- a/pc-bios/s390-ccw/secure-ipl.c
+++ b/pc-bios/s390-ccw/secure-ipl.c
@@ -211,6 +211,53 @@ static void init_lists(IplDeviceComponentList *comp_list,
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
+        zipl_secure_handle("Component address range update failed due to out-of-range"
+                           " index; Overlapping validation cannot be guaranteed");
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
@@ -254,6 +301,8 @@ int zipl_run_secure(ComponentEntry **entry_ptr, uint8_t *tmp_sec)
      * exists for the certificate).
      */
     int cert_list_table[MAX_CERTIFICATES] = { [0 ... MAX_CERTIFICATES - 1] = -1 };
+    SecureIplCompAddrRange comp_addr_range[MAX_CERTIFICATES];
+    int addr_range_index = 0;
     int signed_count = 0;
 
     if (!secure_ipl_supported()) {
@@ -283,6 +332,9 @@ int zipl_run_secure(ComponentEntry **entry_ptr, uint8_t *tmp_sec)
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
2.53.0


