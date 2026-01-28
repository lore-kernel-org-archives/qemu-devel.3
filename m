Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8D2FD25B4C
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Jan 2026 12:14:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vl4Nb-000497-Jg; Wed, 28 Jan 2026 07:10:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chao.liu.zevorn@gmail.com>)
 id 1vl4N6-00043u-E2
 for qemu-devel@nongnu.org; Wed, 28 Jan 2026 07:10:10 -0500
Received: from mail-pf1-x443.google.com ([2607:f8b0:4864:20::443])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <chao.liu.zevorn@gmail.com>)
 id 1vl4Mx-000846-Df
 for qemu-devel@nongnu.org; Wed, 28 Jan 2026 07:10:01 -0500
Received: by mail-pf1-x443.google.com with SMTP id
 d2e1a72fcca58-8230c2d3128so3016405b3a.0
 for <qemu-devel@nongnu.org>; Wed, 28 Jan 2026 04:09:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1769602197; x=1770206997; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=XheKvpqmEdBu2/HaqYD+xRnaouuRf9AbJUOdyoQGXRM=;
 b=P5cF2LZtdW0L6J1b2hW28VwSb65UwlF1NuuNCFsq/PRB6ae4MeICfhAulywBw3M8T9
 +KsJAiuVqCHY2oAgHz9DDUTcDHxcpKSO4b6PeoJ81mQWHHiv2eOSBI1SAW73N42O2RHS
 QN0civGpu9Z3G8VoV9haGQVs+19quwSHKF87R5qyDwa762GUU8GxulfCi7WphaqbWmPf
 UbPaAxMQBxyKyZZL9ER4jTQ/id8iYZFMd4G5K5+3l0aqj+CPvSz/LoqIHXzf/QT3YNQe
 S6kP6OG3hqX5QCcFdPuAO8B2/vr8XdM5hdXxukz6eTtCnPBYRkDfa/S0k26WSeox/fnw
 swyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769602197; x=1770206997;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XheKvpqmEdBu2/HaqYD+xRnaouuRf9AbJUOdyoQGXRM=;
 b=S1d1lVpqdv8gLR9j6jJOkk9kEzPQ8PjcZWgvAWTUE0bzo1w69hmOeXxjwWJJYc3wtb
 eefS8VXaRNHRut2FgY2bdJ0gXty3crar80luG/HFm3eFvmXeku5+BILALiltMUvDC8+1
 ekf56xjsTc8M1gpXqux0ej3gbp/jXAGl+GkkqWccDMKk4vjR5rZUVD/QhbH6zXn89v/0
 hhqaKif9Y880wnPETMWg6LSvJsKLAv5S72ewF8VES00rIigOAjwT728YCz29zQ53klbP
 ATYYfOFyciXweP3cbbnNZVfhcs4W20ces81pgCve+dw8n+iXnk56OgyVZkB/wJolcogK
 PkOw==
X-Gm-Message-State: AOJu0Yx/sxM2sQSwdqdQy89T9IEKzWAr4ON1ucSI8TPi/ZmdxlwJxnOT
 rhd1kNLtDnLCq2GL9/Jwwb3j0opK3aDg6nTPz1sV6h1Q2m0RSGygeYvW
X-Gm-Gg: AZuq6aJE+VKHbROu1iLKV/tUa+siVWT84TX73xnfYY3xmOwYZCfm3gHLjQM4dzFelVe
 BA0Zanu7NCqv64IWio9+6xqyyPthO4JjUBGbX1fThV8n8UFHUiFvznib12pv5YHQ4e3+14jroTL
 bu45LijP++UINEnS7ldo5QIu0AdD12Fj7SXPeqHsEpYL5oLkMvgVl8K0WADmPnWZVGjMLao57Wa
 IV+rHmzkYrVbd2rGrib2tqRaE9wM7dBLSN3KOfQggVLC0NJ/QwfK3rwmXC93H/mCsclO2gjxo4C
 QzDhgeELo2OUkKRG7VcjC8sRJVpHM/e2ouEYaKzzIQm0to9E3ORY08fSL2jZpcHg5TXH83dAiU5
 Ce9E/72j7dtIo+YrjM3JLok8vQwk88gqilFNwUfsz6xf+3pBX/ThpNyqt7DkEHWbVQ0O2Dhenql
 ilg0O/ACkn3g9Q1TFnz1uhqpbdxN0BG/hRUaezdWKAWrBmGCDlmkP526cAFGqDS0pERqahog==
X-Received: by 2002:a05:6a00:a0e:b0:823:f96:63bb with SMTP id
 d2e1a72fcca58-823692e6785mr5198207b3a.52.1769602196912; 
 Wed, 28 Jan 2026 04:09:56 -0800 (PST)
Received: from ZEVORN-PC.bbrouter ([183.195.22.224])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-82379c24083sm2503153b3a.55.2026.01.28.04.09.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 Jan 2026 04:09:56 -0800 (PST)
From: Chao Liu <chao.liu.zevorn@gmail.com>
To: Alistair Francis <alistair.francis@wdc.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, Weiwei Li <liwei1518@gmail.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, Fabiano Rosas <farosas@suse.de>,
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Tao Tang <tangtao1634@phytium.com.cn>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org,
 hust-os-kernel-patches@googlegroups.com,
 Chao Liu <chao.liu.zevorn@gmail.com>
Subject: [RFC PATCH v1 0/2] tests/qtest: Add RISC-V IOMMU bare-metal test
 using iommu-testdev
Date: Wed, 28 Jan 2026 20:09:07 +0800
Message-ID: <cover.1769600111.git.chao.liu.zevorn@gmail.com>
X-Mailer: git-send-email 2.52.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::443;
 envelope-from=chao.liu.zevorn@gmail.com; helo=mail-pf1-x443.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Hi,

This patch series adds a bare-metal qtest for the RISC-V IOMMU using the
iommu-testdev framework. The test exercises address translation paths
without requiring a full guest OS boot.

Motivation
----------

The existing RISC-V IOMMU qtest (riscv-iommu-test.c) focuses on PCI device
enumeration and register-level validation:
- PCI configuration space verification (vendor/device ID)
- Register reset value checks
- Queue initialization procedures (CQ/FQ/PQ)

However, it does not test the actual address translation functionality.
This new test fills that gap by using iommu-testdev to trigger DMA
transactions and validate the IOMMU's translation logic.

Comparison with Existing Test
-----------------------------

| Feature               | riscv-iommu-test.c | iommu-riscv-test.c (new) |
|-----------------------|--------------------|--------------------------|
| PCI config            | Yes                | No                       |
| Register reset        | Yes                | No                       |
| Queue init            | Yes                | Yes (via helper)         |
| Bare translation      | No                 | Yes                      |
| S-stage (SV39)        | No                 | Yes                      |
| G-stage (SV39x4)      | No                 | Yes                      |
| Nested translation    | No                 | Yes                      |
| DMA verification      | No                 | Yes                      |
| Uses iommu-testdev    | No                 | Yes                      |

The new test provides:
- Device context (DC) configuration and validation
- SV39 page table walks for S-stage translation
- SV39x4 page table walks for G-stage translation
- Nested translation combining both stages
- FCTL register constraint validation
- End-to-end DMA verification

Note: The current implementation only supports SV39/SV39x4. Support for
SV48/SV48x4/SV57/SV57x4 can be added in future patches.

Testing
-------

QTEST_QEMU_BINARY=./build/qemu-system-riscv64 \
  ./build/tests/qtest/iommu-riscv-test --tap -k

Question for Maintainers
------------------------

The existing riscv-iommu-test.c and the new iommu-riscv-test.c serve
complementary purposes. Would it be beneficial to merge these two tests
into a single source file for easier maintenance? This would consolidate
all RISC-V IOMMU testing in one place while preserving both the
register-level and translation-level test coverage.

Thanks,
Chao

Chao Liu (2):
  tests/qtest/libqos: Add RISC-V IOMMU helper library
  tests/qtest: Add RISC-V IOMMU bare-metal test

 MAINTAINERS                          |   2 +
 tests/qtest/iommu-riscv-test.c       | 279 +++++++++++++++++++
 tests/qtest/libqos/meson.build       |   2 +-
 tests/qtest/libqos/qos-riscv-iommu.c | 400 +++++++++++++++++++++++++++
 tests/qtest/libqos/qos-riscv-iommu.h | 172 ++++++++++++
 tests/qtest/meson.build              |   5 +-
 6 files changed, 858 insertions(+), 2 deletions(-)
 create mode 100644 tests/qtest/iommu-riscv-test.c
 create mode 100644 tests/qtest/libqos/qos-riscv-iommu.c
 create mode 100644 tests/qtest/libqos/qos-riscv-iommu.h

--
2.52.0


