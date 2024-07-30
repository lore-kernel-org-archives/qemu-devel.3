Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8DA4C3DA49
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jul 2024 16:24:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sYpcc-0008DG-53; Tue, 30 Jul 2024 12:22:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sYpca-00089f-96
 for qemu-devel@nongnu.org; Tue, 30 Jul 2024 12:22:44 -0400
Received: from mail-ej1-x629.google.com ([2a00:1450:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sYpcY-0003Wu-6p
 for qemu-devel@nongnu.org; Tue, 30 Jul 2024 12:22:44 -0400
Received: by mail-ej1-x629.google.com with SMTP id
 a640c23a62f3a-a77ec5d3b0dso576033166b.0
 for <qemu-devel@nongnu.org>; Tue, 30 Jul 2024 09:22:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1722356560; x=1722961360; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=gtdNg4ytyOsjDBrXKcJQe9n38/V98fmUi85OHsrDpmc=;
 b=LsdR9ddq+g0oSU6NhivD2IdIlCmjEX94k8Glql34+phg+5WRfBe/Jc7UGuWMiNsl68
 vO4oi6sLhqtXDC1ECsehGoBlQKvuTRfIwj/GvYUy0u7oizDCvmqiPHdQ6Vh4UIP5O8wQ
 P0Y+9d1VxK7isbmv6h3RGS1QZq7c18Mnd5GoGvrzPDdQ7Vd/1PVeeicsxwSc+z4o7DwJ
 2uaCzSlZQEzRBEHZffEYC4m7YoFUopWF6XT+hG5sA51BhbQ29CCzo4nvuUcJAc+BWmWm
 GUvgDejOhM/lArUUgrLezo9eBrC0bThDiAOGsOkgCTqi8YN/8/+hK+WUyFct9/spZM7P
 pUcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722356560; x=1722961360;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=gtdNg4ytyOsjDBrXKcJQe9n38/V98fmUi85OHsrDpmc=;
 b=sKbe7eQeKw6LGTtFDOu3hJj729LeDULMzXizVDqeXDmHSrWH7MmPoBGCSy8ftLAZdy
 oiD39NlcstbFsyAzVnhNMSvY/A2rBRUo9/W+pwv5xaIUiVhlw8zRGzT6h+nGjteCSvPg
 ZqjxbWJe1zIlqUwpeD0T0kaE+h1lhtsIJSbbo5ymlS9RnOG1wXm4+9bnKeM4jxungVoR
 HS0pxsmB9EMYvkoGK1gxAGuMQ1OT0dJaPyDscrarVXXOxwAncEgQxPY+x/qQDS4VBkY7
 NkmKaVmMxlIQg4Gp3GG3FP8LRrtIZJtkzTJpWhEYRfstZeBuIbwbMQ1cYJWejMBWl2lx
 LrJg==
X-Gm-Message-State: AOJu0YxZ6fYM+h8XdBMtwEGc2nexDynzL7QOfJv83A3pSETrzT3l0P5/
 bDH8wF3bhifPMiL+qzlgnmFDbxYKUOJpIwGaeH78dXAkEGiIWhj3pBxxdYF3NYo=
X-Google-Smtp-Source: AGHT+IGWeUal2dyjqy7qI3n1Y7aTG9qqS4Ut/XrYW2dnx/Kvoz06uvbrvFxKyIX7TqJ75hEYMJV/jw==
X-Received: by 2002:a17:907:6d25:b0:a7d:34fd:6cd0 with SMTP id
 a640c23a62f3a-a7d4015fca8mr836501966b.66.1722356559681; 
 Tue, 30 Jul 2024 09:22:39 -0700 (PDT)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a7acadb8072sm658596866b.196.2024.07.30.09.22.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 30 Jul 2024 09:22:38 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id C701A5F867;
 Tue, 30 Jul 2024 17:22:37 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PULL for 9.1-rc1 00/14] Minor bug fixes and documentation cleanups
Date: Tue, 30 Jul 2024 17:22:23 +0100
Message-Id: <20240730162237.1425515-1-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::629;
 envelope-from=alex.bennee@linaro.org; helo=mail-ej1-x629.google.com
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

The following changes since commit 8617cb073ca9fa5588d7afad5c81b7aa6cd02f26:

  Merge tag 'pull-misc-20240730' of https://gitlab.com/rth7680/qemu into staging (2024-07-30 11:12:42 +1000)

are available in the Git repository at:

  https://gitlab.com/stsquad/qemu.git tags/pull-maintainer-9.1-rc1-300724-1

for you to fetch changes up to 7b690fd3d039211a5bdde6a74b0ff95cb8b872b0:

  plugin/loader: handle basic help query (2024-07-30 11:44:21 +0100)

----------------------------------------------------------------
Minor bug fixes and documentation cleanups:

  - display packages in CI builds to catch changes
  - stop compiler complaining about exec stacks in test cases
  - stop loongarch compiler complaining about rwx in test cases
  - improve docs on running TCG tests
  - remove old unneeded avocado test for memory callback testing
  - move test plugins into tcg testing dir
  - clean-up and move plugin documentation to emulation section
  - remove dead code from cache modelling plugin
  - add compatibility workaround for lockstep plugin
  - make some noise when building contrib plugins

----------------------------------------------------------------
Alex Bennée (9):
      tests/tcg: update README
      docs/devel: update the testing introduction
      docs/devel: document how to run individual TCG tests
      tests/avocado: remove tcg_plugins virt_mem_icount test
      tests/tcg: move test plugins into tcg subdir
      docs: split TCG plugin usage from devel section
      contrib/plugins: be more vocal building
      contrib/plugins: add compat for g_memdup2
      plugin/loader: handle basic help query

Daniel P. Berrangé (2):
      gitlab: record installed packages in /packages.txt in containers
      gitlab: display /packages.txt in build jobs

Peter Maydell (1):
      contrib/plugins/cache.c: Remove redundant check of l2_access

Richard Henderson (2):
      tests/tcg: Use --noexecstack with assembler files
      tests/tcg/loongarch64: Use --no-warn-rwx-segments to link system tests

 MAINTAINERS                                        |   2 +-
 docs/about/emulation.rst                           | 567 ++++++++++++++++++++-
 docs/devel/tcg-plugins.rst                         | 505 ------------------
 docs/devel/testing.rst                             |  34 +-
 contrib/plugins/cache.c                            |   2 +-
 contrib/plugins/lockstep.c                         |  25 +
 plugins/loader.c                                   |   8 +-
 tests/{plugin => tcg/plugins}/bb.c                 |   0
 tests/{plugin => tcg/plugins}/empty.c              |   0
 tests/{plugin => tcg/plugins}/inline.c             |   0
 tests/{plugin => tcg/plugins}/insn.c               |   0
 tests/{plugin => tcg/plugins}/mem.c                |   0
 tests/{plugin => tcg/plugins}/syscall.c            |   0
 .gitlab-ci.d/buildtest-template.yml                |   1 +
 .gitlab-ci.d/crossbuild-template.yml               |   2 +
 contrib/plugins/Makefile                           |  25 +-
 tests/avocado/tcg_plugins.py                       |  37 +-
 .../dockerfiles/debian-all-test-cross.docker       |   3 +-
 .../docker/dockerfiles/debian-hexagon-cross.docker |   3 +-
 .../dockerfiles/debian-legacy-test-cross.docker    |   3 +-
 .../dockerfiles/debian-loongarch-cross.docker      |   3 +-
 .../docker/dockerfiles/debian-tricore-cross.docker |   3 +-
 .../docker/dockerfiles/debian-xtensa-cross.docker  |   3 +-
 tests/meson.build                                  |   2 +-
 tests/tcg/Makefile.target                          |   6 +-
 tests/tcg/README                                   |  23 +-
 tests/tcg/aarch64/Makefile.softmmu-target          |   2 +-
 tests/tcg/alpha/Makefile.softmmu-target            |   2 +-
 tests/tcg/arm/Makefile.softmmu-target              |   2 +-
 tests/tcg/arm/Makefile.target                      |   2 +-
 tests/tcg/i386/Makefile.softmmu-target             |   2 +-
 tests/tcg/loongarch64/Makefile.softmmu-target      |   4 +-
 tests/{plugin => tcg/plugins}/meson.build          |   6 +-
 tests/tcg/riscv64/Makefile.softmmu-target          |   2 +-
 tests/tcg/s390x/Makefile.softmmu-target            |   2 +-
 tests/tcg/x86_64/Makefile.softmmu-target           |   2 +-
 36 files changed, 697 insertions(+), 586 deletions(-)
 rename tests/{plugin => tcg/plugins}/bb.c (100%)
 rename tests/{plugin => tcg/plugins}/empty.c (100%)
 rename tests/{plugin => tcg/plugins}/inline.c (100%)
 rename tests/{plugin => tcg/plugins}/insn.c (100%)
 rename tests/{plugin => tcg/plugins}/mem.c (100%)
 rename tests/{plugin => tcg/plugins}/syscall.c (100%)
 rename tests/{plugin => tcg/plugins}/meson.build (70%)

-- 
2.39.2


