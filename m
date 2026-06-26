Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9F52C43458
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jun 2026 19:36:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wdCL8-0003Pu-Ou; Fri, 26 Jun 2026 15:35:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <linisha232@gmail.com>)
 id 1wdCL5-0003PW-De
 for qemu-devel@nongnu.org; Fri, 26 Jun 2026 15:35:49 -0400
Received: from mail-wr1-x432.google.com ([2a00:1450:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <linisha232@gmail.com>)
 id 1wdCL3-0004qf-9Q
 for qemu-devel@nongnu.org; Fri, 26 Jun 2026 15:35:47 -0400
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-46e4764ca48so1218287f8f.0
 for <qemu-devel@nongnu.org>; Fri, 26 Jun 2026 12:35:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782502543; cv=none;
 d=google.com; s=arc-20260327;
 b=IR7Vg5eqDG06TTJqcIJpfwQx7MgKg41lvenEoUmMp5kozOMOOtP3mreY/A64Padvq2
 PSVuwiFODqjmrM5FzlBYWAkPEyHBahd00LQPHzRc9rS8tz4q+z6tbQAsWMfk2FTqhi4H
 Uqpki+7teNUd/vij1hK/YbJxardMvb1gXFuowkrkElXhHn92lgw2M5rDezwZaMmVNF2u
 f3s3FVo2Sckd3zLl2/HXftSiY8zbX+sSCfrq30dcwUSjUvRIT1R3ASbjlRukoPbAV1TO
 1NzYYM+t7pxDRLBF6AG6aZh3vBCIDvWB7+oU+Sb5N+v3DcMltw4rbec4+QDRn32rEHr5
 szYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=JK+lWSyVRUyCrlfLsjIr0+vRLBR8ajW0zxpJLEvMn/4=;
 fh=sPQOHDVPXjYDb+6GXmgTsCvlUSpmTcOwqHTBDGFwkPU=;
 b=X1QDcTfb0cS2DntsZZzW+RVir02tSpmLNCG7kLKWXtwEN6LvXvK2tHC15rTXCh2gs5
 lIjnzb57V/1qWVCE4kKUYhtp5pmtfKbFSTYV/hapO9etbi+IiaP/34nl8RRk7IBIBNr1
 0azQ/cEQyiv897/3Z3NgjU3H/AAWgOhy71jfgRpE+F1RMAvWxPpRrleD5bzbqr0fsya4
 v/MPIU1AytE/DWntvniDHuTMVCwzEY5Z2r38AArgNH8xDmV7yL7XYEY2UiSWTh0N0jmn
 SABbF5m8tVPn9b7u9oIjlz9a4R/vMUSP6cHHfaHkXy0Wf5Ke0USl0X0rgI6N+5TwO8dI
 qwmw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1782502543; x=1783107343; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=JK+lWSyVRUyCrlfLsjIr0+vRLBR8ajW0zxpJLEvMn/4=;
 b=JNAfMRT+ZrvDlROjYVYx7v2RvNjFR204i90cWi9zBi089EMEb+TIjsTNf7uMHrit22
 mILMbWXRYAPLcVoQF5Y90NJ3sJmjn5jEXV9fhgHpGtEDqZWSH/ym2vtnTLNljSHoIC33
 RpAjztFmuWnMssLLnBkR5zMYI7W7OzhMD2uJ7jE1tJcpoWSsQRYD/E1b5L9bg7qAWBDs
 CKFAH8lr8eEdE6glphvouiCzKlnvii2EWu+JAs7IROnJ4HK5T4CX+CpYnlmQ4y7I2rNd
 lDygK7pbC+9h/H9hDVLoaHpAZoTUsgi0OhNqJma4xaVwx61yIdJch45QCkK8Ctx/rskY
 KjSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782502543; x=1783107343;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=JK+lWSyVRUyCrlfLsjIr0+vRLBR8ajW0zxpJLEvMn/4=;
 b=OTZvptRzkYuoDTvE+pBq4aWZvet1jYVtZ+lcMEHA5caBpveotyZ66BLg0zglNz033q
 95YTa9uyJcb/xGc4z4nkYZ8RMjQW+/mnmJDbKqL9l7Mh/pVPL3HKOeH+oMXmBME7l1Fa
 DGtZ6QEAcFIWoOSdUMDV+VDsU1UAN5tlKmjFsQBUigbOhTlF5BkEdkD9OyVscqUdc7/4
 n6OtJNm/IG1F3KuHqwQc2uTV183cFRTW4s3P5viI6GW56cTlLJ/Y6tf7wbMx8sl4z3iy
 3g4uMM6e9E3qwnBYMKLMldZFcjt5URxWlEj4DQqW8fj8d6kBTxqILwcO7xKNdxkz0zK0
 Yoxw==
X-Forwarded-Encrypted: i=1;
 AHgh+Rp1snmNE/kZIimgv9+TvP/G+pKRNRNqEURlD1yyringZBAuFUxgw7Yir5WRKyP67fAlCRlyaWwTKBCN@nongnu.org
X-Gm-Message-State: AOJu0YxzrsgFx8H+0th/fA+6hai23wn3u2Nxe8XbDqOr096mMwZtTxxC
 ToNIWWQyIo3DS5x0SC86s46KuKzdnyrnz8zfI5XODlMMuFkUxibie2J/wnJHRB4lPmevJAfzo1N
 lEcRb+HRwe4fAxotQjOuBwpY8ByoJAw8=
X-Gm-Gg: AfdE7ck2kZbIAztUrVpX1ZhZR0dA72IluUfuwvNODQQwNMdnfOOjaehvWe3OcmQdrDb
 EoA8CBY2jo78JHHxonLDskrs/2rLPyVnZdcC20Ch0jMtW5J3MHwrDUUSoZptOXDJ4MlBb7eC3FZ
 uKPb7zEmHNiktsrrXVtmwTkgp3p5ffA76Ym4n3l1KNd+9Od0EtLUBRExbssrp7Z7/EmO0h7L0KU
 XxESdwhI3ro0LIAgTma1SYJye0jDJqNUkrQ35WPoe2ujwnRsTLh1+LSWjciuAn01GA5ZRoK14Po
 V7/sNWzn2A==
X-Received: by 2002:a05:6000:41ed:b0:46f:fcf5:59a5 with SMTP id
 ffacd0b85a97d-46ffd049e4fmr1693771f8f.28.1782502543187; Fri, 26 Jun 2026
 12:35:43 -0700 (PDT)
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
 <CAGKMO+VzDjFZj_TDwrSPqL3vMaqwy9gEh6GA3Jxst59AJpxRxg@mail.gmail.com>
 <3eeed5ef-792b-40db-a49f-8fdf904664cc@oss.qualcomm.com>
In-Reply-To: <3eeed5ef-792b-40db-a49f-8fdf904664cc@oss.qualcomm.com>
From: linisha <linisha232@gmail.com>
Date: Sat, 27 Jun 2026 01:05:30 +0530
X-Gm-Features: AVVi8Cd-AaOEUslMepbxHJMgZ07mwbgGwaydFCCaQs4UUIVNl5hRqjhypDiSxh0
Message-ID: <CAGKMO+X=6xYfsW+o1Vppk-cP4eFywwZdOBmHpfJEitvnqJ=FQA@mail.gmail.com>
Subject: Re: [PATCH v2] docs/system: add general note about architecture and
 machine differences
To: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Cc: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 qemu-devel@nongnu.org, alex.bennee@linaro.org, peter.maydell@linaro.org, 
 pbonzini@redhat.com, mjt@tls.msk.ru, philmd@mailo.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::432;
 envelope-from=linisha232@gmail.com; helo=mail-wr1-x432.google.com
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

Thanks for the tip!

On Sat, Jun 27, 2026 at 12:43=E2=80=AFAM Pierrick Bouvier
<pierrick.bouvier@oss.qualcomm.com> wrote:
>
> On 6/26/2026 11:58 AM, linisha wrote:
> > Hmm that would explain it! I'm on Git Bash / MinGW on Windows, so
> > there may indeed be a line-ending or Perl quirk affecting how the
> > script parses MAINTAINERS. Good to know, I'll keep this in mind and
> > double-check the MAINTAINERS file directly when picking CCs in the
> > future, rather than relying solely on the script's output.
> >
>
> In case your (corporate) machine allows it, you can also use WSL to have
> a native Linux env instead of using MSYS2.
> In my experience it works very well.
>
> > On Sat, Jun 27, 2026 at 12:19=E2=80=AFAM Pierrick Bouvier
> > <pierrick.bouvier@oss.qualcomm.com> wrote:
> >>
> >> On 6/26/2026 11:44 AM, linisha wrote:
> >>> Just to clear the confusion, attached the screenshot.
> >>>
> >>
> >> Hum interesting.
> >>
> >> On my side, reproduced on a clean debian container:
> >>
> >> $ git clone https://gitlab.com/qemu-project/qemu --depth=3D1 &&
> >> cd qemu && ./scripts/get_maintainer.pl -f docs/
> >> Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com> (maintainer:Gener=
al
> >> Documenta...)
> >> qemu-devel@nongnu.org (open list:All patches CC here)
> >>
> >> Maybe we have a funny joke hiding there with mingw/windows.
> >>
> >>> Best regards,
> >>> Linisha
> >>>
> >>> On Sat, Jun 27, 2026 at 12:10=E2=80=AFAM linisha <linisha232@gmail.co=
m> wrote:
> >>>>
> >>>> Hi Pierrick,
> >>>>
> >>>> Quick correction to my last reply =E2=80=94 I checked again more car=
efully and
> >>>> get_maintainer.pl -f docs/ still says "No maintainers found" on my
> >>>> tree (origin/master), even after git pull. It only lists recent
> >>>> contributors. So whatever change adds you to MAINTAINERS isn't in my
> >>>> tree yet =E2=80=94 could you point me to the commit/branch?
> >>>>
> >>>> Apologies for the confusion.
> >>>>
> >>>> Best regards,
> >>>> Linisha
> >>>>
> >>>> On Sat, Jun 27, 2026 at 12:08=E2=80=AFAM linisha <linisha232@gmail.c=
om> wrote:
> >>>>>
> >>>>> Hi Pierrick,
> >>>>>
> >>>>> You're right =E2=80=94 my tree was outdated. I just ran git pull an=
d now
> >>>>> scripts/get_maintainer.pl -f docs/ does show you as maintainer for
> >>>>> General Documentation. Sorry for the miss; I'll make sure to pull a=
nd
> >>>>> re-check maintainers before sending future versions.
> >>>>>
> >>>>> Best regards,
> >>>>> Linisha
> >>>>>
> >>>>> On Fri, Jun 26, 2026 at 11:58=E2=80=AFPM Pierrick Bouvier
> >>>>> <pierrick.bouvier@oss.qualcomm.com> wrote:
> >>>>>>
> >>>>>> On 6/26/2026 10:44 AM, linisha wrote:
> >>>>>>> Hi Daniel, Pierrick,
> >>>>>>>
> >>>>>>> Thank you, Daniel, for the Reviewed-by tag and the wrapping feedb=
ack.
> >>>>>>>
> >>>>>>> Pierrick =E2=80=94 I didn't intentionally remove anyone. I used
> >>>>>>> scripts/get_maintainer.pl -f docs/ which returned Peter Maydell,
> >>>>>>> Philippe Mathieu-Daud=C3=A9, Richard Henderson, Alex Benn=C3=A9e,=
 and C=C3=A9dric Le
> >>>>>>> Goater, and I picked CCs from that list along with people who
> >>>>>>> responded to v1. You weren't in the script's output, so I didn't =
know
> >>>>>>> to include you. Apologies for the miss =E2=80=94 I'll CC you on a=
ny future v3.
> >>>>>>>
> >>>>>>
> >>>>>> Thanks for your answer.
> >>>>>>
> >>>>>> Just to dig this further, is your tree up to date?
> >>>>>>
> >>>>>> When running it on my side (from upstream/master), I get:
> >>>>>> $ scripts/get_maintainer.pl -f docs/
> >>>>>> Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com> (maintainer:G=
eneral
> >>>>>> Documenta...)
> >>>>>> qemu-devel@nongnu.org (open list:All patches CC here)
> >>>>>>
> >>>>>>> Daniel =E2=80=94 I'll send a v3 with the commit message body prop=
erly
> >>>>>>> line-wrapped to 76 characters. Let me know if there are other cha=
nges
> >>>>>>> you'd like at the same time.
> >>>>>>>
> >>>>>>> Best regards, Linisha
> >>>>>>>
> >>>>>>> On Fri, Jun 26, 2026 at 9:09=E2=80=AFPM Pierrick Bouvier
> >>>>>>> <pierrick.bouvier@oss.qualcomm.com> wrote:
> >>>>>>>>
> >>>>>>>> On 6/26/2026 3:09 AM, Daniel P. Berrang=C3=A9 wrote:
> >>>>>>>>> CC Pierrick as docs maintainer.
> >>>>>>>>>
> >>>>>>>>
> >>>>>>>> Thanks Daniel.
> >>>>>>>>
> >>>>>>>> I wonder how I was not in original recipients for this patch.
> >>>>>>>> @Linisha: did you explicitly set list of recipients, or remove s=
ome people?
> >>>>>>>>
> >>>>>>>>> On Fri, Jun 26, 2026 at 12:51:19AM +0530, Linisha wrote:
> >>>>>>>>>> Add a note near the start of the introduction explaining that =
QEMU options, properties, and command lines may differ between target archi=
tectures and machine types. This helps prevent confusion when examples show=
n for one architecture do not work for another, such as the pflash0/pflash1=
 options visible in -machine help on some machines but not others.
> >>>>>>>>>
> >>>>>>>>> Please ensure commit messages are line wrapped.
> >>>>>>>>>
> >>>>>>>>>>
> >>>>>>>>>> Suggested-by: Peter Maydell <peter.maydell@linaro.org>
> >>>>>>>>>>
> >>>>>>>>>> Buglink: https://gitlab.com/qemu-project/qemu/-/issues/3254
> >>>>>>>>>> Signed-off-by: Linisha <linisha232@gmail.com>
> >>>>>>>>>> ---
> >>>>>>>>>>
> >>>>>>>>>> v2: Take a different approach based on review feedback from Da=
niel
> >>>>>>>>>>     Berrang=C3=A9 and Peter Maydell. Instead of incorrectly cl=
aiming
> >>>>>>>>>>     pflash0/pflash1 are virt-only (they actually work on x86 p=
c/q35
> >>>>>>>>>>     machines too), add a general note near the start of the in=
troduction
> >>>>>>>>>>     about how options, properties, and command lines may diffe=
r between
> >>>>>>>>>>     target architectures and machine types.
> >>>>>>>>>>
> >>>>>>>>>>
> >>>>>>>>>>  docs/system/introduction.rst | 9 +++++++++
> >>>>>>>>>>  1 file changed, 9 insertions(+)
> >>>>>>>>>>
> >>>>>>>>>> diff --git a/docs/system/introduction.rst b/docs/system/introd=
uction.rst
> >>>>>>>>>> index bec7291e47..8d9ef61d26 100644
> >>>>>>>>>> --- a/docs/system/introduction.rst
> >>>>>>>>>> +++ b/docs/system/introduction.rst
> >>>>>>>>>> @@ -1,6 +1,15 @@
> >>>>>>>>>>  Introduction
> >>>>>>>>>>  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >>>>>>>>>>
> >>>>>>>>>> +.. note::
> >>>>>>>>>> +   QEMU supports many different target CPU architectures and =
many
> >>>>>>>>>> +   different machine types for each architecture. Options, pr=
operties,
> >>>>>>>>>> +   and command lines that work for one architecture or machin=
e type
> >>>>>>>>>> +   will not necessarily work on another. The examples shown i=
n this
> >>>>>>>>>> +   manual are specific to the architecture and machine type b=
eing
> >>>>>>>>>> +   demonstrated. When in doubt, consult the documentation for=
 your
> >>>>>>>>>> +   specific target architecture and machine type.
> >>>>>>>>>> +
> >>>>>>>>>
> >>>>>>>>> Not convinced many people will read this, but I gues it doesn't
> >>>>>>>>> hurt.
> >>>>>>>>>
> >>>>>>>>> Reviewed-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
> >>>>>>>>>
> >>>>>>>>>
> >>>>>>>>>>  .. _Accelerators:
> >>>>>>>>>>
> >>>>>>>>>>  Virtualisation Accelerators
> >>>>>>>>>> --
> >>>>>>>>>> 2.47.0.windows.1
> >>>>>>>>>>
> >>>>>>>>>
> >>>>>>>>> With regards,
> >>>>>>>>> Daniel
> >>>>>>>>
> >>>>>>
> >>
>

