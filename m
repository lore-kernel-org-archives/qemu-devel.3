Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C308DD7879C
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Dec 2025 16:20:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vWdCz-0005pn-Co; Fri, 19 Dec 2025 11:20:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vWdCy-0005pB-Al
 for qemu-devel@nongnu.org; Fri, 19 Dec 2025 11:20:00 -0500
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vWdCw-0005i4-6Z
 for qemu-devel@nongnu.org; Fri, 19 Dec 2025 11:19:59 -0500
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-47796a837c7so14700805e9.0
 for <qemu-devel@nongnu.org>; Fri, 19 Dec 2025 08:19:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1766161196; x=1766765996; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=V7ACHFvuX/8sW66cXL3ukkJ8Tx6VRQ3+OAZ8npieBSY=;
 b=w3ge7FAUSSGijxEtTuAojLdf6NcK7VMVwXbXbSv/163Irwn3qx/O2BQ3HQQSlwPjbO
 zJyFH3ANhuW6E1CjUOxXMEGwnPVVrRxKoI9Eg409vJhuUTRhhkP9XKrex6dXL8V0W8RO
 VH4bZYq6pjE6F7LKZVQa3LT3LFzqBWyYKb1Jqe5FTOl6F2PA6vboUc8hNqXWerSp+plA
 YbRASqhJbarwQaT/udqHawaDnuiJv8S1FFjseVpV86FGB6EhLrjbh3157nujcYCNLtA2
 rtwZ+TRIeLumMhYVutX6rvxwNKHrXwWkD1gIeivFMSeqFbLlpFopcPqArrY6Bbu+LX08
 3mZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766161196; x=1766765996;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=V7ACHFvuX/8sW66cXL3ukkJ8Tx6VRQ3+OAZ8npieBSY=;
 b=ojpI+DMfhVblFtnDcVEpWB/fPcn60CnvVuUUypJmIcSCXALcxVWPuuGiy1YzV+HJlc
 LHWHcOa0uEEFOp/R+GI42kJmPf1peieMyDYFIZpybysqeUt144W79vfKWwjQL7c9MM2J
 QajJB7niy93uEhkbIS0orNYSx+/7bmEpfeycOYf0gqh16EWX5EzRlAOvUyFNSBAwoV8B
 mOJmrnjAVa2JWcIIaUKYsClIFng8UHpRpgUdBQi/Lb5I3h9rcP7rUpSd6gYW3LC/bQlQ
 +DK0fZ3h53Gn645ipQe6SAAlcflEYzr3Epba+nXl+COsZyIQ/NrX/w/o7OfA8e/nQ/CB
 aRXw==
X-Gm-Message-State: AOJu0YwvGHFm9uzid0YXFEUxHpqRpi6V1p01rtGNZC+QL0k9y8jxlhJv
 JzBJEqt0WnZC+8XQcM3oho/tVy+o8zAAKOD1hb8qrgQ/Fp+THYhFwjWjZVmIO18NGqaFvgB1VOT
 kAwzS8wY=
X-Gm-Gg: AY/fxX7lJvoBzBGTak/EwzK0JJNF68UFtaNYbEOn6QIfvYxPnvs/hiT8ocBZJFZiWP1
 CwHuiPjWm7yLar+ILgfj7R2p7prZzIbFkVLqBsmqn13QNDa7SqxUVRKYpqgCo2hQXWnHmGes3lI
 alSOG7KY48q3Z+5gM7uE9GJ6GMk2La51c0GlTVJgDkAlYEjxE5XHth+hGp2KHyZgdRMPeByEQAH
 MKvoX8G0tyzs3wT39xrcDJQoqt0O8hWJPYigHjGKDP0ft+4SriI3+8Qm3IKWaRTF9tCVP6cGjBh
 YooeGJ6uV7WVXEH+N05fOTI9DNXTEFyMXv5/rIwTzBocjwjJCMkPLHwejwC5xDSSdjTKImZZuyv
 z0USaW3DPDDWHwuopqdhvE4gN3PSFr7AjwHEoyHs4KEn1+r1hA2Cw/i5w+GHjQvOij03GvGyWWK
 Ge8uM2My6O0AOArBBYaXYGyilfVC7ZMbhw6WQOEXIYC5Ml7uQLXXAEBbbmn8Xh
X-Google-Smtp-Source: AGHT+IGjVL3TpOhWAM6CXEmFiQjV6RSo9fRs0VulsaqD59GYoDa+FY5Ky06EQEMtYpJ2ZH/ISRpejg==
X-Received: by 2002:a05:600c:474d:b0:477:97ca:b727 with SMTP id
 5b1f17b1804b1-47d1957d7e6mr31391745e9.19.1766161196059; 
 Fri, 19 Dec 2025 08:19:56 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4324eab33f5sm5901519f8f.41.2025.12.19.08.19.54
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 19 Dec 2025 08:19:55 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Anton Johansson <anjo@rev.ng>, David Hildenbrand <david@kernel.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2 00/24] system/memory: Clean ups around address_space_ldst()
 endian variants
Date: Fri, 19 Dec 2025 17:19:27 +0100
Message-ID: <20251219161953.72724-1-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32f.google.com
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

(The motivation is the single-binary project).

This series is preliminary on unifying endianness for the
single binary. The goal is to have a clean API ready for
harder refactor.

First part, we remove the _notdirty() and leul_to_cpu() helpers,
then we prepare the subpage_ops[] MemoryRegionOps to handle
distinct endianness in the same binary, and finally we add
a pair of ldn()/stn() variants to directly infer the access
size and endianness from a MemOp argument.

Second part we let all targets set the
TARGET_USE_LEGACY_NATIVE_ENDIAN_API definition, then restrict
our headers to only expose legacy "native" endian declarations
when this definition exists.
This will allow us to gradually clean the repository,
eventually removing the legacy API.

Please review,

Phil.

Philippe Mathieu-Daudé (24):
  system/memory: Remove address_space_stl_notdirty and stl_phys_notdirty
  system/physmem: Inline and remove leul_to_cpu()
  system/physmem: Convert DEBUG_SUBPAGE printf() to trace events
  system/physmem: Use explicit endianness in subpage_ops::read/write()
  system/memory: Split MemoryRegionCache API to 'memory_cached.h'
  system/memory: Move *ldst* headers from exec/ to system/ namespace
  system/memory: Inline address_space_stq_internal()
  system/memory: Define address_space_ldst[W] endian variants via
    template
  system/memory: Define address_space_ldst[L] endian variants via
    template
  system/memory: Define address_space_ldst[Q] endian variants via
    template
  system/memory: Factor address_space_ldst[M]_internal() helper out
  system/memory: Pass device_endian argument as MemOp bit
  system/memory: Directly call address_space_ldst[M]_internal() helper
  system/memory: Introduce LD/ST helpers with @n suffix (variable size)
  system/memory: Use explicit endianness in ram_device::read/write()
  configs/targets: Introduce TARGET_USE_LEGACY_NATIVE_ENDIAN_API
  system/memory: Restrict legacy ld/st_phys() 'native-endian' API
  system/memory: Restrict legacy ld/st_he() 'native-endian' API
  system/memory: Restrict legacy address_space_ldst() 'native-endian'
    API
  system/memory: Restrict legacy cpu_ld/st() 'native-endian' API
  system/memory: Restrict legacy translator_ld() 'native-endian' API
  system/memory: Restrict legacy tswap() 'native-endian' API
  system/memory: Restrict legacy MO_TE 'native-endian' definitions
  system/memory: Restrict legacy DEVICE_NATIVE_ENDIAN definition

 MAINTAINERS                                   |   4 +
 docs/devel/loads-stores.rst                   |  10 +-
 configs/targets/aarch64-bsd-user.mak          |   1 +
 configs/targets/aarch64-linux-user.mak        |   1 +
 configs/targets/aarch64-softmmu.mak           |   1 +
 configs/targets/aarch64_be-linux-user.mak     |   1 +
 configs/targets/alpha-linux-user.mak          |   1 +
 configs/targets/alpha-softmmu.mak             |   1 +
 configs/targets/arm-bsd-user.mak              |   1 +
 configs/targets/arm-linux-user.mak            |   1 +
 configs/targets/arm-softmmu.mak               |   1 +
 configs/targets/armeb-linux-user.mak          |   1 +
 configs/targets/avr-softmmu.mak               |   1 +
 configs/targets/hexagon-linux-user.mak        |   1 +
 configs/targets/hppa-linux-user.mak           |   1 +
 configs/targets/hppa-softmmu.mak              |   1 +
 configs/targets/i386-bsd-user.mak             |   1 +
 configs/targets/i386-linux-user.mak           |   1 +
 configs/targets/i386-softmmu.mak              |   1 +
 configs/targets/loongarch64-linux-user.mak    |   1 +
 configs/targets/loongarch64-softmmu.mak       |   1 +
 configs/targets/m68k-linux-user.mak           |   1 +
 configs/targets/m68k-softmmu.mak              |   1 +
 configs/targets/microblaze-linux-user.mak     |   1 +
 configs/targets/microblaze-softmmu.mak        |   1 +
 configs/targets/microblazeel-linux-user.mak   |   1 +
 configs/targets/microblazeel-softmmu.mak      |   1 +
 configs/targets/mips-linux-user.mak           |   1 +
 configs/targets/mips-softmmu.mak              |   1 +
 configs/targets/mips64-linux-user.mak         |   1 +
 configs/targets/mips64-softmmu.mak            |   1 +
 configs/targets/mips64el-linux-user.mak       |   1 +
 configs/targets/mips64el-softmmu.mak          |   1 +
 configs/targets/mipsel-linux-user.mak         |   1 +
 configs/targets/mipsel-softmmu.mak            |   1 +
 configs/targets/mipsn32-linux-user.mak        |   1 +
 configs/targets/mipsn32el-linux-user.mak      |   1 +
 configs/targets/or1k-linux-user.mak           |   1 +
 configs/targets/or1k-softmmu.mak              |   1 +
 configs/targets/ppc-linux-user.mak            |   1 +
 configs/targets/ppc-softmmu.mak               |   1 +
 configs/targets/ppc64-linux-user.mak          |   1 +
 configs/targets/ppc64-softmmu.mak             |   1 +
 configs/targets/ppc64le-linux-user.mak        |   1 +
 configs/targets/riscv32-linux-user.mak        |   1 +
 configs/targets/riscv32-softmmu.mak           |   1 +
 configs/targets/riscv64-bsd-user.mak          |   1 +
 configs/targets/riscv64-linux-user.mak        |   1 +
 configs/targets/riscv64-softmmu.mak           |   1 +
 configs/targets/rx-softmmu.mak                |   1 +
 configs/targets/s390x-linux-user.mak          |   1 +
 configs/targets/s390x-softmmu.mak             |   1 +
 configs/targets/sh4-linux-user.mak            |   1 +
 configs/targets/sh4-softmmu.mak               |   1 +
 configs/targets/sh4eb-linux-user.mak          |   1 +
 configs/targets/sh4eb-softmmu.mak             |   1 +
 configs/targets/sparc-linux-user.mak          |   1 +
 configs/targets/sparc-softmmu.mak             |   1 +
 configs/targets/sparc32plus-linux-user.mak    |   1 +
 configs/targets/sparc64-linux-user.mak        |   1 +
 configs/targets/sparc64-softmmu.mak           |   1 +
 configs/targets/tricore-softmmu.mak           |   1 +
 configs/targets/x86_64-bsd-user.mak           |   1 +
 configs/targets/x86_64-linux-user.mak         |   1 +
 configs/targets/x86_64-softmmu.mak            |   1 +
 configs/targets/xtensa-linux-user.mak         |   1 +
 configs/targets/xtensa-softmmu.mak            |   1 +
 configs/targets/xtensaeb-linux-user.mak       |   1 +
 configs/targets/xtensaeb-softmmu.mak          |   1 +
 include/accel/tcg/cpu-ldst.h                  |   2 +
 include/exec/cpu-common.h                     |   2 +
 include/exec/memop.h                          |   4 +
 include/exec/translator.h                     |   2 +-
 include/exec/tswap.h                          |   2 +
 include/hw/virtio/virtio-access.h             |   1 +
 include/qemu/bswap.h                          |  16 +-
 include/system/memory.h                       | 195 +------
 include/system/memory_cached.h                | 209 ++++++++
 system/memory-internal.h                      |   2 +
 include/exec/memory_ldst.h.inc                |  67 ---
 include/exec/memory_ldst_phys.h.inc           | 144 ------
 include/system/memory_ldst.h.inc              |  41 ++
 .../{exec => system}/memory_ldst_cached.h.inc |   0
 include/system/memory_ldst_endian.h.inc       |  37 ++
 include/system/memory_ldst_phys.h.inc         |  47 ++
 include/system/memory_ldst_phys_endian.h.inc  |  57 ++
 system/memory.c                               |  68 ++-
 system/physmem.c                              | 111 ++--
 system/memory_ldst.c.inc                      | 488 ++----------------
 system/memory_ldst_endian.c.inc               |  84 +++
 scripts/make-config-poison.sh                 |   1 +
 system/trace-events                           |   6 +
 92 files changed, 744 insertions(+), 923 deletions(-)
 create mode 100644 include/system/memory_cached.h
 delete mode 100644 include/exec/memory_ldst.h.inc
 delete mode 100644 include/exec/memory_ldst_phys.h.inc
 create mode 100644 include/system/memory_ldst.h.inc
 rename include/{exec => system}/memory_ldst_cached.h.inc (100%)
 create mode 100644 include/system/memory_ldst_endian.h.inc
 create mode 100644 include/system/memory_ldst_phys.h.inc
 create mode 100644 include/system/memory_ldst_phys_endian.h.inc
 create mode 100644 system/memory_ldst_endian.c.inc

-- 
2.52.0


