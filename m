Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3826CD98D2
	for <qemu-devel@archiver.kernel.org>; Sat, 13 Jun 2026 19:53:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wYUPb-0001YA-TY; Sat, 13 Jun 2026 15:53:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wYUOx-0000sv-Jk; Sat, 13 Jun 2026 15:52:19 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wYUOv-0003Wj-Vl; Sat, 13 Jun 2026 15:52:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1781380258; bh=Og0HyygInrFZE1Y0Zj4aatklk05kvCIP9+RnLzuxhzs=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=DSj87jpEHK40KpH/stRw2uPqmbjy59FPHpnf6MFao1X9G+ZmHvdo3mtfmFG1GpPCM
 w5IjPDhC1jrQ9ehvhJ1vUHwEg5SnEUMQOBm6gmgbYoe1p168NN4iOIByqvzioBDUgQ
 +g0dDsE7o8vfx90vr3tQlJLPHC7iKzLQgONzJdefgouDOqpwWGiU9qHkxupV2MZhsU
 gC4si94G58BFnOlUgGHD6EPAsx0Ifc8f4uWWmsTmg6xDVrMolz6ouSfuDAP0SMt2Ku
 B2kr8HA6CWrrgzfZ5MlNLpoYmh+cYnCB1FGhc4bKCNuY9/kMJADU0ekI79JCUFaF7y
 q9zZsw/eb2tDQ==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id A2F5B1B6E1B;
 Sat, 13 Jun 2026 22:50:58 +0300 (MSK)
Received: from think4mjt.tls.msk.ru (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by tsrv.corpit.ru (Postfix) with ESMTP id 0706A3CE895;
 Sat, 13 Jun 2026 22:51:17 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Zishun Yi <vulab@iscas.ac.cn>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-10.0.11 12/56] target/riscv: clear mseccfg on reset for all
 dependent extensions
Date: Sat, 13 Jun 2026 22:50:26 +0300
Message-ID: <20260613195116.1807273-12-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-10.0.11-20260613224446@cover.tls.msk.ru>
References: <qemu-stable-10.0.11-20260613224446@cover.tls.msk.ru>
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

From: Zishun Yi <vulab@iscas.ac.cn>

Currently, the `mseccfg` CSR is only cleared to 0 during reset if the
`ext_smepmp` is enabled. However, this register is now shared by
several other extensions such as `zkr`, `smmpm`, and `zicfilp`.

Fix by clearing `mseccfg` if any dependent extension is present, and
adjusting the relevant comments.

This vulnerability was discovered and reported by SpecHunter, an
AI-driven architecture specification analysis tool.

Link: https://github.com/yizishun/rv-isa-sec/blob/master/output/riscv-svvptc/pr-134/qemu.txt
Signed-off-by: Zishun Yi <vulab@iscas.ac.cn>
Reviewed-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Message-ID: <20260512052240.330815-1-vulab@iscas.ac.cn>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
(cherry picked from commit 8158a74f0a0db8626d7836eb03eca7aba46c18b5)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index 2ff56bd017..9e4f54d250 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -1101,10 +1101,14 @@ static void riscv_cpu_reset_hold(Object *obj, ResetType type)
 
     /*
      * Clear mseccfg and unlock all the PMP entries upon reset.
-     * This is allowed as per the priv and smepmp specifications
-     * and is needed to clear stale entries across reboots.
+     * This is required as per the priv, smepmp, and other security
+     * extension specifications that share this CSR, and is needed
+     * to clear stale entries across reboots.
      */
-    if (riscv_cpu_cfg(env)->ext_smepmp) {
+    if (riscv_cpu_cfg(env)->ext_smepmp ||
+        riscv_cpu_cfg(env)->ext_zkr ||
+        riscv_cpu_cfg(env)->ext_smmpm ||
+        riscv_cpu_cfg(env)->ext_zicfilp) {
         env->mseccfg = 0;
     }
 
-- 
2.47.3


