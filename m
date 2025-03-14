Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B7D6C282EC
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Mar 2025 21:15:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ttCMj-0004EZ-O6; Fri, 14 Mar 2025 17:14:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1ttCMc-0004Dv-Hx
 for qemu-devel@nongnu.org; Fri, 14 Mar 2025 17:14:43 -0400
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1ttCMa-0001KZ-JX
 for qemu-devel@nongnu.org; Fri, 14 Mar 2025 17:14:42 -0400
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-43d07ca6a80so709945e9.1
 for <qemu-devel@nongnu.org>; Fri, 14 Mar 2025 14:14:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741986877; x=1742591677; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0wJmvGjlSYsUOBrlOY9Jr1IghMpoUBzY7EoMKjxv48g=;
 b=gaUJ3vQ1+uynWRxikElNhi87FWTczSGpBuB20s1bsIL0ljEDDCMT9oe5vz1PO3uQL/
 GSkXIiSAsuD3tuY2OGa/1jmy1maBqd0guF5uCEAFtN31nIy1ssBtedOJHH/MnesG2YTl
 fAWH+CkhkKv2vXcii1pdqBNknYx+/363543OcdLT5eukQJM5nXEqpwDU7v7veJtN6e++
 izer4TzepyCYH9J8WsQf4LgTdMWveh19M44ZsTWzlGGyt3MXGwzjrXuLpnXSxbcNeLJ2
 tN3ejRd1aUBb9+evmKd6k2PexlG6pLyDRKy//D8J99Wmwqx4DM58Jh9LQxY1lKVb5LU1
 M45w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741986877; x=1742591677;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=0wJmvGjlSYsUOBrlOY9Jr1IghMpoUBzY7EoMKjxv48g=;
 b=a1jPFYBhC4XNNoeOR+SXUZwzzyuolTONukSGpPWmUfbfNedWpUnrXJExRz7v7em+m0
 ngNcX9kHbqkPIn/DxfIODjsiPhMqh5i8X7VHZyjUGLOPE4kcFxkBoeHbYDmm+htLYJwL
 dGhDEBDz3xN66hFZOSQOEq1xC5q6jcbQkiI8iDG4kG+RT00ifAeYpEVV0cmpltPhy46D
 A1Y7NfvSV+XH3VHKUTTnynhKQXTAdWdtu/064rgqFC50dmd7bWPY8VPz3OIvvbgsILCr
 dU0vLDcFMRsGy41h7CLi3VL5YD6K985KgVK0HIgSEUDWZ3M1xVcNJxUtyZZ6Y7IJ/nCf
 0gBQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUUf0ODI8aCoTZ/rBlfx9S4+FFbpgv/8fnJcxL0YLR51AJe55IWMBW64K8Kn3Pm2zUdPuRMWCY9Y1s9@nongnu.org
X-Gm-Message-State: AOJu0YxQMUhrU+5cwH0aI2410eBTG7A5rns6jt2u7/9jOvxGUW3oUuHk
 kV+ko6TuO50wDWu1EfZsge3O2OgCmEoW0JiqQ26tiAg115/Sk7Xh8oK1BCA0XGg=
X-Gm-Gg: ASbGncsVOic0BeLZ1+EIOk14b1fbRt0cxlSRwR++WeHi2LMPmNVeuw7IAaVrDyUiZcg
 Ha8PEK21jjkEBlL/oq9fUs+uo4Syoj+tAcOa6+NkSSS154toUByvVc5LrJLBNMyLt19f4Nd6mmT
 1f9Y1ElinOdrfvQvJjZIufAmmj9SMoAAzBddkeFc5pshOlPpRQYI/dBdiBsY0M60cQVYsN5lIDW
 Od4ROFvymyst7P+eYQWHLxIsvhAvIdyWSew3Qtjj+ND4Lv+DJhf6GyxEMjpqueZz81RiNe9Xw6V
 ty/WOkuAzdS0/9E/4zhNMCaJ2hyPYu1dPRaop9o4+XkNGzUbXpyji9QnvQ==
X-Google-Smtp-Source: AGHT+IGDRuWL5OdMBQOunEWgO2iXH4cVy8AaEVb13PDHojH/47AWQz0PzoUCVeh/WsG3qX+8yItwRg==
X-Received: by 2002:a05:600c:3c8b:b0:43c:f332:703a with SMTP id
 5b1f17b1804b1-43d1ed22601mr53972205e9.31.1741986877091; 
 Fri, 14 Mar 2025 14:14:37 -0700 (PDT)
Received: from draig.lan ([185.126.160.109]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43d200faebbsm28144495e9.30.2025.03.14.14.14.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 14 Mar 2025 14:14:36 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id A6FAC5F92C;
 Fri, 14 Mar 2025 21:14:35 +0000 (GMT)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>,  qemu-devel@nongnu.org,
 berrange@redhat.com,  Konstantin Kostiuk <kkostiuk@redhat.com>
Subject: Re: [PATCH] configure: disable split_debug on Windows and on
 non-git builds
In-Reply-To: <44fc2b85-ab20-401a-9c71-54240bb1e503@linaro.org> (Pierrick
 Bouvier's message of "Fri, 14 Mar 2025 12:12:08 -0700")
References: <20250314153824.65303-1-pbonzini@redhat.com>
 <44fc2b85-ab20-401a-9c71-54240bb1e503@linaro.org>
User-Agent: mu4e 1.12.9; emacs 30.1
Date: Fri, 14 Mar 2025 21:14:35 +0000
Message-ID: <87ldt7gvr8.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x32c.google.com
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

Pierrick Bouvier <pierrick.bouvier@linaro.org> writes:

> On 3/14/25 08:38, Paolo Bonzini wrote:
>> -gsplit-dwarf is reported to produce broken binaries on Windows.
>> The linker produces warnings but exits successfully:
>> /usr/lib/gcc/x86_64-w64-mingw32/14.2.0/../../../../x86_64-w64-mingw32/bi=
n/ld:
>> qga/qemu-ga.exe:/4: section below image base
>> /usr/lib/gcc/x86_64-w64-mingw32/14.2.0/../../../../x86_64-w64-mingw32/bi=
n/ld:
>> qga/qemu-ga.exe:/24: section below image base
>> and as a result qemu-ga.exe fails to start.
>> On top of this, also disable -gsplit-dwarf unless building from git.
>> Similar to -Werror, split debug info is probably not the best choice
>> for people that want to build for installing.
>> (Random thoughts: there is a tension here between adding an option
>> that is useful for QEMU developers, and messing things up for everyone
>> else by doing something decidedly non-standard.  For example, distros
>> are starting to create a fake git repository just so that they can
>> use "git am" to apply patches; while some of them, for example Fedora,
>> are wise, or paranoid, enough to pass --disable-XXX for everything and
>> then turn back on what they want, it cannot be expected that everyone
>> does this.  It may be safer to make --enable-split-debug default off
>> for everybody and add it somewhere in docs/.  For now I am keeping it
>> enabled but we could consider doing something different during the hard
>> freeze period).
>> Reported-by: Konstantin Kostiuk <kkostiuk@redhat.com>
>> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
>> ---
>>   configure         | 4 ++++
>>   meson_options.txt | 2 +-
>>   2 files changed, 5 insertions(+), 1 deletion(-)
>> diff --git a/configure b/configure
>> index 02f1dd2311f..9aece67ed08 100755
>> --- a/configure
>> +++ b/configure
>> @@ -1864,6 +1864,10 @@ if test "$skip_meson" =3D no; then
>>         { test "$host_os" =3D linux || test "$host_os" =3D "windows"; };=
 then
>>         echo 'werror =3D true' >> $cross
>>     fi
>> +  if test -e "$source_path/.git" && test "$host_os" !=3D "windows"; then
>> +      echo 'split_debug =3D true' >> $cross
>> +  fi
>> +
>>     echo "[project options]" >> $cross
>>     if test "$SMBD" !=3D ''; then
>>       echo "smbd =3D $(meson_quote "$SMBD")" >> $cross
>> diff --git a/meson_options.txt b/meson_options.txt
>> index 3432123fee2..f3546b9abc1 100644
>> --- a/meson_options.txt
>> +++ b/meson_options.txt
>> @@ -362,7 +362,7 @@ option('debug_mutex', type: 'boolean', value: false,
>>          description: 'mutex debugging support')
>>   option('debug_stack_usage', type: 'boolean', value: false,
>>          description: 'measure coroutine stack usage')
>> -option('split_debug', type: 'boolean', value: true,
>> +option('split_debug', type: 'boolean', value: false,
>>          description: 'split debug info from object files')
>>   option('qom_cast_debug', type: 'boolean', value: true,
>>          description: 'cast debugging support')
>
> Unfortunate coincidence, this appears at the same time MSYS2 fixed
> some issue triggering a segfault [1]. So I didn't investigate further
> the current issue, thinking something else have been changed I don't
> know where.
>
> Would be better to revert it completely indeed, creating another build
> configuration is not worth the (cheap) disk storage saved.

Well we should disable debug info on the CI builds then. Nothing is free
and our CI is pretty damned heavy and the builds all add up when debug
info is on by default.

>
> [1] https://github.com/msys2/MINGW-packages/issues/23577

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

