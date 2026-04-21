Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4F89F327A8
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Apr 2026 06:12:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wF4L3-0002Vy-IW; Tue, 21 Apr 2026 02:12:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wF4Kx-0002VT-I7
 for qemu-devel@nongnu.org; Tue, 21 Apr 2026 02:11:56 -0400
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wF4Kv-0000Yk-Q5
 for qemu-devel@nongnu.org; Tue, 21 Apr 2026 02:11:55 -0400
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-4852b81c73aso32421745e9.3
 for <qemu-devel@nongnu.org>; Mon, 20 Apr 2026 23:11:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1776751911; x=1777356711; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=jD8WyQ5rH2Zwa84Ea9NtW6HBFWV7ZHyiCe4m6oiIFss=;
 b=wrM8mtna62QH4RSGBENa4dkB63oFVpmDUC3gOQLh2v7a0x6HZ86dwul2UinJwcXQqC
 3zegtUnPBcyy1o0/fYWzjHGD+dqsURpiffLMyk9ihXkJmr4GHDRlpHJZQnHVboDefEfN
 oyEZAiLrzFAUluJBRJBdR5Q966cUHQCxNYHHeVcEHU1fNPeM1XRiroTIFLywYBfabfG4
 NE+N5+Db6wjOt73/3FmDXTxGiOOldfZqvIdkv/+y2T+0p6NtS7p3eaMaBUrMcvitmt1v
 +gMKPCU/H0+75PFJcyE8fjWTIfDrFB0G91pG7qa0ZRLkh4DTqxPBhMDuILMOsem6XveY
 Vasw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776751911; x=1777356711;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=jD8WyQ5rH2Zwa84Ea9NtW6HBFWV7ZHyiCe4m6oiIFss=;
 b=PAAUHhLFrm0syvQr2fjAAfroQuU9zFhysgCmcY63E4P4pW5PhnQKMwiJs1jcLmE5DI
 UD5x9QOSqR6aBoPE9bzsZJAU6vGHfgrCAzlKKylkS0B8hL0oHo4NzYZnZouVrpp+UEJw
 FT22Awb+tT03KO4gjXom8ZO1orE6EoQK1Nfx4dIMhLMdmml8qNxmGl18s23EiOO1DsGj
 y6nVPCoQiA61aGf+aobecnmA9hLPJiRguoSKh1OTLgLFIbMxGVuTxmy+TTOtw8ZkGRWO
 casL0LHfe5PkpnAfQEDGhLxV7CAYrapgJQHlWJ5Vg9Wc1IYID2dhK/9Qrk3kmHaufams
 xvKA==
X-Forwarded-Encrypted: i=1;
 AFNElJ89iqW/XsDJS+fkxSSBuTmSjxNWPVOWFE9E6dewMl5vS5YJIB7MJphgO1wngmoDSAgfCZuiUJCZKw2V@nongnu.org
X-Gm-Message-State: AOJu0Yz7RiYOt/aIfCHg53cDlfp5sP9nfjAFSGZakyzYdONT9H4+4vdE
 BEF19rsuk52P6bu2RgV7gGgIR5F/2xxFHI6NptqOQIZ2b48/i+LEcBQqyKe3xwaiTfE=
X-Gm-Gg: AeBDievlBU2KFa3FstKwMZW3RgqQiOqbZViN4r66X/qz5jvI7fTZrKXppF7zAEGKZDG
 DP3xxeHmRypQB79SW1uBS8nNV5l3St201FqT/uonm5AWdTnCq0Nrrx0UxfigLteMuCFFiko4uDW
 pP2620QKS9coG/KfRxDdbFmTNX5+n3rkMw9IrO95JhihrGZPLZPjYuHcO1HznqmZOCWT/G/8VpY
 hp94pxAhjW61Vc84BbwUSLRzWuEEiIt4dagJikvCorS1fpVUqHDV1KmcXYtWfjXUt/nYf2tTKhR
 FpFk4uyjAo6bEdL/wyqmADBCLic4eQgHRb17lvrH+26N8jQILRl7gT0OMj4tsbALRentjXRMl3D
 2s5mUJskrULDOSZBq5Js2bkrXvCw6dE3pyJEEw7QcLKqXv9Z/mKCiFdXLJsxBq8LtDcQHITjWhI
 2EsffoBL9I9JbeOKus3YokaHOM1RG0mdFimLSNpdUIUddNC/qKLSTW7ZXMDr3PIw8pJueqZ7L6I
 eMj
X-Received: by 2002:a05:600c:1da1:b0:488:79a3:f04c with SMTP id
 5b1f17b1804b1-488fb7863femr248609805e9.27.1776751911467; 
 Mon, 20 Apr 2026 23:11:51 -0700 (PDT)
Received: from [192.168.69.228] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43fe4cb11b4sm35649605f8f.2.2026.04.20.23.11.50
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 20 Apr 2026 23:11:50 -0700 (PDT)
Message-ID: <d2feb7f0-b06a-414d-a94b-c89545c2cb6a@linaro.org>
Date: Tue, 21 Apr 2026 08:11:49 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 05/13] hw/riscv/virt: Move AIA initialisation to helper
 file
Content-Language: en-US
To: Joel Stanley <joel@jms.id.au>, Alistair Francis <alistair.francis@wdc.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Cc: Michael Ellerman <mpe@kernel.org>, Nicholas Piggin <npiggin@gmail.com>,
 Joel Stanley <jms@oss.tenstorrent.com>,
 Anirudh Srinivasan <asrinivasan@oss.tenstorrent.com>, qemu-riscv@nongnu.org,
 qemu-devel@nongnu.org, Nutty Liu <nutty.liu@hotmail.com>
References: <20260421053140.752059-1-joel@jms.id.au>
 <20260421053140.752059-6-joel@jms.id.au>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20260421053140.752059-6-joel@jms.id.au>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32e.google.com
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

On 21/4/26 07:31, Joel Stanley wrote:
> The AIA init will be used by any server class riscv machine. Separate it
> out in order to share code with such systems.
> 
> The virt machine keeps machine specific #defines such as
> VIRT_IRQCHIP_NUM_MSIS, VIRT_IRQCHIP_NUM_PRIO_BITS.
> 
> Reviewed-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
> Reviewed-by: Nutty Liu <nutty.liu@hotmail.com>
> Signed-off-by: Joel Stanley <joel@jms.id.au>
> ---
> v3:
>   - Add r-b
>   - Move fewer things out of virt machine into aia common code, as they
>     are virt machine specific and not part of aia. Done as part of this
>     movement patch to avoid moving them out only put them back in the
>     next patch.
> ---
>   hw/riscv/aia.h             | 26 +++++++++++
>   include/hw/riscv/virt.h    |  1 -
>   hw/riscv/aia.c             | 89 ++++++++++++++++++++++++++++++++++++++
>   hw/riscv/virt-acpi-build.c |  2 +
>   hw/riscv/virt.c            | 87 +++++--------------------------------
>   hw/riscv/meson.build       |  2 +-
>   6 files changed, 129 insertions(+), 78 deletions(-)
>   create mode 100644 hw/riscv/aia.h
>   create mode 100644 hw/riscv/aia.c

IMHO, since used by distinct machines, AIA should have its own entry
in MAINTAINERS.

Otherwise:
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


