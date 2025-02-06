Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB3F3C02196
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2025 13:11:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tg1el-0004wh-TF; Thu, 06 Feb 2025 08:10:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tg1ek-0004wJ-MG
 for qemu-devel@nongnu.org; Thu, 06 Feb 2025 08:10:58 -0500
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tg1ei-0007yG-O0
 for qemu-devel@nongnu.org; Thu, 06 Feb 2025 08:10:58 -0500
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-436ce2ab251so5629675e9.1
 for <qemu-devel@nongnu.org>; Thu, 06 Feb 2025 05:10:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1738847454; x=1739452254; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=t0eCy2qAoBF+tEzq5kvSEJuyAxl19c06q6TagswS6A0=;
 b=PovJKKCCUkw+aoWYljhWnSTyfgmAac0vjRrar3RA5//eQ3F7SYZgnR0sPmaZiol+Tx
 3biOhlUhGyt7WabQvwkiYr4gVa6FfoEjqID+QSW0nL7ra+5KK5Wx/D0QVe/UwYzPUOzn
 az3d8UePGXJxNMXx4PJ1PcXA2jxFd4w5PIsL+KdI9gG5f0AMzb8bNQokhKZtQr1426W3
 dAhrhySIZPvAT9GIURvg82+Q0MZSDSxinKNg+rjFCx31d61wmm5BfogTGdiygEdxmewR
 xlsgcC8SL8S5H2Xuy69xbEhVFEWXJqDJBCQuGP0MDhBhXEhaIDKAZrFIwFFdioT15ZwA
 bfkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738847454; x=1739452254;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=t0eCy2qAoBF+tEzq5kvSEJuyAxl19c06q6TagswS6A0=;
 b=HK4vhwrpY7ZLiWsgKDYTDV9OPR3hCyIpQERz7VNo8D2rwRyvA+ejaGPdnHtYldv4uJ
 cwWEqdTG5ogfBv5n9FrhXbUUMVgu3y76q8fgHLuqdN/mN4MvvX1eXf98rNWN78jmvKL4
 D2SNF9uQS54hdbYaRY8KeE0hhFqt9ayCCAEDB+vD1+PAstmTznFPJaJy0b+EBbm77TpA
 uFvFoIQGsb31AKBSJU7UL4lezn1nRUs4sLNjnaKpDXuTxUhv8ucHMi60wgVX5vm30Rzu
 A9wH29wepmp7mg2mlBhAzqm7+YOnTrgjmdAXZL8FImDhXVc6swnUqNXa2K3VswsIlC7Q
 t5Jw==
X-Gm-Message-State: AOJu0Yyakv2MXH52C7RuAzn5JrdCWHL3pKFjAHPNJr7dXF85olvKpq1y
 Daqzp4ds3VhmDEQGE2OW2iD84E7WcdP+3A+O748oiIr8R23CLb8ce2yR+rbDfp93+tKzDpEnlGz
 xX/I=
X-Gm-Gg: ASbGncs3ZPBbdPNZKQCHWZBFT2jgYmbZs5Gp3sQcb0pjvtxHzSx2++OjzxKhmGIHtHP
 JxLwaCqnwNYnysEz766MyJ9JJrsPibylk7lPva98FLS7/pj5+bFULRFgkLg64AinxA9UvAQD4UH
 JOjAEQCbP2lWSDB1GtwgaxW1bMKsWkRrdrIeKPaQu6imvCE6j7PhXjh39gbt6au2LvJlEDsikse
 Izd+h9wZkTqsyawDVwURq3xdHuy555nsu71JE3cnMS0GQgPGWdQn2ZXENQDWis5QIAQEqW0SXLO
 q7Hve26DcETu4+K9wFqbVUe6Nc4u+o69OQm5l3/lTaFu8Dkh12efM8YKGtlkwA3hUg==
X-Google-Smtp-Source: AGHT+IFkPXWfPknCP+WUlIDsvXdAvVL+ia+HTcB6Qul8KdXOa1GgHensTaliFButOx4ct0+wa9ZCSw==
X-Received: by 2002:a05:600c:3c8f:b0:438:e231:d35e with SMTP id
 5b1f17b1804b1-4390d34d20cmr59737805e9.0.1738847454417; 
 Thu, 06 Feb 2025 05:10:54 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4390d9334e7sm54581605e9.6.2025.02.06.05.10.53
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 06 Feb 2025 05:10:53 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, Anton Johansson <anjo@rev.ng>,
 Jason Wang <jasowang@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Alistair Francis <alistair@alistair23.me>, Thomas Huth <thuth@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v5 00/16] hw/microblaze: Allow running cross-endian vCPUs
Date: Thu,  6 Feb 2025 14:10:36 +0100
Message-ID: <20250206131052.30207-1-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x336.google.com
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

Missing review: 2 & 14 (new)

Since v4 & v3:
- Addressed Thomas review comments

Since v2:
- Addressed Richard's review comments

Since v1:
- Make device endianness configurable (Edgar)
- Convert more Xilinx devices
- Avoid preprocessor #if (Richard)
- Add R-b tags

Make machines endianness-agnostic, allowing to run a big-endian vCPU
on the little-endian 'qemu-system-microblazeel' binary, and a little
endian one on the big-endian 'qemu-system-microblaze' binary.

Tests added, following combinations covered:
- little-endian vCPU using little-endian binary (in-tree)
- little-endian vCPU using big-endian binary (new)
- big-endian vCPU using little-endian binary (new)
- big-endian vCPU using big-endian binary (in-tree)

To make a target endian-agnostic we need to remove the MO_TE uses.
In order to do that, we propagate the MemOp from earlier in the
call stack, or we extract it from the vCPU env (on MicroBlaze the
CPU endianness is exposed by the 'ENDI' bit).

Next step: Look at unifying binaries.

Please review,

Phil.

Philippe Mathieu-Daudé (16):
  hw/intc/xilinx_intc: Make device endianness configurable
  hw/net/xilinx_ethlite: Make device endianness configurable
  hw/timer/xilinx_timer: Make device endianness configurable
  hw/char/xilinx_uartlite: Make device endianness configurable
  hw/ssi/xilinx_spi: Make device endianness configurable
  hw/arm/xlnx-zynqmp: Use &error_abort for programming errors
  target/microblaze: Explode MO_TExx -> MO_TE | MO_xx
  target/microblaze: Set MO_TE once in do_load() / do_store()
  target/microblaze: Introduce mo_endian() helper
  target/microblaze: Consider endianness while translating code
  hw/microblaze: Support various endianness for s3adsp1800 machines
  tests/functional: Explicit endianness of microblaze assets
  tests/functional: Allow microblaze tests to take a machine name
    argument
  tests/functional: Remove sleep() kludges from microblaze tests
  tests/functional: Have microblaze tests inherit common parent class
  tests/functional: Run cross-endian microblaze tests

 target/microblaze/cpu.h                       |  7 +++
 hw/arm/xlnx-zynqmp.c                          | 38 ++++--------
 hw/char/xilinx_uartlite.c                     | 27 +++++----
 hw/intc/xilinx_intc.c                         | 52 ++++++++++++-----
 hw/microblaze/petalogix_ml605_mmu.c           |  3 +
 hw/microblaze/petalogix_s3adsp1800_mmu.c      | 58 ++++++++++++++++---
 hw/net/xilinx_ethlite.c                       | 20 +++++--
 hw/ppc/virtex_ml507.c                         |  1 +
 hw/ssi/xilinx_spi.c                           | 24 +++++---
 hw/timer/xilinx_timer.c                       | 35 ++++++-----
 target/microblaze/translate.c                 | 49 ++++++++++------
 .../functional/test_microblaze_s3adsp1800.py  | 40 +++++++++++--
 .../test_microblazeel_s3adsp1800.py           | 34 +++--------
 13 files changed, 254 insertions(+), 134 deletions(-)

-- 
2.47.1


