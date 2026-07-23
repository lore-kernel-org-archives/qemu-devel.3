Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F754C531FA
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jul 2026 20:05:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wmzeu-0007WL-NG; Thu, 23 Jul 2026 16:04:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhiwei_liu@linux.alibaba.com>)
 id 1wmzeH-0007OV-TT; Thu, 23 Jul 2026 16:04:06 -0400
Received: from [115.124.30.119] (helo=out30-119.freemail.mail.aliyun.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhiwei_liu@linux.alibaba.com>)
 id 1wmzeA-0005Ry-PX; Thu, 23 Jul 2026 16:04:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linux.alibaba.com; s=default;
 t=1784837024; h=From:To:Subject:Date:Message-Id:MIME-Version;
 bh=Z7ScyqJhyuMD43cubZw/XBiC8G2Ld3c8D9YYFkOZP9k=;
 b=I2jKDW7bzJM9Vy4KhZzuNGPcNiJ1pdwshYPio5+jjXfyHzUVHKnP/4KY/VD6ciqQKWTI7Of7eDk4x1srCCISElPresgdm+EPOakr2752viqySHZ9Mn9s+MTA+0nmlemJAow0AL+oCmrPtkg1zQFYCtf4e0n49zahU/veqtVxHxY=
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R411e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=maildocker-contentspam033037009110;
 MF=zhiwei_liu@linux.alibaba.com; NM=1; PH=DS; RN=11; SR=0;
 TI=SMTPD_---0X7h4UvA_1784837023; 
Received: from localhost.localdomain(mailfrom:zhiwei_liu@linux.alibaba.com
 fp:SMTPD_---0X7h4UvA_1784837023 cluster:ay36) by smtp.aliyun-inc.com;
 Fri, 24 Jul 2026 04:03:44 +0800
From: LIU Zhiwei <zhiwei_liu@linux.alibaba.com>
To: qemu-devel@nongnu.org
Cc: palmer@dabbelt.com, alistair.francis@wdc.com,
 daniel.barboza@oss.qualcomm.com, chao.liu.zevorn@gmail.com,
 liwei1518@gmail.com, qemu-riscv@nongnu.org, rahul@summations.net,
 xiangyi.zeng@linux.alibaba.com, cxx194832@alibaba-inc.com,
 LIU Zhiwei <zhiwei_liu@linux.alibaba.com>
Subject: [PATCH v8 07/11] target/riscv: Add disassembly for Smmpt instructions
 and CSRs
Date: Fri, 24 Jul 2026 04:03:21 +0800
Message-Id: <20260723200325.24969-8-zhiwei_liu@linux.alibaba.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
In-Reply-To: <20260723200325.24969-1-zhiwei_liu@linux.alibaba.com>
References: <20260723200325.24969-1-zhiwei_liu@linux.alibaba.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Host-Lookup-Failed: Reverse DNS lookup failed for 115.124.30.119 (deferred)
Received-SPF: pass client-ip=115.124.30.119;
 envelope-from=zhiwei_liu@linux.alibaba.com;
 helo=out30-119.freemail.mail.aliyun.com
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

Add disassembly support to the RISC-V disassembler for the machine CSRs
and fence instructions introduced by the Smmpt/Smsdid series:

  - CSRs:         mmpt (0x382), msdcfg (0x74e)
  - Instructions: mfence.pa, minval.pa

Note that CSR 0x382 was previously mapped to the obsolete "mibase"
register from the removed base-and-bound draft; it is now reused by
Smmpt for mmpt.

Signed-off-by: LIU Zhiwei <zhiwei_liu@linux.alibaba.com>
---
 disas/riscv.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/disas/riscv.c b/disas/riscv.c
index 7f1b262773..8fdae54449 100644
--- a/disas/riscv.c
+++ b/disas/riscv.c
@@ -990,6 +990,8 @@ typedef enum {
     rv_op_cbo_flush = 958,
     rv_op_cbo_zero = 959,
     rv_op_mnret = 960,
+    rv_op_mfence_pa = 961,
+    rv_op_minval_pa = 962,
 } rv_op;
 
 /* register names */
@@ -2265,6 +2267,8 @@ const rv_opcode_data rvi_opcode_data[] = {
    { "cbo.flush", rv_codec_r, rv_fmt_rs1, NULL, 0, 0, 0 },
    { "cbo.zero", rv_codec_r, rv_fmt_rs1, NULL, 0, 0, 0 },
    { "mnret", rv_codec_none, rv_fmt_none, NULL, 0, 0, 0 },
+   { "mfence.pa", rv_codec_r, rv_fmt_rs1_rs2, NULL, 0, 0, 0 },
+   { "minval.pa", rv_codec_r, rv_fmt_rs1_rs2, NULL, 0, 0, 0 },
 };
 
 /* CSR names */
@@ -2356,7 +2360,7 @@ static const char *csr_name(int csrno)
     case 0x0344: return "mip";
     case 0x0380: return "mbase";
     case 0x0381: return "mbound";
-    case 0x0382: return "mibase";
+    case 0x0382: return "mmpt";
     case 0x0383: return "mibound";
     case 0x0384: return "mdbase";
     case 0x0385: return "mdbound";
@@ -2440,6 +2444,7 @@ static const char *csr_name(int csrno)
     case 0x03ed: return "pmpaddr61";
     case 0x03ee: return "pmpaddr62";
     case 0x03ef: return "pmpaddr63";
+    case 0x074e: return "msdcfg";
     case 0x0780: return "mtohost";
     case 0x0781: return "mfromhost";
     case 0x0782: return "mreset";
@@ -4079,6 +4084,8 @@ static void decode_inst_opcode(rv_decode *dec, rv_isa isa)
                     case 64: op = rv_op_mret; break;
                     }
                     break;
+                case 800: op = rv_op_mfence_pa; break;
+                case 864: op = rv_op_minval_pa; break;
                 case 1792:
                     switch ((inst >> 15) & 0b1111111111) {
                     case 64: op = rv_op_mnret; break;
-- 
2.43.0


