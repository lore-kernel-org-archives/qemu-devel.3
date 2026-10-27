Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07CC1606A31A
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2026 15:56:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=grfQYFYk
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xLjWr-00088h-2y; Tue, 27 Oct 2026 11:56:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1xLjWY-00086B-MY
 for qemu-devel@nongnu.org; Tue, 27 Oct 2026 11:55:45 -0400
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1xLjWW-0005aA-Np
 for qemu-devel@nongnu.org; Tue, 27 Oct 2026 11:55:42 -0400
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 02B6A42AC6;
 Tue, 27 Oct 2026 15:55:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1CA5F1F01825;
 Tue, 27 Oct 2026 15:55:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793116531;
 bh=0ZPfkwD3Efjl9oAFfI7L82kv1ZC8oIEpcm83zienuYA=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=grfQYFYk3t9wbMu760vTvCMOfSwrFF+V5RnqrBYw/yX6c2Ro1LpGCZOR45kBoCMzW
 TTU7Zl67wYUH8FL7kxR1d9+fHauL7h0kax6qUGrLZb8wtl5xEc9N0zhyFvQUSscHDc
 tv7qPnNNzGiix8EA1A2wjXR2FPo9HdldNv/DcOKSek79yeprhZmbtJOCx3YdX2zcGy
 Cwcb01r2F7nZg5Cq3FHLxKtcpEUD3Y/6bKFIaUuC3TQBHPOVCvqylB5uohLQZJHCiV
 fb9PWzPZXeBJ91sb5sxx6rTPU/wPuGHdReN7fxR1RoJHiNt8GRs5OeUt6QRoe4VT4h
 JZKw/Obwz6Bgw==
From: Helge Deller <deller@kernel.org>
To: qemu-devel@nongnu.org
Cc: Helge Deller <deller@gmx.de>,
	Peter Maydell <peter.maydell@linaro.org>
Subject: [PULL 1/2] linux-user/loongarch64: In extframe_alloc,
 align before subtracting sctx_info size
Date: Tue, 27 Oct 2026 16:55:27 +0100
Message-ID: <20261027155528.5040-2-deller@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261027155528.5040-1-deller@kernel.org>
References: <20261027155528.5040-1-deller@kernel.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2600:3c0a:e001:78e:0:1991:8:25;
 envelope-from=deller@kernel.org; helo=sea.source.kernel.org
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
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
X-Spam-Status: No, score=-19.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
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
---
 linux-user/loongarch64/signal.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/linux-user/loongarch64/signal.c b/linux-user/loongarch64/signal.c
index eff75bcdc8..04015e06fd 100644
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
2.54.0


