Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07778C531C9
	for <qemu-devel@archiver.kernel.org>; Sat, 25 Jul 2026 01:28:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wnRA2-0004xZ-NS; Fri, 24 Jul 2026 21:26:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcelomanzo@gmail.com>)
 id 1wnRA1-0004wu-5Q
 for qemu-devel@nongnu.org; Fri, 24 Jul 2026 21:26:41 -0400
Received: from mail-vk1-xa2a.google.com ([2607:f8b0:4864:20::a2a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcelomanzo@gmail.com>)
 id 1wnR9z-0006F0-Bo
 for qemu-devel@nongnu.org; Fri, 24 Jul 2026 21:26:40 -0400
Received: by mail-vk1-xa2a.google.com with SMTP id
 71dfb90a1353d-5bf95ade656so330005e0c.1
 for <qemu-devel@nongnu.org>; Fri, 24 Jul 2026 18:26:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1784942798; x=1785547598; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=FR7smJVQCziDacT+pYW4DAUI7Sa7Mloc02pZ0ckbuCs=;
 b=NoEepBycx8iRl5CMX7Op0N5CxbxDIWL4uxE2roXvnmTbAe6i6Y9GpbzYF4+oVMFmdp
 GHTZQbRuiVce/LzNIhgdisSlVPnJxKpjn4dctLK4SLzzRqXUlbjlvOSrZPlGk8bz/AqB
 YoMd1mWB24HD0pedOQD+S2rchxhrIpS0QewD6Wy2aOJxnJ1uHGWw6+HIdyYY06UtGd3f
 OaQY9Ps9zaxKUoqR69kA1UVmA8Rlu1+VOyH/adxgX4TET5fgN4SuDFmSLhSi9W/9VYWF
 xB/AWPJEpTZ4I8P3FdSLOIuo0q2TFjJsJxn/Ceyjv36o2PEJ3+iUzlw603uaNFk+teIp
 iX/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784942798; x=1785547598;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=FR7smJVQCziDacT+pYW4DAUI7Sa7Mloc02pZ0ckbuCs=;
 b=X7WscrgzVDogzWb3lOgqQmjFrsF9JXAsAXEgAW3rnx2m0NgBIEpcqa6lIn7RftE0gE
 hN3y2YezO7mIyuSh1AVgG8CXCBQTkdabq3bp11RMUP9i0a1jvKf6dyoORa/I6TNJsBOU
 2TQt4j24d37LIs4KbiQPIu5fq3pgolpSKKemwa7GPh9FH6jPfE8PdGQzpDpCmuQ9sIo2
 pEC3Qz5G+MfglEN0mRYDFfEUM4qJryvQ6V1ydSgj4ajtga6lCxllNfNTHnGIplkS0gs0
 nL2nLqsL2BrI35qj6DaLcw5zkkKfHVyLtGYfGTjFEsaO/83fRlhT4PSkwFKfjefPLcfc
 wdEA==
X-Gm-Message-State: AOJu0YxAC03S4cDjeQx0B5ILz9decgrriaPlmwjpphLQlGid8EUOTzTr
 p0uStkqYHFpBqWi1tkqqP9z+/ofRyHDLe+LRZYuKuhX003KTC4LXrXDkOWvHVQ/4
X-Gm-Gg: AR+sD10BL3DW+WLwy4YU0eKnXtEylqIEDaOB6L1qIl1xBriOhA4DIl4X8fUAqs19arl
 P9RHqAb0Ix+etxzucHoS8me5dxl1gLjKvOcgpa55L7bCdM8/cNc51Fhst20BcLAX4zWtoyiTdqI
 pxWJNU9xHxjglMeksvS/Ihy8nzZ3ZnVn91xji0GnAt/N7/bJP5DeyyWGMR357U5dhtKZo77tNAo
 ZkC+kQS3ePl3WDNP2CJBUZb8QPzIrwzAww0sqmcn3PfGMGfxfBNHS8n1cMAegkoiHtDT/5EqNMk
 pJ4swkMwlwQFfbKKWZFTNW0XQfzKu9pzkFrHJ8N/Yiv5PwyyPES3i4ZgXW+qXalHnojzXj2/liW
 bH1vK3rMlPXrL3az+2WM2bxgBjXzAIyHQ01tYQlqZi2JxgvqvOUG+QqM81pliQ7cBZIeHCcK/Ej
 UOkM3Gv9uhkjiiuMP2mnTpb42ciH351jC8MWs/ZguM6rQ=
X-Received: by 2002:a05:6122:4b8a:b0:5bf:ab99:ea92 with SMTP id
 71dfb90a1353d-5c306e11c69mr403557e0c.12.1784942798185; 
 Fri, 24 Jul 2026 18:26:38 -0700 (PDT)
Received: from localhost.localdomain ([146.71.8.128])
 by smtp.gmail.com with ESMTPSA id
 a1e0cc1a2514c-97774c388d7sm1092856241.1.2026.07.24.18.26.36
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 24 Jul 2026 18:26:37 -0700 (PDT)
From: Marcelo Manzo <marcelomanzo@gmail.com>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 Sergey Kambalin <sergey.kambalin@auriga.com>,
 Marcelo Manzo <marcelomanzo@gmail.com>
Subject: [PATCH 0/5] hw/arm/raspi4b: RNG200 and thermal sensor
Date: Fri, 24 Jul 2026 21:26:30 -0400
Message-ID: <20260725012635.4925-1-marcelomanzo@gmail.com>
X-Mailer: git-send-email 2.47.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::a2a;
 envelope-from=marcelomanzo@gmail.com; helo=mail-vk1-xa2a.google.com
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

This is a follow-up to the "hw/arm/raspi4b: working PCIe and GENET
(real networking)" series I sent earlier [1], carrying forward two
more patches from the same stalled Sergey Kambalin series (patchwork
series 829638, [2]): the RNG200 hardware random number generator and
the dummy thermal sensor for BCM2711/raspi4b. These are the last two
devices raspi4b's DTB was masking out (the mask array,
nodes_to_remove[] in raspi4_modify_dtb(), is fully empty after this
series and goes away with it -- GENET, PCIe, RNG200, and the thermal
sensor were the only four entries it ever had).

Same porting approach as the previous series: patches 1 and 3 are
Kambalin's original code carried forward with his authorship and
Signed-off-by kept, adapted only for API drift since 2024 (headers
moved under hw/core/, class_init()'s const void *data, the
Resettable phases API, Property[] losing its
DEFINE_PROP_END_OF_LIST() sentinel, and fifo8_pop_buf() gaining a
caller-supplied destination buffer -- adapted
bcm2838_rng200_read_fifo_data() to the new copying API this code
originally used the now-legacy fifo8_pop_bufptr() form of). No
functional changes. Patches 2 and 4 wire the devices into the SoC.
Patch 5 adds a functional test.

Unlike the GENET/PCIe series, there were no real bugs to find here --
these are much smaller, mostly self-contained register models (the
RNG has a FIFO and a ptimer for periodic entropy generation, but no
DMA/checksum/link-state machinery to get subtly wrong), and testing
confirmed them working on the first pass: the guest probes both
("iproc-rng200 fe104000.rng: hwrng registered" and a working
thermal_zone reporting the expected fixed 25C), /dev/hwrng yields
real random bytes, and the new functional test
(test_arm_raspi4_rng_thermal) checks exactly that.

checkpatch.pl is clean (0 errors) across the series; note it also
caught two real issues in Kambalin's original code while I had it
open for the API-drift adaptation -- an old-style license-boilerplate
header instead of SPDX-License-Identifier in bcm2838_rng200.{c,h}
and bcm2838_thermal.h, and one brace-placement/whitespace nit -- both
fixed in the same patches.
tests/functional/aarch64/test_raspi4.py's other three tests
(including the GENET one from the previous series) still pass.

[1] https://patchwork.kernel.org/project/qemu-devel/cover/20260725004219.66222-1-marcelomanzo@gmail.com/
[2] https://patchwork.kernel.org/project/qemu-devel/cover/20240226000259.2752893-1-sergey.kambalin@auriga.com/

Marcelo Manzo (3):
  hw/arm/bcm2838: enable BCM2838 RNG200
  hw/arm/bcm2838: enable BCM2838 thermal sensor
  tests/functional/aarch64: add raspi4b RNG200/thermal test

Sergey Kambalin (2):
  hw/misc/bcm2838_rng200: add BCM2838 RNG200
  hw/misc/bcm2838_thermal: add BCM2838 thermal sensor

 hw/arm/bcm2838.c                        |   4 +
 hw/arm/bcm2838_peripherals.c            |  28 ++
 hw/arm/raspi4b.c                        |  19 --
 hw/misc/bcm2838_rng200.c                | 406 ++++++++++++++++++++++++
 hw/misc/bcm2838_thermal.c               |  98 ++++++
 hw/misc/meson.build                     |   2 +
 hw/misc/trace-events                    |  10 +
 include/hw/arm/bcm2838_peripherals.h    |   4 +
 include/hw/misc/bcm2838_rng200.h        |  42 +++
 include/hw/misc/bcm2838_thermal.h       |  23 ++
 tests/functional/aarch64/test_raspi4.py |  32 ++
 11 files changed, 649 insertions(+), 19 deletions(-)
 create mode 100644 hw/misc/bcm2838_rng200.c
 create mode 100644 hw/misc/bcm2838_thermal.c
 create mode 100644 include/hw/misc/bcm2838_rng200.h
 create mode 100644 include/hw/misc/bcm2838_thermal.h

-- 
2.47.1


