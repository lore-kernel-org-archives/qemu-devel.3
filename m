Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1289EE8B387
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Feb 2026 01:50:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vnS1j-0004FX-Ja; Tue, 03 Feb 2026 20:49:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vnS1h-0004Ez-TP
 for qemu-devel@nongnu.org; Tue, 03 Feb 2026 20:49:53 -0500
Received: from mail-pf1-x42d.google.com ([2607:f8b0:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vnS1f-0004lK-CJ
 for qemu-devel@nongnu.org; Tue, 03 Feb 2026 20:49:53 -0500
Received: by mail-pf1-x42d.google.com with SMTP id
 d2e1a72fcca58-82318702afbso5189025b3a.1
 for <qemu-devel@nongnu.org>; Tue, 03 Feb 2026 17:49:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1770169790; x=1770774590; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=liqHnRpz+wsxvdhNrhnELCQ/WUt9SLA/8TrJMuVN6bY=;
 b=VFQ8iIyQv8yGEO1WStWfsVjNcMCsd7eD2DenmiwB/FE6+OR02rl4tleV9IrIkyxBNo
 8hMis6cQjxu90a9caY/Z5PZ36bQdWJXEQ/1uyS6Xe4xDFXZRu0qrGGM0IzsRyVjIjJ8z
 Jr2OVCzDY71sjSU3mFwOaiQdZv6YFrrPhdItiA6621gvvonqyLaEw4Pvy+Cu9hxu7wsi
 oG9oJGmzZFH/OSMvQWf8nYNCW4WAW7HbHHbSGLSGX4fjeeVJRmYOYg0kEEIUkcM1Nl3i
 Ez2Wg6WV4yBeG7UDJPhb741uPiDctBGpprpU/4ssxbcLIqOnTAh7RR9TY5s/UdB7YF+z
 0D5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770169790; x=1770774590;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=liqHnRpz+wsxvdhNrhnELCQ/WUt9SLA/8TrJMuVN6bY=;
 b=GwmqKd0VpFu4BtKmLHLsEs55p0pS+tsQhlYzP27kKNON2uD13LXAvPMYY38ox8YNEF
 BB17DhmWhgZSz5d4xMof91Rbq3qdxkadA9Ub+ZsDgy3FuOvo4N9lYqGIBpNMgmpEYSFx
 zwKIznVsgY55EXGz2Ct7b93xnqr4BRIuCCi5P6jxzb1XMp8MntE9BR7iCKs7n1OZxvjn
 ABFexGeuQJTFEKNk2UoX+dKzEpZ3FrWZl3iiUrGZ/tAewuUK0xUnhsmFDjQ569ze4vPC
 YLYhdiaN/SNj8HoqO9nocP3L+OdmP/C26P6W395WmvVIZuyPzcQe3ozdOh0aMtd/+wg7
 S3bw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWFIND6yl1jH21zKpf4Nx1w0zBx1TYgz4jio6UXvL7ZaYeY+ZiTXWpCehV5VBIG3in5+1vHVVBNIViX@nongnu.org
X-Gm-Message-State: AOJu0YzggZ+AlPMuVswrdmNbQsgbk5RGPAttquHzJ+npYcW9oo0hSRvR
 QPO3pYGcc9oGvhRYEjju3Sv5ALYAAuhqnukEWqhgc0pUTa6lYrxdzE2p7VQ0EGiDWOw=
X-Gm-Gg: AZuq6aLIHwUgR+WN17mnnxShj5VXfAtYkIQL4ECe44UOqvGqvcXmf72HX3ADAPFxSvj
 TMgyRpGRM/NBOdXEI3wxlU0NNUtoZKFw+zcCqUhN7NovjpgOplu9WpUjmRtzKsuzLY1zTYSlyJ1
 r1l4PFn/MbAolwsfSQUgEHAUvfHPz98qXfpb0wFydK9R4yFeF+BuC3Zb/gk5GOSfVKe13uMb8TI
 yH3FBL5YQr8ipRjmZD6EYf0xfpdyw0++4cgeoEB8iTczr8Xx/mgOVvvz42yTg7H50K1MEDlQTd0
 jfczECbXKd6DsnrltN2SsNxBeDEGpMZLxfF8v+FBjNX7k7I/VzpAbvJzh9ARJaU6zNC9bSQVhIq
 /lapHkw6JCyP09fIE39bbqa5HoKam28isdOwrbxtIDCirOGbTZHyhFH/tex/+NeBvHy6u1yf+n0
 yDh2nM3ndflaC7XQK3lv/Xh3lk+Re7H75smNEX98lEZe60N9NsZhM1muRcBxc37Dr6nsDX0fCQX
 7MCkWNrrpEd77snyT3v42hPI5I2gMzaVkDd
X-Received: by 2002:a05:6a00:b47:b0:823:602:9565 with SMTP id
 d2e1a72fcca58-8241c1eba85mr1407288b3a.18.1770169789632; 
 Tue, 03 Feb 2026 17:49:49 -0800 (PST)
Received: from ?IPV6:2401:d002:dc0f:2100:1bc:fe1e:491:928e?
 (bg30dhzlx7lnyrq74wrz.ip6.superloop.au.
 [2401:d002:dc0f:2100:1bc:fe1e:491:928e])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-8241d48789dsm592538b3a.58.2026.02.03.17.49.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 03 Feb 2026 17:49:49 -0800 (PST)
Message-ID: <8f91d8f3-0d7a-4438-b261-ca8ba509be96@linaro.org>
Date: Wed, 4 Feb 2026 11:49:43 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v4 2/5] accel/tcg: Have cpu_ld*_mmu() methods consider
 the MO_SIGN flag
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Artyom Tarasenko <atar4qemu@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Laurent Vivier <laurent@vivier.eu>
References: <20260203230054.23667-1-philmd@linaro.org>
 <20260203230054.23667-3-philmd@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260203230054.23667-3-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42d;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42d.google.com
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

On 2/4/26 09:00, Philippe Mathieu-Daudé wrote:
> Sign-extend the result when the MO_SIGN flag is requested
> in TCG common CPU TLB handling.
> 
> Remote the SPARC specific handling.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   accel/tcg/cputlb.c         | 37 +++++++++++++++++++++++++++++++------
>   target/sparc/ldst_helper.c |  9 ---------
>   2 files changed, 31 insertions(+), 15 deletions(-)
> 
> diff --git a/accel/tcg/cputlb.c b/accel/tcg/cputlb.c
> index 76546c66515..97782997881 100644
> --- a/accel/tcg/cputlb.c
> +++ b/accel/tcg/cputlb.c
> @@ -2296,12 +2296,18 @@ static uint8_t do_ld1_mmu(CPUState *cpu, vaddr addr, MemOpIdx oi,
>   {
>       MMULookupLocals l;
>       bool crosspage;
> +    uint8_t ret;
>   
>       cpu_req_mo(cpu, TCG_MO_LD_LD | TCG_MO_ST_LD);
>       crosspage = mmu_lookup(cpu, addr, oi, ra, access_type, &l);
>       tcg_debug_assert(!crosspage);
>   
> -    return do_ld_1(cpu, &l.page[0], l.mmu_idx, access_type, ra);
> +    ret = do_ld_1(cpu, &l.page[0], l.mmu_idx, access_type, ra);
> +
> +    if (l.memop & MO_SIGN) {
> +        ret = (int8_t)ret;
> +    }
> +    return ret;
>   }

Nope.  The return type is uint8_t, so this doesn't change anything at all.


r~

