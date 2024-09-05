Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1779DCD5BD4
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Sep 2024 16:28:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1smFKz-0005qH-Ey; Thu, 05 Sep 2024 12:28:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1smFKx-0005i6-4W
 for qemu-devel@nongnu.org; Thu, 05 Sep 2024 12:27:59 -0400
Received: from mail-ed1-x531.google.com ([2a00:1450:4864:20::531])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1smFKv-0008Se-Cg
 for qemu-devel@nongnu.org; Thu, 05 Sep 2024 12:27:58 -0400
Received: by mail-ed1-x531.google.com with SMTP id
 4fb4d7f45d1cf-5c245c62362so1307293a12.0
 for <qemu-devel@nongnu.org>; Thu, 05 Sep 2024 09:27:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1725553675; x=1726158475; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=keygZ2eFxDOr4bAQfX6rzwmPXVMg+cYWF6Ayf0+YV3o=;
 b=KX1it9/OLq2A77BqIYJY7FTU7HeCE5EaBfNNcxwWymTIbxuet2Jlcl1jmPLUU2hdYb
 wdYa/L1lxz+IcGcHqGr6eVlQrMOY3QaeB99tzg5RdNy9HPqcW/IZKui/SUFBBRYDm4vC
 S+NEC9aQzDc5n2JbOmNOpGMWXyEpR4LcfyrXe/OdjPezMPcuWOdWiqG3c9cseOFVw+wn
 TrLVCqFGnQ09w+7l+ii9eYTYBVb7bYHxkm5LSbcN6f/z0dUp2LLAZ6BoWuPZRlVnmfvN
 OJw9gDKSImE7OXqYDGERMeV4maf0xLbTQLzROXf13lIN170SRi8j9IVuoK27srdDdVwI
 9p/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725553675; x=1726158475;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=keygZ2eFxDOr4bAQfX6rzwmPXVMg+cYWF6Ayf0+YV3o=;
 b=FdUqm2AyLh7q926jE821mB1FQSTPh+HbFqZd3hh9hBexFIGiT+ecsxcTjZjAILuOCv
 47It/BuS+2q0uU7m/D9Glss1FJc3yRThUJqrROF/xf2LKaPNjh9bKjBVIQXQgq4I79Te
 h+tVmrYXXJpqC7vbPVzux8WYkAV7S2gD5aVdLnfuiS0ZW4fE9CBv1R5zFUCalcn1IHAs
 st39so4fkRsgJVUczSUawqEIZgSgA6m7p7tzevqYQHVP0mgPVGyYjLgPoU6YP+Rb+N7o
 u7mZfXrBUOnKvXABE1ISoxvtWJ3c9A7qQDaliSffcKJiAnX6PlIiCfmUjJKWBHjIY0bB
 mA0A==
X-Gm-Message-State: AOJu0Yy7nRH8/9TfPXYO0/FxusP09hJUNrJ5kGS8R7dUMzxYOFEpOrBT
 0H+P07NUBAg1f94KjPw12dB+PvfEAiYPrNRWMneDWJjjYcmB+ysyrmgihfj9fTv/xa7eiGrt5t/
 vKw5G5/3vo8FirxJr+fhNMGDebLhHuBslXWDBwQ==
X-Google-Smtp-Source: AGHT+IEz6sRxe/3hMOSER+YAj1Uows6NvdSEOJG02iCROPTl/h8il9/GtNoNQTrW0Vr9d5RihsVKNNZyvqQNqmUcMyg=
X-Received: by 2002:a05:6402:2549:b0:5c2:6e51:9d22 with SMTP id
 4fb4d7f45d1cf-5c275831da7mr6383108a12.25.1725553674586; Thu, 05 Sep 2024
 09:27:54 -0700 (PDT)
MIME-Version: 1.0
References: <20240904161537.664189-1-edgar.iglesias@gmail.com>
In-Reply-To: <20240904161537.664189-1-edgar.iglesias@gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 5 Sep 2024 17:27:43 +0100
Message-ID: <CAFEAcA-XB0286jF8h8Mev1wyygokRHHjnv_=D3qgSiLsb1zSsQ@mail.gmail.com>
Subject: Re: [PULL v1 00/12] Xen queue
To: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
Cc: qemu-devel@nongnu.org, sstabellini@kernel.org, anthony@xenproject.org, 
 paul@xen.org, alex.bennee@linaro.org, xenia.ragiadakou@amd.com, 
 jason.andryuk@amd.com, edgar.iglesias@amd.com, xen-devel@lists.xenproject.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::531;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x531.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Wed, 4 Sept 2024 at 17:15, Edgar E. Iglesias
<edgar.iglesias@gmail.com> wrote:
>
> From: "Edgar E. Iglesias" <edgar.iglesias@amd.com>
>
> The following changes since commit e638d685ec2a0700fb9529cbd1b2823ac4120c53:
>
>   Open 9.2 development tree (2024-09-03 09:18:43 -0700)
>
> are available in the Git repository at:
>
>   https://gitlab.com/edgar.iglesias/qemu.git tags/edgar/xen-queue-2024-09-04.for-upstream
>
> for you to fetch changes up to 0b57c8160a2a6c833cfb1d958f08385c4391ab70:
>
>   docs/system/i386: xenpvh: Add a basic description (2024-09-04 16:50:43 +0200)
>
> ----------------------------------------------------------------
> Edgars Xen queue.
>
> ----------------------------------------------------------------
> Edgar E. Iglesias (12):
>       MAINTAINERS: Add docs/system/arm/xenpvh.rst
>       hw/arm: xenpvh: Update file header to use SPDX
>       hw/arm: xenpvh: Tweak machine description
>       hw/arm: xenpvh: Add support for SMP guests
>       hw/arm: xenpvh: Remove double-negation in warning
>       hw/arm: xenpvh: Move stubbed functions to xen-stubs.c
>       hw/arm: xenpvh: Break out a common PVH machine
>       hw/arm: xenpvh: Rename xen_arm.c -> xen-pvh.c
>       hw/arm: xenpvh: Reverse virtio-mmio creation order
>       hw/xen: pvh-common: Add support for creating PCIe/GPEX
>       hw/i386/xen: Add a Xen PVH x86 machine
>       docs/system/i386: xenpvh: Add a basic description


Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/9.2
for any user-visible changes.

-- PMM

