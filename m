Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03959C28B2E
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Mar 2025 04:11:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1trqvW-0003Lw-V1; Tue, 11 Mar 2025 00:09:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1trqvO-0003Hg-KV
 for qemu-devel@nongnu.org; Tue, 11 Mar 2025 00:09:03 -0400
Received: from mail-pl1-x635.google.com ([2607:f8b0:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1trqvL-0006NN-1Q
 for qemu-devel@nongnu.org; Tue, 11 Mar 2025 00:09:01 -0400
Received: by mail-pl1-x635.google.com with SMTP id
 d9443c01a7336-2232aead377so157615ad.0
 for <qemu-devel@nongnu.org>; Mon, 10 Mar 2025 21:08:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741666137; x=1742270937; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=fGerXdOtIw0WsOiLQfJLVuAEuZhGly95KD3uNgEzFEA=;
 b=PRAhzH2oipMQUyNKCrI46IzNWLTrbiHnkTkxm+kogJiAQcHOw8YvJSopIjOfyZTRwd
 QPwvuGVM6EWiIVpn1Kuu8WOSHmuaHyLF5HIBKGiu42N8KO1bsM3rdqdvdDJhdKROz5bi
 PmekD3I10z+QKA5kq8kiaWfk4RBj36KbGAOFEmYgqgpYt4ZjhjHqlw2ViLM84/HSgqUa
 9zAJfNdFhpoU/8tDLdnAkt2pfiAnFGsNvn3y2IEp1XKAWyjqrhsfh5llmic6QniGDXas
 OJwKFzcR4vDM3P4wb0oQXTPMqLkruQgsabkdeOfU9SgbsyEKpgsZ3vrFAvO6s7kDZWMU
 rZxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741666137; x=1742270937;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=fGerXdOtIw0WsOiLQfJLVuAEuZhGly95KD3uNgEzFEA=;
 b=PzULBq7MMmejhJ2wHz1zlpuUIn8ic8T69v91GimtnujeBP/VpKHdwD8aVYYnsj71yO
 WsR3KU5UDJ7ZjHRBYW8SL3bdQA++GOrGxXp6oKZErqWQLUTDyk4+pk+/eNipiTrGuS1j
 VWTD2SIivhj+tbXF/LSZClQIZHGI5lh2dJTc2doO4GyI6uzoyX4TNFywvVm2/vebTKs5
 M0PBEELpN7s2n8bLV6BNJeAbnrkXw23Pb6kkLCAyownfSUizjQnpTsY3mX4ZXKoSt1lR
 DVys73EnTnE4j5II5/m1I61V7CtssfsqXvxNB2kinVXVdg2zXjbCRl/E3QouaQQmdRQa
 ufcQ==
X-Gm-Message-State: AOJu0YyHj+qpJQA934zigdNND//HkEy9Iq2JRyNoW2Ugwhf8o1K4+fJu
 7gZa6wDW+GOjeDytbaZi2TN5WzB3iNok1jdYn4uf6lKm678LSd/STxH7JPsgiqZtcMDmH8s97AZ
 ljOE=
X-Gm-Gg: ASbGncuZf7WONt2uEYmFZPqQ/HfR5J77KYhcsFmY32FpkTthmKv5GCQzyBuaxKKptGf
 szhc4YwTVv1Z//P+H7WtFwiHdRskqxID8YgRL4rK4oFo75Szm2vumnPEoq6UllpBYzNrdAQv/yM
 Mon48PEYWsISDcMrzIHjBlRVAiXrNLzaZ9+Hx4eIw0Tb/vPsQ+/n9QC4GgzptDn3Djq8WDUpy7b
 MZvDdRGQ1dTpDCCmLGN4wtXMKo1JRZpY0rNukhj29AwK1PDv7OktgCsWswmF2dmiCbMjsCAJpJv
 Vc0URokL0DfnTBkBWYhLpzalWS9sBmfLBjwPTz2thF+C
X-Google-Smtp-Source: AGHT+IGXMO59GO84wcQfdotD1ICTUfqb/mJe9bhBOPtOn//E28HwyLyMnn+hwaJcsHLDf6vigaP+aw==
X-Received: by 2002:a05:6a21:730e:b0:1f5:64fd:68ea with SMTP id
 adf61e73a8af0-1f564fd6a98mr15013110637.4.1741666137431; 
 Mon, 10 Mar 2025 21:08:57 -0700 (PDT)
Received: from pc.. ([38.39.164.180]) by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-af28c0339cesm7324454a12.46.2025.03.10.21.08.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 10 Mar 2025 21:08:57 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: Paul Durrant <paul@xen.org>, Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 David Hildenbrand <david@redhat.com>, Weiwei Li <liwei1518@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 xen-devel@lists.xenproject.org, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Peter Xu <peterx@redhat.com>, Nicholas Piggin <npiggin@gmail.com>,
 kvm@vger.kernel.org, qemu-ppc@nongnu.org,
 Alistair Francis <alistair.francis@wdc.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Stefano Stabellini <sstabellini@kernel.org>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>, alex.bennee@linaro.org,
 qemu-riscv@nongnu.org, manos.pitsidianakis@linaro.org,
 Yoshinori Sato <ysato@users.sourceforge.jp>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Anthony PERARD <anthony@xenproject.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v2 00/16] make system memory API available for common code
Date: Mon, 10 Mar 2025 21:08:22 -0700
Message-Id: <20250311040838.3937136-1-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.39.5
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::635;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x635.google.com
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

The main goal of this series is to be able to call any memory ld/st function
from code that is *not* target dependent. As a positive side effect, we can
turn related system compilation units into common code.

The first 5 patches remove dependency of memory API to cpu headers and remove
dependency to target specific code. This could be a series on its own, but it's
great to be able to turn system memory compilation units into common code to
make sure it can't regress, and prove it achieves the desired result.

The next patches remove more dependencies on cpu headers (exec-all,
memory-internal, ram_addr).
Then, we add access to a needed function from kvm, some xen stubs, and we
finally can turn our compilation units into common code.

Every commit was tested to build correctly for all targets (on windows, linux,
macos), and the series was fully tested by running all tests we have (linux,
x86_64 host).

v2:
- reorder first commits (tswap change first, so memory cached functions can use it)
- move st/ld*_p functions to tswap instead of bswap
- add define for target_words_bigendian when COMPILING_PER_TARGET, equals to
  TARGET_BIG_ENDIAN (avoid overhead in target code)
- rewrite devend_memop
- remove useless exec-all.h in concerned patch
- extract devend_big_endian function to reuse in system/memory.c
- rewrite changes to system/memory.c

Pierrick Bouvier (16):
  exec/tswap: target code can use TARGET_BIG_ENDIAN instead of
    target_words_bigendian()
  exec/tswap: implement {ld,st}.*_p as functions instead of macros
  exec/memory_ldst: extract memory_ldst declarations from cpu-all.h
  exec/memory_ldst_phys: extract memory_ldst_phys declarations from
    cpu-all.h
  exec/memory.h: make devend_memop "target defines" agnostic
  codebase: prepare to remove cpu.h from exec/exec-all.h
  exec/exec-all: remove dependency on cpu.h
  exec/memory-internal: remove dependency on cpu.h
  exec/ram_addr: remove dependency on cpu.h
  system/kvm: make kvm_flush_coalesced_mmio_buffer() accessible for
    common code
  exec/ram_addr: call xen_hvm_modified_memory only if xen is enabled
  hw/xen: add stubs for various functions
  system/physmem: compilation unit is now common to all targets
  include/exec/memory: extract devend_big_endian from devend_memop
  system/memory: make compilation unit common
  system/ioport: make compilation unit common

 include/exec/cpu-all.h              | 66 -----------------------
 include/exec/exec-all.h             |  1 -
 include/exec/memory-internal.h      |  2 -
 include/exec/memory.h               | 34 +++++++-----
 include/exec/ram_addr.h             | 11 ++--
 include/exec/tswap.h                | 81 +++++++++++++++++++++++++++--
 include/system/kvm.h                |  6 +--
 include/tcg/tcg-op.h                |  1 +
 target/ppc/helper_regs.h            |  2 +
 include/exec/memory_ldst.h.inc      |  4 --
 include/exec/memory_ldst_phys.h.inc |  5 +-
 cpu-target.c                        |  1 +
 hw/ppc/spapr_nested.c               |  1 +
 hw/sh4/sh7750.c                     |  1 +
 hw/xen/xen_stubs.c                  | 56 ++++++++++++++++++++
 page-vary-target.c                  |  2 +-
 system/ioport.c                     |  1 -
 system/memory.c                     | 17 ++----
 target/riscv/bitmanip_helper.c      |  2 +-
 hw/xen/meson.build                  |  3 ++
 system/meson.build                  |  6 +--
 21 files changed, 184 insertions(+), 119 deletions(-)
 create mode 100644 hw/xen/xen_stubs.c

-- 
2.39.5


