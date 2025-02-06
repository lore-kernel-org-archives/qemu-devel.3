Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35364C0219C
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2025 11:34:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tg08P-00070P-SS; Thu, 06 Feb 2025 06:33:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tg08N-0006z6-Kh
 for qemu-devel@nongnu.org; Thu, 06 Feb 2025 06:33:27 -0500
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tg08L-0000ok-JU
 for qemu-devel@nongnu.org; Thu, 06 Feb 2025 06:33:27 -0500
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-436202dd7f6so8813335e9.0
 for <qemu-devel@nongnu.org>; Thu, 06 Feb 2025 03:33:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1738841603; x=1739446403; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=9+JizQ+8tepFEFJsVHo48Ann56AIwzKonw7PNgNaCsU=;
 b=E0aFUjO6sOtBED1NcKMkCC9LALatMOGrgK74BvIKLneUii5Mvo04KcdEcbrmVv1nPo
 P7J7R9XQPgSPqigiyjMRZCmioCmxzAV+f9qMRtiBFUst0DvI7tlb++7SMd2chTYJaZcA
 Lqr2zQq4TrlBWfcwvcmZzIhyodFPjllkRy57kWAfTr7SLv6mjtIiyPkosE9oXDh1iv0w
 drZUU3TJ5IZTMst+cRBWUJsK4U3EVoEbD3s9j3AW72xx/whKc1zN16KP57gc58nBABMK
 QZqNiYOiuwcRc6c+055oeOCnsVdUP92hi62yUxyiOuEPVAtSsBB0bvGu0mN8s24uJMk6
 leWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738841603; x=1739446403;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=9+JizQ+8tepFEFJsVHo48Ann56AIwzKonw7PNgNaCsU=;
 b=mCvJTzTDW0NbnLk5FFWaCPl1cF8pUTrRZKYVw9HuoR2KJN6EPW7bG/2WLBcXz3VtZF
 A4gmJ68bPO9y5StcJmNjSGpk+NW7WDZmHFXmVtl60X6sfpwlCn5N4sajSan6IeOEKFhK
 SMXJAC6HviDK0Pukyr4SusNy+V0wQu2Uu3RFuFfuKwD9W6GJ/mBdTgOfYohFBry8eAhW
 7sdljX5lI3BcU4rCRHxSQs5Hz9924Ad98xe0XbI/68eNwtASGsM3yZj/XkkD9V942m0Y
 +V87XxvIftm9wIX6rnAiXNWy++jaADzOdBY4POJzgsWCYEftmDMDbolhcJsTvZw/fi6k
 8v3w==
X-Gm-Message-State: AOJu0YwAmjlnffflycDdQWGHMdKaBGF7yDB6wpWI/DLgSGoFzsj9f6Z2
 bzVgxR/eyG0ihQfkovIOzTVhaeIf9G+lIsvMyTFWTmDb8wNdSJ6HUk11vFVaTS2k4FP8PZrS4rk
 vIS0=
X-Gm-Gg: ASbGncsVwsFOyugBG1eM6LCm91prUKoUCDNYyRpXlxgqQk1u7IrCyo2WICNi1NO9x5K
 QyX3yk/hR+q4y0Vy0gc9wiIgXUgmnPbftqCexOnstGPJDClME8tsmMw1oRMyWmW/WTwz2JbdqB8
 dofFdSa08tKHABzc4gwfI66vFEYvKgqwOYbZkIot0MySDVlUeGaEw+mKU35qIx3k+eNR65w6AmH
 MTdNPk0VVAATDJB34ypZKKXtpM4oPoIUN+1Ad2uKYkeZO7uDh88Gn051AJg7KNX7K/mhtnR+bDg
 QDqew6aLcy2rpm2ZnbP3kFwDtmufe/rAByp04HKVV9IRypbu8whXUMHHNj5CAu9JVQ==
X-Google-Smtp-Source: AGHT+IGy0Wpzs6KFY/SdbuRuk5hBj8BRg8AmFIAPVnO5PIDrXvhC0kCqZzcVsnwMUQPvvOOez2YBkQ==
X-Received: by 2002:a05:600c:1549:b0:438:a1f4:3e9d with SMTP id
 5b1f17b1804b1-4390d434dfbmr50395345e9.9.1738841603322; 
 Thu, 06 Feb 2025 03:33:23 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4391dfc88a3sm15906065e9.29.2025.02.06.03.33.22
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 06 Feb 2025 03:33:22 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Anton Johansson <anjo@rev.ng>, Alistair Francis <alistair@alistair23.me>,
 Richard Henderson <richard.henderson@linaro.org>,
 Thomas Huth <thuth@redhat.com>, Jason Wang <jasowang@redhat.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v4 00/16] hw/microblaze: Allow running cross-endian vCPUs
Date: Thu,  6 Feb 2025 12:33:05 +0100
Message-ID: <20250206113321.94906-1-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32b.google.com
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

Missing review: 2, 13 to 16.

Since v3:
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
  tests/functional: Have microblaze tests inherit common parent class
  tests/functional: Move microblaze tests to common parent class
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
 .../functional/test_microblaze_s3adsp1800.py  | 42 ++++++++++++--
 .../test_microblazeel_s3adsp1800.py           | 34 +++--------
 13 files changed, 256 insertions(+), 134 deletions(-)

-- 
2.47.1


