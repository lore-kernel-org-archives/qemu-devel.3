Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C49DFD73E87
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Jan 2026 17:38:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vlVyJ-0004M4-9i; Thu, 29 Jan 2026 12:38:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vlVyH-0004JY-MT
 for qemu-devel@nongnu.org; Thu, 29 Jan 2026 12:38:21 -0500
Received: from mail-pf1-x42f.google.com ([2607:f8b0:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vlVyF-0000d6-CV
 for qemu-devel@nongnu.org; Thu, 29 Jan 2026 12:38:21 -0500
Received: by mail-pf1-x42f.google.com with SMTP id
 d2e1a72fcca58-81e821c3d4eso1094085b3a.3
 for <qemu-devel@nongnu.org>; Thu, 29 Jan 2026 09:38:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1769708297; x=1770313097; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=I1T0IHkT1j7CAh04oAglc0N/G/BUP4Rx8GN1KL6/VAo=;
 b=mghmAmyS5vwEwmJXl5+eMKCP2ngxOFaVXZwo/2UPHLb5vINI/6SdJQmpKEuDQQxF14
 dXz+LL8F77dGIIY1ahrkW+tEq1TJQ1+OhXt2+XecTlqjp7uY00S0lY0EF3N4mBUHy/30
 6aqEvjrsQ3/L8xvVG4El8oLpEW2R/xmPsTUr9VUz4oMC+jYgB8t8o9EcUpkziHiQUvKs
 zq7nR0D43oMK1Fw5HJ46DZp+IXlDGBdgxl9MwzDfEetxz4HJLZm4qcwDbFtWffKqbKBn
 QKrBPIkaqT9Rmq1VYo3Ezl65NCv5kFTwyHeAgmwCZqHT7WSfZDNp2Qmjl4ESr7ailNG7
 Jdsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769708297; x=1770313097;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=I1T0IHkT1j7CAh04oAglc0N/G/BUP4Rx8GN1KL6/VAo=;
 b=kly9giBXa9Usd7fo9rD0mEnCG4Mtvt8H0MMfK5nxbf+NQkoG56uauxyBWVJdzKqF3W
 z7JikYMEzwVFmrfE+qxAfqqMOcLS+q9GC70B9ZcFXOKxDopSOIrzdG9zyJzaFWYfLod7
 1pmGKKpaMlpmyM9BbtSavCKHGTlzaJ05kScQo7aCfYCX8SglcSAGaNWFptEGlcdZRCMV
 C230JDoPej+5G3Xgh8UpanAfkObBGLagjmXrC3qb9kAgzxsiIIdtyKJzxArlsMbMLH/P
 5uj9XA5B7MofZk6pxn+ZfgCR2S9328XNNdJqcPX2GskTJSofxwiGeK90o66cbiNoR9a4
 fcTQ==
X-Gm-Message-State: AOJu0YzNnPm0vqfWmUsXt/St5DiINBAppKherjF9f2L+Lij0GxRZUsNw
 w8c2XyCKuycm8Vr+VmTimfqkhfCL2Uu7EPL+LVh9UboGVKYvxyfs9xx7d29PPBpqbSIZP8moNST
 ugexW
X-Gm-Gg: AZuq6aIRS4AfCm5Vrg3aqIU5Qpc2Jnj/t6WU9ou6/iqsei2pgT3IpGZoXf3KHOTMbUV
 Gmi4HjMCdeV3CXy7uSzNwgO1B3KEBJgLZJmXDGiorZtOyoCzY5XtY0vH4pS4jsIzbK84BGcwVC9
 Q35Q5fElN9Q48dy7N+c0s1LUzAStRXXT+omR8hjwGi8vRgBAMsQaiLWu8liehjRSw+1NPzvyDjG
 FmLiAC1nDIWtH+9ahDWccyUJizfJjSYa0bFbP/QSTGKJkkzhkDfF255Oti1tj699lioOXwflg6v
 BUHD3I717gnNzzR9ek/aXV2wrzPsXY2GbETWwLBUfSB1AWlUJM9j+GeY1L1VcwYwvatv7WS2FiG
 dvFKhP+siQtzq2qBRCefkFdP1GPUvOqNbdEoNgiz276TJvIrHoRoIN3VQTWj7mbY+SXS/r1zip0
 wKHv7Teemsw0dCLPHfMwigNM+RiSdPq+5HbnzijN+X9GloT9ZvrTMI71XQnmXGAgBIdLs99+KX3
 eI=
X-Received: by 2002:a05:6a00:1898:b0:823:d58:c4ab with SMTP id
 d2e1a72fcca58-82369165b1amr8486825b3a.2.1769708297291; 
 Thu, 29 Jan 2026 09:38:17 -0800 (PST)
Received: from pc.taild8403c.ts.net (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-82379b222f1sm6706246b3a.7.2026.01.29.09.38.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 29 Jan 2026 09:38:16 -0800 (PST)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PULL 00/21] Plugins patches for 2026-01-29
Date: Thu, 29 Jan 2026 09:37:46 -0800
Message-ID: <20260129173811.138036-1-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.47.3
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42f;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x42f.google.com
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

The following changes since commit 65fb9de4888f9bf32bc4f60c880da3dff04c4fd9:

  Merge tag 'pr-build_fix-20260128' of https://gitlab.com/pbo-linaro/qemu into staging (2026-01-29 13:29:33 +1100)

are available in the Git repository at:

  https://gitlab.com/pbo-linaro/qemu tags/pr-plugins-20260129

for you to fetch changes up to bed25f00d306bbbcc85d068b6469fc00aeecbd11:

  plugins: reduce source conflicts in plugins list (2026-01-29 09:34:14 -0800)

----------------------------------------------------------------
Changes:
- contrib/plugins/hotblocks: Minor bug fixes and add limit argument (Alex Bradbury <asb@igalia.com>)
- linux-user: introduce syscall-filter plugin API (Ziyang Zhang <functioner@sjtu.edu.cn>)
- plugins: return bool from register r/w API (Florian Hofhammer <florian.hofhammer@fhofhammer.de>)
- plugins: enable C++ plugins (Pierrick Bouvier <pierrick.bouvier@linaro.org>)
- plugins: reduce source conflicts in plugins list (Pierrick Bouvier <pierrick.bouvier@linaro.org>)

----------------------------------------------------------------
Alex Bradbury (5):
      contrib/plugins/hotblocks: Correctly free sorted counts list
      contrib/plugins/hotblocks: Fix off by one error in iteration of sorted blocks
      contrib/plugins/hotblocks: Print uint64_t with PRIu64 rather than PRId64
      docs/about/emulation: Add documentation for hotblocks plugin arguments
      contrib/plugins/hotblocks: Allow limit to be set as a command line argument

Florian Hofhammer (1):
      plugins: return bool from register r/w API

Pierrick Bouvier (13):
      linux-user: move user/syscall-trace.h to linux-user/syscall.c
      plugins: move win32_linker.c file to plugins directory
      plugins: factorize plugin dependencies and library details
      plugins: use complete filename for defining plugins sources
      plugins: define plugin API symbols as extern "C" when compiling in C++
      tests/tcg/plugins/mem.c: remove dependency on qemu headers
      plugins: move qemu-plugin.h to include/plugins/
      meson: fix supported compiler arguments in other languages than C
      meson: enable cpp (optionally) for plugins
      qga/vss-win32: fix clang warning with C++20
      meson: update C++ standard to C++23
      contrib/plugins: add empty cpp plugin
      plugins: reduce source conflicts in plugins list

Ziyang Zhang (2):
      linux-user: add plugin API to filter syscalls
      tcg tests: add a test to verify the syscall filter plugin API

 docs/about/emulation.rst                         |  12 +++
 docs/devel/tcg-plugins.rst                       |   4 +-
 meson.build                                      |  26 ++---
 include/{qemu => plugins}/qemu-plugin.h          |  62 +++++++++---
 include/qemu/plugin-event.h                      |   1 +
 include/qemu/plugin.h                            |  35 +++++--
 include/user/syscall-trace.h                     |  43 --------
 bsd-user/freebsd/os-syscall.c                    |   1 -
 contrib/plugins/execlog.c                        |  14 +--
 contrib/plugins/hotblocks.c                      |  20 ++--
 contrib/plugins/uftrace.c                        |   8 +-
 linux-user/syscall.c                             |  44 ++++++++-
 plugins/api.c                                    |  36 ++++---
 plugins/core.c                                   |  39 +++++++-
 {contrib/plugins => plugins}/win32_linker.c      |   0
 tests/tcg/multiarch/test-plugin-syscall-filter.c |  39 ++++++++
 tests/tcg/plugins/insn.c                         |   4 +-
 tests/tcg/plugins/mem.c                          |  59 +++++------
 tests/tcg/plugins/syscall.c                      |  19 ++++
 contrib/plugins/cpp.cpp                          | 119 +++++++++++++++++++++++
 contrib/plugins/meson.build                      |  38 +++++---
 plugins/meson.build                              |  17 +++-
 qga/vss-win32/requester.cpp                      |   6 +-
 tests/tcg/multiarch/Makefile.target              |   7 +-
 tests/tcg/plugins/meson.build                    |  27 ++---
 25 files changed, 497 insertions(+), 183 deletions(-)
 rename include/{qemu => plugins}/qemu-plugin.h (95%)
 delete mode 100644 include/user/syscall-trace.h
 rename {contrib/plugins => plugins}/win32_linker.c (100%)
 create mode 100644 tests/tcg/multiarch/test-plugin-syscall-filter.c
 create mode 100644 contrib/plugins/cpp.cpp

