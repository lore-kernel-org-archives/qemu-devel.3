Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE549C369AB
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Apr 2025 22:04:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u4oNs-0001kZ-QU; Tue, 15 Apr 2025 18:04:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1u4oNo-0001fr-ST
 for qemu-devel@nongnu.org; Tue, 15 Apr 2025 18:03:57 -0400
Received: from mail-pf1-x434.google.com ([2607:f8b0:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1u4oNn-0000EU-7q
 for qemu-devel@nongnu.org; Tue, 15 Apr 2025 18:03:56 -0400
Received: by mail-pf1-x434.google.com with SMTP id
 d2e1a72fcca58-7390d21bb1cso6010300b3a.2
 for <qemu-devel@nongnu.org>; Tue, 15 Apr 2025 15:03:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1744754633; x=1745359433; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=OjERZ+Ap/p3ldvvmAk40SgxYdOcgawhSAwIAcIddYUw=;
 b=DLvk/1DVhZR/aOjEGprsrkyR5R3sZV0aQyGIqv+z3Pj7jTz7cNHxx56aknrJT+0pJO
 rVa+0Vu8ES7iw5PwBsFjWz8raWu/KcGBn7BcCTUSo/mNkWZJSEyG6YvnHRTyFpv+AkAT
 2eY8MsooszHBWT9BSDdqDvj8ijSwR61tn3GXcpC6RIsLLcJLhj0z6kttkfxXI9IW4HVs
 PQ1e2JVVl3FtrKm4q7Tuxjs984gKambbKYpd+TBD13Ng/Z8B+juc6346by0xAlYDSFGw
 dSYNOEyxHz+vQqdnmSIoU9Y5uY0Ev6ik6NCuVnEwt75V3QIxAvR/L4GNmeKwB5P/HCCc
 3BKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744754633; x=1745359433;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=OjERZ+Ap/p3ldvvmAk40SgxYdOcgawhSAwIAcIddYUw=;
 b=Apu16BH6awcfhETVRdHahB+jpikFv79VbU5nGibcZGQ/sIAsx02AhxSRn9BzdWFBB7
 umACpVfPt3aSrSRBboMV9MGDjN+U7BmaCSOkKBC1yeq/qWsKC5/x+ZJHb7ol4ZUlCbul
 zuSPDd1J4xGc6XXUjTcI0uVDfNDL35BniRhvyyW+WXokeKnrrFt9yKrB/Cg7IgOAZZpC
 wglfjr/TT2eX6dnz0Wkn/0F2W2RRzeg7KQ+MlIbr58j5bHEEohrmE/IrIo7Eg7Rh8/WP
 QO3+EIIR+CGsNet9a75aMz5aCguk6RnqNzwHnsTj0bvAJzxplpE9B6W2iZeSPn/DJwKX
 eLow==
X-Forwarded-Encrypted: i=1;
 AJvYcCXweNtlP6tyOKiikDc3tLYWwkkAN0nEIW8umDcQt4O66ejECifhyDPIBF8hWmOkJeTRErnDNbN7uJTG@nongnu.org
X-Gm-Message-State: AOJu0YyjKXUAZ155srHX9ZYMnc+TQ1LzKokKWBOgNio3W7x6t9WGSI0k
 HKIoMXP+YtnsqRrezsIUR++3H+uKTDw5+g5wJXqXrJmFuTTugkxD9tPueA0w/+o=
X-Gm-Gg: ASbGncs9MNzcMoub2XoTiMUiXPFwlxDWX+zMzJd9xx+bzfhDeOj9bj7WcYeYJIcdVpR
 zbJHplqi2K9Ew7lES81l3OhJtrlXBix0dn0cMI3y1s88qSpqChwMbkut/WRXrEz8PXvZoBmH0nr
 ojXPo+0OrrIK30RERn4XAJYSIkR+35UBwnsZmo26G5H16MCI0hI4Yr/JMzu1gqckl5qy96c+uXq
 jiDeKebtjjCVIKq47nsGh0pv8WpVD7sickhnyPjvw2QEpJQ61Xpe3jiP1+aWUCjZz1kwxR9DqEM
 PP5KuhOr1PYVzXg13tZqD+qKF00Kdvq9wa1I7D/tTEzWXqMVBV5wSQ==
X-Google-Smtp-Source: AGHT+IEFHjg42zVRzoWR2bU44iR1TVX4i4KyuNEnXfq+eCRkQtLCefrxaz9S7lWKbfI7FxaElaWpxA==
X-Received: by 2002:a05:6a20:6f0a:b0:1f5:882e:60f with SMTP id
 adf61e73a8af0-203adfc6dcdmr895071637.17.1744754633298; 
 Tue, 15 Apr 2025 15:03:53 -0700 (PDT)
Received: from [192.168.1.87] ([38.39.164.180])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-b0b2220377dsm26232a12.50.2025.04.15.15.03.52
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 15 Apr 2025 15:03:52 -0700 (PDT)
Message-ID: <aafcb88b-c06f-4e66-9fa6-bb10b1d0f770@linaro.org>
Date: Tue, 15 Apr 2025 15:03:52 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 107/163] tcg: Expand fallback sub2 with 32-bit
 operations
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20250415192515.232910-1-richard.henderson@linaro.org>
 <20250415192515.232910-108-richard.henderson@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20250415192515.232910-108-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::434;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x434.google.com
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

On 4/15/25 12:24, Richard Henderson wrote:
> No need to expand to i64 to perform the subtract.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   tcg/tcg-op.c | 17 +++++++++--------
>   1 file changed, 9 insertions(+), 8 deletions(-)
> 
> diff --git a/tcg/tcg-op.c b/tcg/tcg-op.c
> index 8b1356c526..127338b994 100644
> --- a/tcg/tcg-op.c
> +++ b/tcg/tcg-op.c
> @@ -1123,14 +1123,15 @@ void tcg_gen_sub2_i32(TCGv_i32 rl, TCGv_i32 rh, TCGv_i32 al,
>       if (TCG_TARGET_HAS_sub2_i32) {
>           tcg_gen_op6_i32(INDEX_op_sub2_i32, rl, rh, al, ah, bl, bh);
>       } else {
> -        TCGv_i64 t0 = tcg_temp_ebb_new_i64();
> -        TCGv_i64 t1 = tcg_temp_ebb_new_i64();
> -        tcg_gen_concat_i32_i64(t0, al, ah);
> -        tcg_gen_concat_i32_i64(t1, bl, bh);
> -        tcg_gen_sub_i64(t0, t0, t1);
> -        tcg_gen_extr_i64_i32(rl, rh, t0);
> -        tcg_temp_free_i64(t0);
> -        tcg_temp_free_i64(t1);
> +        TCGv_i32 t0 = tcg_temp_ebb_new_i32();
> +        TCGv_i32 t1 = tcg_temp_ebb_new_i32();
> +        tcg_gen_sub_i32(t0, al, bl);
> +        tcg_gen_setcond_i32(TCG_COND_LTU, t1, al, bl);
> +        tcg_gen_sub_i32(rh, ah, bh);
> +        tcg_gen_sub_i32(rh, rh, t1);
> +        tcg_gen_mov_i32(rl, t0);
> +        tcg_temp_free_i32(t0);
> +        tcg_temp_free_i32(t1);
>       }
>   }
>   

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>


