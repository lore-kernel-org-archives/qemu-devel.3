Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D25B4E7716C
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Dec 2024 10:15:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tJ8sh-0007JW-Lr; Thu, 05 Dec 2024 05:14:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcin.juszkiewicz@linaro.org>)
 id 1tJ8sf-0007Ix-MU
 for qemu-devel@nongnu.org; Thu, 05 Dec 2024 05:14:45 -0500
Received: from mail-lj1-x233.google.com ([2a00:1450:4864:20::233])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcin.juszkiewicz@linaro.org>)
 id 1tJ8sd-0001FM-Ku
 for qemu-devel@nongnu.org; Thu, 05 Dec 2024 05:14:45 -0500
Received: by mail-lj1-x233.google.com with SMTP id
 38308e7fff4ca-2ffc380b1d0so7450711fa.0
 for <qemu-devel@nongnu.org>; Thu, 05 Dec 2024 02:14:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733393681; x=1733998481; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:organization:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=4/bY7D9zWncrnLprGHcPJ9u9Yr/L873S7Pe0nbD8v5A=;
 b=Zr90dqYmX884NPbm5DLVVjmFZLgTQ4SS9oV7lF8XTUwIsL1yOPUd7Aos+T2BWULIkB
 VCKXYqHIDtDLHJ9JwNGi4aNxsrhtdj2gPtJk6Ny9njzhCgR/kfpmzG4fJoyvpHse6dtq
 vajDOzjtcRbvBzdjbGkJfND7MAghwC5d75hzVxm4VUUu600aDooVtMsBIAYbVwjboJfY
 hKf01Cfs47ZzP+3vWNGkxAKpxtCGwmVfLnJQnf2U5EovYmDSb2M//SpXzwizui4QQt8N
 5X9TGNISe9X0d1SofRC5+N6eJe9HZvkIkqNtWcxWjtVYjM9W0LxfwaJKdU4EobZnmkn2
 2IBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733393681; x=1733998481;
 h=content-transfer-encoding:in-reply-to:organization:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=4/bY7D9zWncrnLprGHcPJ9u9Yr/L873S7Pe0nbD8v5A=;
 b=a8UwoGWUP2ep07695JCfCU8Ozz1tUP05PpKfaExtyo0s4mrC8CcruVpfrNNbUEJQhE
 edh3GtA08ztw1ihTEDYQCbsp4moD4GeHBjwjmiqTRzj1EKIocBCbIfUyLHqTDglEqfcD
 LlLf2xXYUrnLxU7oH9iVhWTz5E05o3mzVLOPB4BkGuoj9Ad/ReKzp7wTA4P/dgaLqQe2
 oNVYmk5i1SMk6AGcKpDfMV0ts/vc0dCSYGDMyvMGvF5b5UzBA5cwDj1u+IrVuSmhj4rs
 VczEKBuOiZMb1keeBwydhDjZ4v5e+80VJanbqMqepFWRxFJQtMP6VXLENRxQq5uC+FpY
 7hvA==
X-Gm-Message-State: AOJu0YzgT2QQyJ5NjwudHAUvNXFOw+a7DVrZy35vE2zrsNxGTBXocfF4
 nueoCaYDST24BxFpBvVOMsgAjBie668OeJoIvS/DpaeAcJtowcW3G8FaZ6f7GIo=
X-Gm-Gg: ASbGncuNBKIBGrJNt4sF0Zh5oGzk1CoTAnAIxk90bYeC4stkN59jmQ84WTjofc2KpEU
 ns1UsK9TvRPJ+Xc5HlP2r6Suxo/gyqoJ6p9QRvrFw0vAIJ+nkWb+XDX8v15q0fU5SNq899ZTijI
 9wDw8Ko4UyBs4sj6gmktBtTn7+DJQnFCK3SOAn7eMA4AO4nbrgLq+s4HTYNGJAfObqxzk1pI6JN
 2nmp2SHJHjnQRKTLOxSA7pA0J++PwdEDaa/QAqXyAtp1LBI/ECD4vI3LpSZqEQrMZOl0+ar1QTo
 0oS2jyIPX5Xuwuo+JpFemtKNB8e5+zw=
X-Google-Smtp-Source: AGHT+IFiTvwnIECw8ZiCzJ8e7IlDeyZmKk+oUts+QunAI9v7UpAWh0UM7FFAzE6Q7gLrikHQXpxdbQ==
X-Received: by 2002:a2e:a584:0:b0:2ff:d11b:d5b with SMTP id
 38308e7fff4ca-3001eb8e62bmr8255991fa.14.1733393680951; 
 Thu, 05 Dec 2024 02:14:40 -0800 (PST)
Received: from [192.168.210.26] (83.11.36.235.ipv4.supernova.orange.pl.
 [83.11.36.235]) by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-30020da25cfsm1725251fa.38.2024.12.05.02.14.40
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 05 Dec 2024 02:14:40 -0800 (PST)
Message-ID: <18ba737f-d669-4e6a-8319-fb5052223b26@linaro.org>
Date: Thu, 5 Dec 2024 11:14:39 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] hw/arm/sbsa-ref: bump default memory size to 2GB
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Leif Lindholm <quic_llindhol@quicinc.com>,
 Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org,
 Mathieu Poirier <mathieu.poirier@linaro.org>,
 Radoslaw Biernacki <rad@semihalf.com>, leif.lindholm@oss.qualcomm.com
References: <20241126084928.252067-1-marcin.juszkiewicz@linaro.org>
 <CAFEAcA_SkZ+ew8AAVpBHuw-9YW4S5wFbB0Vqx+dBzXf97JGDGw@mail.gmail.com>
 <cd635753-4e2c-42d6-bb7b-d558d90f59d7@linaro.org>
 <2106db77-88fb-4113-ae09-9bf77bce6ad7@quicinc.com>
 <c4245af0-3dd4-4cf6-a786-c15fa079ad05@linaro.org>
From: Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>
Content-Language: pl-PL, en-GB
Organization: Linaro
In-Reply-To: <c4245af0-3dd4-4cf6-a786-c15fa079ad05@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::233;
 envelope-from=marcin.juszkiewicz@linaro.org; helo=mail-lj1-x233.google.com
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

W dniu 4.12.2024 o 21:50, Philippe Mathieu-Daudé pisze:
> On 4/12/24 13:17, Leif Lindholm wrote:
>> On 2024-12-02 10:53, Marcin Juszkiewicz wrote:
>>> W dniu 26.11.2024 o 14:14, Peter Maydell pisze:
>>>> On Tue, 26 Nov 2024 at 08:49, Marcin Juszkiewicz
>>>> <marcin.juszkiewicz@linaro.org> wrote:
>>>>>
>>>>> We are working on adding RME support to SBSA Reference Platform.
>>>>> When RME is enabled then RMM (Realm Managment Monitor) takes 1072MB of
>>>>> memory for own use. Which ends with firmware panic on 1GB machine.
>>>>
>>>> Reasonable change, but isn't it also a bug in the RMM that it
>>>> grabs 1GB of RAM regardless of how much RAM the machine
>>>> actually has?
>>>
>>> I think that the goal is "get it working" first and then optimize.
>>
>> I agree on a different platform this could feel quite hacky, but in 
>> reality even 2GB falls within "ridiculously low for an SBSA platform".
>>
>> If we're worried about overhead for CI jobs that do not require the 
>> feature, we could always conditionalize it on RME being enabled. But 
>> I'd be happy to wait and see.
> 
> I'd rather do that, since it is as simple as:

This is sbsa-ref not sbc-ref. Let it just have that 2GB of ram. None of 
existing SBSA systems comes with such low amount.

If there is a use which is memory limited then it can set other values 
with "-m" argument as always.

That's my opinion. I am fine with whatever option gets merged.

