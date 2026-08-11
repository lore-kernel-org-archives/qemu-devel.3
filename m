Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4AC8AC5AC67
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Aug 2026 07:49:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wthER-0007JF-25; Tue, 11 Aug 2026 03:49:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aesteve@redhat.com>)
 id 1wthEJ-0007Ip-Nc
 for qemu-devel@nongnu.org; Tue, 11 Aug 2026 03:49:01 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aesteve@redhat.com>)
 id 1wthEH-0000o9-QH
 for qemu-devel@nongnu.org; Tue, 11 Aug 2026 03:48:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1786434536;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=D+YokDBqe2kkAkIZcWY1dxZIXtZ+wZDyT19bIEwB80E=;
 b=LignMk35SqPPNt8CEQclTW/6XnbOJ4aIF4APUo3enNS4sUAmH7k0dXn0+SW2ZmqLydcsCC
 +XlB6ZHRzNBV04UD9swiy6OCAdZ6iaOt9FVmkrrcSUGvgLuO83Pvn0q/xma246SX4k2Ofm
 Ad/jKf9cCY1AWOPZiYi4E+Ok0lF+pFY=
Received: from mail-yw1-f199.google.com (mail-yw1-f199.google.com
 [209.85.128.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-665-_Bpe2irrOnWriLkPKkoX6A-1; Tue, 11 Aug 2026 03:48:54 -0400
X-MC-Unique: _Bpe2irrOnWriLkPKkoX6A-1
X-Mimecast-MFC-AGG-ID: _Bpe2irrOnWriLkPKkoX6A_1786434534
Received: by mail-yw1-f199.google.com with SMTP id
 00721157ae682-81f64e9670eso28279277b3.0
 for <qemu-devel@nongnu.org>; Tue, 11 Aug 2026 00:48:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786434534; cv=none;
 d=google.com; s=arc-20260327;
 b=jwz01KktNyb+w89d6pLg2yKp0ECa48ymwxduXEhcya6V/g80DxQHUw+O1F8/r1pbFI
 GXPA5d79UZ13eb/st6ikmWKDBXUwwvDc5e8E5F3qQizj/F4+VBwlXzBCFNkopzI6JCQ8
 6wr1iZkC6y/CRZmC136PO7rFTE+muY2UzYZmd3/JM49X4aRDskJw9sMdNWlP0beJvAMA
 HncgvF+ShGs+xegzKZYd8+Nkocx3K1YOSM77gA4Tr4boVBOisCiQWLKBhEyI6JLhfimK
 mphHALQJ+EJo8UupFkxouE4vliIcgp3noFaQxAPRgjZ877+Tzu5jXP8IBfP3tzXRFLso
 H0kA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=D+YokDBqe2kkAkIZcWY1dxZIXtZ+wZDyT19bIEwB80E=;
 fh=ZNdq7SYvOuLtTIsMG0FtvFyfpcqEj8DYCnxb9pFtz1A=;
 b=at6W0UseQu6wJsICjHb1WjhdpV7VwaRAtoV99k0mqi3h4xT1fN8zJO+PRcbAYdsom9
 KPrlaMhHiioobdesT7hd1FIPX47L3DUn5c7pFInxU058miGDsQ0j7Ybceydr2XOHQCJ0
 qWHR/n6lwqJcL5ZVoVRkKl1IUyVle2MuG7mK9K3HHsFO0OJzoqaLVVAMjaM0e/VmBnz4
 gFZ1YpQC24BDfD5eVxvu0a1onHst2lC0fO0+4szgi5pOl0OZFZM/gBu4Hws7XHBepHX/
 XLNPGjGG/sr7oKejt9WYnBMF6IEKlFHNii1jfOfyULumD8eURBgL27Lq3HDEFGVTFhZY
 FI7A==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1786434534; x=1787039334; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=D+YokDBqe2kkAkIZcWY1dxZIXtZ+wZDyT19bIEwB80E=;
 b=n06H5Wb5zC/dGYDlA2Ev9jbRvoylOTSgVxxW7PxuzEPaBAkMMdw6Ox+06Fca179pBQ
 O7zJ9aj64KGd7RrqR5LaFrJZNZm340nCOnwxly2jeygDKD0zaQpNUpx8QvyPTiFGkSaC
 NVuErAXoiJWOTNXxgOcb4bK4X8lV+EOZ/lux8p+1uHu5szrWBT+d8KvWLwaioJfUML10
 ZUdJLWqIwubT+EFU4LPos3BkcgvJ+ZpV2H5qYDTMx8Ke39Dazc1CD5HIfaUPSmi+CmlL
 YVT8gNVFOa+kVKbGTRnAYiXCT8Fd0pcQZM0XhQN9+Sk6DacvDUzCiYPZAW7Et8qcyph4
 pxBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786434534; x=1787039334;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=D+YokDBqe2kkAkIZcWY1dxZIXtZ+wZDyT19bIEwB80E=;
 b=cT4AUaqCQL2jNb5pvpG7H0mJMshUnYityPlgrWms6IkCsnYKX2xP48+Zls033tlmzv
 d5xB5udhB6AsAUPGYFgaqBLfNLh9DUrw6emBUyP6yv41f7IkgUvAMfonNAxyzfCMtaSJ
 w9aSWD/ZPd71jpNEKwU8qEAAHfYw0Qy6LtK68L6I9Xf6cAD3yg7L5ytpxGj7/qIVjGFK
 ipQZv+PDmfB+4SZ3iW8DLKJAQ8wl9elm6DQkRkhiZrJrzSokDKSMkLs84OX02eBRjscy
 Vm19WVIOHAS17FdhPKoAeLQJL+8RqqUcqEkrLu0Id4VbJ73SD8GkYz4jroU2RIAWaHS1
 ZvZQ==
X-Gm-Message-State: AOJu0YxY23zWahwCTN+bGLz4mxbeZKxmcCQQs/M8LZS7e2AFUcU4jnEf
 lvcsNIScWdXFcKlfaFxZMT6bvZi1bK2kCGmnADuw709tSbA7uqcdVfUmJTKVlySGpzU+m1xJGgU
 5CMQboNoIw2TSnYtCRVRk3vCx2zhsT01/G/eBQYUNjZpejfz4i90T/THoWGCxRqGQPyAKOgF8CR
 5OKVEX2iiXWingzrGsp2whwzpvhPFULcQ=
X-Gm-Gg: AR+sD112EEXsPYFoFol6bf61ZzhsUlYTiVoZLxLjpK8ilsA8m6gcXaSq7dQygCtzojl
 p+EOO9kY+tfUa7qP5njGb3ocWyEuHPnwwONvJycix3zXoz2YRld41LQO733AEpmEQrPZ4AHuwNp
 4ilsQfdOdzlHd+UnXnngRo7oYcYUL7NdZCzrufSfWg0yZjx3bFzr9CMR0=
X-Received: by 2002:a05:690c:9988:b0:7f0:38f7:6ca6 with SMTP id
 00721157ae682-82f215a85dcmr7719027b3.5.1786434533914; 
 Tue, 11 Aug 2026 00:48:53 -0700 (PDT)
X-Received: by 2002:a05:690c:9988:b0:7f0:38f7:6ca6 with SMTP id
 00721157ae682-82f215a85dcmr7718927b3.5.1786434533523; Tue, 11 Aug 2026
 00:48:53 -0700 (PDT)
MIME-Version: 1.0
References: <adxbWKsBtk0YwbByScxXPz9_l5M7DLI6q01STBcfJICPOvOkwk16HKnu70fpfLqv7GbZk8g6s1M8iRvWEL_ixEabh0jipIChe6sGp-fSSB8=@proton.me>
In-Reply-To: <adxbWKsBtk0YwbByScxXPz9_l5M7DLI6q01STBcfJICPOvOkwk16HKnu70fpfLqv7GbZk8g6s1M8iRvWEL_ixEabh0jipIChe6sGp-fSSB8=@proton.me>
From: Albert Esteve <aesteve@redhat.com>
Date: Tue, 11 Aug 2026 09:48:42 +0200
X-Gm-Features: AUfX_mxKtYb6JubDiRl1BF-0-L7wZnmxFNut9BLiavRSKFRUIAFR4C0aOOWLQXA
Message-ID: <CADSE00Lyra3=pCSKO4NOWNSefdJzLsRoz0sFn1CbiGxMXHwpbA@mail.gmail.com>
Subject: Re: [PATCH v2] vhost-user: check memory slot availability for
 SHMEM_MAP
To: Feifan Qian <bea1e@proton.me>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, 
 Stefano Garzarella <sgarzare@redhat.com>, Dorinda Bassey <dbassey@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=aesteve@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.746,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_PASS=-0.001,
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

Hi Feifan,

On Thu, Aug 6, 2026 at 4:14=E2=80=AFPM Feifan Qian <bea1e@proton.me> wrote:
>
> SHMEM_MAP creates a separate RAM MemoryRegion for every mapping. It can
> therefore make a vhost-user memory table exceed the number of slots
> negotiated with the backend.
>
> Reject a mapping before changing the memory topology if KVM or a vhost
> backend has no unreserved slot left. Also validate each memory table
> against the negotiated vhost-user limit as a final defense for mappings
> that become visible in a later memory transaction.
>
> Fixes: b52e1896e764 ("vhost-user: Add VirtIO Shared Memory map request")
> Signed-off-by: Feifan Qian <bea1e@proton.me>
> ---
> Tested with an ASan/UBSan x86_64 build and a vhost-user backend that
> filled the negotiated 512-slot memory table.  The next SHMEM_MAP request
> was rejected and QEMU remained alive, with no sanitizer report.
> qtest-x86_64/qos-test also passed all 134 subtests.
>
>  hw/virtio/vhost-user.c | 18 ++++++++++++++++++
>  1 file changed, 18 insertions(+)
>
> diff --git a/hw/virtio/vhost-user.c b/hw/virtio/vhost-user.c
> index 2881cec72d..3673653f67 100644
> --- a/hw/virtio/vhost-user.c
> +++ b/hw/virtio/vhost-user.c
> @@ -10,6 +10,7 @@
>
>  #include "qemu/osdep.h"
>  #include "qapi/error.h"
> +#include "hw/mem/memory-device.h"
>  #include "hw/virtio/virtio-dmabuf.h"
>  #include "hw/virtio/virtio-qmp.h"
>  #include "hw/virtio/vhost.h"
> @@ -1126,6 +1127,13 @@ static int vhost_user_set_mem_table(struct vhost_d=
ev *dev,
>              dev, VHOST_USER_PROTOCOL_F_CONFIGURE_MEM_SLOTS);
>      int ret;
>
> +    if (mem->nregions > u->user->memory_slots) {
> +        error_report("vhost-user memory table has %u regions, "
> +                     "but the backend supports only %d",
> +                     mem->nregions, u->user->memory_slots);
> +        return -ENOSPC;
> +    }
> +
>      if (do_postcopy) {
>          /*
>           * Postcopy has enough differences that it's best done in it's o=
wn
> @@ -1940,6 +1948,7 @@ vhost_user_backend_handle_shmem_map(struct vhost_de=
v *dev,
>      VhostUserMMap *vu_mmap =3D &payload->mmap;
>      VirtioSharedMemoryMapping *existing;
>      Error *local_err =3D NULL;
> +    unsigned int reserved_memslots;
>      int ret =3D 0;
>
>      if (fd < 0) {
> @@ -1980,6 +1989,15 @@ vhost_user_backend_handle_shmem_map(struct vhost_d=
ev *dev,
>          }
>      }
>
> +    reserved_memslots =3D memory_devices_get_reserved_memslots();
> +    if ((kvm_enabled() &&
> +         kvm_get_free_memslots() <=3D reserved_memslots) ||
> +        vhost_get_free_memslots() <=3D reserved_memslots) {

This is correct with current baseline, but after this[1] series lands
all SHMEM mapping will be filtered by vhost. So this could check
kvm_get_free_memslots() only and avoid reserved_memslots altogether.

Perhaps you could base this series on Dorinda's work above instead?
Actually, the check above is also partially redundant for SHMEM_MAP
regions given the filter in Dorinda's patch. But it's probably still a
valid safety net for ADD_MEM_REG.

[1] https://lore.kernel.org/all/20260717134920.265128-2-dbassey@redhat.com/
[2] https://www.qemu.org/docs/master/devel/submitting-a-patch.html#base-pat=
ches-against-current-git-master

BR,
Albert

> +        error_report("No free memory slots for shared memory mapping");
> +        ret =3D -ENOSPC;
> +        goto send_reply;
> +    }
> +
>      memory_region_transaction_begin();
>
>      /* Create VirtioSharedMemoryMapping object */
> --
> 2.43.0
>


