Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2B8DC3600B
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Mar 2025 06:00:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1txgH4-0007fz-I2; Thu, 27 Mar 2025 01:59:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jinpu.wang@ionos.com>)
 id 1txgGx-0007fT-9e
 for qemu-devel@nongnu.org; Thu, 27 Mar 2025 01:59:24 -0400
Received: from mail-ed1-x536.google.com ([2a00:1450:4864:20::536])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jinpu.wang@ionos.com>)
 id 1txgGv-00071q-0g
 for qemu-devel@nongnu.org; Thu, 27 Mar 2025 01:59:23 -0400
Received: by mail-ed1-x536.google.com with SMTP id
 4fb4d7f45d1cf-5dbe706f94fso114539a12.2
 for <qemu-devel@nongnu.org>; Wed, 26 Mar 2025 22:59:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ionos.com; s=google; t=1743055159; x=1743659959; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Tj8z3IkRztuQe4fY77XowGl0Bzuc0Lzkv3cICjaAkuU=;
 b=HZb75idwC1w1WNMFcof+bh22Wpm8KU8jdxNzHC8aXKR8L6s1wTBMfN1MtmMJ6q9vqX
 WFAkx77GmXjmwujDrDPhxzCYMcy9Sh7+8/BJ89FDA/TDvfuT8Mf3IoCTSxMIktqJzV+Y
 IVOwRDb9hohjc/vUoOAHxbYOS4Mgo6/mI8MkhyuFbIdTcihMIDNmmUV85BJkYD6G11MJ
 TBviLbU2huS/snQYgk6TqlCWp1/qoFsZkGSzF+zVBeuUsLl/UizSem+DNMCIL8bAfZs8
 nUeJLxgTYI4Hi1YlKJLRsRnCfIYPU1QNh93fRaMg1fi3RthFXH4at6fkB1Z+Oeh6Gi+E
 frxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743055159; x=1743659959;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Tj8z3IkRztuQe4fY77XowGl0Bzuc0Lzkv3cICjaAkuU=;
 b=V+CDYNucwKeiDPbXaWOfeZhhZ9SRXbAKmyFvddFKFFfggPzZUx6FUtnp67o2mBWUzZ
 RzhJsrZAe0sgyl9h4KY3TzVFplSf1JZriYXhZY2Y3jDAJ6WKO4GD6ZomYumk/wEdCDjK
 UBglMRvvJw/1MqH0NRK/Rfzn0nFhWPAWqirmk+zMI/85DhI24HNAXzNiB1J5HB9HhHLw
 WOj4qFhCozWJ6Mue6D4YdYXRfetKkt+zeTG+4EFOuVaKOtkvuHUceEDz2eQ5ToJS4vbY
 VhNliohdhT9lXFc0Q0pYI9pJmwfXtPVKn6IG4OJ3agv+YqRjBkfqkDdQvpExXOPPG7PG
 FH9w==
X-Gm-Message-State: AOJu0YzKt+oj/O0h284tWYpT1Q/XroUJ9X5lx85Ar0cJXHgGTOvIUQpv
 f3P8Szer5idEo8JgAZNhwbEXX82kUoamPOv9mCBolmAextvidevdmx4AM17umeaOGKn+Ejv04yD
 Y+jqiVZ5nZs3U43QIhQcmp1YiJI4+UUsFKRnc2Q==
X-Gm-Gg: ASbGnctt/wPv+pMQg/dlfx/2PoEckZU6ct6qMHTrc0TGdEW+6Z0lXvmo0f8a+Xixg4i
 av5QtlmhmdbqvuNEVyDlETdLpQXWnWidqQaySyGIULbAKiefNA9QXVxyc8IxT0ao09ioNI/wVc6
 08ojOdUoOYvu1yZrymucpvdZ72mPb7GhvSd3v/DbzLOPZqDnXczS/XlxbxbcI=
X-Google-Smtp-Source: AGHT+IHyXjVkDqmgGiy05BgIzrV94FQ7NxBcP7+5RxMkTE4X8gtiNcsXnqk1/r6aqBCDVTDYJrYuQTkZBBRdD1lDtIc=
X-Received: by 2002:a05:6402:2791:b0:5dc:c277:f787 with SMTP id
 4fb4d7f45d1cf-5eda03f4091mr499287a12.4.1743055158614; Wed, 26 Mar 2025
 22:59:18 -0700 (PDT)
MIME-Version: 1.0
References: <20250326095224.9918-1-jinpu.wang@ionos.com>
 <3d6955e6-a582-418d-8dea-e3b2a36944f2@fujitsu.com>
In-Reply-To: <3d6955e6-a582-418d-8dea-e3b2a36944f2@fujitsu.com>
From: Jinpu Wang <jinpu.wang@ionos.com>
Date: Thu, 27 Mar 2025 06:59:07 +0100
X-Gm-Features: AQ5f1JpKOIkB9MRKqVFIcxkmdDKu8xyEm9xjQYjgcSuUFcmORB_IWOfs46v4VuM
Message-ID: <CAMGffE=gMEC=WwdQYAZgjY2eo=kyWhbZ5X7q+O5APNfFFtDd8w@mail.gmail.com>
Subject: Re: [RFC PATCH] migration/rdma: Remove qemu_rdma_broken_ipv6_kernel
To: "Zhijian Li (Fujitsu)" <lizhijian@fujitsu.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "farosas@suse.de" <farosas@suse.de>, 
 "peterx@redhat.com" <peterx@redhat.com>, Yu Zhang <yu.zhang@ionos.com>, 
 "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>, 
 "michael@flatgalaxy.com" <michael@flatgalaxy.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: permerror client-ip=2a00:1450:4864:20::536;
 envelope-from=jinpu.wang@ionos.com; helo=mail-ed1-x536.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 T_SPF_PERMERROR=0.01 autolearn=ham autolearn_force=no
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

Hi Zhijian,

On Thu, Mar 27, 2025 at 2:18=E2=80=AFAM Zhijian Li (Fujitsu)
<lizhijian@fujitsu.com> wrote:
>
>
> Please fix this compiling error.
>
>
> cc -m64 -mcx16 -Ilibcommon.a.p -Isubprojects/libvduse -I../subprojects/li=
bvduse -I/usr/include/p11-kit-1 -I/usr/include/pixman-1 -I/usr/include/libp=
ng16 -I/usr/include/spice-server -I/usr/include/spice-1 -I/usr/include/libu=
sb-1.0 -I/usr/include/glib-2.0 -I/usr/lib/x86_64-linux-gnu/glib-2.0/include=
 -I/usr/include/libmount -I/usr/include/blkid -I/usr/include/gio-unix-2.0 -=
I/usr/include/gtk-3.0 -I/usr/include/pango-1.0 -I/usr/include/harfbuzz -I/u=
sr/include/freetype2 -I/usr/include/fribidi -I/usr/include/uuid -I/usr/incl=
ude/cairo -I/usr/include/gdk-pixbuf-2.0 -I/usr/include/x86_64-linux-gnu -I/=
usr/include/atk-1.0 -I/usr/include/at-spi2-atk/2.0 -I/usr/include/dbus-1.0 =
-I/usr/lib/x86_64-linux-gnu/dbus-1.0/include -I/usr/include/at-spi-2.0 -I/u=
sr/include/cacard -I/usr/include/nss -I/usr/include/nspr -I/usr/include/PCS=
C -fdiagnostics-color=3Dauto -Wall -Winvalid-pch -Werror -std=3Dgnu11 -O2 -=
g -fstack-protector-strong -gsplit-dwarf -Wempty-body -Wendif-labels -Wexpa=
nsion-to-defined -Wformat-security -Wformat-y2k -Wignored-qualifiers -Wimpl=
icit-fallthrough=3D2 -Winit-self -Wmissing-format-attribute -Wmissing-proto=
types -Wnested-externs -Wold-style-declaration -Wold-style-definition -Wred=
undant-decls -Wshadow=3Dlocal -Wstrict-prototypes -Wtype-limits -Wundef -Wv=
la -Wwrite-strings -Wno-missing-include-dirs -Wno-psabi -Wno-shift-negative=
-value -isystem /home/lizj/workspace/qemu/qemu/linux-headers -isystem linux=
-headers -iquote . -iquote /home/lizj/workspace/qemu/qemu -iquote /home/liz=
j/workspace/qemu/qemu/include -iquote /home/lizj/workspace/qemu/qemu/host/i=
nclude/x86_64 -iquote /home/lizj/workspace/qemu/qemu/host/include/generic -=
iquote /home/lizj/workspace/qemu/qemu/tcg/i386 -pthread -mcx16 -msse2 -D_GN=
U_SOURCE -D_FILE_OFFSET_BITS=3D64 -D_LARGEFILE_SOURCE -fno-strict-aliasing =
-fno-common -fwrapv -fzero-call-used-regs=3Dused-gpr -fPIE -D_DEFAULT_SOURC=
E -D_XOPEN_SOURCE=3D600 -DNCURSES_WIDECHAR=3D1 -DSTRUCT_IOVEC_DEFINED -MD -=
MQ libcommon.a.p/migration_rdma.c.o -MF libcommon.a.p/migration_rdma.c.o.d =
-o libcommon.a.p/migration_rdma.c.o -c ../migration/rdma.c
> ../migration/rdma.c: In function =E2=80=98qemu_rdma_resolve_host=E2=80=99=
:
> ../migration/rdma.c:815:17: error: unused variable =E2=80=98local_errp=E2=
=80=99 [-Werror=3Dunused-variable]
>    815 |         Error **local_errp =3D err ? NULL : &err;
>        |                 ^~~~~~~~~~
> ../migration/rdma.c: In function =E2=80=98qemu_rdma_dest_init=E2=80=99:
> ../migration/rdma.c:2504:17: error: unused variable =E2=80=98local_errp=
=E2=80=99 [-Werror=3Dunused-variable]
>   2504 |         Error **local_errp =3D err ? NULL : &err;
>        |                 ^~~~~~~~~~
> cc1: all warnings being treated as errors
> [17/19] Compiling C object qemu-img.p/qemu-img.c.o
>
>
> After this fixing, feel free to add
>
> Tested-by: Li zhijian <lizhijian@fujitsu.com>
Thx for checking, will fix them.
>
>
> On 26/03/2025 17:52, Jack Wang wrote:
> > I hit following error which testing migration in pure RoCE env:
> > "-incoming rdma:[::]:8089: RDMA ERROR: You only have RoCE / iWARP devic=
es in your
> > systems and your management software has specified '[::]', but IPv6 ove=
r RoCE /
> > iWARP is not supported in Linux.#012'."
> >
> > In our setup, we use rdma bind on ipv6 on target host, while connect fr=
om source
> > with ipv4, remove the qemu_rdma_broken_ipv6_kernel, migration just work
> > fine.
> >
> > Checking the git history, the function was added since introducing of
> > rdma migration, which is more than 10 years ago. linux-rdma has
> > improved support on RoCE/iWARP for ipv6 over past years. There are a fe=
w fixes
> > back in 2016 seems related to the issue, eg:
> > aeb76df46d11 ("IB/core: Set routable RoCE gid type for ipv4/ipv6 networ=
ks")
> >
> > other fixes back in 2018, eg:
> > 052eac6eeb56 RDMA/cma: Update RoCE multicast routines to use net namesp=
ace
> > 8d20a1f0ecd5 RDMA/cma: Fix rdma_cm raw IB path setting for RoCE
> > 9327c7afdce3 RDMA/cma: Provide a function to set RoCE path record L2 pa=
rameters
> > 5c181bda77f4 RDMA/cma: Set default GID type as RoCE when resolving RoCE=
 route
> > 3c7f67d1880d IB/cma: Fix default RoCE type setting
> > be1d325a3358 IB/core: Set RoCEv2 MGID according to spec
> > 63a5f483af0e IB/cma: Set default gid type to RoCEv2
> >
> > So remove the outdated function and it's usage.
> >
> > Cc: Peter Xu <peterx@redhat.com>
> > Cc: Li Zhijian <lizhijian@fujitsu.com>
> > Cc: Yu Zhang <yu.zhang@ionos.com>
> > Cc: qemu-devel@nongnu.org
> > Cc: linux-rdma@vger.kernel.org
> > Cc: michael@flatgalaxy.com
> > Signed-off-by: Jack Wang <jinpu.wang@ionos.com>
> > ---
> >   migration/rdma.c | 157 ----------------------------------------------=
-
> >   1 file changed, 157 deletions(-)
> >
> > diff --git a/migration/rdma.c b/migration/rdma.c
> > index 76fb0349238a..5ce628ddeef0 100644
> > --- a/migration/rdma.c
> > +++ b/migration/rdma.c
> > @@ -767,149 +767,6 @@ static void qemu_rdma_dump_gid(const char *who, s=
truct rdma_cm_id *id)
> >       trace_qemu_rdma_dump_gid(who, sgid, dgid);
> >   }
> >
> > -/*
> > - * As of now, IPv6 over RoCE / iWARP is not supported by linux.
> > - * We will try the next addrinfo struct, and fail if there are
> > - * no other valid addresses to bind against.
> > - *
> > - * If user is listening on '[::]', then we will not have a opened a de=
vice
> > - * yet and have no way of verifying if the device is RoCE or not.
> > - *
> > - * In this case, the source VM will throw an error for ALL types of
> > - * connections (both IPv4 and IPv6) if the destination machine does no=
t have
> > - * a regular infiniband network available for use.
> > - *
> > - * The only way to guarantee that an error is thrown for broken kernel=
s is
> > - * for the management software to choose a *specific* interface at bin=
d time
> > - * and validate what time of hardware it is.
> > - *
> > - * Unfortunately, this puts the user in a fix:
> > - *
> > - *  If the source VM connects with an IPv4 address without knowing tha=
t the
> > - *  destination has bound to '[::]' the migration will unconditionally=
 fail
> > - *  unless the management software is explicitly listening on the IPv4
> > - *  address while using a RoCE-based device.
> > - *
> > - *  If the source VM connects with an IPv6 address, then we're OK beca=
use we can
> > - *  throw an error on the source (and similarly on the destination).
> > - *
> > - *  But in mixed environments, this will be broken for a while until i=
t is fixed
> > - *  inside linux.
> > - *
> > - * We do provide a *tiny* bit of help in this function: We can list al=
l of the
> > - * devices in the system and check to see if all the devices are RoCE =
or
> > - * Infiniband.
> > - *
> > - * If we detect that we have a *pure* RoCE environment, then we can sa=
fely
> > - * thrown an error even if the management software has specified '[::]=
' as the
> > - * bind address.
> > - *
> > - * However, if there is are multiple hetergeneous devices, then we can=
not make
> > - * this assumption and the user just has to be sure they know what the=
y are
> > - * doing.
> > - *
> > - * Patches are being reviewed on linux-rdma.
> > - */
> > -static int qemu_rdma_broken_ipv6_kernel(struct ibv_context *verbs, Err=
or **errp)
> > -{
> > -    /* This bug only exists in linux, to our knowledge. */
> > -#ifdef CONFIG_LINUX
> > -    struct ibv_port_attr port_attr;
> > -
> > -    /*
> > -     * Verbs are only NULL if management has bound to '[::]'.
> > -     *
> > -     * Let's iterate through all the devices and see if there any pure=
 IB
> > -     * devices (non-ethernet).
> > -     *
> > -     * If not, then we can safely proceed with the migration.
> > -     * Otherwise, there are no guarantees until the bug is fixed in li=
nux.
> > -     */
> > -    if (!verbs) {
> > -        int num_devices;
> > -        struct ibv_device **dev_list =3D ibv_get_device_list(&num_devi=
ces);
> > -        bool roce_found =3D false;
> > -        bool ib_found =3D false;
> > -
> > -        for (int x =3D 0; x < num_devices; x++) {
> > -            verbs =3D ibv_open_device(dev_list[x]);
> > -            /*
> > -             * ibv_open_device() is not documented to set errno.  If
> > -             * it does, it's somebody else's doc bug.  If it doesn't,
> > -             * the use of errno below is wrong.
> > -             * TODO Find out whether ibv_open_device() sets errno.
> > -             */
> > -            if (!verbs) {
> > -                if (errno =3D=3D EPERM) {
> > -                    continue;
> > -                } else {
> > -                    error_setg_errno(errp, errno,
> > -                                     "could not open RDMA device conte=
xt");
> > -                    return -1;
> > -                }
> > -            }
> > -
> > -            if (ibv_query_port(verbs, 1, &port_attr)) {
> > -                ibv_close_device(verbs);
> > -                error_setg(errp,
> > -                           "RDMA ERROR: Could not query initial IB por=
t");
> > -                return -1;
> > -            }
> > -
> > -            if (port_attr.link_layer =3D=3D IBV_LINK_LAYER_INFINIBAND)=
 {
> > -                ib_found =3D true;
> > -            } else if (port_attr.link_layer =3D=3D IBV_LINK_LAYER_ETHE=
RNET) {
> > -                roce_found =3D true;
> > -            }
> > -
> > -            ibv_close_device(verbs);
> > -
> > -        }
> > -
> > -        if (roce_found) {
> > -            if (ib_found) {
> > -                warn_report("migrations may fail:"
> > -                            " IPv6 over RoCE / iWARP in linux"
> > -                            " is broken. But since you appear to have =
a"
> > -                            " mixed RoCE / IB environment, be sure to =
only"
> > -                            " migrate over the IB fabric until the ker=
nel "
> > -                            " fixes the bug.");
> > -            } else {
> > -                error_setg(errp, "RDMA ERROR: "
> > -                           "You only have RoCE / iWARP devices in your=
 systems"
> > -                           " and your management software has specifie=
d '[::]'"
> > -                           ", but IPv6 over RoCE / iWARP is not suppor=
ted in Linux.");
> > -                return -1;
> > -            }
> > -        }
> > -
> > -        return 0;
> > -    }
> > -
> > -    /*
> > -     * If we have a verbs context, that means that some other than '[:=
:]' was
> > -     * used by the management software for binding. In which case we c=
an
> > -     * actually warn the user about a potentially broken kernel.
> > -     */
> > -
> > -    /* IB ports start with 1, not 0 */
> > -    if (ibv_query_port(verbs, 1, &port_attr)) {
> > -        error_setg(errp, "RDMA ERROR: Could not query initial IB port"=
);
> > -        return -1;
> > -    }
> > -
> > -    if (port_attr.link_layer =3D=3D IBV_LINK_LAYER_ETHERNET) {
> > -        error_setg(errp, "RDMA ERROR: "
> > -                   "Linux kernel's RoCE / iWARP does not support IPv6 =
"
> > -                   "(but patches on linux-rdma in progress)");
> > -        return -1;
> > -    }
> > -
> > -#endif
> > -
> > -    return 0;
> > -}
> > -
> >   /*
> >    * Figure out which RDMA device corresponds to the requested IP hostn=
ame
> >    * Also create the initial connection manager identifiers for opening
> > @@ -964,13 +821,6 @@ static int qemu_rdma_resolve_host(RDMAContext *rdm=
a, Error **errp)
> >           ret =3D rdma_resolve_addr(rdma->cm_id, NULL, e->ai_dst_addr,
> >                   RDMA_RESOLVE_TIMEOUT_MS);
> >           if (ret >=3D 0) {
> > -            if (e->ai_family =3D=3D AF_INET6) {
> > -                ret =3D qemu_rdma_broken_ipv6_kernel(rdma->cm_id->verb=
s,
> > -                                                   local_errp);
> > -                if (ret < 0) {
> > -                    continue;
> > -                }
> > -            }
> >               error_free(err);
> >               goto route;
> >           }
> > @@ -2672,13 +2522,6 @@ static int qemu_rdma_dest_init(RDMAContext *rdma=
, Error **errp)
> >           if (ret < 0) {
> >               continue;
> >           }
> > -        if (e->ai_family =3D=3D AF_INET6) {
> > -            ret =3D qemu_rdma_broken_ipv6_kernel(listen_id->verbs,
> > -                                               local_errp);
> > -            if (ret < 0) {
> > -                continue;
> > -            }
> > -        }
> >           error_free(err);
> >           break;
> >       }

