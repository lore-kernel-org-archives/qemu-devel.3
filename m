Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05CB9C0218A
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jan 2025 16:33:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tcoWC-0004b9-T8; Tue, 28 Jan 2025 11:32:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tcoW3-0004Yz-6e
 for qemu-devel@nongnu.org; Tue, 28 Jan 2025 11:32:43 -0500
Received: from mail-pl1-x629.google.com ([2607:f8b0:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tcoVz-0005id-Jh
 for qemu-devel@nongnu.org; Tue, 28 Jan 2025 11:32:42 -0500
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-21644aca3a0so137220205ad.3
 for <qemu-devel@nongnu.org>; Tue, 28 Jan 2025 08:32:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1738081957; x=1738686757; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=fgdDdXBNLxyVPR81uqwioFsw91kPxcJsdwOz6elBtFY=;
 b=vnXF1yt5XPF2+wglrYYnmDhqy3KUdDo9CQz2sA2/wLEPdt3on6LwoXHdakL0t6nwr9
 q2xjgxZC+pif4o8a8VkdoV7LwcikXxxiPJCCb7Jw8LKh0aY9+bgLDAXmKLZ1AGMpPm2q
 JawalyO8KHo3Jwl/zn44E2ifz/2hqkuioTkKuqYg/r8r0Pu5fRW0gUm0Ag2NiFhxMgrG
 B7Dy+En9WZEtOyH5IeDIwLn8DuR5lYdmoqOgSTvFX49CxlzboX2REs0cKnTJuaNXNUqt
 p8Wkz1OtDP5pkpZh7FuPZyAOxCxdTVXT63Ap580k4XV16Wk8i5UfZRgzILVEed0ljxEz
 jhZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738081957; x=1738686757;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=fgdDdXBNLxyVPR81uqwioFsw91kPxcJsdwOz6elBtFY=;
 b=PY8eMzJCT63r4L3d0yz2uGa1pLzSMnqtshuxriG+uvu+RmDFJWVveUlVB2fyNmcDwC
 89jappN6iulUSBbFBeyR6Db+v50rvE3Mp9ctM5HF43YCykPZpFSFlY8i7Eb5zprjcZe9
 WXYQQnAokB3tq+No5RVEIMojZvoKKwr3VSzN1uHrO5tcij7IL78vGz2agwPHyA6K3umB
 lYGpG5JSmTsMyfEpJY6DzhVGKQetuIRVeUohGGZhIwicrHfbT3lx+sHANaoJI2ikzrQF
 ehfAQ5ttP0uA/NC4F72pDauR0kaJNHIemVHxfDESAP422ltmWO1gRR+2JZxmY32gSUwu
 baUA==
X-Gm-Message-State: AOJu0YykQw/jkfglNbGQ7ecA5TccdFieeCEwARmtExmi6IVCIoPenYp9
 sKWAcbHJ+8xsP0HD2y+eoanVH5d4Gw3wS6bz+eTc03Y/Mta2AEGzPi7dvGV11lX/O1xmvojgAWX
 c
X-Gm-Gg: ASbGncsNJAM3P7eJzWlC9z5p+K/YldlhHxJCPiCbbqKBosTKXrt/i0n6z5I6MAQkqhK
 T4XW26vaaskLbbO+6/MoqtleYsVr6FV35+Ypi20uGXdK48jtC5WUkq59KN5haTbu66E7WPb1eeR
 nbi6N1BoPAboBFP2l+qwDjXgwJRX2lHAJZOuirVIZH4hIQfsfVD3guv5bjDUGmduwOTlgMIqDNR
 dj3Oe/6lJHOGPH9rqFIOaDSMKP8h4K9ZTcPkoJGLkf98rHiuB269hYFfc2xasljjP3mxLoFnUKL
 8A8TC5/xuEfXHEsQzrYdHrDdDdmY1pbTFSvGSBskXKhqoEiqo/O7rw6j8w==
X-Google-Smtp-Source: AGHT+IE3kALVrJfwHJ6nqkk4BFai4LBpkbPYPdJIvSc9lYBDHXXvZ4+/pc/Vz3ubwwK9LSW8ihj5RQ==
X-Received: by 2002:a05:6a20:4303:b0:1e1:b105:87b with SMTP id
 adf61e73a8af0-1eb214f0f6cmr67779177637.23.1738081956732; 
 Tue, 28 Jan 2025 08:32:36 -0800 (PST)
Received: from [192.168.0.4] (174-21-71-127.tukw.qwest.net. [174.21.71.127])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-ac495983698sm8502363a12.55.2025.01.28.08.32.36
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 28 Jan 2025 08:32:36 -0800 (PST)
Message-ID: <a7cded26-c448-46f2-87d3-609c76273f92@linaro.org>
Date: Tue, 28 Jan 2025 08:32:34 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] target/arm: Drop unused AARCh64DecodeTable typedefs
To: qemu-devel@nongnu.org
References: <20250128135046.4108775-1-peter.maydell@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250128135046.4108775-1-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::629;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x629.google.com
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

On 1/28/25 05:50, Peter Maydell wrote:
> We removed the old table-based decoder in favour of decodetree, but
> we left a couple of typedefs that are now unused; delete them.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>   target/arm/tcg/translate-a64.c | 11 -----------
>   1 file changed, 11 deletions(-)

Oops.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

> 
> diff --git a/target/arm/tcg/translate-a64.c b/target/arm/tcg/translate-a64.c
> index bd814849c19..155169aeafd 100644
> --- a/target/arm/tcg/translate-a64.c
> +++ b/target/arm/tcg/translate-a64.c
> @@ -75,17 +75,6 @@ static int scale_by_log2_tag_granule(DisasContext *s, int x)
>   #include "decode-sme-fa64.c.inc"
>   #include "decode-a64.c.inc"
>   
> -/* Table based decoder typedefs - used when the relevant bits for decode
> - * are too awkwardly scattered across the instruction (eg SIMD).
> - */
> -typedef void AArch64DecodeFn(DisasContext *s, uint32_t insn);
> -
> -typedef struct AArch64DecodeTable {
> -    uint32_t pattern;
> -    uint32_t mask;
> -    AArch64DecodeFn *disas_fn;
> -} AArch64DecodeTable;
> -
>   /* initialize TCG globals.  */
>   void a64_translate_init(void)
>   {


