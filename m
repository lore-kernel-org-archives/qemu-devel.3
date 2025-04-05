Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7EC04C3601A
	for <qemu-devel@archiver.kernel.org>; Sat,  5 Apr 2025 16:14:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u169A-0000UB-Gg; Sat, 05 Apr 2025 12:13:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u1699-0000Tw-K7
 for qemu-devel@nongnu.org; Sat, 05 Apr 2025 12:13:27 -0400
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u1697-0005Bz-GZ
 for qemu-devel@nongnu.org; Sat, 05 Apr 2025 12:13:27 -0400
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-43cfecdd8b2so24008175e9.2
 for <qemu-devel@nongnu.org>; Sat, 05 Apr 2025 09:13:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1743869602; x=1744474402; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=FeGTlSNot+wgnDO91P5sSxXujpX5NMJR6yi56kwLJLQ=;
 b=Hx27HisglgaXi4ppN1LzoV/bODOwJ5Eb3f7tUBgPofKLu3g8NNSulb5ma1BEVn/+rl
 w04MxEBerwVGZSgQdXahLCCW0ZYmX4agwsYXjIpvZgqjL+fPWo2tLl3TKxlWp13Ldheh
 ToU/7wuaKY0HyXhHlmhCfpK7Dizy4qwvePMygCfBIkX4hn3gkF5qoeQ7s1vzijC0SEtj
 HLE1RosSJ1zRLeTCUAwdURw54lhIIKdFoKo42K8A8wucbEch4D5kpHul2QoMXe8ClajJ
 i13XGWV87025GoU8QHR2iWbSKXqyjvbUPVPSOm1DC6xV34ztZcq0wwNH5engzxJK/At4
 3H+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743869602; x=1744474402;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=FeGTlSNot+wgnDO91P5sSxXujpX5NMJR6yi56kwLJLQ=;
 b=ZDoPgqf3MI/jujAvOYXVxdT+IKIP0ZzIdyPopWDjJ6vMnQKUJZk7xeNlGRnOq+LZiK
 jUciSKMKOzmTa37l5d9Gn8bR0sTkIibnOGuiu0AMbYfPRah4DbE2vrKJgdCoP6fhpGsL
 8ZnwuSrtn0a127aP0tk0IOPFulySiuOo/vLH9pA8G1DW1qZf5SBYf+4LAqO+pIOi8v6z
 S+Xg5m11+6VVOyyozHtz/K0wRIdHy3CI1Ju8IdZfDAltRBriGWpGpDElShEhdr9vQaxa
 LQXsa/IoHDqoXUVAhjwE1Ez4zUtTaKo2UuoK0i4GNCa8JO3UFtyvTNs3Afys2rtaoNCe
 2T+g==
X-Gm-Message-State: AOJu0YzIzmWeoLDt8tJ+PKFsrqzrt6cH5Z0W/Kg8+vYkC3qx8Yg9FWKr
 n3tsMVBjqhqtdVAGXRSUfIhwg/nZ1W6wKoVHJ6iQIEtONba/K7oLdjhMcGMKI5sVLTCl+Avt8TY
 7
X-Gm-Gg: ASbGncvcxI+WK/+U2EfXy1ufnbLWg6r9NH2Skf/l8JqSCrBtARa3k/U8hbAFYVSU/T3
 oSCM4fR7I1Nt1Hr2zcSo0bDp8puew3P9DLciIAgRRCSCxqtUGDwLdJC5pkhNaU9CO3/6OtZ/tx7
 gjqeR+rVUBGdPbL6miJmUIZjhcSxSY9LY1T+/xaMiRYGfrGRShlWJlc9ZJSBuUPNpOJ6IGUcGqE
 2nbFACtQOeN7d2GveeM8cmTP6BdIjpB38lTTY15awsQqrBeG+M4xns11sr4xVH6dgxYbVW2AYVm
 UGNyMzO55sPqYi2/4oL+Em7cW6OZi0GHsu+uVV32Itp8kdKQ33wshmE6OLK3BpvepyhFSuOoCjC
 /NI1qauPlfz9yYNyFFJJ8Cing
X-Google-Smtp-Source: AGHT+IEWJW0qjPBVCNB4p81s0vqYkHE/HLm5dJmCwMj9JtWLmXCqozWAlcIDDZiQKn0tlGnfuMjmIQ==
X-Received: by 2002:a05:600c:a4d:b0:43c:ebc4:36a5 with SMTP id
 5b1f17b1804b1-43ee3e9d55dmr19943015e9.7.1743869602405; 
 Sat, 05 Apr 2025 09:13:22 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-39c3020d68esm7319582f8f.67.2025.04.05.09.13.21
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sat, 05 Apr 2025 09:13:21 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH-for-10.1 v4 00/16] tcg: philmd's queue
Date: Sat,  5 Apr 2025 18:13:04 +0200
Message-ID: <20250405161320.76854-1-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
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

Hi Richard,

Here is my patch queue based on your tcg-next tree fixed.

You can find it on my repository:
https://gitlab.com/philmd/qemu/-/tags/tcgops-mttcg-v4

Thanks,

Phil.

Since v3:
- Include Brian's patch
- Fix TCGCPUOps::mttcg_supported on x86/riscv
Since v2:
- Rebased & addressed review comments
Since v1:
- Deferred warning change and updated desc (patches 40 & 42)

Brian Cain (1):
  target/hexagon: Add memory order definition

Philippe Mathieu-Daudé (15):
  target/riscv: Remove AccelCPUClass::cpu_class_init need
  target/i386: Remove AccelCPUClass::cpu_class_init need
  accel: Remove AccelCPUClass::cpu_class_init() callback
  tcg: Always define TCG_GUEST_DEFAULT_MO
  tcg: Simplify tcg_req_mo() macro
  tcg: Define guest_default_memory_order in TCGCPUOps
  tcg: Remove use of TCG_GUEST_DEFAULT_MO in tb_gen_code()
  tcg: Propagate CPUState argument to cpu_req_mo()
  tcg: Have tcg_req_mo() use TCGCPUOps::guest_default_memory_order
  tcg: Remove the TCG_GUEST_DEFAULT_MO definition globally
  tcg: Move cpu_req_mo() macro to target-agnostic 'backend-ldst.h'
  tcg: Move qemu_tcg_mttcg_enabled() to 'system/tcg.h'
  tcg: Convert TCGState::mttcg_enabled to TriState
  tcg: Factor mttcg_init() out
  tcg: Convert TARGET_SUPPORTS_MTTCG to TCGCPUOps::mttcg_supported field

 docs/devel/multi-thread-tcg.rst          |  6 +-
 configs/targets/aarch64-softmmu.mak      |  1 -
 configs/targets/alpha-softmmu.mak        |  1 -
 configs/targets/arm-softmmu.mak          |  1 -
 configs/targets/hppa-softmmu.mak         |  1 -
 configs/targets/i386-softmmu.mak         |  1 -
 configs/targets/loongarch64-softmmu.mak  |  1 -
 configs/targets/microblaze-softmmu.mak   |  1 -
 configs/targets/microblazeel-softmmu.mak |  1 -
 configs/targets/mips-softmmu.mak         |  1 -
 configs/targets/mipsel-softmmu.mak       |  1 -
 configs/targets/or1k-softmmu.mak         |  1 -
 configs/targets/ppc64-softmmu.mak        |  1 -
 configs/targets/riscv32-softmmu.mak      |  1 -
 configs/targets/riscv64-softmmu.mak      |  1 -
 configs/targets/s390x-softmmu.mak        |  1 -
 configs/targets/sparc-softmmu.mak        |  1 -
 configs/targets/sparc64-softmmu.mak      |  1 -
 configs/targets/x86_64-softmmu.mak       |  1 -
 configs/targets/xtensa-softmmu.mak       |  1 -
 configs/targets/xtensaeb-softmmu.mak     |  1 -
 accel/tcg/backend-ldst.h                 | 41 ++++++++++++
 accel/tcg/internal-target.h              | 35 ----------
 include/accel/accel-cpu-target.h         |  1 -
 include/accel/tcg/cpu-ops.h              | 16 +++++
 include/exec/poison.h                    |  2 -
 include/hw/core/cpu.h                    |  9 ---
 include/system/tcg.h                     |  8 +++
 target/alpha/cpu-param.h                 |  3 -
 target/arm/cpu-param.h                   |  3 -
 target/avr/cpu-param.h                   |  2 -
 target/hppa/cpu-param.h                  |  8 ---
 target/i386/cpu-param.h                  |  3 -
 target/i386/tcg/tcg-cpu.h                |  4 ++
 target/loongarch/cpu-param.h             |  2 -
 target/microblaze/cpu-param.h            |  3 -
 target/mips/cpu-param.h                  |  2 -
 target/openrisc/cpu-param.h              |  2 -
 target/ppc/cpu-param.h                   |  2 -
 target/riscv/cpu-param.h                 |  2 -
 target/riscv/tcg/tcg-cpu.h               |  2 +
 target/s390x/cpu-param.h                 |  6 --
 target/sparc/cpu-param.h                 | 23 -------
 target/xtensa/cpu-param.h                |  3 -
 accel/accel-target.c                     |  3 -
 accel/tcg/cputlb.c                       | 21 +++---
 accel/tcg/tcg-all.c                      | 84 ++++++++++++++----------
 accel/tcg/translate-all.c                |  6 +-
 accel/tcg/user-exec.c                    | 21 +++---
 target/alpha/cpu.c                       |  4 ++
 target/arm/cpu.c                         |  4 ++
 target/arm/tcg/cpu-v7m.c                 |  4 ++
 target/avr/cpu.c                         |  2 +
 target/hexagon/cpu.c                     |  5 ++
 target/hppa/cpu.c                        |  9 +++
 target/i386/cpu.c                        |  4 ++
 target/i386/tcg/tcg-cpu.c                | 20 ++----
 target/loongarch/cpu.c                   |  3 +
 target/m68k/cpu.c                        |  4 ++
 target/microblaze/cpu.c                  |  4 ++
 target/mips/cpu.c                        |  3 +
 target/openrisc/cpu.c                    |  3 +
 target/ppc/cpu_init.c                    |  2 +
 target/riscv/cpu.c                       |  3 +
 target/riscv/tcg/tcg-cpu.c               | 20 ++----
 target/rx/cpu.c                          |  4 ++
 target/s390x/cpu.c                       |  7 ++
 target/sh4/cpu.c                         |  4 ++
 target/sparc/cpu.c                       | 24 +++++++
 target/tricore/cpu.c                     |  3 +
 target/xtensa/cpu.c                      |  4 ++
 tcg/region.c                             |  4 +-
 72 files changed, 260 insertions(+), 227 deletions(-)
 create mode 100644 accel/tcg/backend-ldst.h

-- 
2.47.1


