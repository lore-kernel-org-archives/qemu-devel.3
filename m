Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78BD0CA0FF2
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Sep 2025 10:08:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1utkP8-0007xa-Gd; Wed, 03 Sep 2025 06:07:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1utkP6-0007tk-69
 for qemu-devel@nongnu.org; Wed, 03 Sep 2025 06:07:48 -0400
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1utkP4-00087G-5D
 for qemu-devel@nongnu.org; Wed, 03 Sep 2025 06:07:47 -0400
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-45b8b02dd14so20480145e9.1
 for <qemu-devel@nongnu.org>; Wed, 03 Sep 2025 03:07:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1756894062; x=1757498862; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=L/isQ/voCCrlwxjSgIKFU1t8iMBeSGrxTXbkNGx8ieU=;
 b=cM0zi/GJNKwcVIFg7B1wdIFhNKSVg0p+LGVIgBGyru1TBTz7JqxeVP8opZSlKxIDpl
 iDBihyBYJR6QSWMTdSrDbqIkb3lVBZ+C5Xgdgl2+s4Mvnvf8E4f+sCa7oqLvAj1YRFog
 GouDKpBXErLRPww54pVGxN8D2dvU5fd08CmXyUvFSCqXu/SF5Otlr4OhQSPYEplUkkpZ
 Jg46FrbHHdDUhDKWtAOtDPw2BgJrjkoun4Ruc/WaRo08y1GRmPwtkDSBA0t9mP4Ld7f1
 eovcx3CGypX3MZAoA3QXM6/nQTafm+B7+nr0APABTauCHTjQVr0Eyq3Wv3vM+m2o1Oju
 YZvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756894062; x=1757498862;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=L/isQ/voCCrlwxjSgIKFU1t8iMBeSGrxTXbkNGx8ieU=;
 b=Ce5M5KFI2q257qfNlhFshhquxGkgWbJEK0r0cune1kW2NY0fGV1qRSnKBxNpHQ+goL
 LJN5Z+C7Bqpw9M832rLBxNS2e2oy5QyxAOlL5Kib1WhWchZ+1ATr9RtycTdmJVVELs0Y
 5AiMrIq2WDT34WSXHaATL5cBGpOYXCTDHcBkROqnSdlajasnvLzh6mYycTMYFpWFq7Hw
 ejPUjQAG8VnnSOkNg2kIL8yHbKd9VWBkaZ/WXOuDcguYNfz2FFZ7Lc+z2v4VXiZtl7C6
 h17NESXvnsUpnLYreO/S7kqYAtT1ZOfxTMaJLJxhmXsZMXHAMUWYYL2DvcPMdb0FfsuH
 yj/w==
X-Gm-Message-State: AOJu0YwSq+NAaLWsZow1FrphtEQNQxhX7mkgfzN3muvz++geJgq1tevz
 ITZMlvylk3AVl3yecJKhn2+mpplO4vJ1kZZKxMV+5uEPxm3SqCwfcXm1ATfEfk5xrT5dycJx0nL
 4U/Mx5Rc=
X-Gm-Gg: ASbGncvJ7hbZHNlU2X3B7Bch9LHebYisEddlDWOtQDVAMnL2EN3RJkSe9YfW58g2hCX
 KxavcAMb0r/Ke3051UQtLhhPsOYHh4k3e5HeXLa91E6f5g+cvYrwfa7SNnBnIRPYjUFQl4/Z0Hn
 NCTkDMUuMCTF0GvTHCVOWCBIENunYdyVc78o2LIPl/r7DmtiIkx2rNMLtyGmOp9DPiMX2kx5qG8
 sHWFeKzu7kIxHEc0Q3JBqECssK13yhPikxinY3P9eOEKrlc7ScDXdjKR6FmqHF9SMPiaKL39bJ+
 ruRUjdUSNvh6bmDDmx/FF9g/fk4pivV0s+dl+z+hj0O8MUmcyhZcDj4A814ndlvMQCQynwG4fri
 wQRnLPgitwBBGD74RGpWoMqcpNVrn8n61+rQ3mAJ+gg7h48Mgutvi7TbRCwn9tdE5/gk+IVvD1u
 YAsW93Mw==
X-Google-Smtp-Source: AGHT+IE7xuuV6mXckXtucMGEJxPJpZlNxD1lvEByfXQc0ZZYKNjBf/pFEGH9NAS5gtbYeSloiUVanw==
X-Received: by 2002:a05:600c:3153:b0:458:a559:a693 with SMTP id
 5b1f17b1804b1-45b8557047amr122900305e9.18.1756894062008; 
 Wed, 03 Sep 2025 03:07:42 -0700 (PDT)
Received: from localhost.localdomain (98.red-88-29-180.dynamicip.rima-tde.net.
 [88.29.180.98]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-45b661d87a7sm188551125e9.2.2025.09.03.03.07.39
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 03 Sep 2025 03:07:41 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Alexander Graf <agraf@csgraf.de>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-arm@nongnu.org,
 Mohamed Mediouni <mohamed@unpredictable.fr>,
 Peter Maydell <peter.maydell@linaro.org>, Mads Ynddal <mads@ynddal.dk>,
 Phil Dennis-Jordan <phil@philjordan.eu>,
 Stefan Hajnoczi <stefanha@redhat.com>, Cameron Esfahani <dirty@apple.com>,
 Roman Bolshakov <rbolshakov@ddn.com>, Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH 00/24] target/arm/hvf: Consolidate
Date: Wed,  3 Sep 2025 12:06:36 +0200
Message-ID: <20250903100702.16726-1-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32f.google.com
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

- Fix a pair of memory leak
- Check a pair of return values
- Mention calls which must be run on vCPU thread
- Force MIDR
- Use hv_vcpu_config_create/hv_vcpu_config_get_feature_reg
  when not running on vCPU thread
- Factor hvf_handle_vmexit() / hvf_handle_exception(() out
- Call hv_vcpu_run() in loop
- Guard hv_vcpu_run() between cpu_exec_start/end()
- Restrict ARM specific in AccelCPUState

Based-on: <20250829152909.1589668-14-pbonzini@redhat.com>

Mohamed Mediouni (2):
  target/arm/hvf: Hardcode Apple MIDR
  target/arm/hvf: switch hvf_arm_get_host_cpu_features to not create a
    vCPU

Philippe Mathieu-Daudé (22):
  target/arm/hvf: Release memory allocated by hv_vcpu_config_create()
  target/arm/hvf: Check hv_vcpus_exit() returned value
  target/arm/hvf: Check hv_vcpu_set_vtimer_mask() returned value
  accel/hvf: Rename hvf_vcpu_exec() -> hvf_arch_vcpu_exec()
  accel/hvf: Rename hvf_put|get_registers -> hvf_arch_put|get_registers
  target/arm/hvf: Mention flush_cpu_state() must run on vCPU thread
  accel/hvf: Mention hvf_arch_init_vcpu() must run on vCPU thread
  target/arm/hvf: Mention hvf_wfi() must run on vCPU thread
  target/arm/hvf: Mention hvf_sync_vtimer() must run on vCPU thread
  target/arm/hvf: Mention hvf_arch_set_traps() must run on vCPU thread
  accel/hvf: Mention hvf_arch_update_guest_debug() must run on vCPU
  target/arm/hvf: Mention hvf_inject_interrupts() must run on vCPU
    thread
  accel/hvf: Implement hvf_arch_vcpu_destroy()
  target/arm/hvf: Factor hvf_handle_exception() out
  target/arm/hvf: Factor hvf_handle_vmexit() out
  target/arm/hvf: Keep calling hv_vcpu_run() in loop
  cpus: Trace cpu_exec_start() and cpu_exec_end() calls
  accel/hvf: Guard hv_vcpu_run() between cpu_exec_start/end() calls
  target/arm: Call aarch64_add_pauth_properties() once in host_initfn()
  accel/hvf: Restrict ARM specific fields of AccelCPUState
  target/arm: Rename init_cpreg_list() -> arm_init_cpreg_list()
  target/arm: Add arm_destroy_cpreg_list() helper

 include/system/hvf_int.h    |  23 ++--
 target/arm/internals.h      |   4 +-
 accel/hvf/hvf-accel-ops.c   |   4 +-
 cpu-common.c                |   3 +
 target/arm/cpu.c            |   2 +-
 target/arm/cpu64.c          |   8 +-
 target/arm/helper.c         |  10 +-
 target/arm/hvf/hvf.c        | 206 ++++++++++++++++++++++--------------
 target/i386/hvf/hvf.c       |   8 +-
 target/i386/hvf/x86hvf.c    |   4 +-
 target/arm/hvf/trace-events |   1 +
 trace-events                |   2 +
 12 files changed, 173 insertions(+), 102 deletions(-)

-- 
2.51.0


