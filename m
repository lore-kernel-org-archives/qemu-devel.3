Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72609C43458
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jul 2026 10:05:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wja0X-00073I-GB; Tue, 14 Jul 2026 06:04:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kkostiuk@redhat.com>)
 id 1wja0T-00071q-94
 for qemu-devel@nongnu.org; Tue, 14 Jul 2026 06:04:53 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kkostiuk@redhat.com>)
 id 1wja0O-0004xj-78
 for qemu-devel@nongnu.org; Tue, 14 Jul 2026 06:04:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1784023486;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=FMGMiPNWtBpY0uzFaO4Nd1LTr2trwJJvGe3bxAKc2WI=;
 b=hXXLAYdD5vp2eh1xO+LG9TJPNCgROxE31BMefKei9V2CwfEJNAv5FTKHFm186X0ThADLSJ
 YX9MRodOJF/H0vPth0pJvYsINoqS/onEDqFBnNuEz9pTaASJX4IEwUv17OttyfsPDgTzDb
 K518jkAv9arravDFYW/zQe3SSMaSOr8=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-260-FADYO0tyNjycJqQ_IImNxA-1; Tue, 14 Jul 2026 06:04:44 -0400
X-MC-Unique: FADYO0tyNjycJqQ_IImNxA-1
X-Mimecast-MFC-AGG-ID: FADYO0tyNjycJqQ_IImNxA_1784023484
Received: by mail-qv1-f70.google.com with SMTP id
 6a1803df08f44-8fc92c5373bso64577376d6.1
 for <qemu-devel@nongnu.org>; Tue, 14 Jul 2026 03:04:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784023484; cv=none;
 d=google.com; s=arc-20260327;
 b=V/G0iqo+Av/pefPzZAtFbuhLtKf8yz0UxhfAbhFC1MuBkLfk++sPqcy0cQaqmXnrtt
 r6vG3AU4cdD2iqYsSUUbxur/NE03e1yAN5MzHa7UCQesP/kFxBKmUi6n1FVGOjjfuzNb
 QYj+0oM165c7183pX/lTEpXXeNk4BPHlfXNopNbYaD1k7zpgkGCFSE2hfhVYPM93g+uw
 S/1+Z5iewJ62bHSTl6J+tdq+vWiC+rit7cPFgM6jK/R6aawE4HnPgEez9bLVY3Kl54aF
 AV14l6iGbKQ4tfbPXGHABTIzEtgwo8N934oaohYuKmZKFXaShmXMOxJwQeEjPH5DkYPa
 01Kw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=FMGMiPNWtBpY0uzFaO4Nd1LTr2trwJJvGe3bxAKc2WI=;
 fh=hx4NOeU8lhUvezwFmjfF6zLnVME+nuDkQiDnnmRw0oI=;
 b=cZXTRdw4GRvNCZ/6kt3J8qAvn4idquVXOtIh+5beOR3Zua0123+O7IClO7Li3ozhcj
 3PwXqHhDiBkwZP0VbxOkBr/w1WMWAt5xKfPSSLm/Gnt1UkTA8y2oSMEr07dHsEo4Ssxz
 HxHCpasSVUDH3omwM/a0qtQBJF73TMWF4x5SnjIsG6XDnv1oyVDOD6W+hbvuYsgszZJj
 eKqqOoBkJfH8WWrdBqo2fRFlMYQKnEuRr3/odsoZs5BOFEFWwWBE9dk3T27oguW8nYG8
 yQCNxVSAlhObna1J/YYUAp8wd76PO5mrQqL9w8Nmhs8p+NU/2GmGKKXECqVAfmVOsP9r
 FtFw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1784023484; x=1784628284; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=FMGMiPNWtBpY0uzFaO4Nd1LTr2trwJJvGe3bxAKc2WI=;
 b=H+mgDNFt6PCI0AityUguI1P1QO/kdaup6qrRbzl4xmF4iowJD/SIGWIHmkyHNsE9DS
 p8WFHF8d+PGa2uAvDtjbX8xzs6zYl1DqqC+IrR7+wgDKbjxXLB6Ha6nvRD9z0agxeElG
 xUvBRbXvymeky2uDpw8wshqwGPt4XAAzHMfx6i7vLaaB6qznAMzXwBJJRlviVcOzmhAP
 timCnWPtVq3FM2b20P1XKABBk2yQkDcY+DMXptu2zZwUmlJb7fkoqLHxMVpHoI1C38w4
 CNHiPB49PxTJt4djHXJXSPmcNRryvjfsMbQobi+i8U911hnyRFE4gv3XBouxmtJjWHc0
 VCBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784023484; x=1784628284;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=FMGMiPNWtBpY0uzFaO4Nd1LTr2trwJJvGe3bxAKc2WI=;
 b=qis9Vnt/bUYqTob35OREHvcefS+N9atYnGITiKCGSojAJqcI6FkvV88RQFHq3URO+v
 A2vgLsljYbmr/Epdu7oKdpNH5mN8JBEB/lKUQw4vsljTq2XtAujxCQ7YelStVcgfMUVQ
 Fd2PGcgLUiVyhue6MlGEAud2Cqz7bBjaAdBKkQNsRgOoXHHIVaR9mpxBpwcsgfH0cv+w
 3um1HPPdTgRVeNwT4CPZ3pnDmmlTTW+Y2+fCMHtxhzKer64I8ifKbLCBi+WKhPoTPdqm
 kGZ9QTgKYtw790JOdnBqWLvlruIOCXtGEqvAdfXW0fvnQrwNx2T8Tu92TOysIUPokRVt
 WT8w==
X-Gm-Message-State: AOJu0Yys0mVpNYQg2wG5Zx22L9JgToNKhVZYVpO442u9/P3p+uTCgtV4
 wAJsQ8cNYq58Zgg1CiPNlW1j7VbzHMvqADLJmOSoUMdLsy1KRjnK+Vy2y5XJJzHc+T5KlZip1Pc
 OwT75VM7UgFU9ZKYqk4nP2Dnoj+Nls14fwxORSHwsBPLIejF2iQYv97m6sVpVWiJxsUQf/tBOKe
 Y1AQYhbJWWaoEBsR0+VScu9Xvn3dDHzEUBdat1LGY=
X-Gm-Gg: AfdE7cmt921oLsbHIR++5iHG+z/lPlKx4/oD4fGN/yVxHI9b0iHadzk4KKNUhDzgWqI
 ZANlj5mNfXilHGdCUjIm82T3oDAzPtr/sER/enRBbB4hdCEmlMgLWimdJ3MvO7A4kfwdECW9mQG
 f2dLaKa1vZHqE0rdg5Sj7OMw3YOM34t9zFwtPzjvN4H4nOyHwVY1eJBgO5JqbjXhQSE5hW3g==
X-Received: by 2002:a05:6214:1c8b:b0:8dc:e4bf:67ec with SMTP id
 6a1803df08f44-90401287eacmr136033846d6.5.1784023484221; 
 Tue, 14 Jul 2026 03:04:44 -0700 (PDT)
X-Received: by 2002:a05:6214:1c8b:b0:8dc:e4bf:67ec with SMTP id
 6a1803df08f44-90401287eacmr136033516d6.5.1784023483790; Tue, 14 Jul 2026
 03:04:43 -0700 (PDT)
MIME-Version: 1.0
References: <20260703163107.46469-1-bogorodskiy@gmail.com>
In-Reply-To: <20260703163107.46469-1-bogorodskiy@gmail.com>
From: Kostiantyn Kostiuk <kkostiuk@redhat.com>
Date: Tue, 14 Jul 2026 13:04:31 +0300
X-Gm-Features: AUfX_mwggIPvfe4-h0BXfp4SMpYxAedCcK0phcbTJFc5OVEUGkNOASdc3mhTqwk
Message-ID: <CAPMcbCorQZ9SgdO4pgTnU6n7ED+ZwWPmwUSB59oYoprm4rgdzg@mail.gmail.com>
Subject: Re: [PATCH v2] qga: implement 'guest-get-fsinfo' for FreeBSD
To: Roman Bogorodskiy <bogorodskiy@gmail.com>
Cc: qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>, 
 Michael Roth <michael.roth@amd.com>, Eric Blake <eblake@redhat.com>
Content-Type: multipart/alternative; boundary="00000000000005ca4306568f56cd"
Received-SPF: permerror client-ip=170.10.133.124;
 envelope-from=kkostiuk@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01,
 RCVD_IN_MSPIKE_WL=-0.01, SPF_HELO_PASS=-0.001,
 T_SPF_PERMERROR=0.01 autolearn=ham autolearn_force=no
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

--00000000000005ca4306568f56cd
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Reviewed-by: Kostiantyn Kostiuk <kkostiuk@redhat.com>

On Fri, Jul 3, 2026 at 7:32=E2=80=AFPM Roman Bogorodskiy <bogorodskiy@gmail=
.com>
wrote:

> Implement the qmp_guest_get_fsinfo() API for FreeBSD.
> To implement it, reuse build_fs_mount_list() which is already
> implemented for FreeBSD. Extend the FsMount type to include
> a string "fromname" attribute to store the disk the FS is mounted from.
>
> Disk mapping info is not covered by this implementation.
>
> Signed-off-by: Roman Bogorodskiy <bogorodskiy@gmail.com>
> Acked-by: Markus Armbruster <armbru@redhat.com>
> ---
> Changes since v1:
>
>  - Replace g_malloc0() with g_new0(.., 1) for GuestFilesystemInfo
>
>
>  qga/commands-bsd.c    | 62 ++++++++++++++++++++++++++++++++++++++++++-
>  qga/commands-common.h |  1 +
>  qga/commands-posix.c  |  3 +++
>  qga/qapi-schema.json  | 12 ++++-----
>  4 files changed, 71 insertions(+), 7 deletions(-)
>
> diff --git a/qga/commands-bsd.c b/qga/commands-bsd.c
> index 94ff6fee6a..7f65f2b8db 100644
> --- a/qga/commands-bsd.c
> +++ b/qga/commands-bsd.c
> @@ -20,6 +20,7 @@
>  #include <sys/ucred.h>
>  #include <sys/mount.h>
>  #include <net/if_dl.h>
> +#include <sys/statvfs.h>
>  #if defined(__NetBSD__) || defined(__OpenBSD__)
>  #include <net/if_arp.h>
>  #include <netinet/if_ether.h>
> @@ -28,7 +29,7 @@
>  #endif
>  #include <paths.h>
>
> -#if defined(CONFIG_FSFREEZE) || defined(CONFIG_FSTRIM)
> +#if defined(CONFIG_FSFREEZE) || defined(CONFIG_FSTRIM) ||
> defined(__FreeBSD__)
>  bool build_fs_mount_list(FsMountList *mounts, Error **errp)
>  {
>      FsMount *mount;
> @@ -55,6 +56,7 @@ bool build_fs_mount_list(FsMountList *mounts, Error
> **errp)
>
>          mount->dirname =3D g_strdup(mntp->f_mntonname);
>          mount->devtype =3D g_strdup(mntp->f_fstypename);
> +        mount->fromname =3D g_strdup(mntp->f_mntfromname);
>          mount->devmajor =3D major(mount->dev);
>          mount->devminor =3D minor(mount->dev);
>          mount->fsid =3D mntp->f_fsid;
> @@ -178,3 +180,61 @@ bool guest_get_hw_addr(struct ifaddrs *ifa, unsigned
> char *buf,
>      return true;
>  }
>  #endif /* HAVE_GETIFADDRS */
> +
> +#if defined(__FreeBSD__)
> +static GuestFilesystemInfo *build_guest_fsinfo(struct FsMount *mount,
> +                                               Error **errp)
> +{
> +    GuestFilesystemInfo *fs =3D g_new0(GuestFilesystemInfo, 1);
> +    struct statvfs buf;
> +    unsigned long used, nonroot_total, fr_size;
> +
> +    fs->mountpoint =3D g_strdup(mount->dirname);
> +    fs->type =3D g_strdup(mount->devtype);
> +    fs->name =3D g_strdup(g_path_get_basename(mount->fromname));
> +
> +    if (statvfs(fs->mountpoint, &buf) =3D=3D 0) {
> +        fr_size =3D buf.f_frsize;
> +        used =3D buf.f_blocks - buf.f_bfree;
> +        nonroot_total =3D used + buf.f_bavail;
> +        fs->used_bytes =3D used * fr_size;
> +        fs->total_bytes =3D nonroot_total * fr_size;
> +        fs->total_bytes_privileged =3D buf.f_blocks * fr_size;
> +
> +        fs->has_total_bytes =3D true;
> +        fs->has_total_bytes_privileged =3D true;
> +        fs->has_used_bytes =3D true;
> +    }
> +
> +    return fs;
> +}
> +
> +GuestFilesystemInfoList *qmp_guest_get_fsinfo(Error **errp)
> +{
> +    FsMountList mounts;
> +    struct FsMount *mount;
> +    GuestFilesystemInfoList *ret =3D NULL;
> +    Error *local_err =3D NULL;
> +
> +    QTAILQ_INIT(&mounts);
> +    if (!build_fs_mount_list(&mounts, &local_err)) {
> +        error_propagate(errp, local_err);
> +        return NULL;
> +    }
> +
> +    QTAILQ_FOREACH(mount, &mounts, next) {
> +        g_debug("Building guest fsinfo for '%s'", mount->dirname);
> +
> +        QAPI_LIST_PREPEND(ret, build_guest_fsinfo(mount, &local_err));
> +        if (local_err) {
> +            error_propagate(errp, local_err);
> +            qapi_free_GuestFilesystemInfoList(ret);
> +            ret =3D NULL;
> +            break;
> +        }
> +    }
> +
> +    free_fs_mount_list(&mounts);
> +    return ret;
> +}
> +#endif /* __FreeBSD__ */
> diff --git a/qga/commands-common.h b/qga/commands-common.h
> index 263e7c0525..a07d0885f5 100644
> --- a/qga/commands-common.h
> +++ b/qga/commands-common.h
> @@ -29,6 +29,7 @@ typedef struct FsMount {
>  #if defined(__FreeBSD__)
>      dev_t dev;
>      fsid_t fsid;
> +    char *fromname;
>  #endif
>      QTAILQ_ENTRY(FsMount) next;
>  } FsMount;
> diff --git a/qga/commands-posix.c b/qga/commands-posix.c
> index 837be51c40..837e285b6d 100644
> --- a/qga/commands-posix.c
> +++ b/qga/commands-posix.c
> @@ -731,6 +731,9 @@ void free_fs_mount_list(FsMountList *mounts)
>           QTAILQ_REMOVE(mounts, mount, next);
>           g_free(mount->dirname);
>           g_free(mount->devtype);
> +#if defined(__FreeBSD__)
> +         g_free(mount->fromname);
> +#endif
>           g_free(mount);
>       }
>  }
> diff --git a/qga/qapi-schema.json b/qga/qapi-schema.json
> index c57bc9a02f..8cd0ba048b 100644
> --- a/qga/qapi-schema.json
> +++ b/qga/qapi-schema.json
> @@ -874,7 +874,7 @@
>    'data': [ 'ide', 'fdc', 'scsi', 'virtio', 'xen', 'usb', 'uml', 'sata',
>              'sd', 'unknown', 'ieee1394', 'ssa', 'fibre', 'raid', 'iscsi'=
,
>              'sas', 'mmc', 'virtual', 'file-backed-virtual', 'nvme' ],
> -  'if': { 'any': [ 'CONFIG_WIN32', 'CONFIG_LINUX' ] } }
> +  'if': { 'any': [ 'CONFIG_WIN32', 'CONFIG_LINUX', 'CONFIG_FREEBSD' ] } =
}
>
>  ##
>  # @GuestPCIAddress:
> @@ -892,7 +892,7 @@
>  { 'struct': 'GuestPCIAddress',
>    'data': {'domain': 'int', 'bus': 'int',
>             'slot': 'int', 'function': 'int'},
> -  'if': { 'any': [ 'CONFIG_WIN32', 'CONFIG_LINUX' ] } }
> +  'if': { 'any': [ 'CONFIG_WIN32', 'CONFIG_LINUX', 'CONFIG_FREEBSD' ] } =
}
>
>  ##
>  # @GuestCCWAddress:
> @@ -912,7 +912,7 @@
>             'ssid': 'int',
>             'subchno': 'int',
>             'devno': 'int'},
> -  'if': { 'any': [ 'CONFIG_WIN32', 'CONFIG_LINUX' ] } }
> +  'if': { 'any': [ 'CONFIG_WIN32', 'CONFIG_LINUX', 'CONFIG_FREEBSD' ] } =
}
>
>  ##
>  # @GuestDiskAddress:
> @@ -942,7 +942,7 @@
>             'bus': 'int', 'target': 'int', 'unit': 'int',
>             '*serial': 'str', '*dev': 'str',
>             '*ccw-address': 'GuestCCWAddress'},
> -  'if': { 'any': [ 'CONFIG_WIN32', 'CONFIG_LINUX' ] } }
> +  'if': { 'any': [ 'CONFIG_WIN32', 'CONFIG_LINUX', 'CONFIG_FREEBSD' ] } =
}
>
>  ##
>  # @GuestNVMeSmart:
> @@ -1063,7 +1063,7 @@
>    'data': {'name': 'str', 'mountpoint': 'str', 'type': 'str',
>             '*used-bytes': 'uint64', '*total-bytes': 'uint64',
>             '*total-bytes-privileged': 'uint64', 'disk':
> ['GuestDiskAddress']},
> -  'if': { 'any': [ 'CONFIG_WIN32', 'CONFIG_LINUX' ] } }
> +  'if': { 'any': [ 'CONFIG_WIN32', 'CONFIG_LINUX', 'CONFIG_FREEBSD' ] } =
}
>
>  ##
>  # @guest-get-fsinfo:
> @@ -1077,7 +1077,7 @@
>  ##
>  { 'command': 'guest-get-fsinfo',
>    'returns': ['GuestFilesystemInfo'],
> -  'if': { 'any': [ 'CONFIG_WIN32', 'CONFIG_LINUX' ] } }
> +  'if': { 'any': [ 'CONFIG_WIN32', 'CONFIG_LINUX', 'CONFIG_FREEBSD' ] } =
}
>
>  ##
>  # @guest-set-user-password:
> --
> 2.52.0
>
>

--00000000000005ca4306568f56cd
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Reviewed-by: Kostiantyn Kostiuk &lt;<a href=3D"mailto=
:kkostiuk@redhat.com">kkostiuk@redhat.com</a>&gt;</div></div><br><div class=
=3D"gmail_quote gmail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr=
">On Fri, Jul 3, 2026 at 7:32=E2=80=AFPM Roman Bogorodskiy &lt;<a href=3D"m=
ailto:bogorodskiy@gmail.com">bogorodskiy@gmail.com</a>&gt; wrote:<br></div>=
<blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-=
left:1px solid rgb(204,204,204);padding-left:1ex">Implement the qmp_guest_g=
et_fsinfo() API for FreeBSD.<br>
To implement it, reuse build_fs_mount_list() which is already<br>
implemented for FreeBSD. Extend the FsMount type to include<br>
a string &quot;fromname&quot; attribute to store the disk the FS is mounted=
 from.<br>
<br>
Disk mapping info is not covered by this implementation.<br>
<br>
Signed-off-by: Roman Bogorodskiy &lt;<a href=3D"mailto:bogorodskiy@gmail.co=
m" target=3D"_blank">bogorodskiy@gmail.com</a>&gt;<br>
Acked-by: Markus Armbruster &lt;<a href=3D"mailto:armbru@redhat.com" target=
=3D"_blank">armbru@redhat.com</a>&gt;<br>
---<br>
Changes since v1:<br>
<br>
=C2=A0- Replace g_malloc0() with g_new0(.., 1) for GuestFilesystemInfo<br>
<br>
<br>
=C2=A0qga/commands-bsd.c=C2=A0 =C2=A0 | 62 ++++++++++++++++++++++++++++++++=
++++++++++-<br>
=C2=A0qga/commands-common.h |=C2=A0 1 +<br>
=C2=A0qga/commands-posix.c=C2=A0 |=C2=A0 3 +++<br>
=C2=A0qga/qapi-schema.json=C2=A0 | 12 ++++-----<br>
=C2=A04 files changed, 71 insertions(+), 7 deletions(-)<br>
<br>
diff --git a/qga/commands-bsd.c b/qga/commands-bsd.c<br>
index 94ff6fee6a..7f65f2b8db 100644<br>
--- a/qga/commands-bsd.c<br>
+++ b/qga/commands-bsd.c<br>
@@ -20,6 +20,7 @@<br>
=C2=A0#include &lt;sys/ucred.h&gt;<br>
=C2=A0#include &lt;sys/mount.h&gt;<br>
=C2=A0#include &lt;net/if_dl.h&gt;<br>
+#include &lt;sys/statvfs.h&gt;<br>
=C2=A0#if defined(__NetBSD__) || defined(__OpenBSD__)<br>
=C2=A0#include &lt;net/if_arp.h&gt;<br>
=C2=A0#include &lt;netinet/if_ether.h&gt;<br>
@@ -28,7 +29,7 @@<br>
=C2=A0#endif<br>
=C2=A0#include &lt;paths.h&gt;<br>
<br>
-#if defined(CONFIG_FSFREEZE) || defined(CONFIG_FSTRIM)<br>
+#if defined(CONFIG_FSFREEZE) || defined(CONFIG_FSTRIM) || defined(__FreeBS=
D__)<br>
=C2=A0bool build_fs_mount_list(FsMountList *mounts, Error **errp)<br>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0FsMount *mount;<br>
@@ -55,6 +56,7 @@ bool build_fs_mount_list(FsMountList *mounts, Error **err=
p)<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0mount-&gt;dirname =3D g_strdup(mntp-&gt;f=
_mntonname);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0mount-&gt;devtype =3D g_strdup(mntp-&gt;f=
_fstypename);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 mount-&gt;fromname =3D g_strdup(mntp-&gt;f_mnt=
fromname);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0mount-&gt;devmajor =3D major(mount-&gt;de=
v);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0mount-&gt;devminor =3D minor(mount-&gt;de=
v);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0mount-&gt;fsid =3D mntp-&gt;f_fsid;<br>
@@ -178,3 +180,61 @@ bool guest_get_hw_addr(struct ifaddrs *ifa, unsigned c=
har *buf,<br>
=C2=A0 =C2=A0 =C2=A0return true;<br>
=C2=A0}<br>
=C2=A0#endif /* HAVE_GETIFADDRS */<br>
+<br>
+#if defined(__FreeBSD__)<br>
+static GuestFilesystemInfo *build_guest_fsinfo(struct FsMount *mount,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0Error **errp)<br>
+{<br>
+=C2=A0 =C2=A0 GuestFilesystemInfo *fs =3D g_new0(GuestFilesystemInfo, 1);<=
br>
+=C2=A0 =C2=A0 struct statvfs buf;<br>
+=C2=A0 =C2=A0 unsigned long used, nonroot_total, fr_size;<br>
+<br>
+=C2=A0 =C2=A0 fs-&gt;mountpoint =3D g_strdup(mount-&gt;dirname);<br>
+=C2=A0 =C2=A0 fs-&gt;type =3D g_strdup(mount-&gt;devtype);<br>
+=C2=A0 =C2=A0 fs-&gt;name =3D g_strdup(g_path_get_basename(mount-&gt;fromn=
ame));<br>
+<br>
+=C2=A0 =C2=A0 if (statvfs(fs-&gt;mountpoint, &amp;buf) =3D=3D 0) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 fr_size =3D buf.f_frsize;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 used =3D buf.f_blocks - buf.f_bfree;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 nonroot_total =3D used + buf.f_bavail;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 fs-&gt;used_bytes =3D used * fr_size;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 fs-&gt;total_bytes =3D nonroot_total * fr_size=
;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 fs-&gt;total_bytes_privileged =3D buf.f_blocks=
 * fr_size;<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 fs-&gt;has_total_bytes =3D true;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 fs-&gt;has_total_bytes_privileged =3D true;<br=
>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 fs-&gt;has_used_bytes =3D true;<br>
+=C2=A0 =C2=A0 }<br>
+<br>
+=C2=A0 =C2=A0 return fs;<br>
+}<br>
+<br>
+GuestFilesystemInfoList *qmp_guest_get_fsinfo(Error **errp)<br>
+{<br>
+=C2=A0 =C2=A0 FsMountList mounts;<br>
+=C2=A0 =C2=A0 struct FsMount *mount;<br>
+=C2=A0 =C2=A0 GuestFilesystemInfoList *ret =3D NULL;<br>
+=C2=A0 =C2=A0 Error *local_err =3D NULL;<br>
+<br>
+=C2=A0 =C2=A0 QTAILQ_INIT(&amp;mounts);<br>
+=C2=A0 =C2=A0 if (!build_fs_mount_list(&amp;mounts, &amp;local_err)) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 error_propagate(errp, local_err);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return NULL;<br>
+=C2=A0 =C2=A0 }<br>
+<br>
+=C2=A0 =C2=A0 QTAILQ_FOREACH(mount, &amp;mounts, next) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 g_debug(&quot;Building guest fsinfo for &#39;%=
s&#39;&quot;, mount-&gt;dirname);<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 QAPI_LIST_PREPEND(ret, build_guest_fsinfo(moun=
t, &amp;local_err));<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (local_err) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 error_propagate(errp, local_err)=
;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 qapi_free_GuestFilesystemInfoLis=
t(ret);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ret =3D NULL;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 }<br>
+<br>
+=C2=A0 =C2=A0 free_fs_mount_list(&amp;mounts);<br>
+=C2=A0 =C2=A0 return ret;<br>
+}<br>
+#endif /* __FreeBSD__ */<br>
diff --git a/qga/commands-common.h b/qga/commands-common.h<br>
index 263e7c0525..a07d0885f5 100644<br>
--- a/qga/commands-common.h<br>
+++ b/qga/commands-common.h<br>
@@ -29,6 +29,7 @@ typedef struct FsMount {<br>
=C2=A0#if defined(__FreeBSD__)<br>
=C2=A0 =C2=A0 =C2=A0dev_t dev;<br>
=C2=A0 =C2=A0 =C2=A0fsid_t fsid;<br>
+=C2=A0 =C2=A0 char *fromname;<br>
=C2=A0#endif<br>
=C2=A0 =C2=A0 =C2=A0QTAILQ_ENTRY(FsMount) next;<br>
=C2=A0} FsMount;<br>
diff --git a/qga/commands-posix.c b/qga/commands-posix.c<br>
index 837be51c40..837e285b6d 100644<br>
--- a/qga/commands-posix.c<br>
+++ b/qga/commands-posix.c<br>
@@ -731,6 +731,9 @@ void free_fs_mount_list(FsMountList *mounts)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 QTAILQ_REMOVE(mounts, mount, next);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 g_free(mount-&gt;dirname);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 g_free(mount-&gt;devtype);<br>
+#if defined(__FreeBSD__)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0g_free(mount-&gt;fromname);<br>
+#endif<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 g_free(mount);<br>
=C2=A0 =C2=A0 =C2=A0 }<br>
=C2=A0}<br>
diff --git a/qga/qapi-schema.json b/qga/qapi-schema.json<br>
index c57bc9a02f..8cd0ba048b 100644<br>
--- a/qga/qapi-schema.json<br>
+++ b/qga/qapi-schema.json<br>
@@ -874,7 +874,7 @@<br>
=C2=A0 =C2=A0&#39;data&#39;: [ &#39;ide&#39;, &#39;fdc&#39;, &#39;scsi&#39;=
, &#39;virtio&#39;, &#39;xen&#39;, &#39;usb&#39;, &#39;uml&#39;, &#39;sata&=
#39;,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&#39;sd&#39;, &#39;unknown&=
#39;, &#39;ieee1394&#39;, &#39;ssa&#39;, &#39;fibre&#39;, &#39;raid&#39;, &=
#39;iscsi&#39;,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&#39;sas&#39;, &#39;mmc&#39=
;, &#39;virtual&#39;, &#39;file-backed-virtual&#39;, &#39;nvme&#39; ],<br>
-=C2=A0 &#39;if&#39;: { &#39;any&#39;: [ &#39;CONFIG_WIN32&#39;, &#39;CONFI=
G_LINUX&#39; ] } }<br>
+=C2=A0 &#39;if&#39;: { &#39;any&#39;: [ &#39;CONFIG_WIN32&#39;, &#39;CONFI=
G_LINUX&#39;, &#39;CONFIG_FREEBSD&#39; ] } }<br>
<br>
=C2=A0##<br>
=C2=A0# @GuestPCIAddress:<br>
@@ -892,7 +892,7 @@<br>
=C2=A0{ &#39;struct&#39;: &#39;GuestPCIAddress&#39;,<br>
=C2=A0 =C2=A0&#39;data&#39;: {&#39;domain&#39;: &#39;int&#39;, &#39;bus&#39=
;: &#39;int&#39;,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &#39;slot&#39;: &#39;int&#39;, &#=
39;function&#39;: &#39;int&#39;},<br>
-=C2=A0 &#39;if&#39;: { &#39;any&#39;: [ &#39;CONFIG_WIN32&#39;, &#39;CONFI=
G_LINUX&#39; ] } }<br>
+=C2=A0 &#39;if&#39;: { &#39;any&#39;: [ &#39;CONFIG_WIN32&#39;, &#39;CONFI=
G_LINUX&#39;, &#39;CONFIG_FREEBSD&#39; ] } }<br>
<br>
=C2=A0##<br>
=C2=A0# @GuestCCWAddress:<br>
@@ -912,7 +912,7 @@<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &#39;ssid&#39;: &#39;int&#39;,<br=
>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &#39;subchno&#39;: &#39;int&#39;,=
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &#39;devno&#39;: &#39;int&#39;},<=
br>
-=C2=A0 &#39;if&#39;: { &#39;any&#39;: [ &#39;CONFIG_WIN32&#39;, &#39;CONFI=
G_LINUX&#39; ] } }<br>
+=C2=A0 &#39;if&#39;: { &#39;any&#39;: [ &#39;CONFIG_WIN32&#39;, &#39;CONFI=
G_LINUX&#39;, &#39;CONFIG_FREEBSD&#39; ] } }<br>
<br>
=C2=A0##<br>
=C2=A0# @GuestDiskAddress:<br>
@@ -942,7 +942,7 @@<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &#39;bus&#39;: &#39;int&#39;, &#3=
9;target&#39;: &#39;int&#39;, &#39;unit&#39;: &#39;int&#39;,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &#39;*serial&#39;: &#39;str&#39;,=
 &#39;*dev&#39;: &#39;str&#39;,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &#39;*ccw-address&#39;: &#39;Gues=
tCCWAddress&#39;},<br>
-=C2=A0 &#39;if&#39;: { &#39;any&#39;: [ &#39;CONFIG_WIN32&#39;, &#39;CONFI=
G_LINUX&#39; ] } }<br>
+=C2=A0 &#39;if&#39;: { &#39;any&#39;: [ &#39;CONFIG_WIN32&#39;, &#39;CONFI=
G_LINUX&#39;, &#39;CONFIG_FREEBSD&#39; ] } }<br>
<br>
=C2=A0##<br>
=C2=A0# @GuestNVMeSmart:<br>
@@ -1063,7 +1063,7 @@<br>
=C2=A0 =C2=A0&#39;data&#39;: {&#39;name&#39;: &#39;str&#39;, &#39;mountpoin=
t&#39;: &#39;str&#39;, &#39;type&#39;: &#39;str&#39;,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &#39;*used-bytes&#39;: &#39;uint6=
4&#39;, &#39;*total-bytes&#39;: &#39;uint64&#39;,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &#39;*total-bytes-privileged&#39;=
: &#39;uint64&#39;, &#39;disk&#39;: [&#39;GuestDiskAddress&#39;]},<br>
-=C2=A0 &#39;if&#39;: { &#39;any&#39;: [ &#39;CONFIG_WIN32&#39;, &#39;CONFI=
G_LINUX&#39; ] } }<br>
+=C2=A0 &#39;if&#39;: { &#39;any&#39;: [ &#39;CONFIG_WIN32&#39;, &#39;CONFI=
G_LINUX&#39;, &#39;CONFIG_FREEBSD&#39; ] } }<br>
<br>
=C2=A0##<br>
=C2=A0# @guest-get-fsinfo:<br>
@@ -1077,7 +1077,7 @@<br>
=C2=A0##<br>
=C2=A0{ &#39;command&#39;: &#39;guest-get-fsinfo&#39;,<br>
=C2=A0 =C2=A0&#39;returns&#39;: [&#39;GuestFilesystemInfo&#39;],<br>
-=C2=A0 &#39;if&#39;: { &#39;any&#39;: [ &#39;CONFIG_WIN32&#39;, &#39;CONFI=
G_LINUX&#39; ] } }<br>
+=C2=A0 &#39;if&#39;: { &#39;any&#39;: [ &#39;CONFIG_WIN32&#39;, &#39;CONFI=
G_LINUX&#39;, &#39;CONFIG_FREEBSD&#39; ] } }<br>
<br>
=C2=A0##<br>
=C2=A0# @guest-set-user-password:<br>
-- <br>
2.52.0<br>
<br>
</blockquote></div>

--00000000000005ca4306568f56cd--


