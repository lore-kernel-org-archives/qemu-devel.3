Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86E6EC71141
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Jun 2025 18:56:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uPQbd-0006VJ-Df; Wed, 11 Jun 2025 14:55:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uPQbN-0006P1-JP
 for qemu-devel@nongnu.org; Wed, 11 Jun 2025 14:55:11 -0400
Received: from mail-pg1-x52e.google.com ([2607:f8b0:4864:20::52e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uPQbK-0005RR-71
 for qemu-devel@nongnu.org; Wed, 11 Jun 2025 14:55:08 -0400
Received: by mail-pg1-x52e.google.com with SMTP id
 41be03b00d2f7-b2c384b2945so86846a12.0
 for <qemu-devel@nongnu.org>; Wed, 11 Jun 2025 11:55:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1749668102; x=1750272902; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=1r9iS/lg8OzGS/FnB/5jioJzOvmyA0kX4H5w38VtpDI=;
 b=xqZ7ZHoUCfUbWrxbyWOcTwy1tt5lGZxcnpx0kymrqhde8LLwoorg/k4oyD5FyZdokQ
 hV47WLCuA+bQaT7RehzF3MgVsuB9kGN7liwwq+T9NsDXSYPanWxKxAe3tnkdUII9h8TA
 GUITpWMZwvphD0Xz0V5Zj37rFBxJbjzLVcfvQ3OcR8wJMcHtGFHU1/BwPBM3LeRPmKu/
 yh7SscXtP+79TOVzlu/MwLL2Cz85NC0WSKdNQCazatyMeXDDMDaxDdF6Vb9dIgGzHDSs
 D3QbfZ79sDSoCpHVxXLFb1KBt4xx08XahtvcSgBRr1uUB2i1y+Lqxd2rFFNENe/BZ9+7
 T4Pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749668102; x=1750272902;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=1r9iS/lg8OzGS/FnB/5jioJzOvmyA0kX4H5w38VtpDI=;
 b=XEK2tvETidO1MT6y5g0pRWetqhmUQCH0FOqzwAqXhK8nzBe+x/VEMMU37+TVlyfbF2
 vcWkuIFIZWc2DaW8ca7NWz8ku2B/gG6UM8oV4bVC1InJaUSXYKHNMY1IcjJODu0SRXOD
 47CWcWaTuViz7UqoQSIltJJROY/DmFKpJQULY0DtGW18tK1wUSnB4EA70eSVq/dyuYpI
 ZxiHnz3/TtuHQn3R5tlvGb2xIpa38B9edUAVeRtbB11oXvys4nxkwvNaTX6jxEMekuH+
 NHKrFUNPfvinpk+8eZK0OPdQv1YaUcD5r/0N/l/lTNTNmuk39jSC8zha4ncegpf+Vjr3
 tPww==
X-Gm-Message-State: AOJu0Yz59Q1rXsMDJN6RbWozL2SBTqb7ea2Cp67z7AtGrIzO/fULBQR2
 7TgJJGh4mhGU6w39/qeDMjrLQ7k34aLflRfXfFMUrQB1mXdevw8c8kooaOB78RDGaIM=
X-Gm-Gg: ASbGncv8+08BGj4Dx8ruI67wi2q3mCodbm3NsJ+a7eZjkvX+tjjXRXacVxArQtjsU4m
 6u/Kl78PyjrRQvbOXSZcQ2gFhqexj5JD4dGdpr+cx9pTMUtSnRIZGFZQnOQXlbPaWH2rDkKqb5Q
 wDP9ZPKQJvvXOWJC3H71NGmtGacxZ/pgZj0k23ReW5LErx67eA86X9uQqbm9iYjGq7OmPYUhYZa
 SeEgVzGwc9mRQA/WwSubcWQAGzHGagtiMAW3E7dCBu0zw4xUH3qtPbX+NI+f/Sce36KplbftBB6
 dmRaZiKbeR8bh+PbLP3wzLgNBPbTeziVXQKJXtRHdFsHA3SDaUa3l+vacmsRAzz7vmRfIKXooEw
 =
X-Google-Smtp-Source: AGHT+IHp9rPHM5+5phYPrp7EyfN9Lg8vX7s/IWcWCIaGkx3hMTJvDKFhxx10FOhOPPhiXOMLF0LPOQ==
X-Received: by 2002:a05:6a21:32a1:b0:216:1476:f5c with SMTP id
 adf61e73a8af0-21f86727887mr7159305637.25.1749668102307; 
 Wed, 11 Jun 2025 11:55:02 -0700 (PDT)
Received: from [192.168.1.87] ([38.41.223.211])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7482b0ea2b2sm9525286b3a.161.2025.06.11.11.55.01
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 11 Jun 2025 11:55:01 -0700 (PDT)
Message-ID: <23b737f9-f8b6-437e-a59e-ecd8fec3819c@linaro.org>
Date: Wed, 11 Jun 2025 11:55:00 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] qemu/timer: introduce time dilation factor
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 "P. Berrange, Daniel" <berrange@redhat.com>,
 "Maydell, Peter" <peter.maydell@linaro.org>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Thomas Huth <thuth@redhat.com>
References: <20250610212829.2818792-1-pierrick.bouvier@linaro.org>
 <20250610212829.2818792-2-pierrick.bouvier@linaro.org>
 <CABgObfaNGO+hJtGWf=eBvurQqi4u3GmLUFsoa4dWVwk0iiA3PQ@mail.gmail.com>
Content-Language: en-US
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <CABgObfaNGO+hJtGWf=eBvurQqi4u3GmLUFsoa4dWVwk0iiA3PQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52e;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pg1-x52e.google.com
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

On 6/11/25 12:22 AM, Paolo Bonzini wrote:
> 
> 
> Il mar 10 giu 2025, 23:28 Pierrick Bouvier <pierrick.bouvier@linaro.org 
> <mailto:pierrick.bouvier@linaro.org>> ha scritto:
> 
>     This factor is applied to time spent since we read clock for the first
>     time. It impacts value returned by get_clock() and get_clock_realtime().
> 
> 
> Sounds like a good idea, however it needs a couple changes:
> 
> 1) different clocks have different starts, so the clock_start must be 
> stored per clock type
>

I was not sure if several clocks are used, so I'll simply use static in 
concerned functions.

> 2) dilation must be applied to timers too.
> 

 From what I saw, timers either use clock function (already dilated), or 
rely on cpu_get_host_ticks().
Do you suggest to dilate time returned by cpu_get_host_ticks(), or 
something different?

> As to the option, it's not immediately clear is <1 is a speed up or a 
> slow down. Maybe speed-factor=N is more clearly speeding up things if N>1?
> 
>     +    g_assert(now >= clock_start);
> 

You're right, it's not obvious.
I'm ok with speed-factor name.

> 
> The assertion is not needed, and can even fail in cases involving 
> daylight savings time; perhaps you can assert that the result is 
> positive instead?
> 
>     +    if (!clock_time_dilation) {
>     +        return now;
>     +    }
> 
> 
> Just initialize it to 1?
> 

For exactly the same reason you mention under, possible loss of 
precision. If my math is correct, we can only have a precision of 256 
nanoseconds at this epoch time.
Adding an intermediate cast solves this though, so we can have a default 
value of 1.

>     +    return clock_start + (now - clock_start) * clock_time_dilation;
> 
> 
> Please cast back to integer after multiplying. Adding back clock_start 
> in floating point format loses precision (doubles have only 53 bits of 
> precision; seconds use 32 of them if the base is 1970, and nanoseconds 
> don't have the 30 bits they need).
> 

I'll add the cast.

>     +}
>     +
>       /*
>        * Low level clock functions
>        */
>     @@ -811,11 +823,9 @@ static inline int64_t get_clock_realtime(void)
>           struct timeval tv;
> 
>           gettimeofday(&tv, NULL);
>     -    return tv.tv_sec * 1000000000LL + (tv.tv_usec * 1000);
>     +    return dilate_time(tv.tv_sec * 1000000000LL + (tv.tv_usec * 1000));
>       }
> 
>     -extern int64_t clock_start;
>     -
>       /* Warning: don't insert tracepoints into these functions, they are
>          also used by simpletrace backend and tracepoints would cause
>          an infinite recursion! */
>     @@ -826,7 +836,7 @@ static inline int64_t get_clock(void)
>       {
>           LARGE_INTEGER ti;
>           QueryPerformanceCounter(&ti);
>     -    return muldiv64(ti.QuadPart, NANOSECONDS_PER_SECOND, clock_freq);
>     +    dilate_time(muldiv64(ti.QuadPart, NANOSECONDS_PER_SECOND,
>     clock_freq));
> 
> 
> Missing "return".
>

Thanks, I caught this quickly after sending also.

> Paolo
> 
>       }
> 
>       #else
>     @@ -838,10 +848,10 @@ static inline int64_t get_clock(void)
>           if (use_rt_clock) {
>               struct timespec ts;
>               clock_gettime(CLOCK_MONOTONIC, &ts);
>     -        return ts.tv_sec * 1000000000LL + ts.tv_nsec;
>     +        return dilate_time(ts.tv_sec * 1000000000LL + ts.tv_nsec);
>           } else {
>               /* XXX: using gettimeofday leads to problems if the date
>     -           changes, so it should be avoided. */
>     +           changes, so it should be avoided. Time is already
>     dilated. */
>               return get_clock_realtime();
>           }
>       }
>     diff --git a/util/qemu-timer-common.c b/util/qemu-timer-common.c
>     index cc1326f7264..d8895aaccad 100644
>     --- a/util/qemu-timer-common.c
>     +++ b/util/qemu-timer-common.c
>     @@ -28,6 +28,7 @@
>       /* real time host monotonic timer */
> 
>       int64_t clock_start;
>     +double clock_time_dilation;
> 
>       #ifdef _WIN32
> 
>     -- 
>     2.47.2
> 

Thanks,
Pierrick

