Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7B83C3ABBE
	for <qemu-devel@archiver.kernel.org>; Thu,  8 May 2025 13:39:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uD1SM-0000Wo-FF; Thu, 08 May 2025 09:38:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uD1Rq-0008Lb-PQ
 for qemu-devel@nongnu.org; Thu, 08 May 2025 09:38:03 -0400
Received: from mail-pl1-x635.google.com ([2607:f8b0:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uD1Ro-0003qo-HZ
 for qemu-devel@nongnu.org; Thu, 08 May 2025 09:38:02 -0400
Received: by mail-pl1-x635.google.com with SMTP id
 d9443c01a7336-22e45088d6eso13992165ad.0
 for <qemu-devel@nongnu.org>; Thu, 08 May 2025 06:38:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746711478; x=1747316278; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=WY7gSBXT6cR7bWSaiDRLSHPRiSnEJ0DiKBMO01arpK0=;
 b=st6zY8gdtQxfu2ev4NTpXSr0YGXqWQuhwEir7C8e4T7OpoUad6V60nP0sK4urVXcjq
 DEvol2Wl0MbfpG0iACc7zikVVtoHPJJVfKw0tvwZoEkJGib6hCdD/DWPldOXgy0GVco+
 th75CjygbmUzsY3CoLpE1pepTmhveIky62hA/wIWr2inHSvBzOe/JWUzt3CwzjhQJBRE
 mhY8E2ZmBbccu87M2cfMswhwy6OZGc1sC33jA4CGg0Txo0GhobKat3Se5TSwcla8XxI+
 O84tg+hQaKP3Oo623djRdERsR02exbaNGkLT9VS4mKoXAiSaHbnC+Er+DrZ1fDhWQxsN
 yOCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746711478; x=1747316278;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=WY7gSBXT6cR7bWSaiDRLSHPRiSnEJ0DiKBMO01arpK0=;
 b=nY1JIurNRbrp5jOHjiiAALwLV5twQq3La8ThtTMQkGE753cKNE4l2XvqWZ4V1926TX
 MvHu/lhAB/Bd7Nts3eHK92YGEBp7VcOYNK8dxITvEuxt9fBBA15ZwPJNNMOLWfX+dOIq
 iXV4m8J36sq6sMc/cfHJq63NFUzXJeqJXAQZuPUXrdysslyH64hnYjJCE0IM2hpV5Yvq
 3AY8jPucMbeoMydq6reDm8m3h6ULPGdU3D24NmmdRuq3wC03zu6NMKbozlV3yPrN22IJ
 gETmZWZbS8rEQLrfmSjVqNzm4rfC57ybZCM0pfGvIaN+IBy1xzH/Hk0k2w5lVNvrwqxH
 bANQ==
X-Gm-Message-State: AOJu0Yw33VzpZvG69Q+ysvCOCEvyn0wtUzVX7Fakwqig68ZazawVUdS2
 Davwzgh5liMHh5ya307PAOyv59gnUOyq7HI+IS++EuRV0q7FxgQZFdf1/imBFW2nVE0H1MZjMcc
 MjiRW+Q==
X-Gm-Gg: ASbGncvVRi8EEUWFzEey8BXTIhUyM2SscRcuyEEsrxfENAbb8kKPfCA+P0ZeVCxCc6u
 g0j0xV2quJg+WpA/lAOY90HSR090HsHPDAn97/WgrJ1QVwNt3XbjPhzCtzEUIufjhXB9Pbdiete
 BPmkXOMFvkJvy8/PxE7iYfq67xERnd0YuKPyKDk39vNeS7mIWri93xVikoLoCCOB61s1dBsOgH8
 5Twqa1Zd7Is+QfGhEsEhXzlhUlw0txHaWtnDlP0cWv2EiVCvfHHGfnYiDd+K5LVrE2nVFwPY4S/
 sE7wP6vMOQuLIQPBHPF3kM7u5dc1K5D8+p5sezhaLj8U61aZmiXnrCPHqFlceiqwNHj2xIp3nMo
 CpOvm+/6xuNijV7d1jUK+TSkaUw==
X-Google-Smtp-Source: AGHT+IFLlPSB1rrLA2f2qz61Ov5siZIkGu3fk4846ZY3wJHNQUHlcR79jlid3BO4tuhX5LA8XNMdHA==
X-Received: by 2002:a17:903:244b:b0:22e:b215:1b6 with SMTP id
 d9443c01a7336-22eb2150297mr51984415ad.28.1746711478628; 
 Thu, 08 May 2025 06:37:58 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22e151ebd08sm111835505ad.104.2025.05.08.06.37.45
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 08 May 2025 06:37:58 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>, kvm@vger.kernel.org,
 Sergio Lopez <slp@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Laurent Vivier <lvivier@redhat.com>, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Yi Liu <yi.l.liu@intel.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Marcelo Tosatti <mtosatti@redhat.com>, qemu-riscv@nongnu.org,
 Weiwei Li <liwei1518@gmail.com>, Amit Shah <amit@kernel.org>,
 Zhao Liu <zhao1.liu@intel.com>, Yanan Wang <wangyanan55@huawei.com>,
 Helge Deller <deller@gmx.de>, Palmer Dabbelt <palmer@dabbelt.com>,
 Ani Sinha <anisinha@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 =?UTF-8?q?Cl=C3=A9ment=20Mathieu--Drif?= <clement.mathieu--drif@eviden.com>,
 qemu-arm@nongnu.org,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Huacai Chen <chenhuacai@kernel.org>, Jason Wang <jasowang@redhat.com>
Subject: [PATCH v4 05/27] hw/nvram/fw_cfg: Factor fw_cfg_init_mem_internal()
 out
Date: Thu,  8 May 2025 15:35:28 +0200
Message-ID: <20250508133550.81391-6-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250508133550.81391-1-philmd@linaro.org>
References: <20250508133550.81391-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::635;
 envelope-from=philmd@linaro.org; helo=mail-pl1-x635.google.com
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

Factor fw_cfg_init_mem_internal() out of fw_cfg_init_mem_wide().
In fw_cfg_init_mem_wide(), assert DMA arguments are provided.
Callers without DMA have to use the fw_cfg_init_mem() helper.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/nvram/fw_cfg.c | 17 +++++++++++++----
 1 file changed, 13 insertions(+), 4 deletions(-)

diff --git a/hw/nvram/fw_cfg.c b/hw/nvram/fw_cfg.c
index 10f8f8db86f..4067324fb09 100644
--- a/hw/nvram/fw_cfg.c
+++ b/hw/nvram/fw_cfg.c
@@ -1053,9 +1053,9 @@ FWCfgState *fw_cfg_init_io_dma(uint32_t iobase, uint32_t dma_iobase,
     return s;
 }
 
-FWCfgState *fw_cfg_init_mem_wide(hwaddr ctl_addr,
-                                 hwaddr data_addr, uint32_t data_width,
-                                 hwaddr dma_addr, AddressSpace *dma_as)
+static FWCfgState *fw_cfg_init_mem_internal(hwaddr ctl_addr,
+                                            hwaddr data_addr, uint32_t data_width,
+                                            hwaddr dma_addr, AddressSpace *dma_as)
 {
     DeviceState *dev;
     SysBusDevice *sbd;
@@ -1087,10 +1087,19 @@ FWCfgState *fw_cfg_init_mem_wide(hwaddr ctl_addr,
     return s;
 }
 
+FWCfgState *fw_cfg_init_mem_wide(hwaddr ctl_addr,
+                                 hwaddr data_addr, uint32_t data_width,
+                                 hwaddr dma_addr, AddressSpace *dma_as)
+{
+    assert(dma_addr && dma_as);
+    return fw_cfg_init_mem_internal(ctl_addr, data_addr, data_addr,
+                                    dma_addr, dma_as);
+}
+
 FWCfgState *fw_cfg_init_mem_nodma(hwaddr ctl_addr, hwaddr data_addr,
                                   unsigned data_width)
 {
-    return fw_cfg_init_mem_wide(ctl_addr, data_addr, data_width, 0, NULL);
+    return fw_cfg_init_mem_internal(ctl_addr, data_addr, data_width, 0, NULL);
 }
 
 
-- 
2.47.1


