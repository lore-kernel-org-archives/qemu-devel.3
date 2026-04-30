Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B618ACD13D2
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2026 20:50:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wIYKm-0000sm-7p; Thu, 30 Apr 2026 16:50:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wIYKk-0000p2-OS
 for qemu-devel@nongnu.org; Thu, 30 Apr 2026 16:50:06 -0400
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wIYKh-0003wJ-0y
 for qemu-devel@nongnu.org; Thu, 30 Apr 2026 16:50:06 -0400
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-488b8bc6bc9so9110265e9.3
 for <qemu-devel@nongnu.org>; Thu, 30 Apr 2026 13:50:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1777582201; x=1778187001; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=c72N+XNS6m4/eQLFphJM8huNo348/tMjIvljFWKaLrA=;
 b=qN02Ldlz+5UZeCtJ59akDOyyYOhbPH5+DeYVf5AK6uV8pLX7UanR0Cv4vWU3CC5rOv
 N5h1fuGvC4aCoZ8wU51q/apyLInXjU/Hs38VHIuYxF8YFFPkx0srn9ye+kB0l7j5hBCJ
 aYoKrcIkQjp/5e9Iip2TtRiXXiOAeL5+sxru+sAjS9Iiwla9zlDK5EIw2IMT62i5vuG1
 mjb2brbxR0eOzrYDo3B3iml55gqDSy+lyyxNgqALxEIzSq+IYuMFmfCqyim71BXMANEv
 km85MbMJQXCJdQj7yV8HrsrGKO3j5a5shJ6G3CH0L5dwiilg50w7/kZImm4EmkDiCY1l
 2rzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777582201; x=1778187001;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=c72N+XNS6m4/eQLFphJM8huNo348/tMjIvljFWKaLrA=;
 b=KQx6ZtwhKE26Q7hlK1YArBruZsHF+XyBA+T5CzJ20IGc1U0BqIqW1zrndU3cb0kJSc
 jYEItuWGhadrskNXcHPgfdokcmDrh+Uw6gG0WhG2yGjacy8rMnLM+Mk2pcy95QtI7qIk
 zOwm0AdUNm4ireF0PE9x7Ibjkf4tgFpQzo5tyORyz96IMWokWr7YuqGiT4q6hqWsjgiW
 EFGSDk1vFzV3TmluP15atrrvPud8u3H0x3Ow8fdeUQivTw/xZnSJ2Ud4IVkYzqY9MFkn
 0xCtWtEz6ZyxXfJ5G9R+vjZ+w83TXqeeI5kDn3U7XbPVZdM7Mgb8IGDJc7ssy1KwG/T1
 cK2w==
X-Forwarded-Encrypted: i=1;
 AFNElJ862WaopIsDAWSPoosZm1Z6O6i7pZsjy3KjhmU1t2ydZAYvPsAl9+2ySbxM9sk7QftUSHawCkUJHVKy@nongnu.org
X-Gm-Message-State: AOJu0Yw2My+EdTB/gzLwC9A/v3jkhMKQkDU6EnfXMhscVd68MGWnLzIU
 w4p1j8cMcFBZTokFL2TvsxUyW4K/YWOXq/cl6scPydNxjHZfDlWUNi16ruC1f3zEeyP8ME04hpD
 6sWAp9Go=
X-Gm-Gg: AeBDieu+EpC4Uy3BznUgt4VdeALWUFSvhlLcs4YsMt+40CtSgQ5WdgTaGjayCdcohjG
 PSXcldnjcJKb1kWgD0gpuPwGI6m6i+l8RhRVzJxPPdwrqqYDgkuxT81TB/otTQVzhTZzsBz7taO
 ZoSpxYvcGjA7J3YqrszFHU7h+Xj22dJCD7+mVyAwEEOq+Icob2U5V54R28XzIZs39TmrijYET2r
 AtLfJLzTxvjZF5/HOOfy1A5O2IbdM4nEvgvlKpjB2asDbkC1x1mIejoSSI1t3j3syvWm1SyOuxQ
 ohSvNWOywtux36LB5IDh83/5Ro/g2ab7lFpE361mX54po/8kDeVE7/ogMiTEs2Pw2TVVkYkDbs4
 pxDvLUWd4gXaWvDvx9FAVgfaiphw4Gyy1HMly4tXOsCKaHROb1CqRSOH4DW9g7xTghIDWhr21SY
 1bsi9em1W2WYZp4/vkXkuGHk6gX25Q3MKhxjWzZJcMSVDAsWaIzuo37tCGxVO0a9DPSQzj6hsXs
 Tdj
X-Received: by 2002:a05:600c:4e05:b0:486:fbd1:9dc0 with SMTP id
 5b1f17b1804b1-48a84473724mr76360915e9.22.1777582200605; 
 Thu, 30 Apr 2026 13:50:00 -0700 (PDT)
Received: from [192.168.69.210] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48a8ebb2f32sm5382515e9.13.2026.04.30.13.49.59
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 30 Apr 2026 13:49:59 -0700 (PDT)
Message-ID: <cfba5bad-821f-445d-a71a-3e7e79ea6df6@linaro.org>
Date: Thu, 30 Apr 2026 22:49:58 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 02/13] kconfig: remove duplicate declaration of
 CONFIG_MIPS_BOSTON_AIA
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
References: <20260430090534.841894-1-pbonzini@redhat.com>
 <20260430090534.841894-3-pbonzini@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Content-Language: en-US
In-Reply-To: <20260430090534.841894-3-pbonzini@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32d.google.com
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

On 30/4/26 11:05, Paolo Bonzini wrote:
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>   hw/misc/Kconfig  | 8 --------
>   hw/riscv/Kconfig | 4 ++++
>   2 files changed, 4 insertions(+), 8 deletions(-)


> diff --git a/hw/riscv/Kconfig b/hw/riscv/Kconfig
> index 0222c93f878..2518b04175f 100644
> --- a/hw/riscv/Kconfig
> +++ b/hw/riscv/Kconfig
> @@ -132,5 +132,9 @@ config XIANGSHAN_KUNMINGHU
>   config MIPS_BOSTON_AIA
>       bool
>       default y

Pre-existing but 'default y' unlikely needed.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

> +    depends on RISCV64
>       select PCI_EXPRESS
>       select PCI_EXPRESS_XILINX
> +    select RISCV_MIPS_CMGCR
> +    select RISCV_MIPS_CPC
> +    select RISCV_MIPS_CPS


