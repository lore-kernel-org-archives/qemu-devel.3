Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D170C36014
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Apr 2025 23:51:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u0UJP-0000b8-DR; Thu, 03 Apr 2025 19:49:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u0UJN-0000ar-3o
 for qemu-devel@nongnu.org; Thu, 03 Apr 2025 19:49:29 -0400
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u0UJH-0000P3-5I
 for qemu-devel@nongnu.org; Thu, 03 Apr 2025 19:49:24 -0400
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-39c266c1389so993645f8f.1
 for <qemu-devel@nongnu.org>; Thu, 03 Apr 2025 16:49:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1743724159; x=1744328959; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=Zi6xCCOKToJ81JFzAN6pttjWdXmk4enmEEr52kCZ6B8=;
 b=cdnnu8oI0WOHZeEUi8oZSSPsHLN2kSyaFwKrUqj8b8FzQRJnVBSC5AQTkaBvy4MY0w
 RMGgiZjNELX5zu5qL/HUjUb6nAynSJlOZ/juCriamC2xbIqBXKA5FvSRWtSFKDM2hTEh
 klhaVD3uNmGdb/hWDQ0LZPz3A33bncX5dU8oc7qooRbm2hb8iVtfCz2SfqJ8JSydCiI5
 IKtU7JaeI3WS+dfLgRCXqxOI8gwm1Egcbyxs6Gw0jmUdOdXiDTANhOgvXEIgNcjYpzoB
 deuVG56nT74ymF0c102YDuRvM90+oGahgL+YtdsfkI1NivLQbDxCRMVot0TKbU6aXyrl
 7EeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743724159; x=1744328959;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Zi6xCCOKToJ81JFzAN6pttjWdXmk4enmEEr52kCZ6B8=;
 b=aauCUlfjkqsoydySjLLNmELBwxGusPekHfBoqrjHTmCYkkPzI405Rl4/jHrT1MlrQq
 8HeTHISQpnTaMuQ5xN6U8caDwDjIJQmO9R3wprGUX7YT+cGw/T5IPK/koyRTTd2yiDB+
 Kwi78u699XIYkHPq7ePcfdTLWmxJm12x8UBh5Ly645Ruy6uMoizhW3rk/bgbASf7wteb
 yCtTctFcUi/iobCe+tav9TYkLHvJz8I7AXnfaSvp8ukia2oo3NRCIDj/EI6ceisQkCzN
 tUL4D5vjKlasHT7hnnSzOY2GsT72IfszUw1gDgHoffMC70D8vjh6sK8PnXllY/AtqVRT
 Fmsw==
X-Gm-Message-State: AOJu0Yx1lS5mSvQ188R16uiHpPaXCAdTlaQDlFhY5OHHY38UYW8isApx
 x/jdMi8KLQ3GiAXGr6RqxS0sYNxLXxebOi5Giw7F2d0jL0caNtQv/6b35Gvptdwzc9U+lyvPmnn
 1
X-Gm-Gg: ASbGncu+bpw+wRbWuzG5TmW9uizmiei6DDNYORMYweg8Z8HcvC3zOP8oeI9NdgvV5NJ
 IrUxADaGviOzKAGW8RKTU+NfJCiqv/oOExUBTh2/Axo3BBKn0uxQn2pWk+qwVGIStvqbCrGxYuz
 BHqGqi+1INrHzXZrR3JsL77g25X7MbRYHNvkdqZZSmArmqjiUCh/S54hfGmvpP+8THxmuBcnE/3
 7+fn15iyjfQDDwphCBNhN/1wlxgLbaE2g1mR7aCp1IXZaIk8N5v0SUd7FiCzcWTiIYhS0IhaQtg
 SfIXvfSVsMErQJULgffi3jQHhe/fD1mJAtpPu/HaMh6X4wHpCvnmt1QyHeCbNTKfBSN/8zxbBEF
 uUpCo0jDXxZlQfcsj8Hk=
X-Google-Smtp-Source: AGHT+IFW25vS4gfqLoQa50HWR4bw9ydMOC1xOlkeguBGapH6sKvxCFssorww662HMYPVemMBRJguEw==
X-Received: by 2002:a05:6000:250a:b0:391:2dea:c984 with SMTP id
 ffacd0b85a97d-39d07db55b9mr507516f8f.11.1743724159297; 
 Thu, 03 Apr 2025 16:49:19 -0700 (PDT)
Received: from localhost.localdomain (184.170.88.92.rev.sfr.net.
 [92.88.170.184]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-39c3020d938sm2971469f8f.65.2025.04.03.16.49.16
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 03 Apr 2025 16:49:17 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Markus Armbruster <armbru@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [RFC PATCH-for-10.1 00/19] qemu: Introduce TargetInfo API (for single
 binary)
Date: Fri,  4 Apr 2025 01:48:55 +0200
Message-ID: <20250403234914.9154-1-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42c;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42c.google.com
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

Hi,

At this point this series is mostly a draft for Pierrick.
It implement his idea of a per-binary structure containing
all target-specific information, exposing them via a
target-agnostic API. Commits are barely commented, since
I'd rather get feedback before pursuing further.

Available here, based on tcg-next:
https://gitlab.com/philmd/qemu/-/tags/single-binary-target-info-api-rfc-v1

Another series will follow with the ARM implementation.

Regards,

Phil.

Philippe Mathieu-Daudé (19):
  qemu: Introduce TargetInfo API in 'target_info.h'
  qemu: Convert target_name() to TargetInfo API
  qemu: Factor target_system_arch() out
  qemu: Convert target_words_bigendian() to TargetInfo API
  qemu: Introduce target_long_bits()
  target/tricore: Replace TARGET_LONG_BITS -> target_long_bits()
  target/hppa: Replace TARGET_LONG_BITS -> target_long_bits()
  target/riscv: Replace TARGET_LONG_BITS -> target_long_bits()
  qemu: Introduce target_cpu_type()
  cpus: Replace CPU_RESOLVING_TYPE -> target_cpu_type()
  accel/tcg: Replace CPU_RESOLVING_TYPE -> target_cpu_type()
  cpus: Move target-agnostic methods out of cpu-target.c
  accel: Replace CPU_RESOLVING_TYPE -> target_cpu_type()
  accel: Implement accel_init_ops_interfaces() for both system/user mode
  accel: Include missing 'qemu/accel.h' header in accel-internal.h
  accel: Make AccelCPUClass structure target-agnostic
  accel: Move target-agnostic code from accel-target.c -> accel-common.c
  qemu: Prepare per-binary QOM filter via TYPE_BINARY_PREFIX
  system/vl: Filter machine list for binary using
    machine_binary_filter()

 meson.build                                |  10 ++
 accel/{accel-system.h => accel-internal.h} |  10 +-
 include/accel/accel-cpu-target.h           |  12 +-
 include/accel/accel-cpu.h                  |  23 ++++
 include/exec/poison.h                      |   1 +
 include/exec/tswap.h                       |  13 +-
 include/hw/boards.h                        |   1 +
 include/hw/core/cpu.h                      |   2 -
 include/qemu/target_info-impl.h            |  38 ++++++
 include/qemu/target_info-qom.h             |  14 ++
 include/qemu/target_info.h                 |  39 ++++++
 accel/accel-common.c                       | 142 +++++++++++++++++++++
 accel/accel-system.c                       |   4 +-
 accel/accel-target.c                       | 134 -------------------
 accel/accel-user.c                         |   6 +
 accel/tcg/tcg-all.c                        |   4 +-
 cpu-target.c                               |  88 +------------
 hw/core/cpu-common.c                       |  74 +++++++++++
 hw/core/cpu-system.c                       |   2 +-
 hw/core/machine-qmp-cmds.c                 |   7 +-
 hw/display/vga.c                           |   2 +-
 hw/riscv/riscv-iommu.c                     |   3 +-
 hw/riscv/riscv_hart.c                      |   3 +-
 hw/virtio/virtio.c                         |   2 +-
 plugins/loader.c                           |   2 +-
 system/qtest.c                             |   1 +
 system/vl.c                                |  26 +++-
 target/hppa/mem_helper.c                   |   3 +-
 target/hppa/translate.c                    |   3 +-
 target/tricore/translate.c                 |   6 +-
 target_info-qom.c                          |  15 +++
 target_info-stub.c                         |  29 +++++
 target_info.c                              |  48 +++++++
 accel/meson.build                          |   1 +
 34 files changed, 499 insertions(+), 269 deletions(-)
 rename accel/{accel-system.h => accel-internal.h} (56%)
 create mode 100644 include/accel/accel-cpu.h
 create mode 100644 include/qemu/target_info-impl.h
 create mode 100644 include/qemu/target_info-qom.h
 create mode 100644 include/qemu/target_info.h
 create mode 100644 accel/accel-common.c
 create mode 100644 target_info-qom.c
 create mode 100644 target_info-stub.c
 create mode 100644 target_info.c

-- 
2.47.1


