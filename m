Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E6D7C5DF94
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2026 07:10:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wylID-0004WB-GE; Tue, 25 Aug 2026 03:09:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wylIB-0004TC-Th; Tue, 25 Aug 2026 03:09:55 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wylIA-0006QN-Bt; Tue, 25 Aug 2026 03:09:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1787641596; bh=DGgHuOLpM+2S6J0lMOn4pyinhKq03RNiD3E5qqUkehA=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=fTYw58gIX33h1v+hHWhNE0wGHiv3EzECEx0cOoL0eTvNfqPDY40xZmB5TGMiHowi2
 led6Q6G6CGIghdrMeH5TWrv+pkivZO+sybsb7JTYm+M4Yfx8mwNvpfB7wc/sxJxKk8
 4uuoRvgtqyzwMJeE2mu83CZ6Z07tUWTDnnRSVbW3rREVDRtFo0ZsfJtSYFuuE8JJnV
 q6Ri73h/Y3g54QLou6WqoPRc5wcYLHd4tqhwyDjywsMxcRoGduF3Ws1yBZfP+qTK14
 tg3XM3eqY9vRZEpHDD3XYWuNb/5GwBarDdMbf9h29bw+OvWXSh47lT9045VyKCDF7W
 YToQl43JZVPVg==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 8EF4D1CE230;
 Tue, 25 Aug 2026 10:06:36 +0300 (MSK)
Received: from gandalf.tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id 538F1415FAB;
 Tue, 25 Aug 2026 10:07:13 +0300 (MSK)
Received: by gandalf.tls.msk.ru (Postfix, from userid 1000)
 id C45F032440; Tue, 25 Aug 2026 10:06:35 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, TANG Tiancheng <lyndra@linux.alibaba.com>,
 LIU Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-11.1.1 v2 75/91] disas/riscv: Fix th.srri decoding
Date: Tue, 25 Aug 2026 10:05:47 +0300
Message-ID: <20260825070619.174584-33-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-11.1.1-20260825100540@cover.tls.msk.ru>
References: <qemu-stable-11.1.1-20260825100540@cover.tls.msk.ru>
MIME-Version: 1.0
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

target/riscv/xthead.decode defines th.srri as funct6=000100 in
bits 31:26, with the 6-bit immediate in bits 25:20.

decode_xtheadbb() switches on bits 31:25, i.e. funct6 plus imm[5].
Therefore valid th.srri encodings are 0001000 and 0001001. The
current 0000100 and 0000101 cases use the wrong funct6 value and
decode valid th.srri instructions as illegal.

Fix the cases to match funct6=000100 with both imm[5] values.

Fixes: 318df7238b9f ("disas/riscv: Add support for XThead* instructions")
Signed-off-by: TANG Tiancheng <lyndra@linux.alibaba.com>
Reviewed-by: LIU Zhiwei <zhiwei_liu@linux.alibaba.com>
Reviewed-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Message-ID: <20260703-b4-disas-xthead-fix-riscv-next-v4-1-84c566330bc7@linux.alibaba.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
(cherry picked from commit 6985cfc87512e96c0abfa7fffc836e7bd3889048)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/disas/riscv-xthead.c b/disas/riscv-xthead.c
index fcca326d1c3..2f2ddb8dd9a 100644
--- a/disas/riscv-xthead.c
+++ b/disas/riscv-xthead.c
@@ -315,8 +315,10 @@ void decode_xtheadbb(rv_decode *dec, rv_isa isa)
                         op = rv_op_th_revw;
                     }
                     break;
-                case 0b0000100:
-                case 0b0000101: op = rv_op_th_srri; break;
+                case 0b0001000:
+                case 0b0001001:
+                    op = rv_op_th_srri;
+                    break;
                 }
                 break;
             case 2: op = rv_op_th_ext; break;
-- 
2.47.3


