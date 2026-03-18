Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5FD0107BCF2
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Mar 2026 10:32:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w2oBY-0001Pw-RF; Wed, 18 Mar 2026 06:31:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1w2oBW-0001P8-6u
 for qemu-devel@nongnu.org; Wed, 18 Mar 2026 06:31:30 -0400
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1w2oBT-0001cp-4b
 for qemu-devel@nongnu.org; Wed, 18 Mar 2026 06:31:29 -0400
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-4853c3c2fe7so2874875e9.0
 for <qemu-devel@nongnu.org>; Wed, 18 Mar 2026 03:31:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1773829885; x=1774434685; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=o0UgZxtNhpkBR4HhcNIcCQzamc0QDL5ViISJ9NuRBEw=;
 b=g9OaNoPtJQhIJMLJmCmZSYKQGXU8Eg2k/BJW9qQ4rcy4oTwNJ4mlhj1DfU2lPrEtrz
 WErKp1TbRlyYm4J3XmXAQe4RXaz5E4zvxjqtNXzrqIRmCw+FtYdAlw34qjc6bpv+1QsE
 BEi+6WBWyUHzCALQY0W6/KHCAo/u3lv+/jdaXxFO0EDXAQDFmd1SHTfJ5AOHhKPzKaYz
 1KqVFxsKokwZWhOsrBxF5rBO5oadc1TqFtelNrXFtM1emqYWQ8x8r2nLclYVzUGeHR0l
 +6eUTaDV2v5JGqJEwt1holDCSLtr+DEWeCj2Z1S2JsnW/B4SDJUmGDhLZPD2MzrugpPQ
 RPaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773829885; x=1774434685;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=o0UgZxtNhpkBR4HhcNIcCQzamc0QDL5ViISJ9NuRBEw=;
 b=q5yYa4miMPxn7gzB7j7MlmbR17D4bvSj6zg43qpWv6qs1pxwJyn3u0/VEfoQdioHew
 2/VuIbTTVDevHELvrbeohzMIIlJHTjiqFu7RUsX7zpi5zpJct+K0TJQucuJdFWBJp5Ds
 ANMv57vjlsZNmUHN+brJClokwkgT/f0VZUPTqH1EVCai2Wyb+TDQeXK0oIci6HCZ4wIN
 B7MHdEscfwPoL9gD35JUypA91eSusGD4qeD5jr6dC4F/hBuyUuOm2UxHSzyc4IVs4oEo
 E1FDaOwF4xZITYKzk+TpxcMYsCYHKVhMni9V0hxvQIed3TTf6YuPjuDEe84bkNuTuwTH
 dJrA==
X-Gm-Message-State: AOJu0YxrQDFrPP23vpJOm+e3eIvfiXK563qrFQWclf5o63NBQn4rGMLV
 +XehuWOpIAsp3/ds2u+6McI++NXsK8qablaz9YnYNob/wxXC1hpG0XHdQklU+UzWoPZDXl/GAPp
 NFfk5J50=
X-Gm-Gg: ATEYQzxSNF0AS4YnmSzbFcJHNEEFVkBRpaBGWogbdDwgEbdmCkmeMtFDzYVtvOyOKYG
 jZ4CfLdAO0i/pfzdMhESnHsrzvpFWQDrhfBQrWXFTp5TWH0pSdld+tCQPPA9gGC2dyM2q8ms5Pi
 XO10Ofx2BAn28US9hPwpkZzr0E43t5h9ngSHSokdrmvFPR6PblT1meVQuRVYH4AtfBeXwNwgPfQ
 14N7fGL55BFcsmULwIAKZgvrqnFZE+iPfjAKkNxLkk8e52Tk8mmvnpXVKzz06ObFnYV/I8nwopc
 EofRc23YDAejZTLhF4dZvxTHGJnNy5allA9vB8p1P//PPq2Qq6kocTTkHDcptEpGP0R8cO8lboP
 T4x1aOMiRRtXCHSyi8X2aReuMhwsWiRyrANOHmaPcWX8HKIjREZ9PSu2Nk+VTnnK94vWAEc0TR/
 q3m9e/q/6IKEjx7y/Or3zyVp8pVLu1cJYk6qhALCE18DfodKPfdwGCKBCHeDIq7gho7oJ0mNYT
X-Received: by 2002:a05:600c:34cb:b0:485:3e00:9451 with SMTP id
 5b1f17b1804b1-486f444fcbbmr43252725e9.17.1773829884804; 
 Wed, 18 Mar 2026 03:31:24 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-486f443b77esm55165025e9.15.2026.03.18.03.31.23
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 18 Mar 2026 03:31:24 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Weiwei Li <liwei1518@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Warner Losh <imp@bsdimp.com>, =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20P=C3=A9trot?=
 <frederic.petrot@univ-grenoble-alpes.fr>, 
 Vijai Kumar K <vijai@behindbytes.com>, Anton Johansson <anjo@rev.ng>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>, qemu-riscv@nongnu.org,
 Alistair Francis <Alistair.Francis@wdc.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Alistair Francis <alistair.francis@wdc.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Djordje Todorovic <Djordje.Todorovic@htecgroup.com>
Subject: [PATCH-for-11.1 00/16] target/riscv: Forbid to use legacy native
 endianness API
Date: Wed, 18 Mar 2026 11:31:05 +0100
Message-ID: <20260318103122.97244-1-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32c.google.com
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

Thanks to Frédéric patch on 128-bit registers, we can now
remove all legacy native endianness API uses of RISC-V.

Djordje: You should (re)base your "Add RISC-V big-endian
target support" [*] series on this (after addressing the
review comments) before posting your v4.

[*] https://lore.kernel.org/qemu-devel/20260311115910.564481-1-djordje.todorovic@htecgroup.com/

Djordje Todorovic (1):
  target/riscv: Use MO_LE for instruction fetch

Frédéric Pétrot (2):
  target/riscv: Make LQ and SQ use 128-bit ld/st
  target/riscv: Remove MTTCG check for x-rv128 CPU model

Philippe Mathieu-Daudé (13):
  hw/riscv: Mark RISC-V specific peripherals as little-endian
  target/riscv: Use explicit little-endian LD/ST API
  target/riscv: Explode MO_TExx -> MO_TE | MO_xx (again)
  target/riscv: Conceal MO_ALIGN|MO_TE within load_acquire /
    store_release
  target/riscv: Factor tiny ldn() helper in gdbstub
  target/riscv: Simplify riscv_cpu_gdb_write_register()
  target/riscv: Expose mo_endian_env()
  target/riscv: Have gdbstub consider CPU endianness
  target/riscv: Replace MO_TE by mo_endian (MIPS extension)
  target/riscv: Replace MO_TE by mo_endian (Zilsd extension)
  target/riscv: Replace MO_TE by mo_endian (Zalasr extension)
  target/riscv: Replace MO_TE -> MO_LE
  configs/targets: Forbid RISC-V to use legacy native endianness APIs

 configs/targets/riscv32-linux-user.mak       |  1 +
 configs/targets/riscv32-softmmu.mak          |  1 +
 configs/targets/riscv64-bsd-user.mak         |  1 +
 configs/targets/riscv64-linux-user.mak       |  1 +
 configs/targets/riscv64-softmmu.mak          |  1 +
 target/riscv/internals.h                     | 12 ++++++
 hw/char/ibex_uart.c                          |  2 +-
 hw/char/shakti_uart.c                        |  2 +-
 hw/char/sifive_uart.c                        |  2 +-
 hw/misc/sifive_e_aon.c                       |  2 +-
 hw/misc/sifive_e_prci.c                      |  2 +-
 hw/misc/sifive_u_otp.c                       |  2 +-
 hw/misc/sifive_u_prci.c                      |  2 +-
 hw/riscv/riscv-iommu.c                       |  2 +-
 hw/sd/cadence_sdhci.c                        |  2 +-
 hw/timer/ibex_timer.c                        |  2 +-
 hw/timer/sifive_pwm.c                        |  2 +-
 target/riscv/cpu_helper.c                    |  4 +-
 target/riscv/gdbstub.c                       | 42 ++++++++------------
 target/riscv/op_helper.c                     | 14 -------
 target/riscv/tcg/tcg-cpu.c                   | 10 -----
 target/riscv/translate.c                     | 10 ++---
 target/riscv/insn_trans/trans_rvi.c.inc      | 32 +++++++++++----
 target/riscv/insn_trans/trans_rvzalasr.c.inc | 18 +++++----
 target/riscv/insn_trans/trans_xmips.c.inc    | 24 +++++++----
 target/riscv/insn_trans/trans_zilsd.c.inc    |  4 +-
 26 files changed, 104 insertions(+), 93 deletions(-)

-- 
2.53.0


