Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25457C3ABC0
	for <qemu-devel@archiver.kernel.org>; Wed,  7 May 2025 18:46:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uCjm7-0008Sv-Ex; Wed, 07 May 2025 14:45:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uCjm3-0008Lj-EN
 for qemu-devel@nongnu.org; Wed, 07 May 2025 14:45:44 -0400
Received: from mail-pl1-x629.google.com ([2607:f8b0:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uCjm1-0004kq-FL
 for qemu-devel@nongnu.org; Wed, 07 May 2025 14:45:42 -0400
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-2264aefc45dso3460675ad.0
 for <qemu-devel@nongnu.org>; Wed, 07 May 2025 11:45:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746643539; x=1747248339; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=qxDPVCjfVtoNgCIZdN1lq3rjLY8i4XcwvaPrwsrEMQs=;
 b=YxVtmmAJChKclk+RWM6ZsyH/klbohtIIsUtdtfBrvRqfQ7wiI6sk629sbUzFQb5KbJ
 mKMYQfsvbwrHZVCe2NVJ4oOv1rt0dLzAmdvqWJdlSwsza/leSZABZZfMFZvGgMi9WMZa
 thsssPKnA0yGOuYmcYmrsGRxSG4Qdt8SLQ/vJnxdvUugJHZfUBoyDxelMkKyzL69NSG+
 Z7P2NDc+D6OE+i1CCw6h1v6TWluaxLRmJfwDVew7PwKokjfsCrKwnY36cx8/qZefp0zc
 zF08Ribj/cma+pmbmAgbMyvhpzFPEnKEUn8yH5EUgb8n9txOOewMYnbRmS5qKFz0YUaV
 ZrmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746643539; x=1747248339;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=qxDPVCjfVtoNgCIZdN1lq3rjLY8i4XcwvaPrwsrEMQs=;
 b=IyM+JupSzcwjw57ipW+GTwGKjcaafYgXJY612dHmqeYXEU0W4du6FVFGFHTn6fAZF9
 FBIdk64IkbbobPoyqxfAZwSjYAXtdKpED5BSZbxem8yFtnnHiG39JKg2fM5mz89SltSi
 Xi1fHZDJvxIyg+OtfqBvArb2SV0ZqGZiI9d5xvsk8de7mfoYKdeQ2lFM1yXLkxOx1dSD
 ipYF0eUHeMFO69gRWg6EjJNwiGKTxomUJ0daKbgGksKal+FnBcr1XyasJzEAnmnjyvpa
 AtkUJpY+xXO3yqImTZh7okAABO0gdN5GC3xYFhTa7qSDwbYhZg/6LuabmfvuQa7aydGe
 kwiA==
X-Gm-Message-State: AOJu0Yx0mNIXSXbCQz7e8Buz9uVRAZi/lYGiIsmyyKNLCdNQ/IRQRsGt
 AeqHb5cv/GA2BAxJQEzOT5vA5NmEitaO+gZDDjibWdnl4XvTedvMYwX0Ynw+4W5b7rHnbBh6t4z
 zRyA7nA==
X-Gm-Gg: ASbGncueajxttDzDjmtbyONgoLdFKEH2M8p/tRpHsAtIoF2Qn1n9KLLp8yM6WICrDIp
 QtpPSCt+Ayz1u8f8BXfWIiR2DtN+8xuIh3d9XkzTiMpckCtmBgPaga//VBm0rqR2/Mca80fcqRa
 DDt/6jc0WlOCa4/UIHSnK4CtWId8hOiEg8uTNOPoTIQooFwpZFu6cT9U3sUWpJIAuuIs5RqIeI6
 CjdGLzXKPbfRhH53m66hpwER/XRErfUyxhc7ne1V4AYXpSVGbutaLYngyVdrwgbjDl/AZn9sVzc
 hXtelXzbcyo0aVd8yW+5SAoRIrwuptotxW9qsPHSgHN8lEDiKEQ9NqrDEJ6Hd5g2
X-Google-Smtp-Source: AGHT+IEsAog+MHtGX3z21n5EUDikknzrRG0EBU0DG/ehEfnU6AYRAhfonz8yLAb/4xitHKjA2gr9+A==
X-Received: by 2002:a17:902:e744:b0:22e:53a2:554e with SMTP id
 d9443c01a7336-22e85ed73edmr6794345ad.10.1746643539002; 
 Wed, 07 May 2025 11:45:39 -0700 (PDT)
Received: from [192.168.1.87] ([38.41.223.211])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22e173b584csm93205485ad.16.2025.05.07.11.45.38
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 07 May 2025 11:45:38 -0700 (PDT)
Message-ID: <0657578e-3825-407b-9837-1e29717f94e2@linaro.org>
Date: Wed, 7 May 2025 11:45:37 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] meson: use thorough test setup as default
Content-Language: en-US
To: Thomas Huth <thuth@redhat.com>, =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?=
 <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?=
 <marcandre.lureau@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
References: <20250503201806.3045723-1-pierrick.bouvier@linaro.org>
 <f7da46dd-0e8f-42d8-b555-300c088f605e@redhat.com>
 <91cc4370-163e-4bdd-ac1c-b0d6ea3c06cb@linaro.org>
 <aBnXXC3ldqErl8ub@redhat.com>
 <6a8d7703-e275-4566-bc38-b627cc597e9a@linaro.org>
 <e36633e2-e0de-422a-8ad3-1562e97926c6@redhat.com>
 <aBsISp5UvOLzFhqn@redhat.com>
 <51c4e997-8ae4-43a5-81b7-561c035ba85c@redhat.com>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <51c4e997-8ae4-43a5-81b7-561c035ba85c@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::629;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x629.google.com
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

On 5/7/25 12:39 AM, Thomas Huth wrote:
>>>> Then I don't understand the previous argument from Thomas to not make
>>>> thorough the default: "The thorough functional tests download a
>>>> lot of assets from the internet, so if someone just runs "meson test"
>>>> without further parameters, I think we should not trigger these
>>>> downloads in that case". It's what precache-functional is doing.
>>>
>>> precache-functional is *only* called when you run "make check-functional",
>>> i.e. when you know that you want to run the functional tests that might
>>> download assets from the internet. It's not called when you run the normal
>>> "make check".
>>
>> Are you sure ?  If that's the case it was *not* my intention when i
>> added precaching - I thought that "make check"  would call
>> "make check-functional" and thus trigger precaching ?
> 
> "check-functional" is not part of the normal "check" target - on purpose
> since we don't want to trigger downloads by surprise when people just run
> "make check". That's also why we have separate "functional" CI jobs in the
> gitlab CI, since otherwise this would be handled by the normal "check" jobs
> already.
>

`make check` calls build/pyvenv/bin/meson test --no-rebuild -t 1, which 
triggers func-quick by default, triggering associated downloads, since 
QEMU_TEST_NO_DOWNLOAD=1 is not set for this target, except if I missed 
another hidden hack somewhere.
`meson test --no-suite func-quick --no-suite func-thorough` should be 
what make check should do instead, or we need another "setup", to 
exclude functional-quick from quick default.

It seems that we just have some confusion steaming from our own 
"makefile abstraction layer", when we could simply use builtin meson 
test command for that, which works for all workflows (single vs multiple 
tests). It reinforces my opinion that setups are awkward and that's 
better to use meson test directly with --setup thorough being the 
default, for better or worse. In case a developer wants a specific 
suite, it's also easy to select it with '--suite', and list them with 
'--list'.

That said, I'm dropping this series, and won't pursue asking to change 
the default, since this opinion is not the established consensus.

>    Thomas
> 

Regards,
Pierrick

