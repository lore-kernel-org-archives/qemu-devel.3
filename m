Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6008BC02187
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jan 2025 21:33:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tYXTg-0002VT-A5; Thu, 16 Jan 2025 16:32:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>) id 1tYXTZ-0002VB-Qg
 for qemu-devel@nongnu.org; Thu, 16 Jan 2025 16:32:29 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>) id 1tYXTV-0004sT-EY
 for qemu-devel@nongnu.org; Thu, 16 Jan 2025 16:32:28 -0500
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50GENqAC004822;
 Thu, 16 Jan 2025 21:32:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=pp1; bh=09kZV23D1a3TV6BO1JW3uq3RNWBi
 siCDLTC3IqWmmUI=; b=Bv2uUnhYLtFaNLXwbNLcKURwzQ2Et+y+hHcjGJj5/yRs
 pkanlv+UzZ58N62Rdi0P766WVAo5KLtBCOMo+eBcuSh7vfSLM4bduAAWdpLfUWrz
 7PxAosBvo+IZ1HaRAn5DmLS5RsNPqOKlm03KbQjcoly427zFasXOuxOlbNO4gmtn
 Qgf13+bA+8A62ZzStDco3NrerX98ca+QJp8zb+eeUgoauz2w6jxffzh7xp0eI9hR
 yjfrcoE00ssVvyr5XVVWEKyyjkPqPUAIyTl2WGV8lTk01+meaFKngPmTlmCfbPvw
 5xEW6DqSRV8ejXvMqnUBidDM7/CNbKrQXdWK0WBdeQ==
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 446tkhcymv-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 16 Jan 2025 21:32:22 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 50GL5pQ4007385;
 Thu, 16 Jan 2025 21:32:21 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4443ynfv5b-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 16 Jan 2025 21:32:21 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com
 [10.20.54.104])
 by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 50GLWJra41222418
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 16 Jan 2025 21:32:19 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 2214020043;
 Thu, 16 Jan 2025 21:32:19 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id C050320040;
 Thu, 16 Jan 2025 21:32:18 +0000 (GMT)
Received: from heavy.ibm.com (unknown [9.171.62.46])
 by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Thu, 16 Jan 2025 21:32:18 +0000 (GMT)
From: Ilya Leoshkevich <iii@linux.ibm.com>
To: Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, Ilya Leoshkevich <iii@linux.ibm.com>
Subject: [PATCH v2 1/2] tcg: Document tb_lookup() and tcg_tb_lookup()
Date: Thu, 16 Jan 2025 22:31:32 +0100
Message-ID: <20250116213214.5695-1-iii@linux.ibm.com>
X-Mailer: git-send-email 2.47.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: C3YzpWdH8CHSs2dufFN2cgN2hHfzYfO9
X-Proofpoint-ORIG-GUID: C3YzpWdH8CHSs2dufFN2cgN2hHfzYfO9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-16_09,2025-01-16_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 spamscore=0
 priorityscore=1501 impostorscore=0 adultscore=0 mlxscore=0 clxscore=1015
 bulkscore=0 lowpriorityscore=0 mlxlogscore=999 phishscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2411120000
 definitions=main-2501160159
Received-SPF: pass client-ip=148.163.156.1; envelope-from=iii@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -44
X-Spam_score: -4.5
X-Spam_bar: ----
X-Spam_report: (-4.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H2=-1.797, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

These similarly named functions serve different purposes; add
docstrings to highlight them.

Suggested-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
---
 accel/tcg/cpu-exec.c | 15 ++++++++++++++-
 include/tcg/tcg.h    | 41 +++++++++++++++++++++++++++++++++++++++++
 2 files changed, 55 insertions(+), 1 deletion(-)

diff --git a/accel/tcg/cpu-exec.c b/accel/tcg/cpu-exec.c
index d48b82a9325..8b773d88478 100644
--- a/accel/tcg/cpu-exec.c
+++ b/accel/tcg/cpu-exec.c
@@ -249,7 +249,20 @@ static TranslationBlock *tb_htable_lookup(CPUState *cpu, vaddr pc,
     return qht_lookup_custom(&tb_ctx.htable, &desc, h, tb_lookup_cmp);
 }
 
-/* Might cause an exception, so have a longjmp destination ready */
+/**
+ * tb_lookup:
+ * @cpu: CPU that will execute the returned translation block
+ * @pc: guest PC
+ * @cs_base: arch-specific value associated with translation block
+ * @flags: arch-specific translation block flags
+ * @cflags: CF_* flags
+ *
+ * Look up a translation block inside the QHT using @pc, @cs_base, @flags and
+ * @cflags. Uses @cpu's tb_jmp_cache. Might cause an exception, so have a
+ * longjmp destination ready.
+ *
+ * Returns: an existing translation block or NULL.
+ */
 static inline TranslationBlock *tb_lookup(CPUState *cpu, vaddr pc,
                                           uint64_t cs_base, uint32_t flags,
                                           uint32_t cflags)
diff --git a/include/tcg/tcg.h b/include/tcg/tcg.h
index a77ed12b9dc..057df6c4599 100644
--- a/include/tcg/tcg.h
+++ b/include/tcg/tcg.h
@@ -746,10 +746,51 @@ void tcg_region_reset_all(void);
 size_t tcg_code_size(void);
 size_t tcg_code_capacity(void);
 
+/**
+ * tcg_tb_insert:
+ * @tb: translation block to insert
+ *
+ * Insert @tb into the region trees.
+ */
 void tcg_tb_insert(TranslationBlock *tb);
+
+/**
+ * tcg_tb_remove:
+ * @tb: translation block to remove
+ *
+ * Remove @tb from the region trees.
+ */
 void tcg_tb_remove(TranslationBlock *tb);
+
+/**
+ * tcg_tb_lookup:
+ * @tc_ptr: host PC to look up
+ *
+ * Look up a translation block inside the region trees by @tc_ptr. This is
+ * useful for exception handling, but must not be used for the purposes of
+ * executing the returned translation block. See struct tb_tc for more
+ * information.
+ *
+ * Returns: a translation block previously inserted into the region trees,
+ * such that @tc_ptr points anywhere inside the code generated for it, or
+ * NULL.
+ */
 TranslationBlock *tcg_tb_lookup(uintptr_t tc_ptr);
+
+/**
+ * tcg_tb_foreach:
+ * @func: callback
+ * @user_data: opaque value to pass to @callback
+ *
+ * Call @func for each translation block inserted into the region trees.
+ */
 void tcg_tb_foreach(GTraverseFunc func, gpointer user_data);
+
+/**
+ * tcg_nb_tbs:
+ *
+ * Returns: the number of translation blocks inserted into the region trees.
+ */
 size_t tcg_nb_tbs(void);
 
 /* user-mode: Called with mmap_lock held.  */
-- 
2.47.1


