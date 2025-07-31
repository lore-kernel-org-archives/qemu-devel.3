Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F089C87FCA
	for <qemu-devel@archiver.kernel.org>; Thu, 31 Jul 2025 21:54:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uhbDy-0001Qn-I1; Thu, 31 Jul 2025 17:54:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uhav6-0002te-Q6
 for qemu-devel@nongnu.org; Thu, 31 Jul 2025 17:34:39 -0400
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uhav4-0000DV-9P
 for qemu-devel@nongnu.org; Thu, 31 Jul 2025 17:34:36 -0400
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-45610582d07so9933415e9.0
 for <qemu-devel@nongnu.org>; Thu, 31 Jul 2025 14:34:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1753997672; x=1754602472; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=bjSJeYANY2ZbkmzGr2mc8SbZEDqqyUD89yHv/hj73V4=;
 b=r+3YjNv0yF4g2LGRNEcYAS4cae5lOJGR/104dzu7Qa4LQybVKC+aHNfJmp7MSBsQdA
 EVAVUAPvbKIsNVxQCkXIA9nXz78/veEh3w5sUIkioPDn5XI1AEsDE0yrkAwY7Ra6+sdv
 sZDQgGZhMYC0LOzS/dXxFu4pdg7waPuAPeDIcyQbeWFKQdevuwdqlF4rlIUiAzcOtEEw
 rQ39KoF0sPbfPBdhk4PX/xDlj1tOJcdJ7KZJWJs7mxKwy9csaWbvX6CtEccMJFNqhFDd
 IwfRPgKnrSTZmGjiyIns+AJdMCwMsW4KcMbWxx9yk0ubaGHPobYP8o4DB9gb9Y9Yci1G
 UwRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753997672; x=1754602472;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=bjSJeYANY2ZbkmzGr2mc8SbZEDqqyUD89yHv/hj73V4=;
 b=Fwqitk2OA3z/L6LsJ/4SinT0VC3fghdIG1r+vm+4MpyOxD9ohwr+PiFenyjxMsz58O
 dQRbUuf//ppR4IuyFbGSc0PiFXqrGDBFnCwLRX4yOWNdFzd237vYYIl/7lGb31V0VjYV
 pmEyYviWvlJgyVa0mFdbTPilLV+73g3pnBX7EzldGx6MOtlXFKsFG7G746wvM4Xjhbdg
 2+DNFa/+WaNhHrQkS28Vp8d11SAg9SvoRTX3t8jgU0EqKxRdtNfROFaAsmIh20Usl0OM
 aE0XmHGYPGWUiQSs9y4KQS1bszO9aQFt9MkUM2xV7JxkdJtlUn1sczXqZpmiOSekdbXB
 WLGA==
X-Gm-Message-State: AOJu0Yw+PMymflvpOo+NCW4dYnIHGr3/2MqZsplSr2uB8P3tTROYNhxr
 2iggrBVS8AeqlPj4K0zrHEB2xnJdD7xjKj5vCZufY7UjrmSViyByMV6xi1C/XG/bAk0i5khate7
 AlEnd
X-Gm-Gg: ASbGncsWI/YeA9hSvoT2Jru0SqPtmxGTyFR6ENMVIKfhX/ENTGFYNPUZrX74YmpUIRI
 MovLWEIYsS8YyJjIMmzEk1PsB16n0WEVlaosVGramOaZ5lqjM3I/jPEDy9XEz5GYuyQ/dRGPjV/
 Tyzoatx1YhALKmvEakhMKDtOSvDg3bsJkBC5rAUQaSgDh17TxovOnJ/ZSPfJKNp1y8YvIVtZKyn
 aRb+nHF9uSkj7zzSbfx2AgRGHzn/3KZlX2ZafiI9jw4mhibmD6QcX74AhstUqVLfvUNWC6WRqi5
 FtqNeogTaAsVlrLxf86KR68tfl6o5khv86WVWpHPH3+NwiTbdcn8KvBB68/DGl9Gj+fqz+24X63
 DFg379/U5tLLvNEwVbHw+ANe3RsUmEMmBdiNTxcobKl2oAwEZGrtQMxLFH7lo5mlcAPTTlzwXYX
 it
X-Google-Smtp-Source: AGHT+IEfnpW7zebG93f80H9euFZA1sOew1SvR0bPmhph/xnoa5mSY1Lx3e94xTviawluzWDrFuqVHw==
X-Received: by 2002:a05:600c:6295:b0:442:c993:6f94 with SMTP id
 5b1f17b1804b1-45898c02c1cmr79980775e9.12.1753997672343; 
 Thu, 31 Jul 2025 14:34:32 -0700 (PDT)
Received: from [192.168.69.209] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4589edf55e4sm40916655e9.2.2025.07.31.14.34.30
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 31 Jul 2025 14:34:31 -0700 (PDT)
Message-ID: <9652db52-68d2-41f6-8db4-94c31eecf35c@linaro.org>
Date: Thu, 31 Jul 2025 23:34:30 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH-for-10.1 00/11] hw/sd: Fix SD cards in SPI mode
To: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>,
 Luc Michel <luc.michel@amd.com>, Jamin Lin <jamin_lin@aspeedtech.com>,
 Sai Pavan Boddu <sai.pavan.boddu@amd.com>, Joel Stanley <joel@jms.id.au>
Cc: Guenter Roeck <linux@roeck-us.net>, Palmer Dabbelt <palmer@dabbelt.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Strahinja Jankovic <strahinja.p.jankovic@gmail.com>, qemu-riscv@nongnu.org,
 qemu-arm@nongnu.org, Bin Meng <bmeng.cn@gmail.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Beniamino Galvani <b.galvani@gmail.com>,
 Ben Dooks <ben.dooks@codethink.co.uk>, Weiwei Li <liwei1518@gmail.com>,
 qemu-block@nongnu.org
References: <20250731212807.2706-1-philmd@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250731212807.2706-1-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x329.google.com
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

(Cc'ing few more ppl who worked on hw/sd/)

On 31/7/25 23:27, Philippe Mathieu-Daudé wrote:
> This series fix a pair of issues with SD cards used wired
> via a SPI link / controller.
> 
> Such mode implementation was minimal. I was testing it with
> the ARM Gumstix machines, but we remove them in the v9.2.0
> release (commit a2ccff4d2bc ), so they bit-rotted.
> 
> Although the series looks big, I shrinked it a lot to have
> the minimum amount of meaningful changes. Other changes
> added during debugging will be shared later, as I believe
> they will still be useful to debug other future issues.
> 
> The last patch add testing coverage, to avoid further bitrot.
> 
> Regards,
> 
> Phil.
> 
> Philippe Mathieu-Daudé (11):
>    hw/sd/sdcard: Do not ignore errors in sd_cmd_to_sendingdata()
>    hw/sd/sdbus: Provide buffer size to sdbus_do_command()
>    hw/sd/sdcard: Propagate response size to sd_response_r*_make()
>    hw/sd/sdcard: Fill SPI response bits in card code
>    hw/sd/sdcard: Implement SPI R2 return value
>    hw/sd/sdcard: Use complete SEND_OP_COND implementation in SPI mode
>    hw/sd/sdcard: Allow using SWITCH_FUNCTION in more SPI states
>    hw/sd/sdcard: Factor spi_cmd_SEND_CxD() out
>    hw/sd/sdcard: Disable checking STBY mode in SPI SEND_CSD/CID
>    hw/sd/sdcard: Remove SDState::mode field
>    tests/functional: Test SD cards in SPI mode (using sifive_u machine)
> 
>   MAINTAINERS                               |   1 +
>   include/hw/sd/sd.h                        |  23 ++-
>   hw/sd/allwinner-sdhost.c                  |   5 +-
>   hw/sd/bcm2835_sdhost.c                    |   5 +-
>   hw/sd/core.c                              |   5 +-
>   hw/sd/omap_mmc.c                          |   2 +-
>   hw/sd/pl181.c                             |   4 +-
>   hw/sd/sd.c                                | 202 +++++++++++++++-------
>   hw/sd/sdhci.c                             |   4 +-
>   hw/sd/ssi-sd.c                            |  96 ++--------
>   hw/sd/trace-events                        |   4 +-
>   tests/functional/meson.build              |   1 +
>   tests/functional/test_riscv64_sifive_u.py |  51 ++++++
>   13 files changed, 238 insertions(+), 165 deletions(-)\

Without the 51 lines added by the test, only 22 lines of C are added =)

