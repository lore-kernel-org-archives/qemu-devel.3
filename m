Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2910EC25B74
	for <qemu-devel@archiver.kernel.org>; Fri, 24 May 2024 05:37:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sANbH-00089E-QD; Fri, 24 May 2024 01:36:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1sANbG-000888-C5
 for qemu-devel@nongnu.org; Fri, 24 May 2024 01:36:18 -0400
Received: from mail-pj1-x102e.google.com ([2607:f8b0:4864:20::102e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1sANbE-00012E-0J
 for qemu-devel@nongnu.org; Fri, 24 May 2024 01:36:17 -0400
Received: by mail-pj1-x102e.google.com with SMTP id
 98e67ed59e1d1-2bf5e0de37bso326478a91.1
 for <qemu-devel@nongnu.org>; Thu, 23 May 2024 22:36:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1716528974; x=1717133774;
 darn=nongnu.org; 
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:from:to:cc:subject:date:message-id:reply-to;
 bh=U71R9tSIEndSwV7KO70oICfGEbiSf5kxz8iwxCaWwlQ=;
 b=pcDMkiz/2flxmgqoKALpJk6w7MajBZDt8Gx2my3ZwEG42ddjjsb67a74imnTBZOokF
 IJotXEUE+HVT+WPw5mbiWf77N6j4C9wdG8axNkSiXMCPtDBOlg+UQPM653+uGPKgXsTp
 yFQFxM3sWYlPizuRo3wXxVSkBZEE59GDFZ059fC1IOcG8WvsM2JdIYFqfwY48aL3GyuB
 +JRg3aetbpLC6BLa3l3dDIPQYibsl3aEegoVEUeR38V1S9MOP+kacbovXug51r4R5l5T
 6+WmPk79V0IRBCaWg3n5yCL+rrbiCTYnJdNSt27q6Xw0LaXau2rq+UOmXxn5nrUg3/T1
 LthQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716528974; x=1717133774;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=U71R9tSIEndSwV7KO70oICfGEbiSf5kxz8iwxCaWwlQ=;
 b=lNaFny+pr6AFu2aS8+Md6T2FrpAU5zt4p7YUJDDTTDgKwdRz21iVLqZIjyyyKTCQGt
 xPWcpCzHZACDbY6lTnjezzh1OxHzsjlvXMqOYRb/SEtJ58HepIhOdSpuqOg8+Fw31a82
 2774OrJ8Essbd6bOGqeOwoXiGBbHKua0trqyio8/og0wlXkacle9AoiwS5deIJdZ7JCf
 qd6cgiWmtW360sa519QaPNPIupGHsLVMdN9m8zoEShcuChz7NEG9QgUZCgAMetkxciCC
 AuaZF6P53r7bUvRr+4kr+RLj8D5V+I52oT0p6W/tNBiugmt/nJOxebqG9wKs+4tBYTTx
 aZZw==
X-Gm-Message-State: AOJu0YyMi6HJymts+KArtLWUXkK4BDaLmDYRcHDPF7inmOGmMQ5thHJb
 ZE1v2sRrwlP35gNIBlZKby7SI14HlhEA0VvBrzGvDyICej1tPNWbqfmoevwZYg0=
X-Google-Smtp-Source: AGHT+IFPbBYw9WXG8ci/08YKcd8u+FT+q1YiCViFcK3SGbZba8bdhUH+X3bMKQ4EDjRMjMZ04d+wFg==
X-Received: by 2002:a17:90b:d8d:b0:2bf:5730:1f56 with SMTP id
 98e67ed59e1d1-2bf5e173c7dmr1111756a91.1.1716528973536; 
 Thu, 23 May 2024 22:36:13 -0700 (PDT)
Received: from localhost ([157.82.204.135])
 by smtp.gmail.com with UTF8SMTPSA id
 98e67ed59e1d1-2bf5f30a762sm566417a91.1.2024.05.23.22.36.10
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 23 May 2024 22:36:13 -0700 (PDT)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Subject: [PATCH v4 0/4] Fix sanitizer errors with clang 18.1.1
Date: Fri, 24 May 2024 14:35:46 +0900
Message-Id: <20240524-xkb-v4-0-2de564e5c859@daynix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIADInUGYC/23MTQ6CMBCG4auQrq3pDC0UV97DuCj9kcYIpjUNh
 HB3C24kuvwm87wziTZ4G8mpmEmwyUc/9HnwQ0F0p/qbpd7kTZAhZ4IBHe8tRSG5LLXWwkiSP5/
 BOj9ulcs1787H1xCmLZpgve59AgrUMV4ZaQEUtmejpt6PRz08yBpI+IUQPwgpo1XdCu5UrRvpf
 lD5B5UZaY6NsbJiTsEOLcvyBnnwJDIBAQAA
To: Michael Tokarev <mjt@tls.msk.ru>, Laurent Vivier <laurent@vivier.eu>, 
 Paolo Bonzini <pbonzini@redhat.com>, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Thomas Huth <thuth@redhat.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 =?utf-8?q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>, 
 Wainer dos Santos Moschetta <wainersm@redhat.com>, 
 Beraldo Leal <bleal@redhat.com>, 
 Richard Henderson <richard.henderson@linaro.org>, 
 Laurent Vivier <lvivier@redhat.com>
Cc: qemu-devel@nongnu.org, Akihiko Odaki <akihiko.odaki@daynix.com>
X-Mailer: b4 0.14-dev-01a33
Received-SPF: none client-ip=2607:f8b0:4864:20::102e;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pj1-x102e.google.com
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

Changes in v4:
- Fixed function pointer problems instead of ignoring them.
- Made references to allocations static instead of incompletely freeing
  them for qemu-keymap.
- s/prefix/suffix/ for patch "meson: Drop the .fa library suffix".
- Link to v3: https://lore.kernel.org/r/20240522-xkb-v3-0-c429de860fa1@daynix.com

Changes in v3:
- Moved changes that should belong to patch "meson: Drop the .fa library
  prefix" from patch "meson: Add -fno-sanitize=function".
- Link to v2: https://lore.kernel.org/r/20240522-xkb-v2-0-67b54fa7c98f@daynix.com

Changes in v2:
- Added more patches and converted them to a series.
- Link to v1: https://lore.kernel.org/r/20240501-xkb-v1-1-f046d8e11a2b@daynix.com

---
Akihiko Odaki (4):
      qemu-keymap: Make references to allocations static
      lockable: Do not cast function pointers
      qapi: Do not cast function pointers
      meson: Drop the .fa library suffix

 docs/devel/build-system.rst         |  5 -----
 meson.build                         | 17 ++---------------
 include/qapi/clone-visitor.h        | 37 ++++++++++++++++++++++++-------------
 include/qemu/lockable.h             | 23 +++++++++++++++++++----
 qapi/qapi-clone-visitor.c           | 30 ++++--------------------------
 qemu-keymap.c                       |  8 +++-----
 stubs/blk-exp-close-all.c           |  2 +-
 .gitlab-ci.d/buildtest-template.yml |  2 --
 .gitlab-ci.d/buildtest.yml          |  2 --
 gdbstub/meson.build                 |  2 --
 tcg/meson.build                     |  2 --
 tests/Makefile.include              |  2 +-
 tests/qtest/libqos/meson.build      |  1 -
 13 files changed, 54 insertions(+), 79 deletions(-)
---
base-commit: c25df57ae8f9fe1c72eee2dab37d76d904ac382e
change-id: 20240501-xkb-258483ccc5d8

Best regards,
-- 
Akihiko Odaki <akihiko.odaki@daynix.com>


