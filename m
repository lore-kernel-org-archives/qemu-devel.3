Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A36ACD8CA8
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Jun 2026 06:29:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wXvNh-0005Pb-Fk; Fri, 12 Jun 2026 02:28:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <infra.ai.cloud@bitdeer.com>)
 id 1wXvNb-0005NZ-M3
 for qemu-devel@nongnu.org; Fri, 12 Jun 2026 02:28:37 -0400
Received: from mail-lj1-x232.google.com ([2a00:1450:4864:20::232])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <infra.ai.cloud@bitdeer.com>)
 id 1wXvNZ-0004Fe-F2
 for qemu-devel@nongnu.org; Fri, 12 Jun 2026 02:28:35 -0400
Received: by mail-lj1-x232.google.com with SMTP id
 38308e7fff4ca-39677c434efso5505661fa.3
 for <qemu-devel@nongnu.org>; Thu, 11 Jun 2026 23:28:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781245711; cv=none;
 d=google.com; s=arc-20240605;
 b=C7+GYxtB3fu+K9NLPxdX/zLpIjcKWcGhIWdHHezuH1519f+8Zy+G9A46GPA3tzaeVT
 GDngvkoBxXgrwtb6bTkTsJvZMYhgDRIME3LnezN/lg59Yjh0Qk1rAVeFz+5eF4OScClD
 a+kTIiMvW4JDaUSBZsetmUSETxsvNaTs3D4Nd04XFLyfYwm4td1ex03g2rqwQyZiiCO7
 UdDPt3/1wprWLmYWabBc71U+pwLzENWfGamuW0ynOg4vJNYjnC0HdS4qwWhUlqYUisDZ
 dF37eKv57sqc23K0GuZT76cMF+LcsBzOjyoYiNL5+KPRSlWcU3/2uRTG2+GCQXaMRsFb
 CEdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=Lm0s/PYdb5KfIW3ILjskCu/zVHzSHJXxYmOeyKdYUbU=;
 fh=GhP5mtbGI/sLUMsFC6azrmEsmwMvRvKDnmbSOujsopI=;
 b=jP3rrgkxTkAMwGMp9/ebqWtU5wg3KfQE4IdsnXIy+8r3jnJlM9cO62kYEk3jhn2WWC
 jYWuPqIhHNM/GS9jxI8LjEyfDlpdnpZo8VtSYUPs6A5Rxs/EVh4940zu60QlgHcUJSoH
 SG8Jk9xwGih+JntbK1OHloXT8ns9wij9w0P3LcnCETHWQ3f4scZXx95lTfeceGxJNsL4
 GzX7K3RUyF8r6qDGbI+j57n7r3oWAhXmUXrEJTyYZqNnxZ/tiIbiz1kHL+ADlM76B/Ap
 ZLnUca/RrYl+lycBHZUXubrinDAIdDJM8EV2W9Y3QX5prCN/wPpXvYvYSCuaWcgX7duh
 mNHw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bitdeer.com; s=google; t=1781245711; x=1781850511; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Lm0s/PYdb5KfIW3ILjskCu/zVHzSHJXxYmOeyKdYUbU=;
 b=ZnTy2m9VIfLnj5gx6XNcH66MA+kB3AcsBGnOwRDKrXyfsablxZoo8dhblWh41n/IQ2
 9uTbOa+OCn+OoW/KejZtQjFFE9dSBtE9FrjEUXacnQtPb0X3VgoDjleJ7qbEXeo9/QJn
 V7W0b/emOTo3jF5bOGzlE2Wcq7XgeQWrh7xZgghyh2xiIyQBzIZkv4H5GwfUKH5o7Ynm
 Zdpq6oRvOLNcU7x4sDDDmzI2TNohHjgNuW9gva1QKQwJ3EoJOkt8qGkhVhkiPaXL+eN4
 rhQora+eyPOzFihIWLXpDx+aA2Zs+U7E2EaZTdFP/zshKZlxQn+XrCmkHpF9Ff3YldZg
 cx6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781245711; x=1781850511;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Lm0s/PYdb5KfIW3ILjskCu/zVHzSHJXxYmOeyKdYUbU=;
 b=TqS6HUvnPdNgF3ZHXMzjplWBp0Hmz/e4EDwl6GeVSv8SmC7pL/V9QspDCP2cjEcRyJ
 E7ss091P1A6tAaYS3jpWDwuv2HIWRY7+bjDqQ+msccbdIs20Ya18dE7G7DcMomRCff6l
 2uXqTtAHkuXMOP6dPUX8wMhfYkEIfADoCRZGtlQCUioMyWCSqsIQ9aAmj3yvwpAa+c+b
 SMdFNJnBU4Ysu59xAeeN+lUB4CrRmWRa1myML/YEknsF+0jwE9/VRM/GtHsYk6jDfeiz
 RSCVL1n3EcZxSne+4Gh7Nf0sedfceXFsfr+QdZfrwGXTpdh/sijsgiwDocmVixa+zNIe
 L3nA==
X-Gm-Message-State: AOJu0YysQ9CdLVUE1dzCXtcMp1UV4tNQyU87sOcW4feEA4QOW9hcSGfm
 oylXwcYLJ0x0ScafRrR0wqMeQ3adcZs46rQlTOtBsKTIe0JZPZdnR+E6dNzsaxWVAg2NmmiYZyZ
 mJAZOfsWvCTpg77k9w00J1cctgoZvP2cReeEENUTuVg==
X-Gm-Gg: Acq92OFU4Ov526t4aN82YGxxaAZlLb+emG3Xgj5Q1i2hDeTHTzzQMBO3uKl8ceCM2j3
 K5UztZX88axqeBlgZqBB8ntb/ovfUdKxrTRjXUPeWg2MNTo/p2vicPkmuJL1/xhfcfgqg9O0VRr
 LAtWaVpWHogYI8nvOUL6gNRVVVra01MgUYCT6qUdiaf0UgHlaKyMMsfUKmVl1UIJhrql/D9Gbis
 wkUvTeA5wPukLNfIr/Ziq8/VU+t9roZFXsSR2rhvrQNloHHlBHwrx6dKYSWtb/BA1DZUKTVuASV
 APNEvSg=
X-Received: by 2002:a05:651c:90a:b0:396:9598:aa2d with SMTP id
 38308e7fff4ca-3992afd9455mr4192081fa.1.1781245711432; Thu, 11 Jun 2026
 23:28:31 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1781095539.git.yong.huang@bitdeer.com>
 <CAJSP0QU_tx+ygBJZG-vWdTK0ec+NVtiSaVnt-6FMdV1nsw9tpQ@mail.gmail.com>
In-Reply-To: <CAJSP0QU_tx+ygBJZG-vWdTK0ec+NVtiSaVnt-6FMdV1nsw9tpQ@mail.gmail.com>
From: Hy Man <infra.ai.cloud@bitdeer.com>
Date: Fri, 12 Jun 2026 14:28:20 +0800
X-Gm-Features: AVVi8CfuSC_ls2GE695t5DilKPQ6LtPUZJI1nrpGYO3vTwgbR8taMxd49ik_Elo
Message-ID: <CAFWXh4zVKJ_3j9B=61q6Rq1_Ysr92iG3A0eM9fLXU_PAaf1sBA@mail.gmail.com>
Subject: Re: [PULL 0/1] dirtylimit improvement
To: Stefan Hajnoczi <stefanha@gmail.com>
Cc: qemu-devel@nongnu.org, Hyman Huang <yong.huang@bitdeer.com>, 
 Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::232;
 envelope-from=infra.ai.cloud@bitdeer.com; helo=mail-lj1-x232.google.com
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

On Thu, Jun 11, 2026 at 11:19=E2=80=AFPM Stefan Hajnoczi <stefanha@gmail.co=
m> wrote:
>
> On Wed, Jun 10, 2026 at 9:15=E2=80=AFPM <infra.ai.cloud@bitdeer.com> wrot=
e:
> >
> > From: Hyman Huang <yong.huang@bitdeer.com>
>
> Hi Hyman Huang,
> Is this pull request intended for qemu.git/master?
>
> I did not see any previous pull requests from you in QEMU's git log.
> It looks like your previous dirtylimit work went through the migration
> tree. Do you intend to start sending pull requests now and are the
> migration maintainers aware?
>
> Please follow the pull request process and sign your pull request with
> your GPG key:
> https://www.qemu.org/docs/master/devel/submitting-a-pull-request.html
>
> Thanks,
> Stefan

Thanks for the heads-up and suggestions. Let's wait for Paolo's reply. :)

>
> >
> > The following changes since commit de5d8bfd6105d3dd3ae668df9762df244a6d=
1506:
> >
> >   Merge tag 'pull-loongarch-20260609' of https://github.com/gaosong715/=
qemu into staging (2026-06-09 14:00:28 -0400)
> >
> > are available in the Git repository at:
> >
> >   https://github.com/newfriday/qemu.git tags/dirtylimit-dirtyrate-pull-=
request-20260611
> >
> > for you to fetch changes up to 3b224b1c7df1ddefd6bca34f201264d72846c397=
:
> >
> >   accel/kvm: event-driven wakeup for dirty ring reaper thread (2026-06-=
11 08:22:50 +0800)
> >
> > ----------------------------------------------------------------
> > dirtylimit: refactor dirty ring reaper thread with event-driven wakeup
> >
> > ----------------------------------------------------------------
> > Bin Guo (1):
> >       accel/kvm: event-driven wakeup for dirty ring reaper thread
> >
> >  accel/kvm/kvm-all.c      | 42 ++++++++++++++++++++++++++++++++++------
> >  accel/stubs/kvm-stub.c   |  4 ++++
> >  include/system/kvm.h     |  7 +++++++
> >  include/system/kvm_int.h |  3 +++
> >  system/dirtylimit.c      |  2 ++
> >  5 files changed, 52 insertions(+), 6 deletions(-)
> >
> > --
> > 2.43.0
> >
> >

