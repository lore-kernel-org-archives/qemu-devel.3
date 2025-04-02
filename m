Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC62BC28B20
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Apr 2025 05:06:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tzqIt-000815-Ig; Wed, 02 Apr 2025 01:06:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jinpu.wang@ionos.com>)
 id 1tzqIr-00080e-5U
 for qemu-devel@nongnu.org; Wed, 02 Apr 2025 01:06:17 -0400
Received: from mail-ed1-x530.google.com ([2a00:1450:4864:20::530])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jinpu.wang@ionos.com>)
 id 1tzqIo-0001gp-Ty
 for qemu-devel@nongnu.org; Wed, 02 Apr 2025 01:06:16 -0400
Received: by mail-ed1-x530.google.com with SMTP id
 4fb4d7f45d1cf-5edc468a7daso936307a12.2
 for <qemu-devel@nongnu.org>; Tue, 01 Apr 2025 22:06:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ionos.com; s=google; t=1743570371; x=1744175171; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8xaTTageRrn2WM5zIXFtBnMYl4uVh+i8zkJusyEeAWU=;
 b=Le8Z3AQBAKzzHNBg8jRzmMKyMlQPJbweOK1MeAwf0CTXcZ3ZsmO/rzJjBminO1z/O9
 pgmtlmGqKf0op5TZ1lXbPeUN6l06CfE1W5nweW0CxC8DtFjaPO56L/36Tfs25CGMFk+1
 tvwRNOu6zxvBbBnJ5x3vaZ2lqh4A6JwtdWiDtB6i4XOzQLSgIiTYzSB9ocA6yF0U26SD
 NQyXdAQ5JVeQwbG2lO5xFQp5inlcp+ndWah9TwF/rlspxD4yWS6AfOwYGufO7lOjz31B
 svOjY7EmuuwXN5GLjV191vynIyUheGfslFWKY1ELC5gqFR3LMudBlcLbkoTHDMpmRcsR
 1prQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743570371; x=1744175171;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=8xaTTageRrn2WM5zIXFtBnMYl4uVh+i8zkJusyEeAWU=;
 b=nS70E9UAc+yx0M/bCRuR4WvQIRmNemhETuXCkJfwZdC6HLZhk1Y5eko/+kFmCgkRZw
 f6g7ZpMySLvKXdQJ9LSA6TZCa630eQMqDWJIabqib/O77yzA9mdgxOOYCS/KUg2vG7I9
 TQyBXdXwNFcRSS3TFbRZdmL3/HOCRc1+zIJ0nrzyQefF75DWCUwG7ggfJguB8rbRNaAq
 204repwaQU2tzHUR96wXQp2L7eLkifrx7SYh7PQ2gbOhXcQPWw80KDJs05ENhN0J4MRX
 vSHWlOAG9k3uySn8s+L2dxP00aNFL6/TMVtmQY+kJTIJ7P7iCPXjeQ+2KgLTN9+GsV0n
 JdPA==
X-Gm-Message-State: AOJu0YxnDqw2UJkXltogarfZ8vNp0CJfIrcbhp6Od9qkxBCysmxvdeF9
 QOzincuf0e2EmTkq5CXlMj0pfN7Nrg72KJL6AR6HaCL48IFWZbmgRkh/7iOYg2YgASfM1+sC501
 OCqPt5uViO7krvVuX5oCK4W1CBVJDF9U/piCwncKP7NLTtPJG
X-Gm-Gg: ASbGncsbBU12A8pOTAQO9IqKTXHfMeisg/rfLZWYnSIzNgCoXspxzd+ZZ0aermsOBkN
 pKwf+MvEi1+oeOnY7QwnlXNaR+uTSB5go0a3Xzx3eGRjle0KR6C5tyYYDRkBYg252dhuuGSwHYq
 8zU7OS1TdxXuAHFqc40kO7Yt0+VA3NEOlkV/5oHupQVoXLt3Uir1a4NkE5MlY=
X-Google-Smtp-Source: AGHT+IHGkF6fvb1/M6FeFnlisGPKAnQbc197uIHSTVYOb5GBbijqCtkCK0uyMf4QuE015oYFx4JmnCWf6jdjIVcUUmU=
X-Received: by 2002:a05:6402:13c2:b0:5e5:be39:3361 with SMTP id
 4fb4d7f45d1cf-5f03bec948emr1468088a12.1.1743570371483; Tue, 01 Apr 2025
 22:06:11 -0700 (PDT)
MIME-Version: 1.0
References: <20250327061123.14453-1-jinpu.wang@ionos.com>
 <87cydvllso.fsf@suse.de>
In-Reply-To: <87cydvllso.fsf@suse.de>
From: Jinpu Wang <jinpu.wang@ionos.com>
Date: Wed, 2 Apr 2025 07:06:00 +0200
X-Gm-Features: AQ5f1Joc9tyaXIJbEN61hqIiWxyaipytNVHSClqiaNB9_rkT4V7NANmVjdj1nc4
Message-ID: <CAMGffEmD+t4SKj3SERTHPY0GusmXjzEA-RO25wktKm-SW=uS_w@mail.gmail.com>
Subject: Re: [PATCH] migration/rdma: Remove qemu_rdma_broken_ipv6_kernel
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org, peterx@redhat.com, 
 Li Zhijian <lizhijian@fujitsu.com>, Yu Zhang <yu.zhang@ionos.com>,
 linux-rdma@vger.kernel.org, 
 michael@flatgalaxy.com, Michael Galaxy <mrgalaxy@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: permerror client-ip=2a00:1450:4864:20::530;
 envelope-from=jinpu.wang@ionos.com; helo=mail-ed1-x530.google.com
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

Hi Fabiano,

On Tue, Apr 1, 2025 at 9:32=E2=80=AFPM Fabiano Rosas <farosas@suse.de> wrot=
e:
>
> Jack Wang <jinpu.wang@ionos.com> writes:
>
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
> > Tested-by: Li zhijian <lizhijian@fujitsu.com>
> > Reviewed-by: Michael Galaxy <mrgalaxy@nvidia.com>
> > ---
> > v1: drop RFC, fix build error (zhijian), collect Reviewed-by and Tested=
-by
> >
> >  migration/rdma.c | 159 -----------------------------------------------
> >  1 file changed, 159 deletions(-)
> >
> > diff --git a/migration/rdma.c b/migration/rdma.c
> > index 76fb0349238a..e228520b8e01 100644
> > --- a/migration/rdma.c
> > +++ b/migration/rdma.c
> > @@ -767,149 +767,6 @@ static void qemu_rdma_dump_gid(const char *who, s=
truct rdma_cm_id *id)
> >      trace_qemu_rdma_dump_gid(who, sgid, dgid);
> >  }
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
> >  /*
> >   * Figure out which RDMA device corresponds to the requested IP hostna=
me
> >   * Also create the initial connection manager identifiers for opening
> > @@ -955,7 +812,6 @@ static int qemu_rdma_resolve_host(RDMAContext *rdma=
, Error **errp)
> >
> >      /* Try all addresses, saving the first error in @err */
> >      for (struct rdma_addrinfo *e =3D res; e !=3D NULL; e =3D e->ai_nex=
t) {
> > -        Error **local_errp =3D err ? NULL : &err;
> >
> >          inet_ntop(e->ai_family,
> >              &((struct sockaddr_in *) e->ai_dst_addr)->sin_addr, ip, si=
zeof ip);
> > @@ -964,13 +820,6 @@ static int qemu_rdma_resolve_host(RDMAContext *rdm=
a, Error **errp)
> >          ret =3D rdma_resolve_addr(rdma->cm_id, NULL, e->ai_dst_addr,
> >                  RDMA_RESOLVE_TIMEOUT_MS);
> >          if (ret >=3D 0) {
> > -            if (e->ai_family =3D=3D AF_INET6) {
> > -                ret =3D qemu_rdma_broken_ipv6_kernel(rdma->cm_id->verb=
s,
> > -                                                   local_errp);
> > -                if (ret < 0) {
> > -                    continue;
> > -                }
> > -            }
> >              error_free(err);
>
> err is now unused and should be removed entirely. The comment before the
> loop needs touching up as well.

Good catch, will fix both in v2.
>
> >              goto route;
> >          }
> > @@ -2663,7 +2512,6 @@ static int qemu_rdma_dest_init(RDMAContext *rdma,=
 Error **errp)
> >
> >      /* Try all addresses, saving the first error in @err */
> >      for (e =3D res; e !=3D NULL; e =3D e->ai_next) {
> > -        Error **local_errp =3D err ? NULL : &err;
> >
> >          inet_ntop(e->ai_family,
> >              &((struct sockaddr_in *) e->ai_dst_addr)->sin_addr, ip, si=
zeof ip);
> > @@ -2672,13 +2520,6 @@ static int qemu_rdma_dest_init(RDMAContext *rdma=
, Error **errp)
> >          if (ret < 0) {
> >              continue;
> >          }
> > -        if (e->ai_family =3D=3D AF_INET6) {
> > -            ret =3D qemu_rdma_broken_ipv6_kernel(listen_id->verbs,
> > -                                               local_errp);
> > -            if (ret < 0) {
> > -                continue;
> > -            }
> > -        }
> >          error_free(err);
>
> Same here.
>
> >          break;
> >      }

