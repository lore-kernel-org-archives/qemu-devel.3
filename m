Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97F14CD5BD1
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jun 2026 13:52:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wU33e-0002t8-TY; Mon, 01 Jun 2026 09:51:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1wU33d-0002sl-CO
 for qemu-devel@nongnu.org; Mon, 01 Jun 2026 09:51:57 -0400
Received: from mail-ed1-x52e.google.com ([2a00:1450:4864:20::52e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1wU33b-00036e-Jq
 for qemu-devel@nongnu.org; Mon, 01 Jun 2026 09:51:56 -0400
Received: by mail-ed1-x52e.google.com with SMTP id
 4fb4d7f45d1cf-68bd167797dso4390732a12.0
 for <qemu-devel@nongnu.org>; Mon, 01 Jun 2026 06:51:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780321913; cv=none;
 d=google.com; s=arc-20240605;
 b=HlIck61t2Q7RgbYu0amfWPUjqlI6SWQDCmi29uY+wz6RgKQc8tKPkBV6p01W1/l04t
 zMK9XsEh0XSVAJ8HCET9DKktRjWCvX9bfoKnPXBm5nLdjwMs+le+pUTuIx4RBBhvLdKL
 8AMWkUQiG6HlyTQX/zyOHDJaMfx8IzZ4gg2kmHpRw3wyWid/QLrrEcVgWVpxC9zury2l
 2oXM0aEF37aJQINd8LppCocUNfQQnb2yk0eYegB2/veBNDYvKd/Wr1rhxpRPMZAk4j40
 6IoONrDagM7u8QQoGGouFWowUu0MTezfsMCLOxTYjH/CUqu2Mwp98nCTaydNoBKECG3e
 LXoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=yIn4Seet9cMWpXtd/icQ72RbrP4cPSiitnDC6hJf34Q=;
 fh=4ZKDTZwpCmIjlZIabNLDSiteu+73ynXgc0SM8IFFnQg=;
 b=LgrJbbr9MIVg4nDSemxA4J5Ulk3MPtEiGJIcxnic1UERWEJaMhwBgo7XnPltKeTjf6
 m06r+36uVkJpOpoTkDb4BShT0puklAz+K3cx6U7X7XzRnR9U3k1EHqzKs+L9UZxq1qQj
 bkDzbsRm8Vcr5aetefuYxRh4nPz0ZoMOeLF6D9/RUSCi7KjkWfiOj10YLsehGun9X+j/
 oitwJcYRn0d93V45wwJMZxFUbuN1w/zwLlmOgKFBOzfzsb80QHfVs1IswnGMWhBOr0bP
 1u3Q8MDRqPAjw5+eY+8Xj9RbqX9+BvgAIOMhOv3cQLUqL/MbbeMhX+ksxXW69/jMWbHC
 vnWg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1780321913; x=1780926713; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=yIn4Seet9cMWpXtd/icQ72RbrP4cPSiitnDC6hJf34Q=;
 b=L+qIG354aJpFCFqKd8NrObr3XgiCHN4yRlYGF5iQBq5wTNVy+5CU/Q1h2CVFRW+fRp
 e+u0E8HfVIPoVbplQs5u7DgLXl8UuK+lCV0QaSJVTl2HY8ljeJrHHpF8S9s24oK6zhhd
 HUlgD5qrAeSX9N1GPKyXjLQ5G/8kRxRQtzKTurwuNBTMv5yd+YRTBOTjjl0xWg4HerWA
 sRqvpPvcd4CWSqeiljHx26rHi+CvTW0fOaJQHvFsb0YXZw867Bm3lY8MmRXNDUeOZI0j
 h5Cf4MfZKbhGdhOHQMKjZYgNHi5MiWPVzQhei9fWE3zSSqQtO/VU/aCZ7OKr3fLT3/4X
 U31A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780321913; x=1780926713;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=yIn4Seet9cMWpXtd/icQ72RbrP4cPSiitnDC6hJf34Q=;
 b=hS1aFKMGmAixRO65MZdBWdqU9nwOhjPYrUVxQ6/KWo3BfEDu0h6lYQz6MA4YdQHz9i
 pH9RACWDm9+DA+wNw/Le8dR/+oXS7vOyUFf7c4Dc3h6MyykqM8o49bdoDwDh50R7+CNC
 k3ZNpXFPivQI/HsVxBseNlAEmwyVAN5uqxRmQ1tKNtNVEC/63PVz8B6NNoLD7351KqBu
 yIp2vQP9uqGlSncqpefdEo60Eu3O93nieOoRAhFiVCpzGvXAA0rTfgED1Rl16LRHvq5a
 Pdb0cwRJxl6m49q9tDUaLQl2oZXHdaywilPjNjlr2VxcYXiYSyS365dbE2MP3mUlSs1D
 B4gw==
X-Forwarded-Encrypted: i=1;
 AFNElJ9vyAnSrobZ9sfM1TLOqdrjfmJjelEBbLSJ1MBVjkCV0z1uNQOnPTbOdq9pN/wMvRDfA6wHn3sKTSm/@nongnu.org
X-Gm-Message-State: AOJu0YxwuWahOubkLAeDz47egng8AfjoPp5R/mEvSikDEFTTlE/mARxs
 8SrvTzrch81hmPS5FjmNbQwOcJtI19SGitzavFZQwPa553ko2cXDPZNQvfyvK0PM3xBROHsSABu
 5ziz279vnagKeUUHl1OqneA+8duOQtkY=
X-Gm-Gg: Acq92OHjAfgdV7OWxIeH8CLn5QwTa/BkxHvk82tQUf8Wlo0oewDGtKxkdLtogEZ7gf0
 1L8vKamtGn/D0NHOS+dNPFyBUj/n1vEjmtAn5mFUhYNHkMyLly1kPMdqUe1oeSbljw0nbNr3qY/
 9+cx4/P71uS0l1rJrxekqAUt68Yklofm7/G3djVIc0T+ZMopbC/rFne0e8T/RV0sjCaVc9uyJfa
 4NPMXap3bHKRbjFzfEZUrIzCtQ4PuMdaBacIZnx7rwBK3ZSXfV+65lDbPfDZ36c+8ndtk3wyl+3
 O21YCfVN1mpqgp7RRv9I9ZNRsaCIAS/0v7Dg6fBjzgtiM6HhYwqP
X-Received: by 2002:a05:6402:2b8d:b0:67b:89f5:26c7 with SMTP id
 4fb4d7f45d1cf-68c8bba7203mr5475929a12.26.1780321912926; Mon, 01 Jun 2026
 06:51:52 -0700 (PDT)
MIME-Version: 1.0
References: <874ijtz038.fsf@draig.linaro.org>
 <CADSE00+RdBUhFVBDSXtVd1J5SaccqWy+RBxqnxuLKUYcitFMPw@mail.gmail.com>
 <20260601083628-mutt-send-email-mst@kernel.org>
 <CADSE00+kRnEC08LLVu6H065u2KaxBm-KnSN_8y6+964-FLbJMA@mail.gmail.com>
 <20260601090953-mutt-send-email-mst@kernel.org>
In-Reply-To: <20260601090953-mutt-send-email-mst@kernel.org>
From: Stefan Hajnoczi <stefanha@gmail.com>
Date: Mon, 1 Jun 2026 09:51:40 -0400
X-Gm-Features: AVHnY4K4RWlphAxNghQcViOsEmY2TXDYfUv1TImvk_Ri_z_fBAKqWEEKXrEaY9U
Message-ID: <CAJSP0QV4W=5MJsSGggACv-tqxDtiieKc0YzEn8t-R=RD94KJaQ@mail.gmail.com>
Subject: Re: Where should the vhost-user specification live?
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Albert Esteve <aesteve@redhat.com>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 qemu-devel <qemu-devel@nongnu.org>, virtio-comment@lists.linux.dev, 
 dev@lists.cloudhypervisor.org, rust-vmm@lists.opendev.org, 
 Stefano Garzarella <sgarzare@redhat.com>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>, 
 Demi Marie Obenour <demi@invisiblethingslab.com>, Alyssa Ross <hi@alyssa.is>, 
 Mark Burton <MBURTON@qti.qualcomm.com>, Matti Moell <matti@qti.qualcomm.com>, 
 Stefan Hajnoczi <stefanha@redhat.com>, Viresh Kumar <viresh.kumar@linaro.org>, 
 Dorinda Bassey <dbassey@redhat.com>, Sergio Lopez <slp@redhat.com>, 
 Vishwanath Seshagiri <vishs@meta.com>, Rob Bradford <rbradford@meta.com>, 
 Zhengyu Zhao <zhaozhengyu@bytedance.com>,
 "Jorge E. Moreira" <jemoreira@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::52e;
 envelope-from=stefanha@gmail.com; helo=mail-ed1-x52e.google.com
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

On Mon, Jun 1, 2026 at 9:12=E2=80=AFAM Michael S. Tsirkin <mst@redhat.com> =
wrote:
>
> On Mon, Jun 01, 2026 at 03:05:50PM +0200, Albert Esteve wrote:
> > On Mon, Jun 1, 2026 at 2:39=E2=80=AFPM Michael S. Tsirkin <mst@redhat.c=
om> wrote:
> > >
> > > On Mon, Jun 01, 2026 at 02:32:11PM +0200, Albert Esteve wrote:
> > > >  But also because, in my opinion, separating
> > > > the specification would improve development agility by decoupling
> > > > specification development from QEMU's review and release cycles.
> > >
> > > Generally for QEMU this will be less agility, unless I misunderstand
> > > what is proposed)
> > >
> > > Because presumably there will need to be spec releases then?
> > >
> > > So
> > >         new feature -> spec tree -> spec release -> qemu implementati=
on -> qemu release
> > >
> > > is surely longer that what we have now.
> >
> > I see your point.
> >
> > However, we do not really need to introduce a heavy release management
> > layer. We could just operate it as a living document, where the main
> > branch is the authoritative source of truth.
> >
> > For the workflow, development doesn't have to be strictly sequential
> > either. A contributor can propose the spec update while working on the
> > implementation, much like we do for VirtIO updates. Actually, this way
> > one update/change supports the other.
> >
> > I guess my point is that a dedicated repository could lower the
> > barrier for new changes AND keep QEMU's own development speed mostly
> > unaffected.
> >
> > BR,
> > Albert
>
> Something something submodule? Possibly. If you want to make progress
> on this, pls think of the process, try it out.

If I understand correctly, the motivation for moving the spec
somewhere else is to replace the email patch review process with a git
forge review process?

This seems like a superficial change and is not worth in my opinion if
you consider we'll have to redirect from the old spec location and
move the community over to the new repo. We could actually lose spec
change reviewers in the process either because they don't know what's
going on or decide that they prefer to spend time elsewhere when faced
with switching processes (the people who review and participate in
discussion do so out of personal interest and as far as I'm aware no
one is employed to work on vhost-user as their #1 priority).

Having said that, here is what I imagine it would involve:

1. Michael creates a new repo on a git forge (if he wants it to be
under the GitLab qemu-project organization I can help with creating
the repo, otherwise he creates a new organization and repo).
2. Discussion happens in Issues.
3. Spec changes are proposed in Merge Requests. Michael merges them
once consensus has been reached.

It's similar to what we have now in qemu.git, except that a git forge is us=
ed.

Stefan

