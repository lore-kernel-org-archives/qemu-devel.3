Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C760C531CC
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jul 2026 18:03:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wmxl3-00080q-EM; Thu, 23 Jul 2026 14:02:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1wmxl2-00080g-1m
 for qemu-devel@nongnu.org; Thu, 23 Jul 2026 14:02:56 -0400
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1wmxl0-00006q-7m
 for qemu-devel@nongnu.org; Thu, 23 Jul 2026 14:02:55 -0400
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-4955158f26aso6694255e9.3
 for <qemu-devel@nongnu.org>; Thu, 23 Jul 2026 11:02:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1784829771; x=1785434571; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :user-agent:references:in-reply-to:subject:cc:to:from:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=ikQe1U6KlmcryjT6GmKPLhZl9M9JWji221reG0KAI+g=;
 b=QWsUWLzomRqzryyEw2mzdR7mdgBaTt6TIn251XH9Nnm/xO5UCUf6R9bnizfLGApn84
 jXo0g8kb30R7BCqhWAOAH3V/WE43A5lkFWifUllTARWTl0Fu4wOWDTdPpfUfsivNd5Sc
 f6uZLu5WBZiB44mNIz/tdj+iRczvJZxNzG5zLKAWfIYWoaxbexcZ2XTcI/g2jeQYolo1
 ya1FIrjsXT4z+UJrSRe5YmyX113bg+04A/AHwjBpbwcX05OBXmJ4YVjCTsVRPudlfxh7
 xooS55O9wYw4A98YDUsUWLPkw6rD8KbonY0mK2xJnXvctnYeoDwmFM7krzBhdBNG11+p
 Vobw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784829771; x=1785434571;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :user-agent:references:in-reply-to:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=ikQe1U6KlmcryjT6GmKPLhZl9M9JWji221reG0KAI+g=;
 b=PJMESs50VdAJgN1XbuokqKp4ixaqzHnsUrWQ+zH6B5yrzcbniQduIWFBYWqruJK4R1
 XKQxBTCvrdnkH5QaN+MFIGLGnQUpUPx14ib+9rR3ggAYrQO/IiY0+rWCquPwB07tm03X
 GaYX2OVjIgo/NjynyoA4/nphJyma74D6s+GXMfabAmpTzg7jZPwhGr1c6goFA/4dGdAK
 JdErch6h7VODs1xnEe2lH9Tq+XnCg4JdYniG5fVsc23RO3KuXcZD3CU2yZgL9b1jZ5hU
 Uvyg+K+Cw4JKCqvYxRdL/apAoaYGW0lEmhHBGDyuRM1K7kFIuZGrjD9N7w4BYuG02/c1
 RzmQ==
X-Gm-Message-State: AOJu0YwrWgDVXyP235ZbQcMRIAnHYCD7XJ685vsc2LetFCoxjuhG0XJc
 GlmM8fDpDpUqjS2HzUttLyFWjo5dSt3OTxS2wIjr9CmAggJ44KW4DUan1Gg66S5i3d0=
X-Gm-Gg: AR+sD10eHgTdmXpTvWWCxRdETT5bxa1YgLjD23YtOWKo6tMM8f95AzEw6Pd2ha3Pn6l
 PF2IZKCEmtNSpFI5Z0mIvVFNz2iElwze5YZL5gDuLTJywEiWmoRchz2uZXdQlrZvt3BiJDr2CHr
 b0ocxUw3odPxqZWlGc/ayJ0R8FaK6MQemlErfaEqa7E5PpqGMFKPd62jSBOkgGQdC0CAzjiBfo4
 dtfOTwEW3HtgRgLofvSKBb/i5JCIRmz/8i0iZQkUFwh/Lldl8srFP92BayuxBNJz8QzqI8nKtOE
 L4HQJmeSZi6q+IPbyeZ/e68BBigJvBI0IsWIOekDYqnfaqi0TFF5f3nrDJTGZQnQ4ZqqEUrnCWB
 k0Fg5UtpAr1otqdXF78s6I1HidTdBi2bTqrcLz69pwq76sbeVw3unYJ3sYolhcTfFeb0N3sDf4O
 l/sg==
X-Received: by 2002:a05:600c:654b:b0:492:437a:a653 with SMTP id
 5b1f17b1804b1-49573cff7c9mr32860895e9.26.1784829770399; 
 Thu, 23 Jul 2026 11:02:50 -0700 (PDT)
Received: from draig.lan ([185.124.0.114]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4957b5f3665sm4300015e9.2.2026.07.23.11.02.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 Jul 2026 11:02:48 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 7138F5F7C2;
 Thu, 23 Jul 2026 19:02:47 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org,  Brian Cain <brian.cain@oss.qualcomm.com>,  Peter
 Maydell <peter.maydell@linaro.org>,  Philippe =?utf-8?Q?Mathieu-Daud?=
 =?utf-8?Q?=C3=A9?=
 <philmd@oss.qualcomm.com>,  Daniel =?utf-8?Q?P=2EBerrang=C3=A9?=
 <berrange@redhat.com>,
 Thomas Huth <thuth@redhat.com>,  Ilya Leoshkevich <iii@linux.ibm.com>,
 Richard Henderson <richard.henderson@linaro.org>,  Manos Pitsidianakis
 <manos.pitsidianakis@linaro.org>,  Laurent Vivier <laurent@vivier.eu>,
 Paolo Bonzini <pbonzini@redhat.com>,  Gustavo Romero
 <gustavo.romero@linaro.org>,  Helge Deller <deller@gmx.de>
Subject: Re: [PATCH v5 97/98] configure: remove --cross-cc* options
In-Reply-To: <c16b4480-06fd-4d96-b628-5c423d300988@oss.qualcomm.com> (Pierrick
 Bouvier's message of "Thu, 23 Jul 2026 09:33:19 -0700")
References: <20260710214343.2065491-1-pierrick.bouvier@oss.qualcomm.com>
 <20260710214343.2065491-98-pierrick.bouvier@oss.qualcomm.com>
 <87wlupst0e.fsf@draig.linaro.org>
 <0ed09a8f-2de8-4910-b853-cd717dbf3317@oss.qualcomm.com>
 <87se59r999.fsf@draig.linaro.org>
 <c16b4480-06fd-4d96-b628-5c423d300988@oss.qualcomm.com>
User-Agent: mu4e 1.14.3-pre1; emacs 30.1
Date: Thu, 23 Jul 2026 19:02:47 +0100
Message-ID: <87mrvhr3co.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x333.google.com
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

Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com> writes:

> On 7/23/2026 8:55 AM, Alex Benn=C3=A9e wrote:
>> Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com> writes:
>>=20
>>> On 7/20/2026 6:14 AM, Alex Benn=C3=A9e wrote:
>>>> Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com> writes:
>>>>
>>>>> Those options were useful a few years ago, before containers were
>>>>> available as an alternative for missing cross compilers. Simplify the
>>>>> workflow by removing those options and maintaining only the container
>>>>> based approach.
>>>>
>>>
>>> I was expecting some discussion around this patch, and to start it when
>>> the comment comes. Question is "Should we provide this feature or not?".
>>> I totally agree with you that we need to support other configurations we
>>> have in our CI, like MacOS and compilers from homebrew.
>>>
<snip>
>
> The way I see it is that we offer native cross compilers (with a focus
> on debian at the moment), and the containerized ones: people have a choic=
e.
> We can add any additional compiler name for other distros.
> Also, as Ilya mentioned before, cross compiler on fedora, for instance,
> are not providing any sysroot. So it makes them unusable in our case.

No sysroot at all - even for compiler headers? We don't need the linux
sysroot for building softmmu tests.

> So I'm not sure which other distro you would like to support that is not
> (alpine, arch, slack, other?).
>
> In all cases, just let me know what are your exact requirements (distro
> list and set of compilers) and I would be happy to make it work just as
> you expect on all those platforms.

That's not really the point. I use Debian, partly because its range of
supported cross compilers is so great. But we don't have a
comprehensive survey of all the systems potential developers could have
and with this change we now say they have to jump through hoops to be
able to compile something when they likely have a cross-compiler
available.

And of course non-Linux systems are far less likely to have podman or
docker available. MacOS doesn't by default, Windows? BSDs? BeOS?

>
>>> I think it's a saner choice, because one problem with --cross-* is that
>>> it allows people and maintainers to have their "own" setup, that are not
>>> documented anywhere. By forcing compilers to be added to dockerfiles and
>>> paths to be explicit in arch files, we make sure the same CI is
>>> reproducible for everyone.
>>=20
>> I agree the ideal is everything is dockerised for CI but there are times
>> its not practical:
>>=20
>>   - working with very new features on bleeding edge compilers
>>   - binary only toolchains for the more niche architectures
>>   - unable to run any containers
>>   - running the test inside containers (this is why
>>     debian-all-test-cross has qemu-minimal pre-reqs)
>>
>
> The point of containerization is to hide those details in a reproducible
> recipe. For instance, we could definitely provide bleeding edge gcc to
> have the latest features.
>
> If test relies on a specific machine setup, it's basically dead code: CI
> and other devs can't run it. That's why containerization is important.

For CI yes - but not for someone developing something and writing tests
they may never even upstream.

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

