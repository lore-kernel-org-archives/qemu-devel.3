Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07863D35662
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Jan 2026 07:43:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vl0Ch-0003wt-PS; Wed, 28 Jan 2026 02:43:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <3160104094@zju.edu.cn>)
 id 1vl0Ce-0003vM-Qh
 for qemu-devel@nongnu.org; Wed, 28 Jan 2026 02:43:04 -0500
Received: from zg8tmja2lje4os4yms4ymjma.icoremail.net ([206.189.21.223])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <3160104094@zju.edu.cn>) id 1vl0Ca-0004u2-TM
 for qemu-devel@nongnu.org; Wed, 28 Jan 2026 02:43:04 -0500
Received: from zju.edu.cn (unknown [183.129.171.42])
 by mtasvr (Coremail) with SMTP id _____wA3xYT2vXlpdGNPAA--.2454S3;
 Wed, 28 Jan 2026 15:42:47 +0800 (CST)
Received: from localhost.localdomain (unknown [183.129.171.42])
 by mail-app3 (Coremail) with SMTP id zS_KCgAnKGv1vXlp5c3vBQ--.64065S2;
 Wed, 28 Jan 2026 15:42:45 +0800 (CST)
From: Panda Jiang <3160104094@zju.edu.cn>
To: richard.henderson@linaro.org
Cc: 3160104094@zju.edu.cn,
	pbonzini@redhat.com,
	qemu-devel@nongnu.org
Subject: [PATCH v2] accel/tcg: Ensure get_page_addr_code_hostp nulls output on
 failure
Date: Wed, 28 Jan 2026 15:42:36 +0800
Message-Id: <20260128074236.49624-1-3160104094@zju.edu.cn>
X-Mailer: git-send-email 2.39.2 (Apple Git-143)
In-Reply-To: <459ffb4e-c831-4694-83f3-32ea610f72a2@linaro.org>
References: <459ffb4e-c831-4694-83f3-32ea610f72a2@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: zS_KCgAnKGv1vXlp5c3vBQ--.64065S2
X-CM-SenderInfo: qtrwiiiquqmko62m3hxhgxhubq/
X-CM-DELIVERINFO: =?B?cnXFWQXKKxbFmtjJiESix3B1w3sL8hBMFUTpd3cX36+dE6DPAN7iCt/gLhxLJ5hnLg
 Kjdb2keJFfieWsS/AIcxKcp+f8SKah7Cx7RCdQdLDQXMtEeU9TqjNTKLwd/05fvCJg+4Hq
 fCqcr0kzqGxMr+gy/nQ+NlUreqKaTfCGU1ZYsmm5
X-Coremail-Antispam: 1Uk129KBj93XoW7AFy8Xw1kArW5JF4kAF47Awc_yoW8WF13p3
 9Igr4DKasrJw1Iyw1xJa1xu3WY9w45JFZrWw1rKws093Z3Xr1vqw4vkay29FZ7WrWrX3y3
 JF4avw47ZFWUA3gCm3ZEXasCq-sJn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7ZEXa
 sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
 0xBIdaVrnRJUUU9lb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
 IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
 e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
 0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AK
 xVW0oVCq3wAac4AC62xK8xCEY4vEwIxC4wAS0I0E0xvYzxvE52x082IY62kv0487Mc804V
 CY07AIYIkI8VC2zVCFFI0UMc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AK
 xVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48Icx
 kI7VAKI48JM4x0Y48IcxkI7VAKI48G6xCjnVAKz4kxMxAIw28IcxkI7VAKI48JMxC20s02
 6xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_Jr
 I_JrWlx4CE17CEb7AF67AKxVWUAVWUtwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v2
 6r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw20EY4v20xvaj4
 0_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVWUJVW8
 JbIYCTnIWIevJa73UjIFyTuYvjxU2LIDUUUUU
Received-SPF: pass client-ip=206.189.21.223;
 envelope-from=3160104094@zju.edu.cn;
 helo=zg8tmja2lje4os4yms4ymjma.icoremail.net
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_MSPIKE_H3=0.001,
 RCVD_IN_MSPIKE_WL=0.001, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

In tb_gen_code(), get_page_addr_code_hostp() is called to get a host
mapping for a guest PC. If the function fails (e.g., for an I/O region)
and returns -1, it previously left its output pointer parameter
('host_pc' in the caller) unmodified.

If the caller's variable was uninitialized, this leads to undefined
behavior when it is later used, for example in setjmp_gen_code(). This
was observed as a segmentation fault when running QEMU with the
'-d in_asm' logging option when mmu translation fails.

As suggested by Richard Henderson, fix this within get_page_addr_code_hostp()
itself rather than in the caller. Ensure that in all failure paths where -1
is returned, the output pointer is explicitly set to NULL.

Signed-off-by: Panda Jiang <3160104094@zju.edu.cn>
---
+ Changes in v2:
+ - Moved the fix from the caller (tb_gen_code) to the callee
+   (get_page_addr_code_hostp).
+ - Set the output pointer to NULL on failure paths inside
+   get_page_addr_code_hostp, as suggested.
+ - Updated commit message to reflect the new approach.
+
 accel/tcg/cputlb.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/accel/tcg/cputlb.c b/accel/tcg/cputlb.c
index 6900a12682..6d7cfd2b5a 100644
--- a/accel/tcg/cputlb.c
+++ b/accel/tcg/cputlb.c
@@ -1543,6 +1543,10 @@ tb_page_addr_t get_page_addr_code_hostp(CPUArchState *env, vaddr addr,
     CPUTLBEntryFull *full;
     void *p;
 
+    if (hostp) {
+        *hostp = NULL;
+    }
+
     (void)probe_access_internal(env_cpu(env), addr, 1, MMU_INST_FETCH,
                                 cpu_mmu_index(env_cpu(env), true), false,
                                 &p, &full, 0, false);
-- 
2.39.2 (Apple Git-143)


