Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1BFAC02188
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jan 2025 14:19:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tcPxO-0000Lf-3U; Mon, 27 Jan 2025 09:19:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1tcPxK-00009u-KI; Mon, 27 Jan 2025 09:19:14 -0500
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1tcPxJ-0002Q0-3M; Mon, 27 Jan 2025 09:19:14 -0500
Received: from localhost.tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by isrv.corpit.ru (Postfix) with ESMTP id 49F8CE0E36;
 Mon, 27 Jan 2025 17:18:40 +0300 (MSK)
Received: by localhost.tls.msk.ru (Postfix, from userid 1000)
 id 60DA151D63; Mon, 27 Jan 2025 17:18:03 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Roman Artemev <roman.artemev@syntacore.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Denis Tomashev <denis.tomashev@syntacore.com>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-9.2.1 03/41] tcg/riscv: Fix StoreStore barrier generation
Date: Mon, 27 Jan 2025 17:17:17 +0300
Message-Id: <20250127141803.3514882-3-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <qemu-stable-9.2.1-20250127154029@cover.tls.msk.ru>
References: <qemu-stable-9.2.1-20250127154029@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=86.62.121.231; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -68
X-Spam_score: -6.9
X-Spam_bar: ------
X-Spam_report: (-6.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_HI=-5,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

From: Roman Artemev <roman.artemev@syntacore.com>

On RISC-V to StoreStore barrier corresponds
`fence w, w` not `fence r, r`

Cc: qemu-stable@nongnu.org
Fixes: efbea94c76b ("tcg/riscv: Add slowpath load and store instructions")
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Denis Tomashev <denis.tomashev@syntacore.com>
Signed-off-by: Roman Artemev <roman.artemev@syntacore.com>
Message-ID: <e2f2131e294a49e79959d4fa9ec02cf4@syntacore.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
(cherry picked from commit b438362a142527b97b638b7f0f35ebe11911a8d5)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/tcg/riscv/tcg-target.c.inc b/tcg/riscv/tcg-target.c.inc
index f8331e4688..96f9a7e348 100644
--- a/tcg/riscv/tcg-target.c.inc
+++ b/tcg/riscv/tcg-target.c.inc
@@ -1624,7 +1624,7 @@ static void tcg_out_mb(TCGContext *s, TCGArg a0)
         insn |= 0x02100000;
     }
     if (a0 & TCG_MO_ST_ST) {
-        insn |= 0x02200000;
+        insn |= 0x01100000;
     }
     tcg_out32(s, insn);
 }
-- 
2.39.5


