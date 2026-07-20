Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9D50C44524
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jul 2026 16:03:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wlqRH-0003S5-6e; Mon, 20 Jul 2026 12:01:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1wlqQd-0003Hp-H9
 for qemu-devel@nongnu.org; Mon, 20 Jul 2026 12:01:30 -0400
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1wlqQb-0005bO-KI
 for qemu-devel@nongnu.org; Mon, 20 Jul 2026 12:01:15 -0400
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-4954aff6088so20284665e9.3
 for <qemu-devel@nongnu.org>; Mon, 20 Jul 2026 09:01:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1784563272; x=1785168072; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :user-agent:references:in-reply-to:subject:cc:to:from:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=qkGXXcEmb0Lov1uMTqJnjJBL98VB9Jw/+TrmYRzcpnk=;
 b=QfpBtVpGsRyQjz+dpcPyGq35Y4v/WUI16rOg7ivpPxLsSiZUNCAoRZL53ok3Mp72aB
 HEBwY+t+WRCyd+CfXPJLJlkuW02hAihKns/pJMhw3nAxOrnLJ+3kTJLGXZ2fBlE3XYUn
 Mer/RQ+f3uIoFD9tbLGBfhJa/frq30hhHbDy0iBYycdrWXDT7HyqHCDPUc4GmzBKcjQC
 ub4H9CS2rpfyv42T4F1C/Vk5qZQJAx3K4mbyuqNrBPfvhrDyEK1oWg/o/asND+LpsRyg
 WDSAm+vdzEaOiXO8XKw4SN0M+csSEx7NdYc2bfFQn0pfZnNj9p6vtVfAaezRXri5ZkTS
 eMZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784563272; x=1785168072;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :user-agent:references:in-reply-to:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=qkGXXcEmb0Lov1uMTqJnjJBL98VB9Jw/+TrmYRzcpnk=;
 b=Z0ycrLrnfypBbMLCA7fBPqHQDJOOa7Fv55oCSq184eIdCHnjVd5FayhOqB9soyC5jw
 oCzyeur/HOmvHltTIrzHu5mgCIjuKXn6MiGzR1jVvLX9T0M0qWP4aiQlkw7q3/dQosng
 xCUL2h253N50kPsKIItRy3l5457u6G5VXO4/hQ/h3ngl+ekP4JhNzE3vI/RieXHi+zrB
 zelx2P99G4+F8d4bXey6QoSvSUWnbzrqaCw9amgZ9kS+V8Yp7XEywWekw0I0H2fKP2Js
 qtcRvMjQfD6xN/1P2WCRzSqqczBEWLHA/ZciTKvWzdhECjr0KCqrh2gehZC89du5smVM
 VQfA==
X-Forwarded-Encrypted: i=1;
 AHgh+RoeI3i9TODzPTnrvu0Hh6ucSQ7ViQhAfV4AnOm89jAc/zNiTupr/QZMNp2npPgI6vxoCeY+DyNVuFRr@nongnu.org
X-Gm-Message-State: AOJu0YzVeiXo8plc06kBiFw5tqnGAvmBhVkKccoSJEoBqTNr/FCOClzk
 lsW+i4tFLZlkPMdFI06tOnyFXCvTG0SYn16IFARNGLlLVecTPz/l5YXhIg2AlF6m+EU=
X-Gm-Gg: AfdE7ckfvnOMlCY5fgMKCTwTGfs9+D14yfzqRAmia/IZSdC/V4Es8KwtUmRwPtJ3Y24
 lq6R2Uqk7WVJ1CNxERAfkSPpnhfPU2QssUUjyojNcZRazLTgZGrLdxYFmm0Jyv1Tcw6pgvocJY1
 IMPVf2JGxieB3ti6OBFAulBcdGsZuzxU0oB71I7o5UJAeXf6LIEnic7MhWpjzvYhaZGdD8MYyh4
 y9xn1rMlcclYVogMGPzJTN8/Xory1dmCSUBHLkocIiHGk0mKhMz2heyiZDQOjlotash5wZxX4ND
 p4tpGsbjIRhK2mCGy4QxEkZaA3cx+iMfp7QUM77ZOO15I8wjx+JbkMM1xBj1yolqqL0xQR761xb
 KXf/YvfFZ9gcRFfeuxm1F2HB0jV06gYvDoR4ahsks7574JzvnMzKAQ5j0GiHyOs9XgoteV5gHQa
 krvw==
X-Received: by 2002:a05:600c:1c1b:b0:495:4b24:1b64 with SMTP id
 5b1f17b1804b1-4954b241d02mr185824765e9.0.1784563271186; 
 Mon, 20 Jul 2026 09:01:11 -0700 (PDT)
Received: from draig.lan ([185.124.0.114]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47f63e499c2sm29131191f8f.4.2026.07.20.09.01.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 20 Jul 2026 09:01:10 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id DFE345F911;
 Mon, 20 Jul 2026 17:01:08 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Stefan Hajnoczi <stefanha@gmail.com>
Cc: Peter Maydell <peter.maydell@linaro.org>,  Mohamed Mediouni
 <mohamed@unpredictable.fr>,  qemu-devel <qemu-devel@nongnu.org>
Subject: Re: macOS builds broken in CI
In-Reply-To: <CAJSP0QUkmT4vDPY0cHYFJNaeo57ZsNwxd8nYvAXtuHY8StPeYA@mail.gmail.com>
 (Stefan Hajnoczi's message of "Mon, 20 Jul 2026 11:36:32 -0400")
References: <CAJSP0QXRy1Dc_MwqtU_gS1+jOdrW=Vk6YynP75q5HP3Rz_CpTA@mail.gmail.com>
 <904444A5-0120-4BE6-8E11-C7167F2A3BDB@unpredictable.fr>
 <D91DC576-2462-4652-9E8C-5A7C96791622@unpredictable.fr>
 <CAFEAcA-X7h0hQ4FaTaVoEUKTJvxfaK8GcihR=+RzxOTBf3X_mw@mail.gmail.com>
 <CAJSP0QUkmT4vDPY0cHYFJNaeo57ZsNwxd8nYvAXtuHY8StPeYA@mail.gmail.com>
User-Agent: mu4e 1.14.3-pre1; emacs 30.1
Date: Mon, 20 Jul 2026 17:01:08 +0100
Message-ID: <87ldb5sla3.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x32d.google.com
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

Stefan Hajnoczi <stefanha@gmail.com> writes:

> On Mon, Jul 20, 2026 at 5:38=E2=80=AFAM Peter Maydell <peter.maydell@lina=
ro.org> wrote:
>>
>> On Thu, 25 Jun 2026 at 20:15, Mohamed Mediouni <mohamed@unpredictable.fr=
> wrote:
>> >
>> >
>> >
>> > > On 25. Jun 2026, at 21:11, Mohamed Mediouni <mohamed@unpredictable.f=
r> wrote:
>> > >
>> > >
>> > >
>> > >> On 25. Jun 2026, at 20:38, Stefan Hajnoczi <stefanha@gmail.com> wro=
te:
>> > >>
>> > >> Hi Alex,
>> > >> tests/tcg/multiarch/system/Makefile.softmmu-target's
>> > >> run-gdbstub-interrupt seems to be broken on GitLab CI macOS runners=
. 5
>> > >> days ago it still passed, but now rerunning the pipeline on the same
>> > >> commit ID fails:
>> > >>
>> > >> - Good (5 days ago): https://gitlab.com/qemu-project/qemu/-/pipelin=
es/2615134022
>> > >> - Bad (today): https://gitlab.com/qemu-project/qemu/-/pipelines/262=
9704018
>> > >>
>> > >> I've tried many CI runs with different pull requests applied on top=
 of
>> > >> qemu.git/master and they fail in the same way. Maybe it's an
>> > >> environmental thing with the macOS runners?
>> > >>
>> > >> It's unclear where the SIGKILL (Error 137) comes from. Could it be =
an
>> > >> out-of-memory condition on macOS runners?
>> > >
>> > > Hi,
>> > >
>> > > SIGKILL is the known symptom for failure during signature verificati=
on
>> > > by AMFI.
>> > >
>> > > Now that we don=E2=80=99t have separate -unsigned binaries anymore b=
ut relying
>> > > on in-place ad-hoc (w/o certificate) signing with entitlements we mi=
ght
>> > > have issues linked to that.
>> > >
>> > > In the past file modification had issues with verification tied to t=
he
>> > > inode and the workaround being a reboot or a cat binary > new_binary;
>> > > chmod +x new_binary so that the old (now out of sync) signing state =
is lost
>> > >
>> > This is highlighted in the software update context in: https://develop=
er.apple.com/documentation/security/updating-mac-software
>> >
>> > > This code is incorrect because it modifies the command-line
>> > > tool=E2=80=99s executable file in place. macOS caches information ab=
out
>> > > the code=E2=80=99s signature in the kernel. It doesn=E2=80=99t flush=
 that cache
>> > > when you modify the file=E2=80=99s contents. Modifying the file in p=
lace
>> > > yields a mismatch between the file=E2=80=99s contents and the in-ker=
nel
>> > > cache, which can cause a hard-to-reproduce code-signing crash
>> > > the next time you run the tool.
>> > > While this example uses a command-line tool to demonstrate the issue=
, updating any file that contains signed code might trigger this code-signi=
ng crash. That includes executables, frameworks, dynamic libraries, and bun=
dles.
>> > > To update a file that contains signed code without risking this cras=
h, write the updated code to a temporary file and replace the existing file=
 with that temporary one:
>>
>> I was just looking at this again today, but looking at our
>> scripts/entitlement.sh, when meson.build calls the script SRC
>> will be qemu-system-foo-unsigned and DST will be
>> qemu-system-foo, and we take the in_place case and do:
>>
>>   cp -pPf "$SRC" "$DST.tmp"
>>   SRC=3D"$DST.tmp"
>>
>> to copy the -unsigned binary to a .tmp file. Then we
>> run codesign on that .tmp file, and finally
>>
>>   mv -f "$SRC" "$DST"
>>
>> to rename the signed binary to its final name.
>>
>> So that looks to me like we're following the rules for
>> not signing executables in place to me...
>
> Hmm...then the next step could be reproducing the job failure locally
> on a Mac where it can be debugged or bisected.

Unfortunately I can't reproduce it on the one piece of hardware I have
access to.

We can disable the gdb tests and the rest passes:

  https://gitlab.com/qemu-project/qemu-ci-testing/-/pipelines/2690820623

>
> Please let me know if you need help on the GitLab CI side. Mac runners
> are available to open source projects, so you might not be able to
> test in a personal fork
> (https://docs.gitlab.com/ci/runners/hosted_runners/macos/). Peter, I
> think you have the same GitLab permissions as I do, so you could
> probably run experiments without my help.
>
> Stefan

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

