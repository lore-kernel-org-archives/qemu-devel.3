Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ACB48CA0EED
	for <qemu-devel@archiver.kernel.org>; Mon, 25 Aug 2025 00:59:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uqLXm-0003A6-Ux; Sun, 24 Aug 2025 20:58:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uqLXl-00039k-HO
 for qemu-devel@nongnu.org; Sun, 24 Aug 2025 20:58:41 -0400
Received: from mail-pf1-x42c.google.com ([2607:f8b0:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uqLXj-0000bT-TJ
 for qemu-devel@nongnu.org; Sun, 24 Aug 2025 20:58:41 -0400
Received: by mail-pf1-x42c.google.com with SMTP id
 d2e1a72fcca58-76e2eb6d07bso3145890b3a.3
 for <qemu-devel@nongnu.org>; Sun, 24 Aug 2025 17:58:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1756083518; x=1756688318; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=fUiUAahmJ19uECfDHW0/YqKntlhhJr0tNZPq/CNwnMk=;
 b=IoXNYwquv2/zAp9YDOsnFOJ23UB+YT4sXjx4FRCALbTq65pxYkAiTck0GRVkYzqeRw
 9NyTTgG7Hj8lC3EKwowtPMh4MeE3BggKoKJ+XNti3U6BgxBG2fCsifY/QyeD3jRD8RQQ
 wkne2unJ4hiCWKbeJ5IcZ7SynBJerFR81qOUvB4KMOo4L2HARzXhaNc8FlD1LA6A/7Zt
 ++JOcX/k+wU+vbpEVI5dtSBn3u7OYwUJjk7z2bNJJiKLW7bwcMjFOwB0IsbjD0A2yEKL
 +ExNKTpFvW2Tv6yCzefA/uv1AmARq4Ds2wx7KWMw40Pai3fSp4jJP4WsHTIoya3S+fOb
 L/DA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756083518; x=1756688318;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=fUiUAahmJ19uECfDHW0/YqKntlhhJr0tNZPq/CNwnMk=;
 b=Uue9ky1rSnxpO7wKUqG+HGZMuzUPzr48mxIHD7TeEpC484/TUMvKvleBF3ao6Rwa/s
 thJZotnuuIW2/2gWi1n3sOYRbbfeGtDzjFMHPoLbOi5pmUrfR0+8pKhiEkgnfLIPC17R
 FLQWmlYZkhr1QPistheC+cXkE28KLy7cXO6qvduuOmnPggWtefC73aJoA+YU4P6L6CgV
 MO5Wabin3Yb17+68zsqabZf7HaCp7u2+tngd8ghtkz3SeihuOuweyFOBLp2FnU/AuIko
 HNi6nyD2BdVoBmKVfZJ8TzTpt434PzHkkaIzaRBMxR2aB64i+/M8OznpHIX2NtcJNpJ1
 rrzA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVJO7Ic7R/od4oiYU3byoCQhwYX3/F3NBj92lLxVS2kqWM9cR1jeu1JZBoy+/HM7x8tPTcTTy8FjA5t@nongnu.org
X-Gm-Message-State: AOJu0Ywapopu1mY+t/QqGGzgcBzrP5dy5JyFuv/tpNeqSwtYKinPjnXi
 IpdQy4J8DhnaBnXT5bpVnkcrHWXYuagxxBtkMY82vuv7+42V4Q2lLoxzi5CfCvOOnYE=
X-Gm-Gg: ASbGncspTO86+QXqcDCxITrYXFULEMDvjlKI9Wb14IUVPgcGKDRFSCimzDRgl/zkkPf
 CHeCoiF3mDGkelWMJwuKjPgSFUk+rbAvstb4kP8Abo4/BiE+IW46USzZtGFeVmOKzWW99pi69Fr
 H3RuJGYdz7KqDKDgcJFQdz/n1EJAr5EmUqw6LgKfE14qTxfMdwLNgoAH4hqjils9l50Xkb3A6uw
 zn/K7R5ricKiUhLCFA57NCSdWTJQsvsgtwPXuC++uguJ2BAFgJeGfXIPg0W6p61CBX1agHw7wdG
 9WVoNCYvZIdxDwWEosbbcfAtX2VLmhE8CtkU5gXk7sUuWmGUF0d90qFfBi94QE+QQInb5G9SZiO
 QioF813qc6fG2q/6VQvz0xOcvHaeDNBh8c2sQwDLy11KbR3woahWkHPK0pUsoCXhM85oeKQ/thc
 WoKRTbrUK/6OMh6yukv000Dh+LztYhCaWZTG+/WOGCnKK0p1ytUZdEdm95Tl2Vr2qT
X-Google-Smtp-Source: AGHT+IFByj2yhMPk9msU1HEyEXRfYE6NbvMBwGbvf/OzFkdt+klpI4Hjj/o1JnbPA9HWJrBDNV/jtg==
X-Received: by 2002:a05:6a00:3923:b0:76b:ec81:bcc9 with SMTP id
 d2e1a72fcca58-7702fac61ffmr13248345b3a.21.1756083518057; 
 Sun, 24 Aug 2025 17:58:38 -0700 (PDT)
Received: from ?IPV6:2401:d006:5c08:e100:2b1d:8711:2597:136f?
 (19r3hzjj0vw81f3fs315.ipv6.originbroadband.com.au.
 [2401:d006:5c08:e100:2b1d:8711:2597:136f])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-771e39cb489sm927754b3a.84.2025.08.24.17.58.32
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 24 Aug 2025 17:58:37 -0700 (PDT)
Message-ID: <dc1019c3-8e97-480e-b6a3-d184d54afd6d@linaro.org>
Date: Mon, 25 Aug 2025 10:58:27 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] accel/tcg: Unify big- and little- endian atomic ops
To: Danila Zhebryakov <d.zhebryakov@yandex.ru>, qemu-devel@nongnu.org
Cc: Chinmay Rath <rathc@linux.ibm.com>, Nicholas Piggin <npiggin@gmail.com>,
 Riku Voipio <riku.voipio@iki.fi>, Ilya Leoshkevich <iii@linux.ibm.com>,
 qemu-ppc@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 David Hildenbrand <david@redhat.com>, qemu-s390x@nongnu.org,
 Laurent Vivier <laurent@vivier.eu>, Thomas Huth <thuth@redhat.com>
References: <20250821113348.91339-1-d.zhebryakov@yandex.ru>
 <20250821113348.91339-2-d.zhebryakov@yandex.ru>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20250821113348.91339-2-d.zhebryakov@yandex.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42c;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42c.google.com
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

On 8/21/25 21:33, Danila Zhebryakov wrote:
>   ABI_TYPE ATOMIC_NAME(cmpxchg)(CPUArchState *env, vaddr addr,
>                                 ABI_TYPE cmpv, ABI_TYPE newv,
>                                 MemOpIdx oi, uintptr_t retaddr)
>   {
> +    bool need_bswap = get_memop(oi) & MO_BSWAP;
>       DATA_TYPE *haddr = atomic_mmu_lookup(env_cpu(env), addr, oi,
> -                                         DATA_SIZE, retaddr);
> -    DATA_TYPE ret;
> -
> +                                         DATA_SIZE, retaddr, &need_bswap);
> +    DATA_TYPE ret, ret_e;
> +    if (need_bswap) {

I'd rather you do all of the bswap detection in the helper, not put part of it here and 
then modify the partial value.


> diff --git a/accel/tcg/cputlb.c b/accel/tcg/cputlb.c
> index 87e14bde4f..841b54e41d 100644
> --- a/accel/tcg/cputlb.c
> +++ b/accel/tcg/cputlb.c
> @@ -1808,7 +1808,7 @@ static bool mmu_lookup(CPUState *cpu, vaddr addr, MemOpIdx oi,
>    * or io operations to proceed.  Return the host address.
>    */
>   static void *atomic_mmu_lookup(CPUState *cpu, vaddr addr, MemOpIdx oi,
> -                               int size, uintptr_t retaddr)
> +                               int size, uintptr_t retaddr, bool *need_bswap)
>   {
>       uintptr_t mmu_idx = get_mmuidx(oi);
>       MemOp mop = get_memop(oi);
> @@ -1894,6 +1894,14 @@ static void *atomic_mmu_lookup(CPUState *cpu, vaddr addr, MemOpIdx oi,
>           notdirty_write(cpu, addr, size, full, retaddr);
>       }
>   
> +    if (unlikely(tlb_addr & TLB_BSWAP)) {
> +        assert(!( (  full->slow_flags[MMU_DATA_STORE]
> +            ^ full->slow_flags[MMU_DATA_LOAD ])
> +            & TLB_BSWAP));

You can skip the assert. It's impossible to set a page with differing values.

> +
> +        *need_bswap = !need_bswap;
> +    }

This becomes

       mop ^= MO_BSWAP;
     }
     *need_bswap = mop & MO_BSWAP;


r~

