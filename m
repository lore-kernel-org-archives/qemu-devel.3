Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94518CAC592
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Sep 2025 14:41:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uyANG-0000oo-3X; Mon, 15 Sep 2025 10:40:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <leiyang@redhat.com>)
 id 1uyAND-0000na-0x
 for qemu-devel@nongnu.org; Mon, 15 Sep 2025 10:40:07 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <leiyang@redhat.com>)
 id 1uyAMu-0002V0-JC
 for qemu-devel@nongnu.org; Mon, 15 Sep 2025 10:40:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1757947184;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=E/R1isj+/R1buCjtuAnl1yl9vVKRCHjpkZujIQMDBTU=;
 b=gvEit3RDkyzApY3RBlAifgdoqaNIW7KAMRTm33tsef5OFJSGLPqKH+SL9mmgURCeJz1w4q
 2PSL4KDERqNdvhngqdKvno7bdQ6FpROveY+SVXUdkYl+Ml12BJ+j/m+2AdgiYLJKk872Hy
 /H56s5ILDv4pTE8KPIc1f3TPq5e7+Zg=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-644-Rz7C4BtSP9WD1vfTDuz5eg-1; Mon, 15 Sep 2025 10:39:40 -0400
X-MC-Unique: Rz7C4BtSP9WD1vfTDuz5eg-1
X-Mimecast-MFC-AGG-ID: Rz7C4BtSP9WD1vfTDuz5eg_1757947180
Received: by mail-ej1-f70.google.com with SMTP id
 a640c23a62f3a-b0bb71dead2so174100566b.1
 for <qemu-devel@nongnu.org>; Mon, 15 Sep 2025 07:39:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1757947179; x=1758551979;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=E/R1isj+/R1buCjtuAnl1yl9vVKRCHjpkZujIQMDBTU=;
 b=GrJfb6HsvTXZWZ1GneS45Xlspi2EKvMcMjQe780QgtaXbO5YHVpoQ+m46vdMc6OJu1
 WSL7kYSMNYItIWX6GYfcFeFPiOhT+Z4medzFdAWCQYNYa0QPKZYUxqB6stmBdTtl7aQ/
 kCodbMnhRcCHsvWlv2lORKJ3HiWM6EtZwhukJVlBMX6HhpceFaKONh0bFYsV3wltb+m7
 s1TQe44zFKw6aWujTiYxSwcZuX81U3q03joRrtinuXeFEcRNQ1dciptznMvSexuYK8Ec
 vQt3h3cJZQHnWRDXYbMMYxQcjHlFwtEENQvZIMtyRncDFeBPW2mC44OTLyTsgd7ZzII5
 JkHg==
X-Gm-Message-State: AOJu0Yw3YMh/K4qRemUTwrNiUWi5mIX1crNPw+PRw67U7MLiAgWh7bmo
 Z6cbdmxqUmu0Iyh1DOoWBF6fEBOp6e9vmwfavR1L2p3WoGClz1afI89DGMXnkt8vkwx7EcfU9ql
 GdR0UxnyZ+xEa2jNhovcHDBe68z/LQodbuZRpjg4zIpFBEHU+L8EdHs0uFHz5XgKdJlCwaufGGY
 gmMIRcfEw8TPch1byTMcKSINsgPhFRXYo=
X-Gm-Gg: ASbGncsy0jrANZryVPDzfu8kvHii49IE6qL0Dzl19HDJhkV2ZgZyJJh43xciY6Qzirb
 so5a/Yo8K+RZL44fUOCN0imRZV36KCG6A2WT3+GSfnF6eLOVIBdOvAlgRbyBkUvnJCeJFAnKNPF
 sDvWtDKW7+WS4V5R5pg3/a+g==
X-Received: by 2002:a17:906:c393:b0:b07:d79f:756e with SMTP id
 a640c23a62f3a-b07d79f7b12mr717586166b.65.1757947179524; 
 Mon, 15 Sep 2025 07:39:39 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IElP42gDEywjoTukGG3RVe0xcRmZHFoWjn5Pu9U9oLCtk727VlywSWGaa+aBpMMGcIaIZoYQTGzLmxVzz3UQGk=
X-Received: by 2002:a17:906:c393:b0:b07:d79f:756e with SMTP id
 a640c23a62f3a-b07d79f7b12mr717583366b.65.1757947179013; Mon, 15 Sep 2025
 07:39:39 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1757676218.git.pabeni@redhat.com>
In-Reply-To: <cover.1757676218.git.pabeni@redhat.com>
From: Lei Yang <leiyang@redhat.com>
Date: Mon, 15 Sep 2025 22:39:02 +0800
X-Gm-Features: AS18NWCyHdZvAJzMae6dfEchHJpJvoyJrn1zQNH6JjvO9R8noD_fa0zckRgGjJY
Message-ID: <CAPpAL=yfdoDzXZw+JPAfGym9me=9a+u5p97xAzJyn_VJXJTBYA@mail.gmail.com>
Subject: Re: [PATCH v6 00/14] virtio: introduce support for GSO over UDP tunnel
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
Received-SPF: pass client-ip=170.10.133.124; envelope-from=leiyang@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.035,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_PASS=-0.001, T_SPF_HELO_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

Tested this series of patches v6 with virtio-net regression tests,
everything works fine.

Tested-by: Lei Yang <leiyang@redhat.com>

On Fri, Sep 12, 2025 at 9:10=E2=80=AFPM Paolo Abeni <pabeni@redhat.com> wro=
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
> The new features are disabled by default to avoid compatibilty issues.
> They could be enabled with a later patch, together with the related
> compatiblity entries.
> ---
> v5 -> v6:
>   - colleted ack-by/reviewed-by tags
>   - re-included pre-req patch as per Michael's request
>   - minor checkpatch and whitestaces fixes
>
> v5: https://lists.gnu.org/archive/html/qemu-devel/2025-08/msg02005.html
>
> v4 -> v5:
>   - more sparse cleanup
>   - dropped RFC tag
>   - disable the new features by default
>
> v4: https://lists.gnu.org/archive/html/qemu-devel/2025-07/msg05513.html
>
> v3 -> v4:
>   - more sparse cleanups
>   - fix build failures on a couple of targets
> v3: https://lists.gnu.org/archive/html/qemu-devel/2025-07/msg04872.html
>
> v2 -> v3:
>   - consolidated suffixes for new fields to '_ex'
>   - avoid pre/post load trickery and relay on reset zeroing the features
>   - cleaned-up virtio store implementation deduplicating a bit of code
>   - many more cleanups, see the individual patches changelog for the
>     details
>   - I left patch 1 unmodified, still some hope we could live with that;)
> v2: https://lists.gnu.org/archive/html/qemu-devel/2025-07/msg03000.html
>
> Paolo Abeni (14):
>   net: bundle all offloads in a single struct
>   linux-headers: deal with counted_by annotation
>   linux-headers: Update to Linux v6.17-rc1
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
>  hw/net/e1000e_core.c                          |   5 +-
>  hw/net/igb_core.c                             |   5 +-
>  hw/net/vhost_net-stub.c                       |   8 +-
>  hw/net/vhost_net.c                            |  45 ++--
>  hw/net/virtio-net.c                           | 234 ++++++++++++------
>  hw/net/vmxnet3.c                              |  13 +-
>  hw/virtio/vhost-backend.c                     |  62 ++++-
>  hw/virtio/vhost.c                             |  68 +++--
>  hw/virtio/virtio-bus.c                        |  11 +-
>  hw/virtio/virtio-hmp-cmds.c                   |   3 +-
>  hw/virtio/virtio-pci.c                        |  76 +++++-
>  hw/virtio/virtio-qmp.c                        |  91 ++++---
>  hw/virtio/virtio-qmp.h                        |   3 +-
>  hw/virtio/virtio.c                            | 100 +++++---
>  include/hw/virtio/vhost-backend.h             |   6 +
>  include/hw/virtio/vhost.h                     |  56 ++++-
>  include/hw/virtio/virtio-features.h           | 126 ++++++++++
>  include/hw/virtio/virtio-net.h                |   2 +-
>  include/hw/virtio/virtio-pci.h                |   2 +-
>  include/hw/virtio/virtio.h                    |  11 +-
>  include/net/net.h                             |  20 +-
>  include/net/vhost_net.h                       |  33 ++-
>  include/standard-headers/drm/drm_fourcc.h     |  56 ++++-
>  include/standard-headers/linux/ethtool.h      |   4 +-
>  .../linux/input-event-codes.h                 |   8 +
>  include/standard-headers/linux/input.h        |   1 +
>  include/standard-headers/linux/pci_regs.h     |   9 +
>  include/standard-headers/linux/vhost_types.h  |   5 +
>  include/standard-headers/linux/virtio_net.h   |  33 +++
>  linux-headers/LICENSES/preferred/GPL-2.0      |  10 +-
>  linux-headers/asm-arm64/unistd_64.h           |   2 +
>  linux-headers/asm-generic/unistd.h            |   8 +-
>  linux-headers/asm-loongarch/unistd_64.h       |   2 +
>  linux-headers/asm-mips/unistd_n32.h           |   2 +
>  linux-headers/asm-mips/unistd_n64.h           |   2 +
>  linux-headers/asm-mips/unistd_o32.h           |   2 +
>  linux-headers/asm-powerpc/kvm.h               |  13 -
>  linux-headers/asm-powerpc/unistd_32.h         |   2 +
>  linux-headers/asm-powerpc/unistd_64.h         |   2 +
>  linux-headers/asm-riscv/kvm.h                 |   1 +
>  linux-headers/asm-riscv/unistd_32.h           |   2 +
>  linux-headers/asm-riscv/unistd_64.h           |   2 +
>  linux-headers/asm-s390/unistd_32.h            |   2 +
>  linux-headers/asm-s390/unistd_64.h            |   2 +
>  linux-headers/asm-x86/unistd_32.h             |   2 +
>  linux-headers/asm-x86/unistd_64.h             |   2 +
>  linux-headers/asm-x86/unistd_x32.h            |   2 +
>  linux-headers/linux/iommufd.h                 | 154 +++++++++++-
>  linux-headers/linux/kvm.h                     |   2 +
>  linux-headers/linux/vfio.h                    |  12 +-
>  linux-headers/linux/vhost.h                   |  35 +++
>  net/net.c                                     |  17 +-
>  net/netmap.c                                  |   3 +-
>  net/tap-bsd.c                                 |   8 +-
>  net/tap-linux.c                               |  38 ++-
>  net/tap-linux.h                               |   9 +
>  net/tap-solaris.c                             |   9 +-
>  net/tap-stub.c                                |   8 +-
>  net/tap.c                                     |  21 +-
>  net/tap_int.h                                 |   5 +-
>  qapi/virtio.json                              |   9 +-
>  scripts/update-linux-headers.sh               |   1 +
>  62 files changed, 1196 insertions(+), 291 deletions(-)
>  create mode 100644 include/hw/virtio/virtio-features.h
>
> --
> 2.51.0
>
>


