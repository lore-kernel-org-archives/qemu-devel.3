Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ADAB0E7718A
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Dec 2024 17:08:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tNxWo-00080c-My; Wed, 18 Dec 2024 12:08:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tNxWi-0007o3-B2
 for qemu-devel@nongnu.org; Wed, 18 Dec 2024 12:08:00 -0500
Received: from mail-ed1-x536.google.com ([2a00:1450:4864:20::536])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tNxWg-0003iW-E5
 for qemu-devel@nongnu.org; Wed, 18 Dec 2024 12:07:59 -0500
Received: by mail-ed1-x536.google.com with SMTP id
 4fb4d7f45d1cf-5d3e9a88793so11157043a12.1
 for <qemu-devel@nongnu.org>; Wed, 18 Dec 2024 09:07:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734541677; x=1735146477; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tFTqBXWbrd+5Ar5eHaCN8PTh61B9XqjrZ3+wxsBR9V8=;
 b=LA6eiIcXi4ra+T/9FbOQWs6jjmjLf/z8GdzjdeE+6OnxgvoUBYJLuuZVA94bZLNpCN
 4xqmZokMVouhk6h2QBZGxQZ2hZzG93M504ffiNMgKilxM+bGZmWRecb0elpWWfh0BBiX
 Nio1eRAuUgV1nWA2274FUw8k4KbUoD1RCDatLc3L4WlQtjXfVTPsGxm2IzPKhXIF46MM
 8Ku1UGVcW15zoInpi3eNcsQchU/9rg/F6VKZ0LCtoUq7yDeaZat3qXHhzhrOCgowSCW0
 QXqYOQQXnXGnRat+IJOEbIP/UWl9R5RJPgWLGKpyCYXNqfx18uumhJ0GaQ4IcA8lmbKy
 hGrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734541677; x=1735146477;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=tFTqBXWbrd+5Ar5eHaCN8PTh61B9XqjrZ3+wxsBR9V8=;
 b=W59LWi1jbzMfsI6SzdbcscNJAHFDR+r71reNHm7sLK6qakxN4UIT3UciJMMFrqnIiQ
 /38JCf9AQewWE+FllCcAKBGvrRcuZ6GTC/mvwRiFYQgrZPlWOwH/FCnsBe4Raqf2KrK7
 ULQCW04n0Plzk2fkW9eerUGMajB5L/WMkT/yjncvOJ1cFRPAmiLZxFTi7LxiCVmPeu+y
 9bSw+SCSyhiAGuY8Ap7K7308XcbqCdP+r32EK3Ks9WbfapxwEbsVFsuMhex7Ju2VQOAN
 XJ5VZMDHQIB/Rkxsm9uM+8krvPWYPCQdUnVPpJKFFRsk1L5vuNRI0zt2pVk3ccTP4Dkh
 M3AQ==
X-Gm-Message-State: AOJu0YxKChIfTe6Uue2eF+y0jpox+JdTsJaGXDPf8JcQBxpxPeb8c3y/
 LKpx0Y3iXXijFmBDwXPL4A0+QhVbIr7rWboTqPyj+XGKKVklIjDogwg6qwIoZUw=
X-Gm-Gg: ASbGncuNn8OkS/i6JotE4P2IdXsh2mDL+HQ5bZODmGpHAvcMp+K4VsA0sgdhG2fTu++
 LZysIbzl/BJOs/kcUZr21uVGQpaS2vjzdX00nJRBCbzoVFp3HcbunWaqxNfmIDZ1qzPjUhaMTVE
 Oh4tKAycf500V6QR1WoOk4NP7tZD3A2sW7qtOpoW8Hi07bdhr8P8vwE+TgcFFQbjULr77808Dr4
 p5IBFXF1Xt6LEIdRqdwkEJn90k5hph/aeV+EwXbDVtBZpChfmkCfos=
X-Google-Smtp-Source: AGHT+IHtyPIR1Mgh9eUz6zcTNxJOjznfozFN6xx+O7VrU0zDMzeDMCZRjRGyyAmyIu39LbfQCcoBaw==
X-Received: by 2002:a05:6402:2807:b0:5cf:c97c:8206 with SMTP id
 4fb4d7f45d1cf-5d7ee3fd6demr3832922a12.25.1734541676807; 
 Wed, 18 Dec 2024 09:07:56 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5d652ad21b7sm5532071a12.36.2024.12.18.09.07.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Dec 2024 09:07:55 -0800 (PST)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id DBDED5F796;
 Wed, 18 Dec 2024 17:07:53 +0000 (GMT)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org,  qemu-arm@nongnu.org,  Marcin Juszkiewicz
 <marcin.juszkiewicz@linaro.org>,  Leif Lindholm
 <quic_llindhol@quicinc.com>,  Radoslaw Biernacki <rad@semihalf.com>,
 qemu-stable@nongnu.org,  Andrei Homescu <ahomescu@google.com>,  Arve
 =?utf-8?B?SGrDuG5uZXbDpWc=?= <arve@google.com>,  =?utf-8?Q?R=C3=A9mi?=
 Denis-Courmont <remi.denis.courmont@huawei.com>
Subject: Re: [PATCH 3/3] target/arm: implement SEL2 physical and virtual timers
In-Reply-To: <CAFEAcA_AgkVcVm5nfCNb=PjB5qnYahTUuQxi-U=um92BFokccw@mail.gmail.com>
 (Peter Maydell's message of "Tue, 17 Dec 2024 13:34:49 +0000")
References: <20241206160239.3229094-1-alex.bennee@linaro.org>
 <20241206160239.3229094-4-alex.bennee@linaro.org>
 <CAFEAcA_AgkVcVm5nfCNb=PjB5qnYahTUuQxi-U=um92BFokccw@mail.gmail.com>
User-Agent: mu4e 1.12.7; emacs 29.4
Date: Wed, 18 Dec 2024 17:07:53 +0000
Message-ID: <877c7w5386.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::536;
 envelope-from=alex.bennee@linaro.org; helo=mail-ed1-x536.google.com
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

Peter Maydell <peter.maydell@linaro.org> writes:

> On Fri, 6 Dec 2024 at 16:02, Alex Benn=C3=A9e <alex.bennee@linaro.org> wr=
ote:
>>
>> When FEAT_SEL2 was implemented the SEL2 timers where missed. This
>> shows up when building the latest Hafnium with SPMC_AT_EL=3D2. The
>> actual implementation utilises the same logic as the rest of the
>> timers so all we need to do is:
>>
>>   - define the timers and their access functions
>>   - conditionally add the correct system registers
>>   - create a new accessfn as the rules are subtly different to the
>>     existing secure timer
>
>> diff --git a/include/hw/arm/bsa.h b/include/hw/arm/bsa.h
>> index 8eaab603c0..b4ecca1b1c 100644
>> --- a/include/hw/arm/bsa.h
>> +++ b/include/hw/arm/bsa.h
>> @@ -22,6 +22,8 @@
>>  #define QEMU_ARM_BSA_H
>>
>>  /* These are architectural INTID values */
>> +#define ARCH_TIMER_S_VIRT_EL2_IRQ  19
>
> Can we call this ARM_TIMER_S_EL2_VIRT_IRQ please?

I'm going to assume you mean ARCH_TIMER_S_EL2_VIRT_IRQ ;-)

> We currently have ARCH_TIMER_NS_EL2_VIRT_IRQ
> so we should be consistent about where in
> the name we put the "VIRT" bit.
>
>> +#define ARCH_TIMER_S_EL2_IRQ       20
>>  #define VIRTUAL_PMU_IRQ            23
>>  #define ARCH_GIC_MAINT_IRQ         25
>>  #define ARCH_TIMER_NS_EL2_IRQ      26
>
> -- PMM

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

