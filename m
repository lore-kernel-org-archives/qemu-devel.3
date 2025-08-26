Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 368CFCA0FE9
	for <qemu-devel@archiver.kernel.org>; Tue, 26 Aug 2025 08:28:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uqp12-0001k3-Nv; Tue, 26 Aug 2025 04:26:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1uqp10-0001jg-KE
 for qemu-devel@nongnu.org; Tue, 26 Aug 2025 04:26:50 -0400
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1uqp0s-0006pe-Fr
 for qemu-devel@nongnu.org; Tue, 26 Aug 2025 04:26:50 -0400
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-45b5d49ae47so11322215e9.0
 for <qemu-devel@nongnu.org>; Tue, 26 Aug 2025 01:26:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1756196797; x=1756801597; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KnQZoJzcxwr/v3SVAw+XhgMswGl/dIdrzKeK5w4puc4=;
 b=mSma+i0SQ8uQ8mYtLh+fJIPI5MSZPoZYF5/B9jKtt/JnS2Pr8V2nniOcJGcFZ1ZJrP
 o+BV6Qw0frCi6oY2sLkQNaZlKsfYu+CYlBG7fm+EUfNEh4LB34p1RF8J6cn50kNDTHFV
 4v5TrCl5cAwccrGtt7cRCq0L9aiH7WOGl4HfBgTwqhwMiXdcvwXizJwU3NrzRCP+KdrT
 O41n8W8WaaxE8Ja8DT3vv0Dh4mCalsNU69H7VqMlutKpRMgwv09IPujBbB4VYyhWgl2/
 BiZjKDWg4X7R5VYuRuPoX8FqCF7y+aryNNHi8ifqZZdU8YsDDo+B1Vmn2x/VmFMHkdJ2
 +LPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756196797; x=1756801597;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=KnQZoJzcxwr/v3SVAw+XhgMswGl/dIdrzKeK5w4puc4=;
 b=KU7XvJp7BzHpzMK3Ao5CIYdlJw3nBpb/iGrEi7snzECo0ZVb4g6Ehe+CLI87UYORG5
 oe8UPwLU1Vl14Ck7HQ72TjQVkdw6tLPJ783kon2qsXTI7iHnk3tq3cI+O9rx2z8BlzKj
 TEdgUROYbxgV5vWN41rrMwWoR9lT3NEczecrEdlXj//IuSDsYHPluNkh5QyKFvjcuO89
 2y5g9ybtRN2QU35P+4Pr1Fudw1vIiF7UA+ajO2syZb5ORIq7faWWM60+Ltc1S2sN9PJQ
 1IIbHHlgCddQcwp3CMBSrTEJrZkVAdayECm86l+08YIh/DhKMM0nF2ESLACS9O4ijYm8
 riWw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUSCVs2DhMqoX08LcYDWBExk8lPbJAu9r2bR9JvDAusIQ8XWvgnQyio6P1s2O2Q03Kt8DmGhunSBjoB@nongnu.org
X-Gm-Message-State: AOJu0YyLiZsYsvK9qlMUAcH3sKAks/or07Wc3aPyednCB05f0zONEUHp
 HP+ZFyLeIIWBEqe5yRVqdH1xBp0O+y8vPdi8azIXmcKUzETJnRkLninXwqJpoc9S+nA=
X-Gm-Gg: ASbGnct6zCgpT8pMov3tM3SS3pMTqpLCRtUWSkVZV29ZYs3oS9Rvi0JHMgVm3MyvrB3
 /v1N5k5WfQ0gEUeakqYFQ7nB0KY+883pHQX0c0SuM7TIbpMIXtMPAsmG1XB3buo0AxKJ+mhe7FT
 45bqujpK9xt9mh1TOZ+3bff02+i0fyY46y7F8Ypx3LnY+gzU6s1nslHzyw0jgVW35wrw57v8t9f
 dRIyzWxC/V6VaO7NHOejMVyPs6WTiU2o23nrpysdQJvaD4fFEaz+lH295ykHBWJLt5JhHM0/Aw7
 zwAFx0uoZw6mJLmHbWRmcriYLcf2c4V9ZedcJ6tzes005QMjscTwrmcgiF6aDdXMia9qYjt0yZ+
 jUjCRWIECh2PoWg6OKioYepRdsNX8RMedvw==
X-Google-Smtp-Source: AGHT+IFliCD2lMJu4Gy0VSnVbYIpdwJgh7EZF+0+Ga7qebz0BvyhXz5fgVkX9t05pKh1Y4e1Amjo4A==
X-Received: by 2002:a05:600c:3ba6:b0:43c:f0ae:da7 with SMTP id
 5b1f17b1804b1-45b66c95ad3mr10344135e9.7.1756196796926; 
 Tue, 26 Aug 2025 01:26:36 -0700 (PDT)
Received: from draig.lan ([185.126.160.19]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3c711211cbcsm14861850f8f.31.2025.08.26.01.26.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 26 Aug 2025 01:26:36 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 55DC35F7D8;
 Tue, 26 Aug 2025 09:26:35 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Thomas Huth <thuth@redhat.com>
Cc: Gustavo Romero <gustavo.romero@linaro.org>,  qemu-devel@nongnu.org,
 qemu-arm@nongnu.org,  1844144@gmail.com,  Jan Richter <jarichte@redhat.com>
Subject: Re: [PATCH 0/4] tests/functional: Adapt reverse_debugging to run
 w/o Avocado
In-Reply-To: <8326014d-114e-47df-89fc-632eb5683632@redhat.com> (Thomas Huth's
 message of "Tue, 26 Aug 2025 09:51:27 +0200")
References: <20250819143916.4138035-1-gustavo.romero@linaro.org>
 <53b6e23f-5328-42c6-9c58-97ddbf3e5b29@redhat.com>
 <a1105fed-dbd8-4223-b771-180ab12e3f77@linaro.org>
 <8326014d-114e-47df-89fc-632eb5683632@redhat.com>
User-Agent: mu4e 1.12.12; emacs 30.1
Date: Tue, 26 Aug 2025 09:26:35 +0100
Message-ID: <87tt1u1oas.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x32f.google.com
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

Thomas Huth <thuth@redhat.com> writes:

> On 25/08/2025 16.04, Gustavo Romero wrote:
>> Hello, Thomas!
>> On 8/25/25 07:29, Thomas Huth wrote:
>>> On 19/08/2025 16.39, Gustavo Romero wrote:
>>>> The goal of this series is to remove Avocado as a dependency for runni=
ng
>>>> the reverse_debugging functional test.
>>>>
>>>> This test, the last one I=E2=80=99m aware of that relies on Avocado, r=
equires it
>>>> because of the need for GDB to test reverse stepping and continue.
> ...
>>> I gave it a try, but this did not work for me, the test was not run
>>> at all anymore. Are there any patches needed on top?
>> hmm that's odd. I'm able to run it with 'make check-functional' and
>> with 'meson test'...
>> This is how I'm running it (let me know if I'm missing something):
> ...
>> gromero@gromero0:/mnt/git/qemu_$
>> gromero@gromero0:/mnt/git/qemu_/build$ ../configure
>> --target-list=3Daarch64- softmmu --disable-docs
>> gromero@gromero0:/mnt/git/qemu_/build$ make -j 32
>> gromero@gromero0:/mnt/git/qemu_/build$ time make -j 15=C2=A0 check-funct=
ional
>> [1/2] Generating tests/functional/func-precache-aarch64-
>> aarch64_reverse_debug with a custom command (wrapped by meson to set
>> env)
>> 2025-08-25 12:50:04,215 - qemu-test - INFO - Attempting to cache
>> '/home/ gromero/.cache/qemu/
>> download/7e1430b81c26bdd0da025eeb8fbd77b5dc961da4364af26e771bd39f379cbbf=
7'
>> 2025-08-25 12:50:04,225 - qemu-test - DEBUG - Using cached asset
>> /home/ gromero/.cache/qemu/
>> download/7e1430b81c26bdd0da025eeb8fbd77b5dc961da4364af26e771bd39f379cbbf7
>> for
>> https://archives.fedoraproject.org/pub/archive/fedora/linux/releases/29/
>> Everything/aarch64/os/images/pxeboot/vmlinuz
>> GDB CMD: /usr/bin/gdb-multiarch -q -n -batch -ex 'set pagination
>> off' -ex 'set confirm off' -ex "py
>> sys.argv=3D['/mnt/git/qemu_/tests/functional/
>> test_aarch64_reverse_debug.py']" -x /mnt/git/qemu_/tests/functional/
>> test_aarch64_reverse_debug.py
>> [0/1] Running external command precache-functional (wrapped by meson
>> to set env)
>> make[1]: Entering directory '/mnt/git/qemu_/build'
>> [1/6] Generating qemu-version.h with a custom command (wrapped by
>> meson to capture output)
>> /mnt/git/qemu_/build/pyvenv/bin/meson test=C2=A0 --no-rebuild -t 1
>> --setup thorough=C2=A0 --num-processes 10 --print-errorlogs=C2=A0 --suite
>> func=C2=A0 --suite func- quick=C2=A0 --suite func-thorough
>>  =C2=A01/27 qemu:func-thorough+func-aarch64-thorough+thorough /
>> func-aarch64- aarch64_virt_gpu=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 SKIP=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0
>> 1.95s=C2=A0=C2=A0 0 subtests passed
>
> I tried a couple of times now, and finally realized that it's the
> "gdb-multiarch" binary that is missing on Fedora. And as far as I can
> see, there is also no package that provides this on Fedora? So if we
> go ahead with your patches, this test will only run on certain distros
> that provide this binary.

I've mentioned in another review comment we should use the same gdb as
set/detected from configure as we do for the check-tcg tests.

>
>  Thomas

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

