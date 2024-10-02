Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC695CF31B7
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Oct 2024 12:12:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1svyCW-0003j3-PR; Wed, 02 Oct 2024 08:11:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1svyCU-0003im-1S
 for qemu-devel@nongnu.org; Wed, 02 Oct 2024 08:11:26 -0400
Received: from mail-ed1-x52b.google.com ([2a00:1450:4864:20::52b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1svyCS-00053M-3j
 for qemu-devel@nongnu.org; Wed, 02 Oct 2024 08:11:25 -0400
Received: by mail-ed1-x52b.google.com with SMTP id
 4fb4d7f45d1cf-5c89668464cso4681878a12.1
 for <qemu-devel@nongnu.org>; Wed, 02 Oct 2024 05:11:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1727871082; x=1728475882; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7n5pj8j1hX3CXtg/aVHhmUbsHDv+jfAUcllp9MYePvU=;
 b=u0s7l9WcWNhdON9f//r/jrDbyb0kGodczrFAGytRVwoCopon9TWJ7ZJWNRpx7mSyIA
 PKD4H0Km0k+6gF9nqgPDVgPFCzNnNmexPSw3LlH7uxKIUD5jELrhF09nO5OYidSdxwCu
 5Vj56UUKGMNyDn1pWz9kWnpSBzi8UdfaeFn5bDC3SVSMqcy/jkl9es+rXXj1AeoubAH5
 iFub9GjJt/ID/+VYRNIW/p/4LEYRn/7XG6SMeWJqfzi5/fspOMknttM+R8Qn3QB9QpDL
 eEoASfbIsPQwx1+OkCDp51EWUhbTpNPI0sOVXgmghtzHpSTB37eiaoV4MKS9YnvxAom/
 VCvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727871082; x=1728475882;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=7n5pj8j1hX3CXtg/aVHhmUbsHDv+jfAUcllp9MYePvU=;
 b=JmX7DXRsQ8HJe8UlX1tcSJ9shz2kc86Ix62A1PefgTl+3sBM/JXDez0hyzTlsLUASJ
 gHoMhYKEKFENYIuL5K7OtL0ck8zgU9B118EWyBER+nuKA+/+idl2BK6xi+BPIxGaR6nq
 72P7/HChF7qGtyjKx3UkSEKIfYtA5zsOsKTNhdtBqYpB0VUZGSq7yI4h07laGPnfNnEb
 mU2GXEfsH77wvhjF4hSKDprhu682tMJFjYoqrI3ByLdAiBibkqYQTUoIMICbAR/0zcka
 8hN37lxiRvXCXGIp7xENyJQvVsICaVs8MQcpJhCfAMAeJh+FzmBvXh/RbLYRhL9WrHb8
 ijVg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUw5pBYHm71XX4rFXg0jH+RTaD2Hn8TzpxKBzKO16/mqP0BYB9pesLrZct7lN74/07LkxN1uGKKgkzb@nongnu.org
X-Gm-Message-State: AOJu0Yxh2PFnu8dw9lzVTqtGXCzYJ5GnZ+FUjwMjHGzac4aNkB1XRWGA
 Y3cdK0gHPkWGEGaVNv+dZyw9C3IQKQsGSBnfvdCVnWBw6eIxZ1ZPeCMrOdsoqVR/lL0QJBakNjr
 n7scvUuVY6ejnSlVw8dc2ma58Kbm+MIbHQp2skA==
X-Google-Smtp-Source: AGHT+IHEpFoI3dZz2PMChIqo2a1rcbMBCAGprQ6wkinb6Kx7uf1Ag79meqRAHpkyKa4uUe+At2EQu9bNOLgE1tN8PfQ=
X-Received: by 2002:a05:6402:27d2:b0:5c8:9515:cc6 with SMTP id
 4fb4d7f45d1cf-5c8b1925b82mr1776817a12.12.1727871081994; Wed, 02 Oct 2024
 05:11:21 -0700 (PDT)
MIME-Version: 1.0
References: <20241002083646.2893078-1-marcandre.lureau@redhat.com>
 <b5c138db-2632-4ae4-bb65-afaf20aa89b9@redhat.com>
 <CAJ+F1CKbMQ8drnyur5puC63OP8e3WT+ASmoazOL2-OoC+zfQ6g@mail.gmail.com>
In-Reply-To: <CAJ+F1CKbMQ8drnyur5puC63OP8e3WT+ASmoazOL2-OoC+zfQ6g@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 2 Oct 2024 13:11:11 +0100
Message-ID: <CAFEAcA-126RPg+6JTAkL5NHYRwNKwo3AoKg07m8-jWy90mPNjA@mail.gmail.com>
Subject: Re: [PULL 00/22] -Werror=maybe-uninitialized fixes
To: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Cc: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::52b;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x52b.google.com
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

On Wed, 2 Oct 2024 at 09:45, Marc-Andr=C3=A9 Lureau
<marcandre.lureau@gmail.com> wrote:
>
> Hi
>
> On Wed, Oct 2, 2024 at 12:43=E2=80=AFPM Thomas Huth <thuth@redhat.com> wr=
ote:
>>
>> On 02/10/2024 10.36, marcandre.lureau@redhat.com wrote:
>> > From: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
>> >
>> > The following changes since commit 718780d20470c66a3a36d036b29148d5809=
dc855:
>> >
>> >    Merge tag 'pull-nvme-20241001' of https://gitlab.com/birkelund/qemu=
 into staging (2024-10-01 11:34:07 +0100)
>> >
>> > are available in the Git repository at:
>> >
>> >    https://gitlab.com/marcandre.lureau/qemu.git tags/warn-pull-request
>> >
>> > for you to fetch changes up to baad82ecfb27474f17f4318502725622ab7170f=
c:
>> >
>> >    qom/object: fix -Werror=3Dmaybe-uninitialized (2024-10-02 11:36:12 =
+0400)
>> >
>> > ----------------------------------------------------------------
>> > -Werror=3Dmaybe-uninitialized fixes
>> >
>> > ----------------------------------------------------------------
>> >
>> > Marc-Andr=C3=A9 Lureau (22):
>> >    util/coroutine: fix -Werror=3Dmaybe-uninitialized false-positive
>> >    util/timer: fix -Werror=3Dmaybe-uninitialized false-positive
>> >    hw/qxl: fix -Werror=3Dmaybe-uninitialized false-positives
>> >    nbd: fix -Werror=3Dmaybe-uninitialized false-positive
>> >    block/mirror: fix -Werror=3Dmaybe-uninitialized false-positive
>> >    block/mirror: fix -Werror=3Dmaybe-uninitialized false-positive
>> >    block/stream: fix -Werror=3Dmaybe-uninitialized false-positives
>> >    hw/ahci: fix -Werror=3Dmaybe-uninitialized false-positive
>> >    hw/vhost-scsi: fix -Werror=3Dmaybe-uninitialized
>> >    hw/sdhci: fix -Werror=3Dmaybe-uninitialized false-positive
>> >    block/block-copy: fix -Werror=3Dmaybe-uninitialized false-positive
>> >    migration: fix -Werror=3Dmaybe-uninitialized false-positives
>> >    hw/virtio-blk: fix -Werror=3Dmaybe-uninitialized false-positive
>> >    migration: fix -Werror=3Dmaybe-uninitialized false-positive
>> >    linux-user/hppa: fix -Werror=3Dmaybe-uninitialized false-positive
>> >    target/loongarch: fix -Werror=3Dmaybe-uninitialized false-positive
>> >    tests: fix -Werror=3Dmaybe-uninitialized false-positive
>> >    hw/virtio: fix -Werror=3Dmaybe-uninitialized
>> >    hw/virtio: freeing leaked memory from vhost_svq_get_buf in
>> >      vhost_svq_poll
>> >    block: fix -Werror=3Dmaybe-uninitialized false-positive
>> >    fsdep/9p: fix -Werror=3Dmaybe-uninitialized false-positive
>> >    qom/object: fix -Werror=3Dmaybe-uninitialized
>> >
>> >   block/block-copy.c                 |  2 +-
>> >   block/file-posix.c                 |  2 +-
>> >   block/mirror.c                     |  8 ++++----
>> >   block/stream.c                     |  6 +++---
>> >   fsdev/9p-iov-marshal.c             | 15 ++++++++++++---
>> >   hw/block/virtio-blk.c              |  2 +-
>> >   hw/display/qxl.c                   |  4 ++--
>> >   hw/ide/ahci.c                      |  3 ++-
>> >   hw/scsi/vhost-scsi.c               |  2 +-
>> >   hw/sd/sdhci.c                      |  2 +-
>> >   hw/virtio/vhost-shadow-virtqueue.c |  6 ++++--
>> >   linux-user/hppa/cpu_loop.c         |  2 ++
>> >   migration/dirtyrate.c              |  4 ++--
>> >   migration/migration.c              |  2 +-
>> >   migration/ram.c                    |  2 +-
>> >   nbd/client-connection.c            |  2 +-
>> >   qom/object.c                       |  2 +-
>> >   target/loongarch/gdbstub.c         | 26 ++++++++++++++------------
>> >   tests/unit/test-bdrv-drain.c       |  2 +-
>> >   tests/unit/test-block-iothread.c   |  2 +-
>> >   util/qemu-coroutine.c              |  2 +-
>> >   util/qemu-timer.c                  |  6 +++---
>> >   roms/openbios                      |  2 +-
>>
>> Replying here as well, so that Peter has a chance to see it:
>>
>> The update to roms/openbios in patch 03 seems to have slipped in by
>> accident, so I'd suggest to fix that first before merging this.
>>
>
> \o/ submodules :)
>
> Peter, do you want a v2?
> thanks

Yes, you'll need to resend the pullreq. (You can send just
the cover letter for a trivial tweak like this.)

-- PMM

