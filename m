Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB9C4CD5BB0
	for <qemu-devel@archiver.kernel.org>; Fri, 22 May 2026 20:05:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wQW77-00017h-Td; Fri, 22 May 2026 16:04:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wQW73-00017C-0v
 for qemu-devel@nongnu.org; Fri, 22 May 2026 16:04:54 -0400
Received: from mail-pg1-x529.google.com ([2607:f8b0:4864:20::529])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wQW70-00029n-Ps
 for qemu-devel@nongnu.org; Fri, 22 May 2026 16:04:52 -0400
Received: by mail-pg1-x529.google.com with SMTP id
 41be03b00d2f7-c8016d642b2so3740788a12.0
 for <qemu-devel@nongnu.org>; Fri, 22 May 2026 13:04:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779480289; x=1780085089; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=l4dgXUVC6tuzvLj2cjpvcJR3/0B/Dme0i+5eYta9yto=;
 b=gcwnaX1iIsL0yuHISSscKaJlMroZOxKRo2dtaaTFd/YhMWSxpVvoLoL1TW/bZCIGqM
 V/T80EZYflAauagnQ6snyS1TvlPqZ+7gv/E21fSQLsw02+XlZo88nFssZtqsz9Xe8Uma
 0j6lWHd/JvyOPOAhTMenlCW19V9xkJfa2hN0v0BWDik0R4YNYOQ/aAOoifzgIpjkwzpp
 swqQioAkupc2Nfwg4oy3E/kKfdc7GytSW9XFhViAr1FgHtP0TxIMzJXVbtNThGFOsxEx
 lKxvJ5XtqSY23CEQxefqQCh6RpWMMRO254kJ8bYTcku5X9Zl1pykEMfD/JvNIJKeThB6
 nkAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779480289; x=1780085089;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=l4dgXUVC6tuzvLj2cjpvcJR3/0B/Dme0i+5eYta9yto=;
 b=jgipsrd6PWd+mXyIQcanpO6SwpWlKBEfVkciL8FBPc1A35NRpuBnZ4v6H/KPF8vetG
 A51/npMadDaw3+98fMFAVQsidIHRl9tIdIxjEklpVWkA6CGcoCc9pdsjZaAltVURlfki
 brMNTmJNFZmY799ciCG0B5kxBk1FO6HKZQAYOwVzjup6eafjP41183iRjCPjjuJKu4Xw
 yCQtS+K7SuYW6ww7H1r6HlIXyb2xBGdCj6IO2tMB3lGuDa1LXgK5rgzXLjxIQVDEfFl2
 a7ntJJFkUookE1C1cbNuLx+dWC+6ljHCTmeBfytF2VNP0zZuihjKpcLJDZhVfM0KEPbT
 574Q==
X-Gm-Message-State: AOJu0YxbHqsRiZdl0B9EjXTH4ZEcxye5wrA5vQoG9OXAmVXV/DpdvMBm
 l8u8YZtcz2XhkcIV8GsjJykOrg3ueCEu/5pJi5idfFYeoFLndAzjOGFB0kZlpK/NO7Q=
X-Gm-Gg: Acq92OE7u0cwTNRT/yLk+0kdszr0ekmr5Eadbml5HkUAIkjEHvdIrkRkan4VKYZGFth
 G+a+NK4cD6ia0v3lT9y/sBm1wMJ61W8j2Cp3P8i9a91vi6yDFJlnPSLuOXsSYWViQGeS3vwDkm+
 wGPW/H7H0TLcWIW/WW4yaLvDIkPJwqqwwbfma129USJyQICixHMOXAK/N/pmCDSYM1UsAlQmzk7
 D1wVboXUGpqXGwWQvZ0Ih2qCMHD6ZIRHIctjRZHn1TeauQNPTelSdx7w2TMg8uyYEkZoZKIoPKA
 is1eHHXNeKVL7CiZdvZbV7+5T6DhzNMjMAocAIGELlJYC26YgsiDrMSe0fsl/VYyPUh9gw8KHzI
 GL7vA2/53cAkGIGAFSqAfejA9dhxC8nHzSbNh0GCehmtXwqVBWOO0Sc79QGBcC5mKsnL+H4iVGd
 xMyhwJGn6RxVYRM8Q9ufINB6Z1IFJCbtJu4cNeZkA5
X-Received: by 2002:a17:903:1a0d:b0:2b0:91e6:bc18 with SMTP id
 d9443c01a7336-2beb0878549mr44836265ad.14.1779480288712; 
 Fri, 22 May 2026 13:04:48 -0700 (PDT)
Received: from [192.168.64.111] ([50.78.183.177])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2beb58b2e8csm22804105ad.41.2026.05.22.13.04.48
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 22 May 2026 13:04:48 -0700 (PDT)
Message-ID: <5f707062-fdb9-494d-be0f-bef679c77b8d@linaro.org>
Date: Fri, 22 May 2026 13:04:46 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 60/64] target/arm: Implement FMMLA (FP8 to FP16) for
 AdvSIMD
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org
References: <20260520182213.872945-1-richard.henderson@linaro.org>
 <20260520182213.872945-61-richard.henderson@linaro.org>
 <CAFEAcA8+VBdRt3DO9zgwQccbH+O2PMZnK3o81zmX9M1GmgiseA@mail.gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <CAFEAcA8+VBdRt3DO9zgwQccbH+O2PMZnK3o81zmX9M1GmgiseA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::529;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x529.google.com
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

On 5/21/26 02:52, Peter Maydell wrote:
> On Wed, 20 May 2026 at 19:29, Richard Henderson
> <richard.henderson@linaro.org> wrote:
>>
>> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> 
>> +void HELPER(gvec_fmmla_hb)(void *vd, void *vn, void *vm,
>> +                           CPUARMState *env, uint32_t desc)
> 
> This still has some lurking copy-and-paste issues from the _sb
> version:
> 
>> +{
>> +    FP8MulContext ctx = fp8_mul_start(env, 0xf);
>> +    size_t oprsz = simd_oprsz(desc);
>> +    size_t nseg = oprsz / 16;
> 
> Each loop here handles 4 16-bit halfprec outputs == 8 bytes,
> so we want oprsz / 8.
> 
>> +    uint32_t *n = vn;
>> +    uint32_t *m = vm;
>> +    float16 *d = vd;
>> +
>> +    for (size_t seg = 0; seg < nseg; seg++, d += 4, n += 2, m += 2) {
>> +        float16 d0 = f8dotadd_h(n[0], m[0], 4, d[H4(0)], &ctx);
>> +        float16 d1 = f8dotadd_h(n[0], m[1], 4, d[H4(1)], &ctx);
>> +        float16 d2 = f8dotadd_h(n[1], m[0], 4, d[H4(2)], &ctx);
>> +        float16 d3 = f8dotadd_h(n[1], m[1], 4, d[H4(3)], &ctx);
>> +
>> +        d[H4(0)] = d0;
>> +        d[H4(1)] = d1;
>> +        d[H4(2)] = d2;
>> +        d[H4(3)] = d3;
> 
> The H macros here I think are wrong -- d is a float16 so we
> want H2(), and we need H4() macros for the n and m arrays.
> (I think in fact if you work it through then all the H macros
> cancel out and we could drop the lot, but since they're all
> acting on constant indexes there's no runtime cost and having
> them present is clearer for the reader.)

All correct, now fixed, thanks.


r~

