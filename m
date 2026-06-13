Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 790BECD8CA8
	for <qemu-devel@archiver.kernel.org>; Sat, 13 Jun 2026 20:41:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wYV6Y-0002vY-54; Sat, 13 Jun 2026 16:37:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wYV6R-0002ss-3d; Sat, 13 Jun 2026 16:37:17 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wYV6N-0003Hf-RP; Sat, 13 Jun 2026 16:37:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1781382963; bh=nBTl9hK8MG28XPQTMfA9qQqImj/KPixRdgkMHL6YTeQ=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=BTLlTV9M8gshzFOvM0cU2x4iuKUrD649JJwHJJsAPa0nPMuXIpqB2w4JLQQeL8OY4
 x+qonrGqczy7smdblq/+zjsnPaBGe8Pm51ukc7Fpdrp5LaFiXyZJvWTTvFcBh0dnOg
 8ifBqRZJNK3AHg9rbVA2V/STh/AlXpDdNUZvB1op5TqermhLtk+VxyZ0nqEqrmS8/+
 mane19jxa6xKJUUyVbBsqU6hCpE0VKsbg0kdzeTXYtvdFjLyZz2EPWyq5DlCkz6c+C
 TqWgpunOzNNGOSSZxGbBwBBvJV+8ZoF05WWSVcTuibgSoZ9eWQ2QDOw0A030GRj4/3
 R3sY/RgFmBpDQ==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 2214B1B6EE6;
 Sat, 13 Jun 2026 23:36:03 +0300 (MSK)
Received: from think4mjt.tls.msk.ru (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by tsrv.corpit.ru (Postfix) with ESMTP id 8A3563CE938;
 Sat, 13 Jun 2026 23:36:21 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Zishun Yi <vulab@iscas.ac.cn>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-11.0.2 12/72] target/riscv: clear mseccfg on reset for all
 dependent extensions
Date: Sat, 13 Jun 2026 23:34:38 +0300
Message-ID: <20260613203542.1809153-12-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-11.0.2-20260613224644@cover.tls.msk.ru>
References: <qemu-stable-11.0.2-20260613224644@cover.tls.msk.ru>
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
index 8ac935ac06..269ea35f6d 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -754,10 +754,14 @@ static void riscv_cpu_reset_hold(Object *obj, ResetType type)
 
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


