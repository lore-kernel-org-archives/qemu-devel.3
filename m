Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 297FECA0FF2
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Sep 2025 10:39:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1utksq-0002tF-AS; Wed, 03 Sep 2025 06:38:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1utksk-0002rY-V1
 for qemu-devel@nongnu.org; Wed, 03 Sep 2025 06:38:27 -0400
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1utksj-0000xd-0X
 for qemu-devel@nongnu.org; Wed, 03 Sep 2025 06:38:26 -0400
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-45b7722ea37so4627585e9.1
 for <qemu-devel@nongnu.org>; Wed, 03 Sep 2025 03:38:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1756895901; x=1757500701; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=lHgLtnvHBQmmbohVEEI2nG20Khn1EVlqTj5cEr/ntEg=;
 b=Tt2nJJ03OY/XoIJlTes0sWujWHs0uSiWsRmZA+vyidaGXdBjpMv7MPVc0vtw0aIsEU
 2g+YJpdFoTLu1Id4BQvwemvHLMhi81ezFM5b9SWo/63YORUGcXqFoFDLvWULFqa9veQv
 +OX82JVCDM0BuqT2S09CQe9IkGmv+pGk5O7cwPMR1ZnmPtBE0oNHAOau5UXPpmSdcwkM
 HPMRa4Awfe0Z2lthnnOrZkoSJmziAVO8UcHwnEQdCWKSeRj6PMgokRqh5ECO2lNXc2ei
 kon4Ojez81QM9ObVIq1tb9cbtJ+8Y5bCIB8gFB+D56GEOeEIkcqlmQ4UzUrW3sbb/8VN
 pvug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756895901; x=1757500701;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=lHgLtnvHBQmmbohVEEI2nG20Khn1EVlqTj5cEr/ntEg=;
 b=dvRDY0sk3uur+6dXl8qU77QhQmM3TcTw2LXVWDH9MJG6Gk2an1nOPMhdJFJrm/Ouks
 yl/zYdJ6FVtR32YEeKZ7QGuhIv9eEqCYVi4nbBk9oR2b3N4LyziFO5NOBH/GYuP8crRL
 NoLCUnoBrGSIbsg2QUPo7MljfK/lVZLywDr9Qr8fWXCgk09Vfq3XZAsL9KBQcz9NuYOl
 dcXxOQrE6nqP5qadIXu3MYRLUkOLdzbczKCp92pzoWqUrj7gmqaMQFU/NvVMdiJthvyF
 m0Qo/aUuSrUG1HMFY7O6ecjl1iKM15hPItTlMX+jI+fg/6UygVgTLufM8n0EBxi0u7Lc
 HWxw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVxyb0P0xn48HOXL8BwPDjygFNGMvPo5uFrO7o6dQhmN3QXZvjDjdDdkY64JRQbmFwYY44UmYNKC6lY@nongnu.org
X-Gm-Message-State: AOJu0YxAVsipMja+1WsTHD0IdEYHgvWYBtmr1Vqc9qgG7wvX/NkoAVP7
 QrZ/5dVl60/TiXqgKR5bKSCch/kMmjD2uMthp0CQ2TyY8SzeYc5QDe95a60kKG/yQHw=
X-Gm-Gg: ASbGncuE4SmQhlVjaDtZkinal7IaqtOBcj1fjNqaeD7cAAaR3GHx+mwfA2Q0KLhmGXR
 Ry9qiXo2TVj06a7A+wZKa409UBVlAgn1PqrvmdH5ZdT1UnjXN+tR8+MkfBuvRa3iyJLYgMOKrGm
 pxGXLvl4JS4gWNkrnEda8esgc9HHbXZULhEVT4JzHv7e45Tu6NBaNEGDtc/ux3P+b9hXDafvpuR
 WW6x3Io9Z8sMd19nOt7cVj4Kd/o+ue4sT2km+4E106eXdvSNuAAl6KU/kpchcDchF+rvfJizkUl
 +2bIA9rlvI1aZ5t+2UEvlyghMhqE3EXfbvPzEd3mA+0fqI1DuiH5g/1ntAd7CvqiiT7m8P0Qm+L
 3BsEjETiS7dHgEzj9Kua7KkGd4oyuX1J0/gDN2KHV+iexvRSybD3yqdMorEgGP7ViEJUx8xe2Bq
 svHifDW2bu6q6aJ9eqNy8=
X-Google-Smtp-Source: AGHT+IGkJ6wEABHayyY8edD/iHKITywo3F9AoLkY8LY1AUAKOByIEyZP7DyyF7bnuoUWtgJuUcDnfw==
X-Received: by 2002:a05:600c:5247:b0:45b:910c:adf with SMTP id
 5b1f17b1804b1-45b910c0ba0mr61139175e9.12.1756895901481; 
 Wed, 03 Sep 2025 03:38:21 -0700 (PDT)
Received: from [10.223.47.213] (98.red-88-29-180.dynamicip.rima-tde.net.
 [88.29.180.98]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-45cb687fe4esm13009465e9.23.2025.09.03.03.38.20
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 03 Sep 2025 03:38:20 -0700 (PDT)
Message-ID: <2f195d44-21e6-4829-9e5b-03177452b889@linaro.org>
Date: Wed, 3 Sep 2025 12:38:19 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] memory: Fix addr for flatview_access_allowed()
To: Peter Xu <peterx@redhat.com>, qemu-devel@nongnu.org
Cc: David Hildenbrand <david@redhat.com>, Paolo Bonzini
 <pbonzini@redhat.com>, Peter Maydell <peter.maydell@linaro.org>
References: <20250902214005.730358-1-peterx@redhat.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250902214005.730358-1-peterx@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x335.google.com
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

On 2/9/25 23:40, Peter Xu wrote:
> flatview_access_allowed() should pass in the address offset of the memory
> region, rather than the global address space.
> 
> Shouldn't be a major issue yet, since the addr is only used in an error
> log.
> 
> Cc: Philippe Mathieu-Daudé <philmd@linaro.org>
> Fixes: 3ab6fdc91b ("softmmu/physmem: Introduce MemTxAttrs::memory field and MEMTX_ACCESS_ERROR")
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
>   system/physmem.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/system/physmem.c b/system/physmem.c
> index f498572fc8..019118cf75 100644
> --- a/system/physmem.c
> +++ b/system/physmem.c
> @@ -3027,7 +3027,7 @@ static MemTxResult flatview_write(FlatView *fv, hwaddr addr, MemTxAttrs attrs,
>   
>       l = len;
>       mr = flatview_translate(fv, addr, &mr_addr, &l, true, attrs);
> -    if (!flatview_access_allowed(mr, attrs, addr, len)) {
> +    if (!flatview_access_allowed(mr, attrs, mr_addr, len)) {

Right, but shouldn't we also use the translated length?

        if (!flatview_access_allowed(mr, attrs, mr_addr, l)) {

>           return MEMTX_ACCESS_ERROR;
>       }
>       return flatview_write_continue(fv, addr, attrs, buf, len,
> @@ -3118,7 +3118,7 @@ static MemTxResult flatview_read(FlatView *fv, hwaddr addr,
>   
>       l = len;
>       mr = flatview_translate(fv, addr, &mr_addr, &l, false, attrs);
> -    if (!flatview_access_allowed(mr, attrs, addr, len)) {
> +    if (!flatview_access_allowed(mr, attrs, mr_addr, len)) {

Ditto.

>           return MEMTX_ACCESS_ERROR;
>       }
>       return flatview_read_continue(fv, addr, attrs, buf, len,


