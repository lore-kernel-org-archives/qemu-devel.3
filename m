Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 616C9CD98E1
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2026 10:07:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wZQgL-0005Bx-1t; Tue, 16 Jun 2026 06:06:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wZQgI-0005BZ-Ed
 for qemu-devel@nongnu.org; Tue, 16 Jun 2026 06:06:06 -0400
Received: from mail-pj1-x102b.google.com ([2607:f8b0:4864:20::102b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wZQgG-000366-PM
 for qemu-devel@nongnu.org; Tue, 16 Jun 2026 06:06:06 -0400
Received: by mail-pj1-x102b.google.com with SMTP id
 98e67ed59e1d1-36ba3ea5c46so2530926a91.1
 for <qemu-devel@nongnu.org>; Tue, 16 Jun 2026 03:06:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1781604363; x=1782209163; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lB+WlnNjt8V9VEvbROguMWjIM5FXQ266hkkEQLIspm0=;
 b=QEg/qhwXHevjhdEz2+Wr6Q2tIxu1yqU/57CZEvi8amok4UW3yclr3Y3sNINfKbkt/Z
 monP2Eh1V2MUTBs8/MAvC73kluXCetE36/B22Whq0UfK/71MsKcL/cB2qloSQkQ5Y2w6
 KE/UB79bZczw4mF0ncM4guZxng/w3fqxV7BICL+2RIsxK/ADdSokpiTs0QF0nAOj9GpV
 2jTh0zpbmjWyiAxrGiZUijXM8vdAz31t8PFIP+MjPyfRhdh6mc9iB8LWRvE6Dk+8ubhR
 ZDJMMaktVS7I7Pj+9eVSAVfr61B/XRqvVduMPxX/8bG5Qy9WIblvQHjhrSXsQQtfPE74
 DLbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781604363; x=1782209163;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=lB+WlnNjt8V9VEvbROguMWjIM5FXQ266hkkEQLIspm0=;
 b=bnU88eCCb25QoSi6l5z/JXca9+jHAHqs03sy/UgAPfSZnInRbQUKk4/p4griktZRR2
 ws06NFqUtUiJfNXJYBaaLPfXzZfF6KaxEifqQ+hXRMQnfi5ht76+y5h/pcJL1nKlsWJ6
 Rsvcfo6SblB6kGfS06UXJddkpWeCJUIKAN6dLGMS3bSk56qMlTXnCy/H7N9O4UwxA4E2
 y/Qhx8O3ZECixoVS/vqYJBpTOzueIZI8/QJsC78GmCIOF4j2tkVrBx5maJ+zKLizlPos
 vGXZOpucsXmnoH3W2E46R9fcJD7z/759Rn/dEk8RwrdxSgtqoamyxMgt4/2pd4qJnmzI
 v2Cw==
X-Gm-Message-State: AOJu0Yz1ncLoPY0U6Rle5hXJv5qutVqWtFYhAody5ZOEdrp9fDvbl/QS
 27+rrHaXP3G5U9GpPn8Zuzkyb1P5E/c103jSVX20oSEz9egcifHuitiTA9J3eCfW
X-Gm-Gg: Acq92OF/L8wjg6G0+4ZLK2YkU4tknBd3WSRkFTVZjRV/g2r9gsaGsksAYLzZLDlJQeh
 iAuSuUgICbPN6SXwAJ/IdNPKec0lY/smZ1D+DFUeBAoHS/zOzNhlIwiEPUNUIYuibDhCz/cjc7o
 cZyIgY4VUytdCTyVM+m0UeDRj0b57TRLyWvX/9465yFFWDON9lfJshufXJMpO6ss4zzMUOtlO4T
 XqYAQHNx4cZnJPIyleSCnnvbPCxYpWJ1hrCmCyZN0rXghAC3Jh8B85iI0Xb5ZrtPeiT+HtjxNjn
 2pUym3YNEqJ9GcsYIVT5Zwgiu83ViiTZ77VFogVGTBpK3YhDLREv8ZTugwxM1jq7XLWeM7myTQf
 oklc06GrSE7az3Irj/hJ2nJorW9LoFjt7og5oWTrbYiz2IyWLB19LzmADsgNww8hLbAAe37NEMU
 V5la/vz/QHXd478FD4UAvKTysGicVgSKj/izVOix86
X-Received: by 2002:a17:90b:4c11:b0:36d:7d99:5316 with SMTP id
 98e67ed59e1d1-37a03ec10demr18632881a91.17.1781604363241; 
 Tue, 16 Jun 2026 03:06:03 -0700 (PDT)
Received: from toolbx.alistair23.me ([2403:581e:fdf9:0:13b2:851f:d9cb:44c5])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-c866519f0a6sm10916735a12.22.2026.06.16.03.06.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 Jun 2026 03:06:02 -0700 (PDT)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Zephyr Li <fritchleybohrer@gmail.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Chao Liu <chao.liu.zevorn@gmail.com>
Subject: [PULL 08/83] target/riscv: Reject Svinval instructions in U-mode
Date: Tue, 16 Jun 2026 20:04:11 +1000
Message-ID: <20260616100527.1939565-9-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260616100527.1939565-1-alistair.francis@wdc.com>
References: <20260616100527.1939565-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102b;
 envelope-from=alistair23@gmail.com; helo=mail-pj1-x102b.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

From: Zephyr Li <fritchleybohrer@gmail.com>

The RISC-V privileged specification requires SFENCE.W.INVAL and
SFENCE.INVAL.IR to raise an illegal instruction exception when executed
in U-mode. Check the current privilege mode during translation and reject these
instructions in U-mode, so they are reported as illegal instructions.

Add a helper to reject these instructions in U-mode during translation.

Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3493

Suggested-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>

Signed-off-by: Zephyr Li <fritchleybohrer@gmail.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Chao Liu <chao.liu.zevorn@gmail.com>
Reviewed-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Message-ID: <20260522033145.17850-1-fritchleybohrer@gmail.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/insn_trans/trans_svinval.c.inc | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/target/riscv/insn_trans/trans_svinval.c.inc b/target/riscv/insn_trans/trans_svinval.c.inc
index a06c3b214f..4614c1489c 100644
--- a/target/riscv/insn_trans/trans_svinval.c.inc
+++ b/target/riscv/insn_trans/trans_svinval.c.inc
@@ -22,11 +22,19 @@
     }                                      \
 } while (0)
 
+/* Test if priv level is M or S. */
+#define REQUIRE_PRIV_MS(ctx) do {          \
+    if (ctx->priv == PRV_U) {              \
+        return false;                      \
+    }                                      \
+} while (0)
+
 static bool trans_sinval_vma(DisasContext *ctx, arg_sinval_vma *a)
 {
     REQUIRE_SVINVAL(ctx);
     /* Do the same as sfence.vma currently */
     REQUIRE_EXT(ctx, RVS);
+    REQUIRE_PRIV_MS(ctx);
 #ifndef CONFIG_USER_ONLY
     decode_save_opc(ctx, 0);
     gen_helper_tlb_flush(tcg_env);
@@ -39,6 +47,7 @@ static bool trans_sfence_w_inval(DisasContext *ctx, arg_sfence_w_inval *a)
 {
     REQUIRE_SVINVAL(ctx);
     REQUIRE_EXT(ctx, RVS);
+    REQUIRE_PRIV_MS(ctx);
     /* Do nothing currently */
     return true;
 }
@@ -47,6 +56,7 @@ static bool trans_sfence_inval_ir(DisasContext *ctx, arg_sfence_inval_ir *a)
 {
     REQUIRE_SVINVAL(ctx);
     REQUIRE_EXT(ctx, RVS);
+    REQUIRE_PRIV_MS(ctx);
     /* Do nothing currently */
     return true;
 }
@@ -56,6 +66,7 @@ static bool trans_hinval_vvma(DisasContext *ctx, arg_hinval_vvma *a)
     REQUIRE_SVINVAL(ctx);
     /* Do the same as hfence.vvma currently */
     REQUIRE_EXT(ctx, RVH);
+    REQUIRE_PRIV_MS(ctx);
 #ifndef CONFIG_USER_ONLY
     decode_save_opc(ctx, 0);
     gen_helper_hyp_tlb_flush(tcg_env);
@@ -69,6 +80,7 @@ static bool trans_hinval_gvma(DisasContext *ctx, arg_hinval_gvma *a)
     REQUIRE_SVINVAL(ctx);
     /* Do the same as hfence.gvma currently */
     REQUIRE_EXT(ctx, RVH);
+    REQUIRE_PRIV_MS(ctx);
 #ifndef CONFIG_USER_ONLY
     decode_save_opc(ctx, 0);
     gen_helper_hyp_gvma_tlb_flush(tcg_env);
-- 
2.54.0


