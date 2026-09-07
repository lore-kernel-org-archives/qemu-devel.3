Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EFABBC79F99
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Sep 2026 11:20:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x3XOE-0003fB-Bk; Mon, 07 Sep 2026 07:19:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kkostiuk@redhat.com>)
 id 1x3XOC-0003dw-9K
 for qemu-devel@nongnu.org; Mon, 07 Sep 2026 07:19:52 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kkostiuk@redhat.com>)
 id 1x3XO9-0007AU-Eq
 for qemu-devel@nongnu.org; Mon, 07 Sep 2026 07:19:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1788779988;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=lr3QbvkyQn6r/j6EeknapIv3u2PsAbwaUguAR0kUIGg=;
 b=h6YV984kkqn01woNL6PHGT+IfDNcJErcTu+FL+FEfkzcsH/CrJyQHXHNSTuCfodwj5wUU1
 GO9GTAilutP82CEHU1F3rsK3NfeR/kLdYn9OPKBNFnLA1UnUxIpj378O+gOgdnxGi2ArBp
 kJW41qs0RhwrcEjiavSgfLgNocMHd5c=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-27-h_8CMo51P_-WPGUpKmmasw-1; Mon, 07 Sep 2026 07:19:46 -0400
X-MC-Unique: h_8CMo51P_-WPGUpKmmasw-1
X-Mimecast-MFC-AGG-ID: h_8CMo51P_-WPGUpKmmasw_1788779986
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-92e5e38fbc5so582375885a.2
 for <qemu-devel@nongnu.org>; Mon, 07 Sep 2026 04:19:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788779986; cv=none;
 d=google.com; s=arc-20260327;
 b=lbUK1G3RgMLmpFk4c2GGHz7qlpQqPKd6CSNSKa14EZianiocNrJcfe8H5FebtbsL2f
 MA1coyThXbAJsnZkJkvNiA5J5JgKNF3lnaaCnp0OJpdmoxB2m8d3c45LrfRw20tSFsLj
 a6nnjP0CrIEFPN93N55vG/+nSmG+cyOLbSDy8pnEqGrmcWuH/v9JtxHjJDEoOWw3kPRm
 P15gdaMs2ww0GOV2w+QfyP52pN8L9R/cnYiU2T5bCC0mUlikQ3PppF03G6SplH/kRi3T
 vCDYvB+rmBo3A5od+e8tvcCtbJS28X9TQyNDjSz9MYdFd/qBJVR3cmWLIWA8ED4VXVKl
 bkZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=lr3QbvkyQn6r/j6EeknapIv3u2PsAbwaUguAR0kUIGg=;
 fh=hx4NOeU8lhUvezwFmjfF6zLnVME+nuDkQiDnnmRw0oI=;
 b=C1Oalt1/kWIj3qbIP6DRfnABssoU4BcmvMowJASDxadRQ8GimiUBVorPg6jHohRSAg
 JHIBJXeYKxYyjkpmtFH0PhdQ9N08uvkGbnFftJ/HoA8wvywBxI05IiCb+hpnNXFmJ3g6
 rfhKsn2DKKUtMmhDwz2tupaOk8oxWhTy9zfnWjsTNnTpyBcOXGwYLA2ZeIEbZKsBTR81
 YjSSnoEiE5KF0a2xewy7W4FxN24DMw3EUL4grE89enL79NtIF8UZSit4iWuWMAs1kh/S
 HUVyesi+HUKYgJbdpIbzR+JdUCLTcCl38Z8hoWbEG9OLka1xGGXur/MG70oxUzVaWyIr
 Pizw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1788779986; x=1789384786; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=lr3QbvkyQn6r/j6EeknapIv3u2PsAbwaUguAR0kUIGg=;
 b=nBXLrs50PemFTZP34rdMCUKaZNHVoDpOYvbmo3eCjDvkUY7wP+kGZ3PaMvk4Beh4EA
 Fbap2gwmQWWgBOdQT8w8VyNJHFlmRPJS1kpKT48WgEj/vJjf7Zh6Ht+EvvD289GvcunD
 TvVCCQpE2F68vJXlY77a+lAQa1NSqlCteF+9Pj+34Ow2qyGC+yzruAkx7JEYrOvUnB7Y
 S9tIF4vHv/xooXzirBpP5fqJ9O2fE/FJhrT81Y8MEMyoqHdrY8SZ7Urx0XOSpYDv3rx/
 Wj4NM1qn+5zgyTp3GyVfehp5Ib/VDUW5MdNKFQyGV5XftpW4HvWNxRcpnHRKqxuSTStR
 IYDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788779986; x=1789384786;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=lr3QbvkyQn6r/j6EeknapIv3u2PsAbwaUguAR0kUIGg=;
 b=cuN68N22omWEK+F3SWsucUobgspvG7Bd4y5CW6qGqGpgDfRikVw760D3K26hdP3f22
 xXx1xUvhPnL/erXyo+gw0zsNzDAWYC18vsQii1xVQxF3BGDXHe+pMBfv28NyWPhSXG42
 dhong3SdmkNda3rRres1RDGsA3C0X5oXvR4XqDqFl+7Mvi8puQX1HIaL9ODkjgkc2pup
 tlnJOA9mjorajIA39EUAeorRPZp4hnXougn70xxzeHinxHl0pDbsGWsTl5p9HKr0Plbm
 l+Ru2lEobLc4+LXitOwU7iuDtvFmakG7RhseFODXXi4CFyTPL+av4HxICBWEotAzWHfI
 Fm5Q==
X-Gm-Message-State: AFuF++lnYDj8tMNS8F2Pw+RKNzluq+5s5w3y8zgmTI4o80iSEO0mzRWJ
 Xz/z5kh7lpMn5N8zhvA0ATMUF8jggrUdG25UrNSNr04VmakyiXk8Vn03y0JmbNvEuI6/NW+uADq
 ND58W4UQSV/pr46zJT2AVI07MeE5lDNboexN2tJgcCzA2eC554CG0MSr0S7JAWD2cg/tJ4Vo7u1
 ai0OabZyBV72mDmAln3QhJMlzRHCIlaxo=
X-Gm-Gg: AYBFou1O9fp7rQxJh+WPyeOzpWC3jI1s1L2UeRLhEX9ISM664VfocbpoBovpwFmYDv8
 2O9gcXXK+0y43euEXRFxRjitZoMRfLGwq68+e1zZHtIIMejlIdkL0TNNj3AvG6jnSRlOzEcQ7xr
 zjzCjiLH56t9uPxDcd/uYMDvz/Iwrhm1rSmIwYA5p6s4FmtNcXxTcEAm/WyPo=
X-Received: by 2002:a05:620a:3d02:b0:936:ea3d:9313 with SMTP id
 af79cd13be357-9398037be5dmr1426901085a.20.1788779985962; 
 Mon, 07 Sep 2026 04:19:45 -0700 (PDT)
X-Received: by 2002:a05:620a:3d02:b0:936:ea3d:9313 with SMTP id
 af79cd13be357-9398037be5dmr1426898085a.20.1788779985404; Mon, 07 Sep 2026
 04:19:45 -0700 (PDT)
MIME-Version: 1.0
References: <20260901192732.46190-1-bogorodskiy@gmail.com>
In-Reply-To: <20260901192732.46190-1-bogorodskiy@gmail.com>
From: Kostiantyn Kostiuk <kkostiuk@redhat.com>
Date: Mon, 7 Sep 2026 14:19:33 +0300
X-Gm-Features: AcwNN1UulFx_wix8bOVCVTE2SWU2rBxx6KKYXtBFnDfoU2jHae2DNCBoTVwzT4s
Message-ID: <CAPMcbCp+-tGCWnuSRwi2745r=v8cdtTc0CqVCBg7y08UpAYTAg@mail.gmail.com>
Subject: Re: [PATCH v2] qga: implement 'guest-get-diskstats' for FreeBSD
To: Roman Bogorodskiy <bogorodskiy@gmail.com>
Cc: qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>, 
 Michael Roth <michael.roth@amd.com>, Eric Blake <eblake@redhat.com>
Content-Type: multipart/alternative; boundary="0000000000009ca1dd065ae2cbb7"
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

--0000000000009ca1dd065ae2cbb7
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Reviewed-by: Kostiantyn Kostiuk <kkostiuk@redhat.com>

On Tue, Sep 1, 2026 at 10:29=E2=80=AFPM Roman Bogorodskiy <bogorodskiy@gmai=
l.com>
wrote:

> Implement the 'guest-get-diskstats' for FreeBSD.
> This implementation uses the devstat(3) library which is a part
> of the FreeBSD base system.
>
> The build system is updated to link qga with `-ldevstat`.
>
> Signed-off-by: Roman Bogorodskiy <bogorodskiy@gmail.com>
> Acked-by: Markus Armbruster <armbru@redhat.com> (QAPI schema)
> ---
> Changes since v1:
>  - Replace the guest_diskstats_append() helper with a simpler
> guest_diskstats_info_new().
>  - Drop the unnecessary condition for ios_pgr.
>  - Drop the unnecessary guest_get_diskstats() wrapper.
>  - Jump to error on devstat_getdevs() as it does allocations.
>
>  qga/commands-bsd.c   | 120 +++++++++++++++++++++++++++++++++++++++++++
>  qga/meson.build      |   3 ++
>  qga/qapi-schema.json |   6 +--
>  3 files changed, 126 insertions(+), 3 deletions(-)
>
> diff --git a/qga/commands-bsd.c b/qga/commands-bsd.c
> index 94ff6fee6a..6a1aadee8d 100644
> --- a/qga/commands-bsd.c
> +++ b/qga/commands-bsd.c
> @@ -14,6 +14,7 @@
>  #include "qga-qapi-commands.h"
>  #include "qapi/error.h"
>  #include "qemu/queue.h"
> +#include "block/block-common.h"
>  #include "commands-common.h"
>  #include <sys/ioctl.h>
>  #include <sys/param.h>
> @@ -27,6 +28,9 @@
>  #include <net/ethernet.h>
>  #endif
>  #include <paths.h>
> +#ifdef CONFIG_FREEBSD
> +#include <devstat.h>
> +#endif
>
>  #if defined(CONFIG_FSFREEZE) || defined(CONFIG_FSTRIM)
>  bool build_fs_mount_list(FsMountList *mounts, Error **errp)
> @@ -178,3 +182,119 @@ bool guest_get_hw_addr(struct ifaddrs *ifa, unsigne=
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
> +static GuestDiskStatsInfo *
> +guest_diskstats_info_new(const struct devstat *dev)
> +{
> +    GuestDiskStatsInfo *diskstatinfo;
> +    GuestDiskStats *diskstat;
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
> +    diskstat->ios_pgr =3D dev->start_count - dev->end_count;
> +
> +    diskstat->has_total_ticks =3D true;
> +    diskstat->total_ticks =3D bintime_to_msec(&dev->busy_time);
> +
> +    diskstatinfo->stats =3D diskstat;
> +    return diskstatinfo;
> +}
> +
> +GuestDiskStatsInfoList *qmp_guest_get_diskstats(Error **errp)
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
> +        goto error;
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
> +        const struct devstat *dev;
> +
> +        if (dev_select[i].selected =3D=3D 0) {
> +            continue;
> +        }
> +
> +        dev =3D &stats.dinfo->devices[dev_select[i].position];
> +        QAPI_LIST_APPEND(tail, guest_diskstats_info_new(dev));
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
> 2.55.0
>
>

--0000000000009ca1dd065ae2cbb7
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Reviewed-by: Kostiantyn Kostiuk &lt;<a href=3D"mailto:kkos=
tiuk@redhat.com">kkostiuk@redhat.com</a>&gt;</div><br><div class=3D"gmail_q=
uote gmail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">On Tue, S=
ep 1, 2026 at 10:29=E2=80=AFPM Roman Bogorodskiy &lt;<a href=3D"mailto:bogo=
rodskiy@gmail.com">bogorodskiy@gmail.com</a>&gt; wrote:<br></div><blockquot=
e class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px s=
olid rgb(204,204,204);padding-left:1ex">Implement the &#39;guest-get-diskst=
ats&#39; for FreeBSD.<br>
This implementation uses the devstat(3) library which is a part<br>
of the FreeBSD base system.<br>
<br>
The build system is updated to link qga with `-ldevstat`.<br>
<br>
Signed-off-by: Roman Bogorodskiy &lt;<a href=3D"mailto:bogorodskiy@gmail.co=
m" target=3D"_blank">bogorodskiy@gmail.com</a>&gt;<br>
Acked-by: Markus Armbruster &lt;<a href=3D"mailto:armbru@redhat.com" target=
=3D"_blank">armbru@redhat.com</a>&gt; (QAPI schema)<br>
---<br>
Changes since v1:<br>
=C2=A0- Replace the guest_diskstats_append() helper with a simpler guest_di=
skstats_info_new().<br>
=C2=A0- Drop the unnecessary condition for ios_pgr.<br>
=C2=A0- Drop the unnecessary guest_get_diskstats() wrapper.<br>
=C2=A0- Jump to error on devstat_getdevs() as it does allocations.<br>
<br>
=C2=A0qga/commands-bsd.c=C2=A0 =C2=A0| 120 ++++++++++++++++++++++++++++++++=
+++++++++++<br>
=C2=A0qga/meson.build=C2=A0 =C2=A0 =C2=A0 |=C2=A0 =C2=A03 ++<br>
=C2=A0qga/qapi-schema.json |=C2=A0 =C2=A06 +--<br>
=C2=A03 files changed, 126 insertions(+), 3 deletions(-)<br>
<br>
diff --git a/qga/commands-bsd.c b/qga/commands-bsd.c<br>
index 94ff6fee6a..6a1aadee8d 100644<br>
--- a/qga/commands-bsd.c<br>
+++ b/qga/commands-bsd.c<br>
@@ -14,6 +14,7 @@<br>
=C2=A0#include &quot;qga-qapi-commands.h&quot;<br>
=C2=A0#include &quot;qapi/error.h&quot;<br>
=C2=A0#include &quot;qemu/queue.h&quot;<br>
+#include &quot;block/block-common.h&quot;<br>
=C2=A0#include &quot;commands-common.h&quot;<br>
=C2=A0#include &lt;sys/ioctl.h&gt;<br>
=C2=A0#include &lt;sys/param.h&gt;<br>
@@ -27,6 +28,9 @@<br>
=C2=A0#include &lt;net/ethernet.h&gt;<br>
=C2=A0#endif<br>
=C2=A0#include &lt;paths.h&gt;<br>
+#ifdef CONFIG_FREEBSD<br>
+#include &lt;devstat.h&gt;<br>
+#endif<br>
<br>
=C2=A0#if defined(CONFIG_FSFREEZE) || defined(CONFIG_FSTRIM)<br>
=C2=A0bool build_fs_mount_list(FsMountList *mounts, Error **errp)<br>
@@ -178,3 +182,119 @@ bool guest_get_hw_addr(struct ifaddrs *ifa, unsigned =
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
+static GuestDiskStatsInfo *<br>
+guest_diskstats_info_new(const struct devstat *dev)<br>
+{<br>
+=C2=A0 =C2=A0 GuestDiskStatsInfo *diskstatinfo;<br>
+=C2=A0 =C2=A0 GuestDiskStats *diskstat;<br>
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
+=C2=A0 =C2=A0 diskstat-&gt;ios_pgr =3D dev-&gt;start_count - dev-&gt;end_c=
ount;<br>
+<br>
+=C2=A0 =C2=A0 diskstat-&gt;has_total_ticks =3D true;<br>
+=C2=A0 =C2=A0 diskstat-&gt;total_ticks =3D bintime_to_msec(&amp;dev-&gt;bu=
sy_time);<br>
+<br>
+=C2=A0 =C2=A0 diskstatinfo-&gt;stats =3D diskstat;<br>
+=C2=A0 =C2=A0 return diskstatinfo;<br>
+}<br>
+<br>
+GuestDiskStatsInfoList *qmp_guest_get_diskstats(Error **errp)<br>
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
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 goto error;<br>
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
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 const struct devstat *dev;<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (dev_select[i].selected =3D=3D 0) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 continue;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 dev =3D &amp;stats.dinfo-&gt;devices[dev_selec=
t[i].position];<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 QAPI_LIST_APPEND(tail, guest_diskstats_info_ne=
w(dev));<br>
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
2.55.0<br>
<br>
</blockquote></div>

--0000000000009ca1dd065ae2cbb7--


