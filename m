Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5BF1CA0EE4
	for <qemu-devel@archiver.kernel.org>; Tue, 19 Aug 2025 02:46:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uoCMs-00007t-F2; Mon, 18 Aug 2025 22:46:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1uoCMq-00007l-Gk
 for qemu-devel@nongnu.org; Mon, 18 Aug 2025 22:46:32 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1uoCMo-0003ia-Id
 for qemu-devel@nongnu.org; Mon, 18 Aug 2025 22:46:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1755571589;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1SzH2dqtKBNK5uBN+aBeGCoirbYgWR4RJCafY7K0qmY=;
 b=OcGejPF73ANhF5chtCfZQYLOQgcGiLXnJqzDsPmu84aakz5QK7ZS6n1S9saBpRlQ7VrcC1
 gSzp/VofRamDROboGFHZd5EL6w83NYpJV84Rvm1AumQ2qKMunIlvW1pDej7rua1lzDKItx
 +YW143hTyRFy9Bzt/B9WCO0rPWfkgXs=
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com
 [209.85.210.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-481--Nq5sZVYOEy08EksGR4Ykg-1; Mon, 18 Aug 2025 22:46:27 -0400
X-MC-Unique: -Nq5sZVYOEy08EksGR4Ykg-1
X-Mimecast-MFC-AGG-ID: -Nq5sZVYOEy08EksGR4Ykg_1755571586
Received: by mail-pf1-f200.google.com with SMTP id
 d2e1a72fcca58-76e2eaecf8dso3660909b3a.2
 for <qemu-devel@nongnu.org>; Mon, 18 Aug 2025 19:46:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755571586; x=1756176386;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=1SzH2dqtKBNK5uBN+aBeGCoirbYgWR4RJCafY7K0qmY=;
 b=Ir+RZY88KrQetQDJpIGJwm1nkfEYgrH/q08SrqCsAHnO/kD+cLYnjoPgCsDz5ZIzlx
 hceJyeWioRO5zH4IJUi+mPBk1j69f3+8y8YMdKqgvgud/SIbnEQu/kL7/+mn2tAmg2zk
 plZ0V6TS0AEz7l71SArjq9F3PTcBUOnL23cbJRCuUvFCfLyXAtgRfvgtnNSA5oX0EmpW
 vS1pvQLWyFM1ovngG3DgPyAPUbUfDmeaKEJNfnGiVvf6Qj02YglKGLK5S5dhRIivLP7M
 8woQXydJmnSSqqIoUTQ8XMF0rVY+kltZFPb4FC+A3H+QOCBSCCbh9BiWvs5x6vfoL6Kx
 HDDA==
X-Forwarded-Encrypted: i=1;
 AJvYcCU3hgW/nojJPU6LX3iTgc/i9PtA/bbf6QiUzE8bEKyP8RY6rvguWLXd8Q6yjpQqyswy8RANbYO1A+Vi@nongnu.org
X-Gm-Message-State: AOJu0YwO4sh4VkdBISJK44J1tqNhmiQw5aEkwpSeukyQF6DMA2xE2jav
 Xg0GPJFfAg1KWZeghbSXZbreZIAn2egb797/Y2mG2D4l7Bd74Z/ZV7UbDOG+jBLiUyMD+XHNRKH
 fOsHAtN2xnfi8dLsL2cv9nPArdFDhGgpwaqLJhNbWWvTVxEw+hxKqNcnoxbwW4Ftki8mh61EjEa
 /Ibu2oqktkVuQFbkoVBgHFSn/qJCi9O2U=
X-Gm-Gg: ASbGncsz81TztX02PTGKw+UE2bp0DWBP1OjJInBnEEW7D6+2CJvzmtBAl1nxF8z9ePd
 4/Kn+Ei1snLzTobJR6J6Vl+YvKnCwLWUTxw8258CI4bBYqbIZojdqsH+3v4CMY0VaoGJym/cJDh
 7ziPvOUL6SDLTT93brdrCwdPA=
X-Received: by 2002:a05:6a21:6da5:b0:23f:f934:19b9 with SMTP id
 adf61e73a8af0-2430d39522fmr1290821637.14.1755571586068; 
 Mon, 18 Aug 2025 19:46:26 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFOoAjrU93+D/5e17Mpvox1qXmmqftwtj5QLMePuS37r2pupujDSQdvt+wKrJSE5rrhxCuj/Cl/VFkyS4IZxhc=
X-Received: by 2002:a05:6a21:6da5:b0:23f:f934:19b9 with SMTP id
 adf61e73a8af0-2430d39522fmr1290763637.14.1755571585179; Mon, 18 Aug 2025
 19:46:25 -0700 (PDT)
MIME-Version: 1.0
References: <20250807110806.409065-1-lvivier@redhat.com>
 <CACGkMEsYDPjPBNmAd=AmZQ2AY46weFC_u8PK=+CSCuUD6W9zYg@mail.gmail.com>
 <20250818140313.GA7391@fedora>
In-Reply-To: <20250818140313.GA7391@fedora>
From: Jason Wang <jasowang@redhat.com>
Date: Tue, 19 Aug 2025 10:46:11 +0800
X-Gm-Features: Ac12FXwHeRGdBF72Vs06A0d8yjqKePthJfirsBvi2bXYkG8EJtybbRYG8KUe4OU
Message-ID: <CACGkMEvUq4ugS6PQ=mRH5Kx+rnDda5Wq3K8hSVrehv3=n5xk4Q@mail.gmail.com>
Subject: Re: [PATCH v2] e1000e: Prevent crash from legacy interrupt firing
 after MSI-X enable
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: Laurent Vivier <lvivier@redhat.com>, Michael Roth <michael.roth@amd.com>,
 qemu-devel@nongnu.org, Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Thomas Huth <thuth@redhat.com>, Dmitry Fleytman <dmitry.fleytman@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=jasowang@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Mon, Aug 18, 2025 at 10:03=E2=80=AFPM Stefan Hajnoczi <stefanha@redhat.c=
om> wrote:
>
> On Mon, Aug 18, 2025 at 10:08:18AM +0800, Jason Wang wrote:
> > On Thu, Aug 7, 2025 at 7:08=E2=80=AFPM Laurent Vivier <lvivier@redhat.c=
om> wrote:
> > >
> > > A race condition between guest driver actions and QEMU timers can lea=
d
> > > to an assertion failure when the guest switches the e1000e from legac=
y
> > > interrupt mode to MSI-X. If a legacy interrupt delay timer (TIDV or
> > > RDTR) is active, but the guest enables MSI-X before the timer fires,
> > > the pending interrupt cause can trigger an assert in
> > > e1000e_intmgr_collect_delayed_causes().
> > >
> > > This patch removes the assertion and executes the code that clears th=
e
> > > pending legacy causes. This change is safe and introduces no unintend=
ed
> > > behavioral side effects, as it only alters a state that previously le=
d
> > > to termination.
> > >
> > > - when core->delayed_causes =3D=3D 0 the function was already a no-op=
 and
> > >   remains so.
> > >
> > > - when core->delayed_causes !=3D 0 the function would previously
> > >   crash due to the assertion failure. The patch now defines a safe
> > >   outcome by clearing the cause and returning. Since behavior after
> > >   the assertion never existed, this simply corrects the crash.
> > >
> > > Resolves: https://gitlab.com/qemu-project/qemu/-/issues/1863
> > > Suggested-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
> > > Signed-off-by: Laurent Vivier <lvivier@redhat.com>
> > > ---
> >
> > Acked-by: Jason Wang <jasowang@redhat.com>
> >
> > Consider rc3 is out. Can this be applied directly by maintainers or a
> > PULL request is expected?
>
> The commit description doesn't mention whether this fixes a regression
> introduced since QEMU 10.0, whether there is a security impact, etc.
> In the absence of more information, this looks like a regular bug fix
> that does not need to be merged for -rc4.
>
> Only release blockers will be merged for -rc4 (Tue 19 Aug). Please
> provide a justification if this commit is a release blocker. Reasoning:
> - From -rc3 onwards the goal is to make the final release and adding
>   additional patches risks introducing new issues that will delay the
>   release further.
> - Commits should include enough information to make the decision to
>   merge easy and documented in git-log(1). Don't rely on me to judge the
>   severity in areas of the codebase I'm not an expert in.

I see, I think it's not a release blocker so we can defer this to the
next release.

Thanks

>
> Thanks!
>
> Stefan


