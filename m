Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56B36CD484C
	for <qemu-devel@archiver.kernel.org>; Mon, 11 May 2026 16:32:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wMTXH-0005g8-Pn; Mon, 11 May 2026 12:31:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chao.liu.zevorn@gmail.com>)
 id 1wMTWb-0005aZ-PC
 for qemu-devel@nongnu.org; Mon, 11 May 2026 12:30:42 -0400
Received: from mail-qk1-x744.google.com ([2607:f8b0:4864:20::744])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <chao.liu.zevorn@gmail.com>)
 id 1wMTWG-0004qA-BX
 for qemu-devel@nongnu.org; Mon, 11 May 2026 12:30:25 -0400
Received: by mail-qk1-x744.google.com with SMTP id
 af79cd13be357-8ef5776530bso436008585a.0
 for <qemu-devel@nongnu.org>; Mon, 11 May 2026 09:30:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1778517010; x=1779121810; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=v+l6m64guwW7i1IDHHhqgD3tRb3768l8XXq+f2EbxbU=;
 b=EwZfEpGWpj0hFdwmDVRxz+CsNxn0+bX7p4XCbtjbJbST6TjnBw7QXrO437/MiPDIwY
 V/KGyBQIkGQhkOvqsbunZEAjaiv0+xj7Me7EkWLOJhqKhYzc1RfQvl4FS4fsIcoeGOBc
 bqmNalXoBAkrIO0p1RFqg4+FGGohNbb7CmzKSEVqkm4pZkNtRuphBTVt5+KF4fh5iS29
 h1wsFNt40dOHgT5xARaVn1fipKI90NxtxUf8dSVkXG08sbKHCBZJYCmy9caXSF/jpYq5
 U6Wu7z6IfDiGTtUp0MaV1rNq9IAsYI0Kzqaop8PqQ+aN0Ixb7vd6+wQ04BHxqe5frI9K
 dkrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778517010; x=1779121810;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=v+l6m64guwW7i1IDHHhqgD3tRb3768l8XXq+f2EbxbU=;
 b=MmMGWkL1DL/2sIYReE19sLFE06PwhvCzO0arDjRYi5j6tdeB0U6vbbpf0V7hrKbJJh
 k1YBjklNxv+dFDE5wuqHWsJMFxZIEYLyrjchRhsmbqGn/2j3yzgP0qQPKhPl9cpOU5Xf
 TySovx0ablTlbt6ATTopvNMYf1x10kpETjNBkHkOMAR3zUxFMXgjnhURg2McRwVQTj0y
 UIPLyLcLvx4ilS6iOL4Xh2o3ApVnCM/QKBs8CKqqPWGkGtR3g32+Ojo5iehhsHLplyTG
 vp05mnVk/y1km9UrB9Jk3BMRWzMqenPQDOaSRcU1HxLFJJ6iRijEBrEvkwS4RBp2uFDk
 1fgw==
X-Gm-Message-State: AOJu0YzqUbBpJrokgqbDAg/qQkUFmGLLgAu0fh2/F1xYGDBDSbWEtP97
 IGYCy6+bdCX3a4i72M+dBFBM52C6ijCClw5z6WD71HHRzJVfFUCiIWyO
X-Gm-Gg: Acq92OHWXPS113o1vt0m1Fc5dJUm122ooJdW29/HzxelD3QTWrY/aYBdmAdYrPhk0Ro
 1qjFWc5btTtuqRsfstdOpX5loCPlVdEzIQgAFeqYjf9FttupdjcLJxIjuD/GuKTZD0uH7d9zF/D
 ClZyzJN1ffzDuAv4DgdZYDxzPcwfsyO8l/iaboyrBMDplo7hAtYP4Fe2rgFXgJucEO2W9XhnHal
 BZ/ws8Ps/tAOyzHgDGLOzR94sji/AH26/jtcuM3T765PgVY3SWV3cyBoBgqnXUwXZxOKidWUUTv
 PBn5b002XTbCWB3/jlVVWqG/VVsMTDuIh1QHl8MeYdHRs7YRZia2TN9CgvhrElNnXZksLNFUBf3
 3ARjmhoZG0/d3QkvuWOPjOgl21tilr/wWGeTu9tyDfL9BVH8vMaZwW7WGYI44T3M8ayAEq1TU2/
 /zGPMLshInluYrQPGsGq4HFC8IuWZZsAlAzBWPH8AHCqmbyPthHDpUtrM9dgUdvwdt9xPN4naXB
 IqSOqs=
X-Received: by 2002:a05:620a:4891:b0:8ef:1157:6a05 with SMTP id
 af79cd13be357-9090e6e24ffmr1607105385a.19.1778517009547; 
 Mon, 11 May 2026 09:30:09 -0700 (PDT)
Received: from ZEVORN-PC.bbrouter ([162.244.208.119])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-907b9c542cdsm1097160785a.0.2026.05.11.09.30.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 11 May 2026 09:30:09 -0700 (PDT)
From: Chao Liu <chao.liu.zevorn@gmail.com>
To: Chao Liu <chao.liu.zevorn@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Christoph Muellner <christoph.muellner@vrull.eu>,
 Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>
Cc: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Subject: [PATCH v7 0/5] Add support for K230 board
Date: Tue, 12 May 2026 00:29:44 +0800
Message-ID: <cover.1778516731.git.chao.liu.zevorn@gmail.com>
X-Mailer: git-send-email 2.54.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::744;
 envelope-from=chao.liu.zevorn@gmail.com; helo=mail-qk1-x744.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 T_SPF_HELO_TEMPERROR=0.01 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

This patch series adds support for U-Boot + OpenSBI + standard Linux kernel on
K230 board. Thanks to Peng Jiang, Mig Yang, Renzao Ren, Yao Zi for their help.

The current patchset fixes some bug and tag errors, Thanks to Alistair and
Conor for the review.

Test command with the direct Linux boot:

```
$QEMU -M k230 \
      -kernel [Image] \
      -dtb [k230-qemu.dtb] \
      -initrd [rootfs.cpio.gz] \
      -nographic
```

The k230-boot-assets repo [1] provides K230 Linux kernel images built with
k230-sdk and Yocto.

For more information, see docs/system/riscv/k230.rst.

The GitLab CI result [2] passed all cases.

PATCH v7 changelog:
- Patchset: Removed invalid tags for patchset.
- Patchset: Updated the K230 datasheet link in the patchset comment header.
- Patch 2: Removed the unnecessary changes to MAINTAINERS.
- Patch 2: Fixed an Oops caused by accesses to an unimpl UART MMIO address.
- Patch 2: Adjusted the K230 machine hart count to 1.
- Patch 2: Supported direct boot linux with `-kernel`.
- Patch 3: Aligned the WDT interrupt number with the K230 datasheet.
- Patch 5: Updated k230.rst Linux boot docs.

PATCH v6 changelog:
- Patchset: Rebased on the latest Alistair's riscv-to-apply.next branch [3].
- Patch 4: Picked up Fabiano's Acked-by.

PATCH v5 changelog:
- Patchset: Rebased on Alistair's riscv-to-apply.next branch.
- Patch 2: Fixed reset vector ROM jump to trap-handler bug.

PATCH v4 changelog:
- Patchset: Rebased on the latest master branch.
- Patchset: No functional changes from v3.

PATCH v3 changelog:
- Patch 1: Align T-Head C908 CPU's RISC-V extension with XUANTIE-QEMU.
- Patch 2: Adjust PLIC and CLINT addresses to match K230 datasheet.

PATCH v2 changelog:
- Patch 1: Add Svpbmt extension support for the T-Head C908 CPU.
- Patch 2: Move the k230.rst definition from MAINTAINERS to Patch 5.
- Patch 5: Apply Daniel's bugfix to build the k230 documentation successfully.

PATCH v1 changelog:
- Patch 1: Add T-Head C908 and C908v CPU support.
- Patch 2: Add K230 board initial support(big core is not supported yet).
- Patch 3: Add Programmable Watchdog Timer (WDT) peripheral support.
- Patch 4: Add QEMU test for K230 watchdog.
- Patch 5: Add documentation for K230 machine.

---

Link:
[1] https://github.com/zevorn/k230-boot-assets
[2] https://gitlab.com/chao23.liu/qemu/-/pipelines/2515556858
[3] https://github.com/alistair23/qemu/tree/riscv-to-apply.next

Thanks,
Chao

Chao Liu (5):
  target/riscv: add thead-c908 cpu support
  hw/riscv: add k230 board initial support
  hw/watchdog: add k230 watchdog initial support
  tests/qtest: add test for K230 watchdog
  docs/system/riscv: add documentation for k230 machine

 MAINTAINERS                    |  11 +
 docs/system/riscv/k230.rst     | 113 +++++++
 docs/system/target-riscv.rst   |   1 +
 hw/riscv/Kconfig               |  11 +
 hw/riscv/k230.c                | 524 +++++++++++++++++++++++++++++++++
 hw/riscv/meson.build           |   2 +-
 hw/watchdog/Kconfig            |   4 +
 hw/watchdog/k230_wdt.c         | 296 +++++++++++++++++++
 hw/watchdog/meson.build        |   1 +
 hw/watchdog/trace-events       |   9 +
 include/hw/riscv/k230.h        | 149 ++++++++++
 include/hw/watchdog/k230_wdt.h | 121 ++++++++
 target/riscv/cpu-qom.h         |   2 +
 target/riscv/cpu.c             |  51 ++++
 target/riscv/th_csr.c          | 380 +++++++++++++++++++++++-
 tests/qtest/k230-wdt-test.c    | 189 ++++++++++++
 tests/qtest/meson.build        |   3 +-
 17 files changed, 1864 insertions(+), 3 deletions(-)
 create mode 100644 docs/system/riscv/k230.rst
 create mode 100644 hw/riscv/k230.c
 create mode 100644 hw/watchdog/k230_wdt.c
 create mode 100644 include/hw/riscv/k230.h
 create mode 100644 include/hw/watchdog/k230_wdt.h
 create mode 100644 tests/qtest/k230-wdt-test.c


