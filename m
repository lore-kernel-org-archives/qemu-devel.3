Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20210C7115C
	for <qemu-devel@archiver.kernel.org>; Sun, 22 Jun 2025 02:30:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uTATR-0002gN-KB; Sat, 21 Jun 2025 22:30:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uTATQ-0002g9-28
 for qemu-devel@nongnu.org; Sat, 21 Jun 2025 22:30:24 -0400
Received: from mail-pf1-x436.google.com ([2607:f8b0:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uTATO-0004L4-Li
 for qemu-devel@nongnu.org; Sat, 21 Jun 2025 22:30:23 -0400
Received: by mail-pf1-x436.google.com with SMTP id
 d2e1a72fcca58-742c7a52e97so2442966b3a.3
 for <qemu-devel@nongnu.org>; Sat, 21 Jun 2025 19:30:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1750559421; x=1751164221; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=/aDjc6PrOgJZ3DWquqap2lCiYEPfGg42Z3QilME5reA=;
 b=a00ZLXF9oGMNBDwkdHnAT+nPxigUWe6o1vMIQKstpnqOCnSNhYIl6JipOaoFs0N+AG
 NzETC60ylQKNgTbLgJd0mmkxAXioVc4qNIt7j7aoygW8HzN1XD8f8k34FNsn/Kg72Xwg
 i/D3IbzECAFfxyGYmgvloXBaBxwGF18oxXvQvl2lEIw0NWpPYf4DaGLF9mGxVeFPSwLJ
 OOYffpgR8lhannJBlv84fFc66uBxJFI8LbGmbAHq40UA7DWe6Z49wVbA+N/K0rXbC0bG
 dmsNbl8uEdp2oALXMS1srKz7+IKAiEvpA0+n1/BZqQ65pfNhXQSUs0D2sX2yymvuouS9
 6v0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750559421; x=1751164221;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=/aDjc6PrOgJZ3DWquqap2lCiYEPfGg42Z3QilME5reA=;
 b=CN+EzkBP+KOZXkpdOr2eq329fFZaA/wSP2MWYk0pdH5/dRrQ33Jm+z7rdFufGC0siI
 u1wKDOdaUBmtkB1vo84oMj3AuJKs8B3gSNa2kM9LSrAqAGA3BHmsARQUhWXW2aS/bgt0
 LicSh1c7dW4BZTM5uplQQVIbDbNaQntasQ50FfDYvl/nL8x6gzhUqAIOFz/H3XmTV0FE
 45FRtDr53ILuqU2FJDIHQpPgZh8MaC8BRl4pSJCbQVEBJ0GgQ6MeyrLYcZ17FPOF/ANC
 STxZJvVDORyhnlTJrm0t3wbU/dErDoL9l0XjACfVd1LRipr3Ofbbrxp4dvjzNRXNX0V/
 mkLw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVwJy06MhK4T22kusIfzn17TSCpuprcKIHMw12zJ9m/pQuO0a1/cev2L7TRuJyLMal3Iqqqq2V4hOHY@nongnu.org
X-Gm-Message-State: AOJu0YxXAL8tDQchWxmcIhfYipj8U/1ZxO/xHvpt4RGure8AoIr3TpNx
 rr6BZbEHMNGGq2AVu5NnXv1MNFjRGgQ5AGET768/N7jEh7UafdjceApVkHIHod1NdYD9+mnvLvs
 c8N0fkRg=
X-Gm-Gg: ASbGncutQdaaFSQsZJyNkLYaCHVhl3Nw8uWNkjsFMCvocHvgFozQXtaX2e8BZO2rWwy
 iwQKWHzRkmx6hjW3N9TL68xyaZWD1Jd6Uv49Wbbtv0uHbWlCyzsciTjqEHa2rTfTRGS0HvFlW8P
 /CzYBCUQmx1L/cy5j+xVNLJbF1ibN71kvl9ScbPxwxMT9Yb4Vjt7cIqhqjsQPWuNRbKuGcJYhuf
 R55sGL3MANyqJLTUNlkCxhh62U5C5P0VzsRo3K0C4Ryt72gZIfc3bsBOyzscSI0Tfv9uCoResi1
 +Ytp4C3+zla/Fqxi5N6p30+YtUsZx3G3SjQIXKaSLMj7vkLKgSPsejDQpt6vdqlJWjCdn0OkVjI
 Y0LWnAgycDRb+215Bixkf8Twfc042
X-Google-Smtp-Source: AGHT+IF0zzOaIW6GdLwgfGBy/eJlSYpoTKbU2rmXfc4nvBSYt0qZsAlC0QaYFdGwJOIVhFeRAY6cDA==
X-Received: by 2002:a05:6a21:3399:b0:1ee:e20f:f14e with SMTP id
 adf61e73a8af0-22026fea18emr12023099637.38.1750559421152; 
 Sat, 21 Jun 2025 19:30:21 -0700 (PDT)
Received: from [192.168.0.4] (174-21-67-243.tukw.qwest.net. [174.21.67.243])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7490a689159sm5410757b3a.145.2025.06.21.19.30.20
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 21 Jun 2025 19:30:20 -0700 (PDT)
Message-ID: <ecd138ce-a37a-4676-8b3f-76904b116936@linaro.org>
Date: Sat, 21 Jun 2025 19:30:19 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH RESEND 08/42] accel/split: Implement
 gdbstub_supported_sstep_flags()
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
References: <20250620172751.94231-1-philmd@linaro.org>
 <20250620172751.94231-9-philmd@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250620172751.94231-9-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::436;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x436.google.com
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
>   accel/split/split-all.c | 14 +++++++++++++-
>   1 file changed, 13 insertions(+), 1 deletion(-)
> 
> diff --git a/accel/split/split-all.c b/accel/split/split-all.c
> index cb910300931..413954af96c 100644
> --- a/accel/split/split-all.c
> +++ b/accel/split/split-all.c
> @@ -77,7 +77,19 @@ static bool split_supports_guest_debug(AccelState *as)
>   
>   static int split_gdbstub_supported_sstep_flags(AccelState *as)
>   {
> -    g_assert_not_reached();
> +    SplitAccelState *sas = SPLIT_ACCEL(as);
> +    AccelClass *hwc = ACCEL_GET_CLASS(sas->hw);
> +    AccelClass *swc = ACCEL_GET_CLASS(sas->sw);
> +    int flags = -1;

This only works if one of hw/sw implements the hook.


r~

> +
> +    if (hwc->gdbstub_supported_sstep_flags) {
> +        flags &= hwc->gdbstub_supported_sstep_flags(sas->hw);
> +    }
> +    if (swc->gdbstub_supported_sstep_flags) {
> +        flags &= swc->gdbstub_supported_sstep_flags(sas->sw);
> +    }
> +
> +    return flags;
>   }
>   
>   static void split_get_stats(AccelState *as, GString *buf)


