Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71DEFCD5BC9
	for <qemu-devel@archiver.kernel.org>; Mon, 25 May 2026 18:44:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wRaH8-0004vS-8A; Mon, 25 May 2026 14:43:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1wRaH3-0004ui-RP
 for qemu-devel@nongnu.org; Mon, 25 May 2026 14:43:37 -0400
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1wRaH2-0000ye-8W
 for qemu-devel@nongnu.org; Mon, 25 May 2026 14:43:37 -0400
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-4903974854dso36973635e9.3
 for <qemu-devel@nongnu.org>; Mon, 25 May 2026 11:43:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779734614; x=1780339414; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nzfKWv9JzU5mMugxKaK6qPwERMr9J1AgOUmy+aHJ24g=;
 b=s81ciKku0rudltbtvwdI2l7ki0VOGpMrEGbc1O8sFqJ7uvj3Q1jWy1UJqWdR4shyBd
 Az55GEI/5u57u42UE5UFG5ojEEVoA8HfQ2xaRNzTMeDkFD6bgpP14Xkq56ea4T1AJf22
 lYyvM6e8LVkXtugzDZPW9LtKeXP35GBtMfymt11SxT+QPO9FbDqltlgnIcr8qlC2Z9ql
 gQsUHc3r8td1bFqx/ck2rg+BewG6CMJsZeWanAfB2Y+pjGWVKLDX+bNhSITd4PWoRc4U
 /oLT5CY2+yaxGc7eQVdUrRyn8BaIzvJO4cynHG3Hb7P5YFUg1fJtrlquUnT8SoNSp6YM
 dogw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779734614; x=1780339414;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=nzfKWv9JzU5mMugxKaK6qPwERMr9J1AgOUmy+aHJ24g=;
 b=hNRJW2fo0i05YjpXmLSn3T9d/QW2rg/DzuxSCGX774hyYGEDYOGFVS0Ggj/88mx3N1
 d7bLezyHhOlPlousCCTZCHanag70urM75HS1kWAo3rJlMv7QscHwaZgbHAmouP2HqmQ5
 r+78U2BIObu/NQ6ebbW12ANr31i34Km9fAizA8CG+kGDt+VLa0mF+qjVGkkQqpBbRqZo
 X5/B+XvJWykqKMv75hhniMj5KibH7q8RRvx6FED++OG7ktaIlqHWlQtA9W7Cu5aMB34h
 2IyWbPyfUwCxNU9e9odn9hxiNzwvpvFdSZOuFBL2qiZv5s24IC+kORAmsEq0bTNDQcRA
 URRw==
X-Gm-Message-State: AOJu0YwLtQ2uAjYHgGq8h4c3NVitWDYZMDL6mqSDAZoan01HAswFTk8P
 SyFg0mUmU4mA6n2hFQqfPaI+ODrwQzTNsDpcGmoImlVYpdGh169CRjwiAy6b9AONzGc=
X-Gm-Gg: Acq92OGcmFZx0Itp8r1ssZ0+zcqvBR6NI7uEofA3z4cyHQGk6kO3vXeGDRtKkEs7Itl
 7crm2WYCQFTCu9VUfQ7QQf4Ix77xyMfySstTb3AT2WsLsCmlhQrTnqustrL/7FEvFSkS6n7ypMk
 C8XtDXPKVUDhcvUlOjBVclRTpHwBtpFgW/wdfEbNT31c9GjWuxUG0108u9ZoGmchBvAonyLhyLo
 ESSfKQy6KfPndL5H8hl9rD0PTnpx77mTqFaHG+KEsbzPKQhAP3jhQQ1ybF8gRW2l9sVFOxCEXZr
 8bvKVg6zC6YU131QL5C7zjYdeVrdsd9ED0d/bRN+s1aEOhDd7h3ARIhDehSnD6FrWpfNpQ2ZaWN
 uqpAB/1/msNhVU8GC93V8etVX8BB/MMUYYCL1PyOfQ67N2Jqki8OMFEr6Dn4VPxs93oXiaHyyv+
 +ToIs1EOv9jNX+eGg7O8J132FHykp+jJ+IjQ==
X-Received: by 2002:a05:600c:8217:b0:490:51e9:deba with SMTP id
 5b1f17b1804b1-49051e9e233mr175536925e9.27.1779734614129; 
 Mon, 25 May 2026 11:43:34 -0700 (PDT)
Received: from draig.lan ([185.124.0.195]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-45eb6cd1780sm31122078f8f.16.2026.05.25.11.43.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 25 May 2026 11:43:33 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 40D575F855;
 Mon, 25 May 2026 19:43:32 +0100 (BST)
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
In-Reply-To: <0f73d717-1621-4c3f-9c5e-9bfdfaffb0b8@oss.qualcomm.com> (Pierrick
 Bouvier's message of "Mon, 25 May 2026 10:18:45 -0700")
References: <20260521131739.540157-1-alex.bennee@linaro.org>
 <20260521131739.540157-4-alex.bennee@linaro.org>
 <74e8bc86-cd81-43f9-b5cb-7e3de3bcd3d0@oss.qualcomm.com>
 <87tsrzl138.fsf@draig.linaro.org>
 <093614fb-ced1-4b15-b1e1-5da755f87237@oss.qualcomm.com>
 <87cxymec7b.fsf@draig.linaro.org>
 <5bd51a1a-4079-4073-bbd8-f0206a1ad458@oss.qualcomm.com>
 <0f73d717-1621-4c3f-9c5e-9bfdfaffb0b8@oss.qualcomm.com>
User-Agent: mu4e 1.14.1; emacs 30.1
Date: Mon, 25 May 2026 19:43:32 +0100
Message-ID: <877bor9vor.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x334.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

> On 5/25/2026 8:46 AM, Pierrick Bouvier wrote:
>> On 5/23/2026 1:56 AM, Alex Benn=C3=A9e wrote:
>>> Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com> writes:
>>>
>>>> On 5/22/2026 12:02 PM, Alex Benn=C3=A9e wrote:
>>>>> Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com> writes:
>>>>>
>>>>>> On 5/21/2026 6:17 AM, Alex Benn=C3=A9e wrote:
>>>>>>> Explicitly set the appropriate QEMU binary as a dependency so we can
>>>>>>> ensure they get built. This is especially important for MacOS which
>>>>>>> otherwise only builds the unsigned binaries on a normal "make all"
>>>>>>> run.
>>>>>>>
>>>>>>
>>>>>> I'm not sure to see why it matters. tcg-tests don't make use of hvf,=
 so
>>>>>> unsigned binaries are plenty for it.
>>>>>>
>>>>>> Which other binary is this building that is not built by default?
>>>>>>
>>>>>> In general, if something is not included in "all" target, let's make
>>>>>> sure it's included there (meson.build?) instead of adding a workarou=
nd
>>>>>> here. Not only tests benefit this, but anyone doing a build on a
>>>>>> platform that might have optional binaries not built by default.
>>>>>
>>>>> If you have a suggestion on how to make that work I'm all ears.
>>>>>
>>>>
>>>> I would be happy to help, but I don't understand what the goal is. I
>>>> have three questions that should help to provide a suggestion.
>>>>
>>>> Which exact test command do you run?
>>>
>>> make check-tcg
>>>
>>>>
>>>> ```
>>>> Explicitly set the appropriate QEMU binary as a dependency so we can
>>>> ensure they get built.
>>>> ```
>>>> Aren't they built by all?
>>>
>>> Apparently not.
>>>
>>>> It seems to be a dependency, at least for check-tcg:
>>>> .ninja-goals.check-tcg =3D all test-plugins
>>>>
>>>> ```
>>>> This is especially important for MacOS which otherwise only builds the
>>>> unsigned binaries on a normal "make all" run.
>>>> ```
>>>> Why do you need signed binaries for testing on MacOS (hvf?)?
>>>
>>> In a previous iteration I made configure spit out the unsigned binaries
>>> to config-target.mak but the request was to fix the dependencies
>>> instead.
>>>
>>> It all works on Linux so I'm not sure why MacOS is being so weird
>>> because the meson emulators target mechanism should be the same.
>>>
>>=20
>> Just tried now, and it does not work on Linux neither (make check-tcg
>> does not build any target beyond tests). Maybe you forgot to clean your
>> folder?
>>
>
> The root issue is that tests/Makefile.include is included *after*
> evaluation of ninja-targets in main Makefile. Thus,
> .ninja-goals.check-tcg is ignored.

So this replaces patch 1/16 - I think we have a circular dependency here.

>
> The fix is to move ninja-targets evaluation to the end of main Makefile,
> which introduce the expected dependency for check-tcg to "all
> test-plugins" targets.
>
> You can replace current patch with the one attached to this email.
>
> Regards,
> Pierrick

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

