Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83972C43458
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jun 2026 17:45:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wdAbp-00060x-R7; Fri, 26 Jun 2026 13:44:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <linisha232@gmail.com>)
 id 1wdAbo-00060o-Aq
 for qemu-devel@nongnu.org; Fri, 26 Jun 2026 13:44:56 -0400
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <linisha232@gmail.com>)
 id 1wdAbm-000543-JC
 for qemu-devel@nongnu.org; Fri, 26 Jun 2026 13:44:56 -0400
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-470174001a0so41343f8f.0
 for <qemu-devel@nongnu.org>; Fri, 26 Jun 2026 10:44:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782495893; cv=none;
 d=google.com; s=arc-20260327;
 b=frZcNlD5Q+KVy0YLb/EAVw1/SXVkQtNAM4kfWst7lxIhmzR995VwNCM88E8qMHnKOs
 w2qJbHj47KbpjakcoY/7Njo3tE5G2PfF+kRmmptRADwAa2mbr5jXXPvjX8ikxpfDLWQp
 PJF/ryqnEU1SHcB9GWEkbiz3FMXHgUzbzbsyq9yE/iZGRznqSTglC22Z4GoYU/bIP+sb
 StHOs57JoDQjBpnlBz7mT+9QPbF6N+LDDOdm3XQY4xsZWOhqXk2qsHveaoOs82ia9mHe
 yNM6jTFBFVqWNOZRFAwlvpHP57NFrcOHzi41Vdtrnn+BRUsLX6o3Ud0bZoV3KJ4p4p68
 0pHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=8L1gPUr0IVwOFOqht3f5vnDVUzAsaNNQKkl+2ooJzz0=;
 fh=KcN5oJLvRVz/5dRW0Q4UYdLDBzEfja7oyGGwLRxd/uI=;
 b=Jz3s388IEw6gmDUKy6AxONKzFpmwzUJ15b6ExtSrwpeK8yR4DvPdOw03ySTgvlUQEb
 UzEwHVc0GLwXUpZsIS1HGjnvq/O3gui3kpql0RZMdn+iGxD5dWumQ127XDJw2uypDura
 nqX6UR9h8TYe0sZ5tV2luRjnZ91wqLCbk3qPMUsZkM5k3TwxpmPuK+wbrtq5SRHbraAr
 zw+lSSrNG+NWj18dO/Ie1+VT/oMeU5qHMVtrySOzhy5nEpDj0/BZvCSMYRR4lVpUA3fT
 G4G0xnVzT/4CpiVl5kKOqG9VtYbSnfwtm9xMHv/UPW2HsGR1bB2ihPE7Tlq/ujPJ7SC9
 gq9Q==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1782495893; x=1783100693; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8L1gPUr0IVwOFOqht3f5vnDVUzAsaNNQKkl+2ooJzz0=;
 b=c1QYwvc2K9WV8N4lUt3BKh4CO07KSvygSOUlb2YYZ8JJ95z8BzCYCCsz070DsdUW2e
 qMNWNwNgzctbl4d+myidckcTgtcD+Mrg76T9aXOLZ70uEGFe4laF5ewiUQpz8NUiEnB/
 FY8mCd1zdvGVWFxe/NxFqyErLyudzGWLpYBJnhSPx9g4Ld3/LmO7CCitpiCUC5RMfETi
 a5OKNWrRJNHM2NvKgy0QPSQJkw+xQJw2Ss/mVLYGDnTLAZJrNzKGqh/JAJixWXM/tPkh
 W/yuLzjauJt5mvCiempAsCgF75qEwN5GdlT4Wy/L7Sr6B+/3YZfUC07ms+U/kHaptD84
 FbAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782495893; x=1783100693;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=8L1gPUr0IVwOFOqht3f5vnDVUzAsaNNQKkl+2ooJzz0=;
 b=sFQD2/UU3ZsI1/WGZRhPfeRyb7ogh26qpH8Z0ebZ1uKh5N4143MQVifzfJbRpyOj5L
 tVoMelDupBC8UO2obCNBoApZNcOXrBaK2LQU4jt2XTussuW//GT6iJmD1bMyFf9QnPa3
 KJ4cv1sY67uzkX1NRaJsPKlzOx97EJIu2+rRDPEtInfXqopzQeCMX547LvgFE/0cIBYj
 G6jJMTKjDfVL0+tXUOfafHpf5QO32N2icXf6vujnxAAmvfmE3LyoaLTuzaRhZXxdlmwq
 w+WGIZo0gMEdXN2ebRaxy4IrequNXMDQjZ+u4L4vXbFcFQhokLhYOSmMwC3We61a5nbH
 35MA==
X-Forwarded-Encrypted: i=1;
 AHgh+RrK7VUjUvVdNTYOlrvkfpaoWi3jLvD0U61BDqjD1Cg6qq2iLCac6WglPOeBmkzypFy0J7B1mWWB74FR@nongnu.org
X-Gm-Message-State: AOJu0YzJFN31b8ShDe04jsP7O3DHFr0jAwgekmBYA0YGUIJoNITdAIva
 3BT5gi90RbbHeQJP1nkhml1TQ49toRXkitQ9eWXJ7ZkLkt9FYr2nQ92Q1laSBr4JbPaBXT+csuH
 2Wfm+ZgyKxU8LAYtHXIFY7n4LAzSnNJE=
X-Gm-Gg: AfdE7cnzrH66q741c6l0B2RqzGSvmi8p/7v9VNjVMdRzzjm7FdA4BO8p3eHjGdiE2EI
 cyxGU6Zs7OBBzRbtN0RANiMT6wUtuRFxIbkox2zLOM6OLSErJaUX/qAaMur6FcV/xJdTkfj07Jq
 FKc1o9qZpK1dLoTnllIlaU6HwICFZETrASA7lH6ZsGUVW3/KNGnYUMvJrQgpbydJ7F5fRUTT8ya
 D9gP5UrdRQx5zayKtbn5K9OV9g8lpK7xHVagAZIBSpZIQjlMax59kFzLb5FbmHl4yHRRhWxIR8=
X-Received: by 2002:a5d:5f44:0:b0:465:fa66:be57 with SMTP id
 ffacd0b85a97d-46dc12df7bbmr12633280f8f.30.1782495892559; Fri, 26 Jun 2026
 10:44:52 -0700 (PDT)
MIME-Version: 1.0
References: <20260623205839.1294-1-linisha232@gmail.com>
 <20260625192121.1887-1-linisha232@gmail.com>
 <aj5P0n03aKv93uci@redhat.com>
 <9d695c7f-bb02-44bd-8e1c-f8bdbf3bbbf7@oss.qualcomm.com>
In-Reply-To: <9d695c7f-bb02-44bd-8e1c-f8bdbf3bbbf7@oss.qualcomm.com>
From: linisha <linisha232@gmail.com>
Date: Fri, 26 Jun 2026 23:14:39 +0530
X-Gm-Features: AVVi8Cdab3HGuyK5Vm_7hOUxQfZsTuFvw7K2R843YGTZyp9D_zEeLiQBM9cPjCM
Message-ID: <CAGKMO+VCZ_3cPWx000N_+REsEK+gQg8RCWJcx7YEchUcy20V-Q@mail.gmail.com>
Subject: Re: [PATCH v2] docs/system: add general note about architecture and
 machine differences
To: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Cc: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 qemu-devel@nongnu.org, alex.bennee@linaro.org, peter.maydell@linaro.org, 
 pbonzini@redhat.com, mjt@tls.msk.ru, philmd@mailo.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::436;
 envelope-from=linisha232@gmail.com; helo=mail-wr1-x436.google.com
X-Spam_score_int: -7
X-Spam_score: -0.8
X-Spam_bar: /
X-Spam_report: (-0.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FORGED_GMAIL_RCVD=1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

Hi Daniel, Pierrick,

Thank you, Daniel, for the Reviewed-by tag and the wrapping feedback.

Pierrick =E2=80=94 I didn't intentionally remove anyone. I used
scripts/get_maintainer.pl -f docs/ which returned Peter Maydell,
Philippe Mathieu-Daud=C3=A9, Richard Henderson, Alex Benn=C3=A9e, and C=C3=
=A9dric Le
Goater, and I picked CCs from that list along with people who
responded to v1. You weren't in the script's output, so I didn't know
to include you. Apologies for the miss =E2=80=94 I'll CC you on any future =
v3.

Daniel =E2=80=94 I'll send a v3 with the commit message body properly
line-wrapped to 76 characters. Let me know if there are other changes
you'd like at the same time.

Best regards, Linisha

On Fri, Jun 26, 2026 at 9:09=E2=80=AFPM Pierrick Bouvier
<pierrick.bouvier@oss.qualcomm.com> wrote:
>
> On 6/26/2026 3:09 AM, Daniel P. Berrang=C3=A9 wrote:
> > CC Pierrick as docs maintainer.
> >
>
> Thanks Daniel.
>
> I wonder how I was not in original recipients for this patch.
> @Linisha: did you explicitly set list of recipients, or remove some peopl=
e?
>
> > On Fri, Jun 26, 2026 at 12:51:19AM +0530, Linisha wrote:
> >> Add a note near the start of the introduction explaining that QEMU opt=
ions, properties, and command lines may differ between target architectures=
 and machine types. This helps prevent confusion when examples shown for on=
e architecture do not work for another, such as the pflash0/pflash1 options=
 visible in -machine help on some machines but not others.
> >
> > Please ensure commit messages are line wrapped.
> >
> >>
> >> Suggested-by: Peter Maydell <peter.maydell@linaro.org>
> >>
> >> Buglink: https://gitlab.com/qemu-project/qemu/-/issues/3254
> >> Signed-off-by: Linisha <linisha232@gmail.com>
> >> ---
> >>
> >> v2: Take a different approach based on review feedback from Daniel
> >>     Berrang=C3=A9 and Peter Maydell. Instead of incorrectly claiming
> >>     pflash0/pflash1 are virt-only (they actually work on x86 pc/q35
> >>     machines too), add a general note near the start of the introducti=
on
> >>     about how options, properties, and command lines may differ betwee=
n
> >>     target architectures and machine types.
> >>
> >>
> >>  docs/system/introduction.rst | 9 +++++++++
> >>  1 file changed, 9 insertions(+)
> >>
> >> diff --git a/docs/system/introduction.rst b/docs/system/introduction.r=
st
> >> index bec7291e47..8d9ef61d26 100644
> >> --- a/docs/system/introduction.rst
> >> +++ b/docs/system/introduction.rst
> >> @@ -1,6 +1,15 @@
> >>  Introduction
> >>  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >>
> >> +.. note::
> >> +   QEMU supports many different target CPU architectures and many
> >> +   different machine types for each architecture. Options, properties=
,
> >> +   and command lines that work for one architecture or machine type
> >> +   will not necessarily work on another. The examples shown in this
> >> +   manual are specific to the architecture and machine type being
> >> +   demonstrated. When in doubt, consult the documentation for your
> >> +   specific target architecture and machine type.
> >> +
> >
> > Not convinced many people will read this, but I gues it doesn't
> > hurt.
> >
> > Reviewed-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
> >
> >
> >>  .. _Accelerators:
> >>
> >>  Virtualisation Accelerators
> >> --
> >> 2.47.0.windows.1
> >>
> >
> > With regards,
> > Daniel
>

