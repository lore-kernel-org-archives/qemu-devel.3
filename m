Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D24B8EC01CB
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Mar 2026 10:55:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w4cvi-0001sv-BX; Mon, 23 Mar 2026 06:54:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1w4cvc-0001op-KP
 for qemu-devel@nongnu.org; Mon, 23 Mar 2026 06:54:36 -0400
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1w4cva-00063x-Rp
 for qemu-devel@nongnu.org; Mon, 23 Mar 2026 06:54:36 -0400
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-4853c1ca73aso38150145e9.2
 for <qemu-devel@nongnu.org>; Mon, 23 Mar 2026 03:54:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1774263271; x=1774868071; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=d9XgbTD4Ak+YL3aeWtcJ3IUyRRx+ErQTI98mYRXcnyw=;
 b=BjsmgIZny/GrdT0Vkkp0eq/fWFQayJI35q5qHhVnIv/2xkd7EBRTZoOp2GhnwAuRfC
 4DCKotTeTwiNqJpToIrnIwosOFrB7PteVV2o1gTNtXFGvuY3KXEJ72lrHIPvXtmavVYn
 sNqND0mYzo3QOZFtGYxsws/93JCx5YpBApAtXjQjDTS2qHuh1YL/EnfakE60osed2xW6
 J/KRndDUlATurH9jmXtCEgbLh13beOSz5KXZ/NvAHthximzPYJFOUYQBr/8heAZCcj8C
 Ujb9wsbV0FgfStze0VByIU1PsYalSYzy6C7BV+vpOn+70QIDFs0tM2mDP4/wtyHC9Q0H
 8M3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774263271; x=1774868071;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=d9XgbTD4Ak+YL3aeWtcJ3IUyRRx+ErQTI98mYRXcnyw=;
 b=oygjxpOSFEz5627bEM21n482vKmpjAv+YkkHCY4bS5bkFdgAPjVU8JcFmaUTPgx4/L
 +wAfVzkdHD4t0YNNHbkxpUaBeBpsVXQQVmTN3CS7BueaB7AHJF0eHe9lckGUQUhJ9/m9
 dfpjXdXcxO6OOfl6GuvEro0QfXIxXeLcweRL270jqW/S97aJjMqCr21ikUGil0i8i+tD
 8tLSOykyqWLr93Bg1qDKcZj1cFI1xHS9cf5H+ECiTEYbgUIRAv6HhLBm1pO9MWax1ta5
 REE4Imgoicoy0JxOzYi/2x/OoM6WYHs2OuKcTX2HwMPHTK9jmCS1drKwRgtCxsx5H21O
 v7Dg==
X-Gm-Message-State: AOJu0YzdoTaM/rSxFr6ixS9g/Z6HLELr9hOoKqKQgt38vp/E7CT3vPdH
 XSeD7VZwhbxEu/7jp8D+wQZ4Gq3teq0IKGHnWmLgtQksj3FfHGteNV3VwbvCLJIi/R6c1A2J/RU
 Denm3gbE=
X-Gm-Gg: ATEYQzwvh9is9wlijZ9cX5AZzPugH2SDukcxpahiaDCBFlWKMOz3u/RTNK86blNVu0N
 fmsF4f2TLKxwZdFSbF9yng4lQhE5LXs/gIkEvilj+u3HeChYn4vlnb7x2JSqJZfXw1oCioaReBK
 Lxj+uWRbflKwsMxnqWAUTGUg5x3g+32uycGLey7gVOFEm1yxDwVL86CGrt7V55PLwux1DdyR+QZ
 gAVzgtD1UjLMJZcBHoMjba/YLyPpgi1AzZkF31id60k2gsO5peIMWXMwPYUSwe/78yq/P9pURjD
 bcMNwyW5YkzKx4pEkoIlS5j1tpvOs2O9r1pIkADTAsCqX+QAEUBmqarvrMPL+B5I/jnMcbqHfdQ
 TVJ3KcqWCmSFEYcrsC0gpHQ5DpJIxHkro1s30qtjgWQnww8d5eUpxp1UzztORC/oYLSRJCP+mTk
 qqlXWdXCfZidPMqHVXZI0XuV8sx1Y53tk7/3GbGHSE+9LRz5MaELoY91P9RGIM9dO1nqeYlA4mm
 xxvoiZ4c6mKKZ5jzxOMOd7/jEDq644=
X-Received: by 2002:a05:600c:5248:b0:485:3a27:a961 with SMTP id
 5b1f17b1804b1-486feb5d845mr174412915e9.0.1774263271072; 
 Mon, 23 Mar 2026 03:54:31 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-486ff1dd9f1sm115483185e9.8.2026.03.23.03.54.30
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 23 Mar 2026 03:54:30 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 00/10] target-arm queue
Date: Mon, 23 Mar 2026 10:54:19 +0000
Message-ID: <20260323105429.4059580-1-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x336.google.com
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

The following changes since commit 8e711856d7639cbffa51405f2cc2366e3d9e3a23:

  Merge tag 'hppa-fixes-for-v11-pull-request' of https://github.com/hdeller/qemu-hppa into staging (2026-03-20 10:04:48 +0000)

are available in the Git repository at:

  https://gitlab.com/pm215/qemu.git tags/pull-target-arm-20260323

for you to fetch changes up to b38859be76abf4d49f81f36317e6e37ab93121f0:

  hw/isa/piix: Embed i8259 irq in device state instead of allocating (2026-03-23 09:51:01 +0000)

----------------------------------------------------------------
target-arm queue:
 * tests/qtest/arm-cpu-features: Fix thinko in g_strdup_printf() call
 * configure: Remove unused variable default_cflags
 * whpx: arm: Various fixes, notably making '-cpu host' work
 * configs/targets: Restrict the legacy ldst_phys() API on ARM / Aarch64
 * hw/isa/piix: Embed i8259 irq in device state instead of allocating

----------------------------------------------------------------
Mohamed Mediouni (5):
      whpx: arm: fix -cpu host
      whpx: arm: add EC_DATAABORT assert for WHvRunVpExitReasonGpaIntercept/UnmappedGpa
      whpx: arm: enable more enlightenments
      whpx: arm: remove comment bit that is no longer accurate
      target/arm: cpu: alter error message for host CPU type

Osama Abdelkader (1):
      whpx: arm: fix ID_AA64MMFR3_EL1 host feature register index

Peter Maydell (3):
      tests/qtest/arm-cpu-features: Fix thinko in g_strdup_printf() call
      configure: Remove unused variable default_cflags
      hw/isa/piix: Embed i8259 irq in device state instead of allocating

Philippe Mathieu-Daudé (1):
      configs/targets: Restrict the legacy ldst_phys() API on ARM / Aarch64

 configs/targets/aarch64-softmmu.mak |  1 +
 configs/targets/arm-softmmu.mak     |  1 +
 configure                           |  2 --
 hw/arm/virt.c                       |  2 +-
 hw/isa/piix.c                       | 11 ++++++-----
 include/hw/southbridge/piix.h       |  3 +++
 target/arm/cpu.c                    |  4 ++--
 target/arm/whpx/whpx-all.c          | 11 +++++++----
 tests/qtest/arm-cpu-features.c      |  2 +-
 9 files changed, 22 insertions(+), 15 deletions(-)

