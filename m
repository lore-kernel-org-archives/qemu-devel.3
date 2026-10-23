Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65CA2606A31A
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Oct 2026 02:14:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xK4nI-0002uI-FN; Thu, 22 Oct 2026 22:14:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wang.yechao255@zte.com.cn>)
 id 1xK4nG-0002tU-CU; Thu, 22 Oct 2026 22:14:06 -0400
Received: from mxhk.zte.com.cn ([160.30.148.34])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wang.yechao255@zte.com.cn>)
 id 1xK4nE-0000CG-6B; Thu, 22 Oct 2026 22:14:06 -0400
Received: from mse-fl1.zte.com.cn (unknown [10.5.228.132])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mxhk.zte.com.cn (FangMail) with ESMTPS id 4j9mm50z9zz5B0qc;
 Fri, 23 Oct 2026 10:13:57 +0800 (CST)
Received: from szxlzmapp03.zte.com.cn ([10.5.231.207])
 by mse-fl1.zte.com.cn with SMTP id 69N2Dq7G060442;
 Fri, 23 Oct 2026 10:13:52 +0800 (+08)
 (envelope-from wang.yechao255@zte.com.cn)
Received: from localhost.localdomain (unknown [10.234.74.162])
 by smtp (Zmail) with SMTP; Fri, 23 Oct 2026 10:13:53 +0800
X-Zmail-TransId: 3e816adac2e1026-69356
X-Zmail-LocalSMTP: 1
X-ZMAIL-USEORIGINALEMLTOOUTBOUND: 1
X-Zmail-RealSender: wang.yechao255@zte.com.cn
From: Wang Yechao <wang.yechao255@zte.com.cn>
To: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Chao Liu <chao.liu@processmission.com>
Cc: qemu-riscv@nongnu.org, qemu-devel@nongnu.org,
 Wang Yechao <wang.yechao255@zte.com.cn>,
 Xuemei Liu <liu.xuemei1@zte.com.cn>
Subject: [PATCH v4 4/4] target/riscv: Only save vmstate_debug when TCG is
 enabled
Date: Fri, 23 Oct 2026 10:12:30 +0800
Message-ID: <20261023021237.486091-5-wang.yechao255@zte.com.cn>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20261023021237.486091-1-wang.yechao255@zte.com.cn>
References: <20261023021237.486091-1-wang.yechao255@zte.com.cn>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
X-MAIL: mse-fl1.zte.com.cn 69N2Dq7G060442
X-TLS: YES
X-ENVELOPE-SENDER: wang.yechao255@zte.com.cn
X-SOURCE-IP: 10.5.228.132 unknown Fri, 23 Oct 2026 10:13:57 +0800
X-CLEAN: YES
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 6ADAC2E5.000/4j9mm50z9zz5B0qc
Received-SPF: pass client-ip=160.30.148.34;
 envelope-from=wang.yechao255@zte.com.cn; helo=mxhk.zte.com.cn
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_MSPIKE_H5=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Commit d45b9bc65515 ("target/riscv: move TCG only files to tcg subdir")
moved the TCG-only files into the tcg/ subdirectory, so env->tdataX is
now only allocated and valid when TCG is enabled.

However, cfg.debug is always true in riscv_cpu_properties, so
debug_needed() unconditionally returned true and the debug vmstate
subsection was always considered needed. On --disable-tcg builds the
corresponding fields are uninitialized, and attempting to save them
triggers an assertion failure in vmstate_save_state_v:

  qemu-system-riscv64: ../migration/vmstate.c:737:
  vmstate_save_state_v: Assertion `first_elem || !n_elems || !size' failed.

Fix this by making debug_needed() also require tcg_enabled(), so the
debug subsection is only saved when the TCG-only state actually exists.

Fixes: d45b9bc65515 ("target/riscv: move TCG only files to tcg subdir")
Signed-off-by: Wang Yechao <wang.yechao255@zte.com.cn>
---
 target/riscv/machine.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/riscv/machine.c b/target/riscv/machine.c
index 0de06e9588..c5f0261ba7 100644
--- a/target/riscv/machine.c
+++ b/target/riscv/machine.c
@@ -324,7 +324,7 @@ static bool debug_needed(void *opaque)
 {
     RISCVCPU *cpu = opaque;
 
-    return cpu->cfg.debug || cpu->cfg.ext_sdtrig;
+    return tcg_enabled() && (cpu->cfg.debug || cpu->cfg.ext_sdtrig);
 }
 
 static bool sdext_needed(void *opaque)
-- 
2.47.3


