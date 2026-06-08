Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9671CD6E79
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jun 2026 19:43:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wWfsW-0008UE-S2; Mon, 08 Jun 2026 15:43:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1wWfsQ-0008Sw-F4
 for qemu-devel@nongnu.org; Mon, 08 Jun 2026 15:43:17 -0400
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1wWfsP-0006CQ-3D
 for qemu-devel@nongnu.org; Mon, 08 Jun 2026 15:43:14 -0400
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id C2F4E601E6;
 Mon,  8 Jun 2026 19:43:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9716C1F00893;
 Mon,  8 Jun 2026 19:43:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1780947791;
 bh=J1AWjYZU/hD53VPk5IiZ2Jz6nUV+3nPhEWHBfOxyoTE=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=R2ivfNzxfXIQU7w3syeCZjx/mD67o8bbckXdY7IkpctPu9KU/AdVWS1U14xqNUyAt
 2wkQaM+69x7so/DFtjuSUisczfIIJEzAzeszrGoalt23up+35THKjMjJV9Vp3rVEgJ
 7ew+eW5DmEMn8CdUhe/T/aPyCl/4QttQqK0gS+bAbhyR9c0MHZsibGfXTO4BNoORnu
 uHN5Gln+NQeeme5h4o4vfRRI49GUaHma6CmVCC2Igl/fXX0/y+gvl79W6kn3gxgg0W
 mg90XcCljkuD7rajW6vkkAhuR5MLuKczHcFf0Xb9ORQiIKXBGKlm9T0l+nBrhpHpRM
 trbNU3FuqRMug==
From: Helge Deller <deller@kernel.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Max Filippov <jcmvbkbc@gmail.com>, Helge Deller <deller@gmx.de>,
 Yoshinori Sato <yoshinori.sato@nifty.com>,
 Laurent Vivier <laurent@vivier.eu>, Matt Turner <mattst88@gmail.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Subject: [PULL 5/8] linux-user/sparc: restore L/I registers from RSA in
 sparc64_set_context
Date: Mon,  8 Jun 2026 21:42:53 +0200
Message-ID: <20260608194256.13794-6-deller@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260608194256.13794-1-deller@kernel.org>
References: <20260608194256.13794-1-deller@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2600:3c04:e001:324:0:1991:8:25;
 envelope-from=deller@kernel.org; helo=tor.source.kernel.org
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


