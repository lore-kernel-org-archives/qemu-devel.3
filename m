Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6688FD374E
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Feb 2026 12:26:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vvDxd-0001Te-RN; Wed, 25 Feb 2026 07:25:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vvDxc-0001TP-3B
 for qemu-devel@nongnu.org; Wed, 25 Feb 2026 07:25:48 -0500
Received: from mail-ej1-x631.google.com ([2a00:1450:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vvDxZ-00073M-Vz
 for qemu-devel@nongnu.org; Wed, 25 Feb 2026 07:25:47 -0500
Received: by mail-ej1-x631.google.com with SMTP id
 a640c23a62f3a-b8f9568e074so1138105966b.0
 for <qemu-devel@nongnu.org>; Wed, 25 Feb 2026 04:25:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1772022344; x=1772627144; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=U7/JSI+3sJkzgTe7hifC7lrID3/kE9/q5nZl6uVmzkc=;
 b=XG1figZ4OoG65KTtGRqsu5E1CtozLw9yO87D6SDQ09WeIUgQNboPXYAJR5YzzTNRPo
 UDgqWKg/YoRP2NKUV7Ec9eNigv/3uyAoP8GCEgnA/Gd/oYpMeArh3Zp2EvDlekjnCoyI
 llxihuf1oDYTlfl0k/x4OFrvma0NlJKjga+tPR1V1PWBxKpolwUKpAZM95dQGXKd6XYs
 JFqpeTUn/n/Wbwovxkj1esS7m3aBwW1o1Kw1lQv/YI/Km53TeCiuMJm1hFBZ7GPlBHlR
 8b//LMDm5xRkJgOmhgCnoXdWfntn/hAnlbtqDdEMruQqrYrUcAgCNxQXHb+FEP08p9Tl
 EH6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772022344; x=1772627144;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=U7/JSI+3sJkzgTe7hifC7lrID3/kE9/q5nZl6uVmzkc=;
 b=ezBKDwjshs2pBni92PY9ForijdNdBfTlqr5X2tNKGvaeEH2Nm0zRKpWLTibqgoKEhd
 QYHVx3LeaOnxbBv2ushPXP2e5MjOft4+jRDgZoJM32DkCDyyYQhCYrxSRAbNe2a2waZ3
 BKufDTlEH3zirApwtMiCLbODkil/qtlf1lYCw4oh+53ZPOpGXVuA+DyBSGGxvpK2q7/J
 6QJ8pskzd4ZsVVKrN/8NwWYp7IjsJYFsS8WOjgdhR/BdQW8GWAEM0NViFJqhkTdzosib
 BuO6xp5Ds8srPuTPfm4mjM3WkoGMtAfhuXFR6UUNexM1CPK82qL+QY95w07YH1xUTX4I
 1mHg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWbMFcnqsv82k1Am66Y39UhffG5e5i0t62CVhRwUwbRuuhfzrS4ikmV6IoSzG+XkAVgoGURMFARI7ai@nongnu.org
X-Gm-Message-State: AOJu0YwxvOEqDSTPc9yuiGYZXYenElBbl6Yaaq1GEforhoF4YcPjgf5x
 sxWkg5qpoBD0g+Otg0EZsQjEuZfUa/RoCTmDAHiOKa8ssB1HSCL3yViKlrJCcdiTdSI=
X-Gm-Gg: ATEYQzyoUSHWXyQyUvHEAE4DTi5VFpVbZt80huicYsnJhw2XVR4hBD4UsvYRFCAcOnY
 ReiFK+MolTSCj6wu/tIguLOoAtpkwoWUrLoTnIQE/hEjqimf64GddxE+Dhcjmlak7CI3RXpD646
 gFjgdhshiEbKV/6bUpU6KuxTJuCobG+TBGPNRN6GiAbZPj9fMTJ/SsbYYuJYMRVqY3vFumv9d75
 JTSiP+u+OkKJ7IZIB8nhjTTFli6BSfLAdRPPNgb5tPTI/Yu797NoF45QwxS/LwuvC5gxFJaZ1Wv
 V2cO3ZvAI46S1ef66xj6vnTpNo1DSV2Oerg6LHYOwXOTGA75IzN/1LGHM9cKDy3ylqYhDCVv6+j
 GYEmYJitWMTw2XmIxy7THq7j4+aPyPissXrFL1QugIVBRM+DK2b32mEBpDSKoRj3wy21qcKKBfY
 gJYv1qYr/PBOSK++O+S9UKuyY=
X-Received: by 2002:a17:907:84b:b0:b88:6542:86a0 with SMTP id
 a640c23a62f3a-b93517e2cb1mr1817366b.54.1772022344081; 
 Wed, 25 Feb 2026 04:25:44 -0800 (PST)
Received: from draig.lan ([185.124.0.126]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b9084c5de7esm503991066b.1.2026.02.25.04.25.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Feb 2026 04:25:43 -0800 (PST)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 7D2095F87E;
 Wed, 25 Feb 2026 12:25:42 +0000 (GMT)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Florian Hofhammer <florian.hofhammer@epfl.ch>
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>,  qemu-devel@nongnu.org,
 richard.henderson@linaro.org,  laurent@vivier.eu,  imp@bsdimp.com,
 berrange@redhat.com
Subject: Re: [PATCH v4 2/7] linux-user: make syscall emulation interruptible
In-Reply-To: <ef465a2b-d790-406e-a1fa-a7a5f95c18eb@epfl.ch> (Florian
 Hofhammer's message of "Wed, 25 Feb 2026 10:29:03 +0100")
References: <909b0a4f-9759-4e27-bba8-997ae2f41bd6@epfl.ch>
 <8096590c-bf13-4e5e-8167-ab38a37180bc@epfl.ch>
 <538ada16-07b8-403c-b1fa-f42db7cfc195@linaro.org>
 <874in52mzy.fsf@draig.linaro.org>
 <ef465a2b-d790-406e-a1fa-a7a5f95c18eb@epfl.ch>
User-Agent: mu4e 1.14.0-pre1; emacs 30.1
Date: Wed, 25 Feb 2026 12:25:42 +0000
Message-ID: <87jyw1103d.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::631;
 envelope-from=alex.bennee@linaro.org; helo=mail-ej1-x631.google.com
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

Florian Hofhammer <florian.hofhammer@epfl.ch> writes:

> On 25/02/2026 10:25, Alex Benn=C3=A9e wrote:
>> Pierrick Bouvier <pierrick.bouvier@linaro.org> writes:
>>=20
>>> On 2/24/26 7:50 AM, Florian Hofhammer wrote:
>>>> The syscall emulation code previously wasn't interruptible via
>>>> cpu_loop_exit(), as this construct relies on a longjmp target that is =
not
>>>> live anymore in the syscall handling code. Consequently, longjmp() wou=
ld
>>>> operate on a (potentially overwritten) stale jump buffer. This patch a=
dds an additional
>>>> setjmp and the necessary handling around it to make longjmp() (and by
>>>> proxy cpu_loop_exit() safe to call even within a syscall context.
>>>> Signed-off-by: Florian Hofhammer <florian.hofhammer@epfl.ch>
>>>> ---
>>>>   linux-user/aarch64/cpu_loop.c      |  2 +-
>>>>   linux-user/alpha/cpu_loop.c        |  2 +-
>>>>   linux-user/arm/cpu_loop.c          |  2 +-
>>>>   linux-user/hexagon/cpu_loop.c      |  2 +-
>>>>   linux-user/hppa/cpu_loop.c         |  4 ++++
>>>>   linux-user/i386/cpu_loop.c         |  8 +++++---
>>>>   linux-user/include/special-errno.h |  8 ++++++++
>>>>   linux-user/loongarch64/cpu_loop.c  |  5 +++--
>>>>   linux-user/m68k/cpu_loop.c         |  2 +-
>>>>   linux-user/microblaze/cpu_loop.c   |  2 +-
>>>>   linux-user/mips/cpu_loop.c         |  5 +++--
>>>>   linux-user/or1k/cpu_loop.c         |  2 +-
>>>>   linux-user/ppc/cpu_loop.c          |  6 ++++--
>>>>   linux-user/riscv/cpu_loop.c        |  2 +-
>>>>   linux-user/s390x/cpu_loop.c        |  2 +-
>>>>   linux-user/sh4/cpu_loop.c          |  2 +-
>>>>   linux-user/sparc/cpu_loop.c        |  4 +++-
>>>>   linux-user/syscall.c               | 16 ++++++++++++++++
>>>>   linux-user/xtensa/cpu_loop.c       |  3 +++
>>>>   19 files changed, 59 insertions(+), 20 deletions(-)
>>>> diff --git a/linux-user/sparc/cpu_loop.c
>>>> b/linux-user/sparc/cpu_loop.c
>>>> index 7391e2add8..f054316dce 100644
>>>> --- a/linux-user/sparc/cpu_loop.c
>>>> +++ b/linux-user/sparc/cpu_loop.c
>>>> @@ -229,7 +229,9 @@ void cpu_loop (CPUSPARCState *env)
>>>>                                 env->regwptr[2], env->regwptr[3],
>>>>                                 env->regwptr[4], env->regwptr[5],
>>>>                                 0, 0);
>>>> -            if (ret =3D=3D -QEMU_ERESTARTSYS || ret =3D=3D -QEMU_ESIG=
RETURN) {
>>>> +            if (ret =3D=3D -QEMU_ERESTARTSYS
>>>> +                    || ret =3D=3D -QEMU_ESIGRETURN
>>>> +                    || ret =3D=3D -QEMU_ESETPC) {
>>>>                   break;
>>>>               }
>>>
>>> Just a style nit:
>>> if (ret =3D=3D -QEMU_ERESTARTSYS ||
>>>     ret =3D=3D -QEMU_ESIGRETURN ||
>>>     ret =3D=3D -QEMU_ESETPC) {
>>=20
>> I was hopping the ret test could be wrapped up into a helper but it
>> seems sparc and x86 have enough variation in handled ret codes to make
>> that difficult.
>
> It's not just x86 and sparc, there generally seems to not be consensus
> on whether return codes are checked via a single conditional check (as
> is the case with sparc), dedicated conditional checks for each possible
> error value, or via switch statements. I think moving that into a helper
> would require a bit of refactoring across architectures.
> I could check that out for a follow-up patch set if you think this makes
> sense.

I think we can live with it for now:

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>


>
> Best regards,
> Florian

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

