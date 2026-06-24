Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C96B5CDE004
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jun 2026 13:44:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wcNry-0000wU-BD; Wed, 24 Jun 2026 09:42:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wcNrg-0000Zr-2e; Wed, 24 Jun 2026 09:42:04 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wcNre-0001vZ-Da; Wed, 24 Jun 2026 09:42:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1782308001; bh=C1XT6cdd60teLzTCxyeH20aD9PBFHuswDFTF+CRRc2U=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=tbSof3oqeJtpZdlcx6EPrzyJalCkg8QdtGOZYiGfC2hhPe5IlH6C9mpfZ7+NFY3+F
 WAu6imvVciWE6t5BS4iq2hAjmd83ikLI8kM5vZ8iF/xXoxCXbURuT/f6CEw4Rm/27o
 h7TqWR1C+VSZRyhV5ZiXo/tzVsHwYgz1/Nzs2z+7olwLpqk3R5CBux6VmDPgIZ17sw
 OQDbP/e1Q/foBnoffJiTDctF3bgvTPhEJkoaWEVlcXdATbcXNSyI62mDB7M/Xu/N24
 r3S+2wwwM1h9tucxHCpTfPLdUtyAn+XxIjI8hlT/X7Wkc7EbfQdHzyzLt3AcskMheX
 zzO+8UL/I5WKA==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 8F1E11BAA0D;
 Wed, 24 Jun 2026 16:33:21 +0300 (MSK)
Received: from think4mjt.tls.msk.ru (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by tsrv.corpit.ru (Postfix) with ESMTP id 2BBA13DEA5C;
 Wed, 24 Jun 2026 16:33:27 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-11.0.2 091/107] target/riscv/tcg: disable svnapot if
 satp_mode < sv39
Date: Wed, 24 Jun 2026 16:31:36 +0300
Message-ID: <20260624133301.403266-91-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-11.0.2-20260624163118@cover.tls.msk.ru>
References: <qemu-stable-11.0.2-20260624163118@cover.tls.msk.ru>
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

From: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>

We did a recent change to disable svpbmt if satp_mode < sv39 that was
discovered via a gitlab report.

This time we don't have an opened bug but the problem is similar: RISC-V
privileged ISA, chapter '"Svnapot" Extension for NAPOT Translation
Contiguity, Version 1.0' states:

"The Svnapot extension depends on the Sv39 extension."

Do the same thing with svnapot, including the user warning in case we
try to enable it without the required satp_mode:

$ ./build/qemu-system-riscv64 -M virt,dumpdtb=fdt.dtb \
     -cpu max,sv39=off,sv48=off,sv57=off,sv64=off,svnapot=on
qemu-system-riscv64: warning: svnapot requires at least satp sv39, current satp mode: none

Signed-off-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Message-ID: <20260527213034.2094103-1-daniel.barboza@oss.qualcomm.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
(cherry picked from commit 601c8494c6c7e73f5b3f30b5823de2c13c003990)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/target/riscv/tcg/tcg-cpu.c b/target/riscv/tcg/tcg-cpu.c
index 24496b0d8a..b810592daf 100644
--- a/target/riscv/tcg/tcg-cpu.c
+++ b/target/riscv/tcg/tcg-cpu.c
@@ -884,6 +884,16 @@ void riscv_cpu_validate_set_extensions(RISCVCPU *cpu, Error **errp)
                                      riscv_cpu_is_32bit(cpu)));
         }
     }
+
+    if (cpu->cfg.ext_svnapot && cpu->cfg.max_satp_mode < VM_1_10_SV39) {
+        cpu->cfg.ext_svnapot = false;
+        if (cpu_cfg_ext_is_user_set(CPU_CFG_OFFSET(ext_svnapot))) {
+            warn_report("svnapot requires at least satp sv39, "
+                        "current satp mode: %s",
+                        satp_mode_str(cpu->cfg.max_satp_mode,
+                                      riscv_cpu_is_32bit(cpu)));
+        }
+    }
 #endif
     /*
      * Disable isa extensions based on priv spec after we
-- 
2.47.3


