Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27FC7CAC592
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Sep 2025 13:33:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uy9JC-0004CO-8l; Mon, 15 Sep 2025 09:31:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uy9J9-0004CC-2s
 for qemu-devel@nongnu.org; Mon, 15 Sep 2025 09:31:51 -0400
Received: from mail-pf1-x42e.google.com ([2607:f8b0:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uy9It-0008WR-1J
 for qemu-devel@nongnu.org; Mon, 15 Sep 2025 09:31:50 -0400
Received: by mail-pf1-x42e.google.com with SMTP id
 d2e1a72fcca58-7761bca481dso1900652b3a.1
 for <qemu-devel@nongnu.org>; Mon, 15 Sep 2025 06:31:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1757943091; x=1758547891; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=MpV1cqMdhdgrpZTvQYyPm3LCDwNi9e4xMhPmt4vjYrA=;
 b=XZlFADounYwjhrroLUoOXyFp6PLgYyqm3WzcczBmxz+iauNJzruwH08+fbwI9Ne0zd
 +z04RV4NJG0MHQwC6poffcRtLw7SH+z7vfB4Rng68Wl+8XRCLFg5TMb9oA+a8zgreSRP
 /2kRiEF5ISsQelQu+gZ/2kN1ovAoz4HHcum6OfKwWN/8egY6cUCiUbpppfVdaHDKa//b
 x+/2gOzFJYLySILjSA0shvqyYU5HGzId1gvS19YJgc3Xc6OywcT9CQwx/91S/nP8TEU7
 Piylwis43uIv/WxMaN/rdBO0LH56N1ROcigQM7nwKSiFnPdI62Hme75poE+1bSmcifTy
 Y7qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1757943091; x=1758547891;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=MpV1cqMdhdgrpZTvQYyPm3LCDwNi9e4xMhPmt4vjYrA=;
 b=F0PDZTJJfzwlzYtLdr0xN+ZorKQYk/A6MVp2P147aXB2EC5i6eMn4w9+1RLtFY2ldM
 CtIcMMm256pm+FjYmyFqVAXOg7ddbjI6L4prXVF4tYxIO507qo5fn0RLsSkLtWWIuraW
 KyrTJwKDoE308RGjgUkgpEpGTgnlm3cbb6eCaNqlwTUludPBtQEVtFIyQUyLl5UZc5Ja
 ycOqLV1FAFl0Ysgcba6IOqKYKOSJn7WEquTQv/U+tUMeniG6G04SnM/KcJgmNScPQif/
 tNIM2Cv799d3v8RkgWsfC49lxARsKXwCckat9BgFTWym6rBl2w2/TEOatbcEi8MGSw8i
 9+GQ==
X-Gm-Message-State: AOJu0YzZSSXpwfKHT2UpIj9su9qQnNvgCViq4x1g9U/5Ott7ieDPfX3R
 0LgT1sfwx+P7IjRUAQnF8WSsyuhrGhoNWJH+9sEyj/dug8K3sSEjkILMudoQxKWZIfl3GjjbgoO
 UoRVm
X-Gm-Gg: ASbGncvoZQ825BIeIHTma4QZWs1au0izqqLABTv8n1H1gRFQUvE/Ab0Mp5R4sp9Gk/N
 JNZSniKqM2aiBno+2uJybBA7fGfLoXt5ri/vKA6oAcMdUO5CcG2aVsh0mh44GYPDEjLASqkohSo
 nrjDCgnah4CgY52916RYW9oMpsFbZr/reKbqRrbUUVyLGaRZyh+IMVTpEswqnEGwAtvW12jXAFn
 9/eq7PGWI86nquB3h+jUySwcJY1wvK85901NzdkgX70DsseM+HGRN79H1MrNuElTttKmwEZRS2T
 q98lagxGPFjnb2nIz/9R4NXcYLZ1WoZbLeZwxr9a7OHqQKhfj1O9pdDXtvx12fx9sHPmlMjg7H0
 yxjSpmpCOes8D3iI21NsaOE3U/a90CiRosY5mHqGHi/Acqw4=
X-Google-Smtp-Source: AGHT+IGAZMVAudXnPlH/A4X749JJ5UYYSxiRu7OdO1MtPk4Ys1AAXVDhjcgMrLDwWGnF6cHxqpDvmA==
X-Received: by 2002:a05:6a00:2e16:b0:772:4b05:7899 with SMTP id
 d2e1a72fcca58-77612077891mr13081037b3a.7.1757943091220; 
 Mon, 15 Sep 2025 06:31:31 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.157.132])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-77622c1f52bsm7291223b3a.19.2025.09.15.06.31.30
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 15 Sep 2025 06:31:30 -0700 (PDT)
Message-ID: <bc6e3f0a-356f-461f-bc84-9954f0390e49@linaro.org>
Date: Mon, 15 Sep 2025 06:31:29 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] target/mips: Fix msaregnames and mxuregnames off-by-one
To: qemu-devel@nongnu.org
References: <20250912142927.20919-1-anjo@rev.ng>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20250912142927.20919-1-anjo@rev.ng>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42e;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, T_SPF_HELO_TEMPERROR=0.01,
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

On 9/12/25 07:29, Anton Johansson via wrote:
> The msaregnames and mxuregnames arrays contains strings of 7 bytes
> ("w10.d0", ...) and 5 bytes ("XR10", ...) in length including the
> NULL byte.
> 
> Signed-off-by: Anton Johansson <anjo@rev.ng>
> ---
>   target/mips/tcg/msa_translate.c | 2 +-
>   target/mips/tcg/mxu_translate.c | 2 +-
>   2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/target/mips/tcg/msa_translate.c b/target/mips/tcg/msa_translate.c
> index 82b149922f..0e947125a0 100644
> --- a/target/mips/tcg/msa_translate.c
> +++ b/target/mips/tcg/msa_translate.c
> @@ -32,7 +32,7 @@ static inline int plus_2(DisasContext *s, int x)
>   /* Include the auto-generated decoder.  */
>   #include "decode-msa.c.inc"
>   
> -static const char msaregnames[][6] = {
> +static const char msaregnames[][7] = {
>       "w0.d0",  "w0.d1",  "w1.d0",  "w1.d1",
>       "w2.d0",  "w2.d1",  "w3.d0",  "w3.d1",
>       "w4.d0",  "w4.d1",  "w5.d0",  "w5.d1",
> diff --git a/target/mips/tcg/mxu_translate.c b/target/mips/tcg/mxu_translate.c
> index 35ebb0397d..7e8cc8b06f 100644
> --- a/target/mips/tcg/mxu_translate.c
> +++ b/target/mips/tcg/mxu_translate.c
> @@ -609,7 +609,7 @@ enum {
>   static TCGv mxu_gpr[NUMBER_OF_MXU_REGISTERS - 1];
>   static TCGv mxu_CR;
>   
> -static const char mxuregnames[NUMBER_OF_MXU_REGISTERS][4] = {
> +static const char mxuregnames[NUMBER_OF_MXU_REGISTERS][5] = {
>       "XR1",  "XR2",  "XR3",  "XR4",  "XR5",  "XR6",  "XR7",  "XR8",
>       "XR9",  "XR10", "XR11", "XR12", "XR13", "XR14", "XR15", "XCR",
>   };

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

