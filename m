Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2BA4BCCD1BB
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Oct 2025 19:06:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vBe9M-0004Cl-Nr; Wed, 22 Oct 2025 15:05:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vBe9K-0004CK-JZ
 for qemu-devel@nongnu.org; Wed, 22 Oct 2025 15:05:30 -0400
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vBe9G-0006hv-OP
 for qemu-devel@nongnu.org; Wed, 22 Oct 2025 15:05:28 -0400
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-47118259fd8so46505195e9.3
 for <qemu-devel@nongnu.org>; Wed, 22 Oct 2025 12:05:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761159924; x=1761764724; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=mFHQoIrkwRBBI21maXbOknx1lG8OaPkENBvYDp7hT28=;
 b=xqX7TreocCKVPFiGGDXOyPBbrZeou9Rx55ldTcVOkaloi/39zSUUcOgmITte/c5Rki
 5RmsrTUyPv3Uyt8xuoc7m984g8jCuD5pAu8wQPmbw83PZFbbWPUgs+l5TwLhSjDXwCWs
 Mb9pZpW8LVSxGfQqfyiaF/8n1icNDVHXfjJbScZb9ez9yIR/XkJ+E4ME6gwTI6hsfYD1
 lOPEVZ0y25BXWLQEPrmwfWAPGSRLaMNONvZNhCtbuiaI4/rR8A1vdrZvNWfaD1FREeLK
 8pqCVi/xwoeE3r/lJXcwrGQa6D3KonLZcQRikO8m8wu6sUx9GceaJ5QkemGFC8/f2Zru
 Q0OA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761159924; x=1761764724;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=mFHQoIrkwRBBI21maXbOknx1lG8OaPkENBvYDp7hT28=;
 b=kOesBBtHOf/FGMYJU8QHM0m46ZAtK9yRH3TMaqYGJMrLz8m8qujYhdvmsLr1Z4WspL
 rqhq+9XFoFebAx1mxCgdMLBHCQS7ClCJkzBrw4MH86i8AM4VCMp1F6i+858CuaYx+/8o
 C/B5LHagfQufxHoW7fADfGF5Pi1cjU2al133anRHylwgtNtjqLYuOQgJjvrrMqKwNn72
 K1Ii1CRFaus5gd2AjPsWPKl8uGLM9kBHxNord/P3OTCcJQOR+gg0uhfltQuYUivn+CcR
 8Un0EHoN3+wZkb7BgcpUvqbTpV1lz6TuHYA2prI9upCLf5g7PFwinhxmIrkIAOsyAqBD
 TD2w==
X-Gm-Message-State: AOJu0YxmXtHb/zjhHgNknCxdc/A82kimiHSPeYReWqrxihI3jMQ6eRIK
 y+hbLN9bjFctcknsRhgim38mcuhZTXRFU1Y9yjwpImUYDuwWipbyKaJ/I81BXMqvPJs=
X-Gm-Gg: ASbGncv193baaRcq3jWrd5qQa/7l5pBY4GcnmwLgJi3fv15GbVA5saZymzN9/TqY6SR
 YFYpU9WTKyOLLUNvgSJ/qPhCbqKWTBuGILMaVAJEhDbXudT0WQPYySo2XuCITSOLABsuts3PkwS
 Yw+rO6Yc6ftgqRGtfzoQeJYKy36WMdf5W8V29d3FwawJT745C2uz0RcnlOsrFkgBqFsf/un2yS0
 1XvWDTexyEsrOA58Rma3bFG9TrclnN/7kOr5H/aNsgiFzPjPou94GeLYmrNpf1IiqbHryBtLdIl
 gsbvpPr929l9AeONBa0Hi8VxFVuOHiHNJb7eiF20in8tfljnkSCudj5OfnUauIhG8VJvmslQ+fw
 cS55O8xuOHlsfKI2f0/LxXoBA+A/Q+8/SUZaMcWwbyLaT/fW3PjpRttsBIk9Njdsyknubs72fCY
 DUnJsWRfOVJiDHa8z7ny74LnLTALGtXGwYZcp4Fcw97y0=
X-Google-Smtp-Source: AGHT+IHSxi/OdfUTcjO3Z9vsqVWagnzsvV/2KHfQRgWzt228GxYfdALmFKiFmP6o3WM7EJjGUntAOQ==
X-Received: by 2002:a05:600c:3555:b0:470:fe3c:a3b7 with SMTP id
 5b1f17b1804b1-4711786d42dmr162318745e9.5.1761159924504; 
 Wed, 22 Oct 2025 12:05:24 -0700 (PDT)
Received: from [192.168.69.201] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-474949e0a3csm44816625e9.0.2025.10.22.12.05.23
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 22 Oct 2025 12:05:23 -0700 (PDT)
Message-ID: <62d5c5d1-529e-4344-b8a7-f058d65ae8cf@linaro.org>
Date: Wed, 22 Oct 2025 21:05:22 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] hw/ppc/e500: Check for compatible CPU type instead of
 aborting ungracefully
Content-Language: en-US
To: Thomas Huth <thuth@redhat.com>, Bernhard Beschow <shentey@gmail.com>,
 qemu-ppc@nongnu.org
Cc: qemu-devel@nongnu.org, BALATON Zoltan <balaton@eik.bme.hu>
References: <20251015111243.1585018-1-thuth@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20251015111243.1585018-1-thuth@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x336.google.com
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

On 15/10/25 13:12, Thomas Huth wrote:
> From: Thomas Huth <thuth@redhat.com>
> 
> When using the ppce500 machine with an embedded CPU type that has
> the right MMU model, but is not part of the e500 CPU family, QEMU
> currently aborts ungracefully:
> 
>   $ ./qemu-system-ppc -machine ppce500 -cpu e200z5 -nographic
>   qemu-system-ppc: ../qemu/hw/core/gpio.c:108: qdev_get_gpio_in_named:
>    Assertion `n >= 0 && n < gpio_list->num_in' failed.
>   Aborted (core dumped)
> 
> The ppce500 machine expects a CPU with certain GPIO interrupt pins,
> so let's replace the coarse check for the MMU_BOOKE206 model with
> a more precise check that only allows CPUs from the e500 family.
> 
> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/3162
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>   v2: Drop the old check for the MMU_BOOKE206 model
> 
>   hw/ppc/e500.c | 6 +++---
>   1 file changed, 3 insertions(+), 3 deletions(-)

Queued and merged, thanks!

