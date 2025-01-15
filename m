Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 999E9C02180
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jan 2025 23:21:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tYCgj-00080I-Cq; Wed, 15 Jan 2025 18:20:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>) id 1tYCgf-000803-5m
 for qemu-devel@nongnu.org; Wed, 15 Jan 2025 18:20:37 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>) id 1tYCgd-0003dY-KJ
 for qemu-devel@nongnu.org; Wed, 15 Jan 2025 18:20:36 -0500
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50FHX4iC024068;
 Wed, 15 Jan 2025 23:20:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=pp1; bh=HbxI+QiiaARw4OuL3n6af2R2FAqDIIf5w54NMFwCw
 4U=; b=TnWqo3EHgAsuLvD7+Jkq657XHnlw5+N27InOVesNVW3p7HFFOH3s2qesr
 zIGC6QmJFc9zCEfTVyRFckysTcof4N5Y/8QzRpFE0PUV+uotPMXpXwOLycqiH7PM
 qCS/NudzexaE0eJedC24llHHB5X8GhyE1xnB2Syj0ROzrFK6Rg4pE7GEqG8nHVgL
 iTtErqKRT+X1vzWa7NqG7zv3CaWTv/MNKRFHs5G9xHU+ixQ2crVFxesJTrGKE6sU
 BhnbBqme8nwIKQQOKmRaq7dfikjTQnGcb26as/Fo1/PH8u9TDUvXiO9WyNd8DckX
 NMMtZ4AzTSg9QI/N9CtysO6BUqNrA==
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 44697342jt-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 15 Jan 2025 23:20:32 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 50FLUAp2017359;
 Wed, 15 Jan 2025 23:20:31 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4444fkau59-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 15 Jan 2025 23:20:31 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com
 [10.20.54.102])
 by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 50FNKRgP26804526
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 15 Jan 2025 23:20:27 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id A7CB320043;
 Wed, 15 Jan 2025 23:20:27 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 63BCC20040;
 Wed, 15 Jan 2025 23:20:27 +0000 (GMT)
Received: from heavy.ibm.com (unknown [9.171.76.104])
 by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Wed, 15 Jan 2025 23:20:27 +0000 (GMT)
From: Ilya Leoshkevich <iii@linux.ibm.com>
To: Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, Ilya Leoshkevich <iii@linux.ibm.com>,
 Nina Schoetterl-Glausch <nsg@linux.ibm.com>
Subject: [PATCH] accel/tcg: Call tcg_tb_insert() for one-insn TBs
Date: Thu, 16 Jan 2025 00:20:19 +0100
Message-ID: <20250115232022.27332-1-iii@linux.ibm.com>
X-Mailer: git-send-email 2.47.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: S_umNTJmiIJXq99TXwX57q3kGmXZjryg
X-Proofpoint-GUID: S_umNTJmiIJXq99TXwX57q3kGmXZjryg
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-15_10,2025-01-15_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxscore=0 bulkscore=0
 malwarescore=0 adultscore=0 priorityscore=1501 phishscore=0 clxscore=1015
 suspectscore=0 spamscore=0 impostorscore=0 lowpriorityscore=0
 mlxlogscore=827 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2501150165
Received-SPF: pass client-ip=148.163.158.5; envelope-from=iii@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -44
X-Spam_score: -4.5
X-Spam_bar: ----
X-Spam_report: (-4.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H2=-1.793, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Currently single-insn TBs created from I/O memory are not added to
region_trees. Therefore, when they generate exceptions, they are not
handled by cpu_restore_state_from_tb(). For x86 this is not a problem,
because x86_restore_state_to_opc() only restores pc and cc, which are
already correct. However, on several other architectures,
restore_state_to_opc() restores more registers, and guests can notice
incorrect values.

Fix by always calling tcg_tb_insert(). This may increase the size of
region_trees, but tcg_region_reset_all() clears it once code_gen_buffer
fills up, so it will not grow uncontrollably.

Co-developed-by: Nina Schoetterl-Glausch <nsg@linux.ibm.com>
Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
---
 accel/tcg/translate-all.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/accel/tcg/translate-all.c b/accel/tcg/translate-all.c
index 453eb20ec95..6333302813e 100644
--- a/accel/tcg/translate-all.c
+++ b/accel/tcg/translate-all.c
@@ -531,23 +531,23 @@ TranslationBlock *tb_gen_code(CPUState *cpu,
         tb_reset_jump(tb, 1);
     }
 
+    /*
+     * Insert TB into the corresponding region tree before publishing it
+     * through QHT. Otherwise rewinding happened in the TB might fail to
+     * lookup itself using host PC.
+     */
+    tcg_tb_insert(tb);
+
     /*
      * If the TB is not associated with a physical RAM page then it must be
      * a temporary one-insn TB, and we have nothing left to do. Return early
-     * before attempting to link to other TBs or add to the lookup table.
+     * before attempting to link to other TBs.
      */
     if (tb_page_addr0(tb) == -1) {
         assert_no_pages_locked();
         return tb;
     }
 
-    /*
-     * Insert TB into the corresponding region tree before publishing it
-     * through QHT. Otherwise rewinding happened in the TB might fail to
-     * lookup itself using host PC.
-     */
-    tcg_tb_insert(tb);
-
     /*
      * No explicit memory barrier is required -- tb_link_page() makes the
      * TB visible in a consistent state.
-- 
2.47.1


