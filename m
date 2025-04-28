Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1EBAC369D1
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Apr 2025 03:18:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u9F0e-0003IK-Qe; Sun, 27 Apr 2025 23:18:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhangckid@gmail.com>)
 id 1u9F0H-0003Gs-7x
 for qemu-devel@nongnu.org; Sun, 27 Apr 2025 23:17:59 -0400
Received: from mail-ej1-x62b.google.com ([2a00:1450:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <zhangckid@gmail.com>)
 id 1u9F0E-0005j0-Tw
 for qemu-devel@nongnu.org; Sun, 27 Apr 2025 23:17:56 -0400
Received: by mail-ej1-x62b.google.com with SMTP id
 a640c23a62f3a-ac289147833so753396266b.2
 for <qemu-devel@nongnu.org>; Sun, 27 Apr 2025 20:17:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1745810272; x=1746415072; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dAuCze/EqI6H7SrQ8G87JgWqTWY1CwrbSIbdOEVNJxk=;
 b=TQ32rrZRILx60/SXEbbpofB9rh6IHOixT6z9cINXyj+2sOcMnZJqfLqFzhbXTuSTNl
 pudJ7sxIhAFwJe1J6Z0NmHL0MgO1lauQQbHjDyoZx5HNhZY9GNCrF5YX5/ZQW7Roc6qc
 EkGOw1KeuLuwQAsxznInPy0xX/rhL3obxXZyRZ4EJesNOVHSApt2qw6q6hY+/ib0l5oy
 zrwdaZtExPJxXVjGsLnh1uFidLGvmAxOtv/MtTrOFdOb3c+Hqq0OMZexVdVj7AjtTGL/
 UVXHE5ipWGfYrrSvtdHhOUsg0CQs8qXDuFY43rBiICeAYT+yA/XMUmULO072E0ilk36Q
 LwCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745810272; x=1746415072;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=dAuCze/EqI6H7SrQ8G87JgWqTWY1CwrbSIbdOEVNJxk=;
 b=Ck5B4hTWprR/TetoAvUFf4DFOR+5BBH+E7UPHt3VDu5c/c5W49/4Ck/Xr8Y3O69VoN
 iq4B+4X1TJv/lcB0T2vyLZhbqyv6ZAZtVthbpdmwkzKT7H7MGNwqpBFhgSciGDa2pFPt
 JUmAm+s3nZRjtjgC5RG5Z3PaG6PGOlgZfpO26XJOjq2GPb3gSk7EQmAUt1rPxOcJpRst
 d9YgAyCrcRdkercSy8dIm7Lk149lBkBzQhTI0PeAf3fmilLJlk8XIxu3bKwfrM+NFZN8
 JrU6hWB83YFcpYcACKFgx3AWigu56WcROCfr0gTyKbut960PFmh9bSzGc2DQmuvwTUdG
 12Ew==
X-Forwarded-Encrypted: i=1;
 AJvYcCWTjXImKAUcUDrcJaWtX2/Wydkn+UjlvqfwsM8lQUMsfMIdp8qgWU/90Av+2zVZRC5S2LQrW1g0O+zP@nongnu.org
X-Gm-Message-State: AOJu0YzkAD7+dIprC76MkvGB/a0iCmF/rcUyOtWV1gX6/+7OliFjgoDg
 FLhvNNq6zgEJyi2pDS1siP+1otQ0il9qunolxZf/Gu3ugPbAuNWs2VXMnBraIH7qZBRenXEdlh5
 1HCoHnv+p+N0Sfizx1Fwz2faA708=
X-Gm-Gg: ASbGncsJ454YSzE8tzwx6kuZcyJpCEiBHwFCsutzxrWjNvmWPd0ft45nF3DtLHcHCV4
 d4x9SESKTeVOw1SjJEDoHubRHMBCiqhzRtMVXAfm4vCjXODliEvng2F9lPmvNDJlACyXw6DuqlN
 iUjpFaGDP5JERbN8p8ZcYr/79fDx/5j/FyVQ==
X-Google-Smtp-Source: AGHT+IG+VVos+L8id9GusLsisPP+ktqjmh+FTOzfMpdF0rhGEOEZHV34OdlH487qMc0cpmRSTDjqGJxE1R3yjPXkHKk=
X-Received: by 2002:a17:907:97c7:b0:ace:4ed4:d428 with SMTP id
 a640c23a62f3a-ace84b3b270mr712419366b.57.1745810271549; Sun, 27 Apr 2025
 20:17:51 -0700 (PDT)
MIME-Version: 1.0
References: <20250402135402.14526-1-zhangckid@gmail.com>
 <d39ed054-d99b-46a8-afc8-1a2981d919e1@linaro.org>
 <CAK3tnvLqGLzQffAi=dk_VzXgH_k_r_z2xNTN3tVE-G+xjpPWcw@mail.gmail.com>
 <CAK3tnvJMOe+rtjnwbfQ8nuZyQAtGMPKjgXBVo2RpkmKNtzAXpQ@mail.gmail.com>
 <5d285d42-f91f-4e3d-9cda-ba9058236f95@linaro.org>
In-Reply-To: <5d285d42-f91f-4e3d-9cda-ba9058236f95@linaro.org>
From: Zhang Chen <zhangckid@gmail.com>
Date: Mon, 28 Apr 2025 11:17:14 +0800
X-Gm-Features: ATxdqUEP8vSPpu-5yqjf6ZPvsVKqvQT4DmKhSIx7rQ1Iw-ggna5wmRWUKQpYHy4
Message-ID: <CAK3tnv+wA5Qy=2mT3jTU0iiuzeEQdbMvzSzACns5=bbooXDNcA@mail.gmail.com>
Subject: Re: [PATCH] hw/arm/virt.c: Fix wrong default cpu type in AARCH64
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org, 
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Andrew Jones <ajones@ventanamicro.com>, Alexander Graf <agraf@csgraf.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::62b;
 envelope-from=zhangckid@gmail.com; helo=mail-ej1-x62b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Thu, Apr 24, 2025 at 5:58=E2=80=AFPM Philippe Mathieu-Daud=C3=A9
<philmd@linaro.org> wrote:
>
> On 24/4/25 10:56, Zhang Chen wrote:
> > On Thu, Apr 3, 2025 at 10:23=E2=80=AFAM Zhang Chen <zhangckid@gmail.com=
> wrote:
> >>
> >> On Thu, Apr 3, 2025 at 2:43=E2=80=AFAM Richard Henderson
> >> <richard.henderson@linaro.org> wrote:
> >>>
> >>> On 4/2/25 06:54, Zhang Chen wrote:
> >>>> Because of the CONFIG_TCG auto enabled, the cpu type "cortex-a15"
> >>>> is mistakenly set to the default AARCH64 target.
> >>>
> >>> This is the correct backward compatible setting.
> >>> In essence, it means that you *must* supply a -cpu argument.
> >>>
> >>>
> >>
> >> If the "-cpu" is required, the VM should not be started without this a=
rgument.
> >> If yes, I will skip this patch and submit another one to make QEMU
> >> refuse to start without this parameter.
> >>
> >
> > Ping... and let me explain this status, it is not just for the default =
value.
> > 1. The cpu type "cortex-a15" is not the correct backward compatible
> > setting for AARCH64 target.
>
> IIUC it was meant to be backward compatible for KVM (as in "not TCG"),
> HVF was not a thing for ARM at this time.
>
> > The ARM cortex-a15 is a 32 bit CPU based on ARMv7-A architecture. It
> > can not boot for AARCH64 target.
> > For example, the Apple M silicon can not boot with the default -cpu val=
ue.
>
> A respin of this series might help you, I'll try to remember to Cc you:
> https://lore.kernel.org/qemu-devel/b883f0ef-6131-4335-b273-90fd3d8cc5e4@l=
inaro.org/
>

Thanks Philippe, your patch fix the same issue and looks good for me.
Let's drop this patch.

Thanks
Chen



> > 2. Most of QEMU docs does not said user *must* supply a -cpu argument.
> > https://www.qemu.org/docs/master/system/qemu-manpage.html
> >
> > Thanks
> > Chen
> >
> >> Thanks
> >> Chen
> >>
> >>> r~
> >>>
> >>>>
> >>>> Signed-off-by: Zhang Chen <zhangckid@gmail.com>
> >>>> ---
> >>>>    hw/arm/virt.c | 5 +++--
> >>>>    1 file changed, 3 insertions(+), 2 deletions(-)
> >>>>
> >>>> diff --git a/hw/arm/virt.c b/hw/arm/virt.c
> >>>> index a96452f17a..63649e9543 100644
> >>>> --- a/hw/arm/virt.c
> >>>> +++ b/hw/arm/virt.c
> >>>> @@ -3178,9 +3178,10 @@ static void virt_machine_class_init(ObjectCla=
ss *oc, void *data)
> >>>>        mc->cpu_index_to_instance_props =3D virt_cpu_index_to_props;
> >>>>    #ifdef CONFIG_TCG
> >>>>        mc->default_cpu_type =3D ARM_CPU_TYPE_NAME("cortex-a15");
> >>>> -#else
> >>>> +#ifdef TARGET_AARCH64
> >>>>        mc->default_cpu_type =3D ARM_CPU_TYPE_NAME("max");
> >>>> -#endif
> >>>> +#endif /* TARGET_AARCH64 */
> >>>> +#endif /* CONFIG_TCG */
> >>>>        mc->valid_cpu_types =3D valid_cpu_types;
> >>>>        mc->get_default_cpu_node_id =3D virt_get_default_cpu_node_id;
> >>>>        mc->kvm_type =3D virt_kvm_type;
> >>>
> >>>
> >
>

