Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01C76CDB466
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jun 2026 00:25:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wbow3-00085a-NQ; Mon, 22 Jun 2026 20:24:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stephensportia@gmail.com>)
 id 1wbnOk-0001PU-N3
 for qemu-devel@nongnu.org; Mon, 22 Jun 2026 18:45:46 -0400
Received: from mail-pl1-x634.google.com ([2607:f8b0:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <stephensportia@gmail.com>)
 id 1wbnOi-0004Wb-Ft
 for qemu-devel@nongnu.org; Mon, 22 Jun 2026 18:45:46 -0400
Received: by mail-pl1-x634.google.com with SMTP id
 d9443c01a7336-2c0b9328c4aso35298635ad.0
 for <qemu-devel@nongnu.org>; Mon, 22 Jun 2026 15:45:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1782168342; x=1782773142; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=D3P9AYrpA4BY1vKyeayV+CK886D88ViD7/xJCKcwZO0=;
 b=U5gWNMapJ2uaM/a/pFts6cC1X1J2/RVrnb2VIQQNvpveC2vKwoyZZvBaPbDbr274A4
 EY/Wk5lqGYIy6D/q7criIT98SP71m1CaXDoiEusX/tLiL265S/TY6UQweUaf5poYSRn5
 /ENe4y1bX8BBpJJTUhGu/5U7DBMtjEkl90ldGGde6CQapfOBcqe4Q6TllE2KazcsGKI7
 rIm9eMMeIjsVk1Xc55PaxNjwqcVr1CMQTQdokd6/9RW6fAJ4nm942xZ3IKt+/qHU3fhB
 7Gu569bw/iDblK6s/cmys9ov+Xc9tXj01mdehiDLLDT/r4Vdn8qOpxiCTQ105ChNSkqC
 WyOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782168342; x=1782773142;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=D3P9AYrpA4BY1vKyeayV+CK886D88ViD7/xJCKcwZO0=;
 b=iPxUxZMgx6bo9FmSoYTkFvZh4i0XQNlAIqIbj7eqrRc124QZLK7BZFj7udX95Mfmfo
 MVg7gJqVwdoxsbzmKm25qFweOvVWNSYsiqTWYu0YCpMjjCjSUKntHDusk/q4XljCX3I2
 U2kjYW79Vd0itF1ZwSmiUt9CeaLYCUgpJeSwMzsKC5+bWHHbaJ9VlRPXQQhkaSjJsfce
 VesnRL5XvGs5y8pVHwlqfVyDvePQ76uGpBFSsJGl3sLOGibOr1dYdHwnBc2ANeEU1hF1
 71CahTAChXK+fxT7+kqGzHC9+yoHuDQBj1WSDPJoRSNG10wtUJTaWsWOa48gL+E5Dado
 AN5g==
X-Gm-Message-State: AOJu0YxpLquP0smVo7mY42/KtMpFBO2DL5x7/yRshgR+xyt1KYuITqJW
 B3BPTmfFyNHFq7o8FGdlYvBkB4/2tCAX0Fhqjs91KC2moNzmA4/oJMbObeLr8OWL
X-Gm-Gg: AfdE7clzDKElgtEFMRquTlrU8yVDSsCQ3yPausu5bxhL0aqX7fUY5z6uU/s3X5uxyko
 8CAxMeopVYr41J+xt4bQB1k7YJRAY4zabxvzuy/KwxCF5F6ArmUQpP53p4FBQHFro+8Igv/bXn5
 SrLMBVGqZhW6HoHRBpx8heKzaYj0Tl5g2pIWr0c5CDhHaKTvbTM5yjADO08xbfzWBSYK7JKM1cx
 2he/B39Zl9Cm26kzAcMDFzGH2jlaMpl1tJYX2PTyJfodtMaEsKDvuyIFHMyGPoGhtwkYGUsQ16J
 P2m88KFgOrReH00zyGBwkt+ET01rVkx/QMgZ7JUswzGIcCViRChNBIFP/no5IpeFgLBcHCc0CQo
 fSXWFkdysKEqRC8p57ybWrGzXb6ibY106HJ7Z0PHujVG4SN4PhT9PqkQ0ollLe3z5g/gC9ceVyY
 Ro0pB2nSz2hwsazCS83HSgnEXDWmYuyO11nQ4zhm0GFH3APp4KdcC6U+/KWQ==
X-Received: by 2002:a17:903:1a26:b0:2c0:f807:9bf3 with SMTP id
 d9443c01a7336-2c7423d65cemr125205855ad.10.1782168342240; 
 Mon, 22 Jun 2026 15:45:42 -0700 (PDT)
Received: from lima-default.tail89d63.ts.net ([159.196.41.205])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2c7436af585sm92060885ad.5.2026.06.22.15.45.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 22 Jun 2026 15:45:41 -0700 (PDT)
From: stephensportia@gmail.com
To: qemu-devel@nongnu.org
Cc: Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Chao Liu <chao.liu.zevorn@gmail.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, Weiwei Li <liwei1518@gmail.com>,
 qemu-riscv@nongnu.org, Portia Stephens <portias@oss.tenstorrent.com>
Subject: [PATCH] target/riscv: Generate illegal exception for inval.ir and
 w.inval in U-mode
Date: Tue, 23 Jun 2026 08:45:34 +1000
Message-ID: <20260622224534.1923407-1-stephensportia@gmail.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::634;
 envelope-from=stephensportia@gmail.com; helo=mail-pl1-x634.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Mon, 22 Jun 2026 20:24:12 -0400
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

From: Portia Stephens <portias@oss.tenstorrent.com>

According to the priv spec "Attempting to execute SFENCE.W.INVAL or
SFENCE.INVAL.IR in U-mode raises an illegal-instruction exception." Fix
the current implementation to generate exception.

Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3543
Signed-off-by: Portia Stephens <portias@oss.tenstorrent.com>
---
 target/riscv/insn_trans/trans_svinval.c.inc | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/target/riscv/insn_trans/trans_svinval.c.inc b/target/riscv/insn_trans/trans_svinval.c.inc
index a06c3b214f..10cb9e32b6 100644
--- a/target/riscv/insn_trans/trans_svinval.c.inc
+++ b/target/riscv/insn_trans/trans_svinval.c.inc
@@ -39,6 +39,12 @@ static bool trans_sfence_w_inval(DisasContext *ctx, arg_sfence_w_inval *a)
 {
     REQUIRE_SVINVAL(ctx);
     REQUIRE_EXT(ctx, RVS);
+    if (ctx->priv == PRV_U) {
+        /* Set the virtual exception if virt enabled */
+        ctx->virt_inst_excp = ctx->virt_enabled;
+        gen_exception_illegal(ctx);
+        return false;
+    }
     /* Do nothing currently */
     return true;
 }
@@ -47,6 +53,12 @@ static bool trans_sfence_inval_ir(DisasContext *ctx, arg_sfence_inval_ir *a)
 {
     REQUIRE_SVINVAL(ctx);
     REQUIRE_EXT(ctx, RVS);
+    if (ctx->priv == PRV_U) {
+        /* Set the virtual exception if virt enabled */
+        ctx->virt_inst_excp = ctx->virt_enabled;
+        gen_exception_illegal(ctx);
+        return false;
+    }
     /* Do nothing currently */
     return true;
 }
-- 
2.43.0


