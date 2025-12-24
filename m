Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7AF89E77361
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Dec 2025 15:23:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vYQhD-0000X4-9T; Wed, 24 Dec 2025 10:22:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vYQgr-0000WO-Nj
 for qemu-devel@nongnu.org; Wed, 24 Dec 2025 10:22:24 -0500
Received: from mail-ej1-x643.google.com ([2a00:1450:4864:20::643])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vYQgp-0004WZ-B9
 for qemu-devel@nongnu.org; Wed, 24 Dec 2025 10:22:17 -0500
Received: by mail-ej1-x643.google.com with SMTP id
 a640c23a62f3a-b7355f6ef12so1140854266b.3
 for <qemu-devel@nongnu.org>; Wed, 24 Dec 2025 07:22:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1766589733; x=1767194533; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=YEJPLbPQNi2y5azifXlQaNiuaq+WMAxGeRbxn3Sx/FU=;
 b=nUl7nwFJ9HoP+b6ugi1eg6ChKf7ZEk5sQ7QzQhn/3A0pjj+6xb3xblbLCN2Gj55RwJ
 xbtNxk1PYXyEMXN7zkac5cp8mIAjkSSBOd8rWBoQZgb8qJI2fI2kf5oGoMjfB4x58Jw+
 LURwxQSfWWt8i1ePaAiTUlFr0XSgAYt+wuyI3l/gyhR1AMrjB25EdGlwb07gmTHCa93+
 Rj86ql3bhZxnmm+R4T1J5wshaCDgJeySGirwfvAj0ps19GTpCsoA9rFB+IDL7YoD1tvJ
 LdEM0ra0BbftX1dA10qaiq1FcpgNlsk0eUhKA2cSH/0taanw8rfHjChXT6YzseWAyoXj
 C+OQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766589733; x=1767194533;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YEJPLbPQNi2y5azifXlQaNiuaq+WMAxGeRbxn3Sx/FU=;
 b=i/jBPItDOiJB/hAXc1BX8M8/02xAv8cn+yo15/MQz5LflpB6H2MuN+uT/1nxCmAmNF
 AkHMYwMS6L7qDYy5ms6OqSB9YgnskBLyi5M1XZborlyTh1DBCh0lTuwT+zGUIajo88KP
 IPaB9Ac4uTq4de3zNR9thz1sQYWCbUmOrHJQnkDVDevh1r9R3DOQrwmBNGwAp5NHEQbm
 uUS3FjGp3CWwkCPuwZ8RLHrk4GUKkZTKbNjL91eFVyVL8Y9yyEL8Fib9RT/wgWrOuN/l
 aECiEkD0IVi6hR7AN25YapdczDrCbwr1EINprHnuBccI9b4A44n+Qxpn7e2gVY4a/XYW
 Z6rA==
X-Gm-Message-State: AOJu0Yx4GVsBEia+Dz+p9qi+QVf0NyDtPO2WBun3JxQQKYGNSc0xCd0Q
 JlillT8lxdAmkLHixi1/kJYUb1PBDmxzcUC3NePao4DFprXaMZEqTqst59O7/RHBjbBVMOZGKbk
 bv7qIhWo=
X-Gm-Gg: AY/fxX49GZNpvRqs0L91ZTI+vUq+RzSrrrbkBWuLZ3OgPeCQOV8rfOJXzOwUmo9Hoe0
 Q39ZWDDmhMq/ztshfaLDKjvr9FQVFste5wEfECXx3cZlUvZJhDOXKhctEnFhJO3IYLKpAF7oEZ9
 nRiohleKBIYMg13D7GIHAa9lBfpfML+99yZRcg5b73TqM8+TD6Gqy7/dL4dkNcg+ZldfMsyG23w
 6PtEjBr4/TEGF0ddWAu70M0ddYLkpX8cbKGame/wmAligV5wu+m4NC88zJ7b2fSj02DENlEt52V
 o5m38DMmMg9MpiWjX24+zQglh0V0j++eUccPITFygdG0r6RuurzBKiN50jE4cuYve/kqVu6S8Z5
 4zzS5XWBZynNSs/tTPKDdveYe6NfaJKAPO7TsMfUytrSTcgSXtBo6/7zEp/S+q6z30Q9fjb/lnz
 e24jBXo6zeekiGZ0eb0lewyIxBgwBLwWTv62t6jcsu0Y3pRNFdFReylmPZe5TH
X-Google-Smtp-Source: AGHT+IFufpbcq5X2Tg/JDQt+6hHbW40mOzV8fiWZz2hZfy8ozKmYje75dAS7rE2CSI4rlzUL3O0IVg==
X-Received: by 2002:a17:907:2d94:b0:b73:7a44:b4d5 with SMTP id
 a640c23a62f3a-b8037051a07mr1836523166b.41.1766589732816; 
 Wed, 24 Dec 2025 07:22:12 -0800 (PST)
Received: from localhost.localdomain (188.171.88.92.rev.sfr.net.
 [92.88.171.188]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b8037a6050dsm1812448966b.9.2025.12.24.07.22.11
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 24 Dec 2025 07:22:12 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Peter Xu <peterx@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Anton Johansson <anjo@rev.ng>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v3 00/25] system/memory: Clean ups around address_space_ldst()
 endian variants
Date: Wed, 24 Dec 2025 16:21:43 +0100
Message-ID: <20251224152210.87880-1-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::643;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x643.google.com
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

Since v2:
- Changed opt-out to opt-in approach (Pierrick)
- Split big patches in smaller ones
- Mark ioport little-endian

tag: https://gitlab.com/philmd/qemu/-/tags/sysmem_ldst_endian-v3
CI: https://gitlab.com/philmd/qemu/-/pipelines/2231223066

Philippe Mathieu-Daudé (25):
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
  system: Allow restricting the legacy ld/st_phys() 'native-endian' API
  system: Allow restricting the legacy ld/st_he() 'native-endian' API
  system: Allow restricting legacy address_space_ldst() native-endian
    API
  system: Allow restricting the legacy cpu_ld/st() 'native-endian' API
  system: Allow restricting the legacy translator_ld() 'native-endian'
    API
  system: Allow restricting the legacy tswap() 'native-endian' API
  system: Allow restricting the legacy MO_TE* 'native-endian'
    definitions
  system: Allow restricting the legacy DEVICE_NATIVE_ENDIAN definition
  tests/qtest: Remove unnecessary 'qemu/bswap.h' include
  system/ioport: Declare x86-specific I/O port in little-endian order
  system/ioport: Do not open-code address_space_ld/st_le() methods

 MAINTAINERS                                   |   4 +
 docs/devel/loads-stores.rst                   |  10 +-
 include/accel/tcg/cpu-ldst.h                  |   2 +
 include/exec/cpu-common.h                     |   2 +
 include/exec/memop.h                          |   4 +
 include/exec/translator.h                     |   5 +-
 include/exec/tswap.h                          |   3 +
 include/hw/virtio/virtio-access.h             |   1 +
 include/qemu/bswap.h                          |  16 +-
 include/system/memory.h                       | 189 +-------
 include/system/memory_cached.h                | 209 ++++++++
 system/memory-internal.h                      |   2 +
 tests/qtest/pnv-xive2-common.h                |   1 -
 include/exec/memory_ldst.h.inc                |  65 ---
 include/exec/memory_ldst_phys.h.inc           | 144 ------
 include/system/memory_ldst.h.inc              |  41 ++
 .../{exec => system}/memory_ldst_cached.h.inc |   0
 include/system/memory_ldst_endian.h.inc       |  37 ++
 include/system/memory_ldst_phys.h.inc         |  47 ++
 include/system/memory_ldst_phys_endian.h.inc  |  57 +++
 system/ioport.c                               |  34 +-
 system/memory.c                               |  68 ++-
 system/physmem.c                              | 111 +++--
 tests/qtest/aspeed_smc-test.c                 |   1 -
 tests/qtest/ast2700-smc-test.c                |   1 -
 tests/qtest/endianness-test.c                 |  10 +-
 tests/qtest/libqos/fw_cfg.c                   |   1 -
 tests/qtest/libqos/i2c-omap.c                 |   1 -
 tests/qtest/libqtest.c                        |  13 +-
 tests/qtest/pnv-spi-seeprom-test.c            |   1 -
 tests/qtest/vmcoreinfo-test.c                 |   1 -
 system/memory_ldst.c.inc                      | 449 ++----------------
 system/memory_ldst_endian.c.inc               |  84 ++++
 scripts/make-config-poison.sh                 |   1 +
 system/trace-events                           |   6 +
 35 files changed, 708 insertions(+), 913 deletions(-)
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


