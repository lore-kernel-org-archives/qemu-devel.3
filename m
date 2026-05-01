Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E12A9CD3424
	for <qemu-devel@archiver.kernel.org>; Fri,  1 May 2026 10:18:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wIktt-0003u6-JC; Fri, 01 May 2026 06:15:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wIkts-0003tB-1l
 for qemu-devel@nongnu.org; Fri, 01 May 2026 06:15:12 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wIktp-0008CZ-Br
 for qemu-devel@nongnu.org; Fri, 01 May 2026 06:15:11 -0400
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-488b3f8fa2bso27609435e9.1
 for <qemu-devel@nongnu.org>; Fri, 01 May 2026 03:15:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1777630507; x=1778235307; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=3OgovXw5Fvfw6RA6KlW8vcSRplYfEKQljM9POaKxMsI=;
 b=GmYU88OWYyORPB1kCzeiLjgJ1fLSZ9OlywIM59ngvE/dzaUUdSDzgjlvhZ/eh/pSgH
 s5PdQId+L8wtaHZJ7gSNcDBOyktWWc9u4fq68u6XDtqkQozDkMhh5UkTt4je1ENWFliA
 xRGfhbcXXdWBnUUsKoe1cP4nfPak8CP/NKupFVMhEgKWprcjm4b8eW0znCSn5Trx3+gG
 tkOikdDngmFqDYeTl1SnYfl8M263k5Gfdv1lFdSGQyIWvRx699pe1IxzTe24hh3Yz+/G
 jroBzA0xgnZM1uUAOdTOOAKAA2nXP4MvUD7sXJeASqWsSn7MozpYss9PkotiA460Qm9Z
 mDOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777630507; x=1778235307;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=3OgovXw5Fvfw6RA6KlW8vcSRplYfEKQljM9POaKxMsI=;
 b=TNK1UQp8QIu65xbOPDSMp0kWuRnv/4OJ79x7JcEjTv/fOfGqfEtDJihSMxXtiTPcRH
 lrVkzSMVkUs26Tj+IMyut/NGOMZuhKYyG7JCe0vVntbUdv7hHMMMnyGMuge0c71zQ9Mk
 af8YgoVdX0RiUwwSUsgQalqhzctRmjNcDBtpjGE+nkHb86gRWyj4rtY6XGLmxLcWJ9wq
 2fUJAiBBOJ4Ana8WVf51kvT2kRYSpM1uLp3bt0uRKk+ur8sfVonbfm0b5g6ggXHTylE3
 76IaLFcL2zUftqWklY05BXa9YWkegjmyiGBYsqlUP+9Of2M7HXNntEaoxI++4du8rEbS
 5e0A==
X-Gm-Message-State: AOJu0YxdQHVl8vtynkrrMvbvy3PG3zyU6YxFip+5zFwXZHJMxCl3jIAj
 gFkWvGz28T9+VO2BbV+J2PXtsvLzmEDHJx48GMW50dDB+tOztrjjF0FtBntDxO4lBMqhu7KJXdH
 pTdNB
X-Gm-Gg: AeBDietrthmQCxnTqAGU1ryrpAsqDqxRx/YiXEK8OFKgxDwfB3f9AEwqjX73s9Ep26S
 MLVps5tyUJXWp6jHcfhBKrouA1fMcTKn/oKBvViFa0LHXNdMJsVALbe+pzbz4YPwLaQOxARqi86
 MsGCtusXDFx9DAt5+fNVikKMyMridC6DzWwNS8UwIub48jzQgZpBbpLvOpUeA9kSshz+QC7HYRl
 YWWRrzY5c1qA7ZZtqBOoKHRG8+a20+UdfGDc4GIgsNQLSIJeOoYWVnYrGf9CgdD1n4ldDl53x3m
 rDnfE+d6JFu3Q/VWP8EQnnI8iCUcpRydMfFpQJLaDH7C3rFmxgriExg8rwFhgug1y6Xun2euiPI
 tNtsQMxFDJu+ZRWcs3ed2i0smmmuoSv1MSTrey2Ja6eEpflSe/xby4jKlQmrBQ8SN6tzmWTlxzA
 rMe1wDDtWc65w95FdPSGeUGuckmFAAyW63EEDdRYR3/r74Zc5IF6+ui+KtV2/+H3ZHgpnGuE2VZ
 bTNVPF2QAU/mWhCMUfBDTGnEpEv9ps0vE/f4MhEkA==
X-Received: by 2002:a05:600d:8449:b0:485:3cef:d6ea with SMTP id
 5b1f17b1804b1-48a8609892bmr68084725e9.13.1777630507263; 
 Fri, 01 May 2026 03:15:07 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48a8fede418sm12863335e9.6.2026.05.01.03.15.06
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 01 May 2026 03:15:06 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 00/28] target-arm queue
Date: Fri,  1 May 2026 11:14:37 +0100
Message-ID: <20260501101505.3485916-1-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32b.google.com
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

Hi; here's an arm pullreq. There's a combination of small stuff, plus
the hvf patchset that adds vGIC and nested-virt support. Last time we
tried to land this we got tripped up by some gitlab CI failures on jobs
that only run on the main staging CI run, not on the "run CI in your own
repo before sending" CI. Hopefully that won't happen again, but it's
possible...

thanks
-- PMM

The following changes since commit 282771e1f9b9b6e0147adf5f9d676325175b1767:

  Merge tag 'pull-riscv-to-apply-20260429-1' of https://github.com/alistair23/qemu into staging (2026-04-29 09:22:51 -0400)

are available in the Git repository at:

  https://gitlab.com/pm215/qemu.git tags/pull-target-arm-20260501

for you to fetch changes up to 03f12c3244ceb862714707411fa842bf76df711d:

  hvf: arm: enable vGIC by default for virt-11.1 and later (2026-05-01 10:44:18 +0100)

----------------------------------------------------------------
target-arm queue:
 * hw/arm/fsl-imx8mp: Do not create redundant unimplemented devices
 * hw/arm/fsl-imx8mp: Fix parent of ocram memory region
 * sysbus: Remove unused irq routing notifier method
 * linux-user/arm: Restrict regpairs_aligned
 * qemu-options: Improve description for -smb option
 * preliminary work for FEAT_RME_GDI
 * docs/devel/decodetree: Fix formatting in "field examples" table
 * hw/net/allwinner-sun8i-emac: Flush queued packets when rx is enabled
 * hw/intc/arm_gicv3: Fix NS write to ICC_AP1Rn_EL1 when prebits < 7
 * target/arm/kvm: Cache host CPU probe failure
 * hvf: support platform vGIC
 * hvf: support nested virtualization

----------------------------------------------------------------
Akihiko Odaki (1):
      target/arm/kvm: Cache host CPU probe failure

Bernhard Beschow (3):
      hw/arm/fsl-imx8mp: Do not create redundant unimplemented devices
      hw/arm/fsl-imx8mp: Fix parent of ocram memory region
      Revert "sysbus: add irq_routing_notifier"

Jim MacArthur (4):
      target/arm/cpu-features.c: New fields in AA64MMFR4
      target/arm/cpu.h: New GPCCR fields
      target/arm/ptw.c: Add GDI spaces to the granule protection case
      tests/tcg/aarch64/system/rme_gdi.c: Very basic test of GDI

Mohamed Mediouni (15):
      hw/intc: Add hvf vGIC interrupt controller support
      hw/intc: arm_gicv3_hvf: save/restore Apple GIC state
      accel, hw/arm, include/system/hvf: infrastructure changes for HVF vGIC
      target/arm: hvf: instantiate GIC early
      hw/arm, target/arm: nested virtualisation on HVF
      hvf: only call hvf_sync_vtimer() when running without the platform vGIC
      hvf: gate ARM_FEATURE_PMU register emulation when using the Apple vGIC
      hvf: arm: allow exposing minimal PMU for kernel-irqchip=on
      target/arm: hvf: add asserts for code paths not leveraged when using the vGIC
      hvf: sync registers used at EL2
      target/arm: hvf: pass through CNTHCTL_EL2 and MDCCINT_EL1
      hvf: arm: disable SME when nested virt is active
      hvf: arm: physical timer emulation
      hvf: enable nested virtualisation support
      hvf: arm: enable vGIC by default for virt-11.1 and later

Pali Rohár (1):
      qemu-options: Improve description for -smb option

Peter Maydell (1):
      docs/devel/decodetree: Fix formatting in "field examples" table

Richard Henderson (1):
      linux-user/arm: Restrict regpairs_aligned

liugan1 (1):
      hw/intc/arm_gicv3: Fix NS write to ICC_AP1Rn_EL1 when prebits < 7

宋文武 (1):
      hw/net/allwinner-sun8i-emac: Flush queued packets when rx is enabled

 accel/hvf/hvf-all.c                |  63 +++
 accel/stubs/hvf-stub.c             |  12 +
 docs/devel/decodetree.rst          |  44 +-
 hw/arm/fsl-imx8mp.c                |   3 +-
 hw/arm/virt.c                      |  46 +-
 hw/core/sysbus.c                   |   6 -
 hw/intc/arm_gicv3_common.c         |   4 +
 hw/intc/arm_gicv3_cpuif.c          |  35 +-
 hw/intc/arm_gicv3_hvf.c            | 835 +++++++++++++++++++++++++++++++++++++
 hw/intc/arm_gicv3_hvf_stub.c       |  25 ++
 hw/intc/meson.build                |   2 +
 hw/net/allwinner-sun8i-emac.c      |   3 +
 include/hw/arm/virt.h              |   2 +
 include/hw/core/boards.h           |   1 +
 include/hw/core/sysbus.h           |   1 -
 include/hw/intc/arm_gicv3_common.h |   4 +
 include/system/hvf.h               |   8 +
 include/system/hvf_int.h           |   1 +
 linux-user/user-internals.h        |   2 +-
 qemu-options.hx                    |  19 +-
 system/vl.c                        |   2 +
 target/arm/cpu-features.h          |   8 +
 target/arm/cpu.h                   |   5 +
 target/arm/hvf/hvf.c               | 208 ++++++++-
 target/arm/hvf/sysreg.c.inc        |  44 ++
 target/arm/hvf_arm.h               |   5 +
 target/arm/kvm.c                   |  38 +-
 target/arm/ptw.c                   |  20 +
 tests/tcg/aarch64/system/rme_gdi.c |  46 ++
 29 files changed, 1418 insertions(+), 74 deletions(-)
 create mode 100644 hw/intc/arm_gicv3_hvf.c
 create mode 100644 hw/intc/arm_gicv3_hvf_stub.c
 create mode 100644 tests/tcg/aarch64/system/rme_gdi.c

