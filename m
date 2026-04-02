Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1DD0FD6AB17
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Apr 2026 22:17:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w8QKY-0000xw-TE; Thu, 02 Apr 2026 18:16:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zycai@linux.ibm.com>)
 id 1w8QKH-0000rL-2B; Thu, 02 Apr 2026 18:15:55 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zycai@linux.ibm.com>)
 id 1w8QKF-0004q7-8j; Thu, 02 Apr 2026 18:15:44 -0400
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 632LPfAp3092382; Thu, 2 Apr 2026 22:15:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=d8WRo04U2I5tc2ohS
 qBiyORmKOI9BWAEVb4AE66V5Q4=; b=bFSqP6AqBpdkH5K+Rq0Zknsm4fT9u3AO0
 npHcWD4Tl3fzfnq/TEhN8KWSEsCdmx0MU8gq1LjzSBepwKeaX001BUqN8YzvHIQl
 0sfdAcurk2R4mqANTnV2uom3URWWOpCb8ZMGQ6uBpTkPgTP5W+6dh64rESZPTwwu
 C7x1z4z/6XkqbHccY1vukLjqgjiyv4jnn4KyKYAydZih8BM61xL8JxRfMi/AmZ0/
 4DuiFylElwEQ5KXfgSXD0jptihpQgIcJ8HYXqAwWGIbnUxNQNJPWo5pbMZocdfYE
 GoiXJNxmIldangMxIJIJX7N0iUQ9RZuT5iLehK/+Kixo80lLG1R4Q==
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4d66nnxs9b-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 02 Apr 2026 22:15:39 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 632K2NG3005973;
 Thu, 2 Apr 2026 22:15:38 GMT
Received: from smtprelay05.dal12v.mail.ibm.com ([172.16.1.7])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4d6spyc0ym-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 02 Apr 2026 22:15:38 +0000
Received: from smtpav05.dal12v.mail.ibm.com (smtpav05.dal12v.mail.ibm.com
 [10.241.53.104])
 by smtprelay05.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 632MFbem26870214
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 2 Apr 2026 22:15:37 GMT
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 51E4A58067;
 Thu,  2 Apr 2026 22:15:37 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id CF95858056;
 Thu,  2 Apr 2026 22:15:35 +0000 (GMT)
Received: from fedora-workstation.ibmuc.com (unknown [9.61.183.185])
 by smtpav05.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Thu,  2 Apr 2026 22:15:35 +0000 (GMT)
From: Zhuoying Cai <zycai@linux.ibm.com>
To: qemu-s390x@nongnu.org, qemu-devel@nongnu.org
Cc: jrossi@linux.ibm.com, cohuck@redhat.com, berrange@redhat.com,
 richard.henderson@linaro.org, pierrick.bouvier@linaro.org,
 david@kernel.org, walling@linux.ibm.com, jjherne@linux.ibm.com,
 pasic@linux.ibm.com, borntraeger@linux.ibm.com, farman@linux.ibm.com,
 mjrosato@linux.ibm.com, iii@linux.ibm.com, eblake@redhat.com,
 armbru@redhat.com, zycai@linux.ibm.com, alifm@linux.ibm.com,
 brueckner@linux.ibm.com, jdaley@linux.ibm.com
Subject: [PATCH v10 20/30] pc-bios/s390-ccw: Add signed component address
 overlap checks
Date: Thu,  2 Apr 2026 18:14:42 -0400
Message-ID: <20260402221453.1602899-21-zycai@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260402221453.1602899-1-zycai@linux.ibm.com>
References: <20260402221453.1602899-1-zycai@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: W7GSplnZ2R6YcF0dhtEadSNNoWSUb556
X-Authority-Analysis: v=2.4 cv=KslAGGWN c=1 sm=1 tr=0 ts=69ceea8b cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8 a=id9pkdgl0szQWdF34qoA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDAyMDE5NSBTYWx0ZWRfX2MvMoL+m3A2+
 vsWADu7xeVK/YgtqMK8KlEQmS2o7oRcf1ApkX1B2SVLkpjS2d0vwV6hAVr9ucC/Zo8uo+fLfboS
 zb36mnoxT7AkGzINjxLOqA3aDh9tYVFRG21dow1aWlhWBFtVODvzpxPJlZ73dyTt/AlbuCkqbls
 MChg8UrsgSplOXTTFVhnyx8Sp2SYMbn7CIqoyCGwwrjO/zExioXb1fpizQ0vxuowfcPhz+xJmuS
 CKObG+1vfyZqLE+7LRlGv7SlafAoseWwvLy/IZpqodNA+Xg4DQI+J80qi2U8ECwPIUbC57JuQA0
 XSTRB1S5c52g+UlemIbBdjelasldsm2Pcxo5Qw8+EFaGhIQYrBVtjWoniyO2WVFMaJp83f6HyPJ
 SQPBMlzwBqBLrNbLQre+LH27jpVUil0LjfE9VFwzC1vvYhMYJBoC0/P7ZIYYh2aXjPG8BVYGw/X
 a7Dh7pKOMvJT01llzDg==
X-Proofpoint-ORIG-GUID: W7GSplnZ2R6YcF0dhtEadSNNoWSUb556
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-02_04,2026-04-02_05,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 lowpriorityscore=0 priorityscore=1501 suspectscore=0
 phishscore=0 adultscore=0 bulkscore=0 impostorscore=0 clxscore=1015
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2603050001
 definitions=main-2604020195
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
 pc-bios/s390-ccw/secure-ipl.c | 58 ++++++++++++++++++++++++++++++++---
 pc-bios/s390-ccw/secure-ipl.h | 15 +++++++++
 2 files changed, 69 insertions(+), 4 deletions(-)

diff --git a/pc-bios/s390-ccw/secure-ipl.c b/pc-bios/s390-ccw/secure-ipl.c
index b66ca9ca7e..d2079e19bc 100644
--- a/pc-bios/s390-ccw/secure-ipl.c
+++ b/pc-bios/s390-ccw/secure-ipl.c
@@ -211,6 +211,49 @@ static void init_lists(IplDeviceComponentList *comp_list,
     cert_list->ipl_info_header.len = sizeof(cert_list->ipl_info_header);
 }
 
+static bool is_comp_overlap(SecureIplCompAddrRangeList *range_list,
+                            SecureIplCompEntryInfo comp_entry_info)
+{
+    uint64_t start_addr;
+    uint64_t end_addr;
+
+    start_addr = comp_entry_info.addr;
+    end_addr = comp_entry_info.addr + comp_entry_info.len;
+
+    /*
+     * Check component's address range does not overlap with any
+     * signed component's address range.
+     */
+    for (int i = 0; i < range_list->index; i++) {
+        if ((range_list->comp_addr_range[i].start_addr < end_addr &&
+            start_addr < range_list->comp_addr_range[i].end_addr) &&
+            range_list->comp_addr_range[i].is_signed) {
+            return true;
+       }
+    }
+    return false;
+}
+
+static void comp_addr_range_add(SecureIplCompAddrRangeList *range_list,
+                                SecureIplCompEntryInfo comp_entry_info,
+                                bool is_signed)
+{
+    uint64_t start_addr;
+    uint64_t end_addr;
+
+    start_addr = comp_entry_info.addr;
+    end_addr = comp_entry_info.addr + comp_entry_info.len;
+
+    if (range_list->index >= MAX_CERTIFICATES) {
+        zipl_secure_handle("Component address range update failed due to out-of-range"
+                           " index; Overlapping validation cannot be guaranteed");
+    }
+
+    range_list->comp_addr_range[range_list->index].is_signed = is_signed;
+    range_list->comp_addr_range[range_list->index].start_addr = start_addr;
+    range_list->comp_addr_range[range_list->index].end_addr = end_addr;
+}
+
 static int zipl_load_signature(ComponentEntry *entry, uint64_t sig_sec)
 {
     if (zipl_load_segment(entry, sig_sec) < 0) {
@@ -253,6 +296,7 @@ int zipl_run_secure(ComponentEntry **entry_ptr, uint8_t *tmp_sec)
      * exists for the certificate).
      */
     int cert_list_table[MAX_CERTIFICATES] = { [0 ... MAX_CERTIFICATES - 1] = -1 };
+    SecureIplCompAddrRangeList range_list = { 0 };
     int signed_count = 0;
 
     if (!secure_ipl_supported()) {
@@ -282,14 +326,20 @@ int zipl_run_secure(ComponentEntry **entry_ptr, uint8_t *tmp_sec)
                 goto out;
             }
 
-            if (!sig_len) {
-                break;
-            }
-
             comp_entry_info = (SecureIplCompEntryInfo){ 0 };
             comp_entry_info.addr = comp_addr;
             comp_entry_info.len = (uint64_t)comp_len;
 
+            if (is_comp_overlap(&range_list, comp_entry_info)) {
+                zipl_secure_handle("Component addresses overlap");
+            }
+            comp_addr_range_add(&range_list, comp_entry_info, !!sig_len);
+            range_list.index += 1;
+
+            if (!sig_len) {
+                break;
+            }
+
             verified = verify_signature(comp_entry_info,
                                         sig_len, (uint64_t)sig,
                                         &cert_len, &cert_table_idx);
diff --git a/pc-bios/s390-ccw/secure-ipl.h b/pc-bios/s390-ccw/secure-ipl.h
index 6d65cd5596..c625ac2e3a 100644
--- a/pc-bios/s390-ccw/secure-ipl.h
+++ b/pc-bios/s390-ccw/secure-ipl.h
@@ -24,6 +24,21 @@ typedef struct SecureIplCompEntryInfo {
     uint8_t  flags;
 } SecureIplCompEntryInfo;
 
+typedef struct SecureIplCompAddrRange {
+    bool is_signed;
+    uint64_t start_addr;
+    uint64_t end_addr;
+} SecureIplCompAddrRange;
+
+/*
+ * Custom struct for managing a list of secure IPL component address ranges.
+ * Tracks up to MAX_CERTIFICATES address ranges with an index counter.
+ */
+typedef struct SecureIplCompAddrRangeList {
+    SecureIplCompAddrRange comp_addr_range[MAX_CERTIFICATES];
+    int index;
+} SecureIplCompAddrRangeList;
+
 static inline void zipl_secure_handle(const char *message)
 {
     switch (boot_mode) {
-- 
2.53.0


