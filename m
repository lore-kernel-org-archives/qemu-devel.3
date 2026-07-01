Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD14FC43602
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Jul 2026 14:34:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wew0H-00020Y-TP; Wed, 01 Jul 2026 10:33:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lyndra@linux.alibaba.com>)
 id 1wew08-0001wu-VC; Wed, 01 Jul 2026 10:33:21 -0400
Received: from [115.124.30.131] (helo=out30-131.freemail.mail.aliyun.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lyndra@linux.alibaba.com>)
 id 1wew05-0000SP-0E; Wed, 01 Jul 2026 10:33:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linux.alibaba.com; s=default;
 t=1782916379; h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To;
 bh=SXjVdCGN0cA5Jj+IrBWQWgnMneXp9emPga8+CP/p0a4=;
 b=fYdWJD7Fty2vNR8U+xW1I5rOHwwVI0pY4AGolDaF4MBZNhfVVUMc2md9T7atkoIUSdTZ9Q64KmuXm5khzGwVXljumkZ2pik/7+lDzUEv5fncoqoCbbEJ7NGBJTcUQbQdLSEDXhs2DzqYaUvgDZOtLs3DtDeL5u0xPgRpSVBIrDw=
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R151e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=maildocker-contentspam033037033178;
 MF=lyndra@linux.alibaba.com; NM=1; PH=DS; RN=9; SR=0;
 TI=SMTPD_---0X6A2Trt_1782916376; 
Received: from ea134-sw06.eng.xrvm.cn(mailfrom:lyndra@linux.alibaba.com
 fp:SMTPD_---0X6A2Trt_1782916376 cluster:ay36) by smtp.aliyun-inc.com;
 Wed, 01 Jul 2026 22:32:57 +0800
From: TANG Tiancheng <lyndra@linux.alibaba.com>
Date: Wed, 01 Jul 2026 22:32:11 +0800
Subject: [PATCH v3 3/5] disas/riscv: Use signed type for vector immediates
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260701-b4-disas-xthead-fix-riscv-next-v3-3-fc4f5f1b6c15@linux.alibaba.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1782916375; l=911;
 i=lyndra@linux.alibaba.com; s=20250909; h=from:subject:message-id;
 bh=ITXOf+1LAM2NiTyNtuQuF3UTMPPL6Gn2c9yAeXo53pw=;
 b=1xu37Wm3vbI84OQN54CfAEXTlEhJmMNhTVGcJ6PdKBbgosajeDq6e1f1ws3GgUyV80pcn1x2d
 9woVkTmGAqoAyN/uUHYgiajuZH0RNmCGTiKE0VIJI4Azu1mmNcR6N9H
X-Developer-Key: i=lyndra@linux.alibaba.com; a=ed25519;
 pk=GQh4uOSLVucXGkaZfEuQ956CrYS14cn1TA3N8AiIjBw=
X-Host-Lookup-Failed: Reverse DNS lookup failed for 115.124.30.131 (deferred)
Received-SPF: pass client-ip=115.124.30.131;
 envelope-from=lyndra@linux.alibaba.com;
 helo=out30-131.freemail.mail.aliyun.com
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

operand_vimm() sign-extends the 5-bit vector immediate field in bits
19:15, but returns uint32_t. This sends negative immediates through an
unsigned type before they are assigned to rv_decode.imm.

Return int32_t to match the signed value extracted by the helper.

Signed-off-by: TANG Tiancheng <lyndra@linux.alibaba.com>
Reviewed-by: LIU Zhiwei <zhiwei_liu@linux.alibaba.com>
---
 disas/riscv.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/disas/riscv.c b/disas/riscv.c
index 400a57083f90be18ccd12415797bce0df974784b..e9dcc173d8fa2f89d85b76595a76931c4dddb462 100644
--- a/disas/riscv.c
+++ b/disas/riscv.c
@@ -4487,7 +4487,7 @@ static uint32_t operand_cimmq(rv_inst inst)
         ((inst << 57) >> 62) << 6;
 }
 
-static uint32_t operand_vimm(rv_inst inst)
+static int32_t operand_vimm(rv_inst inst)
 {
     return (int64_t)(inst << 44) >> 59;
 }

-- 
2.43.0


