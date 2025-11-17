Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7C93CEACEF
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Nov 2025 09:49:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vKvqx-0007U9-0L; Mon, 17 Nov 2025 04:48:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vKvqI-0007OG-7P
 for qemu-devel@nongnu.org; Mon, 17 Nov 2025 04:48:15 -0500
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vKvqD-0007iS-Ng
 for qemu-devel@nongnu.org; Mon, 17 Nov 2025 04:48:12 -0500
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-47795f6f5c0so14282405e9.1
 for <qemu-devel@nongnu.org>; Mon, 17 Nov 2025 01:48:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1763372888; x=1763977688; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=aPVtvtBl7qxf1XdYwvBtZS0KTD0bptlLLXJymJlEgPE=;
 b=rwgCFGXiz74FbOQRpbVVRNDBZicx5N7X8YK65SdiTFOplmL7srKqXfCceJHXKu2TpR
 hzpg1KdKZ+Up/e80m0g3nRr2TAbU+iDrqxvZMz3pqsuFzRTs/abcyi0oQElhbLR627Fg
 PY75PsM2jKLm78e32J2D2uKABDh+C1dnh5YbGJBHNLZkQikEBKpH9ieGfmECdUXfessd
 4Wmy4/66awZvlErd70sJfTsTcd1A4fMpzc8UviSxYEVKdLmMRsdR/LXxpToYuhcRYvw7
 3nnHddQWDstn88FtB4G8W5GyH6KA7348fRR0nTv0tb3qpszkIw11CAtCny9hfpCJt7kM
 niOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763372888; x=1763977688;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=aPVtvtBl7qxf1XdYwvBtZS0KTD0bptlLLXJymJlEgPE=;
 b=Bqg/1hOk4lP0JLQ3UlLBfC3D2e9ykZfODFCg2BIAZfWSmWj5oCud0kV0Hf0TgVta3V
 Vv8jMf7Cl5sS0gIhJlMYmyT1n02gRxSi6GZEtiXwmhBDwpCHWw+qNlLeoxxEeJmvGki2
 ijFD1Y1VZITmmFgqvs4eob1U22nvl8AMrsrJRqcpD9+v6eUDMxhyL4VHZGHmE4lpwZ0Q
 x/Aq/sVAYon9V6QmPhsFc84m2TiN4OgDbIU+keW7eCGXZYH2/GF/OdDU1vZ2z3G9t8iw
 aTis7bypx7iF5BDBfhB7b2y6TQv0ODq4Qpi/hYltZWDCjhxTZNy26yEEYzSOn/qgG59V
 395Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCWtC6mFwMQiG7fAucpLsMo75wDHrWTlzCegK76uupGhGVkAShhMryXQ5+3IslU27mKKFi1OVEsIiAFO@nongnu.org
X-Gm-Message-State: AOJu0YwiW2bDzYWmzpTWB5uoxuyCFf/gZLqbxQRaxYmJCkzp9k9LydLq
 fRGnPgg068B7tUepkgteHbtWJVVEFoZADV58BxvuNV1cXQgFBMm6cTjTngQG9XsRf4w=
X-Gm-Gg: ASbGncsYBMlS5dfgtJz42rrTn8VAfT0Wd/4ByAk8JcO/dZaxV+tQo7VQMHiksCWVYRx
 BPqMp7ZIy80AJ3RJetUN2990CTGs9H1YAIiTC/VYL3xcwTaYL/iQyPaFLSx3jaSA6nOYcCh6cj4
 lXK5HLZQMB7KnxZTqPNwrYLPydccIOCoBallChg+93RfEXQL54nmAYw8vyWL0z8Qho3mXGAnfCJ
 AO4bQrPDlg1ydx0pIeT8LTwxaABAlrp+K5xA2g6d3pY0kAgzCKkV5QmOkL3/ttHBl/7n8GoWtL2
 yQqfPB+qywQ0Kntwjb7+pR8zbHyKSw7SpYDdla8eN5RHBAwfsEA7r0BnRCvBKhuLIBW9RyUpvdK
 SkIyo94XsI2aW2Zow0DKeFZZYbFeCI9vqOEWkxeoGvpLkBwVbKnYTXMWFL5RFQkzDpsIcWZRJnx
 UHSsvm5OgXJTn+2jfIma2YXapGJMMSfbSIkM1NW7TQWl6FU3V9XyW6nUnvWtLZ
X-Google-Smtp-Source: AGHT+IGkY10vlhJsb9CvjLedT7lRvnZIHMf9VL1pGCX8YbXkUMO2C2hBNxL8mcaHb5xh9nfLd3UrkA==
X-Received: by 2002:a05:600c:6b66:b0:477:9a28:b09a with SMTP id
 5b1f17b1804b1-4779a28b24bmr49146765e9.0.1763372887967; 
 Mon, 17 Nov 2025 01:48:07 -0800 (PST)
Received: from [192.168.8.105] (66.red-37-158-132.dynamicip.rima-tde.net.
 [37.158.132.66]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-42c9628ebacsm12232945f8f.30.2025.11.17.01.48.06
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 17 Nov 2025 01:48:07 -0800 (PST)
Message-ID: <de5f5b65-cbf8-4724-92a0-0a259b386019@linaro.org>
Date: Mon, 17 Nov 2025 10:48:05 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC v2 01/10] target/arm: explicitly disable MTE4 for max
To: Gabriel Brookman <brookmangabriel@gmail.com>, qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Gustavo Romero <gustavo.romero@linaro.org>, qemu-arm@nongnu.org
References: <20251116-feat-mte4-v2-0-9a7122b7fa76@gmail.com>
 <20251116-feat-mte4-v2-1-9a7122b7fa76@gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20251116-feat-mte4-v2-1-9a7122b7fa76@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=richard.henderson@linaro.org; helo=mail-wm1-x335.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 11/17/25 02:40, Gabriel Brookman wrote:
> Previously, the bits used to advertise the various MTE4 features were
> not explicitly set for -cpu max. This commit calls out these bits and
> explicitly unsets them. At the end of the patch series, a second commit
> will explicitly set all of them.
> 
> Signed-off-by: Gabriel Brookman <brookmangabriel@gmail.com>
> ---
>   target/arm/tcg/cpu64.c | 8 ++++++++
>   1 file changed, 8 insertions(+)
> 
> diff --git a/target/arm/tcg/cpu64.c b/target/arm/tcg/cpu64.c
> index 6871956382..ca9557f4cf 100644
> --- a/target/arm/tcg/cpu64.c
> +++ b/target/arm/tcg/cpu64.c
> @@ -1281,8 +1281,16 @@ void aarch64_max_tcg_initfn(Object *obj)
>       t = FIELD_DP64(t, ID_AA64PFR1, CSV2_FRAC, 0); /* FEAT_CSV2_3 */
>       t = FIELD_DP64(t, ID_AA64PFR1, NMI, 1);       /* FEAT_NMI */
>       t = FIELD_DP64(t, ID_AA64PFR1, GCS, 1);       /* FEAT_GCS */
> +    t = FIELD_DP64(t, ID_AA64PFR1,
> +            MTEX, 0);   /* FEAT_MTE_NO_ADDRESS_TAGS + FEAT_MTE_CANONICAL_TAGS */
>       SET_IDREG(isar, ID_AA64PFR1, t);
>   
> +    t = GET_IDREG(isar, ID_AA64PFR2);
> +    t = FIELD_DP64(t, ID_AA64PFR2, MTEFAR, 0);    /* FEAT_MTE_TAGGED_FAR */
> +    t = FIELD_DP64(t, ID_AA64PFR2, MTESTOREONLY, 0);   /* FEAT_MTE_STORE_ONLY */
> +    t = FIELD_DP64(t, ID_AA64PFR2, MTEPERM, 0);    /* FEAT_MTE_PERM */
> +    SET_IDREG(isar, ID_AA64PFR2, t);
> +
>       t = GET_IDREG(isar, ID_AA64MMFR0);
>       t = FIELD_DP64(t, ID_AA64MMFR0, PARANGE, 6); /* FEAT_LPA: 52 bits */
>       t = FIELD_DP64(t, ID_AA64MMFR0, TGRAN16, 1);   /* 16k pages supported */
> 

They weren't explicitly set, but the whole ARMCPU structure, including the isar field, was 
zeroed upon object creation.  So I don't really see the point in this patch.

r~

