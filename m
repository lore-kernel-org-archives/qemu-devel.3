Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9F3CC3271F
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jul 2024 18:04:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sPQoo-0005cp-Dl; Thu, 04 Jul 2024 14:04:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jean-philippe@linaro.org>)
 id 1sPQom-0005Z5-ST
 for qemu-devel@nongnu.org; Thu, 04 Jul 2024 14:04:28 -0400
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jean-philippe@linaro.org>)
 id 1sPQol-00088I-8J
 for qemu-devel@nongnu.org; Thu, 04 Jul 2024 14:04:28 -0400
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-367a3d1a378so277755f8f.1
 for <qemu-devel@nongnu.org>; Thu, 04 Jul 2024 11:04:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1720116265; x=1720721065; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=Es/jxLkK50VhJEf17n9Xpm/bjPPab2SRedAoqRTJxiU=;
 b=M1gh9Hj03uGxfYIq6IIm5W88dQwezYiEccIagUAvsUvtkI/hwStRUtL+jBAIDCHw6z
 aTJJYufzYJJCWyKHNclL6PkPHDFLYOzDhXALMKK2AtpYAZZc/eUL11UyWLVXMa/e6h6a
 MDi8ejMu1pIGzuWUxznC/ZLkhLug0QoGpkHmqr+Mvo4Y22XZ1DQUg1jI0ocaKdC3+lXX
 k6XfsPLjSfsQhIwpNXnKOI6k/OnS3J5C2Ko6/hSIWuBVcB8jKBZabpPnAWWM39rMNhuq
 BNGCVEwWuRsLedYsjkrDxaBWLEKnsD5p1j/PpaKaxh4nkZ+fSMpBY8T4bo/qseMrz/96
 MKCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720116265; x=1720721065;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Es/jxLkK50VhJEf17n9Xpm/bjPPab2SRedAoqRTJxiU=;
 b=HkMPI3vU2B7P5n0u4TkEJyFG3LBVLHNQurJvQ/unt6T07XhwnINe1zA6SqOL9/BRE/
 ACejxk3DSxNqBEjCSz7fZVYLZJTqSnVhC78+eibXGgTW3BSt1vSwb43VUS940tbjaA2Z
 xbrOuBc9HOwB7dmSti8uloGP8cvLDrr1JQqJaZE8ZwjzO9Rnf0EnTcAORgU3vOHsAdTw
 7t4ObYF8UUOGXGe9ksypQAG8ybIAMuJxi8lwi1V2O1UzAolzxj+yNCx8igH5oPq4nrt+
 AD3KYInwwowzJiccCEIq1fKy7AMMb2YEHryMWqfs86i9oP4FJ7wRImzcqABvwh6Wxj4q
 XQSQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUidHm4kyfHQB0Nj1L20NSrdB0I0mEkRTmC/Th7CEYgbMqhtXejlHUYPEJB8+1DmqYZiIjt58U0biv/xSOi7vB7lRsSOS8=
X-Gm-Message-State: AOJu0Yz4prsgug2zZJSTufXg9aFSGxOKJkezi8i29fw2d8eQMfSi1W1u
 Xa0oDFXIq0K07RH8ZTg7x2nZFWFsteV6IBIVxknx/qATZeqePgsLlj6Or0HhWpQ=
X-Google-Smtp-Source: AGHT+IEJfBPphRVIbf3+hLY41G+08KWfKuKv2n9DJX+keY2Gh5gdkJRrCtstpqEOun2CUE1kWXx8mg==
X-Received: by 2002:a5d:4589:0:b0:367:418d:d4d with SMTP id
 ffacd0b85a97d-3679dd71faamr1979169f8f.60.1720116265607; 
 Thu, 04 Jul 2024 11:04:25 -0700 (PDT)
Received: from myrica ([2.221.137.100]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3679224d11dsm5008808f8f.12.2024.07.04.11.04.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 04 Jul 2024 11:04:25 -0700 (PDT)
Date: Thu, 4 Jul 2024 19:04:38 +0100
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: Mostafa Saleh <smostafa@google.com>
Cc: qemu-arm@nongnu.org, eric.auger@redhat.com, peter.maydell@linaro.org,
 qemu-devel@nongnu.org, alex.bennee@linaro.org, maz@kernel.org,
 nicolinc@nvidia.com, julien@xen.org, richard.henderson@linaro.org,
 marcin.juszkiewicz@linaro.org
Subject: Re: [PATCH v4 07/19] hw/arm/smmu: Introduce CACHED_ENTRY_TO_ADDR
Message-ID: <20240704180438.GD1693268@myrica>
References: <20240701110241.2005222-1-smostafa@google.com>
 <20240701110241.2005222-8-smostafa@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240701110241.2005222-8-smostafa@google.com>
Received-SPF: pass client-ip=2a00:1450:4864:20::436;
 envelope-from=jean-philippe@linaro.org; helo=mail-wr1-x436.google.com
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

On Mon, Jul 01, 2024 at 11:02:29AM +0000, Mostafa Saleh wrote:
> Soon, smmuv3_do_translate() will be used to translate the CD and the
> TTBx, instead of re-writting the same logic to convert the returned
> cached entry to an address, add a new macro CACHED_ENTRY_TO_ADDR.
> 
> Signed-off-by: Mostafa Saleh <smostafa@google.com>
> ---
>  hw/arm/smmuv3.c              | 3 +--
>  include/hw/arm/smmu-common.h | 3 +++
>  2 files changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/hw/arm/smmuv3.c b/hw/arm/smmuv3.c
> index cc61708160..229b3c388c 100644
> --- a/hw/arm/smmuv3.c
> +++ b/hw/arm/smmuv3.c
> @@ -950,8 +950,7 @@ epilogue:
>      switch (status) {
>      case SMMU_TRANS_SUCCESS:
>          entry.perm = cached_entry->entry.perm;
> -        entry.translated_addr = cached_entry->entry.translated_addr +
> -                                    (addr & cached_entry->entry.addr_mask);
> +        entry.translated_addr = CACHED_ENTRY_TO_ADDR(cached_entry, addr);
>          entry.addr_mask = cached_entry->entry.addr_mask;
>          trace_smmuv3_translate_success(mr->parent_obj.name, sid, addr,
>                                         entry.translated_addr, entry.perm,
> diff --git a/include/hw/arm/smmu-common.h b/include/hw/arm/smmu-common.h
> index 96eb017e50..09d3b9e734 100644
> --- a/include/hw/arm/smmu-common.h
> +++ b/include/hw/arm/smmu-common.h
> @@ -37,6 +37,9 @@
>  #define VMSA_IDXMSK(isz, strd, lvl)         ((1ULL << \
>                                               VMSA_BIT_LVL(isz, strd, lvl)) - 1)
>  
> +#define CACHED_ENTRY_TO_ADDR(ent, addr)      (ent)->entry.translated_addr + \
> +                                             ((addr) & (ent)->entry.addr_mask);

nit: maybe wrap this in parenthesis to avoid future usage mistakes and
drop the semicolon 

Thanks,
Jean

> +
>  /*
>   * Page table walk error types
>   */
> -- 
> 2.45.2.803.g4e1b14247a-goog
> 

