Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5287FC7EE2A
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Jun 2025 12:24:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uTg8g-0001BF-6b; Mon, 23 Jun 2025 08:19:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uTg8V-00019y-Vm
 for qemu-devel@nongnu.org; Mon, 23 Jun 2025 08:19:00 -0400
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uTg8S-0000PB-0q
 for qemu-devel@nongnu.org; Mon, 23 Jun 2025 08:18:54 -0400
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-3a50fc819f2so3251708f8f.2
 for <qemu-devel@nongnu.org>; Mon, 23 Jun 2025 05:18:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1750681128; x=1751285928; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=7t8GepafkJeMN/Zl0RDAcmDhcsq3WRAaImUu4o56bag=;
 b=LytyFpZGbC/WWcHz6Aek2TaFAbqRcYl2tCbc8QMq1bzIthuimFcwWjGIMY05dIuXCb
 GM0YUsqebdjOr+IwmoCmJJOaXOPUL/t/F5kqqhDlsLb1wlIOf+Mqm9F0Q5xpuDgVar0x
 iuKh03pQw6wLZnAmclUe2xBreOIrePosJWWzkzVuk+irOVf9qz16FO521vIAQBwqL8I7
 TlRlzMmNQ5RNl3n8QO8U6wKcQmeE7Rng3ZlUHk5STD84eUqDSUQGifD5evRCtfJxcrOw
 0Sb1y80W35YwoH2v2uy6Qka/vBsTop6qtkx8i655VM8Z3gqc6qnbCQ9Zm5p8CjQMLRNE
 K7Hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750681128; x=1751285928;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=7t8GepafkJeMN/Zl0RDAcmDhcsq3WRAaImUu4o56bag=;
 b=a3oL120O5IEV//vMwITVH3vbZJ1QeU9V3K8Q84ZjsAf3T6MJcNRoR+daRSYFkY/iWg
 RlBxzSvyw4WNQgh1bh+ElvkE8HnA24rypWU8qWS4McK6sl+m3w8m7B9hMWVrOUlPOEo4
 roI9smsYmTJWNT6rYTgEAdjK/84MNWPf8OGLYi62bD0nC046H28bKBy229djgYU+6TB4
 kkwst8b9pCITQLiElXP4I0fSrvaN5gsHy+4gVx44RGKTVWtfddfogA+Q25KCcjr4JPaI
 zQI3GLy3jMo3VQaAxHqF4JXx6UoNBqD8z1NQuth2dSzi0XDaL3p3mHgLZedGzxcI8CW9
 4t6w==
X-Gm-Message-State: AOJu0YyVqlE9XhGCVhaVpH1e9bYmjwLUszzn62/dcDIp58O1tGKO2KzL
 om1LFmHmzR+hzSVE+ooDJRnEMQqo2wwMcj92TY+g1clGjc7qcLxUDHfNNZJWNETcNd/JtQ/qKzY
 opAPy
X-Gm-Gg: ASbGncvebajYT3C/e7HJeaY9leoEJbVofMuZKUsWbTqDzUQxdpPKYscoAd+/Qh2xNlZ
 vvu3bbLWqkkS9pAX88wuDGdaxFmXzTi4b829ZGmx/GXqJUIHetgPlOOMpeZDwUUZQKc3ABtwrQl
 nw9yUm8pNRuZIHMdT0bgg5ljh9iCbdZy2CBUNekH1S8yU4c/4wOMwv22iA0sBxpgnbwxbUpKcNA
 7vVWy2yp227OsWdC7gB9XJJqtwggRw4tXs82sJJprhkztODRVJQmxtsmg2nFHsJgEVjSisTBkIO
 hURI7Vd2DpSWcvZxxz+Cr9UpHmL3rYFtHdIwzY9UfPILTJRkVPdHEd+9eFvnlL9K+hYzRnKe9sH
 7xjrzC4YaHCewkcaqTjrnP1PKZskKRvc+RjB/
X-Google-Smtp-Source: AGHT+IFM1NS/tC9WBk7I3nX53LY2i9vYAhCY9oXhCQwhmOzZQ3Cjx1W2PBOvVDeh1+H7KqoU9pMS+Q==
X-Received: by 2002:a05:6000:248a:b0:3a5:2fae:1348 with SMTP id
 ffacd0b85a97d-3a6d13129c6mr9113300f8f.51.1750681128074; 
 Mon, 23 Jun 2025 05:18:48 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a6d117c66esm9121303f8f.47.2025.06.23.05.18.46
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 23 Jun 2025 05:18:47 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Leif Lindholm <leif.lindholm@oss.qualcomm.com>, qemu-arm@nongnu.org,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Roman Bolshakov <rbolshakov@ddn.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Alexander Graf <agraf@csgraf.de>, Bernhard Beschow <shentey@gmail.com>,
 John Snow <jsnow@redhat.com>, Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 kvm@vger.kernel.org, Eric Auger <eric.auger@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Cameron Esfahani <dirty@apple.com>, Cleber Rosa <crosa@redhat.com>,
 Radoslaw Biernacki <rad@semihalf.com>,
 Phil Dennis-Jordan <phil@philjordan.eu>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PATCH v3 00/26] arm: Fixes and preparatory cleanups for split-accel
Date: Mon, 23 Jun 2025 14:18:19 +0200
Message-ID: <20250623121845.7214-1-philmd@linaro.org>
X-Mailer: git-send-email 2.49.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::431;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x431.google.com
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

Only the last patch is missing review (#26)

Since v2:
- Addressed thuth review comments

Since v1:
- Addressed rth's review comments

Omnibus series of ARM-related patches (noticed during the
"split accel" PoC work).

- Usual prototypes cleanups
- Check TCG for EL2/EL3 features (and not !KVM or !HVF)
- Improve HVF debugging
- Correct HVF 'dtb_compatible' value for Linux
- Fix HVF GTimer frequency (My M1 hardware has 24 MHz)
  (this implies accel/ rework w.r.t. QDev vCPU REALIZE)
- Expand functional tests w.r.t. HVF

Regards,

Phil.

Philippe Mathieu-Daudé (26):
  target/arm: Remove arm_handle_psci_call() stub
  target/arm: Reduce arm_cpu_post_init() declaration scope
  target/arm: Unify gen_exception_internal()
  target/arm/hvf: Simplify GIC hvf_arch_init_vcpu()
  target/arm/hvf: Directly re-lock BQL after hv_vcpu_run()
  target/arm/hvf: Trace hv_vcpu_run() failures
  accel/hvf: Trace VM memory mapping
  target/arm/hvf: Log $pc in hvf_unknown_hvc() trace event
  target/arm: Correct KVM & HVF dtb_compatible value
  accel/hvf: Model PhysTimer register
  target/arm/hvf: Pass @target_el argument to hvf_raise_exception()
  target/arm: Restrict system register properties to system binary
  target/arm: Create GTimers *after* features finalized / accel realized
  accel: Keep reference to AccelOpsClass in AccelClass
  accel: Introduce AccelOpsClass::cpu_target_realize() hook
  accel/hvf: Add hvf_arch_cpu_realize() stubs
  target/arm/hvf: Really set Generic Timer counter frequency
  hw/arm/virt: Only require TCG || QTest to use TrustZone
  hw/arm/virt: Only require TCG || QTest to use virtualization extension
  hw/arm/virt: Rename cpu_post_init() -> post_cpus_gic_realized()
  hw/arm/sbsa-ref: Tidy up use of RAMLIMIT_GB definition
  tests/functional: Set sbsa-ref machine type in each test function
  tests/functional: Restrict nested Aarch64 Xen test to TCG
  tests/functional: Require TCG to run Aarch64 imx8mp-evk test
  tests/functional: Add hvf_available() helper
  tests/functional: Expand Aarch64 SMMU tests to run on HVF accelerator

 meson.build                                   |  1 +
 accel/hvf/trace.h                             |  2 +
 include/qemu/accel.h                          |  3 +
 include/system/accel-ops.h                    |  4 +-
 include/system/hvf.h                          |  3 +
 target/arm/cpu.h                              |  2 -
 target/arm/internals.h                        |  6 +-
 target/arm/tcg/translate.h                    |  1 +
 accel/accel-common.c                          |  4 +
 accel/accel-system.c                          |  3 +-
 accel/hvf/hvf-accel-ops.c                     |  8 ++
 accel/tcg/tcg-accel-ops.c                     |  4 +-
 hw/arm/sbsa-ref.c                             |  8 +-
 hw/arm/virt.c                                 |  9 +-
 target/arm/cpu.c                              | 78 +++++++++--------
 target/arm/hvf/hvf.c                          | 86 ++++++++++++-------
 target/arm/kvm.c                              |  2 +-
 target/arm/tcg/translate-a64.c                |  6 --
 target/arm/tcg/translate.c                    |  2 +-
 target/i386/hvf/hvf.c                         |  5 ++
 accel/hvf/trace-events                        |  7 ++
 python/qemu/utils/__init__.py                 |  2 +-
 python/qemu/utils/accel.py                    |  8 ++
 target/arm/hvf/trace-events                   |  5 +-
 tests/functional/qemu_test/testcase.py        |  6 +-
 tests/functional/test_aarch64_imx8mp_evk.py   |  1 +
 tests/functional/test_aarch64_sbsaref.py      |  5 +-
 .../functional/test_aarch64_sbsaref_alpine.py |  3 +-
 .../test_aarch64_sbsaref_freebsd.py           |  3 +-
 tests/functional/test_aarch64_smmu.py         | 12 ++-
 tests/functional/test_aarch64_xen.py          |  1 +
 31 files changed, 186 insertions(+), 104 deletions(-)
 create mode 100644 accel/hvf/trace.h
 create mode 100644 accel/hvf/trace-events

-- 
2.49.0


