Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57D99C7115B
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Jun 2025 13:15:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uSF58-0003Ve-Gd; Thu, 19 Jun 2025 09:13:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uSF57-0003VE-1y
 for qemu-devel@nongnu.org; Thu, 19 Jun 2025 09:13:29 -0400
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uSF53-0003pp-Oy
 for qemu-devel@nongnu.org; Thu, 19 Jun 2025 09:13:27 -0400
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-45362b7adc9so1456135e9.0
 for <qemu-devel@nongnu.org>; Thu, 19 Jun 2025 06:13:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1750338803; x=1750943603; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=jLfE9fOJifGBcyKWvwZ9c2lJf+BVklJMs4lfWx36NIY=;
 b=UbE2pw+NtRfGCNU1tDKEHyTAW2pf6w3ZDf2I9hRN+DlhCPUWGeiVwNqdoDJYoC4sqd
 pDNUPPoUvJjbQrlei/lArbD6OuPs9eDI/T1xsTnpz5md94VLUNjoSHbGpQHhWO3DcMbW
 e1xxBvmQT76rzWEBi1HiYSDAxl0HeC9ZJn/20dC3L/zVDk1XyzQXokTO2DUjhOmeRRK2
 wQUPI7l0qHCNvB61gGjdMEdS+AM9TnFNbVuXUrtG9eHuELChxUyEZd2E904aY5AkhOww
 ppRA3nS4OZWg44UJaVSl2lhMUlWaxRQI7QJB4FZ/f3h+UcXT1NCAIWCU4TAtBoVo0lzg
 PHRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750338803; x=1750943603;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=jLfE9fOJifGBcyKWvwZ9c2lJf+BVklJMs4lfWx36NIY=;
 b=uDV24RMoWUjRBO2V4d5Dczjkz9YdFAOvx+UzKfjouQmqHqMQiCCiJmt62OG9uC6O+l
 Q/b/888UU33rATBya5+x48SxVr/YhnSYSxP0L206AMzEVxWhkEJVxSpaHS1Eq4/bzjCX
 2DgV92YgFiz+EDeYbtgu6Q70JBViRCc/oDovUFH7diEeVB+JZmoWzujIJ3wHereQ/fSl
 FKD4379bwh1dMCfupeiCL2vOOEi/V7YorveB6iA5b4hupYnkI1ACcGRb0gZFEUyzZtR5
 O/d/G+KRw5hYiTuxcNRkDgiyVkINM6Jr2xu50yAiAMkkMnd4KkkBDKVbdWPMB4PrR6T3
 20zA==
X-Gm-Message-State: AOJu0YxNF3t712hUCmxYTAHjRMB18f17ZQ1jFxlWY7fY9HGbdfFOjvHn
 IhdOvzjXwy8/Nxm9+kvV351yvg8Dwe8NVSkJduEXmimRGyOkUXCxJvtpxPpCAeSpeM2FTAFqgLG
 FDtA9tjE=
X-Gm-Gg: ASbGncte/847iSRROVxpsGBONpDSZFvLhk6zdglqz4ov+ldEpKwjvW5l/ZWe0jXnUnk
 27AQvLen01s9f3UZiC8EX27lpLnzkCy4Wb5K63jUqk4wKmKYlcQT9q7In5+cL1XreXf4PsHpmP4
 Ia54SHmGZh1AaWaUTGZWMfkk1kJ0uEZyuC9k0XO7T4FfSEpoU9rQtPpnQ0t69/jIq67xfxtiP6K
 B8JXfM2w1VaWD4A3Bo2672ngz/Pys/tXUBAJS/W/Wq2xY7KunwyIj9WYxYHTfRHySyYYxeOyjtn
 92F/pGXTa6hlKVEw5+Q+gL34XZj1wF3af2MffQYFRzEMOl7FdWnBCD5j/pOcYIs/B4a10qJV/X/
 7Phq40d/qU3A7aUSh9L9ZRtXYS/AFq0xuAyNz
X-Google-Smtp-Source: AGHT+IFZta5PRVvj+E2GJ5o/dtJ2nlRFJisiMQh02QL8783nK8vqZBU6kAfypQFE9/oYtUYHjFX88A==
X-Received: by 2002:a05:600c:83c3:b0:442:f4a3:a2c0 with SMTP id
 5b1f17b1804b1-4535ec8d13dmr38863525e9.13.1750338803340; 
 Thu, 19 Jun 2025 06:13:23 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4535ead2449sm28200915e9.30.2025.06.19.06.13.21
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 19 Jun 2025 06:13:22 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Cameron Esfahani <dirty@apple.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Julian Armistead <julian.armistead@linaro.org>,
 Radoslaw Biernacki <rad@semihalf.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Phil Dennis-Jordan <phil@philjordan.eu>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Leif Lindholm <leif.lindholm@oss.qualcomm.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-arm@nongnu.org,
 Roman Bolshakov <rbolshakov@ddn.com>, Alexander Graf <agraf@csgraf.de>
Subject: [PATCH 00/20] arm: Fixes and preparatory cleanups for split-accel
Date: Thu, 19 Jun 2025 15:12:59 +0200
Message-ID: <20250619131319.47301-1-philmd@linaro.org>
X-Mailer: git-send-email 2.49.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32d.google.com
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

Omnibus series of ARM-related patches (noticed during the
"split accel" PoC work).

- Usual prototypes cleanups
- Check TCG for EL2/EL3 features (and not !KVM or !HVF)
- Improve HVF debugging
- Correct HVF 'dtb_compatible' value for Linux
- Fix HVF GTimer frequency (My M1 hardware has 24 MHz)
  (this implies accel/ rework w.r.t. QDev vCPU REALIZE)

Regards,

Phil.

Philippe Mathieu-Daudé (20):
  target/arm: Remove arm_handle_psci_call() stub
  target/arm: Reduce arm_cpu_post_init() declaration scope
  target/arm: Unify gen_exception_internal()
  target/arm/hvf: Simplify GIC hvf_arch_init_vcpu()
  target/arm/hvf: Directly re-lock BQL after hv_vcpu_run()
  target/arm/hvf: Trace hv_vcpu_run() failures
  accel/hvf: Trace VM memory mapping
  target/arm/hvf: Log $pc in hvf_unknown_hvc() trace event
  target/arm/hvf: Correct dtb_compatible value
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
  tests/functional/sbsa-ref: Move where machine type is set

 meson.build                              |  1 +
 accel/hvf/trace.h                        |  2 +
 include/qemu/accel.h                     |  3 +
 include/system/accel-ops.h               |  4 +-
 include/system/hvf.h                     |  3 +
 target/arm/cpu.h                         |  2 -
 target/arm/internals.h                   |  6 +-
 target/arm/tcg/translate.h               |  1 +
 accel/accel-common.c                     |  4 ++
 accel/accel-system.c                     |  3 +-
 accel/hvf/hvf-accel-ops.c                |  8 +++
 accel/tcg/tcg-accel-ops.c                |  4 +-
 hw/arm/sbsa-ref.c                        |  8 ++-
 hw/arm/virt.c                            |  9 +--
 target/arm/cpu.c                         | 71 ++++++++++++------------
 target/arm/hvf/hvf.c                     | 46 +++++++++++----
 target/arm/tcg/translate-a64.c           |  6 --
 target/arm/tcg/translate.c               |  2 +-
 target/i386/hvf/hvf.c                    |  5 ++
 accel/hvf/trace-events                   |  7 +++
 target/arm/hvf/trace-events              |  3 +-
 tests/functional/test_aarch64_sbsaref.py |  2 +-
 22 files changed, 129 insertions(+), 71 deletions(-)
 create mode 100644 accel/hvf/trace.h
 create mode 100644 accel/hvf/trace-events

-- 
2.49.0


