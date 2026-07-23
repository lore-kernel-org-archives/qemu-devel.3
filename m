Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47F6EC531D0
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jul 2026 20:06:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wmzfF-00081E-TI; Thu, 23 Jul 2026 16:05:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhiwei_liu@linux.alibaba.com>)
 id 1wmzeI-0007Pb-T5; Thu, 23 Jul 2026 16:04:07 -0400
Received: from [115.124.30.133] (helo=out30-133.freemail.mail.aliyun.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhiwei_liu@linux.alibaba.com>)
 id 1wmzeA-0005Ru-Pd; Thu, 23 Jul 2026 16:04:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linux.alibaba.com; s=default;
 t=1784837023; h=From:To:Subject:Date:Message-Id:MIME-Version;
 bh=o9Tsn3g5F5bgE5q/yvCjG/dBWMS6cVPED04c2iL2CMg=;
 b=tKVyFowZ5d5BDs8mpuof51t5dQ4/f/IvfAY2jTQZq8dV50SnbsfBcKUPmU4b+rG3iP1EamIq0sLdPVJDAeJZUvFFQ4vZIZtthxoRLQdzWXGbo6g+R/JywR3que7mKdCLfn5poRZrUBxuxCSDRWXFMO8weJt0YPHcTNMpP3iHJMU=
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R791e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=maildocker-contentspam033037033178;
 MF=zhiwei_liu@linux.alibaba.com; NM=1; PH=DS; RN=13; SR=0;
 TI=SMTPD_---0X7h4UuV_1784837022; 
Received: from localhost.localdomain(mailfrom:zhiwei_liu@linux.alibaba.com
 fp:SMTPD_---0X7h4UuV_1784837022 cluster:ay36) by smtp.aliyun-inc.com;
 Fri, 24 Jul 2026 04:03:42 +0800
From: LIU Zhiwei <zhiwei_liu@linux.alibaba.com>
To: qemu-devel@nongnu.org
Cc: palmer@dabbelt.com, alistair.francis@wdc.com,
 daniel.barboza@oss.qualcomm.com, chao.liu.zevorn@gmail.com,
 liwei1518@gmail.com, qemu-riscv@nongnu.org, rahul@summations.net,
 xiangyi.zeng@linux.alibaba.com, cxx194832@alibaba-inc.com,
 LIU Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Huang Tao <eric.huang@linux.alibaba.com>,
 TANG Tiancheng <lyndra@linux.alibaba.com>
Subject: [PATCH v8 05/11] target/riscv: Implement SMMPT fence instructions
Date: Fri, 24 Jul 2026 04:03:19 +0800
Message-Id: <20260723200325.24969-6-zhiwei_liu@linux.alibaba.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
In-Reply-To: <20260723200325.24969-1-zhiwei_liu@linux.alibaba.com>
References: <20260723200325.24969-1-zhiwei_liu@linux.alibaba.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Host-Lookup-Failed: Reverse DNS lookup failed for 115.124.30.133 (deferred)
Received-SPF: pass client-ip=115.124.30.133;
 envelope-from=zhiwei_liu@linux.alibaba.com;
 helo=out30-133.freemail.mail.aliyun.com
X-Spam_score_int: -166
X-Spam_score: -16.7
X-Spam_bar: ----------------
X-Spam_report: (-16.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, ENV_AND_HDR_SPF_MATCH=-0.5,
 RCVD_IN_DNSWL_NONE=-0.0001, RDNS_NONE=0.793, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, UNPARSEABLE_RELAY=0.001, USER_IN_DEF_DKIM_WL=-7.5,
 USER_IN_DEF_SPF_WL=-7.5 autolearn=no autolearn_force=no
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
new fence instructions: `mfence.pa` and `minval.pa`.

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
---
 target/riscv/insn32.decode                    |  2 ++
 .../tcg/insn_trans/trans_privileged.c.inc     | 30 +++++++++++++++++++
 2 files changed, 32 insertions(+)

diff --git a/target/riscv/insn32.decode b/target/riscv/insn32.decode
index 21272fdb50..f0917b7696 100644
--- a/target/riscv/insn32.decode
+++ b/target/riscv/insn32.decode
@@ -120,6 +120,8 @@ sret        0001000    00010 00000 000 00000 1110011
 mret        0011000    00010 00000 000 00000 1110011
 wfi         0001000    00101 00000 000 00000 1110011
 sfence_vma  0001001    ..... ..... 000 00000 1110011 @sfence_vma
+mfence_pa   0011001    ..... ..... 000 00000 1110011 @sfence_vma
+minval_pa   0011011    ..... ..... 000 00000 1110011 @sfence_vma
 
 # *** NMI ***
 mnret       0111000    00010 00000 000 00000 1110011
diff --git a/target/riscv/tcg/insn_trans/trans_privileged.c.inc b/target/riscv/tcg/insn_trans/trans_privileged.c.inc
index a8eaccef67..67f2e56034 100644
--- a/target/riscv/tcg/insn_trans/trans_privileged.c.inc
+++ b/target/riscv/tcg/insn_trans/trans_privileged.c.inc
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
+static bool do_mfence_pa(DisasContext *ctx)
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
+static bool trans_mfence_pa(DisasContext *ctx, arg_mfence_pa *a)
+{
+    return do_mfence_pa(ctx);
+}
+
+static bool trans_minval_pa(DisasContext *ctx, arg_minval_pa *a)
+{
+    return do_mfence_pa(ctx);
+}
-- 
2.43.0


