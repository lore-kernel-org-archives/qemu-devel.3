Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E29EFC71157
	for <qemu-devel@archiver.kernel.org>; Sun, 22 Jun 2025 02:48:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uTAkM-00008R-SX; Sat, 21 Jun 2025 22:47:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uTAkK-00008A-Vn
 for qemu-devel@nongnu.org; Sat, 21 Jun 2025 22:47:53 -0400
Received: from mail-pl1-x630.google.com ([2607:f8b0:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uTAkJ-0007Qv-9M
 for qemu-devel@nongnu.org; Sat, 21 Jun 2025 22:47:52 -0400
Received: by mail-pl1-x630.google.com with SMTP id
 d9443c01a7336-236377f00a1so27468885ad.3
 for <qemu-devel@nongnu.org>; Sat, 21 Jun 2025 19:47:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1750560469; x=1751165269; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=uN+kQu731rwhNXdlF+pZFTB4aXP084sW7W4cb/jqwdw=;
 b=vlFIrK2KIYsjOdPDebyOStxEl0zOjoJJoFE2w+1g012UdKFOMm4t7Haszn9xVXQCU3
 sIEpGjtfIKp+NSwC8uelIw6xKyWMml1+rFXl0zaLR/1sCTv/r50PZjesA0m4SjfIWXy5
 rpJj3YP+EsZiqtUtxKK/aJqPxdC1uqhkLNfiKJRM/opJImLE2MCCjEgrfteyoscyeSWO
 LSLBsgAWcyhCasRkd/VwE/TfA5oDQ2zw1lblTwAmj8TxuLVP22y848RtKiECXjo0jjHs
 FMpuvq+4BCsbuwf9pjtVwmKBYgTDCn2Mq/icJbZkDUtAYoR9lAfL+9ffvkdmvkR6TqGR
 V9YA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750560469; x=1751165269;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=uN+kQu731rwhNXdlF+pZFTB4aXP084sW7W4cb/jqwdw=;
 b=W3tdKUzMC3eJPZd7UJ9O5uayQEIpxTNHfL23eG5mHY4XDE5sUX+GG95u8CD6T/tqek
 s+4bKm47o8P5ByaNhHjCo81lPyg2w5uvR3uenbDFXbBX3+MJC3+08/tPl/G2IgVmtcvz
 6xR0cM9QDf8T1ZbuGtVrITacrpqeLxtXCgF01ZhMeCiDEt0CLeCoAMZ9IE0t+x1q+3AX
 0xJomQvBFyUD5ord8Dxm2moZXik2Hznr0eq2C3MLzvhQ/5TpTqZ+2IdgdCIxSXWI8cYP
 PqbINN1WuS44cqRaBwhV2ot7VjXAXhLhUi+zaleA1dJHpwhoVOxzJh7ohu/cRmp53vCa
 F8oQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXxAeWJzeq8IJaddLQ9JFwDcAb9xztBDH+3A1hhXhOTarCaa53stvvEiEgd7ykvdpdaOK+uZxfBmx9r@nongnu.org
X-Gm-Message-State: AOJu0YxRoPQIshAovw60+MSi+RfyU31HRsdtOOPkJm25HMLAh+14jLta
 FGcnWhy2mrJPpHP1Kgbwvk6CAtgZSYo1MWjLCthYwJBNQzZ/tVjyGF8wcDzQZ3GE4o8=
X-Gm-Gg: ASbGncsYU7P0c0g/cB7WFJ3Yri+PsXa1jRUA/4pGu0mcYGLcIuOxd76W2z7M8OkC+vs
 U5clU6zvivjtrCIX3iD3/XRNXFz2Q7xj91J4Gx5RP2eFp6/cglYEuT6XYQ9HTmtbPt1mT5YV5nk
 1ru+ys/o/z5sSFu5m3nwAWApE34ouLkRmn3/9rejoRHGhocjCBeUir59a3ju86ZuT0pmqvj4i2z
 Xb8jt8t/ae5ChB1qjl/pZfclO7Z4e2hAheWfGtj1Ufdl3CmLf5QtSANm7JCaQSFb5p8qHQsGHIh
 YSodSUGmMZ/vvgsuyzU/z2aAOhql+OoCnxuUL757BwbzGvtSyysu0exUgn+nWQOhJdQedohewxs
 ++6SIj/Bp9GlMlY0u2keICD05KhgU
X-Google-Smtp-Source: AGHT+IEekyp6h4nuMb9/Oq8FaO8G5Q63B1f4Ap7/KFxy3bEuLrO6/jbkMjmOEr+F3f5yw45WC5Lsag==
X-Received: by 2002:a17:902:e88f:b0:234:bca7:292e with SMTP id
 d9443c01a7336-237d973b345mr108369955ad.14.1750560468959; 
 Sat, 21 Jun 2025 19:47:48 -0700 (PDT)
Received: from [192.168.0.4] (174-21-67-243.tukw.qwest.net. [174.21.67.243])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-237d860fb58sm50073355ad.99.2025.06.21.19.47.47
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 21 Jun 2025 19:47:48 -0700 (PDT)
Message-ID: <5fe6acdc-e997-4070-a560-7cd8f4f2eb73@linaro.org>
Date: Sat, 21 Jun 2025 19:47:46 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH RESEND 14/42] accel/split: Implement
 synchronize_post_init()
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
References: <20250620172751.94231-1-philmd@linaro.org>
 <20250620172751.94231-15-philmd@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250620172751.94231-15-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::630;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x630.google.com
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

On 6/20/25 10:27, Philippe Mathieu-Daudé wrote:
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   accel/split/split-accel-ops.c | 11 ++++++++++-
>   1 file changed, 10 insertions(+), 1 deletion(-)
> 
> diff --git a/accel/split/split-accel-ops.c b/accel/split/split-accel-ops.c
> index d4fa07c2dec..6b3ddf21a17 100644
> --- a/accel/split/split-accel-ops.c
> +++ b/accel/split/split-accel-ops.c
> @@ -151,7 +151,16 @@ static void split_synchronize_post_reset(CPUState *cpu)
>   
>   static void split_synchronize_post_init(CPUState *cpu)
>   {
> -    g_assert_not_reached();
> +    SplitAccelState *sas = SPLIT_ACCEL(cpu->accel->accel);
> +    AccelClass *hwc = ACCEL_GET_CLASS(sas->hw);
> +    AccelClass *swc = ACCEL_GET_CLASS(sas->sw);
> +
> +    if (hwc->ops->synchronize_post_init) {
> +        hwc->ops->synchronize_post_init(cpu);
> +    }
> +    if (swc->ops->synchronize_post_init) {
> +        swc->ops->synchronize_post_init(cpu);
> +    }
>   }
>   
>   static void split_synchronize_state(CPUState *cpu)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

