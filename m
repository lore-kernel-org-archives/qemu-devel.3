Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8449D1D892
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Dec 2025 08:31:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vR4jt-0001T1-Gv; Thu, 04 Dec 2025 03:31:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vR4jr-0001Sh-Jb
 for qemu-devel@nongnu.org; Thu, 04 Dec 2025 03:30:59 -0500
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vR4jo-00023Y-GI
 for qemu-devel@nongnu.org; Thu, 04 Dec 2025 03:30:58 -0500
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-42e2e77f519so519442f8f.2
 for <qemu-devel@nongnu.org>; Thu, 04 Dec 2025 00:30:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1764837052; x=1765441852; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=S184QNFPKqWa2rtm1nZBrfNCABED9JDrO5vXJ/hKN7o=;
 b=oT+TAoOD3HnimFKKRSpKd+lDX5BtA/jCtfkzVIodFqDBNVmmwBMDBoOlLho81V/KlJ
 KzLZUY7js9PN+GCSb658Q8l9UHcyFCh9z3RqXf11zY9PLu2leGjPWvZS5cNc0jJGcDpC
 Dh1McvYaywFlxW3AZs8EBXfp7VfciWiO7QqLOMse9rKENTZQdnTyfE+1ZXMDG0tW7kdH
 nxYqNTq0bN8z/5wFk/AwzB+vZY84ApW8JvUUZtOCdfLHFb9JNv7NJuGGcZaZoiT4g0bf
 ak56tuXbUlKfLxN5xzz3ZXBtfKD8qKlkSRVKNwny0txb2VWgtEYPWAZNS+aYBdUOmKQu
 4u8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764837052; x=1765441852;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=S184QNFPKqWa2rtm1nZBrfNCABED9JDrO5vXJ/hKN7o=;
 b=UnKuF4XnG53bpkyG8NEP3MYkpOJDZrN3InBvtGsR5Z+egVV7mpyTKs1M8tjLIsXkWj
 oN4fE11hUcqo1wjgsLwePAVI68iq10L/fWJi0SpT6GS5OozDz8yKHocmdMizvEAfU19l
 ZFswmXlf1bzbIynOCmAgMr4mcJ1ZjHIS+WC6C1VfAu+2BBLoFxhd9EPHkIhY321LW6vh
 FE5/3rR2sFPAitGcmSnLU8w0GNhHjJ017OPxMzuv1DWBvBAavxPEwwpYXqzN/qHyk4JA
 ZWYQPnB1WVGSBwRx4cLJk17EA9asYZC3DX2rk6o2yKq5Mh1G8ey9ttK6xV+JbPmMe0Uj
 avaQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUKQeSq2bu8jZ9snHvjV7Zt/ZISGempox90s8bwUZVQ/lpOAbbZBYJCK6XDa0LwHsLtFegOCHkf/pyd@nongnu.org
X-Gm-Message-State: AOJu0YzKCiQ5Pz1/712160k2y0bMR4Kk4wkUBNyQQriw2BLY/0Cfeu5Q
 9i21EcvU9+YqAFeRyrO7NF/BkU+uOnIYkXCvRcUYZ98AbSaDKfVUsQK/b/m004vI60U=
X-Gm-Gg: ASbGnct7bhYpWIsJ6W4bmwoamIGFDnSQoGOvJKKvEpRJX3AsdvjOEyuNM8lmraVFt6Y
 1+/PWQsfPDR5OxiOZfSLl3WAbMkFiJcI4FWOjVwQRouSsmqq2kImlN/zatoHNHdLOPV1cwJm0Ap
 gSpABnMlhXo+6pI5u2cJgXj0LenKa8YXZpYXvSYyfoeKYXW6DDGmpkh/ZiMuPc54jJrc5Mz2xFf
 VG+8kTJuKfJN6ue0RKElriOb0vcNKPV2vzCSDdspGDao6IRWcCrWQGpXrEqtWcA44fIiH1wmuPi
 xqwOgldU2j0GrF8uUw5OuVfp1kAj4dUfM5+v6yvqX+jREfU3wZuBgDs9plwASfgvzhHY0PNnTiH
 lri/Q7YjMVvtVHOlLJ0ZFQUC14+yDjE4T9pv72OKtPfibBWnAt4vThh9Ld2Wcy6J+kNha5WsPHs
 BTtQswGaP9zRDsanxUZfS4fwXTLnAG218zulRX5uljX/ff7wtZqnEZRg==
X-Google-Smtp-Source: AGHT+IGU2ZP5moJmbvdFzxv3QW1rrP7fJIE7ACdHg3f4v5ZH4BsXjrN6JjbeQzhZT5hEAFbJDAJeNA==
X-Received: by 2002:a05:6000:4013:b0:42b:40df:2338 with SMTP id
 ffacd0b85a97d-42f7986236bmr1943301f8f.52.1764837052124; 
 Thu, 04 Dec 2025 00:30:52 -0800 (PST)
Received: from [192.168.69.213] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-42f7d222506sm2170813f8f.28.2025.12.04.00.30.50
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 04 Dec 2025 00:30:51 -0800 (PST)
Message-ID: <bc6babb4-9cc0-46dc-af77-d182575b72a9@linaro.org>
Date: Thu, 4 Dec 2025 09:30:50 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] error-report: move real_time_iso8601() to header
Content-Language: en-US
To: Markus Armbruster <armbru@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Cc: marcandre.lureau@redhat.com, pbonzini@redhat.com, eblake@redhat.com,
 berrange@redhat.com, yc-core@yandex-team.ru, d-tatianin@yandex-team.ru,
 qemu-devel@nongnu.org
References: <20251128200536.207344-1-vsementsov@yandex-team.ru>
 <20251128200536.207344-3-vsementsov@yandex-team.ru>
 <87h5u7odkh.fsf@pond.sub.org>
 <69a68b6b-0bd6-4295-930f-bd9486c732f4@yandex-team.ru>
 <87zf7yll7g.fsf@pond.sub.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <87zf7yll7g.fsf@pond.sub.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42c;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42c.google.com
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

Hi,

On 4/12/25 09:12, Markus Armbruster wrote:
> Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru> writes:
> 
>> On 03.12.25 17:16, Markus Armbruster wrote:
>>> Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru> writes:
>>>
>>>> To be reused in the following commit.
>>>>
>>>> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
>>>> ---
>>>>    include/qemu/error-report.h | 6 ++++++
>>>>    util/error-report.c         | 7 -------
>>>>    2 files changed, 6 insertions(+), 7 deletions(-)
>>>>
>>>> diff --git a/include/qemu/error-report.h b/include/qemu/error-report.h
>>>> index 3ae2357fda..412b705898 100644
>>>> --- a/include/qemu/error-report.h
>>>> +++ b/include/qemu/error-report.h
>>>> @@ -74,4 +74,10 @@ extern bool message_with_timestamp;
>>>>    extern bool error_with_guestname;
>>>>    extern const char *error_guest_name;
>>>>    
>>>> +static inline char *real_time_iso8601(void)
>>>> +{
>>>> +    g_autoptr(GDateTime) dt = g_date_time_new_now_utc();
>>>> +    return g_date_time_format_iso8601(dt);
>>>> +}
>>>> +
>>>>    #endif
>>>
>>> Reasons for inline?  Because the function is so small?
>>
>> Yes, seems, just this.
> 
> I'd prefer not to.
> 
> Actually, I'd be tempted to just duplicate the two calls and call it a
> day.  Up to you.

We now prefer to let the toolchain LTO do its clever job.
Better avoid duplication. To enforce this style, lets expose
the declaration with a @docstring, and keep the definition in util/.
My 2 cents.

> 
>>>> diff --git a/util/error-report.c b/util/error-report.c
>>>> index 1b17c11de1..20618640e8 100644
>>>> --- a/util/error-report.c
>>>> +++ b/util/error-report.c
>>>> @@ -169,13 +169,6 @@ static void print_loc(void)
>>>>        }
>>>>    }
>>>>    
>>>> -static char *
>>>> -real_time_iso8601(void)
>>>> -{
>>>> -    g_autoptr(GDateTime) dt = g_date_time_new_now_utc();
>>>> -    return g_date_time_format_iso8601(dt);
>>>> -}

