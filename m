Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38615C3ABBE
	for <qemu-devel@archiver.kernel.org>; Tue,  6 May 2025 08:24:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uCDbA-0003iR-Gh; Tue, 06 May 2025 04:24:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uCDb6-0003hq-Rb
 for qemu-devel@nongnu.org; Tue, 06 May 2025 04:24:16 -0400
Received: from mail-ej1-x62f.google.com ([2a00:1450:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uCDb4-0003sI-S2
 for qemu-devel@nongnu.org; Tue, 06 May 2025 04:24:16 -0400
Received: by mail-ej1-x62f.google.com with SMTP id
 a640c23a62f3a-ac345bd8e13so876566466b.0
 for <qemu-devel@nongnu.org>; Tue, 06 May 2025 01:24:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746519852; x=1747124652; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=cq0N3criJDHU7BSJNCvrvSttnQ51DU8aN7mRbORYFks=;
 b=fGL7T5d+p0FO54n7tOULzrejUuYGM3uqCeODQ3GfK02R5rHHm4KA7ABtesV1fW3r2K
 wcqfEyDaCM9hr0sAzhX5MQmFQ9Q8EQUUGtbQPolY61enuLRzOsrar1e0AvC+vnJjSNm8
 Xg3V949LUMnN0GTnWTU7Vpe0+v5GWP5FU1/L0rBXDepV2hpTRCpVV24HAHAVdl7CakhU
 28C4V8BlQtMKwyWofLa3X7BYtlJ7/JS08ThNtrXEYqccGPkhUxEPwURhIpPng8cHZRJA
 eo0Uhc/nlj+tuoviu+PtzyvSp5vHnUhpMA+wwaV/39QV5ASv0peNLAkDJF0VlhrDZkuK
 1hgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746519853; x=1747124653;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=cq0N3criJDHU7BSJNCvrvSttnQ51DU8aN7mRbORYFks=;
 b=aT0HhVdRvk4VxQgzi+f8jc3Bu488/ELRFKcajws7ppz1QaNTZ8ZV1Ik/J5hLWwDtTZ
 hCc5LOiLPnJBj3jfpeVOX3Q9VsgSR0N+O4B/F0yanxVZGu19k6BpakKZoZcIWNtxygvT
 P+7nVZQQcvPioL56UrG8+QzY7tZpIdmRc4naIFavQk1Bz/7QYV2FfKna75EOdCBYMZ6m
 +5Y+DcDEQ4/acSY19ESCR0Zk253xdk/TVLRMbs0lwqgkrfwJtk7OCxo0kMiFoA32vq3U
 wm8EVcEMA5PbdpK5akDQcp2kzLtMgauMHcszjU1cX1WuyVywJb+6+UAeJaefWNPaAL4X
 z3fg==
X-Forwarded-Encrypted: i=1;
 AJvYcCX5gBxqtMZZLnOPkEk3dSUPTDE0PE2N5UGA2RJ6pp1fTxkFgNIMKYovlQ8Oz3wRBg21rsM/Frft9wZA@nongnu.org
X-Gm-Message-State: AOJu0YwOo/txpSmruGVOooZyzq5Rkxqk0CVsRcauJN8TRfB3KjT/GksS
 5GJ8rTgwAwOf5IjOH6TW8AwMy38HboXTKGZvwp0xByemPutmf8nU0y1F0uch5N0=
X-Gm-Gg: ASbGncsHguGxmGTx0SfaqNb5/4QEdwgR0trfDNU6nO8rZsSoA1i9J/9TFHegc3Cqy1B
 AhStIct7ObXphGk+bt7Eva3f64CmL9ImCqaqVWjlWl0uAFGcEaHB3lhHGKHvo2AqroWlRpQy5oL
 OpLSHiCaQv7teVbgXhahLyHiJ/Em4ICK2QZoSKk9cDsg1TKspgysumU5ZRqCcMWFjWUWq3uw/dh
 nFoRExDfkUc5unSItjOO1pdRK/OamZI1x5RXCME2UJBUt46LhnEjtpyt3WPiGA/wAWuUug+ynxi
 yEFKe05F/BGlv52gB74pQzGZ6HPGAjcbul+C9IpblVzvBjZ+RdjgjrRD8dQYlEx+wf0wvBVhzTi
 q+3Y=
X-Google-Smtp-Source: AGHT+IGt5txLqLtSp3+cU2gSSgyJlnUvTSYiBCOBY+5W/7nbeKOqVAo/CFoPl+08CP9SDWM0WurRpw==
X-Received: by 2002:a17:907:7fa2:b0:ac6:d142:2c64 with SMTP id
 a640c23a62f3a-ad1d454e258mr210203366b.18.1746519852598; 
 Tue, 06 May 2025 01:24:12 -0700 (PDT)
Received: from [10.194.152.213] (238.21.205.77.rev.sfr.net. [77.205.21.238])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ad1891478fasm655909466b.26.2025.05.06.01.24.11
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 06 May 2025 01:24:11 -0700 (PDT)
Message-ID: <56396829-cd35-4a96-bc7b-321eb01b91e4@linaro.org>
Date: Tue, 6 May 2025 10:24:10 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] bsd-user: add option to enable plugins
To: Warner Losh <imp@bsdimp.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Cc: Kyle Evans <kevans@freebsd.org>, qemu-devel@nongnu.org,
 richard.henderson@linaro.org, alex.bennee@linaro.org
References: <20250331234228.3475706-1-pierrick.bouvier@linaro.org>
 <0a39e805-eb75-4b88-b316-189acad38efa@linaro.org>
 <a7cc7e54-b84d-44e1-8c75-df39b44dd28f@FreeBSD.org>
 <0a765d57-0c9a-4732-b560-203f03f903e9@linaro.org>
 <CANCZdfpg6JEbDx3dJvCcdQNexcjW+zBYzjhrmtDDLJC8rm7meQ@mail.gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <CANCZdfpg6JEbDx3dJvCcdQNexcjW+zBYzjhrmtDDLJC8rm7meQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62f;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x62f.google.com
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

On 6/5/25 02:25, Warner Losh wrote:
> I'm also ignorant of plugins, but (a) if not enabling plugins is a nop
> and (b) plugins either work or fail completely, then I think we can
> enable them. If they cause problems when not enabled by the user,
> though, we'll likely have to revert.

Elsewhere in this thread Pierrick mentioned:

"... system mode, which runs on BSD ... already has plugins enabled."

> 
> I don't know enough about them, though, to review.
> 
> Warner
> 
> On Mon, May 5, 2025 at 12:38 PM Pierrick Bouvier
> <pierrick.bouvier@linaro.org> wrote:
>>
>> On 4/28/25 3:57 PM, Kyle Evans wrote:
>>> On 4/28/25 14:36, Pierrick Bouvier wrote:
>>>> On 3/31/25 4:42 PM, Pierrick Bouvier wrote:
>>>>> Nothing prevent plugins to be enabled on this platform for user
>>>>> binaries, only the option in the driver is missing.
>>>>>
>>>>> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
>>>>> ---
>>>>>     bsd-user/main.c | 12 ++++++++++++
>>>>>     1 file changed, 12 insertions(+)


