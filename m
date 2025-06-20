Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9722AC7115C
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Jun 2025 13:11:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uSbSh-0002JT-1R; Fri, 20 Jun 2025 09:07:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uSbSf-0002J3-2T
 for qemu-devel@nongnu.org; Fri, 20 Jun 2025 09:07:17 -0400
Received: from mail-wr1-x42e.google.com ([2a00:1450:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uSbSd-0004U0-3J
 for qemu-devel@nongnu.org; Fri, 20 Jun 2025 09:07:16 -0400
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-3a53359dea5so1048946f8f.0
 for <qemu-devel@nongnu.org>; Fri, 20 Jun 2025 06:07:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1750424832; x=1751029632; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=+QJmU5PBg2tZeWfZeXKYOSoau8zVaAF0qlZsb030HdQ=;
 b=cOblI3HebgHlpfnOSsV96ssafJjQK+UTt8b+PwtULW1nSCaulLh+ZgQfHSM9g+sxgq
 ClTG8YprVtFqSzJo9phQvWZ2qlTpK2ljUJcKnhemHscvSozn7jBB9H9WMdDqlgFXTKz1
 y2HqEpT8HGSs7L13gIHLVGCjRA3WQck71GA8bIsng7bkXNjZ/w5L1zroaQFQTcikhPbR
 /8jUWiqjA+GEOFg9cRCG8SS3vbYrN/rdNhzXUVVAP2tFAvBSCmEYZnrrjIyXmgRoL5yA
 LEVwd9thYc662MV1ni/H2rO/9O5QvP7c9wO23jB3rPtn/3a3UHWYCALI/1ljxZ04Hr94
 ILyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750424832; x=1751029632;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=+QJmU5PBg2tZeWfZeXKYOSoau8zVaAF0qlZsb030HdQ=;
 b=Dh3w8xdoVhQB32KOP8vXMdCmF89GDPX90k++nA+ydpKK6n7ioS5s6SStSqSDsOXylG
 4EiqsBmM5I9xszLEi4dwwbsyjWXfSlLR5V+J0gnJ370QZQ2u1wgAmj6x73ghl3AaxXDG
 Ihq7mmNOr1hybw/qo/WpabKTXfCLkzVLLZNCnoOWdXe7uZDR/M51pQUrjpkOFBXhmIqL
 3+nY1sa6pCAE+n/lu42ceku6Qcz2iiSYQAViAwG37Hw1zzokkFRV+tcxPgn9np1qUMYj
 RJp1ty/jVkvg/8W5ynOK9C5JkTc7h9K0y4aSCNh042RGBfz1mRu7v6/fylzO+MjkBnrS
 ErQw==
X-Gm-Message-State: AOJu0YzkzYPwStXG/Tvu4/T2oMlzUSopnSR+EVyMOW+3x+MO6fcUBLe0
 U0lyyLR5CfzcJf+SfoHlWTuV2qlRTXUGAz/zqYEbZ3fVVpT+BwrNdNtT1p7uGDWt2ujnCfQ2cmP
 JmK1EnC4=
X-Gm-Gg: ASbGncs5frF/XAgF5Q7TwXqCf2ndZmAcd0vnaA7XbmsRICL4kQaYlOaRpHAeALFwunk
 9aNh6BqA40HCqqgGNNc+S3BbT74ilshom9rv0TdAQBtayb3bTKThr1WeR5q1h07zHpNgpriLJz2
 adoGXTm83S6V//Cz0rM28ipP6384Sy6mJhhu6GTxOnRmm/FRrN9gk6z2ud8l0GSXGt+6Q21+iTA
 vC83yPR01oWZO35cyDQNBUZTOjUuzL8vgkymPx7RcO5USVRZaxNA3Frk7x6LQ0XoJ1TqCKgUybe
 NMdi4nNJEtx8kpqGTZ8CX/6/ngpBmyXqHIwG8N7fXVSm5Kb1xoMNJKHf2UsrBb4DrdqviActl1n
 HeyUth/v91+44YNveXRkU1/boezAiuCSvHNVb
X-Google-Smtp-Source: AGHT+IEJ9h5ss6DQ9nbsYss8UAzQAQ33xR7PMaeHXiIi1steBknP4WF0eD2p4PDUPBMV6vbuu4kWIQ==
X-Received: by 2002:a05:6000:23c3:b0:3a4:f744:e00c with SMTP id
 ffacd0b85a97d-3a6d130452fmr1797673f8f.29.1750424831952; 
 Fri, 20 Jun 2025 06:07:11 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-453646dc66fsm24751975e9.18.2025.06.20.06.07.10
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 20 Jun 2025 06:07:11 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Leif Lindholm <leif.lindholm@oss.qualcomm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Radoslaw Biernacki <rad@semihalf.com>, Alexander Graf <agraf@csgraf.de>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Phil Dennis-Jordan <phil@philjordan.eu>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Bernhard Beschow <shentey@gmail.com>, Cleber Rosa <crosa@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Cameron Esfahani <dirty@apple.com>, kvm@vger.kernel.org,
 qemu-arm@nongnu.org, Eric Auger <eric.auger@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Roman Bolshakov <rbolshakov@ddn.com>,
 John Snow <jsnow@redhat.com>
Subject: [PATCH v2 00/26] arm: Fixes and preparatory cleanups for split-accel
Date: Fri, 20 Jun 2025 15:06:43 +0200
Message-ID: <20250620130709.31073-1-philmd@linaro.org>
X-Mailer: git-send-email 2.49.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42e;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42e.google.com
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
  target/arm/hvf: Trace host processor features
  hw/arm/virt: Only require TCG || QTest to use TrustZone
  hw/arm/virt: Only require TCG || QTest to use virtualization extension
  hw/arm/virt: Rename cpu_post_init() -> post_cpus_gic_realized()
  hw/arm/sbsa-ref: Tidy up use of RAMLIMIT_GB definition
  tests/functional: Restrict nexted Aarch64 Xen test to TCG
  tests/functional: Require TCG to run Aarch64 imx8mp-evk test
  tests/functional: Add hvf_available() helper
  tests/functional: Expand Aarch64 SMMU tests to run on HVF accelerator

 meson.build                                 |   1 +
 accel/hvf/trace.h                           |   2 +
 include/qemu/accel.h                        |   3 +
 include/system/accel-ops.h                  |   4 +-
 include/system/hvf.h                        |   3 +
 target/arm/cpu.h                            |   2 -
 target/arm/internals.h                      |   6 +-
 target/arm/tcg/translate.h                  |   1 +
 accel/accel-common.c                        |   4 +
 accel/accel-system.c                        |   3 +-
 accel/hvf/hvf-accel-ops.c                   |   8 ++
 accel/tcg/tcg-accel-ops.c                   |   4 +-
 hw/arm/sbsa-ref.c                           |   8 +-
 hw/arm/virt.c                               |   9 +-
 target/arm/cpu.c                            |  78 ++++++------
 target/arm/hvf/hvf.c                        | 129 +++++++++++++++-----
 target/arm/kvm.c                            |   2 +-
 target/arm/tcg/translate-a64.c              |   6 -
 target/arm/tcg/translate.c                  |   2 +-
 target/i386/hvf/hvf.c                       |   5 +
 accel/hvf/trace-events                      |   7 ++
 python/qemu/utils/__init__.py               |   2 +-
 python/qemu/utils/accel.py                  |   8 ++
 target/arm/hvf/trace-events                 |   6 +-
 tests/functional/qemu_test/testcase.py      |   6 +-
 tests/functional/test_aarch64_imx8mp_evk.py |   1 +
 tests/functional/test_aarch64_smmu.py       |   9 +-
 tests/functional/test_aarch64_xen.py        |   1 +
 28 files changed, 221 insertions(+), 99 deletions(-)
 create mode 100644 accel/hvf/trace.h
 create mode 100644 accel/hvf/trace-events

-- 
2.49.0


