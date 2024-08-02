Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06A4DC3DA4A
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Aug 2024 07:27:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sZmh9-0005vV-8D; Fri, 02 Aug 2024 03:27:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philipp.reisner@linbit.com>)
 id 1sZmh0-0005OK-70
 for qemu-devel@nongnu.org; Fri, 02 Aug 2024 03:27:15 -0400
Received: from mail-yb1-xb36.google.com ([2607:f8b0:4864:20::b36])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philipp.reisner@linbit.com>)
 id 1sZmgx-00045P-3C
 for qemu-devel@nongnu.org; Fri, 02 Aug 2024 03:27:13 -0400
Received: by mail-yb1-xb36.google.com with SMTP id
 3f1490d57ef6-e0b9d344d66so4090651276.1
 for <qemu-devel@nongnu.org>; Fri, 02 Aug 2024 00:27:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linbit-com.20230601.gappssmtp.com; s=20230601; t=1722583629; x=1723188429;
 darn=nongnu.org; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wJeAb483QjH0H/n1WfZzt8Epen45/tNiw/JGSP1mOp8=;
 b=AWsBAO3wTSD7LTtLd8R8fnLL60hS2qh0OHCY6X36gHuQw0tanK2l808SKFvwARQ0fD
 HFvPvyn0I7jdIbGLdyjRhR2T3XgYrvHKTtTR6azenseXGmwhJylb/0GUmH36QtOGntL5
 8vByK2u/GzhQD47hu0SwkCeLWy63CQdXrMhgDPqBqmM8fKOydEniU9XIIigUp0gPDPTp
 ROtjrb7F6lDbGovUq3zBOrB7ONeSWeMy8kEJSJdTPh/wsdnHjzhzrR/xe5SUWIK4PIg2
 BHIGDvYwXy9hQ1xLBlEfSRVF3xDPWQTEuP1Nbr/lQqfb10/IihbagYrU4w2VkPXKR6Wd
 tRVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722583629; x=1723188429;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=wJeAb483QjH0H/n1WfZzt8Epen45/tNiw/JGSP1mOp8=;
 b=pVTbdURi6PS/qSFRZNLw0yf9LGIpbJMIvRb8tuubPQkp5n1z855LvRYFP+gKa+V7BC
 PwQZJ8DJ2OviXG7+QmjeAvpww7xnqsXRv+zi0Gp2fj7d6R0XdxUe5CRqXFTOjpNgx6qy
 dF+jRGcvKGmgYikYiLBWS35gLIA0011Q4++FmVV8uVWqAfBUF2RGDzVPXTs/0dvOZNrw
 BXt2tjk9+JAbA7IxX2GvlBUdP4wEciT2Rt5DZuCpSip6y9jMbpfREx32HpVdDGrwKAmV
 luAmQVVugw9/QkjzREeqGm1iL2JLzROc+XZMvyI8rzZVBL9AsSfTdG8zEjMBGstF/4AC
 3SKA==
X-Gm-Message-State: AOJu0Yy2Qw8LeDAOPzrmnHE/L0/JUgziiNEiVzIgyK3rrB4ACKvop5ds
 8lsum/qZrz4WcQjpvehwwYIsvwww2cm+IKCGnFH7206T2av+75z0JJUXjNdPcC8RwirqHRvr9eP
 PPtyDTZb+1k30nuRfelz4jSb3wwmCKYL+PawDnQ==
X-Google-Smtp-Source: AGHT+IG7oCFrAoGl4noKURVz6N0TrRdsRGEy6S/FdfjYlPnGeHzjTFH14jlPUkRyA/gQlbRGQP4ifShmj+HL7ifg4nc=
X-Received: by 2002:a05:6902:f84:b0:e0b:11c6:cf77 with SMTP id
 3f1490d57ef6-e0bde1f5f89mr3212707276.4.1722583628681; Fri, 02 Aug 2024
 00:27:08 -0700 (PDT)
MIME-Version: 1.0
References: <CAFEAcA9J37Z1JJb34zyRDo=ow0h1QgOq9bm10dCc0u5bMyQKpg@mail.gmail.com>
 <20240731151714.326879-1-philipp.reisner@linbit.com>
 <8524dc6f-51a0-4fbe-88d5-47a662e674b5@linaro.org>
In-Reply-To: <8524dc6f-51a0-4fbe-88d5-47a662e674b5@linaro.org>
From: Philipp Reisner <philipp.reisner@linbit.com>
Date: Fri, 2 Aug 2024 09:26:57 +0200
Message-ID: <CADGDV=XaHxBosHp9Y_Q_okQTACnt16ZxtRETws8Ui6wVKqEAPw@mail.gmail.com>
Subject: Re: [PATCH v3] util: use RETRY_ON_EINTR() on open() more consistently
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-block <qemu-block@nongnu.org>, 
 Fabiano Rosas <farosas@suse.de>, Peter Xu <peterx@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, David Hildenbrand <david@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::b36;
 envelope-from=philipp.reisner@linbit.com; helo=mail-yb1-xb36.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Hi Philippe and everyone else on the thread,

In the meantime, I learned that we can cause the kernel to restart the
open() syscall by returning ERESTARTSYS from the kernel-level block
device driver side. It was our mistake from the DRBD side that we
returned EINTR instead.

The proposed patch to qemu is okay but not necessary. I will no
further pursuit the inclusion of this patch.

Sorry for the noise.

Best regards,
 Philipp



On Thu, Aug 1, 2024 at 2:48=E2=80=AFPM Philippe Mathieu-Daud=C3=A9 <philmd@=
linaro.org> wrote:
>
> Hi Philipp,
>
> On 31/7/24 17:17, Philipp Reisner wrote:
> > As with many syscalls, open() might be interrupted by a signal.
> >
> > The call trace
> > img_open_file()
> >    blk_new_open()
> >      raw_open()
> >        raw_open_common()
> >          qemu_open()
> >            qemu_open_internal()
> >              qemu_open_cloexec()
> >
> > Ended up in calling open() without a retry loop around it.
> >
> > The experienced logfile entry is:
> > qemu-system-x86_64: -device virtio-blk-pci,bus=3Dpci.0,addr=3D0x7,drive=
=3Dlibvirt-2-format,id=3Dvirtio-disk0,bootindex=3D2,write-cache=3Don,serial=
=3D1b990c4d13b74a4e90ea: Could not open '/dev/drbd1003': Interrupted system=
 call
> >
> > Add the RETRY_ON_EINTR() in qemu_open_cloexec() and remove it on
> > call-sites using qemu_open_old().
> >
> > Signed-off-by: Philipp Reisner <philipp.reisner@linbit.com>
> > ---
> >   chardev/char-fd.c   | 2 +-
> >   chardev/char-pipe.c | 4 ++--
> >   os-posix.c          | 2 +-
> >   util/osdep.c        | 4 ++--
> >   4 files changed, 6 insertions(+), 6 deletions(-)
>
> If you need to repost, please set the next version in your patch
> (which will be v4). Also avoid replying to previous version /
> discussions and your patch could be missed, see
> https://www.qemu.org/docs/master/devel/submitting-a-patch.html#when-resen=
ding-patches-add-a-version-tag:
>
>    Send each new revision as a new top-level thread, rather than
>    burying it in-reply-to an earlier revision, as many reviewers
>    are not looking inside deep threads for new patches.
>
> Also please Cc qemu-block@nongnu.org since the block layer is
> involved via the blk_new_open() call.
>
> Regards,
>
> Phil.

