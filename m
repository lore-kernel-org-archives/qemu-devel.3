Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8300CD5BD5
	for <qemu-devel@archiver.kernel.org>; Thu, 28 May 2026 20:23:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wShFu-0005Ia-7P; Thu, 28 May 2026 16:23:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wShFr-0005Gx-VK
 for qemu-devel@nongnu.org; Thu, 28 May 2026 16:23:00 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wShFp-0004C0-VW
 for qemu-devel@nongnu.org; Thu, 28 May 2026 16:22:59 -0400
Received: by mail-wr1-x444.google.com with SMTP id
 ffacd0b85a97d-44e5624c053so7918492f8f.2
 for <qemu-devel@nongnu.org>; Thu, 28 May 2026 13:22:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779999775; x=1780604575; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=pmymOgY0NPikGWDMTriaQbCuVEkKyMkTPhQBuHxB4qQ=;
 b=AQUKUEGWVesmh6a+B7iwtkr/xzoR/sh4HIKXZNZfpCtCanfvf85SV5xfhnKZ6mfgGy
 ZN7a/SFRnsxCCWvHmQ+mfOGs8FO3+dm0NfTnkrxAMHqcYaOKiuUtUEH4kmvHw/X/ZAIw
 iJoo47GIE01fsaxHvNVudtk9OdQXqkpczUsq2tlBe3aMZHGEuRQfS6fzUQZTShDBc6K4
 LbP/9m7n/IdExmH+jFuw57ZdQrV0Lf3knYTq1nP3ChBT+21cvPspVupoI12aokaiWXYI
 ULEfGoSXbqIypHhSuw6lBhgC6s78Y2bcQSHD7tgYkiTWhXjvug+p5hzRtvr+r6G3MtTb
 y58Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779999775; x=1780604575;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=pmymOgY0NPikGWDMTriaQbCuVEkKyMkTPhQBuHxB4qQ=;
 b=A2hSHoi9A56r0rrYp+YQHgoxKg69pVrw5VsMP5+7VQyMmpmuhKypEWhUuatPeT6OTG
 TAZwLusyCekiKxH3Bhy2Lr+zFVms99glZ0vu3bYhQlLjjqkgju+HuhPZ6Ju0YL20LvY1
 x7J85xHtr9fYfIipEjwQ9zaWX2jVB46Pka406gp1qYWsfvaMYThJa79v5pLE8fO5tKdM
 OdC7n76XnrpQpckZDyM8HO65otPG++ZX7HvOdEbZVAaiIimZmdYh8cxQPYQwZinUD22z
 PUw7cMw0MKg7jDiEP4nYHvI/YCY7nX+Dn9ITg5H5jt5HJufseE54i2Yoq+VkBFjgPKvC
 DbbQ==
X-Gm-Message-State: AOJu0YyuUikij3JPG/NEgwJUd5f8PfbJ3bTdyxkZMH/JIU/WDkh6nN8L
 HsV9irG56MlIm1zFc5yulLzua9ACk1DcM3ove2o6aodLCDvNweQ6/57ISQp1o/amQMc8MPrZ7Rh
 e18XGgPed6y2Q
X-Gm-Gg: Acq92OFvEKwN7G9usVyZygkf6UP6L5MdwmVjed7l8LYf/TKUcCkVYUWIS5fHHrsBd3S
 3p5H8HKf9LVHJ45g/nI5VP97eXBa4ZOcOgNBKekf8d5UcY9Rb9cobTlSKx5o/76EpU38WbFR+oj
 T+vqmM1Hl8QuszGMxMdPWu7vWrlo5gorXI6TKX/8N2hYUYCY4s2MwYXETt6fTMeIgQtzw6XWurV
 06eFMzdPl+Ri4wGPLG1V/VF7b2f8/auTiPz0xq+34RsplfTjajah3Zj1hWgqfbxCu1oEsgrwTX1
 lYZrjZofDD8ZdpllgH2piTqzOZYleL885zCqO3LVt8efgTPgl1bp7UHqUsNLUDJPkvuz2czsdNO
 z3Fyx1Sa+m8BjQX7MfqELQJDiS67NMqd+IGVnsdT2rlyqLRx8Y9i5eT+Mn66ALF4kivx69DUtO2
 u4rJxYwtCT5RQ5NwvTq3lqsx8deoeGk13d8GbPqNVXl9lt4uzq2j3fsGyVK5EXJpvM4Q==
X-Received: by 2002:a05:600c:6287:b0:490:3f7a:108b with SMTP id
 5b1f17b1804b1-4909c0d6780mr337315e9.16.1779999775373; 
 Thu, 28 May 2026 13:22:55 -0700 (PDT)
Received: from m15.home (88-187-86-199.subs.proxad.net. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-45edb5b28absm16331508f8f.27.2026.05.28.13.22.54
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 28 May 2026 13:22:54 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 00/22] Single binary patches for 2026-05-28
Date: Thu, 28 May 2026 22:22:30 +0200
Message-ID: <20260528202253.49122-1-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::444;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x444.google.com
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

The following changes since commit 2db91528542672cf0db78b3f2cc0e22b36302b38:

  Merge tag 'pull-vfio-20260527' of https://github.com/legoater/qemu into staging (2026-05-27 14:45:58 -0400)

are available in the Git repository at:

  https://github.com/philmd/qemu.git tags/single-binary-20260528

for you to fetch changes up to 603813bfc2aa57410cffdf4bccf4b45a82ea006a:

  hw/core: Remove SysemuCPUOps::get_phys_addr_attrs_debug (2026-05-28 22:18:35 +0200)

Checkpatch warnings ignored:

  WARNING: line over 80 characters
  #47: FILE: target/microblaze/helper.h:30:
  +DEF_HELPER_FLAGS_2(microblaze_unaligned_access, TCG_CALL_NO_WG, noreturn, env, i64)

  WARNING: added, moved or deleted file(s), does MAINTAINERS need updating?
    accel/accel-target.c

----------------------------------------------------------------
Various patches loosely related to single binary effort:

- Fix possible stub conflicts in meson.build
- Remove SysemuCPUOps::get_phys_addr_attrs_debug()
- Few other fixes and .mailmap updates
----------------------------------------------------------------

Knutsson Development (1):
  monitor: fix missing spaces in screendump help text

Mohammadfaiz Bawa (1):
  hw/tpm/tpm_tis_sysbus: defer resource allocation to realize

Peter Maydell (3):
  target/microblaze: Convert to translate_for_debug
  target/i386: Convert to translate_for_debug
  hw/core: Remove SysemuCPUOps::get_phys_addr_attrs_debug

Philippe Mathieu-Daudé (6):
  target/tcg: Rename unaligned_access() helpers
  docs/devel/tcg-ops: Stop listing dup2_vec()
  docs/devel/tcg-ops: List more vector opcodes
  mailmap: Update email addresses for Daniel Henrique Barboza
  mailmap: Update email addresses for Andrew Jones
  accel/common: Remove last bit of target-specific code

Pierrick Bouvier (7):
  meson.build: move some subdir before system lib creation
  target/arm: move kvm-stub to arm_stubs_ss
  target/arm: move whpx-stub to arm_stubs_ss
  migration: use stub_ss for vfio-stub.c
  net: use stub_ss for vhost-user-stub.c and vhost-vdpa-stub.c
  hw/net: use stub_ss for vhost_net-stub.c
  hw/vfio: use stub_ss for iommufd-stubs.c

Quan Sun (1):
  meson: fix close_range detection on older glibc

Richard W.M. Jones (1):
  system/exit-with-parent: Close the file descriptor before exit

Thomas Huth (2):
  system/vl: Free allocate memory for pid file name in case realpath()
    failed
  system/qtest: Fix length parameter in the b64write code

 docs/devel/tcg-ops.rst           | 13 ++++++----
 meson.build                      | 28 +++++++++++-----------
 include/hw/core/sysemu-cpu-ops.h | 14 -----------
 target/arm/tcg/helper-a64-defs.h |  2 +-
 target/i386/cpu.h                |  4 ++--
 target/microblaze/cpu.h          |  4 ++--
 target/microblaze/helper.h       |  2 +-
 accel/accel-common.c             | 15 ++++++++++++
 accel/accel-target.c             | 41 --------------------------------
 hw/core/cpu-system.c             | 11 ++-------
 hw/tpm/tpm_tis_sysbus.c          | 18 +++++++-------
 system/exit-with-parent.c        |  1 +
 system/qtest.c                   |  2 +-
 system/vl.c                      |  3 +++
 target/arm/tcg/helper-a64.c      |  4 ++--
 target/arm/tcg/translate-a64.c   |  4 ++--
 target/i386/cpu.c                |  2 +-
 target/i386/helper.c             | 31 +++++++++++++-----------
 target/i386/whpx/whpx-all.c      |  2 +-
 target/microblaze/cpu.c          |  2 +-
 target/microblaze/helper.c       | 18 +++++++-------
 target/microblaze/translate.c    |  2 +-
 .mailmap                         |  5 ++++
 accel/meson.build                |  1 -
 hmp-commands.hx                  |  4 ++--
 hw/net/meson.build               |  5 ++--
 hw/vfio/meson.build              |  2 +-
 migration/meson.build            |  4 ++--
 net/meson.build                  |  6 +++--
 target/arm/meson.build           |  6 +++--
 target/arm/whpx/meson.build      |  2 +-
 31 files changed, 114 insertions(+), 144 deletions(-)
 delete mode 100644 accel/accel-target.c

-- 
2.53.0


