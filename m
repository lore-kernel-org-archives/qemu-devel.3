Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 404CAC02188
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jan 2025 01:00:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tcZwZ-0003u4-W3; Mon, 27 Jan 2025 19:59:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tcZwY-0003tm-Tj
 for qemu-devel@nongnu.org; Mon, 27 Jan 2025 19:59:06 -0500
Received: from mail-pl1-x62f.google.com ([2607:f8b0:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tcZwX-0008Bi-49
 for qemu-devel@nongnu.org; Mon, 27 Jan 2025 19:59:06 -0500
Received: by mail-pl1-x62f.google.com with SMTP id
 d9443c01a7336-2166360285dso86328945ad.1
 for <qemu-devel@nongnu.org>; Mon, 27 Jan 2025 16:59:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1738025943; x=1738630743; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=ZNJkqOFUlf+JMjg/qrCd8u92786zvrxFFOaN8oYOYEc=;
 b=qlqAS8HFj/dLqgr5IhOfz9jXxApcdEIdZ11aUYpUFWsGCP2gjs+v8ez3abp42j5enn
 pDW1hU62Q8KSJWwti79Rj6GzJCHQzTf/ZLZAMhRgJp6rycRKaqMcgg9UGahr61tdOwtN
 u0doFaZ6PF76AgGumXg/Ml15OmUh9XnbjvFsm38B2t3QhpxmTh2+Ef8kqJ9FMk9EA7pY
 KeTF/WkqDI9cEIpUVCB/hMRLQqecn/J1y+Ntf9LWHsSwqJ81Kc4oQOIsSLR1qdQIjiuJ
 K7x1471eE/VOWHl1uHXxdT0sF7uhbW6XOeFKhC/APpvzHSL7PQneM7kwzU/23aZUYe+7
 X3ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738025943; x=1738630743;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ZNJkqOFUlf+JMjg/qrCd8u92786zvrxFFOaN8oYOYEc=;
 b=eXqx/lPgMYOjVqtvISSwCraiFjgZttxerwXWiC2JTgtpCfIBKEiuK+jmjxV5/9FhjO
 tX6oLdtrRGAqCG+bBoqtz6AdlH5/49C7ComQ7aT6K5/BV2AcY03XpY+Hr49nGVIRd4c0
 wAQmg0zdxXuvQdJUdMklNCHZufpDch7SJIUK2S9LO14iESFXW1a8QRQpc+nwOHi7aF0+
 QImw/sC4OVOlzoJVk40Cg3CAryNkwC0IIu0KJmt6kpc7GmCK8MQGnYkisca1+rvnHyCT
 CEbm8IRdj2ZPEe3bTafoMrwj340WKdGI6An4ktSp/8YidjDipbectRA5+gPndOVa+38+
 GjiQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCW3PV9S56/veY1q7OzkpbyFX0dNFjUzg6OElQB8nLAWMPcyPk3wtc0j4W8QO+OebgmOT2nQ6AIlE1G9@nongnu.org
X-Gm-Message-State: AOJu0Ywck2Sl8ZkYnUz89ve9FdbKH3Q+8EGOxAfi1YyvgkbF8voOT31f
 NFAIu0ZEv6y5we7nX8WjJBh5AQW87ecZXiGz3JizO+xElx5fC+10gY2z8p5GdAA=
X-Gm-Gg: ASbGncuP/kIzdvjmNui74z8KQLZGwE60jxZVvLS490phYwsbTWiSWdVGEQkAE86ijLS
 lFq/vwZgL+G38/SNAjJqTEP3fXxmVjaVwRZmlzjpUwf0xDb54w43ALk5lb3gAJAbwZOiJv59xcU
 YhJEVbTk+CETYUJHH2tEk/xrGg0PB4/UwJmpyzwUe9P3wa16lYPbZsG8W5yYoYIdjyPKoohAP5q
 QJoXd/A2DkX3hSSHwEpqnxrRwmnXu90jcFwGe8c/NNumkxMisFhlQzU4p1707t6bLPoUQ4qfRuC
 Z0sSS5zOAQeo4cdaT9j7jrIjo734a58esCAeolI4aJy5Hbs=
X-Google-Smtp-Source: AGHT+IH27hf7HZ5c3c2GnWkLLuKzdKaXPizPPZ03ZLRwN7UXGlw3Nw97F3aNY4gpq2oWlUwSyr9fRg==
X-Received: by 2002:a17:902:d590:b0:216:725c:a122 with SMTP id
 d9443c01a7336-21c35512745mr704957345ad.19.1738025942983; 
 Mon, 27 Jan 2025 16:59:02 -0800 (PST)
Received: from [192.168.0.4] (174-21-71-127.tukw.qwest.net. [174.21.71.127])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-21da3ea3346sm69560465ad.78.2025.01.27.16.59.02
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 27 Jan 2025 16:59:02 -0800 (PST)
Message-ID: <d48a825f-571c-4158-834c-96bf63b88bb1@linaro.org>
Date: Mon, 27 Jan 2025 16:59:00 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] target/s390x: Fix MVC not always invalidating
 translation blocks
To: Ilya Leoshkevich <iii@linux.ibm.com>, David Hildenbrand
 <david@redhat.com>, Thomas Huth <thuth@redhat.com>
Cc: qemu-s390x@nongnu.org, qemu-devel@nongnu.org,
 Berthold Gunreben <azouhr@opensuse.org>, Sarah Kriesch
 <ada.lovelace@gmx.de>, qemu-stable@nongnu.org
References: <20250128001338.11474-1-iii@linux.ibm.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250128001338.11474-1-iii@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62f;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62f.google.com
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

On 1/27/25 16:12, Ilya Leoshkevich wrote:
> Node.js crashes in qemu-system-s390x with random SIGSEGVs / SIGILLs.
> 
> The v8 JIT used by Node.js can garbage collect and overwrite unused
> code. Overwriting is performed by WritableJitAllocation::CopyCode(),
> which ultimately calls memcpy(). For certain sizes, memcpy() uses the
> MVC instruction.
> 
> QEMU implements MVC and other similar instructions using helpers. While
> TCG store ops invalidate affected translation blocks automatically,
> helpers must do this manually by calling probe_access_flags(). The MVC
> helper does this using the access_prepare() -> access_prepare_nf() ->
> s390_probe_access() -> probe_access_flags() call chain.
> 
> At the last step of this chain, the store size is replaced with 0. This
> causes the probe_access_flags() -> notdirty_write() ->
> tb_invalidate_phys_range_fast() chain to miss some translation blocks.
> 
> When this happens, QEMU executes a mix of old and new code. This
> quickly leads to either a SIGSEGV or a SIGILL in case the old code
> ends in the middle of a new instruction.
> 
> Fix by passing the true size.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

> 
> Reported-by: Berthold Gunreben <azouhr@opensuse.org>
> Cc: Sarah Kriesch <ada.lovelace@gmx.de>
> Cc: qemu-stable@nongnu.org
> Closes: https://bugzilla.opensuse.org/show_bug.cgi?id=1235709
> Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
> ---
>   target/s390x/tcg/mem_helper.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/target/s390x/tcg/mem_helper.c b/target/s390x/tcg/mem_helper.c
> index 32717acb7d1..c6ab2901e5a 100644
> --- a/target/s390x/tcg/mem_helper.c
> +++ b/target/s390x/tcg/mem_helper.c
> @@ -149,7 +149,7 @@ static inline int s390_probe_access(CPUArchState *env, target_ulong addr,
>                                       int mmu_idx, bool nonfault,
>                                       void **phost, uintptr_t ra)
>   {
> -    int flags = probe_access_flags(env, addr, 0, access_type, mmu_idx,
> +    int flags = probe_access_flags(env, addr, size, access_type, mmu_idx,
>                                      nonfault, phost, ra);
>   
>       if (unlikely(flags & TLB_INVALID_MASK)) {


