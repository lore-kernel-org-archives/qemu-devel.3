Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B64C1C28B28
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Mar 2025 00:09:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1trQfA-0001lx-7M; Sun, 09 Mar 2025 20:06:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1trQf7-0001l2-0d
 for qemu-devel@nongnu.org; Sun, 09 Mar 2025 20:06:29 -0400
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1trQf3-0007GG-2r
 for qemu-devel@nongnu.org; Sun, 09 Mar 2025 20:06:28 -0400
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-43cef0f03cfso4785455e9.3
 for <qemu-devel@nongnu.org>; Sun, 09 Mar 2025 17:06:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741565183; x=1742169983; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=vluwFSKp6e7zoU80eebsr7FlbxAE5fBxSqh6kQbHYLQ=;
 b=KWF8VMPUgkgBl+NQu/36q1Sii3Go+nz/wZzd40CGS4mPelfzqlsW2QWEphCONnnp4d
 g6X5QuMhVwRxXGOyZIkLSwzEGDXHHZ+4btKl9/ly0i5JjOg9vtzn/JRAoztwg++rCjGk
 Sy/mtgX3dSvZejhF/dXpfhEdpAJ8fZpuCensZFC2c2Zni3p68XzIlCbJJcLjIOvMcllV
 ijS42ZDTBONIFwcxmFUK68NdRb8HUupkC/FWeFHOyS24FOsmF1ptXVTG6Pr42Tjnic5K
 Hd9V2HRdmryDRGkNjgH4iA71wh/gf7zl/wt6nhDnUToy20mPqRkIlS60aaS9qRRFCa1F
 5lIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741565183; x=1742169983;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=vluwFSKp6e7zoU80eebsr7FlbxAE5fBxSqh6kQbHYLQ=;
 b=ERIG75Qfs8kB6I+fLvzk+yIo4knw5QGtYrMMP3WS6b2H/hQiiLMMW3wJP89U3irdnH
 78gFH16LiP4e1ZpTgAY8apTFI+32TUNUmOg2FtLv2nONlV/jiIjZ6YnKXA5AnjCWMaqO
 rTlhrZ/UdnE2YNFRzgpdmPRl1CnN+owzQiFHNZwvw9tHNwTYMmBRn5U+8BPTd6wOqPTI
 PqfS7XgMw0Nwl+JZmGFCwLoGD6hH9qFXrvb2D1NxiudYLAGCzQ5hgxUhl/MJNK/8wAOp
 tcRMzDu8PiwQqS9WYBgNQmMacKSA0964I0QGw0k9chB3FSWo1DEBQ/Hqpf8kGOpvm1o/
 Wolg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVb29MWFcwSeYaSck8XyPZofgFbKtnNaX1C9zRknJj67LxGBaoNJwnSDB1hLNHxgVuQGrkrFlWdXzbI@nongnu.org
X-Gm-Message-State: AOJu0Yz+sHK9HeORuEA5eqxWownVuRfDfGTimwgYM7Dd7uak6A0SmU9L
 o7yrBfZVjAjmPZ5G6dYz3X2f7j7QwBHVjz3C1SZkVzD1Z6VwYlKA4vw37tQT9tM=
X-Gm-Gg: ASbGncvKw9vV8vzt14LZCTuoxAeTgFoyKT/H+GmNGp9Hei0MmEdflXemmLzR/fkg+1x
 nNPqNGxY0pmm4dquyoi6PkJeSfGIsKbm/5ZLAHsuKfo7EeUpCqMWE0icmxKtOcHmeRkK0O8QGEt
 OAePf5BSNvxFF60EEp9BgV4/VjdpSHVwsM9IvwFxfCRbrhDLr/3ydcij3WPOv5D18HpBsfwujBX
 cwk1K+SQ/QNJ2bE8eJvjmH8OQ+jMDTIwf2fhJgJ9ryCyd1o7LmRytgC+nzAQhFLSoFMiFA/++3X
 Knpm0JIoOl671AaIiKryo9/2g0C96vOl7YZzzJhRRVMTvGtTNpg+jrBURTfmRZmgflaR5KaiiNS
 Yy/agg64oH7PfzaL1Ix7CKQE/20lb2A==
X-Google-Smtp-Source: AGHT+IGXQGVRl/PbnRa8YqPLCqfxr6IXZ2UAWjlgzILsr9g7wtjeJG/FGLjoRfyLER+TiVWgoQeHew==
X-Received: by 2002:a05:600c:5103:b0:439:685e:d4c8 with SMTP id
 5b1f17b1804b1-43c5a60eda3mr70337825e9.15.1741565183204; 
 Sun, 09 Mar 2025 17:06:23 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43cfbae50aasm4329205e9.8.2025.03.09.17.06.21
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sun, 09 Mar 2025 17:06:22 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: BALATON Zoltan <balaton@eik.bme.hu>,
	qemu-devel@nongnu.org
Cc: Steven Lee <steven_lee@aspeedtech.com>, Joel Stanley <joel@jms.id.au>,
 Bernhard Beschow <shentey@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 Andrey Smirnov <andrew.smirnov@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Bin Meng <bmeng.cn@gmail.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Eduardo Habkost <eduardo@habkost.net>, qemu-ppc@nongnu.org,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Guenter Roeck <linux@roeck-us.net>,
 Andrew Jeffery <andrew@codeconstruct.com.au>, Troy Lee <leetroy@gmail.com>,
 Jean-Christophe Dubois <jcd@tribudubois.net>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-block@nongnu.org, Jamin Lin <jamin_lin@aspeedtech.com>
Subject: [PATCH v5 00/14] hw/sd/sdhci: Set reset value of interrupt registers
Date: Mon, 10 Mar 2025 01:06:06 +0100
Message-ID: <20250310000620.70120-1-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32f.google.com
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

Since v4:
- Convert quirks (Zoltan)
- Cache class to avoid invalid cast with PCI
- Remove 'endianness' property (Bernhard)

Since v3:
- Fix "hw/qdev-properties-system.h" (first patch)
- Convert to EndianMode (patch #10)

Rainy saturday, time for some hobbyist contributions :)

In this series we try to address the issue Zoltan reported
and try to fix in [*], but using a more generic approach.
The SDHCI code ends up better consolidated and ready to
scale for more vendor implementations.

[*] https://lore.kernel.org/qemu-devel/20250210160329.DDA7F4E600E@zero.eik.bme.hu/

Philippe Mathieu-Daudé (14):
  hw/qdev-properties-system: Include missing 'qapi/qapi-types-common.h'
  hw/sd/sdhci: Remove need for SDHCIState::vendor field
  hw/sd/sdhci: Redefine SDHCI_QUIRK_NO_BUSY_IRQ bitmask as bit
  hw/sd/sdhci: Include 'wp-inverted' property in quirk bitmask
  hw/sd/sdhci: Include 'pending-insert-quirk' property in quirk bitmask
  hw/sd/sdhci: Introduce SDHCIClass stub
  hw/sd/sdhci: Make quirks a class property
  hw/sd/sdhci: Make I/O region size a class property
  hw/sd/sdhci: Allow SDHCI classes to register their own MemoryRegionOps
  hw/sd/sdhci: Allow SDHCI classes to register their own read-only regs
  hw/sd/sdhci: Allow SDHCI classes to have different register reset
    values
  hw/sd/sdhci: Implement Freescale eSDHC as TYPE_FSL_ESDHC
  hw/ppc/e500: Replace generic SDHCI by Freescale eSDHC
  hw/sd/sdhci: Remove unnecessary 'endianness' property

 hw/sd/sdhci-internal.h              |  26 ++---
 include/hw/qdev-properties-system.h |   1 +
 include/hw/sd/sdhci.h               |  83 ++++++++++----
 hw/arm/aspeed.c                     |   2 +-
 hw/arm/fsl-imx25.c                  |   2 -
 hw/arm/fsl-imx6.c                   |   2 -
 hw/arm/fsl-imx6ul.c                 |   2 -
 hw/arm/fsl-imx7.c                   |   2 -
 hw/arm/fsl-imx8mp.c                 |   2 -
 hw/ppc/e500.c                       |  12 +-
 hw/sd/sdhci-pci.c                   |   1 +
 hw/sd/sdhci.c                       | 166 ++++++++++++++++++----------
 12 files changed, 184 insertions(+), 117 deletions(-)

-- 
2.47.1


