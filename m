Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6B7DCA0EEB
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Aug 2025 02:35:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uoYfN-0003rY-76; Tue, 19 Aug 2025 22:35:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1uoYfM-0003pn-4x
 for qemu-devel@nongnu.org; Tue, 19 Aug 2025 22:35:08 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1uoYfK-0001uv-8L
 for qemu-devel@nongnu.org; Tue, 19 Aug 2025 22:35:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1755657305;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=LvBZn7lUEa2OQEkzY3AIHDlQsTiZ8bQufpJGVtLedAw=;
 b=dw7QK2s6/dFApDVTbJjhxtcjHIvZRUuKfSzHGVcZ8kmP5YEqWQdOIThmquq69k+0eqwCbA
 YunzfGTBMbLIbkx/MiNJri0NgT8VP/26hxPzHikYYnt8GAu4H/VCTdtEHy0uOZ4xWbFWUt
 OPOD0GIo9I0WTS7RRF8WrZ+bKm6vGsg=
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com
 [209.85.210.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-664-T16UiUmSMH-zQYe-6FUsHg-1; Tue, 19 Aug 2025 22:35:03 -0400
X-MC-Unique: T16UiUmSMH-zQYe-6FUsHg-1
X-Mimecast-MFC-AGG-ID: T16UiUmSMH-zQYe-6FUsHg_1755657303
Received: by mail-pf1-f197.google.com with SMTP id
 d2e1a72fcca58-76e395107e2so5364593b3a.3
 for <qemu-devel@nongnu.org>; Tue, 19 Aug 2025 19:35:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755657303; x=1756262103;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=LvBZn7lUEa2OQEkzY3AIHDlQsTiZ8bQufpJGVtLedAw=;
 b=Ju5xOpI+G6+a7WMeygMyk+sjfx1zqgw6mZxOuJX/XGjVhJ0IJ06/uwxh58RrV/6K9X
 m5DfhyTVX65QjV5FaYDnoI0OWeY3Yr0AkGBYyvPZ38WnKJklPukXBLS6cFx7Q2tM4+2x
 Go+V0ZPIjVIe7sxuV9h07EQ5bN1HVx7Gd5do6GPLPQW/0HtcuQQDbvRAmpwpsAEEf3FF
 GlMDWea7uiC/H4Xvp8JOjMjM+i+PSj54yHIo00Jsz0KdFoeqnf4PkqCFgCT5CHkZcvyn
 qLY5aUMN3kGNRJdcI2Znl4dm+L8DVi4QqMbIssnaRLOmDSSpD2HBMPFYdegkdjcM3Pd2
 q6ng==
X-Gm-Message-State: AOJu0YzNrjoFANUf5rTh7NBwjPX2FAdXvq9CNxdDzLh2lBzJAOjXnF2B
 pxE+ZzNdo4A0MYksAPP4HWXApO3zxzq3EsPQadFdQwNDj8wb1+r4fG5LlrdVviFGZzoCUe0W+kR
 HxH2NIy6yk/ZQcAH1KbyY2BxIdecgREbpnjbQ3Va2CSt1M0dIFVdTsN/zNbrkh7IeiJej/0gLWb
 vQ3dcrwvXZ41bSCp3AgP/FLjdca2sip3w=
X-Gm-Gg: ASbGncvbxMasNPObm0s9XH0flwEccjoVN7m7i304bkEMmhSU9rZTExLy0ubJWvUU0Ty
 XeKiOiBbEyVyGOouZjDAoERpekDB19BsHXoT51ITrB8Q13gTO8sjOpvc5uJVZHXvc6qgV5BlxdB
 MrEiNnIU2rFswCJ7L7b8kgwNU=
X-Received: by 2002:a05:6a20:258a:b0:240:2371:cffd with SMTP id
 adf61e73a8af0-2431b7b40c2mr2153504637.7.1755657302653; 
 Tue, 19 Aug 2025 19:35:02 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF2V4tsN1a2IKrUN4roPZdCkaRJWC/iiBTvc5hOpdNMndrM4t4LF1NuLrd3jmePq9Zp64wmqDX9V3Rz+L5OIm8=
X-Received: by 2002:a05:6a20:258a:b0:240:2371:cffd with SMTP id
 adf61e73a8af0-2431b7b40c2mr2153476637.7.1755657302131; Tue, 19 Aug 2025
 19:35:02 -0700 (PDT)
MIME-Version: 1.0
References: <20250310122240.2908-1-jasowang@redhat.com>
 <20250310122240.2908-3-jasowang@redhat.com>
 <29e31b2d06036441ede4ccb2d2bd22a6c1ba33ae.camel@infradead.org>
In-Reply-To: <29e31b2d06036441ede4ccb2d2bd22a6c1ba33ae.camel@infradead.org>
From: Jason Wang <jasowang@redhat.com>
Date: Wed, 20 Aug 2025 10:34:51 +0800
X-Gm-Features: Ac12FXxXcLs1ksGO_K2EbQsq_F1NtmsTxKJFtNKpi9BBZA0gfjpj7YhI6PNCEOA
Message-ID: <CACGkMEsuE8HC=s2HTWj+p=T8haOxHPhSj6w4==k-pvzKjwrKqw@mail.gmail.com>
Subject: Re: [PULL 2/5] net: move backend cleanup to NIC cleanup
To: =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
 Jonah Palmer <jonah.palmer@oracle.com>
Cc: qemu-devel@nongnu.org, Lei Yang <leiyang@redhat.com>, 
 David Woodhouse <dwmw2@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=jasowang@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

On Wed, Aug 20, 2025 at 12:13=E2=80=AFAM David Woodhouse <dwmw2@infradead.o=
rg> wrote:
>
> On Mon, 2025-03-10 at 20:22 +0800, Jason Wang wrote:
> > From: Eugenio P=C3=A9rez <eperezma@redhat.com>
> >
> > Commit a0d7215e33 ("vhost-vdpa: do not cleanup the vdpa/vhost-net
> > structures if peer nic is present") effectively delayed the backend
> > cleanup, allowing the frontend or the guest to access it resources as
> > long as the frontend is still visible to the guest.
> >
> > However it does not clean up the resources until the qemu process is
> > over.  This causes an effective leak if the device is deleted with
> > device_del, as there is no way to close the vdpa device.  This makes
> > impossible to re-add that device to this or other QEMU instances until
> > the first instance of QEMU is finished.
> >
> > Move the cleanup from qemu_cleanup to the NIC deletion and to
> > net_cleanup.
> >
> > Fixes: a0d7215e33 ("vhost-vdpa: do not cleanup the vdpa/vhost-net struc=
tures if peer nic is present")
> > Reported-by: Lei Yang <leiyang@redhat.com>
> > Signed-off-by: Eugenio P=C3=A9rez <eperezma@redhat.com>
> > Signed-off-by: Jonah Palmer <jonah.palmer@oracle.com>
> > Signed-off-by: Jason Wang <jasowang@redhat.com>
>
> This crashes QEMU when I launch an emulated Xen guest with a Xen PV
> NIC, and quit (using Ctrl-A x on the monitor).

Eugenio and Jonah, any thoughts on this? It looks like the code
doesn't deal with hub correctly.

Thanks

>
> $ gdb --args  ./qemu-system-x86_64 --accel kvm,xen-version=3D0x40011,kern=
el-irqchip=3Dsplit -serial mon:stdio     -display none  -m 1G  -kernel /boo=
t/vmlinuz-6.13.8-200.fc41.x86_64/boot/vmlinuz-6.13.8-200.fc41.x86_64 -appen=
d "console=3DttyS0"
> (gdb) handle SIGUSR1 pass nostop noprint
> (gdb) run
> [    0.000000] Linux version 6.13.8-200.fc41.x86_64 (mockbuild@cdcecfee8b=
71420eb7f55566b7811804) (gcc (GCC) 14.2.1 20250110 (Red Hat 14.2.1-7), GNU =
ld version 2.43.1-5.fc41) #1 SMP PREEMPT_DYNAMIC Sun Mar 23 05:03:09 UTC 20=
25[    0.000000] Linux version 6.13.8-200.fc41.x86_64 (mockbuild@cdcecfee8b=
71420eb7f55566b7811804) (gcc (GCC) 14.2.1 20250110 (Red Hat 14.2.1-7), GNU =
ld version 2.43.1-5.fc41) #1 SMP PREEMPT_DYNAMIC Sun Mar 23 05:03:09 UTC 20=
25
> [    0.000000] Command line: console=3DttyS0
> [    0.000000] BIOS-provided physical RAM map:
> [    0.000000] BIOS-e820: [mem 0x0000000000000000-0x000000000009fbff] usa=
ble
> [    0.000000] BIOS-e820: [mem 0x000000000009fc00-0x000000000009ffff] res=
erved
> [    0.000000] BIOS-e820: [mem 0x00000000000f0000-0x00000000000fffff] res=
erved
> [    0.000000] BIOS-e820: [mem 0x0000000000100000-0x000000003ffdffff] usa=
ble
> [    0.000000] BIOS-e820: [mem 0x000000003ffe0000-0x000000003fffffff] res=
erved
> [    0.000000] BIOS-e820: [mem 0x00000000feff8000-0x00000000feffffff] res=
erved
> [    0.000000] BIOS-e820: [mem 0x00000000fffc0000-0x00000000ffffffff] res=
erved
> [    0.000000] NX (Execute Disable) protection: active
> [    0.000000] APIC: Static calls initialized
> [    0.000000] SMBIOS 2.8 present.
> [    0.000000] DMI: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.16=
.3-0-ga6ed6b701f0a-prebuilt.qemu.org 04/01/2014
> [    0.000000] DMI: Memory slots populated: 1/1
> [    0.000000] Hypervisor detected: Xen HVM
> =E2=80=A6
> <Ctrl-A x>
> Thread 1 "qemu-system-x86" received signal SIGSEGV, Segmentation fault.
> 0x000055555584821c in net_hub_port_cleanup (nc=3D0x555557ce23d0) at ../ne=
t/hub.c:132
> 132         QLIST_REMOVE(port, next);
> (gdb) bt
> #0  0x000055555584821c in net_hub_port_cleanup (nc=3D0x555557ce23d0) at .=
./net/hub.c:132
> #1  0x000055555584a8c9 in qemu_cleanup_net_client (nc=3D<optimized out>, =
remove_from_net_clients=3Dfalse)
>     at ../net/net.c:392
> #2  qemu_del_nic (nic=3D0x555558866400) at ../net/net.c:476
> #3  0x00005555557cae41 in xen_device_unrealize (dev=3D<optimized out>) at=
 ../hw/xen/xen-bus.c:988
> #4  0x0000555555c414ff in notifier_list_notify
>     (list=3Dlist@entry=3D0x5555570671f0 <exit_notifiers>, data=3Ddata@ent=
ry=3D0x0) at ../util/notify.c:39
> #5  0x00005555557efd2c in qemu_run_exit_notifiers () at ../system/runstat=
e.c:854
> #6  0x00007ffff52996c1 in __run_exit_handlers () at /lib64/libc.so.6
> #7  0x00007ffff529978e in exit () at /lib64/libc.so.6
> #8  0x0000555555b90a5c in qemu_default_main (opaque=3Dopaque@entry=3D0x0)=
 at ../system/main.c:52
> #9  0x00005555555622d0 in main (argc=3D<optimized out>, argv=3D<optimized=
 out>) at ../system/main.c:76
>


