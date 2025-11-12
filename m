Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 166A7CCFA1A
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Nov 2025 11:35:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vJ97g-0006ao-P5; Wed, 12 Nov 2025 06:34:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vJ94s-0005yu-F2
 for qemu-devel@nongnu.org; Wed, 12 Nov 2025 06:31:57 -0500
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vJ94p-0004La-Pt
 for qemu-devel@nongnu.org; Wed, 12 Nov 2025 06:31:53 -0500
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-477619f8ae5so5426985e9.3
 for <qemu-devel@nongnu.org>; Wed, 12 Nov 2025 03:31:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1762947070; x=1763551870; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=YvVPXdYbfHwfM8CajHFtkN7+K4UKu3FmToITsG04s2U=;
 b=Xi8nwWPoU+EqTXwxtd2Tm/OlUatK0Rg3NCO4bIjtx+Asbu22yWPTwK4BFilBQRcH8S
 S/vciqMzjo0EPpxMbRbo3nSYB135y8XB+kxKoBZ1sHPInLK1ku1atGoyerH/c14ZvC6X
 5HC7NDiKvapGzIIsmEDPlwTBimEEiUpcVbgUSMWAfD5WL80PFc8VbJWlttc/cav4nfrX
 9IMTpG08AWsxi8IjkDG6wFwIaJqYjiPrBfS/d/K0eYmnXOs9W2dEEuznmumKckJRACYH
 4lihSuo6wAt4GoOUxK7gCDLsxZfXEQJFOYPQzyQrGsnzwYNV3mjRLDZraq0MEMsWbo1w
 byaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762947070; x=1763551870;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=YvVPXdYbfHwfM8CajHFtkN7+K4UKu3FmToITsG04s2U=;
 b=a+J9PbVKsH2g4tyMWvV5fc62Dohk1rrwhTwmNVjh/7senOXgLupNkXUdilB9AVB2PI
 RN37W/zqGz0m9+8vsA2Jr18lbk2Yh5pzF4TNICcIKoPivLSuf8RJfccBORlvtWWWijHO
 nBbZeZYLa+beXyyUlTjQeNNcMc8E2rgTxxAkXccwJvbWix4XdxzP8jEld2kcDybTHz+e
 dsPgbzsYiA6My7wh+OcweOv/9pdpH1MPTNBQzBKgQ63WRBSaI1v9C45HosIwQj/zRvtp
 9bgYsrCazP2lfK7seM93DY6ble4mgTh0BjqpyGostXuQjJE7bVOoC4FdxgFQYdBU+ELB
 tEsg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUghkqoNFiYNn9GvS3k301Djsh9OT/2YBvn8s+rEvX0gi5t4c14t/QPLvJWttTEPxd/qwUB56OdEVDW@nongnu.org
X-Gm-Message-State: AOJu0Yy1qzBWntYrpw21Q9XU1POS6NQiNxyYU6q5WTNXDmuSrSWDe5yZ
 nRhXaoIE2sHYk44qaC/GLd0ai3vkiXNdtJnq6gS/O9ujZ9MUp1eE9OE7SiRo/4RqbpM=
X-Gm-Gg: ASbGnct0N1uEAJtu/pdHwiHWNBPI9LdlbUXwpL2CZW9sEV0n2nJ1J5YhgUSkpK9TJ8c
 Tm5FUMSMxnAwFKJfXtF5nEdD9FQW4A0mcA/qKFeU0YXEiaG9S6LBseCX51FzP5Y14C/TS/ffgju
 I5XqqcRQ0jmvOy2xcFWb5jROoe76H8TLNuxg+s1hat5497IayqGz20/krq1zaczHuoZpkp1UYPG
 6tzGQovYFlXiPT/SZ8mejWVZYzGxJpT0A6HoHCSEPqzmGMD+YxuIhs6971Y5TMz9zTDAHLI/MhT
 QFY3PrJ+W/e+Ey3hRDPUHLbL7R4K/u8m2HGP7f/O6vXPWb8mojIgkGaM4Ml5vb5n/7qEaEZZ+Fi
 x8HpNDfjrkow+bHKqnlV+FLyagz1BtpIvO9dgTm1uGxslgtIZU96oGFKMRCqzhYgbE3xa9EOwvX
 JenDFh60EE845cQeSbYcZpWLrji1ID/AiFzuf11DGblM4=
X-Google-Smtp-Source: AGHT+IHWiFdSb/J64SsgfuKIugDKj30LxQVwkZldEfWHaXByqOM3ud3g9o7sMRo0P3EmD/yuMMZXmQ==
X-Received: by 2002:a05:600c:c87:b0:471:1d8e:3c4f with SMTP id
 5b1f17b1804b1-4778708664amr19434235e9.24.1762947069769; 
 Wed, 12 Nov 2025 03:31:09 -0800 (PST)
Received: from [192.168.69.210] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47787e45677sm31010455e9.8.2025.11.12.03.31.08
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 12 Nov 2025 03:31:09 -0800 (PST)
Message-ID: <69e61674-df92-492a-a982-a94f7c979621@linaro.org>
Date: Wed, 12 Nov 2025 12:31:08 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH-for-10.2 v4 08/15] hw/dma/zynq-devcfg: Fix register memory
Content-Language: en-US
To: =?UTF-8?Q?Corvin_K=C3=B6hne?= <corvin.koehne@gmail.com>,
 qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Yannick_Vo=C3=9Fen?= <y.vossen@beckhoff.com>,
 qemu-block@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>, Alistair Francis <alistair@alistair23.me>,
 qemu-arm@nongnu.org, =?UTF-8?Q?Corvin_K=C3=B6hne?= <c.koehne@beckhoff.com>,
 Kevin Wolf <kwolf@redhat.com>, "Edgar E. Iglesias"
 <edgar.iglesias@gmail.com>, "Edgar E. Iglesias" <edgar.iglesias@amd.com>
References: <20251111102836.212535-1-corvin.koehne@gmail.com>
 <20251111102836.212535-9-corvin.koehne@gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20251111102836.212535-9-corvin.koehne@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
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

On 11/11/25 11:28, Corvin Köhne wrote:
> From: YannickV <Y.Vossen@beckhoff.com>
> 
> Registers are always 32 bit aligned. R_MAX is not the maximum
> register address, it is the maximum register number. The memory
> size can be determined by 4 * R_MAX.
> 
> Currently every register with an offset bigger than 0x40 will be
> ignored, because the memory size is set wrong. This effects the
> MCTRL register and makes it useless. This commit restores the
> correct behaviour.
> 

Cc: qemu-stable@nongnu.org

> Signed-off-by: YannickV <Y.Vossen@beckhoff.com>
> Reviewed-by: Edgar E. Iglesias <edgar.iglesias@amd.com>

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

> ---
>   hw/dma/xlnx-zynq-devcfg.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)


