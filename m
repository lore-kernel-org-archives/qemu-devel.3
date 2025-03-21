Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B0F9C36005
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Mar 2025 18:36:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tvhCx-0007g3-Jf; Fri, 21 Mar 2025 14:35:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tvhCs-0007f2-FV
 for qemu-devel@nongnu.org; Fri, 21 Mar 2025 14:34:58 -0400
Received: from mail-wr1-x42e.google.com ([2a00:1450:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tvhCp-0006QQ-0C
 for qemu-devel@nongnu.org; Fri, 21 Mar 2025 14:34:57 -0400
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-3995ff6b066so1460070f8f.3
 for <qemu-devel@nongnu.org>; Fri, 21 Mar 2025 11:34:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1742582093; x=1743186893; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=VCImrLeTQF54hZJTWiziXGlUhQoLGJyQXloUBsF+fQA=;
 b=EQqm8OcHTJR2J9UXqcwVJ2dnKF4oaAU/MO6JKcrtOPIgN4hRQgnNnlD7EKT8ftdTwX
 N/p/OIxLBosS4Sjmf+u6yIH8fmiIMQ4nFTSyp+OnuKChPSY1VTqW+ALMBErXrfw8FAYk
 iaA4h8lo2uPamLOnGhKDF9nmcFMLHanr4U9uKKz8e8qwyZebcRHApSbv3Svkgs81s5K5
 j2zO1D28ReTsSjC1xNUc6eyKAlrANpn79TOD8BF6x26tJvfHc64uD44M7v5QNL508QOW
 OTpzaAEci8eYIAkGkncu0R7uMrXX6LZF2FmkyEY9g1N+dFzoM4xQq3iMpFsIQoSJgsf3
 VLjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742582093; x=1743186893;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=VCImrLeTQF54hZJTWiziXGlUhQoLGJyQXloUBsF+fQA=;
 b=cjfwj8lrsBfP6pEPIokVuWwzfoZ0ETAg3/BVMHbq3RxqkexyJ/JiLzNWHFfuJImoXo
 OTKdjUWGsyqS9iV7f1EftKMil/lQJ3l+ffGZjmnIWIU3HyLTASxzrvR5KJkZVf8R6Ib7
 PFUUnzcjL4J9ecbq9lvV6VcwwH0ms5y1eSEFkDWkWvOvD/IAvqQZaKuEId9/qCapkBDT
 hAWufsedJZPFpQYsD5VFoP06xl+J+awzSXfy5L8o0DPvknUHo8Blc7ur0aTX4QNIIY1x
 0lK+iecFRGZPp/elJ+F8IhTNFVk3TXLagm+ak2p6Vo+0GsHUNapHkMvMyO2zc95E4olM
 0Uew==
X-Forwarded-Encrypted: i=1;
 AJvYcCWo9FX/TNnXu2s0yAeN3GsM6TV1PGw93nM6Qk/Ka6BxFRtmdAQklGZW4uh9hNIFGjTIIJyu98SfLeQa@nongnu.org
X-Gm-Message-State: AOJu0YwfZv14Xxqo+QI4MXeNC3KzZCWhUR5yLf32Fu+e1siOu98ymsUF
 y5t9KRjYc8W2TLy3YwSonlYwoUziqKb5mY/qVYzbKCOcG74EZQdzhOqtVuC4A1I=
X-Gm-Gg: ASbGnctsMZu712UwGiSR1SiFi5pf6QqIwF7LOGYF+QXVyI5Ek2pzSHzESzDqf9TJjEq
 2TC1TjHdKwG13o34o/YQGwO0MsS02b6Mk5W4paImzBdL0ZOJU8+LWG+hZ4FZXkhuqKKEb2B1NMe
 bB2j5oS2BkNo2WF74mNNF6AWCwlXHRgl4AZw2WzJmUBx9ubiO4/aGW7pIHSeF9IlMU17ZHWHlfw
 xa+IldU03cicTo4gnlEBgCQ/iFcP32nt2RWbOQ5cGAUA1VjwZp3E6M1W3SPMvJqI0dVyM0Sw+gO
 riTrfLSs0ycUdOYSrZxmd8C+cmPNf3m8Tta94WzDTJMiYet342I+RfWYh8kk0Oz7oV4ucYz8X2W
 +o3v+cjJO66Ql/cgZjUdhOaoLkvjZ8A==
X-Google-Smtp-Source: AGHT+IEZykZqPxi1Q0RIRT6rKk4eqWRjwBRVLNUn3C2nPhL+D00bJtRz/+n5B3WJFmU5dScO/kAMXw==
X-Received: by 2002:a05:6000:1acb:b0:391:4095:49b7 with SMTP id
 ffacd0b85a97d-3997f91d52amr5110887f8f.25.1742582092770; 
 Fri, 21 Mar 2025 11:34:52 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43d43f55750sm86617165e9.21.2025.03.21.11.34.50
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 21 Mar 2025 11:34:51 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: Richard Henderson <richard.henderson@linaro.org>,
	qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Anton Johansson <anjo@rev.ng>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH-for-10.1 v2 0/4] tcg: Convert TARGET_SUPPORTS_MTTCG to
 TCGCPUOps::mttcg_supported field
Date: Fri, 21 Mar 2025 19:34:45 +0100
Message-ID: <20250321183450.3970-1-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42e;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42e.google.com
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

Since v1:
- Update TCGState::mttcg_enabled (Anton)
- Better describe change in patch 3 (Pierrick)

In this series we replace the TARGET_SUPPORTS_MTTCG (Makefile)
definition by a 'mttcg_supported' field in TCGCPUOps.

Based-on: <20250321181549.3331-1-philmd@linaro.org>

Philippe Mathieu-Daudé (4):
  target/riscv: Restrict RV128 MTTCG check on system emulation
  tcg: Move qemu_tcg_mttcg_enabled() to 'system/tcg.h'
  tcg: Convert TCGState::mttcg_enabled to TriState
  tcg: Convert TARGET_SUPPORTS_MTTCG to TCGCPUOps::mttcg_supported field

 docs/devel/multi-thread-tcg.rst          |  2 +-
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
 include/accel/tcg/cpu-ops.h              |  8 +++
 include/exec/poison.h                    |  1 -
 include/hw/core/cpu.h                    |  9 ----
 include/system/tcg.h                     |  8 +++
 accel/tcg/tcg-all.c                      | 69 +++++++++++++-----------
 target/alpha/cpu.c                       |  1 +
 target/arm/cpu.c                         |  1 +
 target/arm/tcg/cpu-v7m.c                 |  1 +
 target/avr/cpu.c                         |  1 +
 target/hexagon/cpu.c                     |  1 +
 target/hppa/cpu.c                        |  1 +
 target/i386/tcg/tcg-cpu.c                |  1 +
 target/loongarch/cpu.c                   |  1 +
 target/m68k/cpu.c                        |  1 +
 target/microblaze/cpu.c                  |  1 +
 target/mips/cpu.c                        |  1 +
 target/openrisc/cpu.c                    |  1 +
 target/ppc/cpu_init.c                    |  1 +
 target/riscv/tcg/tcg-cpu.c               |  4 +-
 target/rx/cpu.c                          |  1 +
 target/s390x/cpu.c                       |  1 +
 target/sh4/cpu.c                         |  1 +
 target/sparc/cpu.c                       |  1 +
 target/tricore/cpu.c                     |  1 +
 target/xtensa/cpu.c                      |  1 +
 tcg/region.c                             |  4 +-
 47 files changed, 79 insertions(+), 65 deletions(-)

-- 
2.47.1


