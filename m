Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D279606A31E
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Nov 2026 07:14:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xWTgJ-0004Ma-GU; Thu, 26 Nov 2026 02:14:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <maobibo@loongson.cn>)
 id 1xWTg9-000496-1u
 for qemu-devel@nongnu.org; Thu, 26 Nov 2026 02:14:03 -0500
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <maobibo@loongson.cn>) id 1xWTg3-0003Dr-Ea
 for qemu-devel@nongnu.org; Thu, 26 Nov 2026 02:13:59 -0500
Received: from loongson.cn (unknown [10.40.46.54])
 by gateway (Coremail) with SMTP id _____8DxztIm3Adr_iojAA--.33694S3;
 Thu, 26 Nov 2026 15:13:42 +0800 (CST)
Received: from fedora.loongson.cn (unknown [127.0.0.1])
 by front1 (Coremail) with SMTP id qMiowJCxtMwk3AdrwX03AA--.17808S3;
 Thu, 26 Nov 2026 15:13:41 +0800 (CST)
From: Bibo Mao <maobibo@loongson.cn>
To: Song Gao <17746591750@163.com>
Cc: Xianglai Li <lixianglai@loongson.cn>,
	qemu-devel@nongnu.org
Subject: [PATCH v3 17/18] target/loongarch: Call generic csrwr helper for part
 read-only bits
Date: Thu, 26 Nov 2026 15:14:39 +0800
Message-ID: <20261126071440.3293877-18-maobibo@loongson.cn>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261126071440.3293877-1-maobibo@loongson.cn>
References: <20261126071440.3293877-1-maobibo@loongson.cn>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qMiowJCxtMwk3AdrwX03AA--.17808S3
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj93XoW7Zr18JrWrAr1DAFyftw17CFX_yoW8XF17pr
 42kr15KrWUta97Cwn3uayFvF15Aws5Gw4IqanrJwnxZay5Jrs8Wa10qry2gFyUXF1FqF4F
 va1vv34vg3yFqagCm3ZEXasCq-sJn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7ZEXa
 sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
 0xBIdaVrnRJUUUk2b4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
 IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
 e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
 0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AK
 xVW8Jr0_Cr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2x26I8E6xACxx
 1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26rWY6Fy7McIj6I8E87Iv
 67AKxVW8JVWxJwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41l42xK82IYc2
 Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s02
 6x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1Y6r17MIIYrxkI7VAKI48JMIIF0x
 vE2Ix0cI8IcVAFwI0_Xr0_Ar1lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE
 42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVW8JVWxJwCI42IY6I8E87Iv6x
 kF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxUsZqXUUUUU
Received-SPF: pass client-ip=114.242.206.163; envelope-from=maobibo@loongson.cn;
 helo=mail.loongson.cn
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

If part and not all bit are writable, it shoud call generic csrwr
helper function. And there is wrmask in structure CSRInfo, the generic
csrwr helper can ignore read-only bits from the value of wrmask.

Signed-off-by: Bibo Mao <maobibo@loongson.cn>
---
 .../tcg/insn_trans/trans_privileged.c.inc      | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/target/loongarch/tcg/insn_trans/trans_privileged.c.inc b/target/loongarch/tcg/insn_trans/trans_privileged.c.inc
index d9fc8f2695..fc0d9d1b5b 100644
--- a/target/loongarch/tcg/insn_trans/trans_privileged.c.inc
+++ b/target/loongarch/tcg/insn_trans/trans_privileged.c.inc
@@ -72,6 +72,7 @@ static bool set_csr_trans_func(unsigned int csr_num, GenCSRRead readfn,
 static void init_csr_wrmask(void)
 {
     int i;
+    CSRInfo *csr;
     uint64_t romask;
 
     romask = R_CSR_MISC_RSV_MASK | R_CSR_MISC_RSV1_MASK;
@@ -104,6 +105,23 @@ static void init_csr_wrmask(void)
     for (i = 0; i < MAX_PERF_EVENTS; i++) {
         clear_csr_wrmask(LOONGARCH_CSR_PERFCTRL(i), romask);
     }
+
+    for (i = 0; i < LOONGARCH_CSR_MAX; i++) {
+        csr = get_csr(i);
+        if (!csr || (csr->flags & CSRFL_READONLY) || csr->writefn) {
+            continue;
+        }
+
+        if (csr->wrmask == MAKE_64BIT_MASK(0, 64)) {
+            continue;
+        }
+
+        if (csr_get_width(csr) == 32 && csr->wrmask == MAKE_64BIT_MASK(0, 32)) {
+            continue;
+        }
+
+        csr->writefn = (GenCSRFunc)gen_helper_csrwr;
+    }
 }
 
 #define SET_CSR_FUNC(NAME, read, write)                 \
-- 
2.54.0


