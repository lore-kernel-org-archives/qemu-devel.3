Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB1E5E7717D
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Dec 2024 18:39:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tKiea-0000ht-Lc; Mon, 09 Dec 2024 13:38:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tKieW-0000hP-V2
 for qemu-devel@nongnu.org; Mon, 09 Dec 2024 13:38:41 -0500
Received: from mail-pf1-x431.google.com ([2607:f8b0:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tKieS-0007a0-OT
 for qemu-devel@nongnu.org; Mon, 09 Dec 2024 13:38:39 -0500
Received: by mail-pf1-x431.google.com with SMTP id
 d2e1a72fcca58-72764c995e5so299490b3a.2
 for <qemu-devel@nongnu.org>; Mon, 09 Dec 2024 10:38:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733769508; x=1734374308; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=hrxRqjImF46rvESoiK1W018AdZYMB4lscGcQQqWWxE0=;
 b=W7kkMc8z/c5S5AzMtteOfdfWiRh1V1A2Lw++6pErKNc0nEUp78ZVyG/Jio4csLGmpG
 lLWvOgclzbFWDo4eKfvdACoc339Z+5MGjHDm1BKm29T9FApqRnGLgXwytL8TSFH/Cgjw
 xqiqXDIkyPEcbDk2n8BiYRnEeB+boxglso0slWRIkcLRWY5DrRH3SrCFzNc+OxxcUrbo
 Cz3G31KDnfwfiVHVVpaNocvH7ZaUaFiI1JGZbVinoNBzXmfstvs2OP58QX7NIEXH2owf
 LonfmkfQ4AuJpn7oNYnED5i74OByGZ5DgvC6Ur+FeTjRE7kLx0Iqer7bDUgWtHOSIpzI
 41cA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733769508; x=1734374308;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=hrxRqjImF46rvESoiK1W018AdZYMB4lscGcQQqWWxE0=;
 b=jvKiehTNQS7lL/bnR4Ob1kR0XHetm6wXthsqgGyIqRjokeZ7y1ALVzI9VJr0EjWxMf
 a64nMNMhpHvZH5NUviicgZ5IMe+1Vqgizo5ajO797pOJkU0YkeFuw1c8ttnZ8wnGO2YB
 A1pVmKbr9YVPZfVNQDMtLZ9AnmpybkOzWuHZe6jgzgDtaJhH7tQIwqn2IwjASzFGRcbz
 4ubWjtMdpy6pw9UGXbtz+57FkruATB89KOSlqvDuNw0GDLuATwuH1b0/sbfaUN7/yH+U
 AHAixeTYfse9xnqJfT7eqc7mmbwlB/eFPY/vxYu57JutEkrFs6UWju1nsd6Caw+B44Kf
 4jpw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVopj0Qn/ciU0nSJcwfR3CnBZhjkyl7+CcXex9oNa0pjTqgcFrkpbfOA8yF8K7m52o/+9OVapntKKup@nongnu.org
X-Gm-Message-State: AOJu0YzS4Cbhxi5wVnuAfdt4Yl+2DvUkrb/upO1GOXZfNxQO3UlK8ag9
 ngxnhIlRaLqdSN+SUMySEZ9lgr8jOVzWePGSp38eq+X3cZxZaH0D5p6TC9GYNcg=
X-Gm-Gg: ASbGncuWHv6/Nllt7LBzLVv9qN0Rv4RH8UA7T0engOdsofu9TU5owYua19BabSxr533
 6yV0+KuZUaU4uENZuqSu2tU6ckl5Sht45+bdcxQzdWN1ZyqTp7hG39comMJwvQxLo1nn09J1C6i
 oCq9wPTjunTWyPiJ0qop6/kwP9R38ZjaxCygHRYtrk//xaJ3LqE3bSU/kc5LuBZa+ZxDlupyfMz
 EJnEGr8hamq9GTOp+ij4i3FLa6QIyRZsp/35TTLomWHcbqXIKIyJD1WIqtTvWEvw5v+4ZPii/FM
 XFouisFTAaf0gFu9ek2R2iycQg==
X-Google-Smtp-Source: AGHT+IGy3FxQ50QMkdNKY1vEPuMGBBvVDSaD7xDto9mZWUF0B5DDyDzW218psqj6dGlV6ScS7yaI7w==
X-Received: by 2002:a05:6a00:a90:b0:725:f153:22d5 with SMTP id
 d2e1a72fcca58-725f1532457mr4954456b3a.18.1733769508159; 
 Mon, 09 Dec 2024 10:38:28 -0800 (PST)
Received: from [192.168.1.67] (216-180-64-156.dyn.novuscom.net.
 [216.180.64.156]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-725f0e75e13sm1897030b3a.146.2024.12.09.10.38.27
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 09 Dec 2024 10:38:27 -0800 (PST)
Message-ID: <0886af3d-31f0-4bb8-8eb6-2f5f01a16192@linaro.org>
Date: Mon, 9 Dec 2024 10:38:26 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/3] Add inject plugin and x86_64 target for the inject
 plugin
Content-Language: en-US
To: Rowan Hart <rowanbhart@gmail.com>, qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>, Alexandre Iooss <erdnaxe@crans.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>, Paolo Bonzini
 <pbonzini@redhat.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>
References: <20241206102605.961658-1-rowanbhart@gmail.com>
 <20241206102605.961658-4-rowanbhart@gmail.com>
 <5ec40cb8-8a9d-4d13-b78e-79ea30317dbf@linaro.org>
 <8e25cab2-6809-4a66-b3f1-f9570f408614@gmail.com>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <8e25cab2-6809-4a66-b3f1-f9570f408614@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::431;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x431.google.com
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

On 12/6/24 17:02, Rowan Hart wrote:
>>> +++ b/tests/tcg/plugins/inject.c
>>
>> Could we find a better name?
> 
> For sure, maybe "hypercalls.c" since that's really what it's mostly about.
> 

Sounds good.

>>> @@ -0,0 +1,206 @@
>>> +/*
>>> + * Copyright (C) 2024, Rowan Hart <rowanbhart@gmail.com>
>>> + *
>>> + * License: GNU GPL, version 2 or later.
>>> + *   See the COPYING file in the top-level directory.
>>> + */
>>
>> We can add a comment here about what the plugin is doing.
> 
> Will do!
> 
>> One challenge with picking a random value, is how to ensure this pattern has no other meaning for all architectures? I'm not sure we can find a single pattern of bytes that works for all arch, even though that would be definitely stylish :).
>>
>> In more, it seems that we are reinventing the syscall interface, while we already have it. But as the current instrumentation only works for user-mode, having a specific hypercall interface might be worth it for plugins, so system mode could benefit from it too.
>>
>> The work done here could serve later to define a proper interface.
> 
> 
> I'll see what I can do about this. SIMICS supports many architectures and has a
> "magic instruction" interface[0] (basically hypercalls) and has these
> instructions defined per-architecture in a way that at minimum there are 12
> values available which work on every architecture the simulator supports. QEMU
> supports more architectures than SIMICS but I think we could start there and
> follow a similar approach.
> 
> [0]:
> https://intel.github.io/tsffs/simics/simics-user-guide/breakpoints.html#Magic-Breakpoints
> 

Looks like a good model to reuse if we want to implement something similar.

> -Rowan


