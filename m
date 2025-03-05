Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 913A3C021B8
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Mar 2025 00:53:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tpczz-0001yA-Pf; Tue, 04 Mar 2025 19:52:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tpczx-0001xc-8A
 for qemu-devel@nongnu.org; Tue, 04 Mar 2025 19:52:33 -0500
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tpczv-0007Q9-55
 for qemu-devel@nongnu.org; Tue, 04 Mar 2025 19:52:32 -0500
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-43bc38bb6baso17009465e9.3
 for <qemu-devel@nongnu.org>; Tue, 04 Mar 2025 16:52:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741135948; x=1741740748; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=9cx41270KwV2RsvJaXRPp+qFCSNUAqq2qOHjSJJvwi0=;
 b=eGf+TXfeFZukIKX+A4fivp0kJ7VV0DpXt/v33sg47rwNjha9naaEvS3AbTVj0s31Mz
 0EIrVIPbIyTyfkTSBgT/O9430imvX50kK4aqSU1Gq9ZqcYrAbUFLX2kSpPdWoHYtR1CS
 VaqDkM5DwqUVsO4UKoxKDs7+LUZPvFRofTOrfOqgn+Ydlzk+tgaWmochJ2lTdTvkP5jx
 QT7KO3XkOOW7hogwjlfcZw6cacQsMbUNiL/lia6s2G74D/ag5rPjSja3Wi6ex50DTQLE
 0IRZ2LDjsTV1dUMbeiHdWog6479m7CTgrqwOmsPIeLRndJFUmBu91bwlySgxr3kbNJ2y
 /bRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741135948; x=1741740748;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=9cx41270KwV2RsvJaXRPp+qFCSNUAqq2qOHjSJJvwi0=;
 b=jdfOesi+vQny7ay0l+nU0AgoHqi9iwAfrbh/YjENdUqaRzD2NSHpW7vxV/Hs2f7S5B
 hf2TPEhYeBeg6zx8SnH7Xa+m7gKozGtkN2PsdGn8zo9gVNDaOKVYPv6nScgPogSwhcoR
 OJx5xx6t408ykgMgNmdo0ckHmp5CXkEQTCpnQ77yB2v7UhrycJasDQ07FMrrj9qAnFDq
 QiBcelv0fox00S/h5U/Y8fBVw+wjR5L5mx8gx2EsYF3RKl4XMQ1z7JVmbQcfLYKZMgn8
 SWR9Ns+q1QNaRYYu7qWUhwrBbiR0yC0ZxxNwhudC3tekwdLLtbvVF0C4Hp8p/L8FIiqf
 wK2Q==
X-Gm-Message-State: AOJu0YwM1UsLj4ffiuTM2oUyTfeTSfKt/xql2azAIEUtzykRGrbwnZiu
 FY9EA8ARIhmtmSNUL7B2Tkbvr+bTobykvD9v4B/iWLOshkX6xtxeimts7Jrm3IoqxeHGvNwFXMp
 uzls=
X-Gm-Gg: ASbGncsyVD8SsVn7fUZI2V3251BrxN94wv4dtZURkb11U4nVAp/wbNENkUkShaTrZoM
 6zX1XtClxKuf+nYZcPfoh0FJen36dOyU8y7Tnm0ZUEIZLQgRKpkIkGr1tqq35v1YebTQJN2YbkW
 kUOhM8umissTjqiBH1SmFYGJ/qdQDvyPhc8CMuOZyzXEO68AQ1BDlpYyrti5LNQrqIQ0YeZUcnS
 55QnHM6ObQzVivgIs+WAC8wa6j/C/vkN9+ON4T3OtIZzXFn/3lQJ18dADjj/nSH2RyjgGesFhJS
 V1XtaWTG/KirCaV62iFc+M4AH2hldo91RyucilHNvVLVK31hOUr+uX2OmBMD6pgRHTinKOsD+Uo
 IoUTapRsQX91ER4Skudw=
X-Google-Smtp-Source: AGHT+IEo720edrp++aFGTVzlJSAcmqBI9AGhStP/JHiBmJ8dEFczj6L0vPHQ/Po5qYhYfWg+4aOriw==
X-Received: by 2002:a05:6000:1565:b0:390:f6aa:4e72 with SMTP id
 ffacd0b85a97d-3911f740127mr652893f8f.18.1741135948381; 
 Tue, 04 Mar 2025 16:52:28 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-390e47b7a73sm19632623f8f.50.2025.03.04.16.52.26
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 04 Mar 2025 16:52:27 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [RFC PATCH 00/11] qemu: Remove TARGET_NAME definition
Date: Wed,  5 Mar 2025 01:52:14 +0100
Message-ID: <20250305005225.95051-1-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
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

Replace all TARGET_NAME uses by target_name() runtime,
then remove the definition and poison it.

While is looks like another cleanup, it is a small step
required for the single binary project.

Alex Bennée (1):
  plugins/loader: populate target_name with target_name()

Philippe Mathieu-Daudé (10):
  system: Extract target-specific globals to their own compilation unit
  system: Open-code qemu_init_arch_modules() using target_name()
  system: Introduce QemuArchBit enum
  system: Replace arch_type global by qemu_arch_available() helper
  include: Expose QemuArchBit enum to user emulation
  include: Declare target_name() in common "qemu/arch_info.h"
  tests/qtest: Replace TARGET_NAME -> target_name()
  user: Replace TARGET_NAME -> target_name()
  qemu: Introduce qemu_arch_name() helper
  qemu: Remove C definitions of TARGET_NAME

 meson.build                     | 10 +++--
 include/exec/poison.h           |  1 -
 include/hw/core/cpu.h           |  2 -
 include/qemu/arch_info.h        | 55 +++++++++++++++++++++++++++
 include/qemu/osdep.h            |  2 +
 include/system/arch_init.h      | 32 ----------------
 arch_info-target.c              | 67 +++++++++++++++++++++++++++++++++
 bsd-user/main.c                 |  9 +++--
 cpu-target.c                    |  5 ---
 hw/core/machine-qmp-cmds.c      |  1 +
 hw/scsi/scsi-disk.c             |  4 +-
 linux-user/main.c               | 12 +++---
 plugins/loader.c                |  3 +-
 system/arch_init.c              | 50 ------------------------
 system/globals-target.c         | 24 ++++++++++++
 system/qdev-monitor.c           |  6 +--
 system/vl.c                     | 14 ++++---
 tests/qtest/fuzz/fuzz.c         |  5 +--
 tests/qtest/fuzz/generic_fuzz.c |  4 +-
 tests/qtest/fuzz/i440fx_fuzz.c  |  5 ++-
 tests/qtest/fuzz/qos_fuzz.c     |  5 ++-
 system/meson.build              |  2 +-
 22 files changed, 195 insertions(+), 123 deletions(-)
 create mode 100644 include/qemu/arch_info.h
 delete mode 100644 include/system/arch_init.h
 create mode 100644 arch_info-target.c
 delete mode 100644 system/arch_init.c
 create mode 100644 system/globals-target.c

-- 
2.47.1


