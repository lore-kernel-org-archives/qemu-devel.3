Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B885FC55822
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Aug 2026 13:16:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wrEzy-0004ya-JN; Tue, 04 Aug 2026 09:16:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jacobly@ziglang.org>)
 id 1wr8dZ-00012B-Gx
 for qemu-devel@nongnu.org; Tue, 04 Aug 2026 02:28:29 -0400
Received: from mail.ziglang.org ([108.61.23.47])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jacobly@ziglang.org>)
 id 1wr8dY-0004Mz-30
 for qemu-devel@nongnu.org; Tue, 04 Aug 2026 02:28:29 -0400
From: Jacob Young <jacobly@ziglang.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ziglang.org; s=mail;
 t=1785824904; bh=ul7VNU7/HibLwmPtfzc1doZXoMM7nU7NsFps/KhH5ww=;
 h=From:Subject:Date:To:Cc;
 b=jxDCl3RVwLX5ThQMhQpoddbDnLgt57hPfElQ/3Ya0fbTknMeQwcU21/NOYNxULZTB
 im9mrqIsztPTg1jF8AGPv/UfTuZygqnEq5uM/ctkYnNr/WCc+uvkttyQXTC09O7aU5
 /LyREgkJtsgS7TvpRkM5d1+qWl5vHvGDNevYlnDY=
Subject: [PATCH] tcg/optimize: computes incorrect smask for some shifts
Date: Tue, 04 Aug 2026 02:27:22 -0400
Message-Id: <20260804-fix-shift-smask-v1-0-8ce16b4000d1@ziglang.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXMSwqEMBCE4atIr21IIojOVcSFj1JbGWdIqwji3
 Y26/KDqP0jhBUqf6CCPTVR+c4CNI2qGau7B0gaTMy41mUm4k511kG5h/VY6cWaRpDVyZ+EovP4
 eYfIUi/K1rvWIZrkzdJ4XkUx1o3MAAAA=
X-Change-ID: 20260803-fix-shift-smask-81e36be921e2
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>, 
 Jacob Young <jacobly@ziglang.org>
Received-SPF: pass client-ip=108.61.23.47; envelope-from=jacobly@ziglang.org;
 helo=mail.ziglang.org
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Tue, 04 Aug 2026 09:15:48 -0400
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

We were getting test failures in the Zig project test suite that only
occurred when running the test binary under qemu-i386 without passing
-one-insn-per-tb, suggesting a tcg bug.  I reduced the behavioral
difference down to:

        .globl  _start
    _start:
        movw    $0x4000, %ax
        addw    %ax, %ax
        cwtl
        shrl    %eax
        xorl    %ebx, %ebx
        cmpw    $-0x3fff, %ax
        setnl   %bl
        movl    $1, %eax
        int     $0x80

which reproduces the bug and is fixed by this patch:

    $ as --32 repro.s -o repro.o; ld -m elf_i386 repro.o -o repro
    $ ./repro; echo $?
    0
    $ qemu-i386 -one-insn-per-tb ./repro; echo $?
    0
    $ qemu-i386 ./repro; echo $?
    1
    $ ../qemu/build/qemu-i386 ./repro; echo $?
    0

Signed-off-by: Jacob Young <jacobly@ziglang.org>
---
Jacob Young (1):
      tcg/optimize: Fix s_mask computation for shifts

 tcg/optimize.c | 8 ++++++++
 1 file changed, 8 insertions(+)
---
base-commit: b428fe036233cbd15d37e3c027ab6ca4d3661a80
change-id: 20260803-fix-shift-smask-81e36be921e2

Best regards,
--  
Jacob Young <jacobly@ziglang.org>


