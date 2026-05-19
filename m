Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76A96CD4F3C
	for <qemu-devel@archiver.kernel.org>; Tue, 19 May 2026 14:46:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wPLhq-0007nu-Im; Tue, 19 May 2026 10:46:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wPLho-0007mt-8a
 for qemu-devel@nongnu.org; Tue, 19 May 2026 10:46:00 -0400
Received: from mail-wr1-x435.google.com ([2a00:1450:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wPLhl-0007dS-UY
 for qemu-devel@nongnu.org; Tue, 19 May 2026 10:45:59 -0400
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-44a74032ff8so2589503f8f.1
 for <qemu-devel@nongnu.org>; Tue, 19 May 2026 07:45:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779201956; x=1779806756; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=mjEY0DrBky3++IIp6Xm8/05zq+4Q//C1o6qyRCvDS9w=;
 b=n4B7/28gQjRfve2JG/uIbkagz47hC4L7Vjj/8D5Pbw2eYoLjMg0luaASCjxiCsoStk
 Df27xUY9Crpqn3Bni1FKVk62u0uU8ARsQzaL42Xp5Sota/WrbuoApJZp8HW4DwPDG1nk
 Yv2linC30/KxXN3IYP+UHpPf5A/lJn1HcElAUJflwrO1kYB6nh2JJDDaCNhujgKauMZs
 D12r9HaRQyg9QikfiykcqFFsNDP4UhjvWdmLwf7ly7n8RijRfmbNZxNtXU36QoeQKjUh
 1quYhpX+LF6LPknyN7PVkGjafg6Vha7P1HLVBXHquaMDvQIZxPcPGzj23N6Lz27qDuc2
 2IiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779201956; x=1779806756;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mjEY0DrBky3++IIp6Xm8/05zq+4Q//C1o6qyRCvDS9w=;
 b=NtMkLksO94qSQ1H6YTJkrAsmlwrvNEUI2Lh/zx98zSfcpozXf/fatfEIFWM5quStKZ
 rpMrrdNyRM6lzbujogm95D3EWK5v9GJltljCeIE5N1QwVIKgsr+tKOu64LJ9QlOkMPC4
 Ba2maIdVFoSF9euJwZ/vKZp9N4ABW0tmRPPWdopYm2YDmjwpCwMdGhczUoNRKXcPBChc
 HJ6gXeBqimXKUsY64wgwl8TlKtVyKk6gNdw+o1wmIx1mM9hrfPkZRFatlA+3OnCl1r+F
 w8gXCxWfiwuYyVomBn1tjPzXY/uarFfkDSaWT176F+QwM17eAXPW2cZKdix9StuRQoji
 Nyhw==
X-Gm-Message-State: AOJu0YxY2LRS3UPhvmvR6PlQXpl2ttamTXPKN+2fAyRdZyNCV9/Dk+1L
 JukneuvceoZ5qPaAl0eRBRxf0Bk5LKlLnV6hDtSwK+XtkoGcvYJcdsG4b6Optw4geIT35SWcIC2
 9FBL57yc=
X-Gm-Gg: Acq92OHAuFiCmRV7fbLAkpShvT+KfN5dsQP+uiqSAVbMgtg8XOPyCeYqcVE55v0VYdc
 bPcmjoskeoZZbchIelhZXSMwQyvgIIoRt7KifuMSe37qNhYqlZyrWWK3G5wyUWgWcpTQzn1FReW
 chS9Go5e433tExTJrcS6Eu0OrxRUXsYY+cMt4M8+a3XIRpFdGvx01XBhGusL4xk0j8CJG5nIY9d
 kf3yayjE2ScvqHzhR9d0ys1xlxiWH70pxTZtvwSm6OGe9fVn5bDnFTXXQlV+nX2lJOqOm3VyPjO
 wDDW0CSIJH03F6gU6DxGixUVvJWORnwm4KWRrvEod2Fun3x1UMl/f/zrdB1IK2loTjosF6Ya3Zv
 E0kG4OUi+jPEfocZctjw/PlzFxKU4lNTTCw8alnXpkWnuUJsRXjaHh+MBR0Sc7CD37VvFozlauA
 /nqpm8iT6gk7B/niXaO2kT+8dLsMGk657ANG72/f7u1qFUYjtNyjdk9dG69CkPlbab4soodmcR
X-Received: by 2002:a05:6000:1845:b0:43d:309b:9c4f with SMTP id
 ffacd0b85a97d-45e5c57d2fdmr32015944f8f.6.1779201955427; 
 Tue, 19 May 2026 07:45:55 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-45da0fe13b4sm46621957f8f.28.2026.05.19.07.45.54
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 19 May 2026 07:45:54 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
Subject: [PATCH v8 00/18] single-binary: Make hw/arm/ common
Date: Tue, 19 May 2026 16:45:35 +0200
Message-ID: <20260519144553.91483-1-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
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

Series fully reviewed.

Since v7:
- Rebased on top of 8d3e31c0d57 (IDAU interface)

Since v6:
- Do not initialize Aspeed CPU in SoC realize (cdrx)

Since v5:
- Unify 'max' CPU type (rth, pm215)

Since v4:
- Add DEFINE_MACHINE_WITH_INTERFACES (Zoltan)
- Use GPtrArray for get_valid_cpu_type (Richard)
- Define InterfaceInfo[] arrays (Richard)
- Collect R-b tags

Since v3:
- QAPI structure renamed as QemuTargetInfo
- MachineClass::get_valid_cpu_types() runtime
- target_aarch64() checking SysEmuTarget value
- Remove CONFIG_TCG #ifdef'ry in hw/arm/

Since v2:
- More comments from Pierrick addressed
- Use GList to register valid CPUs list
- Remove all TARGET_AARCH64 uses in hw/arm/

Since v1:
- Dropped unrelated / irrelevant patches
- Addressed Pierrick comments
- Added R-b tag
- Only considering machines, not CPUs.

Available here, based on my pending patch queue:
https://gitlab.com/philmd/qemu/-/tags/single-binary-hw-arm-rfc-v5

Matthew Penney (1):
  tests/qtest: fix discarded const qualifier warning

Philippe Mathieu-Daudé (17):
  hw/arm/raspi: Initialize 64-bit CPU types during DeviceRealize()
  hw/arm/raspi: Build objects once
  hw/arm/aspeed: Do not realize 64-bit CPU types under QTest
  hw/arm/aspeed: Build objects once
  hw/arm/meson: Remove now unused arm_ss[] source set
  target/arm: Introduce common system/user meson source set
  target/arm: Build gdbstub64.o as common object
  target/arm: Build cpu64.o as common object
  target/arm: Extract common code related to 'max' CPU
  target/arm: Use make_ccsidr(LEGACY) in 32 bit 'max' CPU type
  target/arm: Implement DBGDEVID* registers in max AArch32 CPU
  target/arm: Only set %kvm_target when KVM is enabled
  target/arm: Factor aarch64_aa32_a57_init() out
  target/arm: Re-use common aarch64_aa32_a57_init() helper
  target/arm: Define 'max' CPU type in cpu-max.c
  target/arm: Build cpu32-system.o as common object
  target/arm: Build cpu-max.c once

 target/arm/internals.h                     |   2 +
 hw/arm/aspeed_ast27x0.c                    |  14 ++
 hw/arm/bcm2836.c                           |  14 +-
 hw/arm/raspi.c                             |   4 -
 target/arm/cpu-max.c                       | 241 +++++++++++++++++++++
 target/arm/cpu64.c                         |  80 +------
 target/arm/tcg/{cpu32.c => cpu32-system.c} | 174 +--------------
 target/arm/tcg/stubs32.c                   |  10 +
 tests/qtest/libqtest.c                     |   2 +-
 hw/arm/meson.build                         |  15 +-
 target/arm/meson.build                     |  26 ++-
 target/arm/tcg/meson.build                 |  57 ++---
 12 files changed, 319 insertions(+), 320 deletions(-)
 create mode 100644 target/arm/cpu-max.c
 rename target/arm/tcg/{cpu32.c => cpu32-system.c} (81%)

-- 
2.53.0


