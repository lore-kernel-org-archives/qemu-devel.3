Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 035F0CC6B2F
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Oct 2026 03:38:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xHCHr-00053V-NL; Wed, 14 Oct 2026 23:37:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jay.chang@sifive.com>)
 id 1xHCHp-00052s-Vk
 for qemu-devel@nongnu.org; Wed, 14 Oct 2026 23:37:45 -0400
Received: from mail-pf1-x42f.google.com ([2607:f8b0:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jay.chang@sifive.com>)
 id 1xHCHo-0008Jy-Dh
 for qemu-devel@nongnu.org; Wed, 14 Oct 2026 23:37:45 -0400
Received: by mail-pf1-x42f.google.com with SMTP id
 d2e1a72fcca58-88d48da248eso3460908b3a.1
 for <qemu-devel@nongnu.org>; Wed, 14 Oct 2026 20:37:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1792035461; x=1792640261; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=odqEaUh7f60I3OiDEsMS+R3AbpE42KkGMAJEvO3ZAOE=;
 b=MY6NfCvdtj9QMgFMnLHZQhzM8xPEIN7tBn2N4TVziuGPHoOh9TbCCa8MPVr7Mg+u7X
 c40lUl6ZnxG5EFabC3Oo7uHKQ6lCQR6CDvYbiUdib73yVzZDUt9Trct/ECURI6KU0+mr
 iZfqdBfURBfkMn4yuY8TcjFsOVbR2VmF62WbwwFYdEscZCo6tjVschAGfBhpSp7x5Z+Q
 KabDbg98sEsrunLgl5NS7NG40TJzko11KAAhlr8AB1SycpREwMdUw17jJfyZY2+Ix2U5
 a9WfZjSBBKzKm72zOw+20OZPAiTDTAWO6Kjhl6PyCV3+iy6YiWcisHsq6Y7OI6t77lxM
 r4/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792035461; x=1792640261;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=odqEaUh7f60I3OiDEsMS+R3AbpE42KkGMAJEvO3ZAOE=;
 b=yODab/Si2B1GjJ64Qoag4T0/89USl8mJV92BD8GKS5MDoIbb8m1oZ/wSiyZWdraoIA
 tR6dWNFDxSm9tH8Jj+2zqxJiWH0HAOwBp7kkwLonqrY3rdGEbybVuVNe4vy8CMzaqc4U
 L+71WI4ohTjOFuq4vhuW+sOYYps/rcBiRTZ4/c0IgRn7H/4UDu7+NNKtwdXCEHM0KhbT
 MGP1pOGYrmZsvsPI1fZCCytgOcNkgk303FbmR+I2mXewboa/Jl5Y1iR3/ZLwkjbSFsJx
 D/BLGwcLsqpEzdziIIrDV3bRFQEH05zJIzJ1xFUGNFd660/dPofb2KREP7zAw4sFtvi/
 fkkw==
X-Gm-Message-State: AFq9FYIiIgpuST9tf+J0XD/M6g2m2QbGrmueypqFLZgsyr28ZuHL0+9/
 nD6t8e3kDh9fYUN0htW0zD5p+zzsRl38z08Xhs72oAHclViA4wRJ5Fb/nYaPBTe6oiHNSsSK51J
 VJ1kA9iwumpI+E9oPqcVRZWAOrMzFa13MUpoq6QTaIBULmZf/gcmtJU5QQtmstHR/qWOnCkyygx
 qOpiUI+rUTkfvI8Yjh9SbOseMStC/3vm+3S0sUQcPzhDS0Qg==
X-Gm-Gg: AYBFou3oWVBiOV2xQMF3lla6IM2Y7UC5aSQBii7A61ixUeOyfLafaavZu6znSE24gsy
 uIvAU7L2HylY+n7jsnDLx2CCaCYU+PoCaECHhd+MGxL8aR+95eTWZbFnkuuvT/qTyi7JSzb0Nrc
 kV2amYqtGwHV0pCQRdZhOgsku1ezqPVgIylZFYFFhZ8Ogl7UX+WGE30vncGHbidI/SXoIHkac9/
 +pLb3VvQr4ezP56IeTrK46LT2ua1NtVBOdywEdF9vwo/nwg7s85z4JiP7bEsyoC4W49BOJv++qD
 XTo8jj8PKEFUa4xgdmP5ffv4MHUQmhgpNjRro3akuxlfj8R7Ojob4LadK1ShInHnAnsuRdLREFL
 L1Nm/M/LEOBeHugnJns2+NXZdqsakG8kMjETtvitEZF2EuEwkZKOB8D/CXEs7bLSdSwTTenOs9l
 N8WAPwquvn1mO7RTJ63AkzXYbQVjgXK5MvKR465QD/iCq0cKGBTXFbOXxyEraKKrzunv7R8NbBa
 0Jp2b7aHutUhem4oygSBkNKB1vNfmD+zcqe
X-Received: by 2002:a05:6a21:70cb:b0:3c3:6f6c:aa21 with SMTP id
 adf61e73a8af0-3e16bd857e3mr16235041637.11.1792035461295; 
 Wed, 14 Oct 2026 20:37:41 -0700 (PDT)
Received: from jchang-1875.internal.sifive.com ([136.226.240.181])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-cd635c612a9sm559188a12.17.2026.10.14.20.37.38
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 14 Oct 2026 20:37:40 -0700 (PDT)
From: Jay Chang <jay.chang@sifive.com>
To: qemu-devel@nongnu.org
Cc: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Alistair Francis <alistair@alistair23.me>,
 Peter Maydell <peter.maydell@linaro.org>,
 Jason Wang <jasowangio@gmail.com>,
 qemu-arm@nongnu.org (open list:Xilinx Zynq),
 Jay Chang <jay.chang@sifive.com>
Subject: [PATCH 0/6] hw/dma,net: Fix Xilinx AXI DMA and Ethernet
Date: Thu, 15 Oct 2026 11:37:27 +0800
Message-ID: <20261015033733.35116-1-jay.chang@sifive.com>
X-Mailer: git-send-email 2.48.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42f;
 envelope-from=jay.chang@sifive.com; helo=mail-pf1-x42f.google.com
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

The Xilinx AXI DMA controller supports 64-bit descriptor addresses,
but the QEMU model only handled the low 32 bits during stream
processing.  This causes descriptor accesses to use incorrect
addresses when descriptors are located above 4 GiB.

This series updates the descriptor and MMIO handling and fixes related
AXI DMA and AXI Ethernet behavior.

The series:

- Add 64-bit descriptor address handling to stream processing.
- Add separate 32-bit and 64-bit MMIO access helpers.
- Fix DMASR W1C and DMACR start processing behavior.
- Reset both DMA channels when DMACR_RESET is written.
- Do not start a transfer when TAILDESC is written while the channel
  is halted.
- Fix AXI Ethernet RX packet double-buffering.

Testing:
- Tested Xilinx AXI Ethernet networking with U-Boot.
- Tested DHCP and ping.

Jay Chang (6):
  hw/dma/xilinx_axidma: Support 64-bit descriptor addressing in stream
    processing
  hw/dma/xilinx_axidma: Add 64-bit MMIO access support
  hw/dma/xilinx_axidma: Fix DMASR register handling
  hw/dma/xilinx_axidma: Reset both channels on DMACR_RESET
  hw/dma/xilinx_axidma: Don't start transfer on TAILDESC write when
    halted
  hw/net/xilinx_axienet: Fix packet double-buffering issue

 hw/dma/xilinx_axidma.c  | 249 +++++++++++++++++++++++++++++-----------
 hw/net/xilinx_axienet.c |  12 ++
 2 files changed, 193 insertions(+), 68 deletions(-)

-- 
2.48.1


