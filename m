Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93EBEFF8855
	for <qemu-devel@archiver.kernel.org>; Tue,  5 May 2026 20:22:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wKMFi-00010x-5D; Tue, 05 May 2026 16:20:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zycai@linux.ibm.com>)
 id 1wKMFc-0000YG-T0; Tue, 05 May 2026 16:20:16 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zycai@linux.ibm.com>)
 id 1wKMFa-0000Jl-P1; Tue, 05 May 2026 16:20:16 -0400
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 645EYhBe1105811; Tue, 5 May 2026 20:19:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=HNYxZnCJCo9ZIXZpG
 Ks+l+hALoNGl093Esyq4xS6QDg=; b=L19YUfszlfXu/GEd2GVS0JUDJ4TrGmUxE
 8TQTl4ZuYr1owDtQBPuVSl8r6mQfHKQ+YgYfot9mGflVRqy33gNt17Nzo+cA7rYW
 /ArAZdnn8GQIhdi6JqTxxNZ5+fhgJBkfBW4sVViTwrqpDdO7bukANCBXmgH7soDh
 RvHieYM8arfvPZwp46amCf3sUJpu1BqUK5Ai8mb+/tR9Kwc51uf6YuwP0tSW9Zyz
 /HZ8tF053wZ4sSwmO9qyAoAekJfKtDWk+69+bVam5mENmthIatpUkMpTB9yi1OZX
 DEQPVKFp/vFUhf0uJ5AHOfSb6fQYxI5iy2eBgGpBFPqvKMLIWFOZQ==
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4dw9y4n72t-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 05 May 2026 20:19:49 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 645K9dGT030408;
 Tue, 5 May 2026 20:19:49 GMT
Received: from smtprelay03.wdc07v.mail.ibm.com ([172.16.1.70])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4dwwtgb53r-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 05 May 2026 20:19:49 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (smtpav02.wdc07v.mail.ibm.com
 [10.39.53.229])
 by smtprelay03.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 645KJK3l17302126
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 5 May 2026 20:19:20 GMT
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 8E5715805C;
 Tue,  5 May 2026 20:19:47 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id EF25958059;
 Tue,  5 May 2026 20:19:45 +0000 (GMT)
Received: from fedora-workstation.pok.ibm.com (unknown [9.12.79.241])
 by smtpav02.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Tue,  5 May 2026 20:19:45 +0000 (GMT)
From: Zhuoying Cai <zycai@linux.ibm.com>
To: qemu-s390x@nongnu.org, qemu-devel@nongnu.org
Cc: jrossi@linux.ibm.com, cohuck@redhat.com, berrange@redhat.com,
 richard.henderson@linaro.org, david@kernel.org, walling@linux.ibm.com,
 jjherne@linux.ibm.com, pasic@linux.ibm.com, borntraeger@linux.ibm.com,
 farman@linux.ibm.com, mjrosato@linux.ibm.com, iii@linux.ibm.com,
 eblake@redhat.com, armbru@redhat.com, zycai@linux.ibm.com,
 alifm@linux.ibm.com, brueckner@linux.ibm.com,
 pierrick.bouvier@oss.qualcomm.com, jdaley@linux.ibm.com
Subject: [PATCH v11 22/32] pc-bios/s390-ccw: Add signed component address
 overlap checks
Date: Tue,  5 May 2026 16:18:54 -0400
Message-ID: <20260505201905.997996-23-zycai@linux.ibm.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260505201905.997996-1-zycai@linux.ibm.com>
References: <20260505201905.997996-1-zycai@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTA1MDE5NSBTYWx0ZWRfX6tM6nnQ6tlgE
 5tpaMnzK8lxf4M2oca25NqSjlUmNgdvgb/rLwxAYztJZAfU0qXIk5tTGFAKz0DnZaB35pghBG1j
 idRZPONgZq5MoyhFXM4+q3FH1KIih2maeNPI5I7LU94halnHzCZVIld+vSIxRU9G6JadDBpOGwk
 B5t0TcSubG/557RVmfOVoFqfljS6V+oBs1gvRMlU7NY/aTGsc/tr5zQoVulMKic1dRb1p+EQrCl
 LCMm4LeE0wnBEuiPSzsBK/AN+pHNvNrLmBXWfqDxp2vFrfnrSj4TX0en8gOXiVJznYbfLcyX/QD
 w/kzUbQHo7Cgoh1IEcHcse3ZLMekQWTGMxSXGzXqdnxjWUybc5lwC6CpBnVYSvK2xMPotiJIz9E
 ozRUQIP3gnf/UV47lffj3a0G7nYQvx7aMr6wdvGsSZiX+WEST/O4juP4dT7kxYFxS9Zqpeo5Btu
 ccyAvKRd9sJW8AujpHA==
X-Authority-Analysis: v=2.4 cv=J4GaKgnS c=1 sm=1 tr=0 ts=69fa50e6 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8 a=id9pkdgl0szQWdF34qoA:9
X-Proofpoint-GUID: yhyLgwM0mj0WYkxINw1xsKaUoPT0Yqa1
X-Proofpoint-ORIG-GUID: yhyLgwM0mj0WYkxINw1xsKaUoPT0Yqa1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-05_02,2026-04-30_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 clxscore=1015 malwarescore=0 bulkscore=0 suspectscore=0
 priorityscore=1501 spamscore=0 phishscore=0 adultscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2605050195
Received-SPF: pass client-ip=148.163.158.5; envelope-from=zycai@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
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

Add address range tracking and overlap checks to ensure that no
component overlaps with a signed component during secure IPL.

Signed-off-by: Zhuoying Cai <zycai@linux.ibm.com>
---
 pc-bios/s390-ccw/secure-ipl.c | 49 +++++++++++++++++++++++++++++++++++
 pc-bios/s390-ccw/secure-ipl.h | 15 +++++++++++
 2 files changed, 64 insertions(+)

diff --git a/pc-bios/s390-ccw/secure-ipl.c b/pc-bios/s390-ccw/secure-ipl.c
index 6e943446a7..fdac74aa97 100644
--- a/pc-bios/s390-ccw/secure-ipl.c
+++ b/pc-bios/s390-ccw/secure-ipl.c
@@ -220,6 +220,51 @@ static void init_lists(IplDeviceComponentList *comp_list,
     cert_list->ipl_info_header.len = sizeof(IplInfoBlockHeader);
 }
 
+static void check_comp_overlap(SecureIplCompAddrRangeList *range_list,
+                               SecureIplCompEntryInfo comp_entry_info)
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
+    for (int i = 0; i < range_list->num; i++) {
+        if (range_list->comp_addr_range[i].is_signed &&
+            (range_list->comp_addr_range[i].start_addr < end_addr &&
+            start_addr < range_list->comp_addr_range[i].end_addr)) {
+            zipl_secure_error("Component addresses overlap");
+       }
+    }
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
+    if (range_list->num >= MAX_COMP_ENTRIES) {
+        zipl_secure_error("Component address range update failed due to out-of-range"
+                          " index; Overlapping validation cannot be guaranteed");
+        return;
+    }
+
+    range_list->comp_addr_range[range_list->num].is_signed = is_signed;
+    range_list->comp_addr_range[range_list->num].start_addr = start_addr;
+    range_list->comp_addr_range[range_list->num].end_addr = end_addr;
+
+    range_list->num += 1;
+}
+
 static int zipl_load_signature(ComponentEntry *entry, uint64_t sig)
 {
     if (entry->compdat.sig_info.format != DER_SIGNATURE_FORMAT) {
@@ -261,6 +306,7 @@ int zipl_run_secure(ComponentEntry **entry_ptr, uint8_t *tmp_sec)
      * exists for the certificate).
      */
     int cert_list_table[MAX_CERTIFICATES] = { [0 ... MAX_CERTIFICATES - 1] = -1 };
+    SecureIplCompAddrRangeList range_list = { 0 };
     int signed_count = 0;
 
     init_lists(&comp_list, &cert_list);
@@ -292,6 +338,9 @@ int zipl_run_secure(ComponentEntry **entry_ptr, uint8_t *tmp_sec)
             comp_entry_info.addr = comp_addr;
             comp_entry_info.len = (uint64_t)comp_len;
 
+            check_comp_overlap(&range_list, comp_entry_info);
+            comp_addr_range_add(&range_list, comp_entry_info, !!sig_len);
+
             /* no signature present (unsigned component) */
             if (!sig_entry_info.len) {
                 break;
diff --git a/pc-bios/s390-ccw/secure-ipl.h b/pc-bios/s390-ccw/secure-ipl.h
index cc0302f56b..29bbf65c6c 100644
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
+ * Tracks up to MAX_COMP_ENTRIES address ranges with an num counter.
+ */
+typedef struct SecureIplCompAddrRangeList {
+    SecureIplCompAddrRange comp_addr_range[MAX_COMP_ENTRIES];
+    int num;
+} SecureIplCompAddrRangeList;
+
 static inline void zipl_secure_error(const char *message)
 {
     switch (boot_mode) {
-- 
2.54.0


