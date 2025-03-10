Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A04E2C282DE
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Mar 2025 05:03:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1trVE7-0002dt-Q3; Mon, 10 Mar 2025 00:58:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1trVE5-0002ce-OA
 for qemu-devel@nongnu.org; Mon, 10 Mar 2025 00:58:53 -0400
Received: from mail-pl1-x635.google.com ([2607:f8b0:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1trVE3-000894-Ta
 for qemu-devel@nongnu.org; Mon, 10 Mar 2025 00:58:53 -0400
Received: by mail-pl1-x635.google.com with SMTP id
 d9443c01a7336-223594b3c6dso65469375ad.2
 for <qemu-devel@nongnu.org>; Sun, 09 Mar 2025 21:58:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741582730; x=1742187530; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=CyMnY8DCOyhH4sll8UBWjGQBOdpS4N2V2sRcD5CyECM=;
 b=hfLiPxvyqxmTjLmZ3nHbM5hovdVZpMl8UjjeM9FOXEt19EmPihv0lDDEUNXHbaz+A2
 grqQ439HrcAOhn+hbFe8/8kAgY6IEegpzXEqbP+qowOj7j92KbsgpqeNp80JrzHrWNt6
 agXIGxUsEmhL+VhlqgWKC/JjNNo7Q3g0KcH+K9zBCqTdsE+2iFQBi4UPJFsPI8tFVN7W
 UQVPyAFxA+dxkYjlRwW99bsNZant7KFzGDvkxkQN4CrMJwZzazXCfz9M2Hw9zy/vJwX8
 TxCYLJr3iRvzcrioUCmNv0pUuWlUth5YkejF2bofZPs4SBBaug3zm/HJnwHapxPuo/v+
 1OeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741582730; x=1742187530;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=CyMnY8DCOyhH4sll8UBWjGQBOdpS4N2V2sRcD5CyECM=;
 b=TePJt39Tknia7slZkZsyCmMY6J0ZLv8NSxOB9zOZUQa7BM3+ZOzLYuIqnRAy0wMpSO
 QkypdM0W3PCqOMqxZRpB2QpBsSVTNY2tPvvJe9RDa+kB18/6uIn2nia1W6CIo6OLfMVn
 CwH5m0tL53zUtIvI+AqWnnE1fu2hXz1MYxO0/NWw+ZwlkmbNR6bpBCIhjXsfBly9k50R
 x/0kyOoq5t9GJoINJttOY0bmsvNAOoLLHDkwGdlEG6R6OfukzgMP5wKHxcMK2QUyIlwO
 GRx5j4Eh3OUf0LOQHAqSzTJrjncFDl+TTCaUEP5ia0jErRqkCaow+s6BeiTUOuiPj4iW
 Om8A==
X-Gm-Message-State: AOJu0YwszJeg/pbzHBGytBPJblAI4V1YeK3TZvD1+N2Zdh/DHEMMImBf
 l0p9ZQxscAEYVsDnkfM5boHQNdiXKgWD9OEOrlacaHZzOaXQQMSgr9TAYhuxNl2Xed6MQnP4ood
 Rpcc=
X-Gm-Gg: ASbGncuA1telyNQzRbxNlaQNCXX/zTGOAmgeJWANfGbW5O3dh2/cW2ss5CzhSoy/Zsp
 Kw3PjjhIc3bsFzMaKscDgcndUflGXX20+4cWCBR+1lF1Y15V437TkdL+Ravjv4wE3tKUI071Lkm
 09c2VtgwtiufqlF3hcoMEi8EdLJL0oupaNmsbYTgEArRPi3wzh2sDSmqRzL4EHCkSlASjaZJrel
 sEGl3g95dUsN1bRdwj7kFHQ3NVUwUg5alaa59XaaC7LMMyodJMm9BddKTp+OgCUAdGSs+kZfhlR
 n0dszxHhj9YlLst76by0r88LObESqRpGMYImaIAfMYul30K+t2nKcJk=
X-Google-Smtp-Source: AGHT+IFBRE9vcuWy/8QGIVJH+CegCd8ZXFRntWgx7wfqbQL9hdyzkh8MEMl2t2vqfLHGN0wEW9B3Eg==
X-Received: by 2002:a05:6a00:b4e:b0:736:57cb:f2b6 with SMTP id
 d2e1a72fcca58-736aaa1acf0mr17943212b3a.12.1741582729877; 
 Sun, 09 Mar 2025 21:58:49 -0700 (PDT)
Received: from pc.. ([38.39.164.180]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-736d2ae318csm1708308b3a.53.2025.03.09.21.58.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 09 Mar 2025 21:58:49 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, Alistair Francis <alistair.francis@wdc.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>, alex.bennee@linaro.org,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>, kvm@vger.kernel.org,
 Peter Xu <peterx@redhat.com>, Nicholas Piggin <npiggin@gmail.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 David Hildenbrand <david@redhat.com>, Weiwei Li <liwei1518@gmail.com>,
 Paul Durrant <paul@xen.org>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Anthony PERARD <anthony@xenproject.org>,
 Yoshinori Sato <ysato@users.sourceforge.jp>,
 manos.pitsidianakis@linaro.org, qemu-riscv@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>, xen-devel@lists.xenproject.org,
 Stefano Stabellini <sstabellini@kernel.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH 00/16] make system memory API available for common code
Date: Sun,  9 Mar 2025 21:58:26 -0700
Message-Id: <20250310045842.2650784-1-pierrick.bouvier@linaro.org>
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

The first 6 patches remove dependency of memory API to cpu headers and remove
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

Pierrick Bouvier (16):
  exec/memory_ldst: extract memory_ldst declarations from cpu-all.h
  exec/memory_ldst_phys: extract memory_ldst_phys declarations from
    cpu-all.h
  include: move target_words_bigendian() from tswap to bswap
  exec/memory.h: make devend_memop target agnostic
  qemu/bswap: implement {ld,st}.*_p as functions
  exec/cpu-all.h: we can now remove ld/st macros
  codebase: prepare to remove cpu.h from exec/exec-all.h
  exec/exec-all: remove dependency on cpu.h
  exec/memory-internal: remove dependency on cpu.h
  exec/ram_addr: remove dependency on cpu.h
  system/kvm: make kvm_flush_coalesced_mmio_buffer() accessible for
    common code
  exec/ram_addr: call xen_hvm_modified_memory only if xen is enabled
  hw/xen: add stubs for various functions
  system/physmem: compilation unit is now common to all targets
  system/memory: make compilation unit common
  system/ioport: make compilation unit common

 include/exec/cpu-all.h              | 52 ------------------
 include/exec/exec-all.h             |  1 -
 include/exec/memory-internal.h      |  2 -
 include/exec/memory.h               | 48 ++++++++++++++---
 include/exec/ram_addr.h             | 11 ++--
 include/exec/tswap.h                | 11 ----
 include/qemu/bswap.h                | 82 +++++++++++++++++++++++++++++
 include/system/kvm.h                |  6 +--
 include/tcg/tcg-op.h                |  1 +
 target/ppc/helper_regs.h            |  2 +
 include/exec/memory_ldst.h.inc      | 13 ++---
 include/exec/memory_ldst_phys.h.inc |  5 +-
 hw/ppc/spapr_nested.c               |  1 +
 hw/sh4/sh7750.c                     |  1 +
 hw/xen/xen_stubs.c                  | 56 ++++++++++++++++++++
 page-vary-target.c                  |  3 +-
 system/ioport.c                     |  1 -
 system/memory.c                     | 22 +++++---
 target/riscv/bitmanip_helper.c      |  1 +
 hw/xen/meson.build                  |  3 ++
 system/meson.build                  |  6 +--
 21 files changed, 225 insertions(+), 103 deletions(-)
 create mode 100644 hw/xen/xen_stubs.c

-- 
2.39.5


