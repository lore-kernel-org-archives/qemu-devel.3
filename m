Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C1FCD1D47D
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Jan 2026 16:17:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vdsgp-0000Pi-3W; Thu, 08 Jan 2026 11:16:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vdsgn-0000Kd-LL
 for qemu-devel@nongnu.org; Thu, 08 Jan 2026 11:16:45 -0500
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vdsgl-0003wZ-1Y
 for qemu-devel@nongnu.org; Thu, 08 Jan 2026 11:16:45 -0500
Received: by mail-wm1-x344.google.com with SMTP id
 5b1f17b1804b1-477ba2c1ca2so36789885e9.2
 for <qemu-devel@nongnu.org>; Thu, 08 Jan 2026 08:16:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1767889001; x=1768493801; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=lOcnwlKDE40JPg0kkELYGw2x4MA3NwmO5dkRLDQXGBY=;
 b=U+/Lpdp+/BuK+GVex9bSTwg891PcV3b5C8cYjXFkGWzeZ1oKbNYWmk/fs0S06uyYo9
 tGWw0/PYN+8O8aV91+Zg7ixs1plzUDpfJEEwgfNLznaCGZlKnFahLJbyvLiOlcwDRuWr
 ABrjj4gtcysGbYMSDkvp2klP6vWjn1ZebgXBjUtmQlwnlxuYaN5PC7ocneF4h+yWUDbJ
 OHkvEMC/7Eui9u2P0uXQ4Fym7upjEHMw5gY4t9L5eKDPuYwVwho4zc27P7g0frjpYzEp
 uXQeLFcSjAVwacQiSSwchwETPhTpJAdPEFQwwMJW0JdVn9DwuIn9QKBbfK9yOxvfXUud
 SSfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767889001; x=1768493801;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=lOcnwlKDE40JPg0kkELYGw2x4MA3NwmO5dkRLDQXGBY=;
 b=u2wV805QRFbBf7X1BTnoLH1+EPE3v6icURT/yu5Mswt4pIRI+hjjfJAg340Ez2IpQL
 31pTsN6I3j2iPrP1olg+jqGYR+xDXvtGRywQxysP5j4N1lNoUxDIZOrbvJQ42s0Yw+Ix
 vJhs0MmcceMhlZcp/0d6R1i080GlJUx19wiy80HyWjx9u3Js3JSksW5dlMFZpngs3LEA
 ysY3ENk6ocUVi/L1PloBEmlPsr9XDfpTJE0D/Pq6esP512PV3Hhz/dKDjy3W/7mmJPUV
 sP/9BUFkIL9wMGJC83WagFF+J2HJIMpwgfByTN77LtXjgHZCQYmZqQnC4uYQ8/G8f/bR
 oafw==
X-Gm-Message-State: AOJu0Ywzr2shl54peCT9tKU0WjIKMSDsaBRI7Oxqzefed44oQYTacKlp
 HI8ykuYqG13luhHZRUeGd9yXscAaGM84L2oUCP7/iTLud0jLKF0BqZTgTx133qufO8w=
X-Gm-Gg: AY/fxX57VUrjxrzs0IOTPl2p1ykk3CIWLxFeBRMYwvPzxDgf0oG0hLbTj8rqWILzYqt
 1oImuFb+/cBhZnu9vt4051IME1r25ajMBdpIy8NVKQ9OoG5GcnKfCqLeTKtyhMbPgCEZFLq9a5Y
 mNEcReE9JD+an+Pc9WfIMx6IXAXaz+HwUy6ujdKNwcQE+RYXQ8iBbn4GwErxV8VsR55oXb1fj8B
 P33E9uQhtKxss6fi9zWDLi7VBZ3X0AV3sJlYcr6G++jHSyLnCksJQzdmsw94HUxpDE0tuPbqV0f
 9jyj/QD/SI/ZLQgfgAEU2kxtQ9L92wqULg1Gs6hB6jr+YidKKIDvIyMNArOqQosScTcwOECso99
 hbSpPDXce56jiQd+1dUgfqpjWTw05zQ8BKzS2xG0wTHQX9aomc3IFekfd3FIWdid8EOwTcYbQXr
 0vAurBx+fdugB+1jCysP40Li2Sl3TTC0TFO0XeA2nQruHVn3R4fdenAw==
X-Google-Smtp-Source: AGHT+IEHoXTxTcXflrhXX+bo48YhOyHaaA9JMT0JIq5+MIC9M+DWr3OH/jIKls363cc3XHMwXK9pFQ==
X-Received: by 2002:a05:600c:6096:b0:47a:935f:61a0 with SMTP id
 5b1f17b1804b1-47d849ba979mr77524615e9.0.1767889001087; 
 Thu, 08 Jan 2026 08:16:41 -0800 (PST)
Received: from [192.168.69.213] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47d7f68f69dsm162106265e9.1.2026.01.08.08.16.40
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 08 Jan 2026 08:16:40 -0800 (PST)
Message-ID: <41a03c3a-5903-4939-800e-211ef788b91e@linaro.org>
Date: Thu, 8 Jan 2026 17:16:39 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] dump/win_dump: Use stubs on non-Windows hosts like
 POSIX
Content-Language: en-US
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, Ani Sinha <anisinha@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
References: <20260107180519.50820-1-philmd@linaro.org>
 <20260107180519.50820-3-philmd@linaro.org> <aV902eZnijhEnONE@redhat.com>
 <0438ddd7-6061-4b7b-a995-0ec32f250f95@linaro.org>
 <aV-Ms5PQDCiIA86v@redhat.com>
 <a5c263e3-20a0-4736-9999-eca0ef639ba8@linaro.org>
 <aV-Wx6qXaXNnqf5R@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <aV-Wx6qXaXNnqf5R@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::344;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x344.google.com
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

On 8/1/26 12:36, Daniel P. Berrangé wrote:
> On Thu, Jan 08, 2026 at 12:14:30PM +0100, Philippe Mathieu-Daudé wrote:
>> On 8/1/26 11:53, Daniel P. Berrangé wrote:
>>> On Thu, Jan 08, 2026 at 11:51:00AM +0100, Philippe Mathieu-Daudé wrote:
>>>> On 8/1/26 10:11, Daniel P. Berrangé wrote:
>>>>> On Wed, Jan 07, 2026 at 07:05:19PM +0100, Philippe Mathieu-Daudé wrote:
>>>>>> Rather than compiling the same content for all targets (unused
>>>>>> most of the time, i.e. qemu-system-avr ...), build it once per
>>>>>> POSIX hosts. Check Windows host (less likely) before x86 host.
>>>>>>
>>>>>> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>>>>>> ---
>>>>>>     dump/win_dump-stubs.c | 21 +++++++++++++++++++++
>>>>>>     dump/win_dump.c       | 12 ++++++++----
>>>>>>     dump/meson.build      |  6 +++++-
>>>>>>     3 files changed, 34 insertions(+), 5 deletions(-)
>>>>>>     create mode 100644 dump/win_dump-stubs.c
>>>>>
>>>>> snip
>>>>>
>>>>>> diff --git a/dump/meson.build b/dump/meson.build
>>>>>> index 4277ce9328a..0aaf3f65d9c 100644
>>>>>> --- a/dump/meson.build
>>>>>> +++ b/dump/meson.build
>>>>>> @@ -1,2 +1,6 @@
>>>>>>     system_ss.add([files('dump.c', 'dump-hmp-cmds.c'), snappy, lzo])
>>>>>> -specific_ss.add(when: 'CONFIG_SYSTEM_ONLY', if_true: files('win_dump.c'))
>>>>>> +if host_os == 'windows'
>>>>>> +  system_ss.add(files('win_dump.c'))
>>>>>> +else
>>>>>> +  system_ss.add(files('win_dump-stubs.c'))
>>>>>> +endif
>>>>>
>>>>> This is very wrong.
>>>>>
>>>>> The win_dump.c  file has no association with Windows hosts. It is about
>>>>> creating crash dumps of Windows *guests* in the Windows dump format. The
>>>>> current conditional which builds it on TARGET_X86_64 is correct.
>>>>
>>>> Great to know this is a *guest* feature and not a *host* one.
>>>>
>>>> Something else is currently wrong, because this file is built with
>>>> qemu-system-avr on macOS.
>>>
>>> Why is that a problem ?
>>
>> Single binary can not be linked because each target has these same symbols.
> 
> So we need a make 'win_dump_available()' into a runtime check against
> the current target == x86, and then unconditionally build the rest of
> the file ? How do we provide access to target specific types in such
> builds as merely removing the #ifdef shows missing X86CPU / CPUX86State
> types for most targets.

I went with using a new Kconfig symbol in v2, see:
http://lore.kernel.org/qemu-devel/20260108161220.15146-5-philmd@linaro.org/

