Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BFFE0C44500
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Jul 2026 14:34:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wew0C-0001yA-Qk; Wed, 01 Jul 2026 10:33:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lyndra@linux.alibaba.com>)
 id 1wew08-0001wi-2L; Wed, 01 Jul 2026 10:33:20 -0400
Received: from [115.124.30.132] (helo=out30-132.freemail.mail.aliyun.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lyndra@linux.alibaba.com>)
 id 1wew05-0000S1-Ew; Wed, 01 Jul 2026 10:33:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linux.alibaba.com; s=default;
 t=1782916379; h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To;
 bh=jtbdk5iG5WqPu5oOXDmCOt9/eRNGNPDbyea6/KJsfeE=;
 b=MZp+vfyuP9iUX+M2ElhZDxL9jYWzMrLulNd8ncQAvqzoW1PEQ+iZvj8MIBaweVRl1XnyvOaglItIAdNziLMq9vTl5ZWLx5fm3SliSK43HBAajLiOI4hbe9XU2MuYRCsuPqWSfNfvDLuXS7TEOE65dYu+VGsePVA5hMguGGZgk5I=
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R151e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=maildocker-contentspam033045133197;
 MF=lyndra@linux.alibaba.com; NM=1; PH=DS; RN=9; SR=0;
 TI=SMTPD_---0X6A2Trh_1782916376; 
Received: from ea134-sw06.eng.xrvm.cn(mailfrom:lyndra@linux.alibaba.com
 fp:SMTPD_---0X6A2Trh_1782916376 cluster:ay36) by smtp.aliyun-inc.com;
 Wed, 01 Jul 2026 22:32:56 +0800
From: TANG Tiancheng <lyndra@linux.alibaba.com>
Date: Wed, 01 Jul 2026 22:32:10 +0800
Subject: [PATCH v3 2/5] disas/riscv: Fix 6-bit immediate extraction
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260701-b4-disas-xthead-fix-riscv-next-v3-2-fc4f5f1b6c15@linux.alibaba.com>
References: <20260701-b4-disas-xthead-fix-riscv-next-v3-0-fc4f5f1b6c15@linux.alibaba.com>
In-Reply-To: <20260701-b4-disas-xthead-fix-riscv-next-v3-0-fc4f5f1b6c15@linux.alibaba.com>
To: qemu-devel@nongnu.org
Cc: Christoph Muellner <christoph.muellner@vrull.eu>, 
 LIU Zhiwei <zhiwei_liu@linux.alibaba.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>, 
 Alistair Francis <Alistair.Francis@wdc.com>, 
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>, 
 Richard Henderson <richard.henderson@linaro.org>, qemu-riscv@nongnu.org, 
 TANG Tiancheng <lyndra@linux.alibaba.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1782916375; l=1154;
 i=lyndra@linux.alibaba.com; s=20250909; h=from:subject:message-id;
 bh=fECxabHVg6J3QPrge6wP3Wo05THZjnLRqrtTjO6bXmk=;
 b=r5wU2y8vP7juYB3a/T+etaLj1cJfC9b8kHrQU93qa0bG+ANdhYQaVgqg6z47BL6ZDs63RTMjE
 luzCsm+x+c5Cst3GHfuFPD3xJnl7/cctKXX/ROUOJ1A2iQcPMR/dzzv
X-Developer-Key: i=lyndra@linux.alibaba.com; a=ed25519;
 pk=GQh4uOSLVucXGkaZfEuQ956CrYS14cn1TA3N8AiIjBw=
X-Host-Lookup-Failed: Reverse DNS lookup failed for 115.124.30.132 (deferred)
Received-SPF: pass client-ip=115.124.30.132;
 envelope-from=lyndra@linux.alibaba.com;
 helo=out30-132.freemail.mail.aliyun.com
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

rv_codec_r2_imm6 is used for XThead instructions whose 6-bit
immediate field is encoded in bits 25:20. The old expression
left-shifted by 38 and then right-shifted by 60, so it kept only
bits 25:22.

Shift right by 58 instead, keeping the existing extraction style while
retaining the full bits 25:20 field. This fixes the immediate printed
for th.srri and th.tst.

Fixes: 318df7238b9f ("disas/riscv: Add support for XThead* instructions")
Signed-off-by: TANG Tiancheng <lyndra@linux.alibaba.com>
Reviewed-by: LIU Zhiwei <zhiwei_liu@linux.alibaba.com>
Reviewed-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
---
 disas/riscv.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/disas/riscv.c b/disas/riscv.c
index 7f1b26277378c225c963d8f435cc7a2fc6e4a0b8..400a57083f90be18ccd12415797bce0df974784b 100644
--- a/disas/riscv.c
+++ b/disas/riscv.c
@@ -4546,7 +4546,7 @@ static uint32_t operand_zcmp_rlist(rv_inst inst)
 
 static uint32_t operand_imm6(rv_inst inst)
 {
-    return (inst << 38) >> 60;
+    return (inst << 38) >> 58;
 }
 
 static uint32_t operand_imm2(rv_inst inst)

-- 
2.43.0


