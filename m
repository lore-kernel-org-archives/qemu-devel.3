Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A28AC677C4
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Jun 2025 17:04:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uP27n-0002ul-9j; Tue, 10 Jun 2025 12:46:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uP0MQ-0005QA-T5
 for qemu-devel@nongnu.org; Tue, 10 Jun 2025 10:53:59 -0400
Received: from mail-pf1-x429.google.com ([2607:f8b0:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uP0MO-0008Ks-KQ
 for qemu-devel@nongnu.org; Tue, 10 Jun 2025 10:53:58 -0400
Received: by mail-pf1-x429.google.com with SMTP id
 d2e1a72fcca58-747c2cc3419so3929772b3a.2
 for <qemu-devel@nongnu.org>; Tue, 10 Jun 2025 07:53:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1749567233; x=1750172033; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=sLbR6oc+On5Mq6zpnUUQIMWRLD1RcyCjq2IEay9viWA=;
 b=dInfK68cO66lZeOeYITY1AJVUpA52GUZf2wAzoPDq6tjFMSHYpinDlaoJYWLexlwko
 CknaKUtImocRwFAFJjFYH/pcPjI+kJ3k8KfUwnwpKVjhKQs0m8z7HYKbFstbv2u5L0Xt
 KE2d76usN3wPJLCGx9JLcTNjWVaSmsIxlyw3zEqUo1WGMWaB9cyvCwuQNPJlg6Gr0SeH
 b8anWPc6QInDdQXvplC0Oq19t6PtIMqtctblUXl5LG6T0go2LMrK8f/K210LuHkEJbu8
 N/v84rQh7xn3W75nvKeroZyBDWi83pViD9+gRNBeg13Aoup5X1CHoe6MTmgMdvNZnghi
 +7kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749567233; x=1750172033;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=sLbR6oc+On5Mq6zpnUUQIMWRLD1RcyCjq2IEay9viWA=;
 b=UeYvOPNspP6kDgT9m/uR8HGoi1O5Q6ZrpgdP8As+NjuxTM18PRJN7Px5SyTCFxvnMT
 yIbRSbtTLkELDAQkEotr1//20nGylr5uPIN0FNnPXl/zIVEk/fa3/nx3tdGLRZt2QseE
 b5EC5gLMGKmq+/2pUlREPQXSZoUfakH/Nt3g+oLJ1uTMsBskad72TSkzYboiCsO+Wi9m
 NyOEdvIGm1wvM5peB7mCUqY0yIZTWZmE4r176moha5zO9nHZ59QoPJWaZH0e9r+OukTQ
 5/Zu8zxDIaqJMMmTRgAhQC4hZiRv9pT6WL8SDEebL3PeVlwJ7RwoZMkkN91avR0k45F4
 UkIQ==
X-Gm-Message-State: AOJu0YxAY7VquZ9HHCDsspkcmarq9icTH/Yr9AOQtn64wco7a41lp8HZ
 P+eM7PZUHG6+Aygns9nhkcV8uijR4ZjVeeNqJifnVBMvNkL9v0ggroBjAueqkj6Q16o=
X-Gm-Gg: ASbGncueXJvGRH+ZVylmTPbxtF5Ly+RigFkYyGdZ75XAu7VZrS1OsD6rcpRkZPyU/eQ
 A0Tjvd0I56SzjORksE961/EdVmp/6mPQMuGmzEr5FYtSvUo4AssJneAvvJgLcqLi3Dlupuq1WOW
 1Hd8DRbjt6nmKdZ9mXl59YZD0TbyVYSQ7rMLQ7qC2g5ZbE/dNthSlIENV9kMzNy+GDPi30hJghL
 joc2ulfKkZ3578EgusPMxqz4FMoK748URT3ldU0YR26Dyv1wwlQtujuVLK9csbR66tTQOHKZSWc
 6VX3IeK7y6FP21eAS+4BdgxtG7mYs7BI5l8b2MBP4LkwGN7AddnIdkhI4cMGpWNtngtaOWZUNx8
 =
X-Google-Smtp-Source: AGHT+IGfgDE4yJRZdn2k3SW/MkvgFzLx7RChz6WAbj0e6LY1RNp17Zx8bvfTTm1TeTxcVj3FjzHUQw==
X-Received: by 2002:a05:6a00:9a3:b0:747:b043:41e8 with SMTP id
 d2e1a72fcca58-74827f12808mr21781849b3a.15.1749567233447; 
 Tue, 10 Jun 2025 07:53:53 -0700 (PDT)
Received: from [192.168.1.87] ([38.41.223.211])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7482b0f3e59sm7759943b3a.178.2025.06.10.07.53.52
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 10 Jun 2025 07:53:53 -0700 (PDT)
Message-ID: <6edebc63-4b64-42b1-acdc-c70a9f58cb9f@linaro.org>
Date: Tue, 10 Jun 2025 07:53:52 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RESEND v3] meson: fix Windows build
Content-Language: en-US
To: Oleg Tolmatcev <oleg.tolmatcev@gmail.com>
Cc: qemu-devel@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>,
 Mads Ynddal <mads@ynddal.dk>
References: <20250607094503.1307-2-oleg.tolmatcev@gmail.com>
 <878ac7c5-6729-4930-a64f-19cf0e10f7f2@linaro.org>
 <CACcXsZgSdLNUovP_Cz7vAU+E=KzaJ6tLCKFhm1xQpQpKO5h=2Q@mail.gmail.com>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <CACcXsZgSdLNUovP_Cz7vAU+E=KzaJ6tLCKFhm1xQpQpKO5h=2Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::429;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x429.google.com
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

On 6/8/25 1:23 AM, Oleg Tolmatcev wrote:
> Am So., 8. Juni 2025 um 02:43 Uhr schrieb Pierrick Bouvier
> <pierrick.bouvier@linaro.org>:
>>
>> On 6/7/25 2:45 AM, oltolm wrote:
>>> Sorry, I forgot to cc the maintainers.
>>>
>>> The build failed when run on Windows. I replaced calls to Unix programs
>>> like ´cat´, ´sed´ and ´true´ with calls to ´python´. I wrapped calls to
>>> ´os.path.relpath´ in try-except because it can fail when the two paths
>>> are on different drives. I made sure to convert the Windows paths to
>>> Unix paths to prevent warnings in generated files.
>>>
>>> Signed-off-by: oltolm <oleg.tolmatcev@gmail.com>
>>> ---
>>>    contrib/plugins/meson.build         |  2 +-
>>>    plugins/meson.build                 |  2 +-
>>>    scripts/tracetool/__init__.py       | 15 ++++++++++++---
>>>    scripts/tracetool/backend/ftrace.py |  4 +---
>>>    scripts/tracetool/backend/log.py    |  4 +---
>>>    scripts/tracetool/backend/syslog.py |  4 +---
>>>    tests/functional/meson.build        |  4 +---
>>>    tests/include/meson.build           |  2 +-
>>>    tests/tcg/plugins/meson.build       |  2 +-
>>>    trace/meson.build                   |  5 +++--
>>>    10 files changed, 23 insertions(+), 21 deletions(-)
>>
>> Are you building using msys2, or another environment on Windows? I'm
>> curious to know in which configuration the build is failing.
>>
>> In case you use msys2, maybe you're simply missing some packages. Our
>> documentation explains what to install [1].
>> Building out of msys2 on Windows is not recommended, as this is the only
>> maintained setup (tested in our CI, and maintained as an msys2 package
>> by msys2 maintainers) for this system.
>>
>> [1] https://www.qemu.org/docs/master/devel/build-environment.html
> 
> Yes I do use msys2, but I only use bash for the initial configuration.
> Afterwards I just call meson and ninja from "cmd" not from bash.

Maybe it's because it's complicated to execute a single command from 
msys2, and return. Using the -shell parameter of msys2_shell, you can 
pass arguments to bash.

cmd.exe /c c:/msys64/msys2_shell.cmd -defterm -here -no-start -mingw64
   -shell bash -c 'ls / /tmp'

That said, I'm not opposed to the current series, I just wanted to 
understand what is the context.

Thanks,
Pierrick

