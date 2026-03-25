Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 877FA103A9A7
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Mar 2026 11:22:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w5MIw-0006Gz-87; Wed, 25 Mar 2026 07:21:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1w5MIo-0006FD-MU
 for qemu-devel@nongnu.org; Wed, 25 Mar 2026 07:21:34 -0400
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1w5MIm-0008FH-BL
 for qemu-devel@nongnu.org; Wed, 25 Mar 2026 07:21:33 -0400
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-482f454be5bso7477225e9.0
 for <qemu-devel@nongnu.org>; Wed, 25 Mar 2026 04:21:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1774437690; x=1775042490; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=CvKEVKcv7f3BzA/1Uh0nPdE2w3AyCFo2zjW38XFHqq8=;
 b=ygBpsBp+F2Axxz+BeoVH/zIeBJD3FKO1XbF+pNgiK+4Emgv0fABvF6JAc4eSXie9HU
 CI5IkeMpmCv+/26XRBZfsPs6X4ABSTWRLgBTPDofGxrcHT/kyiH07d5EhDVG4coGrkbO
 vPp6R51YYETDauwfAvWsz5Zuc72hWqh4INp30ZDo1SXBmDY6U6asFqT5NOTkog0l0nd3
 +niCOhatugcNqepFT1ARxgxIeOl/431FRZaqLWM/wYOctnHhjnb+idC4E805qnwnnH1o
 5Z+KzMDoHu7f6WmHY9H8i2gMdKTWvmn8Y+PD/RJOy6z/pCfKKLmGIb0uCmXy5q9+Vosz
 q6Mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774437690; x=1775042490;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=CvKEVKcv7f3BzA/1Uh0nPdE2w3AyCFo2zjW38XFHqq8=;
 b=EiUeJ/WpuZzPPI4HVLgJuS6tgis6+xKMxCruDv0XZAFGIyQpYN/83nMdffG6nCEaks
 S962Ury4+kxkCs/4HIRHsOOV4p40X98Fd/6bOaCKDjBKO4GFx2f29SQN2VlHI0C/mOsI
 wvGdi1/pq5fI7qqoIAQ0cOCeeZDV+IxRHs4Ehbu+lhJ8vCaQY8rpTEuUvlqgvgUTHJZi
 PYcy5uNF+DW6dGeFPLwz7E7p8A1IJ8IGGjmD1dFN4kwVq+QJXZjVUnlN/YrTF9a2l5cy
 QQLDBOyX05AbBqiU7leukke+KI0N3oNz4V25FXtn7VQQaUvLnfUhWIhJaLp/jVxLideO
 o9Cg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWYn3Oq9mOUbD3neVU5vaPzksrvuvtImz3gmvEwfVHpAyfEC/Pu0mcAxi9zaMQ+nvzwifxivkbnlmx6@nongnu.org
X-Gm-Message-State: AOJu0YxldKfOAcpKMcr19YDjf8s3Sg2MraP1D1uAUZ+qcuUuA0Ke0Uz/
 2vxpsxE7tfgpmozoo8TI8rgDA6oGvLGUGrgaCbdHTU2tVhcx+4YVCUuoFrU5/NzPDsk=
X-Gm-Gg: ATEYQzyaZBNUEmoaTE9M48v10AOKTTh3tphQooD3ibKN4EwCVYIUUSgxq856XEkK9XJ
 AVNVOhJm7ngCBymqY985qZaRkie8RUsqAAjlUdSlufyFUIEXHUfAfYVo7/rStk+shUyZOTbzp+O
 5yZa0IXuxWIRv3L6X2azC6cCLGP/4/DDu+KNW95fB0fLQo01JO1ZSJv8nUlkxzSfJIRIDrbxycT
 /fjrq99bbN3dUgP7Qa291SK/0alD/m5uXnSPVWRbd5RMAh015UDwoJ241V5hpuNirOIMg8+rCWA
 Rdo5r9auld1HucjZH2OhvvROwHop3IzJpS0WpPXFNa79tt06RrLDSCeR+5rX+qJ7xKwXI08N4Nl
 wP/TXuv1DbtwAnr9cEmqI7P67WbtQmMjjXvtvbiTuog8Sw/VZYeEl1T0nxQT452qjb6AzLQ+IX3
 9YvrrTTGpgJphgddI/i8c/ciOghErVXtVJlfjAq0R/BIvAY3BgutLlCqB2MQGzn2zawQ==
X-Received: by 2002:a05:600c:4f89:b0:477:9890:9ab8 with SMTP id
 5b1f17b1804b1-48715fc75b2mr40446795e9.3.1774437689570; 
 Wed, 25 Mar 2026 04:21:29 -0700 (PDT)
Received: from [192.168.69.229] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48711701804sm126251425e9.4.2026.03.25.04.21.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 25 Mar 2026 04:21:28 -0700 (PDT)
Message-ID: <d2db3893-7691-4707-8f43-341d09ceac97@linaro.org>
Date: Wed, 25 Mar 2026 12:21:27 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: QEMU requires a 64-bit CPU host architecture?
Content-Language: en-US
To: Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-block <qemu-block@nongnu.org>
Cc: Michael Tokarev <mjt@tls.msk.ru>, QEMU Development
 <qemu-devel@nongnu.org>, Richard Henderson <richard.henderson@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
References: <2c0d6ae0-eb06-4eed-87fe-0954ae59d951@tls.msk.ru>
 <fc32bb67-ea52-4244-9ad7-c18db3be339e@tls.msk.ru>
 <acOoVWw3jXfkfion@redhat.com>
 <CAFEAcA-Jzh0Wan9Dh+Pe9S3cHPeexV5mLaD+juXS8L9eMMd43g@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <CAFEAcA-Jzh0Wan9Dh+Pe9S3cHPeexV5mLaD+juXS8L9eMMd43g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x334.google.com
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

On 25/3/26 11:24, Peter Maydell wrote:
> On Wed, 25 Mar 2026 at 09:19, Daniel P. Berrangé <berrange@redhat.com> wrote:
>>
>> On Wed, Mar 25, 2026 at 11:08:41AM +0300, Michael Tokarev wrote:
>>> On 20.03.2026 09:45, Michael Tokarev wrote:
>>>> Hi!
>>>>
>>>> Is it intentional that qemu does not build utilities on 32bit hosts
>>>> anymore?
>>>
>>> This is
>>>
>>> commit 372ec46b9f1215f48a4717f2b7ed969f65bfadc6
>>> Author: Richard Henderson <richard.henderson@linaro.org>
>>> Date:   Thu Dec 18 09:56:27 2025 +1100
>>>
>>>      meson: Reject 32-bit hosts
>>>
>>>      32-bit hosts have been deprecated since 10.0.
>>>
>>> How would one build qemu-img and especially qemu-guest-agent, say,
>>> on i386 or armhf?
>>>
>>> I tried removing this error message from meson.build (in $subject),
>>> but it fails to build even the qga due to errors in atomic.h, -
>>> even if these aren't used by qga.
>>>
>>> That smells like a bad decision, - to drop qga and qemu-img support
>>> on 32bit architectures.  Especially qga.
>>
>> IMHO dropping the block related tools is reasonable, as if you keep
>> that, the dependencies that need to remain 32-bit compatible ripple
>> out across a very large part of the codebase.
>>
>> Not having qga though feels like a pretty undesirable consequence,
>> given our message overall is that we were dropping host support but
>> keeping 32-bit emulation.
> 
> Yes, I'm not sure we quite realised that we would be no longer
> building QGA for 32-bits. How much effort would it be to
> reinstate that?

 From the commits in 5053e0a65db...90e2e8ada7c we'd need to (partially)
revert various of the buildsys ones (meson & configure).

Then we'd need to check if the Stat64 API (90e2e8ada7c) was used by
the block tools, and if so also revert the atomic64 patches (around
997d86a9bb1). If not some (sane) refactor is needed for some core
components (disentangle qdev from qom due to the atomic uses). Still
we rely heavily on atomic helpers for threads and co-routines used
by the block layer (and also to reference the QOM objects...).

How / where would we test that (and for how long)?

