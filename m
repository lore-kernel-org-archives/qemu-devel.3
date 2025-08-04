Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 514EFC87FCB
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Aug 2025 18:42:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uj07I-0002w3-Iz; Mon, 04 Aug 2025 14:41:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uiyYm-0003wt-Ei
 for qemu-devel@nongnu.org; Mon, 04 Aug 2025 13:01:22 -0400
Received: from mail-pl1-x62c.google.com ([2607:f8b0:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uiyYj-0008SW-ND
 for qemu-devel@nongnu.org; Mon, 04 Aug 2025 13:01:16 -0400
Received: by mail-pl1-x62c.google.com with SMTP id
 d9443c01a7336-23636167afeso30340535ad.3
 for <qemu-devel@nongnu.org>; Mon, 04 Aug 2025 10:01:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1754326871; x=1754931671; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=2GuumWBMsYZXS9/3GFrOhzvSx5QB81wAgEaNbjkkZ/E=;
 b=gZb4WVIIooqZvLRQNFkc2pjDGwZ8wva1pzFn984KWhw2pElwNakM01BkW6FfoYKZw0
 4xhGRwF/823lA3tNu/JjvYOfjfM9ZkVKyECj7BZxTBl8PeauyRIh/P2idAwAFaB25PuP
 4xpj2VfoOZC9wtsY2bRIDDcWyPy6q97dhZEXBfh0kct2PU6ZCkBjjEHWkSkld6kdILUx
 TpXWn/xVvBN+MwwGQnM3Itzj4mATvbhYZWu5vSWFWDBA7w0XqONbgr4+GB6FWJwEnvWM
 2M/gsIMC7Yu0kNzn7nvG55UFcWMJ6+y9toyR/8KjksGAz7EHxIGoW9wViZ85wBMrZZlG
 0MCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754326871; x=1754931671;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=2GuumWBMsYZXS9/3GFrOhzvSx5QB81wAgEaNbjkkZ/E=;
 b=hPNPpgQr4nwpbH2Bzbh3FyKlCbtr7aiO1muzKGDYy+amciptPtzCu5JlzShbUfLpgl
 1qnQBXpIksd1hfrizC5sezeyzjHi6rHdGCrYVGx9X4DMXKEFfm4EO81VJM/lxlj5ENW4
 v/Wqgl/wQDLRkbCiqVZJf0dwl4TnitarqMzcsspF9c2y/rqDFV33c7C5Rb5pSpAZgNiv
 mBFYsZu9PUIsP76ne8C1qRyi10n74N+s04ZDpVM3879g5mrmt8Rgn9pxENAT1glTaIWX
 RbvYgqphKNZNH4eRTFI5giiPd32QIav7pgtaRJw1c40jqJiLfmeV3P1VcTAJTvgMG77d
 yMhA==
X-Forwarded-Encrypted: i=1;
 AJvYcCU17xHzq4OETOwsy7CqiPGcSPlgihptebU8fL0wIMJR6vo+QbcjECILz+4s+bSkoPFhxhQJ1WArV4Vn@nongnu.org
X-Gm-Message-State: AOJu0YwpDm5b+nyZvyZrJFkQEihC+P+ZZXAYuJP1S5g90Zploy8W/zar
 DLW2uA+ZBfCe9AAMKqEkqOhnomAJXlZA2nAEIUhIs5YvIO2/m7Bzrj7TiVG/YsPKmry5rdsnxLp
 l4hbu
X-Gm-Gg: ASbGnct4CGwMJqiEbMfkYP06kCUab8dvGTMEGnqyQ45JZaKngY2WWB0G3EF24czQYT8
 cOFFLgqH/s6gvu1GKri+h2I9K9EtpfxJpdzfes4bfEdWpl9mEyuAcEgkh3V6coRjwzOf2Hfo4YW
 6kyS75OhkpHdYn6FaoGqY6e9jcmWkxPHsiNJu5S4mNyXjzZcvMPCO94WbE+4lA7w0EZ9nblyY9s
 2/YiXdMncEi28WIVb+oHsT2YnNAK+DLUAvrPkzjvz11rZhRv+xNraax6gH7PigVC7DNflQAkVQv
 hmLLjl6lHXN9OmK1NKFZTrpSGmCb6+qYjyPBAWZPZ0oqkQWk1PuIl6+XkyujBHOJ7aPQfAw0uCE
 LGQM+Zmn8yK124dei6BbkTv7eXYHOcDQE3MQ=
X-Google-Smtp-Source: AGHT+IHJH+/i5sytnIG3xtCpKh1AiA3gGfckZw3bPJMREgPXvUOk80J1rBJ/xhvTrVmQ/hTMQAOiVg==
X-Received: by 2002:a17:902:ea10:b0:240:3c62:6194 with SMTP id
 d9443c01a7336-24246f6a8famr127352035ad.20.1754326870863; 
 Mon, 04 Aug 2025 10:01:10 -0700 (PDT)
Received: from [192.168.1.87] ([38.41.223.211])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-241e8ab3da8sm113603395ad.175.2025.08.04.10.01.10
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 04 Aug 2025 10:01:10 -0700 (PDT)
Message-ID: <4807d308-ec22-4e00-a91a-9c59f39e9830@linaro.org>
Date: Mon, 4 Aug 2025 10:01:09 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: New capabilities for plugins
Content-Language: en-US
To: Florian Hofhammer <florian.hofhammer@epfl.ch>, qemu-devel@nongnu.org
References: <205e6753-53a4-4739-99ed-26344403a437@epfl.ch>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <205e6753-53a4-4739-99ed-26344403a437@epfl.ch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62c;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x62c.google.com
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

Hello Florian,

thanks for your interest about QEMU plugins.
As you noticed, we recently expanded API to be able to modify state of 
executed program/machine. Before that, plugins were limited to observe 
what is happening, without allowing any modification. One of the reasons 
if that it might break QEMU in subtle ways, but we came to realize that 
benefits are worth the risk.

On 8/4/25 3:14 AM, Florian Hofhammer wrote:
> Hello,
> 
> I'm currently working a lot with QEMU plugins for dynamic analysis of
> userspace binaries (i.e., running under qemu-user). While working on
> that, I found that the QEMU plugin API luckily has been getting more and
> more capabilities with recent versions but that I'm still lacking some
> functionality for my use cases.
> More specifically, the "vcpu_syscall_cb" and "vcpu_syscall_ret"
> callbacks already allow me to instrument syscall translation entry and
> exit points. While the register read/write APIs also allow me to modify
> register contents in my syscall callback implementations, there is
> currently no good way to emulate a syscall myself in the plugin or
> explicitly set the syscall return value (as it will be overwritten with
> the original syscall's return value again, even if I set the
> corresponding guest register).
>

The vcpu_syscall_ret callback is called just at the end of do_syscall 
(before returning value), so this is why the value does not get overwritten.

If you replace the returned value at the right point, which should be 
the next instruction after svc (instruction callbacks are called 
*before* instruction is executed), this should overwrite the return as 
expected.

> I was wondering whether the QEMU community would be open to extending
> the plugin API so that a plugin can fully emulate a syscall without the
> original syscall being executed by QEMU. I had multiple approaches for
> that in mind, with some working patches locally that I'd be happy to
> share and build such a feature on:
> 
> 1. Change the API of the existing callbacks so that the syscall entry
> point callback returns "bool" instead of "void" and if any of the
> registered callbacks returns true, execution of the actual syscall is
> skipped.
> 2. Introduce a new API function that sets a flag for a specific syscall
> to be skipped:
> 2a. A function that's called once in the manner of "always skip the
> syscall with this specific syscall number" or
> 2b. a function that's called every time in the syscall entry point
> callback in the manner of "skip this specific instance of the syscall".
> 
> I'd be happy to get your opinion on those proposals and to
> develop/submit the corresponding patches!
>

Before talking about the how and what, it could be useful to explain why 
it's needed to replace syscalls.

It's not clear for me how a program can do anything useful if we replace 
real syscalls with fake stubs or skip them. Could you give us a bit more 
details about your work and goals? This will help going in the right 
direction for what you need.

> Thanks in advance and best regards,
> Florian
> 
> 

Thanks,
Pierrick

