Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E091CDB479
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jun 2026 05:14:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wcFrl-00044q-Ag; Wed, 24 Jun 2026 01:09:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wcFqb-0002uf-7y; Wed, 24 Jun 2026 01:08:27 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wcFqW-0005pi-VV; Wed, 24 Jun 2026 01:08:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1782277622; bh=bEJwbZH2Ng3U2UqlGmEAoVUd6jBA72yoLTfhhUkvOQc=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=fZ9X9dPJlLHg8QFUBIc0+fNv+yHjzJeUDV2+ypy7YLUruCDofqzofV0MEgoK7BeVp
 9D7IB3a7frGduNCoDhVAU3NmYR4Watxbku0PQxnzc0XTUUJu5Fm7aSw7QN1TbZbmIJ
 b6cKjYJq46JX/Z5D8GoZzz9f1ZwOU7FGiZNoyJSc48py1FkA9+YGj0Y6aktVX3RCPd
 sFF2Wgu+/2A5wuyc7r94AbRRdzM1dr/YHZ/6QjF112OktuwFuCIfI+89lOD5R3uB20
 xqqTC8Yj4JamBeuWXayU6QA3EfwL4a6Zcjet+9G22F6LFfBPQlxvlBc/ZvMLTXjYwQ
 XJNXDLEA3KTYQ==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id D5E4E1BA667;
 Wed, 24 Jun 2026 08:07:02 +0300 (MSK)
Received: from think4mjt.tls.msk.ru (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by tsrv.corpit.ru (Postfix) with ESMTP id BF5833DDB04;
 Wed, 24 Jun 2026 08:07:07 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Chao Liu <chao.liu.zevorn@gmail.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-10.2.4 73/95] target/riscv/tcg: disable svpbmt if satp_mode <
 sv39
Date: Wed, 24 Jun 2026 08:05:08 +0300
Message-ID: <20260624050541.395079-12-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-10.2.4-20260624080454@cover.tls.msk.ru>
References: <qemu-stable-10.2.4-20260624080454@cover.tls.msk.ru>
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

Priv spec chapter "Svpbmt Extension for Page-Based Memory Types, Version
1.0" mentions that "The Svpbmt extension depends on the Sv39
extension.".

We're not doing any satp checks when enabling svpbmt.  This causes
problems with the riscv32 'max' CPU that happens to be enabling svpbmt
even though it doesn't support the required satp mode.  In fact all rv32
CPUs are allowing menvcfg.PBMTE writes, which doesn't make sense for
them in any circunstance since svpbmt is not possible for rv32 at this
moment [1].

This also impacts rv64 CPUs that are running in satp 'bare' mode and are
reporting svpbmt in the riscv,isa.

All these problems can be solved by disabling svpbmt if satp_mode is not
at least sv39.  The problem reported in [1] goes away because we'll
never enable MENVCFG_PBMTE write mask in write_menvcfgh().  We're also
become consistent with how svpbmt is enabled for rv64.

In case the user enables svpbmt in the command line using an invalid setup,
not just disable svpbmt but also throw a warning:

$ ./build/qemu-system-riscv64 -M virt,dumpdtb=fdt.dtb \
    -cpu max,sv39=off,sv48=off,sv57=off,sv64=off,svpbmt=on
qemu-system-riscv64: warning: svpbmt requires at least satp sv39, current satp mode: none

[1] https://gitlab.com/qemu-project/qemu/-/work_items/3473

Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3473
Signed-off-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Reviewed-by: Chao Liu <chao.liu.zevorn@gmail.com>
Message-ID: <20260519114858.316532-1-daniel.barboza@oss.qualcomm.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
(cherry picked from commit 109856754cbd4c98db49e67071b620945a4ee2a9)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/target/riscv/tcg/tcg-cpu.c b/target/riscv/tcg/tcg-cpu.c
index 22ced1ed1b..c4dfa4ac09 100644
--- a/target/riscv/tcg/tcg-cpu.c
+++ b/target/riscv/tcg/tcg-cpu.c
@@ -861,6 +861,17 @@ void riscv_cpu_validate_set_extensions(RISCVCPU *cpu, Error **errp)
         return;
     }
 
+#ifndef CONFIG_USER_ONLY
+    if (cpu->cfg.ext_svpbmt && cpu->cfg.max_satp_mode < VM_1_10_SV39) {
+        cpu->cfg.ext_svpbmt = false;
+        if (cpu_cfg_ext_is_user_set(CPU_CFG_OFFSET(ext_svpbmt))) {
+            warn_report("svpbmt requires at least satp sv39, "
+                        "current satp mode: %s",
+                        satp_mode_str(cpu->cfg.max_satp_mode,
+                                     riscv_cpu_is_32bit(cpu)));
+        }
+    }
+#endif
     /*
      * Disable isa extensions based on priv spec after we
      * validated and set everything we need.
-- 
2.47.3


