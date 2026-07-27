Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1FECFC5321C
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jul 2026 09:07:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1woHHr-0003WJ-Eu; Mon, 27 Jul 2026 05:06:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1woHHB-0003R9-Td
 for qemu-devel@nongnu.org; Mon, 27 Jul 2026 05:05:44 -0400
Received: from mail-pl1-x634.google.com ([2607:f8b0:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1woHHA-0008OQ-1K
 for qemu-devel@nongnu.org; Mon, 27 Jul 2026 05:05:33 -0400
Received: by mail-pl1-x634.google.com with SMTP id
 d9443c01a7336-2ceaf8a1265so29232505ad.2
 for <qemu-devel@nongnu.org>; Mon, 27 Jul 2026 02:05:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785143130; cv=none;
 d=google.com; s=arc-20260327;
 b=XuVeFDa9BULlGRMRsI1BBUKuURBOgw2cm5cG825ejBLg6sRBVYBazflF54vl2veo0c
 M+h7/CNBYUTOvi2OzSD2+l9N/CDvqK+qhDbpKI9Rxu/fYyDVLt0vl6DjnOKA1XB17qMz
 xO84+ExVZUQVjYGfvPSJ3jFeabKIsEbFavTMzgPe2pS/WvuOeVZscbSmoiz9BpOeLh7/
 81IyeICXuRp4/tDCd81FDNXVebNjev5cIgaNppjsajZQqZPW/cj/HQE+Wuz528kk7wlH
 mGdEHvq25NkIowzKs1dSlaId7faQhsQ9M9KYViUOKd04xNolnx1tiLd6kVams2oQtxUJ
 +3ww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=7vT+xOlLjYuwkWGIEf2srARPM9q5qEwRRnN1rquqV+0=;
 fh=NslLSXajYw6/fhaduPFA3iYcwKcIqwkl+hWoUZd07+o=;
 b=rtuBj1cmdCdOARx+82PxopN0OltexqB1CLcEQ6rIvGDp/afhyzNWiRz5udXlXWhVJb
 Gnmj3oEDe/l6XG//Xy6+zklxwtw1i7plcaYRIgLyUedWNo6x084l0ViT0cODEbwEyyvj
 PvBQOYdss9PMx+uXcy4imY30rXyz+jL40pIiwbYFCt19dQ0NZp9ecxW21vIrbVl6AZjj
 eVEsmuXmyrbHyCEx1/fT2OuNfLdJ0WCDDREWV6eBE0qYlKiOb34R81kcjfouc13KhMDU
 xTqQU8EuhSSQcfXGTxRw45UbhLZgtZFWJRc0+PaApBOjmWhdEyW7Y3OvDGFJgoyt+OBU
 QvCg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1785143130; x=1785747930; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=7vT+xOlLjYuwkWGIEf2srARPM9q5qEwRRnN1rquqV+0=;
 b=YE48oXTMgcw/Zg7HoKCy7COQwQ+6jR1VNe8OHe1CUslFrVROBMZxc02ECp0LEiXlhz
 AR9ewpBxv6ZdhGkfKHu/WoN2fnJhfInvIaEAF8CBJPztqR2+5bzV3ow9F9rFE+u0n69Z
 C/xRjwnFQHCHVOYkoHLv4edZWJmQnuIjcWkpKbJt7qSPSa62X3Bqr2sEMP1ki6Wbabre
 UkbqgzK75wUDzvtpJpzVbOyjUoDhSlofkq40A7cwISKip944Jk/lEI0E/+cqJxYkz5FF
 BOXca1RUamweOQvvh22X5arzP0CRYm3sngFcP8lCyNN38isBkGqHzMl83TEFMISsQc8r
 Ssug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785143130; x=1785747930;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=7vT+xOlLjYuwkWGIEf2srARPM9q5qEwRRnN1rquqV+0=;
 b=It0ow4xOeHiSq0kSHdfeRAUM4lGZUqOBEP8Pzj65RH9LEN105LpFPoHUXz29bDLwlF
 nxwqppxJYa13+h5/G2/gpQXcXZEidd969S3412LB3dDJeTO9ZBVBsU3U75OC3Lb8nE/4
 hnmXyO0mZfwJs70HrbUO4PE/ry7dpjc4ZC1OtvtIHVdAjbFiBNPlFiC/5n3kKMs4q5uv
 GkB7Z2OX+piMGvLKrAggB0YRE+HD7CO4BrAd0+joKezdyGy94NQKiw4JWe03EoQApJbz
 E/6coKttNZN5oATYo15c6XMZBPguIv+TPnuLeUCI0MXKeA6X7MvO36eA0B0C4jnze1OH
 59nA==
X-Gm-Message-State: AOJu0Yy9TzqAVJJlT76JD8qOg+kdaACL6nUt/B8JBE+XLTBgEykubvlw
 MnIqSVyf1jEn5eaAbIJ5bLTMRgjflhsdqVCflh858HsQRoV0wSoalTQEiBSvldugLcnbq6QRiYF
 MAB5HZWSf+rFd9+N3bNyLf2fwYS48/ZM=
X-Gm-Gg: AR+sD13kEDNBjjemXhkLHv2mOg9bjx3W7CsKoeA5brt7y6Chdj7JQPooQHiqqffih0Q
 l9ZxOVMnUhHAq+A+PS/8d+o/jq6ar8af8xol1ZjbEOtD7BcsfGgrMUWgwOQZ5/Of0QcvjPL5Er1
 HHx4yid5qmcd6pFkA8qrmtmrOvY68qcasq4PMzk3Ehp3RzU72UG2ia/34QWrKaWDsbmOvJwqgjO
 NgZQttgYAqzYoD62/1EJ5b/rPfyYQ6KjDnrHPBcY2B+sqhF8k56ysYv5ez1LItra+2jj+SVktse
 BKDxs3PuOvo3l1u9Y1g9VG7/fgvV
X-Received: by 2002:a17:903:244c:b0:2cf:477f:57c5 with SMTP id
 d9443c01a7336-2cfde67c4d2mr72292055ad.1.1785143130072; Mon, 27 Jul 2026
 02:05:30 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1785101237.git.mst@redhat.com>
 <20260727045453-mutt-send-email-mst@kernel.org>
In-Reply-To: <20260727045453-mutt-send-email-mst@kernel.org>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Mon, 27 Jul 2026 13:05:17 +0400
X-Gm-Features: AUfX_mw1T7FhwsFMiN8KLqj46jPoaY1tU294MB7_jTJKEnzJMsZ8cL_fsAF4evs
Message-ID: <CAJ+F1C+MR4J5Unu5xOXPO+Kj5V5XC8pVOA-WzqqBO3bW4mvrJQ@mail.gmail.com>
Subject: Re: [PULL 00/30] pci, vhost, virtio, iommu: bugfixes
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::634;
 envelope-from=marcandre.lureau@gmail.com; helo=mail-pl1-x634.google.com
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

Hi Michael

On Mon, Jul 27, 2026 at 12:57=E2=80=AFPM Michael S. Tsirkin <mst@redhat.com=
> wrote:
>
> On Sun, Jul 26, 2026 at 05:29:01PM -0400, Michael S. Tsirkin wrote:
> > The following changes since commit cbd42e2b75b23953a9bdb073c8531518b1bd=
6163:
> >
> >   Update version for v11.1.0-rc1 release (2026-07-21 13:18:25 -0400)
> >
> > are available in the Git repository at:
> >
> >   https://git.kernel.org/pub/scm/virt/kvm/mst/qemu.git tags/for_upstrea=
m
> >
> > for you to fetch changes up to 13342b9c4104f3bf93c2e52e7de4b383971d7bd6=
:
>
>
> moved to f2fe2afd27ddf93b49a16a29e8224d16b9888953 now:
> I dropped
>        vmstate: fix type confusion in vmstate_size() for VMSTATE_VBUFFER_=
UINT64
> will go in through the migration tree.
>

Some of the commits have duplicate Signed-off lines. It's also strange
to be both the Author and Reviewed-by (and some did not receive
external review)

I guess we could teach checkpatch about those quirks

> >   backends/rng: cap request size to avoid oversized allocation (2026-07=
-26 17:26:41 -0400)
> >
> > ----------------------------------------------------------------
> > pci, vhost, virtio, iommu: bugfixes
> >
> > Fixes all over the place, including a bunch of CVE fixes.
> >
> > Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> >
> > ----------------------------------------------------------------
> > Cl=C3=A9ment MATHIEU--DRIF (1):
> >       intel_iommu: Check address mask before using it in pasid-based io=
tlb invalidation
> >
> > GuoHan Zhao (1):
> >       hw/virtio/vdpa-dev: pass set_config buffer to vhost backend
> >
> > Haotian Jiang (1):
> >       hw/cxl: fix OOB access in cxl_doe_cdat_rsp via entry_handle
> >
> > Laurent Vivier (4):
> >       hw/virtio: reject zero-length packed indirect descriptor table
> >       hw/net/virtio-net: Protect from DMA re-entrancy bugs
> >       hw/virtio-rng: Fix host use-after-free (CVE-2026-50624)
> >       backends/rng: cap request size to avoid oversized allocation
> >
> > Manos Pitsidianakis (2):
> >       virtio-snd: check rx buffer descriptor size
> >       virtio-snd: check for overflow before g_malloc0
> >
> > Michael S. Tsirkin (18):
> >       virtio: use masked features with set_features_ex
> >       virtio-net: fix OOB read in RSC receive path
> >       virtio-net: fix short frame OOB read in receive_filter()
> >       libvhost-user: protect against OOB writes in vu_set_inflight_fd
> >       libvhost-user: protect against OOB vring queue access
> >       vhost: do not crash on ring map failure
> >       virtio-scsi: fix SCSIRequest leak on a bad request
> >       virtio-mmio: fix QUEUE_NUM_MAX
> >       virtio: fix queue size validation against allocated maximum
> >       virtio: stop migrating num_default, validate vring.num on load
> >       virtio: fail early on bad config_len in migration
> >       vhost-user: assert nregions within limit
> >       virtio-pmem: wait for flush requests on unrealize
> >       libvhost-user: validate last_batch_head in vu_check_queue_infligh=
ts
> >       libvhost-user: fix heap overflow in vu_check_queue_inflights
> >       vmstate: fix type confusion in vmstate_size() for VMSTATE_VBUFFER=
_UINT64
> >       libvduse: validate vq size
> >       virtio-iommu: fix OOM due to unbounded call_rcu
> >
> > Peter Maydell (3):
> >       hw/pci-host/q35.c: Always initialize smram-region even if SMM dis=
abled
> >       hw/pci-host/q35.c: Factor out creation of SMRAM MRs
> >       hw/pci-host/q35.c: Avoid early return in mch_write_config()
> >
> >  include/hw/scsi/scsi.h                    |   1 +
> >  include/hw/virtio/virtio-bus.h            |   1 +
> >  include/hw/virtio/virtio-iommu.h          |   1 +
> >  include/hw/virtio/virtio-mmio.h           |   1 +
> >  include/hw/virtio/virtio-pmem.h           |   1 +
> >  include/migration/vmstate.h               |   5 +-
> >  include/system/rng.h                      |  14 ++++
> >  backends/rng.c                            |  21 +++++-
> >  hw/audio/virtio-snd.c                     |  24 +++++--
> >  hw/core/machine.c                         |   1 +
> >  hw/i386/intel_iommu.c                     |   9 +++
> >  hw/mem/cxl_type3.c                        |   3 +
> >  hw/net/virtio-net.c                       |  25 ++++++-
> >  hw/pci-bridge/cxl_upstream.c              |   3 +
> >  hw/pci-host/q35.c                         | 110 ++++++++++++++++------=
--------
> >  hw/scsi/scsi-bus.c                        |   7 ++
> >  hw/scsi/virtio-scsi.c                     |   2 +
> >  hw/virtio/vdpa-dev.c                      |   2 +-
> >  hw/virtio/vhost-user.c                    |   3 +
> >  hw/virtio/vhost.c                         |   5 +-
> >  hw/virtio/virtio-iommu.c                  |  29 ++++++++
> >  hw/virtio/virtio-mmio.c                   |   7 +-
> >  hw/virtio/virtio-pmem.c                   |  17 ++++-
> >  hw/virtio/virtio-rng.c                    |   2 +
> >  hw/virtio/virtio.c                        |  43 ++++++++----
> >  migration/vmstate.c                       |  31 ++++++++-
> >  subprojects/libvduse/libvduse.c           |   5 ++
> >  subprojects/libvhost-user/libvhost-user.c |  61 ++++++++++++++++-
> >  28 files changed, 345 insertions(+), 89 deletions(-)
> >
>
>


--=20
Marc-Andr=C3=A9 Lureau

