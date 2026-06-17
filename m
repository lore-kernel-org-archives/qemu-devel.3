Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2EB52CD98F0
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jun 2026 06:38:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wZjuW-0001zW-M3; Wed, 17 Jun 2026 02:38:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chao.liu.zevorn@gmail.com>)
 id 1wZjuI-0001yY-Qg
 for qemu-devel@nongnu.org; Wed, 17 Jun 2026 02:37:51 -0400
Received: from mail-dl1-x1244.google.com ([2607:f8b0:4864:20::1244])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <chao.liu.zevorn@gmail.com>)
 id 1wZjuA-000790-AX
 for qemu-devel@nongnu.org; Wed, 17 Jun 2026 02:37:43 -0400
Received: by mail-dl1-x1244.google.com with SMTP id
 a92af1059eb24-1363fe80fe8so7760525c88.0
 for <qemu-devel@nongnu.org>; Tue, 16 Jun 2026 23:37:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1781678258; x=1782283058; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=glGT/9Tgf/nxMCnzrBWKieQYTY5bAp/gZqD5zP9BJKg=;
 b=BjmCDdO2V1JXBmNnwn4YdE8Oj98lJSdAbdU4BlacUMBDvhNmKRaagkKJQMndL3EpGZ
 7aGAtb5ipBNwZ0oP+2Px00s1oagHCJXhuuIftoI6CVcGHGh/2epexWv8Dcp7aKDBhdqa
 tEl3o4SB9U2Tx1BVbtV9skep6SgQ7X8CkQ/mKvERINQutX4TZ/3xspBgumDDzkC7xTw6
 2S24U5F/NwLijDWeIyoBkqRjes49EEeDeLTloul4Dymk7GxTeD0Jbz2gqmhCioWf/t8J
 /7HgX4Hbzidvvgj2ebuxqkvXach3XhJrZJ/AgKIc89TBq3UWO0CQpbNW282SLqsi8XYa
 b1AQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781678258; x=1782283058;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=glGT/9Tgf/nxMCnzrBWKieQYTY5bAp/gZqD5zP9BJKg=;
 b=L0MpOi12o2ZIhJx/dx8dqB3loMp2SLCsYkCoqAdJaOy7nsa2NxvA6w5qFss3UEFaEO
 NK/xIjPO8GyC0GynCr4QXJf2IvURGcxgDlklizvqax763scrqEmEmAilPjHKhNO0n0Vl
 oox6pJCB8cGF+5IIIo8WE91FjCKK6F5UbIQZkk6veKSW0mFvYnqBvcJvAbswnQBKm5l8
 P+tpa6O3qkO7b0R5G+rwYrjAejEwi5QfVYvjNQn7xWJjA5SFVC4smJJOfM78tqoVPd+q
 JaRVjiu7K96ZybqHzi3wsZSHGg+TG216+3uQHSAJ0DLJCWSgrOAoEhntVAHAHgeckHir
 vIlQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ9Q8K2Vx+kJKsmyLAOetiaH4ZxXPZoTH0UaV1afhKAQW9eAx7t2oFNPNmqUzUZeoZe+TXM42asDXRGL@nongnu.org
X-Gm-Message-State: AOJu0YzVKhaIzYG+AIICB8q5tV3z+wKzbeUdYTn2BO5fxVcsW6kj2i6a
 9FZf5uaq6G/LteuPCEcvJJbPj2/OT5BthCcD/OEqvd0tsA8QC2+yUa+F+SnpRnh1
X-Gm-Gg: Acq92OEzeU2KKuzZCIqI/oxApnBXOBM6cCV1N65tUbIE3nncacg5AJ/6VeR4lRBWNgD
 yYDR1ALeFWft5msFApRVe7rWjwwh/SEcGdcZ5pzRimyjFC8pMF4u1YutIvDPGizhebcs+0vGbyP
 45cJrquluCsq6b1N+hNkuKz1nvn6YJn81NGbULbZDYrR4j68cqSktvt+O6g82vbcFEJf/EymWmy
 1NUHcHKa5si4HeH91rDNRmcrPErnZBN22WajUp9L1/YabSkgaNYRyDj8aWWVJuevHiYEZjlOG/t
 CW/1CJ1d1FIU6Acbe+w+RytPJm543kPVGGgP/VQ5/T22Pp80dauHRpOlWQ66DxHf851g1XQ+ems
 mIxQz+RhZrir5dbfxeOcbPfWUeWRN7rVtHtzfTxoXIe5eJxuhRlPEAiz9Uk66U7BPPyxsl5FgWQ
 ixaJY2XfWt6g8B8rjhhUHhRLUQuyeQEIMsZJdV53tGidjzUabj
X-Received: by 2002:a05:7022:3d05:b0:138:6027:b768 with SMTP id
 a92af1059eb24-1398f6de208mr992799c88.27.1781678258395; 
 Tue, 16 Jun 2026 23:37:38 -0700 (PDT)
Received: from localhost ([64.186.250.142]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-1384b9110d3sm16199635c88.5.2026.06.16.23.37.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 Jun 2026 23:37:37 -0700 (PDT)
Date: Wed, 17 Jun 2026 14:37:34 +0800
From: Chao Liu <chao.liu.zevorn@gmail.com>
To: Kuan-Wei Chiu <visitorckw@gmail.com>
Cc: pbonzini@redhat.com, marcandre.lureau@redhat.com, 
 alistair.francis@wdc.com, farosas@suse.de, lvivier@redhat.com,
 liwei1518@gmail.com, 
 daniel.barboza@oss.qualcomm.com, zhiwei_liu@linux.alibaba.com,
 jserv@ccns.ncku.edu.tw, 
 eleanor15x@gmail.com, marscheng@google.com, qemu-devel@nongnu.org, 
 qemu-riscv@nongnu.org
Subject: Re: [PATCH v3 0/5] hw/riscv: Add support for Milk-V Duo board
Message-ID: <ajI_7sMKcaa-_lKD@ChaodeMacBook-Pro.local>
References: <20260616190147.1286316-1-visitorckw@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260616190147.1286316-1-visitorckw@gmail.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::1244;
 envelope-from=chao.liu.zevorn@gmail.com; helo=mail-dl1-x1244.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Tue, Jun 16, 2026 at 07:01:42PM +0800, Kuan-Wei Chiu wrote:
Hi Kuan-Wei,

> Add initial support for the Milk-V Duo board.
> 
> The Sophgo CV1800B SoC features T-Head C906 processing, standard PLIC
> and CLINT controllers, a dw8250 uart, and basic clock control. The
> current implementation can successfully run OpenSBI and boot Linux v7.0
> from an SD card to the Linux shell.
Can you add a document for the Milk-V Duo board?

Thanks,
Chao
> ---
> Changes in v3:
> - Rebase on master branch.
> - Drop custom T-Head PMU CSR patch to avoid duplication.
> - Use REG_BYTE_WIDTH macro in clock controller.
> 
> Changes in v2:
> - Added link for the custom T-Head PMU CSRs
> - Added qtest to validate basic for the dw8250 and clock controller.
> - Removed RFC tag.
> 
> Kuan-Wei Chiu (5):
>   hw/char: Add dw8250 UART
>   hw/misc: Add Sophgo CV1800B clock controller
>   hw/riscv: Add Sophgo CV1800B SoC support
>   hw/riscv: Add Milk-V Duo board support
>   tests/qtest: Add qtest for Milk-V Duo board
> 
>  MAINTAINERS                                 |  12 ++
>  configs/devices/riscv64-softmmu/default.mak |   1 +
>  hw/char/Kconfig                             |   4 +
>  hw/char/dw8250.c                            | 118 ++++++++++++++
>  hw/char/meson.build                         |   1 +
>  hw/misc/Kconfig                             |   3 +
>  hw/misc/cv1800b_clk.c                       |  90 +++++++++++
>  hw/misc/meson.build                         |   1 +
>  hw/riscv/Kconfig                            |  14 ++
>  hw/riscv/cv1800b.c                          | 168 ++++++++++++++++++++
>  hw/riscv/meson.build                        |   3 +
>  hw/riscv/milkv_duo.c                        | 124 +++++++++++++++
>  include/hw/char/dw8250.h                    |  27 ++++
>  include/hw/misc/cv1800b_clk.h               |  24 +++
>  include/hw/riscv/cv1800b.h                  |  52 ++++++
>  tests/qtest/meson.build                     |   3 +-
>  tests/qtest/milkv-duo-test.c                |  70 ++++++++
>  17 files changed, 714 insertions(+), 1 deletion(-)
>  create mode 100644 hw/char/dw8250.c
>  create mode 100644 hw/misc/cv1800b_clk.c
>  create mode 100644 hw/riscv/cv1800b.c
>  create mode 100644 hw/riscv/milkv_duo.c
>  create mode 100644 include/hw/char/dw8250.h
>  create mode 100644 include/hw/misc/cv1800b_clk.h
>  create mode 100644 include/hw/riscv/cv1800b.h
>  create mode 100644 tests/qtest/milkv-duo-test.c
> 
> -- 
> 2.54.0.1136.gdb2ca164c4-goog
> 

