Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 088DCC3DA59
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jul 2024 07:24:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sVnP9-00023Z-Vj; Mon, 22 Jul 2024 03:24:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1sVnP9-00021L-Ag
 for qemu-devel@nongnu.org; Mon, 22 Jul 2024 03:24:19 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1sVnP7-0002EO-HU
 for qemu-devel@nongnu.org; Mon, 22 Jul 2024 03:24:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1721633056;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=BcMThMO35PnzVfjRBtRLhAasaMeB19h7/noV5EO32wc=;
 b=OJnMIxwwGYxdOL00Ujmj8BIEepFv3Mr3nIfgJulhvnUOvbI+wy+0R1KuBQLeebPBi7BdiJ
 fALBAA1wAkEBCcIKUqnNUH0+eb+GDqE3AaXqoVjV1cc+7ObTHRZQwRKViHsGAgFmLRfI4h
 J/P6jtkidkQEeNeOADa01dQcTKEKOLo=
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com
 [209.85.215.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-426-lrUke3sENPK9O7FkkYWFcQ-1; Mon, 22 Jul 2024 03:24:12 -0400
X-MC-Unique: lrUke3sENPK9O7FkkYWFcQ-1
Received: by mail-pg1-f198.google.com with SMTP id
 41be03b00d2f7-5e4df21f22dso4660303a12.0
 for <qemu-devel@nongnu.org>; Mon, 22 Jul 2024 00:24:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721633052; x=1722237852;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=BcMThMO35PnzVfjRBtRLhAasaMeB19h7/noV5EO32wc=;
 b=DrSrkIKtmrh+fnsXsButI+033OqlpibTGFebI1nVlVpM/PzcTwAmCbNs58tJTKTbvZ
 fWdUkygOupU7vp1kWCNiJkKrVFsyiMThyimZeRXsq8o+uys/dqiEJUPQx+C/CJD4eO8D
 DOjic9bmgdBJ/by6ffp2ipGyc7viWgh+15R5AswHvNC3K33pwxuKCfAPi8srXWBVovz1
 aXlqsHppZFPtt9m7u8MwBbpFo64jn3seYLMxg7aHWdDAlX3LdhZUvFytp+Ua+II3gfF8
 fWdOHgcF0Sr0hOsp0M1fdtiA4mIvPV1qNR66cKPNPfFXnetQVGw5KxWPSPj4XBbwfMEk
 ru1Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCX9nqFe0xGN2lDvKM9M/2smZBUkzVeWIN2jAsd4wh7tevPtFLWaxquPe5ScFXdiCLdyshxplu661gXiSg1D5ohQjtpcGU8=
X-Gm-Message-State: AOJu0YxvZj2nEyKCdNakWT2UV4pMbpqy9XiT+AvgbCbZX2e+wbpCa4MI
 mzd5w1H0n61gnbo/wtHwPgnvXuPA+TjrHRKrXVyKBzlFfpNidtNYvKG622wFOlnhGVHqAwQDAcE
 ddWm4B6UxcX6B0lJcOoci7nF+xaqiAZyWXxhF8RhWv/MLTjYBY6ma91FS8QM3uMnHvVjVAbvPrb
 bTYH5bBCXqns82lj755v4x0ZEeAeA=
X-Received: by 2002:a17:90b:1d08:b0:2cb:5d90:2b9 with SMTP id
 98e67ed59e1d1-2cd16d62831mr10885541a91.11.1721633051611; 
 Mon, 22 Jul 2024 00:24:11 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHcYfhfqF5oUiQInVha9WC7z+6AJ97aON+MO7Pk8XuRtnEGDyMqRHnJ6ghCMFK5+Bip52AxB+j14z4xo48q+jc=
X-Received: by 2002:a17:90b:1d08:b0:2cb:5d90:2b9 with SMTP id
 98e67ed59e1d1-2cd16d62831mr10885512a91.11.1721633050940; Mon, 22 Jul 2024
 00:24:10 -0700 (PDT)
MIME-Version: 1.0
References: <20240719052531.926801-1-lulu@redhat.com>
In-Reply-To: <20240719052531.926801-1-lulu@redhat.com>
From: Jason Wang <jasowang@redhat.com>
Date: Mon, 22 Jul 2024 15:23:59 +0800
Message-ID: <CACGkMEtauhCfYSfFHc-GXAzvXm78fodTpDb-JcoGwfVjCD1qvw@mail.gmail.com>
Subject: Re: [PATCH v5] virtio-pci: Fix the use of an uninitialized irqfd
To: Cindy Lu <lulu@redhat.com>
Cc: mst@redhat.com, qemu-devel@nongnu.org, qemu-stable@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=jasowang@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.141,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Hi Cindy

On Fri, Jul 19, 2024 at 1:25=E2=80=AFPM Cindy Lu <lulu@redhat.com> wrote:
>
> The crash was reported in MAC OS and NixOS, here is the link for this bug
> https://gitlab.com/qemu-project/qemu/-/issues/2334
> https://gitlab.com/qemu-project/qemu/-/issues/2321
>
> In this bug, they are using the virtio_input device. The guest notifier w=
as
> not supported for this device, The function virtio_pci_set_guest_notifier=
s()
> was not called, and the vector_irqfd was not initialized.
>
> So the fix is adding the check for vector_irqfd in virtio_pci_get_notifie=
r()
>
> But The function virtio_pci_get_notifier(),it can also be used in all kin=
ds of device.
> If the vector_irqfd still didn't initial after the VIRTIO_CONFIG_S_DRIVER=
_OK is set
> means this device is not using guest notifier. We can let the check fail =
here
>
> This fix is verified in vyatta,MacOS,NixOS,fedora system.
>
> The bt tree for this bug is:
> Thread 6 "CPU 0/KVM" received signal SIGSEGV, Segmentation fault.
> [Switching to Thread 0x7c817be006c0 (LWP 1269146)]
> kvm_virtio_pci_vq_vector_use () at ../qemu-9.0.0/hw/virtio/virtio-pci.c:8=
17
> 817         if (irqfd->users =3D=3D 0) {
> (gdb) thread apply all bt
> ...
> Thread 6 (Thread 0x7c817be006c0 (LWP 1269146) "CPU 0/KVM"):
> 0  kvm_virtio_pci_vq_vector_use () at ../qemu-9.0.0/hw/virtio/virtio-pci.=
c:817
> 1  kvm_virtio_pci_vector_use_one () at ../qemu-9.0.0/hw/virtio/virtio-pci=
.c:893
> 2  0x00005983657045e2 in memory_region_write_accessor () at ../qemu-9.0.0=
/system/memory.c:497
> 3  0x0000598365704ba6 in access_with_adjusted_size () at ../qemu-9.0.0/sy=
stem/memory.c:573
> 4  0x0000598365705059 in memory_region_dispatch_write () at ../qemu-9.0.0=
/system/memory.c:1528
> 5  0x00005983659b8e1f in flatview_write_continue_step.isra.0 () at ../qem=
u-9.0.0/system/physmem.c:2713
> 6  0x000059836570ba7d in flatview_write_continue () at ../qemu-9.0.0/syst=
em/physmem.c:2743
> 7  flatview_write () at ../qemu-9.0.0/system/physmem.c:2774
> 8  0x000059836570bb76 in address_space_write () at ../qemu-9.0.0/system/p=
hysmem.c:2894
> 9  0x0000598365763afe in address_space_rw () at ../qemu-9.0.0/system/phys=
mem.c:2904
> 10 kvm_cpu_exec () at ../qemu-9.0.0/accel/kvm/kvm-all.c:2917
> 11 0x000059836576656e in kvm_vcpu_thread_fn () at ../qemu-9.0.0/accel/kvm=
/kvm-accel-ops.c:50
> 12 0x0000598365926ca8 in qemu_thread_start () at ../qemu-9.0.0/util/qemu-=
thread-posix.c:541
> 13 0x00007c8185bcd1cf in ??? () at /usr/lib/libc.so.6
> 14 0x00007c8185c4e504 in clone () at /usr/lib/libc.so.6
>
> Fixes: 2ce6cff94d ("virtio-pci: fix use of a released vector")
> Cc: qemu-stable@nongnu.org
> Signed-off-by: Cindy Lu <lulu@redhat.com>
> ---
>  hw/virtio/virtio-pci.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/hw/virtio/virtio-pci.c b/hw/virtio/virtio-pci.c
> index 592fdaa10f..dc31a37ec0 100644
> --- a/hw/virtio/virtio-pci.c
> +++ b/hw/virtio/virtio-pci.c
> @@ -860,6 +860,9 @@ static int virtio_pci_get_notifier(VirtIOPCIProxy *pr=
oxy, int queue_no,
>      VirtIODevice *vdev =3D virtio_bus_get_device(&proxy->bus);
>      VirtQueue *vq;
>
> +    if (!proxy->vector_irqfd && vdev->status & VIRTIO_CONFIG_S_DRIVER_OK=
)
> +        return -1;
> +

Did this mean !proxy->vector_irqfd && !(vdev->status &
VIRTIO_CONFIG_S_DRIVER_OK)) is legal?

Thanks

>      if (queue_no =3D=3D VIRTIO_CONFIG_IRQ_IDX) {
>          *n =3D virtio_config_get_guest_notifier(vdev);
>          *vector =3D vdev->config_vector;
> --
> 2.45.0
>


