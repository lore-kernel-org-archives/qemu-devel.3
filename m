Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93DAFC7115C
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Jun 2025 22:18:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uSk3e-0000ay-2b; Fri, 20 Jun 2025 18:18:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uSfWz-00073V-0z
 for qemu-devel@nongnu.org; Fri, 20 Jun 2025 13:28:01 -0400
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uSfWx-0005sS-0c
 for qemu-devel@nongnu.org; Fri, 20 Jun 2025 13:28:00 -0400
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-450cf214200so19977165e9.1
 for <qemu-devel@nongnu.org>; Fri, 20 Jun 2025 10:27:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1750440477; x=1751045277; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=Z58Mj9AHxYXEvEbVh057KHI5t4/Z8R9hueKfYcnEoHE=;
 b=qzfDIVNB8i+legobLa0U1mmd8tMuJ7bWG0fn3PrVvyqOTP0l63Vp9EnUOlW7XMG7A3
 qTWI/KEL+bxdBrNxLoiL19M5ndeOFGTeCz4AmDlODbirejo+TMzQZjoqZzIwYomtXVmw
 gU9U+i2OtUvjcMEcJhCqi9/tm67Q8XvEhXIFEq//vE7AVWrX1HZ7BcmiG9g5LplPyxMi
 YlBN1TetZfdvLePNmCV2FO439J/GhZjMbVkVt4pX/pIV5JNeHfMGC253c5YHXM1YDa/p
 g5CbV1rWSNyVPr4Dt20cMHzt+4xZM2xKo/YrmPDJxxNkNTeBLDAiAN2SIeE1/1pRwjQw
 p7TQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750440477; x=1751045277;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Z58Mj9AHxYXEvEbVh057KHI5t4/Z8R9hueKfYcnEoHE=;
 b=vpKHREcsjWlZ5/16+aEBRVuBT3N/7YoD4RXhfvA1CRR66F6xV7IprbNjdOqKsHUosp
 FqibN+YAW254WFCNv2g7gvG3TiyMVYzizIAcVKvZJAzOZzjmUglgPhwqVEs3ZZZ7aQu6
 4gogs9XR0N1uOq87l9OkJEfF8kM6WocXj05NzptlqBwA+Y3FWl2iwFryVyXzo8SiA8Bs
 vslNr4QDt/3YpWRwYggTnUGlA6I0IDsQqV6J1g0QQP6b/wusMkOC+VQfeoe6A7drKO1e
 +AgWxOn1vYc6G9jT7/KnejtCJnKmAIFYC9TtVtUQXyBdELM8m0H+i2sjF/54zPXO521G
 lxjw==
X-Gm-Message-State: AOJu0YxhjgI0o23ChuKd+DrnDeqa8r0lS/2jw3XhwjTu1aL8lEw1nHhp
 xr7nkz14JmgZOWptXSWTPWq+Y8vEePupbsCHmAFOYbOcGlst9Rd8SYSp1kpnLHlkHo4YgSygSGD
 x9EzyU4Cwsw==
X-Gm-Gg: ASbGncsZLIujEcHULPCtVTdclT9US/FB1saq9In2TAQzB3y6TvXZ+tP/GWcof2HPLXp
 5TGI6cauTBsFBPAlLNUX3mFvBFOVdmd5Ce05zMSXgYA7PtVzbX2Vi8CruzZOUgw7cStq1ncFrrw
 wKPCwjxIDGPfoaBk4Y5SPsXZ7GWBckeCQI/jbMtIJm4X0Aq/lMP1nEjEMF00R44DiMn2+DD+N8u
 W4UQe0DxpQIvH3h1Q0biFK3yyAOuTkGo21Xa0Tfac32U2g5lyJEqMv8buNvkU+/cZXSjyEzq3UJ
 ng+S+MlTizB20TwoSXqIzk4asntgoSeHasLSsI2FDZlsZokJvNVajrIyEA7IOwFycvLlmp7v+kJ
 MxeSAUZ1dPZdO+YS1k+JFlo17d5xVnLQXDIJVTsm8rUS0rFiHTpQMtWuN
X-Google-Smtp-Source: AGHT+IELpMWEEJg2772d4kDJYxelxol+C3W5lX1LKEWw1gTabBQbE8A/kvszZ9A8u1AVv61B4xMJVQ==
X-Received: by 2002:a05:600c:3b14:b0:43d:fa59:be39 with SMTP id
 5b1f17b1804b1-45365a0acfdmr33474415e9.33.1750440476612; 
 Fri, 20 Jun 2025 10:27:56 -0700 (PDT)
Received: from localhost.localdomain
 (101.red-95-127-63.dynamicip.rima-tde.net. [95.127.63.101])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-45364703f1esm31662015e9.32.2025.06.20.10.27.53
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 20 Jun 2025 10:27:56 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Alexander Graf <agraf@csgraf.de>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Julian Armistead <julian.armistead@linaro.org>,
 Cameron Esfahani <dirty@apple.com>, Mark Burton <mburton@qti.qualcomm.com>,
 Thomas Huth <thuth@redhat.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [RFC PATCH RESEND 00/42] accel/split/arm: Run EL2 using TCG and
 EL1/EL0 in hardware with HVF
Date: Fri, 20 Jun 2025 19:27:08 +0200
Message-ID: <20250620172751.94231-1-philmd@linaro.org>
X-Mailer: git-send-email 2.49.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32d.google.com
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

Hi,

This RFC is a proof-of-concept we can have QEMU run both software
emulator (TCG) and hardware accelerator (here HVF). Unfortunately
I'm exhausted so I'll let Alex explain what this is about,
otherwise I'll post the real cover letter next Monday after
getting some rest.

Full work available in the split-accel-rfc-v5 tag:
https://gitlab.com/philmd/qemu/-/commits/split-accel-rfc-v5

Regards,

Phil.

Julian Armistead (1):
  accel/split: Minimal stubs for split accelerator

Philippe Mathieu-Daudé (41):
  accel/split: Define SplitAccelState
  accel/split: Implement cpus_are_resettable()
  accel/split: Implement accel_init_machine()
  accel/split: Expose 'hw' and 'sw' properties
  accel/split: Empty setup_post()
  accel/split: Implement supports_guest_debug()
  accel/split: Implement gdbstub_supported_sstep_flags()
  accel/split: Add cpu_thread_routine() stub
  accel/split: Define and allocate AccelCPUState
  accel/split: Register MTTCG
  accel/split: Have thread routine ready to dispatch over HW/SW
  accel/split: Implement cpu_reset_hold()
  accel/split: Implement synchronize_post_init()
  accel/split: Implement synchronize_pre_resume()
  accel/split: Implement synchronize_state()
  accel/split: Implement synchronize_post_reset()
  accel/split: Implement synchronize_pre_loadvm()
  accel/split: Implement kick_vcpu_thread()
  accel/split: Implement cpu_common_realize()
  accel/split: Set use_hw in cpu_thread_routine() and switch over
  accel/split: Add few trace events in cpu_thread_routine handler
  target/arm: Implement SysemuCPUOps::can_accelerate() handler
  accel/split: Implement handle_interrupt()
  accel/split: Empty ops_init()
  accel/split: Empty set/get_virtual_clock()
  accel/split: Empty get_elapsed_ticks()
  accel/split: Empty cpu_thread_is_idle()
  accel/split: Kludge qemu_tcg_mttcg_enabled()
  accel/split: Implement remove_all_breakpoints()
  accel/split: Implement remove_breakpoint()
  accel/split: Implement insert_breakpoint()
  accel/split: Implement update_guest_debug()
  accel/split: Implement get_[vcpu]_stats()
  target/arm: Emulate EL2 under TCG
  target/arm: Have ERET switch to hw accel for EL0/EL1
  accel/hvf: Emulate HVC at EL2
  accel/tcg: Introduce TCGCPUOps::rebuild_tb_hflags handler
  target/arm: Implement TCGCPUOps::rebuild_tb_hflags()
  accel/split: Call TCGCPUOps::rebuild_tb_hflags()
  tests/functional: Add split_available() helper
  tests/functional: Test Aarch64 virt machine with split-accelerator

 meson.build                                 |   1 +
 accel/split/split-accel.h                   |  54 +++
 accel/split/trace.h                         |   2 +
 accel/tcg/internal-common.h                 |   1 +
 include/accel/tcg/cpu-ops.h                 |   2 +
 include/exec/cpu-common.h                   |   1 +
 include/system/accel-ops.h                  |   8 +
 target/arm/cpu.h                            |   2 +
 accel/split/split-accel-ops.c               | 381 ++++++++++++++++++++
 accel/split/split-all.c                     | 196 ++++++++++
 accel/tcg/cpu-exec.c                        |   9 +
 accel/tcg/tcg-accel-ops.c                   |   1 +
 accel/tcg/tcg-all.c                         |   1 +
 system/vl.c                                 |   4 +
 target/arm/cpu.c                            |   9 +
 target/arm/cpu64.c                          |   7 +-
 target/arm/hvf/hvf.c                        |   6 +
 target/arm/tcg/cpu-v7m.c                    |   1 +
 target/arm/tcg/helper-a64.c                 |   9 +
 target/arm/tcg/hflags.c                     |   5 +
 accel/Kconfig                               |   6 +
 accel/meson.build                           |   1 +
 accel/split/meson.build                     |   9 +
 accel/split/trace-events                    |   9 +
 python/qemu/utils/__init__.py               |   3 +-
 python/qemu/utils/accel.py                  |  10 +
 tests/functional/meson.build                |   1 +
 tests/functional/qemu_test/testcase.py      |   4 +-
 tests/functional/test_aarch64_virt_split.py |  69 ++++
 29 files changed, 808 insertions(+), 4 deletions(-)
 create mode 100644 accel/split/split-accel.h
 create mode 100644 accel/split/trace.h
 create mode 100644 accel/split/split-accel-ops.c
 create mode 100644 accel/split/split-all.c
 create mode 100644 accel/split/meson.build
 create mode 100644 accel/split/trace-events
 create mode 100644 tests/functional/test_aarch64_virt_split.py

-- 
2.49.0


