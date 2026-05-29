Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C05B8CD6E54
	for <qemu-devel@archiver.kernel.org>; Fri, 29 May 2026 17:47:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wT1IL-00036S-Vo; Fri, 29 May 2026 13:46:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wT1IG-00035X-FJ
 for qemu-devel@nongnu.org; Fri, 29 May 2026 13:46:49 -0400
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wT1IC-0001av-21
 for qemu-devel@nongnu.org; Fri, 29 May 2026 13:46:47 -0400
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-4903d5c67bfso46953385e9.1
 for <qemu-devel@nongnu.org>; Fri, 29 May 2026 10:46:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1780076801; x=1780681601; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=f+vAfnebhWCOSkEW/XUg0sxLevAUiIY6ENXJUedXEk8=;
 b=IoEQ3S7zICXZdYBATEVIj91PRH4Hq7jYfmzS/bG+gQ5EG3hiyeSay9q+bYVsp7aV7n
 k/OLHDVQaUhCE6UPzN0vlR5cFHadtajy8lAWkuqISZXxI3Y+3VIdUB/a0iYiSUR9f3H8
 5gfAaFwzxjWWHKy1CirI7l8s40WuhzwdQ9o2Z/SMsW8rSB2835BBnOjNDlbUOe2YdThn
 pKxZTvxd+aRkzQvrC1RJWuZ82MEb2E4bYnufHeQRF3igBkgvuTOLGcC8ZkSW1Q3Cd3J3
 S8eIVFt38cUgmbC1fI9jjvPeMI+JKQBdNNFkSPj7JOpQ6wGASxkLWCKFwHtEtWKR7104
 tvoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780076801; x=1780681601;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=f+vAfnebhWCOSkEW/XUg0sxLevAUiIY6ENXJUedXEk8=;
 b=rFGSavJeM4OoXA2n0UTkiNuhHczPua67S0u+BNRtj3GEB/Ce6zsjS36KPsy8cbP5Wy
 iNHuT6Rnfo2Nssdv42MwoM8f2HfzGQM8QRG3WE16XfVxkruFLXcPOWZ2wIL8vgaVY2yD
 neAsPMBohXaKmt8Qi+WukegY6Jngb6hYzV4b82FiWRVCxPpDeQ/viB4Yrn9I+tuzK2GK
 ewUrLFjl66ZHDTvxNpjkp2ByFXeRdHuEbJjsBwjRHWQByTF8S6x0I3BqKKUzdeY6D0/3
 OVfOA7/T7IFAbCdCuhg4eq77NcRTEaNW9FrwZfO+0SLbSVQ8XDnNerIw4D97SUf9b0Gr
 oqLQ==
X-Gm-Message-State: AOJu0YxuJS3MNiGmRH22cW85dEo9eaOogjqZZ9VsIw7mPUoR0SIT9/uo
 zBbWq+UrPv7l/VPZCY8nzFI44yvqzADiXGcj/p7O9460YaFNkn8cINvPd6DQ9HglmzIictosISG
 pyC+N
X-Gm-Gg: Acq92OHgm6sSbXLc4JQrnHi6UqV9plAG4G9+gG4ItBJN7v8IppCA3RHOagT4S4siuUZ
 J65/MfcnMnV8mXF53OfMwZRjy79iRNFw4B7T+OP++7pI4gK8KzL3lv3Z7tfI/34de7i/ucOMMgU
 rbPCm8zV1m2a1hf68rkbJ48TwVCCUjKwvKmSHjWHQadtKlRvt2IffuWcQj828FnngHvoC3iRAOA
 0EdLkNAnlpY2KODRu078ZEDACHHMBsN2HVjJCqRKdYe5eZritldNXOWeRoDmBRAX7TJcwlDnnDZ
 NeWh5H32EifMYt1K1x3t4AVv2fVISFeiAHiLS80klNjEZytM9BGqGUM6cjVQqZqxfFBmI0mSj/a
 CXYwCbyRQaFI9pZ7FTyXmbBC069SyJ5N32+wLgTvkzWEclJQ6BV0hLJhDXV37NjPpkZMGW7hhef
 AfmAlFkz0eBnnyYaV1E5A+DFi2aGNCEPRiHbbWaVKc1pJTqBbHFq/qCAXLWn0nLEnXP4BVwc2o/
 9t6t9Pb8HD8KRA1LcafNBi9InOBI7k5wiJIfTW9foY67lziQ7g+Ag==
X-Received: by 2002:a05:600d:486:10b0:48f:d1c0:5cd3 with SMTP id
 5b1f17b1804b1-490a29128a3mr9034845e9.13.1780076801550; 
 Fri, 29 May 2026 10:46:41 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4909c0aa24bsm18668895e9.9.2026.05.29.10.46.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 29 May 2026 10:46:40 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Paolo Bonzini <pbonzini@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Sergio Lopez <slp@redhat.com>, Song Gao <gaosong@loongson.cn>,
 Bibo Mao <maobibo@loongson.cn>, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Chao Liu <chao.liu.zevorn@gmail.com>
Subject: [PATCH 0/5] hw/nvram/fw_cfg: Document and tighten up register layouts
Date: Fri, 29 May 2026 18:46:34 +0100
Message-ID: <20260529174639.451353-1-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
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

We support the fw_cfg device on more architectures and machines that
we let on about in the documentation.  Luckily most of the new ones
(notably riscv and loongarch) have followed the straightforward layout
that the Arm virt board picked. Allowing every machine type to have
its own special-snowflake register layout has no particular benefits
and tends to result in guest OSes accumulating ifdef ladders to deal
with all the unnecessary variation.
    
This patchset:
 * updates the docs to present the arm/riscv/loongarch memory
   mapped layout as the "standard" layout to be used by all
   new architectures/machines in future
 * adds the layouts used by various existing boards that we
   didn't document (PA-RISC, SPARC, PPC and MIPS)
 * tightens up fw_cfg_init_mem_dma() and fw_cfg_init_io_dma()
   functions so that they don't provide flexibility to the
   caller to pick their own weird new layout. None of the
   callers were using this flexibility, so it's better to
   have fw_cfg_init_mem_dma() give the "standard MMIO" layout
   and fw_cfg_init_io_dma() give the x86 ioport layout.

thanks
-- PMM

Peter Maydell (5):
  docs/specs/fw_cfg: Document all architecture register layouts
  hw/nvram/fw_cfg: Enforce standard layout for fw_cfg_init_mem_dma()
  hw/nvram/fw_cfg: Enforce standard layout for x86 fw_cfg I/O ports
  hw/nvram/fw_cfg: Remove support for I/O port fw_cfg without DMA
  hw/nvram/fw_cfg: Document fw_cfg_init_mem_nodma()

 docs/specs/fw_cfg.rst     | 28 ++++++++++++++++---
 hw/arm/virt.c             |  2 +-
 hw/i386/fw_cfg.c          |  3 +-
 hw/i386/microvm.c         |  3 +-
 hw/i386/pc.c              |  3 +-
 hw/loongarch/fw_cfg.c     |  3 +-
 hw/nvram/fw_cfg.c         | 22 ++++++---------
 hw/riscv/virt.c           |  3 +-
 include/hw/nvram/fw_cfg.h | 58 +++++++++++++++++++++++++++++++++++----
 9 files changed, 92 insertions(+), 33 deletions(-)

-- 
2.43.0


