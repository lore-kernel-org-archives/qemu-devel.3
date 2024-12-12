Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B3A3E77180
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Dec 2024 14:03:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tLjmT-0006CU-2v; Thu, 12 Dec 2024 09:03:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tLjm6-00069m-9s
 for qemu-devel@nongnu.org; Thu, 12 Dec 2024 09:02:42 -0500
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tLjm4-0007qL-GC
 for qemu-devel@nongnu.org; Thu, 12 Dec 2024 09:02:41 -0500
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-43622267b2eso6616855e9.0
 for <qemu-devel@nongnu.org>; Thu, 12 Dec 2024 06:02:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734012158; x=1734616958; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
 :cc:subject:date:message-id:reply-to;
 bh=5ll2uwrgdIB1huIsLEBMtDox+tpLOXeoimu9Vc3koss=;
 b=HvwL1qjJuO0Vn9jF66157cvmE/uMIR2GsOWQ1ATOG6dR0Enna8cc4b9dqs0rpLrMyL
 oLmXVGFeEY14OX0I9qUo1yi6Dv78j9SJ1KSlvMGxt6suF5kY7IJSNfuz+Zf4JVg7XUMn
 jC7suXi/BCkt7GcupuLJMougCQmEjkRHagQ4dQqyg0PbP/UhKVTwjvHSEYMJPiFl1qRq
 +IDiu93LsPek9+i8MANf2Ct/svY4uVEKCUl3fAaxbFF83wd4SDRt8j/q2gGtldKxzGy8
 UWGd2hrtk/JlfCHibcjL0bhBdE7lzLtqYdiPQGFj2zJwJB7AxN/ygcwjbS2heMKeHTJu
 NC9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734012158; x=1734616958;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:from:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=5ll2uwrgdIB1huIsLEBMtDox+tpLOXeoimu9Vc3koss=;
 b=aQJlmdI+iKbBFqE6Xfs2023ftJP4cltU6uPKCjjdxqNFeqdOoSSuacmVL6B4lpnzAp
 9te7awksM7OW0LEn81cvZcXJnrRQ6RpId+zguYaZhKtLqER9niCg77txT8IVbBIvBy+g
 RAZdoY3e1eVxpehHq02sgEuCD2d6FsugR6knMpNmALM8O0qxQJZIhnpMUhzGrKPboDNE
 KduIvLZtYhf5MGIU3Cjr3TYjm7mQk7DgJe6bJNGlhZrS26ycnIPwlL9xZFacqFU9Z9de
 OG15L/rwwIcH4IX6xdUAMZVB6mTSQj65APN59p/OJe+Fu7lYgeiPLpaYSDNBkC6KLsOw
 MBqw==
X-Gm-Message-State: AOJu0Yzqty9TyySeX3eo9vP4luj3ZpM3WKkntsphnJ4mW62THQm5YdQ8
 b+Om0qCB/g2HjIS+iOf8+DzzHiTCoPkkx5GjhcoxV6RE4esovhCmFd/bwLQqkbk=
X-Gm-Gg: ASbGnctevE0gQhoEoCxMjRYnbWMz0EcbgoFSE/v2TI1PSYPWstJVdHN8lKyHcEQAgPR
 9itgcR7nNWbOzToo3nW6/H1qxM3zGGtisHUmq7y2o4S5tD0iasU0qbh2S/wMiZh+RF5M+0idV+z
 CUkPjq9sxW0UPrSmMmWMHvJD1u6Hlx6fJQIiRlmwb4CpCzuI5cy4KqjJjSm36sFCpCsqv/WeudN
 jPYe9e3i6qRekCHJlIZwqYz0fYXlmsnLsgc8kqvmguPgVz49zRsBWRHfPH9nH7pgElfY5qKBRId
 rE0V+oQ11tL790MWbqeyi8Ys
X-Google-Smtp-Source: AGHT+IFwrGbLCU7Lf3n1pmAGkbtzaWISehbcD+wLsK+FjhhShucW1xUmOnig7RnGFb0lI2uoo+MnJg==
X-Received: by 2002:a05:600c:1e26:b0:434:f4f9:8104 with SMTP id
 5b1f17b1804b1-4361c4340b1mr55102575e9.33.1734012158412; 
 Thu, 12 Dec 2024 06:02:38 -0800 (PST)
Received: from [192.168.69.223] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-387824ca9absm4105378f8f.61.2024.12.12.06.02.37
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 12 Dec 2024 06:02:37 -0800 (PST)
Message-ID: <41df69cc-18fd-4394-bfad-8442a303b561@linaro.org>
Date: Thu, 12 Dec 2024 15:02:36 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] system: Restrict libpmem and libdaxctl CPPFLAGS to
 physmem.c
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: BALATON Zoltan <balaton@eik.bme.hu>
Cc: qemu-devel@nongnu.org, =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?=
 <marcandre.lureau@redhat.com>, Pankaj Gupta <pankaj.gupta.linux@gmail.com>,
 Wei Yang <richardw.yang@linux.intel.com>, Paolo Bonzini
 <pbonzini@redhat.com>, Haozhong Zhang <haozhong.zhang@intel.com>
References: <20241212092632.18538-1-philmd@linaro.org>
 <20241212092632.18538-3-philmd@linaro.org>
 <5c323271-8563-342f-35d1-6f9575265f72@eik.bme.hu>
 <684c89b4-a898-484f-aff9-92b46bc78c04@linaro.org>
Content-Language: en-US
In-Reply-To: <684c89b4-a898-484f-aff9-92b46bc78c04@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32c.google.com
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

On 12/12/24 15:00, Philippe Mathieu-Daudé wrote:
> On 12/12/24 14:11, BALATON Zoltan wrote:
>> On Thu, 12 Dec 2024, Philippe Mathieu-Daudé wrote:
>>> Only physmem.c includes libpmem and libdaxctl headers.
>>> No need to pass them to all system_ss[] files.
>>
>> I think doing this patch first would leave the other one unnecessary so 
> 
> This one is about libpmem / libdaxctl in physmem.c,
> the previous one is about libsdl in vl.c. I'm missing
> what inverting the order would change.
> 
> Besides in 2 patches it is simpler to check what CPPFLAGS are applied.
> 
> Anyhow if you insist, I can squash. I don't care much as long as

s/care/mind/ ;)

> we reduce the flags applied to system_ss[].
> 
>> you could do both in one patch with less churn and maybe reduce this 
>> series to a single patch.
>>
>> Regards,
>> BALATON Zoltan
>>
>>> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>>> ---
>>> system/meson.build | 7 +++++--
>>> 1 file changed, 5 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/system/meson.build b/system/meson.build
>>> index f7e2c8b826f..50d915bd80c 100644
>>> --- a/system/meson.build
>>> +++ b/system/meson.build
>>> @@ -2,10 +2,13 @@ specific_ss.add(when: 'CONFIG_SYSTEM_ONLY', 
>>> if_true: [files(
>>>   'arch_init.c',
>>>   'ioport.c',
>>>   'memory.c',
>>> -  'physmem.c',
>>>   'watchpoint.c',
>>> )])
>>>
>>> +specific_ss.add(when: 'CONFIG_SYSTEM_ONLY', if_true: [files(
>>> +  'physmem.c',
>>> +), libpmem, libdaxctl])
>>> +
>>> system_ss.add(files(
>>>   'balloon.c',
>>>   'bootdevice.c',
>>> @@ -23,7 +26,7 @@ system_ss.add(files(
>>>   'runstate-hmp-cmds.c',
>>>   'runstate.c',
>>>   'tpm-hmp-cmds.c',
>>> -), libpmem, libdaxctl)
>>> +))
>>>
>>> system_ss.add(files(
>>>   'vl.c',
>>>
> 


