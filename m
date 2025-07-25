Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 421BBC83F26
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Jul 2025 09:26:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ufEgA-0008JD-Az; Fri, 25 Jul 2025 05:25:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <leiyang@redhat.com>)
 id 1ufEg6-0008GI-Tn
 for qemu-devel@nongnu.org; Fri, 25 Jul 2025 05:25:24 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <leiyang@redhat.com>)
 id 1ufEg3-0002Ap-Rn
 for qemu-devel@nongnu.org; Fri, 25 Jul 2025 05:25:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1753435518;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=NRkxf0Co3kE3u/wpZULXKwkvWTQBZftXMbsqImP+Q3I=;
 b=QQJtfeQdGhmw0FjrHhQmjcGTGmY5g+oSPyNNq7uPaRsbNChYG80WKuZ7L5ePEF+6r/cxAP
 y2H3qM8cNXcvao32RWeavMyb15H1dtf6VgJ0K513sqS37o6hLq7cAyVXpj9dqUkPB/IiDJ
 V2nhT4TlPx0SBTsS4n84SPinP9MBPpo=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-695-aeV_j7ZcOGCiG-XmZU0JYA-1; Fri, 25 Jul 2025 05:25:16 -0400
X-MC-Unique: aeV_j7ZcOGCiG-XmZU0JYA-1
X-Mimecast-MFC-AGG-ID: aeV_j7ZcOGCiG-XmZU0JYA_1753435515
Received: by mail-ej1-f71.google.com with SMTP id
 a640c23a62f3a-ae401eba66aso126077266b.3
 for <qemu-devel@nongnu.org>; Fri, 25 Jul 2025 02:25:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753435515; x=1754040315;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=NRkxf0Co3kE3u/wpZULXKwkvWTQBZftXMbsqImP+Q3I=;
 b=o2eZneqpZMKhZgYEnzlAEuxcAuSSzPsVp0xIHtF93EhGHW0Mn8Ys1DGDg1u2laQOGQ
 W7XYUUTjWU2S8N6bAb6NSykvlxM553Vsh1DiTXmgSyGY8CPsxQGIZNiUIK+adgWXH7sS
 77tLGrMGPls37ahKfx5QSAq5Im2RA2GFHzhPqUNalFOoetzxcnaet/wm7DI7CNmj9CaD
 MfU29F+mjazlHDOJWmiiFR9bxXLuPkrqd97hYaWL8hI5tkMWGbKsj9PVWn/727Rc1ogT
 +IcalmuiMcpN6TTqa8l+TH3u76Cn+NRg39/6D+8RE0XEjBaMOM+rIfgdjcUUO5pGgg7A
 GfoQ==
X-Gm-Message-State: AOJu0YyuRuMyESMaDFGE6nIGe3havbP4lTcK1nal+8H4DMtEBVx5VYDb
 2BFuCURL3MVxvildVnGJ8gqyN5YhVWtokquZ54qLIh04gest6Gzw9X+kEeRw+ICMpJu47cxygSh
 52/dX8P+Jk0NmvD+668ze5i+7rasZfZOu7OXyYucJWy1Y3puUXGeIQ5VwjQWYiQAV10MguFqph3
 JlSBFF+dtFJ5oFidD8saAlFUISWQX7qZw=
X-Gm-Gg: ASbGnctufol0ba+pO13uuFdR4p4uyZMVNn/aDXUYlEl1oYOpoXtzleWUYMH65GDBAKP
 SYqqyrgEE4CDfyb/8bOnovX4zIRQjezetBxMDCFlwEacFALywQHgc4mph2tL4JurXEx06unDoWW
 Hl6ZcdNhaaIz9rqk8DoclfbA==
X-Received: by 2002:a17:907:a088:b0:ae6:d94f:4326 with SMTP id
 a640c23a62f3a-af61e922340mr180660666b.57.1753435515220; 
 Fri, 25 Jul 2025 02:25:15 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEUjdFwywN1/0Zo0IMG8xLmYMMhI7inplJ7T1c/JwRCgnv1I4L0cxrd0BUl7BiSiAyyNtKsauPo8dpMuVyeSFw=
X-Received: by 2002:a17:907:a088:b0:ae6:d94f:4326 with SMTP id
 a640c23a62f3a-af61e922340mr180656566b.57.1753435514805; Fri, 25 Jul 2025
 02:25:14 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1753297661.git.pabeni@redhat.com>
In-Reply-To: <cover.1753297661.git.pabeni@redhat.com>
From: Lei Yang <leiyang@redhat.com>
Date: Fri, 25 Jul 2025 17:24:37 +0800
X-Gm-Features: Ac12FXwet-qMRB90hWKFN5OEtYP4Bm8PCWfwVSb7olzrhLWFwV56Yo1M3Nwj14A
Message-ID: <CAPpAL=yYgqQk572yaRkNaKnoBbw7OcBGZ0HdXAJXz9mo5F6W5A@mail.gmail.com>
Subject: Re: [RFC PATCH v4 00/14] virtio: introduce support for GSO over UDP
 tunnel
To: Paolo Abeni <pabeni@redhat.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, 
 Dmitry Fleytman <dmitry.fleytman@gmail.com>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>, 
 Jason Wang <jasowang@redhat.com>,
 Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>, 
 "Michael S. Tsirkin" <mst@redhat.com>, Stefano Garzarella <sgarzare@redhat.com>,
 Cornelia Huck <cohuck@redhat.com>, 
 Luigi Rizzo <lrizzo@google.com>, Giuseppe Lettieri <g.lettieri@iet.unipi.it>, 
 Vincenzo Maffione <v.maffione@gmail.com>, Eric Blake <eblake@redhat.com>, 
 Markus Armbruster <armbru@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=leiyang@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.45,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

Tested this series of patches V4 with virtio-net regression tests,
everything works fine.

Tested-by: Lei Yang <leiyang@redhat.com>

On Thu, Jul 24, 2025 at 3:34=E2=80=AFAM Paolo Abeni <pabeni@redhat.com> wro=
te:
>
> Some virtualized deployments use UDP tunnel pervasively and are impacted
> negatively by the lack of GSO support for such kind of traffic in the
> virtual NIC driver.
>
> The virtio_net specification recently introduced support for GSO over
> UDP tunnel, and the kernel side of the implementation has been merged
> into the net-next tree; this series updates the virtio implementation to
> support such a feature.
>
> Currently the qemu virtio support limits the feature space to 64 bits,
> while the virtio specification allows for a larger number of features.
> Specifically the GSO-over-UDP-tunnel-related virtio features use bits
> 65-69; the larger part of this series (patches 4-12) actually deals with
> extending the features space.
>
> The extended features are carried by fixed size uint64_t arrays,
> bringing the current maximum features number to 128.
>
> The patches use some syntactic sugar to try to minimize the otherwise
> very large code churn. Specifically the extended features are boundled
> in an union with 'legacy' features definition, allowing no changes in
> the virtio devices not needing the extended features set.
>
> The actual offload implementation is in patches 13 and 14 and boils down
> to propagating the new offload to the tun devices and the vhost backend.
>
> Patch 1 is a small pre-req refactor that ideally could enter the
> tree separately; it's presented here in the same series to help
> reviewers more easily getting the full picture, patch 2 updates to
> linux headers update script to deal with annotations recently introduce
> in the kernel and patch 3 is a needed linux headers update.
>
> Tested with basic stream transfer with all the possible permutations of
> host kernel/qemu/guest kernel with/without GSO over UDP tunnel support,
> vs snapshots creation and restore and vs migration.
>
> Sharing again as RFC as the kernel bits have not entered the Linus tree
> yet - but they should on next merge window.
>
> ---
> Note: next revision will be after the Linux merge window to allow
> dropping the 'RFC' tag and also due to myself being off-the-grid
> meanwhile.
>
> v3 -> v4:
>   - more sparse cleanups
>   - fix build failures on a couple of targets
>
> v2 -> v3:
>   - consolidated suffixes for new fields to '_ex'
>   - avoid pre/post load trickery and relay on reset zeroing the features
>   - cleaned-up virtio store implementation deduplicating a bit of code
>   - many more cleanups, see the individual patches changelog for the
>     details
>   - I left patch 1 unmodified, still some hope we could live with that;)
>
> Paolo Abeni (14):
>   net: bundle all offloads in a single struct
>   linux-headers: deal with counted_by annotation
>   linux-headers: Update to Linux ~v6.16-rc7 net-next
>   virtio: introduce extended features type
>   virtio: serialize extended features state
>   virtio: add support for negotiating extended features
>   virtio-pci: implement support for extended features
>   vhost: add support for negotiating extended features
>   qmp: update virtio features map to support extended features
>   vhost-backend: implement extended features support
>   vhost-net: implement extended features support
>   virtio-net: implement extended features support
>   net: implement tunnel probing
>   net: implement UDP tunnel features offloading
>
>  hw/net/e1000e_core.c                         |   5 +-
>  hw/net/igb_core.c                            |   5 +-
>  hw/net/vhost_net-stub.c                      |   8 +-
>  hw/net/vhost_net.c                           |  45 ++--
>  hw/net/virtio-net.c                          | 222 +++++++++++++------
>  hw/net/vmxnet3.c                             |  13 +-
>  hw/virtio/vhost-backend.c                    |  62 +++++-
>  hw/virtio/vhost.c                            |  68 ++++--
>  hw/virtio/virtio-bus.c                       |  11 +-
>  hw/virtio/virtio-hmp-cmds.c                  |   3 +-
>  hw/virtio/virtio-pci.c                       |  69 +++++-
>  hw/virtio/virtio-qmp.c                       |  91 +++++---
>  hw/virtio/virtio-qmp.h                       |   3 +-
>  hw/virtio/virtio.c                           | 102 ++++++---
>  include/hw/virtio/vhost-backend.h            |   6 +
>  include/hw/virtio/vhost.h                    |  56 ++++-
>  include/hw/virtio/virtio-features.h          | 127 +++++++++++
>  include/hw/virtio/virtio-net.h               |   2 +-
>  include/hw/virtio/virtio-pci.h               |   2 +-
>  include/hw/virtio/virtio.h                   |  11 +-
>  include/net/net.h                            |  20 +-
>  include/net/vhost_net.h                      |  33 ++-
>  include/standard-headers/linux/ethtool.h     |   4 +-
>  include/standard-headers/linux/vhost_types.h |   5 +
>  include/standard-headers/linux/virtio_net.h  |  33 +++
>  linux-headers/linux/vhost.h                  |   7 +
>  net/net.c                                    |  17 +-
>  net/netmap.c                                 |   3 +-
>  net/tap-bsd.c                                |   8 +-
>  net/tap-linux.c                              |  38 +++-
>  net/tap-linux.h                              |   9 +
>  net/tap-solaris.c                            |   9 +-
>  net/tap-stub.c                               |   8 +-
>  net/tap.c                                    |  21 +-
>  net/tap_int.h                                |   5 +-
>  qapi/virtio.json                             |   9 +-
>  scripts/update-linux-headers.sh              |   1 +
>  37 files changed, 875 insertions(+), 266 deletions(-)
>  create mode 100644 include/hw/virtio/virtio-features.h
>
> --
> 2.50.0
>
>


