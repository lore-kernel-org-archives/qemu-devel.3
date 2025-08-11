Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ECAD6CA0EC4
	for <qemu-devel@archiver.kernel.org>; Mon, 11 Aug 2025 17:08:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ulVyi-0004jL-8g; Mon, 11 Aug 2025 13:06:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ulVyf-0004iv-2t
 for qemu-devel@nongnu.org; Mon, 11 Aug 2025 13:06:29 -0400
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ulVyV-0001jn-UE
 for qemu-devel@nongnu.org; Mon, 11 Aug 2025 13:06:28 -0400
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-3b794a013bcso3967421f8f.2
 for <qemu-devel@nongnu.org>; Mon, 11 Aug 2025 10:06:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1754931974; x=1755536774; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=Gct7C1Y1ZRB4jTTLIlstS8WuVX5u4p3QrSuPcz6V+Qw=;
 b=YOa5qwM/uGwbX2q5PDlegXRA27MVRAlTUps8789volzzOqmH9W3zMxJ4uafZAEoxmF
 jnziou1L86vh9Ew8Gjire2yE6+lMYjdmF+/xaykqV0MhIixvhWOk9Q453XSa0h/DYA0Z
 /6lRmbIxVkGDpIxwweVA84DT4et8SCsPQNlhs230Z0en8ibxuuxUkpfTRgLnl+qXJJM6
 nGBTPBM1uaGKNf2rJLBoDPdJgidzAjCkv67TxwSBBbhbkt1CyNU8Leq+doEH4OUbItTs
 ZaAaJx6ORCsmqZOP6W0vjThMGtmnk+qtVQkcSMWN10Yk7IG/ozSX9mR0tB/sgYL34t5a
 WfOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754931974; x=1755536774;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Gct7C1Y1ZRB4jTTLIlstS8WuVX5u4p3QrSuPcz6V+Qw=;
 b=ObwIfTL2MGj24FzY508mTdqemrbzlZVU09uKeNG0WzvsU/70wg/Q3WbeISBTa6SDeE
 q6R5wE78wSmZtwB38fWNATaiwZuuhEjcOpNKjjEvKYArwl7m9v1PTq1ckuZd1lhXQ5oB
 dAIqW7e4XU3czH6pjLN9h6gMXXWj9C8Bry+Vk5eWSireUfWbc/KUl319O7pMWWafOHVH
 FzVe9HLQqK7SaP+WGZpc+MgUWJZnp4+pQvvd52bBoDHodVrCtIt+LgvtFKT0I9g/4nBj
 6ircUKMs8y6XT1NbqNAx8rBixjqJP1yu5KD+SzXULVjJvUOhnAJ0gaVrs7/CgfpPIxnm
 Ez1w==
X-Gm-Message-State: AOJu0Ywsbn5/zzglKLrctWWStVkt4wBmbJoab1tBc/ebSGV14ULCufjC
 N0yJklgdAYCp8Cgt8Zd4CBOItHUmsxkAK+QCfhEENriUOFPwR7sepyctgJfWFZVI5bHR7qFseFI
 UYMWz
X-Gm-Gg: ASbGncuETX3QXSU0D49qX2RJD/ZqQ1O/+gjPf2nvrw3eYp7QyXsOrSsnePbwEPB3Ppw
 4ZwjOGRvU94jHftrrvwjZllwkIu8wf/J5IbOgVaxdme5oPgXs07E1DmS1lCnITApnAFo58eOUm9
 nAGncaKF/IuhjRA/Udm1Z6gRhD0rnHS5PiYkJj/HDibhY5qm3EUKDlyqleMDG1fdL67SekjeAVs
 q9Lt1f3I/yf7WjDhpZONASTtWI8smBxNBlKSGasXrsba2SH/bUYF9V+ZYroWfLBR0uChKHahgo8
 +hiVH2JRiTCTn3YK7lpfINT/bCcBs13Pu2vYYimOtn3stEyqAmsQC/Ov5eNnfeizpVs1GhecBLa
 Nrk9rMdPOvEGi3KsN2+h17VG0XZjHiWdogm0k5zj5CdkcEF2oaiAvElQlpcLiWe801rTGMkVK
X-Google-Smtp-Source: AGHT+IFxSRfqcB19VeCggmPRFwXZs8vukwQy0+SZAp+RMLZ5Gi+wPHMHtoSwlNvUFKTkhMS9MhdHQA==
X-Received: by 2002:a05:6000:2013:b0:3b7:8473:312c with SMTP id
 ffacd0b85a97d-3b9009068b3mr11290961f8f.0.1754931974313; 
 Mon, 11 Aug 2025 10:06:14 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b79c3ac574sm41205758f8f.5.2025.08.11.10.06.12
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 11 Aug 2025 10:06:13 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Miguel Luis <miguel.luis@oracle.com>,
 Richard Henderson <richard.henderson@linaro.org>, kvm@vger.kernel.org,
 Peter Maydell <peter.maydell@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Haibo Xu <haibo.xu@linaro.org>,
 Mohamed Mediouni <mohamed@unpredictable.fr>,
 Mark Burton <mburton@qti.qualcomm.com>, Alexander Graf <agraf@csgraf.de>,
 Claudio Fontana <cfontana@suse.de>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Mads Ynddal <mads@ynddal.dk>, Eric Auger <eric.auger@redhat.com>,
 qemu-arm@nongnu.org, Cameron Esfahani <dirty@apple.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [RFC PATCH 00/11] target/arm: Introduce host_cpu_feature_supported()
 API
Date: Mon, 11 Aug 2025 19:06:00 +0200
Message-ID: <20250811170611.37482-1-philmd@linaro.org>
X-Mailer: git-send-email 2.49.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::433;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x433.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, T_SPF_HELO_TEMPERROR=0.01,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

Mohamed and myself are working on adding nested virtualization
support to HVF Aarch64. Mohamed approach leverages the latest
hardware features of the Apple M3+ Silicon chips [1], while mine
falls back to emulation [2] when features are not available, as
it happens with the M1 and M2 chipsets.

We want to support both methods long term, as they solve different
use cases. Therefore I'm looking for a common API for methods
added in both series.

In this series we propose the host_cpu_feature_supported() method
to check if a feature is supported by the host, allowing fall back
to TCG. KVM uses are converted, and an example -- while not really
usable without other patch applied -- is provided for HVF.

Does this look reasonable enough to pursue in that direction?

Thanks,

Phil.

[1] https://lore.kernel.org/qemu-devel/20250808070137.48716-1-mohamed@unpredictable.fr/
[2] https://lore.kernel.org/qemu-devel/20250620172751.94231-1-philmd@linaro.org/

Mohamed Mediouni (2):
  target/arm: Factor hvf_psci_get_target_el() out
  target/arm/hvf: Sync registers used at EL2

Philippe Mathieu-Daudé (9):
  accel/system: Introduce hwaccel_enabled() helper
  target/arm: Use generic hwaccel_enabled() to check 'host' cpu type
  target/arm: Restrict PMU to system mode
  target/arm: Introduce arm_hw_accel_cpu_feature_supported()
  target/arm: Introduce host_cpu_feature_supported()
  target/arm: Replace kvm_arm_pmu_supported by
    host_cpu_feature_supported
  target/arm: Replace kvm_arm_el2_supported by
    host_cpu_feature_supported
  target/arm/hvf: Consider EL2 acceleration for Silicon M3+ chipsets
  target/arm/hvf: Allow EL2/EL3 emulation on Silicon M1 / M2

 include/system/hw_accel.h | 13 +++++++
 target/arm/cpu.h          | 23 +++++++++++++
 target/arm/kvm_arm.h      | 24 -------------
 hw/arm/virt.c             |  8 +----
 target/arm/arm-qmp-cmds.c |  5 +--
 target/arm/arm_hw_accel.c | 27 +++++++++++++++
 target/arm/cpu.c          | 14 ++++----
 target/arm/cpu64.c        | 11 +++---
 target/arm/hvf/hvf.c      | 71 +++++++++++++++++++++++++++++++++++++--
 target/arm/kvm-stub.c     | 10 ------
 target/arm/kvm.c          | 33 +++++++++++++-----
 target/arm/meson.build    |  2 +-
 12 files changed, 176 insertions(+), 65 deletions(-)
 create mode 100644 target/arm/arm_hw_accel.c

-- 
2.49.0


