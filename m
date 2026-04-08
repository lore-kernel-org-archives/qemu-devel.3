Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6003A10F9969
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Apr 2026 19:23:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wAYSy-0005iE-EF; Wed, 08 Apr 2026 15:21:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhiwei_liu@linux.alibaba.com>)
 id 1wAY3v-0006Bx-Md; Wed, 08 Apr 2026 14:55:39 -0400
Received: from out30-119.freemail.mail.aliyun.com ([115.124.30.119])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhiwei_liu@linux.alibaba.com>)
 id 1wATcO-0001IF-Dt; Wed, 08 Apr 2026 10:10:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linux.alibaba.com; s=default;
 t=1775657328; h=From:To:Subject:Date:Message-Id:MIME-Version;
 bh=7btD77cTka+EC1KtIs9mPj6vd0anECLAhodJnjQttdc=;
 b=TTSATh8QpBgLjz7ojaxiYOnEiJI+1kmhoXAsBKGzboZxtVCwwqhg82FowFYc36q9BYAt6NGH0e69QNMqzfESECbMBQGjyrTHPcTcVJjZfJyvVE675JwpaX7WxxUiGKqSlX0su/4JfvY65OGQSLnQkzsnef49vZFzt6o5ceXfNAM=
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R201e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=maildocker-contentspam033032089153;
 MF=zhiwei_liu@linux.alibaba.com; NM=1; PH=DS; RN=11; SR=0;
 TI=SMTPD_---0X0f.zj4_1775657327; 
Received: from localhost.localdomain(mailfrom:zhiwei_liu@linux.alibaba.com
 fp:SMTPD_---0X0f.zj4_1775657327 cluster:ay36) by smtp.aliyun-inc.com;
 Wed, 08 Apr 2026 22:08:48 +0800
From: LIU Zhiwei <zhiwei_liu@linux.alibaba.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, chao.liu.zevorn@gmail.com, palmer@dabbelt.com,
 alistair23@gmail.com, daniel.barboza@oss.qualcomm.com, liwei1518@gmail.com,
 LIU Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Huang Tao <eric.huang@linux.alibaba.com>,
 TANG Tiancheng <lyndra@linux.alibaba.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Subject: [PATCH v5 4/6] target/riscv: Implement SMMPT fence instructions
Date: Wed,  8 Apr 2026 22:06:33 +0800
Message-Id: <20260408140635.42546-5-zhiwei_liu@linux.alibaba.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
In-Reply-To: <20260408140635.42546-1-zhiwei_liu@linux.alibaba.com>
References: <20260408140635.42546-1-zhiwei_liu@linux.alibaba.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=115.124.30.119;
 envelope-from=zhiwei_liu@linux.alibaba.com;
 helo=out30-119.freemail.mail.aliyun.com
X-Spam_score_int: -174
X-Spam_score: -17.5
X-Spam_bar: -----------------
X-Spam_report: (-17.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, ENV_AND_HDR_SPF_MATCH=-0.5,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 UNPARSEABLE_RELAY=0.001, USER_IN_DEF_DKIM_WL=-7.5,
 USER_IN_DEF_SPF_WL=-7.5 autolearn=ham autolearn_force=no
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

This patch completes the SMMPT implementation by adding support for the
new fence instructions: `mfence.spa` and `minval.spa`.

According to the specification, these instructions act as memory ordering
fences for MPT updates. In QEMU's TCG model, this is conservatively
implemented by flushing the entire TLB, which ensures that any subsequent
memory accesses will re-evaluate permissions and see the effects of any prior
MPT modifications.

The instructions are privileged and will cause an illegal instruction
exception if executed outside of M-mode.

Co-authored-by: Huang Tao <eric.huang@linux.alibaba.com>
Co-authored-by: TANG Tiancheng <lyndra@linux.alibaba.com>
Signed-off-by: LIU Zhiwei <zhiwei_liu@linux.alibaba.com>
Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
---
 target/riscv/insn32.decode                    |  2 ++
 .../riscv/insn_trans/trans_privileged.c.inc   | 30 +++++++++++++++++++
 2 files changed, 32 insertions(+)

diff --git a/target/riscv/insn32.decode b/target/riscv/insn32.decode
index 6e35c4b1e6..84cec57daf 100644
--- a/target/riscv/insn32.decode
+++ b/target/riscv/insn32.decode
@@ -120,6 +120,8 @@ sret        0001000    00010 00000 000 00000 1110011
 mret        0011000    00010 00000 000 00000 1110011
 wfi         0001000    00101 00000 000 00000 1110011
 sfence_vma  0001001    ..... ..... 000 00000 1110011 @sfence_vma
+mfence_spa  1000011    ..... ..... 000 00000 1110011 @sfence_vma
+minval_spa  0000011    ..... ..... 000 00000 1110011 @sfence_vma
 
 # *** NMI ***
 mnret       0111000    00010 00000 000 00000 1110011
diff --git a/target/riscv/insn_trans/trans_privileged.c.inc b/target/riscv/insn_trans/trans_privileged.c.inc
index 8a62b4cfcd..5ec6bf5991 100644
--- a/target/riscv/insn_trans/trans_privileged.c.inc
+++ b/target/riscv/insn_trans/trans_privileged.c.inc
@@ -160,3 +160,33 @@ static bool trans_sfence_vma(DisasContext *ctx, arg_sfence_vma *a)
 #endif
     return false;
 }
+
+#define REQUIRE_SMSDID(ctx) do {          \
+    if (!ctx->cfg_ptr->ext_smsdid) {      \
+        return false;                     \
+    }                                     \
+} while (0)
+
+static bool do_mfence_spa(DisasContext *ctx)
+{
+#ifndef CONFIG_USER_ONLY
+    REQUIRE_SMSDID(ctx);
+    if (ctx->priv != PRV_M) {
+        return false;
+    }
+    decode_save_opc(ctx, 0);
+    gen_helper_tlb_flush_all(tcg_env);
+    return true;
+#endif
+    return false;
+}
+
+static bool trans_mfence_spa(DisasContext *ctx, arg_mfence_spa *a)
+{
+    return do_mfence_spa(ctx);
+}
+
+static bool trans_minval_spa(DisasContext *ctx, arg_minval_spa *a)
+{
+    return do_mfence_spa(ctx);
+}
-- 
2.43.0


