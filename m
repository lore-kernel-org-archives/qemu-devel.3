Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45BFAC2BD09
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Jun 2024 02:01:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sLvUb-0005oY-3p; Mon, 24 Jun 2024 22:01:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yong.huang@smartx.com>)
 id 1sLvUY-0005oD-7I
 for qemu-devel@nongnu.org; Mon, 24 Jun 2024 22:01:06 -0400
Received: from mail-oa1-x2c.google.com ([2001:4860:4864:20::2c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <yong.huang@smartx.com>)
 id 1sLvUS-0002Gm-TD
 for qemu-devel@nongnu.org; Mon, 24 Jun 2024 22:01:05 -0400
Received: by mail-oa1-x2c.google.com with SMTP id
 586e51a60fabf-24542b8607fso2503009fac.1
 for <qemu-devel@nongnu.org>; Mon, 24 Jun 2024 18:58:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=smartx-com.20230601.gappssmtp.com; s=20230601; t=1719280737; x=1719885537;
 darn=nongnu.org; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=TF8shNaT/QLWQC7VdF+da0g+s7RS8KsUomYGgRDrh8c=;
 b=amH2G00OLythSm1jQv28wuZPLjrVm3GeJ1WsEtMY0H3iO2pCsyoVlHAnUoSYn7lgq9
 LUls5b/vveX88JlftYwuE0CTv0DhZWVDEP3Qocc+oDg9xOhSqmirwSWKdI76BBC320aU
 Mua1/p4tamxAV6wcTQyjickMuVIz0PRL1EejbuWRt3ERgpc6EbEpWq4EkuaYtYhXoXoq
 WnCxO6DVODXtVe5E0NUF59VRHyVfzsA+6IvqJGuUuIUhrjdyF2TkiYPfPOEj68Wo9MSi
 6sEiISUK7Ics1/do0FXy0XFFab0NPV1awT0DX+WeNtKQEBNUtN/nqOE3xopgq0F90TME
 PyJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719280737; x=1719885537;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=TF8shNaT/QLWQC7VdF+da0g+s7RS8KsUomYGgRDrh8c=;
 b=ANeYca7peVfuqP9WOPPatqd/qEGsi70yCFdLTAxt8b/NLvT+wHZLTqQf5smK0TtFxX
 CA/12Wl5twJrWE072mXFEerVigzb10IPHxORLceCiCSw5AcEbKyImlkx5lsAaISZ/p7F
 e9MwYnrkcHzMIU2gTEEfJ1aK97dIbfFRUZpsgFG4vCGBUsuBXlTGvK2FP12lDU1IPGio
 oeewsAlyweaDCMt0DpvUeOJfZzwIFbbw2VvyASTQ+ObZdSK167ID7RKi1Ig8vN2mWk9S
 7Lsq4wUWEOTwE4bHay1RnDCEzcbnaqe8d8pL60i28IC4C4ujEE89ZhSYF4JHWwvi7v0Z
 cbGg==
X-Forwarded-Encrypted: i=1;
 AJvYcCW8/URpkyOWvz58DAyJd7yxrKCokup8f9CTZzWpNncm7nHyeUB5GJJspcJulcsp63XCSP6peLyyoIZ74z4JU+0RHwbKo4E=
X-Gm-Message-State: AOJu0YzJFdC07gkK4K3/6Ah1yVTkcPACeXl4a30mELhc6e7OBdzSl+hC
 vNWMbRQzNiqe98+FTMNHuELjuh5Wsjv3F4hBjFmDwq0iw1hZW5GGdCZ7mIRTe20OU2dpSH7WDqO
 DaOoElalp5VKAI26OhmldWcosMfJMmGK+8hLFPg==
X-Google-Smtp-Source: AGHT+IHADYNk1qnQuGUShedQqDrAHE9QoyUoj/hc30aM+8jUt2u1+ZFi5C3UavD3wxfBoUXVCgawhQHwg5zD64meWes=
X-Received: by 2002:a05:6871:154:b0:251:109:98f4 with SMTP id
 586e51a60fabf-25d06e36745mr7172990fac.47.1719280736139; Mon, 24 Jun 2024
 18:58:56 -0700 (PDT)
MIME-Version: 1.0
References: <20240610170252.26516-1-pbonzini@redhat.com>
 <b625d08e-e65f-4da4-818d-bbc4e2015122@redhat.com>
In-Reply-To: <b625d08e-e65f-4da4-818d-bbc4e2015122@redhat.com>
From: Yong Huang <yong.huang@smartx.com>
Date: Tue, 25 Jun 2024 09:58:40 +0800
Message-ID: <CAK9dgmYbuQnX1ny=R3C6705dS5D1tv9vBVmkuqXzH=6GzkybpQ@mail.gmail.com>
Subject: Re: [PATCH v2] scsi-disk: Fix crash for VM configured with USB CDROM
 after live migration
To: Thomas Huth <thuth@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Content-Type: multipart/alternative; boundary="0000000000008c15fe061bad3de3"
Received-SPF: none client-ip=2001:4860:4864:20::2c;
 envelope-from=yong.huang@smartx.com; helo=mail-oa1-x2c.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

--0000000000008c15fe061bad3de3
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 24, 2024 at 6:06=E2=80=AFPM Thomas Huth <thuth@redhat.com> wrot=
e:

> On 10/06/2024 19.02, Paolo Bonzini wrote:
> > From: Hyman Huang <yong.huang@smartx.com>
> >
> > For VMs configured with the USB CDROM device:
> >
> > -drive
> file=3D/path/to/local/file,id=3Ddrive-usb-disk0,media=3Dcdrom,readonly=3D=
on...
> > -device usb-storage,drive=3Ddrive-usb-disk0,id=3Dusb-disk0...
> >
> > QEMU process may crash after live migration, to reproduce the issue,
> > configure VM (Guest OS ubuntu 20.04 or 21.10) with the following XML:
> >
> > <disk type=3D'file' device=3D'cdrom'>
> >    <driver name=3D'qemu' type=3D'raw'/>
> >    <source file=3D'/path/to/share_fs/cdrom.iso'/>
> >    <target dev=3D'sda' bus=3D'usb'/>
> >    <readonly/>
> >    <address type=3D'usb' bus=3D'0' port=3D'2'/>
> > </disk>
> > <controller type=3D'usb' index=3D'0' model=3D'piix3-uhci'/>
> >
> > Do the live migration repeatedly, crash may happen after live migratoin=
,
> > trace log at the source before live migration is as follows:
> >
> > 324808@1711972823.521945:usb_uhci_frame_start nr 319
> > 324808@1711972823.521978:usb_uhci_qh_load qh 0x35cb5400
> > 324808@1711972823.521989:usb_uhci_qh_load qh 0x35cb5480
> > 324808@1711972823.521997:usb_uhci_td_load qh 0x35cb5480, td 0x35cbe000,
> ctrl 0x0, token 0xffe07f69
> > 324808@1711972823.522010:usb_uhci_td_nextqh qh 0x35cb5480, td 0x35cbe00=
0
> > 324808@1711972823.522022:usb_uhci_qh_load qh 0x35cb5680
> > 324808@1711972823.522030:usb_uhci_td_load qh 0x35cb5680, td 0x75ac5180,
> ctrl 0x19800000, token 0x3c903e1
> > 324808@1711972823.522045:usb_uhci_packet_add token 0x103e1, td
> 0x75ac5180
> > 324808@1711972823.522056:usb_packet_state_change bus 0, port 2, ep 2,
> packet 0x559f9ba14b00, state undef -> setup
> > 324808@1711972823.522079:usb_msd_cmd_submit lun 0, tag 0x472, flags
> 0x00000080, len 10, data-len 8
> > 324808@1711972823.522107:scsi_req_parsed target 0 lun 0 tag 1138
> command 74 dir 1 length 8
> > 324808@1711972823.522124:scsi_req_parsed_lba target 0 lun 0 tag 1138
> command 74 lba 4096
> > 324808@1711972823.522139:scsi_req_alloc target 0 lun 0 tag 1138
> > 324808@1711972823.522169:scsi_req_continue target 0 lun 0 tag 1138
> > 324808@1711972823.522181:scsi_req_data target 0 lun 0 tag 1138 len 8
> > 324808@1711972823.522194:usb_packet_state_change bus 0, port 2, ep 2,
> packet 0x559f9ba14b00, state setup -> complete
> > 324808@1711972823.522209:usb_uhci_packet_complete_success token
> 0x103e1, td 0x75ac5180
> > 324808@1711972823.522219:usb_uhci_packet_del token 0x103e1, td
> 0x75ac5180
> > 324808@1711972823.522232:usb_uhci_td_complete qh 0x35cb5680, td
> 0x75ac5180
> >
> > trace log at the destination after live migration is as follows:
> >
> > 3286206@1711972823.951646:usb_uhci_frame_start nr 320
> > 3286206@1711972823.951663:usb_uhci_qh_load qh 0x35cb5100
> > 3286206@1711972823.951671:usb_uhci_qh_load qh 0x35cb5480
> > 3286206@1711972823.951680:usb_uhci_td_load qh 0x35cb5480, td
> 0x35cbe000, ctrl 0x1000000, token 0xffe07f69
> > 3286206@1711972823.951693:usb_uhci_td_nextqh qh 0x35cb5480, td
> 0x35cbe000
> > 3286206@1711972823.951702:usb_uhci_qh_load qh 0x35cb5700
> > 3286206@1711972823.951709:usb_uhci_td_load qh 0x35cb5700, td
> 0x75ac5240, ctrl 0x39800000, token 0xe08369
> > 3286206@1711972823.951727:usb_uhci_queue_add token 0x8369
> > 3286206@1711972823.951735:usb_uhci_packet_add token 0x8369, td
> 0x75ac5240
> > 3286206@1711972823.951746:usb_packet_state_change bus 0, port 2, ep 1,
> packet 0x56066b2fb5a0, state undef -> setup
> > 3286206@1711972823.951766:usb_msd_data_in 8/8 (scsi 8)
> > 2024-04-01 12:00:24.665+0000: shutting down, reason=3Dcrashed
> >
> > The backtrace reveals the following:
> >
> > Program terminated with signal SIGSEGV, Segmentation fault.
> > 0  __memmove_sse2_unaligned_erms () at
> ../sysdeps/x86_64/multiarch/memmove-vec-unaligned-erms.S:312
> > 312        movq    -8(%rsi,%rdx), %rcx
> > [Current thread is 1 (Thread 0x7f0a9025fc00 (LWP 3286206))]
> > (gdb) bt
> > 0  __memmove_sse2_unaligned_erms () at
> ../sysdeps/x86_64/multiarch/memmove-vec-unaligned-erms.S:312
> > 1  memcpy (__len=3D8, __src=3D<optimized out>, __dest=3D<optimized out>=
) at
> /usr/include/bits/string_fortified.h:34
> > 2  iov_from_buf_full (iov=3D<optimized out>, iov_cnt=3D<optimized out>,
> offset=3D<optimized out>, buf=3D0x0, bytes=3Dbytes@entry=3D8) at ../util/=
iov.c:33
> > 3  iov_from_buf (bytes=3D8, buf=3D<optimized out>, offset=3D<optimized =
out>,
> iov_cnt=3D<optimized out>, iov=3D<optimized out>)
> >     at
> /usr/src/debug/qemu-6-6.2.0-75.7.oe1.smartx.git.40.x86_64/include/qemu/io=
v.h:49
> > 4  usb_packet_copy (p=3Dp@entry=3D0x56066b2fb5a0, ptr=3D<optimized out>=
,
> bytes=3Dbytes@entry=3D8) at ../hw/usb/core.c:636
> > 5  usb_msd_copy_data (s=3Ds@entry=3D0x56066c62c770, p=3Dp@entry=3D0x560=
66b2fb5a0)
> at ../hw/usb/dev-storage.c:186
> > 6  usb_msd_handle_data (dev=3D0x56066c62c770, p=3D0x56066b2fb5a0) at
> ../hw/usb/dev-storage.c:496
> > 7  usb_handle_packet (dev=3D0x56066c62c770, p=3Dp@entry=3D0x56066b2fb5a=
0) at
> ../hw/usb/core.c:455
> > 8  uhci_handle_td (s=3Ds@entry=3D0x56066bd5f210, q=3D0x56066bb7fbd0, q@=
entry=3D0x0,
> qh_addr=3Dqh_addr@entry=3D902518530, td=3Dtd@entry=3D0x7fffe6e788f0,
> td_addr=3D<optimized out>,
> >     int_mask=3Dint_mask@entry=3D0x7fffe6e788e4) at ../hw/usb/hcd-uhci.c=
:885
> > 9  uhci_process_frame (s=3Ds@entry=3D0x56066bd5f210) at
> ../hw/usb/hcd-uhci.c:1061
> > 10 uhci_frame_timer (opaque=3Dopaque@entry=3D0x56066bd5f210) at
> ../hw/usb/hcd-uhci.c:1159
> > 11 timerlist_run_timers (timer_list=3D0x56066af26bd0) at
> ../util/qemu-timer.c:642
> > 12 qemu_clock_run_timers (type=3DQEMU_CLOCK_VIRTUAL) at
> ../util/qemu-timer.c:656
> > 13 qemu_clock_run_all_timers () at ../util/qemu-timer.c:738
> > 14 main_loop_wait (nonblocking=3Dnonblocking@entry=3D0) at
> ../util/main-loop.c:542
> > 15 qemu_main_loop () at ../softmmu/runstate.c:739
> > 16 main (argc=3D<optimized out>, argv=3D<optimized out>, envp=3D<optimi=
zed
> out>) at ../softmmu/main.c:52
> > (gdb) frame 5
> > (gdb) p ((SCSIDiskReq *)s->req)->iov
> > $1 =3D {iov_base =3D 0x0, iov_len =3D 0}
> > (gdb) p/x s->req->tag
> > $2 =3D 0x472
> >
> > When designing the USB mass storage device model, QEMU places SCSI disk
> > device as the backend of USB mass storage device. In addition, USB mass
> > device driver in Guest OS conforms to the "Universal Serial Bus Mass
> > Storage Class Bulk-Only Transport" specification in order to simulate
> > the transform behavior between a USB controller and a USB mass device.
> > The following shows the protocol hierarchy:
> >
> >                        +----------------+
> >   CDROM driver         |  scsi command  |        CDROM
> >                        +----------------+
> >
> >                     +-----------------------+
> >   USB mass          | USB Mass Storage Class|    USB mass
> >   storage driver    | Bulk-Only Transport   |    storage device
> >                     +-----------------------+
> >
> >                        +----------------+
> >   USB Controller       |  USB Protocol  |        USB device
> >                        +----------------+
> >
> > In the USB protocol layer, between the USB controller and USB device, a=
t
> > least two USB packets will be transformed when guest OS send a
> > read operation to USB mass storage device:
> >
> > 1. The CBW packet, which will be delivered to the USB device's Bulk-Out
> > endpoint. In order to simulate a read operation, the USB mass storage
> > device parses the CBW and converts it to a SCSI command, which would be
> > executed by CDROM(represented as SCSI disk in QEMU internally), and sto=
re
> > the result data of the SCSI command in a buffer.
> >
> > 2. The DATA-IN packet, which will be delivered from the USB device's
> > Bulk-In endpoint(fetched directly from the preceding buffer) to the USB
> > controller.
> >
> > We consider UHCI to be the controller. The two packets mentioned above
> may
> > have been processed by UHCI in two separate frame entries of the Frame
> List
> > , and also described by two different TDs. Unlike the physical
> environment,
> > a virtualized environment requires the QEMU to make sure that the resul=
t
> > data of CBW is not lost and is delivered to the UHCI controller.
> >
> > Currently, these types of SCSI requests are not migrated, so QEMU canno=
t
> > ensure the result data of the IO operation is not lost if there are
> > inflight emulated SCSI requests during the live migration.
> >
> > Assume for the moment that the USB mass storage device is processing th=
e
> > CBW and storing the result data of the read operation to a buffre, live
> > migration happens and moves the VM to the destination while not migrati=
ng
> > the result data of the read operation.
> >
> > After migration, when UHCI at the destination issues a DATA-IN request =
to
> > the USB mass storage device, a crash happens because USB mass storage
> device
> > fetches the result data and get nothing.
> >
> > The scenario this patch addresses is this one.
> >
> > Theoretically, any device that uses the SCSI disk as a back-end would b=
e
> > affected by this issue. In this case, it is the USB CDROM.
> >
> > To fix it, inflight emulated SCSI request be migrated during live
> migration,
> > similar to the DMA SCSI request.
> >
> > Signed-off-by: Hyman Huang <yong.huang@smartx.com>
> > Message-ID: <
> 878c8f093f3fc2f584b5c31cb2490d9f6a12131a.1716531409.git.yong.huang@smartx=
.com
> >
> > [Do not bump migration version, introduce compat property instead. -
> Paolo]
> > Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> > ---
> >   hw/core/machine.c   |  1 +
> >   hw/scsi/scsi-disk.c | 24 +++++++++++++++++++++++-
> >   2 files changed, 24 insertions(+), 1 deletion(-)
> >
> > diff --git a/hw/core/machine.c b/hw/core/machine.c
> > index c93d2492443..655d75c21fc 100644
> > --- a/hw/core/machine.c
> > +++ b/hw/core/machine.c
> > @@ -36,6 +36,7 @@
> >
> >   GlobalProperty hw_compat_9_0[] =3D {
> >       {"arm-cpu", "backcompat-cntfrq", "true" },
> > +    {"scsi-disk-base", "migrate-emulated-scsi-request", "false" },
> >       {"vfio-pci", "skip-vsc-check", "false" },
> >   };
>
>   Hi Paolo, hi Hyman,
>
> this patch introduced a problem with device introspection on older machin=
e
> types. Running "make check-qtest SPEED=3Dslow" is now failing for older
> machine types.
>
> Or if you want to reproduce it manually:
>
>   $ ./qemu-system-x86_64 -M pc-q35-8.0 -monitor stdio
>   QEMU 9.0.50 monitor - type 'help' for more information
>   (qemu) device_add scsi-block,help
>   Unexpected error in object_property_find_err() at
>   ../../devel/qemu/qom/object.c:1357:
>   can't apply global scsi-disk-base.migrate-emulated-scsi-request=3Dfalse=
:
>   Property 'scsi-block.migrate-emulated-scsi-request' not found
>   Aborted (core dumped)
>
> I think the problem is that the property is only added to certain SCSI
> devices via the DEFINE_SCSI_DISK_PROPERTIES macro, but "scsi-block" devic=
e
> does not use this macro and thus does not have this property. So when the
> compat code tries to set this property for "scsi-block" (which is also
> derived from "scsi-disk-base"), it fails, of course.
>
"scsi-block" appears to handle two different types of devices:
passthrough-ed block devices and scsi-block devices.

Since each of them is capable of supporting the load/save scsi request,
and this patchset does not address any problems for them.

So, IMHO, The "scsi-disk-base" class may not be the best place for the
"migrate-emulated-scsi-request" attribute?


>
> Should the "migrate-emulated-scsi-request" property maybe rather be added
> to
> the "scsi-disk-base" class instead? Or should hw_compat_9_0 rather list
> the
> devices that have the property instead of using the parent class? Could
> you
> please have a look?
>
>   Thanks,
>    Thomas
>
>

--=20
Best regards

--0000000000008c15fe061bad3de3
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><div class=3D"gmail_default" style=3D"fon=
t-family:&quot;comic sans ms&quot;,sans-serif"><br></div></div><br><div cla=
ss=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">On Mon, Jun 24, 20=
24 at 6:06=E2=80=AFPM Thomas Huth &lt;<a href=3D"mailto:thuth@redhat.com">t=
huth@redhat.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" s=
tyle=3D"margin:0px 0px 0px 0.8ex;border-left-width:1px;border-left-style:so=
lid;border-left-color:rgb(204,204,204);padding-left:1ex">On 10/06/2024 19.0=
2, Paolo Bonzini wrote:<br>
&gt; From: Hyman Huang &lt;<a href=3D"mailto:yong.huang@smartx.com" target=
=3D"_blank">yong.huang@smartx.com</a>&gt;<br>
&gt; <br>
&gt; For VMs configured with the USB CDROM device:<br>
&gt; <br>
&gt; -drive file=3D/path/to/local/file,id=3Ddrive-usb-disk0,media=3Dcdrom,r=
eadonly=3Don...<br>
&gt; -device usb-storage,drive=3Ddrive-usb-disk0,id=3Dusb-disk0...<br>
&gt; <br>
&gt; QEMU process may crash after live migration, to reproduce the issue,<b=
r>
&gt; configure VM (Guest OS ubuntu 20.04 or 21.10) with the following XML:<=
br>
&gt; <br>
&gt; &lt;disk type=3D&#39;file&#39; device=3D&#39;cdrom&#39;&gt;<br>
&gt;=C2=A0 =C2=A0 &lt;driver name=3D&#39;qemu&#39; type=3D&#39;raw&#39;/&gt=
;<br>
&gt;=C2=A0 =C2=A0 &lt;source file=3D&#39;/path/to/share_fs/cdrom.iso&#39;/&=
gt;<br>
&gt;=C2=A0 =C2=A0 &lt;target dev=3D&#39;sda&#39; bus=3D&#39;usb&#39;/&gt;<b=
r>
&gt;=C2=A0 =C2=A0 &lt;readonly/&gt;<br>
&gt;=C2=A0 =C2=A0 &lt;address type=3D&#39;usb&#39; bus=3D&#39;0&#39; port=
=3D&#39;2&#39;/&gt;<br>
&gt; &lt;/disk&gt;<br>
&gt; &lt;controller type=3D&#39;usb&#39; index=3D&#39;0&#39; model=3D&#39;p=
iix3-uhci&#39;/&gt;<br>
&gt; <br>
&gt; Do the live migration repeatedly, crash may happen after live migratoi=
n,<br>
&gt; trace log at the source before live migration is as follows:<br>
&gt; <br>
&gt; 324808@1711972823.521945:usb_uhci_frame_start nr 319<br>
&gt; 324808@1711972823.521978:usb_uhci_qh_load qh 0x35cb5400<br>
&gt; 324808@1711972823.521989:usb_uhci_qh_load qh 0x35cb5480<br>
&gt; 324808@1711972823.521997:usb_uhci_td_load qh 0x35cb5480, td 0x35cbe000=
, ctrl 0x0, token 0xffe07f69<br>
&gt; 324808@1711972823.522010:usb_uhci_td_nextqh qh 0x35cb5480, td 0x35cbe0=
00<br>
&gt; 324808@1711972823.522022:usb_uhci_qh_load qh 0x35cb5680<br>
&gt; 324808@1711972823.522030:usb_uhci_td_load qh 0x35cb5680, td 0x75ac5180=
, ctrl 0x19800000, token 0x3c903e1<br>
&gt; 324808@1711972823.522045:usb_uhci_packet_add token 0x103e1, td 0x75ac5=
180<br>
&gt; 324808@1711972823.522056:usb_packet_state_change bus 0, port 2, ep 2, =
packet 0x559f9ba14b00, state undef -&gt; setup<br>
&gt; 324808@1711972823.522079:usb_msd_cmd_submit lun 0, tag 0x472, flags 0x=
00000080, len 10, data-len 8<br>
&gt; 324808@1711972823.522107:scsi_req_parsed target 0 lun 0 tag 1138 comma=
nd 74 dir 1 length 8<br>
&gt; 324808@1711972823.522124:scsi_req_parsed_lba target 0 lun 0 tag 1138 c=
ommand 74 lba 4096<br>
&gt; 324808@1711972823.522139:scsi_req_alloc target 0 lun 0 tag 1138<br>
&gt; 324808@1711972823.522169:scsi_req_continue target 0 lun 0 tag 1138<br>
&gt; 324808@1711972823.522181:scsi_req_data target 0 lun 0 tag 1138 len 8<b=
r>
&gt; 324808@1711972823.522194:usb_packet_state_change bus 0, port 2, ep 2, =
packet 0x559f9ba14b00, state setup -&gt; complete<br>
&gt; 324808@1711972823.522209:usb_uhci_packet_complete_success token 0x103e=
1, td 0x75ac5180<br>
&gt; 324808@1711972823.522219:usb_uhci_packet_del token 0x103e1, td 0x75ac5=
180<br>
&gt; 324808@1711972823.522232:usb_uhci_td_complete qh 0x35cb5680, td 0x75ac=
5180<br>
&gt; <br>
&gt; trace log at the destination after live migration is as follows:<br>
&gt; <br>
&gt; 3286206@1711972823.951646:usb_uhci_frame_start nr 320<br>
&gt; 3286206@1711972823.951663:usb_uhci_qh_load qh 0x35cb5100<br>
&gt; 3286206@1711972823.951671:usb_uhci_qh_load qh 0x35cb5480<br>
&gt; 3286206@1711972823.951680:usb_uhci_td_load qh 0x35cb5480, td 0x35cbe00=
0, ctrl 0x1000000, token 0xffe07f69<br>
&gt; 3286206@1711972823.951693:usb_uhci_td_nextqh qh 0x35cb5480, td 0x35cbe=
000<br>
&gt; 3286206@1711972823.951702:usb_uhci_qh_load qh 0x35cb5700<br>
&gt; 3286206@1711972823.951709:usb_uhci_td_load qh 0x35cb5700, td 0x75ac524=
0, ctrl 0x39800000, token 0xe08369<br>
&gt; 3286206@1711972823.951727:usb_uhci_queue_add token 0x8369<br>
&gt; 3286206@1711972823.951735:usb_uhci_packet_add token 0x8369, td 0x75ac5=
240<br>
&gt; 3286206@1711972823.951746:usb_packet_state_change bus 0, port 2, ep 1,=
 packet 0x56066b2fb5a0, state undef -&gt; setup<br>
&gt; 3286206@1711972823.951766:usb_msd_data_in 8/8 (scsi 8)<br>
&gt; 2024-04-01 12:00:24.665+0000: shutting down, reason=3Dcrashed<br>
&gt; <br>
&gt; The backtrace reveals the following:<br>
&gt; <br>
&gt; Program terminated with signal SIGSEGV, Segmentation fault.<br>
&gt; 0=C2=A0 __memmove_sse2_unaligned_erms () at ../sysdeps/x86_64/multiarc=
h/memmove-vec-unaligned-erms.S:312<br>
&gt; 312=C2=A0 =C2=A0 =C2=A0 =C2=A0 movq=C2=A0 =C2=A0 -8(%rsi,%rdx), %rcx<b=
r>
&gt; [Current thread is 1 (Thread 0x7f0a9025fc00 (LWP 3286206))]<br>
&gt; (gdb) bt<br>
&gt; 0=C2=A0 __memmove_sse2_unaligned_erms () at ../sysdeps/x86_64/multiarc=
h/memmove-vec-unaligned-erms.S:312<br>
&gt; 1=C2=A0 memcpy (__len=3D8, __src=3D&lt;optimized out&gt;, __dest=3D&lt=
;optimized out&gt;) at /usr/include/bits/string_fortified.h:34<br>
&gt; 2=C2=A0 iov_from_buf_full (iov=3D&lt;optimized out&gt;, iov_cnt=3D&lt;=
optimized out&gt;, offset=3D&lt;optimized out&gt;, buf=3D0x0, bytes=3Dbytes=
@entry=3D8) at ../util/iov.c:33<br>
&gt; 3=C2=A0 iov_from_buf (bytes=3D8, buf=3D&lt;optimized out&gt;, offset=
=3D&lt;optimized out&gt;, iov_cnt=3D&lt;optimized out&gt;, iov=3D&lt;optimi=
zed out&gt;)<br>
&gt;=C2=A0 =C2=A0 =C2=A0at /usr/src/debug/qemu-6-6.2.0-75.7.oe1.smartx.git.=
40.x86_64/include/qemu/iov.h:49<br>
&gt; 4=C2=A0 usb_packet_copy (p=3Dp@entry=3D0x56066b2fb5a0, ptr=3D&lt;optim=
ized out&gt;, bytes=3Dbytes@entry=3D8) at ../hw/usb/core.c:636<br>
&gt; 5=C2=A0 usb_msd_copy_data (s=3Ds@entry=3D0x56066c62c770, p=3Dp@entry=
=3D0x56066b2fb5a0) at ../hw/usb/dev-storage.c:186<br>
&gt; 6=C2=A0 usb_msd_handle_data (dev=3D0x56066c62c770, p=3D0x56066b2fb5a0)=
 at ../hw/usb/dev-storage.c:496<br>
&gt; 7=C2=A0 usb_handle_packet (dev=3D0x56066c62c770, p=3Dp@entry=3D0x56066=
b2fb5a0) at ../hw/usb/core.c:455<br>
&gt; 8=C2=A0 uhci_handle_td (s=3Ds@entry=3D0x56066bd5f210, q=3D0x56066bb7fb=
d0, q@entry=3D0x0, qh_addr=3Dqh_addr@entry=3D902518530, td=3Dtd@entry=3D0x7=
fffe6e788f0, td_addr=3D&lt;optimized out&gt;,<br>
&gt;=C2=A0 =C2=A0 =C2=A0int_mask=3Dint_mask@entry=3D0x7fffe6e788e4) at ../h=
w/usb/hcd-uhci.c:885<br>
&gt; 9=C2=A0 uhci_process_frame (s=3Ds@entry=3D0x56066bd5f210) at ../hw/usb=
/hcd-uhci.c:1061<br>
&gt; 10 uhci_frame_timer (opaque=3Dopaque@entry=3D0x56066bd5f210) at ../hw/=
usb/hcd-uhci.c:1159<br>
&gt; 11 timerlist_run_timers (timer_list=3D0x56066af26bd0) at ../util/qemu-=
timer.c:642<br>
&gt; 12 qemu_clock_run_timers (type=3DQEMU_CLOCK_VIRTUAL) at ../util/qemu-t=
imer.c:656<br>
&gt; 13 qemu_clock_run_all_timers () at ../util/qemu-timer.c:738<br>
&gt; 14 main_loop_wait (nonblocking=3Dnonblocking@entry=3D0) at ../util/mai=
n-loop.c:542<br>
&gt; 15 qemu_main_loop () at ../softmmu/runstate.c:739<br>
&gt; 16 main (argc=3D&lt;optimized out&gt;, argv=3D&lt;optimized out&gt;, e=
nvp=3D&lt;optimized out&gt;) at ../softmmu/main.c:52<br>
&gt; (gdb) frame 5<br>
&gt; (gdb) p ((SCSIDiskReq *)s-&gt;req)-&gt;iov<br>
&gt; $1 =3D {iov_base =3D 0x0, iov_len =3D 0}<br>
&gt; (gdb) p/x s-&gt;req-&gt;tag<br>
&gt; $2 =3D 0x472<br>
&gt; <br>
&gt; When designing the USB mass storage device model, QEMU places SCSI dis=
k<br>
&gt; device as the backend of USB mass storage device. In addition, USB mas=
s<br>
&gt; device driver in Guest OS conforms to the &quot;Universal Serial Bus M=
ass<br>
&gt; Storage Class Bulk-Only Transport&quot; specification in order to simu=
late<br>
&gt; the transform behavior between a USB controller and a USB mass device.=
<br>
&gt; The following shows the protocol hierarchy:<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 +----------------+<br>
&gt;=C2=A0 =C2=A0CDROM driver=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 scsi=
 command=C2=A0 |=C2=A0 =C2=A0 =C2=A0 =C2=A0 CDROM<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 +----------------+<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0+-----------------------+<br>
&gt;=C2=A0 =C2=A0USB mass=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 | USB Mass Stor=
age Class|=C2=A0 =C2=A0 USB mass<br>
&gt;=C2=A0 =C2=A0storage driver=C2=A0 =C2=A0 | Bulk-Only Transport=C2=A0 =
=C2=A0|=C2=A0 =C2=A0 storage device<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0+-----------------------+<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 +----------------+<br>
&gt;=C2=A0 =C2=A0USB Controller=C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 USB Proto=
col=C2=A0 |=C2=A0 =C2=A0 =C2=A0 =C2=A0 USB device<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 +----------------+<br>
&gt; <br>
&gt; In the USB protocol layer, between the USB controller and USB device, =
at<br>
&gt; least two USB packets will be transformed when guest OS send a<br>
&gt; read operation to USB mass storage device:<br>
&gt; <br>
&gt; 1. The CBW packet, which will be delivered to the USB device&#39;s Bul=
k-Out<br>
&gt; endpoint. In order to simulate a read operation, the USB mass storage<=
br>
&gt; device parses the CBW and converts it to a SCSI command, which would b=
e<br>
&gt; executed by CDROM(represented as SCSI disk in QEMU internally), and st=
ore<br>
&gt; the result data of the SCSI command in a buffer.<br>
&gt; <br>
&gt; 2. The DATA-IN packet, which will be delivered from the USB device&#39=
;s<br>
&gt; Bulk-In endpoint(fetched directly from the preceding buffer) to the US=
B<br>
&gt; controller.<br>
&gt; <br>
&gt; We consider UHCI to be the controller. The two packets mentioned above=
 may<br>
&gt; have been processed by UHCI in two separate frame entries of the Frame=
 List<br>
&gt; , and also described by two different TDs. Unlike the physical environ=
ment,<br>
&gt; a virtualized environment requires the QEMU to make sure that the resu=
lt<br>
&gt; data of CBW is not lost and is delivered to the UHCI controller.<br>
&gt; <br>
&gt; Currently, these types of SCSI requests are not migrated, so QEMU cann=
ot<br>
&gt; ensure the result data of the IO operation is not lost if there are<br=
>
&gt; inflight emulated SCSI requests during the live migration.<br>
&gt; <br>
&gt; Assume for the moment that the USB mass storage device is processing t=
he<br>
&gt; CBW and storing the result data of the read operation to a buffre, liv=
e<br>
&gt; migration happens and moves the VM to the destination while not migrat=
ing<br>
&gt; the result data of the read operation.<br>
&gt; <br>
&gt; After migration, when UHCI at the destination issues a DATA-IN request=
 to<br>
&gt; the USB mass storage device, a crash happens because USB mass storage =
device<br>
&gt; fetches the result data and get nothing.<br>
&gt; <br>
&gt; The scenario this patch addresses is this one.<br>
&gt; <br>
&gt; Theoretically, any device that uses the SCSI disk as a back-end would =
be<br>
&gt; affected by this issue. In this case, it is the USB CDROM.<br>
&gt; <br>
&gt; To fix it, inflight emulated SCSI request be migrated during live migr=
ation,<br>
&gt; similar to the DMA SCSI request.<br>
&gt; <br>
&gt; Signed-off-by: Hyman Huang &lt;<a href=3D"mailto:yong.huang@smartx.com=
" target=3D"_blank">yong.huang@smartx.com</a>&gt;<br>
&gt; Message-ID: &lt;<a href=3D"mailto:878c8f093f3fc2f584b5c31cb2490d9f6a12=
131a.1716531409.git.yong.huang@smartx.com" target=3D"_blank">878c8f093f3fc2=
f584b5c31cb2490d9f6a12131a.1716531409.git.yong.huang@smartx.com</a>&gt;<br>
&gt; [Do not bump migration version, introduce compat property instead. - P=
aolo]<br>
&gt; Signed-off-by: Paolo Bonzini &lt;<a href=3D"mailto:pbonzini@redhat.com=
" target=3D"_blank">pbonzini@redhat.com</a>&gt;<br>
&gt; ---<br>
&gt;=C2=A0 =C2=A0hw/core/machine.c=C2=A0 =C2=A0|=C2=A0 1 +<br>
&gt;=C2=A0 =C2=A0hw/scsi/scsi-disk.c | 24 +++++++++++++++++++++++-<br>
&gt;=C2=A0 =C2=A02 files changed, 24 insertions(+), 1 deletion(-)<br>
&gt; <br>
&gt; diff --git a/hw/core/machine.c b/hw/core/machine.c<br>
&gt; index c93d2492443..655d75c21fc 100644<br>
&gt; --- a/hw/core/machine.c<br>
&gt; +++ b/hw/core/machine.c<br>
&gt; @@ -36,6 +36,7 @@<br>
&gt;=C2=A0 =C2=A0<br>
&gt;=C2=A0 =C2=A0GlobalProperty hw_compat_9_0[] =3D {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0{&quot;arm-cpu&quot;, &quot;backcompat-cntfr=
q&quot;, &quot;true&quot; },<br>
&gt; +=C2=A0 =C2=A0 {&quot;scsi-disk-base&quot;, &quot;migrate-emulated-scs=
i-request&quot;, &quot;false&quot; },<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0{&quot;vfio-pci&quot;, &quot;skip-vsc-check&=
quot;, &quot;false&quot; },<br>
&gt;=C2=A0 =C2=A0};<br>
<br>
=C2=A0 Hi Paolo, hi Hyman,<br>
<br>
this patch introduced a problem with device introspection on older machine =
<br>
types. Running &quot;make check-qtest SPEED=3Dslow&quot; is now failing for=
 older <br>
machine types.<br>
<br>
Or if you want to reproduce it manually:<br>
<br>
=C2=A0 $ ./qemu-system-x86_64 -M pc-q35-8.0 -monitor stdio<br>
=C2=A0 QEMU 9.0.50 monitor - type &#39;help&#39; for more information<br>
=C2=A0 (qemu) device_add scsi-block,help<br>
=C2=A0 Unexpected error in object_property_find_err() at<br>
=C2=A0 ../../devel/qemu/qom/object.c:1357:<br>
=C2=A0 can&#39;t apply global scsi-disk-base.migrate-emulated-scsi-request=
=3Dfalse:<br>
=C2=A0 Property &#39;scsi-block.migrate-emulated-scsi-request&#39; not foun=
d<br>
=C2=A0 Aborted (core dumped)<br>
<br>
I think the problem is that the property is only added to certain SCSI <br>
devices via the DEFINE_SCSI_DISK_PROPERTIES macro, but &quot;scsi-block&quo=
t; device <br>
does not use this macro and thus does not have this property. So when the <=
br>
compat code tries to set this property for &quot;scsi-block&quot; (which is=
 also <br>
derived from &quot;scsi-disk-base&quot;), it fails, of course.<br></blockqu=
ote><div><div style=3D"font-family:&quot;comic sans ms&quot;,sans-serif" cl=
ass=3D"gmail_default"></div><div class=3D"gmail_default"><font face=3D"comi=
c sans ms, sans-serif">&quot;scsi-block&quot; appears to handle two differe=
nt types of devices:=C2=A0</font></div><div class=3D"gmail_default"><font f=
ace=3D"comic sans ms, sans-serif">passthrough-ed block devices and scsi-blo=
ck devices.=C2=A0</font></div><div class=3D"gmail_default"><span style=3D"f=
ont-family:&quot;comic sans ms&quot;,sans-serif"><br></span></div><div clas=
s=3D"gmail_default"><span style=3D"font-family:&quot;comic sans ms&quot;,sa=
ns-serif">Since each of them is capable of supporting the load/save scsi re=
quest,=C2=A0</span><br></div><div class=3D"gmail_default"><font face=3D"com=
ic sans ms, sans-serif">and this patchset does not address any problems for=
 them.</font></div></div><div class=3D"gmail_default"><font face=3D"comic s=
ans ms, sans-serif"><br></font></div><div class=3D"gmail_default"><font fac=
e=3D"comic sans ms, sans-serif">So,=C2=A0IMHO,=C2=A0The &quot;scsi-disk-bas=
e&quot; class may not be the best place for the</font></div><div class=3D"g=
mail_default"><font face=3D"comic sans ms, sans-serif">&quot;migrate-emulat=
ed-scsi-request&quot; attribute?</font></div><div>=C2=A0</div><blockquote c=
lass=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left-width:1p=
x;border-left-style:solid;border-left-color:rgb(204,204,204);padding-left:1=
ex">
<br>
Should the &quot;migrate-emulated-scsi-request&quot; property maybe rather =
be added to <br>
the &quot;scsi-disk-base&quot; class instead? Or should hw_compat_9_0 rathe=
r list the <br>
devices that have the property instead of using the parent class? Could you=
 <br>
please have a look?<br>
<br>
=C2=A0 Thanks,<br>
=C2=A0 =C2=A0Thomas<br>
<br>
</blockquote></div><br clear=3D"all"><div><br></div><span class=3D"gmail_si=
gnature_prefix">-- </span><br><div dir=3D"ltr" class=3D"gmail_signature"><d=
iv dir=3D"ltr"><font face=3D"comic sans ms, sans-serif">Best regards</font>=
</div></div></div>

--0000000000008c15fe061bad3de3--

