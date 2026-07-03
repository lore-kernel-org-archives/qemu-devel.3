Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B26F8C43458
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jul 2026 09:42:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wfaP9-0001z8-2P; Fri, 03 Jul 2026 05:41:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wfaP4-0001yP-UZ
 for qemu-devel@nongnu.org; Fri, 03 Jul 2026 05:41:46 -0400
Received: from mail-yx1-xb135.google.com ([2607:f8b0:4864:20::b135])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wfaP3-0006cs-EF
 for qemu-devel@nongnu.org; Fri, 03 Jul 2026 05:41:46 -0400
Received: by mail-yx1-xb135.google.com with SMTP id
 956f58d0204a3-664c535f1a0so518564d50.1
 for <qemu-devel@nongnu.org>; Fri, 03 Jul 2026 02:41:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783071704; cv=none;
 d=google.com; s=arc-20260327;
 b=kLVD6XwyDqn1QoWFafFsfSRsSCdSMW8A5sdTLuTLVPUmW2kCx1+BgEiAWk2DJtchGu
 IQt2ezRlKXOp+XSYGTcUoK4BFcJr9XSmKO/mqWY4pTtGGoMdcfLMif7G6c25IGjM+1T9
 I1TUAZkgUOG3xNoPNnJAiCYN4bh+qZj/JNVj2ao3WOweECqmyOQB+JbqwkXr1j9PDHW2
 Q1rdKyTJ1VCCRF2YAfOppcagYLZ4edWBpEhisuK8jlTlf4yviomZvgoxVpilApKYJxbV
 N/BjzzfKtsQR6xFGH8gtl6g0ho0eSK+in4TdYc8WZLuTscGAu+bS/sLJZLmB5tDaNzYZ
 pLGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=jeONQzrl2bFXG2XJ9K7Xcc+CGiWXw/9fDJtGx17N6+c=;
 fh=i3aTsLkWDss7sATxxxnCTWo9SEUKd2dJ9ri4Q8kNJxA=;
 b=h/jLWp1jxYevo60jqD4bfBDAUrAxXfOplvQ4a7kvOwJMqZl4qu4T+s0e57y943byOQ
 0LpToKwHYV4wgO85Vn+KqaKsviOLPkv74AL52r/Ts6yIbn+lX6+VczOswO9ZcykfnRDO
 p7jIv1KUBoxump9qzku3YqYNiY9Kp3Fpux7qDeB1Lbba1hUUYPYMgxuxkcbFDd+rBkiD
 SV2towGdA5QwFYnH2uW+FJctjCHXKrLHS4pdPLC0MTZStlbdHPYM8b2onwcsADwnbPWh
 SK/3g8VTtb2vVkoYtZpyh9M1MRB0UCXpeOWTPsj3mTtcTLJSzK8dZSM5OFkulo5tosom
 qFxw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1783071704; x=1783676504; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=jeONQzrl2bFXG2XJ9K7Xcc+CGiWXw/9fDJtGx17N6+c=;
 b=luzm5Lia8heKOXjr1zRuWqg5wh2yvevoWkpguBwsm5fCJ1AmSLJ2q+XBnK5qVDbPr5
 O7j4kaufWDZ0/nVMuNsX2HxSETKDWEy9NoZi7YD5XkaIiciqoHv+95T66rKpbazrYedm
 Y5Xzd883pRor8NstVtkqUIjo9KweoTsl7csEYK+yb6/KsWWcF2xuoqP0gztphbBTrhXO
 6pb7GbB81+us/jytLy7NGPrzrDJGdtuxR1uJ3+66XBhYzzhMWJZhOWz7yL6HYnaxdCa7
 XStRSgIIdcA2LrXZ1Z+Ry6DDeUh7xuOLUM/mFySRSiWArfoW0GKIJadFk47ym2xbnKeX
 4nTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783071704; x=1783676504;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jeONQzrl2bFXG2XJ9K7Xcc+CGiWXw/9fDJtGx17N6+c=;
 b=rl13VAf1T2ceOGA34UqbN7sMFu7Jq3QsAMkacFksET8VwpD8CWmFqe2+3PWzfEuz6r
 rAvVudARQXOyTBetWjBJOTLrahMuF5ip/jtdR/1SVs0Xif3ERA4mS2epO3XBhM+7NOwQ
 g6vRSYWx8NdgcZdKlbgrkQqzf+2htd3WnE2zk5zjYzcHM+aMoUCTVohLtLRw6ixXJ5he
 fUXNXN0f7cVsTQ1aGeGnok5NiKz+vsOn0tg9jPC+Q6B9UFoJFITxJ3pjE8w4eThKTbXQ
 AG4t39aZAPsL2xhLllt8TQ3hDyiY5JCUXgivhg5yFFo113VcuIbI3Yo0pH3v1aKpboVM
 Q5Kw==
X-Gm-Message-State: AOJu0YyWB2HjUttncmvcy38PYSFpTlnh8MPHwuC/AxYNRpg4spyWwOcM
 hb5kR7PNfkSD6ucY+vbFuAOeb0mh8/Xv8zJWYWdGenEgQxRwlEwX+Rf58wO7m6WA5H4H90ZuJ01
 zlmBiNA5P9KQ7BhAwju1ZX01KXiWwchgPluyQpJdNbPKnZVcMeuZh
X-Gm-Gg: AfdE7cmK200R6Hty8/qAilByEXU7iOEClYGB98sPJk7O5wzf640tImQTuqlXAxAcNFc
 9bzFmpEdLioyrlSpmDhZhn1YygMkPyE64Qaa15KiUpFIL6cOZDE5CWxeT2oJbUZMVFjZdehqlcs
 iidYwP18g3+RzPtGPpqD6B9iU3nxH54Ppbq0kCTalC0sfbd/zA/BGYRv+xvz1+cwmJQRDQoL+d+
 VynI3GsL79iqTB79T3z4z6PKW5oUkB0IqI4zEFpgdSZjr0SAbkWx6vsoHbWku47lNfXubfoOwol
 AKkH3ncWqZR3M5UnDNkaaLYyHM8eozv27u/dZmUU7C/BmeeXnKmffYy+
X-Received: by 2002:a05:690e:d03:b0:666:27de:9b5 with SMTP id
 956f58d0204a3-66627de0e48mr5854988d50.20.1783071703863; Fri, 03 Jul 2026
 02:41:43 -0700 (PDT)
MIME-Version: 1.0
References: <20260529174639.451353-1-peter.maydell@linaro.org>
In-Reply-To: <20260529174639.451353-1-peter.maydell@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 3 Jul 2026 10:41:32 +0100
X-Gm-Features: AVVi8CdBznoWikXy_P2bJZkfJdF_S50WSIHLDOw0ZeVxMFLPxrMY-nX_Z7N8Iw0
Message-ID: <CAFEAcA9GDPyd19-fdoepJesSbw=eZfPtPDTsa++yZ1F=j3p87Q@mail.gmail.com>
Subject: Re: [PATCH 0/5] hw/nvram/fw_cfg: Document and tighten up register
 layouts
To: qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Sergio Lopez <slp@redhat.com>, 
 Song Gao <gaosong@loongson.cn>, Bibo Mao <maobibo@loongson.cn>, 
 Jiaxun Yang <jiaxun.yang@flygoat.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
 Alistair Francis <alistair.francis@wdc.com>, Weiwei Li <liwei1518@gmail.com>, 
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, 
 Chao Liu <chao.liu.zevorn@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b135;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb135.google.com
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

These have all now been reviewed. Since fw_cfg is marked as
Orphaned in MAINTAINERS, I'm going to take the series via
target-arm.next. Let me know if anybody would prefer something else.

thanks
-- PMM

On Fri, 29 May 2026 at 18:46, Peter Maydell <peter.maydell@linaro.org> wrote:
>
> We support the fw_cfg device on more architectures and machines that
> we let on about in the documentation.  Luckily most of the new ones
> (notably riscv and loongarch) have followed the straightforward layout
> that the Arm virt board picked. Allowing every machine type to have
> its own special-snowflake register layout has no particular benefits
> and tends to result in guest OSes accumulating ifdef ladders to deal
> with all the unnecessary variation.
>
> This patchset:
>  * updates the docs to present the arm/riscv/loongarch memory
>    mapped layout as the "standard" layout to be used by all
>    new architectures/machines in future
>  * adds the layouts used by various existing boards that we
>    didn't document (PA-RISC, SPARC, PPC and MIPS)
>  * tightens up fw_cfg_init_mem_dma() and fw_cfg_init_io_dma()
>    functions so that they don't provide flexibility to the
>    caller to pick their own weird new layout. None of the
>    callers were using this flexibility, so it's better to
>    have fw_cfg_init_mem_dma() give the "standard MMIO" layout
>    and fw_cfg_init_io_dma() give the x86 ioport layout.
>
> thanks
> -- PMM
>
> Peter Maydell (5):
>   docs/specs/fw_cfg: Document all architecture register layouts
>   hw/nvram/fw_cfg: Enforce standard layout for fw_cfg_init_mem_dma()
>   hw/nvram/fw_cfg: Enforce standard layout for x86 fw_cfg I/O ports
>   hw/nvram/fw_cfg: Remove support for I/O port fw_cfg without DMA
>   hw/nvram/fw_cfg: Document fw_cfg_init_mem_nodma()
>
>  docs/specs/fw_cfg.rst     | 28 ++++++++++++++++---
>  hw/arm/virt.c             |  2 +-
>  hw/i386/fw_cfg.c          |  3 +-
>  hw/i386/microvm.c         |  3 +-
>  hw/i386/pc.c              |  3 +-
>  hw/loongarch/fw_cfg.c     |  3 +-
>  hw/nvram/fw_cfg.c         | 22 ++++++---------
>  hw/riscv/virt.c           |  3 +-
>  include/hw/nvram/fw_cfg.h | 58 +++++++++++++++++++++++++++++++++++----
>  9 files changed, 92 insertions(+), 33 deletions(-)

