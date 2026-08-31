Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C24C5C624A4
	for <qemu-devel@archiver.kernel.org>; Mon, 31 Aug 2026 16:06:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x14WF-0000z5-7A; Mon, 31 Aug 2026 12:05:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kkostiuk@redhat.com>)
 id 1x14WD-0000yl-KG
 for qemu-devel@nongnu.org; Mon, 31 Aug 2026 12:05:57 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kkostiuk@redhat.com>)
 id 1x14WA-0002o1-72
 for qemu-devel@nongnu.org; Mon, 31 Aug 2026 12:05:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1788192351;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=RgpwLCoiXdOpetcNvH7SUOY864y6IWzqIzQjNquzz5w=;
 b=KA+3fJeokkktqJ8b+WwMEcJBotNkuROdVu0EpaRQdyF9IouCVbyfffWdHbiI5F3e0xj1WW
 ybO7mVGxLbsxRqynAk3adX/MYthGJ7eLUJOHhf9AvOx/l2h/FxRgl/2XkDVJDAkNeEnuTW
 9dPna64fc3owFWpjkO6GazJ/A9VTHyo=
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-631-LiBrzCeKMpayYsAHWLez0A-1; Mon, 31 Aug 2026 12:05:49 -0400
X-MC-Unique: LiBrzCeKMpayYsAHWLez0A-1
X-Mimecast-MFC-AGG-ID: LiBrzCeKMpayYsAHWLez0A_1788192348
Received: by mail-pl1-f199.google.com with SMTP id
 d9443c01a7336-2cc6dd43737so73284435ad.2
 for <qemu-devel@nongnu.org>; Mon, 31 Aug 2026 09:05:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788192348; cv=none;
 d=google.com; s=arc-20260327;
 b=DfX7WW8a52zZrLQCFuw9PlpuTb8GFR/PuDzPKBpTYayA8QuMePFlnPkMIK6qjbi9bI
 boEy262Oq5Xetrq9hWmrpax8cYIGdllgzDzo0NaVWzeAoihzpCKllkkp+tFzThdI1dSE
 /Ao6FvgOmKb1vgn662bdTw+pcGM42bbwNHiflywnS52qZ4SC+iS3hf8Ey0zAPhiFeXw9
 vg+53eQtSgC6M1pk2obmYOorGVjhrC4anEJhrqKHh4HmwBe/WdUGZ2i6bmnZ2O4cLkYC
 xsQ16uA4Q0kyVWUlqhZ2qfpm0Dy+CtWX4N9FskxhHQqaPfCpfmF5R+zPaFciCKHs8fj+
 8zCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=RgpwLCoiXdOpetcNvH7SUOY864y6IWzqIzQjNquzz5w=;
 fh=oPtfXQM5EZVioUGQT0clvqK6TK6ir1gI82An+AX8V3g=;
 b=MHioG7MHV6ZGaSN/vT2iUzjnd9aFqJNbfCMAyKQRmMGPT6ajRAoKALe5YUBeLQ4bd1
 wKmvOaANektrq82IHIALxuQVzZEhH1g1BvPMmlevK8Nr74OY8NNc4CCRlLUnyRpUsq5h
 KHJqQ6ygCKaOedrObyiKe2W850CP7ISb6nyqf19LigWxJqwg5RLx6e+oRuE7AvuZRy9o
 wu2XrxtYEhJij3weEt4Rpd2FdPaZ6I4sxJrS0Boy+/OnPRjuenFLVYQQ3qY8fTr+H5ln
 zf05wVviqMCwhYmV0vrnvS83njb1kvSD3KpcN/iw4Jp8YUNkjVrM9Vf4XojPG8acfWs7
 S7Pw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1788192348; x=1788797148; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=RgpwLCoiXdOpetcNvH7SUOY864y6IWzqIzQjNquzz5w=;
 b=sBItIpz0GBCT1fXq3g2UEEtWYfCwK7/e+bE3lWCqwp0UsFlTaverHbV6BgS7MMj3Vw
 YxKaz6i6rzkFOyUlo2ALF0hxTxmLbi+8h/pcDY17fe9xZK2jq1aYoyWaEt+7a+kML/MH
 zGLPNQWpcqnXbipCUAdVH41jTc8HPbtEyTrs36tdsQR9QSh/ECSSVAe7l0OciZxfxk6v
 B1skIXAK21+ZsSAYUYRtsk5HFwpLHYqG12ZE6DeEJaoEAJ+34KMAUkAaYTjbNFks1QuI
 xb4lgaqffWjw4Bf7dKBlT7hbQawlOTXbsuHSkMI7aUCRMtbT+sGiuT0ZcTIGGqFQJAb7
 i0Gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788192348; x=1788797148;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=RgpwLCoiXdOpetcNvH7SUOY864y6IWzqIzQjNquzz5w=;
 b=B5Yo/NgVEr63PHLopVEM5Fi+b08B2ZwSBzyVsUwaBhGVs9HORB0GVZPOsPb12KeH8Z
 MppDMxkaE8Tl2C0R676hAz14y19BUTjws+IGiuLIoRgNZlqwJwVJq4hyyWyMZj12uRw4
 tLKSHgjEEdqMrCv05jKiV7hV0z/Kgmk8jlrNoyT7rBU00zMX6X4zLfgcSzUWA107LZzh
 hwPjUPH6OmoWM2/WPwH+davVFmSxAeuZz3oQPVx1GR9q2dFLOIyT8SkhrQcDk3Zkey7B
 cY6KFbObWkj6w1hIJhF/x+iibn8IfbaxYhhShulFl+IfhmGW/jZQbYF3EO6yKG5TJHcC
 cFSg==
X-Gm-Message-State: AFuF++nqrpreecbKmpY1vbQKypQAx8/Os3kDzNmo/Mkfzd29UKjw8Sib
 eo14wy2H8wUl5SnWX3cYNp6OGt7EuXT8hcyLbYk8BHaYAvD1d9kSeLZKTHSO6w8ya/HWm4sD3pU
 OUluxXLR741kemZdZ4eIpq6NtDKW2LpXQ0/hYq3E6+SS/hJzvtKPz6SJIXvbu7jZ9aNRaYtxgXa
 qbHRvynLvtip2Vk5XwjXmSDoue5wUllOM=
X-Gm-Gg: AYBFou0ZvUiSuqCGmVnF4ioK0MaP4a+w3lmm/8VoSTR4hlH+z7q7n2gpyNdAI+W5UCw
 bTeJwTEWvSpdh/iV6y2vQqpiFwbXypz0x/eYhP1al01+XAdBJeFUImBRozj0gzbjd7lzAx/ehJ9
 Wlp+anQO/FZ/naFIq0lIyrpCA36B/jNMVn04zQuyN2LBUDwFb6DEajA4i9yCo=
X-Received: by 2002:a17:902:cf0f:b0:2d0:cc92:f7a3 with SMTP id
 d9443c01a7336-2d94a703f61mr24697005ad.2.1788192347802; 
 Mon, 31 Aug 2026 09:05:47 -0700 (PDT)
X-Received: by 2002:a17:902:cf0f:b0:2d0:cc92:f7a3 with SMTP id
 d9443c01a7336-2d94a703f61mr24695855ad.2.1788192347115; Mon, 31 Aug 2026
 09:05:47 -0700 (PDT)
MIME-Version: 1.0
References: <20260719160329.73695-1-bogorodskiy@gmail.com>
In-Reply-To: <20260719160329.73695-1-bogorodskiy@gmail.com>
From: Kostiantyn Kostiuk <kkostiuk@redhat.com>
Date: Mon, 31 Aug 2026 19:05:34 +0300
X-Gm-Features: AcwNN1XgOtYi9uz3xu_Knv--6kB6CtZYv2vnp08LsTmM_qoSJ0yHkkU1Ipwh4uE
Message-ID: <CAPMcbCrLmS2NXASKAWujm6=do9cAvMcB4p5Yxp73T_6HshRGQA@mail.gmail.com>
Subject: Re: [PATCH] qga: implement 'guest-get-diskstats' for FreeBSD
To: Roman Bogorodskiy <bogorodskiy@gmail.com>
Cc: qemu-devel@nongnu.org, Michael Roth <michael.roth@amd.com>, 
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>
Content-Type: multipart/alternative; boundary="000000000000a40878065a59f9b1"
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kkostiuk@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

--000000000000a40878065a59f9b1
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Roman,

Thanks for your patch, and sorry for the late reply


On Sun, Jul 19, 2026 at 7:04=E2=80=AFPM Roman Bogorodskiy <bogorodskiy@gmai=
l.com>
wrote:

> Implement the 'guest-get-diskstats' for FreeBSD.
> This implementation uses the devstat(3) library which is a part
> of the FreeBSD base system.
>
> The build system is updated to link qga with `-ldevstat`.
>
> Signed-off-by: Roman Bogorodskiy <bogorodskiy@gmail.com>
> ---
>  qga/commands-bsd.c   | 127 +++++++++++++++++++++++++++++++++++++++++++
>  qga/meson.build      |   3 +
>  qga/qapi-schema.json |   6 +-
>  3 files changed, 133 insertions(+), 3 deletions(-)
>
> diff --git a/qga/commands-bsd.c b/qga/commands-bsd.c
> index 94ff6fee6a..763db33c9f 100644
> --- a/qga/commands-bsd.c
> +++ b/qga/commands-bsd.c
> @@ -27,6 +27,9 @@
>  #include <net/ethernet.h>
>  #endif
>  #include <paths.h>
> +#ifdef CONFIG_FREEBSD
> +#include <devstat.h>
> +#endif
>
>  #if defined(CONFIG_FSFREEZE) || defined(CONFIG_FSTRIM)
>  bool build_fs_mount_list(FsMountList *mounts, Error **errp)
> @@ -178,3 +181,127 @@ bool guest_get_hw_addr(struct ifaddrs *ifa, unsigne=
d
> char *buf,
>      return true;
>  }
>  #endif /* HAVE_GETIFADDRS */
> +
> +#ifdef CONFIG_FREEBSD
> +static uint64_t bintime_to_msec(const struct bintime *bt)
> +{
> +    return (uint64_t)bt->sec * 1000ULL + (((bt->frac >> 32) * 1000ULL) >=
>
> 32);
> +}
> +
> +static void guest_diskstats_append(GuestDiskStatsInfoList ***tailp,
> +                                   const struct devstat *dev)
>

Can we simplify pointer logic?
For example, return GuestDiskStatsInfo* for devstat* and then append the
list in guest_get_diskstats.
***tailp -> more pointers - easier to make a mistake or memory leak.


> +{
> +    GuestDiskStatsInfoList **tail =3D *tailp;
> +    g_autofree GuestDiskStatsInfo *diskstatinfo =3D NULL;
> +    g_autofree GuestDiskStats *diskstat =3D NULL;
> +
> +    diskstatinfo =3D g_new0(GuestDiskStatsInfo, 1);
> +    diskstatinfo->name =3D g_strdup_printf("%s%d", dev->device_name,
> +                                         dev->unit_number);
> +    /*
> +     * devstat does not expose Linux-style major/minor numbers.  Report
> the
> +     * devstat device number and unit number in these mandatory QAPI
> fields.
> +     */
> +    diskstatinfo->major =3D dev->device_number;
> +    diskstatinfo->minor =3D dev->unit_number;
> +
> +    diskstat =3D g_new0(GuestDiskStats, 1);
> +    diskstat->has_read_ios =3D true;
> +    diskstat->read_ios =3D dev->operations[DEVSTAT_READ];
> +    diskstat->has_read_sectors =3D true;
> +    diskstat->read_sectors =3D dev->bytes[DEVSTAT_READ] / BDRV_SECTOR_SI=
ZE;
> +    diskstat->has_read_ticks =3D true;
> +    diskstat->read_ticks =3D bintime_to_msec(&dev->duration[DEVSTAT_READ=
]);
> +
> +    diskstat->has_write_ios =3D true;
> +    diskstat->write_ios =3D dev->operations[DEVSTAT_WRITE];
> +    diskstat->has_write_sectors =3D true;
> +    diskstat->write_sectors =3D dev->bytes[DEVSTAT_WRITE] /
> BDRV_SECTOR_SIZE;
> +    diskstat->has_write_ticks =3D true;
> +    diskstat->write_ticks =3D
> bintime_to_msec(&dev->duration[DEVSTAT_WRITE]);
> +
> +    diskstat->has_discard_ios =3D true;
> +    diskstat->discard_ios =3D dev->operations[DEVSTAT_FREE];
> +    diskstat->has_discard_sectors =3D true;
> +    diskstat->discard_sectors =3D dev->bytes[DEVSTAT_FREE] /
> BDRV_SECTOR_SIZE;
> +    diskstat->has_discard_ticks =3D true;
> +    diskstat->discard_ticks =3D
> bintime_to_msec(&dev->duration[DEVSTAT_FREE]);
> +
> +    diskstat->has_ios_pgr =3D true;
> +    if (dev->start_count >=3D dev->end_count) {
> +        diskstat->ios_pgr =3D dev->start_count - dev->end_count;
> +    }
>

In case start_count < end_count, you have has_ios_pgr =3D true, and ios_pgr=
 =3D
0 (g_new0 initialized to 0=E2=80=99s)
Is this expected? And in general, is this possible?


> +
> +    diskstat->has_total_ticks =3D true;
> +    diskstat->total_ticks =3D bintime_to_msec(&dev->busy_time);
> +
> +    diskstatinfo->stats =3D g_steal_pointer(&diskstat);
> +    QAPI_LIST_APPEND(tail, diskstatinfo);
> +    diskstatinfo =3D NULL;
> +
> +    *tailp =3D tail;
> +}
> +
> +static GuestDiskStatsInfoList *guest_get_diskstats(Error **errp)
> +{
> +    GuestDiskStatsInfoList *head =3D NULL, **tail =3D &head;
> +    struct devinfo dinfo =3D { 0 };
> +    struct statinfo stats =3D { .dinfo =3D &dinfo };
> +    struct device_selection *dev_select =3D NULL;
> +    struct devstat_match matches[] =3D {
> +        {
> +            .match_fields =3D DEVSTAT_MATCH_TYPE,
> +            .device_type =3D DEVSTAT_TYPE_DIRECT,
> +            .num_match_categories =3D 1,
> +        },
> +    };
> +    int num_selected =3D 0;
> +    int num_selections =3D 0;
> +    long select_generation =3D 0;
> +    int i;
> +
> +    if (devstat_checkversion(NULL) =3D=3D -1) {
> +        error_setg(errp, "%s", devstat_errbuf);
> +        return NULL;
> +    }
> +
> +    if (devstat_getdevs(NULL, &stats) =3D=3D -1) {
> +        error_setg(errp, "%s", devstat_errbuf);
> +        return NULL;
> +    }
> +
> +    if (devstat_selectdevs(&dev_select, &num_selected, &num_selections,
> +                           &select_generation, stats.dinfo->generation,
> +                           stats.dinfo->devices, stats.dinfo->numdevs,
> +                           matches, ARRAY_SIZE(matches), NULL, 0,
> +                           DS_SELECT_ONLY,
> +                           stats.dinfo->numdevs, 0) =3D=3D -1) {
> +        error_setg(errp, "%s", devstat_errbuf);
> +        goto error;
> +    }
> +
> +    for (i =3D 0; i < num_selections; i++) {
> +        if (dev_select[i].selected =3D=3D 0) {
> +            continue;
> +        }
> +
> +        guest_diskstats_append(&tail,
> +
>  &stats.dinfo->devices[dev_select[i].position]);
> +    }
> +
> +    free(stats.dinfo->mem_ptr);
> +    free(dev_select);
> +    return head;
> +
> +error:
> +    qapi_free_GuestDiskStatsInfoList(head);
> +    free(stats.dinfo->mem_ptr);
> +    free(dev_select);
> +    return NULL;
> +}
> +
> +GuestDiskStatsInfoList *qmp_guest_get_diskstats(Error **errp)
> +{
> +    return guest_get_diskstats(errp);
>

Any reason for this wrapper?
I see it in the Linux implementation, but not for other commands.



> +}
> +#endif /* CONFIG_FREEBSD */
> diff --git a/qga/meson.build b/qga/meson.build
> index cfa2157efb..a046ebe305 100644
> --- a/qga/meson.build
> +++ b/qga/meson.build
> @@ -93,6 +93,9 @@ qga_ss =3D qga_ss.apply({})
>
>  gen_tlb =3D []
>  qga_libs =3D []
> +if host_os =3D=3D 'freebsd'
> +  qga_libs +=3D ['-ldevstat']
> +endif
>  if host_os =3D=3D 'windows'
>    qga_libs +=3D ['-lws2_32', '-lwinmm', '-lpowrprof', '-lwtsapi32',
> '-lwininet', '-liphlpapi', '-lnetapi32',
>                 '-lsetupapi', '-lcfgmgr32', '-luserenv', '-lpdh' ]
> diff --git a/qga/qapi-schema.json b/qga/qapi-schema.json
> index c57bc9a02f..0d1476dcc4 100644
> --- a/qga/qapi-schema.json
> +++ b/qga/qapi-schema.json
> @@ -1714,7 +1714,7 @@
>             '*total-ticks': 'uint64',
>             '*weight-ticks': 'uint64'
>             },
> -  'if': 'CONFIG_LINUX' }
> +  'if': { 'any': ['CONFIG_LINUX', 'CONFIG_FREEBSD'] } }
>
>  ##
>  # @GuestDiskStatsInfo:
> @@ -1732,7 +1732,7 @@
>             'major': 'uint64',
>             'minor': 'uint64',
>             'stats': 'GuestDiskStats' },
> -  'if': 'CONFIG_LINUX' }
> +  'if': { 'any': ['CONFIG_LINUX', 'CONFIG_FREEBSD'] } }
>
>  ##
>  # @guest-get-diskstats:
> @@ -1745,7 +1745,7 @@
>  ##
>  { 'command': 'guest-get-diskstats',
>    'returns': ['GuestDiskStatsInfo'],
> -  'if': 'CONFIG_LINUX'
> +  'if': { 'any': ['CONFIG_LINUX', 'CONFIG_FREEBSD'] }
>  }
>
>  ##
> --
> 2.52.0
>
>

Best Regards,
Kostiantyn Kostiuk.

--000000000000a40878065a59f9b1
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><div><div>Hi=C2=A0Roman,</div><div><br></=
div><div>Thanks for your patch, and sorry for the late reply</div><br></div=
></div><br><div class=3D"gmail_quote gmail_quote_container"><div dir=3D"ltr=
" class=3D"gmail_attr">On Sun, Jul 19, 2026 at 7:04=E2=80=AFPM Roman Bogoro=
dskiy &lt;<a href=3D"mailto:bogorodskiy@gmail.com">bogorodskiy@gmail.com</a=
>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px=
 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">Imp=
lement the &#39;guest-get-diskstats&#39; for FreeBSD.<br>
This implementation uses the devstat(3) library which is a part<br>
of the FreeBSD base system.<br>
<br>
The build system is updated to link qga with `-ldevstat`.<br>
<br>
Signed-off-by: Roman Bogorodskiy &lt;<a href=3D"mailto:bogorodskiy@gmail.co=
m" target=3D"_blank">bogorodskiy@gmail.com</a>&gt;<br>
---<br>
=C2=A0qga/commands-bsd.c=C2=A0 =C2=A0| 127 ++++++++++++++++++++++++++++++++=
+++++++++++<br>
=C2=A0qga/meson.build=C2=A0 =C2=A0 =C2=A0 |=C2=A0 =C2=A03 +<br>
=C2=A0qga/qapi-schema.json |=C2=A0 =C2=A06 +-<br>
=C2=A03 files changed, 133 insertions(+), 3 deletions(-)<br>
<br>
diff --git a/qga/commands-bsd.c b/qga/commands-bsd.c<br>
index 94ff6fee6a..763db33c9f 100644<br>
--- a/qga/commands-bsd.c<br>
+++ b/qga/commands-bsd.c<br>
@@ -27,6 +27,9 @@<br>
=C2=A0#include &lt;net/ethernet.h&gt;<br>
=C2=A0#endif<br>
=C2=A0#include &lt;paths.h&gt;<br>
+#ifdef CONFIG_FREEBSD<br>
+#include &lt;devstat.h&gt;<br>
+#endif<br>
<br>
=C2=A0#if defined(CONFIG_FSFREEZE) || defined(CONFIG_FSTRIM)<br>
=C2=A0bool build_fs_mount_list(FsMountList *mounts, Error **errp)<br>
@@ -178,3 +181,127 @@ bool guest_get_hw_addr(struct ifaddrs *ifa, unsigned =
char *buf,<br>
=C2=A0 =C2=A0 =C2=A0return true;<br>
=C2=A0}<br>
=C2=A0#endif /* HAVE_GETIFADDRS */<br>
+<br>
+#ifdef CONFIG_FREEBSD<br>
+static uint64_t bintime_to_msec(const struct bintime *bt)<br>
+{<br>
+=C2=A0 =C2=A0 return (uint64_t)bt-&gt;sec * 1000ULL + (((bt-&gt;frac &gt;&=
gt; 32) * 1000ULL) &gt;&gt; 32);<br>
+}<br>
+<br>
+static void guest_diskstats_append(GuestDiskStatsInfoList ***tailp,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0const struct devstat *d=
ev)<br></blockquote><div><br></div><div>Can we <span class=3D"Asgive ng" st=
yle=3D"border-style:none;background:none">simplify</span> pointer logic?<br=
></div><div>For example, return=C2=A0GuestDiskStatsInfo* for=C2=A0devstat* =
and then append the list in=C2=A0guest_get_diskstats.</div><div>***tailp -&=
gt; more pointers - easier to make a mistake or memory leak.=C2=A0</div><di=
v>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px=
 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
+{<br>
+=C2=A0 =C2=A0 GuestDiskStatsInfoList **tail =3D *tailp;<br>
+=C2=A0 =C2=A0 g_autofree GuestDiskStatsInfo *diskstatinfo =3D NULL;<br>
+=C2=A0 =C2=A0 g_autofree GuestDiskStats *diskstat =3D NULL;<br>
+<br>
+=C2=A0 =C2=A0 diskstatinfo =3D g_new0(GuestDiskStatsInfo, 1);<br>
+=C2=A0 =C2=A0 diskstatinfo-&gt;name =3D g_strdup_printf(&quot;%s%d&quot;, =
dev-&gt;device_name,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0de=
v-&gt;unit_number);<br>
+=C2=A0 =C2=A0 /*<br>
+=C2=A0 =C2=A0 =C2=A0* devstat does not expose Linux-style major/minor numb=
ers.=C2=A0 Report the<br>
+=C2=A0 =C2=A0 =C2=A0* devstat device number and unit number in these manda=
tory QAPI fields.<br>
+=C2=A0 =C2=A0 =C2=A0*/<br>
+=C2=A0 =C2=A0 diskstatinfo-&gt;major =3D dev-&gt;device_number;<br>
+=C2=A0 =C2=A0 diskstatinfo-&gt;minor =3D dev-&gt;unit_number;<br>
+<br>
+=C2=A0 =C2=A0 diskstat =3D g_new0(GuestDiskStats, 1);<br>
+=C2=A0 =C2=A0 diskstat-&gt;has_read_ios =3D true;<br>
+=C2=A0 =C2=A0 diskstat-&gt;read_ios =3D dev-&gt;operations[DEVSTAT_READ];<=
br>
+=C2=A0 =C2=A0 diskstat-&gt;has_read_sectors =3D true;<br>
+=C2=A0 =C2=A0 diskstat-&gt;read_sectors =3D dev-&gt;bytes[DEVSTAT_READ] / =
BDRV_SECTOR_SIZE;<br>
+=C2=A0 =C2=A0 diskstat-&gt;has_read_ticks =3D true;<br>
+=C2=A0 =C2=A0 diskstat-&gt;read_ticks =3D bintime_to_msec(&amp;dev-&gt;dur=
ation[DEVSTAT_READ]);<br>
+<br>
+=C2=A0 =C2=A0 diskstat-&gt;has_write_ios =3D true;<br>
+=C2=A0 =C2=A0 diskstat-&gt;write_ios =3D dev-&gt;operations[DEVSTAT_WRITE]=
;<br>
+=C2=A0 =C2=A0 diskstat-&gt;has_write_sectors =3D true;<br>
+=C2=A0 =C2=A0 diskstat-&gt;write_sectors =3D dev-&gt;bytes[DEVSTAT_WRITE] =
/ BDRV_SECTOR_SIZE;<br>
+=C2=A0 =C2=A0 diskstat-&gt;has_write_ticks =3D true;<br>
+=C2=A0 =C2=A0 diskstat-&gt;write_ticks =3D bintime_to_msec(&amp;dev-&gt;du=
ration[DEVSTAT_WRITE]);<br>
+<br>
+=C2=A0 =C2=A0 diskstat-&gt;has_discard_ios =3D true;<br>
+=C2=A0 =C2=A0 diskstat-&gt;discard_ios =3D dev-&gt;operations[DEVSTAT_FREE=
];<br>
+=C2=A0 =C2=A0 diskstat-&gt;has_discard_sectors =3D true;<br>
+=C2=A0 =C2=A0 diskstat-&gt;discard_sectors =3D dev-&gt;bytes[DEVSTAT_FREE]=
 / BDRV_SECTOR_SIZE;<br>
+=C2=A0 =C2=A0 diskstat-&gt;has_discard_ticks =3D true;<br>
+=C2=A0 =C2=A0 diskstat-&gt;discard_ticks =3D bintime_to_msec(&amp;dev-&gt;=
duration[DEVSTAT_FREE]);<br>
+<br>
+=C2=A0 =C2=A0 diskstat-&gt;has_ios_pgr =3D true;<br>
+=C2=A0 =C2=A0 if (dev-&gt;start_count &gt;=3D dev-&gt;end_count) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 diskstat-&gt;ios_pgr =3D dev-&gt;start_count -=
 dev-&gt;end_count;<br>
+=C2=A0 =C2=A0 }<br></blockquote><div><br></div><div>In case=C2=A0start_cou=
nt &lt;=C2=A0end_count, you have has_ios_pgr =3D true, and ios_pgr =3D 0 (g=
_new0=C2=A0initialized to 0=E2=80=99s)<br></div><div>Is this expected? And =
in general, is <span class=3D"Asgive ng" style=3D"border-style:none;backgro=
und:none">this</span> possible?=C2=A0=C2=A0</div><div>=C2=A0</div><blockquo=
te class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px =
solid rgb(204,204,204);padding-left:1ex">
+<br>
+=C2=A0 =C2=A0 diskstat-&gt;has_total_ticks =3D true;<br>
+=C2=A0 =C2=A0 diskstat-&gt;total_ticks =3D bintime_to_msec(&amp;dev-&gt;bu=
sy_time);<br>
+<br>
+=C2=A0 =C2=A0 diskstatinfo-&gt;stats =3D g_steal_pointer(&amp;diskstat);<b=
r>
+=C2=A0 =C2=A0 QAPI_LIST_APPEND(tail, diskstatinfo);<br>
+=C2=A0 =C2=A0 diskstatinfo =3D NULL;<br>
+<br>
+=C2=A0 =C2=A0 *tailp =3D tail;<br>
+}<br>
+<br>
+static GuestDiskStatsInfoList *guest_get_diskstats(Error **errp)<br>
+{<br>
+=C2=A0 =C2=A0 GuestDiskStatsInfoList *head =3D NULL, **tail =3D &amp;head;=
<br>
+=C2=A0 =C2=A0 struct devinfo dinfo =3D { 0 };<br>
+=C2=A0 =C2=A0 struct statinfo stats =3D { .dinfo =3D &amp;dinfo };<br>
+=C2=A0 =C2=A0 struct device_selection *dev_select =3D NULL;<br>
+=C2=A0 =C2=A0 struct devstat_match matches[] =3D {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 .match_fields =3D DEVSTAT_MATCH_=
TYPE,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 .device_type =3D DEVSTAT_TYPE_DI=
RECT,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 .num_match_categories =3D 1,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 },<br>
+=C2=A0 =C2=A0 };<br>
+=C2=A0 =C2=A0 int num_selected =3D 0;<br>
+=C2=A0 =C2=A0 int num_selections =3D 0;<br>
+=C2=A0 =C2=A0 long select_generation =3D 0;<br>
+=C2=A0 =C2=A0 int i;<br>
+<br>
+=C2=A0 =C2=A0 if (devstat_checkversion(NULL) =3D=3D -1) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 error_setg(errp, &quot;%s&quot;, devstat_errbu=
f);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return NULL;<br>
+=C2=A0 =C2=A0 }<br>
+<br>
+=C2=A0 =C2=A0 if (devstat_getdevs(NULL, &amp;stats) =3D=3D -1) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 error_setg(errp, &quot;%s&quot;, devstat_errbu=
f);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return NULL;<br>
+=C2=A0 =C2=A0 }<br>
+<br>
+=C2=A0 =C2=A0 if (devstat_selectdevs(&amp;dev_select, &amp;num_selected, &=
amp;num_selections,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0&amp;select_generation, stats.dinfo-&gt;generation,=
<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0stats.dinfo-&gt;devices, stats.dinfo-&gt;numdevs,<b=
r>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0matches, ARRAY_SIZE(matches), NULL, 0,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0DS_SELECT_ONLY,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0stats.dinfo-&gt;numdevs, 0) =3D=3D -1) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 error_setg(errp, &quot;%s&quot;, devstat_errbu=
f);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 goto error;<br>
+=C2=A0 =C2=A0 }<br>
+<br>
+=C2=A0 =C2=A0 for (i =3D 0; i &lt; num_selections; i++) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (dev_select[i].selected =3D=3D 0) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 continue;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 guest_diskstats_append(&amp;tail,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&amp;stats.dinfo-&gt;devices[dev_sele=
ct[i].position]);<br>
+=C2=A0 =C2=A0 }<br>
+<br>
+=C2=A0 =C2=A0 free(stats.dinfo-&gt;mem_ptr);<br>
+=C2=A0 =C2=A0 free(dev_select);<br>
+=C2=A0 =C2=A0 return head;<br>
+<br>
+error:<br>
+=C2=A0 =C2=A0 qapi_free_GuestDiskStatsInfoList(head);<br>
+=C2=A0 =C2=A0 free(stats.dinfo-&gt;mem_ptr);<br>
+=C2=A0 =C2=A0 free(dev_select);<br>
+=C2=A0 =C2=A0 return NULL;<br>
+}<br>
+<br>
+GuestDiskStatsInfoList *qmp_guest_get_diskstats(Error **errp)<br>
+{<br>
+=C2=A0 =C2=A0 return guest_get_diskstats(errp);<br></blockquote><div><br><=
/div><div>Any reason for this wrapper?=C2=A0</div><div>I see <span class=3D=
"Asgive ng" style=3D"border-style:none;background:none">it</span> in the Li=
nux implementation, but not for other commands.</div><div><br></div><div>=
=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0=
.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
+}<br>
+#endif /* CONFIG_FREEBSD */<br>
diff --git a/qga/meson.build b/qga/meson.build<br>
index cfa2157efb..a046ebe305 100644<br>
--- a/qga/meson.build<br>
+++ b/qga/meson.build<br>
@@ -93,6 +93,9 @@ qga_ss =3D qga_ss.apply({})<br>
<br>
=C2=A0gen_tlb =3D []<br>
=C2=A0qga_libs =3D []<br>
+if host_os =3D=3D &#39;freebsd&#39;<br>
+=C2=A0 qga_libs +=3D [&#39;-ldevstat&#39;]<br>
+endif<br>
=C2=A0if host_os =3D=3D &#39;windows&#39;<br>
=C2=A0 =C2=A0qga_libs +=3D [&#39;-lws2_32&#39;, &#39;-lwinmm&#39;, &#39;-lp=
owrprof&#39;, &#39;-lwtsapi32&#39;, &#39;-lwininet&#39;, &#39;-liphlpapi&#3=
9;, &#39;-lnetapi32&#39;,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &#39;-lsetupapi&#39=
;, &#39;-lcfgmgr32&#39;, &#39;-luserenv&#39;, &#39;-lpdh&#39; ]<br>
diff --git a/qga/qapi-schema.json b/qga/qapi-schema.json<br>
index c57bc9a02f..0d1476dcc4 100644<br>
--- a/qga/qapi-schema.json<br>
+++ b/qga/qapi-schema.json<br>
@@ -1714,7 +1714,7 @@<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &#39;*total-ticks&#39;: &#39;uint=
64&#39;,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &#39;*weight-ticks&#39;: &#39;uin=
t64&#39;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 },<br>
-=C2=A0 &#39;if&#39;: &#39;CONFIG_LINUX&#39; }<br>
+=C2=A0 &#39;if&#39;: { &#39;any&#39;: [&#39;CONFIG_LINUX&#39;, &#39;CONFIG=
_FREEBSD&#39;] } }<br>
<br>
=C2=A0##<br>
=C2=A0# @GuestDiskStatsInfo:<br>
@@ -1732,7 +1732,7 @@<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &#39;major&#39;: &#39;uint64&#39;=
,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &#39;minor&#39;: &#39;uint64&#39;=
,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &#39;stats&#39;: &#39;GuestDiskSt=
ats&#39; },<br>
-=C2=A0 &#39;if&#39;: &#39;CONFIG_LINUX&#39; }<br>
+=C2=A0 &#39;if&#39;: { &#39;any&#39;: [&#39;CONFIG_LINUX&#39;, &#39;CONFIG=
_FREEBSD&#39;] } }<br>
<br>
=C2=A0##<br>
=C2=A0# @guest-get-diskstats:<br>
@@ -1745,7 +1745,7 @@<br>
=C2=A0##<br>
=C2=A0{ &#39;command&#39;: &#39;guest-get-diskstats&#39;,<br>
=C2=A0 =C2=A0&#39;returns&#39;: [&#39;GuestDiskStatsInfo&#39;],<br>
-=C2=A0 &#39;if&#39;: &#39;CONFIG_LINUX&#39;<br>
+=C2=A0 &#39;if&#39;: { &#39;any&#39;: [&#39;CONFIG_LINUX&#39;, &#39;CONFIG=
_FREEBSD&#39;] }<br>
=C2=A0}<br>
<br>
=C2=A0##<br>
-- <br>
2.52.0<br>
<br></blockquote><div><br></div><div><div><br clear=3D"all"></div><div><div=
 dir=3D"ltr" class=3D"gmail_signature"><div dir=3D"ltr"><div>Best Regards,<=
/div><div>Kostiantyn Kostiuk.</div></div></div></div>=C2=A0</div></div></di=
v>

--000000000000a40878065a59f9b1--


