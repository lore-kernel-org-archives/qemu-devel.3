Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28118CA0ED1
	for <qemu-devel@archiver.kernel.org>; Fri, 15 Aug 2025 14:31:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1umvSX-0004ef-Fj; Fri, 15 Aug 2025 10:31:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1umvSV-0004eH-6P
 for qemu-devel@nongnu.org; Fri, 15 Aug 2025 10:31:07 -0400
Received: from mail-pf1-x436.google.com ([2607:f8b0:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1umvSQ-0006GR-Ns
 for qemu-devel@nongnu.org; Fri, 15 Aug 2025 10:31:06 -0400
Received: by mail-pf1-x436.google.com with SMTP id
 d2e1a72fcca58-76e2ea79219so2371243b3a.2
 for <qemu-devel@nongnu.org>; Fri, 15 Aug 2025 07:31:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1755268260; x=1755873060; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=ytyFB3qOEeepUxC0KNFTXH9ZO+iQ+SMdQFfeEdw5h0s=;
 b=dTeZGd9yldagG5ktJu5E3PB5bPstcZ1dRhILFlhFP4X1gmve7mMevbMXX76maAFHFu
 GdHedUIKuM8Flgtg9b1w/lk2zkeRGcNRhRBOm0vTx2fd4+TkBmAJF2j9JzlhupcRMYst
 ofjPwJnfrssPfMp1HkV/dMyOsinvdAHnscjrGziaJyREqrB04djqytVSnOPcgP9hC9Ds
 KMhNJtjWfs8JHucjUfua9qnkbsqgm18FxCxsz+4ZeaoldMzXgKIhLumuTP3KZ3972TPI
 mFaT13n/htoccIFvu6ZKtwi/SITe1JdkSPlezngQTNEgEtentXGfsVNHa6kuvlNKY2UO
 26DA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755268260; x=1755873060;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ytyFB3qOEeepUxC0KNFTXH9ZO+iQ+SMdQFfeEdw5h0s=;
 b=F5yc/isCTZKJYat3Jqj9K6xpLuRGI7PyP+dzSx0JvzvpOyCXA1GwY2/ODQCOp6/8+Q
 o/Xjf5qXzGF3V66wcgPuV/AgTxCKkmv5bTV9Zzdixgmwiiq1orngMtoxKHwiyIGZ2XGn
 8PEkFmnaRIHaMUTqLyPNQvxvT1cR9b707xwl1kdoWiEQ19g/wrroYldaS5x2h7pYE2Aq
 oD+5K1HsybkkGU1LykhJ/qOruKpqou1QmU6ceeaItp/K/ceae7MXHZXDIa0X22v6HFeN
 dFWkkJaZt8m9d9hOLsLqTv6QbrmUnNv/Gda6q5nt8C0rUB9KCaFavMar9afV3kh4/vWS
 7DqQ==
X-Gm-Message-State: AOJu0Yx85vd4Od6PqmwN7PFsuht0Sq8Md0kHEPrWVU69AkBKOzQWgTAz
 9cO/rwy3b+f+qDwyAfqxx8bJivFmieO5U+DrYKhOstZJ1MSC9+PMpTr2XQXRGX8YWMuOZMuZRMm
 oUuuo8s4=
X-Gm-Gg: ASbGncu9c4DS0PwlBz7I2ENalH3BbU2YaAtj2DxHbBGzOgdcb/I9GGFHjQWSmKa4JvL
 VXyVXsOE1ef0U6STDrbKLs/ypJBX3LJY2NT+v12/7+F+Kkb4bEzZtm9/SW9Ity7rcrq0qG7FCNW
 QokG6Fr21fTD92yM4YFcfnnQDA5GwBpaXZHWVNjVpMVuyz0Kkup5AGuj51b8uiChfvm5XagDmAh
 BwZgKhrzbtYqjtzjij+KZgVL6DvfUQdlGIhyRiSZS1u1KZYHygs5+PWDFlnZtJPLk+VMOFb7zBK
 gyBWZmgnmKO2YhMxv9qm74xQIXri8fSEiicxNnpjPVOF9qQR5y78jD9FKVODC3FLCWecH0AbQwt
 deIT64LGVw+ppund6TmFDLs6aGjwNY+Ic6xU8D6o=
X-Google-Smtp-Source: AGHT+IGwZAbjyIT2gZpWytJkPVFL0zILITflswoZDJM/jL7HlXaQJ9ceMCeR0XBGTFKLsqC6EqHAuA==
X-Received: by 2002:a05:6a21:999a:b0:21c:fbf0:21bb with SMTP id
 adf61e73a8af0-240d2e68decmr4014646637.24.1755268259634; 
 Fri, 15 Aug 2025 07:30:59 -0700 (PDT)
Received: from [192.168.4.112] ([206.83.105.236])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-76e4526a1fasm1257160b3a.13.2025.08.15.07.30.57
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 15 Aug 2025 07:30:59 -0700 (PDT)
Message-ID: <04500975-6a94-4bf9-b362-a0f310060dbc@linaro.org>
Date: Sat, 16 Aug 2025 00:30:54 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC 2/3] target/ppc: Add IBM PPE42 special instructions
To: qemu-devel@nongnu.org
References: <20250814223741.29433-1-milesg@linux.ibm.com>
 <20250814223741.29433-3-milesg@linux.ibm.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20250814223741.29433-3-milesg@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::436;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x436.google.com
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

On 8/15/25 08:37, Glenn Miles wrote:
> Adds the following instructions exclusively for
> IBM PPE42 processors:
> 
>    LSKU
>    LCXU
>    STSKU
>    STCXU
>    LVD
>    LVDU
>    LVDX
>    STVD
>    STVDU
>    STVDX
>    SLVD
>    SRVD
>    CMPWBC
>    CMPLWBC
>    CMPWIBC
>    BNBWI
>    BNBW
>    CLRBWIBC
>    CLRWBC
>    DCBQ
>    RLDICL
>    RLDICR
>    RLDIMI
> 
> A PPE42 GCC compiler is available here:
> https://github.com/open-power/ppe42-gcc
> 
> For more information on the PPE42 processors please visit:
> https://wiki.raptorcs.com/w/images/a/a3/PPE_42X_Core_Users_Manual.pdf
> 
> Signed-off-by: Glenn Miles <milesg@linux.ibm.com>
> ---
>   target/ppc/helper_regs.c            |  15 +-
>   target/ppc/insn32.decode            |  66 ++-
>   target/ppc/translate.c              |  29 +-
>   target/ppc/translate/ppe-impl.c.inc | 805 ++++++++++++++++++++++++++++
>   4 files changed, 898 insertions(+), 17 deletions(-)
>   create mode 100644 target/ppc/translate/ppe-impl.c.inc

Oof.  This is really too much at once -- the patch ought to be split.

> diff --git a/target/ppc/insn32.decode b/target/ppc/insn32.decode
> index e53fd2840d..8beb588a2a 100644
> --- a/target/ppc/insn32.decode
> +++ b/target/ppc/insn32.decode
> @@ -58,6 +58,10 @@
>   %ds_rtp         22:4   !function=times_2
>   @DS_rtp         ...... ....0 ra:5 .............. ..             &D rt=%ds_rtp si=%ds_si
>   
> +%dd_si          3:s13

Note that the format describes this as shifted left by 3.  I see you multiply by 8 in 
trans_LSKU, but it's generally easier to have the immediates match the format description.

> +&DD             rt ra si:int64_t

Why are you forcing si to int64_t?  It's a 16-bit signed immediate.

> +static bool trans_LCXU(DisasContext *ctx, arg_LCXU *a)
> +{
> +#if defined(TARGET_PPC64)
> +    return false;
> +#else
> +    int i;
> +    TCGv base, EA;
> +    TCGv lo, hi;
> +    TCGv_i64 t8;
> +    const uint8_t vd_list[] = {9, 7, 5, 3, 0};

We're trying to move away from having separate binaries for different cpu models.  While 
target/ppc/ needs quite a bit of work for that to be a reality, let's try to avoid adding 
more code that needs cleaning up.

> +
> +    if (unlikely(!is_ppe(ctx))) {
> +        return false;
> +    }

This test should be sufficient to disable the insn for ppc64, without the ifdef.


r~

