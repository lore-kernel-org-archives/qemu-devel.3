Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E617C83F22
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Aug 2024 13:37:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sjfKY-0002Jz-DZ; Thu, 29 Aug 2024 09:36:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chigot@adacore.com>)
 id 1sjfKU-0002Bv-IT
 for qemu-devel@nongnu.org; Thu, 29 Aug 2024 09:36:50 -0400
Received: from mail-qk1-x72b.google.com ([2607:f8b0:4864:20::72b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <chigot@adacore.com>)
 id 1sjfKS-0005yU-Dr
 for qemu-devel@nongnu.org; Thu, 29 Aug 2024 09:36:50 -0400
Received: by mail-qk1-x72b.google.com with SMTP id
 af79cd13be357-7a7ff6c4fd0so41796085a.1
 for <qemu-devel@nongnu.org>; Thu, 29 Aug 2024 06:36:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=adacore.com; s=google; t=1724938607; x=1725543407; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HsizXNqDD8qnmQZG2I43zdIYqv66eVGNpf0Lo0aMnRI=;
 b=C/WEW/l8xRtyG4g4phEFLv/5+M3+oGHMuo3l0pbn6owaI66AICz0qEDcp5Rc0dXYiz
 /79SCSNWdv71E2tuywJ3XmGXFGgdnEIGXOYhrsVLwMRfOZtk7AzMDiQJ08jKEuMLBpQB
 uXrfy310mombDd/UfUe00SSDcttOhHYdQCtWT3bSNrLhvd4DqzZZArDxdXX+5TM0Sqy4
 I2pRpnRKo5ILWiLWST1r2by6Wh9j8iHtlhcHQzkyJ/LQQ25OFgjgxMWLRdQRKZX42+DC
 gE2VEDCViFb6Pl04LxrZ3LnsOEroqxoa9avgMziNbfpIIYAMBOrkkQexSLGEy68PKF6x
 MT/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724938607; x=1725543407;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=HsizXNqDD8qnmQZG2I43zdIYqv66eVGNpf0Lo0aMnRI=;
 b=nCR9YoZ8QbYX1Nq1D8j9IHWc38NfghhwIkK7ZhU2Y+s0DrPb9IZA3MPBYFNeBUSRlC
 I3Wgq8fe2Bk1Z5zW6nm3KFBuxsAkUk2EHSkbaDA5+rX3pcBQDfl89VRP1ew35Fk3nEOL
 pvgaJuXs0LQh5oSEATSliAHu/bmEWXYqYZ7wsLk12sl2uGCmv+wIiHvLKZuyhw2XH5MO
 cH34NPBhJk246Gm9O/AdCLLaev2fG34+cRuHu7HgmMFCCuuo/T3iP939UI3MmwAlXaNA
 QATpHsW17JfpnzQGGYZFNGhycFJMx5vo+pO5nB06A9CKjiEzu6TcCkjmExWNt0VXUKGV
 NTlg==
X-Gm-Message-State: AOJu0YzCkH73a/Keb4/oYLIscmFMT+wTm2TKMPKyanWJTvM+P2HKTr6V
 uYJOeDRQlbHCME6HWlscPTV5V3m3TuRjTR2rJ/Kk7H7PExGRALMWXnZspFVPqLtUxRE+tggwew7
 +VkLcW/8mww8MaU/61bK4XGwsaloSSBr7deSvV4GvMqBeLGa+HA==
X-Google-Smtp-Source: AGHT+IGVFT8AB1vL7n5VsdK/YLHUjq1tAQbjy6r6WnsjUhkSg8slmlIdw2+jo6pJEhDsxYEkGW02lTgpuPm092H8oy8=
X-Received: by 2002:a05:6a00:2ea8:b0:70d:350c:757e with SMTP id
 d2e1a72fcca58-715dfb2db37mr3647845b3a.10.1724938595838; Thu, 29 Aug 2024
 06:36:35 -0700 (PDT)
MIME-Version: 1.0
References: <20240715084639.983127-1-chigot@adacore.com>
 <42fe0e65-e1c1-47be-9ba1-9a43e4a05192@kaod.org>
 <CAJ307Eg_w1K63Q7YmsAw6mSnwgPrC9R2UOvi+fUDjam4n0mvDg@mail.gmail.com>
 <a0665964-ba34-4144-82fd-184f864d844c@kaod.org>
In-Reply-To: <a0665964-ba34-4144-82fd-184f864d844c@kaod.org>
From: =?UTF-8?Q?Cl=C3=A9ment_Chigot?= <chigot@adacore.com>
Date: Thu, 29 Aug 2024 15:36:24 +0200
Message-ID: <CAJ307Ei9fbWmhpDcqy1eukC4WSAhTgHLt+AKOb9V24j2kG9RbA@mail.gmail.com>
Subject: Re: [PATCH] hw/ppc: fix decrementer with BookE timers
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
Cc: qemu-devel@nongnu.org, npiggin@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::72b;
 envelope-from=chigot@adacore.com; helo=mail-qk1-x72b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Thu, Aug 29, 2024 at 2:33=E2=80=AFPM C=C3=A9dric Le Goater <clg@kaod.org=
> wrote:
>
> On 8/28/24 09:21, Cl=C3=A9ment Chigot wrote:
> > On Tue, Aug 27, 2024 at 7:40=E2=80=AFPM C=C3=A9dric Le Goater <clg@kaod=
.org> wrote:
> >>
> >> Hello Cl=C3=A9ment,
> >>
> >> On 7/15/24 10:46, Cl=C3=A9ment Chigot wrote:
> >>> The BookE decrementer stops at 0, meaning that it won't decremented
> >>> towards "negative" values.
> >>> However, the current logic is inverted: decr is updated solely when
> >>> the resulting value would be negative.
> >>
> >> How did you hit the issue ? which machine ? I didn't see any error
> >> when booting Linux 6.6.3 on mpc8544ds, e500mc, e5500 and e6500.
> >
> > I hit this issue while running some version of VxWorks on a custom
> > machine: p3041ds (description [1] and our local implementation [2]).
> > So, I'm not that surprised you were not able to reproduce.
> >
> >>> Signed-off-by: Cl=C3=A9ment Chigot <chigot@adacore.com>
> >>> Fixed: 8e0a5ac87800 ("hw/ppc: Avoid decrementer rounding errors")
> >>
> >> LGTM,
> >>
> >> Reviewed-by: C=C3=A9dric Le Goater <clg@redhat.com>
> >>
> >> We have some automated tests with the ppce500 machine which it would b=
e
> >> interesting  to extend to have a better coverage of booke.
> >
> > Thanks for the pointer, I'll see if I can extend them.
> >
> >> Thanks,
> >>
> >> C.
> >>
> >
> > [1] https://www.nxp.com/design/design-center/software/qoriq-developer-r=
esources/p3041-qoriq-development-system:P3041DS
> > [2] https://github.com/AdaCore/qemu/blob/qemu-stable-9.0.0/hw/ppc/p3041=
ds.c
>
> Nice. Do you have any plans to upstream the machine ?

That was the plan. However, we are using that emulation in order to
test VxWorks on PPC.  Recent versions have now officially provided a
BSP for QEmu using ppce500 board. We are planning to transition to it,
mainly to avoid having to maintain that P3041DS home-made
implementation. Thus, I'm not sure we'll spend time on upstreaming it
:(
That being said, if you heard people being interested in that board,
please do warn me.

Thanks,
Cl=C3=A9ment

> Thanks,
>
> C.
>

