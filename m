Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78A51C5DF9B
	for <qemu-devel@archiver.kernel.org>; Sat, 22 Aug 2026 16:55:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wxoze-0002b9-4a; Sat, 22 Aug 2026 12:54:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <163wangjack@gmail.com>)
 id 1wxozc-0002aN-Jk
 for qemu-devel@nongnu.org; Sat, 22 Aug 2026 12:54:52 -0400
Received: from mail-pl1-x62b.google.com ([2607:f8b0:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <163wangjack@gmail.com>)
 id 1wxoza-0006a0-7o
 for qemu-devel@nongnu.org; Sat, 22 Aug 2026 12:54:52 -0400
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-2cc7e86e7aeso27658895ad.2
 for <qemu-devel@nongnu.org>; Sat, 22 Aug 2026 09:54:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787417686; x=1788022486; darn=nongnu.org;
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=EC8TeC/W01d6N/D29gUhoqJqCJazFQ4XKTiy9pebG08=;
 b=fzWyDbRY1XvhFPMMN2Hmp/QMTjppbhA24Xb0BCy62pyLR6DLPjYzoITDXKOEDWxQpW
 uU7b5XwAGfEVx84eLEkpoCMqKQtcS+VK1dztkiiXZO+Qi9NERBCsj2pRUHeSkskjItAp
 +QkU88w7oJgcJKC5Z8wMRpkC2BgpOjOh25aYcHA6S/21VelnC6ZgNGmhjxWpt5LXLrnA
 Ud5YvnXpSwvShw3Y72IxlhkgENGCtiVuQ/cGWosVPFXtdg8gKDqV8zUZZFtFyBNi9p0h
 87EhfwpneTIZseGseAhhk46OIg0JrfMhiqp4Jz+DFQjJQFP/KaI+w4A9t/QbZCHuYWaP
 k5fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787417686; x=1788022486;
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=EC8TeC/W01d6N/D29gUhoqJqCJazFQ4XKTiy9pebG08=;
 b=pHDhEuNfzfDXOIfz4z3i9NqPhTuQEdxfp4NCEUmuo18Gd645WNg3d647QrvOsF73le
 /ImVTadPcMPUgOHdQBqvBbq7dHkwUDDETNgzlJ7PkjNDLS1gfrNfgU98wRjldFFT7DEf
 rcfCOG+uXr0bZFYUwymsoQ5rr1kZr5/lFrB582z4U/5dbF0lmTmKvOPscVy+csTgtg6g
 qyxmvnawKcUIKc584L3IJJzeRPKUja9OsXCZICoIFmE5gimd4pL4kz0y5w7q7lY4voeo
 s5KidjqT1JgZWjLGzj7WerW+SSTs9JtKvCKpgzbJ51N4X0qqJP2dBhz4IIc/TD5xllCc
 Da3A==
X-Gm-Message-State: AFuF++m27xR0E4+dYrYS+YipTqqg5AuM9mJ1NvGElENJAw6p9yuUUO+W
 bT00i/ItJ302G+gjq9JRzaq6oWcp/YSyl/Llj5IogIR+XfaaUO153NuH
X-Gm-Gg: AR+sD13YAH8T0k/8MOKV83YHJZI1AhBp9FobM1iaVtijEzSw+ZvYMy8VUneIgjmFCCD
 /Gxo5ZLSLpqxF/CL1e4RMzI1nghu3+Yld7E/JeZ3agOHxggCzMJT2OFctRcyLNkN4cUYE7Rc1bP
 pDHfNRThiPOibWhp84ETpRaDM+ls9nsOZGqFuapouuBJ/bfFuGp9hEX1u/Dxn59SJq/IVRZ3n7H
 ExUrlIvGUDGhZqPY/owMwfDNKXUls8e/dN1shzljaP3LIw+DebzDKUojwIuvdCiwUaRE21hPXdv
 t2b3l2I4mEWZ5w0oysA5rTMdfeL3CvfgcEu3pp2QPg06EPxPqiNUxl/09imOZae32PXLChbJEsE
 jhxhf3wqqeOYSFZwIb8Ck3b/Oev3boQpi5mMZWjeiPktHU2wmH+K6MbLDRxdJR8LNDjC9OgdCYS
 t40B4a8jJGiQEltMTyksHXLtN/GNiTx7Y/tCMz/My2Tdw4774oRCt145eam0Ktir1FMbHReBT9H
 ykKQ258l7RWI6NYTU0VJT9ooagFvq1vezh2hlhV/e98cQxZioZJ+/LQiWcTiyKmqQPvo5s=
X-Received: by 2002:a17:902:f70f:b0:2c9:8f4a:90b with SMTP id
 d9443c01a7336-2d64ada4464mr285387065ad.3.1787417686258; 
 Sat, 22 Aug 2026 09:54:46 -0700 (PDT)
Received: from
 1.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.ip6.arpa
 ([117.55.237.216]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-327f91d2d1esm8688456eec.17.2026.08.22.09.54.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 22 Aug 2026 09:54:45 -0700 (PDT)
From: Jack Wang <163wangjack@gmail.com>
Subject: [PATCH RFC v2 0/5] hw/gpio: STM32F1xx GPIO controller in Rust
Date: Sun, 23 Aug 2026 00:54:34 +0800
Message-Id: <20260823-stm32f100-gpio-v2-final-v2-0-02e31f589dd0@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yWMQQqDMBAAvyJ77kJcRWKvhT7Aq/Rg48ZuaaNkr
 RTEvzfV4wzMrKAchRXO2QqRF1EZQwI6ZeAeXRgYpU8MZKgylgh1fhfkc2NwmGTEhdBL6F5Y1c6
 Vts9tSTWkeors5bufW2iuF7gdUj/3J7v5/4Rt+wE+/5EZgAAAAA==
X-Change-ID: 20260822-stm32f100-gpio-v2-final-69cc48d18429
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-rust@nongnu.org, 
 Peter Maydell <peter.maydell@linaro.org>, 
 Alexandre Iooss <erdnaxe@crans.org>, 
 Alistair Francis <alistair@alistair23.me>, qemu-arm@nongnu.org, 
 Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3746; i=163wangjack@gmail.com; 
 h=from:subject:message-id;
 bh=GPKRi93Tmf1oFh6gkn8GuSHyqAY0VuW5AizLmvWGCPU=; 
 b=owEBiQJ2/ZANAwAIARVa4Yx0u1BNAcsmYgBqidRRdAEkAJRzF7q4zlc6SfANdA5XEU09ZO6l3
 xOt00ZYciSJAk8EAAEIADkWIQQlXkw4qdbVYyKFm20VWuGMdLtQTQUCaonUURsUgAAAAAAEAA5t
 YW51MiwyLjUrMS4xMiwwLDMACgkQFVrhjHS7UE2T3A/9EnOTYfazm7bFFVL0nUD2S6YM8b/BKim
 J9U/iKBh+QZruuQ5T+pi4sH1KaJO39AA4IDUJshVeXroSOiIbpPCAOYGzU6PHEEIlGjhLI5TWpF
 upfC4R2x8/Sfldqw0ouOX0g1nr5zZsbWRxvqUs/e1D798HtJMpR1wwQmKW7ENyaUyxlKkjrJCfT
 FLSWqAQ1r8vWDd4aeGrxrHSIoEdDM54KlzFgqHyX0xXwwMl/B7tSwyQMiBnhL1SeT53ZQkW/8zc
 KEj/OAA8Ox6tsiPjImvl7eKEhqU/DZ7opk2GHlyJm16CqQxj1+KDd+gQNH+Kq4dVXwqMInn/68G
 wN00hcptkIrTaj6AOAr+cf1gILj3LLJVjBHZe4zoebvFfgwkTJpNQEn9U4DLSJM6MnSzmKqpH7P
 yxIh3cPBGCMzYr7Trx7CxCLMrVBQyb8z8xMw0Solv7BjOxjAuzJOvmZoeXMXY54idlcSzimIkB6
 Q/ISd+F8w+myClVyheGdTNaFGz4jrm8NIWDIsG5W/OYrIeB67jyTGcj4A+iJxOoofhJRtEtAgBA
 BuJGz6hz6qdqaY3R4FHS14e90piy3kXOQ7zais9zAaR5kSGLLvqMOHXK6jt7qEhScLaEFrV/A3P
 /0JcQl6w4pGWhm68lNqzsedaINXp7z4Gkx5Sh2lbMGy0jQKtQUOE=
X-Developer-Key: i=163wangjack@gmail.com; a=openpgp;
 fpr=255E4C38A9D6D56322859B6D155AE18C74BB504D
Received-SPF: pass client-ip=2607:f8b0:4864:20::62b;
 envelope-from=163wangjack@gmail.com; helo=mail-pl1-x62b.google.com
X-Spam_score_int: -13
X-Spam_score: -1.4
X-Spam_bar: -
X-Spam_report: (-1.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 FROM_STARTS_WITH_NUMS=0.738, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Hi,

This is a minimal v2 of the STM32F1xx Rust GPIO series. 

The generic device implements the STM32F1 CRL/CRH configuration layout,
IDR/ODR and atomic BSRR/BRR updates. The register behavior is based on the
STM32F100xx RM0041 reference manual. This revision also restricts MMIO to
aligned 32-bit accesses and corrects analog-input, released open-drain,
alternate-function fallback and reset-output behavior.

The SoC patch instantiates GPIOA through GPIOE only. The address table has an
explicit STM32F100_NUM_GPIOS size. If the Rust type is unavailable, the same
five address windows retain their existing unimplemented-device fallback
instead of being left unbacked.

This remains a basic GPIO model. LCKR configuration locking,
AFIO/peripheral routing, EXTI interrupts, precise Hi-Z resolution and RCC
clock gating are not implemented. LCKR writes are ignored and read as zero,
and GPIO pins are not connected directly to the NVIC because external
interrupts are routed through EXTI.

Here is the datasheet I refered: https://embedded.fel.cvut.cz/sites/default
/files/procesory/STM32/en.CD00246267___RM0041_STM32F100_Reference_Manual.pdf 
 Most hardware behavoir according to General-purpose and alternate-function I/Os
(GPIOs and AFIOs) chapter

All qtest pass,both for c and rust. Rust/no-Rust ARM build successfully, checkpath
pass with 4 MAINTAINERA wanings do not change intentionally. 

Changes since v1:
- rebased the series directly onto upstream QEMU rather than the repository's
  out-of-tree STM32F103 commit;
- moved SoC integration and QTests to upstream STM32F100RBT6;
- instantiated GPIOA-E instead of GPIOA-G;
- gave the GPIO address table an explicit size;
- retained GPIO UNIMP regions in builds without Rust;
- changed the hardware reference from RM0008 to RM0041;
- updated the crate integration for QEMU's current root Cargo workspace and
  cargo_ws Meson interface;
- enforced aligned 32-bit register accesses;
- corrected analog input, released open-drain sampling, AF fallback and
  reset output deassertion;
- made unsupported LCKR writes read back as zero instead of suggesting that
  locking succeeded;
- retargeted the existing QTests and native tests and added focused
  regression cases for these changes;

Thanks,
Jack Wang

Signed-off-by: Jack Wang <163wangjack@gmail.com>
---
Jack Wang (5):
      hw/gpio: add STM32F1xx GPIO device model in Rust
      rust: add hw/gpio crate to the workspace
      hw/arm/stm32f100: instantiate and map GPIO ports
      tests/qtest: add STM32F100 GPIO tests
      rust/hw/gpio: add native unit tests

 Cargo.lock                        |  15 ++
 Cargo.toml                        |   1 +
 hw/arm/Kconfig                    |   1 +
 hw/arm/stm32f100_soc.c            |  35 ++-
 hw/gpio/Kconfig                   |   5 +
 hw/gpio/trace-events              |   7 +
 include/hw/arm/stm32f100_soc.h    |   2 +
 rust/hw/Kconfig                   |   1 +
 rust/hw/gpio/Cargo.toml           |  30 +++
 rust/hw/gpio/Kconfig              |   4 +
 rust/hw/gpio/meson.build          |  49 ++++
 rust/hw/gpio/src/bindings.rs      |  19 ++
 rust/hw/gpio/src/gpio.rs          | 491 ++++++++++++++++++++++++++++++++++++++
 rust/hw/gpio/src/lib.rs           |   3 +
 rust/hw/gpio/tests/tests.rs       | 216 +++++++++++++++++
 rust/hw/meson.build               |   1 +
 tests/qtest/meson.build           |   4 +
 tests/qtest/stm32f100_gpio-test.c | 380 +++++++++++++++++++++++++++++
 18 files changed, 1259 insertions(+), 5 deletions(-)
---
base-commit: eea8fe61b8be8f3016e522e6af24924a0266ca95
change-id: 20260822-stm32f100-gpio-v2-final-69cc48d18429

Best regards,
--  
Jack Wang <163wangjack@gmail.com>


