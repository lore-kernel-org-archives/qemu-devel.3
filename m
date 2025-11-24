Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59228CFA466
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Nov 2025 09:54:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vNTHK-0005LK-DI; Mon, 24 Nov 2025 04:54:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vNTEx-0004XC-Cf
 for qemu-devel@nongnu.org; Mon, 24 Nov 2025 04:52:32 -0500
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vNTEu-0001dI-VQ
 for qemu-devel@nongnu.org; Mon, 24 Nov 2025 04:52:11 -0500
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-477a1c28778so45092995e9.3
 for <qemu-devel@nongnu.org>; Mon, 24 Nov 2025 01:52:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1763977927; x=1764582727; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZZv0HaxYobXFFOcIY/qhqjmI7UJo1JUgEvzHSujWxJE=;
 b=LDlR5dTAF9JMJ1mlGGgEDFx1JQRX8I2JBEZPlXxpOOIg/4fKr3wQSaRQhAmmya8y0e
 l5oicKCrVLPKgq/z9yLHF2kaGIVBXKpRbSl5CdJE6/Qdbnn6Pfrc9A0h0l/dZRwhtt1l
 vQoKGF8iBFB5CJkGbvPc5UilhPBhkemW/GyNVUu/t+c99B0DZerY14o5NiaHZiXwFKrg
 Is+ulPn6qIyAf7//M0dqbuD3cOsIV2nFcPSDobfF2TCo2OiEr8bk10DDcZ7ItyViLpNk
 9crsdEIAwcnnyqh7ZGRJH8zrFtIjfX4rCkvbwB73MWSLL0AlyMiVXrdUkGd6ZB6KTZm+
 v6UQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763977927; x=1764582727;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=ZZv0HaxYobXFFOcIY/qhqjmI7UJo1JUgEvzHSujWxJE=;
 b=dYva1al1FhcENtqhkIYXsGIjQlgvRuYUKOg4mad8T+K0e8TUAh7ZtTapNjuW2DIVom
 r4VazjXr8vYwsroelZY5Fly9KGssLnKS7VPg275EOPtZzC4mjHtIhrZsH72deuDmLD//
 KAPwelIpmOHfsqsjP8Hy7RjEky+QZFC53Pry+gTR3v1PdpSUjwp5GTHXHvzzvKeHwqp7
 Lp2DjXB69VFvFD6XolBPltDtLWvqiCCdXXDpio3voKHMUrwUh8ZDka5hSI4Zi1ARuftB
 MOPCPVxZd1JWe/RrwZiy+eVnFwO2F6YFc3CJrUszFUQHRmnYR6NGgqhODHg/AtlOG16N
 E6PQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUfajoWT0ZrQUhpp3UFggFxn5fS5UA3EaxuI+82Ara4Y4Dxdyv/jxv3kS1hTYpCg4oYmmKTrxA/FGQ7@nongnu.org
X-Gm-Message-State: AOJu0YwilYvrJvs/mDD2DlPV4GhD6kLqN/kfATDEgZMWhbvfgPvOexer
 Bsc2z/qwsqFX47iAroTT0fn6B6R2WpCa61ZMnwb8/0AzR0pVedKPkwmxWDE/hSKHtvk=
X-Gm-Gg: ASbGncuJ+A5rj1U1vp5EQggnlxRLmQ3zs7lHU9DTeopRuEhtBDhVX+3FKWblBMhR03V
 UlSj56cPUj0eDzkHS1seSE4KzizX9AkpkAf3WhL4T2k8mk4On0697+loGRlTCb/E3BJcG+R9T0W
 p319C7/P4huFdHiK639sKAQC0CrFb/OGL7vJ2Kwb7gKax+eE0g3PLjQhQzrtyKUGuIgtgOD/plT
 TAyLn/b2pdYddLeZyHrc8Ql0YLQlZbmi0l+G6Kx5I9PB/H2Fpkn2xPPsTUZcr2TLaEqjtJ5/VcG
 MWA8J4BKjLcZgDw/efP+xw5fgMYdgXv+xBVTOfQCV7Lo6STZluxEBSqWHv8gQm9LmTVCTokLCkZ
 5783V4SoZ8LuZlm8u6pBo+qdWDhH63RkXLKHWDmF2AO1Gks4xw2mZgybxnilYgLonqV6dEvMkjK
 yA6XN8wOzoJy9y0oQ6UZu7gkgRyl0yk2LKvB1HkQZZFhV58KkHD08S3CGIcZqr
X-Google-Smtp-Source: AGHT+IGGpfroJHfu/PAd7oP+q+1QpIhfe/5kzG1uDNv2xwCFwEE+tTSrVfmPZs765o2hTRlw4lizEg==
X-Received: by 2002:a05:600c:c8f:b0:477:fcb:2256 with SMTP id
 5b1f17b1804b1-477c01bc360mr105579675e9.17.1763977926860; 
 Mon, 24 Nov 2025 01:52:06 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-477a9de4765sm144416295e9.10.2025.11.24.01.52.05
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 24 Nov 2025 01:52:06 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
 qemu-devel@nongnu.org
Cc: Rob Landley <rob@landley.net>, Thorsten Glaser <tg@debian.org>,
 Yoshinori Sato <yoshinori.sato@nifty.com>,
 Magnus Damm <magnus.damm@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH-for-11.0 08/13] hw/sh4/r2d: Use EXT_CS_BASE() macro for boot
 flash device
Date: Mon, 24 Nov 2025 10:51:03 +0100
Message-ID: <20251124095109.66091-9-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251124095109.66091-1-philmd@linaro.org>
References: <20251124095109.66091-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/sh4/r2d.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/hw/sh4/r2d.c b/hw/sh4/r2d.c
index ecbc1ec2a98..26edcabf2c0 100644
--- a/hw/sh4/r2d.c
+++ b/hw/sh4/r2d.c
@@ -252,6 +252,7 @@ static void r2d_init(MachineState *machine)
     PCIBus *pci_bus;
     USBBus *usb_bus;
     r2d_fpga_t *fpga;
+    const hwaddr flash_base = EXT_CS_BASE(0);
     hwaddr sdram_base;
     uint64_t sdram_size = machine->ram_size;
 
@@ -321,7 +322,7 @@ static void r2d_init(MachineState *machine)
      * addressable in words of 16bit.
      */
     dinfo = drive_get(IF_PFLASH, 0, 0);
-    pflash_cfi02_register(0x0, "r2d.flash", FLASH_SIZE,
+    pflash_cfi02_register(flash_base, "r2d.flash", FLASH_SIZE,
                           dinfo ? blk_by_legacy_dinfo(dinfo) : NULL,
                           64 * KiB, 1, 2, 0x0001, 0x227e, 0x2220, 0x2200,
                           0x555, 0x2aa, 0);
-- 
2.51.0


