Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3BF6CD8C8C
	for <qemu-devel@archiver.kernel.org>; Sun,  7 Jun 2026 14:05:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wWE6p-0004Kn-2H; Sun, 07 Jun 2026 10:04:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1wWE6n-0004KP-NX
 for qemu-devel@nongnu.org; Sun, 07 Jun 2026 10:04:13 -0400
Received: from sea.source.kernel.org ([172.234.252.31])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1wWE6m-00085h-5j
 for qemu-devel@nongnu.org; Sun, 07 Jun 2026 10:04:13 -0400
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 487D241B73;
 Sun,  7 Jun 2026 14:04:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C52D1F00893;
 Sun,  7 Jun 2026 14:04:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1780841051;
 bh=J1AWjYZU/hD53VPk5IiZ2Jz6nUV+3nPhEWHBfOxyoTE=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=U+GPrPTKNQAKBXYb/dChj93Zr03RwQAYY2B2K2hgxSslrSkKKwPYzS77XTMhaCMFd
 O9vVyKKjlxJ/0q33dCkWmhLRELojdyUa6JuYRY21Luxdg9nCLBP9ZQcAwQd4qB4ZIh
 QVtwfuZkxmm0hPbNvj0kxj+MkwkeDjU9AcpU34PN34UK4P/cfGCSHtf/ZZm2B1Ll4w
 myg4jymZmF/44Z+5W2gsU9lyWStBdDISh6cOOwbVDoTKuimIGcTpy/INxqOC2EZJwi
 1KKTcxj0Qd7YLGwGbQC+t4PHoS+rQf20scjnD0JtVmwybdj89W0dR3Wn2X/hQgIXKf
 /iGoameZ8RJQA==
From: Helge Deller <deller@kernel.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Laurent Vivier <laurent@vivier.eu>,
 Yoshinori Sato <yoshinori.sato@nifty.com>,
 Max Filippov <jcmvbkbc@gmail.com>, Helge Deller <deller@gmx.de>,
 Matt Turner <mattst88@gmail.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Subject: [PATCH 05/10] linux-user/sparc: restore L/I registers from RSA in
 sparc64_set_context
Date: Sun,  7 Jun 2026 16:03:51 +0200
Message-ID: <20260607140356.10702-6-deller@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260607140356.10702-1-deller@kernel.org>
References: <20260607140356.10702-1-deller@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=172.234.252.31; envelope-from=deller@kernel.org;
 helo=sea.source.kernel.org
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Matt Turner <mattst88@gmail.com>

The kernel's do_rt_sigreturn loads L and I registers from the register
save area (RSA) at the restored O6+STACK_BIAS.  QEMU lacks the kernel's
window-fill path, so restore L0-L7 and I0-I5 explicitly from the RSA.
I6 and I7 are already restored from mc_fp/mc_i7.

Signed-off-by: Matt Turner <mattst88@gmail.com>
Cc: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Signed-off-by: Helge Deller <deller@gmx.de>
---
 linux-user/sparc/signal.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/linux-user/sparc/signal.c b/linux-user/sparc/signal.c
index d339f89928..fda5508c48 100644
--- a/linux-user/sparc/signal.c
+++ b/linux-user/sparc/signal.c
@@ -656,6 +656,24 @@ void sparc64_set_context(CPUSPARCState *env)
     __get_user(env->regwptr[WREG_FP], &(ucp->tuc_mcontext.mc_fp));
     __get_user(env->regwptr[WREG_I7], &(ucp->tuc_mcontext.mc_i7));
 
+    /*
+     * The kernel's do_rt_sigreturn loads L and I registers from the
+     * register save area (RSA) at the new O6+STACK_BIAS.  Unlike the
+     * kernel, QEMU has no kernel-mode path that triggers a window fill,
+     * so we must do it explicitly here.  I6 and I7 are already restored
+     * from mc_fp and mc_i7 above; restore L0-L7 and I0-I5 from the RSA.
+     */
+    {
+        abi_ulong sp_ptr = env->regwptr[WREG_O6];
+        /* LP64 O6 is biased (8-byte-aligned - 2047); low bit set. ILP32 O6 is 4-byte-aligned. */
+        if (sp_ptr & 3)
+            sp_ptr += TARGET_STACK_BIAS;
+        for (i = 0; i < 8; i++)
+            get_user_ual(env->regwptr[WREG_L0 + i], sp_ptr + i * 8);
+        for (i = 0; i < 6; i++)  /* I0-I5; I6=FP and I7 already restored */
+            get_user_ual(env->regwptr[WREG_I0 + i], sp_ptr + 64 + i * 8);
+    }
+
     fpup = &ucp->tuc_mcontext.mc_fpregs;
 
     __get_user(fenab, &(fpup->mcfpu_enab));
-- 
2.54.0


