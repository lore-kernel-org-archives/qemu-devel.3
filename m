Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C252A109B462
	for <qemu-devel@archiver.kernel.org>; Tue, 31 Mar 2026 13:15:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w7YwM-0005Yr-Sg; Tue, 31 Mar 2026 09:15:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1w7YwF-0005T3-4I
 for qemu-devel@nongnu.org; Tue, 31 Mar 2026 09:15:23 -0400
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1w7YwC-00042d-CH
 for qemu-devel@nongnu.org; Tue, 31 Mar 2026 09:15:22 -0400
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-48374014a77so67956455e9.3
 for <qemu-devel@nongnu.org>; Tue, 31 Mar 2026 06:15:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1774962918; x=1775567718; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=PnT1G0OtWTFYv4298adVXVlE64BE/QbpdYmTgbtqlRs=;
 b=fjzeYPF9RVhlBa8ETsTZoFT7XI9DICIlqX3iU8ZRZz2ob2xwoHNztK0CVZRXm+Ij3U
 i+gNcD4cU4Z5l2k5ra5Qy5gpP7tnnuQ3v1zsCWheLYTziNj2E7v/1wvPwMoDq++ihb87
 VkhlFlzN3uA6e365535mzGidC6yxxc8rAw+ze8/ZmIEm4R+yhfm6Y43YfMzdNjDdcz9r
 oo10kCKYEw0FBnBvVmeZDE3ZY/q8NUMUGZtUIIrWyUJ3d7+OBwzDetBDqe6JIh7tmNnf
 Vx36XC8GF/fz6F39WdLg48+ysAEcX7IWI/Q4mNjc8GxWbZTrNms9hpd2h6cFBnqgbcXG
 yawA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774962918; x=1775567718;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=PnT1G0OtWTFYv4298adVXVlE64BE/QbpdYmTgbtqlRs=;
 b=dKbits0YScvghsAO+DzOjYSi/fUqr+nSwwruU43foCrwIPICdYcXfgk25eeY2JKTVD
 0G9HVMoy7xCFXEJKt7NwziogORWjwkm7Rh7+5ln+1Frn/2SHeKbQd056uGDnPBZi9MvL
 roCkcmYoWC0XUDp0RzRSQfJhtZTfQNpmGDx09lVxVqesMEmkVcxJjTNmRtHeytxPVSmV
 h2FAOyC1fFspTXWhHSE1XdvsC2lLDiSRUz3/0J+cD18/5csT+4KyrU/+CS4fAxhXC8Mw
 5QiqqlREQlrQ/MPN0yy4MkP4/yWikT4/aH4P367pOzAjosu9UzUPETd/4jJhdmpww4iT
 iBwg==
X-Gm-Message-State: AOJu0YzTxqCvPRGcGOcySV1CIv8Is3vBiU+Ce6ils71oMcbAMlq3KLMZ
 mKX1Va4drfXR3SkuEXq2oEH8mTQKPIR1j0W+EogXsw1xZJN4Le+Xl9h8f2uAGlskpRxp3Vjyo9R
 SowJVIaM=
X-Gm-Gg: ATEYQzxXGyZak7ZEn43hvw0hcMJcsAHY775BF61jmhvqgq5TvNq4EhylW/aBJV4853X
 vD3donyJ4c6eSKQ6Q1tY7Uys62Crky0k7sc4CQA/uH+WTmP2CTVoP/V/mpgRsOfM3z1XfC65hVY
 QIb1utVpTURWRWUYlpvfrL+S0ax+4BQltVp7IHZ/kCcZW6pZhLgG6ERMN9/Gk55q7sVmy7JoNc7
 q9VaXKEkLfcFawpVee3KkQRanTKtlDufqa3YStzsLaWOZhT0AUhzTl36H4n5mvoz45EldNYyHje
 rjvd0evkxvv/DR7lsEB+Bv8oKSIAcVu2WQidAfhfj3yLSCK44zGrAz0Til8QvP5t9mUW/GN8ofK
 bTeyRCYt+GEKKLIW75zY7lacvGpth5/nCIK/JsVLxKJJ3jrXKVZJlS8WfpTA3zXR3OyahFlX21U
 zREg+qj+pwvVJosi7l6TRLipxVU29GgYKWCRMypOYsbabfqPwI05xS7JF1ahW/NKcx+oY=
X-Received: by 2002:a05:600c:4e15:b0:485:2ce2:4c87 with SMTP id
 5b1f17b1804b1-48727d45881mr289290735e9.4.1774962918149; 
 Tue, 31 Mar 2026 06:15:18 -0700 (PDT)
Received: from localhost.localdomain (43.149.216.82.rev.sfr.net.
 [82.216.149.43]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43cf330872asm24986420f8f.17.2026.03.31.06.15.16
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 31 Mar 2026 06:15:17 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 00/11] Misc HW patches for 2026-03-31
Date: Tue, 31 Mar 2026 15:15:02 +0200
Message-ID: <20260331131514.21152-1-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32e.google.com
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

The following changes since commit 49ea0100202fe448be1d0f3ea5384cd51b5e6a58:

  Merge tag 'migration-20260330-pull-request' of https://gitlab.com/farosas/qemu into staging (2026-03-31 09:39:52 +0100)

are available in the Git repository at:

  https://github.com/philmd/qemu.git tags/hw-misc-20260331

for you to fetch changes up to a4d5cfe3eed909c81b19c73309dd44a0262d59c7:

  MAINTAINERS: fix OSUOSL typo (2026-03-31 15:12:45 +0200)

----------------------------------------------------------------
Misc HW patches

Few fixes and MAINTAINERS updates.

----------------------------------------------------------------

Alex Bennée (1):
  MAINTAINERS: fix OSUOSL typo

BALATON Zoltan (2):
  ati-vga: Silence warning about operator precedence
  ati-vga: Add upper limit to x-linear-aper-size property

Helge Deller (2):
  hw/pci-host/astro: Update copyright and documentation link
  hw/hppa: Disable Artist graphics card on 64-bit machines

Luigi Leonardi (1):
  backends/igvm: switch to PRIx64

Peter Maydell (2):
  target/i386/cpu.c: Correct minor grammar error in warning
  target/i386: Treat qtest like TCG for supported-features

Philippe Mathieu-Daudé (1):
  MAINTAINERS: Separate QDev section from QOM one

Shivang Upadhyay (1):
  ppc/pnv: generate dtb after machine initialization is complete

Trieu Huynh (1):
  target/mips: save CP0 timer in vmstate

 MAINTAINERS                  | 23 ++++++++------
 include/hw/ppc/pnv.h         |  2 ++
 backends/igvm.c              |  4 +--
 hw/display/ati.c             |  4 +++
 hw/display/ati_2d.c          |  2 +-
 hw/hppa/machine.c            |  3 +-
 hw/pci-host/astro.c          |  4 +--
 hw/ppc/pnv.c                 | 58 ++++++++++++++++++++----------------
 target/i386/cpu.c            |  6 ++--
 target/mips/system/machine.c | 22 ++++++++++++++
 10 files changed, 85 insertions(+), 43 deletions(-)

-- 
2.53.0


