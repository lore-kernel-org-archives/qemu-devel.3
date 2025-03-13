Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F626C282DE
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Mar 2025 16:42:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tslaa-0003In-3H; Thu, 13 Mar 2025 12:39:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tslaV-0003HG-PN
 for qemu-devel@nongnu.org; Thu, 13 Mar 2025 12:39:16 -0400
Received: from mail-pj1-x1029.google.com ([2607:f8b0:4864:20::1029])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tslaT-0005aQ-AS
 for qemu-devel@nongnu.org; Thu, 13 Mar 2025 12:39:15 -0400
Received: by mail-pj1-x1029.google.com with SMTP id
 98e67ed59e1d1-2ff6ae7667dso2578253a91.0
 for <qemu-devel@nongnu.org>; Thu, 13 Mar 2025 09:39:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741883952; x=1742488752; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=ffKtZZCij4vskrAA+3NvWrKzzZscOxv69bTHCnUkApM=;
 b=KHOdIaeHePwgbUznE6sWMNKnFfAHqiUL7v4Vqnvzi5Xlx2a2uHJRaAJ+7dMl2CFg6C
 kK44uHQHwmgaFUDgeBqwJuL7EjrFiVXpAvrFpV0hBfH+tjRdB7H00xfcVk8lizvYW4jG
 HQHljyYzS4MZK1oPLv3/Vk33m/iB2bV19OBfkn9IYNLauyqLCImgZquMsle+KXk9qMxu
 CfZ4Z8xKZMEy0ns61+B4BDfAP+FlVwuUnJyGk3o/OaTFpqjp+WTAKwocfPgUCacWD7G0
 KubRjcUukK/lJYLA2Ha30UPTaK3NSYX/ZsWMShhsOwp1paD7njN72WviMYd7+e8Z1aoZ
 mZ/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741883952; x=1742488752;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ffKtZZCij4vskrAA+3NvWrKzzZscOxv69bTHCnUkApM=;
 b=higk+Nwdu9NFvncNPqrReQz4RDWi1PYLzq4dpQb06HE3QmIYUd5zcSd0eldrTV50um
 qy5mOxllnbxAIo2itJvHAB3MIUgI6pXhcatXGksRwqI2aoCqIoNs36yklw85I/zEEkxk
 LoCd67emjET6CGwAaEtMT+eZS8QkDfVInRT2OAudh/op861c8D+F+F9gLQxNrzIIuyVB
 Mlxb0fFMj3nhSy+clzrKm+4hMdqRQYhx0egxBqnnBZHRR2e72266EsVUPWn8Q9H2GQVb
 mYm+c4ZLLevOxPa6qjosMvtLYZ2lKhS1kfc5vOQ90Hqc3puclQDxwhOV4Go5PREFGAeP
 /7iA==
X-Gm-Message-State: AOJu0YwD+Te7+Ne4sNFMVE7GJgOvp+troJOynK+V5eYc3CNGsY7kD3Cd
 +cxN0maOWRZw0KiL7pfRNPZp3hug9dzaQ+4pyRmQ+mq93dL3TFamSPYKV6kr0mWEJDxXI+eGHU+
 xcD4=
X-Gm-Gg: ASbGnctrWbAMLar1+9wTYj0H18NMJ9XPBJDhtpwlXcELTs1V6nm0SAsiYDMdjAOcXsR
 Y8Q1A9zgi85CJxlJh4O7HRZ0RQ6wx2K2g2FrzZYKAtZhZWFkqDL4cJQqJDeeuiPA0MCJe2P2RH2
 ALrVG4o84E8TupBWs1KZTy7YEOSqrLHuOcPUn+eB78R0iOvA2cRp7fB3zDC8efGF+IAjSEP8spN
 AcHNa6D9zdQWxpBwJrx1GXlS2rvGHfNp2kPl+zd2/6fk0snJNKsPqgOYDzv1wHBOqccy/hxmRS/
 zCk4f3y6+alKIhJ7BzizfUqHOiq7LXq81vnRCGBs1XX/tKTpW5ejo5M=
X-Google-Smtp-Source: AGHT+IHILZBC4XG/VXTDGPE0LXvE+Aqy8ch+S3jq5UEPqUMQPlTTQn84Hgx+UBUoAEZm2kMt8qUx5g==
X-Received: by 2002:a17:90a:e7c1:b0:2fa:137f:5c61 with SMTP id
 98e67ed59e1d1-3014e843678mr320923a91.12.1741883951572; 
 Thu, 13 Mar 2025 09:39:11 -0700 (PDT)
Received: from pc.. ([38.39.164.180]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-30119265938sm4020084a91.39.2025.03.13.09.39.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 13 Mar 2025 09:39:11 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: Paul Durrant <paul@xen.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 xen-devel@lists.xenproject.org, Peter Xu <peterx@redhat.com>,
 alex.bennee@linaro.org, manos.pitsidianakis@linaro.org,
 Stefano Stabellini <sstabellini@kernel.org>,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-ppc@nongnu.org,
 Richard Henderson <richard.henderson@linaro.org>, kvm@vger.kernel.org,
 David Hildenbrand <david@redhat.com>, Palmer Dabbelt <palmer@dabbelt.com>,
 Weiwei Li <liwei1518@gmail.com>, qemu-riscv@nongnu.org,
 Alistair Francis <alistair.francis@wdc.com>,
 Anthony PERARD <anthony@xenproject.org>,
 Yoshinori Sato <ysato@users.sourceforge.jp>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Nicholas Piggin <npiggin@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v4 00/17] make system memory API available for common code
Date: Thu, 13 Mar 2025 09:38:46 -0700
Message-Id: <20250313163903.1738581-1-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.39.5
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1029;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pj1-x1029.google.com
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
 hw/xen/xen_stubs.c                  | 56 ++++++++++++++++++++
 page-vary-target.c                  |  2 +-
 system/ioport.c                     |  1 -
 system/memory.c                     | 17 ++----
 target/ppc/tcg-excp_helper.c        |  1 +
 target/riscv/bitmanip_helper.c      |  2 +-
 hw/xen/meson.build                  |  3 ++
 system/meson.build                  |  6 +--
 22 files changed, 193 insertions(+), 126 deletions(-)
 create mode 100644 hw/xen/xen_stubs.c

-- 
2.39.5


