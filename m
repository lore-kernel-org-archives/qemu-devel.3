Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F6EDC43458
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jul 2026 16:13:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1whrN1-0003Gy-AO; Thu, 09 Jul 2026 12:13:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1whrMy-0003Gb-Hp
 for qemu-devel@nongnu.org; Thu, 09 Jul 2026 12:13:00 -0400
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1whrMw-0007FE-RE
 for qemu-devel@nongnu.org; Thu, 09 Jul 2026 12:13:00 -0400
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-493d92b7db3so21332295e9.2
 for <qemu-devel@nongnu.org>; Thu, 09 Jul 2026 09:12:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1783613576; x=1784218376; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :user-agent:references:in-reply-to:subject:cc:to:from:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=zvnSguue5BmlLwAC2u9mLn2rr1UmDTzgdMs0UziSNyM=;
 b=PbBdWPRfTGj0YzTrm81EQGaa/tnzB76iG22ta2F7q9QQNWszQCVkMh61E6astjZdic
 IB7F7n81JGd8acMsMKABfDyDKa5FjA+PPOFXtYOc+p90pii4LSQ2V9kh7cYvImhXTz6b
 3AEBRRK1v5HLs4aUoqKZuJNqFgayLyc/K0AXWf+LmiA3yXyb5Q759l6vLD6I4hGCcoac
 Vy5b5Im0ZYwmVvh+nUE8f7UfmazM70peVRH46fWkiNxkSGOp0Sd0eNBuOgV3ApDjUZVa
 LCucSFU+VruxmdvrGoNGs3ltxVd7VCCDEBSZ9JwNMSSJJe9nH5B3o+vlesjvJbENlCCP
 ItMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783613576; x=1784218376;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :user-agent:references:in-reply-to:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=zvnSguue5BmlLwAC2u9mLn2rr1UmDTzgdMs0UziSNyM=;
 b=QkU+pfySfidFeh0JUwFRooy3KdbjedxiclQQMw/dRiIcQMVWkxv9XrZfKt2eNz003d
 nBndzjILHMAtAZnj4LnyI9FGeBf5LOXMomJaTTviDIP6VEBoea/qM/fKVWWHc8u7P/51
 J4i/N32VDx9wKrxUy3FI2MiBP99lGKvjB9ae2MB2Ob6v+Pnk9SYYM0iMjikp16rvhFJW
 /UnD/V7dxoh1fTpPPp/Q4KY2OjHaiNAJ99vlF6vuE2BJLAOkASkjxf0CaaoKTatF3n8N
 telbNeze+n8LJXqSwMLpAFCs71R6FfatR/2gL54jxmR9vXGwZcMnK8YH+To6P7cgmVS7
 l4IQ==
X-Gm-Message-State: AOJu0Yw8uGi/Gk3+m+oRQhtm6GpaqfHjTJNNR3i638uBbw8vlb3KERsC
 O6+PYT8Gw5Ymgvp9tfPZCt68OvThVr5LcPjNzw6cp4ITB7IRrNmQ7m7sW7zhmR9pGcE=
X-Gm-Gg: AfdE7cnRgdlY299Oja6fEiOULo7oZUQF/QTuIe5hElzUQEsc7fJBOXv99N57YIevgkO
 DXfk4AmIa9s5f663W0uW9NDs/NIbmu5iPl072yfXq8cAPxUrdeVG7yZqgSi3gIZmPlowl7yW0vc
 7BVNCJDhBx48AuwRncR6M9YyHV8oJ+mMssDXbmKTwpddYhYpIVHnNzlkX2A8a3QkSt4Xn2QgpHN
 Qa/3yVgpK5RP5Lri6YLF6P7R6qY4ObuU4GrBwzVbM1+TLCkZBj0B+r0pPj73bhtWnntlqxySdBu
 KkQr8UdRu5HVgjTcC50fQ0tfMFaB8X4Dt+4ZRPUAImVcp6N52gwsOyugvg2X7BlV2S03HT0V+Cg
 0DJ+PUvBwM1TFjpPv+EAhuceD1IjDyYXjf1gee6V8P8mHxZMPMsnZEqFt+YvSkDt+QRysVG3+kS
 v6010/ExI1Fm99
X-Received: by 2002:a05:600c:4fc6:b0:493:cefc:d113 with SMTP id
 5b1f17b1804b1-493e68b7f62mr80626235e9.5.1783613575585; 
 Thu, 09 Jul 2026 09:12:55 -0700 (PDT)
Received: from draig.lan ([185.124.0.114]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47a9e4d6da9sm51570179f8f.12.2026.07.09.09.12.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 09 Jul 2026 09:12:54 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id C7B745F82D;
 Thu, 09 Jul 2026 17:12:53 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org,  Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?=
 <philmd@oss.qualcomm.com>,  Daniel =?utf-8?Q?P=2EBerrang=C3=A9?=
 <berrange@redhat.com>,
 Thomas Huth <thuth@redhat.com>,  Paolo Bonzini <pbonzini@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,  Ilya Leoshkevich
 <iii@linux.ibm.com>,  Brian Cain <brian.cain@oss.qualcomm.com>,  Gustavo
 Romero <gustavo.romero@linaro.org>,  Laurent Vivier <laurent@vivier.eu>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,  Helge Deller
 <deller@gmx.de>,  Richard Henderson <richard.henderson@linaro.org>
Subject: Re: [PATCH v3 19/91] tests/tcg/meson.build: add wrapper record_replay
In-Reply-To: <decd7f0d-fd74-4314-8a44-df9f7a75d8d5@oss.qualcomm.com> (Pierrick
 Bouvier's message of "Thu, 9 Jul 2026 08:10:59 -0700")
References: <20260706223343.988769-1-pierrick.bouvier@oss.qualcomm.com>
 <20260706223343.988769-20-pierrick.bouvier@oss.qualcomm.com>
 <87echcrzah.fsf@draig.linaro.org>
 <41fb9818-b18f-4deb-889c-e1847293a3f0@oss.qualcomm.com>
 <decd7f0d-fd74-4314-8a44-df9f7a75d8d5@oss.qualcomm.com>
User-Agent: mu4e 1.14.2; emacs 30.1
Date: Thu, 09 Jul 2026 17:12:53 +0100
Message-ID: <878q7krvju.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x330.google.com
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

> On 7/9/2026 8:03 AM, Pierrick Bouvier wrote:
>> On 7/9/2026 7:52 AM, Alex Benn=C3=A9e wrote:
>>> Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com> writes:
>>>
>>>> Runs a record and replay test, and make sure the output produced by
>>>> both runs is the same.
>>>>
>>>> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
>>>> ---
>>>>  tests/tcg/meson.build              |  1 +
>>>>  tests/tcg/scripts/record_replay.sh | 16 ++++++++++++++++
>>>>  2 files changed, 17 insertions(+)
>>>>  create mode 100755 tests/tcg/scripts/record_replay.sh
>>>>
>>>> diff --git a/tests/tcg/meson.build b/tests/tcg/meson.build
>>>> index 30178df0f7a..e610ce30f40 100644
>>>> --- a/tests/tcg/meson.build
>>>> +++ b/tests/tcg/meson.build
>>>> @@ -7,6 +7,7 @@ if config_host.has_key('GDB')
>>>>  endif
>>>>  gdb =3D find_program(gdb_progs, required: false)
>>>>  prog_gdb_test =3D find_program('../guest-debug/run-test.py')
>>>> +prog_record_replay =3D find_program('./scripts/record_replay.sh')
>>>>  prog_run_and_diff =3D find_program('./scripts/run_and_diff.sh')
>>>>  prog_run_with_input =3D find_program('./scripts/run_with_input.sh')
>>>>  prog_run_and_check_forbidden_output =3D find_program(
>>>> diff --git a/tests/tcg/scripts/record_replay.sh b/tests/tcg/scripts/re=
cord_replay.sh
>>>> new file mode 100755
>>>> index 00000000000..57775a2d4c1
>>>> --- /dev/null
>>>> +++ b/tests/tcg/scripts/record_replay.sh
>>>> @@ -0,0 +1,16 @@
>>>> +#!/usr/bin/env bash
>>>
>>> While at it is there any reason this couldn't be plain POSIX shell. I
>>> don't think we explicitly require bash although its super likely to be
>>> on most systems. configure is all POSIX shell.
>>>
>>=20
>> The main reason for me to use bash is that it supports set -uo pipefail
>> in combination with set -e.
>>=20
>> Which produces:
>> - exit if a variable is undefined
>> - exit if any command in a pipe sequence fails
>> Without this, script shells are pretty much house of cards waiting to
>> collapse on any corner case.
>>=20
>> bash is available out of the box at least on macos, msys2, and I expect,
>> every single linux distro out there. Not sure about bsds though.
>>=20
>> If that's such a big issue, I can port the scripts to sh.
>>
>
> Interestingly, QEMU main Makefile makes bash a defacto requirement,
> since it uses it for every single command to run. The reason is... to
> use -o pipefail.
>
> https://gitlab.com/qemu-project/qemu/-/blob/master/Makefile?ref_type=3Dhe=
ads#L17
>

Well it looks like I misremembered as we list bash as a dependency in
qemu-minimal:

  packages:
   - bash

so I drop my objection.


>>>> +# SPDX-License-Identifier: GPL-2.0-or-later
>>>> +
>>>> +set -euo pipefail
>>>> +
>>>> +if [ $# -lt 2 ]; then
>>>> +    echo "record_replay: qemu_bin [args]..." 1>&2
>>>> +    exit 1
>>>> +fi
>>>> +qemu=3D"$1";shift
>>>> +tmp=3D$(mktemp -d)
>>>> +trap "rm -rf $tmp" EXIT
>>>> +set -x
>>>> +$qemu -icount shift=3D5,rr=3Drecord,rrfile=3D$tmp/rr.bin "$@" |& tee =
$tmp/record
>>>> +$qemu -icount shift=3D5,rr=3Dreplay,rrfile=3D$tmp/rr.bin "$@" |& tee =
$tmp/replay
>>>> +diff $tmp/record $tmp/replay
>>>
>>=20

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

