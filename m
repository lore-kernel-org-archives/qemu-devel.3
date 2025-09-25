Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2741DCAC5AE
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Sep 2025 00:21:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v1Zib-0001Y5-FC; Wed, 24 Sep 2025 20:20:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v1ZiX-0001XQ-5v
 for qemu-devel@nongnu.org; Wed, 24 Sep 2025 20:20:13 -0400
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v1ZiQ-0003Pj-6j
 for qemu-devel@nongnu.org; Wed, 24 Sep 2025 20:20:12 -0400
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-46e30ef74b0so2022915e9.0
 for <qemu-devel@nongnu.org>; Wed, 24 Sep 2025 17:20:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1758759602; x=1759364402; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=yBTysEaJeGfbau7ZgvrXVhzczRMD5WRfmbRaLJ4gBhE=;
 b=JMLhtZkeidvP0RMA1AzbB7tgZRWQeduu0ZwBGFnf8J/fFofixfYOsCNWu3BJy3WNHz
 Ge3rvYuMlX3PEePZEflDeCBYYbruTQSTQaOT4kVsj/hQ/qY/ZY4ceMWQjVQIdUBZvjq+
 RrUfjuK9b55wyBTK5AY73DOsL7Dv+am2/mBV3Ttk2gjzrpx0sJouLNzFwZAwoRgZys+W
 1kj6aOwHYcONTVvX91giCJL3rcbLaMDhV1UsLt1F3nrSdJQZc8UjVo4Ks8DPfeTTBk8i
 xCx3z76v6xYA4kngxoGzG263ZJLytcXj0nxCDg+eiPEmchYrcdXTHOdfIQnoSwxP1DEo
 6rYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758759602; x=1759364402;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=yBTysEaJeGfbau7ZgvrXVhzczRMD5WRfmbRaLJ4gBhE=;
 b=r8l5GAbf0WeWZe4zzMbwukIJey7AmkiVSP7ciKOqMGDmcQdrwdW/1alvtXtizsE4CO
 W5MoAZAxED5c8xAj71C4b4PDzk/o8uYwRarOnhxrxhmobM1Nc/5jT38f1SNum4pztk7V
 aucNv+oWmK3c7IEzz09DAwS8UlI9PUJWGI++uaXgjb5pkH9nCCFxyHr1z2efjlfdo1+U
 uvAh7+drcxO+ThMHsgoXZAI21ryk3yh8O0BJ9FFVxAu6oKuNF4d7dXAyjZ0ko0fioM9o
 lNZWPK/H0WossgsZyM+5NmU022tzK23yKyrkpXMimeZaCxTMtcq6BtIkNQjBIVxzO0Fq
 AGtA==
X-Gm-Message-State: AOJu0YwAwqv3sCnU//ezrCd4tk8C1NdO2iPUH56p7DgEUBAjci7vBrP4
 x5k1u6LNWEkn++EcnHbTVIQuNtCgrb7UriLNQs7YCb5R69ExsM35UK102imjTvmy2LU=
X-Gm-Gg: ASbGncuSGXxAJ9xLedBNKWEamBbFHwvSntcxzr6eNFSjofYfAVYuXlMoU2JTm6YDfbN
 Kze99WTEnNBQkBIZNld1obrXco4yFVsip2QsQG+o2OJ3S7vbaVO8sjCNBrKfTGO/PNoAz1gTAcJ
 cWltIS0pnxDJ7MlZJAKC743+MDLeCWvg5e8V83xJCVabeSF52npbxT9mPRbbMAlZQMhB5qHjEc4
 yGLqPo9dFFJcgZVvmqqT3FKvsGB4DhIJjV6Po0jqpHcLnELVIogNY5HyIY4h8k0yUr3zdMUYoHV
 R4jS2qIBUgVNycc0LRIZxLbM4m/gNrArFFCUTTs71SG0JzfYrDcY9uNsa9G4m1p94Jchdg15Wn4
 Onxu26Cqehn+iQQS/J4xCfE8J8O2M1fJKpX3yyU2txGgtAVnVYFNpIt9elDxyUkrxEg==
X-Google-Smtp-Source: AGHT+IFpG9FWod2mOuetb+mLamZZcuHLaDWY25b1ZCgR/+Nd0TSNU+iYMojV0leL+1r9SFKmPErzLg==
X-Received: by 2002:a05:600c:1c8e:b0:46e:1f86:aeba with SMTP id
 5b1f17b1804b1-46e329f819dmr16198575e9.17.1758759601540; 
 Wed, 24 Sep 2025 17:20:01 -0700 (PDT)
Received: from [192.168.69.221] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-46e330d1d2fsm5588915e9.3.2025.09.24.17.19.58
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 24 Sep 2025 17:20:00 -0700 (PDT)
Message-ID: <a9d3913f-0996-4f5d-9ba7-b0fb464e9d28@linaro.org>
Date: Thu, 25 Sep 2025 02:19:57 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH] docs/system/security: Restrict "virtualization use
 case" to specific machines
Content-Language: en-US
To: Bernhard Beschow <shentey@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Alistair Francis <Alistair.Francis@wdc.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, qemu-riscv@nongnu.org,
 qemu-ppc@nongnu.org, Huacai Chen <chenhuacai@kernel.org>,
 qemu-s390x@nongnu.org, Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Song Gao <gaosong@loongson.cn>, Bibo Mao <maobibo@loongson.cn>
References: <20250908125058.220973-1-peter.maydell@linaro.org>
 <aL7xrilR-gyByKEM@redhat.com>
 <CAFEAcA_wt3HwDq=sJ+VuLdx_RFFwB6E9FjrbT1zgNXGGvfQ9YA@mail.gmail.com>
 <B5215A1D-C8F5-44FD-B19B-70D78B7FD4F5@gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <B5215A1D-C8F5-44FD-B19B-70D78B7FD4F5@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x336.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 24/9/25 20:16, Bernhard Beschow wrote:
> Am 8. September 2025 15:15:43 UTC schrieb Peter Maydell <peter.maydell@linaro.org>:
>> On Mon, 8 Sept 2025 at 16:09, Daniel P. Berrangé <berrange@redhat.com> wrote:
>>>
>>> On Mon, Sep 08, 2025 at 01:50:57PM +0100, Peter Maydell wrote:

[...]

>>> Currently 'virtualization use case' is reasonably vague such that we can
>>> bend its scope as we desire, at the time it is questioned in a possible
>>> security report.
>>>
>>> Machine types are only one aspect of this. Devices are the other, and
>>> the area where it gets significantly more fuzzy and difficult because
>>> essentially any device can be used with KVM, and where we draw the
>>> line is fairly arbitrary.
>>
>> I think that being vague like this is a disservice to our users.
>> If I'm a user of QEMU, I'd like to know whether I'm inside the
>> line or outside of it before I put my config into production,
>> not later on when it turns out there was an exploitable bug
>> that wasn't classified as a security issue...
>>
>> Most devices can't in fact be used with KVM, because they're
>> sysbus devices that aren't used in the machines that you can
>> use with KVM. Pluggable devices are rarer (and yes, under
>> our current policy random PCI devices are effectively
>> in-scope).
> 
>  From the top of my head: Various USB and I²C devices can be used as well.

I suppose USB /is/ regularly used by 'virtualization use case' for input.

Also I expect I2C to be mandatory on x86/q35 due to the SMBus
dependency.

Like we list machines here, should we be explicit about devices covered?

> Best regards,
> Bernhard
> 
>>
>> thanks
>> -- PMM

