Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4EF33CD37B2
	for <qemu-devel@archiver.kernel.org>; Sun, 10 May 2026 16:11:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wM6k7-0004cr-9r; Sun, 10 May 2026 12:10:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wM6k6-0004cK-6d
 for qemu-devel@nongnu.org; Sun, 10 May 2026 12:10:58 -0400
Received: from mail-oo1-xc36.google.com ([2607:f8b0:4864:20::c36])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wM6k4-00027o-LJ
 for qemu-devel@nongnu.org; Sun, 10 May 2026 12:10:57 -0400
Received: by mail-oo1-xc36.google.com with SMTP id
 006d021491bc7-682fce74c06so2382132eaf.3
 for <qemu-devel@nongnu.org>; Sun, 10 May 2026 09:10:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1778429455; x=1779034255; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=aBzePcZo6B/mA+sCAwJBUgpeHdTX0XV9jsx4hMYH/ls=;
 b=nBcqZCz8ZtJ9JCaVIVH7lX9uzMF+Vffdqy3La2g5ulOnCLYdyYe5aytC0XEZ+kpNsL
 cP9ODfJVXH3v92V9c3+KgVMnHdreuUKkHduKFppAjAyu0pdYGxooc1Al9O9yKRBK2z2J
 r0T08796KiZLOZGok6vwDZdNWJgwtCpfcmu6SYjtGYYU/7XjwIYvdKf7Q8FrDX21SQsH
 ugY9jlqZ+PICuBIbOylYIrBphkLynKSBWpCoA8mUu1cM+PaVgoxjggHykrBQs25lsAsh
 yPlJ4t/Nh/qnMG/tJDClO0hPsiHzQmmpCCA5NGsg4GDEpdcjhqSdvbS8/ZvwQrH1lVS9
 02rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778429455; x=1779034255;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=aBzePcZo6B/mA+sCAwJBUgpeHdTX0XV9jsx4hMYH/ls=;
 b=P3/NUJNR4udU1Bb/vzHpZ96BZIxxY81aVjfOLsx8Cwuof3+VJNHXafIWDYPCQDvliT
 Ds8kzJp3PWRbXN0OJMLCujleQT5OSSiG+0lEO7dKFCTt65ZhpovkzzH4pffggY9K+A02
 iCPo46bREKifAkmrG/P8pWv2CzBzvd42t5R1NK2Bbr8YtE5aJ8+1oJ7F/PnfBF82CIqq
 8ohXkD4jb4yOcn6aZudNbn39ywJu65Ow+2eavX3nmJlNljRUilGQ24v/2Y0AR6uHLEXd
 NOyuzaGtz/O8lmSbE0/KG4AEZ6xr6I+G4jBuNctm4vGK26xSC2H7nkUWeRq1uGRd6dOE
 Jhmg==
X-Gm-Message-State: AOJu0YzoXU15tcw6SuQH8Y0o5tAWaElhID7dXfuYYtAk+/N9zOL3sfrZ
 SBGpXP3mMsG1QwzkUnGOcUUUs+OHPDEu42zz3fJPTaM4WetNBYQ1TOITYkC9fC5de0RDoYKoppb
 99ZNM
X-Gm-Gg: Acq92OEuvWDLzOa4f1ItZ84IkS19oi8JQ5EiO/3GILxSOEIZxvG3GHDV1/hXomocVxu
 SUvg9YlJP3BVnmZAwlgesXUXwcsuc5i5TtvHUNDVArITGyye30l0R9Q7kZYBRqCpG+0a0UaWn8V
 dGnWJ2dL71dPQIHMfvPRchsJwibclNdKiB+UGldyrYAaPbRKK+xSA9fqlJDY+hOQzH7pLyNAMjL
 cIArDJhDllOFIhl0YNW/Dmkmt7xCJ0fyEgTw9yo6Jt9l+ya1ikA9fS5QTNaAitKuGL+fzWgPbL2
 vu/v5BqHCwbzNPpHsoxUPhqBzNxIQj7OtrMcAX/SEmb+B3j46Txxdz1XD9Ljtf7Wwh6R4QUmf0s
 yvv6hRJVC8Rij235mTvUAkviTWPmXfdgF/Lt0Nc824+ssq40RyeR8o+L/LymfYyyAmvHK6qn8Tr
 PWHQkSSrYM3NxtRWZuA7J3VcN/N51qXjTWfaVmcTAkxxEzvC2AR+qWyZYOVTq6Ba5hlPkhyfRRp
 /eNnlYc2Q==
X-Received: by 2002:a05:6820:80c4:b0:696:1a85:5872 with SMTP id
 006d021491bc7-69b36a8b40fmr3727480eaf.18.1778429455140; 
 Sun, 10 May 2026 09:10:55 -0700 (PDT)
Received: from ?IPV6:2600:381:c938:6375:32c5:6ccf:a676:6508?
 ([2600:381:c938:6375:32c5:6ccf:a676:6508])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-4355736f517sm7565919fac.12.2026.05.10.09.10.53
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 10 May 2026 09:10:54 -0700 (PDT)
Message-ID: <f81dde0f-7bbd-4049-9ef2-44831aa61928@linaro.org>
Date: Sun, 10 May 2026 11:10:52 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 09/32] target/mips: add Octeon LHUX instruction
To: qemu-devel@nongnu.org
References: <20260509-mips-octeon-missing-insns-v2-v4-0-d669dcd05c2f@gmail.com>
 <20260509-mips-octeon-missing-insns-v2-v4-9-d669dcd05c2f@gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260509-mips-octeon-missing-insns-v2-v4-9-d669dcd05c2f@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::c36;
 envelope-from=richard.henderson@linaro.org; helo=mail-oo1-xc36.google.com
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

On 5/9/26 21:13, James Hilliard wrote:
> LHUX performs an indexed unsigned halfword load from base + index and
> zero-extends the result into rd.
> 
> Add the decode entry and reuse the common indexed-load translator with
> MO_UW.
> 
> Signed-off-by: James Hilliard<james.hilliard1@gmail.com>
> ---
> Changes v2 -> v3:
>    - Split LHUX out of the combined Octeon arithmetic and memory
>      instruction patch.  (requested by Richard Henderson)
> ---
>   target/mips/tcg/octeon.decode      | 1 +
>   target/mips/tcg/octeon_translate.c | 1 +
>   2 files changed, 2 insertions(+)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

