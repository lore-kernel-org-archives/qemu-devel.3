Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 900E7CCA470
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Oct 2025 16:03:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v3zFX-0003JF-KA; Wed, 01 Oct 2025 12:00:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v3zFK-0003Bf-Iu
 for qemu-devel@nongnu.org; Wed, 01 Oct 2025 12:00:05 -0400
Received: from mail-qv1-xf36.google.com ([2607:f8b0:4864:20::f36])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v3zFD-00025L-6W
 for qemu-devel@nongnu.org; Wed, 01 Oct 2025 12:00:02 -0400
Received: by mail-qv1-xf36.google.com with SMTP id
 6a1803df08f44-79599d65f75so538986d6.2
 for <qemu-devel@nongnu.org>; Wed, 01 Oct 2025 08:59:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1759334381; x=1759939181; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=3H7aos6A708jGSZuLPLSE070Fktbew8/eoA80ARhIUI=;
 b=dXQupdZGceNYc3e4Ra70GM0s4lawhMkc/y1YxLRoRBGIIL+Tvq8SKCaVaJlLMJxRm1
 Zc0rAWV5ovJumhBl4tKUgSaQopN6LvienYIWSL3oYTQ01cLfoiYxD953pvu7aHqBKwDL
 TIk0yPmahHCAj9QLTCwPCkJ6PnDGmtOKyp3vh4HXU6OfuATOS568tAdrTohQ2E7YYyJs
 FTdHKsnzBVhC3dsic9S3vWevIPaFoqpbFb0MRKK38F2/nl4+tA1ynT14FjyndytTZqal
 RC6D2E75Roysos57Rlye9X/8lqC8knpy/CFZwjrxuiIaytwpa7g1CDImwtSKvLkcze/P
 FeCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759334381; x=1759939181;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=3H7aos6A708jGSZuLPLSE070Fktbew8/eoA80ARhIUI=;
 b=ujYqavgFo1A8BrbYcbmsTYxWU24tlZSkdBLIkHsoDpuCbGurkbG22sn44FLl9/Ihix
 oksnSEnZe7AlhtRC6q0nMQxp7XAzkh1Q6j7dDQAhTaIGd/Q/E4X5Dowlwx5C5NzLSx8R
 5t7PUC7zJ0Lfz3LJUWiSAR+JI65CLbcuoPov4BTmCtk3jrFCeNfmNS17nHNh/mU7p4mG
 JesWMmFP+n+uYKbCAbgs/Pn8f+75XGKJl6hLuCvUavjSUR4OmmoroND43TOjcM7eTT90
 +PTa+jSzQhP+/mHQ3v8bRTD4NgpzwRreLxrOtMv2bSlg+x3FFYiW0nCzxQLBbafUQtI5
 pGgg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVMTUVkG4i7Kcu1LhzCawIJd+BjgvBItZ7wibTW46zwBbDGfxP5hVnwrLGjKtSY8IY0dGHUutMn0l8a@nongnu.org
X-Gm-Message-State: AOJu0YxxbQcIpKB1hnNypsb1EB/cLNSd66OhVUlFgiFhusXkist5zP4Q
 xs+tl5BEcba6/pLnaaFBz941yQ5vFKffkMLt6lo7WnrlFz8LoJK84MKKL+CkOFxYipg=
X-Gm-Gg: ASbGncsKnZrGqpBOoD7k+eEjZ6AF0y8+tnmO+Oq3EuKqAwbNCD4ISYicuaXdOGFE1l5
 ivYqgebyteNqJKQn+vqzGB/GLjSsIJ8XSQLzn/vrBuvW1UkUOuVntDrjqTXWBTS2gyNEic8Sc1+
 YQKebUOFch0pyCtSMWq7eLrQTgogNmteo1h2eIbRzp9oQ+Y3zADgRRhVUDCBcVad+NM/rt0dZqq
 fqUJPGoVJxUUOjoqHNG48Vls46J4L1+mYXSH2cVljbS+8jpaGCgq+5HwrGsdCVjnJBpMCriSxQE
 qUwPEcrn5df3HQHMrJzr+7+kXY7jSHbc+xCm7/0i5xntPo+jjHLcZ981E4awVaVIVdpN/qfJ0Eo
 7qz1ywwgTHdaj7v/RG1BahycNBKkbLyjSkW168UFhEwxlBVvOEqclp6DX7Oi6RWMbb9x66ENRbe
 ElX0EL//TS6Wb6/8yZaQawo77lJZs76OY=
X-Google-Smtp-Source: AGHT+IGVdskAfeNNXFR4PU+7tslHlDwSJrWZk61Zlg8p6+z91XBdxRpfUC8DJn1TrfJqCud5iIEExA==
X-Received: by 2002:ad4:5baf:0:b0:787:982:2953 with SMTP id
 6a1803df08f44-8739f3c7da3mr58386356d6.29.1759334381302; 
 Wed, 01 Oct 2025 08:59:41 -0700 (PDT)
Received: from ?IPV6:2607:fb91:1ec5:27b9:1bec:2e21:cc45:2345?
 ([2607:fb91:1ec5:27b9:1bec:2e21:cc45:2345])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-878bb4465cesm424136d6.17.2025.10.01.08.59.39
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 01 Oct 2025 08:59:40 -0700 (PDT)
Message-ID: <2184ba65-b67f-47fd-8234-883f5d8b57fd@linaro.org>
Date: Wed, 1 Oct 2025 08:59:37 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/6] system/ramblock: Use ram_addr_t in
 ram_block_discard_guest_memfd_range
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Fabiano Rosas <farosas@suse.de>,
 "Maciej S. Szmigiero" <maciej.szmigiero@oracle.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 David Hildenbrand <david@redhat.com>, kvm@vger.kernel.org,
 Peter Xu <peterx@redhat.com>
References: <20250929154529.72504-1-philmd@linaro.org>
 <20250929154529.72504-5-philmd@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20250929154529.72504-5-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::f36;
 envelope-from=richard.henderson@linaro.org; helo=mail-qv1-xf36.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

On 9/29/25 08:45, Philippe Mathieu-Daudé wrote:
> Rename @start as @offset. Since it express an offset within a
> RAMBlock, use the ram_addr_t type to make emphasis on the QEMU
> intermediate address space represented.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   include/system/ramblock.h |  3 ++-
>   system/physmem.c          | 12 ++++++------
>   2 files changed, 8 insertions(+), 7 deletions(-)
> 
> diff --git a/include/system/ramblock.h b/include/system/ramblock.h
> index e69af20b810..897c5333eaf 100644
> --- a/include/system/ramblock.h
> +++ b/include/system/ramblock.h
> @@ -104,7 +104,8 @@ struct RamBlockAttributes {
>   };
>   
>   int ram_block_discard_range(RAMBlock *rb, uint64_t start, size_t length);
> -int ram_block_discard_guest_memfd_range(RAMBlock *rb, uint64_t start,
> +/* @offset: the offset within the RAMBlock */
> +int ram_block_discard_guest_memfd_range(RAMBlock *rb, ram_addr_t offset,
>                                           size_t length);

This isn't a ram_addr_t, it's an offset.
You can't pass the value to one of the lookup functions, for instance.
Though I suppose 80% of the ram_addr.h interface uses ram_addr_t for lots of things that 
aren't.


r~

