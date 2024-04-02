Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68A30CD1284
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Apr 2024 14:25:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rrf47-0000f9-IS; Tue, 02 Apr 2024 10:24:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rrf44-0000c2-Q9
 for qemu-devel@nongnu.org; Tue, 02 Apr 2024 10:24:40 -0400
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rrf41-0007R1-Iy
 for qemu-devel@nongnu.org; Tue, 02 Apr 2024 10:24:40 -0400
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-4161c24bad0so4147965e9.0
 for <qemu-devel@nongnu.org>; Tue, 02 Apr 2024 07:24:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1712067876; x=1712672676; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=0ARN4/ABZhX8L8cR8XaKVceRbmAnWWSOTXp/b2jJ1bY=;
 b=UrJdUsQAlMoJ+TiUTHwVHTgoJ4j4LfkDX5IC6rk9Rco59xPtxAol2rg+JpzPPDTh2x
 g7MMJ3WFtx9QIQFt914CToyYO3Z7aF/UE2D/BAlpuz8SqfB99Jn6C057r1sR00pFM76N
 ttcQps21uH87hj1iBKrDaJ5K3NbaAYXiPO6G/Hywrw3+GCqv5sZSxptE2dpuvKiZmpf9
 wTWwPeBvnQasUzcLX4D8eaSwqUot4Y8k6ulDQA6T8FI9j63/lgCggDPL+sJyK25R4uOd
 p2mXTSqR2YDY3VBGEZ+KR93fIRs0CPjcgupwbLRxjqf7luOemmYZsdzt58QCa6EDEMNF
 3TMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712067876; x=1712672676;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=0ARN4/ABZhX8L8cR8XaKVceRbmAnWWSOTXp/b2jJ1bY=;
 b=KmUP5d8iVpxlO4CfXYk3sPiSnaaC8WdcXn53invkwZTgB0Uzu9Pdybc0nK+LdUWdQS
 zsFk+QFhM01x5CQyoaIjEevPTpEPdMtec/RYNjvCC5Ws3rEeIVWyjsAdtQEXP8BxTQ7K
 sdZvuXRLUCi++kFIFTdWzpIXq0P0AWiOT0NEO3/uA4HawwvPu5bobOyxsfAorCVdE0Lk
 XIzHiDP95h0DiTRZQOs93AcDi5NwS3w777D0RMaS/M+VeipdoCD5vtsWZdOBvdgWYhP4
 MT1mvxchbfEiKqFpOmaMVfkMl/Ze25QkOi66lm9UIgFfeuLusBludozbDlzYB3e9LQD7
 Wqbw==
X-Gm-Message-State: AOJu0YwUI8PhU/x+OlyKq/cd4FyZjpWgEkW8t96xM0ygaesnOeQlbx1Q
 6zoaJkIzhReg3TYFL63uacxF1du/ZcQEyfxkkdyBZdenfiTpR0K9yc3Zm3cJPGdcn026aML+jGQ
 4hT4=
X-Google-Smtp-Source: AGHT+IH5pJZGRwVYJ9ZaeHhgmfXs5wfeZQNVe6bhs+mY49AmsJWjrCyh8DPnhqmg6+ssKn7cwo0unw==
X-Received: by 2002:a05:600c:6b0c:b0:415:52e2:64b2 with SMTP id
 jn12-20020a05600c6b0c00b0041552e264b2mr7130224wmb.6.1712067875701; 
 Tue, 02 Apr 2024 07:24:35 -0700 (PDT)
Received: from m1x-phil.lan ([176.187.202.91])
 by smtp.gmail.com with ESMTPSA id
 l6-20020a05600c4f0600b0041469869d11sm21166619wmq.47.2024.04.02.07.24.34
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 02 Apr 2024 07:24:35 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, qemu-block@nongnu.org, qemu-arm@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 00/15] Misc HW patches for 2024-04-02
Date: Tue,  2 Apr 2024 16:24:15 +0200
Message-ID: <20240402142431.70700-1-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x330.google.com
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

The following changes since commit 7fcf7575f3d201fc84ae168017ffdfd6c86257a6:

  Merge tag 'pull-target-arm-20240402' of https://git.linaro.org/people/pmaydell/qemu-arm into staging (2024-04-02 11:34:49 +0100)

are available in the Git repository at:

  https://github.com/philmd/qemu.git tags/hw-misc-20240402

for you to fetch changes up to 4c54f5bc8e1d38f15cc35b6a6932d8fbe219c692:

  hw/net/virtio-net: fix qemu set used ring flag even vhost started (2024-04-02 16:15:07 +0200)

----------------------------------------------------------------
Misc HW patch queue

- MAINTAINERS updates (Zhao, Glenn)
- Replace incorrect mentions of 'softmmu' by 'system' (Phil)
- Avoid using inlined functions with external linkage (Phil)
- Restrict CXL to x86 PC PCI-based machines (Phil)
- Remove unnecessary NULL check in bdrv_pad_request (Kevin)
- Fix a pair of -Werror=maybe-uninitialized (Marc-André)
- Initialize variable in xen_evtchn_soft_reset (Artem)
- Do not access virtio-net tx queue until vhost is started (Yajun)

----------------------------------------------------------------

Artem Chernyshev (1):
  hw/xen_evtchn: Initialize flush_kvm_routes

Glenn Miles (1):
  gpio/pca955x: Update maintainer email address

Kevin Wolf (1):
  block: Remove unnecessary NULL check in bdrv_pad_request()

Marc-André Lureau (2):
  plugins: fix -Werror=maybe-uninitialized false-positive
  hw/nvme: fix -Werror=maybe-uninitialized

Philippe Mathieu-Daudé (8):
  accel/tcg/plugin: Remove CONFIG_SOFTMMU_GATE definition
  gdbstub: Correct invalid mentions of 'softmmu' by 'system'
  gdbstub/system: Rename 'user_ctx' argument as 'ctx'
  target/ppc: Rename init_excp_4xx_softmmu() -> init_excp_4xx()
  hw/arm/smmu: Avoid using inlined functions with external linkage again
  accel/hvf: Un-inline hvf_arch_supports_guest_debug()
  qtest/libqos: Reduce size_to_prdtl() declaration scope
  hw/i386/pc: Restrict CXL to PCI-based machines

Yajun Wu (1):
  hw/net/virtio-net: fix qemu set used ring flag even vhost started

Zhao Liu (1):
  MAINTAINERS: Fix error-report.c entry

 MAINTAINERS               |  4 ++--
 gdbstub/internals.h       | 26 +++++++++++++-------------
 tests/qtest/libqos/ahci.h |  1 -
 accel/tcg/plugin-gen.c    |  6 ------
 block/io.c                |  2 +-
 gdbstub/system.c          | 10 +++++-----
 hw/arm/smmu-common.c      |  2 +-
 hw/i386/kvm/xen_evtchn.c  |  2 +-
 hw/i386/pc.c              |  4 +++-
 hw/net/virtio-net.c       |  4 ++++
 hw/nvme/ctrl.c            |  2 +-
 plugins/loader.c          |  2 +-
 target/arm/hvf/hvf.c      |  2 +-
 target/i386/hvf/hvf.c     |  2 +-
 target/ppc/cpu_init.c     |  4 ++--
 tests/qtest/libqos/ahci.c |  2 +-
 16 files changed, 37 insertions(+), 38 deletions(-)

-- 
2.41.0


