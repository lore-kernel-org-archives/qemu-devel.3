Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F01351067022
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Mar 2026 13:57:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w0gWQ-0008Q6-1q; Thu, 12 Mar 2026 09:56:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1w0gWJ-0008Lp-MF
 for qemu-devel@nongnu.org; Thu, 12 Mar 2026 09:56:11 -0400
Received: from mail-wr1-x430.google.com ([2a00:1450:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1w0gWH-0004kj-Rf
 for qemu-devel@nongnu.org; Thu, 12 Mar 2026 09:56:11 -0400
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-43a03cb1df9so382427f8f.1
 for <qemu-devel@nongnu.org>; Thu, 12 Mar 2026 06:56:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1773323767; x=1773928567; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PA8mhn3Pz1xs8wzDfjld8pN5y/jy18MoXVEm3yW6CSI=;
 b=d42NWMGbK6l7mzFsckcfk+mQTPqctZjkMb6QOWc1DTxuN+l0g7vRRJjz//URRn4LpI
 iKesv8136e5Ss36aPZh2HDE4rwBGy8hiRRWRKR7Vnyq8hHHYlYIeFwCnRD5CI/ChP09F
 xzCO+HCmkq834tcgiAsMxTzeHRVXf2/Ak6JSD2Rh01aCOUQ1uT9ntjdQc0u2OyS95sHL
 s2HzjU/H4cu+6Qi5nYeIkHFxli+CelOhhqIORicxXGXvaEBsTHNcDgkpl1ISWpVe5Hq8
 NcRQkhkcF31m00/iNWiGeMg4xNsdWVK76aSt9a6xLSbW2oEYV5KTpvf6drFBKehRZhdN
 hT0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773323767; x=1773928567;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=PA8mhn3Pz1xs8wzDfjld8pN5y/jy18MoXVEm3yW6CSI=;
 b=KQhbjJkK1djEfQJzxUTkPcEMsub4lmasPWXdMugzQzNK3124pVdxX/fGqVep90oTD5
 JK+1PhsOBIyBS134yqn0Gc3DH/2LhqLrJhhN2yPZciCgpZIwuDXCUeBdoONaqu0bZkCw
 1aSgNEuYPw3bDeysVRxTSwPFiSLPNYqh8QsI9ylxjvjlDIcoL2k3wK1/2y5XvhSXfk9Z
 g0zC88jaxJGnI694gP+ZujfwLcg+0tvG9dUmNkrXttvzbSmWPe03EdNQYPhGQ+cz3oPe
 FoEiJHDKH6xSWPStAd+rDrS5RAir+bQKcC1Cy2XkkJ4N+cvSLDb4xD74GWnmRoFse/wk
 SQsg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWKLkWisTJG+vK8mw1LPW70lt0quzIffkr5nJsAXmsLFouINFLpnpePlkVoho/21XbPeq3DC5JcsrOJ@nongnu.org
X-Gm-Message-State: AOJu0Yx+31sd/WfK+6S7A4B579ZV/7WssV/ujnavYsATq12sj4NSfrsn
 O91R9fcVhkiWQbGuri+Rl0BzxMlp4RHGsea9LOUCFZUiT4VKgR6kOlP6f/vM/FM25yo=
X-Gm-Gg: ATEYQzzi7vnOUEPgfAP3Iq7Z+MQiZ8xA5ia7Z2oY5RAFhJIsFwst/WRKz/QJfEkdR6p
 Dw5rXzn8wMm3pnUtN4ksxE/9iLn4+WY/Vp0D0rUh+JLn1HaqMGiJhqzCxzB8Cz5sMMR0F4L2TVe
 rgq3ZD0OU3z8Dv+V425sZ8LfKej6ClK0KtULtZPnA8SYwwYthlrGT2v5FFjl7lCiT22o+B5wppH
 C5PQRKzM7knSATzWzbS18O/sqQTO7QZhkLyQXGWrqg4BZcvHUnvapx1J7OwYysVGlR5sf6eaFfW
 hJDqOQnTTZdWTc0dHCa0qWVcr6JN8hXHv8NWDJ3tOkycvLJZ9Pfi2sVHF6GUXouLaprMyYg5A1s
 PG47xnsBcdJTqXdnn009QyubtkNs/SbShWAmbOe+sqxhhveVgwF79W2QFAoY5zDU42gEDhxKuMg
 Ae/ycQVSoSDHT+AncCUsISH0/9FTrFJZ//Kg==
X-Received: by 2002:a5d:588e:0:b0:439:c5ee:cb5b with SMTP id
 ffacd0b85a97d-439f821de3dmr12118180f8f.40.1773323766908; 
 Thu, 12 Mar 2026 06:56:06 -0700 (PDT)
Received: from draig.lan ([185.124.0.237]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-439fe19acc6sm8672703f8f.8.2026.03.12.06.56.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 12 Mar 2026 06:56:06 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 5ACC65F7A0;
 Thu, 12 Mar 2026 13:56:05 +0000 (GMT)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: Ilya Leoshkevich <iii@linux.ibm.com>,  Pierrick Bouvier
 <pierrick.bouvier@linaro.org>,  qemu-devel@nongnu.org,  Brad Smith
 <brad@comstyle.com>,  qemu-arm@nongnu.org,  Kyle Evans
 <kevans@freebsd.org>,  Paolo Bonzini <pbonzini@redhat.com>,  Peter Maydell
 <peter.maydell@linaro.org>,  Thomas Huth <thuth@redhat.com>,  Warner Losh
 <imp@bsdimp.com>,  Daniel P. =?utf-8?Q?Berrang=C3=A9?=
 <berrange@redhat.com>
Subject: Re: [PATCH 1/7] tests/docker: add gdb-multiarch to all-test-cross
In-Reply-To: <CAPMQPEKPk1iySmCt0_Vi1=bcaG_ZkNfzYknCu14zzR2N7p-6zw@mail.gmail.com>
 ("Philippe =?utf-8?Q?Mathieu-Daud=C3=A9=22's?= message of "Thu, 12 Mar 2026
 11:41:44 +0100")
References: <20260306161728.2657486-1-alex.bennee@linaro.org>
 <20260306161728.2657486-2-alex.bennee@linaro.org>
 <78c8b024-6dd5-4f1b-a19c-c7a71c7acc9f@linaro.org>
 <7e6cdb4b-4cb8-4968-acce-56db2f0ee307@linaro.org>
 <97506340-18a4-4691-8017-110ab2fc76b8@linaro.org>
 <3c2bf09d-245c-4de7-b55d-37085ef24545@linaro.org>
 <c776bbc1-6021-45d0-a5ca-74e50d906f4f@linux.ibm.com>
 <1493fdd5-5254-4398-bb69-8c83eee8bef2@linaro.org>
 <CAPMQPEKPk1iySmCt0_Vi1=bcaG_ZkNfzYknCu14zzR2N7p-6zw@mail.gmail.com>
User-Agent: mu4e 1.14.0-pre2; emacs 30.1
Date: Thu, 12 Mar 2026 13:56:05 +0000
Message-ID: <871phpi22y.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::430;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x430.google.com
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

Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org> writes:

> On Thu, 12 Mar 2026 at 11:39, Philippe Mathieu-Daud=C3=A9 <philmd@linaro.=
org> wrote:
>>
>> On 12/3/26 11:11, Ilya Leoshkevich wrote:
>> >
>> > On 3/11/26 00:28, Philippe Mathieu-Daud=C3=A9 wrote:
>> >> On 11/3/26 00:22, Pierrick Bouvier wrote:
>> >>> On 3/10/26 4:07 PM, Philippe Mathieu-Daud=C3=A9 wrote:
>> >>>> On 10/3/26 23:33, Philippe Mathieu-Daud=C3=A9 wrote:
>> >>>>> On 6/3/26 17:17, Alex Benn=C3=A9e wrote:
>> >>>>>> This allows the gdb integration tests to be run as well.
>> >>>>>>
>> >>>>>> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
>> >>>>>> ---
>> >>>>>>    tests/docker/dockerfiles/debian-all-test-cross.docker | 1 +
>> >>>>>>    tests/lcitool/refresh                                 | 1 +
>> >>>>>>    2 files changed, 2 insertions(+)
>> >>>>>
>> >>>>> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
>> >>>>
>> >>>> I'm getting:
>> >>>>
>> >>>> Python Exception <class 'gdb.MemoryError'>: Cannot access memory at
>> >>>> address 0x45001fff
>> >>>> Error occurred in Python: Cannot access memory at address 0x45001fff
>> >>>> qemu-hppa: QEMU: Terminated via GDBstub
>> >>>> make[1]: ***
>> >>>> [/builds/philmd/qemu/tests/tcg/multiarch/Makefile.target:121:
>> >>>> run-gdbstub-prot-none] Error 1
>> >>>> make[1]: *** Waiting for unfinished jobs....
>> >>>> qemu-hppa: QEMU: Terminated via GDBstub
>> >>>> warning: Could not load shared library symbols for linux-vdso32.so.=
1.
>> >>>> Do you need "set solib-search-path" or "set sysroot"?
>> >>>> make: *** [/builds/philmd/qemu/tests/Makefile.include:66:
>> >>>> run-tcg-tests-hppa-linux-user] Error 2
>> >>>>
>> >>>
>> >>> To add more information, we tested it on GitHub, our machines and
>> >>> GitLab, and for an unknown reason, it only fails on GitLab runners.
>> >>
>> >> Also we tested on our local Linux machines, where this test pass
>> >> for all our targets ;)
>> >>
>> >>>
>> >>> Which is unfortunate since it is where QEMU run its CI.
>> >>>
>> >>> Regards,
>> >>> Pierrick
>> >>
>> > FWIW it passes on my laptop as well.
>> >
>> > Does this test fail only for hppa, or for other architectures as well?
>>
>> Have a look at these job failures:
>> https://gitlab.com/philmd/qemu/-/pipelines/2376819801
>>
>> Python Exception <class 'gdb.MemoryError'>: Cannot access memory at
>> address 0x7e085b4b1fff
>> Error occurred in Python: Cannot access memory at address 0x7e085b4b1fff
>> qemu-aarch64: QEMU: Terminated via GDBstub
>> make[1]: ***
>> [/builds/philmd/qemu/tests/tcg/multiarch/Makefile.target:121:
>> run-gdbstub-prot-none] Error 1
>> make: *** [/builds/philmd/qemu/tests/Makefile.include:66:
>> run-tcg-tests-aarch64-linux-user] Error 2
>>
>> Python Exception <class 'gdb.MemoryError'>: Cannot access memory at
>> address 0x40802fff
>> Error occurred in Python: Cannot access memory at address 0x40802fff
>> qemu-arm: QEMU: Terminated via GDBstub
>> make[1]: ***
>> [/builds/philmd/qemu/tests/tcg/multiarch/Makefile.target:121:
>> run-gdbstub-prot-none] Error 1
>> make[1]: *** Waiting for unfinished jobs....
>> make: *** [/builds/philmd/qemu/tests/Makefile.include:66:
>> run-tcg-tests-arm-linux-user] Error 2
>>
>> Python Exception <class 'gdb.MemoryError'>: Cannot access memory at
>> address 0x45001fff
>> Error occurred in Python: Cannot access memory at address 0x45001fff
>> qemu-hppa: QEMU: Terminated via GDBstub
>> make[1]: ***
>> [/builds/philmd/qemu/tests/tcg/multiarch/Makefile.target:121:
>> run-gdbstub-prot-none] Error 1
>> make[1]: *** Waiting for unfinished jobs....
>> qemu-hppa: QEMU: Terminated via GDBstub
>> make: *** [/builds/philmd/qemu/tests/Makefile.include:66:
>> run-tcg-tests-hppa-linux-user] Error 2
>>
>> Python Exception <class 'gdb.MemoryError'>: Cannot access memory at
>> address 0x7d742025efff
>> Error occurred in Python: Cannot access memory at address 0x7d742025efff
>> qemu-alpha: QEMU: Terminated via GDBstub
>> make[1]: ***
>> [/builds/philmd/qemu/tests/tcg/multiarch/Makefile.target:121:
>> run-gdbstub-prot-none] Error 1
>> make: *** [/builds/philmd/qemu/tests/Makefile.include:66:
>> run-tcg-tests-alpha-linux-user] Error 2
>>
>> So at least Alpha / ARM / Aarch64 / HPPA.
>>
>> (I haven't checked whether the test is run for other targets).
>>
>> We also run these on GitHub runners where the tests pass, and apparently
>> when running on k8s private runner on GitLab they also pass. The problem
>> is with public runner on GitLab.
>
> Also another test we ran was to pull GitLab docker image and run the same
> tests locally within that GitLab-generated image and they passed. So we
> believe the issue is related to some container restriction with
> GitLab.

Most likely because the ptrace settings are tighter - ptrace is the
mechanism we use to access the memory we can't normally.

>
>>
>> > I'm asking because it may have something to do with /proc/self/mem or
>> > with the architecture.
>> >
>>

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

