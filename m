Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B15BC44520
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jul 2026 11:51:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wkh5f-00031o-Rs; Fri, 17 Jul 2026 07:50:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aesteve@redhat.com>)
 id 1wkh5e-00031g-UH
 for qemu-devel@nongnu.org; Fri, 17 Jul 2026 07:50:50 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aesteve@redhat.com>)
 id 1wkh5c-00039p-B1
 for qemu-devel@nongnu.org; Fri, 17 Jul 2026 07:50:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1784289045;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=PL+JIVUfP2T88Lb85E2opQpl4gleVZjIFm720qYcIaI=;
 b=KiQcGHXdrNtShqQqp7tFhuJvILrR8YzxN7ND1b4p4YM6SOAhn8yebOVzRUEq13Ou8A10nT
 qwd+4VAN4gslJnH9XrDTWs2XAmSoziBeo9eFvfg8qIleV/xlWJxiNSIR+tPLKUN8K2u6Dc
 jeiAMnfnTGfQY0nnGRiOaalBj3cX5ck=
Received: from mail-yw1-f200.google.com (mail-yw1-f200.google.com
 [209.85.128.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-154-onITQDqcMfOKlXFIYt5dTg-1; Fri, 17 Jul 2026 07:50:44 -0400
X-MC-Unique: onITQDqcMfOKlXFIYt5dTg-1
X-Mimecast-MFC-AGG-ID: onITQDqcMfOKlXFIYt5dTg_1784289044
Received: by mail-yw1-f200.google.com with SMTP id
 00721157ae682-81e85096e65so13326907b3.2
 for <qemu-devel@nongnu.org>; Fri, 17 Jul 2026 04:50:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784289043; cv=none;
 d=google.com; s=arc-20260327;
 b=ByB6sbiodNVFnwtuIi8sfdsngWIPtS7lQi9o1Rj4OCqsPuqtxquiqtnWrdTbvbE97V
 PU+vg0FUzP5SIakfBMe3e3gjkVzbRiTGD7cwCvtGu5TIis0tkeyqfEJCgBxfkX2uwxO0
 SOk0Z+Ru1iBmdcQE0iWYCo55VoPtC0LJyd/EIopbrMCrJI0yLH3gk8+OiqC2nBGaVORi
 IplhHT/HxfBbTr+5MtsQkOBq6Qk1proXuMKGZoHa0pL5+pNil+EnXZ3lVFmXyFyuiNxa
 VFgr6lMSUe5/3tXBWo43H63FlB62L5hmUhCPPTa7f41V+irCaWpQv3jPuTt7YjfycPGK
 cr0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=PL+JIVUfP2T88Lb85E2opQpl4gleVZjIFm720qYcIaI=;
 fh=RWtWNYEOH40uILQhtQ4eYdsUqQAdhLJVdLNvEoqRoyk=;
 b=Z6GjMS1RBzYe8g5D8HiB7k4Aah+Zgi3/OUryHTo40Vx00Q/yttgm9POzRCpB4mmDob
 wM0yiHCfnJC+/E1OfGHs9EYvgImgtHEPtVWxyexDQUMFI/fXgjx/0MCwiHYdvzWxvlqM
 82xks+ZSitdnmx1MATvB/Qr+6w+ZUV/w0FpGIxIv1ekNPH8Vl3sWIu3m3pcxbIyq/M7b
 rc5ThwxL5z6jq7XRGEKX8wHbcA2lTXgXtNWUpjHqrLhkF5ankA61NAPMlsS0ylDwtQ0a
 cwjwoJHm18HZ04vDmNZYhDwB5G76ksA+uNiaFCj47Z72borbBBedDSMFL/YbPN+DkfoK
 9eGw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1784289043; x=1784893843; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=PL+JIVUfP2T88Lb85E2opQpl4gleVZjIFm720qYcIaI=;
 b=YeRxfLp2Ld4citjWHy1tLxSC0/slrTUmIGnmq82ri79Ht+iwncueBqLDqs1p6c+lSI
 ovrVnZq42L6bTQQmZw+uc468mqdCQA07dkfvndrBX0eqt7UuAWNrO6DVoEySqLRdEf1h
 MtGNnWtCW6AA4kaeVE9jnSMKtd6bvyVeUM/tY4mF4VjzX+HD+PNycoYQM0137Z/PBwDm
 SN1X/KYMLA2f4ZmslfCE+zvPYMahvgknzlfC0wQiKM1AL1NxWwG7C2cM/H6EPMFFnlCp
 wGgRRagZdqKWvpOIPvXM2oNBcD7NsErOsa4mpFGx+1GzyXq26QAGNjKJHFPuLEqz12kj
 rAmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784289043; x=1784893843;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=PL+JIVUfP2T88Lb85E2opQpl4gleVZjIFm720qYcIaI=;
 b=duxZi5ocmCEeA4cCb4M/sQ7r665Zvbmn3uIbJITs95owK7fV1mvzBaj7iaL/PA4UOq
 R6uf7BnSeg+uuyxJ4rH1j2vglwIzW4ZHxsubvqC9cXOL1jXPN4KpNjEsxXTgLx3xWoE7
 LuHXgUSOGubnjN8FvejD7Lpb0gtII9oBekUAfo0aNy2cE9gMYkLYcMLyLlr7DDggHvic
 fuIYD8IFK5OqVR46GxqBYNAxqq5JGQoMUYbQGfzlk24NB+yvq1aG3S5ufW2WFLZHtFP6
 Q22uqxhoqGUwwZCyJ8GywaG7sTwyzYoyllbvcWd+dmjCyzUAYFeBtrHnUfm0Q1S3U0se
 z4lQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RoHYe22tfrOXbAweNDChvLVwCLuigN60HwIUV3JSzFWI2dsvE9LWng+JDPIIU+iiPuCt2BXjKPM8X1w@nongnu.org
X-Gm-Message-State: AOJu0Ywle5DeQN08NJ78houcY2EjkLDSfbcooRcb7nVfbk/sUijceW9H
 n4gSL2GbSOE+BvQFX16ILCuEF05N6B9roOLlYbfXhou51pxdpHCZawjfIy6KtjvZFDDOk/tVJaq
 7MK7itqCgWhXlbeSoNovdqy6LGmGK+hAQ4/ltaDITaQ5+bOC9Nqd0g2I9tjy91WwTzBfAKAtxQ3
 9IncZgxMIHP5em0kHOm2xQNPk8tdg5ZcQ=
X-Gm-Gg: AfdE7cln3OWPSlt8Zc39WffV/U1mVVHJeTIoNSONi9PIt2STc4sU/fKSoj1pbtyfyzZ
 GEFU7ZI1W8eO1Le/PfTikCTywj5WRRH/nDe84QQEQRmrMRAGH9v6UV6Qvnn5pfEiMGSlPhePdnD
 XhveEMk/SRjimo8g/iObBv36eJPLztJgVl6efgBJCtrk+Is8hLxjWRZ4MR
X-Received: by 2002:a05:690e:43d0:b0:667:b898:4d84 with SMTP id
 956f58d0204a3-6683bba43efmr384012d50.28.1784289043597; 
 Fri, 17 Jul 2026 04:50:43 -0700 (PDT)
X-Received: by 2002:a05:690e:43d0:b0:667:b898:4d84 with SMTP id
 956f58d0204a3-6683bba43efmr384002d50.28.1784289043080; Fri, 17 Jul 2026
 04:50:43 -0700 (PDT)
MIME-Version: 1.0
References: <20260717103301.228974-1-dbassey@redhat.com>
 <20260717103301.228974-2-dbassey@redhat.com>
 <20260717063641-mutt-send-email-mst@kernel.org>
In-Reply-To: <20260717063641-mutt-send-email-mst@kernel.org>
From: Albert Esteve <aesteve@redhat.com>
Date: Fri, 17 Jul 2026 13:50:31 +0200
X-Gm-Features: AUfX_my8qhEbGhpQPS3kwZAKCd8NTL5b0CvrBhddLfpLZzfjrL5xR8r7X2JvceQ
Message-ID: <CADSE00+Uoy=fu3OnvMCr0Cn=tHSj27LkD9y7_CPqT32oSaDFow@mail.gmail.com>
Subject: Re: [PATCH v3 1/3] vhost: Fix SHMEM_MAP transaction ordering and
 resulting deadlock
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Dorinda Bassey <dbassey@redhat.com>, qemu-devel@nongnu.org,
 mhrica@redhat.com, sgarzare@redhat.com, manos.pitsidianakis@linaro.org, 
 marcandre.lureau@redhat.com, stefanha@redhat.com, pbonzini@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: permerror client-ip=170.10.133.124;
 envelope-from=aesteve@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_PASS=-0.001, T_SPF_PERMERROR=0.01 autolearn=ham autolearn_force=no
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

On Fri, Jul 17, 2026 at 12:37=E2=80=AFPM Michael S. Tsirkin <mst@redhat.com=
> wrote:
>
> On Fri, Jul 17, 2026 at 12:32:59PM +0200, Dorinda Bassey wrote:
> > Commit the memory region transaction before sending the SHMEM_MAP reply
> > so the KVM memory slot exists before the guest can access the mapped
> > region.
> >
> > This moves the commit to while the backend is still blocked waiting for
> > the reply, which can trigger ADD_MEM_REG back to the backend and
> > deadlock. Filter shmem mapping regions out of vhost_section() by
> > checking the MR owner type to prevent this.
> >
> > The explicit transaction begin/commit wrapping is dropped since
> > virtio_add_shmem_map() already commits via memory_region_add_subregion(=
).
> >
> > Fixes: b52e1896e764 ("vhost-user: Add VirtIO Shared Memory map request"=
)
> > Suggested-by: Albert Esteve <aesteve@redhat.com>
> > Signed-off-by: Dorinda Bassey <dbassey@redhat.com>
> > ---
> >  hw/virtio/vhost-user.c | 20 ++------------------
> >  hw/virtio/vhost.c      | 10 ++++++++++
> >  2 files changed, 12 insertions(+), 18 deletions(-)
> >
> > diff --git a/hw/virtio/vhost-user.c b/hw/virtio/vhost-user.c
> > index 517cc4ca716..01468f7441a 100644
> > --- a/hw/virtio/vhost-user.c
> > +++ b/hw/virtio/vhost-user.c
> > @@ -1977,8 +1977,6 @@ vhost_user_backend_handle_shmem_map(struct vhost_=
dev *dev,
> >          }
> >      }
> >
> > -    memory_region_transaction_begin();
> > -
> >      /* Create VirtioSharedMemoryMapping object */
> >      VirtioSharedMemoryMapping *mapping =3D virtio_shared_memory_mappin=
g_new(
> >          vu_mmap->shmid, fd, vu_mmap->fd_offset, vu_mmap->shm_offset,
> > @@ -1986,7 +1984,7 @@ vhost_user_backend_handle_shmem_map(struct vhost_=
dev *dev,
> >
> >      if (!mapping) {
> >          ret =3D -EFAULT;
> > -        goto send_reply_commit;
> > +        goto send_reply;
> >      }
> >
> >      /* Add the mapping to the shared memory region */
> > @@ -1994,22 +1992,8 @@ vhost_user_backend_handle_shmem_map(struct vhost=
_dev *dev,
> >          error_report("Failed to add shared memory mapping");
> >          object_unref(OBJECT(mapping));
> >          ret =3D -EFAULT;
> > -        goto send_reply_commit;
> > -    }
> > -
> > -send_reply_commit:
> > -    /* Send reply and commit after transaction started */
> > -    if (hdr->flags & VHOST_USER_NEED_REPLY_MASK) {
> > -        payload->u64 =3D !!ret;
> > -        hdr->size =3D sizeof(payload->u64);
> > -        if (!vhost_user_send_resp(ioc, hdr, payload, &local_err)) {
> > -            error_report_err(local_err);
> > -            memory_region_transaction_commit();
> > -            return -EFAULT;
> > -        }
> > +        goto send_reply;
> >      }
> > -    memory_region_transaction_commit();
> > -    return 0;
> >
> >  send_reply:
> >      if (hdr->flags & VHOST_USER_NEED_REPLY_MASK) {
> > diff --git a/hw/virtio/vhost.c b/hw/virtio/vhost.c
> > index af41841b529..e5c219be095 100644
> > --- a/hw/virtio/vhost.c
> > +++ b/hw/virtio/vhost.c
> > @@ -636,6 +636,16 @@ static bool vhost_section(struct vhost_dev *dev, M=
emoryRegionSection *section)
> >  {
> >      MemoryRegion *mr =3D section->mr;
> >
> > +    /*
> > +     * Skip shmem mapping regions, they are managed via SHMEM_MAP/UNMA=
P.
> > +     * Including them triggers ADD_MEM_REG during the SHMEM_MAP transa=
ction
> > +     * commit, deadlocking the backend.
> > +     */
> > +    if (object_dynamic_cast(memory_region_owner(mr),
> > +                            TYPE_VIRTIO_SHARED_MEMORY_MAPPING)) {
> > +        return false;
> > +    }
> > +
> >      if (memory_region_is_ram(mr) && !memory_region_is_rom(mr)) {
> >          uint8_t dirty_mask =3D memory_region_get_dirty_log_mask(mr);
> >          uint8_t handled_dirty;
>
>
> This all seems risky i have to say.  Is this always map never unmap?

The filter covers both, and this is a good point. For symmetry the
handle_shmem_unmap() should call virtio_del_shmem_map() before
replying.

BR,
Albert.

>
> > --
> > 2.52.0
>


