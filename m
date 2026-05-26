Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5139CCD5BC8
	for <qemu-devel@archiver.kernel.org>; Tue, 26 May 2026 10:47:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wRpJp-0007jW-Hi; Tue, 26 May 2026 06:47:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1wRpJn-0007j4-Q4
 for qemu-devel@nongnu.org; Tue, 26 May 2026 06:47:27 -0400
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1wRpJl-0005yL-TS
 for qemu-devel@nongnu.org; Tue, 26 May 2026 06:47:27 -0400
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-490426d72f7so37337835e9.3
 for <qemu-devel@nongnu.org>; Tue, 26 May 2026 03:47:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779792444; x=1780397244; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1OuTu71O+a92onUemZiUDqg/Kn/1kwKgwFUodFC5Hq0=;
 b=awq2eb/gN292mV5p1dMegO/bXA/VI7IrKPMBeY6jzu4jieVxrMzCY6L1LBrjpUR77Y
 WJTqgh+lyk9hMTaEonr/1Kj+6eYW5BkLWyXWWrndCTHZSaQMHC8/Rqp5D6XDBDrSuPbT
 gfsv8FnThJF33a9p0C3i8tBz0QQdlQsxlLWzrXKk2MCOpMVm6mEW7HY/BMUd6+9d7jt6
 ImTrP1dmS6SlnQfBsjzZfjm1stqj2cBAPqEabhjYLPtEUTXii0nsg3hFhMKYup7D1sp4
 G94iRp9wfFo4hG3da2s841g3cFpAOFo/BRRPzv1vU+oSF90FpDegcBXd6qcm5h3cvC5T
 u5vQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779792444; x=1780397244;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=1OuTu71O+a92onUemZiUDqg/Kn/1kwKgwFUodFC5Hq0=;
 b=kYrG9lcAwD/RDJoowaTiyZQIyhXTTIJtZ0ZSdFxEKfUVzQJS7ojkFWqxJzIRDjiqE5
 NUlI8gOx+XG7jT9mqVYMSeATaRKjWjVgQxTkywL7w7k96cKChysNsAjFRgjOiQ0Mi47N
 IYePdKQqWVVFscr8EzcrrKKzX+fYGojocj7PZTysZgP4B1kp8NK2VQy7y8vYjQhs+DnB
 BLj1HJROorNLigFKIDQdDklbANluM4hz4ovajvNwJGy2ATLA5q+pzX2aRxNr5V2DOt8r
 AZnlRO69BmmRqzPqlATQRYHIzZ3pSTYgDQx6eK8xn5yB/MtV4La4q7NQnj6UdaaIhyRZ
 gOaw==
X-Gm-Message-State: AOJu0YyTe8OoSJD+pp8ABNHVWkKmZct8+ku/qoXjsL+Cco8aaoSNskX1
 YX+r7PGUxdWPnQx7vn3KheNk5FV00yOT+dmNtderNrW3N2UQv+XhJSNtxmzHMVN7kVY=
X-Gm-Gg: Acq92OHozYiHnWInTs20dcVSvid3jxxis56bRKSnkZX/S4YSC4/wLrcpQV1tDtHesN8
 3sUgeNtz+mQr4N3r14iW0tzKRRf4+KgJjeoktFIAxk+l0Svm3TJ8VYIky72ku7F190B5sJMiPOJ
 LIyH3tcUlSWxdXJXaD+mVBFkdFLAfznsD2ixg1k32ZuYfctsDQRwUUEMUabqNf1nnm+Ud/bWxeE
 k6OHA9GVDJn/ZrboQHwqXcLuKOKHe+qzSrsuoamIYmLjd/k4iOQ1phKXB8eUyO7NzYJk/ePqMlP
 V3TJIJN3kNphh1G0SNzf0utm336zoZMUwmIH39N3QTFaLwoz2Tw9c8Nx7gguq0hALBnG7G9jbIe
 V1m96RJE4pouyKSZeKUzkpt6QEAn86u8BZEbEi6ZdX0aIQyUjn8PZOo+/bIB6y0ejI2pHpA1cn9
 6726uw9dC5oi7LAtm5gLb9u9ct/K0ON4DxfQ==
X-Received: by 2002:a05:600c:5298:b0:490:778:4fec with SMTP id
 5b1f17b1804b1-490428e02d3mr304386955e9.33.1779792444029; 
 Tue, 26 May 2026 03:47:24 -0700 (PDT)
Received: from draig.lan ([185.124.0.195]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-45eb6d5cb9asm37255865f8f.27.2026.05.26.03.47.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 26 May 2026 03:47:23 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 5024C5F810;
 Tue, 26 May 2026 11:47:22 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org,  Peter Xu <peterx@redhat.com>,  Daniel P.
 =?utf-8?Q?Berrang=C3=A9?= <berrange@redhat.com>,  Thomas Huth
 <th.huth+qemu@posteo.eu>,
 Song Gao <gaosong@loongson.cn>,  John Snow <jsnow@redhat.com>,  Philippe
 =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,  Kyle Evans
 <kevans@freebsd.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,  Cleber Rosa
 <crosa@redhat.com>,  Warner Losh <imp@bsdimp.com>,  Brad Smith
 <brad@comstyle.com>,  Thomas Huth <thuth@redhat.com>,  Paolo Bonzini
 <pbonzini@redhat.com>,  Max Filippov <jcmvbkbc@gmail.com>,  Brian Cain
 <brian.cain@oss.qualcomm.com>,  Fabiano Rosas <farosas@suse.de>,  Peter
 Maydell <peter.maydell@linaro.org>,  Richard Henderson
 <richard.henderson@linaro.org>,  qemu-arm@nongnu.org
Subject: Re: [PATCH v2 03/16] tests/Makefile.include: add binary dependency
 to run-tcg-tests-% rules
In-Reply-To: <7d58926d-a36d-430f-828e-7ebdd9cc4eb5@oss.qualcomm.com> (Pierrick
 Bouvier's message of "Mon, 25 May 2026 12:22:39 -0700")
References: <20260521131739.540157-1-alex.bennee@linaro.org>
 <20260521131739.540157-4-alex.bennee@linaro.org>
 <74e8bc86-cd81-43f9-b5cb-7e3de3bcd3d0@oss.qualcomm.com>
 <87tsrzl138.fsf@draig.linaro.org>
 <093614fb-ced1-4b15-b1e1-5da755f87237@oss.qualcomm.com>
 <87cxymec7b.fsf@draig.linaro.org>
 <5bd51a1a-4079-4073-bbd8-f0206a1ad458@oss.qualcomm.com>
 <0f73d717-1621-4c3f-9c5e-9bfdfaffb0b8@oss.qualcomm.com>
 <877bor9vor.fsf@draig.linaro.org>
 <7d58926d-a36d-430f-828e-7ebdd9cc4eb5@oss.qualcomm.com>
User-Agent: mu4e 1.14.1; emacs 30.1
Date: Tue, 26 May 2026 11:47:22 +0100
Message-ID: <87qzmyzbut.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x32e.google.com
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

> On 5/25/2026 11:43 AM, Alex Benn=C3=A9e wrote:
>> Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com> writes:
>>=20
>>> On 5/25/2026 8:46 AM, Pierrick Bouvier wrote:
>>>> On 5/23/2026 1:56 AM, Alex Benn=C3=A9e wrote:
>>>>> Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com> writes:
>>>>>
>>>>>> On 5/22/2026 12:02 PM, Alex Benn=C3=A9e wrote:
>>>>>>> Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com> writes:
>>>>>>>
>>>>>>>> On 5/21/2026 6:17 AM, Alex Benn=C3=A9e wrote:
>>>>>>>>> Explicitly set the appropriate QEMU binary as a dependency so we =
can
>>>>>>>>> ensure they get built. This is especially important for MacOS whi=
ch
>>>>>>>>> otherwise only builds the unsigned binaries on a normal "make all"
>>>>>>>>> run.
>>>>>>>>>
>>>>>>>>
>>>>>>>> I'm not sure to see why it matters. tcg-tests don't make use of hv=
f, so
>>>>>>>> unsigned binaries are plenty for it.
>>>>>>>>
>>>>>>>> Which other binary is this building that is not built by default?
>>>>>>>>
>>>>>>>> In general, if something is not included in "all" target, let's ma=
ke
>>>>>>>> sure it's included there (meson.build?) instead of adding a workar=
ound
>>>>>>>> here. Not only tests benefit this, but anyone doing a build on a
>>>>>>>> platform that might have optional binaries not built by default.
>>>>>>>
>>>>>>> If you have a suggestion on how to make that work I'm all ears.
>>>>>>>
>>>>>>
>>>>>> I would be happy to help, but I don't understand what the goal is. I
>>>>>> have three questions that should help to provide a suggestion.
>>>>>>
>>>>>> Which exact test command do you run?
>>>>>
>>>>> make check-tcg
>>>>>
>>>>>>
>>>>>> ```
>>>>>> Explicitly set the appropriate QEMU binary as a dependency so we can
>>>>>> ensure they get built.
>>>>>> ```
>>>>>> Aren't they built by all?
>>>>>
>>>>> Apparently not.
>>>>>
>>>>>> It seems to be a dependency, at least for check-tcg:
>>>>>> .ninja-goals.check-tcg =3D all test-plugins
>>>>>>
>>>>>> ```
>>>>>> This is especially important for MacOS which otherwise only builds t=
he
>>>>>> unsigned binaries on a normal "make all" run.
>>>>>> ```
>>>>>> Why do you need signed binaries for testing on MacOS (hvf?)?
>>>>>
>>>>> In a previous iteration I made configure spit out the unsigned binari=
es
>>>>> to config-target.mak but the request was to fix the dependencies
>>>>> instead.
>>>>>
>>>>> It all works on Linux so I'm not sure why MacOS is being so weird
>>>>> because the meson emulators target mechanism should be the same.
>>>>>
>>>>
>>>> Just tried now, and it does not work on Linux neither (make check-tcg
>>>> does not build any target beyond tests). Maybe you forgot to clean your
>>>> folder?
>>>>
>>>
>>> The root issue is that tests/Makefile.include is included *after*
>>> evaluation of ninja-targets in main Makefile. Thus,
>>> .ninja-goals.check-tcg is ignored.
>>=20
>> So this replaces patch 1/16 - I think we have a circular dependency here.
>>
>
> Indeed, I didn't notice the duplication. While it solves things under
> Linux, it doesn't trigger any build on MacOS, which is what you observed
> also. I wonder if it's a gmake vs whatever-make difference.
>
> Another solution that seems ok on both platforms is to use (harmful)
> recursive make:
>
>  .PHONY: check-tcg
> -.ninja-goals.check-tcg =3D all test-plugins
> -check-tcg: $(RUN_TCG_TARGET_RULES)
> +check-tcg:
> + $(MAKE) all test-plugins
> + $(MAKE) $(RUN_TCG_TARGET_RULES)
>
>  .PHONY: clean-tcg
>  clean-tcg: $(CLEAN_TCG_TARGET_RULES)
>
> Or maybe just leave it as it is? Doc already mentions build should be
> done before running any test to avoid missing binaries.
> Hopefully we'll completely move tcg tests to meson one day, so there is
> no need to deal with make idiosyncrasy anymore.

The blocker for that to happen would be meson knowing about anything
else than the host compiler and singular cross compiler.

>
>>>
>>> The fix is to move ninja-targets evaluation to the end of main Makefile,
>>> which introduce the expected dependency for check-tcg to "all
>>> test-plugins" targets.
>>>
>>> You can replace current patch with the one attached to this email.
>>>
>>> Regards,
>>> Pierrick
>>=20

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

