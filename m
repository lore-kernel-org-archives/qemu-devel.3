Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7E39CCA470
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Oct 2025 15:08:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v3yPB-0000cy-AK; Wed, 01 Oct 2025 11:06:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v3yOy-0000aw-Tp
 for qemu-devel@nongnu.org; Wed, 01 Oct 2025 11:05:56 -0400
Received: from mail-wr1-x435.google.com ([2a00:1450:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v3yOk-0000cB-SM
 for qemu-devel@nongnu.org; Wed, 01 Oct 2025 11:05:55 -0400
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-3ee13baf2e1so5553170f8f.3
 for <qemu-devel@nongnu.org>; Wed, 01 Oct 2025 08:05:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1759331131; x=1759935931; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=bX1keC/9mpclBrFaOQD5CnQBdOGk2TIdIpvuGAEFtoQ=;
 b=k5Apk4xEkTwwA2nCV6pB7+qn/5PfgsI/a4KeiB/FBMHpv7aaP4gRyXPVGvMoKm73dc
 KzysThC6B7r6EIgBumVHhGqW2JjPwZbViAz/6kkiRLzXGU0rS0IRK4yCJCx8Quq+R/4q
 JGJlTbwZS5Hrvdjic641q1xXZfP/Bau0HwDa2CH7hFYGKo7DzhQAJPnwtwnOE50wa/2X
 Utjs9oF0LC1Q0H9wXyMAJ0KME3kKruDcEp+3BOAQCdkPBKuCJIaMAnbZ9RHreyGcFjDB
 DytSkNtj+cs6WBXib/fDvoDxhAh4GjHApsfk/6vKc2jOu2BaXj0vjGZ7DAkraA6yh2FK
 4H1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759331131; x=1759935931;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=bX1keC/9mpclBrFaOQD5CnQBdOGk2TIdIpvuGAEFtoQ=;
 b=T1B3ghGh2+32iepjZxDr2+hp3OVQGG0SkSpBobqoHy4kB5rqG2odBz4Vy3j0rdpZfl
 7jyeeoPiqDam1+JOBzupLJfjAzPhntCpWD8KnaXhYh3UFgXQ7sjmLYTzxT5NImGGxPBO
 pDHoQYeB9shJP0crVXR3nxLOkWVC9r0G/bG+xb3WlXBVZ7vcUdftEA2r+pQl3Aohu16t
 ZHa9kiy5CV5H2w7k0+aQ3FC7bd3GBGBCjrRyY9xdUFIybChTSKbfOFHiA1AA2y4+MCnL
 KZwCOxsRNJ6fh2if8iQO+BhKDgklB23yem7go/+7IpTUUdwQeAiaimoKDmBBXAXYJHJ5
 fwIQ==
X-Gm-Message-State: AOJu0YzX2xtnas3AbhNz5MwcRznBy60mZtFhTIV7khPU+EPO4Ju2PIXb
 yPN1AUKAD6sL6y5VUcHgONmNfYwXtkomxcV2t/oIl/30TlrukFiZp8IesSbBAwEnPak2Y0rWDP2
 hBwMNgsXNDg==
X-Gm-Gg: ASbGncs7WF6u6e30l8nHhGCIzENIO1zMyW3y+h7cVXvodUl81J8EWtHYPLHxfC8nzP3
 eRZvUH2deH8wRbkp+z7gtcNBw4h313FQR3Atpls7984CnlbLaeHpG46tuCYyYBxzDQQrnUVLkMb
 p4kUBNm2Cai3ZdaScVdlMbLFpo4bfG7gXq36cGxeBeslXAqR9tGs7bYu38Dl2JBQsH+BRYgNwFu
 c4XD+7T0KQsgIsogtsAgeO1VfbjwwRxmBxAnQ2sKdLZJUhtBULZJpZ74Ycv2vz/CeRSTGMhlOQd
 O/VeuyOcXWS5MWmYrKRkukCl6ydSO8vqxVioSxJYGmEquMjUxrzrRigaFN9QDTlZkq/J56ExjPK
 8QIXB+Ro2+j8QRqP1KfhcZseAdxY8bHjbGvCcCWWFQMVmKE94tvcTyu91vIT+pJyp/+9dyQg9U7
 Unoh5qwfgoQNWTDfIBaVXS8/EpwXlhnNE=
X-Google-Smtp-Source: AGHT+IE5bhum517hVkgU+gzfCFhPtdaNIrGi0XfxSJacAGZiwEMZLs8k8e8gb1GkqoMBBwDEaDIpdA==
X-Received: by 2002:a05:6000:200d:b0:400:1bbb:d279 with SMTP id
 ffacd0b85a97d-4255780b23dmr2887842f8f.39.1759331131328; 
 Wed, 01 Oct 2025 08:05:31 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-40fb89fb2fcsm29386920f8f.22.2025.10.01.08.05.30
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 01 Oct 2025 08:05:30 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, qemu-s390x@nongnu.org,
 Richard Henderson <richard.henderson@linaro.org>, qemu-riscv@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>, qemu-ppc@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Peter Xu <peterx@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 00/22] hw/core/cpu: Remove @CPUState::as field
Date: Wed,  1 Oct 2025 17:05:05 +0200
Message-ID: <20251001150529.14122-1-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::435;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x435.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=unavailable autolearn_force=no
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

Instead of using the convenient @CPUState::as shortcut, use
cpu_get_address_space(asidx=0) to get the vCPU first address
space.

The goal is to reduce the risk of AS mis-use for targets
that uses multiple ASes per vCPU.

Based-on: <20251001082127.65741-1-philmd@linaro.org>

Philippe Mathieu-Daudé (22):
  system/qtest: Use &address_space_memory for first vCPU address space
  disas/disas-mon: Get cpu first addr space with cpu_get_address_space()
  monitor/hmp-cmds: Get cpu first addr space with
    cpu_get_address_space()
  hw/core/loader: Get cpu first addr space with cpu_get_address_space()
  hw/ppc: Get cpu first addr space with cpu_get_address_space()
  hw/m86k: Get cpu first addr space with cpu_get_address_space()
  target/xtensa: Get cpu first addr space with cpu_get_address_space()
  target/riscv: Get cpu first addr space with cpu_get_address_space()
  semihosting: Get cpu first addr space with cpu_get_address_space()
  target/alpha: Get cpu first addr space with cpu_get_address_space()
  target/arm: Get cpu first addr space with cpu_get_address_space()
  target/hppa: Get cpu first addr space with cpu_get_address_space()
  target/i386: Get cpu first addr space with cpu_get_address_space()
  target/loongarch: Get cpu first addr space with
    cpu_get_address_space()
  target/m68k: Get cpu first addr space with cpu_get_address_space()
  target/microblaze: Get cpu first addr space with
    cpu_get_address_space()
  target/ppc: Get cpu first addr space with cpu_get_address_space()
  target/s390x: Get cpu first addr space with cpu_get_address_space()
  target/sparc: Get cpu first addr space with cpu_get_address_space()
  hw/core/cpu: Remove @CPUState::as field
  exec/cpu: Declare cpu_memory_rw_debug() in 'hw/core/cpu.h' and
    document
  target/sparc: Reduce inclusions of 'exec/cpu-common.h'

 include/exec/cpu-common.h         |  4 ---
 include/hw/core/cpu.h             | 23 +++++++++++--
 target/ppc/mmu-hash32.h           | 12 ++++---
 target/sparc/cpu.h                |  1 -
 disas/disas-mon.c                 |  3 +-
 hw/core/cpu-common.c              |  1 -
 hw/core/generic-loader.c          |  5 +--
 hw/intc/spapr_xive.c              |  5 +--
 hw/m68k/mcf5208.c                 |  6 ++--
 hw/m68k/q800.c                    | 17 ++++++----
 hw/m68k/virt.c                    |  5 +--
 hw/ppc/pegasos2.c                 |  2 +-
 hw/ppc/spapr.c                    | 12 +++----
 hw/ppc/spapr_hcall.c              | 55 ++++++++++++++++---------------
 hw/ppc/spapr_iommu.c              |  4 +--
 hw/ppc/spapr_nested.c             | 43 +++++++++++++-----------
 monitor/hmp-cmds-target.c         |  3 +-
 semihosting/arm-compat-semi.c     |  4 ++-
 system/cpus.c                     |  2 +-
 system/physmem.c                  | 10 ------
 system/qtest.c                    | 27 +++++++--------
 target/alpha/helper.c             |  8 +++--
 target/arm/cpu.c                  |  7 ++--
 target/hppa/int_helper.c          |  3 +-
 target/i386/arch_memory_mapping.c | 10 +++---
 target/loongarch/cpu_helper.c     |  5 +--
 target/loongarch/tcg/tlb_helper.c |  7 ++--
 target/m68k/helper.c              | 28 ++++++++--------
 target/microblaze/op_helper.c     |  6 ++--
 target/ppc/excp_helper.c          |  4 +--
 target/ppc/mmu-book3s-v3.c        |  5 +--
 target/ppc/mmu-hash32.c           |  6 ++--
 target/ppc/mmu-hash64.c           | 12 ++++---
 target/ppc/mmu-radix64.c          | 13 ++++----
 target/riscv/cpu_helper.c         |  7 ++--
 target/s390x/cpu-system.c         |  4 ++-
 target/s390x/mmu_helper.c         |  9 ++---
 target/s390x/tcg/excp_helper.c    | 10 +++---
 target/s390x/tcg/mem_helper.c     |  6 ++--
 target/sparc/helper.c             |  1 +
 target/sparc/int64_helper.c       |  1 +
 target/sparc/ldst_helper.c        | 22 +++++++------
 target/sparc/mmu_helper.c         | 21 +++++++-----
 target/xtensa/mmu_helper.c        |  3 +-
 44 files changed, 253 insertions(+), 189 deletions(-)

-- 
2.51.0


