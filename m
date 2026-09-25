Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 381D5C98324
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Sep 2026 09:39:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xA2OV-0000Ov-MH; Fri, 25 Sep 2026 05:39:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1xA2OP-0000Nz-1N
 for qemu-devel@nongnu.org; Fri, 25 Sep 2026 05:38:57 -0400
Received: from sea.source.kernel.org ([172.234.252.31])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1xA2ON-0006Dy-Ea
 for qemu-devel@nongnu.org; Fri, 25 Sep 2026 05:38:56 -0400
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id B44B743AA2;
 Fri, 25 Sep 2026 09:38:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A3901F000FF;
 Fri, 25 Sep 2026 09:38:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1790329133;
 bh=rukc2QXxQ5m9wxhcv1mTkjBTk1ApN+E5byqZCiijtZI=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=fTXnobhumsXoT/jb8rpe/xF1FvOpG9NJvYya97jWIYdoXXTgMxGY3SWTXA8Pj6pc3
 sdakYRCCYbz7Rz/yHbdBZxAcpXHKh9xxc/T4QK8KQNmOpLUua2V++vvc8zeceU3Skz
 u9M6Nfx0h2PkO92wdkZpiFmgM7Yp/v26fTrJy09xH4CNX9OgRQb0rfo7dl1aT6jjSJ
 7kbZmcGP46dHTryPz6HXdrc3AY//xmb10XaQ0zakl4HKTs7wEkCH7LFgGlzi39pyBr
 hA45VH3Fl1ZcaZ15ldAlSixHJQ/yOn/BN1kM6t4vmaXchPxSz185cImRlWMDG7/St6
 /vV91TJXLksaw==
From: Helge Deller <deller@kernel.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Yoshinori Sato <yoshinori.sato@nifty.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Helge Deller <deller@gmx.de>, Laurent Vivier <laurent@vivier.eu>
Subject: [PULL 3/8] linux-user/sh4: align the vdso sigreturn trampolines
Date: Fri, 25 Sep 2026 11:38:39 +0200
Message-ID: <20260925093844.5685-4-deller@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260925093844.5685-1-deller@kernel.org>
References: <20260925093844.5685-1-deller@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=172.234.252.31; envelope-from=deller@kernel.org;
 helo=sea.source.kernel.org
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

libunwind's unw_is_signal_frame() reads the trampoline as 32-bit words,
but __kernel_sigreturn is only 2-byte aligned. Align both trampolines
to 4 bytes, as the kernel's vsyscall-sigreturn.S does (with .balign 32).

Signed-off-by: Matt Turner <mattst88@gmail.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Reviewed-by: Helge Deller <deller@gmx.de>
Signed-off-by: Helge Deller <deller@gmx.de>
---
 linux-user/sh4/vdso-be.so | Bin 2720 -> 2724 bytes
 linux-user/sh4/vdso-le.so | Bin 2720 -> 2724 bytes
 linux-user/sh4/vdso.S     |   2 ++
 3 files changed, 2 insertions(+)

diff --git a/linux-user/sh4/vdso-be.so b/linux-user/sh4/vdso-be.so
index df9fa22efab46bffbb9957af078199639998ea43..d74a2d78e869d7bc6c531c36d82d6c2b1315287b 100755
GIT binary patch
delta 192
zcmZ1=x<qt>GNZ~w6=&8z3=AxPCgxO#9C@_r)US}NFAa~om)?|aoD?HG|JB4F*9C7d
zFfa%RF);8jFfe2=FtEJY{D5&c6SD?`*W`ID79tFslUWZ7C~(6dLpcNI<Yz2D!TLY|
zq)!=S$>a~L`HXKSC$QNIA<RrpPBe)yOw8N7ku8mxF=Da=monp@$u?Z-jB6&RaH)&V
PWnf@v0h<E>j35dCBc3ya

delta 172
zcmZ1?x<GV-GNZyo6=&8T3=AwkCgxO#M6Q#1zh>Q;(|ew7YO+;`jbwinsW|b+b-`;4
z3=9H73=BLB3=A0z3@k4;KVaO=#H_;LIe8w7g}`Li!vYH2Fvw6o`4!7gupSTq=}`t*
zF!>8>KI4nYDQxya2=kJY{d_D<{hT*%WlLjb44Ev$rOfzavICbo<BG`{T<VN7Cr{uK
F0RTQaF{c0k

diff --git a/linux-user/sh4/vdso-le.so b/linux-user/sh4/vdso-le.so
index decd674202260f045b646b318ebb0b6daf416651..a59c9e5244dbebd709f187028831f0a51a8b0706 100755
GIT binary patch
delta 200
zcmZ1=x<qt>0;9@AMQ7GOEDQ{PCT3QPWaXVH&gBv-40~8xYBG;6g<=1u`xAd$5xl{|
zz#zcDz#zoH!;rzi!0=}CUB=x^Y#Iy<3=CeA=doA_b26|_7C6kU0E6WWoRgojd<W}<
z03HTq1_p*dli#xDGrpM|%VsZ%Y$`)?a%6;mVNk~Ajcm!xj1iMXxs)0IOt$1wXIwKm
TkxN}-E;|E53)CnOV1%*(2DmUT

delta 193
zcmZ1?x<GV-0;9r2MQ7F@EDQ`kCT3QP{0T|D+C1g@<*pwKXS>-y?_bLI+hO95D}vWp
z7#IW?7#M^Yco;Gm7#Ln`zRS3qiA{xpfq}tu@;nv`e%8qXhq)DCuzd1MmhWI)5WvHr
z%)r3#WAaDVe8v}(6WQ!VkxgVsPA-e^_Xzgiyp=7PnK5K?B8Tu~9WDXJACqml)LB=s
YF))0b9LOm=xrR%CbtXFlLkoxp030MX^8f$<

diff --git a/linux-user/sh4/vdso.S b/linux-user/sh4/vdso.S
index 290eb498ae..a66cac7439 100644
--- a/linux-user/sh4/vdso.S
+++ b/linux-user/sh4/vdso.S
@@ -135,6 +135,7 @@ vdso_syscall __vdso_gettimeofday, __NR_gettimeofday
 	.cfi_offset		24, SC_FPSCR
 
 	nop
+	.balign	4
 
 sigreturn_region_start:
 __kernel_sigreturn:
@@ -144,6 +145,7 @@ endf __kernel_sigreturn
 	/* rt_sigreturn frame layout; nop for the same reason as above. */
 	.cfi_def_cfa_offset	RT_SIGFRAME_SC_OFFSET
 	nop
+	.balign	4
 
 __kernel_rt_sigreturn:
 	sigreturn_tramp __NR_rt_sigreturn
-- 
2.54.0


