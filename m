Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64516C88E78
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Sep 2026 16:08:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x69Dj-0002TT-5F; Mon, 14 Sep 2026 12:07:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1x69D5-00027D-Mq
 for qemu-devel@nongnu.org; Mon, 14 Sep 2026 12:07:16 -0400
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1x69D3-0006Fh-O2
 for qemu-devel@nongnu.org; Mon, 14 Sep 2026 12:07:11 -0400
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-49d05d51553so29874345e9.2
 for <qemu-devel@nongnu.org>; Mon, 14 Sep 2026 09:07:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1789402028; x=1790006828; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :user-agent:references:in-reply-to:subject:cc:to:from:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=WzKfzk46A9PJG/TH9IjZiYI/GWm3iPJfLfq5ntNMGVU=;
 b=keZD1j2FMtxp2y7e756dcmYRbNGU5pemZp9Iv2ZqnwXl05ib8IMcc5wH4zFVgceB+H
 CkyD3lhj6sV+Vrm6x+Dy/idUh0/eGxg1yTA2kc4uxoHfZ1IGo5GoVwPYB5NbzzacEZSL
 m9a/dgLGpSNyW5p09ES7Lln89tcNDUmAFFoVyri7mGVs+BbpF5g4fURFLsV4rFHK12IL
 DR9xCtqon55+mJLbedUy5ccLx1MfeiW95o6oLssOoAXILrkp+BQHCV0hyeL12rMw2ln7
 Lf/R2Le1aSj53nLTb4pkW0hgPfNWJxbMul9GvfjFSxWE7gpL05qVcEBqQuVeepCE7Vcy
 wnaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789402028; x=1790006828;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :user-agent:references:in-reply-to:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=WzKfzk46A9PJG/TH9IjZiYI/GWm3iPJfLfq5ntNMGVU=;
 b=MSbSsc9V6oMYgRLykePXOByxx2BgbTrrefIHg2/FBPnrtc+I2UNQvY9EYySa8UMV8T
 r1itTJ/bD1LmKU4z7GCxiZYm6cwez7GtqJFo8pB/uSVabaz41UNPiY3BgG3yEyTq8Y+u
 VCVwdHdODOkUeYCtXMN1eegTEEXueqsyTCMiOyBRa1gKDLLA/5NLO6W34RgLCxPcSLQZ
 5doV/SnS2QGAM6/lbptG5oF6XeMaislksjmvssPMLpDYKVXbhLj4rJzcIh0f4DXllBFK
 DTvlm6kxOZPs7CPVgIJ0IZknB1ZrQws/DlYMt7eab31WL4EDH4YLkUo17o/hES6FDgkM
 J6aQ==
X-Forwarded-Encrypted: i=1;
 AKwUvByMLsNrS+/jxD0nXRMVG8nVnO8usGB5gEBjPFEb4phXv0OIJIOBQBjdBS9gDS1gfHp6P/ITwrOkmDxB@nongnu.org
X-Gm-Message-State: AFuF++mO0HK1U+NA7PwvXjTrHg3IT1vtpaBkpGDiA8UP6KVDvRxBjrwO
 Pyx0lS398Y0BcGpgCE/QyLbxYWrd2vuZu4uAIdWsn1OoouSA+pDtZRQygy2nqTdPSmI=
X-Gm-Gg: AYBFou0I3jrj45b/Y9rRHIkrDW9H0xz7BS2IRX27Jsgo73DK+vFv9M+BAUlcwyP/PTy
 cvYSeNWVSL70wVzcESC705JQzjrddfo3n3dgP+uIRHihlSnNUEBjqrorJCO6OjxBFHK3EE3WpFA
 tbohJRnzTyvd6uK4XJOUomjZciLvMXyvXgitoINCNjvMhF8S5wAfG0OmbGufiNBuRMlD+Ma+ZON
 EVYcfgxx0tYO3ONBvTQrzHdP3orILnMBpzrKxu7/2awbpvXrteVJpTThf63lM5mQKIMlyU4ZaV5
 RlvHLkwkWVwnX59ZU0bU9ozK2aBRRSGgxUO/D4nV9Tqh4FD7q8cbW3XotwRntEP1Fs/HotDUwsA
 mmmiq0rHCbXaXQLH45Wfb1HlY/7v1leqcWR6pi1dnz4N154aB7rCe0w3qn/GHSI4fHSxZgw/5Mz
 lYcw9JEQZ+P9YwzvFBPxm55E/msZsOH1ehR/zhr/KReTcNw7cL+xP4SdxZUIhk9jqD40oWkNI=
X-Received: by 2002:a05:600c:3586:b0:49d:15b9:2a2a with SMTP id
 5b1f17b1804b1-49e7a64ea8fmr49780695e9.10.1789402027888; 
 Mon, 14 Sep 2026 09:07:07 -0700 (PDT)
Received: from draig.lan ([185.124.0.156]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49e7d66820dsm2631115e9.3.2026.09.14.09.07.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Sep 2026 09:07:07 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 18A785F81D;
 Mon, 14 Sep 2026 17:07:06 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Daniel P. =?utf-8?Q?Berrang=C3=A9?= <berrange@redhat.com>
Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 qemu-devel@nongnu.org,  Ilya Leoshkevich <iii@linux.ibm.com>
Subject: Re: [PATCH 2/9] tests/tcg: improve check for working cross compilers
In-Reply-To: <aqexk7afMhWLxf3w@redhat.com> ("Daniel P. =?utf-8?Q?Berrang?=
 =?utf-8?Q?=C3=A9=22's?= message of
 "Mon, 14 Sep 2026 09:34:27 +0100")
References: <20260910181504.1010916-1-alex.bennee@linaro.org>
 <20260910181504.1010916-3-alex.bennee@linaro.org>
 <22dca41b-3833-45d2-912f-b05a77d7d883@oss.qualcomm.com>
 <aqexk7afMhWLxf3w@redhat.com>
User-Agent: mu4e 1.14.4-pre3; emacs 30.1
Date: Mon, 14 Sep 2026 17:07:06 +0100
Message-ID: <87a4pjddg5.fsf@draig.linaro.org>
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

Daniel P. Berrang=C3=A9 <berrange@redhat.com> writes:

(trimed cc list, add Ilya)

> On Sun, Sep 13, 2026 at 10:08:52PM -0700, Pierrick Bouvier wrote:
>> On 9/10/26 11:14 AM, Alex Benn=C3=A9e wrote:
>> > From: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
>> >=20
>> > When it finds a cross compiler, tests/tcg/meson.build tries
>> > building test_cc.c to validate that the compiler works. This
>> > includes "stdint.h" as a witness for working C library, however,
>> > that is not a good choice as it can be provided by the toolchain
>> > alone:
>> >=20
>> >    $ rpm -ql gcc-s390x-linux-gnu  | grep /stdint.h
>> >    /usr/lib/gcc/s390x-linux-gnu/16/include/stdint.h
>> >=20
>> > As a result, if you install the s390x GCC cross compiler, but
>> > not any C library, meson decides to use the host compiler instead
>> > of the container:
>> >=20
>> >      cc for aarch64-softmmu          : aarch64-linux-gnu-gcc (from 'de=
bian-all-test-cross' container)
>> >      cc for loongarch64-softmmu      : loongarch64-unknown-linux-gnu-g=
cc (from 'debian-loongarch-cross' container)
>> >      cc for riscv64-softmmu          : riscv64-linux-gnu-gcc (from 'de=
bian-all-test-cross' container)
>> >      cc for s390x-softmmu            : s390x-linux-gnu-gcc
>> >      cc for x86_64-softmmu           : x86_64-linux-gnu-gcc (from 'deb=
ian-amd64-cross' container)
>> >=20
>> > Eventually this results in failure to run 'make check':
>> >=20
>> > [33/40] Generating tests/tcg/s390x-softmmu-hello with a custom command
>> > FAILED: [code=3D1] tests/tcg/s390x-softmmu-hello.test
>> > /usr/bin/s390x-linux-gnu-gcc /home/berrange/src/virt/qemu/tests/tcg/mu=
ltiarch/system/hello.c -o tests/tcg/s390x-softmmu-hello.test -static -MMD -=
MF tests/tcg/s390x-softmmu-hello.d -Wall -Werror -O0 -g -fno-strict-aliasin=
g -nostdlib -ffreestanding -Wa,--noexecstack -I /home/berrange/src/virt/qem=
u/tests/tcg/s390x/system/../../minilib /home/berrange/src/virt/qemu/tests/t=
cg/s390x/system/../../minilib/printf.c -I /home/berrange/src/virt/qemu/incl=
ude/hw/s390x/ipl -march=3Dz13 ../tests/tcg/s390x/system/../head64.S ../test=
s/tcg/s390x/system/../console.c
>> > In file included from ../tests/tcg/s390x/system/../console.c:8:
>> > ../tests/tcg/s390x/system/../../../../pc-bios/s390-ccw/sclp.c:11:10: f=
atal error: string.h: No such file or directory
>> >     11 | #include <string.h>
>> >        |          ^~~~~~~~~~
>> > compilation terminated.
>> >=20
>> > Adding more include files to the test program ensures the
>> > meson probe makes a better decision.
>> >=20
>> > Fixes: e5d084d622b1 (tests/tcg/meson.build: check host cross cc is wor=
king)
>> > Signed-off-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
>> > Message-ID: <20260910100120.2076092-1-berrange@redhat.com>
>> > Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
>> > ---
>> >   tests/tcg/test_cc.c | 6 +++++-
>> >   1 file changed, 5 insertions(+), 1 deletion(-)
>> >=20
>> > diff --git a/tests/tcg/test_cc.c b/tests/tcg/test_cc.c
>> > index d3614a01fe6..fafee055b40 100644
>> > --- a/tests/tcg/test_cc.c
>> > +++ b/tests/tcg/test_cc.c
>> > @@ -1,7 +1,11 @@
>> >   /* SPDX-License-Identifier: GPL-2.0-or-later */
>> > -/* Include a standard header to make sure cross compiler provides the=
m */
>> > +/* Use some standard headers to ensure the cross compiler provides th=
em */
>> >   #include <stdint.h>
>> > +#include <string.h>
>> > +#include <stdbool.h>
>> > +#include <stddef.h>
>> > +#include <stdio.h>
>> >   int main(void)
>> >   {
>>=20
>> Ideally, we should do separate tests for system vs user tests.
>> System ones are always compiled with -ffreestanding, while user ones sho=
uld
>> provide a C library.
>>=20
>> From this standard:
>>=20
>> https://www.open-std.org/jtc1/sc22/wg21/docs/papers/2023/p2338r3.html
>> ```
>> A freestanding C implementation is required to provide the entirety of t=
he
>> following headers:
>>=20
>> <float.h>
>> <iso646.h>
>> <limits.h>
>> <stdalign.h>
>> <stdarg.h>
>> <stdbool.h>
>> <stddef.h>
>> <stdint.h>
>> <stdnoreturn.h>
>> Most of <string.h> is required (strdup, strndup, strcoll, strxfrm, and
>> strerror are excluded). This includes strtok, which requires global data.
>> ```
>>=20
>> Maybe for now we can just remove stdio.h from current patch, as it's not
>> supposed to be provided in a freestanding environment.
>
> A huge number of files under tests/tcg/ have a #include <stdio.h>
> currently.

They are all *-user mode tests though, which do need a proper libc.

>
> In the example build failure in the commit message, we have
>
>   tests/tcg/s390x/system/../console.c
>
> which does
>
>   #include "../../../pc-bios/s390-ccw/sclp.c"
>
> and sclp.c has
>
>   #include "s390-ccw.h"
>
> and that header has:
>
>   #include <stdbool.h>
>   #include <stddef.h>
>   #include <stdint.h>
>   #include <stdio.h>
>
> hence the 4 headers I added to the meson check.
>
> So AFAICT, our code is expecting stdio.h to be provided in a
> -ffreestanding build. Have we got a more fundamental mistake
> wrt our use of -ffreestanding, such that it is relying on
> unintended functionality ?

They shouldn't - but s390x seems to be doing something funky here. Ilya
can you explain what s390x is trying to do here?

>
> With regards,
> Daniel

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

