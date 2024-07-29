Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F020C3DA4A
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jul 2024 14:45:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sYRbr-0003dy-JK; Mon, 29 Jul 2024 10:44:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sYRbq-0003b3-EW
 for qemu-devel@nongnu.org; Mon, 29 Jul 2024 10:44:22 -0400
Received: from mail-ej1-x62c.google.com ([2a00:1450:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sYRbm-0008MQ-OE
 for qemu-devel@nongnu.org; Mon, 29 Jul 2024 10:44:21 -0400
Received: by mail-ej1-x62c.google.com with SMTP id
 a640c23a62f3a-a7a81bd549eso323558066b.3
 for <qemu-devel@nongnu.org>; Mon, 29 Jul 2024 07:44:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1722264257; x=1722869057; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=eU1U0CRnG69r+xwrYAiab1VshqFyV1qABAq/chKJ/jE=;
 b=KPiidmodxC6u+SG8U6gKAlKgrTK8wcM9UalR1w5ZgNVJMYUkothjz+b+8as+SWax0Q
 s2b7pFIusvuoGM20WYVT7qB+e4XKGR+cvIS0oesBnQiQa3iRkmS6jtQIKZfDHl3PgQIj
 UxfM25mY8CHwaj4dh+mZLGE9NvbnoBoS+P+lRFbkRRiAC09ttTzYXuAnqyoxcpyaCzxl
 wQ/mlIDVy8tcnK59bJWc7xA9Mu+LOSVM9nOECINXnFYAl6Ht33W5F4xVm2o3Ecn+ZK5Y
 cvz6U3qiduvJ1Flwrog1aSPfrBGxDLapFVPuVrZ5HR0Z7C2HGFtCnic8fADlrgJnbkKz
 845g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722264257; x=1722869057;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=eU1U0CRnG69r+xwrYAiab1VshqFyV1qABAq/chKJ/jE=;
 b=MWcU0Lcg6+0JtvOA5Sz+kU0bh1IGoMRO66m/o6YxEJHXiSazliCUj9wSS73M2S3f1r
 7UECgCnZlBDoedYND4N1KYTYKGWf/RKGwFq31GENfaG/hY/9IUgZlnEWHcfp76WIQc6S
 nrLvVRcc78qceu+QFEF8wr4VFoQ+ZCtd+h6iasyXa600MYSlZZ7cHpjcsNqlbh/n2C8M
 ZJX281f+FDoeFvwSmoHtmzpAlOZAxmju+hgAOHuCzwkuK5vVi5SV8U+H01nkg2uVNQoH
 5q4JjU5+VJwpLnRoynm97xZ+QeuyoMdfnGUVMrKYx0Plj6ji+poQ+Ob0CqeO8JHgUbeY
 UTEA==
X-Gm-Message-State: AOJu0YxrJRZ1WPKEBDcAo1iPDTpBBNwrBEW/EM1vR0SHDodGMAj+UKz7
 GxfhAlf9Vyn594G9JhKarCpk8MC1y4G6qbFe0i1FMjNgm46qbDP0uurhCM+UjD0=
X-Google-Smtp-Source: AGHT+IGgjkrV2iIsdjBsLjNP2k/eXWq309IDDAQuMAN0ShQy1FVBMp0vPnfrGfCpPhV3vEWksJiBEQ==
X-Received: by 2002:a17:907:9802:b0:a6f:1036:98cf with SMTP id
 a640c23a62f3a-a7d401509efmr566744566b.54.1722264256340; 
 Mon, 29 Jul 2024 07:44:16 -0700 (PDT)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a7acad911a0sm510956266b.155.2024.07.29.07.44.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 29 Jul 2024 07:44:15 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id F29175F844;
 Mon, 29 Jul 2024 15:44:14 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Eduardo Habkost <eduardo@habkost.net>, Thomas Huth <thuth@redhat.com>,
 Beraldo Leal <bleal@redhat.com>, Palmer Dabbelt <palmer@dabbelt.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Bin Meng <bmeng.cn@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-riscv@nongnu.org, Weiwei Li <liwei1518@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>, qemu-s390x@nongnu.org,
 Cleber Rosa <crosa@redhat.com>, Ilya Leoshkevich <iii@linux.ibm.com>,
 Mahmoud Mandour <ma.mandourr@gmail.com>, qemu-arm@nongnu.org,
 Alexandre Iooss <erdnaxe@crans.org>, Song Gao <gaosong@loongson.cn>,
 David Hildenbrand <david@redhat.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>
Subject: [PATCH 00/14] Various fixes and tweaks for 9.1-rc0/1
Date: Mon, 29 Jul 2024 15:44:00 +0100
Message-Id: <20240729144414.830369-1-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62c;
 envelope-from=alex.bennee@linaro.org; helo=mail-ej1-x62c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

As usual during soft freeze I switch to cleaning up the various
niggles and bugs which have accumulated over the years.

Aside from some test build tweaks and some useful tools for debugging
CI failures I've also moved tests/plugin to tests/tcg/plugins to
better align with contrib/plugins and clearly marking what is TCG
only. I took the opportunity to clean up some of the documentation
while I was at it.

Please review:

  plugin/loader: handle basic help query
  contrib/plugins: add compat for g_memdup2
  contrib/plugins: be more vocal building
  docs: split TCG plugin usage from devel section
  tests/tcg: move test plugins into tcg subdir
  tests/avocado: remove tcg_plugins virt_mem_icount test
  docs/devel: document how to run individual TCG tests
  docs/devel: update the testing introduction
  tests/tcg: update README

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

 MAINTAINERS                                   |   2 +-
 docs/about/emulation.rst                      | 567 +++++++++++++++++-
 docs/devel/tcg-plugins.rst                    | 505 ----------------
 docs/devel/testing.rst                        |  34 +-
 contrib/plugins/cache.c                       |   2 +-
 contrib/plugins/lockstep.c                    |  25 +
 plugins/loader.c                              |   8 +-
 tests/{plugin => tcg/plugins}/bb.c            |   0
 tests/{plugin => tcg/plugins}/empty.c         |   0
 tests/{plugin => tcg/plugins}/inline.c        |   0
 tests/{plugin => tcg/plugins}/insn.c          |   0
 tests/{plugin => tcg/plugins}/mem.c           |   0
 tests/{plugin => tcg/plugins}/syscall.c       |   0
 .gitlab-ci.d/buildtest-template.yml           |   1 +
 .gitlab-ci.d/crossbuild-template.yml          |   2 +
 contrib/plugins/Makefile                      |  25 +-
 tests/avocado/tcg_plugins.py                  |  37 +-
 .../dockerfiles/debian-all-test-cross.docker  |   3 +-
 .../dockerfiles/debian-hexagon-cross.docker   |   3 +-
 .../debian-legacy-test-cross.docker           |   3 +-
 .../dockerfiles/debian-loongarch-cross.docker |   3 +-
 .../dockerfiles/debian-tricore-cross.docker   |   3 +-
 .../dockerfiles/debian-xtensa-cross.docker    |   3 +-
 tests/meson.build                             |   2 +-
 tests/tcg/Makefile.target                     |   6 +-
 tests/tcg/README                              |  23 +-
 tests/tcg/aarch64/Makefile.softmmu-target     |   2 +-
 tests/tcg/alpha/Makefile.softmmu-target       |   2 +-
 tests/tcg/arm/Makefile.softmmu-target         |   2 +-
 tests/tcg/arm/Makefile.target                 |   2 +-
 tests/tcg/i386/Makefile.softmmu-target        |   2 +-
 tests/tcg/loongarch64/Makefile.softmmu-target |   4 +-
 tests/{plugin => tcg/plugins}/meson.build     |   6 +-
 tests/tcg/riscv64/Makefile.softmmu-target     |   2 +-
 tests/tcg/s390x/Makefile.softmmu-target       |   2 +-
 tests/tcg/x86_64/Makefile.softmmu-target      |   2 +-
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


