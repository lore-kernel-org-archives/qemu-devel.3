Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0104C3DA7F
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Aug 2024 04:03:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sbXst-0001oe-QO; Wed, 07 Aug 2024 00:02:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1sbXss-0001ne-2U
 for qemu-devel@nongnu.org; Wed, 07 Aug 2024 00:02:46 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1sbXsp-0005Oe-Q7
 for qemu-devel@nongnu.org; Wed, 07 Aug 2024 00:02:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1723003361;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=L0nrnYo6giFC+FDzlqOOwxOJkGsScJZ8265A/qmPRUw=;
 b=FFxpWn+LKzewB/fRjM17HK+T7Q2+/fUxB+X8WDviBhqVT59X/Km1UiEp1aExmIO8PuZ0jJ
 mBzOpdseiA4hkTkNXdAzfBPJWeSagpGdv0MDbyFgIoTBun8sBLFaT5C5XfCTkeZgnexV0I
 DwNThQC1ar3IqCqdTCjxeLCvMltq6Bw=
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com
 [209.85.210.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-524-SK7lmHCQOfSJCRe-XXq7bw-1; Wed, 07 Aug 2024 00:02:39 -0400
X-MC-Unique: SK7lmHCQOfSJCRe-XXq7bw-1
Received: by mail-pf1-f200.google.com with SMTP id
 d2e1a72fcca58-70d1469f5e1so1540892b3a.3
 for <qemu-devel@nongnu.org>; Tue, 06 Aug 2024 21:02:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723003358; x=1723608158;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=L0nrnYo6giFC+FDzlqOOwxOJkGsScJZ8265A/qmPRUw=;
 b=Mg5PTXnbYdAl4MPBzysX6MMweiuC1vwhEDrcOAzf5BslMq/C4ztKJNtjD0B1xczBKw
 WrZ2PcQUd59sS5AQAyFMHBV6HZeJvKbzpmmMUqIXlzbn1gINZrA87XNM5kaVWto6beLf
 hFRH4kfta284XXOM4ULEw8WeLXs50YFGlRaLEstuGQLIV1uDQ57qOvieQDPNOFvGZkqN
 OYxqFK3n58Jbs4ViqhPnFHDnMxET4/4jqE/xr7nvL8CQY3X6R8lVk5tKa/KCUYPAeUh7
 s0X7yEGG0cbqBAR+E42hGZ+R1C9cydlMur9/OktGEa4DuIyXiHqn0m/B2xlopNZJo8BY
 N2Og==
X-Forwarded-Encrypted: i=1;
 AJvYcCXINqU2wuD8++XyPANu7ofO+6443Xt6J9fBRki3bZsnTZnb4yfDlIorlkw/lqTvHu6w8eObnHegya7Pi1Hzhd83s3/Adgc=
X-Gm-Message-State: AOJu0YzTtIuqoxPxR5Gdeo2ikD0xNx4q5+Qwv7IEYrBqG3R57Ma/M3DL
 PFvWPfjgMfWtXzW5HMy0xTR2NNu/TdPGEv//qWg2RbWIpyjJswLaEhhAk5xKfsT0RDbpCpgDQ0a
 qAVdE+IEM+ncfVlYqwNUVsdkFT+SeT4UKJ1q/xx9wQyU1LghbSxp3Eh3T2HFWLNbP49NOc5HJYW
 b5xc5VOHlFEpNXHFPqecSeb6ZHrCE=
X-Received: by 2002:a05:6a20:729c:b0:1c4:d8ec:b59f with SMTP id
 adf61e73a8af0-1c6995a1f72mr19563598637.25.1723003358217; 
 Tue, 06 Aug 2024 21:02:38 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG300s/yeT3O38Ala3I5ZemnpWsiFU8qQtNMFPMmeziJiLj3QQJ93XWKsI2ZkbzzAxiHcx5ArL6j7L3irH/NWQ=
X-Received: by 2002:a05:6a20:729c:b0:1c4:d8ec:b59f with SMTP id
 adf61e73a8af0-1c6995a1f72mr19563560637.25.1723003357489; Tue, 06 Aug 2024
 21:02:37 -0700 (PDT)
MIME-Version: 1.0
References: <20240806093715.65105-1-lulu@redhat.com>
In-Reply-To: <20240806093715.65105-1-lulu@redhat.com>
From: Jason Wang <jasowang@redhat.com>
Date: Wed, 7 Aug 2024 12:02:26 +0800
Message-ID: <CACGkMEs8T4z1+dMxJ2AotTX6X-Y6POtNX4WLxJxCbe6xes70Ow@mail.gmail.com>
Subject: Re: [PATCH v6] virtio-pci: Fix the use of an uninitialized irqfd
To: Cindy Lu <lulu@redhat.com>
Cc: mst@redhat.com, qemu-devel@nongnu.org, qemu-stable@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=jasowang@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.144,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Tue, Aug 6, 2024 at 5:37=E2=80=AFPM Cindy Lu <lulu@redhat.com> wrote:
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
> The function virtio_pci_get_notifier() can be used in various devices.
> It could also be called when VIRTIO_CONFIG_S_DRIVER_OK is not set. In thi=
s situation,
> the vector_irqfd being NULL is acceptable. We can allow the device contin=
ue to boot
>
> If the vector_irqfd still hasn't been initialized after VIRTIO_CONFIG_S_D=
RIVER_OK
> is set, it means that the function set_guest_notifiers was not called bef=
ore the
> driver started. This indicates that the device is not using the notifier.
> At this point, we will let the check fail.
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

Acked-by: Jason Wang <jasowang@redhat.com>

Thanks


