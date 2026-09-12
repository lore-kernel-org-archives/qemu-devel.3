Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2509C88E53
	for <qemu-devel@archiver.kernel.org>; Sat, 12 Sep 2026 15:10:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x5PML-00045x-Bl; Sat, 12 Sep 2026 11:09:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1x5PME-00045G-DF
 for qemu-devel@nongnu.org; Sat, 12 Sep 2026 11:09:35 -0400
Received: from mail-ed2-x10.google.com ([2a00:1450:4864:33::10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1x5PMB-0001lk-GV
 for qemu-devel@nongnu.org; Sat, 12 Sep 2026 11:09:33 -0400
Received: by mail-ed2-x10.google.com with SMTP id
 4fb4d7f45d1cf-6a60591ae45so1752453a12.2
 for <qemu-devel@nongnu.org>; Sat, 12 Sep 2026 08:09:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789225769; cv=none;
 d=google.com; s=arc-20260327;
 b=sv5She36XZ+3CdgU6glx+4lufCZ9RpIPxubVyvCVEODo8uwYo3n1Zh3VvOVBRrGvaL
 WhNEysO5jwm35k0V0paR72UgzUqOqHsUdTLbY+wkQaRbM2rhZwF6MUWX0fH6QsXWYPnL
 2LXfNs1vg8etuuRQgoe7i8DQw8fVqoFWKRUdi91O6YS1WF6ehQbHLl0vx72Tb879wR6x
 ksKWJiSPMuwSW92U8KW1x8OOeAJotI3ri2g2iLF9jyTdAEWGB3dYzu2KT/UOF1SaPnLj
 jSvXloMcrpJs/dFQV/Pdqyo4+z6tYfgASaxduv6r/508M/R6QUrlBMizoeAIwVTBU+q8
 2r3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=1iVWz9whZiWJOL8Q1JzdGuk9/4boRCvuNLaLIkeos+0=;
 fh=eFpQx5bTK/9y3qZWFnouRS4o+ULP32H2/VkiuQ9OOIs=;
 b=HRNCjLZN4LPfpDrZkwKFv1WxUETu/nCPkE/f1U3dhXY3pgmN/BCwEeiZgdv2JkVFFX
 oxW+4L1OXSwOonQavgwcifar7pVSwr9dFlRXBuDH0I8jpIKXJE7FNi4EIuvoQBkDBxIR
 MtFkQGHeJ7d9pJBuOc8z2Uy4BqByAzmO4ssKEnmapktchkmQbTbTBafeTEvO/i2Qiz4o
 +DBf+BlVwIyAR2mkJR+jxEVL/JTbDzZYKSHZC4aLy/ShJhC6/4+Pv/0xEVu8VDgEPdNc
 RHwto8oLDe0v8rcnIL3C1m70DfoiL1w/sXDdoEl8Yo6CeMNAK+TJGJsLHqc69LOcQfLf
 jeXw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1789225769; x=1789830569; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=1iVWz9whZiWJOL8Q1JzdGuk9/4boRCvuNLaLIkeos+0=;
 b=WOrqJoR1YjebEki12EyhksCU9djG1qAAD/5lgDPSqdbq9jlVRRiws+5OhWmUuTGI2s
 W1K2wPqzoYDnlfViaRQzUoN49Zr37AfSgzuXVykK8tgmQ2vDGmW57auflS92A5lYhlhQ
 u1bv1cjprfnYGm8y3RkdAHnJV82JqFsGV23ZVTyiFbL+qVILeRIWQrvUhcjaaKbSBDvX
 JToFIl60ir5dFMpn54VZzFzwG45S3+kCqhtmhkZ84Repj86EQf6wjfMUepATTAE5TQdJ
 9mAtAUzFwBlzeqXsGFPUqlt9hX8IUFke8yWhbrMYV56GCUEVcHLFQgKK5Xw+w71nfF8m
 YXlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789225769; x=1789830569;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=1iVWz9whZiWJOL8Q1JzdGuk9/4boRCvuNLaLIkeos+0=;
 b=d18djOEt4lllfPQuH+EB0RFdfwKiGuxJc5o5tPRD+9esfnD2HNHBN4UaiY02WVyqBk
 qNxLw0n/FWZ6EDfIzg1A/I2h6uVdDqK1zZbp69lCzeeSpH+pVP66DswYjFubizJ0nQC/
 4EcMEHMm6gGsdqXk0aIJPhOOOMram15M5o4WxHqH31XLmFmHQ/XKcVeXIaV9jyXrAS2a
 kT1hu1B4hl1mQFR9bdxmetkKkO7PJhBpeS5vUzG+kdqxGmsfub8iQp8YGpHDgp+nj6QG
 yCT22rVmd9r2BC6HALaYGHaVNtNnwJeCsk6wQcXzGktw1Kwao2VtfQBZDYnLbS55Id2J
 KYQQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBxU3zbgpRmvyzSV3nwhz44NGZLnMPsXwQStI0M/8xs6DvWPhrF5asYwHIRKmYdl7kVEoZK2rpVlFvEL@nongnu.org
X-Gm-Message-State: AFuF++l4uGac6VarKkBf+Pd8CBHw+IIG2y0IBW8OljBwlO7sx6oxZ/4x
 T01pMKRS0O9WR8bj8flQ/QlszzgcZxv5pwYyy2pMKmOLG/Cgc+v9KjkQvhnRRQcq7ti0eUl2bP2
 nXgTw6PazjotjF/8W8rmJNJORtn6m+gk=
X-Gm-Gg: AYBFou0EfC0AmmE2LaKiUm88JXiqD1vr22ls5eg2O0WCBgv4vC5HC4xKfwIalIHwkkw
 mDI3PxZv7xqNyZag3HWYvLnrU5tH+G2gODq4XITxAec5Fe8w/Y1xspaweUSd8iiBKDaroy/Xy9X
 ZU3ej3NPyzhX3b6XbUz+MnYcOh9OyxpgkSbvseNUb/TvQ9XKtir+1k0ZVf4ttVPxeZd50kNzRJr
 EeZTT4IOkIzcXZXQ0GLW+lAlEPrRr2wlH7kT5dBvMgeH15z/KYg+on+WReoZfgvEVHnjENSJmbK
 qAxgrc9FfcNBvnWmRg3uErcK+UQXcn+p6Izfu2pDEfhBF96jgf57EX+pSLPIYNLMt+eACZUSxqu
 IM3oZrHzr+UFc
X-Received: by 2002:a05:6402:a205:20b0:6a9:c0ec:417a with SMTP id
 4fb4d7f45d1cf-6a9c0ec45c0mr5353787a12.18.1789225768539; Sat, 12 Sep 2026
 08:09:28 -0700 (PDT)
MIME-Version: 1.0
References: <20260825154854.263819-1-stefanha@redhat.com>
 <83065cc3-e299-4b50-9a78-8f7b669daa85@tls.msk.ru>
In-Reply-To: <83065cc3-e299-4b50-9a78-8f7b669daa85@tls.msk.ru>
From: Stefan Hajnoczi <stefanha@gmail.com>
Date: Sat, 12 Sep 2026 11:09:15 -0400
X-Gm-Features: AcwNN1UCEliTJ-fxO2IvE2Qcr7njCLJMW9adQglIDKnX2rndI7xP7clpcdVBUHM
Message-ID: <CAJSP0QVYCG8sTyg6677NAknxT_Gs91zQgt07JkQNU23s7rsWMw@mail.gmail.com>
Subject: Re: [PATCH] virtio-scsi: set dataplane_started to false upon failure
To: Michael Tokarev <mjt@tls.msk.ru>
Cc: Stefan Hajnoczi <stefanha@redhat.com>, qemu-devel@nongnu.org,
 Fam Zheng <fam@euphon.net>, 
 Paolo Bonzini <pbonzini@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, 
 QEMU Stable <qemu-stable@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:33::10;
 envelope-from=stefanha@gmail.com; helo=mail-ed2-x10.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Sat, Sep 12, 2026 at 5:14=E2=80=AFAM Michael Tokarev <mjt@tls.msk.ru> wr=
ote:
>
> On 8/25/26 18:48, Stefan Hajnoczi wrote:
> > Commit e24a47c5b73e ("virtio-scsi: do not use vring in dataplane") set
> > dataplane_started to true when virtio_scsi_dataplane_start() fails. Thi=
s
> > is likely a typo since dataplane is not functional after failure.
> >
> > The non-ioeventfd fallback is broken because dataplane_started is true
> > after virtio_scsi_dataplane_start() failure. As a result, the following
> > assertion failure occurs when a virtio-scsi device exceeds the open fil=
e
> > descriptor ulimit when setting up notifiers (eventfds):
> >
> >    $ ulimit -n 104 # exact number can vary based on QEMU version
> >    $ qemu-system-x86_64 -M q35,accel=3Dkvm -m 1G -cpu host -smp 14 \
> >           --blockdev file,node-name=3Ddrive0,filename=3Dtest.img,cache.=
direct=3Don,aio=3Dnative \
> >           --blockdev file,node-name=3Ddrive1,filename=3Ddata01.img,cach=
e.direct=3Don,aio=3Dnative \
> >           --device virtio-scsi-pci,id=3Dvirtio-scsi-pci0 \
> >           --device scsi-hd,drive=3Ddrive0,bus=3Dvirtio-scsi-pci0.0 \
> >           --device virtio-scsi-pci,id=3Dvirtio-scsi-pci1 \
> >           --device scsi-hd,drive=3Ddrive1,bus=3Dvirtio-scsi-pci1.0
> >    qemu: virtio-scsi: Failed to set guest notifiers (-24), ensure -acce=
l kvm is set.
> >    qemu: virtio_bus_start_ioeventfd: failed. Fallback to userspace (slo=
wer).
> >    qemu-system-x86_64: ../hw/scsi/virtio-scsi.c:1017: virtio_scsi_reset=
: Assertion `!s->dataplane_started' failed.
> >    Aborted                    (core dumped)
> >
> > Cc: Paolo Bonzini <pbonzini@redhat.com>
> > Fixes: e24a47c5b73e ("virtio-scsi: do not use vring in dataplane")
> > Buglink: https://redhat.atlassian.net/browse/RHEL-193328
> > Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> I'm picking this one for currently active qemu stable series.
> Please let me know if I shouldn't.  Maybe it's a too specific
> bug but it's not good to throw assertion failures to the user.

Sounds good.

Stefan

