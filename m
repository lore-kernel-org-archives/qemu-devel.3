Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE042D78333
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Dec 2024 16:30:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tI9IZ-00054z-4Q; Mon, 02 Dec 2024 11:29:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tI9IY-00054b-3O
 for qemu-devel@nongnu.org; Mon, 02 Dec 2024 11:29:22 -0500
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tI9IW-0000RM-Al
 for qemu-devel@nongnu.org; Mon, 02 Dec 2024 11:29:21 -0500
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-385e96a285eso1042150f8f.3
 for <qemu-devel@nongnu.org>; Mon, 02 Dec 2024 08:29:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733156958; x=1733761758; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=dlQbNx+JffZzs6bek1V/fItnLxBAEe17t7iBaX8dCZA=;
 b=MHiND2FNCbt2vFecGRxhOUcBwazSK2Z5zTfe9Bws08ja5l1+cCf0IQsFQ5J1pZGlfo
 OmF1dBNIw9qquNvFvQ9CVOjTdA99uN7xUbs7hLEkpR2OYbq8Ism24aPNu1iTFYdfORXf
 Rt4PxB0DR/+jQ+oheCJ8dNTQel+TykFKOsQ9acEEHjjXBZFUGR0XRM3wrTLyqUHG8vFS
 LvhUOQ3JvUxf32wJgCEj4wrtHtOssxAw9Xlvcg22btk9wIwQNHHi4qeKeFvbaeScWIFH
 W88eajXCw+mjt9kzAWrX+i1Wym68/igVjT7n/tC1vdoBOqUfBJOYn1BhCLtMK7Mrc+AW
 RZTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733156958; x=1733761758;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=dlQbNx+JffZzs6bek1V/fItnLxBAEe17t7iBaX8dCZA=;
 b=RSCreOi48I7ykBQYniQQuHUJGxqmAI9MPi7PNY/rGId/OJF5ik9x3QtfhuonndDqWg
 nm69ywqWvLQOKieJQlRHtplL7zC0T4w1LM3/4qIZXvHnUjAKPaNwcnvmtmVEPEZGJBZC
 7i5eFVH2X0ITrle/nI/w70BEQxCS0eFpzvxYt7Jp2hT1Yy1wk5Omx6CzMfEdyy+CdccO
 ehIQA0Fojd+z2UXe1AtvqcC6cc6zOra6Yy7VKUVLt94y0cO1OH69dbqpVdh9stPJRd0c
 BhZnjFgLetu4cDL8dlU8nBwdlOphb2oLE4o8aK1ozvtl4h0kud7bnzFArIloPFtiAPK1
 UlIw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWLkCfWZnZMVgKNSK1TGWLBsezGcpzn2yMMqq/mkHcasveFw1EsX5/lKltEXR5O8LJ9KTbr5gtnmUyx@nongnu.org
X-Gm-Message-State: AOJu0YyvGVVYIOjK1cjbVWm1uUfwLiOi3qOqxPeMxalDUh71Cpiah2gY
 8wtDyTQJrFZjVy+NlGGgqxN+9KKHcLx8dDBKslzMtQauWSCKzVrFCZ2EuI8cExo=
X-Gm-Gg: ASbGnctQEUyVqDPOqo6bltm+UoqYaZ6P/WoTDtTLdMO7Vac1ttz//8y8U4LFo0NJAvJ
 INdHx6072rZHzQJob46uVwVju1mu60oX7iHgrBQuAWnZ09gG/xYVpA+LUE6GwOLUqgV4M01BXho
 YXxkE8HF0UvPnSYV/UzE7LXQrgCz3tMVZFLFUIU8hmM7YpE+ZRtMepXluhbLzHMC0d/1k3MkVOS
 Htk9Svi2DxMcCKDukvfQzSX05gPLQVvRxMi+y/KmVIkcm+nKKelnBKSEnwidANSLBV6uQ14ttgt
 F00vleXCb9EzXFLFiSLYiOo7OQjmRQ==
X-Google-Smtp-Source: AGHT+IHvVskRNBEAKW01FF8QveTMCls2rp7Ie5fIxQlPllX8kOkFWyMJCEyDA9y98dymQRcwI0CueA==
X-Received: by 2002:a05:6000:2ac:b0:385:dd10:215d with SMTP id
 ffacd0b85a97d-385dd1022fbmr14270312f8f.44.1733156958460; 
 Mon, 02 Dec 2024 08:29:18 -0800 (PST)
Received: from [192.168.68.213] (72.red-95-127-54.dynamicip.rima-tde.net.
 [95.127.54.72]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-385ccd36557sm12860168f8f.24.2024.12.02.08.29.16
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 02 Dec 2024 08:29:17 -0800 (PST)
Message-ID: <c0aa6a8b-59f4-4d3a-83c5-aff885a2eaf8@linaro.org>
Date: Mon, 2 Dec 2024 17:29:14 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 36/67] target/arm: Introduce gen_gvec_cls, gen_gvec_clz
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
References: <20241201150607.12812-1-richard.henderson@linaro.org>
 <20241201150607.12812-37-richard.henderson@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20241201150607.12812-37-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::429;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x429.google.com
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

On 1/12/24 16:05, Richard Henderson wrote:
> Add gvec interfaces for CLS and CLZ operations.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   target/arm/tcg/translate.h      |  5 +++++
>   target/arm/tcg/gengvec.c        | 35 +++++++++++++++++++++++++++++++++
>   target/arm/tcg/translate-a64.c  | 29 +++++++--------------------
>   target/arm/tcg/translate-neon.c | 29 ++-------------------------
>   4 files changed, 49 insertions(+), 49 deletions(-)


> +void gen_gvec_cls(unsigned vece, uint32_t rd_ofs, uint32_t rn_ofs,
> +                  uint32_t opr_sz, uint32_t max_sz)
> +{
> +    static const GVecGen2 g[] = {
> +        { .fni4 = gen_helper_neon_cls_s8,
> +          .vece = MO_8 },
> +        { .fni4 = gen_helper_neon_cls_s16,
> +          .vece = MO_16 },
> +        { .fni4 = tcg_gen_clrsb_i32,

Why do we have tcg_gen_clrsb_i32(), ...

> +          .vece = MO_32 },
> +    };
> +    assert(vece <= MO_32);
> +    tcg_gen_gvec_2(rd_ofs, rn_ofs, opr_sz, max_sz, &g[vece]);
> +}
> +
> +static void gen_clz32_i32(TCGv_i32 d, TCGv_i32 n)

... but not tcg_gen_clz32_i32()?

> +{
> +    tcg_gen_clzi_i32(d, n, 32);
> +}

Anyhow,

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


