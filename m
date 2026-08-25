Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0ABAEC61DC7
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2026 11:19:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wyp8t-00061q-Jj; Tue, 25 Aug 2026 07:16:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wyp8o-0005Wm-Gf; Tue, 25 Aug 2026 07:16:30 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wyp8m-0000oY-Kf; Tue, 25 Aug 2026 07:16:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1787656396; bh=knfKyi1qWgAKvsGabG0Ieqee+iGAkXDncJVIrqyfuZY=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=bRk99mA+BjhR0CdQeUiRmKX9L++nO0MNJOhZEvRwmZMcudUEM3EQWO6vW9CVpo7/Y
 28K0vJQAcHotGMByoA3pIHxa4ddSYyCwVB31EFZJh4VjQwTqPUBnFkbVddKZWOhojn
 4/EEiy8G0Rn+kJcxdVpigCw4IuTIwsmlc4D/d2jeIhPMqZ06y/u1a+QcP+r7/Zc+lh
 afy99+8wNGZBQksRPnoKoYTEwHNWK7m8kSsipvzuXf1d8uMdwgtm9xkKIaNGj6UWF6
 L2LT+kqglIm177Hkt4DtzFLwbz4IIlnQ8VxVLom76QMpBq6zdfSjE8D+CHn0RfNDS7
 XPM05LrT4IL/g==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 994D91CE4C2;
 Tue, 25 Aug 2026 14:13:16 +0300 (MSK)
Received: from gandalf.tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id B251F41628E;
 Tue, 25 Aug 2026 14:13:53 +0300 (MSK)
Received: by gandalf.tls.msk.ru (Postfix, from userid 1000)
 id BFD82325C7; Tue, 25 Aug 2026 14:13:15 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, "Christian S. Lima" <christianslima@proton.me>,
 Alistair Francis <alistair.francis@wdc.com>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-10.0.13 v3 166/166] target/riscv/tcg: sret in virtual user
 mode raises virtual instruction exception
Date: Tue, 25 Aug 2026 14:12:02 +0300
Message-ID: <20260825111206.482723-32-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-10.0.13-20260825141147@cover.tls.msk.ru>
References: <qemu-stable-10.0.13-20260825141147@cover.tls.msk.ru>
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
index c5dc18a27b9..8b2ae3a0c76 100644
--- a/target/riscv/op_helper.c
+++ b/target/riscv/op_helper.c
@@ -297,6 +297,11 @@ target_ulong helper_sret(CPURISCVState *env)
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
@@ -312,10 +317,6 @@ target_ulong helper_sret(CPURISCVState *env)
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


