Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 236F0C43602
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jul 2026 17:47:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wh9se-0004V4-Sh; Tue, 07 Jul 2026 13:46:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wh9sd-0004UW-Rr
 for qemu-devel@nongnu.org; Tue, 07 Jul 2026 13:46:47 -0400
Received: from mail-pl1-x629.google.com ([2607:f8b0:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wh9sb-0000Y9-3v
 for qemu-devel@nongnu.org; Tue, 07 Jul 2026 13:46:47 -0400
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-2ca70925c25so57657315ad.1
 for <qemu-devel@nongnu.org>; Tue, 07 Jul 2026 10:46:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1783446401; x=1784051201; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=3sMdVol0gdjWLFJmeU/sL5ExcaNLdVxgwXus46FfxVs=;
 b=RQzAmGR+GTDz++MpkikxbJJaVkos+SCboT1TOWfT9Qow9Ik4nGJECwyjlOd/ADXi0D
 YJhrNKt+tQhw/7BYVJkEWPqkN/V9o1n1i1AAcjoIVuXFAN0AiO/6ObUaP6SzbVtPqFDQ
 LKWraahhx7BT33gMF9BTU74rXADc8oXyPT+a0mRjRFVPDThA290fNmZ/iy23ZspyEeKb
 cEQ1FQkXv4dh4rnF6VV1jlynV+Dv7eHl5XoyyvUHIInGbXVJs0MzdLCrYQsUHSL4XNfI
 ISY9K5oT/e7CruKjFNPmgoRjUWguLwSLsONCrXSrnvjvVe5Ae0DpxOPle5EMvhfGBkLn
 IVnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783446401; x=1784051201;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=3sMdVol0gdjWLFJmeU/sL5ExcaNLdVxgwXus46FfxVs=;
 b=c9xuVbODW1btzOBw6OUc14bnsYMyENXyDKQFaOtKpOzfPwaLDd9z2cfYieGK6e/XRR
 FPlZC3pOp163Dwdyq+c2dhw9MrHTHNeJ0Jl09ed9VXr83QDXwcFaNiGeJfOWJEPJEXWx
 n38dyBfCGn1Thv6tety4Wt5tf9lG/UhozLaYH0aIf4I7COLFU0wXLU4Y+qZLo0PQ5zS2
 uBh+dhYEdb6WK/TV1IA3GlHcZ0j6hw0MHNy0GsYkwCuSKF0dMz688Tj4mp6UzGYQxx6g
 SbkZvJoY5EpKMTwX0rzoGchBJaoxnWxgIP4e0+TPyiNjvR061Fuiqw/BSFF4s8P79Iz6
 kiYA==
X-Forwarded-Encrypted: i=1;
 AHgh+RpKJ1bLJyWpuqSDIYFYfmO72P5V7fGp2+QlEzfNKMDzEMhpjVsmzPMN2uXcwixb2qmp6VrHrBoqvjYy@nongnu.org
X-Gm-Message-State: AOJu0Yx38cP5BoJCDmqKjIPRYzsjuTOvWVWPu1Be2Hgo1T4KKOczhAfp
 l7KesiAMkqwBrWdfwkYr+9XMMyKTIlBjHEnzucutqdJmMuWuPpGu6ckbUmVkBeE2eeI=
X-Gm-Gg: AfdE7cmfEbhQJhYXNDECXe7yF+VljG8FLK7jrEFWV0E6yDafaiqSg+BQWPn5W1VBMi/
 RmvhtX0DulLyCuiSMGNjanrM8LRo/q9PY25TEvbpzMAqd9nGbsEplISlManUYPtvu3cRD205IzV
 pLM1VNX+iGMo4fn9PBtYkxoIWFpDhkaMQCQDhIURVytWyV5D8rhAPTuFiFNLLXOaDmKhfZIfShI
 IQo3wIUnOYEUDI9zQxL549q3crDttEEJj1d/3mAaQIA2SgorCglLLGj5jFbb+mJWx5sQl69K7YX
 ny9W5jKb3RFlQgRHK9ocIxdrsU0LEuYpkUycZWqNrKOzoIaGC2z/dnb6KNgLc7vlzgxZ66lelT/
 oasIFTEYN+ZNS4nMAU5tLR44bI5VK2fO1mBLucb4I3/5xXfZb2dM5kx9f3sfGDcOHMZxLjCFKJU
 AX5JTBzmP4usLgmiL9r8Xg0a6gESZ4tPvpeTAt0Nmfy8Tg02VlBNgSBvw=
X-Received: by 2002:a17:902:e84e:b0:2c9:e5ff:995d with SMTP id
 d9443c01a7336-2ccbf051374mr67932065ad.31.1783446400546; 
 Tue, 07 Jul 2026 10:46:40 -0700 (PDT)
Received: from [192.168.0.4] (71-212-39-188.tukw.qwest.net. [71.212.39.188])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2ccc9d3b906sm16173925ad.56.2026.07.07.10.46.39
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 07 Jul 2026 10:46:40 -0700 (PDT)
Message-ID: <38651779-9181-4f22-93cc-23fc508ac9ce@linaro.org>
Date: Tue, 7 Jul 2026 10:46:38 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] tcg/x86_64: declare MO_ATOM_WITHIN16 host atomicity
 support
To: Andrew Jones <andrew.jones@oss.qualcomm.com>, qemu-devel@nongnu.org,
 qemu-riscv@nongnu.org
Cc: daniel.barboza@oss.qualcomm.com, LIU Zhiwei <zhiwei_liu@linux.alibaba.com>
References: <20260707122819.114105-1-andrew.jones@oss.qualcomm.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260707122819.114105-1-andrew.jones@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::629;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x629.google.com
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

On 7/7/26 05:28, Andrew Jones wrote:
> Just like aarch64's prepare_host_addr(), x86_64 should use
> MO_ATOM_WITHIN16 for the memop when it's capable. Unlike aarch64,
> which needs to check a CPU feature, x86 has been capable since P6
> family processors and newer (see Intel SDM Vol. 3 §11.1.1).
> 
> Since a 16-byte aligned region always fits within a 16-byte multiple
> sized cache line (x86_64 implementations always have cache lines of
> at least 64 bytes), then this enables riscv cpu models with Zama16b
> to use the fast path, just as cpu models without Zama16b do.
> 
> Cc: LIU Zhiwei <zhiwei_liu@linux.alibaba.com>
> Signed-off-by: Andrew Jones <andrew.jones@oss.qualcomm.com>
> ---
>   tcg/x86_64/tcg-target.c.inc | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tcg/x86_64/tcg-target.c.inc b/tcg/x86_64/tcg-target.c.inc
> index 92251f832738..99b6559eed88 100644
> --- a/tcg/x86_64/tcg-target.c.inc
> +++ b/tcg/x86_64/tcg-target.c.inc
> @@ -1934,7 +1934,7 @@ static TCGLabelQemuLdst *prepare_host_addr(TCGContext *s, HostAddress *h,
>           *h = x86_guest_base;
>       }
>       h->base = addr;
> -    h->aa = atom_and_align_for_opc(s, opc, MO_ATOM_IFALIGN, s_bits == MO_128);
> +    h->aa = atom_and_align_for_opc(s, opc, MO_ATOM_WITHIN16, s_bits == MO_128);
>       a_mask = (1 << h->aa.align) - 1;
>   
>       if (tcg_use_softmmu) {

You should update both uses of atom_and_align_for_opc.

With that,
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

