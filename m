Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46E95CD37B2
	for <qemu-devel@archiver.kernel.org>; Sun, 10 May 2026 16:17:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wM6pt-0007g0-Ul; Sun, 10 May 2026 12:16:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wM6pl-0007fV-Rd
 for qemu-devel@nongnu.org; Sun, 10 May 2026 12:16:49 -0400
Received: from mail-ot1-x330.google.com ([2607:f8b0:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wM6pk-0003sJ-7L
 for qemu-devel@nongnu.org; Sun, 10 May 2026 12:16:49 -0400
Received: by mail-ot1-x330.google.com with SMTP id
 46e09a7af769-7dea20cf21aso3348226a34.1
 for <qemu-devel@nongnu.org>; Sun, 10 May 2026 09:16:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1778429806; x=1779034606; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=KQ6ToM7Wf9WNRnbFxllkmpNyp4obz7B0oX4VVTw5oxQ=;
 b=iXi7Awb4GUy9cYWovSwb+aumuMqzjkpcXrdscFOAhx7KEpQ9Vfd5oQFwcAG/2oDeVg
 Ogcpl/y+ybUKFdKM16/ph2llIPkKUpdqgZWFtvtZkKaylEsM+hVvBR33zU8U/L6VAcNi
 L/qjM2RmQs+WpdDN9DJ8BP+rA3zmecSXp9WXBhHC62wsbbXsEuo3KRh5sK/vlv3lvdfp
 3VUH8SU15MOl9T0YJvWKxb79xIgnkdsNDfgZgum+l3CP2qlCSbe9Ir5BM/+WgtW+MHjE
 sCLoCAHGnC3vacOsuiPmLXK2HsYXVG5OoNTsNFmM+c20tWOvlh6zBc1VO5bsolHD2YRL
 2xSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778429806; x=1779034606;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=KQ6ToM7Wf9WNRnbFxllkmpNyp4obz7B0oX4VVTw5oxQ=;
 b=h+Zb89FzcqgKlFTL+NDDdTF8pZZxeqciJE8o4wnNs59cBr52YN2t0ve5kWMCO4pipg
 eMSYyXkPDcS0xaR9hQ7IXwmz2fYiq9lKrUoZHY1jrmK16nDwcbQB0UvaqAUXlGaXrBv3
 sOuBBTdZZL0HMuGkE1p3FOCpJ3gCI2IyCA4nPIdiuJj1Npqynde4hjqO7k71MLRI+iul
 ZsuPZcE8x/7ICR/uRSONOLbLY/4+eGutiWaACDHDmGdObLxjbXiv0hrPjIMQspaRYpcj
 bC2NDrbmm7GmyxIEtfcjxdehyzZeDdiQxWSv8C9HaiS260WqDZSOuaD2RSz9MG74Ar0Q
 JyhQ==
X-Gm-Message-State: AOJu0YyoBS0Ger1lm6O36hQoKmCdznFgxNjvTpQ4hQ0I6E6r89BVUS5M
 NS3AV9wRaGJq0c1sF3+YsSvzAMjcOI+sHBB2JjLvJxzTBWniD7O2cUj2JOD7QiCh8ZksymTdSdM
 rk7PP
X-Gm-Gg: Acq92OFyw+4kK+qyWS6OUKRqLtZFeyHfP0TqJep7jLsDJVtXwGb+l++CLcL1UaHYLWu
 vyzTLKtuOOEcvKN2QRt4zjo/9DxTJjI8GUHR5urj3IrOGFsHFq5Pomx3NpLOt3NALqR279iMOJp
 /4kVXS5WJvyZriqpVpOggL3rT4Wyb/9wT8W4eEAgkv52yP8LqGwaMYMlHuUdIClTJuhXasAnGAJ
 VOqk+dLSHftVdT7ZV6pYoVengd0MNc50xfIwYuoo7rioK0W0ArZ7y7gdFBeVETAGwSStOZ2srup
 Kelo2VxdOVJ1L3bcYr9ea3GoRSaCvqESRKdpI4M5i/JB5QI8yBfRUjSHMKzuGOmZwdnnQqtgWzF
 43skkjJHXVBVWF9FfLwLkxUnOl2zsuW2F2ro2ZUL6BC29L74PHMl6QE3n5cf1JzwYetn4PJAsN3
 8UQKj46INEFwnpOwoJx/CX4pT/Y57YlNSjXDbJOm5k75tITw9RnQ+ylhglt8scyCpXhEvl5er9I
 riVhVhhDA==
X-Received: by 2002:a05:6830:378e:b0:7de:49c0:a752 with SMTP id
 46e09a7af769-7e1df26c2d2mr12262571a34.27.1778429806239; 
 Sun, 10 May 2026 09:16:46 -0700 (PDT)
Received: from ?IPV6:2600:381:c938:6375:32c5:6ccf:a676:6508?
 ([2600:381:c938:6375:32c5:6ccf:a676:6508])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7e367a18481sm5236995a34.0.2026.05.10.09.16.45
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 10 May 2026 09:16:45 -0700 (PDT)
Message-ID: <3be776b0-de87-4ffb-942e-a15128f092cf@linaro.org>
Date: Sun, 10 May 2026 11:16:43 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 12/32] target/mips: add Octeon SAAD instruction
To: qemu-devel@nongnu.org
References: <20260509-mips-octeon-missing-insns-v2-v4-0-d669dcd05c2f@gmail.com>
 <20260509-mips-octeon-missing-insns-v2-v4-12-d669dcd05c2f@gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260509-mips-octeon-missing-insns-v2-v4-12-d669dcd05c2f@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::330;
 envelope-from=richard.henderson@linaro.org; helo=mail-ot1-x330.google.com
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
> SAAD is the Octeon+ doubleword form of SAA: it atomically adds rt to the
> naturally aligned 64-bit doubleword at base and discards the old memory
> value.
> 
> Route it through the common SAA/SAAD translator so the MemOp selects the
> aligned doubleword transaction size.
> 
> Signed-off-by: James Hilliard<james.hilliard1@gmail.com>
> ---
> Changes v2 -> v3:
>    - Split SAAD out of the combined Octeon arithmetic and memory
>      instruction patch.  (requested by Richard Henderson)
> 
> Changes v3 -> v4:
>    - Note that SAAD shares the Octeon+ gated SAA translator path.
> ---
>   target/mips/tcg/octeon.decode      | 1 +
>   target/mips/tcg/octeon_translate.c | 1 +
>   2 files changed, 2 insertions(+)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

