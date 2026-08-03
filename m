Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BBA64C55196
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Aug 2026 21:02:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wqznB-0006Ti-Em; Mon, 03 Aug 2026 17:01:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1wqzn7-0006TS-7W
 for qemu-devel@nongnu.org; Mon, 03 Aug 2026 17:01:45 -0400
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1wqzn5-0000Aj-EV
 for qemu-devel@nongnu.org; Mon, 03 Aug 2026 17:01:44 -0400
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 1168360A59;
 Mon,  3 Aug 2026 21:01:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A3C831F000E9;
 Mon,  3 Aug 2026 21:01:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1785790898;
 bh=bY2KJIhnhmWBex2exMsEUUldtupO89FVahXGNRIrCsM=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=BsiCGo9T97MlsPmg3cX14PI61kE4eJQEhV6pRB8xn0u9BDGZ3fdKSzLzH6BAPuy0s
 CyoToC5kY57eT3Q8hbKjcWbA/RnsDkmp+atDuJEhNi/LUSTEWkf+jYBBWOj+70ckRC
 amoOwF+DfYBlK1Lz4Rx1/MkEgtFzhXTL9Dq/8FjoNtxk1WEIG0A2A05yVMsD1RIzeK
 o8Gfxvf7Bx+DGZ1d9YlgJizWTtYTNUVA9Mzd61dIXkECY2k8WLScRbeCX8RxEE7Akq
 HLVUlRqTZsyqulZz0hvX921HsezwvDxYb4lB7j+YnpeHVpogTQ/OA9fkzkJbt4xih0
 ZeCG1Pk2PjAhg==
Date: Mon, 3 Aug 2026 23:01:35 +0200
From: Helge Deller <deller@kernel.org>
To: Andreas Schwab <schwab@linux-m68k.org>,
 Peter Maydell <peter.maydell@linaro.org>
Cc: Helge Deller <deller@gmx.de>, qemu-devel@nongnu.org
Subject: Re: [PATCH] linux-user: Fix msqid_ds struct wrt 32-bit big endian
 architectures
Message-ID: <anEBr8nK-4nKmuXj@p100>
References: <20260728192913.61279-1-deller@kernel.org>
 <CAFEAcA_8o2A8FDsJKacde+pdj4HzA5c7aTw=k7tmONYXD4=c_w@mail.gmail.com>
 <244987da-f6d8-47a8-ac4a-16a71c660e36@gmx.de>
 <CAFEAcA9F8rauUNc2NAqbnf1f7-0O_ivft1XOftwt1hW0YWeeJw@mail.gmail.com>
 <a8c13cdc-54c3-4913-bc6e-956cbfe082cb@gmx.de>
 <87ecgfkrg9.fsf@igel.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87ecgfkrg9.fsf@igel.home>
Received-SPF: pass client-ip=2600:3c04:e001:324:0:1991:8:25;
 envelope-from=deller@kernel.org; helo=tor.source.kernel.org
X-Spam_score_int: -28
X-Spam_score: -2.9
X-Spam_bar: --
X-Spam_report: (-2.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.811,
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

* Andreas Schwab <schwab@linux-m68k.org>:
> On Aug 01 2026, Helge Deller wrote:
> 
> > m68k could be a problem.
> > The other big-arches seem to be handled correctly by the kernel:
> > arch/sparc/include/uapi/asm/msgbuf.h:struct msqid64_ds {
> > arch/parisc/include/uapi/asm/msgbuf.h:struct msqid64_ds {
> > arch/xtensa/include/uapi/asm/msgbuf.h:struct msqid64_ds {
> > arch/x86/include/uapi/asm/msgbuf.h:struct msqid64_ds {
> > arch/powerpc/include/uapi/asm/msgbuf.h:struct msqid64_ds {
> > arch/mips/include/uapi/asm/msgbuf.h:struct msqid64_ds {
> > arch/mips/include/uapi/asm/msgbuf.h:struct msqid64_ds {
> > arch/mips/include/uapi/asm/msgbuf.h:struct msqid64_ds {
> 
> glibc commit 9f9feb6d5d says:
> 
>     * Some older 32-bit big-endian architectures have padding before
>       rather than after time fields, although the preferred generic
>       approach is padding after the time fields independent of endianness.
> 
> and m68k uses the "preferred" approach.

Thanks for the info, Andreas!
The msgctl01 LTP testcase does work correctly on a physical m68k
machine for me, so glibc/kernel seems ok, esp. regarding msqid64_ds.

Regarding qemu linux-user the patch below seems to fix the LTP msgctl01
testcase in my m68k qemu chroot. Peter, do you mind reviewing the patch?

Helge
-------

From: Helge Deller <deller@gmx.de>
Date: Mon, 3 Aug 2026 22:49:46 +0200
Subject: [PATCH] linux-user: Fox msqid64_ds for 32-bit big endian m68k target

On some older 32 bit big-endian architectures (like m68k) the 64-bit time
fields of msqid64_ds is a pair of unsigned long values, where the lower
half is in the wrong place. Adjust the target_swap_time64() macro
accordingly.

Fixes: 9e3df3019d21 ("linux-user: Fix msqid_ds struct wrt 32-bit big endian architectures")
Noticed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Helge Deller <deller@gmx.de>

diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index dc028686f4..1a18fea52d 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -4217,7 +4217,16 @@ static inline abi_long do_semtimedop(int semid,
 #endif
 
 #define target_time64_t         abi_ullong
-#define target_swap_time64(x)   tswap64(x)
+/*
+  * On some older 32 bit big-endian architectures (like m68k) the 64-bit time
+  * fields of msqid64_ds is a pair of unsigned long values, where the lower
+  * half is in the wrong place.
+ */
+#ifdef TARGET_M68K
+# define target_swap_time64(x)   (tswap32(x) | (((uint64_t)tswap32((x) >> 32)) << 32))
+#else
+# define target_swap_time64(x)   tswap64(x)
+#endif
 
 struct target_msqid_ds
 {

