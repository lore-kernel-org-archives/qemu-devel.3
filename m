Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36417C87FCA
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Jul 2025 15:46:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ufKcJ-0003SG-EO; Fri, 25 Jul 2025 11:45:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1ufKbt-0002nH-8J
 for qemu-devel@nongnu.org; Fri, 25 Jul 2025 11:45:27 -0400
Received: from mail-ej1-x633.google.com ([2a00:1450:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1ufKbr-0002Qg-5M
 for qemu-devel@nongnu.org; Fri, 25 Jul 2025 11:45:24 -0400
Received: by mail-ej1-x633.google.com with SMTP id
 a640c23a62f3a-ae708b0e83eso437951166b.2
 for <qemu-devel@nongnu.org>; Fri, 25 Jul 2025 08:45:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1753458321; x=1754063121; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=1IMtRnTmX5Lhb1N1GyrYkTv6JgaPYpb4Fh7da53dX9k=;
 b=B9UI0IZDobteG4glRROJXYk3FCYtoZJoQMRQi96MJK+j+7/4tK8XzK58x6PhSjfpPU
 ku+arK0jqNDXpUR11BawvT6QrDQTCxmh3vBmqqXQL8vpcVEJ2o/Jy2UYjFgMjaxgXPBH
 p5Bq15bidNq8PRc93DL4xFVM03J2u6HFDyq0tBIcg2o9zyjLqLqI48t7gWdPgeOyf9rh
 DG2jATDZReh15ja/VnviUM2HCAlgXAMv7UUqJIzqg302146dPU5ySt8RCflX335RMCee
 28WboesAY7bJGyyKjTvY6cW5t183LNv5mAQZDSPhdrHbE1HOFPNU84GcHQaHtyhtlXMu
 Fvwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753458321; x=1754063121;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=1IMtRnTmX5Lhb1N1GyrYkTv6JgaPYpb4Fh7da53dX9k=;
 b=Ngx1xOdwgM01fz2/sDiLqv9oqtVAw9G3RIuWJa8vZZpT6jen5+XnHqhH5Ty1FXNfcD
 2WFIi91s6/FZ6NhRovuT+MFWRPKyTlUdhcO1Hmc0Mk2u9KYPLQHlTe2C5QgvqjJnlg3X
 NuW/v6GR6hFoFQ7vutrXw0o6hBgDbA3NKHn+vnCLtMuP6+gNeK4L1mnL3Ys/NpBKG2R2
 eDejIEV8jKSP4krWG2OHnjYWJCQZzYNdozrzvARIm781nHenxw16R5EppNX0U9mUxbN2
 QIaMylQyaXkci1CcTyhvCc0hNRk9nVVGtx0vuZP3HSJ18LW0GgDN1EmhY+4ybo1FN/ma
 WqdQ==
X-Gm-Message-State: AOJu0YxjvfJ3gjP7/VkUBLGmXU0J+xqGOvGPXOwvkgqVJQIdWQ1tJxOV
 ue5q3cnRyrLzoc6KyGlU8Zmb8OSN+CpX3UVxnZydonpvIKoNWLRWWnvNRo1ULoMV/ck=
X-Gm-Gg: ASbGncsSW5p/+F941+krMzACW1eLT72qVFHJBvM0hbZmf9GLL3vfp3hmRobgoR18F+i
 7jWOhXzaeliA0cuzbGOUsELn/qHHlJnXSVdiPYmIL9+qUqxEO7wWW2wX8XaVRVdKpfc+GBHSWFL
 TMDwF9Piqac6CXRZ+22cE8wqqiDwurPkAiD+MNqUPmv9UEchQGkqDR08278Pq0jnxb9pyDs2l2k
 uSi77GGoQeVHsmKQiRU/5U9ZbFwQqqj9xFp3bH/6YwplANZXwhMVlDRcSx9W4RzEr3pdJU1MHr2
 XivkoromMn53NG5BTtuVxddI13u6fxb18GoPIEkQ6ISnDumA9Hwtntp+gGp7UnRbJw+QdBSSZrm
 W2KEbrjRHtv4aF0PY1xwI9WI=
X-Google-Smtp-Source: AGHT+IFumtDaidpLhSD9rz67d/MAitKu89CK45a8NYoJDU75EBYX9yOSwDbCFIgxGE9wEr97t1NMOg==
X-Received: by 2002:a17:907:3cc4:b0:ae0:d08b:e85 with SMTP id
 a640c23a62f3a-af619c0ca37mr333350366b.61.1753458320720; 
 Fri, 25 Jul 2025 08:45:20 -0700 (PDT)
Received: from draig.lan ([185.126.160.19]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-af635b08846sm8317366b.140.2025.07.25.08.45.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 25 Jul 2025 08:45:18 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id D5C095F7EE;
 Fri, 25 Jul 2025 16:45:17 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH for 10.1 v2 00/14] documentation updates and test tweaks pre-PR
Date: Fri, 25 Jul 2025 16:45:03 +0100
Message-ID: <20250725154517.3523095-1-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.2
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::633;
 envelope-from=alex.bennee@linaro.org; helo=mail-ej1-x633.google.com
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

For v2
  - mostly collecting review tags
  - a few fixes (see commit message log)
  - add sysv.argv passthrough for unittests

I'm away for a week so if I don't post the PR on Saturday another
maintainer is free to merge it via their tree.

The following need review:

  docs/user: expand section on threading

Alex.

Alex Bennée (14):
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
  tests/functional: expose sys.argv to unittest.main

 docs/system/devices/net.rst                   | 16 +++--
 docs/user/index.rst                           |  5 +-
 docs/user/main.rst                            | 60 ++++++++++------
 configure                                     |  1 +
 .../dockerfiles/debian-all-test-cross.docker  | 34 +++++----
 tests/functional/meson.build                  |  1 +
 tests/functional/qemu_test/testcase.py        |  2 +-
 tests/functional/test_aarch64_kvm.py          | 71 +++++++++++++++++++
 tests/tcg/Makefile.target                     | 36 ++++++++--
 tests/tcg/multiarch/Makefile.target           |  8 ++-
 .../multiarch/system/Makefile.softmmu-target  | 16 +++--
 11 files changed, 192 insertions(+), 58 deletions(-)
 create mode 100755 tests/functional/test_aarch64_kvm.py

-- 
2.47.2


