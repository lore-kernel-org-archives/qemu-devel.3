Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F81BC02181
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jan 2025 04:59:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tbBmh-00076z-Lj; Thu, 23 Jan 2025 23:59:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1tbBme-00076f-5e
 for qemu-devel@nongnu.org; Thu, 23 Jan 2025 23:59:08 -0500
Received: from mail-pl1-x62e.google.com ([2607:f8b0:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1tbBmb-00065N-1i
 for qemu-devel@nongnu.org; Thu, 23 Jan 2025 23:59:06 -0500
Received: by mail-pl1-x62e.google.com with SMTP id
 d9443c01a7336-216281bc30fso39943515ad.0
 for <qemu-devel@nongnu.org>; Thu, 23 Jan 2025 20:59:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1737694743; x=1738299543;
 darn=nongnu.org; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=/sKbSJbHIRm0Em0zuSISSBur10wxZnN3EvbQiCGthU8=;
 b=RLZZWQnbMTRaWOns5Xjeert/ktZ3EztyanS6f/4zxJkBJcKUJQ4I+92CMZ75sr+KG2
 hylqe2ZhOnaQHY+72ZtwEAUdsT70UPkyOrRlsfTXrV1o+CFrvXnYPxRJd3GlyREdi/TW
 bUXDgDcbGoQ7ZG6DOcbz+ss4Gz+8y1hFB1abRAhdaQDXYaH14g5khTS86R1LX7YgGBwI
 dKGXn2mBh4x/7mhcVI8GjfchJcmeOefohduzsU136GTmyLEoZb7YB+sXx7pm3cKYaH+H
 t0LPyeO9qo6v1zdDCXILC636UrF7+xUBEQq9HgfZaMxAXjPixv6qcidEqBAHpIeW0CuQ
 58IA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737694743; x=1738299543;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=/sKbSJbHIRm0Em0zuSISSBur10wxZnN3EvbQiCGthU8=;
 b=EmPvL4S56oVvutgKALTecD39fr6o9pUPpv258hjdBg6xA/lmkPn6MVc2SKwOO+AVjt
 hnrnim+sNrYeBgm07ek++kr7oF7BRnAjq15nEsOP5YicxbSwtJYKFdv73bwjHRxoWkJx
 0w0P+duL+C3Yv7qNtj0LzqAtZhmH8POs3SbUBQNZrFlfM3TI+v/GoZHUinw0zyAWG2zZ
 GAdwnCQA0y/0nSqqcSUG6tB4TfQ65BJSvl9lkj6NCuzIPmz6ZxrYj+LXtz6bLmaP9R4g
 eHN+hDKhnRSP2IyWP/+JYW6IGhEOgkjEPNG03XintMr9uXdU4rykKWCmkQOTg1qN9MAu
 s71g==
X-Gm-Message-State: AOJu0Yxo3PXy5m7qpaHiouoe5Fm45Jt5MrtbZkGDsJ0ONtUqfuSqj2LM
 5FbmXIaoFikq9vulvFaYxz9oAcOpAL1sv6CjALZld/dnl+/78EQil+X/W50yqD0=
X-Gm-Gg: ASbGncsWXuehUSuiSS+5cI6y0RrzO0E9X7w7GsUA3XdN/q2Sygw8Arb91/YTn/tn2LU
 lf4g/69aRqBzWlK8APL+on4Ad66QleYB2qt52WAo1ckCYkuTe/4JNItoyOTczYFkFwzOihDwGHp
 xcglshWesU4mAC0NnPSjfYqc9YFvKYjJshuc3WY2Q9z10900tDvCvYD1tKYmTKAxiWyOUr/S5wk
 DlhrDPxZK5Us+0RgQrLqkuWGs2FjCWlJyDMshb/ydtFn1LClbKuJw4weksxlHxPrAbC2cFaxkc3
 Hy/U5VY6agxS0GpNQg==
X-Google-Smtp-Source: AGHT+IGKoxWKKab4FiWGrWyIZsHZg8KKrgyICJISnrnGnKQq1rRp1CU7MKvSiu8CKu+tTqY+U3wDkg==
X-Received: by 2002:a05:6a21:7a8c:b0:1e1:bb23:dfd6 with SMTP id
 adf61e73a8af0-1eb215efe62mr43350929637.39.1737694743272; 
 Thu, 23 Jan 2025 20:59:03 -0800 (PST)
Received: from [157.82.207.107] ([157.82.207.107])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-ac49745c0b9sm728434a12.78.2025.01.23.20.59.01
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 23 Jan 2025 20:59:02 -0800 (PST)
Message-ID: <f62af9d4-36ae-45ea-8aa6-9139502da47e@daynix.com>
Date: Fri, 24 Jan 2025 13:58:59 +0900
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
Content-Language: en-US
From: Akihiko Odaki <akihiko.odaki@daynix.com>
In-Reply-To: <7a020e94-841a-4a3c-bdea-12c00579ef3f@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62e;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pl1-x62e.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

On 2025/01/23 17:43, Philippe Mathieu-Daudé wrote:
> Hi Akihiko,
> 
> On 23/1/25 08:18, Akihiko Odaki wrote:
>> These functions can be used to re-initialize buffers when hardware
>> parameters change due to device hotplug, for example.
>>
>> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
>> Reviewed-by: Phil Dennis-Jordan <phil@philjordan.eu>
>> Reviewed-by: Christian Schoenebeck <qemu_oss@crudebyte.com>
>> ---
>>   audio/audio_int.h |  2 ++
>>   audio/audio.c     | 24 ++++++++++++++++++------
>>   2 files changed, 20 insertions(+), 6 deletions(-)
> 
> 
>> index 
>> 87b4e9b6f2f356b6e5e972eabc100cf270fcbc29..17c6bbd0ae9e6ff810c0989dbfa1710ef674ff0a 100644
>> --- a/audio/audio.c
>> +++ b/audio/audio.c
>> @@ -1407,12 +1407,18 @@ void audio_run(AudioState *s, const char *msg)
>>   #endif
>>   }
>> +void audio_generic_initialize_buffer_in(HWVoiceIn *hw)
>> +{
>> +    g_free(hw->buf_emul);
>> +    hw->size_emul = hw->samples * hw->info.bytes_per_frame;
>> +    hw->buf_emul = g_malloc(hw->size_emul);
> 
> What about using g_realloc()? Otherwise LGTM.

g_realloc() will copy the content, which is not necessary here.

> 
>> +    hw->pos_emul = hw->pending_emul = 0;
>> +}
> 


