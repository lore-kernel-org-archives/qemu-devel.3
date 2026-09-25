Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A108C9830E
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Sep 2026 09:39:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xA2OT-0000OT-2S; Fri, 25 Sep 2026 05:39:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1xA2OM-0000NF-Bx
 for qemu-devel@nongnu.org; Fri, 25 Sep 2026 05:38:54 -0400
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1xA2OK-0006DS-LO
 for qemu-devel@nongnu.org; Fri, 25 Sep 2026 05:38:53 -0400
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id EABDD60230;
 Fri, 25 Sep 2026 09:38:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2395E1F000FF;
 Fri, 25 Sep 2026 09:38:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1790329131;
 bh=GKPRmJ+Lm+CKy/mUbJzqSr1KpZBNcPrYdh01jZ5K3cw=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=Gv3e1+cJSMcjOojFxAJFLcnNdZVkRv5tWWEqYR8oirTzzTZgjIDTaQR3D8aYOBFlI
 ZmYY6EGJNfdfSDVrmTVJa3FB0GaqC6XA1Wf8/0NXXojN5F0cJ4LS0ZhxolN57q339h
 st/Bsg41rM/l6EtW1FDvzAvDT+SUBhHh8k1gGapWvN9Md3B51PaJ+D4oj1/0LhVQVi
 g5PFF9VsCxcp46d/c+DmJWCRsFeNIyRko0LGXooxKkdy/rhWO8w8bJXDIALZoYiKHK
 gP0/Px0Xqws832P/vldig13Miuprro9oIBzUSF2LNhc0zVULlZqghSgyPLsINcjf0Z
 F/RLRijyla8fw==
From: Helge Deller <deller@kernel.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Yoshinori Sato <yoshinori.sato@nifty.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Helge Deller <deller@gmx.de>, Laurent Vivier <laurent@vivier.eu>
Subject: [PULL 2/8] linux-user/sh4: fix vdso CFA for rt_sigreturn frames
Date: Fri, 25 Sep 2026 11:38:38 +0200
Message-ID: <20260925093844.5685-3-deller@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260925093844.5685-1-deller@kernel.org>
References: <20260925093844.5685-1-deller@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2600:3c04:e001:324:0:1991:8:25;
 envelope-from=deller@kernel.org; helo=tor.source.kernel.org
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

The unwinder looks up a return address as IP - 1 (hence the nop before
sigreturn_region_start). For a frame returning to __kernel_rt_sigreturn
that is the last byte of __kernel_sigreturn, which still has the
sigreturn CFA, so the rt_sigreturn frame is unwound with the wrong
sigcontext offset. _Unwind_Backtrace() from an SA_SIGINFO handler stops
after three frames.

Add a nop after .cfi_def_cfa_offset, as linux-user/i386/vdso.S does.

Fixes: 975bd51a88 ("linux-user/sh4: add VDSO support for sh4 and sh4eb")
Cc: qemu-stable@nongnu.org
Signed-off-by: Matt Turner <mattst88@gmail.com>
Reviewed-by: Helge Deller <deller@gmx.de>
Signed-off-by: Helge Deller <deller@gmx.de>
---
 linux-user/sh4/vdso-be.so | Bin 2720 -> 2720 bytes
 linux-user/sh4/vdso-le.so | Bin 2720 -> 2720 bytes
 linux-user/sh4/vdso.S     |   3 ++-
 3 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/linux-user/sh4/vdso-be.so b/linux-user/sh4/vdso-be.so
index bc1fb37e1089b7aa5612da0039e24193b156b3d8..df9fa22efab46bffbb9957af078199639998ea43 100755
GIT binary patch
delta 94
zcmZ1=x<GWo6OqVuQt#KSJ9B!^(@jmb3bB#wuObyE{&>##V)FyW-As%sljpE_2{CX^
vW<4yRzzu^8YbPf%icjWeeZcr*@(0#@#ut+l*u2^Nd@N1<oHuV|d(R92IA0@3

delta 94
zcmZ1=x<GWo6Op!OLQF3#0+d8#l(nNCM8CN5&G7ofAI}+|ZGOPGn~70r@*EZ~p~<X=
u1r)epkYOzY=j232@yYzG4;a5q{=k~g_-t|ln>SlhXr*UW(&mk9@0kI)8X|`P

diff --git a/linux-user/sh4/vdso-le.so b/linux-user/sh4/vdso-le.so
index c1ff560cc165413d7b07aa873225bd92afb8569e..decd674202260f045b646b318ebb0b6daf416651 100755
GIT binary patch
delta 93
zcmZ1=x<GWo6Olh5saKn)T)*7)W8rK!`{(^j`F=Z0{PBeG#pb(=yO|hOCeLK?735@K
uoh)#eTLA{wPEKSLoy^1ffbqxVx2*Y$FDA#b`LUHn_<IEVZ{EoEo*4j_?<GY5

delta 93
zcmZ1=x<GWo6Op|ikGEYj60C8&_)xA>#wX*~i%pXz{&>RpZ1Y{l-As&1lV`H{3bIZX
uILxg8gKHT$CnqwBPUc~K!1!(QTh@HWXOm;u{Md{<Esc#+H*aKn&kO)kh$G_w

diff --git a/linux-user/sh4/vdso.S b/linux-user/sh4/vdso.S
index 1faa665774..290eb498ae 100644
--- a/linux-user/sh4/vdso.S
+++ b/linux-user/sh4/vdso.S
@@ -141,8 +141,9 @@ __kernel_sigreturn:
 	sigreturn_tramp __NR_sigreturn
 endf __kernel_sigreturn
 
-	/* Update CFA base for the rt_sigreturn frame layout. */
+	/* rt_sigreturn frame layout; nop for the same reason as above. */
 	.cfi_def_cfa_offset	RT_SIGFRAME_SC_OFFSET
+	nop
 
 __kernel_rt_sigreturn:
 	sigreturn_tramp __NR_rt_sigreturn
-- 
2.54.0


