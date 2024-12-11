Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B590AE77182
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Dec 2024 16:46:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tLPh5-0006ZP-2z; Wed, 11 Dec 2024 11:36:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tLPgP-00057J-6Z
 for qemu-devel@nongnu.org; Wed, 11 Dec 2024 11:35:29 -0500
Received: from mail-qv1-xf2f.google.com ([2607:f8b0:4864:20::f2f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tLPgM-0001yi-5n
 for qemu-devel@nongnu.org; Wed, 11 Dec 2024 11:35:27 -0500
Received: by mail-qv1-xf2f.google.com with SMTP id
 6a1803df08f44-6d8e8445219so39238176d6.0
 for <qemu-devel@nongnu.org>; Wed, 11 Dec 2024 08:35:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733934925; x=1734539725; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=gng6M6YMpGpg7rmPmXYoDXLqibSnH1wAgGKaZZa/k24=;
 b=TpKEMlM5I/S/xgC3aFjzRgUDDRd898mgzYTJQYkbcfA8lF7I0QpOkXfUzDdYTJZ3C3
 Q5/D+0rRd++2IND8svMwLVRWObC4F6RDb7SktZXmYfSFuPMj/nRq2Ns6Q2IAezuOoutR
 Oqp7WSABxG2+1UqUTQWxYx4/J9cRhomQ1/fpp9XXllbeiLbrPuHp2CMn27ulnxaHjgQ7
 0EnJ0cH8Y4Ad3F/b4Yk4unThnm5ui4Hw4tYExmdASUNHT+w0wqjMCDGpky0tnbM4KQdP
 mrMJQ4iIqkhVatfafOW3vy5mASMQ6WFjUNZlB7+zG1qeKqbM6D8HXn27HV6orh5BwMgr
 C+/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733934925; x=1734539725;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=gng6M6YMpGpg7rmPmXYoDXLqibSnH1wAgGKaZZa/k24=;
 b=LeCUH47FY8FhPbIj2NzRqcvr89dREKuuBu129hyqNIYiVcmBozJyGKE5PIqK9EL+N2
 bT6ef8OfViaiGUlSQt2XZj+a+U5SqVrdCNrtIjFlsvguUYZlJvxSUh7phFfzR+Y7VlFA
 ZTEPq03ueaILlyANZUeFgRkMFkwVfNintgKMXaAOLeSrmfCr9oLFu2DcEPjxg9nyYDOf
 i+l2kDRDVEklTZATHgaDKgW4einxTSq228twXBcYv/B4oWMsxWGrnpPfC3VMMEozkGvQ
 5ndlBylncnE9AXI2RoaMQQLkcr7vEy2nhjn1g170eG5Jc0kiG1Ub4b8UkMhqHfLL1XhG
 vAuw==
X-Forwarded-Encrypted: i=1;
 AJvYcCX4YohM79qWmkeiysiG+Kq+w6w9xDCWbMPeUaxI4G0lTCp3oJgQKXS/5JNlrQ02bHvDg3ttB9pL099R@nongnu.org
X-Gm-Message-State: AOJu0YyGyMmyNlxHxJyHzWFwOSRDGxUhIvbSvGlci5ketGFF3/U7+LXg
 rJ7+B4fyL6nUj2a+MFA0RtD84ORRnVsTahIGWCuQcAiHoqcSHuxQR14iAnHRapI=
X-Gm-Gg: ASbGncu09WbdkFS8798Qd9ZK64tiGep1cpzxrO1X6lh9zAYBwkKCMcBe2xcEUTgLrza
 DgC8pt8ghAl/N4cZY2FGH9Eh864qjT5WCeNbJdcFCCjIHuF4R8gVA1uYCbSFQdqzR779LAQAEao
 HTMkVlhz6N0nJgQ9lgbmn2eGSiTuA/Gnx22MzYcSOgjrRJsGl+V4jRF8r3k4LiyJaS9UFhyje9m
 /QrLrtaAXGVCXXxM+GB+jA09ONX73igkYEXIk0L+wdwjClxY5BS5NuS2kjboDBTrmCEW4s=
X-Google-Smtp-Source: AGHT+IFwq7GWH/yZffXkYrSXZL8B4Ypx4yTfLYUkWJC/jO9aJ1bundN//6xu7dUHqwbC5t6RGuv+yg==
X-Received: by 2002:ad4:5ecf:0:b0:6d8:af2d:2a44 with SMTP id
 6a1803df08f44-6dae2ab2e4bmr4850936d6.32.1733934925128; 
 Wed, 11 Dec 2024 08:35:25 -0800 (PST)
Received: from [172.20.4.119] ([187.217.227.247])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6d8f6b68037sm51385396d6.19.2024.12.11.08.35.23
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 11 Dec 2024 08:35:24 -0800 (PST)
Message-ID: <60a9ea0b-d512-41d0-861b-d5e865afbdd6@linaro.org>
Date: Wed, 11 Dec 2024 10:35:20 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] tcg/riscv: Fix StoreStore barrier generation
To: Roman Artemev <roman.artemev@syntacore.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: "palmer@dabbelt.com" <palmer@dabbelt.com>,
 "Alistair.Francis@wdc.com" <Alistair.Francis@wdc.com>,
 "qemu-riscv@nongnu.org" <qemu-riscv@nongnu.org>,
 Denis Tomashev <denis.tomashev@syntacore.com>
References: <e2f2131e294a49e79959d4fa9ec02cf4@syntacore.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <e2f2131e294a49e79959d4fa9ec02cf4@syntacore.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::f2f;
 envelope-from=richard.henderson@linaro.org; helo=mail-qv1-xf2f.google.com
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

On 12/11/24 01:40, Roman Artemev wrote:
> On RISC-V to StoreStore barrier corresponds
> `fence w, w` not `fence r, r`
> 
> Signed-off-by: Denis Tomashev <denis.tomashev@syntacore.com>
> Signed-off-by: Roman Artemev <roman.artemev@syntacore.com>
> ---
>   tcg/riscv/tcg-target.c.inc | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tcg/riscv/tcg-target.c.inc b/tcg/riscv/tcg-target.c.inc
> index f8331e4688..96f9a7e348 100644
> --- a/tcg/riscv/tcg-target.c.inc
> +++ b/tcg/riscv/tcg-target.c.inc
> @@ -1624,7 +1624,7 @@ static void tcg_out_mb(TCGContext *s, TCGArg a0)
>           insn |= 0x02100000;
>       }
>       if (a0 & TCG_MO_ST_ST) {
> -        insn |= 0x02200000;
> +        insn |= 0x01100000;
>       }
>       tcg_out32(s, insn);
>   }

Fixes: efbea94c76b ("tcg/riscv: Add slowpath load and store instructions")
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

Wow, that typo has been around for a while.
Thanks, queued.


r~


