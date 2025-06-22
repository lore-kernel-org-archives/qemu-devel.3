Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7BEFC7115A
	for <qemu-devel@archiver.kernel.org>; Sun, 22 Jun 2025 20:54:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uTRhi-0002Fa-M3; Sun, 22 Jun 2025 16:54:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uTRhg-0002FI-42
 for qemu-devel@nongnu.org; Sun, 22 Jun 2025 16:54:16 -0400
Received: from mail-pg1-x533.google.com ([2607:f8b0:4864:20::533])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uTRhe-0008Dd-Nk
 for qemu-devel@nongnu.org; Sun, 22 Jun 2025 16:54:15 -0400
Received: by mail-pg1-x533.google.com with SMTP id
 41be03b00d2f7-b3182c6d03bso4169183a12.0
 for <qemu-devel@nongnu.org>; Sun, 22 Jun 2025 13:54:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1750625647; x=1751230447; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :to:from:subject:user-agent:mime-version:date:message-id:from:to:cc
 :subject:date:message-id:reply-to;
 bh=YZckxj0XXhWUaGy4NvMc4tGfkjutE2z/XM3wOKKH5eQ=;
 b=YTr24SNqT4LYSXRxFfi8zM8Xblh60hVKp9rySjTdPvBWR5+FkFJKVmY6D1QL/M9G7r
 /HZWW2VeUTx5HW3Z/5/WN2gtLWuahQWJu3FaV/NfSie7IKzkPN4RJH+fXgf19rWS0V0x
 AbjQ7OD92RIqk6u3m2TysdIIpDCDjzvFIVOC9uDjALyUKN1foF2wsP4iRht+MYmg3XxT
 AmrKyHrkIYlnK3Tt/tagTMJwbJWWHk4O0Khbp+RfMCn01bBSvvE5wvqPzQ54vXMn4mNC
 cGf+4nzMeKB7DQRDsnkY0GlBagajnWWT0qZ0SNy27422l9DWUxvizt5tJfTxEffXex3k
 83Nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750625647; x=1751230447;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :to:from:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=YZckxj0XXhWUaGy4NvMc4tGfkjutE2z/XM3wOKKH5eQ=;
 b=GFE3EJdYKiPmw2YXLvdsKLCLVuqsMxxwToWyXWiHp+gxmApGb6VLDAf4ZWJgx3wOMa
 1FZODilz3u3gNDHdtJHWBYmEK6nj8cOvMY/gSbuTI/SBCdfYJHLsySYuBCZGq0e6lTNJ
 erJpejTJFt90QBN7SijZE+Tr8kxq+uJ9TUSTazZhuvlDzwFz3apZ0OWYLDjLllJ6okEN
 6vzALcIImyWTGEmEh/WMLaOodzbiIkI+Cg1BrGDBJSTOmTy91WAhC2dgvzOVSXUUcalB
 vE9YKw5eg7Pp0ruhcEH94Z4qP1ADf7uBLsXMw8rnK4DjBBRwPJmGj2wFNYnoAoCR/h7k
 hLUA==
X-Gm-Message-State: AOJu0Yyf07lr2IrBI889hUmf8YZhmvawcSvugFgCo1Vyp7xu4fPeuBxj
 oQ3gQI1/oHvbhb5epCwlwDKk/4+iNcoG2L0KlVX5WNS6b+Dimko4/GJ3rDwCmBDo5lmm7PAPBjo
 q074eXG4=
X-Gm-Gg: ASbGncty7VlgGUzrnId80RCb1Bj1lDkKoat3kzxXajADQbbSwz3sZ6hGrB2f67Dzzoo
 XzkuWFHTRzQ+dgM+rmmCJ5P4s8wZm2wBNtX+HhzsZwTkhotCv1GXcVSeGf/V7YqmgDEVmAGkH4w
 P6yV6fFuKk6LLJ2cEsdvVZp8mczuCjXkt1TxFnRBGicegggozJLHTFaKHJvrS65ACJm/T3+UZM9
 qME3Jt++/1fhYYj6ssgBSM0M+p6d6H0BSMRoc0HOz7r10J+aoLFcdiNWJPm8LXZ9knwHnj4msuB
 UpZkG68DKFDp54lUZapim8eoS+4saWCRZ5GGzI9S7QrRpqiGF18ykzUuZqJw4z2dRAArwkyes/n
 Cl30oPeQxAoih3DayEbMgmLURBk8N
X-Google-Smtp-Source: AGHT+IE8BdogXDX8TICc/AhZ4I8QCQ9jNadn/FAMqZvh8ZHYLKKDPEStF02b4kyHuEBQ4KDMPbthag==
X-Received: by 2002:a05:6a21:1587:b0:1f5:6e71:e55 with SMTP id
 adf61e73a8af0-22026d33126mr16909262637.6.1750625646685; 
 Sun, 22 Jun 2025 13:54:06 -0700 (PDT)
Received: from [192.168.0.4] (174-21-67-243.tukw.qwest.net. [174.21.67.243])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-b31f1242bfasm5219869a12.46.2025.06.22.13.54.06
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 22 Jun 2025 13:54:06 -0700 (PDT)
Message-ID: <629c93ff-5849-4937-9b52-3d2116f90035@linaro.org>
Date: Sun, 22 Jun 2025 13:54:04 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 065/101] target/arm: Implement SME2 FCLAMP, SCLAMP,
 UCLAMP
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
References: <20250621235037.74091-1-richard.henderson@linaro.org>
 <20250621235037.74091-66-richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20250621235037.74091-66-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::533;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x533.google.com
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

On 6/21/25 16:50, Richard Henderson wrote:
> +static bool trans_FCLAMP(DisasContext *s, arg_zzz_en *a)
> +{
> +    static gen_helper_gvec_3_ptr * const fn[] = {
> +        gen_helper_sme2_bfclamp,
> +        gen_helper_sme2_fclamp_h,
> +        gen_helper_sme2_fclamp_s,
> +        gen_helper_sme2_fclamp_d,
> +    };
> +    TCGv_ptr fpst;
> +    int vl;
> +
> +    /* This insn uses MO_8 to encode BFloat16. */
> +    if (a->esz == MO_8
> +        ? dc_isar_feature(aa64_sme2_b16b16, s)
> +        : dc_isar_feature(aa64_sme2, s)) {

Missing !'s.


r~

