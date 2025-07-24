Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 914BCC83F26
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Jul 2025 11:00:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uetfu-0007CV-F1; Thu, 24 Jul 2025 06:59:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1uetft-0007AP-7q
 for qemu-devel@nongnu.org; Thu, 24 Jul 2025 06:59:45 -0400
Received: from mail-ej1-x631.google.com ([2a00:1450:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1uetfr-0007x4-Hk
 for qemu-devel@nongnu.org; Thu, 24 Jul 2025 06:59:45 -0400
Received: by mail-ej1-x631.google.com with SMTP id
 a640c23a62f3a-ae3a604b43bso134287066b.0
 for <qemu-devel@nongnu.org>; Thu, 24 Jul 2025 03:59:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1753354781; x=1753959581; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=d37m3MaXFrCwnLFACnbyFONcYZLWLyBitA8HTfc9Io0=;
 b=ykiA7LUkmOssvaVu/tewMpJaNA95fHvOLysDvxET/NzONxwdH0kvR8317yrBHFxMtz
 dwPNSsjYc0rtaSu71m65JYh8MQ6M2zOLwqqOHwsvfqnpJB4pe8/HFpZ1i6m6gUYW1lyC
 ZrWObeQJzm8WV9PFvWvX/t9XrNXkvCKi5gHpoUkZPDfOtvBZHObYzFqSok0qu6+1KbDL
 XtcqBXwH0esWsLusocInecEKylhxdyjFyYZ3Fusv29Qt5PgkQxyFavD9DkbBEVpypOsy
 pGgunFJQiHqu1y4gCkPsU31zFHyIJVXNfTOLVdyb3Np6NkzjUTIDziOqMaE1Fnuie9P/
 l8XA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753354781; x=1753959581;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=d37m3MaXFrCwnLFACnbyFONcYZLWLyBitA8HTfc9Io0=;
 b=iCWtyJsIufW1dqPvU51Bij8Vjkw4Q3Y42IKEv72576b+0TqmHlglt+uJ8M/QYTE8ce
 cyznsr5UmVgCblkOdDwizpyFC4D4XZjxJIm4GPDfITlNqeGvSHPtLTHxf0oH96/gcXJh
 om6Rl3K8f7vydAkID109lG9K/mch+TxbeySlXdJWN5iNKHLntXhacGRsiDmcOQLHuhxk
 vVxm6hfQ48C1BUKlRzUw6hpWCFd4wR+wN2YXym7A1VRpIDuWsE1VbL0qWh9lRySDuwL7
 DpUZUwvrQkMl1lpnVrJMIMFiYIKH07LEBo11mDxqrwdaBi1QD2W8pz0CYW/+m1/yGc86
 DIPA==
X-Gm-Message-State: AOJu0YxsbfHKC5ktk0KF7/kkQu3cP1QaxHeM7FyIGdnKS1kWHtwTquYa
 C7WJIcby55gEfKrNiajkPyOuKA0teRXimYuFh/dgQQeiWm8X/QPtO+D2zV0FFbnV58w=
X-Gm-Gg: ASbGnct9wQQu6KhqIBFg/UqBHX8NdwlDM+BpgiehgvJps//P2IaSsru2Dh7uKiHXPtQ
 sp2IKI82XnNt3UT1MHs9QVRgQ7Bupmwb8/lgHimjZNWGtD69dJAUJQgd8cGrvfge8plw1dQtMUy
 BLYaj5DaLC8AQ0CJ5Fl5yXS2eW+q5F41TKkjPdTO9XGmKmmcwN0+/qLPggr9Rjm+HNLldq/8MVM
 CBZRPFaIl1DY9PNtXCcbK2UWR9UJEAAy++Dgwko1Zo96Rn5ZkV5td0xxKpVKq8qKgU8aIvX88gP
 qdEC0AJgo1Sv+3tlSwHzPYO8jPz1LO7QQNRfIyyHc+wfd0a+mr6HVJCkMoQYqyUCER6qdFR6e1X
 ocOrZ9QLMuG19/+9y7t6sLJA=
X-Google-Smtp-Source: AGHT+IFvizPYQty1TRWcRR2yAn0UGidPMH4ULvwmUHheExUQdQsjqrV/3t1jZmP25wB+HGheI8vt8w==
X-Received: by 2002:a17:906:9f89:b0:ae0:cc5f:88ef with SMTP id
 a640c23a62f3a-af2f8857bd4mr623064666b.32.1753354781531; 
 Thu, 24 Jul 2025 03:59:41 -0700 (PDT)
Received: from draig.lan ([185.126.160.19]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-af47c495ea4sm97361166b.26.2025.07.24.03.59.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 24 Jul 2025 03:59:40 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id E488E5F7B0;
 Thu, 24 Jul 2025 11:59:39 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>
Subject: [PATCH for 10.1 00/13] documentation updates and test tweaks
Date: Thu, 24 Jul 2025 11:59:26 +0100
Message-ID: <20250724105939.2393230-1-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.2
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::631;
 envelope-from=alex.bennee@linaro.org; helo=mail-ej1-x631.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

I did a quick pass of some of the documentation bugs and tried to
clean-up the linux-user documentation some more.

I've also tackled the exploding number of TCG tests by rotating the
plugin run against test rather than having every combination. We now
have enough multiarch tests I'm fairly confident this gives good
enough coverage of the APIs. Some plugins have explicit test programs
they need to be run against and these are still added manually.

The following need review:

  tests/docker: handle host-arch selection for all-test-cross
  tests/docker: add --arch-only to qemu deps for all-test-cross
  tests/tcg: reduce the number of plugin tests combinations
  configure: expose PYTHON to test/tcg/config-host.mak
  tests/tcg: don't include multiarch tests if not supported
  tests/tcg: remove ADDITIONAL_PLUGINS_TESTS
  tests/tcg: skip libsyscall.so on softmmu tests
  tests/functional: add hypervisor test for aarch64
  docs/user: expand section on threading
  docs/user: slightly reword section on system calls
  docs/user: clean up headings
  docs/system: reword the TAP notes to remove tarball ref
  docs/user: clarify user-mode expects the same OS

Alex.

Alex Bennée (13):
  docs/user: clarify user-mode expects the same OS
  docs/system: reword the TAP notes to remove tarball ref
  docs/user: clean up headings
  docs/user: slightly reword section on system calls
  docs/user: expand section on threading
  tests/functional: add hypervisor test for aarch64
  tests/tcg: skip libsyscall.so on softmmu tests
  tests/tcg: remove ADDITIONAL_PLUGINS_TESTS
  tests/tcg: don't include multiarch tests if not supported
  configure: expose PYTHON to test/tcg/config-host.mak
  tests/tcg: reduce the number of plugin tests combinations
  tests/docker: add --arch-only to qemu deps for all-test-cross
  tests/docker: handle host-arch selection for all-test-cross

 docs/system/devices/net.rst                   | 16 ++--
 docs/user/index.rst                           |  5 +-
 docs/user/main.rst                            | 59 ++++++++-----
 configure                                     |  1 +
 .../dockerfiles/debian-all-test-cross.docker  | 33 ++++----
 tests/functional/meson.build                  |  1 +
 tests/functional/test_aarch64_kvm.py          | 83 +++++++++++++++++++
 tests/tcg/Makefile.target                     | 36 ++++++--
 tests/tcg/multiarch/Makefile.target           |  8 +-
 .../multiarch/system/Makefile.softmmu-target  | 16 +++-
 10 files changed, 201 insertions(+), 57 deletions(-)
 create mode 100755 tests/functional/test_aarch64_kvm.py

-- 
2.47.2


