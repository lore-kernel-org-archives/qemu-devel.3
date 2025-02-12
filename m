Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA5BDC02198
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Feb 2025 15:47:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tiExR-0001l1-41; Wed, 12 Feb 2025 10:47:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tiEx6-0001bU-N6
 for qemu-devel@nongnu.org; Wed, 12 Feb 2025 10:47:06 -0500
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tiEx4-0007ar-KE
 for qemu-devel@nongnu.org; Wed, 12 Feb 2025 10:47:04 -0500
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-38dd93ace00so2261539f8f.1
 for <qemu-devel@nongnu.org>; Wed, 12 Feb 2025 07:47:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1739375220; x=1739980020; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=pB0ENgpOF4siqf9ei8VqVtgbIqocpNRNnEMWdlRCBq0=;
 b=hD72kEPyHIEtkef5eXoXRT9qENl3Msw7R2zSHaJz91Z2dlPP4WzdKZYty7xKPpr+0Y
 EAOytNbITZoTFd67pCbG4ZrP6dv5xKCEa+rvpgLRsOgkogQQFIsBSE+Fu61ESEXzKQUM
 AkZm8Pu2l8Ft660Z6IfsuBDJhSzvd6hdTTC8bY00AN9JKOYhrq/eMTIZTf0eM96k0lcr
 09OhHvrfqGTrYNDQDvIZHgDYCQ84EOguTD3hulD9iTHRFWLj9KdkubKT2a5WeO0duKaW
 6ei4A7zKSJOJ+udHs3/Vr+J7WQaBY1mlnf5ZOBHCMYL1540FEqFueQ9WH+AKEILXOVof
 8IZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739375220; x=1739980020;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=pB0ENgpOF4siqf9ei8VqVtgbIqocpNRNnEMWdlRCBq0=;
 b=h4oeFyMcc90L68Jma+5o0ilanBGd5OaAvGWreF7vWsI8ODLtFpxwfoTKBU4pdNNa4x
 t6DzyZ0/NqKX1/TvDmn7T22sVwmFsOFtDMhcw+hT9wY2a1to708Q99bIqpslgzVw2jVR
 58RlRpP6YFeIRRUc7LvSIqU+D00QfF+Jp3GZpTdKAV3vOrgQncDR9q4+zNSBoRAsUAoi
 qNb3LpGavY5teJMytsO07soK2jUS6/bIcFmG/MW7MnIxzwEc4UCx226164kW+cpd8Gzi
 ekqxb9wae2PbAJNPGkrLoCd5f4V8jQgFukFlOqA5RAix16tXDFkoVBRCUSD6vhC4V7IO
 tcNg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXw7/aUzGoVSs51Ot/8TehDv7VhQ3uaHzJzpIMS4532NjRryRLtrObqUodTLyqbdOT9fsJWSN+wf8hL@nongnu.org
X-Gm-Message-State: AOJu0YzbuafHmKEbJNjx1nr/+JLdlelD55lWSVaaYtEkMKbmEs8H7ZhE
 Xv+jZBSzHdWLwJLxydAmfLr/xWNTb85Q034/pDVwxCvQItnYvdoIgXpOxft8TmY=
X-Gm-Gg: ASbGncumsdVddK7YWQILmS4N0S5k4/dWemBUmWQqys9YMUvV+o898RrfoG8QXBEHO38
 Iff8Rtw3teIz/UDeTCkGrMyRTNfFYWBtY93irR/gweiTQtc0wZI4VyZKQ/OBhtjFZQGMScJ0hOc
 Ssvw1bWY8D40PDc8/5eVBsFrnCg5F61POiF9WRgpb1ons+5ZXaK3qAYQG3HxVRnXv7O5XtPAqsV
 izZ6x+oIuVb9o3HQuR2c+e+AobMepcqnHQfT2t5WaZtd25T1KfCRAIvBwO9yihslmSFB8hBuqVp
 /A2g0pKvXhbSmvFLy//fRLT9qe3WUM+LLEzno1rGz2U6wieuCPawWUtkbs2U1Uak
X-Google-Smtp-Source: AGHT+IERldz8YocYKmHRq+Ospp2qa8WC2w5veJCIg6lfPEnDRRWX+F32EJI2vss8JkCCYR+ds8Iuzw==
X-Received: by 2002:adf:f48a:0:b0:386:4a24:18f2 with SMTP id
 ffacd0b85a97d-38dea28b50amr2857832f8f.25.1739375219792; 
 Wed, 12 Feb 2025 07:46:59 -0800 (PST)
Received: from [192.168.69.196] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38dc6b89ef5sm16043769f8f.31.2025.02.12.07.46.58
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 12 Feb 2025 07:46:58 -0800 (PST)
Message-ID: <4badc66e-ef82-4b19-b8b9-1ce2d2fe3c90@linaro.org>
Date: Wed, 12 Feb 2025 16:46:58 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 1/4] os: add an ability to lock memory on_fault
To: Peter Xu <peterx@redhat.com>, Daniil Tatianin <d-tatianin@yandex-team.ru>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Stefan Weil <sw@weilnetz.de>,
 Fabiano Rosas <farosas@suse.de>, Peter Maydell <peter.maydell@linaro.org>,
 qemu-devel@nongnu.org
References: <20250212143920.1269754-1-d-tatianin@yandex-team.ru>
 <20250212143920.1269754-2-d-tatianin@yandex-team.ru>
 <Z6y81mXn7yaXy63A@x1.local>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <Z6y81mXn7yaXy63A@x1.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42b;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42b.google.com
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

On 12/2/25 16:23, Peter Xu wrote:
> On Wed, Feb 12, 2025 at 05:39:17PM +0300, Daniil Tatianin wrote:
>> This will be used in the following commits to make it possible to only
>> lock memory on fault instead of right away.
>>
>> Signed-off-by: Daniil Tatianin <d-tatianin@yandex-team.ru>
>> ---
>>   include/system/os-posix.h |  2 +-
>>   include/system/os-win32.h |  3 ++-
>>   meson.build               |  6 ++++++
>>   migration/postcopy-ram.c  |  2 +-
>>   os-posix.c                | 14 ++++++++++++--
>>   system/vl.c               |  2 +-
>>   6 files changed, 23 insertions(+), 6 deletions(-)


>> diff --git a/os-posix.c b/os-posix.c
>> index 9cce55ff2f..17b144c0a2 100644
>> --- a/os-posix.c
>> +++ b/os-posix.c
>> @@ -327,18 +327,28 @@ void os_set_line_buffering(void)
>>       setvbuf(stdout, NULL, _IOLBF, 0);
>>   }
>>   
>> -int os_mlock(void)
>> +int os_mlock(bool on_fault)
>>   {
>>   #ifdef HAVE_MLOCKALL
>>       int ret = 0;
>> +    int flags = MCL_CURRENT | MCL_FUTURE;
>>   
>> -    ret = mlockall(MCL_CURRENT | MCL_FUTURE);
>> +#ifdef HAVE_MLOCK_ONFAULT
>> +    if (on_fault) {
>> +        flags |= MCL_ONFAULT;
>> +    }
>> +#else
>> +    (void)on_fault;
>> +#endif
> 
> IIUC we should fail this when not supported.
> 
> Would you mind I squash this in?
> 
> diff --git a/os-posix.c b/os-posix.c
> index 17b144c0a2..52925c23d3 100644
> --- a/os-posix.c
> +++ b/os-posix.c
> @@ -333,13 +333,14 @@ int os_mlock(bool on_fault)
>       int ret = 0;
>       int flags = MCL_CURRENT | MCL_FUTURE;
>   
> -#ifdef HAVE_MLOCK_ONFAULT
>       if (on_fault) {
> +#ifdef HAVE_MLOCK_ONFAULT
>           flags |= MCL_ONFAULT;
> -    }
>   #else
> -    (void)on_fault;
> +        error_report("mlockall: on_fault not supported");
> +        return -EINVAL;

Good point!

>   #endif
> +    }
>   
>       ret = mlockall(flags);
>       if (ret < 0) {


