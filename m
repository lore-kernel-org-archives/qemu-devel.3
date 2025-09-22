Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C2C6CAC592
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Sep 2025 09:39:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v0czC-0001x1-3x; Mon, 22 Sep 2025 05:37:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1v0cz2-0001qR-GQ
 for qemu-devel@nongnu.org; Mon, 22 Sep 2025 05:37:20 -0400
Received: from mail-wr1-x435.google.com ([2a00:1450:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1v0cyz-0000cG-4K
 for qemu-devel@nongnu.org; Mon, 22 Sep 2025 05:37:20 -0400
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-3ecdf2b1751so2388984f8f.0
 for <qemu-devel@nongnu.org>; Mon, 22 Sep 2025 02:37:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1758533834; x=1759138634; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=DY0XmkUw/px6He2/QViLhoiKimIF9WS2BOzUGcig47M=;
 b=PRJhJXsQuRNVUX4enWK7NFbkSDSg0iemfSk5i549omoA0IaoiJNnV0MVuPyfBse8Pg
 Tov9TRIezI/UsJvSCq1S5ujaiIUfjr58Bzq3AitgEFizGBZU4NHnKqoajYvz36DMGITu
 8mHCiLFZC1AYpxUEy1tMVTWyvw2Za0houDPMRac7MenoHmiAIhQReXpQwuiw1sGghjns
 6bthUT/WIUU16q4FwLvrhCOdRBBxPB8MJftFMUouQQxkJkRuv6QkKVNlPH0saItxZA4T
 ANarUY00AuZ9gRRl8gtxoS61WX3PKbvR2mNsnUr21+NNozXeR+7KxJ0xqmXo0HBaC4P0
 u6Lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758533834; x=1759138634;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=DY0XmkUw/px6He2/QViLhoiKimIF9WS2BOzUGcig47M=;
 b=effw5buWzMZ9ifutRDGc0GBvH4Ls/B+XdGI6b3jFQ7fMrGsSsLA7RJJBFYBGRai4xI
 nJDCzdCrZMgcSk0MFejDN6wmgZ19TvM6l/5PWxyJmLreAjLumU9PElo3457c7qymhAaq
 6ZcJORhEerxGLbIm0pymuPFAa6Wxi2rTtQAdiRI5SxpPwkaGStZ5fA1RKSrO63U79Hoe
 f3IEhU4w5RkVwraX6fGeBNtLjtlGeb0y40UY5CKlIpQuGzP5G1gm2x3OF09jXJFpQq61
 Djccz9Tne1qI0zDNQmfdaZoYf2bVveRnV9EvVwHmqtROw52r2MB6beecG0Bhc6OIyWpg
 6ZuQ==
X-Gm-Message-State: AOJu0Yx/Fp6cJVshGK+VkGjrBZWgTzgV3OI6BqxXdc2705rP8CQ+fMyW
 rfvw0b2MGaTlrSVo21u+XoZG2LcH5v+BaJ9KGwu3iZWClQpm6eZZb+XgT01citgb+QE=
X-Gm-Gg: ASbGncugOpE+gUoo/HIh7JilyLZc8cWQYDNZVgPDr7Ai4sX5rTBU5LyEEO6B4OTrbG2
 bjdNKgW0RZrW1j5Z3xVFGkT5VGQoYxuGqetUKIGCjtffTlr28VMNZJY1I7Sn0bvh7XndvYN14bv
 rF16CwLvcSKOi90ykM6+0R6jwUKnrpCblbTOd9eExhHggryzDl+14Rrpwp3zVNj0hFd9EjDks+D
 slInSp3Am/Pca0f376ZCAd3f4buxy9E9TdYVtyDvhptDV1/yRuBnlma4yPEP+9+C+YxCmS0ZlYP
 IL95odRkANEm3Z2eip071I8TjHzMnqDOrHj9TklxSr+XMLMfiLTX+LanGjo5mW7JhQprYLYoG8E
 RUgu6sL1GHTvVQuFIZZZO4b4LoPkT7I+PRQ==
X-Google-Smtp-Source: AGHT+IHWrI4/43aheYywm2/WnfKmVmn8vZizXgUs4ZCZPfXuPbJzRHgAuqENnwGr/lbSzIRfsf+B8Q==
X-Received: by 2002:a05:6000:440a:b0:3f9:e348:f5c with SMTP id
 ffacd0b85a97d-3f9e34815b0mr2918240f8f.60.1758533834086; 
 Mon, 22 Sep 2025 02:37:14 -0700 (PDT)
Received: from draig.lan ([185.126.160.19]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-46d7a566a27sm27122065e9.20.2025.09.22.02.37.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 22 Sep 2025 02:37:12 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 85B005F7B1;
 Mon, 22 Sep 2025 10:37:11 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Palmer Dabbelt <palmer@dabbelt.com>, Alexandre Iooss <erdnaxe@crans.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>, qemu-riscv@nongnu.org,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Thomas Huth <thuth@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Alistair Francis <alistair.francis@wdc.com>, qemu-arm@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Weiwei Li <liwei1518@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>
Subject: [PATCH 00/25] September maintainer updates (docs, plugins,
 semihosting) pre-PR
Date: Mon, 22 Sep 2025 10:36:45 +0100
Message-ID: <20250922093711.2768983-1-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::435;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x435.google.com
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

These are all bits and pieces that have been mostly reviewed when
posted with a few minor additional patches. I plan to send the PR by
the end of the week.

Plugins

  - minor fix checking return values from Peter
  - Pierrick's nifty uftrace plugin

Semihosting

  - build the sub-system once (single binary work)

Misc

  - typo fix
  - tweak to checkpatch license checking
  - *new* gitlab-failure-analysis script

The following still need review:

  scripts/ci: add gitlab-failure-analysis script
  docs/devel: fix typo in code-provenance.rst

Alex.

Alex Bennée (2):
  docs/devel: fix typo in code-provenance.rst
  scripts/ci: add gitlab-failure-analysis script

Nabih Estefan (1):
  checkpatch: Ignore removed lines in license check

Peter Maydell (1):
  contrib/plugins/execlog: Explicitly check for
    qemu_plugin_read_register() failure

Pierrick Bouvier (21):
  semihosting/syscalls: compile once in system and per target for user
    mode
  semihosting/syscalls: replace uint64_t with vaddr where appropriate
  semihosting/guestfd: compile once for system/user
  semihosting/arm-compat-semi: change common_semi_sys_exit_extended
  target/riscv/common-semi-target: remove sizeof(target_ulong)
  target/{arm, riscv}/common-semi-target: eradicate target_ulong
  include/semihosting/common-semi: extract common_semi API
  semihosting/arm-compat-semi: eradicate sizeof(target_ulong)
  semihosting/arm-compat-semi: replace target_ulong with vaddr
  semihosting/arm-compat-semi: eradicate target_long
  semihosting/arm-compat-semi: remove dependency on cpu.h
  semihosting/arm-compat-semi: compile once in system and per target for
    user mode
  contrib/plugins/uftrace: skeleton file
  contrib/plugins/uftrace: define cpu operations and implement aarch64
  contrib/plugins/uftrace: track callstack
  contrib/plugins/uftrace: implement tracing
  contrib/plugins/uftrace: implement privilege level tracing
  contrib/plugins/uftrace: generate additional files for uftrace
  contrib/plugins/uftrace: implement x64 support
  contrib/plugins/uftrace_symbols.py
  contrib/plugins/uftrace: add documentation

 docs/about/emulation.rst                      | 199 ++++
 docs/devel/code-provenance.rst                |   2 +-
 include/semihosting/common-semi.h             |   6 +
 include/semihosting/guestfd.h                 |   7 -
 include/semihosting/semihost.h                |   2 +
 include/semihosting/syscalls.h                |  30 +-
 contrib/plugins/execlog.c                     |   1 +
 contrib/plugins/uftrace.c                     | 878 ++++++++++++++++++
 semihosting/arm-compat-semi-stub.c            |  19 +
 semihosting/arm-compat-semi.c                 |  63 +-
 semihosting/guestfd.c                         |  26 +-
 semihosting/syscalls.c                        | 109 ++-
 ...mon-semi-target.h => common-semi-target.c} |  22 +-
 ...mon-semi-target.h => common-semi-target.c} |  23 +-
 contrib/plugins/meson.build                   |   3 +-
 contrib/plugins/uftrace_symbols.py            | 152 +++
 scripts/checkpatch.pl                         |   3 +-
 scripts/ci/gitlab-failure-analysis            | 117 +++
 semihosting/meson.build                       |  18 +-
 target/arm/meson.build                        |   4 +
 target/riscv/meson.build                      |   4 +
 21 files changed, 1539 insertions(+), 149 deletions(-)
 create mode 100644 contrib/plugins/uftrace.c
 create mode 100644 semihosting/arm-compat-semi-stub.c
 rename target/arm/{common-semi-target.h => common-semi-target.c} (59%)
 rename target/riscv/{common-semi-target.h => common-semi-target.c} (53%)
 create mode 100755 contrib/plugins/uftrace_symbols.py
 create mode 100755 scripts/ci/gitlab-failure-analysis

-- 
2.47.3


