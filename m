Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6935110BA434
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Mar 2026 23:38:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w6GkD-0002XB-1d; Fri, 27 Mar 2026 19:37:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1w6GkC-0002Ws-5b
 for qemu-devel@nongnu.org; Fri, 27 Mar 2026 19:37:36 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1w6GkA-0000Bt-DP
 for qemu-devel@nongnu.org; Fri, 27 Mar 2026 19:37:35 -0400
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-482f454be5bso34633765e9.0
 for <qemu-devel@nongnu.org>; Fri, 27 Mar 2026 16:37:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1774654652; x=1775259452; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=GPh5zuELW3Gv9po5dSTAKCbMAwXteQzdQsFJR1HQki0=;
 b=N37ybUsN9lihTSnjHqsPfkWoOPS6jUin7EArA8LtgbT6GomhrCfhNjcm/Z2twNhu0i
 kihE2a8OO8pcYRc7+Rpixu3iVCck/ymz2FxgpVPysBpS0TFpZAJ16K5AlULzEUoxeoVW
 VJCbi577u2xa+9w+PY49/93XE2SH3Tg2rYtNaqok1Ib8WXZApXNQfLRTLfOu8sqonjbA
 wl7a71fWSBclRIQJMxkOZ0x18uUTYU2b8YsAKkyR8lQxHI1xEghrg9sq80S80qvPTK4T
 v/ZU9rl0HuoblArTtrjvBdpP6uPCBGx1Oz9oCVJUnZPl+YPmO6lXQU6QTboRdN0Iv+Xg
 0pCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774654652; x=1775259452;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=GPh5zuELW3Gv9po5dSTAKCbMAwXteQzdQsFJR1HQki0=;
 b=iT+3knSoUUuPJ2ey0oagaxxlwRYoNwidXy8lesKbCD9MG/CyDxPx1QX6S+IEtaJsLC
 UhYVwgfK2sUsaqcjZ8jfp2dl2RpTNPmYOhjnmkQkctkkcE2JYx296fV9PyRiqCS+z45z
 DVLR8KTky+1JY3YrUb9duhWuNGTVD+G6midFscMBRsbVy2rfJO/xAChih981ubMai27j
 iOEoff6ErZqoFSJ2vPbi3jDmd8zFD0GTo4FDw9mIBh3793r1sPQCyerHaBmoEibi4Chp
 e4Ry77TRKhcFsbkcG5ya67sXj6JWMl3A7VVtdckhUU0kqAS2m14Pr9WgjQegfy6yT+14
 /v2A==
X-Forwarded-Encrypted: i=1;
 AJvYcCUz8vDubqd8nS8E/KtnoRCohy/CS7RrYIeDlQ2KDPMfDSm29tlWsJkH89rOD3cB1eHT1rgTjzV2dM/h@nongnu.org
X-Gm-Message-State: AOJu0Yw3kcn04FMjEQi5g+6gK4UHSrTbs5sEreqOGC1EMK6uS82qGshv
 HXka+mx2BhcSQ6i0h+/sk5OEUmrb6FGB7NyP0a1sK+F4ojNwJaR67RtD6r8+bVUNJgk=
X-Gm-Gg: ATEYQzw4uda0/sQIyPBCiDExrJhWx3tZ5HQl4XwRruh2SwNX2majLaKyAyWmfMVkwGj
 OSkkPCC2c1WCcOdMGgyLkVQDgOWy11Nycu33xXLDiVt1sVBmH5VZKvpYAcHHCRiqpS/S81XaSBb
 IqMwXOQ4OKbjmSALXeOupzhBeMde82qOZnxpvYiKlJMuFvUhV4XiPjliFUw68a8q1bFy0hS3sVo
 aJfwJI3Eo7y8JdaOIU9NY6ImC3jwqDf5Q0Da02RBE6w27PHJzHykh4mUO1zD2UMlFbeFSOKMuPe
 f6NPG1KAWvj++CmLVdHpHIZ6zlVLAK/G4HjDdD1ZUMGfdXRdyD1qrRO0lm9qeXb/6BYaZaLBFCb
 dL6g8CjM9P8JR2SdgP4DJdv+h3mQiZZyVUewLH9ZuY0iow1N9FQwCGUhvA1crr7zsr99u5zmIcV
 nQqbLNschNACyY6fDeqbMgfMhOEM+OPUyiJ1DimvWte1FZ9LLMfM793S2/bv/0pg==
X-Received: by 2002:a05:600c:638e:b0:485:3c09:843 with SMTP id
 5b1f17b1804b1-48722be44b4mr135336735e9.9.1774654652271; 
 Fri, 27 Mar 2026 16:37:32 -0700 (PDT)
Received: from [10.202.147.66] (147.149.216.82.rev.sfr.net. [82.216.149.147])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43cf2570b18sm1347590f8f.31.2026.03.27.16.37.30
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 27 Mar 2026 16:37:31 -0700 (PDT)
Message-ID: <01eb4b4a-b77f-421c-8ff8-bbd061482c8d@linaro.org>
Date: Sat, 28 Mar 2026 00:37:29 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/5] hw/tpm: Remove instance @ppi_enabled field
Content-Language: en-US
To: Stefan Berger <stefanb@linux.ibm.com>, qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, Thomas Huth <thuth@redhat.com>,
 Stefan Berger <stefanb@linux.vnet.ibm.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Ani Sinha <anisinha@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>
References: <20260317120241.16320-1-philmd@linaro.org>
 <70bd2f29-9f33-43e0-897f-52f0b2af111f@linaro.org>
 <ece64b0e-7f05-43de-b326-38788a9abe8b@linux.ibm.com>
 <2c06e37f-477a-49d6-a65b-fd826fcdc5b2@linux.ibm.com>
 <184a1a43-d41b-4b23-bc53-768a12631884@linux.ibm.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <184a1a43-d41b-4b23-bc53-768a12631884@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32b.google.com
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

On 27/3/26 19:17, Stefan Berger wrote:
> 
> 
> On 3/27/26 11:21 AM, Stefan Berger wrote:
>>
>>
>> On 3/27/26 11:18 AM, Stefan Berger wrote:
>>>
>>>
>>> On 3/23/26 5:56 AM, Philippe Mathieu-Daudé wrote:
>>>> On 17/3/26 13:02, Philippe Mathieu-Daudé wrote:
>>>>
>>>>> Philippe Mathieu-Daudé (5):
>>>>>    hw/tpm: Factor tpm_ppi_enabled() out
>>>>>    hw/tpm: Add TPMIfClass::ppi_enabled field
>>>>>    hw/tpm: Remove CRBState::ppi_enabled field
>>>>>    hw/tpm: Propagate @ppi_enabled to tpm_tis_reset() and remove in
>>>>>      TPMState
>>>>>    hw/tpm: Simplify tpm_ppi_enabled()
>>>>
>>>> Series queued for 11.1 (typo fixed), thanks.
>>>>
>>>
>>> Here's another TPM PPI related series. It would make sense to 
>>> upstream them together. Do you want to queue that one as well?
>>>
>>> https://lore.kernel.org/qemu-devel/20260327-tpm-tis-sysbus-ppi-v2-0- 
>>> d8ec84d25dbc@redhat.com/T/#t
>>>
>>
>> Actually, they will have to rebase on this series first...
>>>
>>
> 
> v3 is good now:
> 
> https://lore.kernel.org/qemu-devel/20260327173209.148180-1- 
> mbawa@redhat.com/T/#t
> 
> If you want to take it let me know, otherwise I will have to wait for 
> your series.

Thanks for the head up, I'll queue it along and send the pull
request after 11.0 is released.

Regards,

Phil.

