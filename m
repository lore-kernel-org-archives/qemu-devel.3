Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0CDB5C25B7A
	for <qemu-devel@archiver.kernel.org>; Wed, 22 May 2024 10:44:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s9jRJ-0003Ig-2C; Wed, 22 May 2024 06:43:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1s9jRH-0003IH-DT
 for qemu-devel@nongnu.org; Wed, 22 May 2024 06:43:19 -0400
Received: from mail-pf1-x42b.google.com ([2607:f8b0:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1s9jR6-0001e1-V3
 for qemu-devel@nongnu.org; Wed, 22 May 2024 06:43:19 -0400
Received: by mail-pf1-x42b.google.com with SMTP id
 d2e1a72fcca58-6f6bddf57f6so1441125b3a.0
 for <qemu-devel@nongnu.org>; Wed, 22 May 2024 03:43:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1716374587; x=1716979387;
 darn=nongnu.org; 
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:from:to:cc:subject:date:message-id:reply-to;
 bh=CHHlxuDeaTModWA+eV9vkqH/aedHv0c3Sc+uYxssJlM=;
 b=3BmtPga6HKrXVZl8pHWAL2m1WE+pZUgtF8JBiDX3HvyGag6fWv3UZsnbfljwYpWRRi
 ydKZbJWN9LDlbBb5sH3oeo21QG4xXmDm1D+54QczzdkUnU5sR35PF7GMbQDHj/9LJUr0
 1CwxbMcS78zCk0iQvgEAoXaZ9nDGpLuPc6/a1U0vY0tW/3Dg+GrCK214ukXk31M0+PEC
 qhQEKWyu2Ys4iDKBJ0Wv0yOVJBgfGhnbSPZ0maHGvt9H7hfKGq3ZbR12EdKwEIm1KZbw
 /Lc6yszCH7HFAjU45hDqj9rVMKuQG5AmgxQZDiDxf+kii5Jip1212/OJbvsuPKKqTFjN
 /STg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716374587; x=1716979387;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=CHHlxuDeaTModWA+eV9vkqH/aedHv0c3Sc+uYxssJlM=;
 b=WldnRqVlYjepICiLvJJfTG13g7lvghY73qAb3YDviV+8sHmyIy44k2xjepJXeDlsSs
 G+n7rJC2NoCfns/Zpa7mk+41E2P01F5475EGo/wG0ju0cbk6nlw5pb0gKfXb/Axy4Zan
 L9prSrfq+LCvXafye0txKi/Ax4pbiBGIVf5mqVJ9FO2F+MFj2ratPXAKc5xn1zCm0jD2
 gJyTikDzhClQ2kOqgnXNn71ovyYKmwhzZBpSAgQlXELJbGwgihYdanCDlgT5WrwNeovu
 DNwnNwwTxp907oNxKxKWhtthFZZ5HOn+PdI4iCDs8UThPnXsssQc2AuDEIA1yx6rVEER
 l30g==
X-Gm-Message-State: AOJu0YxDorvgw8jng0jjAVILOkqws4z5ocERTOny77EFlhB4Qb0wbu8j
 ohUK3DUSorrCSx3gppElBPAzdquwoUcefaBbuIHA3QtsfXv9OShk1qznKFZSqOI=
X-Google-Smtp-Source: AGHT+IF8qkDUfaDXOvfFE4AmV0rivo4tqvylDsfQtCNeapksjwzhUZ8PEI/y9wyoDYSPx+r2Hey99g==
X-Received: by 2002:a05:6a00:4fd1:b0:6ea:afdb:6d03 with SMTP id
 d2e1a72fcca58-6f6d61b787cmr1557306b3a.19.1716374587191; 
 Wed, 22 May 2024 03:43:07 -0700 (PDT)
Received: from localhost ([157.82.204.135])
 by smtp.gmail.com with UTF8SMTPSA id
 d2e1a72fcca58-6f4d2afa7b5sm22111688b3a.163.2024.05.22.03.43.04
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 22 May 2024 03:43:06 -0700 (PDT)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Subject: [PATCH v2 0/3] Fix sanitizer errors with clang 18.1.1
Date: Wed, 22 May 2024 19:43:01 +0900
Message-Id: <20240522-xkb-v2-0-67b54fa7c98f@daynix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIADXMTWYC/1WMwQ7CIBAFf6XZsxgWwRBP/kfTAwVqN0YwYAhNw
 7+LvXmclzezQ/aJfIbbsEPyhTLF0EGcBrCrCQ/PyHUGwYXkiiOrz5kJpaW+WGuV09Cf7+QXqkd
 lnDqvlD8xbUe04G/99wsyZAuXV6c9ohHz3ZktUD3b+IKptfYFDfSsw5cAAAA=
To: Paolo Bonzini <pbonzini@redhat.com>, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Thomas Huth <thuth@redhat.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 =?utf-8?q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>, 
 Wainer dos Santos Moschetta <wainersm@redhat.com>, 
 Beraldo Leal <bleal@redhat.com>, 
 Richard Henderson <richard.henderson@linaro.org>, 
 Laurent Vivier <lvivier@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>, 
 Laurent Vivier <laurent@vivier.eu>
Cc: qemu-devel@nongnu.org, Akihiko Odaki <akihiko.odaki@daynix.com>
X-Mailer: b4 0.14-dev-01a33
Received-SPF: none client-ip=2607:f8b0:4864:20::42b;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pf1-x42b.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

I upgraded my Fedora Asahi Remix from 39 to 40 and found new sanitizer
errors with clang it ships so here are fixes.

The patch "meson: Drop the .fa library prefix" may have a broad impact
to the build system so please tell me if you have a concern with it.

To: Michael Tokarev <mjt@tls.msk.ru>
To: Laurent Vivier <laurent@vivier.eu>
To: Paolo Bonzini <pbonzini@redhat.com>
To: Marc-André Lureau <marcandre.lureau@redhat.com>
To: Daniel P. Berrangé <berrange@redhat.com>
To: Thomas Huth <thuth@redhat.com>
To: Philippe Mathieu-Daudé <philmd@linaro.org>
To: Alex Bennée <alex.bennee@linaro.org>
To: Wainer dos Santos Moschetta <wainersm@redhat.com>
To: Beraldo Leal <bleal@redhat.com>
To: Richard Henderson <richard.henderson@linaro.org>
To: Laurent Vivier <lvivier@redhat.com>
Cc: qemu-devel@nongnu.org
Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>

Changes in v2:
- Added more patches and converted them to a series.
- Link to v1: https://lore.kernel.org/r/20240501-xkb-v1-1-f046d8e11a2b@daynix.com

---
Akihiko Odaki (3):
      qemu-keymap: Free xkb allocations
      meson: Add -fno-sanitize=function
      meson: Drop the .fa library prefix

 docs/devel/build-system.rst         |  5 -----
 meson.build                         | 19 +++----------------
 qemu-keymap.c                       |  3 +++
 stubs/blk-exp-close-all.c           |  2 +-
 .gitlab-ci.d/buildtest-template.yml |  2 --
 .gitlab-ci.d/buildtest.yml          |  2 --
 gdbstub/meson.build                 |  2 --
 tcg/meson.build                     |  2 --
 tests/Makefile.include              |  2 +-
 tests/qtest/libqos/meson.build      |  1 -
 10 files changed, 8 insertions(+), 32 deletions(-)
---
base-commit: c25df57ae8f9fe1c72eee2dab37d76d904ac382e
change-id: 20240501-xkb-258483ccc5d8

Best regards,
-- 
Akihiko Odaki <akihiko.odaki@daynix.com>


