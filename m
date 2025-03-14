Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D710C35FF1
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Mar 2025 17:38:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tt8tP-0005io-CQ; Fri, 14 Mar 2025 13:32:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tt8sy-0005TH-Tl
 for qemu-devel@nongnu.org; Fri, 14 Mar 2025 13:31:54 -0400
Received: from mail-pl1-x630.google.com ([2607:f8b0:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tt8st-0008CT-56
 for qemu-devel@nongnu.org; Fri, 14 Mar 2025 13:31:52 -0400
Received: by mail-pl1-x630.google.com with SMTP id
 d9443c01a7336-223959039f4so52137995ad.3
 for <qemu-devel@nongnu.org>; Fri, 14 Mar 2025 10:31:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741973505; x=1742578305; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=mbx4XaRe0fsea/1JxsaLA7ueH0t1s6VZZ5QhNdIFgD0=;
 b=N8NxHi+NkzUr4mMPM4Zf3372GtSSwqMHiRRcLAO/kbj7XZNLZ27fCkNDXCrUJJHV4I
 0NmQRtIIkYWnMRiNCq4a7MPxrU8CUnnkWlild7Llr4X+Vvw63tEIjGos3AlZ7sxS6JhD
 nNo0S7kr53wknrWwmr9HxSt1U/KiPWQtuNsroyrZZxWP7zDYHJHg85AWxf9+QEJP0/Df
 64NJbiNJiUVADKsQ4icZ3REBUmP+qB0EiCxAVJ/ziXvM/JBy8ZQRoCKmL7S6BXBxJNiI
 bTmHf4HPsPYSPzfcHPWnPLivmWm9QrpmBXjf7tKoBh5FuYw81xa8cpZCDxR4LFTnsZbf
 q8jQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741973505; x=1742578305;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=mbx4XaRe0fsea/1JxsaLA7ueH0t1s6VZZ5QhNdIFgD0=;
 b=OxKoZaUxFThecC/Gxqk3bYTIcDta9LVN+eFCZUBjju4b7fODBTjlQoBJ40SaYvaHzm
 pwvrXWwx1qQjNtU0ENh+WvNoDwBxmkxHlmHmH79Gg6Js7qGZPL+S17wmbakiTl5H/YPP
 N+djLNM/vUhoTnAlxoKurG+FZmuF2KjgOA/mEJ07ay7tUH3yrC+Mk5o3ctgJpt8mS0h0
 eTGPoRdlFYMnRzpOBKSaYiLPAwNVD+mfXByvff5H4jebFrE56Lul2sztTITUnYg6dUxE
 Pvuwcil4xjDT4OMOVMvEAccKTLK8gdsSCqlPBe2cVve+TDdE4QLL6yYZHaJ7J436aaoj
 PeQg==
X-Gm-Message-State: AOJu0YymjOUX7hGtRdbIqEOEy0sFQqDS9d283X13wz1UMxEXxSQqDbwB
 cEPy0ycoaJGp8WYKjxGaMv/qIJ3fyMunMg5qrt9zycJ8c8xQQlsqLYP9OXaMN9YNiHqmZ8S+5ol
 vDlA=
X-Gm-Gg: ASbGnctUzNtfP3X27qSLHwr561yEn4AZiFUl1n16J4NHLQVAAOrYKGf+iot12Y4wb/5
 dnRQJ7ubtj/uf2onx6Rz27mTQI+s0Lgv32jE7gIiVvzslBbRYvW966PSqTPwlVTc6qjicAhrTju
 w7pmpTlAyBUWBoHaq5/dY6GjTDE+o3S8ng2PK97XOat0DEEnJw3nki9INTqdP6gLJ1XohI8GClg
 0P20Hk7CDziB4oqHWUwvVCsTf7KfCTXflvH/dUJNLm8o/6lFpEDJ7uw45XkZ2HMx6lXXF2FVWxT
 jfWVSsA9/W1nPZBRDfl2CldlVgk7VtCym8+tz1+GFlDt
X-Google-Smtp-Source: AGHT+IG45qOt2dgsJDV7nujhL0kdPo+5GKsExuYeufblXdBnsz6vqmVVLVscbpfExXfMyu2MvPKFvA==
X-Received: by 2002:a05:6a00:a1f:b0:732:5164:3cc with SMTP id
 d2e1a72fcca58-737223e7399mr3832223b3a.19.1741973504748; 
 Fri, 14 Mar 2025 10:31:44 -0700 (PDT)
Received: from pc.. ([38.39.164.180]) by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-af56e9cd03bsm2990529a12.8.2025.03.14.10.31.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 14 Mar 2025 10:31:44 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, Yoshinori Sato <ysato@users.sourceforge.jp>,
 Paul Durrant <paul@xen.org>, Peter Xu <peterx@redhat.com>,
 alex.bennee@linaro.org, Harsh Prateek Bora <harshpb@linux.ibm.com>,
 David Hildenbrand <david@redhat.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Nicholas Piggin <npiggin@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>, qemu-riscv@nongnu.org,
 manos.pitsidianakis@linaro.org, Palmer Dabbelt <palmer@dabbelt.com>,
 Anthony PERARD <anthony@xenproject.org>, kvm@vger.kernel.org,
 xen-devel@lists.xenproject.org,
 Stefano Stabellini <sstabellini@kernel.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Weiwei Li <liwei1518@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v5 00/17] make system memory API available for common code
Date: Fri, 14 Mar 2025 10:31:22 -0700
Message-Id: <20250314173139.2122904-1-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.39.5
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::630;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x630.google.com
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

v3:
- move devend functions to memory_internal.h
- completed description for commits removing cpu.h dependency

v4:
- rebase on top of master
  * missing include in 'codebase: prepare to remove cpu.h from exec/exec-all.h'
  * meson build conflict

v5:
- remove extra xen stub xen_invalidate_map_cache()
- edit xen stubs commit message

Pierrick Bouvier (17):
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
  include/exec/memory: move devend functions to memory-internal.h
  system/memory: make compilation unit common
  system/ioport: make compilation unit common

 include/exec/cpu-all.h              | 66 -----------------------
 include/exec/exec-all.h             |  1 -
 include/exec/memory-internal.h      | 21 +++++++-
 include/exec/memory.h               | 30 ++++-------
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
 hw/xen/xen_stubs.c                  | 51 ++++++++++++++++++
 page-vary-target.c                  |  2 +-
 system/ioport.c                     |  1 -
 system/memory.c                     | 17 ++----
 target/ppc/tcg-excp_helper.c        |  1 +
 target/riscv/bitmanip_helper.c      |  2 +-
 hw/xen/meson.build                  |  3 ++
 system/meson.build                  |  6 +--
 22 files changed, 188 insertions(+), 126 deletions(-)
 create mode 100644 hw/xen/xen_stubs.c

-- 
2.39.5


