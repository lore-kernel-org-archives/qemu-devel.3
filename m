Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A553C43458
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jun 2026 18:59:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wdBlS-0002aH-10; Fri, 26 Jun 2026 14:59:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <linisha232@gmail.com>)
 id 1wdBlM-0002ZC-3t
 for qemu-devel@nongnu.org; Fri, 26 Jun 2026 14:58:53 -0400
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <linisha232@gmail.com>)
 id 1wdBlJ-00083i-RN
 for qemu-devel@nongnu.org; Fri, 26 Jun 2026 14:58:51 -0400
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-490b64c8311so15196395e9.3
 for <qemu-devel@nongnu.org>; Fri, 26 Jun 2026 11:58:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782500328; cv=none;
 d=google.com; s=arc-20260327;
 b=mXD93g4dFwxWYkq97jPEqwYukhbEEhOjrIU3W2rqQt4XcEHpBetZsAj7n4CDIBeUEE
 l566QU0w7el4Ych8F442jXbffGtLwzE9gsDwQw87LhrW5Rdj1lQ+MwOL9kooxWckhQ1g
 tCBEvK+dUF9UiMXcic4dkj1j9gKuvPf2J0fpdq+zJpFCE13Vucr4J7SI1PhokxrfwIHz
 3sA8/lhZTyFkFpQOz0rnV6zcvDp/DKQR/V6t7Irmt55lC0qXw6DZIo2tD/OCcp5NzJGd
 0+djjcMydi2HnJOWI+3Tw05Om81XgbxhVrIW47crtcLbPWlaOATksshd9LPn3B8Pe/JL
 i8FQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=QVovn2eI0oqBbH09lMrfmlLDZSJoooELepuKz1ZlmFg=;
 fh=r3BcR13fMoDVYE3ZDXHxmfMgt7OQ8Y/yN7kOeiQ9B1M=;
 b=qBZXXjqcX92ajeIDRAyw/vbekYOV0kuB19vad/Zh8S0wvbv5OKPe1QIAgMN1Jkj4Wx
 l+fEhFzIky1YXjf3Gkhk1+YrqCCqn0ywhR1NfwtevM9IOazJyW5FFf8dWw4ClmLqepbu
 LJZbdbAXcTdbtyIPhQwvPYVahis/jHy6BvDIMZIDZ68KfY+Vv29DewV9nCd/7DXFUAC9
 qhXvSV+JgvIlOWBKDp+8YTCUqPQD0snXG8bceqEj5JhuOj7yZ7/l6Z40o032cWGeOYKH
 kLk/4TGOEIgkjOSZG2LZb91zukHfy1AqvsyUBUzwSRkT8nrLTJF+mXnjaUktJY3tIEQu
 FZ2g==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1782500328; x=1783105128; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QVovn2eI0oqBbH09lMrfmlLDZSJoooELepuKz1ZlmFg=;
 b=ZW8aXbCdvFb5q3fGWA0PwE9x90xcrLCiOH2hDqiTVLvGBFQ+onK29UOTWn1Wdr6hjA
 ZGInesuP/DLay8eTMAMDtu+GEZRPE5sseU2z6+Tujx9MuJ4h9Q4js0dF0D9DtY6+E+Lb
 xM0gpEPTYYYE+b7zNxufh07FAIOm/xgp10sLNaAIF4Dll5TUbd2yJDiK/pwDRI3Aj4mt
 FllpcV3ZKJ9d8xEyhci6PvHwzY2NHZLZhXOzDbphUClNZjq4OBYkeVxZLOMfW9xdKi+F
 CqrPpoVfPJOhCglO32akQqbjLgJTkzX6/9IzTrl8sI6z2wSw8oBefxTi7wDC6Pc1FFP6
 vrww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782500328; x=1783105128;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=QVovn2eI0oqBbH09lMrfmlLDZSJoooELepuKz1ZlmFg=;
 b=XbbIQlE5b4+4Tg1cBmAisiu4oM5BLY+4OCJvprNO9bJ+iqGBvMqD6N3fTw9bM6rwlL
 tPAwgdI3o9quV/DoqLci0Y4muV0abAf2mh2IznjtDIRA6vZ0wP37qZj+yfe+U3uTYJU4
 olKdHeY8hLKl7BDDsUDKYypXH/KICWHpIzn4IzCvwTJDhOKWmxxPMOVkYMAlalor1TmP
 nWWhnJ5rAyQS0ph0JjJE3AL2LL1et9mGBxwO0FjTN7FouCsA8GYO3sGnP7YEUzYxFBiB
 vbyP4CFGk9bZgpWWLGxgP22gSFjwTlCsTnc31z/Ays6Poy5zuH3Y+Q30P5GPzVADOa3Z
 VH3A==
X-Forwarded-Encrypted: i=1;
 AFNElJ+EqVgYTv9TnT6BZAvRkRSlOD1Jh1gc4ukdA0NVYngqTF97kRBNXANpPrbbJ3tezCXg6oLY/agS/qLI@nongnu.org
X-Gm-Message-State: AOJu0YztQYLXa+z9sFgOYgx+HRfRL3QwjH7uX4TdRrybNoPcxf48+sYQ
 oSu+EPZbUTqFRNIJ2Z6XWiyTz5+lWanYNksvsmfy9zNYBJ9zTnx0xE3ysiMKOco6SLxZkO3iIxc
 JCoILC8ucW4MlVgUd8u/WIoKrk0Ja2/o=
X-Gm-Gg: AfdE7cm2PMLNDysgJwHZlvp48DO/beICgLYAm9f3sg3tSVii0sDPddGsdYDUD038aZx
 99UVNtaXB6/OYmGvn3W63PLVC7VjpWiL8Qakfn1e6Vp40HElfgy5ciEHOGP7oAweTsz4Q4B2cO/
 NtFWWjckfEMfdRTej7/lpIHpO4Uj/22QWuM4BtTWNaYED/laxrOujVZI84Jb/3QMVF7Ckho3MG5
 MPbsIhFpQeyb2w+mSMYyTPqe91jSciS9PSLG7bkiUCdm2UNbdz+u6GhTvMzgS3Md0nQBWHxxX4=
X-Received: by 2002:a05:600c:a111:b0:492:68bc:3237 with SMTP id
 5b1f17b1804b1-49268bc34e3mr66424255e9.32.1782500327401; Fri, 26 Jun 2026
 11:58:47 -0700 (PDT)
MIME-Version: 1.0
References: <20260623205839.1294-1-linisha232@gmail.com>
 <20260625192121.1887-1-linisha232@gmail.com>
 <aj5P0n03aKv93uci@redhat.com>
 <9d695c7f-bb02-44bd-8e1c-f8bdbf3bbbf7@oss.qualcomm.com>
 <CAGKMO+VCZ_3cPWx000N_+REsEK+gQg8RCWJcx7YEchUcy20V-Q@mail.gmail.com>
 <c0292d61-3915-416f-a6e1-d8498dcd42e9@oss.qualcomm.com>
 <CAGKMO+XpdeOQwqqp6sq+q2gbGBkH-inBU0B49buohQ6OWhOxUA@mail.gmail.com>
 <CAGKMO+XRcM86qk_X3qaWeYjvxnHWj-jsyWC-FoBLkYBemHJgtA@mail.gmail.com>
 <CAGKMO+VVgV_qx9rwz7XQQhW5y9GzjuZJcGfd9ucTGx=Y58pPUg@mail.gmail.com>
 <fe22c259-195c-4032-94dc-7b62fe3f25e3@oss.qualcomm.com>
In-Reply-To: <fe22c259-195c-4032-94dc-7b62fe3f25e3@oss.qualcomm.com>
From: linisha <linisha232@gmail.com>
Date: Sat, 27 Jun 2026 00:28:34 +0530
X-Gm-Features: AVVi8CfxqqWj4IwEdktiq8nBOTpkVXoEdi0__ayulvTrl-D89-PhPCU6WxMuRqw
Message-ID: <CAGKMO+VzDjFZj_TDwrSPqL3vMaqwy9gEh6GA3Jxst59AJpxRxg@mail.gmail.com>
Subject: Re: [PATCH v2] docs/system: add general note about architecture and
 machine differences
To: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Cc: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 qemu-devel@nongnu.org, alex.bennee@linaro.org, peter.maydell@linaro.org, 
 pbonzini@redhat.com, mjt@tls.msk.ru, philmd@mailo.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=linisha232@gmail.com; helo=mail-wm1-x329.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

Hmm that would explain it! I'm on Git Bash / MinGW on Windows, so
there may indeed be a line-ending or Perl quirk affecting how the
script parses MAINTAINERS. Good to know, I'll keep this in mind and
double-check the MAINTAINERS file directly when picking CCs in the
future, rather than relying solely on the script's output.

On Sat, Jun 27, 2026 at 12:19=E2=80=AFAM Pierrick Bouvier
<pierrick.bouvier@oss.qualcomm.com> wrote:
>
> On 6/26/2026 11:44 AM, linisha wrote:
> > Just to clear the confusion, attached the screenshot.
> >
>
> Hum interesting.
>
> On my side, reproduced on a clean debian container:
>
> $ git clone https://gitlab.com/qemu-project/qemu --depth=3D1 &&
> cd qemu && ./scripts/get_maintainer.pl -f docs/
> Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com> (maintainer:General
> Documenta...)
> qemu-devel@nongnu.org (open list:All patches CC here)
>
> Maybe we have a funny joke hiding there with mingw/windows.
>
> > Best regards,
> > Linisha
> >
> > On Sat, Jun 27, 2026 at 12:10=E2=80=AFAM linisha <linisha232@gmail.com>=
 wrote:
> >>
> >> Hi Pierrick,
> >>
> >> Quick correction to my last reply =E2=80=94 I checked again more caref=
ully and
> >> get_maintainer.pl -f docs/ still says "No maintainers found" on my
> >> tree (origin/master), even after git pull. It only lists recent
> >> contributors. So whatever change adds you to MAINTAINERS isn't in my
> >> tree yet =E2=80=94 could you point me to the commit/branch?
> >>
> >> Apologies for the confusion.
> >>
> >> Best regards,
> >> Linisha
> >>
> >> On Sat, Jun 27, 2026 at 12:08=E2=80=AFAM linisha <linisha232@gmail.com=
> wrote:
> >>>
> >>> Hi Pierrick,
> >>>
> >>> You're right =E2=80=94 my tree was outdated. I just ran git pull and =
now
> >>> scripts/get_maintainer.pl -f docs/ does show you as maintainer for
> >>> General Documentation. Sorry for the miss; I'll make sure to pull and
> >>> re-check maintainers before sending future versions.
> >>>
> >>> Best regards,
> >>> Linisha
> >>>
> >>> On Fri, Jun 26, 2026 at 11:58=E2=80=AFPM Pierrick Bouvier
> >>> <pierrick.bouvier@oss.qualcomm.com> wrote:
> >>>>
> >>>> On 6/26/2026 10:44 AM, linisha wrote:
> >>>>> Hi Daniel, Pierrick,
> >>>>>
> >>>>> Thank you, Daniel, for the Reviewed-by tag and the wrapping feedbac=
k.
> >>>>>
> >>>>> Pierrick =E2=80=94 I didn't intentionally remove anyone. I used
> >>>>> scripts/get_maintainer.pl -f docs/ which returned Peter Maydell,
> >>>>> Philippe Mathieu-Daud=C3=A9, Richard Henderson, Alex Benn=C3=A9e, a=
nd C=C3=A9dric Le
> >>>>> Goater, and I picked CCs from that list along with people who
> >>>>> responded to v1. You weren't in the script's output, so I didn't kn=
ow
> >>>>> to include you. Apologies for the miss =E2=80=94 I'll CC you on any=
 future v3.
> >>>>>
> >>>>
> >>>> Thanks for your answer.
> >>>>
> >>>> Just to dig this further, is your tree up to date?
> >>>>
> >>>> When running it on my side (from upstream/master), I get:
> >>>> $ scripts/get_maintainer.pl -f docs/
> >>>> Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com> (maintainer:Gen=
eral
> >>>> Documenta...)
> >>>> qemu-devel@nongnu.org (open list:All patches CC here)
> >>>>
> >>>>> Daniel =E2=80=94 I'll send a v3 with the commit message body proper=
ly
> >>>>> line-wrapped to 76 characters. Let me know if there are other chang=
es
> >>>>> you'd like at the same time.
> >>>>>
> >>>>> Best regards, Linisha
> >>>>>
> >>>>> On Fri, Jun 26, 2026 at 9:09=E2=80=AFPM Pierrick Bouvier
> >>>>> <pierrick.bouvier@oss.qualcomm.com> wrote:
> >>>>>>
> >>>>>> On 6/26/2026 3:09 AM, Daniel P. Berrang=C3=A9 wrote:
> >>>>>>> CC Pierrick as docs maintainer.
> >>>>>>>
> >>>>>>
> >>>>>> Thanks Daniel.
> >>>>>>
> >>>>>> I wonder how I was not in original recipients for this patch.
> >>>>>> @Linisha: did you explicitly set list of recipients, or remove som=
e people?
> >>>>>>
> >>>>>>> On Fri, Jun 26, 2026 at 12:51:19AM +0530, Linisha wrote:
> >>>>>>>> Add a note near the start of the introduction explaining that QE=
MU options, properties, and command lines may differ between target archite=
ctures and machine types. This helps prevent confusion when examples shown =
for one architecture do not work for another, such as the pflash0/pflash1 o=
ptions visible in -machine help on some machines but not others.
> >>>>>>>
> >>>>>>> Please ensure commit messages are line wrapped.
> >>>>>>>
> >>>>>>>>
> >>>>>>>> Suggested-by: Peter Maydell <peter.maydell@linaro.org>
> >>>>>>>>
> >>>>>>>> Buglink: https://gitlab.com/qemu-project/qemu/-/issues/3254
> >>>>>>>> Signed-off-by: Linisha <linisha232@gmail.com>
> >>>>>>>> ---
> >>>>>>>>
> >>>>>>>> v2: Take a different approach based on review feedback from Dani=
el
> >>>>>>>>     Berrang=C3=A9 and Peter Maydell. Instead of incorrectly clai=
ming
> >>>>>>>>     pflash0/pflash1 are virt-only (they actually work on x86 pc/=
q35
> >>>>>>>>     machines too), add a general note near the start of the intr=
oduction
> >>>>>>>>     about how options, properties, and command lines may differ =
between
> >>>>>>>>     target architectures and machine types.
> >>>>>>>>
> >>>>>>>>
> >>>>>>>>  docs/system/introduction.rst | 9 +++++++++
> >>>>>>>>  1 file changed, 9 insertions(+)
> >>>>>>>>
> >>>>>>>> diff --git a/docs/system/introduction.rst b/docs/system/introduc=
tion.rst
> >>>>>>>> index bec7291e47..8d9ef61d26 100644
> >>>>>>>> --- a/docs/system/introduction.rst
> >>>>>>>> +++ b/docs/system/introduction.rst
> >>>>>>>> @@ -1,6 +1,15 @@
> >>>>>>>>  Introduction
> >>>>>>>>  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >>>>>>>>
> >>>>>>>> +.. note::
> >>>>>>>> +   QEMU supports many different target CPU architectures and ma=
ny
> >>>>>>>> +   different machine types for each architecture. Options, prop=
erties,
> >>>>>>>> +   and command lines that work for one architecture or machine =
type
> >>>>>>>> +   will not necessarily work on another. The examples shown in =
this
> >>>>>>>> +   manual are specific to the architecture and machine type bei=
ng
> >>>>>>>> +   demonstrated. When in doubt, consult the documentation for y=
our
> >>>>>>>> +   specific target architecture and machine type.
> >>>>>>>> +
> >>>>>>>
> >>>>>>> Not convinced many people will read this, but I gues it doesn't
> >>>>>>> hurt.
> >>>>>>>
> >>>>>>> Reviewed-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
> >>>>>>>
> >>>>>>>
> >>>>>>>>  .. _Accelerators:
> >>>>>>>>
> >>>>>>>>  Virtualisation Accelerators
> >>>>>>>> --
> >>>>>>>> 2.47.0.windows.1
> >>>>>>>>
> >>>>>>>
> >>>>>>> With regards,
> >>>>>>> Daniel
> >>>>>>
> >>>>
>

