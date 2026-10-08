Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C35CCCA6011
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Oct 2026 17:25:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xErra-00011U-RO; Thu, 08 Oct 2026 13:25:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andy0x48@linux.ibm.com>)
 id 1xEqIx-00073j-0E; Thu, 08 Oct 2026 11:45:11 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andy0x48@linux.ibm.com>)
 id 1xEqIv-00023c-CH; Thu, 08 Oct 2026 11:45:10 -0400
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 698EZNpg1578199; Thu, 8 Oct 2026 15:45:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=pp1; bh=AULcUfuSy1hdbWKBZZlH7SIOAgQxL90v7S4mEM2SC
 k0=; b=KKNkPkYGPoKltgdfMMiZmp2rRJ9dVAmVf/N8UkQpCecph6ZIewnLuHOd9
 sWBu6QIvxKpzCVJdbn7+D6FKRSqTSJNGEW3rvKB+u1Ee9OPGd0WGafN/wta3b7GE
 EBjuVrvP15yMiXik5UMLi5pezeckl7m+kVMCgtx5W8Hgc2tm/8NkGhgDsY91Xw2o
 eqIlJYoxl1G5ZCJ6821n50DNMmdKU9/jbDn+/atnnohlrB5sdbj7/cp2sDLwnclE
 ZIb/0CnDvnB/jVUbO1j8P8TT1OHPP8lb7sJ8TPm3RMAuLDFnC81fejU/aZas37aR
 PDFqQ9uYxcDJIBT/hwrT6SfZEY3EQ==
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4h5xjvcsfv-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Thu, 08 Oct 2026 15:45:02 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id
 698EXfJs3632381; Thu, 8 Oct 2026 15:45:01 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4h5a6dqs2w-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 08 Oct 2026 15:45:01 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com
 [10.20.54.105])
 by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 698FiwF654460892
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 8 Oct 2026 15:44:58 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 0BAD720049;
 Thu,  8 Oct 2026 15:44:58 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 52D802004B;
 Thu,  8 Oct 2026 15:44:57 +0000 (GMT)
Received: from li-4c4c4544-0051-4610-8046-b1c04f514634.ibm.com (unknown
 [9.111.72.43]) by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Thu,  8 Oct 2026 15:44:57 +0000 (GMT)
From: Andrew Holden <andy0x48@linux.ibm.com>
To: qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, iii@linux.ibm.com, richard.henderson@linaro.org,
 david@kernel.org, cohuck@redhat.com, freude@linux.ibm.com,
 Andrew Holden <andy0x48@linux.ibm.com>
Subject: [PATCH] target/s390x/tcg: fix register update on guest memory fault
 in cpacf_aes_ecb
Date: Thu,  8 Oct 2026 16:44:55 +0100
Message-ID: <20261008154455.369004-1-andy0x48@linux.ibm.com>
X-Mailer: git-send-email 2.56.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: xt_wqZIJJLD8gWtF4r-KedNoq-L5e_Sz
X-Proofpoint-ORIG-GUID: xt_wqZIJJLD8gWtF4r-KedNoq-L5e_Sz
X-Authority-Analysis: v=2.4 cv=H8NOUOYi c=1 sm=1 tr=0 ts=6ac7ba7e cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8 a=r6Tt9g7xu0lz_p5kHnAA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA4MDA2MiBTYWx0ZWRfX45sj1B/0Rgpw
 QPXRicdMf5FHk/lETRsC5+gJP6nphXZnnrESOhczsuWU5sGf4AIW2sZLi4cDaaKsWObapOCBP6o
 Za3ncxJF4Oi+R0uY4+jk1odcqt0ojjMRo2TcC/bYzZBXrMgNQAH7pI8gWuYPVWwlGDpTVg4VfNn
 jkhlV5D50oSYzyLuIniw365fK1dqbuAUvLuJyTwsqTPKqO8DH4Q3FFl2ymd62j+FDyxByqoEoGU
 iHEd7M5kzNuUHyavkFBeCqnM3fSNZ4GuFIy+Mo/4HejpPyHHY+I7Sw1VdzTMAdIqzsxJv7wHq8M
 YZSb37Jzq9g+lhd5j4GDPANeFIVY8CQoA58jM5NVmjzFIGG19bsYOihXGHA169ZjhvbRJpPQBVE
 zfzpoF3ugcsPRLOfUUvdSw1hWSDR5PxFSir7c4nkcKHme+9UNSg67L0eUg8nUobQeQMe53OHabK
 4n628sVLfrrevXvo4rg==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA4MDA2MiBTYWx0ZWRfX5fzkAOTdSUA2
 yiOLiyCeFOS6sWmPZLBFf7q6pxxvF3Tl+jD0MyDM4/1yxjS6QzLZfUJLXardjwcnhV0tXiKJ5Y4
 xoIkzTufdmoHTGuRjJK32HdJDc+oWBw=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-08_05,2026-10-08_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 adultscore=0 phishscore=0 lowpriorityscore=0 impostorscore=0
 clxscore=1011 spamscore=0 priorityscore=1501 malwarescore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610020000 definitions=main-2610080062
Received-SPF: pass client-ip=148.163.156.1;
 envelope-from=andy0x48@linux.ibm.com; helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Thu, 08 Oct 2026 13:25:01 -0400
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

The KM instruction loop in cpacf_aes_ecb() updated the source pointer,
destination pointer, and length registers only after the entire loop
completed, using a 'done' accumulator. If a guest memory access fault
fires mid-loop, siglongjmp unwinds the C stack before the register
update is reached. The registers then reflect block 0 rather than the
block being processed, causing the instruction to restart from the
beginning on every fault. This results in quadratic reprocessing and
violates the PoP requirement that registers reflect partial completion
per block processed.

Fix this by updating the registers inside the loop body after each
successfully processed block, and removing the 'done' accumulator.

Signed-off-by: Andrew Holden <andy0x48@linux.ibm.com>
---
 target/s390x/tcg/cpacf_aes.c | 18 ++++++++----------
 1 file changed, 8 insertions(+), 10 deletions(-)

diff --git a/target/s390x/tcg/cpacf_aes.c b/target/s390x/tcg/cpacf_aes.c
index 92884c4120..41ebc57087 100644
--- a/target/s390x/tcg/cpacf_aes.c
+++ b/target/s390x/tcg/cpacf_aes.c
@@ -62,7 +62,7 @@ int cpacf_aes_ecb(CPUS390XState *env, const int mmu_idx, uintptr_t ra,
 {
     enum { MAX_BLOCKS_PER_RUN = 8192 / AES_BLOCK_SIZE };
     uint8_t in[AES_BLOCK_SIZE], out[AES_BLOCK_SIZE];
-    uint64_t len = *src_len_reg, done = 0;
+    uint64_t len = *src_len_reg;
     int i, keysize, addr_reg_size;
     uint8_t key[32];
     AES_KEY exkey;
@@ -116,23 +116,21 @@ int cpacf_aes_ecb(CPUS390XState *env, const int mmu_idx, uintptr_t ra,
 
     /* process up to MAX_BLOCKS_PER_RUN aes blocks */
     for (i = 0; i < MAX_BLOCKS_PER_RUN && len >= AES_BLOCK_SIZE; i++) {
-        aes_read_block(env, mmu_idx, ra, *src_ptr_reg + done, in);
+        aes_read_block(env, mmu_idx, ra, *src_ptr_reg, in);
         if (mod) {
             AES_decrypt(in, out, &exkey);
         } else {
             AES_encrypt(in, out, &exkey);
         }
-        aes_write_block(env, mmu_idx, ra, *dst_ptr_reg + done, out);
+        aes_write_block(env, mmu_idx, ra, *dst_ptr_reg, out);
+        *src_ptr_reg = deposit64(*src_ptr_reg, 0, addr_reg_size,
+                                 *src_ptr_reg + AES_BLOCK_SIZE);
+        *dst_ptr_reg = deposit64(*dst_ptr_reg, 0, addr_reg_size,
+                                 *dst_ptr_reg + AES_BLOCK_SIZE);
+        *src_len_reg -= AES_BLOCK_SIZE;
         len -= AES_BLOCK_SIZE;
-        done += AES_BLOCK_SIZE;
     }
 
-    *src_ptr_reg = deposit64(*src_ptr_reg, 0, addr_reg_size,
-                             *src_ptr_reg + done);
-    *dst_ptr_reg = deposit64(*dst_ptr_reg, 0, addr_reg_size,
-                             *dst_ptr_reg + done);
-    *src_len_reg -= done;
-
     return !len ? 0 : 3;
 }
 
-- 
2.56.0


