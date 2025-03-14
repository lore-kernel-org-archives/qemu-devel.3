Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04D8EC282EC
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Mar 2025 13:17:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tt4u5-00055y-7H; Fri, 14 Mar 2025 09:16:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tt4u3-00054h-P2
 for qemu-devel@nongnu.org; Fri, 14 Mar 2025 09:16:43 -0400
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tt4u1-00011h-P3
 for qemu-devel@nongnu.org; Fri, 14 Mar 2025 09:16:43 -0400
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-390e3b3d3f4so1231399f8f.2
 for <qemu-devel@nongnu.org>; Fri, 14 Mar 2025 06:16:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741958200; x=1742563000; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=HGD+ON4QaFWqAADoWp87jJ/O0EiVbY2+DMqteJA7PvM=;
 b=LIOqMy/zstuUTPZmBM01MOBJXzoBLVPzRLp+Hr1HU3vYTYU5hWiO7Pr0EmmLd1mzCs
 rsmpYdZafy49SukTkRKKYfCuP7elyXJsAefruzPAsz6DLtZygK1r+Lcps1tOc9Bees51
 qY0EV6z1/cSdghFcdF9yOoJ6qdXgagUgGXNWHaek/s2JkwgSDX8OGSuT0GvFMCwFPFlv
 2KrrCHn9I6bHkY5wmraPnNqjWvc1KOh9cCemAwMhsrDg8rxiBiqcVDNyGRBQQMOjJYLK
 q+wiSXLNqZSZD84a0RMehBfoGjYWfgra1Q3J4pdK/ycdxBsU9ig5cj6rDMtcMHJEXSil
 5PpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741958200; x=1742563000;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=HGD+ON4QaFWqAADoWp87jJ/O0EiVbY2+DMqteJA7PvM=;
 b=tgRU5zBkn3pIjjsEh1vEUP9kyyB3XqbqAJa+kJDEiZW17RxHDtCkhV0q3l6H8dXsEK
 Mq6+PhyyJSDC+QEgeqH1vApodI7Ac9+ByrrZIO77FalzcbBDHrJ65WXPYPgciuYgc0NS
 k+vnM/UW/dcDX/OSZ0roLX4w0nKV6xJ59zzGHyddRBW65zUteUH/fiVGHDj6MjtmZnp8
 ZIvz5cROFgWNh0eF4Gpwi6CIobmPBKWqCvzbTosIdGjKG8XFZe5q4bujPTKN6ynMhiD2
 Zu7k20619/9+7WcTK8jN2TLCf1MId/s41Zv96idNwtCMvUL2xZrM4u7D3q/PAzZOY0fb
 Mghg==
X-Gm-Message-State: AOJu0YxlVxZpdUzLOBWuJ+LRaz7QBYZWrIBSlWNFoUMpWJ8Kxtlzluef
 QGx1W6eDYjlZslnRnOytXriGXpZlQtM4/th7gRtwvr5Lwv0//K9Uyd1ddam8xZ2wtFb1qelwTJI
 6
X-Gm-Gg: ASbGncsptq7Qk+o7ssUMNK49Zirj+cgP9uCmbn/1uiBJWUbICjH4JbpQfTIWRHazi54
 cny2Zo+gnVdGQVqpmGTTgiml4NEG1QpyvRqtRa4hZPDtO6+5XJt3p4exhXRNPIg0YgOFsdKU8YF
 LnIMFU5TvrYOtnhMOKCaEQBdphlXbc4omoj+sSGkyeCmXMM/QKAm3GbBjvhKjAdp0s5zqUXaZx4
 GDrBFjxd6Ny/lgGyaKOGI3IvKIKih8OPfcjZTLP/m7kIC4QYXEM+7hf55sWdgyLsiGZT+QTqoud
 YFBq5CARv/6AhR7+NugpFf685hnclVlP56lVLS4MXeBg/vNMMZY=
X-Google-Smtp-Source: AGHT+IFr9LmouJHO6Yp5h+oPNU56HAeUUc6BnCXdrF2/KgJ0iuQbXG4Upgmp1Ce1msOzljx8e0zmbA==
X-Received: by 2002:a5d:588c:0:b0:391:22e2:cd21 with SMTP id
 ffacd0b85a97d-3971fadc3admr2925948f8f.36.1741958199517; 
 Fri, 14 Mar 2025 06:16:39 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-395cb7eb93csm5437923f8f.86.2025.03.14.06.16.38
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 14 Mar 2025 06:16:38 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 00/17] target-arm queue
Date: Fri, 14 Mar 2025 13:16:20 +0000
Message-ID: <20250314131637.371866-1-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::433;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x433.google.com
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

Hi; here's a target-arm pullreq for rc0; these are all bugfixes
and similar minor stuff.

thanks
-- PMM

The following changes since commit 0462a32b4f63b2448b4a196381138afd50719dc4:

  Merge tag 'for-upstream' of https://repo.or.cz/qemu/kevin into staging (2025-03-14 09:31:13 +0800)

are available in the Git repository at:

  https://git.linaro.org/people/pmaydell/qemu-arm.git tags/pull-target-arm-20250314-1

for you to fetch changes up to a019e15edfd62beae1e2f6adc0fa7415ba20b14c:

  meson.build: Set RUST_BACKTRACE for all tests (2025-03-14 12:54:33 +0000)

----------------------------------------------------------------
target-arm queue:
 * Correctly handle corner cases of guest attempting an exception
   return to AArch32 when target EL is AArch64 only
 * MAINTAINERS: Fix status for Arm boards I "maintain"
 * tests/functional: Bump up arm_replay timeout
 * Revert "hw/char/pl011: Warn when using disabled receiver"
 * util/cacheflush: Make first DSB unconditional on aarch64
 * target/arm: Fix SVE/SME access check logic
 * meson.build: Set RUST_BACKTRACE for all tests

----------------------------------------------------------------
Joe Komlodi (1):
      util/cacheflush: Make first DSB unconditional on aarch64

Paolo Bonzini (1):
      Revert "hw/char/pl011: Warn when using disabled receiver"

Peter Maydell (13):
      target/arm: Move A32_BANKED_REG_{GET,SET} macros to cpregs.h
      target/arm: Un-inline access_secure_reg()
      linux-user/aarch64: Remove unused get/put_user macros
      linux-user/arm: Remove unused get_put_user macros
      target/arm: Move arm_cpu_data_is_big_endian() etc to internals.h
      target/arm: Move arm_current_el() and arm_el_is_aa64() to internals.h
      target/arm: SCR_EL3.RW should be treated as 1 if EL2 doesn't support AArch32
      target/arm: HCR_EL2.RW should be RAO/WI if EL1 doesn't support AArch32
      target/arm: Add cpu local variable to exception_return helper
      target/arm: Forbid return to AArch32 when CPU is AArch64-only
      MAINTAINERS: Fix status for Arm boards I "maintain"
      tests/functional: Bump up arm_replay timeout
      meson.build: Set RUST_BACKTRACE for all tests

Richard Henderson (2):
      target/arm: Make DisasContext.{fp, sve}_access_checked tristate
      target/arm: Simplify pstate_sm check in sve_access_check

 MAINTAINERS                         |  14 ++--
 meson.build                         |   9 ++-
 target/arm/cpregs.h                 |  28 +++++++
 target/arm/cpu.h                    | 153 +-----------------------------------
 target/arm/internals.h              | 135 +++++++++++++++++++++++++++++++
 target/arm/tcg/translate-a64.h      |   2 +-
 target/arm/tcg/translate.h          |  10 ++-
 hw/char/pl011.c                     |  19 ++---
 hw/intc/arm_gicv3_cpuif.c           |   1 +
 linux-user/aarch64/cpu_loop.c       |  48 -----------
 linux-user/arm/cpu_loop.c           |  43 +---------
 target/arm/arch_dump.c              |   1 +
 target/arm/helper.c                 |  16 +++-
 target/arm/tcg/helper-a64.c         |  12 ++-
 target/arm/tcg/hflags.c             |   9 +++
 target/arm/tcg/translate-a64.c      |  37 ++++-----
 util/cacheflush.c                   |   4 +-
 .gitlab-ci.d/buildtest-template.yml |   1 -
 18 files changed, 257 insertions(+), 285 deletions(-)

