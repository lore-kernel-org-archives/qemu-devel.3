Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A15C0C44501
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jul 2026 06:12:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1whLVU-0000ZB-IR; Wed, 08 Jul 2026 02:11:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jcmvbkbc@gmail.com>)
 id 1whLVT-0000Yt-A7
 for qemu-devel@nongnu.org; Wed, 08 Jul 2026 02:11:39 -0400
Received: from mail-qv1-xf2d.google.com ([2607:f8b0:4864:20::f2d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jcmvbkbc@gmail.com>)
 id 1whLVR-0005CG-NH
 for qemu-devel@nongnu.org; Wed, 08 Jul 2026 02:11:39 -0400
Received: by mail-qv1-xf2d.google.com with SMTP id
 6a1803df08f44-8efcef23d21so2508266d6.2
 for <qemu-devel@nongnu.org>; Tue, 07 Jul 2026 23:11:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783491096; cv=none;
 d=google.com; s=arc-20260327;
 b=QoZRerCtVQhL6sgzdC6+9HSeX7jUomJNDrAEJ+UNjQLwQTSWlC7pHPfZ01u1ac/GBg
 YCRBgxeCUvooRaoOmZJ/LFflOW7icwkuTAyq1jClivMfDbA+huEgzrvjkzJNyzfgh2as
 Izr8+BPkjPBzwfN5WntNUBe/YyWOMc4/G1q4d9+T49l6aIGvi7qiShWUj1rHNm1ScWmu
 4uXFdqNVmOlGtA26f+Yf7/dWX5rVJ/ASTzxrp1nZJZ6TwmFwdhxtkoa5nONZXoaTOsgB
 LcWvn+S7QxuFCIVSX8wdTdes9K9GixpVOeIWyqCwYFBkTXGc7n/u6aM5OeeLOVmJdBL7
 Pd9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=aNIxXk4bR6Nvqx+DWtT70jXBqjVIf527NVWqQmo0Xhg=;
 fh=py8qWij750+NlEfFcK5ghwGWeGBs72nVcPl8SzkNb0c=;
 b=WjK3joKG0n2wI1ccb4JPP6tTHUh7/FRNwFZoGKPJc8UESaJvWpEFZF1zFaj126O/HE
 mRJHaYgQXLG11A97M33IkZ2ulbQhjJOVLJqsDTbp38eK3QtBQh7b91fxjq5kPQZhHZ2+
 gVndBrqqxN8pULJmKyCWX+pwgFC8VB3CQZz1lG7IrkpIAakRVA1wtq5WAzrqR9eVMAg2
 9yW5bK1kx4Knsr7c2cz2uet05aE596HVgekjMUPMiJzDsfXojQng0N3yqQZbCGtluyJz
 ft1UlfFwOJynnZcGPtO7383LGnq1Pj0ackdiiqbYBYtfuzVwTFgl+WaMX1RYA1Ticr5M
 WrAg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1783491096; x=1784095896; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=aNIxXk4bR6Nvqx+DWtT70jXBqjVIf527NVWqQmo0Xhg=;
 b=FzOurn0EpI+I9jNHGUR+T4FEXGG260BaAjk31A0QLnMsmkidJIa4ZYnkxuWntLYx62
 eFGMBvvQorsrjz7eM2oxhFb9ZMRRXit8NxRIIVQr9Fxa9OtGE0z7YKioU6PHf3WRMlVF
 KuyC/q4T6pcLyRKoIMrdFLOArUA0rYekSh+/uuSzbI45CugYr590BY6N89Moy1ULRyqH
 aAzfqil0P7Pe7Kjak8mLdeIF6BMwWoeMdF1B/HEvFf7anQxUJhHTn58xB90oIco1Zkwd
 gluBd2m4mMNB7m6tK3SGE4FFm1Js5FPILQ3olJBz2NERAiT5vaOf5lI+V0yvW50aslNq
 U3xA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783491096; x=1784095896;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=aNIxXk4bR6Nvqx+DWtT70jXBqjVIf527NVWqQmo0Xhg=;
 b=KVcVesK21S/3aZyEqm1l3pq31N550hF2yLd04s/+48LeNYzKBMEM8UOaG0l/CkRbDz
 TAR5VDl15YsGeUXjVZh2Yxk2bipG5uzSzFEES8iDD5W7BPLsOaCXN3WajKM1E+i+cSV5
 vh//6gUiuZRRLijN1u+Y1/WNrV5QTbPZZCaT7UKbqFdlzb7ijoSP5VZcIL1hJ06srFu/
 MDaNqT80T6M6VOL6zgQZS9sgKyUckeoVpWInEnRpaU2FkMV8i8MamVbqx+fkmTy7pBPJ
 Sq0PUAeqcVroCJwLEnct2lSzUbxVbjoKe2HssuwFID/yqTVn8QkCDY0vIzBCWMRoLSO7
 grKQ==
X-Gm-Message-State: AOJu0YxJTqhDSbhhhdU2lprVsLXyMDPq6ejxQmG6NiEJm8dkPnGfEBSm
 0W6AsthUfryvUbf42Pex8qzHnRMcQDihPGlNkgW/hCSehJHez0IoXxzTFB97vouRFEc97p6Du+Y
 X4r0UbzUZYumAI/7v5hWh1+7Q8l0vJ3Q=
X-Gm-Gg: AfdE7ckEg5og3pGdMdgkcQ6dGFgGc4LMGwnNPz5mzijWrFMoWbQjWN092+gKIAb3jSV
 zqLHAx15R7SC5nSDjx4SNsTDM/fDgt0cS+fdhmhBDP/rF3/fzovZ70y8UzAeO+bI/9W2Z6/jfDs
 x06eejm7XFBjwq+Z9A5Xd9oq49DuCtUjcY9Acn8iH6bXCJZuyh7zojj+c2vRAkrP23mFwjafZWZ
 mY9+lZZy1BtiPjQLvxhctSS9J3pIJKmnSp6LDnLwXW8ShTqL0LUX9nfL6AN4nstNeXeHcIw4nzv
 2km74QQnyUGi8aqMdbVQRxIcs1LpwIrojv7E/e5D8QPTUn5MRUu2sQ/fKd8P
X-Received: by 2002:a05:6214:48d:b0:8e9:f62b:bee5 with SMTP id
 6a1803df08f44-8fec304fb5cmr9812276d6.53.1783491096463; Tue, 07 Jul 2026
 23:11:36 -0700 (PDT)
MIME-Version: 1.0
References: <20260706223343.988769-1-pierrick.bouvier@oss.qualcomm.com>
 <20260706223343.988769-88-pierrick.bouvier@oss.qualcomm.com>
 <CAMo8BfJg09ca6Kxw0WLLj0SQLBcOCwYmSN=e3u063oY-fgrdfw@mail.gmail.com>
 <99d7064e-50f3-4947-884a-6f6c14f2cee2@oss.qualcomm.com>
 <84fddbf3-e523-4a23-b95e-cc6102e459c3@oss.qualcomm.com>
In-Reply-To: <84fddbf3-e523-4a23-b95e-cc6102e459c3@oss.qualcomm.com>
From: Max Filippov <jcmvbkbc@gmail.com>
Date: Tue, 7 Jul 2026 23:11:25 -0700
X-Gm-Features: AVVi8CejDDqt-WPeT9CEcCCZYcxXGzhc7i4mEn_NZQvnLlDpZ3dQxkcS_5zCQfY
Message-ID: <CAMo8BfKGqu=GbDhp525Oqt4VVCC7cPSYZ5obsUuuFQYKvreeKQ@mail.gmail.com>
Subject: Re: [PATCH v3 87/91] tests/tcg/xtensa/crt.S: align .text section
To: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@oss.qualcomm.com>, 
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Thomas Huth <thuth@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, 
 Peter Maydell <peter.maydell@linaro.org>, Ilya Leoshkevich <iii@linux.ibm.com>,
 Brian Cain <brian.cain@oss.qualcomm.com>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 Gustavo Romero <gustavo.romero@linaro.org>, Laurent Vivier <laurent@vivier.eu>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Helge Deller <deller@gmx.de>, 
 Richard Henderson <richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::f2d;
 envelope-from=jcmvbkbc@gmail.com; helo=mail-qv1-xf2d.google.com
X-Spam_score_int: 4
X-Spam_score: 0.4
X-Spam_bar: /
X-Spam_report: (0.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 FROM_LOCAL_NOVOWEL=0.5, HK_RANDOM_ENVFROM=0.999, HK_RANDOM_FROM=0.999,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On Tue, Jul 7, 2026 at 11:10=E2=80=AFAM Pierrick Bouvier
<pierrick.bouvier@oss.qualcomm.com> wrote:
> On 7/7/2026 9:30 AM, Pierrick Bouvier wrote:
> > On 7/7/2026 6:45 AM, Max Filippov wrote:
> >> On Mon, Jul 6, 2026 at 3:43=E2=80=AFPM Pierrick Bouvier
> >> <pierrick.bouvier@oss.qualcomm.com> wrote:
> >>>
> >>> Needed, else we get this error:
> >>> dangerous relocation: l32r: misaligned literal target: .text
> >>
> >> This flag wasn't needed before because crt.S hasn't been built
> >> with text-section-literals, why is it needed now?
> >>
> > Previously, .S and .c were compiled in different steps, with different
> > options. Now, with meson, we have to provide a single compiler command
> > for all the files (no intermediate steps), which is a *hard* requiremen=
t
> > to save user from dealing with compilation details in arch files.

This sounds a bit restrictive for the tests, no?

> > One consequence is that .c + .S combination gets
> > -mtext-section-literals, which triggers this. Easily fixed by adding th=
e
> > .align section.

Ok, not having literals in the text section isn't essential for the existin=
g
xtensa tests. But not being able to do that deliberately feels a bit strang=
e.

> > I can add this in commit description, if you're ok with this
> > explanation, and accept the patch.

Sure. Feel free to add
Reviewed-by: Max Filippov <jcmvbkbc@gmail.com>

> >>> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
> >>> ---
> >>>  tests/tcg/xtensa/crt.S | 1 +
> >>>  1 file changed, 1 insertion(+)
> >>>
> >>> diff --git a/tests/tcg/xtensa/crt.S b/tests/tcg/xtensa/crt.S
> >>> index 909872cd385..de8fd8c1cd7 100644
> >>> --- a/tests/tcg/xtensa/crt.S
> >>> +++ b/tests/tcg/xtensa/crt.S
> >>> @@ -6,6 +6,7 @@
> >>>      jx      a2
> >>>
> >>>  .text
> >>> +.align 4
> >>>  .global _start
> >>>  _start:
> >>>  #if XCHAL_HAVE_WINDOWED
> >>> --
> >>> 2.47.3
> >>>
> >>>
> >>
> >>
> >
>
> While at it, any chance you could give some hints about how to compile
> for xtensaeb? I didn't find any compiler flag, and out of modifying
> target/xtensa/core-dc232b/core-isa.h to set XCHAL_HAVE_BE to 1, I'm stuck=
.
>
> I doubt it's the right way to do considering that it was not needed befor=
e.

You can download a compiler for the core `test_kc705_be` from
  https://github.com/foss-xtensa/toolchain/releases/tag/2020.07
and then either run qemu `configure` with the option
  --cross-cc-xtensaeb=3Dxtensa-test_kc705_be-elf-gcc
or run tests with
  make test-tcg CORE=3Dtest_kc705_be CC=3Dxtensa-test_kc705_be-elf-gcc

The `CORE` variable chooses both the argument for the qemu `-cpu` option
and include directory used when building tests. The `CC` chooses the
compiler and linker.

I usually run configure with some compilers for little- and big-endian xten=
sa
and then run tests switching the core and compiler.
--=20
Thanks.
-- Max

