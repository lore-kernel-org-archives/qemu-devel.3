Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 052F4C2BD09
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Jun 2024 04:28:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sMgjU-0006w0-NJ; Thu, 27 Jun 2024 00:27:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brad@comstyle.com>)
 id 1sMgjT-0006vk-ET; Thu, 27 Jun 2024 00:27:39 -0400
Received: from speedy.comstyle.com ([2607:f938:3000:8::2]
 helo=mail.comstyle.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_CHACHA20_POLY1305:256)
 (Exim 4.90_1) (envelope-from <brad@comstyle.com>)
 id 1sMgjR-0004v5-Sf; Thu, 27 Jun 2024 00:27:39 -0400
Received: from mail.comstyle.com (localhost [127.0.0.1])
 by mail.comstyle.com (Postfix) with ESMTP id 4W8lsh3YQYz8PbP;
 Thu, 27 Jun 2024 00:27:36 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=comstyle.com; h=date
 :from:to:cc:subject:message-id:mime-version:content-type; s=
 default; bh=uBlLsb/lrFJPHUPLa8b6ZjT2KRYKEfy6nKawxyw2neI=; b=TsJH
 ErGg+QVmyVE9oGRXllORTw7HdGYTAU/HhGoar0h/IKUV5eSkBXDzyr4RtuZ4d41s
 vyBnNaX1nkpDeo9TT2jPReFf/GFl/psZiMMtoZabJPsn66xlN0wvFcxwmfboegbJ
 X5h23V9lBSnK22G6pGWTeGDV8aTSyTJ2OUmgAeA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=comstyle.com; h=date:from:to
 :cc:subject:message-id:mime-version:content-type; q=dns; s=
 default; b=Shxpgp7y82J4MoLOCBu7rsLoWy1Q2tp7QDHyQ/0vHF0xdvjUUkPAd
 uxhrS9JI+33FsXujfMhZ6hXN2j5Y2YwtFeBVBEzRXol0EePINDBf35AbAHq6IwRQ
 fLSm/9OjLBEQNk31RRAVc2+ry57Slbstkx9wqDTvHVtXwwAR8TsQHE=
Received: from humpty.home.comstyle.com (unknown
 [IPv6:2001:470:b050:3:6ab7:8ff0:603e:f824])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA512)
 (No client certificate requested) (Authenticated sender: brad)
 by mail.comstyle.com (Postfix) with ESMTPSA id 4W8lsh1RqFz8PbN;
 Thu, 27 Jun 2024 00:27:36 -0400 (EDT)
Date: Thu, 27 Jun 2024 00:27:34 -0400
From: Brad Smith <brad@comstyle.com>
To: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <Alistair.Francis@wdc.com>,
 Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-riscv@nongnu.org, qemu-devel@nongnu.org
Subject: [PATCH] tcg/riscv: Fix building on OpenBSD/riscv64
Message-ID: <ZnzqNlUbHG5Ue6L1@humpty.home.comstyle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=2607:f938:3000:8::2;
 envelope-from=brad@comstyle.com; helo=mail.comstyle.com
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
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

tcg/riscv: Fix building on OpenBSD/riscv64

Use ucontext_t/struct sigcontext member name from machine/signal.h
instead of Linux specific name.

Signed-off-by: Brad Smith <brad@comstyle.com>
---
 tcg/riscv/tcg-target.c.inc | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/tcg/riscv/tcg-target.c.inc b/tcg/riscv/tcg-target.c.inc
index 639363039b..aeae9a8ad8 100644
--- a/tcg/riscv/tcg-target.c.inc
+++ b/tcg/riscv/tcg-target.c.inc
@@ -2116,7 +2116,12 @@ static void sigill_handler(int signo, siginfo_t *si, void *data)
 {
     /* Skip the faulty instruction */
     ucontext_t *uc = (ucontext_t *)data;
+
+#ifdef __OpenBSD__
+    uc->sc_sepc += 4;
+#else
     uc->uc_mcontext.__gregs[REG_PC] += 4;
+#endif
 
     got_sigill = 1;
 }
-- 
2.45.2


