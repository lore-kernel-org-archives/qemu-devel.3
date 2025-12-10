Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9673D3B9A9
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Dec 2025 08:00:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vTF7M-0000na-Be; Wed, 10 Dec 2025 03:00:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aesteve@redhat.com>)
 id 1vTF7K-0000n7-Ln
 for qemu-devel@nongnu.org; Wed, 10 Dec 2025 03:00:10 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aesteve@redhat.com>)
 id 1vTF7I-0002KH-KP
 for qemu-devel@nongnu.org; Wed, 10 Dec 2025 03:00:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1765353606;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5EhGVFs/7l4gTQaGlgFohAnXx8tm9ULwlVY9BFK2teU=;
 b=Xwzf2CKqh512f5k8AoyLGlWwZS1mpMqfqaPRFzi2g9NIXh0TXmOjnW4iwY/fu1qqi9HBAi
 SWai0Ed9Ji8SStGB6tbAFBOuimuWV2I7lXYICxgKs781UUoGH3+fgIMqDce/nqB1D4h64J
 wwhCB9e6/3T8XL/rT1pQHBGZZCovIQc=
Received: from mail-yw1-f200.google.com (mail-yw1-f200.google.com
 [209.85.128.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-88-cHz9n8MJNfO43HiEQ4Fs-g-1; Wed, 10 Dec 2025 03:00:04 -0500
X-MC-Unique: cHz9n8MJNfO43HiEQ4Fs-g-1
X-Mimecast-MFC-AGG-ID: cHz9n8MJNfO43HiEQ4Fs-g_1765353604
Received: by mail-yw1-f200.google.com with SMTP id
 00721157ae682-78c3b8ccb24so48570097b3.3
 for <qemu-devel@nongnu.org>; Wed, 10 Dec 2025 00:00:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1765353604; x=1765958404; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5EhGVFs/7l4gTQaGlgFohAnXx8tm9ULwlVY9BFK2teU=;
 b=SV0t2iUzLeTnUrh39GTEvYMYwcdzpg+1AN/90DzxOqGxLzaOqBO27LiFHpWGz61enx
 VdriqD4tkyIFlZBRFBAinbGGpEWdgjKQhP3W1V8EmpYjNrPt7XKChZTL925LYlHj9Chi
 XbQsKU2KBm6hFJhIp+9cWPgbbYmsA8H89L7QxxdLAeAL12Hb4wnECPavKW6pSH7vUwCk
 W6qYphjpnlkRWnVRkER3r3PeO//MtQ0Y+EvdtNmN+CkFGC2SK450Yj3SiCavjIi6UNyY
 rVBJBx5LTcFnNqmwlAKS16/KTF6/n7nVgmCMkS71V4WpWB5DeAFKj8BxdppD6LLh1XSX
 56lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765353604; x=1765958404;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=5EhGVFs/7l4gTQaGlgFohAnXx8tm9ULwlVY9BFK2teU=;
 b=dlEM2nNrjS9rIqhKEsIwWa378+laZliKbzVkfGeU/lF27y8gfRxgYixMgaMCyj+uHI
 qTIjYbSwGu3PZoFmpIZF/VL0STO7sHp9XJZtuIjyBZgIgp1TyX6LMLgN/wq/t6iz1zj+
 h3bCuaWAp7YvBqe2qHMatp8fTAvAjaSWfVeVoccWDY5Ic4UkpNbB4nOQxaQBAMsExTYN
 VGlo3A6eZTiLR0n81ahBHquz4PWutlrd1Cigen0hogja+Ye5qQc3+yKZs8Y0vTT3y5Qn
 UNcQKkt5e7Y6PudrHvE7kipnPkKB9GufZyGVEJrz7Faq2DvgqRa978kwIuxaPf/C/ZKx
 cIvg==
X-Gm-Message-State: AOJu0YyDSDvTIKqvdvSwsNmkLrU1Oesu/J1j1qr8k7XP9C7b9BrnWJmP
 6LDCxnb9naZVFCBB/AzwZqTdES+yJ9ceEdiH50T4PVv1v4qYwXiGRF/agiN/oIaD00FTZDWui0F
 nwzxYq1MyKAzcMl6ubQ+ZHnIZE8sQlPjMwiz6R/OwkBXvB2U3k9O2uN7XZkkLYU5gMnvuuuKoPs
 oQd6s2sbcOmhNYan5fKFEA36ojIG9BJc0=
X-Gm-Gg: AY/fxX6UcbFFVsIoe+BYp/ZkDA/WTXWfDvk5AaW2+0I5MMZCA5yLSEe81NZ3xvEtAqY
 kbuGR0kSIRh1LifuRvHCSQHLivId5ODj5mE9MC7F8moOgcNUWHneGXdC6rT/7/4sgAkIU9dAgnA
 oiVvhoKNmMwpJteDpevZcr09vv/SIHC4Ii3yj5CDJ08JrFVbzcxFNFtiw11TsnAw==
X-Received: by 2002:a05:690c:48c9:b0:787:e3c0:f61f with SMTP id
 00721157ae682-78c9d79d6damr24235947b3.57.1765353604003; 
 Wed, 10 Dec 2025 00:00:04 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH14jfCUWF8FQ1rh5aRPiORIWKZPvPiWI9w4Y1RsITiK7mhFGDro5dwBRKy68/7HZciVyWc3UjJTRx7gpijsnY=
X-Received: by 2002:a05:690c:48c9:b0:787:e3c0:f61f with SMTP id
 00721157ae682-78c9d79d6damr24235577b3.57.1765353603616; Wed, 10 Dec 2025
 00:00:03 -0800 (PST)
MIME-Version: 1.0
References: <20251111091058.879669-1-aesteve@redhat.com>
 <20251202144821-mutt-send-email-mst@kernel.org>
In-Reply-To: <20251202144821-mutt-send-email-mst@kernel.org>
From: Albert Esteve <aesteve@redhat.com>
Date: Wed, 10 Dec 2025 08:59:52 +0100
X-Gm-Features: AQt7F2pTds7FlHFOs9i9WRkZuFLUHNDFGizSerjFLchynjcBP7CfMDyDxMizX5g
Message-ID: <CADSE00J4Ux=_E+MsehKSEQZPkDSDT2U7_Hv6XGXyZrCUU6R_zw@mail.gmail.com>
Subject: Re: [PATCH v11 0/7] vhost-user: Add SHMEM_MAP/UNMAP requests
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: qemu-devel@nongnu.org, dbassey@redhat.com, manos.pitsidianakis@linaro.org, 
 slp@redhat.com, stefanha@redhat.com, Fabiano Rosas <farosas@suse.de>,
 jasowang@redhat.com, 
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 Paolo Bonzini <pbonzini@redhat.com>, david@redhat.com, hi@alyssa.is,
 stevensd@chromium.org, 
 Stefano Garzarella <sgarzare@redhat.com>, Laurent Vivier <lvivier@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=aesteve@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Tue, Dec 2, 2025 at 8:50=E2=80=AFPM Michael S. Tsirkin <mst@redhat.com> =
wrote:
>
> On Tue, Nov 11, 2025 at 10:10:51AM +0100, Albert Esteve wrote:
> > Hi all,
> >
> > v10->v11
> > - Rebase to grab commit fde5930cc37175cfcd0f03a089e26f4458a52311
> >   and explicitly unset reply_ack on the SHMEM_MAP/UNMAP msg.
> > - Mention mapping cleanup on device reset in the spec.
> > v9->v10
> > - Fix transaction_commit invoked without transaction_begin
> >   on vhost_user_backend_handle_shmem_map() early errors
> > - Removed fd tracking on VirtioSharedMemoryMapping, it
> >   is handled by the RAMBlock
> > - Reject invalid BAR configurations when VIRTIO Shared Memory
> >   Regions are in use by vhost-user-test-device
> > v8->v9
> > - Fixed vhost-user new handlers to ensure that they always
> >   reply
> > - Made MMAP request flags field u64 everywhere
> > - Fixed double memory_region_del_subregion() on UNMAP
> > - Add mappings cleaning on virtio_reset()
> > - Some small typos and fixes
> > - Fixed virtio pci bar mapping for vhost-user-test-device
> > v7->v8
> > - Unified VhostUserShmemObject and VirtioSharedMemoryMapping
> > - Refined shmem_obj lifecycle by transferring ownership
> > - Other small improvements
> >
> > This patch series implements dynamic fd-backed memory mapping support
> > for vhost-user backends, enabling backends to dynamically request memor=
y
> > mappings and unmappings during runtime through the new
> > VHOST_USER_BACKEND_SHMEM_MAP/UNMAP protocol messages.
> >
> > This feature benefits various VIRTIO devices that require dynamic share=
d
> > memory management, including virtiofs (for DAX mappings), virtio-gpu
> > (for resource sharing), and the recently standardized virtio-media.
> >
> > The implementation introduces a QOM-based architecture for managing
> > shared memory lifecycle:
> >
> > - VirtioSharedMemoryMapping: an intermediate object that manages
> >   individual memory mappings by acting as generic container for regions
> >   declared in any vhost-user device type
> > - Dynamic Mapping: backends can request mappings via SHMEM_MAP messages=
,
> >   with the frontend creating MemoryRegions from the provided file
> >   descriptors and adding them as subregions
> >
> > When a SHMEM_MAP request is received, the frontend:
> > 1. Creates VirtioSharedMemoryMapping to manage the mapping lifecycle
> > 2. Maps the provided fd with memory_region_init_ram_from_fd()
> > 3. Creates a MemoryRegion backed by the mapped memory
> > 4. Adds it as a subregion of the appropiate VIRTIO Shared Memory Region
> >
> > The QOM reference counting ensures automatic cleanup when mappings are
> > removed or the device is destroyed.
> >
> > This patch also includes:
> > - VHOST_USER_GET_SHMEM_CONFIG: a new frontend request allowing generic
> >   vhost-user devices to query shared memory configuration from backends
> >   at device initialization, enabling the generic vhost-user-device
> >   frontend to work with any backend regardless of specific shared memor=
y
> >   requirements.
>
> Looks good, we are in freeze so will merge after 10.2.
> If it's not too much trouble, pls ping me after the release
> to help make sure it's not forgotten.

Release happened already iianm?
Sending the ping.

>
>
> > The implementation has been tested with rust-vmm based backends.
> >
> > Albert Esteve (7):
> >   vhost-user: Add VirtIO Shared Memory map request
> >   vhost_user.rst: Align VhostUserMsg excerpt members
> >   vhost_user.rst: Add SHMEM_MAP/_UNMAP to spec
> >   vhost_user: Add frontend get_shmem_config command
> >   vhost_user.rst: Add GET_SHMEM_CONFIG message
> >   qmp: add shmem feature map
> >   vhost-user-device: Add shared memory BAR
> >
> >  docs/interop/vhost-user.rst               | 102 ++++++++
> >  hw/virtio/vhost-user-base.c               |  47 +++-
> >  hw/virtio/vhost-user-test-device-pci.c    |  39 +++-
> >  hw/virtio/vhost-user.c                    | 269 ++++++++++++++++++++++
> >  hw/virtio/virtio-qmp.c                    |   3 +
> >  hw/virtio/virtio.c                        | 199 ++++++++++++++++
> >  include/hw/virtio/vhost-backend.h         |  10 +
> >  include/hw/virtio/vhost-user.h            |   1 +
> >  include/hw/virtio/virtio.h                | 137 +++++++++++
> >  subprojects/libvhost-user/libvhost-user.c |  70 ++++++
> >  subprojects/libvhost-user/libvhost-user.h |  54 +++++
> >  11 files changed, 926 insertions(+), 5 deletions(-)
> >
> > --
> > 2.49.0
>


