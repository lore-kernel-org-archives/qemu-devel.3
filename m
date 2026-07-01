Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E438FC43458
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Jul 2026 14:34:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wew0K-00021p-9k; Wed, 01 Jul 2026 10:33:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lyndra@linux.alibaba.com>)
 id 1wew09-0001wv-6I; Wed, 01 Jul 2026 10:33:21 -0400
Received: from [115.124.30.132] (helo=out30-132.freemail.mail.aliyun.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lyndra@linux.alibaba.com>)
 id 1wew04-0000Rk-Ri; Wed, 01 Jul 2026 10:33:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linux.alibaba.com; s=default;
 t=1782916378; h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To;
 bh=cFVSdKRxBxbWRYZb04r06GB3+hYX03AMc5Cn5Wd3z24=;
 b=ukDH98iQyi62Dbs+HY7zVaXLiXvZDKCj/QEMgk+62OBEGqZ3l42reOR7scBlDMpixc9qs/klD8QhD3rS3FbY+JrJAOseH3MG54z5OH/JRAcUQ12m7rKWY9sKUacC+SSCe66OjHB4jTp76F5hwNJbWv9QENMeHdLSdXWjaMU9cOU=
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R411e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=maildocker-contentspam033045098064;
 MF=lyndra@linux.alibaba.com; NM=1; PH=DS; RN=9; SR=0;
 TI=SMTPD_---0X6A2Trb_1782916375; 
Received: from ea134-sw06.eng.xrvm.cn(mailfrom:lyndra@linux.alibaba.com
 fp:SMTPD_---0X6A2Trb_1782916375 cluster:ay36) by smtp.aliyun-inc.com;
 Wed, 01 Jul 2026 22:32:56 +0800
From: TANG Tiancheng <lyndra@linux.alibaba.com>
Date: Wed, 01 Jul 2026 22:32:09 +0800
Subject: [PATCH v3 1/5] disas/riscv: Fix th.srri decoding
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260701-b4-disas-xthead-fix-riscv-next-v3-1-fc4f5f1b6c15@linux.alibaba.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1782916375; l=1506;
 i=lyndra@linux.alibaba.com; s=20250909; h=from:subject:message-id;
 bh=m/WPwWNlaTg0Hlf4CSq6Gcr7JvCTsC5AbG3EU9dKV6w=;
 b=j8YqUAmQ43jsczS61QRECmlQcyuXScSJuQMvOdvF3OsT1FBOn8Q20R7amLqRRCPa5PCnBHeii
 7tk/utkG3PVDHot+/gvODZopWbz+3jG9OUBRiPAoIDdi3r0HiyLXEY4
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
---
 disas/riscv-xthead.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/disas/riscv-xthead.c b/disas/riscv-xthead.c
index fcca326d1c398a6745984b9f5d90fc5f7d54dfd9..2f2ddb8dd9a13e17a28539b4179cd10fa93c5941 100644
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
2.43.0


