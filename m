Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 651D1C2BA1A
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Jun 2024 17:58:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sJGbl-0000Zu-T6; Mon, 17 Jun 2024 13:57:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sJGbi-0000TX-VE
 for qemu-devel@nongnu.org; Mon, 17 Jun 2024 13:57:31 -0400
Received: from mail-pf1-x42c.google.com ([2607:f8b0:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sJGbf-0003Gh-Gg
 for qemu-devel@nongnu.org; Mon, 17 Jun 2024 13:57:30 -0400
Received: by mail-pf1-x42c.google.com with SMTP id
 d2e1a72fcca58-6f6a045d476so3552995b3a.1
 for <qemu-devel@nongnu.org>; Mon, 17 Jun 2024 10:57:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1718647042; x=1719251842; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Xeze6laj5Ddscd3FgIMlrvPObdMTF/B5kdcGtpNJ++o=;
 b=ymzn00XvmVejzCqaS6hGmQj92lPnY6YTrIOlAhhVgAk5f9ZhfFETnVeEluatpiwBUy
 WLUTbp8jEVCTQCwSSaEjFk3lrIct0w49EgV13TFjv/QJ5b8nZPHETp+wyX/lSslpGZXk
 R+u5s3kCGOfEG0oEisENT9dV807crOIOl7+zSFvTnoJDz8NooVvFVpZAz4BuNL7B39uA
 cdvI89k6seYqMKJ4ik8nXxTfVAfb3DNlogImASk//petWRbpBO9TZbLV3NU7DVvX8Zb3
 LtkQ8rkK347i7h9hcv76DoNqciggoO0MB1I4kOmkQR2enq47XNz3FRYPp0LoKBy34TXc
 MEvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718647042; x=1719251842;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Xeze6laj5Ddscd3FgIMlrvPObdMTF/B5kdcGtpNJ++o=;
 b=fHXjeoHzEqA//n1BuXDFt0CKTz0eceHITPXc29HlV0HzPS84ODzej4MauDRyBqWMOb
 qemWZwaMquKHf6dzxPSGgogAG+HHXFe74Xbs87V0Yo1aG1K2GNkQzWwjugVKgEAd4M3e
 jh1yB4+GmsTPxEhwu44jA1whvB66vN8+/uMbv5yf9VbT3fKixRQB2YEBDd3NvWUqz5Fc
 X8C7LOecXUzcy+Ik2KnDo3xd9/WJXs3Ql3wUj/+hG0DXsAz8A28LaviKxTGPK6fOnprx
 ZeK68r2vvlhh1MdtzG9MjNkyIqw5ZZuj9GFeq69s6hkhOxKRRm3A6+1QpWl3QFwlLf5H
 80mQ==
X-Gm-Message-State: AOJu0Yzigcmc2OurrKjijCL6mk43VQZgHs6jAYrBtya1IfSAkj0nNiYH
 6kE5fJNZw+6VKlcVnHoQUPq8uSj/T5ew0+Bi1r8kXhzqR8Flm6h+c4HrNnSc78g=
X-Google-Smtp-Source: AGHT+IGtnsGrdqYbWrHT/cOk7B0AbLDBETUMbMaOVCQVuYVuAh2RLvyOuVNi7JC381SJnCCU4w/dhQ==
X-Received: by 2002:a05:6a21:1506:b0:1b5:8ecf:4e7e with SMTP id
 adf61e73a8af0-1bae8335933mr11617631637.58.1718647042535; 
 Mon, 17 Jun 2024 10:57:22 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.132.216])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-705ccb6af5csm7632154b3a.162.2024.06.17.10.57.21
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 17 Jun 2024 10:57:21 -0700 (PDT)
Message-ID: <a50d339b-d44a-41c1-bb28-82eb761771a1@linaro.org>
Date: Mon, 17 Jun 2024 10:57:15 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/4] target/ppc: Move VSX vector with length storage
 access insns to decodetree.
To: Chinmay Rath <rathc@linux.vnet.ibm.com>,
 Chinmay Rath <rathc@linux.ibm.com>, qemu-ppc@nongnu.org
Cc: qemu-devel@nongnu.org, npiggin@gmail.com, danielhb413@gmail.com,
 harshpb@linux.ibm.com
References: <20240613093318.314913-1-rathc@linux.ibm.com>
 <20240613093318.314913-3-rathc@linux.ibm.com>
 <6638b813-f4ef-4587-b94f-3c24d90ca09e@linaro.org>
 <94d97af2-62e2-4fde-909b-c57af8ef814f@linux.vnet.ibm.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <94d97af2-62e2-4fde-909b-c57af8ef814f@linux.vnet.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42c;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

On 6/17/24 04:51, Chinmay Rath wrote:
> 
> 
> Hi Richard,
> On 6/17/24 00:43, Richard Henderson wrote:
>> On 6/13/24 02:33, Chinmay Rath wrote:
>>> +/* EA <- (ra == 0) ? 0 : GPR[ra] */
>>> +static TCGv do_ea_calc_ra(DisasContext *ctx, int ra)
>>> +{
>>> +    TCGv EA;
>>> +    if (!ra) {
>>> +        EA = tcg_constant_tl(0);
>>> +        return EA;
>>> +    }
>>> +    EA = tcg_temp_new();
>>> +    if (NARROW_MODE(ctx)) {
>>> +        tcg_gen_ext32u_tl(EA, cpu_gpr[ra]);
>>> +    } else {
>>> +        tcg_gen_mov_tl(EA, cpu_gpr[ra]);
>>
>> Why are you making a copy, rather than just returning cpu_gpr[ra]?
>> If you need to modify the resulting EA, then you also need to make a copy for 0.
>>
> Please ignore my previous response.
> I think do_ea_calc_ra should allow modification to the resulting EA, hence below change 
> appears more appropriate to me :
> 
> /* EA <- (ra == 0) ? 0 : GPR[ra] */
> static TCGv do_ea_calc_ra(DisasContext *ctx, int ra)
> {
>      TCGv EA = tcg_temp_new();
>      if (!ra) {
>          tcg_gen_movi_tl(EA, 0);
>          return EA;
>      }
>      if (NARROW_MODE(ctx)) {
>          tcg_gen_ext32u_tl(EA, cpu_gpr[ra]);
>      } else {
>          tcg_gen_mov_tl(EA, cpu_gpr[ra]);
>      }
>      return EA;
> }

If that's what's needed by the callers of do_ea_calc_ra, then yes.
You can drop the first return EA and use else if instead.


r~

