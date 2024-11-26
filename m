Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BFD88D66B85
	for <qemu-devel@archiver.kernel.org>; Tue, 26 Nov 2024 22:36:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tG49u-0001zB-Eo; Tue, 26 Nov 2024 17:35:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tG49s-0001yg-9d
 for qemu-devel@nongnu.org; Tue, 26 Nov 2024 17:35:48 -0500
Received: from mail-oi1-x230.google.com ([2607:f8b0:4864:20::230])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tG49q-0000U6-T6
 for qemu-devel@nongnu.org; Tue, 26 Nov 2024 17:35:48 -0500
Received: by mail-oi1-x230.google.com with SMTP id
 5614622812f47-3ea3bf79a03so1321854b6e.2
 for <qemu-devel@nongnu.org>; Tue, 26 Nov 2024 14:35:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1732660545; x=1733265345; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Iy1hBp4wrWgB//U1K6KDs/GKwh86S2uxy20rRQToiI8=;
 b=bseGtHfH6lEVYv5TCg90eKYeL256eHNpZ5BcTM4o1nk1CtVm/irpNUl8Zi4YX2xEGG
 R/wiNvwMqxm7WkFXFWcHHqAQ9eSObXTGoCceuI0yE/pryel3ltZlp91EO86LR9dwHH3d
 qYDBNSO3ZCBkXYC2xHpfxCFzw4kSOftYiq44zeklgzlwOkdzGkFbjAsY1yX1b274gx2v
 yJ+kKyGUdf7opKOCyKxoARSqSp+Pi7c81OAiMgo80u4fjQ1Kae3p5UAYLJaaWopUp8S6
 zV9uZxAIARd6u5dQDwoxWS5F7QZf50MiV/Aqu8dLryut4vxeXf1SKM0KOEm/d/QhbIpM
 4uDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732660545; x=1733265345;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Iy1hBp4wrWgB//U1K6KDs/GKwh86S2uxy20rRQToiI8=;
 b=H8bPhzHelh15Y1GfYOe4Bpa62CW/D7n32z98TbhGGnplbLbgAZkMR52igf53vYV7bI
 1iBctJPtf/4GD+SYxJjPK74VvHLuxyoFm30Hyt6RjXZ9pCHcLIsy6Tn5NqUV2Ncvs96z
 CRkfkyFgveJ1Ls2pVrdTvtXgw+ibUVENzeINHRkoWmRCDcoYZiQIzO490Jmi+ejjFVS0
 qMtIz/r2XBFYGpaiea5fVEmMonxq7c3cW8LGGypvHi7yWJree0+eDnSwY7rss/fGjcxx
 UBS/LUjr8kVjpqW7naXQnCmzs+ltZ4Zt8U/VaWDZuBpxBdJnDneD3Uf7vo0v9gLh4W4Z
 rcdw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUgDr4Hk0lgPf7b20oD/IoQmIeru/gPTHMT5v5oqS9K+Mcbcq/xUiF+Lc4/8ahtzoerPMuOmckMsxOL@nongnu.org
X-Gm-Message-State: AOJu0YyQpUMBgPW5m5lwbH9MfoqQz8l4eqUzcRzs2z2RO8ivqnb2X0lY
 5320/zzrohYKx5S2gAQ0ZG6nkk8Ly5kH+h0HxR883+Luw2Nv1YqcLB0SGM9yrQU=
X-Gm-Gg: ASbGncu2V28Jo+uyjU+nOhiJVKCrnK6LfcR5bTO/J/gjlSKWMQ4Uoj9qY2n5m+ZTR61
 8tcUYdBd9G9T20SlWjawpbggqrBlQq9MbtVClWsnbz3HQl/SwPsCq6dy2FQLSPzU3thPxEjSgL8
 4LXhNI4nJTY1ITaDcTeqVF0Ovus5jMhwwtCJf0XRdyo7atSzvVGYqsRuHblqOS9Xs4DkInChU80
 RC51bNvPV5nnVlHPT5x23k/ZYBsCvDKegeMqRcaVHZ8bIUG7QIILSKfaajJ3mTwEHSXGap5NA10
 juNXr+xz212riuhGiBUg6Tz9JwL2
X-Google-Smtp-Source: AGHT+IHsJgX4KpPgzjjdFbLPodXax9zqtYTIm4OboUh52uBCV4DH9XhD8Cg58NhYv0cgt8SVJEDIKA==
X-Received: by 2002:a05:6808:1829:b0:3ea:50a8:4559 with SMTP id
 5614622812f47-3ea6dbb1d5cmr1369676b6e.11.1732660545309; 
 Tue, 26 Nov 2024 14:35:45 -0800 (PST)
Received: from [192.168.4.112] (fixed-187-189-51-143.totalplay.net.
 [187.189.51.143]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-3e91500f931sm3200674b6e.51.2024.11.26.14.35.44
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 26 Nov 2024 14:35:44 -0800 (PST)
Message-ID: <9a4840cd-0076-43e1-b523-3c073aa3d699@linaro.org>
Date: Tue, 26 Nov 2024 16:35:42 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 16/16] target/mips: Convert nanoMIPS LI opcodes to
 decodetree
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Aurelien Jarno <aurelien@aurel32.net>,
 Aleksandar Rikalo <arikalo@gmail.com>, Jiaxun Yang <jiaxun.yang@flygoat.com>
References: <20241126140003.74871-1-philmd@linaro.org>
 <20241126140003.74871-17-philmd@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20241126140003.74871-17-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::230;
 envelope-from=richard.henderson@linaro.org; helo=mail-oi1-x230.google.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On 11/26/24 08:00, Philippe Mathieu-Daudé wrote:
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   target/mips/tcg/nanomips16.decode        |  8 ++++++++
>   target/mips/tcg/nanomips48.decode        |  8 ++++++++
>   target/mips/tcg/nanomips_translate.c     | 21 +++++++++++++++++++++
>   target/mips/tcg/nanomips_translate.c.inc | 17 -----------------
>   4 files changed, 37 insertions(+), 17 deletions(-)
> 
> diff --git a/target/mips/tcg/nanomips16.decode b/target/mips/tcg/nanomips16.decode
> index 81fdc68e98b..12815161d9c 100644
> --- a/target/mips/tcg/nanomips16.decode
> +++ b/target/mips/tcg/nanomips16.decode
> @@ -6,3 +6,11 @@
>   #
>   # Reference: nanoMIPS32 Instruction Set Technical Reference Manual
>   #            (Document Number: MD01247)
> +
> +&rd_imm             rd imm not_in_nms
> +
> +%s_eu               0:s7 !function=s_eu
> +
> +@rt3_s          ...... rd:3 .......         &rd_imm         imm=%s_eu
> +
> +LI              110100 ... .......          @rt3_s          not_in_nms=0        # LI[16]

I think probably it is a mistake to include not_in_nms in the argument set.
I think it would be better to have separate trans_LI and trans_LI_nnms.


> diff --git a/target/mips/tcg/nanomips48.decode b/target/mips/tcg/nanomips48.decode
> index 696cc15607a..778bff4ec06 100644
> --- a/target/mips/tcg/nanomips48.decode
> +++ b/target/mips/tcg/nanomips48.decode
> @@ -6,3 +6,11 @@
>   #
>   # Reference: nanoMIPS32 Instruction Set Technical Reference Manual
>   #            (Document Number: MD01247)
> +
> +&rd_imm     rd  imm not_in_nms                                       !extern
> +
> +%imm        16:16 0:s16

These subfields are swapped.

That said...  I will note that all 48-bit instructions are 16-bit plus a 32-bit immediate. 
There's a trick we used over in target/rx/ where we (ab)use !function to read immediate 
data. Using this would mean that we can treat all of these 48-bit insns as 16-bit insns.

%i48       !func=i48
@ri48      ...... rt:5  .....  &ri imm=%i48

LI_nnmi    011000 ..... 00000  @ri48


r~

