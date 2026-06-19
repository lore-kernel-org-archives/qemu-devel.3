Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE12FCD98F6
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jun 2026 09:52:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1waVtp-0001tX-HJ; Fri, 19 Jun 2026 05:52:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nikita.shubin@maquefel.me>)
 id 1waVtn-0001sV-9l
 for qemu-devel@nongnu.org; Fri, 19 Jun 2026 05:52:31 -0400
Received: from forward101b.mail.yandex.net ([178.154.239.148])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nikita.shubin@maquefel.me>)
 id 1waVtj-0000XI-L4
 for qemu-devel@nongnu.org; Fri, 19 Jun 2026 05:52:31 -0400
Received: from mail-nwsmtp-smtp-production-main-89.sas.yp-c.yandex.net
 (mail-nwsmtp-smtp-production-main-89.sas.yp-c.yandex.net
 [IPv6:2a02:6b8:c11:2281:0:640:870e:0])
 by forward101b.mail.yandex.net (Yandex) with ESMTPS id 0FA1CC1CA6;
 Fri, 19 Jun 2026 12:52:21 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-89.sas.yp-c.yandex.net (smtp)
 with ESMTPSA id JqPRggKd9eA0-Ig6XTPMr; 
 Fri, 19 Jun 2026 12:52:20 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=maquefel.me; s=mail;
 t=1781862740; bh=0m1cPFUb7vs1mtnrK1B5tOukrYmq3HgU+zXITudt8eU=;
 h=Cc:To:Message-Id:Date:Subject:From;
 b=joZ/xaXcfUl1P/2vkeH9KzzTIhI2bKovBx24Ejjmo+BEXdVPxS+Dy8sb76/4EMAsu
 rW9MuVX9MHgJiIjIc2rhEgDoBBAlES/L1pGM052cONxbbIVJHSNYEM9j4Cs75iMZFy
 c0Ju86I8050vasiR4VJ9waolxK/OoiW/nFM5SV8w=
Authentication-Results: mail-nwsmtp-smtp-production-main-89.sas.yp-c.yandex.net;
 dkim=pass header.i=@maquefel.me
From: Nikita Shubin <nikita.shubin@maquefel.me>
Subject: [PATCH 0/2] semihosting: Fix auto-strlen for 32-bit targets + add
 riscv32 test
Date: Fri, 19 Jun 2026 12:52:18 +0300
Message-Id: <20260619-fix-sign-extended-32-bit-addresses-v1-0-47ae14f8e8c5@maquefel.me>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/x2NQQqEQAwEvyI5G9ARhtWviIfR9Lq5zMpERBD/b
 vBY0NV1kaEojIbqooJDTf/Zoa0rWn4pr2AVZwpNiE1se/7qyaZrZpw7skC4CzzrzkmkwAzG8YM
 5+XiRPpEfbQVuvZFxuu8HQZ6U5XQAAAA=
X-Change-ID: 20260619-fix-sign-extended-32-bit-addresses-68eba061cd9a
To: qemu-devel@nongnu.org
Cc: =?utf-8?q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>, 
 Paolo Bonzini <pbonzini@redhat.com>, 
 Nikita Shubin <nikita.shubin@maquefel.me>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1781862741; l=1345;
 i=nikita.shubin@maquefel.me; s=20230718; h=from:subject:message-id;
 bh=XlNKbQfnc/PpQTDLqRBCODvWwax6c+MYFq72kEk40sE=;
 b=wFIhLPpHJQ4SMRSqZ8ie+jwiF0yk+j7iV+j68dAOdLxixDJEoe3DOt5hlDrtLPzneLFdQCCsV
 Pq/1rTguEMJD1XBVJnN9wpW7sI2W1lIXrlhlYWxfHp7uMpS3zwH+BMt
X-Developer-Key: i=nikita.shubin@maquefel.me; a=ed25519;
 pk=vqf5YIUJ7BJv3EJFaNNxWZgGuMgDH6rwufTLflwU9ac=
Received-SPF: pass client-ip=178.154.239.148;
 envelope-from=nikita.shubin@maquefel.me; helo=forward101b.mail.yandex.net
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

This short series fixes a regression in semihosting's automatic string length
detection for 32‑bit targets, introduced when target_ulong was replaced with
uint64_t. The first patch restores the original behaviour where passing
-1 (0xffffffff) in arg2 triggers the auto‑length logic by detecting the
32‑bit sentinel and promoting it to the 64‑bit equivalent.

The second patch extends the TCG test suite with a new RISC‑V 32‑bit
semihosting test that exercises SYS_OPEN with auto‑length, verifying that
the fix works correctly on qemu-system-riscv32.

Signed-off-by: Nikita Shubin <nikita.shubin@maquefel.me>
---
Nikita Shubin (2):
      semihosting/arm-compat-semi: Fix auto‑strlen detection for 32‑bit targets
      tests/tcg/riscv32: Add RISC-V 32-bit semihosting test

 configure                                 |  6 +++-
 semihosting/arm-compat-semi.c             | 11 ++++++
 tests/tcg/riscv32/Makefile.softmmu-target | 30 +++++++++++++++++
 tests/tcg/riscv32/semihost.ld             | 24 +++++++++++++
 tests/tcg/riscv32/test-semihosting-open.S | 56 +++++++++++++++++++++++++++++++
 5 files changed, 126 insertions(+), 1 deletion(-)
---
base-commit: 3b50303f9563a42538a1fd5c0ea7f952e23016e1
change-id: 20260619-fix-sign-extended-32-bit-addresses-68eba061cd9a

Best regards,
-- 
Nikita Shubin


