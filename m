Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73561C61DC2
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2026 11:20:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wyp7X-00029F-Ct; Tue, 25 Aug 2026 07:15:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wyp7U-00027r-N3; Tue, 25 Aug 2026 07:15:08 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wyp7T-0000XF-2x; Tue, 25 Aug 2026 07:15:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1787656396; bh=WbCK2vovdkZkyz9DyqN7FolDKHTv3oCz8AmWMOwz1T0=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=KeoYariV5PZ8KwEJsCc26fv3iINscKU0awgvwUG7ZPgdprFbQwKRITkZq3PBtnSWR
 oRRK8ROc2ctdcAeI/wghpJGi/NwPa1f12SIXnr7BNBgkQ2yL4VWAzz8Qi/0chvTv6C
 DtcHZguykqQSj1jjWyLJdmgE/vxQpLdxLNyP4zAUPTinUA6TVwxCzW9bqDG2ugrdVI
 KVYFigz4bN+dZqenfOiwh1Nkw6GXPIOGdoMnv1odFjr02u0HEfFxggeM4V2d3Gzcli
 KocyWkfNx8yBSPePPZMzZv1mGO65NnKGacm7vfhTY+7rQwbgCTSVHYHuAj7ROMJ2AP
 mNsdzs5vQGbiw==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 5F5841CE4B6;
 Tue, 25 Aug 2026 14:13:16 +0300 (MSK)
Received: from gandalf.tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id 785CE416282;
 Tue, 25 Aug 2026 14:13:53 +0300 (MSK)
Received: by gandalf.tls.msk.ru (Postfix, from userid 1000)
 id 9B3CF325AF; Tue, 25 Aug 2026 14:13:15 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, TANG Tiancheng <lyndra@linux.alibaba.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 LIU Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-10.0.13 v3 154/166] disas/riscv: Fix 6-bit immediate
 extraction
Date: Tue, 25 Aug 2026 14:11:50 +0300
Message-ID: <20260825111206.482723-20-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-10.0.13-20260825141147@cover.tls.msk.ru>
References: <qemu-stable-10.0.13-20260825141147@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=212.248.84.144; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, SPF_HELO_NONE=0.001,
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

From: TANG Tiancheng <lyndra@linux.alibaba.com>

rv_codec_r2_imm6 is used for XThead instructions whose 6-bit
immediate field is encoded in bits 25:20. The old expression
left-shifted by 38 and then right-shifted by 60, so it kept only
bits 25:22.

Use extract32() to decode bits 25:20 directly. This fixes the
immediate printed for th.srri and th.tst.

Fixes: 318df7238b9f ("disas/riscv: Add support for XThead* instructions")
Suggested-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: TANG Tiancheng <lyndra@linux.alibaba.com>
Reviewed-by: LIU Zhiwei <zhiwei_liu@linux.alibaba.com>
Reviewed-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Message-ID: <20260703-b4-disas-xthead-fix-riscv-next-v4-2-84c566330bc7@linux.alibaba.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
(cherry picked from commit 7a8454ef293085a45686929577b7d5a5daded242)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/disas/riscv.c b/disas/riscv.c
index 2d8add32127..692765cd32f 100644
--- a/disas/riscv.c
+++ b/disas/riscv.c
@@ -4538,7 +4538,7 @@ static uint32_t operand_zcmp_rlist(rv_inst inst)
 
 static uint32_t operand_imm6(rv_inst inst)
 {
-    return (inst << 38) >> 60;
+    return extract32(inst, 20, 6);
 }
 
 static uint32_t operand_imm2(rv_inst inst)
-- 
2.47.3


