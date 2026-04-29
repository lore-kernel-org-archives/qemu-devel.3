Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0269CCFA13
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Apr 2026 20:04:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wIB7z-0003ZY-Ns; Wed, 29 Apr 2026 16:03:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joel@airwebreathe.org.uk>)
 id 1wI8M7-0005I6-Nt
 for qemu-devel@nongnu.org; Wed, 29 Apr 2026 13:05:47 -0400
Received: from a-painless.mh.aa.net.uk ([2001:8b0:0:30::51])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joel@airwebreathe.org.uk>)
 id 1wI8M5-00057y-RV
 for qemu-devel@nongnu.org; Wed, 29 Apr 2026 13:05:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=airwebreathe.org.uk; s=aaisp1; h=Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
 Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=4HlHIUCCfVNq7SnCRPG2LedBEmtBcE0/hKTviMJSuM0=; b=l5fFFXZ5TkSjTn546RCYxThIZn
 TxN/9TtZXu0Rt5j5SkciMY32IatNtwNbyuUIonZz9RiaNTySTshfYZUyDsuII3XxGr1hQGn1pIWaN
 Z9FOEismvGbLAovnxcySem0nn5WlCP36vnmMmk9mrPu0RQc9zAzH3Z+oZPU33j6y1qB9DeNDmMbh1
 kFfz0QelestFDjrD+FPhEZZM4DjNMGjV12zKvowu/FBblnvW+e7/XL97lLaFuygOY9TRhabe3yE0d
 rl4trVMOdE7Gd2adsPy+baYuoiaHMNiA0450MIDpWJ9M+gw5fj+WiGQ1iQ82yX2Iu2qOZsSwl3hll
 nPmm4k8g==;
Received: from thunderhill.nvidia.com ([216.228.112.22]
 helo=jholdsworth-sail.nvidia.com)
 by painless-a.thn.aa.net.uk with esmtpsa (TLS1.3) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.98.2)
 (envelope-from <joel@airwebreathe.org.uk>)
 id 1wI8M4-00000003iOT-1VND; Wed, 29 Apr 2026 18:05:44 +0100
To: qemu-devel@nongnu.org
Cc: Stafford Horne <shorne@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Joel Holdsworth <jholdsworth@nvidia.com>
Subject: [PATCH 2/2] target/or1k: fix gen_div INT_MIN / -1 undefined behavior
Date: Wed, 29 Apr 2026 10:03:59 -0700
Message-ID: <20260429170519.2137725-3-joel@airwebreathe.org.uk>
X-Mailer: git-send-email 2.51.2
In-Reply-To: <20260429170519.2137725-1-joel@airwebreathe.org.uk>
References: <20260429170519.2137725-1-joel@airwebreathe.org.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2001:8b0:0:30::51;
 envelope-from=joel@airwebreathe.org.uk; helo=a-painless.mh.aa.net.uk
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Wed, 29 Apr 2026 16:03:09 -0400
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
Reply-to:  joel@airwebreathe.org.uk
From: joel--- via qemu development <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

From: Joel Holdsworth <jholdsworth@nvidia.com>

Signed division of INT_MIN (0x80000000) by -1 produces a result that
overflows a 32-bit signed integer.  On many host architectures (x86,
ARM) this triggers a hardware exception.  The existing code only guards
against divide-by-zero but not this case.

Add an explicit check for the INT_MIN / -1 pattern and suppress the
host-side exception by substituting a divisor of 1, setting the
overflow flag instead.

Signed-off-by: Joel Holdsworth <jholdsworth@nvidia.com>
---
 target/or1k/translate.c | 22 ++++++++++++++++++----
 1 file changed, 18 insertions(+), 4 deletions(-)

diff --git a/target/or1k/translate.c b/target/or1k/translate.c
index 1602e204fe..68d40111f0 100644
--- a/target/or1k/translate.c
+++ b/target/or1k/translate.c
@@ -279,13 +279,27 @@ static void gen_div(DisasContext *dc, TCGv_i32 dest,
                     TCGv_i32 srca, TCGv_i32 srcb)
 {
     TCGv_i32 t0 = tcg_temp_new_i32();
+    TCGv_i32 ov = tcg_temp_new_i32();
 
-    tcg_gen_setcondi_i32(TCG_COND_EQ, cpu_sr_ov, srcb, 0);
-    /* The result of divide-by-zero is undefined.
-       Suppress the host-side exception by dividing by 1. */
-    tcg_gen_or_i32(t0, srcb, cpu_sr_ov);
+    /* Check for divide-by-zero. */
+    tcg_gen_setcondi_i32(TCG_COND_EQ, ov, srcb, 0);
+
+    /* Check for INT_MIN / -1 overflow (0x80000000 / -1). */
+    TCGv_i32 t_is_min = tcg_temp_new_i32();
+    TCGv_i32 t_is_neg1 = tcg_temp_new_i32();
+    TCGv_i32 t_intmin_ov = tcg_temp_new_i32();
+
+    tcg_gen_setcondi_i32(TCG_COND_EQ, t_is_min, srca, (int32_t)0x80000000);
+    tcg_gen_setcondi_i32(TCG_COND_EQ, t_is_neg1, srcb, -1);
+    tcg_gen_and_i32(t_intmin_ov, t_is_min, t_is_neg1);
+    tcg_gen_or_i32(ov, ov, t_intmin_ov);
+
+    /* Suppress the host-side exception by dividing by 1 on overflow. */
+    tcg_gen_movcond_i32(TCG_COND_NE, t0, ov, tcg_constant_i32(0),
+                        tcg_constant_i32(1), srcb);
     tcg_gen_div_i32(dest, srca, t0);
 
+    tcg_gen_mov_i32(cpu_sr_ov, ov);
     tcg_gen_neg_i32(cpu_sr_ov, cpu_sr_ov);
     gen_ove_ov(dc);
 }
-- 
2.51.2


