Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D283C53219
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jul 2026 07:47:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1woG2o-0005k7-PY; Mon, 27 Jul 2026 03:46:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nikita.shubin@maquefel.me>)
 id 1woG2e-0005ic-4r
 for qemu-devel@nongnu.org; Mon, 27 Jul 2026 03:46:28 -0400
Received: from forward101a.mail.yandex.net ([178.154.239.84])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nikita.shubin@maquefel.me>)
 id 1woG2a-0008Vy-VC
 for qemu-devel@nongnu.org; Mon, 27 Jul 2026 03:46:27 -0400
Received: from mail-nwsmtp-smtp-production-main-95.vla.yp-c.yandex.net
 (mail-nwsmtp-smtp-production-main-95.vla.yp-c.yandex.net
 [IPv6:2a02:6b8:c15:340d:0:640:ad51:0])
 by forward101a.mail.yandex.net (postfix) with ESMTPS id 9D4B581807;
 Mon, 27 Jul 2026 10:46:17 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-95.vla.yp-c.yandex.net (smtp)
 with ESMTPSA id EkWbDKvd4a60-kwK05xpS; 
 Mon, 27 Jul 2026 10:46:16 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=maquefel.me; s=mail;
 t=1785138377; bh=4lMUUmv7+Co2Yl0TF+cEC1rJU0/Z+DuE+TWAeEN1VQk=;
 h=Cc:To:Message-Id:Date:Subject:From;
 b=hMb4G5nOgUq2xmS3e6Wd7dhiiDBf1OyacN54+UGbm97BnbuwFdqYSaYKvGN4+yfGE
 gyQ/9ajAb5WUSvxdEA5gSsSEn+0jXcFztQVYtjFS5jS+74WH4j7x2mKJSoC7feFchz
 HEYwUTF2go7O0yRNoBhQ1fiUQ5/Jxl9VGElGh1hE=
Authentication-Results: mail-nwsmtp-smtp-production-main-95.vla.yp-c.yandex.net;
 dkim=pass header.i=@maquefel.me
From: Nikita Shubin <nikita.shubin@maquefel.me>
Subject: [PATCH v2 0/2] semihosting: Fix auto-strlen for 32-bit targets +
 add riscv32 test
Date: Mon, 27 Jul 2026 10:46:18 +0300
Message-Id: <20260727-fix-sign-extended-32-bit-addresses-v2-0-6d6a01efed8a@maquefel.me>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/5WNQQ6CMBREr0K69htaEcGV9zAsCh3gJ1K0HwmGc
 HcrN3D5JjNvViUIDFHXZFUBMwuPPoI5JKrpre9A7CIrk5o8zXVJLS8k3HnCMsE7ODoZqnki61y
 ACITyArWN5caVVkXRMyCu9pN7Fblnmcbw2T9n/Uv/0s+aUsouFjprCxTN+TbY1xstHscBqtq27
 QvG+8Mx1gAAAA==
X-Change-ID: 20260619-fix-sign-extended-32-bit-addresses-68eba061cd9a
To: qemu-devel@nongnu.org
Cc: =?utf-8?q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>, 
 Paolo Bonzini <pbonzini@redhat.com>, 
 Alistair Francis <alistair.francis@wdc.com>, 
 Nikita Shubin <nikita.shubin@maquefel.me>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1785138386; l=1508;
 i=nikita.shubin@maquefel.me; s=20230718; h=from:subject:message-id;
 bh=NoPly3DJdsXtAH69iE5VokYSyiBDblLV0RT8xSvHpM8=;
 b=CQVrwSm9PJY1/dEUZqVP54jkMLwkqnzUeHcCKe15w8R/HlTSqEuc6rGvQrB4MuuBkEG/xzOI+
 lPHKs9hzbwVCOY4XhVRPrkDCLJrlZ14UT62Q/3Np1iY8y5D41ok5EPG
X-Developer-Key: i=nikita.shubin@maquefel.me; a=ed25519;
 pk=vqf5YIUJ7BJv3EJFaNNxWZgGuMgDH6rwufTLflwU9ac=
Received-SPF: pass client-ip=178.154.239.84;
 envelope-from=nikita.shubin@maquefel.me; helo=forward101a.mail.yandex.net
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
Changes in v2:
- Added tags.
- Link to v1: https://lore.kernel.org/qemu-devel/20260619-fix-sign-extended-32-bit-addresses-v1-0-47ae14f8e8c5@maquefel.me

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
base-commit: 6333226c2abb72f31648c251624c56e70993d625
change-id: 20260619-fix-sign-extended-32-bit-addresses-68eba061cd9a

Best regards,
--  
Nikita Shubin


