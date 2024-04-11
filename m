Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F04E2C4345F
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Apr 2024 16:38:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ruxQK-00078F-QE; Thu, 11 Apr 2024 12:37:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yu.zhang@ionos.com>)
 id 1ruxQJ-00077j-9h
 for qemu-devel@nongnu.org; Thu, 11 Apr 2024 12:37:15 -0400
Received: from mail-ed1-x529.google.com ([2a00:1450:4864:20::529])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <yu.zhang@ionos.com>)
 id 1ruxQC-0006qq-Lr
 for qemu-devel@nongnu.org; Thu, 11 Apr 2024 12:37:15 -0400
Received: by mail-ed1-x529.google.com with SMTP id
 4fb4d7f45d1cf-56e6acb39d4so5536254a12.1
 for <qemu-devel@nongnu.org>; Thu, 11 Apr 2024 09:37:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ionos.com; s=google; t=1712853425; x=1713458225; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xEsBPCb59XpCNMWUPY1qcsKCuKrD1GGTHKLwPxoBsPo=;
 b=IaxA6dHrEoqxva+EtLRuWEF1or94XyRN/ShBpXyv9yI7zSu0TWqu84vc2sxdQJAcDI
 IBqzFlS6nms9iR4AYASRXrT4WQoJo0LkK5Htvrg7+PnpRrIvssS8AoEM0SnDFmFqBbmu
 lLsDU0Z5NksdPlU+Hu08IQsdRKbT2xEcexVydrm0u3c6ayly1e8dvhloApuUCTICB+Hf
 yf3b974Gf9+aZOLj5KLsc/BaPZC5yNyeNgBvgBms9jxljcR7OSmlvrKwWW+TQSqfSjBZ
 YymRT81PSmcM2a5zbifZlfZyQ4BvAKJDaDs8fIwCIBZ2HOsAN0mMqgE6spVv+rula0RF
 nZbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712853425; x=1713458225;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=xEsBPCb59XpCNMWUPY1qcsKCuKrD1GGTHKLwPxoBsPo=;
 b=ZWp0oY9MLDCc+P9DroO+gSDA1ZqpY0CmrM0naHdUYGfGxZq9JeJHeyJgxOFSGhZpXg
 gURMpv6YMlLX4HNyvJLDHJyxwmObDuGCxaRYUtV8yfkpoMPBI/2Bq7ZAjf34SJdj8Kae
 AN9SPoyeNLfNpaxcwZ8IeSxROK1EspS2nR55B2xPbwrqFnnz4yMrCYj5h1x48NFjUwbm
 lxIFApyah//EI+zYiYgydLP7h1Qrio3K87JKW0vBnsAdLu/u/kOKetxvLazlnG1tW0qB
 hVvjd4JDtyEcVO+Atva6ZYlNssKoiniRiM1O0Pr1U92yRW/o8LJlpiLQtFWpLGmagc3L
 5Gbg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWnAczQ87pyUxAuK5KfavqEwsLwBfK+f64ah4+QvU51xVd8ZtoyS1BhgrZRJk7bit8LONlWVDaF0JfchI8kTU+k1JbJ26w=
X-Gm-Message-State: AOJu0YwGXJKdu2/+5rmXyc2JD3ZL2u6Chbd/jdnGWOrcbYuZyGqBJ9pI
 I2oOkrXpGHD2Aq6t4Z5/BR2q6C5No7jPjRsPtJ+pHszw5QrYq0XFyFImZdc5wtXql4nc/EMtfhx
 iT9K5Z/Qxz8OWEi6a2y/dZwdmifrMjkyfnBn0DA==
X-Google-Smtp-Source: AGHT+IHP4jy3cKiL9cIw9NVCrm+KyRIszlxZOuty+FO2dzK6oH98DnfLyeoyVcv+jBsOfn5+H+vG/vaWtld+UQo5pyM=
X-Received: by 2002:a17:906:3488:b0:a52:e86:ae62 with SMTP id
 g8-20020a170906348800b00a520e86ae62mr156368ejb.54.1712853425151; Thu, 11 Apr
 2024 09:37:05 -0700 (PDT)
MIME-Version: 1.0
References: <ef160e75-d4a4-4be0-81f3-77d8b0e76178@linaro.org>
 <9d082daf-acf0-27c5-1758-5a3f2af7ee0f@fujitsu.com>
 <CAHEcVy50AtvDyCjwPa9Hu+x1wiUF6xf5McGOTHL+wdt3WN3pgA@mail.gmail.com>
 <Zgx3brrz8m0V7HS4@x1n>
 <CAMGffE=i+hVCNaX_31h1D1VW7JGJBqoa9T0qEJe2CDcb9BPiAA@mail.gmail.com>
 <ZhQYu3ZnsIGv2qUZ@x1n>
 <CAMGffEm2TWJxOPcNQTQ1Sjytf5395dBzTCMYiKRqfxDzJwSN6A@mail.gmail.com>
 <ZhWa0YeAb9ySVKD1@x1n> <082a21b0-d4d1-9f6c-24b5-bee56263008e@fujitsu.com>
 <ZhaY2_cO6CrQFCt3@x1n> <Zhfxoaz9yNTx8Btd@x1n>
In-Reply-To: <Zhfxoaz9yNTx8Btd@x1n>
From: Yu Zhang <yu.zhang@ionos.com>
Date: Thu, 11 Apr 2024 18:36:54 +0200
Message-ID: <CAHEcVy7POArt+CmY8dyNTzLJp3XxXgjh3k8=C=9K+_cw1CSJFA@mail.gmail.com>
Subject: Re: [PATCH-for-9.1 v2 2/3] migration: Remove RDMA protocol handling
To: Peter Xu <peterx@redhat.com>
Cc: "Zhijian Li (Fujitsu)" <lizhijian@fujitsu.com>,
 Jinpu Wang <jinpu.wang@ionos.com>, Elmar Gerdes <elmar.gerdes@ionos.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, 
 Yuval Shaia <yuval.shaia.ml@gmail.com>, Kevin Wolf <kwolf@redhat.com>, 
 Prasanna Kumar Kalever <prasanna.kalever@redhat.com>,
 Cornelia Huck <cohuck@redhat.com>, Michael Roth <michael.roth@amd.com>,
 Prasanna Kumar Kalever <prasanna4324@gmail.com>, 
 "integration@gluster.org" <integration@gluster.org>,
 Paolo Bonzini <pbonzini@redhat.com>, 
 "qemu-block@nongnu.org" <qemu-block@nongnu.org>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 "devel@lists.libvirt.org" <devel@lists.libvirt.org>,
 Hanna Reitz <hreitz@redhat.com>, 
 "Michael S. Tsirkin" <mst@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Eric Blake <eblake@redhat.com>, Song Gao <gaosong@loongson.cn>,
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Beraldo Leal <bleal@redhat.com>, arei.gonglei@huawei.com, 
 pannengyuan@huawei.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: permerror client-ip=2a00:1450:4864:20::529;
 envelope-from=yu.zhang@ionos.com; helo=mail-ed1-x529.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 T_SPF_PERMERROR=0.01 autolearn=unavailable autolearn_force=no
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

> 1) Either a CI test covering at least the major RDMA paths, or at least
>     periodically tests for each QEMU release will be needed.
We use a batch of regression test cases for the stack, which covers the
test for QEMU. I did such test for most of the QEMU releases planned as
candidates for rollout.

The migration test needs a pair of (either physical or virtual) servers wit=
h
InfiniBand network, which makes it difficult to do on a single server. The
nested VM could be a possible approach, for which we may need virtual
InfiniBand network. Is SoftRoCE [1] a choice? I will try it and let you kno=
w.

[1]  https://enterprise-support.nvidia.com/s/article/howto-configure-soft-r=
oce

Thanks and best regards!

On Thu, Apr 11, 2024 at 4:20=E2=80=AFPM Peter Xu <peterx@redhat.com> wrote:
>
> On Wed, Apr 10, 2024 at 09:49:15AM -0400, Peter Xu wrote:
> > On Wed, Apr 10, 2024 at 02:28:59AM +0000, Zhijian Li (Fujitsu) via wrot=
e:
> > >
> > >
> > > on 4/10/2024 3:46 AM, Peter Xu wrote:
> > >
> > > >> Is there document/link about the unittest/CI for migration tests, =
Why
> > > >> are those tests missing?
> > > >> Is it hard or very special to set up an environment for that? mayb=
e we
> > > >> can help in this regards.
> > > > See tests/qtest/migration-test.c.  We put most of our migration tes=
ts
> > > > there and that's covered in CI.
> > > >
> > > > I think one major issue is CI systems don't normally have rdma devi=
ces.
> > > > Can rdma migration test be carried out without a real hardware?
> > >
> > > Yeah,  RXE aka. SOFT-RoCE is able to emulate the RDMA, for example
> > > $ sudo rdma link add rxe_eth0 type rxe netdev eth0  # on host
> > > then we can get a new RDMA interface "rxe_eth0".
> > > This new RDMA interface is able to do the QEMU RDMA migration.
> > >
> > > Also, the loopback(lo) device is able to emulate the RDMA interface
> > > "rxe_lo", however when
> > > I tried(years ago) to do RDMA migration over this
> > > interface(rdma:127.0.0.1:3333) , it got something wrong.
> > > So i gave up enabling the RDMA migration qtest at that time.
> >
> > Thanks, Zhijian.
> >
> > I'm not sure adding an emu-link for rdma is doable for CI systems, thou=
gh.
> > Maybe someone more familiar with how CI works can chim in.
>
> Some people got dropped on the cc list for unknown reason, I'm adding the=
m
> back (Fabiano, Peter Maydell, Phil).  Let's make sure nobody is dropped b=
y
> accident.
>
> I'll try to summarize what is still missing, and I think these will be
> greatly helpful if we don't want to deprecate rdma migration:
>
>   1) Either a CI test covering at least the major RDMA paths, or at least
>      periodically tests for each QEMU release will be needed.
>
>   2) Some performance tests between modern RDMA and NIC devices are
>      welcomed.  The current knowledge is modern NIC can work similarly to
>      RDMA in performance, then it's debatable why we still maintain so mu=
ch
>      rdma specific code.
>
>   3) No need to be soild patchsets for this one, but some plan to improve
>      RDMA migration code so that it is not almost isolated from the rest
>      protocols.
>
>   4) Someone to look after this code for real.
>
> For 2) and 3) more info is here:
>
> https://lore.kernel.org/r/ZhWa0YeAb9ySVKD1@x1n
>
> Here 4) can be the most important as Markus pointed out.  We just didn't
> get there yet on the discussions, but maybe Markus is right that we shoul=
d
> talk that first.
>
> Thanks,
>
> --
> Peter Xu
>

