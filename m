Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4191BC44506
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2026 11:00:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wi8ws-0006Rq-Ob; Fri, 10 Jul 2026 06:59:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wi8wq-0006RU-Jp
 for qemu-devel@nongnu.org; Fri, 10 Jul 2026 06:59:12 -0400
Received: from mail-wr2-x01.google.com ([2a00:1450:4864:30::1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wi8wo-0001NC-Ol
 for qemu-devel@nongnu.org; Fri, 10 Jul 2026 06:59:12 -0400
Received: by mail-wr2-x01.google.com with SMTP id
 ffacd0b85a97d-4703eef5987so270979f8f.0
 for <qemu-devel@nongnu.org>; Fri, 10 Jul 2026 03:59:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1783681149; x=1784285949; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=WgXgLjcNB2sizCIRY4K8oa4Ca9Ff/wTtH9CTjHRjCJM=;
 b=Oj79xJLlznaOtVyBg/ShyzvO8yxEcDxzXPmZQDry3sQElwi05QdvkxreRWWGXUxzDA
 CoyYPnuAmnYkZRbMpcdsM+ClCWKdhbsXYcp34r9eGuAQ8EIPBzEMPsFC5PO82LrcsMYY
 n2jwwBufyqg+PYK7NxxMj7Z6nYcAgGfgJh+/xflhiIXpnFmT3PNjDps4EJJb8Ir7pts4
 sSTpYjn7O+XBXJ/MQgQrpNaTxUmvfx+UcZ1UzMQxR0MLXPdAMzmWsGW8L/n9/f+zd1nE
 e4QCq4ppZiBg06AXv5f3/cwq54ACNXs5F1jLArgFaIkqM4voHsE3EBV3eYwrlU8bJig6
 3A+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783681149; x=1784285949;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=WgXgLjcNB2sizCIRY4K8oa4Ca9Ff/wTtH9CTjHRjCJM=;
 b=GnTZWNmrCjQPe+N2kvN+bDghmHxNhUHcJhsWXloypNjmeQwQLG9n5+0UsL9UsYgzeO
 E0xaB9mjvzcGFJYAd8VYCAwxaAFHNM1Wir4FMzmLCGUjBNGR2DK76NYi2EYymgZymPVl
 fEvGvCBJ0bha60320/lL2bisQ3+KjL3EVPz3hj1VEX7Vm7dPqPcAAAyBT8g2a0gC9QWA
 55WpoZ/dsYm0fFMbc+ImEJpyZgiE6w991behYi8RtfNFwyzz8u0Mv1mk1U2EM6TzDB6Z
 NYAJV+VRW1riGgCTyROPxIRgzWOwdQjD5nnsuHlXpThjcFrFK7Yi0ZHFmwat2xh0rXwv
 fOuQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RpOr9/C6jI/kNw24iYxyo3LdLlrpjg335F1b0NmVAeVVNcGGRN3fumH9+/lI8SI0iu7Wg1q6FrXh8jh@nongnu.org
X-Gm-Message-State: AOJu0YznMclhHWno93z8YgsiMsayg777/LcS++iwH0D8s540xUL+gT0g
 NARDrpD5ahlruEdLJw2iB4w4cM80xyNwqe/4AL0IKaAlg0QFon8+O0c5bpwgw3ktHiI=
X-Gm-Gg: AfdE7ckgnXzRN0ct+WgoySFgUcJGs94omAVl1RW7AwF8WlwyGd/g2nIdwbMr8txcu0r
 J1uMSDzjJZ1FahaB8oKQR3lQR5FFRT0KSAurvQGX8s6MwwYWQVKk5oSYPCLqNAMwn147Zph+plQ
 wESrBXlqqX2dxrEaT5o23KP4v6O2DDuNC+CEvhsGRbkYWx9QXBvpfhfJI2SvA5srnef8Z63Zxx+
 RUdMv75+mi3gYDhqhxENULczaGzj3HSwatD2dFNHujLPVqfbxW6Y6xsf92/nUGrEexi9G7tUfLj
 0TGIGkkFFpDGc2SKMnJFBEwMvjDugYAalzxPTixZpKES9DhnJtXhWwZH9PfaxkJkgkDsShYFftd
 w+oVuNmDIWgSqvduCtmQOn7qL69heWad8jV6CifSb/2JFMebl+cz0Zih9v9RacTbeGqZey3uKta
 wWTp/S1kQZzqgJ3lauVBwptat81gFPL2RGdvZ4vl2t3pEU0suoJlwIaC1Pm9v2UNEvHlNHpOZ5k
 ym6QvG6tkZRjuKNDekpGw==
X-Received: by 2002:a05:600c:310f:b0:493:d1e0:a4f1 with SMTP id
 5b1f17b1804b1-493e6c05de0mr98206315e9.0.1783681149018; 
 Fri, 10 Jul 2026 03:59:09 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-493f2d88698sm51946175e9.1.2026.07.10.03.59.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 10 Jul 2026 03:59:08 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: Jim MacArthur <jim.macarthur@linaro.org>
Subject: [PATCH 0/9] omap_dma: avoid non-bounds-checked memcopy
Date: Fri, 10 Jul 2026 11:58:58 +0100
Message-ID: <20260710105907.2570621-1-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:30::1;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr2-x01.google.com
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

The omap_dma device is the only user of the soc_dma code.  This code
has a fastpath for when DMA transfers are from RAM to RAM.  The
current implementation of this has the caller of
soc_dma_port_add_mem() pass the underlying host address of the RAM
block that the DMA port is connected to (obtained via
memory_region_get_ram_ptr()).  Then the actual transfer function does
a simple memcpy().  This has several problems.
    
Most importantly, no bounds checking is done on the address and size
passed by the guest, so the memcpy source and destination might be
outside the backing host RAM entirely.  Secondly, because the DMA
access is done via this back door, there is no updating of the dirty
region when memory is written this way.

The better way to handle memory-to-memory DMA is to use
physical_memory_map(), because this will tell you if the address/size
you asked for would run off the edge of the RAM block, and it handles
updating dirty bits on write.

There are also various places where the omap_dma code is a bit
cavalier about possible integer overflows if the guest sets a
very high element and frame count for a transfer.

This series fixes both these problems, thus resolving
https://gitlab.com/qemu-project/qemu/-/work_items/3204
In the process it also simplifies the soc_dma code by removing
the unused "FIFO port" handling, so we don't have to check or
update that code.

thanks
-- PMM

Peter Maydell (9):
  hw/dma/soc_dma: Remove soc_dma_port_fifo support
  hw/dma/soc_dma: Simplify soc_dma_ch_update()
  hw/dma/soc_dma: Remove union from memmap_entry_s struct
  hw/dma/omap_dma: Be more careful about overflow in transfer setup
  hw/dma/soc_dma: dma bytes is uint64_t
  hw/dma/soc_dma: Use physical_memory_map() for mem2mem transfers
  hw/dma/soc_dma: Remove unused mem.base, paddr fields
  include/hw/arm/omap_dma.h: Move to include/hw/dma
  MAINTAINERS: Add soc_dma to OMAP section

 MAINTAINERS                       |   2 +
 hw/arm/omap1.c                    |   8 +-
 hw/dma/omap_dma.c                 |  37 +++---
 hw/dma/soc_dma.c                  | 196 ++++++++++--------------------
 include/hw/{arm => dma}/soc_dma.h |  33 ++---
 5 files changed, 97 insertions(+), 179 deletions(-)
 rename include/hw/{arm => dma}/soc_dma.h (70%)

-- 
2.43.0


