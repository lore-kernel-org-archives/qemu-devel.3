Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E741F433CD
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Apr 2026 00:13:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wDALk-0002Dg-GH; Wed, 15 Apr 2026 20:12:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wDALj-0002D8-2Z
 for qemu-devel@nongnu.org; Wed, 15 Apr 2026 20:12:51 -0400
Received: from mail-pf1-x42e.google.com ([2607:f8b0:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wDALh-0001MA-J2
 for qemu-devel@nongnu.org; Wed, 15 Apr 2026 20:12:50 -0400
Received: by mail-pf1-x42e.google.com with SMTP id
 d2e1a72fcca58-824c9da9928so5029119b3a.3
 for <qemu-devel@nongnu.org>; Wed, 15 Apr 2026 17:12:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1776298367; x=1776903167; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
 :cc:subject:date:message-id:reply-to;
 bh=wMgAftakz2omrM8BeDe7Pp1M+j/gpq6X/8IIrlphNO0=;
 b=HFOrJ4/rP9qtgLeIvgNaka7zsbKlMvJJLB1yuOD1E8qhI6MB6cBRWPTfg439WI75aw
 HQAZUZqgO1b6warwU7PnbCjwvTgT0Uy6X9pgZAfGUM8VcG7Ry/sEYLlB7uMmYLLPkZse
 N5WhOC/WIjbsDWZZ1b9KJ+FUy5vaazA2HX7XW3HsLbNwi0wHTfmyV+3beHIsUlNGuHJm
 sqoJg4/1jMOv9X9YEVszmSg165PdKyK7Ot6kVnW9daIweBwsLkeKZoU9NbkOLkzDSZMi
 4V/aUdEYVaL6PJ6YR+/Go1txeCODd48htcGGMhSuaUATWLf0SLb8x2yLaRaaz14ExhkX
 BKDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776298367; x=1776903167;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:from:subject:user-agent:mime-version:date:message-id:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=wMgAftakz2omrM8BeDe7Pp1M+j/gpq6X/8IIrlphNO0=;
 b=Ve4Opp2jeO7x+lyFpjL+F7AYt7hfxci0hP3+Akmv+B7NIMSdXpy35x1Uc/E3/3kp1s
 mb/wrufTBSiIAHeWKkWDzoRclCfV9+/1FHji0Kh4tScd11AokGWuBSX++XdvUEootyTr
 ZFUo7Ua9pQAZO/yLPFMG9sBkHjOuPF1sjnlA5Rv7BmiuQT8T4YT9ao+kfjBdhVpOR2v8
 Qf3tbI7M4RDQLNF45p9ZzCOfiH3xCktR6yJ0euHQy5Sh7pmvsBiVteMVzYOlDeRe3bh+
 cKvRW2xOMlv6fPIDNZ5VKAEXLk2UDaKIfrLv4nR2IXQPybTiky+waFf3T80RdZcbsy64
 Uj+Q==
X-Forwarded-Encrypted: i=1;
 AFNElJ+uUIsoboxqr/6SSbsXuByAKMG+BFNdxYDFdlwwkSPS+6y6bqZ3hHPqNiJqZs8FIMPl/V4h3emp9dvW@nongnu.org
X-Gm-Message-State: AOJu0Yw3Wuhxh7XjxyZUi+WSBbVJC9wn2+zboXs0wTcrNIvvitJi/L4J
 0F4i+PALCJTp6nChx5KzGO0VOMThMddbxl+X/QJWdkvRq75h9S4HO/4QR329ghnQIYo=
X-Gm-Gg: AeBDievdt4J2tLGlAux6kVdw0pnf8Jt9aWq6HPVVYwcSZu3gtOCgOw0SgiXHSipylTV
 BwGSQqm6dcgjXwEGKAywAqONfogsApZAOXuqTttuDhWD9moABd6+Skaq/yrzkFkR1UuttVuBRiW
 fXuULiJ/45d/M9avkGy/w656fpiff3Q4E6Tkv9TZqL/m1wR5o1BBm4DgHkfCkigiSxLWK8CMFSl
 uhIlxCUyEC8+GCtZPD6/DyJpg6fB9S+CRnOKEwdOR+LVmCJVmIss+Lq8SjmZSYxBpUVdmti6PUz
 W86S71KrurP1U+8h9y1AnzD1v9TknYWbhvUtS2JjM+GpIBEJOeIoSMNcYyExWoaVilNOBTYt3sY
 4yxv8HntsErbxNYxwGRbSW7LbN9j6Ew/cjMjl9ECYIz4GZV5ZmKSVCRGBzIWMSa/THtpcZok2UM
 OLRHRFRt2XVohnFzuNbW5qFJRiNX/mPFSqGu18drQs6vXwCFfSFkYXSMyFfAOJgoSsBn99Sjkmy
 uqUOSy1q5RFePbaQemhZt56
X-Received: by 2002:a05:6a00:1805:b0:82f:7703:2ca5 with SMTP id
 d2e1a72fcca58-82f770339bemr1186423b3a.52.1776298365874; 
 Wed, 15 Apr 2026 17:12:45 -0700 (PDT)
Received: from ?IPV6:2401:d002:dc0f:2100:31f2:aa94:4389:37f8?
 ([2401:d002:dc0f:2100:31f2:aa94:4389:37f8])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-82f6728d5d3sm3295571b3a.25.2026.04.15.17.12.42
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 15 Apr 2026 17:12:45 -0700 (PDT)
Message-ID: <78385610-428c-4315-b99e-711ddfe8b01c@linaro.org>
Date: Thu, 16 Apr 2026 10:12:38 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v5 3/6] target/mips: Convert MSA LD/ST.H (Halfword
 Vector)
From: Richard Henderson <richard.henderson@linaro.org>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Aleksandar Rikalo <arikalo@gmail.com>, Aurelien Jarno <aurelien@aurel32.net>
References: <20260415202027.83008-1-philmd@linaro.org>
 <20260415202027.83008-4-philmd@linaro.org>
 <befeecab-5485-4159-a60c-b0f07948bee2@linaro.org>
Content-Language: en-US
In-Reply-To: <befeecab-5485-4159-a60c-b0f07948bee2@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42e;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42e.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 4/16/26 10:11, Richard Henderson wrote:
> On 4/16/26 06:20, Philippe Mathieu-Daudé wrote:
>> @@ -813,6 +824,15 @@ static bool trans_msa_ldst(DisasContext *ctx, arg_msa_i *a, bool 
>> is_load)
>>           tcg_gen_extr_i128_i64(d0, d1, t16);
>>       }
>> +    if (mo_endian(ctx) != MO_LE) {
>> +        switch (a->df) {
>> +        case 1:
>> +            gen_bswap16x4_i64(d0, d0);
>> +            gen_bswap16x4_i64(d1, d1);
>> +            break;
>> +        }
>> +    }
>> +
>>       if (!is_load) {
>>           tcg_gen_concat_i64_i128(t16, d0, d1);
>>           tcg_gen_qemu_st_i128(t16, addr, ctx->mem_idx, mop);
> 
> You've just bswaped the architectural registers.
> You need new temporaries here...

... for stores.

Hit send too soon.  :-)


r~

