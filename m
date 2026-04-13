Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A224DE9380D
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Apr 2026 02:55:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wC7RS-0007yp-AA; Sun, 12 Apr 2026 22:54:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wC7RR-0007ya-Ao
 for qemu-devel@nongnu.org; Sun, 12 Apr 2026 22:54:25 -0400
Received: from mail-pj1-x102a.google.com ([2607:f8b0:4864:20::102a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wC7RP-0006F8-Le
 for qemu-devel@nongnu.org; Sun, 12 Apr 2026 22:54:25 -0400
Received: by mail-pj1-x102a.google.com with SMTP id
 98e67ed59e1d1-35d971fb6f1so3302779a91.0
 for <qemu-devel@nongnu.org>; Sun, 12 Apr 2026 19:54:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1776048862; x=1776653662; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=YRZzF1molMiU0mAe7mBsbNpM+GuMrYExyMffQk1r0Q4=;
 b=EPuJ74JaQPD/locpmWITFXwSRJrmY55CYjJqyQ5kPDo6jdAwgkCLL9IvwfDzKjnruw
 G49pZ6viaLu+jMK7ogeHFo7HDf3MFcUk9s26gdFqT1cpMqPGyr00OhUluazvLVi+b3RW
 iQHuAJD3OV5ymplY4Gh8xjzVfTtDUBtkLp/OL816DktjQQTmfm/Zegvw/8oU349fbfO1
 teSyNyNs+bxDUby2ZChpEBRyQNXZwv1KcGlutMTiq+Tpj7K6mfEmvegxRgpfghh3FMO5
 7EwJ6EPbtqt9A32ipMi0K/9xeLJyRSzPCWLxYpF0UtsEOSZ8LFDZYxr7dObi9qPqBs/0
 QyTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776048862; x=1776653662;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=YRZzF1molMiU0mAe7mBsbNpM+GuMrYExyMffQk1r0Q4=;
 b=N4NSZym8pK/uY5cNvhUSpxXP5092ogSYMtBpoXb9J5FPrgU2nXUQf3CHkDrLni/IcE
 Hc4XT4DQR4noajb8vYe1eR1mTbLihZUrHxIx8ZDpJa3MoEIIOoCl+cyDuf8nlgfyM/UI
 9j9ZDha3XayzBw+CLC11rZYrHEcPk5g998TM6+9hLKT7alDXfMXon+m8a2lCpzDFNz7H
 RhFZ025/AWQBPjBLzk+DNSYGNJRwBIDaE92Z69dS8igr42CH9QL6JhysDBOsEoCJtjAm
 CYUDf3m2u5Bh7BBtaJ32oXoR2ZlhOvpeZqdmLUg5T6vhFkOK4CfFYmGWSzhIGaGKT7G1
 XfQw==
X-Forwarded-Encrypted: i=1;
 AFNElJ96UWbilQEn2ZMWKEKbNwt0n2QWdxkLK/N5jOIbu8kpSzUM2zASBgWL9DCZ7B1k5dnMFbwyMX1bec+G@nongnu.org
X-Gm-Message-State: AOJu0YzngrxGQwIV87fK1Ssan6DULhxm1bOozr/KfyUis6MLf4UO5CEd
 /+bYiPVh9yrwqFX2bgP2jvrvSWBpQHegKKgGOIUTTmqf5iwxo1UsOEQ+AczNEuKHcUc=
X-Gm-Gg: AeBDietVwFFkyVokpW4bByXTW/Dw4knmYeuT/rj2lG9Yrpd9yyOm6RphDJlMhVxsZ+W
 TJ7+fWRzCtrs+LBZPNeN67EXcGWYmJMoHorjliroDOYLcnrCd6vsX4xzTVBiMLfj7l5CMnjccSL
 A6fyYNLYLjuCnfKCyMNGwfAIZvLi64xDUZcp306LvfzVI38BzXt8ndHSYICIyMVLWRwATmnRQj3
 R3u1gwrg7cA08zn7RgQPkTTqkzGJ8VAcd3JHWWYbCBbOB1EbYsFoAhnVBz1dw8X/LCdFl5x+E+3
 MXiaZK98K9CNtAM5uEqodpfNQ+G4QOgHPcns27z23kdrCLEKsdxC8uwEwmZZF7xDYJdvep1UuVg
 b+xguaC7XZxfQUVKMx98YC8m8ObeQ5h2+zI0PynSvkO0eOnGNuCG3+oRZduG8Lx5fjxIU9DwDGM
 sa2bTcgpdeAzonKY9awhFUU8vSIWKReD+6QxYedqeu2T2CSIQVMiF/UWdQLneBttz5mwVHdUOWM
 g+RYGJ2vy9ed4/PbiBmpfDHFEsVj+oAFAtNqINo6V+5xGBXWF1LZig=
X-Received: by 2002:a17:90a:d610:b0:35b:929f:7e95 with SMTP id
 98e67ed59e1d1-35e42769f6bmr11324920a91.4.1776048861574; 
 Sun, 12 Apr 2026 19:54:21 -0700 (PDT)
Received: from ?IPV6:2401:d002:dc0f:2100:a7b4:d4f1:5b23:321f?
 (bg30dj032xp6rdh0yngy.ip6.superloop.au.
 [2401:d002:dc0f:2100:a7b4:d4f1:5b23:321f])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-35e4133695bsm13543325a91.13.2026.04.12.19.54.14
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 12 Apr 2026 19:54:21 -0700 (PDT)
Message-ID: <23fa80fc-52e7-4a56-984e-1b87e80969ac@linaro.org>
Date: Mon, 13 Apr 2026 12:54:08 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 02/27] monitor: Remove target_long use in
 get_monitor_def()
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: "Dr. David Alan Gilbert" <dave@treblig.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-riscv@nongnu.org,
 Markus Armbruster <armbru@redhat.com>, qemu-s390x@nongnu.org,
 kvm@vger.kernel.org, qemu-ppc@nongnu.org
References: <20260410195323.17937-1-philmd@linaro.org>
 <20260410195323.17937-3-philmd@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260410195323.17937-3-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102a;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x102a.google.com
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

On 4/11/26 05:52, Philippe Mathieu-Daudé wrote:
> Truncate manually, removing the need of target-specific
> code in get_monitor_def().
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   monitor/hmp-target.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/monitor/hmp-target.c b/monitor/hmp-target.c
> index 812714ada01..b9b79e8e927 100644
> --- a/monitor/hmp-target.c
> +++ b/monitor/hmp-target.c
> @@ -93,7 +93,7 @@ int get_monitor_def(Monitor *mon, int64_t *pval, const char *name)
>   
>       ret = target_get_monitor_def(cs, name, &tmp);
>       if (!ret) {
> -        *pval = (target_long) tmp;
> +        *pval = target_long_bits() == 32 ? (int32_t)tmp : tmp;
>       }

Likewise force the target to deal with int64_t.
There is only one user: riscv.


r~

