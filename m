Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB888C87FCB
	for <qemu-devel@archiver.kernel.org>; Sun,  3 Aug 2025 11:00:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uiWRg-0002v1-1F; Sun, 03 Aug 2025 07:00:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uiWRb-0002rZ-Lt
 for qemu-devel@nongnu.org; Sun, 03 Aug 2025 07:00:01 -0400
Received: from mail-yw1-x112c.google.com ([2607:f8b0:4864:20::112c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uiWRa-0007Rd-0s
 for qemu-devel@nongnu.org; Sun, 03 Aug 2025 06:59:59 -0400
Received: by mail-yw1-x112c.google.com with SMTP id
 00721157ae682-71b4677044bso37453567b3.2
 for <qemu-devel@nongnu.org>; Sun, 03 Aug 2025 03:59:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1754218797; x=1754823597; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=7sbeLRr4p47gOR8XPhLMvqlI63yuM7O8kWxCclDbtdE=;
 b=yOz9pz94oNVmEMP9nHNupu3W0dKK9bNrdPZ/kxryWDM5SLBZbwqbMvU8EhSvcsr0WI
 3RxULZ/JbDoGMzkeirfvmhXdFENpb0R/drRoYodlBP0+O0Md9NH42SWLQ/HnkSF6ApRr
 Xo5xSNLlHvtTSVVBCZO8VXV1PBNOo4L9NS3dp71WnQVSFCtS/6qLPNaMj2jkJhrbaha/
 gGsg9vCxJuloZDNk8olifBaEgIwbNVuvoIE1WpUFri+DyK0wsabo3pkaGaUnvobzQgle
 aoOaM91TvaRqvyb9mwPspJr7QlWKsmQTY+mZzEKWuCiBEOifN+ydEWySU3jWY8SCzz1b
 Bz2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754218797; x=1754823597;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=7sbeLRr4p47gOR8XPhLMvqlI63yuM7O8kWxCclDbtdE=;
 b=K3za8TIQLJbzY4qO8YcO0Vitn8IautV8W9FHsAdSyDuXExsL7SYd8rcpRF5eslbhOL
 bYBPFF87yScE6CbIrcmX0IQazW9e5lix4Za7W1xbIQ+WgKQ3NFAXunB2Ubb5tT7H+IYs
 WpSQOCEQIud1SVAzJnlxW/6X6NW5oHhCcveGlIvMcbtQ3FD1VXmD531AZgWgZuX5MEP7
 YtyRf34oIZY2hxOUbX2XBLHFbQh/abmHhCqcXDcJnzstJ0cWPaHSqpbHqP1vosIIGwSe
 jJAskvkYt9IHsd7pLCs23mrZDAyh+kR+B1XCJP12Y4S7WJ6Wvl+lPdQvOI3Cb2Yhliy2
 3ShQ==
X-Gm-Message-State: AOJu0YzeOCrQuAlnHfbiQHp7d2+/MGPRxzQmMh4QGQIfGwJ9XZ6UtrQy
 vs0DBlHRMi7+pHuwJwksTKqF1hMs3A4U3dhNAuis11fvjr6vk6KqDauBYHwSLgStEjm9b0OMOkY
 cxkB+siFgTeGkf/2kZwF8TBak2Br6PmaSG6BoGs+F84aNMFcgVZ8l
X-Gm-Gg: ASbGnctGjeYDJOrBwEbE65n+jxwh085yQPFJ4Qc6di78kpzGlemRAJua2lLE1CiIYbY
 x3O6t7MWjV7AfIYqpBf958H9+Pi6yvHSUqoKbMbaCh+cer8UDKU3OZeSO3cETDyUN4xKcEeFeh1
 I77+qkJZYbAVj+FRttrPZL1/G+fjYCtsCN26d2+NySCYHaH+ZXVdoRuztcoQtXh0Vy3SIcnKSfV
 h3LG2Kk
X-Google-Smtp-Source: AGHT+IFU64UHcARPOBCR8D3QNdJ8LQ0E31quVUsum0iPnogyVdgZc/vQeLXKObNLtbW4/lu7fKAFDA1YwaAPD233nIs=
X-Received: by 2002:a05:690c:9d:b0:71b:4739:9d54 with SMTP id
 00721157ae682-71b7ed16c9emr88232427b3.2.1754218796727; Sun, 03 Aug 2025
 03:59:56 -0700 (PDT)
MIME-Version: 1.0
References: <20250802230459.412251-1-richard.henderson@linaro.org>
 <20250802230459.412251-46-richard.henderson@linaro.org>
In-Reply-To: <20250802230459.412251-46-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Sun, 3 Aug 2025 11:59:45 +0100
X-Gm-Features: Ac12FXwnBdrpAHj-FdmV5rI0U9dJJzHOlM7_HL_XokqoM1YC3938hB1O1yWLk5Q
Message-ID: <CAFEAcA8RJ2NKRBL6USCL12kPY_D5C1os0-t57t6aGZHSxkOE2A@mail.gmail.com>
Subject: Re: [PATCH v2 45/95] linux-user: Remove target_elf_greg_t
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::112c;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x112c.google.com
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

On Sun, 3 Aug 2025 at 00:20, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> This typedef is synonymous with target_ulong.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  linux-user/elfload.c | 29 +++++++++++++----------------
>  1 file changed, 13 insertions(+), 16 deletions(-)
>
> diff --git a/linux-user/elfload.c b/linux-user/elfload.c
> index fce4c05674..70a1e402d3 100644
> --- a/linux-user/elfload.c
> +++ b/linux-user/elfload.c
> @@ -131,10 +131,8 @@ int info_is_fdpic(struct image_info *info)
>  #endif
>
>  #ifdef TARGET_ABI_MIPSN32
> -typedef abi_ullong      target_elf_greg_t;
>  #define tswapreg(ptr)   tswap64(ptr)
>  #else
> -typedef abi_ulong       target_elf_greg_t;
>  #define tswapreg(ptr)   tswapal(ptr)
>  #endif

Previously we had target_elf_greg_t:
 * for MIPSN32: abi_ullong, which is 64 bits
 * for other TARGET_ABI32: abi_ulong, which is 32 bits
 * for 64-bit archs: abi_ulong, which is 64 bits
 * for 32-bit archs: abi_ulong, which is 32 bits

Now we have target_ulong, which is:
 * for 64-bit archs: 64 bits
 * for 32-bit archs: 32 bits

So the two TARGET_ABI32 which weren't special cased
(hppa and sparc32plus) will go from a 32-bit type to a 64-bit
type, won't they ?

It wouldn't surprise me if this is a bug in the hppa and
sparc32plus cases, but if so we should say in the commit
message that we're fixing it.

thanks
-- PMM

