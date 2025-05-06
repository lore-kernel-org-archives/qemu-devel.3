Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80A95C3ABB6
	for <qemu-devel@archiver.kernel.org>; Tue,  6 May 2025 00:27:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uC694-0008PS-RW; Mon, 05 May 2025 20:26:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1uC692-0008Lt-KK
 for qemu-devel@nongnu.org; Mon, 05 May 2025 20:26:48 -0400
Received: from mail-pf1-x441.google.com ([2607:f8b0:4864:20::441])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1uC690-0001Ra-3u
 for qemu-devel@nongnu.org; Mon, 05 May 2025 20:26:48 -0400
Received: by mail-pf1-x441.google.com with SMTP id
 d2e1a72fcca58-736a72220edso5654980b3a.3
 for <qemu-devel@nongnu.org>; Mon, 05 May 2025 17:26:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746491199; x=1747095999; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=h4sIncQY5r5apgcE9rlS/8QBsbDJtCkeXIVQE9s4/kU=;
 b=XoAGc5Q+xOvrcLWS/fstK/ANT+0Ixr5UF2EonKpm0nTAY9Hz4o2PTVlTJSEiO6lHvj
 JOxW9LJZdZ0w8gMkDWtt/A7ZRpbVbtjczIinvthtuGpTrbLHjxVyeSE4S8im+vTevGIC
 dIp0RxbofFHdiDIhTU6efnQnT5RE2Z7l/c/LQnnsQ80IliautqnwS8xtwppEfrsR7Hji
 R3SP23y84vNRrHWHOgbUpbk2vHuR9Jv+/20ctmaaQPbd3k+O3AI5hi1Au5TarvN9hq94
 T1/qK8DClIhm6Zkjwz/em5nteuuDuITgLcDMFX5LFnF6erwySZ0JXncYpnHkts7WCief
 WGZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746491199; x=1747095999;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=h4sIncQY5r5apgcE9rlS/8QBsbDJtCkeXIVQE9s4/kU=;
 b=BTv7/7OPkK+2BHLFWEbWLuq58FD30SsB3hUvX9OUC4Wyyqf7g9edJgmfuPdTdg1RMN
 M42hNwgMmscTkhBsW58qIxJL7qDpND6+H0L0F7oHTwZBe0RvM7b9lNMMOaWiZ2OnkRX/
 0zvjXHXs71VHQcOOdGvOTo1WqUY7uO3btnfydZ9zOZgX1jLWhLzsc+4QC9DHFcnBBjWv
 F7nyTR6MXt//UjngFo9Aip8sL+lRmWTQcRfa8fXuiyMk0B4b/y22kJ7uZS/JMLxPGDpR
 zp5RP2OUXlsR11ZdZlDuix61GSxfl97yQRlRfD+zSODUTtQf5UewJndEHPkUtdrFOyGi
 2QTQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUdpkuGyt6Fo6jKbuwbUlS6Fo8XTCEx44fhGY4IV+pwJ+JvZJuTUTrf1Y0bzU4VXPma8/l/7gWf/DS2@nongnu.org
X-Gm-Message-State: AOJu0YxVumNfxBFquyG1XXFnLgiKRSxjLTiY97jVPzt8bGcK4D14VroR
 paoZ9Hdq5CK42D247TcKxyqThGnlfsfjlp/4TIAn5XuQ0rD27doCiul7kG/vvJY=
X-Gm-Gg: ASbGnctgcCUyOYPDkrkSikohm5ZFbj8PXsg3DzzSj2ABIBCKkJo/wQm/zrNObRXo9Pq
 RihZKkZ8IVG+dMW7x0SCHyWy0DUwurgVYsQOlZcwU+xd0td8vy266NU6MvHpVCE8esjSxGWf+9a
 NgVhzPk2G4fDUSa+6pIrQv+jJeO+AYchtehaf3x6EQLRgW+vnNt5Uh67vmcOy8Ir2MxzwhGh0BW
 d6iFXafdxXuKfbRWAaBikPWA+rkMxF2YSU63k7gKMOnHrmPqogTvjfk0+kkupzzxd+FGJCRZCBm
 ArJSETHC+7+jz+cIPE/IJvF20dEz0+n0ueqmj4VehHWmSNS96MLtVIwJUnsH5BA9d83iry8djDa
 NyzoOVB1Km/w/QSO8Qsk=
X-Google-Smtp-Source: AGHT+IEHsJVj1h5STNnQCbZvqPdOshyZMMmUGvSXm9Q2Pe4WLz6gdcurC6evIVbstKoDiV3JFUwAEQ==
X-Received: by 2002:a05:6a20:c908:b0:1f5:7873:3052 with SMTP id
 adf61e73a8af0-211819af752mr1524620637.11.1746491199525; 
 Mon, 05 May 2025 17:26:39 -0700 (PDT)
Received: from ?IPV6:2804:7f0:b400:8604:71fc:f75a:e2f5:e7b5?
 ([2804:7f0:b400:8604:71fc:f75a:e2f5:e7b5])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-b1fb3920069sm6251724a12.9.2025.05.05.17.26.37
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 05 May 2025 17:26:39 -0700 (PDT)
Message-ID: <5b507a45-133d-4340-b677-e8fc49bfbfd8@linaro.org>
Date: Mon, 5 May 2025 21:26:35 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hw/acpi/pcihp: Fix typo in function name
To: eric.auger@redhat.com, qemu-devel@nongnu.org,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
Cc: qemu-trivial@nongnu.org, philmd@linaro.org
References: <20250504215639.54860-10-gustavo.romero@linaro.org>
 <b0faa0cf-8c68-4385-923c-e761b6582cc0@redhat.com>
 <6523849b-b44c-4176-ba5f-78a606621eb6@linaro.org>
 <c66f47ae-ccb9-47b2-9bbe-fb1386958e6f@redhat.com>
Content-Language: en-US
From: Gustavo Romero <gustavo.romero@linaro.org>
In-Reply-To: <c66f47ae-ccb9-47b2-9bbe-fb1386958e6f@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::441;
 envelope-from=gustavo.romero@linaro.org; helo=mail-pf1-x441.google.com
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

Hi Eric,

On 5/5/25 11:19, Eric Auger wrote:
> Hi Gustavo,
> 
> On 5/5/25 2:29 PM, Gustavo Romero wrote:
>> Hi Eric,
>>
>> On 5/5/25 04:13, Eric Auger wrote:
>>>
>>>
>>> On 5/4/25 11:56 PM, Gustavo Romero wrote:
>>>> Fix typo in QEMU's ACPI PCI hotplug API function name that checks
>>>> whether a given bus is hotplug-capable.
>>>>
>>>> Signed-off-by: Gustavo Romero <gustavo.romero@linaro.org>
>>> Reviewed-by: Eric Auger <eric.auger@redhat.com>
>>>
>>> For awareness, there is a similar typo in pci-port.
>>> see
>>> https://lore.kernel.org/all/20250428102628.378046-2-eric.auger@redhat.com/
>>>
>>
>> hmm it's unfortunate that I was about to publish a series to exactly
>> enable the APCI PCI hotplug on ARM. Next time I should try to sync better
>> with Red Hat folks on the work fronts...
> Sorry to hear that. That's always a frustrating situation :-(

Yes...


>> I've skimmed through your RFC and it seems to be doing mostly of what I
>> was doing for my series, so I'll reviewed it formally today, it should
>> be quick.
> I guess we may need to add some additional qtests for hotplug (just as
> they have on x86). Maybe we can collaborate on this or you already have
> some stuff under work.

Sure, the new test I'm baking is the one I've used in the smoke test. I'll
contribute it on top of your series so.

For the x86 "parity", which tests you're thinking of to add for arm64?


Cheers,
Gustavo

