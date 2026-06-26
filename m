Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0435C43327
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jun 2026 18:45:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wdBYB-0006fX-6K; Fri, 26 Jun 2026 14:45:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <linisha232@gmail.com>)
 id 1wdBY9-0006ex-Ul
 for qemu-devel@nongnu.org; Fri, 26 Jun 2026 14:45:13 -0400
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <linisha232@gmail.com>)
 id 1wdBY7-0003l0-GI
 for qemu-devel@nongnu.org; Fri, 26 Jun 2026 14:45:13 -0400
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-4633193af19so775377f8f.2
 for <qemu-devel@nongnu.org>; Fri, 26 Jun 2026 11:45:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782499510; cv=none;
 d=google.com; s=arc-20260327;
 b=ixm4e3ADZtvhEsPFgnCpDSNF/RLox83dO25bSI3auxXZJAQcl68DrPeLa4a1vFRXFN
 xjNPxSj2LLyCCM8MrmVqklp6PuA/e/ZwvS0b6WMWWCAyaQZdTHhwncZQKZbqJeU3GqZM
 xKmFZa9UpPhUDd9TYGayQO2cegYgObiM6ShjFhwj3A4TTD8YXQWGAmg8fgltf2b/51Xk
 19Rf58MXJF2hxBvqtOhjd0BPmAbCBrX5wv4pmGAnEgnPf7W94tkDKUXDgooUzgMnCNED
 BzHpQAgTc3oUxjahZrkBV8K8dOc5ORVVPOh4lOOh8m3vjnLu7GICObP4AilhdVSrN+/d
 x0xQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=l4Xf7jt9npdBd8Zm+Z7oJqrwdWvKjJaT98D9qJzQkXA=;
 fh=lSfCyTateRL+9bAvqmxMUiC3uKAUKq7BVZlxY6M0i7U=;
 b=Z8ceDVCfp+dlYiqPuqtMoy1Paf/54wQX90ym1QpSdrO1knGtI0boTEaxnGD1wOnLCr
 J0AxXjXuGzhCHHhOSXOtRasSigERnWpk8+sluvsmkeO5ma8Ty/YZxNqHwf2O3uFOCSo7
 qZchkJkHM5sLDNDPJU6Fg2z9YRWHfmTu1ZRuT7bTTGMyZKRyw3SED0Cjke69zA4Y8RRi
 5zF6DknjF/tdTiuPhhwqveCviM2RAdUgEGtq2NRunfLu6HAK1D2loNiKhAhQsegFxwLS
 OHvlZBlw0oIIECTWC+ai1hTaq8liosi2TCCbRYEuZ1nuRSPCTEsszFtzGFziYqF1x04C
 8dGA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1782499510; x=1783104310; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=l4Xf7jt9npdBd8Zm+Z7oJqrwdWvKjJaT98D9qJzQkXA=;
 b=C3MN84Hv5vrJsYS6ppsKSEFWBBVo/sVbVjJAP7YLrJuptlk4HbHDwb3DFpFBtWAsrk
 8l68g8vokzDkF6XCWRMGgmAcjzAaphqyAsPbbRofCNda6BSqGv5qKnKlDdDHl1o5YOo9
 lo/oPcJHM74Eq5Y6cADVKHXfWNXxHaNETtYI/KASa+2zSQkJpR9Mg6V8Yf9jhWK2gDQA
 DVC70KE7qiUTBBowZ7VoDmOAQEGrV4pezFJbWWB/QCwmyn0iPs/7EGBtjhEUZdLlVc12
 SnNHClr7TTq9TZGcoRAjk8Zn0TUFSey03EcK2SkJzo3iRKkjMKXetXtbshyC3W3kEDo+
 1GaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782499510; x=1783104310;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=l4Xf7jt9npdBd8Zm+Z7oJqrwdWvKjJaT98D9qJzQkXA=;
 b=GVEi7mDQHX7uTL4cGZLN4vyTyBQPB6YKHGN8tB0kcjQoS70nG4HjC76RxV3eijAQPV
 U6YQYMaRTAX3TpDIZhQ1FrDln44s/S6ieVByv7qYHM/a1rWCV3vbr+HIvIawBzxRgKn6
 l3d8wFgvFx+muF45FmeXg2a+e30Bmv3M9FPGEqqCE9z9zCVVFUTupdSs23/N+Ll/79sI
 e9Fet7bNpfAZEabMLcotxCa0+G11oMyMKPUVd3zOj50TWutlp5/8yzPDeJae4RCrc7SX
 zoCjijrll0pXvC9Q2zF4q5R81azGv1wXM7LXehYy/9e22oKWNFO1wEm3OzvUpxQnou99
 LXMg==
X-Forwarded-Encrypted: i=1;
 AFNElJ98+m/9RwN1pQ5OYd/KRiiVo4lq1NAm3sQTuERYI9jIZkvV69lvMU+Z9fAO7QAoNJAcKq1Vy3EOPVNZ@nongnu.org
X-Gm-Message-State: AOJu0YxrrkCjHmwNUuU/b3bu5aIuJTnjD6RMfQseDYiu8Yu9GeDswYrL
 b4rXclUo7Iwc6wAZRBKSN4rgxlKzE5UoJZh9BY9Xks3CHDH2D8qxu7Akg3ggrEX6ERc8wSvjbRo
 icZ7rj+SjJnk/Izn0+vmz8niTC3m8NTg=
X-Gm-Gg: AfdE7ckN1ht2aWt4HGkzvyDQlngsl3gQOcssr/HxIbKzCg9C9Nyf0a60XAFVwxn8/VH
 cdz7LSkQ4aPd39C7jb6/OS+k/rG+/H6+M/Ik2QphHDfkXEyEsPT2VVzvpXWrjdhvUwH4bxwOMRw
 aX7+2N8SyfUqBUBU+hN0nfedreBUKQdQxsM3QaEUS6iYwuXIMVwlhH4h7HBMM+GQ9yUr3qsCU/k
 pfbY1q/1fM30N9wfzjpjkF3tTAHoLqfsd6C5r+87qO9fs8kSGbaQS/0sgC816MHj1HdN01Qk+0=
X-Received: by 2002:a05:600d:6409:10b0:490:ce99:d2ee with SMTP id
 5b1f17b1804b1-4926fc43078mr29392135e9.15.1782499509493; Fri, 26 Jun 2026
 11:45:09 -0700 (PDT)
MIME-Version: 1.0
References: <20260623205839.1294-1-linisha232@gmail.com>
 <20260625192121.1887-1-linisha232@gmail.com>
 <aj5P0n03aKv93uci@redhat.com>
 <9d695c7f-bb02-44bd-8e1c-f8bdbf3bbbf7@oss.qualcomm.com>
 <CAGKMO+VCZ_3cPWx000N_+REsEK+gQg8RCWJcx7YEchUcy20V-Q@mail.gmail.com>
 <c0292d61-3915-416f-a6e1-d8498dcd42e9@oss.qualcomm.com>
 <CAGKMO+XpdeOQwqqp6sq+q2gbGBkH-inBU0B49buohQ6OWhOxUA@mail.gmail.com>
 <CAGKMO+XRcM86qk_X3qaWeYjvxnHWj-jsyWC-FoBLkYBemHJgtA@mail.gmail.com>
In-Reply-To: <CAGKMO+XRcM86qk_X3qaWeYjvxnHWj-jsyWC-FoBLkYBemHJgtA@mail.gmail.com>
From: linisha <linisha232@gmail.com>
Date: Sat, 27 Jun 2026 00:14:56 +0530
X-Gm-Features: AVVi8CcGQ5JeQjs_dBbNr1n3C2lLHfkznfz77oVAY1rNAbnnhN5GfPfbd0LNvfI
Message-ID: <CAGKMO+VVgV_qx9rwz7XQQhW5y9GzjuZJcGfd9ucTGx=Y58pPUg@mail.gmail.com>
Subject: Re: [PATCH v2] docs/system: add general note about architecture and
 machine differences
To: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Cc: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 qemu-devel@nongnu.org, alex.bennee@linaro.org, peter.maydell@linaro.org, 
 pbonzini@redhat.com, mjt@tls.msk.ru, philmd@mailo.com
Content-Type: multipart/mixed; boundary="0000000000001392a506552c82f4"
Received-SPF: pass client-ip=2a00:1450:4864:20::434;
 envelope-from=linisha232@gmail.com; helo=mail-wr1-x434.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DC_PNG_UNO_LARGO=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

--0000000000001392a506552c82f4
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Just to clear the confusion, attached the screenshot.

Best regards,
Linisha

On Sat, Jun 27, 2026 at 12:10=E2=80=AFAM linisha <linisha232@gmail.com> wro=
te:
>
> Hi Pierrick,
>
> Quick correction to my last reply =E2=80=94 I checked again more carefull=
y and
> get_maintainer.pl -f docs/ still says "No maintainers found" on my
> tree (origin/master), even after git pull. It only lists recent
> contributors. So whatever change adds you to MAINTAINERS isn't in my
> tree yet =E2=80=94 could you point me to the commit/branch?
>
> Apologies for the confusion.
>
> Best regards,
> Linisha
>
> On Sat, Jun 27, 2026 at 12:08=E2=80=AFAM linisha <linisha232@gmail.com> w=
rote:
> >
> > Hi Pierrick,
> >
> > You're right =E2=80=94 my tree was outdated. I just ran git pull and no=
w
> > scripts/get_maintainer.pl -f docs/ does show you as maintainer for
> > General Documentation. Sorry for the miss; I'll make sure to pull and
> > re-check maintainers before sending future versions.
> >
> > Best regards,
> > Linisha
> >
> > On Fri, Jun 26, 2026 at 11:58=E2=80=AFPM Pierrick Bouvier
> > <pierrick.bouvier@oss.qualcomm.com> wrote:
> > >
> > > On 6/26/2026 10:44 AM, linisha wrote:
> > > > Hi Daniel, Pierrick,
> > > >
> > > > Thank you, Daniel, for the Reviewed-by tag and the wrapping feedbac=
k.
> > > >
> > > > Pierrick =E2=80=94 I didn't intentionally remove anyone. I used
> > > > scripts/get_maintainer.pl -f docs/ which returned Peter Maydell,
> > > > Philippe Mathieu-Daud=C3=A9, Richard Henderson, Alex Benn=C3=A9e, a=
nd C=C3=A9dric Le
> > > > Goater, and I picked CCs from that list along with people who
> > > > responded to v1. You weren't in the script's output, so I didn't kn=
ow
> > > > to include you. Apologies for the miss =E2=80=94 I'll CC you on any=
 future v3.
> > > >
> > >
> > > Thanks for your answer.
> > >
> > > Just to dig this further, is your tree up to date?
> > >
> > > When running it on my side (from upstream/master), I get:
> > > $ scripts/get_maintainer.pl -f docs/
> > > Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com> (maintainer:Gene=
ral
> > > Documenta...)
> > > qemu-devel@nongnu.org (open list:All patches CC here)
> > >
> > > > Daniel =E2=80=94 I'll send a v3 with the commit message body proper=
ly
> > > > line-wrapped to 76 characters. Let me know if there are other chang=
es
> > > > you'd like at the same time.
> > > >
> > > > Best regards, Linisha
> > > >
> > > > On Fri, Jun 26, 2026 at 9:09=E2=80=AFPM Pierrick Bouvier
> > > > <pierrick.bouvier@oss.qualcomm.com> wrote:
> > > >>
> > > >> On 6/26/2026 3:09 AM, Daniel P. Berrang=C3=A9 wrote:
> > > >>> CC Pierrick as docs maintainer.
> > > >>>
> > > >>
> > > >> Thanks Daniel.
> > > >>
> > > >> I wonder how I was not in original recipients for this patch.
> > > >> @Linisha: did you explicitly set list of recipients, or remove som=
e people?
> > > >>
> > > >>> On Fri, Jun 26, 2026 at 12:51:19AM +0530, Linisha wrote:
> > > >>>> Add a note near the start of the introduction explaining that QE=
MU options, properties, and command lines may differ between target archite=
ctures and machine types. This helps prevent confusion when examples shown =
for one architecture do not work for another, such as the pflash0/pflash1 o=
ptions visible in -machine help on some machines but not others.
> > > >>>
> > > >>> Please ensure commit messages are line wrapped.
> > > >>>
> > > >>>>
> > > >>>> Suggested-by: Peter Maydell <peter.maydell@linaro.org>
> > > >>>>
> > > >>>> Buglink: https://gitlab.com/qemu-project/qemu/-/issues/3254
> > > >>>> Signed-off-by: Linisha <linisha232@gmail.com>
> > > >>>> ---
> > > >>>>
> > > >>>> v2: Take a different approach based on review feedback from Dani=
el
> > > >>>>     Berrang=C3=A9 and Peter Maydell. Instead of incorrectly clai=
ming
> > > >>>>     pflash0/pflash1 are virt-only (they actually work on x86 pc/=
q35
> > > >>>>     machines too), add a general note near the start of the intr=
oduction
> > > >>>>     about how options, properties, and command lines may differ =
between
> > > >>>>     target architectures and machine types.
> > > >>>>
> > > >>>>
> > > >>>>  docs/system/introduction.rst | 9 +++++++++
> > > >>>>  1 file changed, 9 insertions(+)
> > > >>>>
> > > >>>> diff --git a/docs/system/introduction.rst b/docs/system/introduc=
tion.rst
> > > >>>> index bec7291e47..8d9ef61d26 100644
> > > >>>> --- a/docs/system/introduction.rst
> > > >>>> +++ b/docs/system/introduction.rst
> > > >>>> @@ -1,6 +1,15 @@
> > > >>>>  Introduction
> > > >>>>  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > > >>>>
> > > >>>> +.. note::
> > > >>>> +   QEMU supports many different target CPU architectures and ma=
ny
> > > >>>> +   different machine types for each architecture. Options, prop=
erties,
> > > >>>> +   and command lines that work for one architecture or machine =
type
> > > >>>> +   will not necessarily work on another. The examples shown in =
this
> > > >>>> +   manual are specific to the architecture and machine type bei=
ng
> > > >>>> +   demonstrated. When in doubt, consult the documentation for y=
our
> > > >>>> +   specific target architecture and machine type.
> > > >>>> +
> > > >>>
> > > >>> Not convinced many people will read this, but I gues it doesn't
> > > >>> hurt.
> > > >>>
> > > >>> Reviewed-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
> > > >>>
> > > >>>
> > > >>>>  .. _Accelerators:
> > > >>>>
> > > >>>>  Virtualisation Accelerators
> > > >>>> --
> > > >>>> 2.47.0.windows.1
> > > >>>>
> > > >>>
> > > >>> With regards,
> > > >>> Daniel
> > > >>
> > >

--0000000000001392a506552c82f4
Content-Type: image/png; name="image.png"
Content-Disposition: attachment; filename="image.png"
Content-Transfer-Encoding: base64
Content-ID: <f_mqva4e8g0>
X-Attachment-Id: f_mqva4e8g0

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
rkJggg==
--0000000000001392a506552c82f4--

