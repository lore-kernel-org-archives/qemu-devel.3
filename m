Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C932C61DBD
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2026 09:06:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wyn6v-0003aE-CM; Tue, 25 Aug 2026 05:06:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wyn6u-0003Zd-A5; Tue, 25 Aug 2026 05:06:24 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wyn6s-0003t0-IQ; Tue, 25 Aug 2026 05:06:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1787648560; bh=DIt1ONs+QNdCyTuajRNes8DO8mI5jBcrhgVvTyYnOF8=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=BiEUafjG4i3TgSXGlYbsj5Qh0THi2j4tlRJ9mniAxdg3Uey0TZeAmlyR39gGL0VBI
 pUHwivCJjaEZU05p2syVLKsctqNBNkmHAErApijd6pM58z+g2BieWqGwzELrEF/8VI
 knkX0F4a6aFmsv4AtxCwS1GsbLcwuRYqZy+ZwNvwHI8x+T9rSMgwFwdR56jX6SIAA3
 vxp6iXgqI6ZY1+auZ48hIy6FG4Kcinl8loqjYvpyweSeStgISSa4os8wH1vv4xLjsv
 W67k9Rm+/Q4Z9uDEEdVDq94IRnhvUSsQDkDoK2zmhlOfnh7yQxhliNou3w/w2UQ5U6
 uGdr4QXqUremg==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id DC1491CE3CE;
 Tue, 25 Aug 2026 12:02:40 +0300 (MSK)
Received: from gandalf.tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id C8F0E416190;
 Tue, 25 Aug 2026 12:03:17 +0300 (MSK)
Received: by gandalf.tls.msk.ru (Postfix, from userid 1000)
 id 241B832585; Tue, 25 Aug 2026 12:02:40 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, "Christian S. Lima" <christianslima@proton.me>,
 Alistair Francis <alistair.francis@wdc.com>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-11.0.4 v3 196/196] target/riscv/tcg: sret in virtual user
 mode raises virtual instruction exception
Date: Tue, 25 Aug 2026 12:01:53 +0300
Message-ID: <20260825090157.471948-35-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-11.0.4-20260825115401@cover.tls.msk.ru>
References: <qemu-stable-11.0.4-20260825115401@cover.tls.msk.ru>
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

From: "Christian S. Lima" <christianslima@proton.me>

Currently, when a `sret` is executed in virtual user mode, qemu
raise an `illegal instruction exception`, but in this case the correct
behavior is to raise a `virtual instruction exception` and the code
already contains a check to it, but it's not enough to catch. This
patch is useful to improve the correctness of the virtualization of
the risc v architecture.

Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3622

Signed-off-by: Christian S. Lima <christianslima@proton.me>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Message-ID: <20260808031849.59726-1-christianslima@proton.me>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
(cherry picked from commit 85d38315fd19cda7fcfec5350f27cdfa15742600)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/target/riscv/op_helper.c b/target/riscv/op_helper.c
index 83d7023d075..be62690d52d 100644
--- a/target/riscv/op_helper.c
+++ b/target/riscv/op_helper.c
@@ -319,6 +319,11 @@ target_ulong helper_sret(CPURISCVState *env)
     const target_ulong src_priv = env->priv;
     const bool src_virt = env->virt_enabled;
 
+    if ((env->virt_enabled && env->priv < PRV_S) ||
+        (env->virt_enabled && get_field(env->hstatus, HSTATUS_VTSR))) {
+        riscv_raise_exception(env, RISCV_EXCP_VIRT_INSTRUCTION_FAULT, GETPC());
+    }
+
     if (!(env->priv >= PRV_S)) {
         riscv_raise_exception(env, RISCV_EXCP_ILLEGAL_INST, GETPC());
     }
@@ -334,10 +339,6 @@ target_ulong helper_sret(CPURISCVState *env)
         riscv_raise_exception(env, RISCV_EXCP_ILLEGAL_INST, GETPC());
     }
 
-    if (env->virt_enabled && get_field(env->hstatus, HSTATUS_VTSR)) {
-        riscv_raise_exception(env, RISCV_EXCP_VIRT_INSTRUCTION_FAULT, GETPC());
-    }
-
     mstatus = env->mstatus;
     prev_priv = get_field(mstatus, MSTATUS_SPP);
     mstatus = set_field(mstatus, MSTATUS_SIE,
-- 
2.47.3


