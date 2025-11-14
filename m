Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C6F2CE8D46
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Nov 2025 15:27:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vJvhh-0003In-GB; Fri, 14 Nov 2025 10:27:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vJvbw-00065E-74
 for qemu-devel@nongnu.org; Fri, 14 Nov 2025 10:21:16 -0500
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vJvbu-0003tC-9o
 for qemu-devel@nongnu.org; Fri, 14 Nov 2025 10:21:15 -0500
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-4775ae77516so23589615e9.1
 for <qemu-devel@nongnu.org>; Fri, 14 Nov 2025 07:21:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1763133672; x=1763738472; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=P8ubjuL45MQvtuL1jnJKk70iPWsS7zMJRiRaAWaROj8=;
 b=ApSvn6EHAX/LOJpGljnobIzJ7byGECRP8zqNhDDJ+nCazr8rtSRw3ni0ufYmeZZEgh
 o1IVzBw2X11lfrcFI6xQpm3NUYKblX14NbdVAWSYh6ZFJJzIPK9FGWGNgKc28l4quNJc
 y4LmMUsX3WgiLPrRkZtuO3DsBKn+iOvnoosRef7cUKU4MN/2QKQKOE9cvNNGsf4pJZc9
 1M9r8mvwQpueTICEvH0yai94Sjez88BOVtfoZb5cAnkcX22ViHDvrpbGi//+mbyOUd6r
 UPVBPNqgzsi0CiW5VDbp3X9haKLp/S/mOesMFInneVp7toGmmu6zGsyr8Z22WXmkwd+R
 xZ9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763133672; x=1763738472;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=P8ubjuL45MQvtuL1jnJKk70iPWsS7zMJRiRaAWaROj8=;
 b=QnvFldwPEeUmtE2LSj4fN6E+vvXPA7Wex8nJ8x31HFOTAl6kfK3ZpsJq1jol/KgzH8
 eaHtTKmVP7P1XLqbvQdnp+v2VzkbK4324dSFkoJDq/vFnqNy8abqJaD+83ytFFd0ROGz
 gjJKjKOqt2rimPZeDKNcMiGh8f01jCRn8SxHCMo45xkbSidBjIdM57+KwjkoOITkpxFp
 B6glws9tsT1bsDDkLiip8/7oUIlB+f4UIVMy10hojzEGx4eJ5YYqB08kO+t/xMWPVi1A
 6ccnO9klyOCOJ1sXS0y6nAmLjKjYxVMfWWWE8wn6b40FJGilep8jk1rTJ/PboDExvkF9
 lq5A==
X-Gm-Message-State: AOJu0YyW2hqiS9XCiBC2IB6MPsT25UhtqpROdxUZN/zDEqqlbbjPExJx
 s3uBLYx+NNIqQ4FRG1BhTqNkVHV6JVHh1jy9xohFYKzp0ayxJigGiJ8m3odFfWbkHDUscBqCA2/
 Cqdv4
X-Gm-Gg: ASbGncu6xQRV9EB90cf1hEkkMThvnoPTF2Kj5TUyd1C0CuGoSwVCaEHgRmW5Ju756gy
 wvL9+Z+LLRwU/thQiQNXEPYVcIZY0Nexu9UlBb3zCzz+ZRHMv++xQQtzqCFUBm9BDzrvpwEGbQV
 alyDVaKwbxvdLOstS7WRoxvzGpO32UejRBMi4gODbPAQ31SvPdDoMoy/TUumZCvnCHkc6YzTQrK
 MAkD7i36tVYfc2WRonC1kmyEoD3ckK36MSgEcmmNYE8lS0UBf7bwnvb5XUPsXRcY/VF/eah8kEb
 RwcZUVycEZeJGKPcAwz6PTa3Oh13NmpfLQb68fBPPHZtKiprDfcR7adXgz4KUUsgSw695h2TRfp
 +0i1fIIBgGiN4NCPtZ/pVgWnZpzvkWzFSQJNI5PYhQGmdeIMNwZ7Ymweo99JcUzbZCX3bdljjat
 cEKsiq3/vDfcGrrUbL
X-Google-Smtp-Source: AGHT+IENLVPpZtdSayPQtmtObWveMJe6Kh0hoQsxV7PaFgpyACN0PZ+t98CJQ5AlGtORaKp6eKdXiQ==
X-Received: by 2002:a05:600c:c4a2:b0:477:c37:2ea7 with SMTP id
 5b1f17b1804b1-4778fe9ac28mr32712315e9.21.1763133672370; 
 Fri, 14 Nov 2025 07:21:12 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47787e8e798sm146772835e9.10.2025.11.14.07.21.11
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 14 Nov 2025 07:21:11 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 00/10] target-arm queue
Date: Fri, 14 Nov 2025 15:21:00 +0000
Message-ID: <20251114152110.2547285-1-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32b.google.com
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

Hi; here are some arm patches for the freeze; mostly these are
fairly unexciting minor bug fixes.

I did find in my CI run for this that the check-python-minreqs
job failed with:
"ERROR: /builds/pm215/qemu/scripts/qapi/commands.py Imports are incorrectly sorted and/or formatted."
https://gitlab.com/pm215/qemu/-/jobs/12092087877

but since this pullreq doesn't touch that file or anything
else python-related I assume that's a pre-existing CI failure.

thanks
-- PMM

The following changes since commit 9febfa94b69b7146582c48a868bd2330ac45037f:

  Merge tag 'for-upstream' of https://repo.or.cz/qemu/kevin into staging (2025-11-12 11:47:42 +0100)

are available in the Git repository at:

  https://gitlab.com/pm215/qemu.git tags/pull-target-arm-20251114

for you to fetch changes up to 522444744eb79dd01e377ad2ed15544f10bcc70c:

  hw/audio/lm4549: Don't try to open a zero-frequency audio voice (2025-11-14 13:20:10 +0000)

----------------------------------------------------------------
target-arm queue:
 * MAINTAINERS file update for whpx
 * target/arm: Fix accidental write to TCG constant
 * target/arm/cpu64: remove duplicate include
 * hw/display/xlnx_dp: don't abort() on guest errors
 * cxl, vfio, tests: clean up includes
 * hw/misc/npcm_clk: Don't divide by zero when calculating frequency
 * hw/audio/lm4549: Don't try to open a zero-frequency audio voice

----------------------------------------------------------------
Mohamed Mediouni (1):
      MAINTAINERS: update maintainers for WHPX

Osama Abdelkader (1):
      target/arm/cpu64: remove duplicate include

Peter Maydell (7):
      hw/display/xlnx_dp.c: Don't abort on AUX FIFO overrun/underrun
      hw/display/xlnx_dp: Don't abort for unsupported graphics formats
      cxl: Clean up includes
      vfio: Clean up includes
      tests: Clean up includes
      hw/misc/npcm_clk: Don't divide by zero when calculating frequency
      hw/audio/lm4549: Don't try to open a zero-frequency audio voice

Richard Henderson (1):
      target/arm: Fix accidental write to TCG constant

 MAINTAINERS                          |  3 +-
 hw/vfio-user/container.h             |  1 -
 hw/vfio-user/device.h                |  1 -
 hw/vfio/pci-quirks.h                 |  1 -
 tests/qtest/aspeed-hace-utils.h      |  1 -
 tests/qtest/aspeed-smc-utils.h       |  1 -
 hw/audio/lm4549.c                    | 17 +++++++-
 hw/cxl/cxl-mailbox-utils.c           |  2 +-
 hw/display/xlnx_dp.c                 | 83 ++++++++++++++++++++++++++++++++----
 hw/mem/cxl_type3.c                   |  2 +-
 hw/misc/npcm_clk.c                   |  5 ++-
 hw/vfio-user/container.c             |  2 +-
 hw/vfio-user/pci.c                   |  2 +-
 hw/vfio/ap.c                         |  1 -
 hw/vfio/container.c                  |  2 +-
 hw/vfio/cpr-legacy.c                 |  2 +-
 target/arm/cpu64.c                   |  1 -
 target/arm/tcg/translate.c           | 11 +++--
 tests/qtest/aspeed_gpio-test.c       |  1 -
 tests/qtest/dbus-display-test.c      |  3 --
 tests/qtest/pnv-spi-seeprom-test.c   |  1 -
 tests/unit/test-cutils.c             |  2 +-
 tests/unit/test-error-report.c       |  1 -
 tests/unit/test-io-channel-command.c |  2 -
 24 files changed, 110 insertions(+), 38 deletions(-)

