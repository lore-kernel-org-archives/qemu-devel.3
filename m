Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E84FEE499D
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Sep 2024 12:27:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1soMKY-0006lI-Uc; Wed, 11 Sep 2024 08:20:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1soMKX-0006b2-7C
 for qemu-devel@nongnu.org; Wed, 11 Sep 2024 08:20:17 -0400
Received: from mail-wr1-x42f.google.com ([2a00:1450:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1soMKV-0007xJ-Ck
 for qemu-devel@nongnu.org; Wed, 11 Sep 2024 08:20:16 -0400
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-374c4d4f219so1133795f8f.1
 for <qemu-devel@nongnu.org>; Wed, 11 Sep 2024 05:20:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1726057214; x=1726662014; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=titgfk+Bz5dLoawseTkpqwiImX9LHrftar/isSFcAD0=;
 b=leubrYkPQcUhVyUsU/jODCpE6o2/EQpqwfTyWLikiIwQPHewCs0nRsFcNPpx6M9g1z
 YPd+lth6SWPZERWuQ5puV9zc7lDnFdWmOZF4og53ARDYTYmmVpZSr2w9s9XNGEJWv7Qv
 dn6DOCV1q67hUz1IM/5tFsSjAbPQXukYdocW91v++TxkNy7JO+NdwoCJQY2ouawyn2st
 mlP3rICbhUo99JL0FaSS6mg8ze3m+soZwrqb+Z7ftBu+XjeOXfs4iODkUeIv9tzFYMQv
 4trPOuPlO/miaQyQ0J05PY/TTzfxRNdiiT79/LGDiKTuj+cHpeyC9mbVBbamj0LUc2fx
 6+/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726057214; x=1726662014;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=titgfk+Bz5dLoawseTkpqwiImX9LHrftar/isSFcAD0=;
 b=Tx6t/L+tVGhQS8K8aLpkI9SPFBGCZBDUpKnU0B1eh4BqtYqyiSVttqkOGCMT7ZsA/y
 KjbsGh1uW7zMksm0hk4qPNVXKtqr2TY5QK2jQZfGn2O6gjCiNl/7rSQRe550Y54lWT5Y
 jb2qbwWqJ+IiSsj+ylGZl7zgD3Ulu11Zk5rcc3Ta+oOeymZauIwm6vQX2U3U704aetVf
 LyHdAaASe8nCLHDZc8cJReKkAdZ/m4brsWVykHQP7QC+I5ezHWm9qvo0/GUwptXvpR0C
 VSc6ewkcM7k8mzVi1Dfo991NjaluQ+tvfCpoKfnrhrOW+1DeSvhz+ipuWfonguzPF/6x
 FoiQ==
X-Gm-Message-State: AOJu0YxFpm4gUkpDhImrFNA/1ovfDtUBw4tglQm1jyLaQkZDo0MoRlKy
 2M5K2+2ZqaRcbj6RCudOc0LTOt3e84dMDZkNE/xD/1lly7HWFS3xrRvLA/7iL1EWcCAX3ZvBGgh
 bIJXMBa5QqzVbfileUh8Gj6/YyOE+/myK++sBdw==
X-Google-Smtp-Source: AGHT+IEZdTOhk+I/l754eUl7J21ppa4WZmpAyC7wEay2FjzV4l6GgbZfhLKTDEboSrTc8N8bETXd67Sro9rY91Dclb8=
X-Received: by 2002:adf:f14f:0:b0:374:ca4f:bd78 with SMTP id
 ffacd0b85a97d-378b07965f2mr1891238f8f.10.1726057213662; Wed, 11 Sep 2024
 05:20:13 -0700 (PDT)
MIME-Version: 1.0
References: <20240902123038.1135412-1-jan.kloetzke@kernkonzept.com>
 <CAFEAcA-tK24wCPKZwig1iDPSOiHKqZMU4WH99ZZEG-awveEvag@mail.gmail.com>
 <f53a98c763f55f56e189fcf7822d203872870eee.camel@kernkonzept.com>
In-Reply-To: <f53a98c763f55f56e189fcf7822d203872870eee.camel@kernkonzept.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 11 Sep 2024 13:20:02 +0100
Message-ID: <CAFEAcA9yLJg7smf-e52wRohHYVz00yzHz_6pM9qzSjhw41tj-Q@mail.gmail.com>
Subject: Re: [PATCH] hw/intc/arm_gic: fix spurious level triggered interrupts
To: =?UTF-8?B?SmFuIEtsw7Z0emtl?= <jan.kloetzke@kernkonzept.com>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::42f;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x42f.google.com
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

On Wed, 11 Sept 2024 at 11:54, Jan Kl=C3=B6tzke <jan.kloetzke@kernkonzept.c=
om> wrote:
>
> On Fri, 2024-09-06 at 13:50 +0100, Peter Maydell wrote:
> > On Mon, 2 Sept 2024 at 13:32, Jan Kl=C3=B6tzke <jan.kloetzke@kernkonzep=
t.com> wrote:
> > >
> > > Level triggered interrupts are pending when either the interrupt line
> > > is asserted or the interrupt was made pending by a GICD_ISPENDRn writ=
e.
> > > Making a level triggered interrupt pending by software persists until
> > > either the interrupt is acknowledged or cleared by writing
> > > GICD_ICPENDRn. As long as the interrupt line is asserted, the interru=
pt
> > > is pending in any case.
> > >
> > > This logic is transparently implemented in gic_test_pending(). The
> > > function combines the "pending" irq_state flag (used for edge trigger=
ed
> > > interrupts and software requests) and the line status (tracked in the
> > > "level" field). Now, writing GICD_ISENABLERn incorrectly set the
> > > pending flag if the line of a level triggered interrupt was asserted.
> > > This keeps the interrupt pending even if the line is de-asserted afte=
r
> > > some time.
> > >
> > > Fix this by simply removing the code. The pending status is fully
> > > handled by gic_test_pending() and does not need any special treatment
> > > when enabling the level interrupt.
> > >
> > > Signed-off-by: Jan Kl=C3=B6tzke <jan.kloetzke@kernkonzept.com>
> >
> > Thanks for this patch. I agree that this is wrong for the
> > GICv2 -- I think this is a bit we missed in commit 8d999995e45c
> > back in 2013 where we fixed most other places that were not
> > correctly making this distinction of "pending because of
> > ISPENDR write" and "pending because level triggered and
> > line is held high".
> >
> > However I think for consistency with that commit, we should
> > retain the current behaviour here for the s->revision =3D=3D REV_11MPCO=
RE
> > case. (This is basically saying "we don't really know exactly
> > how the 11MPCore GIC behaved and we don't much care to try to
> > find out, so leave it alone", which is the stance we were
> > already taking in 2013...) In particular, notice that
> > gic_test_pending() only does the "pending if level triggered
> > and held high" logic for the not-REV_11MPCORE case.
>
> Right. Thanks for catching this. I'll send a V2 shortly.
>
> Actually, I tried to make sense out of the ARM11 MPCore TRM but gave
> up. At least, I could not come with a consistent idea how the hardware
> is supposed to behave. Keeping the old behavior really looks like the
> most sensible option here.

Yeah. To be honest, I wouldn't be surprised if actually the
11mpcore and the GICv2 behave the same and the behaviour
we have under REV_11MPCORE is just "what the person who
implemented the QEMU model guessed at based on the rather
nonspecific 11mpcore TRM documentation". But at this late date
there's really no benefit in trying to find out :-)

thanks
-- PMM

