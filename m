Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CED76C48BC4
	for <qemu-devel@archiver.kernel.org>; Sat, 17 Feb 2024 19:27:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rbQKL-0001iz-PI; Sat, 17 Feb 2024 14:26:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1rbQKI-0001iS-QM
 for qemu-devel@nongnu.org; Sat, 17 Feb 2024 14:26:19 -0500
Received: from mail-pl1-x62b.google.com ([2607:f8b0:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1rbQKH-0004Mh-6B
 for qemu-devel@nongnu.org; Sat, 17 Feb 2024 14:26:18 -0500
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-1dba6b9b060so11572565ad.1
 for <qemu-devel@nongnu.org>; Sat, 17 Feb 2024 11:26:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1708197974; x=1708802774; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=AK/24FGUB+ScKMfTMHjDwhW82/kkOGAu43XiMr4h06A=;
 b=Ay7xbQcBgzcOX5oHu2VjrgjjTW0SifZ4r2n9XKaEn2poOZoYcCeQjG8Z+1M8JQnmzh
 clgO36zRCWCNzUDYGh5D66YHSOq6kP4fYRZR6wAQqbPVTI/uz5tgLPgCxOHRze2nGGSL
 MIHva79hJnxSEqX4FmdnJJO5C+L1foTAv7UXYb7DsE7gb+0211fMDT3U5AVj5q+OrBCQ
 3RcUCkp5/T+kBA6aqhOy7E2iuDkIZV+RLaSqRK9vU3PhlrTUOgvGiDOWSNFIycRwmeEA
 GDE40Q2THcrjpq3zNQh2kE7aAFWR2ub+8yAeX66vDB8lIUz/4bZiHidhjbnv8/zc354R
 FFJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708197974; x=1708802774;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=AK/24FGUB+ScKMfTMHjDwhW82/kkOGAu43XiMr4h06A=;
 b=IsOJPs7F3+6RRb0rqHHH/QY31Zkoj96hJqKuIrvSygW6wnaEgu6UtwamneSkHGxIxd
 bSQdlovCXdUNKrN9XHSXxXT84gff9YaKh5rhZsaK/0M4IPmh77L/Sp1rkbO/2RYoHhy6
 rdR1KDCN6nnKtMEtUgjeYDzlgSWn2qVFrtso+oza4zOIfLalsCUB/CE4hh368pTmtdKt
 vxZToEgOkiIjvuH8H0YAyx3DspqX0WImtMuq/jkJI8qP1d8ju1RcXfMWPwRGt+2AdpE1
 7j3KKkwggAx4JdhQwTtOkfPF4oCSCfjL3gEEDRZ5qzAnwF7b9clc3jjYHyd1EXCwYppr
 ShwQ==
X-Gm-Message-State: AOJu0YzgOPAWLhP5BC2PbNcqu7gvdKUCPS4l/xCTqFTF3w/laudkw9jh
 IpTzfEslY0Al/a4pa+lbgDPHzIGUbUWqaJ30Vg6HTGEXql1jqd5bGLX9Eji8AaX/Z5b7yMz3L9b
 Z
X-Google-Smtp-Source: AGHT+IEs2BNjDAgr9BOp6RiezfPoKHEuerje7UL4SFX36MWazFQOrP55DzmGVSjNNvgdrGQaBkxHNg==
X-Received: by 2002:a17:903:2291:b0:1db:cb54:5e71 with SMTP id
 b17-20020a170903229100b001dbcb545e71mr2077297plh.31.1708197973981; 
 Sat, 17 Feb 2024 11:26:13 -0800 (PST)
Received: from grind.. ([177.94.15.159]) by smtp.gmail.com with ESMTPSA id
 p3-20020a170902c70300b001db86c48221sm1770927plp.22.2024.02.17.11.26.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 17 Feb 2024 11:26:13 -0800 (PST)
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, bmeng@tinylab.org,
 liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, palmer@rivosinc.com,
 thuth@redhat.com, lvivier@redhat.com, pbonzini@redhat.com,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Subject: [PATCH v2 0/6] libqos, riscv: libqos fixes, add riscv machine
Date: Sat, 17 Feb 2024 16:26:01 -0300
Message-ID: <20240217192607.32565-1-dbarboza@ventanamicro.com>
X-Mailer: git-send-email 2.43.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62b;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-pl1-x62b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

This second version was rebased with current
alistair/riscv.to.apply-next and has typo fixes in patch 1. No other
changes were made.

All patches reviewed/acked.

Changes from v1:
- patch 1: typos in the commit message fixed
- v1 link: https://lore.kernel.org/qemu-riscv/20240213191736.733334-1-dbarboza@ventanamicro.com/

Daniel Henrique Barboza (6):
  libqos/virtio.c: init all elems in qvring_indirect_desc_setup()
  libqos/virtio.c: fix 'avail_event' offset in qvring_init()
  hw/riscv/virt.c: create '/soc/pci@...' fdt node earlier
  hw/riscv/virt.c: add virtio-iommu-pci hotplug support
  hw/riscv/virt.c: make aclint compatible with 'qtest' accel
  tests/libqos: add riscv/virt machine nodes

 hw/riscv/virt.c                         |  97 ++++++++++++-----
 tests/qtest/libqos/meson.build          |   1 +
 tests/qtest/libqos/riscv-virt-machine.c | 137 ++++++++++++++++++++++++
 tests/qtest/libqos/virtio.c             |  27 +++--
 4 files changed, 228 insertions(+), 34 deletions(-)
 create mode 100644 tests/qtest/libqos/riscv-virt-machine.c

-- 
2.43.2


