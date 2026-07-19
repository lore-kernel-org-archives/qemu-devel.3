Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43C41C4450A
	for <qemu-devel@archiver.kernel.org>; Sun, 19 Jul 2026 07:48:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wlMGE-0007Sv-9w; Sun, 19 Jul 2026 03:48:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <functioner@sjtu.edu.cn>)
 id 1wlMG5-0007SB-Df
 for qemu-devel@nongnu.org; Sun, 19 Jul 2026 03:48:23 -0400
Received: from smtp186.sjtu.edu.cn ([202.120.2.186])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <functioner@sjtu.edu.cn>)
 id 1wlMG0-00053t-T5
 for qemu-devel@nongnu.org; Sun, 19 Jul 2026 03:48:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=sjtu.edu.cn;
 s=default; t=1784447283;
 bh=/O/vxbwpXbZXYbSCQBNEYQGtcjTBlPDztYZMNvB9RGw=;
 h=From:To:Cc:Subject:Date;
 b=a/leCE+9nqNJ2wYCFYw6M8qinKD+2oGZuix9f03FWc495+wzoTciIDW1yXaSc6ZYP
 N+6ROsXj9+VIRLPH56G967lnFh6NVeI+9TxIqRmdCwA1EwbHe57i8jPd3iuwY4TnzV
 /ETYUemUb8ytfdRqgmv5RCzwZOxFJk1/K6xk8u8ctsJ2hdX0/eN1vh9Y2aiHfVVgS1
 fQntUQgio+Wa+syt3MEyPSammdgDXhP0mP4vi2+wl35vB9Y5ZwhvU519ZKjWta8J+2
 lGN61ckVanQdYeaqIuT5SfyO2R+/s4EMKhhFUFR6hNhDBH7pvA1wU+wfy+PubQ4LHK
 3EIEHXpV0dsCQ==
Received: from proxy188.sjtu.edu.cn (smtp188.sjtu.edu.cn [202.120.2.188])
 by smtp186.sjtu.edu.cn (Postfix) with ESMTPS id 57E382FF3F5;
 Sun, 19 Jul 2026 07:48:03 +0000 (UTC)
Received: from pc.. (unknown [202.120.40.100])
 by proxy188.sjtu.edu.cn (Postfix) with ESMTPSA id 2248A37C8CA;
 Sun, 19 Jul 2026 15:47:32 +0800 (CST)
From: Ziyang Zhang <functioner@sjtu.edu.cn>
To: qemu-devel <qemu-devel@nongnu.org>
Cc: Riku Voipio <riku.voipio@iki.fi>, Laurent Vivier <laurent@vivier.eu>,
 Alex Bennee <alex.bennee@linaro.org>, Alexandre Iooss <erdnaxe@crans.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Florian Hofhammer <florian.hofhammer@epfl.ch>,
 Richard Henderson <richard.henderson@linaro.org>,
 Zhengwei Qi <qizhwei@sjtu.edu.cn>, Yun Wang <yunwang94@sjtu.edu.cn>,
 Mingyuan Xia <xiamy@ultrarisc.com>, Kailiang Xu <xukl2019@sjtu.edu.cn>,
 Ziyang Zhang <functioner@sjtu.edu.cn>
Subject: [PATCH 0/3] dlcall: correct the syscall number claim and the guest
 requirements
Date: Sun, 19 Jul 2026 15:47:27 +0800
Message-Id: <20260719074730.1520517-1-functioner@sjtu.edu.cn>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=202.120.2.186;
 envelope-from=functioner@sjtu.edu.cn; helo=smtp186.sjtu.edu.cn
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

Hi,

Three small follow-ups to the dlcall plugin merged for 11.1. There is no
functional change: all of them are comment and documentation fixes.

The first one matters most. The plugin picks 4096 as its magic syscall number,
and the comment justified that by saying every Linux ABI keeps its syscall
numbers well below it. That is not true for MIPS O32, which bases its numbering
at 4000, so 4000 + 96 is a real getpriority. Loading the plugin on such a guest
would let the filter consume a legitimate getpriority() and read its arguments
as a dlcall request, where the first one selects an operation and the second is
taken as a string pointer.

Raising the number does not rescue that case, which is the part I had wrong at
first. O32 answers numbers its table does not define with ENOSYS in cpu_loop(),
before do_syscall() and therefore before the filter, so on O32 there is no
number that is both free and reachable. Its N32 and N64 ABIs base at 6000 and
5000 and have no such gate, so they are unaffected.

I checked this under qemu-mips rather than only reading cpu_loop(), using a
plugin that logs what its syscall filter receives. A plain getpriority() from
the guest arrives at the filter as num=4096 a1=0, which is what dlcall would
read as an operation ID with a NULL key, while syscall(8192, ...) returns
ENOSYS and never reaches the filter at all.

There is an upper bound elsewhere too. arm32 answers anything past ARM_NR_BASE
(0xf0000) with ENOSYS or SIGILL before do_syscall(), as the comment in
tests/tcg/multiarch/test-plugin-syscall-filter.c already notes, so a large
number is not a safe default either. 4096 sits below that and above the
ordinary syscall numbers, which is why it works on the targets people use this
with.

That test carried the same wrong reason, so the second patch corrects it. It
picked 4096 believing no ISA uses the number, when what actually keeps it safe
is that the filter matches on the first argument as well: a real syscall
carrying this number falls through untouched. tests/tcg/plugins/setpc.c matches
on the number alone, which works for the single test program it is loaded with,
but the collision applies there too, so neither test shows that 4096 is free.

I have deliberately not changed the default, nor restricted which guests may
load the plugin. The number is already configurable with syscall_num=N, and
dlcall is generic infrastructure rather than something tied to one userspace
project, so it should not decide which guest architectures people may
experiment with. What was wrong here was the reasoning in the comments, so they
now describe what a target actually does with the number.

The last patch extends the guest_base == 0 warning, since the guest must match
the host's pointer width and endianness as well, and tidies two things in the
prose: a library is not turned into thunks but has thunks produced for it, and
argument marshalling, callbacks and variadic functions belong with Lorelei
rather than in the plugin's description, since they are precisely what it does
not do.

Also in the first patch, two out pointers were dereferenced without the assert
the others carry.

Thanks,
Ziyang Zhang

Ziyang Zhang (3):
  contrib/plugins/dlcall: correct the syscall number claim, note the
    data model
  tests/tcg: correct why the magic syscall number is safe here
  docs/about/emulation: sharpen the dlcall boundary and its guest
    requirements

 contrib/plugins/dlcall.c                      | 32 +++++++++++++------
 docs/about/emulation.rst                      | 31 ++++++++++++------
 .../multiarch/test-plugin-syscall-filter.c    |  9 ++++--
 3 files changed, 50 insertions(+), 22 deletions(-)

-- 
2.34.1


