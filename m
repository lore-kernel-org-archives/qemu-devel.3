Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B6C1C02181
	for <qemu-devel@archiver.kernel.org>; Sun, 26 Jan 2025 04:03:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tbtrV-0001Me-7j; Sat, 25 Jan 2025 23:03:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1tbtrU-0001MP-18
 for qemu-devel@nongnu.org; Sat, 25 Jan 2025 23:03:04 -0500
Received: from mail-pl1-x62e.google.com ([2607:f8b0:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1tbtrS-0001ev-Im
 for qemu-devel@nongnu.org; Sat, 25 Jan 2025 23:03:03 -0500
Received: by mail-pl1-x62e.google.com with SMTP id
 d9443c01a7336-21631789fcdso58955275ad.1
 for <qemu-devel@nongnu.org>; Sat, 25 Jan 2025 20:03:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1737864181; x=1738468981;
 darn=nongnu.org; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=rlXAd1qPOHzbh/WdW2rkX5vHAatvrIrUCBoDhx8aIYI=;
 b=trbhjB9sdv23i95yY3pavSXZnl62xTYhSg91uvVkta+yZ//nsSayIwd6dXCgxdTRup
 RAIF7iQgy3qtj8PHzCKH1rDcEka1Q+jJ+Pj4DRso3LcbVXSZYsWPWzUtUAPeanLU7Pq+
 kgd98DnH6ynzvuLBiUNnEENuL3TWjP6oZq0zoru2fiEvq8DkAJG8JKiW+elICsJciq8p
 twLBbcBHdiDuXJAVUwez/gQdOSZ+OUXKGcQLnSEhshY2QiDoShpbgvp9PUuOU0LifEYh
 +jBPLpNKMhgwparXXPZnCzzgPIwrcFrJomoKla3Lo3qmOs8h9nLUUVrqGSpolnI7d8AL
 +QBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737864181; x=1738468981;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=rlXAd1qPOHzbh/WdW2rkX5vHAatvrIrUCBoDhx8aIYI=;
 b=Ln4GeO4Fdd35x32F3SDimR7+vT08avvGHMq/yobapyrSkB8/R6fYRRL4kiPggNicQy
 t67wKWf33wBzHa35RJLmSBMw9tokubvNOmIBWPkZ4LWWRX8CZaNwOkSwmN4rcleLbs7K
 zuNZ88GvKryTqgX5IV44gfjU0+d6eA+0dPAtba15fQKZbpOmVYeImB8gi70t7ZO/Bhqj
 LT6WUABfP96bC8yaffKTKbnpnioCKNjuhYRANGP3Uwc4dc9UUiEMHAZ6QjH3YKe+KaBR
 MpSgMhEbEsfZrb5zn2vZRSmOaFHGTS/gGqa28epEP1dtQ156oxXiZ7GK4Lp8+K7xaCUR
 CXYQ==
X-Gm-Message-State: AOJu0Yx7QWOPbk0si/XAhAIk6Jy+aC9uNSTHVUJLYNrJCivj0wZ4AlHd
 RY2ShnhdCEUp1svUvSQat6AQU6RiC2dYilUbXX181cK9D70mydkdhSAKy8qA6kc=
X-Gm-Gg: ASbGncvmtHmNbhR9POiYZDS6lBkKmqCEvf81+PlK2DVDah6oWj2NfgUtntc74r2BrW+
 PqehFXh+TROPYV/0HA2cHRXN4hHeU83MdFaalTts3+D1In2UyixL0tpwINta7nycnfDe0SudfEp
 Nd1oUyrqky6dYQXxxgL+wYhBH/Xa21wiiEVGmbFgXNBWwM08ZXYzffe+hXAqWqwTMgD1xUMXlKW
 WCyeOWqShVt/te7eW706UdVmQYLLw4Q2gEOjmhgwgdFAe/eyCq2H86gkdNZoIA1LjdhLz0bzSOS
 IUasih76OFuJCmQ=
X-Google-Smtp-Source: AGHT+IHP//wBUFqOiAMnWOWww+WNH7JYS9EeEf3Ipp/cZy2IgXsR9Rbt49bX4EYvZn/+5jRwKj+P3Q==
X-Received: by 2002:a05:6a21:6d9f:b0:1e1:ad90:dda6 with SMTP id
 adf61e73a8af0-1eb697c1bb0mr21999765637.20.1737864180838; 
 Sat, 25 Jan 2025 20:03:00 -0800 (PST)
Received: from [157.82.203.37] ([157.82.203.37])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-72f8a69fb30sm4524613b3a.32.2025.01.25.20.02.58
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 25 Jan 2025 20:03:00 -0800 (PST)
Message-ID: <609e75fd-0430-440c-acac-04eb3e1b29f4@daynix.com>
Date: Sun, 26 Jan 2025 13:02:57 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 3/4] audio: Add functions to initialize buffers
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Gerd Hoffmann <kraxel@redhat.com>,
 Christian Schoenebeck <qemu_oss@crudebyte.com>
Cc: qemu-devel@nongnu.org, devel@daynix.com,
 Phil Dennis-Jordan <phil@philjordan.eu>
References: <20250123-coreaudio-v5-0-6873df4215a0@daynix.com>
 <20250123-coreaudio-v5-3-6873df4215a0@daynix.com>
 <7a020e94-841a-4a3c-bdea-12c00579ef3f@linaro.org>
 <f62af9d4-36ae-45ea-8aa6-9139502da47e@daynix.com>
 <fbf13036-18b3-4aa5-b514-e6c8484ff33e@linaro.org>
Content-Language: en-US
From: Akihiko Odaki <akihiko.odaki@daynix.com>
In-Reply-To: <fbf13036-18b3-4aa5-b514-e6c8484ff33e@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62e;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pl1-x62e.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On 2025/01/26 3:25, Philippe Mathieu-Daudé wrote:
> On 24/1/25 05:58, Akihiko Odaki wrote:
>> On 2025/01/23 17:43, Philippe Mathieu-Daudé wrote:
>>> Hi Akihiko,
>>>
>>> On 23/1/25 08:18, Akihiko Odaki wrote:
>>>> These functions can be used to re-initialize buffers when hardware
>>>> parameters change due to device hotplug, for example.
>>>>
>>>> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
>>>> Reviewed-by: Phil Dennis-Jordan <phil@philjordan.eu>
>>>> Reviewed-by: Christian Schoenebeck <qemu_oss@crudebyte.com>
>>>> ---
>>>>   audio/audio_int.h |  2 ++
>>>>   audio/audio.c     | 24 ++++++++++++++++++------
>>>>   2 files changed, 20 insertions(+), 6 deletions(-)
>>>
>>>
>>>> index 
>>>> 87b4e9b6f2f356b6e5e972eabc100cf270fcbc29..17c6bbd0ae9e6ff810c0989dbfa1710ef674ff0a 100644
>>>> --- a/audio/audio.c
>>>> +++ b/audio/audio.c
>>>> @@ -1407,12 +1407,18 @@ void audio_run(AudioState *s, const char *msg)
>>>>   #endif
>>>>   }
>>>> +void audio_generic_initialize_buffer_in(HWVoiceIn *hw)
>>>> +{
>>>> +    g_free(hw->buf_emul);
>>>> +    hw->size_emul = hw->samples * hw->info.bytes_per_frame;
>>>> +    hw->buf_emul = g_malloc(hw->size_emul);
>>>
>>> What about using g_realloc()? Otherwise LGTM.
>>
>> g_realloc() will copy the content, which is not necessary here.
> 
> Oh I missed that! Maybe worth mentioning? Anyway, just nitpicking...
> 
> hw->size_emul = hw->samples * hw->info.bytes_per_frame;
> g_free(hw->buf_emul); /* Discard previous content, no need to realloc */
> hw->buf_emul = g_malloc(hw->size_emul);

I think we can just leave it as is. This function is named 
audio_generic_initialize_buffer_in() so it is not expected to keep the 
state.

