Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2679DCD5BBF
	for <qemu-devel@archiver.kernel.org>; Mon, 25 May 2026 07:48:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wRQ1m-0007LW-V2; Mon, 25 May 2026 03:47:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1wRQ1l-0007L6-3W
 for qemu-devel@nongnu.org; Mon, 25 May 2026 03:47:09 -0400
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1wRQ1i-0002WZ-Rj
 for qemu-devel@nongnu.org; Mon, 25 May 2026 03:47:08 -0400
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-45297094718so7219493f8f.3
 for <qemu-devel@nongnu.org>; Mon, 25 May 2026 00:47:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779695224; cv=none;
 d=google.com; s=arc-20240605;
 b=d3YUfzKOanlVs4rNFSeCKqt+ZGO7W8S0zNzTNsnE5+6wSzaN81n7dXtZBPtTAGWO9O
 DXqRXS5PfCi5mV8/22Ea41MxDl2OkfwLiDqUdooImzau1UFkA7E7ai4lVgzLNqeBBD7F
 sNsoh252XY401JU7pLSk0t2W6kpzSfrVo2nMa80YJpMZWteGEQ9fPBCbq4DTxQqQg+v0
 yaJDzVyJ+Jqlq/J28VujvIempAZxnTeyAtRV+/6DL+vj3GRTe6gHk6j7oxm5dfpjwH4c
 6UMoMhXEE4lSvzqWmTH9mmpAvDD8p3b3SuGkCt1cCv/LBEGEtl1tfui6BnJ31RwB8Jo4
 Yjiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=IYPTF5H9I6VRTp35b/XCzf3flG37iOJLAxoiyVJ+CVs=;
 fh=3ECvT/GZR4nX0YMg6413hD192/dipztT9e9SiY1bQiU=;
 b=SNyUVc2tgwAaFAV/mBfa5hE9Cv+7PiOnKgrmPCe1DX2yT7Siuf9ixxpdysB9/Fzdye
 p01t2QI/+0+C59MS3+6qPymHMkufDkMfWpCqprq/9M2NVy9M3AQdLN5R52QcqC91GFrT
 a3PR4lUOOz+BjjYAToO0jnfqZ426Yg6yXxct22NF8ek1Ahgi18qfhuumJGL4QdLmGTBt
 fgcOsoGfWTGpw4Tu38/uALCVszBcDsU8MxH6V1pInkKzSnmWl0rn+eDGdSgGtryTp9Ng
 nXrZlFPhsFsmynNjp7fQ/yKd79eoqlNAwHbva1xGYaQHEOfTjFYIebkMM6VQfJsZdeLb
 XSXg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779695224; x=1780300024; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=IYPTF5H9I6VRTp35b/XCzf3flG37iOJLAxoiyVJ+CVs=;
 b=sI2ot2Sh2W5Efs0YwpVOotTwdFJ110IfaemywScgmW0VEpcv71H2hPFfTMe8395U2k
 8AU6LY+DnjW3WkaOh4JbWL9DnAHLMKNdpOy84w5L11iix29kxyQHUjxUbuIJ1SJ6+GNR
 WgLmU9amw7FoqRuovmIvZqGXXS6HANTqPmtSgawEJNxi66e3X79u3xzRYNuWRwlUry39
 GyGG5xbvC4UVRu+qAgS78hZJ0Uc54AS3DjFVXqBuIe8h9HnrT4MZBsnpPhGpN9xXTzsW
 bC5ocCPh5kGB7BzKfOxrwOXGrZD3P62t2eyRsW8Dr+19VJv1gdK9Dd+hhrkc9haM7mMz
 f0mA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779695224; x=1780300024;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=IYPTF5H9I6VRTp35b/XCzf3flG37iOJLAxoiyVJ+CVs=;
 b=D/7bEM1CCUyQ9Dmfd555z3k58kTpZ+IffDuYc3mix2PyVCUu1Y+i+aP/Z1HWSD0BaD
 SF5N671gK9kDl11NHCv+v5NlZsfiyKYUjALwDw0bY++tEP4/5f23ogl/kTQGBH3gqj4S
 T90J1/00wMIVgyRi51L84pdTy17xAoOC+QY/sBAFusr7J1lpl2EwMOfaU2q1MYlkeebp
 iowLZSIg+1gnfttIhOmAgQbgzHpKLrwDTOo8/yzPl2+xokY1qw+vo2hjAHZ6tguTGX+9
 XznK1y3to+RhyvIXqmbcIlvsF15gKtnV2Hji0uTWssEscKb/aMMc1KVnz6c2jAFoVNZl
 0j4g==
X-Forwarded-Encrypted: i=1;
 AFNElJ/l/n8/jrCRSDn2XQCqZCC1btyHirVWLN66810/4uINRMnWN7r+PZZSz+DLrg7bpUxJfdrG5z405dKY@nongnu.org
X-Gm-Message-State: AOJu0Yy7pwvlA1vvsy2T6HqLBM0Z2P+ilAgavZg2Djse/oZ1obkW/3eH
 LsAOD7gZL1wV/3pYl3Rs+5fB4Hma02sb9vUhW2oZIb3NQWnHg9UFNs59Hre32fvL2aYr72bPrHm
 xijOLNEQYKuKOe2KAKyuf5gWfMH0PyqGM8o65RNTXNA==
X-Gm-Gg: Acq92OH/oDOIbF94bnVy3q2Ox8Sh0QVpU256UsrFJsdww2prycd6JMDm0+jNRlMooew
 1Az0rVx+Pe1wELhTEunm6FMrgAIoFhHzFZDSV/nG1/ex2LgwwAuRXT+Pefms/HW6Ly3HBfqv3r6
 9im1aD3tYrVpDoVkKlWZmiz+3Uj3/EaSJpKTWWo6cF77PjbrNbMXHPb3glnhr7v6HZpXTYJA0O5
 Z0QKPAMn+t2IuvgD+TJGJUlj3B/m93r41w+C6H5d65MFA4dsDtDauz7ZGg27u72cnS6+rhvZ/d8
 lEfcwLcsD/zm4vkAjJI9f9eO5XgZ0zPVDQPjTuHYiBjHX8aNXRK8wDPZZMLw
X-Received: by 2002:a05:6000:2383:b0:43c:4810:dc4a with SMTP id
 ffacd0b85a97d-45eb38c924amr23448366f8f.38.1779695224376; Mon, 25 May 2026
 00:47:04 -0700 (PDT)
MIME-Version: 1.0
References: <875x4fmzcv.fsf@draig.linaro.org>
 <96181e0d-4c75-430a-9b80-9d8d0eabcce7@gmail.com>
In-Reply-To: <96181e0d-4c75-430a-9b80-9d8d0eabcce7@gmail.com>
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Date: Mon, 25 May 2026 10:46:38 +0300
X-Gm-Features: AVHnY4IyJ0SdHNufC3rLj6_Xl9MAuSQ2qWxLp2b1yUikjqZ_1oRpIhV35dIXFoY
Message-ID: <CAAjaMXbFhtiHgiUwmJFXti25+vXRebjtaD6fFD+GkOHsDny=Bg@mail.gmail.com>
Subject: Re: KVM/QEMU community call @ 26/05/2026 agenda items?
To: Demi Marie Obenour <demiobenour@gmail.com>
Cc: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 Albert Esteve <aesteve@redhat.com>, Alberto Faria <afaria@redhat.com>, 
 Alessandro Di Federico <ale@rev.ng>,
 Alistair Francis <alistair.francis@wdc.com>, Anton Johansson <anjo@rev.ng>, 
 Markus Armbruster <armbru@redhat.com>, Brian Cain <bcain@quicinc.com>, 
 "Daniel P. Berrange" <berrange@redhat.com>,
 Chao Peng <chao.p.peng@linux.intel.com>, cjia@nvidia.com, 
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>, cw@f00f.org, 
 dhedde@kalrayinc.com, Eric Blake <eblake@redhat.com>, eblot@rivosinc.com, 
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Eduardo Habkost <eduardo@habkost.net>, 
 Elena Ufimtseva <elena.ufimtseva@oracle.com>,
 Auger Eric <eric.auger@redhat.com>, felipe@nutanix.com, 
 helge.deller@googlemail.com, Alyssa Ross <hi@alyssa.is>, iggy@theiggy.com, 
 Warner Losh <imp@bsdimp.com>, jacob.oursland@gmail.com,
 Jan Kiszka <jan.kiszka@web.de>, 
 Jason Gunthorpe <jgg@nvidia.com>, jidong.xiao@gmail.com,
 Jim Shu <jim.shu@sifive.com>, Joao Martins <joao.m.martins@oracle.com>,
 Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, 
 Luc Michel <luc@lmichel.fr>,
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>, 
 matthieu@minio.io, Max Chou <max.chou@sifive.com>, 
 Mark Burton <mburton@qti.qualcomm.com>, "Ho, Nelson" <nelson.ho@windriver.com>,
 Paul Walmsley <paul.walmsley@sifive.com>, Paolo Bonzini <pbonzini@redhat.com>, 
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Phil_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 QEMU Developers <qemu-devel@nongnu.org>, Roberto Campesato <rbc@meta.com>, 
 Richard Henderson <richard.henderson@linaro.org>, 
 Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>,
 Bernhard Beschow <shentey@gmail.com>, 
 Stefan Hajnoczi <stefanha@gmail.com>, Thomas Huth <thuth@redhat.com>,
 Wei Wang <wei.w.wang@intel.com>, 
 z.huo@139.com, LIU Zhiwei <zhiwei_liu@linux.alibaba.com>, zwu.kernel@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::434;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-wr1-x434.google.com
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

On Mon, May 25, 2026 at 5:03=E2=80=AFAM Demi Marie Obenour
<demiobenour@gmail.com> wrote:
>
> On 5/22/26 07:56, Alex Benn=C3=A9e wrote:
> >
> > Hi,
> >
> > The KVM/QEMU community call is at:
> >
> > https://meet.jit.si/kvmcallmeeting
> > @
> > 26/05/2026 14:00 UTC
> >
> > Are there any agenda items for the sync-up?
>
> I have (at least) six.  Four are related to the vhost-user spec,
> one is related to the current vhost-user implementation in QEMU,
> and one is related to MSI-X interrupts in the virtio PCI transport.
>
> I'm not sure if these are better discussed offline, but:

IMHO these are all mailing list topics, vhost-user maintainers might
not be in the community call anyway.

I suggest sending patches (like you've already done) whenever it makes
sense, and please try not to flood the zone.

>
> The first is whether vhost-user memory regions
> are guaranteed to not overlap.  I sent a patch in
> https://lore.kernel.org/qemu-devel/20260522-vhost-user-dev-v1-1-b31646cf1=
9b8@gmail.com
> to guarantee this is not the case.  However, this is technically a
> breaking spec change.  The virtio vhost-user device I'm working on
> requires this.
>
> The second is when the backend needs to remove memory regions removed
> by VHOST_USER_REM_MEM_REG.  This could matter for Xen grant mapping.
> Does it need to happen before the backend replies?
>
> The third is whether a vhost-user backend can assume that the frontend
> will always provide an eventfd where the protocol calls for one,
> instead of falling back to pipe2() or pipe().  The virtio-vhost-user
> device I am working on acts as a vhost-user backend and does not
> support this.
>
> The fourth is whether a virtio-PCI device specification can assume
> that there are a large number of MSI-X interrupts available.
> My understanding is that a vhost-user device can have up to 256
> virtqueues.  If so, the version of the virtio-vhost user device
> I am currently working on will require a device to offer 263 MSI-X
> interrupts.
>
> This is a workaround for a limitation of Cloud Hypervisor: it can't
> handle changing irqfd to MSI-X mappings once the device has started.
> This is already a bug, but I didn't want to add yet another feature
> that Cloud Hypervisor didn't implement properly.
>
> The fifth is the importance of the features I'm planning on leaving
> out at first:
>
> 1. VHOST_USER_PROTOCOL_F_PAGEFAULT
> 2. VHOST_USER_PROTOCOL_F_HOST_NOTIFIER
>
> VHOST_USER_PROTOCOL_F_PAGEFAULT is needed for post-copy live migration.
> However, it requires the backend to provide the frontend with a
> userfaultfd, which it could use to stall backend memory accesses
> indefinitely.  This is an easy frontend to backend denial of service.
> Furthermore, unless async page faults are supported, it is an
> easy backend *kernel* denial of service.
>
> VHOST_USER_PROTOCOL_F_HOST_NOTIFIER requires the driver to somehow
> tell the frontend what memory to use.  Furthermore, I'm not sure if
> it can prevent the frontend from mapping too much of it.
>
> The sixth is if references to "QEMU" should be replaced by a more
> generic term.  QEMU is not the only vhost-user implementation nowadays,
> and there may be implementations that support features QEMU does not.
> In fact, I believe that this is going to happen in the near term,
> for vhost-user-GPU blob object support.  Alyssa Ross has implemented
> this in Cloud Hypervisor, but I don't think QEMU supports it.
> --
> Sincerely,
> Demi Marie Obenour (she/her/hers)

