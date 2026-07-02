Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8239DC43458
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jul 2026 07:17:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wfBfH-0000xH-W4; Thu, 02 Jul 2026 03:16:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kkostiuk@redhat.com>)
 id 1wfBfG-0000x0-Jn
 for qemu-devel@nongnu.org; Thu, 02 Jul 2026 03:16:50 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kkostiuk@redhat.com>)
 id 1wfBfD-0004DA-33
 for qemu-devel@nongnu.org; Thu, 02 Jul 2026 03:16:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1782976605;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=OjlU+J8ES11GtZuHwTGlE62khxV4WaUhoMUb4xK3oPI=;
 b=DEiMTWjSWgDKB6BQwlgTO0D83tq+IErh2eWwEFUu5CiM6V0sPndMmGDjJjZ7nC4XuA9BS8
 m9FlhQ/HK2Tv7OkdEJ4pHkKsmPpX8uQg8wu5lNrJrFRDqRnBiSpoCfo6ZFnH2SaVPwawro
 hO+5M/quplgj2v77/BITAtg8/TZt1m8=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-107-Zqb4qtpNPaWvFmsSMKFBdw-1; Thu, 02 Jul 2026 03:16:43 -0400
X-MC-Unique: Zqb4qtpNPaWvFmsSMKFBdw-1
X-Mimecast-MFC-AGG-ID: Zqb4qtpNPaWvFmsSMKFBdw_1782976603
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-92e632390d2so298204685a.3
 for <qemu-devel@nongnu.org>; Thu, 02 Jul 2026 00:16:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782976603; cv=none;
 d=google.com; s=arc-20260327;
 b=UTc7md70z7wO9UIWpUZ/KYWbu/dQ1mTH14veN4CWybVfa2q52mie7lSHyPOH1C0BQo
 hXeNDssVNJ+zca4AM2yu+qaULFjunf5kM+YJXjvpmCZeBw6HkDl6wj77ejEtBCTgY0Ay
 6nZB5LesKmJPTOTgXmlCjtgMrTjFY8SYcECwyMZCb5rjPFuPQAbE+NVjXYHnfb7XGIOW
 6foq+3eYHxp7+COeMLQ+uS++WqnzfvkpBuy01cycs7O168dQsyPV2AVkFMhLjUkYNNbz
 4P/jndmmJtbLwYXGljvph6TIChw+UPhqscDHWycZqlOXaL2oxdFoO9C8H96J0r8bgkug
 KVYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=OjlU+J8ES11GtZuHwTGlE62khxV4WaUhoMUb4xK3oPI=;
 fh=oPtfXQM5EZVioUGQT0clvqK6TK6ir1gI82An+AX8V3g=;
 b=BnNgQsn4jW+Iu6WrDrhYRlXQ3tPnyCfNdhoavtrBbe7C/n24kjLmn6KXp4vy1PWXRZ
 E2wuG0d1VQvtCUlGRmOaGDAQdW2r3zMQ1rJaiN+CjawlxKC477H3ejTIpd4z40+sAN/n
 7HIzOiTcCsTPOPTlq6hyNTVEY0arwlaBhLv631jFD0tdzf4pdyOQHVj2UpDkBviDXzhS
 Xz1QFqpIACSwn6mFuwNg4nynH0lUEcsAaQHDENzjgE4sY1N7QSfFdlePGWMJ/3m2LiEL
 s/2YdtnFw7FAS8lxacdbZ2voVlOLYL/dBdIUPpn8nBOiWHAejD3pTqdtPKcDbXrCyNOy
 Pq+w==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1782976603; x=1783581403; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=OjlU+J8ES11GtZuHwTGlE62khxV4WaUhoMUb4xK3oPI=;
 b=KCNcUR15/WH2yloKb6edB3mACu9I7g+lMXEyzZZTlonenXw+RsOChwBg62HGbdMZM2
 aNAI7w8o5TI4MlhNI3CNWDQAeGuuedWWD1nE6prF/aCGekEZRV/1TuCn7L+ztqMRHQn6
 i1nJfp5bIVpDwK7m7/rOWaAzU5VG0gXFJexVNs6n41e9Gaf76IzhNuGN5yNi/kxnJEsY
 bUTK1vQdgzGLxIU1953nW8cl1hekcd/l+awo0ucqSmfxOSgTijkGhudgXiS5x2VGPs7B
 F/hKNdLHmee33gAkhxDTjoySdWWwBq7Lo6WIfwUX1rdiOJiMOKTqV/3Z/OplZilI4rFS
 gpdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782976603; x=1783581403;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=OjlU+J8ES11GtZuHwTGlE62khxV4WaUhoMUb4xK3oPI=;
 b=MUNC1EF5FGl8hH0Tv8EJZr7Fmf9zXZOd7uO+FyJjXPRBVRgSgNDx9egMhBpTZE8+qQ
 S0jtVGMTt0TczRLoXKxOkOixQOFDqtL+HJPRtklMP+QgvhNc4F3BKPq3st/ba5T1xVi9
 TUxxWiUREJHUKlbDQhdS73AUP23Y2YVTl7VQhYIy6fpt/1cqAX18TNymLOdmWFmv4oc5
 8qe4asA3WSXllHFE1I0CLbj1bXtDocx7cOveoa6gSZ0s3ECA+xB4Qe1QgFJQmYKHhyYq
 M1XRS6IqMIbjIdbzT+uqlzHvBRtCKBsot+sZZ7Esvd9E/TamO4046NQj5NjuBvQAEwfE
 G8kw==
X-Gm-Message-State: AOJu0YyJYLL156XnnRTgYImuQfgZnNMz8BVP3nGwmuwtLqjcAqXJxqyO
 yzBfTdKDFaa9c/FwXCtFrx7+yYsvsZw4IGTwl9VGBTTnqvpuNWolcoIZ9MO5nrW2oCXgurA2Vhb
 EpJtKrRBmVUoMPXjkigdcBjC5ZMK7rtMe7NgpEmw4kKiGnBFn+Ya2KfcL4cfsiQAFSE+bRqplZY
 yecdT+6nFgljA78fahPyYa8EQl1lpcC4Q=
X-Gm-Gg: AfdE7cm+gULdsGYHMrlpLxAzEqlcJ0jiJ4T86n8QJDhtnv0Jf1O2FVEVdJpbjgR8orC
 cFBSsM6ehiCHI308I5DxNfflZ/LijSvCM3gvH/djqOvs3Tix9c3fu+YrnWSCfWiGD5zkcyYpIW9
 klVC/6sxtr+hMlUJC57n844GnnwiVa7Lb8LAsCF5Emy4wESfbizDELrc9IjboM4CK/Wc1YsQ==
X-Received: by 2002:a05:620a:472b:b0:925:e485:fca7 with SMTP id
 af79cd13be357-92e7afb154bmr562668985a.15.1782976602965; 
 Thu, 02 Jul 2026 00:16:42 -0700 (PDT)
X-Received: by 2002:a05:620a:472b:b0:925:e485:fca7 with SMTP id
 af79cd13be357-92e7afb154bmr562665885a.15.1782976602459; Thu, 02 Jul 2026
 00:16:42 -0700 (PDT)
MIME-Version: 1.0
References: <20260701162529.10235-1-bogorodskiy@gmail.com>
In-Reply-To: <20260701162529.10235-1-bogorodskiy@gmail.com>
From: Kostiantyn Kostiuk <kkostiuk@redhat.com>
Date: Thu, 2 Jul 2026 10:16:31 +0300
X-Gm-Features: AVVi8CfVpYBL8a4NWYR4Rxr3MMN9V0mvaEIkYG_K7I1I_oED6L8wIBnnoNxJH0k
Message-ID: <CAPMcbCr607ROVbrzpLscdpLSw6bLrkD20czZFAvRpN0pVeozrA@mail.gmail.com>
Subject: Re: [PATCH] qga: implement 'guest-get-fsinfo' for FreeBSD
To: Roman Bogorodskiy <bogorodskiy@gmail.com>
Cc: qemu-devel@nongnu.org, Michael Roth <michael.roth@amd.com>, 
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>
Content-Type: multipart/alternative; boundary="0000000000000868f406559b9784"
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kkostiuk@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_PASS=-0.001,
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

--0000000000000868f406559b9784
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 1, 2026 at 7:27=E2=80=AFPM Roman Bogorodskiy <bogorodskiy@gmail=
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
> ---
>  qga/commands-bsd.c    | 62 ++++++++++++++++++++++++++++++++++++++++++-
>  qga/commands-common.h |  1 +
>  qga/commands-posix.c  |  3 +++
>  qga/qapi-schema.json  | 12 ++++-----
>  4 files changed, 71 insertions(+), 7 deletions(-)
>
> diff --git a/qga/commands-bsd.c b/qga/commands-bsd.c
> index 94ff6fee6a..a258133918 100644
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
> +    GuestFilesystemInfo *fs =3D g_malloc0(sizeof(*fs));
>

Please use g_new0(GuestFilesystemInfo, 1) instead


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

--0000000000000868f406559b9784
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote g=
mail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">On Wed, Jul 1, =
2026 at 7:27=E2=80=AFPM Roman Bogorodskiy &lt;<a href=3D"mailto:bogorodskiy=
@gmail.com">bogorodskiy@gmail.com</a>&gt; wrote:<br></div><blockquote class=
=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rg=
b(204,204,204);padding-left:1ex">Implement the qmp_guest_get_fsinfo() API f=
or FreeBSD.<br>
To implement it, reuse build_fs_mount_list() which is already<br>
implemented for FreeBSD. Extend the FsMount type to include<br>
a string &quot;fromname&quot; attribute to store the disk the FS is mounted=
 from.<br>
<br>
Disk mapping info is not covered by this implementation.<br>
<br>
Signed-off-by: Roman Bogorodskiy &lt;<a href=3D"mailto:bogorodskiy@gmail.co=
m" target=3D"_blank">bogorodskiy@gmail.com</a>&gt;<br>
---<br>
=C2=A0qga/commands-bsd.c=C2=A0 =C2=A0 | 62 ++++++++++++++++++++++++++++++++=
++++++++++-<br>
=C2=A0qga/commands-common.h |=C2=A0 1 +<br>
=C2=A0qga/commands-posix.c=C2=A0 |=C2=A0 3 +++<br>
=C2=A0qga/qapi-schema.json=C2=A0 | 12 ++++-----<br>
=C2=A04 files changed, 71 insertions(+), 7 deletions(-)<br>
<br>
diff --git a/qga/commands-bsd.c b/qga/commands-bsd.c<br>
index 94ff6fee6a..a258133918 100644<br>
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
+=C2=A0 =C2=A0 GuestFilesystemInfo *fs =3D g_malloc0(sizeof(*fs));<br></blo=
ckquote><div><br></div><div>Please use=C2=A0g_new0(GuestFilesystemInfo, 1) =
instead</div><div>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"ma=
rgin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:=
1ex">
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
</blockquote></div></div>

--0000000000000868f406559b9784--


