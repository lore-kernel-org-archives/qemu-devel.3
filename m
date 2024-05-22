Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81920C25B77
	for <qemu-devel@archiver.kernel.org>; Wed, 22 May 2024 10:49:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s9jWg-0000QJ-LE; Wed, 22 May 2024 06:48:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1s9jWd-0000Pu-UO
 for qemu-devel@nongnu.org; Wed, 22 May 2024 06:48:52 -0400
Received: from mail-pl1-x62e.google.com ([2607:f8b0:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1s9jWa-0002lT-BE
 for qemu-devel@nongnu.org; Wed, 22 May 2024 06:48:50 -0400
Received: by mail-pl1-x62e.google.com with SMTP id
 d9443c01a7336-1ed96772f92so9500775ad.0
 for <qemu-devel@nongnu.org>; Wed, 22 May 2024 03:48:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1716374926; x=1716979726;
 darn=nongnu.org; 
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:from:to:cc:subject:date:message-id:reply-to;
 bh=mNKP2/Exzvp9wWUXTZ4fs+/6fcwV5Och9cQHhjPIzro=;
 b=O9UPv/1vaxccpjKjgYePfS6AtBXYM+5gzgCQEuaJLVs2ImTMQuKT9lkDFSDo6mWt8O
 TQMYdVj7RN1lq8ZZ/8lVybstSo4qidUr6IC7VSShGYKQfY3LR0+/AYYpvVpGOGh1mnnw
 ggXuPpiFT+eWx3bB2oOBZZH00msnjZO6Y5al6serVwyCjJAMvVJGAMzubFW0fVZOhh++
 ZF8ZrcAmDzQSuEbkqxeakAQ2es3ZioXYNCKciY7V9wom8VJlDO/68X1zH68PeM8rSBJM
 NMTBTE+rSeEdHK/j14Nvv0VeQ7c2B3JmLOCcD8lupXoY0FzNv8z14UT7oRfgFTQKbwAz
 telg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716374926; x=1716979726;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=mNKP2/Exzvp9wWUXTZ4fs+/6fcwV5Och9cQHhjPIzro=;
 b=pCwCFzzN0ai0vMkSE1ZEXBeULmjAOKuqhsCFDExe9qE+Vttww3X5Q8ZIU3v2UkK6XT
 voyq43hWKZFlQ4rjErodiQIb/MFbpaSootQWvLlz6cT6LvtRgrKiV7uH0bgfqtPabhBI
 rKf2ZvW3fC9u80vlOvdAAqCCaVCKn4G7XdOboaZFQh9D94qZo3ocUzhsPjf6V+w3HtQU
 uWMgn7KMbmpt6xm4qF2W7ySFgQ33oXShk/iIjjxYSmOh9n646/HIJlI+Fb160TN8vgmX
 R4moWxhNHFIsy8X+iZaKrnf8ccejev/nZxMwUQ1ew4FxU8aci4X239uz6aP6irP9aqLj
 JyBw==
X-Gm-Message-State: AOJu0YxRUcuHZ69YzbZc4fNrPZMcROxv2fTz6TFxj0y2eeY0J614wJyV
 MFn+uhuaMOXr0SOpNsSzL36bGXaXcWB/HYHpSvStZ1LTvgr7ennjl5UrJGZ0fVA=
X-Google-Smtp-Source: AGHT+IGooyFsrfkbRSBo7YQQj0YgFknV7rHh2xiivAiaAhvhMTCTbIjJpHkcf7bizpMZPZVLEkkhxQ==
X-Received: by 2002:a17:902:680d:b0:1f3:3116:bbb7 with SMTP id
 d9443c01a7336-1f33116bbe2mr339925ad.23.1716374925939; 
 Wed, 22 May 2024 03:48:45 -0700 (PDT)
Received: from localhost ([157.82.204.135])
 by smtp.gmail.com with UTF8SMTPSA id
 d9443c01a7336-1f3107590b4sm26606325ad.277.2024.05.22.03.48.42
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 22 May 2024 03:48:45 -0700 (PDT)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Subject: [PATCH v3 0/3] Fix sanitizer errors with clang 18.1.1
Date: Wed, 22 May 2024 19:48:35 +0900
Message-Id: <20240522-xkb-v3-0-c429de860fa1@daynix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAIPNTWYC/1WMyw6CMBBFf8XM2jHt0EJ15X8YF6UPaYxgWtNAC
 P9uwY0sz809Z4bkYnAJLocZosshhaEvUB0PYDrdPxwGWxiIkWCScRyfLZJUQlXGGGkVlOc7Oh/
 GrXK7F+5C+gxx2qKZr+vezxw5eiZqqxznmtqr1VMfxpMZXrAGMv1JRD+JkGHdtFJ43Ziz8jtpW
 ZYviqHaw8wAAAA=
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
Received-SPF: none client-ip=2607:f8b0:4864:20::62e;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pl1-x62e.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

Changes in v3:
- Moved changes that should belong to patch "meson: Drop the .fa library
  prefix" from patch "meson: Add -fno-sanitize=function".
- Link to v2: https://lore.kernel.org/r/20240522-xkb-v2-0-67b54fa7c98f@daynix.com

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


