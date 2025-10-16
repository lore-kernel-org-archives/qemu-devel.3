Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75C18CCD194
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Oct 2025 12:38:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v9NES-0000QM-Ii; Thu, 16 Oct 2025 08:37:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <salil.mehta@opnsrc.net>)
 id 1v9NEK-0000K4-At
 for qemu-devel@nongnu.org; Thu, 16 Oct 2025 08:37:16 -0400
Received: from mail-oo1-xc31.google.com ([2607:f8b0:4864:20::c31])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <salil.mehta@opnsrc.net>)
 id 1v9NEE-0002Sc-1T
 for qemu-devel@nongnu.org; Thu, 16 Oct 2025 08:37:15 -0400
Received: by mail-oo1-xc31.google.com with SMTP id
 006d021491bc7-6505128db16so172974eaf.0
 for <qemu-devel@nongnu.org>; Thu, 16 Oct 2025 05:37:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=opnsrc.net; s=google; t=1760618220; x=1761223020; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Y+J/F1sCBg4WgwkKB2trb15KWQwj20xEXkrq4paSYiU=;
 b=G9raLvWYbbIr3iYyOBFBJiHChgSlWM9xDKbUNs6QgM7hExf1nfCQq7HQpOcbWn7wTv
 FQraYqPDJNaVnDqPu3vgSGLqDTM5+Wom+TZ7Mk+OC8w1oo0LWf4zWULplgKDtGSKiqcU
 KngohHW8xX9QTYDt7JpieZjqOsamLYlRZWn8FxPPYSAPTXc79DZdF82fzW6zGelEslul
 4OkMxx04sMTVssefHf75lHghjzNQzOuspvsict2yNRoKIbBbOZUctohCkfHtqgaeJxPz
 1g7OA9SrKufpMEG18d1N4gmf+Rl5CQsqcnex4uJT2KcnmxoQYLEi4yOVBbXVWU16ox6f
 phYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760618220; x=1761223020;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Y+J/F1sCBg4WgwkKB2trb15KWQwj20xEXkrq4paSYiU=;
 b=pjUyftysaI7HFKWyv22uAQmgZCDE/69Aa8TbcMmWoJ9ZPqlH5JCD2txCaeW2gfw3zc
 J29lKAF9vmY/qIuOAPG+ff2qIcm2NjKtYLoRWBiUW345O4PUJkdiBnHe8JHYvT9+xXQk
 XJpUhd0WY735ffKZPkP1T/YWLZF8cFZNvBixvSR1D8Nq2djQ53zfPbjutl/NhVKPla8x
 2U1wayTh9n59/0j1wGsbQO6B4IOzfLoI7ig1pAsnPLp0bkIa+bwhWC3HYS8bQoSgYeUC
 ctAJMPFZi4VsLlOUcSPzlLGWTqb3NEweD9oPqOgXd8rPtf6sTfZPJQdgegJueTKNEBBc
 i41A==
X-Forwarded-Encrypted: i=1;
 AJvYcCWA3JZEY8XMADCExC6iJtJv5P/NHxqgDHT7xNhkZkOra/DeZAqI6JBmq9lHBx8eI/J93bs38P2Wiejb@nongnu.org
X-Gm-Message-State: AOJu0Yx9wlG/G4hdSBVYlLQ2xGFm5yaL6yJefQnS9rTfFUVcEPpZbhMb
 NT9FWdUldoOgoAs05mGRsnVH0EK3gNlF7TRUxWFsoMxeJTH4Ra/U6szO5Y2h+uPtx0s028bJ47E
 oj2KziH2S982CDJp7ndnVzGIqbN+CGytZvfQPoa2oYw==
X-Gm-Gg: ASbGnctyEbv8eTtgtasPDVJchQcp1s/QW6eYyy4PTa+YHd9QGBysd9OyXxE+YOHBG4s
 uPwBZHze8+s8avd3NTohm5ozFPUsd+Uil9Dd5xP2ofXdv7bxenicoA+rcWWx113PiKfS9kVw7ri
 qiOcseTgTaZzk6ylOUfapyWWkfrbDipb3m+Ksa+7GdyCUfeKXmdE+pLwx1TkiE5bs4qFdlP/Hoc
 RllX9axNlcSv1GjuFMDeLHKUS9SXAOgPtLl2kJcP8xuTKjG/8y2K/PxSw2Tb8lnASMDK6E/ckXa
 7nrhNEKpMvj192Z1a7kGCsBoeZ3QLZKbqm58NQnRwA==
X-Google-Smtp-Source: AGHT+IHS/1yfutO8IZJYdhrBOL8heEcPXQRbaDxdCNmeSIj+AkTk5YZ4LyrT6ZSMzbmbxa3U3NGd++0mGszeLl3jGf8=
X-Received: by 2002:a05:6870:818e:b0:3c9:8689:35da with SMTP id
 586e51a60fabf-3c986893830mr289987fac.25.1760618220527; Thu, 16 Oct 2025
 05:37:00 -0700 (PDT)
MIME-Version: 1.0
References: <20251014102439.319915-1-peter.maydell@linaro.org>
 <4b686af261024bad91bf079a098976de@huawei.com>
 <CAFEAcA-CdCSD36azVc=7EVKn2jgXggOa8Rt-Gvnqnyebwbx6eg@mail.gmail.com>
In-Reply-To: <CAFEAcA-CdCSD36azVc=7EVKn2jgXggOa8Rt-Gvnqnyebwbx6eg@mail.gmail.com>
From: Salil Mehta <salil.mehta@opnsrc.net>
Date: Thu, 16 Oct 2025 12:36:48 +0000
X-Gm-Features: AS18NWDX_SDOAbexP8zCHhNxM5YobpavyeanbngiOHPEhZUxIUW3kkHIuf4cDao
Message-ID: <CAJ7pxeb8xS-xG2ocQL5ORDEhhSs7swEJYFTstnxFyo7H8LOD7A@mail.gmail.com>
Subject: Re: [PATCH] hw/intc/arm_gicv3_kvm: Avoid reading ICC_CTLR_EL1 from
 kernel in cpuif reset
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Salil Mehta <salil.mehta@huawei.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, 
 Marc Zyngier <maz@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::c31;
 envelope-from=salil.mehta@opnsrc.net; helo=mail-oo1-xc31.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

On Thu, Oct 16, 2025 at 12:23=E2=80=AFPM Peter Maydell <peter.maydell@linar=
o.org> wrote:
>
> On Thu, 16 Oct 2025 at 13:17, Salil Mehta <salil.mehta@huawei.com> wrote:
> >
> > Hi Peter,
> >
> > > From: qemu-devel-bounces+salil.mehta=3Dhuawei.com@nongnu.org <qemu-
> > > devel-bounces+salil.mehta=3Dhuawei.com@nongnu.org> On Behalf Of Peter
> > > Maydell
> > > Sent: Tuesday, October 14, 2025 11:25 AM
> > > To: qemu-devel@nongnu.org
> > > Cc: Salil Mehta <salil.mehta@opnsrc.net>; Marc Zyngier <maz@kernel.or=
g>
> > > Subject: [PATCH] hw/intc/arm_gicv3_kvm: Avoid reading ICC_CTLR_EL1 fr=
om
> > > kernel in cpuif reset
> > >
> > > Currently in arm_gicv3_icc_reset() we read the kernel's value of
> > > ICC_CTLR_EL1 as part of resetting the CPU interface.  This mostly wor=
ks, but
> > > we're actually breaking an assumption the kernel makes that userspace=
 only
> > > accesses the in-kernel GIC data when the VM is totally paused, which =
may
> > > not be the case if a single vCPU is being reset.  The effect is that =
it's possible
> > > that the read attempt returns EBUSY.
> > >
> > > Avoid this by reading the kernel's value of the reset ICC_CTLR_EL1 on=
ce in
> > > device realize. This brings ICC_CTLR_EL1 into line with the other cpu=
if
> > > registers, where we assume we know what the kernel is resetting them =
to
> > > and just update QEMU's data structures in arm_gicv3_icc_reset().
> > >
> > > Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> > > ---
> > > I've only tested this fairly lightly, but it seems to work.
> > > Salil, does this fix the EBUSY issues you were seeing ?
> >
> >
> > Would you be absorbing this in your tree now or should I make it part
> > of the RFC V7 ?
> >
> > Reviewed-by: Salil Mehta <salil.mehta@huawei.com>
> > Tested-by: Salil Mehta <salil.mehta@huawei.com>
>
> Thanks for the testing. I'll pull it into target-arm.next since
> it does fix a potential issue with the current codebase.


Thanks. I hope you've noticed my earlier reply. There is a potential
*future* breakdown condition with this patch.

https://lore.kernel.org/qemu-devel/e2b03da8f7514b57aef7d236be1dcb90@huawei.=
com/

I assume you've accepted that as a no-risk?


Best regards
Salil.


>
> -- PMM

