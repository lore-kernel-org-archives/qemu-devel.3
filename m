Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89F20D3B986
	for <qemu-devel@archiver.kernel.org>; Tue, 26 Nov 2024 11:25:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tFteA-0003gH-G1; Tue, 26 Nov 2024 06:22:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tFte9-0003fb-MQ
 for qemu-devel@nongnu.org; Tue, 26 Nov 2024 06:22:21 -0500
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tFte6-0002Vh-Ba
 for qemu-devel@nongnu.org; Tue, 26 Nov 2024 06:22:21 -0500
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-382433611d0so4575779f8f.3
 for <qemu-devel@nongnu.org>; Tue, 26 Nov 2024 03:22:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1732620135; x=1733224935; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=KF5+Q+1rOwwX8eIZyyP/Swk9x61oFbeTaj2aNqOzoek=;
 b=uqspTHG7nWNYGC04V7d9iVNSCuRszDF0T0PhCE1EP+v8tqK70adGQPBqRqrsUSt2ue
 58nMqaRi8CsezZLP2+N82HflK4ah5bGK/hVF0Q3eOy1BO+bq8rLjK2HELm9mQXBqCQtZ
 +Eyls/Md6HqHay4nxB1hV37t+N9PwFXD8T0x1eMyNphvFNIXm+jwbxs6lM3DpkVs8lrr
 /gHvRJm+XqD9dWmgNaZg8414n/G3KFyzMkuuJKdfVeAmmqoSCwpZckJz8KgFmpyapblT
 UEteKKL9q10R1bZxLVmc0wKGRrQoEyvrYD2Bn+ztqkshyJWQevxmSmHefaftZuPKhDQz
 0oSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732620135; x=1733224935;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=KF5+Q+1rOwwX8eIZyyP/Swk9x61oFbeTaj2aNqOzoek=;
 b=FuSu+JSWvnMMsOKwb3Fi3VTJYTX0WtFvNjVnANIs30zX3ySEtmyYWof1rENbgS4BQt
 2mhaWAv15uL30QN62yKPtjKLPY7WmxbMkGJ5QCM1+LwLqNT2+ce4i8MndFeUkMd2TZVh
 XJ0e2l09m83cw0AlwYXmbdTv8L2h19WQ/t8YPRHxJNrfjf7+0vR+sw6zaGQfaplSTcXJ
 L+7aonoPQItE/U29yww0apsi7oEz9hKPRyrgPGprEbqFEN7DsjZOg3Px4Aq1Iul14oqp
 M6YO/FmK8H647/lebKYeucqrRPW+faTu/O5353fEkC2oA/k151VJhRuKDs42ySVfcR2c
 kXcw==
X-Gm-Message-State: AOJu0YwG0K4k9f/jW7PPOVq1910MOFtOmaLi+B7PHzyKmMuWeVGg6GLe
 zyinoJP3WKCw18zFMMpQhR77OKCvTaZ15nSNYpSiFm6lHpOnVKR7fKIXa+OjqZiTpQwrRESKaGw
 Q
X-Gm-Gg: ASbGncvuiZ8dbsMQnb8dwCJUkykpcxNsJOdS9oxrNDafwndrfPcyA1S1gfNTWNs+EVp
 Goc1fW1cHeVW2vDY3T0Zpcm8ydfFg4VawZ50Yla310APw+9vSVHoiBWQ0fv9UuuG2RjGnhgVU6q
 OMipMFTyg6GlDyAkZYPMnD9D7Yqd2nh4+m6qx8i/RuNO5epUfeKSfwBHtjTtWokvPHOnSo25bSB
 kvtV5kvVGAjxx6rQLPvgIvFNVOCVW7eBvjmy5DrYCmQpMh6m1oIb0nPfh9O/J3cUrc/YXRi
X-Google-Smtp-Source: AGHT+IGB1S3nePENSA533CkYLMuP58/EiNkFaULMaHf4Q6BH3rt6mUvqb14gZTBwOv+wLOm8/JJ+aA==
X-Received: by 2002:a5d:5f53:0:b0:382:46ea:1113 with SMTP id
 ffacd0b85a97d-38260b3cc31mr15783506f8f.4.1732620135272; 
 Tue, 26 Nov 2024 03:22:15 -0800 (PST)
Received: from localhost.localdomain ([176.176.143.205])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3825fbc34bdsm13398468f8f.78.2024.11.26.03.22.13
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 26 Nov 2024 03:22:14 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, qemu-s390x@nongnu.org, Thomas Huth <thuth@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, qemu-riscv@nongnu.org,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH-for-10.0 v2 00/13] hw/boards: Remove legacy
 MachineClass::pci_allow_0_address flag
Date: Tue, 26 Nov 2024 12:21:59 +0100
Message-ID: <20241126112212.64524-1-philmd@linaro.org>
X-Mailer: git-send-email 2.45.2
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42a;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42a.google.com
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

Since v1:
- Looked at previous analysis from Peter [1]
- Invert logic so "allow address 0 accesses" is default

---

This series aims to remove a legacy field from
MachineClass. Why? Because it doesn't scale on
heterogeneous machine where different host bridges
are created.

Rather than a global exposed to all machines,
use a pci-bus specific flag on each machine
requiring it, propagated by the host bridge
device.

No logical change intended, only machines previously
using pci_allow_0_address do not set refuse-bar-at-addr-0.

Presumably various machines neither need to set this
'refuse-bar-at-addr-0' flag, but updating that is
deferred to each machine maintainer since I don't have
the knowledge and sufficient test suite IMHO.

[1] https://lore.kernel.org/qemu-devel/20241125140535.4526-1-philmd@linaro.org/
[2] https://lore.kernel.org/qemu-devel/1444683308-30543-1-git-send-email-agordeev@redhat.com/T/#u

Philippe Mathieu-Daudé (13):
  hw/pci: Do not declare PCIBus::flags mask as enum
  hw/pci-bridge: Initialize bridge with parent bus flags
  hw/pci: Factor machine_refuses_bar_at_addr_0() helper out
  hw/pci: Introduce PCIBusFlag::PCI_BUS_BAR_AT_ADDR0_REFUSED
  hw/pci: Propagate bar_at_addr_0_refused to
    pci_root_bus_internal_init()
  hw/pci: Propagate bar_at_addr_0_refused to pci_root_bus_init()
  hw/pci: Propagate bar_at_addr_0_refused to pci_root_bus_new()
  hw/pci: Propagate bar_at_addr_0_refused to pci_register_root_bus()
  hw/ppc/spapr: Create host bridge setting bar_at_addr_0_refused=false
  hw/pci-host/gpex: Expose 'refuse-bar-at-addr-0' property
  hw/arm/virt: Create GPEX host bridge without refuse-bar-at-addr-0
  hw/riscv/virt: Create GPEX host bridge without refuse-bar-at-addr-0
  hw/pci/pci: Remove legacy MachineClass::pci_allow_0_address flag

 include/hw/boards.h                 |  1 -
 include/hw/pci-host/gpex.h          |  1 +
 include/hw/pci/pci.h                |  8 +++++---
 include/hw/pci/pci_bus.h            | 10 ++++++++--
 hw/alpha/typhoon.c                  |  2 +-
 hw/arm/sbsa-ref.c                   |  1 -
 hw/arm/virt.c                       |  1 -
 hw/i386/microvm.c                   |  2 ++
 hw/loongarch/virt.c                 |  2 ++
 hw/mips/loongson3_virt.c            |  2 ++
 hw/openrisc/virt.c                  |  2 ++
 hw/pci-bridge/pci_expander_bridge.c | 17 +++++++++++-----
 hw/pci-host/articia.c               |  3 ++-
 hw/pci-host/astro.c                 |  3 ++-
 hw/pci-host/bonito.c                |  2 +-
 hw/pci-host/designware.c            |  2 +-
 hw/pci-host/dino.c                  |  2 +-
 hw/pci-host/gpex.c                  |  5 ++++-
 hw/pci-host/grackle.c               |  2 +-
 hw/pci-host/gt64120.c               |  2 +-
 hw/pci-host/i440fx.c                |  2 +-
 hw/pci-host/mv64361.c               |  2 +-
 hw/pci-host/pnv_phb3.c              |  2 +-
 hw/pci-host/pnv_phb4.c              |  2 +-
 hw/pci-host/ppc440_pcix.c           |  2 +-
 hw/pci-host/ppc4xx_pci.c            |  2 +-
 hw/pci-host/ppce500.c               |  3 ++-
 hw/pci-host/q35.c                   |  2 +-
 hw/pci-host/raven.c                 |  2 +-
 hw/pci-host/remote.c                |  2 +-
 hw/pci-host/sabre.c                 |  2 +-
 hw/pci-host/sh_pci.c                |  2 +-
 hw/pci-host/uninorth.c              |  8 ++++----
 hw/pci-host/versatile.c             |  2 +-
 hw/pci-host/xilinx-pcie.c           |  2 +-
 hw/pci/pci.c                        | 31 ++++++++++++++++++-----------
 hw/pci/pci_bridge.c                 |  1 +
 hw/ppc/ppc440_uc.c                  |  2 +-
 hw/ppc/spapr.c                      |  1 -
 hw/ppc/spapr_pci.c                  |  2 +-
 hw/riscv/virt.c                     |  1 -
 hw/s390x/s390-pci-bus.c             |  2 +-
 hw/xen/xen-pvh-common.c             |  2 ++
 hw/xtensa/virt.c                    |  2 ++
 44 files changed, 94 insertions(+), 57 deletions(-)

-- 
2.45.2


