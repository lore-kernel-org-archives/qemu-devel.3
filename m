Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C613FED2FE
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Mar 2026 10:42:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w0dUX-000690-2F; Thu, 12 Mar 2026 06:42:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu-daude@linaro.org>)
 id 1w0dUO-00065R-IF
 for qemu-devel@nongnu.org; Thu, 12 Mar 2026 06:42:01 -0400
Received: from mail-oi1-x232.google.com ([2607:f8b0:4864:20::232])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu-daude@linaro.org>)
 id 1w0dUM-0004iS-Iu
 for qemu-devel@nongnu.org; Thu, 12 Mar 2026 06:42:00 -0400
Received: by mail-oi1-x232.google.com with SMTP id
 5614622812f47-4671cbce626so428524b6e.1
 for <qemu-devel@nongnu.org>; Thu, 12 Mar 2026 03:41:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773312117; cv=none;
 d=google.com; s=arc-20240605;
 b=AnFx0azpa+EB3vW7VV1eo8BqUamEZxDjXNOgwBNlqDdq36T05Ory8ZeAuvZw1uNeqw
 y1RX0LNF2gYyRK1U3LFjc2QYMUC51hPoXTKsY1KAw4IkUCoMBmaBLDAIAnQRoFvOpPYR
 GOuFy8FBjaLV+BeS0mn3/mLq3kxEL1Do3YFX8bqyHbN5aIE4taJkKFcXWZkzQLdfJz9w
 VkYnMBLvUUWunWZrt9ooAOpjfbgIvABAasnmpM+voTxP3C1tE2FkVpez0MYOrkKqq2ls
 caAXu6hbo5ioSfHsCYZvvMLIa8EA8fs61F9uc731v1RWZd3fVKiKBJ7DZHKhBPGxNXNO
 sSlA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=Twiaz5YwQvCCXrClL7BJMAyTvcDxdAp97EtxNjxbYh4=;
 fh=mwbspBOyPbBIUrcz4+lhe7CF4vgzQtFmlICn8Zmc0MA=;
 b=PseN/YcC7RgUvfBWQk2CoofkoWVLQ0pl+5uxypo22+J8/J7X2a90sd7S7r4zo/B4FL
 kZgcQeQAtKXJq38TqRU56HidNp7lddA7OUXvMX7nj78yejoRt7vkIuvU9emCStVyok4b
 cTiWoDlbkdEnn7AM0jbqoCbNA4HKl8PQk29d1pVegweo+Ta4raawP3NLvM3p5r8Hd4Et
 4BFvJXxodPHC1B27bJa4Ovab696RtVGieAQxK+11Sns1dgUQIwZcAEGB0FNG53PlCJFL
 LbpQYbJxsZhO9H1ptDYjZgJEZk7kbOYM/7BXgzJv7hcSjxzaGZMdd1JfWCfWyQwe+UYe
 FyZg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1773312117; x=1773916917; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Twiaz5YwQvCCXrClL7BJMAyTvcDxdAp97EtxNjxbYh4=;
 b=JvNItalZX3le0K+vBiZP+6DuQEyg1xiSleh1MRIwXo0vDtk90cD2xwJDXUJxXszY3r
 eqIF43VwOm/9s0AAqQokGpCnfDape+EMGqZGjGV680STJ28Pg8w8lYG84yLcNf0cqGdF
 1tiX+ZXIFatsL5Xz0xZmpSovWzSMjjgB5AuaHuO94T4aN6uc1lqvihKlONdD5zzwtHOr
 huptzSdxyy+ROJW7P8F+woyKzKOVNg9TmEuMSbTWZ7Ekibd4XVHYmlQU3k23HQn+DN91
 x6pzAYh6n9Y9eoTV5li2YPHvlteqSgILVzkAtZiwg82WoDE9CpeWe2xPILPWyMulKwU6
 IYQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773312117; x=1773916917;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Twiaz5YwQvCCXrClL7BJMAyTvcDxdAp97EtxNjxbYh4=;
 b=t4sxoVXbCu4PR4s5jXPrY0xnewywkyhlujYuWjWg2F8SrraDAH1WtblMZvABqrGXhO
 E1yc3dcoh0A9rnYYrUe0ZAYUohuoPibbFViucnWM6xpmfpPBv2d+DdG5xTG1Y/GnEfVx
 YzZAlTE8ByXCK3kxQVMPNJp2JH4jS+mY+LEURD8aAFdeoPLu4hZ5c7CAfPiL05k2Cmye
 ddQcn6HaXeiDbsDJOaW715fF1xm0yWwmRP9K2rpax7ZlQ3qaIuQAuBjOuIixnNEqfI0L
 mwexvD7mYKEPOtRrvDm0qYwDUlGtPm/Q4rteg98B7F1js1Iv5umYTvFPurE+mgRGBDYo
 IhkQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVI93Rml/+rbwx8dKyMg/6F++iKMFuh6X++s1vK3gu/T8P47Yne0gBxUmJTOIrMwS8NJBWRG0u09vqz@nongnu.org
X-Gm-Message-State: AOJu0Yw/mHIpqiSN+ISFhr0RPIeH36Ofl3yU4zGDGXs6HZHlLWTo/pUE
 py5/vhKsZmi6T+5fgQuc7uCqqY5RmIt7EuLpKxbSiUXz2Tx4YQZGR26kIrRq7p4soYOfBKjZPqd
 XLEFGficAcEDNTKbdbgpU5V1hIPgl+37ogtfRy9WURg==
X-Gm-Gg: ATEYQzw/RHiwL2++44EldAFO8hS0DvntpV/kRq86VZSpJu0naFWaV0H7bZNUeSBKW4I
 B7eDQmGqT+0RQT7YbXRQ0CBf78yGVRGGKY8FPpmnClkjCOuW9E1VJiOjDJ146W7fHMmQ3Ipm5nE
 2mLkxxqSeftTTe/qtFcBqGzSXQfbWiPF7V5ioVHZX63yvftxJxrFws8g+b9O/bz2XqnMJ/pskqe
 8gfxQb4XwsmVLG4ugBF8w/b/zCTeusHE8dhGK38euy8dUG01nSVvmQc1W95vXDwkRkmKlLixmD4
 xer5mHIGozblEgNbZA==
X-Received: by 2002:a05:6820:4deb:b0:679:e7b2:9fc2 with SMTP id
 006d021491bc7-67bc8877588mr3369800eaf.10.1773312116504; Thu, 12 Mar 2026
 03:41:56 -0700 (PDT)
MIME-Version: 1.0
References: <20260306161728.2657486-1-alex.bennee@linaro.org>
 <20260306161728.2657486-2-alex.bennee@linaro.org>
 <78c8b024-6dd5-4f1b-a19c-c7a71c7acc9f@linaro.org>
 <7e6cdb4b-4cb8-4968-acce-56db2f0ee307@linaro.org>
 <97506340-18a4-4691-8017-110ab2fc76b8@linaro.org>
 <3c2bf09d-245c-4de7-b55d-37085ef24545@linaro.org>
 <c776bbc1-6021-45d0-a5ca-74e50d906f4f@linux.ibm.com>
 <1493fdd5-5254-4398-bb69-8c83eee8bef2@linaro.org>
In-Reply-To: <1493fdd5-5254-4398-bb69-8c83eee8bef2@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Date: Thu, 12 Mar 2026 11:41:44 +0100
X-Gm-Features: AaiRm50JzZHcvlOUtB-EjRaqETmulbvHWdBVv8NVkYvVXr-KN5U_gGk0GQWSiBk
Message-ID: <CAPMQPEKPk1iySmCt0_Vi1=bcaG_ZkNfzYknCu14zzR2N7p-6zw@mail.gmail.com>
Subject: Re: [PATCH 1/7] tests/docker: add gdb-multiarch to all-test-cross
To: Ilya Leoshkevich <iii@linux.ibm.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, 
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, qemu-devel@nongnu.org
Cc: Brad Smith <brad@comstyle.com>, qemu-arm@nongnu.org,
 Kyle Evans <kevans@freebsd.org>, 
 Paolo Bonzini <pbonzini@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, 
 Thomas Huth <thuth@redhat.com>, Warner Losh <imp@bsdimp.com>, 
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::232;
 envelope-from=philippe.mathieu-daude@linaro.org; helo=mail-oi1-x232.google.com
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

On Thu, 12 Mar 2026 at 11:39, Philippe Mathieu-Daud=C3=A9 <philmd@linaro.or=
g> wrote:
>
> On 12/3/26 11:11, Ilya Leoshkevich wrote:
> >
> > On 3/11/26 00:28, Philippe Mathieu-Daud=C3=A9 wrote:
> >> On 11/3/26 00:22, Pierrick Bouvier wrote:
> >>> On 3/10/26 4:07 PM, Philippe Mathieu-Daud=C3=A9 wrote:
> >>>> On 10/3/26 23:33, Philippe Mathieu-Daud=C3=A9 wrote:
> >>>>> On 6/3/26 17:17, Alex Benn=C3=A9e wrote:
> >>>>>> This allows the gdb integration tests to be run as well.
> >>>>>>
> >>>>>> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
> >>>>>> ---
> >>>>>>    tests/docker/dockerfiles/debian-all-test-cross.docker | 1 +
> >>>>>>    tests/lcitool/refresh                                 | 1 +
> >>>>>>    2 files changed, 2 insertions(+)
> >>>>>
> >>>>> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
> >>>>
> >>>> I'm getting:
> >>>>
> >>>> Python Exception <class 'gdb.MemoryError'>: Cannot access memory at
> >>>> address 0x45001fff
> >>>> Error occurred in Python: Cannot access memory at address 0x45001fff
> >>>> qemu-hppa: QEMU: Terminated via GDBstub
> >>>> make[1]: ***
> >>>> [/builds/philmd/qemu/tests/tcg/multiarch/Makefile.target:121:
> >>>> run-gdbstub-prot-none] Error 1
> >>>> make[1]: *** Waiting for unfinished jobs....
> >>>> qemu-hppa: QEMU: Terminated via GDBstub
> >>>> warning: Could not load shared library symbols for linux-vdso32.so.1=
.
> >>>> Do you need "set solib-search-path" or "set sysroot"?
> >>>> make: *** [/builds/philmd/qemu/tests/Makefile.include:66:
> >>>> run-tcg-tests-hppa-linux-user] Error 2
> >>>>
> >>>
> >>> To add more information, we tested it on GitHub, our machines and
> >>> GitLab, and for an unknown reason, it only fails on GitLab runners.
> >>
> >> Also we tested on our local Linux machines, where this test pass
> >> for all our targets ;)
> >>
> >>>
> >>> Which is unfortunate since it is where QEMU run its CI.
> >>>
> >>> Regards,
> >>> Pierrick
> >>
> > FWIW it passes on my laptop as well.
> >
> > Does this test fail only for hppa, or for other architectures as well?
>
> Have a look at these job failures:
> https://gitlab.com/philmd/qemu/-/pipelines/2376819801
>
> Python Exception <class 'gdb.MemoryError'>: Cannot access memory at
> address 0x7e085b4b1fff
> Error occurred in Python: Cannot access memory at address 0x7e085b4b1fff
> qemu-aarch64: QEMU: Terminated via GDBstub
> make[1]: ***
> [/builds/philmd/qemu/tests/tcg/multiarch/Makefile.target:121:
> run-gdbstub-prot-none] Error 1
> make: *** [/builds/philmd/qemu/tests/Makefile.include:66:
> run-tcg-tests-aarch64-linux-user] Error 2
>
> Python Exception <class 'gdb.MemoryError'>: Cannot access memory at
> address 0x40802fff
> Error occurred in Python: Cannot access memory at address 0x40802fff
> qemu-arm: QEMU: Terminated via GDBstub
> make[1]: ***
> [/builds/philmd/qemu/tests/tcg/multiarch/Makefile.target:121:
> run-gdbstub-prot-none] Error 1
> make[1]: *** Waiting for unfinished jobs....
> make: *** [/builds/philmd/qemu/tests/Makefile.include:66:
> run-tcg-tests-arm-linux-user] Error 2
>
> Python Exception <class 'gdb.MemoryError'>: Cannot access memory at
> address 0x45001fff
> Error occurred in Python: Cannot access memory at address 0x45001fff
> qemu-hppa: QEMU: Terminated via GDBstub
> make[1]: ***
> [/builds/philmd/qemu/tests/tcg/multiarch/Makefile.target:121:
> run-gdbstub-prot-none] Error 1
> make[1]: *** Waiting for unfinished jobs....
> qemu-hppa: QEMU: Terminated via GDBstub
> make: *** [/builds/philmd/qemu/tests/Makefile.include:66:
> run-tcg-tests-hppa-linux-user] Error 2
>
> Python Exception <class 'gdb.MemoryError'>: Cannot access memory at
> address 0x7d742025efff
> Error occurred in Python: Cannot access memory at address 0x7d742025efff
> qemu-alpha: QEMU: Terminated via GDBstub
> make[1]: ***
> [/builds/philmd/qemu/tests/tcg/multiarch/Makefile.target:121:
> run-gdbstub-prot-none] Error 1
> make: *** [/builds/philmd/qemu/tests/Makefile.include:66:
> run-tcg-tests-alpha-linux-user] Error 2
>
> So at least Alpha / ARM / Aarch64 / HPPA.
>
> (I haven't checked whether the test is run for other targets).
>
> We also run these on GitHub runners where the tests pass, and apparently
> when running on k8s private runner on GitLab they also pass. The problem
> is with public runner on GitLab.

Also another test we ran was to pull GitLab docker image and run the same
tests locally within that GitLab-generated image and they passed. So we
believe the issue is related to some container restriction with GitLab.

>
> > I'm asking because it may have something to do with /proc/self/mem or
> > with the architecture.
> >
>

