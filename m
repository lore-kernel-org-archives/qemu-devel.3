Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9BDF3C021A7
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Feb 2025 04:33:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tiQu0-0007hb-7Y; Wed, 12 Feb 2025 23:32:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1tiQty-0007hH-3H
 for qemu-devel@nongnu.org; Wed, 12 Feb 2025 23:32:38 -0500
Received: from mail-pj1-x102d.google.com ([2607:f8b0:4864:20::102d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1tiQtv-0008FZ-Mm
 for qemu-devel@nongnu.org; Wed, 12 Feb 2025 23:32:37 -0500
Received: by mail-pj1-x102d.google.com with SMTP id
 98e67ed59e1d1-2fbf77b2b64so940991a91.2
 for <qemu-devel@nongnu.org>; Wed, 12 Feb 2025 20:32:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1739421153; x=1740025953;
 darn=nongnu.org; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=QXg3YLfOBh2uV4jpH0St0IWJccuGqUYzF074mqjxaHs=;
 b=iDeEwVefWcbf5U7zBMwFF4L1Xu0QOWfL6Iv5c4Vs+UQA5T0xa3AqOBzS1/oB6Bzd0U
 L/tmN8fO1wfeGHJFCP0Gd0U3D5D1ZUkziVwrLx1/l3dQAoqpkvqmeI/V5VdG86FftBQb
 cMQblWi0CzYPFH3LQZczl1su6hXl13w3qobNOSG+AasdY0sydzUUkmVS7/o/K/wvLh1d
 0/wk74ozCuq51KPAKaJDzTCXHXh2ISL3AJUbRy4JE02U/4G8wTEDgH5+tNGl9ZOYBJy9
 D3I4KiJ34uqaAc2zM1uwKsWuyI5iDqhIf+D8n2Euy3Y2U6Vyiv0cn7bPDkp3LB1HCci6
 qI5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739421153; x=1740025953;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=QXg3YLfOBh2uV4jpH0St0IWJccuGqUYzF074mqjxaHs=;
 b=vG0riNJbPia3bGeAXWfrPlG4VKZQkyZQLt3Q6lAdyrypi0vs0j7rVlKkhfyApNo4CF
 7OTfibbtW/p6oDYIZDk1/ocEuxfAReBNfiOMlNJXrHHn7+uY+rPY2u5jHLeBQM54ywzv
 2ZY0mY51b3AClvOLsXQWFjGyt/B4v6hYZZAkig+ZtS1LdHGcQeoK3zV9Vm8N8Sfrt8ku
 2U3v7JjwYfiF1SGJNGa73fvHOkK6IJxPS+s7K1w2uYYK0E/45iGY23r7ujp8AN+cqhup
 mzBT1qRRSHny/t1CYuhu+GypYVyqs+vDaaVNXqX0qfLdPH29ARhTm2XJk6oJJiCE7GNw
 T23g==
X-Forwarded-Encrypted: i=1;
 AJvYcCWVKlKP+y8jDTheq+aATjpkpMspt1Jatsr0shW++1Sq1Y2NbLN+BhPpyQLS5Kx+gD3vPxsJ1/XF2ZJT@nongnu.org
X-Gm-Message-State: AOJu0YwkSfkR4I7eIvUOvnIYQXgIuGV5zXznhqU/SCOxc81BXNpBTpCq
 rOboeiPrgVVHK/II7Wgf+FPskZXPcKLjuzIUkFSSmK6KaWzRlSk0LH8VmgJbB/k=
X-Gm-Gg: ASbGncs4+m7i2K7jBlfMBspvQKvZCtjNYcb7ZAI4URTbQ6DBA4Q9T3pOuqNyXI9R29f
 bMrCDUzLY4vrqfAOeBih39A9WltwwxTx0u0BWu6ZpwLLROwU//+l27WCR+fH3xvqOeoRb3N0cBH
 d1pEGK7FnYnJMwtIaov5hNpmji2bNHfAXvPHk+hXdl+W8AL2vvr3h2+B9OyBbfEuwgU49m5c+Iz
 UD3s5xo1J6qP3xnquNZCLnxqeCPMtBfyzXBR+qR+yb76u1u99FPPZ8yQLeVWUn7kgKqQQpxmHnW
 HCogn8wbbcckt83DbGSjkvH8GhaR
X-Google-Smtp-Source: AGHT+IF9ozNDeCh06G1/ig2voIDt/BuHhJ8CCC6lZcOity3F/oq/QZ5CKz1vGVZQ8aRLVApnfYxpqA==
X-Received: by 2002:a17:90b:4a10:b0:2ea:5054:6c49 with SMTP id
 98e67ed59e1d1-2fbf5ae3f48mr10167309a91.0.1739421153155; 
 Wed, 12 Feb 2025 20:32:33 -0800 (PST)
Received: from [157.82.205.237] ([157.82.205.237])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2fc13ac19aesm271924a91.17.2025.02.12.20.32.26
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 12 Feb 2025 20:32:32 -0800 (PST)
Message-ID: <a8fc06f0-0197-4394-bac4-733f3fcef103@daynix.com>
Date: Thu, 13 Feb 2025 13:32:25 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 8/8] docs/system: Expand the virtio-gpu documentation
To: Dmitry Osipenko <dmitry.osipenko@collabora.com>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
Cc: Huang Rui <ray.huang@amd.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Gerd Hoffmann <kraxel@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Gert Wollny
 <gert.wollny@collabora.com>, qemu-devel@nongnu.org,
 Gurchetan Singh <gurchetansingh@chromium.org>, Alyssa Ross <hi@alyssa.is>,
 =?UTF-8?Q?Roger_Pau_Monn=C3=A9?= <roger.pau@citrix.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 Stefano Stabellini <stefano.stabellini@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Xenia Ragiadakou <xenia.ragiadakou@amd.com>,
 Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>,
 Honglei Huang <honglei1.huang@amd.com>, Julia Zhang <julia.zhang@amd.com>,
 Chen Jiqian <Jiqian.Chen@amd.com>, Rob Clark <robdclark@gmail.com>,
 Yiwei Zhang <zzyiwei@chromium.org>, Sergio Lopez Pascual <slp@redhat.com>
References: <20250119220050.15167-1-dmitry.osipenko@collabora.com>
 <20250119220050.15167-9-dmitry.osipenko@collabora.com>
 <c2e1c362-5d02-488e-b849-d0b14781a60f@daynix.com>
 <87ikq9r7wj.fsf@draig.linaro.org>
 <171b1cd3-1077-438c-a27c-3b9b3ce25f0f@daynix.com>
 <ea866d19-90f6-4bb9-a3f6-f84b2ea2c457@collabora.com>
 <86dce86b-03bf-4abe-b825-1341e93eb88d@daynix.com>
 <920043a8-9294-4b40-8d8e-3611727e4cd2@collabora.com>
 <0f88994f-1a93-4049-addc-a62e8ca49904@daynix.com>
 <d85f6669-8c46-4678-85d6-59240935d197@collabora.com>
 <fdd8b7ca-e4ad-405d-a58e-fbcb82183ec8@daynix.com>
 <59f70c1d-4c66-4440-a102-5f478749c8f3@collabora.com>
Content-Language: en-US
From: Akihiko Odaki <akihiko.odaki@daynix.com>
In-Reply-To: <59f70c1d-4c66-4440-a102-5f478749c8f3@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102d;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pj1-x102d.google.com
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

On 2025/02/10 6:03, Dmitry Osipenko wrote:
> On 2/6/25 08:41, Akihiko Odaki wrote:
>> On 2025/02/06 2:40, Dmitry Osipenko wrote:
>>> On 2/3/25 08:31, Akihiko Odaki wrote:
>>> ...
>>>>> Requirements don't vary much. For example virglrenderer minigbm support
>>>>> is mandatory for crosvm, while for QEMU it's not.
>>>>
>>>> Is that true? It seems that virglrenderer uses builds without minigbm
>>>> support to run tests on GitLab CI.
>>>
>>> CI is running in a headless mode using software renderer. For a
>>> full-featured crosvm support running on a baremetal, minigbm should be
>>> needed, along with other downstream features.
>>
>> That makes sense.
>>
>> Based on your input, for QEMU, I don't think we need a separate
>> documentation to describe libvirglrenderer's build flags though crosvm
>> should have some documentation saying it requires minigbm.
>>
>>>
>>>> Anyway, if there is any variance in the build procedure, that may
>>>> justify having a separate build instruction in QEMU tree to avoid
>>>> confusion. Otherwise, it's better to have a documentation shared with
>>>> other VMMs.
>>>>
>>>>>
>>>>>> I'm not entirely sure the documentation will stay as is for that long.
>>>>>> The requirements of Intel native context refer to merge requests that
>>>>>> can be merged sooner or later. Asahi may need more updates if you
>>>>>> document it too because its DRM ABI is still unstable.
>>>>>
>>>>> The unstable parts of course will need to be updated sooner, but the
>>>>> stable should be solid for years. I expect that about a year later
>>>>> requirements will need to be revisited.
>>>>>
>>>>
>>>> It will be some burden in the future. Now you are adding this
>>>> documentation just for QEMU, but crosvm and libkrun may gain similar
>>>> documentation. The DRM native context support for Intel and Asahi is in
>>>> development, and I guess nvk will support it someday.
>>>>
>>>> So, a very rough estimation of future documentation updates will be:
>>>> (number of VMMs) * (number of DRM native contexts in development)
>>>> = 3 * 3
>>>> = 9
>>>>
>>>> That's manageable but suboptimal.
>>>
>>> I don't mind deferring the doc addition if that's preferred. Either way
>>> is fine with me. Yet it's better to have doc than not.
>>
>> My suggestion is not to defer the addition, but to add it to Mesa, which
>> does not require deferring.
>>
>>>
>>> In my view crosvm and libkrun exist separately from QEMU, they serve a
>>> different purpose. Majority of QEMU users likely never heard about those
>>> other VMMs. A unified doc won't be a worthwhile effort, IMO.
>>>
>>
>> When evaluating the utility of a unified documentation, Whether the
>> majority of Mesa/Virgl users care VMMs other than QEMU matters more. And
>> I think it is true; libkrun and crosvm are excellent options for
>> graphics-accelerated VMs.
>>
>> If we have a unified documentation, any VM can point to it for the build
>> instruction of Mesa and virglrenderer. Once that's done, QEMU users who
>> want graphics acceleration can take the following steps:
>> 1. See docs/system/devices/virtio-gpu.rst
>> 2. Figure out that they need Mesa and virglrenderer
>> 3. Click the link to the unified documentation
>> 4. Build Mesa and virglrenderer accordingly
>>
>> No other VMMs will bother them in this procedure.
> 
> Will see. For the starter, adding example build flags to QEMU doesn't
> hurt, it's a very minimal information. Later on, if and when all
> relevant Mesa/virglrenderer doc pages will appear, it won't be a problem
> replace QEMU flags with the links. Please let's do it step-by-step, one
> step at a time :)
> 

To be honest, I'm concerned that you may be using QEMU as a staging tree 
for Mesa/virglrenderer. Submitting a documentation to QEMU as a 
preparation to submit one to Mesa is not OK.

You shouldn't submit a documentation to QEMU if upstream
Mesa developers rejects it because it contains too little information. 
It may not hurt QEMU, but still lacks a valid reasoning.

Mesa should have more people who care virtio-gpu as there are people 
using other VMMs and perhaps it may be difficult to convince them to add 
a documentation like this. It is still not a good idea to workaround 
that by adding one to QEMU. The documentation submitted to QEMU is 
mostly reviewed only by me, who barely used Venus and DRM native 
contexts, which is not a good sign. Getting reviewed by more people is 
one of the advantage of open-source contribution after all so let's keep it.

I can help you add a documentation to Mesa by reviewing and supporting 
one if you want, but I cannot support adding one to QEMU if it's done to 
avoid a potential challenge to add it to Mesa.

Regards,
Akihiko Odaki

