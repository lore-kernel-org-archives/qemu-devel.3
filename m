Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43AB0C79F9F
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Sep 2026 15:00:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x4gFe-0005cI-LR; Thu, 10 Sep 2026 10:59:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1x4gFd-0005cA-Jn
 for qemu-devel@nongnu.org; Thu, 10 Sep 2026 10:59:45 -0400
Received: from mail-yw1-x112e.google.com ([2607:f8b0:4864:20::112e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1x4gFb-000089-NX
 for qemu-devel@nongnu.org; Thu, 10 Sep 2026 10:59:45 -0400
Received: by mail-yw1-x112e.google.com with SMTP id
 00721157ae682-87ffa98d4a9so25280417b3.3
 for <qemu-devel@nongnu.org>; Thu, 10 Sep 2026 07:59:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789052382; cv=none;
 d=google.com; s=arc-20260327;
 b=LrGlw8P5iqI0JpAa4ReDeeltoMIzxwE7yHHR+oZFBgCEvv2HaTU/MC2hXKC2Iicaf0
 G98Ec66cT+eXvl4MNZ1+s8ao7wE6X6moMuX8+3COyrgIEenIifweNLKltUMoGgXulbdW
 Y14vwne0eap6mKDdatHDsWBdGR4DW59kdwywtGyIB6i7G+eVlE3Qv9OHfDSQCNpnvNlp
 PfWEynj4r+6SOkf/hPYdjkoS2wKbb7kxo3Fv4C1ag0vOSZ5Am4XpklNLgAnQytXvLIPe
 k+ws3Se8l73X4L91SgTSYZqDYz+70TpDhm9HD8bkPGXXkdJjPkdOocslSNNru4f9+IHG
 K6tA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=9sww6vFzMO3g8KjSUP+1A1lg11o43IFmG1CL1QemVQM=;
 fh=anZl6Td6NaKjHGFM8y4oK3yu8UEI3L8plTd5OD+C2Mo=;
 b=CURwPfZ49ez0kRZpAfRpv5DcHaPPjZsiZqv7iKCOwFiriEJLH2he/flVTIqetLQ9eC
 Ybc+tFvkFUZywfxTmHVjZshTyU/eSevdaOeHzvBXdIbKHu1LO/qLb60pYyKlmamcKcJC
 5KSd434AmGhwAug/F+5XitUz8YgFVKfTrmFkahmVgQasvvp8r1sKq/NaTN9wqx5NDnjw
 GIXvbkOqaQf6EzVTxP+FlczmKe+C7CgR3Q2Fv6cfkEXpg6iLlIn5NvmcFwmsY0nBdqdM
 P1fvuVuGwzvHmFpwgMmzrE0akJtJSybT3xIm12Oes2uaOuPPZrAEoH2re13aVOnbE3Ao
 LLwQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1789052382; x=1789657182; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=9sww6vFzMO3g8KjSUP+1A1lg11o43IFmG1CL1QemVQM=;
 b=ihWwJSy8lqbAA81yVHmKIFd84TQ6CGWTEji9vcRUHuxFaQVbhXi0xBJ3I3seBpe8Pz
 ++dbP7PqlnwaMErCiwI4VUVvR4VgRuW2XU6KesAQIs95opg24RjMMK7cPAlJf6Q0K74T
 jXI1IUD+/wf6X3nY4hMR8zSkZuhbo0/FfnB/rybXbtx6xF9LlDpV0IT+nu9lC1pn9FYP
 YOvrg/DSMm2beupDwzQvi0RhG79/1RsdrVSSfS6vOh5+E1SXDvJTqyJplc8Nhpajx5A6
 RAbs6y9Y4noczlw+OY45KDQJLGyyf8/5Yn85mUUmwEMTwZaMHtaKdPC8OPw7O+O5d/el
 u+Xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789052382; x=1789657182;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=9sww6vFzMO3g8KjSUP+1A1lg11o43IFmG1CL1QemVQM=;
 b=fRiTk8QANhLYad4ZMP6bYlESY3nH6OMFUWPRxw6+YMGJqLwJ/wv1PPgBveEHcNzar0
 rOQ5uBv+nCuavv+ysTOiKss18ijqSrBANVcUfV+sdVhFNeaPAxbce5ltDr4V/uyEL0eJ
 0uW8eRQoyckUXEixfpeqFMemYPojmq8pAKSC/lmAOCqssQLTTUv5vwEmJas+7t8eG7eq
 eCaEiRWn73y+85GNODeqnFgVqKbypMqHq90QZYZyRO3Nl7vBOrsR61C9p4V5iAIVubv/
 UFITeS5LMP7cstd4oSdbMbfaQQmqcNS9hhHNNs4j3jCQbIQiwburp6Vpc68Zt3tx6mLd
 AHPQ==
X-Gm-Message-State: AFuF++lhLtUQ8SuTcFgyfQAMam0nzDZ7mbjgTR9xgdH50TNKp3tdeCYg
 7QcuR0M3+1ql+FP43au+sTUUbzP7Xb5z+aAakTAzDrwJSmtjFk6RVzYvAGwGIIP65RLqzhT+Av7
 yzp97houIjRIBXbPf3ncgjKdj8Al5k+Hf5RgF0O3jzQ==
X-Gm-Gg: AYBFou0EjfjooQZ7Z/i2dVi18Y7A0hqSYZBn5h3rm69dO+q7f/5YiQCW8FUja3dIeZj
 gF9zIQf/hM1fYnag9UuIwM/Zu2rAm0gbiyqqKlT1ZZ2IqmKo/ba2CoGGKvJHfXS2EOh6YxkrqUY
 GnugvP/gUB8PAMk44QJPXBUKR53PZrxUmPwYhz6P1VjfilnKnM3S2kKgy8yZ8hTqBequb76Hqpk
 /c1lfPVjjUVbh+cXNgDCMaBkDLCZJraGC8LZ3I4x+tZq0mjYBM6nEALzjnfzgC2OVRfKxwDn6FW
 5C5AsxF2KHZpvIUzt5BpSoBSlYvcYSnl/n2iuWd0OIe5kMwe2dPQxnKa71uaRlVNrr5mxlM499K
 GnZ76nuU42g6nOEfvRL/w5E3K6UWapDuXB59eEI8=
X-Received: by 2002:a05:690c:620b:b0:844:9f61:92d9 with SMTP id
 00721157ae682-87126aa7734mr162978057b3.17.1789052381653; Thu, 10 Sep 2026
 07:59:41 -0700 (PDT)
MIME-Version: 1.0
References: <20260910-virtio-gpu-cleanup-v1-0-ccb8927a671e@redhat.com>
 <CAFEAcA8hD2+8uupWy5jZbKYLLUPwkvX9LdCEGrdVL20L1f7mpw@mail.gmail.com>
 <CAMxuvazBKab1h7-H55De4XRJFXtd=umAqCxc1WPz+iOKx7nrvA@mail.gmail.com>
In-Reply-To: <CAMxuvazBKab1h7-H55De4XRJFXtd=umAqCxc1WPz+iOKx7nrvA@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 10 Sep 2026 15:59:30 +0100
X-Gm-Features: AcwNN1Xt50hskAx7IZ5G3ViMsKpTnWVMUZoWwFxMhtXuQ91MBo9OK5bNuKSW568
Message-ID: <CAFEAcA_gvGYxL7LxjUKjqO3gNFT0_ZheC2ZxSf49jhAKz3276A@mail.gmail.com>
Subject: Re: [GIT PULL 00/24] Various virtio-gpu/dmabuf related fixes
To: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::112e;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x112e.google.com
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

On Thu, 10 Sept 2026 at 15:55, Marc-Andr=C3=A9 Lureau
<marcandre.lureau@redhat.com> wrote:
>
> Hi
>
> On Thu, Sep 10, 2026 at 6:45=E2=80=AFPM Peter Maydell <peter.maydell@lina=
ro.org> wrote:
> >
> > On Thu, 10 Sept 2026 at 14:30, Marc-Andr=C3=A9 Lureau
> > <marcandre.lureau@redhat.com> wrote:
> > >
> > > The following changes since commit 257bf4f160c50ca8c4ebd603f519f5c786=
013fb7:
> > >
> > >   Merge tag 'for-upstream' of https://gitlab.com/bonzini/qemu into st=
aging (2026-09-10 11:08:04 +0100)
> > >
> > > are available in the Git repository at:
> > >
> > >   https://gitlab.com/marcandre.lureau/qemu.git tags/virtio-gpu-pr-v1
> > >
> > > for you to fetch changes up to d26343c12d84227263b8d2fc89bac7632a98e0=
0d:
> > >
> > >   contrib/vhost-user-gpu: disable scanouts on resource unref (2026-09=
-10 17:29:47 +0400)
> > >
> > > ----------------------------------------------------------------
> > > Various virtio-gpu/dmabuf related fixes
> > >
> > > Hi,
> > >
> > > While working on CVE-2026-66020 (which had a few revision on list), I
> > > kept finding several places where virtio-gpu scanout and dmabuf
> > > ownership was unclear.
> > >
> > > The CVE comes from using a blob after RESOURCE_DETACH_BACKING has
> > > unmapped its memory. Following that path also found stale dmabuf
> > > references, duplicated scanout bookkeeping, and inconsistent cleanup
> > > between display backends.
> > >
> > > Those changes touch a lot of area and I have done basic testing with =
the
> > > various backends. I would not recommend backporting them all to stabl=
e.
> > > The first 2 patches address CVE-2026-66020 in the general case and
> > > should be safe to backport.
> > >
> > > thanks
> > >
> > > To: qemu-devel@nongnu.org
> > > Cc: Alex Benn=C3=A9e <alex.bennee@linaro.org>
> > > Cc: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
> > > Cc: Dmitry Osipenko <dmitry.osipenko@collabora.com>
> > > Cc: "Michael S. Tsirkin" <mst@redhat.com>
> > > Cc: Stefano Garzarella <sgarzare@redhat.com>
> > > Cc: Alex Williamson <alex@shazbot.org>
> > > Cc: C=C3=A9dric Le Goater <clg@redhat.com>
> > > Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> > >
> > > ---
> > > Changes in v5:
> > > - EDITME: describe what is new in this series revision.
> > > - EDITME: use bulletpoints and terse descriptions.
> > > - Link to v4: https://lore.kernel.org/qemu-devel/20260910-virtio-gpu-=
cleanup-v4-0-7d623714bd71@redhat.com
> >
> > So is this different from the v4 on list? Please don't send pull
> > requests as if they were new revisions of individual patch series.
> > This is not the mechanism the project uses: pull requests should
> > be an accumulation of whatever patches the maintainer of a
> > subsystem has. Sometimes that will happen to be a single
> > patchset, but usually not.
>
> My bad, I should have cleaned-up the series cover letter. There is no
> difference with v4 beside trailer tags.
> I didn't include other pending ui or related patches, I could, but I
> would rather have smaller PR.

Thanks for clarifying.

> I can send another PR if those extra lines in the cover letter are too
> dirty. Let me know

I think since the text is also in the commit message for the
merge commit and so it all appears in the git log it would be
worth cleaning that up and sending a fresh PR. (You can just
resend a new cover letter email with the new pullreq info,
you don't need to resend all the patchmails.)

thanks
-- PMM

