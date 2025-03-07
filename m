Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8328AC28B28
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Mar 2025 21:54:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tqfdl-0001nM-Ax; Fri, 07 Mar 2025 16:53:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tqfdj-0001n6-OL
 for qemu-devel@nongnu.org; Fri, 07 Mar 2025 16:53:55 -0500
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tqfdh-0001F2-Lw
 for qemu-devel@nongnu.org; Fri, 07 Mar 2025 16:53:55 -0500
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-43bc0b8520cso14403715e9.1
 for <qemu-devel@nongnu.org>; Fri, 07 Mar 2025 13:53:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741384432; x=1741989232; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=8/QBhpGd4oKIS4wag5OuC3xTrAPGu1jhF+FKNzj5rhk=;
 b=rMuvHBVGHHnCJjOHn9Pq8sYFuIo+bmYrQmFjhg07UXEF84d1VS2Vnwq8q0k/jyM5c3
 8X3VFfOiB+Kc9Xw0mZE0T5lfO3v24Ia3v1VdwD+kXopUNUCfjAgK0An8Z32mHt/RtrGQ
 wVSecLUZzgv1KBQTYte3h9zaV0yt0UWLwgD0Bi7F32ai0wblbaZsKky+x+mLOVqmiV/l
 /bUo8uYwunzh2Xhs0O5YLUOyMalTpbrlBToyQfGXGWcUgsJV0MejXvGZZi9CRu7/YLdX
 K1mbNQwjbYVHPrIlcigEhcUvxFgmGMXo5fRifn0XOoZ5jYrge5XWSlDSgNjT/MnJ7kyC
 G0Jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741384432; x=1741989232;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=8/QBhpGd4oKIS4wag5OuC3xTrAPGu1jhF+FKNzj5rhk=;
 b=sGV/tU2Z4aNKAG3qJq03L9P6emkjlrsNUY+gIt5/XD4fxCojSXY+NLFg+QdkfslhPY
 Lg5Ob4Mi2l/zAdtmHIi9NteYnWtqGoXQBDGv4J/pBnbI/pVkOVmL7DKg+SfHZOtpCE2b
 w1LOOdo86Izwmez9uYHPZ+DP1YOhfOuj3qqrOK3F4UE43iRQwqnK2jGUmSnybMrYxLW6
 Yj19kiyVfkLFcfmWJL/1/RpIep14BWwao1KXu2FRVBSApqmtd6WcOn5Rs+eaI/ZsPLVv
 0W/X7mp0F5EQibEwUhKlsvEaffe+1pC/djF83ZcUs4NyDiPy/fzsIi/fqUhrd5rOFoiU
 9/ZA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUH+GMoKyugfRDRMAArSVn4WH6rdMUUwtqhDsaMSCvlk1aG3t4k9mfaweiGGtPfCTUG/Y7CiKFEbKH3@nongnu.org
X-Gm-Message-State: AOJu0YyStRUs6V6mlqBsWLUSOEHPPHtcwAZFwNKOqaH3cLt82lM0dJOq
 l5IhNAy0rDLFQvQMYL9AzbJpg3r6nHVzUo4mDrjJsIY8fhcodSnNR0Xxi5Z+tsk=
X-Gm-Gg: ASbGncuwwYRPG+JNzhUll4Cg00QfDpE1mQiAqDo0mK8VRzJtkJgsQUkyEVWMH+XFrOv
 a9hH4+5RrdIZFJfMBGWFsrKFzZ0B4EocpvA7IZxjSFpKAF5gvCH6oEomO6dlaSqNi4t/7+hXB4e
 lNUdlKDEyvN1ujgArspBc9B9nzEEOQ/hLy/vkOdB7ZW4txUfit667NXisVZp9nEUIegez1+HIno
 AS6yW8SMCIHdR464Us8kgwW8PHVfb3tBF3KNNf8Q3uWRwMXbCJSggRB2WNCsqvUxMwR78fLnL+m
 CKwkrybu+vSrWYvDCDquwmViqi7lumW0eZZHfHIMFtxrHffUdGMvIlLAnVOiGvhXKiO1Am2fWBa
 Rn9WHDLrcSScy
X-Google-Smtp-Source: AGHT+IFrKeof4SALalLoDbum099MMFGPvPGRkWAgtEfbyIScOE4d85n9obZ2W4qNQYI46HMe6oUKaQ==
X-Received: by 2002:a05:6000:188c:b0:391:2f71:bbb3 with SMTP id
 ffacd0b85a97d-39132db782cmr3268573f8f.46.1741384432280; 
 Fri, 07 Mar 2025 13:53:52 -0800 (PST)
Received: from [192.168.69.199] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3912c0e2f44sm6445131f8f.76.2025.03.07.13.53.51
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 07 Mar 2025 13:53:51 -0800 (PST)
Message-ID: <a76de2e3-fee8-4e5e-ab8b-a8afa434757b@linaro.org>
Date: Fri, 7 Mar 2025 22:53:51 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: make check-functional failures with --enable-rust: unsafe
 precondition(s) violated: NonNull::new_unchecked
To: Peter Maydell <peter.maydell@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>
References: <CAFEAcA8ozGhFJWc41M6ziB3mPtEQ_bpWcQTCj1Ue_W66-MYf2w@mail.gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <CAFEAcA8ozGhFJWc41M6ziB3mPtEQ_bpWcQTCj1Ue_W66-MYf2w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32e.google.com
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

On 7/3/25 19:24, Peter Maydell wrote:
> I noticed that 'make check-functional' for arm targets doesn't all
> pass when QEMU is built with --enable-rust:
> 
> 11/46 qemu:func-thorough+func-aarch64-thorough+thorough /
> func-aarch64-aarch64_virt            TIMEOUT         720.03s   killed
> by signal 15 SIGTERM
>   9/46 qemu:func-thorough+func-arm-thorough+thorough /
> func-arm-arm_tuxrun                      ERROR            51.71s
> exit status 1
> 30/46 qemu:func-thorough+func-arm-thorough+thorough /
> func-arm-arm_vexpress                    ERROR             1.62s
> exit status 1
> 44/46 qemu:func-thorough+func-arm-thorough+thorough /
> func-arm-arm_replay                      TIMEOUT          90.02s
> killed by signal 15 SIGTERM
> 
> The first of these is the virt/gpu breakage that's not Rust related.
> 
> tuxrun fails because of a Rust panic, though:

[...]

> Is this a known issue ? (I'm using git commit 98c7362b1efe.)
> 
> Here's the RUST_BACKTRACE=1 version:


> (side note: should we set RUST_BACKTRACE=1 for our
> make check/check-functional infra? it would probably be better
> to capture the backtrace in the logfiles rather than needing
> the user to re-run by hand, especially for the CI case.)

I agree, and Stefan also suggested that:
https://lore.kernel.org/qemu-devel/CAJSP0QWJ=qkA2Bzih7nGq5K=YrJRqUOt85RAGL=mj3MEjAW6ug@mail.gmail.com/


