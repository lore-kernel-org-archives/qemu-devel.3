Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64DFBC54E64
	for <qemu-devel@archiver.kernel.org>; Mon, 25 Mar 2024 14:20:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rolAT-0005ZE-M6; Mon, 25 Mar 2024 10:19:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rolAO-0005WZ-LF
 for qemu-devel@nongnu.org; Mon, 25 Mar 2024 10:19:12 -0400
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rolAI-0006el-CR
 for qemu-devel@nongnu.org; Mon, 25 Mar 2024 10:19:12 -0400
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-4148bd1d000so2673305e9.3
 for <qemu-devel@nongnu.org>; Mon, 25 Mar 2024 07:19:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1711376342; x=1711981142; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=w6Q+MaUnWFZ//6MqEvpo2kb7mJBVveU/bMvAeIsGocM=;
 b=L6tCk43n4E/AiSP6caUVmJ2WrQDmIftN+v1zk/cT7CWjGmFvC24GaiCQx6fVCa5Iyk
 ayq0rOtMKruxPzQUcnLivRg+ZpufeeCi6VLCcM3jPlV8j+PRyJf5wJb8fNJ0+fls9fTp
 tfyqIphqSnpl5K1r6PtYZGPkjCyIhdKCt6JkAQ+fWlFiMnYKgRBgnsHnpbEj4PwNbgbO
 V6/O/zNBsPURsY9FmkfSoE7NhpOS/NCXUV6/wtydu1iWm52MHmU0rK1fEgCV4JVmtoCL
 Z6hx0UdGaPnNLgSPWjqfoN7+8kYedXTaU6c1Wog1gXFG1N9cRTlVB6mx1ki/YlQpbd+R
 ymhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711376342; x=1711981142;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=w6Q+MaUnWFZ//6MqEvpo2kb7mJBVveU/bMvAeIsGocM=;
 b=AGAMJ4Wua3qgoF6uWwv2Koj8i7OuZ6+zLksiDuI07bpo4GWPS+KaYx1oHN99JGlJHu
 XFdCoR8p5tROJq35lnwOZk7bNB1tW6jzLlAVZGaoRJSUfi+Op5PGg0hjMF2SxDUIR+Pi
 aaxRBQ2XFXgMhSIv7nlZOPfAcS8zVkK+/0Aa4qim+LGnzYccuCXJnXg9837mpoa8E7Ha
 e+oKbkcBNl23beJieCdw9rPWjPNsC2RRB5vT3VIPh77h9kNnkp+QNajpbx9/yx/y0N++
 IVDlAY51vn1d0MxhaT4Mu34TjJ+KkeWEv43ajzFJIvuen4aInyX4v06sBTQd4a9UvN6H
 uitA==
X-Gm-Message-State: AOJu0Yyz0GlVl8QjNlP3ifhSX4pLbSR/GK/fbvV096IrEGsQuJ/L0BTG
 J+3EgJsPWbtj8ECsaTayovw/eua8OZ94sAPvMnKQwuaJTTsdoNcHMZ22tNKUZoqj/ClI8wiULuE
 X
X-Google-Smtp-Source: AGHT+IFpnElsqYfTfOPFbZyp6/gEMfyheCjudhVhzhZWoRjL6E/lmMIP3etWsgdIK+Wymek0739aBQ==
X-Received: by 2002:a05:600c:470e:b0:414:65cb:7e99 with SMTP id
 v14-20020a05600c470e00b0041465cb7e99mr5171016wmo.26.1711376342189; 
 Mon, 25 Mar 2024 07:19:02 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 o12-20020a05600c4fcc00b004148c79f067sm157417wmq.39.2024.03.25.07.19.01
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 25 Mar 2024 07:19:01 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL v2 0/7] target-arm queue
Date: Mon, 25 Mar 2024 14:19:01 +0000
Message-Id: <20240325141901.2080584-1-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32c.google.com
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


v2: added a missing #include qemu/error-report.h which only causes
build failure in some configs, not all.

The following changes since commit 853546f8128476eefb701d4a55b2781bb3a46faa:

  Merge tag 'pull-loongarch-20240322' of https://gitlab.com/gaosong/qemu into staging (2024-03-22 10:59:57 +0000)

are available in the Git repository at:

  https://git.linaro.org/people/pmaydell/qemu-arm.git tags/pull-target-arm-20240325-1

for you to fetch changes up to fe3e38390126c2202292911c49d46fc7ee4a163a:

  tests/qtest/libqtest.c: Check for g_setenv() failure (2024-03-25 14:17:07 +0000)

----------------------------------------------------------------
target-arm queue:
 * Fixes for seven minor coverity issues

----------------------------------------------------------------
Peter Maydell (7):
      tests/qtest/npcm7xx_emc_test: Don't leak cmd_line
      tests/unit/socket-helpers: Don't close(-1)
      net/af-xdp.c: Don't leak sock_fds array in net_init_af_xdp()
      hw/misc/pca9554: Correct error check bounds in get/set pin functions
      hw/nvram/mac_nvram: Report failure to write data
      tests/unit/test-throttle: Avoid unintended integer division
      tests/qtest/libqtest.c: Check for g_setenv() failure

 hw/misc/pca9554.c              | 4 ++--
 hw/nvram/mac_nvram.c           | 6 +++++-
 net/af-xdp.c                   | 3 +--
 tests/qtest/libqtest.c         | 6 +++++-
 tests/qtest/npcm7xx_emc-test.c | 4 ++--
 tests/unit/socket-helpers.c    | 4 +++-
 tests/unit/test-throttle.c     | 4 ++--
 7 files changed, 20 insertions(+), 11 deletions(-)

