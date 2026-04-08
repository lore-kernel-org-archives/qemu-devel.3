Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DFB6B10F9969
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Apr 2026 19:32:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wAYRH-0008D6-EM; Wed, 08 Apr 2026 15:19:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wAY2X-0005gc-G0
 for qemu-devel@nongnu.org; Wed, 08 Apr 2026 14:54:13 -0400
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wAOJ0-0000Rq-AQ
 for qemu-devel@nongnu.org; Wed, 08 Apr 2026 04:30:35 -0400
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-488b3f8fa2bso8786375e9.1
 for <qemu-devel@nongnu.org>; Wed, 08 Apr 2026 01:30:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1775637032; x=1776241832; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=ZAnMxxL01N5IxoKOxbsSfYCOflB6CsqQ85mcmel8rIA=;
 b=KufkOnXmKmntMDmgqf75+kf1TANqxLQoicjxHJmdqvuaj6y7U6MN3OjZ+p9DmuWGi4
 t0tVA25AmjzMtz6uZG5fd6ymw+UVcvMVtn8rlFto6bbM16rkL6dNErQ4F6TcYhbulHAP
 L7T51N+YlP1l07G3k72eJco3rRUBzGH0CAOgklPVXd4vNYal8yWK+j3cQ8/gpOaIURnz
 4zC7eNXsPj4bPXNM/EPLanpbJx1sp2KMjmMaQvxk7r6yik6BcNSW81Sn4MWGd58jqSTH
 LfJ7aFOyWxbSWt2O9q0R7MwINo82zX4GgF9c0mguEn1oYI2B8anBWi/VMoO5TG91twd1
 EYyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775637032; x=1776241832;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ZAnMxxL01N5IxoKOxbsSfYCOflB6CsqQ85mcmel8rIA=;
 b=Tzx6r0q/wWB2qDQBLZ+HgQFk8ht1vR511vBr5DT3kpDpkrI5GuGhVhVeTexr/7heRC
 wr6FG9FG9MVUbS/Ejtf0j8cKLcBaBWDvuXUM3a1Xo1aLTI/MIf9x1hTPD/by7oV9Lc2+
 CjcQ/t64VE0CxLGFiL/j4YXnJuCPjYZKLaBzqt3p8D40970B+TL5h9NJHYyGqNJByNxE
 rPI0W/JWmZURhU2W7DxCMkqYuOdIoOo1UMQt0EhO1czjP+rpxlC8TanQ28Dbr+p+qDh1
 Rt6cbu574EgZQ+vUETzhItmZ3PT/poSHcWMLKMyiui8fvqeB1shOFTUQR/n2N07+q6ND
 L2tA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXJEaVpN6iewH9IIVR76xzOQe0fYuqrvmKVx9tsn0ZImj6zsARspD2NKYjFammLdmlR2lu1SpsTIQWe@nongnu.org
X-Gm-Message-State: AOJu0YzMMJE1wxGYrez0wj00MP6rTao87W+AXrraDX69F0YjkvTc5Ti6
 SeSZYXTco551BwpBzevp95vGUZ/Ie0E0ArhNxPpEr9XQzIk3N95BJFDnCZPJZmbY2wM=
X-Gm-Gg: AeBDies1es6yKXHgseQFbZ2aKdpG+g3Zez8PDwobS30LhdOnJqgXaKPezF+VmHhbryB
 DTvW7hrOQ94BWz8ScWSLG7RTDeg/XSla+KfTB3AV9dNMeCbqopqQwzGce5il8k2b55z2JaLgWwR
 sJmLbTKbndSQ5UvdYbuzW25lqxDb6mj6r+xxTYwIXqKFhRHy5RDcgtLptoP+K5+yUNg7d/AXvOh
 0QqBrwo5LsvqnWkVgvT59U0IVuRVf261XTdYlu7Mf3lPfKtWHRse1JG+8O3y8cgqgI0PyvUV66x
 UWBPYkzep79EJLJMsXEWsNwC3bVNfMp4EVSinFXF5gLO0ThJZuvde+X869JPZq9xIgqA3Pfx2by
 JlrgQ71xwZ8xmMBgM++QviweSawFl+u09mn+YjHBgMSpRQc0MLEp0WeHnt6VPkaFZPXZMuPGcJ5
 woFCYuPoBeRSZRbwkYk4gbGMRsVJzdRp2mlih02AUienqmSsSI7yuNVL0oX6EacDFLmg==
X-Received: by 2002:a05:600c:5289:b0:487:22ad:403e with SMTP id
 5b1f17b1804b1-488994b34b4mr292359145e9.14.1775637032224; 
 Wed, 08 Apr 2026 01:30:32 -0700 (PDT)
Received: from [192.168.69.228] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-488b739e00bsm218508645e9.10.2026.04.08.01.30.31
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 08 Apr 2026 01:30:31 -0700 (PDT)
Message-ID: <b31f28a1-1475-4022-9cad-31c6d90d5d80@linaro.org>
Date: Wed, 8 Apr 2026 10:30:30 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: =?UTF-8?B?UmU6IOWbnuWkjTogUmU6IFtQQVRDSF0gYXVkaW8vcGlwZXdpcmU6IEZp?=
 =?UTF-8?Q?x_stack_overflow_by_moving_buffer_to_heap?=
Content-Language: en-US
To: Thomas Huth <thuth@redhat.com>, =?UTF-8?B?5Za75Yab?= <yujun@kylinos.cn>,
 "marcandre.lureau" <marcandre.lureau@redhat.com>,
 odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Cc: "mark.caveayland" <mark.caveayland@nutanix.com>,
 qemu-devel <qemu-devel@nongnu.org>
References: <a1npd7r5807-a1so0q5obt4@nsmail8.2--kylin--1>
 <944cccdf-68f1-4565-9647-59cae7fb3fb8@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <944cccdf-68f1-4565-9647-59cae7fb3fb8@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32a.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 8/4/26 08:43, Thomas Huth wrote:
> On 08/04/2026 08.31, 喻军 wrote:
>> Hi，Thomas：
>>
>> Thank you for reviewing the patch.
>>
>> Just using AI to describe it, you know, my English is not very good.
> 
> Ok, that's fine!
> 
>> I am currently pruning and optimizing qemu with the aim of reducing 
>> its memory usage.

You are not "reducing" memory usage, simply moving from stack to heap.

If any usefule, "reducing" would need to remove RINGBUFFER_SIZE
uses completely and use the frame length provided by the 
AudioMixengBackendClass::read/write/...() handlers.

> I happened to discover the large memory allocation 
>> of this stack and am trying to propose a new solution.
> 
> Could you please still point me to the function where this array is 
> allocated on the stack? ... I did not spot it in the code...
> 
>   Thanks,
>    Thomas
> 


