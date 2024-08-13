Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25B69C52D7B
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Aug 2024 10:39:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sdovQ-00008Q-0d; Tue, 13 Aug 2024 06:38:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sdovN-00006c-EX
 for qemu-devel@nongnu.org; Tue, 13 Aug 2024 06:38:45 -0400
Received: from mail-ed1-x533.google.com ([2a00:1450:4864:20::533])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sdovL-0000WG-FC
 for qemu-devel@nongnu.org; Tue, 13 Aug 2024 06:38:45 -0400
Received: by mail-ed1-x533.google.com with SMTP id
 4fb4d7f45d1cf-5a10bb7bcd0so6578234a12.3
 for <qemu-devel@nongnu.org>; Tue, 13 Aug 2024 03:38:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1723545521; x=1724150321; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=mgAZcOQAThAzJJCq+i0mkaB1CcwP3mbj+b4EqeZ7Smg=;
 b=ispn1MjhdtRNc3PFO/noBaedN/haHF11rJzqPaUinZMourTCkKCNnbKeVzZOmiuN2O
 qnvcNmoDcJEeQ3Vf+O32pHZFmC9XOqsNGiMidkkuW0ZzE9/Ew0v3DR5BY+/frM3ij/TI
 kUWiqy4bjz4dPZACglJ44eRkZHY3aYebmF78og03cy+akePHNTuk3YB7iWtfNSvX6IJQ
 vVnbweWzyOF9ICBHdvm9DBPrqLK3dv17x8ZLmacf/KmE3v+TVU2m/YWO1SCslx0lRQt3
 3dI1V4ZCUwlDo71EdkUQzXM4oOy93CkmQLL4zCz1H2eOScrh15xl72/8TndHW0e+4q5R
 XYlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723545521; x=1724150321;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=mgAZcOQAThAzJJCq+i0mkaB1CcwP3mbj+b4EqeZ7Smg=;
 b=pNMb0RuHq5lcSQLGai+NzPT7BdPIijyZKgd4ZmY2HjFQCCen3oLQM7WAaEZay7sG0A
 6/VsVRwBb6Mc1q1O+9H0tNh04UO4WTAgMovBHZNaV7Vs66Iydwqy792Qqud9va/drNDy
 9zOE2utC1mkqxnln0pDgT3HAq7YLpLmCT3DrqTB6Ta2EWCX+pECTBS8SWOC7WewlEBnM
 gp23l4v59qb7jzKScHRma7ynjBJ54n/IgaQCaoHRQryuKBLyM3IeOyjxrj8psDBX/lvy
 TbS/xk8CAsZDKoEZdBGojIf53j2MY84rS88wFOA9RlWPQLJPVr2uQhM4N/AjyXLRmX+n
 8gFg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWwaycb7IaE/V7rTOu0PwmjxoNkz/uz0yhIbuu0rGuo3vOs6qDblQr+tm81W7IyiOfqJD4DVFyyqHEiPOYWlypzWbd54Lc=
X-Gm-Message-State: AOJu0YyQpRD45v+2qQ0Io2M6bYro/dsm1DvyNCwpeU0nFcvfK9n9UQnw
 l2LEMzoKDjevKjm8Yfl7Vkp1DVZYNl3B34V2hLHYEVBW9pqI1CMnJA0Q6cgda80=
X-Google-Smtp-Source: AGHT+IH+k/jeWUlpPzP2vNHKVoYiipwI4vtuwY58Wcmz1bUdadoB7V6Of1ghjm3CuViEhC0+Wkdvlg==
X-Received: by 2002:a05:6402:35ce:b0:5b9:3846:8bb3 with SMTP id
 4fb4d7f45d1cf-5bd44c2854amr2532733a12.12.1723545521125; 
 Tue, 13 Aug 2024 03:38:41 -0700 (PDT)
Received: from [192.168.69.100] ([176.176.129.17])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5bd190ad256sm2809513a12.33.2024.08.13.03.38.36
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 13 Aug 2024 03:38:40 -0700 (PDT)
Message-ID: <6d425bd0-efd0-42ee-af3e-d7b5c3379d55@linaro.org>
Date: Tue, 13 Aug 2024 12:38:29 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH for-9.1] linux-user: Preserve NULL hit in target_mmap
 subroutines
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org
References: <20240813094654.306430-1-richard.henderson@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240813094654.306430-1-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::533;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x533.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On 13/8/24 11:46, Richard Henderson wrote:
> Do not pass guest_base to the host mmap instead of zero hint.
> 
> Cc: qemu-stable@nongnu.org
> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2353
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   linux-user/mmap.c | 18 +++++++++++++++---
>   1 file changed, 15 insertions(+), 3 deletions(-)
> 
> diff --git a/linux-user/mmap.c b/linux-user/mmap.c
> index 4d09a72fad..6418e811f6 100644
> --- a/linux-user/mmap.c
> +++ b/linux-user/mmap.c
> @@ -560,9 +560,13 @@ static abi_long mmap_h_eq_g(abi_ulong start, abi_ulong len,
>                               int host_prot, int flags, int page_flags,
>                               int fd, off_t offset)
>   {
> -    void *p, *want_p = g2h_untagged(start);
> +    void *p, *want_p = NULL;
>       abi_ulong last;
>   
> +    if (start || (flags & (MAP_FIXED | MAP_FIXED_NOREPLACE))) {
> +        want_p = g2h_untagged(start);
> +    }
> +
>       p = mmap(want_p, len, host_prot, flags, fd, offset);
>       if (p == MAP_FAILED) {
>           return -1;
> @@ -610,11 +614,15 @@ static abi_long mmap_h_lt_g(abi_ulong start, abi_ulong len, int host_prot,
>                               int mmap_flags, int page_flags, int fd,
>                               off_t offset, int host_page_size)
>   {
> -    void *p, *want_p = g2h_untagged(start);
 > +    void *p, *want_p = NULL;

Maybe extract as static helper?

       void *p, *want_p = g2h_untagged_FOO(start, flags);

>       off_t fileend_adj = 0;
>       int flags = mmap_flags;
>       abi_ulong last, pass_last;
>   
> +    if (start || (flags & (MAP_FIXED | MAP_FIXED_NOREPLACE))) {
> +        want_p = g2h_untagged(start);
> +    }

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>



