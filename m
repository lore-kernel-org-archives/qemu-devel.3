Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30591E7716A
	for <qemu-devel@archiver.kernel.org>; Sat, 14 Dec 2024 05:29:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tMKiW-0002Nz-BA; Sat, 14 Dec 2024 00:29:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tMKiS-0002Kb-RQ
 for qemu-devel@nongnu.org; Sat, 14 Dec 2024 00:29:25 -0500
Received: from mail-oa1-x31.google.com ([2001:4860:4864:20::31])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tMKiN-0005pO-R4
 for qemu-devel@nongnu.org; Sat, 14 Dec 2024 00:29:24 -0500
Received: by mail-oa1-x31.google.com with SMTP id
 586e51a60fabf-2a01707db44so760994fac.2
 for <qemu-devel@nongnu.org>; Fri, 13 Dec 2024 21:29:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734154158; x=1734758958; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=8oG/yalcRR7XO3lHQJ3AJpOqpRkooQKjQ5F+RmODWKk=;
 b=A23YUmz5SmBtuR+/5r3QI52mSruaFosK+YXTyD84EsHCx8a9w861nQUfEgmqsAis3T
 JBKlSn4IT+xKU/REU2LYJSuUR/y6cfuXXGT2feiCVJ4A43jAAVxWlHpZAwta7b8JoZIu
 2Mkc9PgoTbNDqnM9RPL2TuPV0p02VdLHx+dfOptwPnhHNsUEdtQtAv7250kC7XWzw4KL
 3xUnhC+BQRSXh+t6oQEbM3rcwXgfr4aMTBC1BXypw6U1BZ+EZAYALzbV7XU5kl2XC5XH
 P/IgzyLLBQqXd0erk6kh/bdCWR7ID/6oy0ipl8Ti2ZgjrGgq6MpvXO7MsCimyhXtX1wQ
 d2GA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734154158; x=1734758958;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=8oG/yalcRR7XO3lHQJ3AJpOqpRkooQKjQ5F+RmODWKk=;
 b=AlOLa7x5cpraSQv+FEMSIUS8Dg/D5xw2ZI+RtVwUjvSaQ/dHWhhcbRUTR7iql3NVZl
 xPrh0Q318x/JBuhGAID+CL9HMT1t4N33Y9gsgDuaO/O5zgVj2jpwbJSrHq6PZrCe5I2g
 b+Qs1WFgRFDFh7yBLSgGa7nt+QAIWw2dybO++6ITjvE216mMsH+8+2PQojRVB3/COYc8
 NFqqb0/RIGSq8jaiAko4Fk7CHfbBDyZKcIFlNFBG7G6y0gDIo6vFv7t2kf8elHS/sfGr
 47xr1vXmKOs8IZCP7vzQRFn6XhVj4eWhu7cmxNLvrRmhoLj5Y5/rqYP2024RtLveo6O7
 hL6Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCUj8DDxpB7bnC++PVWdYitSe+FAyk3PoUbTL/Q+ljdAZgbgsNRo+5+erIv9zG32iaRAj1wY7LEd2W38@nongnu.org
X-Gm-Message-State: AOJu0YxyabccxJcBWjWzn4qzKvpbjtnVewsC21cTO6JT4gnmpvDg7rYM
 X3R058NQ/f3XAazXlZVtv+4WNfL8A1oxQNnoto5yKehK8/qCNs78zrEMHroOc8ptKGdAEtQeJ9Y
 S5++GRO5t
X-Gm-Gg: ASbGnctlix53bSPrGGv8qNrezUvwwI3H567Q3yCvM45UcgzQlTR0zEARBjPsVljGmtX
 vSiJ0OUTN++NhC1ZwUUgKj3S4uRgg5Jik6TkHrekLgYSxG8yqrrg/HdBzdCCsA8Ga5l8KHB8dLu
 2Lwh0VtSST1mfnxhQoMVu2VyMHiYeEs4SNk6BhInq8Y+oPL/IYx50AF5kK295pj0bJ6fv5JXVJn
 w7mZeB3KnokKqF+rnPNw5F4QN5KEZ/deqVqMANQHnrHc4BleRbvdlLxfkO9gh9Hae/veHVOcIq/
 Qd5EKFmiiXZSJ3jRdizVJgb+3JT9Xly8pds=
X-Google-Smtp-Source: AGHT+IH/01gvYsnNW4ctMEdw8mcl26txGBB/kPP/XE3Txsoo91EImh1h4hPBxz/SkQEA8tAgjjzaNw==
X-Received: by 2002:a05:6870:f811:b0:29e:2bbd:51cb with SMTP id
 586e51a60fabf-2a3ac6b8b7dmr2565032fac.24.1734154157522; 
 Fri, 13 Dec 2024 21:29:17 -0800 (PST)
Received: from [192.168.4.112] (fixed-187-189-51-143.totalplay.net.
 [187.189.51.143]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-71e4836f8c2sm278124a34.34.2024.12.13.21.29.16
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 13 Dec 2024 21:29:16 -0800 (PST)
Message-ID: <03bf8242-8dd7-43ae-a0a5-3f304aa546bd@linaro.org>
Date: Fri, 13 Dec 2024 23:29:13 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: contrib/plugins does not build on 32-bit host
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 qemu-devel <qemu-devel@nongnu.org>, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>
References: <dbb6dbf1-1ceb-48c0-8174-ee5dea7533dc@linaro.org>
 <718f3f80-eb3b-4d9b-b2a0-24946a8c5b79@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <718f3f80-eb3b-4d9b-b2a0-24946a8c5b79@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2001:4860:4864:20::31;
 envelope-from=richard.henderson@linaro.org; helo=mail-oa1-x31.google.com
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

On 12/13/24 21:44, Pierrick Bouvier wrote:
> Hi Richard,
> 
> On 12/13/24 13:47, Richard Henderson wrote:
>> Hi,
>>
>> Several of the recent contrib/plugins/ patches do not build on e.g. arm32.
>> All of the issues are related to casting between pointers and uint64_t; there is a Werror
>> generated for casting between pointers and integers of different sizes.
>>
>> I suspect all of the instances will need to use separate structures to store uint64_t
>> within the hash tables.  The hash values themselves can use uintptr_t, as "hash" by
>> definition loses data.
>>
>> The following is *not* a suggested patch, just touches every place with an error to
>> highlight all of the places.
>>
> 
> This is something I already tried to fix this way, but alas, casting values is not enough, 
> we might lose information (in the case where guest is 64 bits). Some plugins need a 
> refactoring to allocate data dynamically, instead of hiding it under a pointer.
> 
> See this previous series:
> https://patchew.org/QEMU/20240814233645.944327-1-pierrick.bouvier@linaro.org/
> 
> Finally, we discussed it was not worth the effort, and Alex simply deactivated plugins by 
> default for 32 bits platform, so it should not be built for arm 32 bits. If we really have 
> someone that needs this usecase, we might make the effort, but for now, it does not seem 
> worth the hassle.

Hmm.  I didn't delete my 32-bit build tree, but it certainly re-configured.  If plugins 
are supposed to be disabled, something may be wrong there...


r~

