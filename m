Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0160E77188
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Dec 2024 22:26:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tQwIp-00084K-DM; Thu, 26 Dec 2024 17:25:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tQwIm-00083q-7C
 for qemu-devel@nongnu.org; Thu, 26 Dec 2024 17:25:56 -0500
Received: from mail-pl1-x62e.google.com ([2607:f8b0:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tQwIk-0002aQ-Iy
 for qemu-devel@nongnu.org; Thu, 26 Dec 2024 17:25:55 -0500
Received: by mail-pl1-x62e.google.com with SMTP id
 d9443c01a7336-2166360285dso81099565ad.1
 for <qemu-devel@nongnu.org>; Thu, 26 Dec 2024 14:25:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1735251953; x=1735856753; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=5dLf1Kq6xzTrktj3bf/evyPGkUN+v5J4zWxwWlBVJgU=;
 b=JlCwCaFAv9vDVB5i2C1G9051oOCkHT0weuE6R3fg2KyMVgiJoakGDWa+J/4JvCAFdR
 mb3iZeYD7JdFAHO4xHGW0+R61G1pnWUpwTuXSQSuvoOrjzd7uFUZ+1j6xxdGnh0YYZqb
 JpzZGjBGLKID99ig++MKC6utdxVpDxw7hNSrgS+XlPVNRf8GMhiRSDnF/b2PMToHAMX/
 4CgCAqR5jNaFzIFML5VDuhHuEci9IFD/2Noy/B3cUpwPE7irn9vw8WKqxKx7vtdGTmA5
 We9mZ5kpZFS7NmddDLXQmkmuJrND+rly3QdZbkcueUp8GF+mSz82gvLa0M07+Yqy+U7j
 nGrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1735251953; x=1735856753;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=5dLf1Kq6xzTrktj3bf/evyPGkUN+v5J4zWxwWlBVJgU=;
 b=vgRoeL1NMwzQwyrCIXAJWvGsF0u7Qewa5Jl6MixQzU4XOyyQ3+ysiSvbMR47u+4JHA
 OHpKcRJyu/Xr8X0gi7aO/JhM2ytLutPOxPiAAuv9a0A1faATwUs+w2hHvzwjM5KtCyzG
 Cp8kWjLR9wzCcoDJiATOq5tu0c2wyOqEijwaeZm6vB9tSxhltD6Jos9Xmr3VF0RcWKjY
 ExmIif2hLp8E6HvzkrjV3bIhLdI8mDVERWhlGV0iBlYtFqn/IFugRewny/pSXXuMxex+
 gcqIN6WcJ6mdsFt/7rHmGUfkic/j0LEMpZjnhmMFFP8qjQIsRF3dLvgSjTI7ACaJfy+B
 CstA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXgYScLISUdiI8Lwr8TMaopAdYHP8qNzB7rCtu6eOqdF0WjkN//InRmLjVRTm+aqgxbVUSyswU1e18w@nongnu.org
X-Gm-Message-State: AOJu0YyRh9pVQHXrFaJNTNEJ2BRV3h474f/PzS7Z2COTSP3ViZHAgoFn
 CQoO2mD/M0hLu+GhuKdRoKW6wScnzyIIx3ci9kXZvMP487jvfr3Ms/t1kT/Iov8=
X-Gm-Gg: ASbGncssCMluLILbjmmLKPd0WmpjJPkgcdR0iJpqkd69LlVY1dHrPFNuRowAb4/h2As
 gbvz9HXXVjfYN5e56hSjJvdQTfJOtTsAjaOlQujmIoJLu5/wLQ9YlT9O3dCTBxNOhBKp0oVMwZX
 m4x4qzQhlJP7Zws3cFy4Dd8rByIbM0l3CvWZG3igZ+kxqdYKDqTh3mtwXJyFqCPTLaPHzJ9Bkd0
 jqUa3ywWZvulCiEcOyvkG2mweH6l010RsT479RyBj1ZtKXCUQBiAbqZFAaEwBdzonjM2vOItGg1
 AU8P3me2zF8ybiryHB4b5kVJ+BMwa+RY8vDUDEc=
X-Google-Smtp-Source: AGHT+IGGRdeq8nbi0mWgw2kNc6AxG2iUZKGctq79L2Zr4qsoJHqXYTdTo31/GkMyYZknbVBHjlN6rg==
X-Received: by 2002:a17:903:2acb:b0:212:514:b30a with SMTP id
 d9443c01a7336-219e6e85a46mr380297765ad.12.1735251952733; 
 Thu, 26 Dec 2024 14:25:52 -0800 (PST)
Received: from [192.168.125.227] (syn-156-019-246-023.biz.spectrum.com.
 [156.19.246.23]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-219dc964a73sm124152935ad.45.2024.12.26.14.25.51
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 26 Dec 2024 14:25:52 -0800 (PST)
Message-ID: <85a13307-6d57-402d-bc30-8004275e9d47@linaro.org>
Date: Thu, 26 Dec 2024 14:25:49 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 11/23] target/loongarch: Scrutinise TCG vector
 translation for 32 bit build
To: Jiaxun Yang <jiaxun.yang@flygoat.com>, qemu-devel@nongnu.org
Cc: Song Gao <gaosong@loongson.cn>, Bibo Mao <maobibo@loongson.cn>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>, Zhao Liu <zhao1.liu@intel.com>,
 Paolo Bonzini <pbonzini@redhat.com>
References: <20241226-la32-fixes1-v2-0-0414594f8cb5@flygoat.com>
 <20241226-la32-fixes1-v2-11-0414594f8cb5@flygoat.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20241226-la32-fixes1-v2-11-0414594f8cb5@flygoat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62e;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62e.google.com
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

On 12/26/24 13:19, Jiaxun Yang wrote:
> @@ -4850,12 +4852,12 @@ static bool gen_g2x(DisasContext *ctx, arg_vr_i *a, MemOp mop,
>       return gen_g2v_vl(ctx, a, 32, mop, func);
>   }
>   
> -TRANS(vinsgr2vr_b, LSX, gen_g2v, MO_8, tcg_gen_st8_i64)
> -TRANS(vinsgr2vr_h, LSX, gen_g2v, MO_16, tcg_gen_st16_i64)
> -TRANS(vinsgr2vr_w, LSX, gen_g2v, MO_32, tcg_gen_st32_i64)
> -TRANS(vinsgr2vr_d, LSX, gen_g2v, MO_64, tcg_gen_st_i64)
> -TRANS(xvinsgr2vr_w, LASX, gen_g2x, MO_32, tcg_gen_st32_i64)
> -TRANS(xvinsgr2vr_d, LASX, gen_g2x, MO_64, tcg_gen_st_i64)
> +TRANS(vinsgr2vr_b, LSX, gen_g2v, MO_8, tcg_gen_st8_tl)
> +TRANS(vinsgr2vr_h, LSX, gen_g2v, MO_16, tcg_gen_st16_tl)
> +TRANS(vinsgr2vr_w, LSX, gen_g2v, MO_32, tcg_gen_st32_tl)
> +TRANS(vinsgr2vr_d, LSX, gen_g2v, MO_64, tcg_gen_st_tl)
> +TRANS(xvinsgr2vr_w, LASX, gen_g2x, MO_32, tcg_gen_st32_tl)
> +TRANS(xvinsgr2vr_d, LASX, gen_g2x, MO_64, tcg_gen_st_tl)

All of these *_d instructions are invalid for LA32.
This is obvious because they specifically refer to general registers.

All of the rest of these changes need to be audited.

> @@ -4905,8 +4907,8 @@ static bool gvec_dup_vl(DisasContext *ctx, arg_vr *a,
>           return true;
>       }
>   
> -    tcg_gen_gvec_dup_i64(mop, vec_full_offset(a->vd),
> -                         oprsz, ctx->vl/8, src);
> +    tcg_gen_gvec_dup_tl(mop, vec_full_offset(a->vd),
> +                         oprsz, ctx->vl/TARGET_LONG_SIZE, src);
>       return true;
>   }

This is not obvious.  There might be uses for which we really ought to have extended the 
src argument to TCGv_i64.


r~

