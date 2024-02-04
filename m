Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5026AC4828F
	for <qemu-devel@archiver.kernel.org>; Sun,  4 Feb 2024 01:45:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rWRZO-0005Mq-Rn; Sat, 03 Feb 2024 20:45:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <raphael.s.norwitz@gmail.com>)
 id 1rWRZN-0005MQ-1J
 for qemu-devel@nongnu.org; Sat, 03 Feb 2024 20:45:17 -0500
Received: from mail-io1-xd2d.google.com ([2607:f8b0:4864:20::d2d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <raphael.s.norwitz@gmail.com>)
 id 1rWRZH-0007QP-DH
 for qemu-devel@nongnu.org; Sat, 03 Feb 2024 20:45:16 -0500
Received: by mail-io1-xd2d.google.com with SMTP id
 ca18e2360f4ac-7c2ca431146so33294739f.1
 for <qemu-devel@nongnu.org>; Sat, 03 Feb 2024 17:45:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1707011110; x=1707615910; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7nZ3I2FQgo6o08a8W3FIH5f9bXW1US92Nnc9DumZvUM=;
 b=GdiBSbacLtdUFKBlPwT75ct3tIcUUi9jDPD3FZZh503x8SWsY/ZnBW1V0JFbJzsyPG
 W1RZ4sadpHZNc/KlkBK9rQg29gX3MurL8Ob33pkVo7Vlxlp5El3z7MdGmfuNLLAMn3mx
 T3KKNLd/AocXcPn9Lskv6fEIufbAP5LtvK8iBook1snbVojcL31PUsbifv0xFbs/BRV1
 IPsBWF7m50MGckCxRfrpzIzhDy3hGhzrEm7p+3r4KwUkHf1I6pXsMgV1V/cKN8rgAYjL
 SnooVP/tsOV19GCrq+htyeoTEACXj+Lus4QEwwu/3wBx7GtjA8/ifNPkGtYRrpvjL0bu
 W/4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707011110; x=1707615910;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=7nZ3I2FQgo6o08a8W3FIH5f9bXW1US92Nnc9DumZvUM=;
 b=i8JCy1ql5zRl0AY8kU/uqr3yxVbOCvZyT1jlQu52JbJZ0Zioif6UmKhXZlDVqGtA3m
 svB7z/9hTZKuhcy62hmvIBdwpgIRUm0lY4Sdqhkae0/CjdIwg1LJpamFlUC5hRoVD6aH
 0WAg6tIFzW4Ix7Kpo95oAmfdKyYGSsHBcbqma19UikrBS3PC8nz0BKlwTknqNpzdkQXL
 Cm00NHeMbZrKwFIikXMT4SA6f+Dw/rxZy9BbLkz7HkeFt+NBG+QcHMNRTTOs6ueysW6m
 aFdrPUMdTPoOlhsBJ9sRMoWLj6X7f7ep4RXyCDcOZ8l3ClUxQZO4E4ahPKFOXH5x5RMP
 NABQ==
X-Gm-Message-State: AOJu0YwnAEaTg37MgxurNj4N+Np8BVqMMH//8vWhxLSxJVkjqdlL8+o5
 MmoD04PTYlaQ6b+/F3/7lE8USvHY+NHPlhZzog7sAmO7vu9RiAiHP0w7n9vnt8SSnKvmCKA0Mme
 lmp3IS57ziRUiMx8PVxU7lti8xW8=
X-Google-Smtp-Source: AGHT+IGBYu78X8eUMH26MBW4LhmsW6bq+6pie5R0MYpyZgRO/w7bRtLkrg3Wzq3ZCjjbYAP2omkxEDvnrbD/mKbL+64=
X-Received: by 2002:a6b:da14:0:b0:7bc:3ceb:6552 with SMTP id
 x20-20020a6bda14000000b007bc3ceb6552mr13331988iob.5.1707011110190; Sat, 03
 Feb 2024 17:45:10 -0800 (PST)
MIME-Version: 1.0
References: <20240202215332.118728-1-david@redhat.com>
 <20240202215332.118728-7-david@redhat.com>
In-Reply-To: <20240202215332.118728-7-david@redhat.com>
From: Raphael Norwitz <raphael.s.norwitz@gmail.com>
Date: Sat, 3 Feb 2024 20:44:59 -0500
Message-ID: <CAFubqFtBJ-h=ph+C201a6G73GzOgyHV1wWKcdfhxNTq5J8hSkA@mail.gmail.com>
Subject: Re: [PATCH v1 06/15] libvhost-user: Factor out adding a memory region
To: David Hildenbrand <david@redhat.com>
Cc: qemu-devel@nongnu.org, "Michael S . Tsirkin" <mst@redhat.com>,
 Jason Wang <jasowang@redhat.com>, 
 Stefan Hajnoczi <stefanha@redhat.com>, Stefano Garzarella <sgarzare@redhat.com>,
 Germano Veit Michel <germano@redhat.com>,
 Raphael Norwitz <raphael.norwitz@nutanix.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::d2d;
 envelope-from=raphael.s.norwitz@gmail.com; helo=mail-io1-xd2d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Fri, Feb 2, 2024 at 4:55=E2=80=AFPM David Hildenbrand <david@redhat.com>=
 wrote:
>
> Let's factor it out, reducing quite some code duplication and perparing
> for further changes.
>
> If we fail to mmap a region and panic, we now simply don't add that
> (broken) region.
>
> Note that we now increment dev->nregions as we are successfully
> adding memory regions, and don't increment dev->nregions if anything went
> wrong.
>
> Signed-off-by: David Hildenbrand <david@redhat.com>

Reviewed-by: Raphael Norwitz <raphael@enfabrica.net>

> ---
>  subprojects/libvhost-user/libvhost-user.c | 168 ++++++++--------------
>  1 file changed, 60 insertions(+), 108 deletions(-)
>
> diff --git a/subprojects/libvhost-user/libvhost-user.c b/subprojects/libv=
host-user/libvhost-user.c
> index d9e2214ad2..a2baefe84b 100644
> --- a/subprojects/libvhost-user/libvhost-user.c
> +++ b/subprojects/libvhost-user/libvhost-user.c
> @@ -256,6 +256,61 @@ vu_remove_all_mem_regs(VuDev *dev)
>      dev->nregions =3D 0;
>  }
>
> +static void
> +_vu_add_mem_reg(VuDev *dev, VhostUserMemoryRegion *msg_region, int fd)
> +{
> +    int prot =3D PROT_READ | PROT_WRITE;
> +    VuDevRegion *r;
> +    void *mmap_addr;
> +
> +    DPRINT("Adding region %d\n", dev->nregions);
> +    DPRINT("    guest_phys_addr: 0x%016"PRIx64"\n",
> +           msg_region->guest_phys_addr);
> +    DPRINT("    memory_size:     0x%016"PRIx64"\n",
> +           msg_region->memory_size);
> +    DPRINT("    userspace_addr   0x%016"PRIx64"\n",
> +           msg_region->userspace_addr);
> +    DPRINT("    mmap_offset      0x%016"PRIx64"\n",
> +           msg_region->mmap_offset);
> +
> +    if (dev->postcopy_listening) {
> +        /*
> +         * In postcopy we're using PROT_NONE here to catch anyone
> +         * accessing it before we userfault
> +         */
> +        prot =3D PROT_NONE;
> +    }
> +
> +    /*
> +     * We don't use offset argument of mmap() since the mapped address h=
as
> +     * to be page aligned, and we use huge pages.
> +     */
> +    mmap_addr =3D mmap(0, msg_region->memory_size + msg_region->mmap_off=
set,
> +                     prot, MAP_SHARED | MAP_NORESERVE, fd, 0);
> +    if (mmap_addr =3D=3D MAP_FAILED) {
> +        vu_panic(dev, "region mmap error: %s", strerror(errno));
> +        return;
> +    }
> +    DPRINT("    mmap_addr:       0x%016"PRIx64"\n",
> +           (uint64_t)(uintptr_t)mmap_addr);
> +
> +    r =3D &dev->regions[dev->nregions];
> +    r->gpa =3D msg_region->guest_phys_addr;
> +    r->size =3D msg_region->memory_size;
> +    r->qva =3D msg_region->userspace_addr;
> +    r->mmap_addr =3D (uint64_t)(uintptr_t)mmap_addr;
> +    r->mmap_offset =3D msg_region->mmap_offset;
> +    dev->nregions++;
> +
> +    if (dev->postcopy_listening) {
> +        /*
> +         * Return the address to QEMU so that it can translate the ufd
> +         * fault addresses back.
> +         */
> +        msg_region->userspace_addr =3D r->mmap_addr + r->mmap_offset;
> +    }
> +}
> +
>  static void
>  vmsg_close_fds(VhostUserMsg *vmsg)
>  {
> @@ -727,10 +782,7 @@ generate_faults(VuDev *dev) {
>  static bool
>  vu_add_mem_reg(VuDev *dev, VhostUserMsg *vmsg) {
>      int i;
> -    bool track_ramblocks =3D dev->postcopy_listening;
>      VhostUserMemoryRegion m =3D vmsg->payload.memreg.region, *msg_region=
 =3D &m;
> -    VuDevRegion *dev_region =3D &dev->regions[dev->nregions];
> -    void *mmap_addr;
>
>      if (vmsg->fd_num !=3D 1) {
>          vmsg_close_fds(vmsg);
> @@ -760,69 +812,20 @@ vu_add_mem_reg(VuDev *dev, VhostUserMsg *vmsg) {
>       * we know all the postcopy client bases have been received, and we
>       * should start generating faults.
>       */
> -    if (track_ramblocks &&
> +    if (dev->postcopy_listening &&
>          vmsg->size =3D=3D sizeof(vmsg->payload.u64) &&
>          vmsg->payload.u64 =3D=3D 0) {
>          (void)generate_faults(dev);
>          return false;
>      }
>
> -    DPRINT("Adding region: %u\n", dev->nregions);
> -    DPRINT("    guest_phys_addr: 0x%016"PRIx64"\n",
> -           msg_region->guest_phys_addr);
> -    DPRINT("    memory_size:     0x%016"PRIx64"\n",
> -           msg_region->memory_size);
> -    DPRINT("    userspace_addr   0x%016"PRIx64"\n",
> -           msg_region->userspace_addr);
> -    DPRINT("    mmap_offset      0x%016"PRIx64"\n",
> -           msg_region->mmap_offset);
> -
> -    dev_region->gpa =3D msg_region->guest_phys_addr;
> -    dev_region->size =3D msg_region->memory_size;
> -    dev_region->qva =3D msg_region->userspace_addr;
> -    dev_region->mmap_offset =3D msg_region->mmap_offset;
> -
> -    /*
> -     * We don't use offset argument of mmap() since the
> -     * mapped address has to be page aligned, and we use huge
> -     * pages.
> -     */
> -    if (track_ramblocks) {
> -        /*
> -         * In postcopy we're using PROT_NONE here to catch anyone
> -         * accessing it before we userfault.
> -         */
> -        mmap_addr =3D mmap(0, dev_region->size + dev_region->mmap_offset=
,
> -                         PROT_NONE, MAP_SHARED | MAP_NORESERVE,
> -                         vmsg->fds[0], 0);
> -    } else {
> -        mmap_addr =3D mmap(0, dev_region->size + dev_region->mmap_offset=
,
> -                         PROT_READ | PROT_WRITE, MAP_SHARED | MAP_NORESE=
RVE,
> -                         vmsg->fds[0], 0);
> -    }
> -
> -    if (mmap_addr =3D=3D MAP_FAILED) {
> -        vu_panic(dev, "region mmap error: %s", strerror(errno));
> -    } else {
> -        dev_region->mmap_addr =3D (uint64_t)(uintptr_t)mmap_addr;
> -        DPRINT("    mmap_addr:       0x%016"PRIx64"\n",
> -               dev_region->mmap_addr);
> -    }
> -
> +    _vu_add_mem_reg(dev, msg_region, vmsg->fds[0]);
>      close(vmsg->fds[0]);
>
> -    if (track_ramblocks) {
> -        /*
> -         * Return the address to QEMU so that it can translate the ufd
> -         * fault addresses back.
> -         */
> -        msg_region->userspace_addr =3D dev_region->mmap_addr +
> -                                     dev_region->mmap_offset;
> -
> +    if (dev->postcopy_listening) {
>          /* Send the message back to qemu with the addresses filled in. *=
/
>          vmsg->fd_num =3D 0;
>          DPRINT("Successfully added new region in postcopy\n");
> -        dev->nregions++;
>          return true;
>      } else {
>          for (i =3D 0; i < dev->max_queues; i++) {
> @@ -835,7 +838,6 @@ vu_add_mem_reg(VuDev *dev, VhostUserMsg *vmsg) {
>          }
>
>          DPRINT("Successfully added new region\n");
> -        dev->nregions++;
>          return false;
>      }
>  }
> @@ -940,63 +942,13 @@ static bool
>  vu_set_mem_table_exec(VuDev *dev, VhostUserMsg *vmsg)
>  {
>      VhostUserMemory m =3D vmsg->payload.memory, *memory =3D &m;
> -    int prot =3D PROT_READ | PROT_WRITE;
>      unsigned int i;
>
> -    if (dev->postcopy_listening) {
> -        /*
> -         * In postcopy we're using PROT_NONE here to catch anyone
> -         * accessing it before we userfault
> -         */
> -        prot =3D PROT_NONE;
> -    }
> -
>      vu_remove_all_mem_regs(dev);
> -    dev->nregions =3D memory->nregions;
>
>      DPRINT("Nregions: %u\n", memory->nregions);
> -    for (i =3D 0; i < dev->nregions; i++) {
> -        void *mmap_addr;
> -        VhostUserMemoryRegion *msg_region =3D &memory->regions[i];
> -        VuDevRegion *dev_region =3D &dev->regions[i];
> -
> -        DPRINT("Region %d\n", i);
> -        DPRINT("    guest_phys_addr: 0x%016"PRIx64"\n",
> -               msg_region->guest_phys_addr);
> -        DPRINT("    memory_size:     0x%016"PRIx64"\n",
> -               msg_region->memory_size);
> -        DPRINT("    userspace_addr   0x%016"PRIx64"\n",
> -               msg_region->userspace_addr);
> -        DPRINT("    mmap_offset      0x%016"PRIx64"\n",
> -               msg_region->mmap_offset);
> -
> -        dev_region->gpa =3D msg_region->guest_phys_addr;
> -        dev_region->size =3D msg_region->memory_size;
> -        dev_region->qva =3D msg_region->userspace_addr;
> -        dev_region->mmap_offset =3D msg_region->mmap_offset;
> -
> -        /* We don't use offset argument of mmap() since the
> -         * mapped address has to be page aligned, and we use huge
> -         * pages.  */
> -        mmap_addr =3D mmap(0, dev_region->size + dev_region->mmap_offset=
,
> -                         prot, MAP_SHARED | MAP_NORESERVE, vmsg->fds[i],=
 0);
> -
> -        if (mmap_addr =3D=3D MAP_FAILED) {
> -            vu_panic(dev, "region mmap error: %s", strerror(errno));
> -        } else {
> -            dev_region->mmap_addr =3D (uint64_t)(uintptr_t)mmap_addr;
> -            DPRINT("    mmap_addr:       0x%016"PRIx64"\n",
> -                   dev_region->mmap_addr);
> -        }
> -
> -        if (dev->postcopy_listening) {
> -            /*
> -             * Return the address to QEMU so that it can translate the u=
fd
> -             * fault addresses back.
> -             */
> -            msg_region->userspace_addr =3D dev_region->mmap_addr +
> -                                         dev_region->mmap_offset;
> -        }
> +    for (i =3D 0; i < memory->nregions; i++) {
> +        _vu_add_mem_reg(dev, &memory->regions[i], vmsg->fds[i]);
>          close(vmsg->fds[i]);
>      }
>
> --
> 2.43.0
>
>

