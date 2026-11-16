Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B056D606A881
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Nov 2026 20:28:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tls.msk.ru header.i=@tls.msk.ru header.a=rsa-sha256 header.s=202602 header.b=uFmbXhDX
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xT3HO-0004hT-Dj; Mon, 16 Nov 2026 15:26:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1xT3HH-0003zK-Bj; Mon, 16 Nov 2026 15:26:12 -0500
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1xT3HE-0006Oh-V6; Mon, 16 Nov 2026 15:26:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1794860763; bh=ToO/N/SNeYcWTuejJos5wip9YB6vK30C03DFVOLvRiM=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=uFmbXhDXgQW5kVPWhjr4cEGanu/+uuJkpItVF6uKSSoHsnJ+5jWUsnUHZda01daDA
 xa1ZVWC+GwsoHQHBGvlBIoEN8czKKrFazBUjzGYRiGOafb0LBzDkt1OM9sB+ptPg1a
 AjSgUECQVxtZyRzWILXtZu9gMpxFxtIX3s2JNQyVUt7hK/o6iV/fE0H4ksiNVzIWRI
 8WEcwAUJi8VRZiczyJdgN3aUN6DH9Ic9Ql0OEJJNG1zetpE8PvZIveSj3/66ApfMh9
 riDYvt+u3qga1VmLeQde67166jNAAuyOtLSSor6U4FMtrEIqZrw5JhR1kKp2r7b0wc
 5JIYIOyrw1Y0A==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 8BC591E7198;
 Mon, 16 Nov 2026 23:26:03 +0300 (MSK)
Received: from gandalf.tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id 85C5245FBC4;
 Mon, 16 Nov 2026 23:26:03 +0300 (MSK)
Received: by gandalf.tls.msk.ru (Postfix, from userid 1000)
 id 7197DB8E4C; Mon, 16 Nov 2026 23:26:03 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Bibo Mao <maobibo@loongson.cn>, Helge Deller <deller@gmx.de>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-11.1.4 03/63] linux-user/loongarch64: In extframe_alloc,
 align before subtracting sctx_info size
Date: Mon, 16 Nov 2026 23:24:42 +0300
Message-ID: <20261116202554.535325-3-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-11.1.4-20261116212645@cover.tls.msk.ru>
References: <qemu-stable-11.1.4-20261116212645@cover.tls.msk.ru>
X-Archived-By: <archiver.kernel.org>
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
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Peter Maydell <peter.maydell@linaro.org>

In extframe_alloc() we allocate space on the guest stack for a
context struct, which consists of a target_sctx_info plus a more
specific struct such as target_lasx_context.  The specific struct may
have a higher alignment requirement than the basic target_sctx_info.

The Linux kernel code for this is in arch/loongarch/kernel/signal.c
in extframe_alloc():

       unsigned long new_base = base - size;

       new_base = round_down(new_base, (align < 16 ? 16 : align));
       new_base -= sizeof(struct sctx_info);

and it first adjusts the base (SP) address down by the size of the
specific struct, then rounds that down to provide the required
alignment, and finally subtracts the size of the sctx_info.

QEMU's version does this in the wrong order, subtracting both the
specific struct size and the sctx_info size before rounding down for
alignment.  This means that for the target_lasx_context which needs
32-alignment, we instead give the start of sctx_info 32-alignment,
which (since that is 16 bytes long) means that the
target_lasx_context is only 16-aligned.

This manifests as a failure in the TCG tests such as
loongarch64-linux-user-signals.test if you build with the clang
sanitizers enabled:

../../linux-user/loongarch64/signal.c:182:13: runtime error: member access within misaligned address 0x7dc793950b90 for type 'struct target_lasx_context', which requires 32 byte alignment
0x7dc793950b90: note: pointer points here
 00 00 00 00  00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  00 00 00 00
              ^
    #0 0x57216113d881 in setup_sigframe /home/pm215/qemu/build/clang/../../linux-user/loongarch64/signal.c:182:13
    #1 0x57216113d881 in setup_rt_frame /home/pm215/qemu/build/clang/../../linux-user/loongarch64/signal.c:389:5
    #2 0x5721612a5041 in handle_pending_signal /home/pm215/qemu/build/clang/../../linux-user/signal.c:1349:9
    #3 0x5721612a46ef in process_pending_signals /home/pm215/qemu/build/clang/../../linux-user/signal.c:1401:17
    #4 0x57216113baa3 in cpu_loop /home/pm215/qemu/build/clang/../../linux-user/loongarch64/cpu_loop.c:121:9

Correct setup_extcontext() to match the order the kernel does it.

Cc: qemu-stable@nongnu.org
Fixes: 9d5cd6587a70d613 ("linux-user: Add LoongArch signal support")
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Bibo Mao <maobibo@loongson.cn>
Signed-off-by: Helge Deller <deller@gmx.de>
(cherry picked from commit c341f8ce205ff931e12df857fb69f4c87172bdbb)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/linux-user/loongarch64/signal.c b/linux-user/loongarch64/signal.c
index eff75bcdc86..04015e06fda 100644
--- a/linux-user/loongarch64/signal.c
+++ b/linux-user/loongarch64/signal.c
@@ -111,9 +111,10 @@ static abi_ptr extframe_alloc(struct extctx_layout *extctx,
 {
     abi_ptr sp = orig_sp;
 
-    sp -= sizeof(struct target_sctx_info) + size;
+    sp -= size;
     align = MAX(align, CONTEXT_INFO_ALIGN);
     sp = ROUND_DOWN(sp, align);
+    sp -= sizeof(struct target_sctx_info);
     sctx->gaddr = sp;
 
     size = orig_sp - sp;
-- 
2.47.3


