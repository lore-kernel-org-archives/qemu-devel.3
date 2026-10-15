Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A6FCCC6B33
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Oct 2026 18:11:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xHPvD-0000i9-Mc; Thu, 15 Oct 2026 14:11:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcelomanzo@gmail.com>)
 id 1xHPvB-0000fm-Am
 for qemu-devel@nongnu.org; Thu, 15 Oct 2026 14:11:17 -0400
Received: from mail-qv1-xf2b.google.com ([2607:f8b0:4864:20::f2b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcelomanzo@gmail.com>)
 id 1xHPv9-0001NI-5u
 for qemu-devel@nongnu.org; Thu, 15 Oct 2026 14:11:16 -0400
Received: by mail-qv1-xf2b.google.com with SMTP id
 6a1803df08f44-91b834592afso46779756d6.0
 for <qemu-devel@nongnu.org>; Thu, 15 Oct 2026 11:11:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792087874; x=1792692674; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=2PceX3qsOiDXQLmud9eRsNiV1Uv8rBOK84CEGuehFb8=;
 b=hWfD6nuWF1pUe7SacwVn0jKxnkZ/hLPnRcq38PNUDaLmvSOnZQglclKscQVBzJJtYg
 pOnsL2jPR94CfO1/9R4XoxqZrXBdQ3yPjZGZYxWN+ibwob74CjnpkpzEGFknC3AY7atK
 XCZon7HexjowoEbnDvWdsNHFvl99/avmlcd0ItxznKHJVdkA5MZpuC5F9x0h4Qq/I0k9
 +PuSaTi8v/jO/IPSmhR4A9B8sder/Ooq7suQDznnREukhveB/BKezNks20s0g3oOho4i
 5Tdeoye6DWyfSNaDDwrFg+vVz8F8V0fnNLMEq7hrXihdOCbTkXvSaU0SwDu7LmH2BRWR
 ZWVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792087874; x=1792692674;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=2PceX3qsOiDXQLmud9eRsNiV1Uv8rBOK84CEGuehFb8=;
 b=jONXp4aexmXkThiLOAQ/FaqR6d2RyFC27NurxJshK3eqjMogVKO8ZcXsqgKlxu6/66
 fiAvw7Z2VaZw30A3G8kv2g4o+YTP78trveRYTIAN/J+VN+sdjases+qZAYwSwx5/3wEV
 mLfCEZLWmUSV8gQKIjTdOkHxiMAhE2Y7xFpYeXxijeK0d1WIo2Nxbi+NFBUoM+DvF2Kr
 szw1OQIu0PZpHn0uWRPRg+y12ozc1XvVmCZbViVqSCz/1RaiFYLHYSj5CbFI3Onuf2AL
 cR6GykrRddT2EUgLIi3Zmo3mKxKtbFGPKUFQ0hzYE9HflRCN1lJzht8Y8jJGHbrsd0LT
 AGyg==
X-Gm-Message-State: AFq9FYLvnB5sB6FXXMeFgxNg35XeBvhsIwjCm9JbGVaN5qcHmsntMr5Y
 AEXI+zTnb9MrAUhQnlpoo9iEHuRmrwzOHgOgHZCV3S0j6kBYimqO3iVD2Jqi7rAc
X-Gm-Gg: AYBFou13v/0qiecnbBahM53o5lKqY6U5sd9962gzsp/WpI8KYbzppZqoPS1Yyrgr3sL
 yo/0KVule5R4dG7bkX2h5BDF6wygwY8+A86veazgP4PI4vlvQkZxVAc0OeHMOqB/6QZCp6nYzHz
 D07fL7ROrAKRrUp4Gb9XIHU1Tsj7/3W+Gf/DHzOnGDgqczjmYqA8B7DnaF1ZB1E2GAQJ7IykesE
 5ZeUBiweLSZzT8+DGG/Bq1H6y8qTg8bC9YNMRstrQBkH3x7Jh/5t2axfqtpo0+f7vKa0uh91YGF
 /6k0iYknrA+zFWaPfcLua7wn8BnPZMScUBXlQVo+JNGwcBBRYjbuaEdbpvndnqJ8uJ19kDIawb7
 JlY4oOF8dgpWtvrdh6z+EKnsQc5CmOy3qXKAYq0MZ8o0qvIyXQxGsrgKwLdMwgmQ8aJHel3gmgz
 4aL0lTRemoXnAW4UnxdhqXjagGCTQ0BNvqbO1IMlvwenV/N/UQ26gKTsdprL/MJ7xicPLAj5SEj
 GKz2Ig2qTMdy6RP55VE1uzdoNLjAwb/l+NDUljTyRI8R6bjIGnv6/NkqYmuqBEvZoHblw==
X-Received: by 2002:a05:6214:c4b:b0:919:51e9:8f16 with SMTP id
 6a1803df08f44-91b55806079mr387378426d6.32.1792087873441; 
 Thu, 15 Oct 2026 11:11:13 -0700 (PDT)
Received: from localhost.localdomain ([2606:6d00:159:2900:919:5388:4e10:5949])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-91bcba45dffsm1816206d6.12.2026.10.15.11.11.12
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 15 Oct 2026 11:11:12 -0700 (PDT)
From: Marcelo Manzo <marcelomanzo@gmail.com>
To: qemu-devel@nongnu.org,
	qemu-arm@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Marcelo Manzo <marcelomanzo@gmail.com>
Subject: [PATCH v2 0/5] hw/arm/raspi4b: RNG200 and thermal sensor
Date: Thu, 15 Oct 2026 14:11:06 -0400
Message-ID: <20261015181111.60491-1-marcelomanzo@gmail.com>
X-Mailer: git-send-email 2.55.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::f2b;
 envelope-from=marcelomanzo@gmail.com; helo=mail-qv1-xf2b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

This series adds the BCM2711 RNG200 hardware random number generator
and the dummy thermal sensor to raspi4b, carrying forward two more
patches from Sergey Kambalin's stalled Raspberry Pi 4B series
(patchwork series 829638). Patches 1 and 3 are Kambalin's code with
his authorship and Signed-off-by kept, adapted only for API drift
since 2024; patches 2 and 4 wire the devices into the SoC, and patch
5 extends the existing functional test.

v2: thanks to Peter for the review. Now based directly on current
master -- v1 was written on top of the "working PCIe and GENET" series
and so did not apply to master; it no longer depends on that series.

  - Patch 1: use VMSTATE_UINT32_ARRAY(), open-code the one-use
    increment_bit_counter_by() helper, stop aligning the format
    strings in trace-events, and drop the unneeded <stdbool.h>
    include from the header.
  - Patch 4: since the PCIe and GENET entries are no longer removed
    by an earlier patch in this series, this now only drops the
    "brcm,bcm2711-thermal" entry from nodes_to_remove[] rather than
    removing the whole mechanism; the commit message is updated to
    match. (The "working PCIe and GENET" series will drop the
    remaining entries.) Peter's Reviewed-by is kept, as the change is
    a strict subset of what he reviewed -- please say if you'd rather
    I dropped it.
  - Patch 5: fold the RNG200/thermal checks into the existing
    test_arm_raspi4_initrd test instead of adding a test that boots
    the same kernel again, as suggested.
  - Added Peter's Reviewed-by to patches 2, 3 and 4.
  - Rebased on current master (7e8d3c7fc4).

This conflicts trivially (three files: raspi4b.c and
bcm2838_peripherals.[ch]) with the "working PCIe and GENET" series
("[PATCH v3 00/16] hw/arm/raspi4b: working PCIe and GENET (real
networking)"), which is posted separately. Whichever lands second, I
will rebase.

Tested: checkpatch.pl reports no errors, the series builds on current
master, tests/functional/aarch64/test_raspi4.py passes, and a
Raspberry Pi OS Bullseye image boots to a login prompt with
"iproc-rng200 fe104000.rng: hwrng registered" in the kernel log.

Marcelo Manzo (3):
  hw/arm/bcm2838: enable BCM2838 RNG200
  hw/arm/bcm2838: enable BCM2838 thermal sensor
  tests/functional/aarch64: add raspi4b RNG200/thermal test

Sergey Kambalin (2):
  hw/misc/bcm2838_rng200: add BCM2838 RNG200
  hw/misc/bcm2838_thermal: add BCM2838 thermal sensor

 hw/arm/bcm2838.c                        |   4 +
 hw/arm/bcm2838_peripherals.c            |  28 ++
 hw/arm/raspi4b.c                        |   2 -
 hw/misc/bcm2838_rng200.c                | 400 ++++++++++++++++++++++++
 hw/misc/bcm2838_thermal.c               |  98 ++++++
 hw/misc/meson.build                     |   2 +
 hw/misc/trace-events                    |  10 +
 include/hw/arm/bcm2838_peripherals.h    |   4 +
 include/hw/misc/bcm2838_rng200.h        |  41 +++
 include/hw/misc/bcm2838_thermal.h       |  23 ++
 tests/functional/aarch64/test_raspi4.py |   7 +
 11 files changed, 617 insertions(+), 2 deletions(-)
 create mode 100644 hw/misc/bcm2838_rng200.c
 create mode 100644 hw/misc/bcm2838_thermal.c
 create mode 100644 include/hw/misc/bcm2838_rng200.h
 create mode 100644 include/hw/misc/bcm2838_thermal.h

-- 
2.55.0


