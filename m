Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D4E8CCD1AB
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Oct 2025 09:28:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vCE4r-0005fV-J9; Fri, 24 Oct 2025 05:27:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vishalc@linux.ibm.com>)
 id 1vCE4g-0005dW-Hz; Fri, 24 Oct 2025 05:27:08 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vishalc@linux.ibm.com>)
 id 1vCE4d-0003oB-Aj; Fri, 24 Oct 2025 05:27:05 -0400
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59O8CXQ0017699;
 Fri, 24 Oct 2025 09:26:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=Po9Oy62d35SD6HCry
 EX++IVVu5myxcWtXc9PrKqtKfs=; b=AyUUW6eE4GfARQLEu4zunp2X8fAPvWlum
 9OnmYA0Ny2K+6zUNx5ef8naASOq75Fu3ZyEGDDgD0hOV2lz2YCyCyGHEDOlZHLLz
 evDbq6kKNpoNLJpMB3WvZYrG3McfdZrpnNYhtV0MimeVRVZi7xRmY3xnfbo1UZkV
 R6lzklD4HF0NkRG4s5hxTBZBYeRWjdNY+qn6hKX2nsJ3P4DHJDFoJ3zVRhd52E4M
 hwLkaUV5XbQmh4Q6C9tOZNnE3BoxgD8jBKB8i4Qw3MtViivI6QA3liMCOQfdMyo1
 UH/Q0TQrmGf1P6GmS2jyNEMwFxmvSY4q2vYy78jcX9X/ONu1o1i7w==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 49v30w5153-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 24 Oct 2025 09:26:59 +0000 (GMT)
Received: from m0356516.ppops.net (m0356516.ppops.net [127.0.0.1])
 by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 59O9Qxmd029892;
 Fri, 24 Oct 2025 09:26:59 GMT
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 49v30w514v-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 24 Oct 2025 09:26:59 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 59O5ZD0n032142;
 Fri, 24 Oct 2025 09:26:58 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 49vp7nabx2-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 24 Oct 2025 09:26:58 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com
 [10.20.54.105])
 by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 59O9QstK38994260
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 24 Oct 2025 09:26:54 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 4180F20049;
 Fri, 24 Oct 2025 09:26:54 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 92A8420040;
 Fri, 24 Oct 2025 09:26:51 +0000 (GMT)
Received: from vishalc-ibm.ibm.com (unknown [9.39.24.189])
 by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Fri, 24 Oct 2025 09:26:51 +0000 (GMT)
From: Vishal Chourasia <vishalc@linux.ibm.com>
To: adityag@linux.ibm.com, harshpb@linux.ibm.com, milesg@linux.ibm.com,
 npiggin@gmail.com, peter.maydell@linaro.org, alistair23@gmail.com,
 balaton@eik.bme.hu, qemu-devel@nongnu.org, qemu-ppc@nongnu.org,
 berrange@redhat.com
Cc: Vishal Chourasia <vishalc@linux.ibm.com>
Subject: [Patch v9 3/6] core/loader: improve error handling in image loading
 functions
Date: Fri, 24 Oct 2025 14:56:15 +0530
Message-ID: <20251024092616.1893092-6-vishalc@linux.ibm.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251024092616.1893092-2-vishalc@linux.ibm.com>
References: <20251024092616.1893092-2-vishalc@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: yZjHjJoxuiTLmS4M0kQny2Y7F5LTWwVs
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDE4MDAyMiBTYWx0ZWRfX6H72LNTnReH8
 a/QXXhVZKQbgUve9gVaKlwevBIWtUNA+9TE+ELF99apXU3lCvEbpOpheI2UVeZN/y6bG4EY8aVC
 wcX51NjJfmUjXeObyq5rxo+YK+q9E0sqq1ilZSvhzrxR7KoX9V3MEbu7rIvwMvIRP14JA7ncjEy
 y0SeY6nr2Aij+GW+xXyZyFN0ch95ZLR1bSj13CAeUecmqbEQBckh90C9rS7xUzL2+rDQrDqBxvo
 /XPhMKQk/DbXh9KhQxW/N91V5PvsS5Cv9kMvVHmSIjouwBr4zxAk0l2pqOXAw8PW/aOcQDG8Gh7
 5BhImg5D6ZyHE0ebNFy+PHSKOd7IGs47zF3uEANCLPwZym0SgNnunFoHx3RuXEuuCwpIVQS9utr
 NPnuS2OYvPVzomA9Cxfe06gEJI+3yg==
X-Authority-Analysis: v=2.4 cv=MIJtWcZl c=1 sm=1 tr=0 ts=68fb4663 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=VnNF1IyMAAAA:8
 a=6_wqFlELkqIZ2uQeFiMA:9 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-ORIG-GUID: 2MLcp4aHSzUiTcjKg87oIBuDjSa0WeJT
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-23_03,2025-10-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 spamscore=0 phishscore=0 lowpriorityscore=0 adultscore=0
 clxscore=1015 impostorscore=0 bulkscore=0 priorityscore=1501 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510180022
Received-SPF: pass client-ip=148.163.158.5; envelope-from=vishalc@linux.ibm.com;
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

Add error checking for lseek() failure and provide better error
messages when image loading fails, including filenames and addresses.

Signed-off-by: Vishal Chourasia <vishalc@linux.ibm.com>
---
 hw/core/loader.c | 16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

diff --git a/hw/core/loader.c b/hw/core/loader.c
index 7aca4989ef..48dd4e7b33 100644
--- a/hw/core/loader.c
+++ b/hw/core/loader.c
@@ -79,6 +79,10 @@ int64_t get_image_size(const char *filename, Error **errp)
     if (fd < 0)
         return -1;
     size = lseek(fd, 0, SEEK_END);
+    if (size < 0) {
+        error_setg_errno(errp, errno, "lseek failure: %s", filename);
+        return -1;
+    }
     close(fd);
     return size;
 }
@@ -129,14 +133,24 @@ ssize_t load_image_targphys_as(const char *filename,
                                hwaddr addr, uint64_t max_sz, AddressSpace *as,
                                Error **errp)
 {
+    ERRP_GUARD();
     ssize_t size;
 
     size = get_image_size(filename, errp);
-    if (size < 0 || size > max_sz) {
+    if (*errp) {
+        return -1;
+    }
+
+    if (size > max_sz) {
+        error_setg(errp, "%s exceeds maximum image size (%" PRIu64 " MiB)",
+                   filename, max_sz / MiB);
         return -1;
     }
+
     if (size > 0) {
         if (rom_add_file_fixed_as(filename, addr, -1, as) < 0) {
+            error_setg(errp, "could not load '%s' at %" HWADDR_PRIx,
+                       filename, addr);
             return -1;
         }
     }
-- 
2.51.0


