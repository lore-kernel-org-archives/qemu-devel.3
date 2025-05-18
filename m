Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86090C3ABD8
	for <qemu-devel@archiver.kernel.org>; Sun, 18 May 2025 04:57:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uGW4u-0004Ij-2V; Sun, 18 May 2025 00:56:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1uGW4r-0004Hw-8f
 for qemu-devel@nongnu.org; Sun, 18 May 2025 00:56:45 -0400
Received: from mail-pf1-x42d.google.com ([2607:f8b0:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1uGW4p-0003fL-1A
 for qemu-devel@nongnu.org; Sun, 18 May 2025 00:56:44 -0400
Received: by mail-pf1-x42d.google.com with SMTP id
 d2e1a72fcca58-742b614581dso1687837b3a.3
 for <qemu-devel@nongnu.org>; Sat, 17 May 2025 21:56:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1747544201; x=1748149001;
 darn=nongnu.org; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=W9/cBnVIez29CLs/L+Yh/duA+f3i6XOG+65a+hphMz4=;
 b=Weq/4jLdMU04HrK1yXnBJ1d1bLuaT1BqocDPRhJiQ0uuqPQ2pClwDAqBhwKpd9U0+R
 YRDM0Lr38ABnKpjEetPRjzk0xXPE0cuCczfD1yp4aB5U2e5a8EtIxt980k2ZXcZx+PoY
 /Wwk8ZLCwm97E/D3IN8laySrzO20RpWYzF2ZNWhdP3ruCjDkRypRQsaQVb7cofFmkPhT
 PIoo18QauycWOddi+NT/OTGPOkFKNc9bPZvtt7CAFCkVEEPuwKjqSN4knvtAdFwPIRg2
 37U/PFLWF6q5cY2Gbl2URHX1BcN6I9MNc74JkBBs/7Pdd38gffMsBXVzdCekti4YcntM
 WVxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747544201; x=1748149001;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=W9/cBnVIez29CLs/L+Yh/duA+f3i6XOG+65a+hphMz4=;
 b=OyLn4RBk0twc7eLPBpvRb7L7qra+d/r36AJmRo9H7dqMscoW+T5NEWqJDReKAlCakV
 chYHsvgS/Z1/6RU99XTOOw2XR95U1Oa/Z7NG+mth0+eAE7bTWRfqFCAk8gW7+I/NTFy/
 jHDL2083pSUW3ShcYPSPogDwvRO3t5dEZCI+nQRFSFMIt1LaNCQHGESMYrR1L7XgRlZR
 anLrzSbVMSm6Cm2u2g02rB+d+nnJMSe455/4tGviBXVGsnRs0ESG1U47YszznINT/DB5
 g81gADwCugBYO07ht4k2p201CRZXjnt8FDaP+y0NygoHtqH1lF5VWw0m9jNCG+behBXR
 wghA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUh6avD96jS5hlTnXaRRLZ/eY/NY9lssQf/lPbw8qMB3MDLkEPcYJMyMOPWML6GJAF/OP7NlQeb5WID@nongnu.org
X-Gm-Message-State: AOJu0Yx7jTkWWaOEEklSSGFyzdCjSeZK26kMghKND1tyU/zBEb5Fvv1G
 Yjo1jyCyCzaFbsHrOGjU8Ode2ofJIV78cptP1XzIhDv2zUuFHbVuTtvpMlhrQZNG69Q=
X-Gm-Gg: ASbGnctTseWP9u6zZmKH5yuLZHOJOVYyAbIOUxqjeuKw//IhVQZ3wmzU/z8tSQMe3du
 7F08vArg73UQtySX6GpxXJzsksDVyieYu4TvA95TnHRMvVEHG6CnN638lUMswIa96c/7sC2EmjN
 ZpWaYSZAGJQa4JWzrmblQomuQ+t0cwCyR4Tp2kiy/viH11a2Fsk92qAwfqznko3NwfQidpf66D5
 X+F7cKBZKwlnE+zfzZ0TGVlW/VUAKY0s0tLohQs5bpCfAcfrqovuxRYBni4tx+xKGcVROtKs17s
 ljCULTlSEdaumsATdkPWVSjT1evp1+TuLFqSgbjza2DAX559l0wWnhtRPRFL/Q==
X-Google-Smtp-Source: AGHT+IE17VcvEavpeRxgfxNYGu0UiZ7U9RqdxTzGf4RpgZpNRkZpAOWxK+qNbKtURBc/tvnxO+axHw==
X-Received: by 2002:a05:6a21:31c8:b0:20d:df67:4830 with SMTP id
 adf61e73a8af0-216f85ac739mr11814951637.0.1747544201109; 
 Sat, 17 May 2025 21:56:41 -0700 (PDT)
Received: from [157.82.207.61] ([157.82.207.61])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-b26eb0a906bsm3979875a12.71.2025.05.17.21.56.36
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 17 May 2025 21:56:40 -0700 (PDT)
Message-ID: <63911dcc-482b-45c5-9468-120ae3df691b@daynix.com>
Date: Sun, 18 May 2025 13:56:35 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 12/14] ui/gtk-gl-area: Remove extra draw call in refresh
To: "Kim, Dongwon" <dongwon.kim@intel.com>,
 Dmitry Osipenko <dmitry.osipenko@collabora.com>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 David Hildenbrand <david@redhat.com>, Laurent Vivier <lvivier@redhat.com>,
 "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 Markus Armbruster <armbru@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Peter Xu <peterx@redhat.com>, =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?=
 <berrange@redhat.com>, John Snow <jsnow@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Peter Maydell <peter.maydell@linaro.org>,
 Alexandre Iooss <erdnaxe@crans.org>,
 "Kasireddy, Vivek" <vivek.kasireddy@intel.com>
References: <20250506125715.232872-1-alex.bennee@linaro.org>
 <20250506125715.232872-13-alex.bennee@linaro.org>
 <d5a8cec1-f689-4d31-b6bb-b63eaa4ce2af@daynix.com>
 <d370ffec-f430-4377-80bc-323d5087834c@collabora.com>
 <f7d65908-cd12-4c44-a80a-07e23ff27833@daynix.com>
 <PH8PR11MB6879FBA9E5133649714D74AEFA97A@PH8PR11MB6879.namprd11.prod.outlook.com>
Content-Language: en-US
From: Akihiko Odaki <akihiko.odaki@daynix.com>
In-Reply-To: <PH8PR11MB6879FBA9E5133649714D74AEFA97A@PH8PR11MB6879.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42d;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pf1-x42d.google.com
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

On 2025/05/13 2:01, Kim, Dongwon wrote:
>> Subject: Re: [PATCH v2 12/14] ui/gtk-gl-area: Remove extra draw call in refresh
>>
>> On 2025/05/10 21:12, Dmitry Osipenko wrote:
>>> On 5/10/25 07:52, Akihiko Odaki wrote:
>>>> On 2025/05/06 21:57, Alex Bennée wrote:
>>>>> From: Dongwon Kim <dongwon.kim@intel.com>
>>>>>
>>>>> This partially reverts commit
>>>>> 77bf310084dad38b3a2badf01766c659056f1cf2
>>>>> which causes some guest display corruption when gtk-gl-area is used
>>>>> for GTK rendering (e.g. Wayland Compositor) possibly due to
>>>>> simulataneous accesses on the guest frame buffer by host compositor
>>>>> and the guest.
>>>>
>>>> Simply reverting the part of the commit may re-introduce the problem
>>>> the commit tried to solve, which will be a regression as the commit
>>>> is already included in releases.
>>>>
>>>> I guess the problem is that the gl_block callback of GraphicHwOps is
>>>> not properly implemented and it is what should be fixed.
>>>
>>> The reverted commit made QEMU GTK GUI unusable under Wayland. It was
>>> fixing problem which requires very specific QEMU setup, while breaking
>>> generic setups. The offending change should be reverted as it
>>> introduced a bigger problem. A proper solution should be found,
>>> meanwhile QEMU GTK under Wayland should be restored, IMO.
>>>
>>> For the reference see [1]. First bug reports about a mirrored display
>>> problem were made to me on IRC a year ago and the root of the problem
>>> was identified only couple months ago.
>>>
>>> [1]
>>> https://lore.kernel.org/qemu-devel/5aedf1ad-d9b0-4edb-a050-f3d9bee9bcc
>>> b@collabora.com/
>>
>> That describes the context well. It should also be described with an inline
>> comment so that we will not lose track of the known problem.
> 
> [Kim, Dongwon]  Do you mean we should have this info in the commit message?

A comment in the code is better.

A description of the current version of the code should be left as a 
comment so that readers can find it without git blame.

The commit message is suited for a description of the old version of 
code (e.g., a bug fixed by the commit) or a comparison between the old 
and new version; leaving them as comments will infinitely increase the 
amount of the code.

In this case, it is about a problem with the current version so it 
should be written as a comment.

> 
>>
>>>
>>> As of today, the GTK problem isn't understood.
>>>
>>
>> If your guess about simultaneous accesses on the guest frame buffer is correct,
>> it's a bug of the emulated device, not GTK.
> 
> [Kim, Dongwon]  "Simultaneous accesses" was just a guess. This problem needs to be debugged further.
> BTW, the problem the original commit was trying to fix is some lockup due to suspended rendering on
> minimized or hidden GTK window. But according to Dmitry, this case wasn't hit in his setup with wayland
> compositor so I assume the risk of not having an extra draw in gtk-gl-area would be low.

It is better to describe the estimation of the risk in the comment too.

Regards,
Akihiko Odaki

