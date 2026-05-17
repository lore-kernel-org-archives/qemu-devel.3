Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78A38CD4F3D
	for <qemu-devel@archiver.kernel.org>; Sun, 17 May 2026 22:23:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wOjsW-00004x-5T; Sun, 17 May 2026 18:22:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <faithilikerun@gmail.com>)
 id 1wOjsU-0008WB-OY
 for qemu-devel@nongnu.org; Sun, 17 May 2026 18:22:30 -0400
Received: from mail-pj1-x102c.google.com ([2607:f8b0:4864:20::102c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <faithilikerun@gmail.com>)
 id 1wOjsQ-0006du-LV
 for qemu-devel@nongnu.org; Sun, 17 May 2026 18:22:30 -0400
Received: by mail-pj1-x102c.google.com with SMTP id
 98e67ed59e1d1-36643b96b99so1529766a91.0
 for <qemu-devel@nongnu.org>; Sun, 17 May 2026 15:22:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779056543; cv=none;
 d=google.com; s=arc-20240605;
 b=UQnnWsZgkMMLw0XSAQNNXKnbAnPa46/56AfTfcPVG14W+p1estUTuGCX8oxlcdLs9c
 ZbD9klsk7q8FKee2ejKs6T9qic0pogdxgiFX5zRVvyR9XUDq7JPfUq8HjIYf5s6PD/E2
 JuizXA9iQ1wo45elL9UtffyQnJMiu1/FoYvFLK39gGjT2hXt4KXnrVDPYmVj6aca890J
 FG9+RwgPiUV32YmJV9DJs+8btYXAWPUruMPjQfUii1oPDztm3CrZMG7SqKJNOHCMYFdh
 2lBvoiQYkmA7UeOclP9sksoPLtqBkmWMBnW+yFGbJZn/XUEHYjpfIzFJc3kY2IrS8jtW
 AkJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=ZH3XplFTq87C5zH1ZEG2c/7Zh4u5Ago+5ox+hYI4W3w=;
 fh=16ROSnVJ/M0vRbjdNRcio4ye9tBpAiAozVgOoszGlKA=;
 b=OP2Rjh+FcpsMyx6BV6eJ4wrXLpnYzl3q7KkE31c0D8wtjAy9R+7qPXMpWuDd/1aZr7
 rV3OZdscBTUAfKcOc/51uTgi7VrRSKugDItDbB6Wzk4cjJHG2tHkwlDy0K/hfOXCQOVI
 jUGSpzAzNHFGy0UGFmf3QdS6lQuvu7yegIiaFmoxikhs0Y1UcldmTJfLDwnMaLdyUyk2
 oYV2NslGNZGTli2Ah62lIhG7MHje+hRe22nzcgH2ztTFXcbdFjP8Mv93fL1+SmWuqRSe
 xlb4mi+QWRaj9d3HqiFOkiQgM6E37isSxUzEvJdfYdKNetgRfIpgf3/sC0B7y7BUq7Q2
 v78g==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1779056543; x=1779661343; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZH3XplFTq87C5zH1ZEG2c/7Zh4u5Ago+5ox+hYI4W3w=;
 b=FTdNkeUzdxVIQ2kcuCE4oE5DcS1mCQyWvnZT8s15nvoW3voBGb14vAmoRhdDVariny
 h8DLDiO9/2f+uLmoMloDY1hFjbSbzQlaFzQUuDbwzhj0vFe34Um8jnUBTeWWOVjUH28R
 KCX6MnZuuzl+yBHE8uGA4JQLgHxhGxIYsipD/02twOA+d31+MXtZsxlxNJSq3dQW/BBV
 apKaEHybxTg2Gk3NfXaVeRrNCWPorNatdO8eETzoNVndsjqwOR7tuWblhO4ovqMHPPPg
 zHFsc1ECRxnNvqvygJY2jF2NS7I3pAAleFMPLBnRyzyD+6OlyEggk/BESqWkLuz4J6It
 2DwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779056543; x=1779661343;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=ZH3XplFTq87C5zH1ZEG2c/7Zh4u5Ago+5ox+hYI4W3w=;
 b=RAHto25g32tswUK4OERWtft2niUEQEmkrrkG9Ehh1JNzJ/ClwO6F6qrJYfAIjGK9GO
 vGE36KAqj2zAxUWQMAxoWFiWVr1iyloEVWH9h8z+kSoodqImlLwhMCmjUNqH6z+ZHHcx
 H1W9glUNXhJsgWfWpGbjr3GCbjEZpHxU4ifbJ8Rjg0OyQ31ehf6J5pcaTYziUiv1mG3d
 1Sif7Y8HFCIdrCZSirZEAjuy6m0uZiWiuWjM4VIcnZhvXxjH8rDLxqZE2StgIvnfLRbb
 CMt8qGRyV7UQLuGo5RpUbEyvkviJZVd4O+gLl4RfgV+SRq6afLF4n1rYi4/qV1AGEaiV
 MzGg==
X-Gm-Message-State: AOJu0Yw8hGZkmsK4fx+/LBNah45gmH9eeyDemw9WXqyXjmUa4C7NzgaH
 c5NYU3v2GLXSxAA0BHoKfnDXAuqOLbLvEuMxnGCcyVGA/CzO8lsKRAA4tn1ZQNzLM4wUXdlY2rz
 5ZHjfR5GpM7FgyZIY3b5tGf0pjKah4Qg=
X-Gm-Gg: Acq92OFplZ0X0BbK5kaM6iXYSvttGjGmcfwwDEWKdplpSq95+3jrQaUCbGWnO+JPF00
 fkanrFUrAtVUeguhlXf+AmIfgFMv2A/jPK5LLlUbQYTdGiSqYv54LR8DMMOQ6Y2Nz/2qfS4+rgR
 a0dTdH2Lg+1+38RmPsp/Llw6puCk3gtdApszT0v3F4wXOmcf3M1YjxU4Dfvc/rObOyS3yyugLwO
 DClD5wfWbKdeiEm8UVIFuhrNOfPPoJwcLd/fP+PtGm0Z7a87Uk/c5VHbN9FO2e/ws0Q+mHvC1gy
 l7PVvlaQcJmQpHABtjvmb0DvERACdNVBK8Gr87GDU8nr24TTHjqjyjI/teGT/yM80gIde5DVcw=
 =
X-Received: by 2002:a17:90b:3c4a:b0:361:45df:f5 with SMTP id
 98e67ed59e1d1-36951b87f9cmr12041290a91.16.1779056542429; Sun, 17 May 2026
 15:22:22 -0700 (PDT)
MIME-Version: 1.0
References: <20260510175059.311814-1-faithilikerun@gmail.com>
 <20260510175059.311814-3-faithilikerun@gmail.com>
 <20260514194906.GC1535937@fedora>
In-Reply-To: <20260514194906.GC1535937@fedora>
From: Sam Li <faithilikerun@gmail.com>
Date: Mon, 18 May 2026 00:21:55 +0200
X-Gm-Features: AVHnY4KuW_NHCj03lkCPly3LNZ_d10_f1FYKVGs7EKuo1SfeoyMHkDYG4isiu10
Message-ID: <CAAAx-8K+12SGZqzpLGsxjsr6iGAHwQu-TUXe6Z6rtZA27OpjrQ@mail.gmail.com>
Subject: Re: [PATCH v10 2/4] qcow2: add configurations for zoned format
 extension
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: qemu-devel@nongnu.org, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, dmitry.fomichev@wdc.com, 
 Kevin Wolf <kwolf@redhat.com>, cassel@kernel.org,
 Markus Armbruster <armbru@redhat.com>, 
 qemu-block@nongnu.org, dlemoal@kernel.org, Eric Blake <eblake@redhat.com>, 
 "Michael S. Tsirkin" <mst@redhat.com>, hare@suse.de,
 Hanna Reitz <hreitz@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::102c;
 envelope-from=faithilikerun@gmail.com; helo=mail-pj1-x102c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

On Thu, May 14, 2026 at 9:49=E2=80=AFPM Stefan Hajnoczi <stefanha@redhat.co=
m> wrote:
>
> On Sun, May 10, 2026 at 07:50:57PM +0200, Sam Li wrote:
> > To configure the zoned format feature on the qcow2 driver, it
> > requires settings as: the device size, zone model, zone size,
> > zone capacity, number of conventional zones, limits on zone
> > resources (max append bytes, max open zones, and max_active_zones).
> >
> > To create a qcow2 image with zoned format feature, use command like
> > this:
> > qemu-img create -f qcow2 zbc.qcow2 -o size=3D768M \
> > -o zone.size=3D64M -o zone.capacity=3D64M -o zone.conventional_zones=3D=
0 \
> > -o zone.max_append_bytes=3D4096 -o zone.max_open_zones=3D6 \
> > -o zone.max_active_zones=3D8 -o zone.mode=3Dhost-managed
> >
> > Signed-off-by: Sam Li <faithilikerun@gmail.com>
> > ---
> >  block/file-posix.c               |   2 +-
> >  block/qcow2.c                    | 264 ++++++++++++++++++++++++++++++-
> >  block/qcow2.h                    |  32 +++-
> >  docs/interop/qcow2.rst           | 110 ++++++++++++-
> >  include/block/block_int-common.h |  15 +-
> >  qapi/block-core.json             |  70 +++++++-
> >  6 files changed, 485 insertions(+), 8 deletions(-)
> >
> > diff --git a/block/file-posix.c b/block/file-posix.c
> > index e49b13d6ab..14278785b9 100644
> > --- a/block/file-posix.c
> > +++ b/block/file-posix.c
> > @@ -3607,7 +3607,7 @@ raw_co_zone_append(BlockDriverState *bs,
> >
> >      if (*offset & zone_size_mask) {
> >          error_report("sector offset %" PRId64 " is not aligned to zone=
 size "
> > -                     "%" PRId32 "", *offset / 512, bs->bl.zone_size / =
512);
> > +                     "%" PRId64 "", *offset / 512, bs->bl.zone_size / =
512);
> >          return -EINVAL;
> >      }
> >
> > diff --git a/block/qcow2.c b/block/qcow2.c
> > index 81fd299b4c..b543bcf3e3 100644
> > --- a/block/qcow2.c
> > +++ b/block/qcow2.c
> > @@ -73,6 +73,7 @@ typedef struct {
> >  #define  QCOW2_EXT_MAGIC_CRYPTO_HEADER 0x0537be77
> >  #define  QCOW2_EXT_MAGIC_BITMAPS 0x23852875
> >  #define  QCOW2_EXT_MAGIC_DATA_FILE 0x44415441
> > +#define  QCOW2_EXT_MAGIC_ZONED_FORMAT 0x007a6264
> >
> >  static int coroutine_fn
> >  qcow2_co_preadv_compressed(BlockDriverState *bs,
> > @@ -194,6 +195,74 @@ qcow2_extract_crypto_opts(QemuOpts *opts, const ch=
ar *fmt, Error **errp)
> >      return cryptoopts_qdict;
> >  }
> >
> > +/*
> > + * Passing by the zoned device configurations by a zoned_header struct=
, check
> > + * if the zone device options are under constraints. Return false when=
 some
> > + * option is invalid
> > + */
> > +static inline bool
> > +qcow2_check_zone_options(Qcow2ZonedHeaderExtension *zone_opt, Error **=
errp)
> > +{
> > +    if (zone_opt) {
>
> The zone_opt =3D=3D NULL case never happens. Remove it to simplify the
> function?
>
> > +        uint32_t sequential_zones;
> > +
> > +        if (zone_opt->zone_size =3D=3D 0) {
> > +            error_setg(errp, "Zoned extension header zone_size field "
> > +                       "can not be 0");
> > +            return false;
> > +        }
> > +
> > +        if (zone_opt->zone_capacity > zone_opt->zone_size) {
> > +            error_setg(errp, "zone capacity %" PRIu64 "B exceeds zone =
size "
> > +                       "%" PRIu64 "B", zone_opt->zone_capacity,
> > +                       zone_opt->zone_size);
> > +            return false;
> > +        }
> > +
> > +        if (zone_opt->max_append_bytes + BDRV_SECTOR_SIZE >=3D
> > +            zone_opt->zone_capacity) {
> > +            error_setg(errp, "max append bytes %" PRIu64 "B exceeds zo=
ne "
> > +                       "capacity %" PRIu32 "B by more than block size"=
,
> > +                       zone_opt->zone_capacity,
> > +                       zone_opt->max_append_bytes);
> > +            return false;
> > +        }
> > +
> > +        if (zone_opt->conventional_zones >=3D zone_opt->nr_zones) {
> > +            error_setg(errp, "Conventional_zones %" PRIu32 " exceeds "
> > +                       "nr_zones %" PRIu32 ".",
> > +                       zone_opt->conventional_zones, zone_opt->nr_zone=
s);
> > +            return false;
> > +        }
> > +
> > +        if (zone_opt->max_active_zones > zone_opt->nr_zones) {
> > +            error_setg(errp, "Max_active_zones %" PRIu32 " exceeds "
> > +                       "nr_zones %" PRIu32 ". Set it to nr_zones.",
> > +                       zone_opt->max_active_zones, zone_opt->nr_zones)=
;
> > +            zone_opt->max_active_zones =3D zone_opt->nr_zones;
> > +        }
> > +
> > +        sequential_zones =3D zone_opt->nr_zones - zone_opt->convention=
al_zones;
> > +        if (zone_opt->max_open_zones > sequential_zones) {
> > +            error_setg(errp, "Max_open_zones field can not be larger t=
han"
> > +                       "the number of SWR zones. Set it to number of S=
WR"
> > +                       "zones %" PRIu32 ".", sequential_zones);
> > +            zone_opt->max_open_zones =3D sequential_zones;
> > +        }
> > +        if (zone_opt->max_open_zones > zone_opt->max_active_zones) {
> > +            error_setg(errp, "Max_open_zones %" PRIu32 " exceeds "
> > +                       "max_active_zones %" PRIu32 ". Set it to "
> > +                       "max_active_zones.",
> > +                       zone_opt->max_open_zones,
> > +                       zone_opt->max_active_zones);
> > +            zone_opt->max_open_zones =3D zone_opt->max_active_zones;
> > +        }
> > +
> > +        return true;
> > +    }
> > +    return false;
> > +}
> > +
> >  /*
> >   * read qcow2 extension and fill bs
> >   * start reading from start_offset
> > @@ -211,6 +280,7 @@ qcow2_read_extensions(BlockDriverState *bs, uint64_=
t start_offset,
> >      uint64_t offset;
> >      int ret;
> >      Qcow2BitmapHeaderExt bitmaps_ext;
> > +    Qcow2ZonedHeaderExtension zoned_ext;
> >
> >      if (need_update_header !=3D NULL) {
> >          *need_update_header =3D false;
> > @@ -432,6 +502,51 @@ qcow2_read_extensions(BlockDriverState *bs, uint64=
_t start_offset,
> >              break;
> >          }
> >
> > +        case QCOW2_EXT_MAGIC_ZONED_FORMAT:
> > +        {
> > +            if (ext.len < sizeof(zoned_ext)) {
>
> Should this be ext.len !=3D sizeof(zoned_ext)?
>
> > +                /* Missing fields */
> > +                error_setg(errp, "zoned_ext: len=3D%" PRIu32 " too sma=
ll "
> > +                           "(<%zu)", ext.len, sizeof(zoned_ext));
> > +                return -EINVAL;
> > +            }
> > +            ret =3D bdrv_pread(bs->file, offset, ext.len, &zoned_ext, =
0);
>
> ...otherwise we cannot read ext.len bytes into &zoned_ext because it
> could overflow.

Right, I will fix it.

>
> > +            if (ret < 0) {
> > +                error_setg_errno(errp, -ret, "zoned_ext: "
> > +                                 "Could not read ext header");
> > +                return ret;
> > +            }
> > +
> > +            zoned_ext.zone_size =3D be64_to_cpu(zoned_ext.zone_size);
> > +            zoned_ext.zone_capacity =3D be64_to_cpu(zoned_ext.zone_cap=
acity);
> > +            zoned_ext.conventional_zones =3D
> > +                be32_to_cpu(zoned_ext.conventional_zones);
> > +            zoned_ext.nr_zones =3D be32_to_cpu(zoned_ext.nr_zones);
> > +            zoned_ext.max_open_zones =3D be32_to_cpu(zoned_ext.max_ope=
n_zones);
> > +            zoned_ext.max_active_zones =3D
> > +                be32_to_cpu(zoned_ext.max_active_zones);
> > +            zoned_ext.max_append_bytes =3D
> > +                be32_to_cpu(zoned_ext.max_append_bytes);
> > +            s->zoned_header =3D zoned_ext;
> > +
> > +            /* refuse to open broken images */
> > +            if (zoned_ext.nr_zones !=3D DIV_ROUND_UP(bs->total_sectors=
 *
> > +                BDRV_SECTOR_SIZE, zoned_ext.zone_size)) {
> > +                error_setg(errp, "Zoned extension header nr_zones fiel=
d "
> > +                           "is wrong");
> > +                return -EINVAL;
> > +            }
> > +            if (!qcow2_check_zone_options(&zoned_ext, errp)) {
> > +                return -EINVAL;
> > +            }
> > +
> > +#ifdef DEBUG_EXT
> > +            printf("Qcow2: Got zoned format extension: "
> > +                   "offset=3D%" PRIu32 "\n", offset);
> > +#endif
> > +            break;
> > +        }
> > +
> >          default:
> >              /* unknown magic - save it in case we need to rewrite the =
header */
> >              /* If you add a new feature, make sure to also update the =
fast
> > @@ -2068,6 +2183,15 @@ static void qcow2_refresh_limits(BlockDriverStat=
e *bs, Error **errp)
> >      }
> >      bs->bl.pwrite_zeroes_alignment =3D s->subcluster_size;
> >      bs->bl.pdiscard_alignment =3D s->cluster_size;
> > +    bs->bl.zoned =3D s->zoned_header.zoned;
>
> Let's avoid the assumption that qcow2 file format constants are
> identical to internal QEMU block layer API constants (see more on this
> below). This will need to translate from the qcow2 zoned header
> host-managed constant to the QEMU block layer constant.
>
> > +    bs->bl.nr_zones =3D s->zoned_header.nr_zones;
> > +    bs->bl.max_append_sectors =3D s->zoned_header.max_append_bytes
> > +        >> BDRV_SECTOR_BITS;
> > +    bs->bl.max_active_zones =3D s->zoned_header.max_active_zones;
> > +    bs->bl.max_open_zones =3D s->zoned_header.max_open_zones;
> > +    bs->bl.zone_size =3D s->zoned_header.zone_size;
> > +    bs->bl.zone_capacity =3D s->zoned_header.zone_capacity;
> > +    bs->bl.write_granularity =3D BDRV_SECTOR_SIZE;
> >  }
> >
> >  static int GRAPH_UNLOCKED
> > @@ -3170,6 +3294,11 @@ int qcow2_update_header(BlockDriverState *bs)
> >                  .bit  =3D QCOW2_INCOMPAT_EXTL2_BITNR,
> >                  .name =3D "extended L2 entries",
> >              },
> > +            {
> > +                .type =3D QCOW2_FEAT_TYPE_INCOMPATIBLE,
> > +                .bit  =3D QCOW2_INCOMPAT_ZONED_FORMAT_BITNR,
> > +                .name =3D "zoned format",
> > +            },
> >              {
> >                  .type =3D QCOW2_FEAT_TYPE_COMPATIBLE,
> >                  .bit  =3D QCOW2_COMPAT_LAZY_REFCOUNTS_BITNR,
> > @@ -3215,6 +3344,31 @@ int qcow2_update_header(BlockDriverState *bs)
> >          buflen -=3D ret;
> >      }
> >
> > +    /* Zoned devices header extension */
> > +    if (s->zoned_header.zoned =3D=3D BLK_Z_HM) {
> > +        Qcow2ZonedHeaderExtension zoned_header =3D {
> > +            .zoned              =3D s->zoned_header.zoned,
> > +            .zone_size          =3D cpu_to_be64(s->zoned_header.zone_s=
ize),
> > +            .zone_capacity      =3D cpu_to_be64(s->zoned_header.zone_c=
apacity),
> > +            .conventional_zones =3D
> > +                cpu_to_be32(s->zoned_header.conventional_zones),
> > +            .nr_zones           =3D cpu_to_be32(s->zoned_header.nr_zon=
es),
> > +            .max_open_zones     =3D cpu_to_be32(s->zoned_header.max_op=
en_zones),
> > +            .max_active_zones   =3D
> > +                cpu_to_be32(s->zoned_header.max_active_zones),
> > +            .max_append_bytes =3D
> > +                cpu_to_be32(s->zoned_header.max_append_bytes)
> > +        };
> > +        ret =3D header_ext_add(buf, QCOW2_EXT_MAGIC_ZONED_FORMAT,
> > +                             &zoned_header, sizeof(zoned_header),
> > +                             buflen);
> > +        if (ret < 0) {
> > +            goto fail;
> > +        }
> > +        buf +=3D ret;
> > +        buflen -=3D ret;
> > +    }
> > +
> >      /* Keep unknown header extensions */
> >      QLIST_FOREACH(uext, &s->unknown_header_ext, next) {
> >          ret =3D header_ext_add(buf, uext->magic, uext->data, uext->len=
, buflen);
> > @@ -3589,6 +3743,8 @@ qcow2_co_create(BlockdevCreateOptions *create_opt=
ions, Error **errp)
> >      ERRP_GUARD();
> >      BlockdevCreateOptionsQcow2 *qcow2_opts;
> >      QDict *options;
> > +    Qcow2ZoneCreateOptions *zone_struct;
> > +    Qcow2ZoneHostManaged *zone_host_managed;
> >
> >      /*
> >       * Open the image file and write a minimal qcow2 header.
> > @@ -3615,6 +3771,8 @@ qcow2_co_create(BlockdevCreateOptions *create_opt=
ions, Error **errp)
> >
> >      assert(create_options->driver =3D=3D BLOCKDEV_DRIVER_QCOW2);
> >      qcow2_opts =3D &create_options->u.qcow2;
> > +    zone_struct =3D create_options->u.qcow2.zone;
> > +    zone_host_managed =3D &create_options->u.qcow2.zone->u.host_manage=
d;
> >
> >      bs =3D bdrv_co_open_blockdev_ref(qcow2_opts->file, errp);
> >      if (bs =3D=3D NULL) {
> > @@ -3828,6 +3986,14 @@ qcow2_co_create(BlockdevCreateOptions *create_op=
tions, Error **errp)
> >          header->incompatible_features |=3D
> >              cpu_to_be64(QCOW2_INCOMPAT_DATA_FILE);
> >      }
> > +    if (zone_struct && zone_struct->mode =3D=3D QCOW2_ZONE_MODEL_HOST_=
MANAGED) {
> > +        /*
> > +         * The incompatible bit must be set when the zone model is
> > +         * host-managed
> > +         */
> > +        header->incompatible_features |=3D
> > +            cpu_to_be64(QCOW2_INCOMPAT_ZONED_FORMAT);
> > +    }
> >      if (qcow2_opts->data_file_raw) {
> >          header->autoclear_features |=3D
> >              cpu_to_be64(QCOW2_AUTOCLEAR_DATA_FILE_RAW);
> > @@ -3885,10 +4051,9 @@ qcow2_co_create(BlockdevCreateOptions *create_op=
tions, Error **errp)
> >      bdrv_graph_co_rdlock();
> >      ret =3D qcow2_alloc_clusters(blk_bs(blk), 3 * cluster_size);
> >      if (ret < 0) {
> > -        bdrv_graph_co_rdunlock();
> >          error_setg_errno(errp, -ret, "Could not allocate clusters for =
qcow2 "
> >                           "header and refcount table");
> > -        goto out;
> > +        goto unlock;
> >
> >      } else if (ret !=3D 0) {
> >          error_report("Huh, first cluster in empty image is already in =
use?");
> > @@ -3896,11 +4061,62 @@ qcow2_co_create(BlockdevCreateOptions *create_o=
ptions, Error **errp)
> >      }
> >
> >      /* Set the external data file if necessary */
> > +    BDRVQcow2State *s =3D blk_bs(blk)->opaque;
> >      if (data_bs) {
> > -        BDRVQcow2State *s =3D blk_bs(blk)->opaque;
> >          s->image_data_file =3D g_strdup(data_bs->filename);
> >      }
> >
> > +    if (zone_struct && zone_struct->mode =3D=3D QCOW2_ZONE_MODEL_HOST_=
MANAGED) {
> > +        s->zoned_header.zoned =3D BLK_Z_HM;
>
> BLK_Z_HM is a QEMU block layer constant while zoned_header.zoned is a
> qcow2 file format field. Please do not mix the two, even if the constant
> values are identical. Instead, define a constant for host-manager (1) in
> block/qcow2.h and use that. This ensures that QEMU's interval constant
> values can be changed in the future and are not tied to the qcow2 file
> format.

I see. Then we only need to add translations from qcow2 constants to
block layer ones like host-managed =3D BLK_Z_HM.

>
> > +
> > +        if (!zone_host_managed->has_size) {
> > +            s->zoned_header.zone_size =3D DEFAULT_ZONE_SIZE;
> > +        } else {
> > +            s->zoned_header.zone_size =3D zone_host_managed->size;
> > +        }
> > +        s->zoned_header.nr_zones =3D DIV_ROUND_UP(qcow2_opts->size,
> > +                                                s->zoned_header.zone_s=
ize);
> > +
> > +        if (zone_host_managed->has_capacity) {
> > +            s->zoned_header.zone_capacity =3D zone_host_managed->capac=
ity;
> > +        } else {
> > +            s->zoned_header.zone_capacity =3D s->zoned_header.zone_siz=
e;
> > +        }
> > +
> > +        if (zone_host_managed->has_conventional_zones) {
> > +            s->zoned_header.conventional_zones =3D
> > +                zone_host_managed->conventional_zones;
> > +        }
> > +
> > +        if (zone_host_managed->has_max_active_zones) {
> > +            s->zoned_header.max_active_zones =3D
> > +                zone_host_managed->max_active_zones;
> > +
> > +            if (zone_host_managed->has_max_open_zones) {
> > +                s->zoned_header.max_open_zones =3D
> > +                    zone_host_managed->max_open_zones;
> > +            } else {
> > +                s->zoned_header.max_open_zones =3D
> > +                    zone_host_managed->max_active_zones;
> > +            }
> > +        }
> > +
> > +        if (zone_host_managed->has_max_append_bytes) {
> > +            s->zoned_header.max_append_bytes =3D
> > +                    zone_host_managed->max_append_bytes;
> > +        } else {
> > +            s->zoned_header.max_append_bytes =3D DEFAULT_MAX_APPEND_BY=
TES;
> > +        }
> > +
> > +        if (!qcow2_check_zone_options(&s->zoned_header, errp)) {
> > +            s->zoned_header.zoned =3D BLK_Z_NONE;
> > +            ret =3D -EINVAL;
> > +            goto unlock;
> > +        }
> > +    } else {
> > +        s->zoned_header.zoned =3D BLK_Z_NONE;
> > +    }
> > +
> >      /* Create a full header (including things like feature table) */
> >      ret =3D qcow2_update_header(blk_bs(blk));
> >      bdrv_graph_co_rdunlock();
> > @@ -3974,6 +4190,9 @@ qcow2_co_create(BlockdevCreateOptions *create_opt=
ions, Error **errp)
> >      }
> >
> >      ret =3D 0;
> > +    goto out;
> > +unlock:
> > +    bdrv_graph_co_rdunlock();
> >  out:
> >      blk_co_unref(blk);
> >      bdrv_co_unref(bs);
> > @@ -4052,6 +4271,10 @@ qcow2_co_create_opts(BlockDriver *drv, const cha=
r *filename, QemuOpts *opts,
> >          { BLOCK_OPT_COMPAT_LEVEL,       "version" },
> >          { BLOCK_OPT_DATA_FILE_RAW,      "data-file-raw" },
> >          { BLOCK_OPT_COMPRESSION_TYPE,   "compression-type" },
> > +        { BLOCK_OPT_CONVENTIONAL_ZONES, "zone.conventional-zones" },
> > +        { BLOCK_OPT_MAX_OPEN_ZONES,     "zone.max-open-zones" },
> > +        { BLOCK_OPT_MAX_ACTIVE_ZONES,   "zone.max-active-zones" },
> > +        { BLOCK_OPT_MAX_APPEND_BYTES,   "zone.max-append-bytes" },
> >          { NULL, NULL },
> >      };
> >
> > @@ -6265,6 +6488,41 @@ static QemuOptsList qcow2_create_opts =3D {
> >              .type =3D QEMU_OPT_BOOL,                                  =
    \
> >              .help =3D "Assume the external data file already exists an=
d " \
> >                      "do not overwrite it"                             =
  \
> > +        },                                                            =
  \
> > +        {                                                             =
  \
> > +            .name =3D BLOCK_OPT_ZONE_MODEL,                           =
    \
> > +            .type =3D QEMU_OPT_STRING,                                =
    \
> > +            .help =3D "zone model modes, mode choice: host-managed",  =
    \
> > +        },                                                            =
  \
> > +        {                                                             =
  \
> > +            .name =3D BLOCK_OPT_ZONE_SIZE,                            =
    \
> > +            .type =3D QEMU_OPT_SIZE,                                  =
    \
> > +            .help =3D "zone size",                                    =
    \
> > +        },                                                            =
  \
> > +        {                                                             =
  \
> > +            .name =3D BLOCK_OPT_ZONE_CAPACITY,                        =
    \
> > +            .type =3D QEMU_OPT_SIZE,                                  =
    \
> > +            .help =3D "zone capacity",                                =
    \
> > +        },                                                            =
  \
> > +        {                                                             =
  \
> > +            .name =3D BLOCK_OPT_CONVENTIONAL_ZONES,                   =
    \
> > +            .type =3D QEMU_OPT_NUMBER,                                =
    \
> > +            .help =3D "numbers of conventional zones",                =
    \
> > +        },                                                            =
  \
> > +        {                                                             =
  \
> > +            .name =3D BLOCK_OPT_MAX_APPEND_BYTES,                     =
    \
> > +            .type =3D QEMU_OPT_SIZE,                                  =
    \
> > +            .help =3D "max append bytes",                             =
    \
> > +        },                                                            =
  \
> > +        {                                                             =
  \
> > +            .name =3D BLOCK_OPT_MAX_ACTIVE_ZONES,                     =
    \
> > +            .type =3D QEMU_OPT_NUMBER,                                =
    \
> > +            .help =3D "max active zones",                             =
    \
> > +        },                                                            =
  \
> > +        {                                                             =
  \
> > +            .name =3D BLOCK_OPT_MAX_OPEN_ZONES,                       =
    \
> > +            .type =3D QEMU_OPT_NUMBER,                                =
    \
> > +            .help =3D "max open zones",                               =
    \
> >          },
> >          QCOW_COMMON_OPTIONS,
> >          { /* end of list */ }
> > diff --git a/block/qcow2.h b/block/qcow2.h
> > index 192a45d596..743f2e3e79 100644
> > --- a/block/qcow2.h
> > +++ b/block/qcow2.h
> > @@ -129,6 +129,9 @@
> >
> >  #define DEFAULT_CLUSTER_SIZE 65536
> >
> > +#define DEFAULT_ZONE_SIZE (256 * MiB)
> > +#define DEFAULT_MAX_APPEND_BYTES (64 * KiB)
>
> DEFAULT_ZONE_MAX_APPEND_BYTES would make it clear that this constant is
> related to zones.
>
> > +
> >  #define QCOW2_OPT_DATA_FILE "data-file"
> >  #define QCOW2_OPT_LAZY_REFCOUNTS "lazy-refcounts"
> >  #define QCOW2_OPT_DISCARD_REQUEST "pass-discard-request"
> > @@ -237,6 +240,27 @@ typedef struct Qcow2CryptoHeaderExtension {
> >      uint64_t length;
> >  } QEMU_PACKED Qcow2CryptoHeaderExtension;
> >
> > +typedef struct Qcow2ZonedHeaderExtension {
> > +    /* Zoned device attributes */
> > +    uint8_t zoned;
> > +    uint8_t reserved[3];
>
> I suggest padding to natural alignment so there is no need to worry
> about misaligned loads/stores:
>
>   uint8_t reserved[7];
>

Indeed. It should align zone_size at offset 8.

> > +    uint64_t zone_size;
> > +    uint64_t zone_capacity;
> > +    uint32_t conventional_zones;
> > +    uint32_t nr_zones;
> > +    uint32_t max_active_zones;
> > +    uint32_t max_open_zones;
> > +    uint32_t max_append_bytes;
> > +    uint64_t zonedmeta_size;
> > +    uint64_t zonedmeta_offset;
> > +} QEMU_PACKED Qcow2ZonedHeaderExtension;
> > +
> > +typedef struct Qcow2ZoneListEntry {
> > +    QLIST_ENTRY(Qcow2ZoneListEntry) exp_open_zone_entry;
> > +    QLIST_ENTRY(Qcow2ZoneListEntry) imp_open_zone_entry;
> > +    QLIST_ENTRY(Qcow2ZoneListEntry) closed_zone_entry;
> > +} Qcow2ZoneListEntry;
> > +
> >  typedef struct Qcow2UnknownHeaderExtension {
> >      uint32_t magic;
> >      uint32_t len;
> > @@ -257,17 +281,20 @@ enum {
> >      QCOW2_INCOMPAT_DATA_FILE_BITNR  =3D 2,
> >      QCOW2_INCOMPAT_COMPRESSION_BITNR =3D 3,
> >      QCOW2_INCOMPAT_EXTL2_BITNR      =3D 4,
> > +    QCOW2_INCOMPAT_ZONED_FORMAT_BITNR =3D 5,
> >      QCOW2_INCOMPAT_DIRTY            =3D 1 << QCOW2_INCOMPAT_DIRTY_BITN=
R,
> >      QCOW2_INCOMPAT_CORRUPT          =3D 1 << QCOW2_INCOMPAT_CORRUPT_BI=
TNR,
> >      QCOW2_INCOMPAT_DATA_FILE        =3D 1 << QCOW2_INCOMPAT_DATA_FILE_=
BITNR,
> >      QCOW2_INCOMPAT_COMPRESSION      =3D 1 << QCOW2_INCOMPAT_COMPRESSIO=
N_BITNR,
> >      QCOW2_INCOMPAT_EXTL2            =3D 1 << QCOW2_INCOMPAT_EXTL2_BITN=
R,
> > +    QCOW2_INCOMPAT_ZONED_FORMAT     =3D 1 << QCOW2_INCOMPAT_ZONED_FORM=
AT_BITNR,
> >
> >      QCOW2_INCOMPAT_MASK             =3D QCOW2_INCOMPAT_DIRTY
> >                                      | QCOW2_INCOMPAT_CORRUPT
> >                                      | QCOW2_INCOMPAT_DATA_FILE
> >                                      | QCOW2_INCOMPAT_COMPRESSION
> > -                                    | QCOW2_INCOMPAT_EXTL2,
> > +                                    | QCOW2_INCOMPAT_EXTL2
> > +                                    | QCOW2_INCOMPAT_ZONED_FORMAT,
> >  };
> >
> >  /* Compatible feature bits */
> > @@ -426,6 +453,9 @@ typedef struct BDRVQcow2State {
> >       * is to convert the image with the desired compression type set.
> >       */
> >      Qcow2CompressionType compression_type;
> > +
> > +    /* States of zoned device */
> > +    Qcow2ZonedHeaderExtension zoned_header;
> >  } BDRVQcow2State;
> >
> >  typedef struct Qcow2COWRegion {
> > diff --git a/docs/interop/qcow2.rst b/docs/interop/qcow2.rst
> > index 5948591107..7bf3a00e77 100644
> > --- a/docs/interop/qcow2.rst
> > +++ b/docs/interop/qcow2.rst
> > @@ -128,7 +128,26 @@ the next fields through ``header_length``.
> >                                  allows subcluster-based allocation. Se=
e the
> >                                  Extended L2 Entries section for more d=
etails.
> >
> > -                    Bits 5-63:  Reserved (set to 0)
> > +                    Bit 5:      Zoned extension bit. If this bit is se=
t then
> > +                                the file is an emulated zoned device. =
The
> > +                                zoned extension must be present.
> > +                                Implementations that do not support zo=
ned
> > +                                emulation cannot open this file becaus=
e it
> > +                                generally only make sense to interpret=
 the
> > +                                data along with the zone information a=
nd
> > +                                write pointers.
> > +
> > +                                It is unsafe when any qcow2 user witho=
ut
> > +                                knowing the zoned extension reads or e=
dits
> > +                                a file with the zoned extension. The w=
rite
> > +                                pointer tracking can be corrupted when=
 a
> > +                                writer edits a file, like overwriting =
beyond
> > +                                the write pointer locations. Or a read=
er tries
> > +                                to access a file without knowing write
> > +                                pointers where the software setup will=
 cause
> > +                                invalid reads.
> > +
> > +                    Bits 6-63:  Reserved (set to 0)
> >
> >           80 -  87:  compatible_features
> >                      Bitmask of compatible features. An implementation =
can
> > @@ -259,6 +278,7 @@ be stored. Each extension has a structure like the =
following::
> >                          0x23852875 - Bitmaps extension
> >                          0x0537be77 - Full disk encryption header point=
er
> >                          0x44415441 - External data file name string
> > +                        0x007a6264 - Zoned extension
> >                          other      - Unknown header extension, can be =
safely
> >                                       ignored
> >
> > @@ -344,6 +364,94 @@ The fields of the bitmaps extension are::
> >                     Offset into the image file at which the bitmap dire=
ctory
> >                     starts. Must be aligned to a cluster boundary.
> >
> > +Zoned extension
> > +---------------
> > +
> > +The zoned extension must be present if the incompatible bit is set, an=
d
> > +omitted when the incompatible bit is clear. It contains fields for
>
> The first sentence is a little vague about the "incompatible bit".
> Either saying "the corresponding incompatible bit" or
> "incompatible_features bit 5" is more specific and gives the reader an
> indication that they need to look for a specific bit.
>
> > +emulating the zoned storage model (https://zonedstorage.io/). When the
> > +zone model mode is not host-managed, it is regarded as incompatible
> > +and reports an error to users.
>
> This sentence is unnecessary because the same information is repeated in
> the zoned field description below. I suggest removing it since the zoned
> field description provides more context, but if you want you could
> replace it with something like:
>
>   Currently only the host-managed zone model is supported.
>
> > +
> > +The write pointers for each zone are stored in an area called zonedmet=
a
> > +clusters. It is 8 bytes per zone. The offset and size of the zonedmeta
>
> Slightly more descriptive:
>
> "It is 8 bytes per zone" -> "The zonedmeta clusters contain a table of
> the zone write pointers. Each entry is 8 bytes."
>
> > +are kept in the zoned extension header.
> > +
> > +The fields of the zoned extension are::
> > +
> > +    Byte       0:  zoned
> > +                   The byte represents the zoned model of the device. =
0 is for
> > +                   a non-zoned device (all other information in this h=
eader
> > +                   is ignored). 1 is for a host-managed device, which =
only
> > +                   allows for sequential writes within each zone. Othe=
r
> > +                   values may be added later, the implementation must =
refuse
> > +                   to open a device containing an unknown zone model.
> > +
> > +          1 -  3:  Reserved, must be zero.
> > +
> > +          4 -  11: zone_size
> > +                   Total size of each zone, in bytes. The 64-bit field=
 is to
> > +                   satisfy the virtio-blk zone_size range and emulate =
a read
> > +                   zoned device, whose maximum zone size can be as lar=
ge as
> > +                   2TB.
> > +
> > +                   The value must be power of 2. Linux currently requi=
res
> > +                   the zone size to be a power of 2 number of LBAs. Qc=
ow2
> > +                   following this is mainly to allow emulating a real
> > +                   ZNS drive configuration. It is not relevant to the =
cluster
> > +                   size.
> > +
> > +          12 - 19: zone_capacity
> > +                   The number of writable bytes within the zones. The =
bytes
> > +                   between zone capacity and zone size are unusable: r=
eads
> > +                   will return 0s and writes will fail.
> > +
> > +                   A zone capacity is always smaller or equal to the z=
one
> > +                   size. It is for emulating a real ZNS drive configur=
ation,
> > +                   which has the constraint of aligning to some hardwa=
re erase
> > +                   block size.
> > +
> > +         20 - 23:  conventional_zones
> > +                   The number of conventional zones. The conventional =
zones
> > +                   allow sequential writes and random writes. While th=
e
> > +                   sequential zones only allow sequential writes.
> > +
> > +         24 - 27:  nr_zones
> > +                   The number of zones. It is the sum of conventional =
zones
> > +                   and sequential zones. The maximum value for nr_zone=
s is
> > +                   (2^32 - 1)/8 =3D 536870911.
> > +
> > +         28 - 31:  max_active_zones
> > +                   The number of the zones that can be in the implicit=
 open,
> > +                   explicit open or closed state. The max active zones=
 cannot
> > +                   be larger than the max open zones.
> > +
> > +         32 - 35:  max_open_zones
> > +                   The maximal number of open (implicitly open or expl=
icitly
> > +                   open) zones. It cannot be larger than the number of=
 SWR
> > +                   zones of the device.
> > +
> > +                   If the limits of open zones or active zones are equ=
al to
> > +                   the total number of SWR zones, then it's the same a=
s having
> > +                   no limits therefore max open zones and max active z=
ones are
> > +                   set to 0.
> > +
> > +         36 - 39:  max_append_bytes
> > +                   The number of bytes of a zone append request that c=
an be
> > +                   issued to the device. It must be 512-byte aligned a=
nd less
> > +                   than the zone capacity.
> > +
> > +         40 - 47:  zonedmeta_size
> > +                   The size of zoned metadata in bytes. It contains no=
 more
> > +                   than 4GB. The zoned metadata structure is the write
> > +                   pointers for each zone whose size is the number of =
zones
> > +                   multiplied by the zone size.
>
> I can't parse the last sentence. Is this field necessary since there is
> already a nr_zones field?

No, it can be removed as it can be deduced by nr_zones.

>
> > +
> > +         48 - 55:  zonedmeta_offset
> > +                   The offset of zoned metadata structure in the conta=
ined
> > +                   image, in bytes.
>
> Do you want to say anything about the order in which metadata is
> persisted to disk when zones used? I guess the data is written into the
> image file first, then the non-zoned qcow2 L1/L2/refcount metadata is
> updated, and finally the write pointer is written. Write pointers are
> not guaranteed to be updated on disk until the write request followed by
> a flush request are both completed.

The current ordering is not like that. The write pointer is written
persistently first, then the data writes and the non-zoned qcow2
L1/L2/refcount metadata updates. On IO failure, the corresponding
write pointer is re-read from disk. As noted in the previous comment,
the wp must be updated when issuing the IO, under the assumption that
the write IO will succeed.

The ordering has been settled this way since v7 to deal with
concurrent zone append writes. If the wp was only updated after data
I/O, two concurrent appends would both have read the same wp and tried
to write to the same position.

>
> (The idea is that the data must be visible in the qcow2 file before it
> is safe to update the write pointer. Otherwise a power failure would
> leave the file in an inconsistent state where the write pointer has
> advanced but the data was not written.)

The crash-consistency is a concern...

>
> >  Full disk encryption header pointer
> >  -----------------------------------
> >
> > diff --git a/include/block/block_int-common.h b/include/block/block_int=
-common.h
> > index 147c08155f..349876bc65 100644
> > --- a/include/block/block_int-common.h
> > +++ b/include/block/block_int-common.h
> > @@ -57,6 +57,13 @@
> >  #define BLOCK_OPT_COMPRESSION_TYPE  "compression_type"
> >  #define BLOCK_OPT_EXTL2             "extended_l2"
> >  #define BLOCK_OPT_KEEP_DATA_FILE    "keep_data_file"
> > +#define BLOCK_OPT_ZONE_MODEL        "zone.mode"
> > +#define BLOCK_OPT_ZONE_SIZE         "zone.size"
> > +#define BLOCK_OPT_ZONE_CAPACITY     "zone.capacity"
> > +#define BLOCK_OPT_CONVENTIONAL_ZONES    "zone.conventional_zones"
> > +#define BLOCK_OPT_MAX_APPEND_BYTES      "zone.max_append_bytes"
> > +#define BLOCK_OPT_MAX_ACTIVE_ZONES      "zone.max_active_zones"
> > +#define BLOCK_OPT_MAX_OPEN_ZONES        "zone.max_open_zones"
> >
> >  #define BLOCK_PROBE_BUF_SIZE        512
> >
> > @@ -901,7 +908,13 @@ typedef struct BlockLimits {
> >      BlockZoneModel zoned;
> >
> >      /* zone size expressed in bytes */
> > -    uint32_t zone_size;
> > +    uint64_t zone_size;
> > +
> > +    /*
> > +     * The number of usable logical blocks within the zone, expressed
> > +     * in bytes. A zone capacity is smaller or equal to the zone size.
> > +     */
> > +    uint64_t zone_capacity;
> >
> >      /* total number of zones */
> >      uint32_t nr_zones;
> > diff --git a/qapi/block-core.json b/qapi/block-core.json
> > index 508b081ac1..d771dfb4a1 100644
> > --- a/qapi/block-core.json
> > +++ b/qapi/block-core.json
> > @@ -5268,6 +5268,70 @@
> >  { 'enum': 'Qcow2CompressionType',
> >    'data': [ 'zlib', { 'name': 'zstd', 'if': 'CONFIG_ZSTD' } ] }
> >
> > +##
> > +# @Qcow2ZoneModel:
> > +#
> > +# Zoned device model used in qcow2 image file
> > +#
> > +# @host-managed: The host-managed model only allows sequential write
> > +#     over the device zones.
> > +#
> > +# Since 11.0
> > +##
> > +{ 'enum': 'Qcow2ZoneModel',
> > +  'data': [ 'host-managed'] }
> > +
> > +##
> > +# @Qcow2ZoneHostManaged:
> > +#
> > +# The host-managed zone model.  It only allows sequential writes.
> > +#
> > +# @size: Total number of bytes within zones (default 256 MB).
> > +#
> > +# @capacity: The number of usable logical blocks within zones
> > +#     in bytes.  A zone capacity is always smaller or equal to the
> > +#     zone size (default to zone size).
> > +#
> > +# @conventional-zones: The number of conventional zones of the
> > +#     zoned device (default 0).
> > +#
> > +# @max-open-zones: The maximal number of open zones.  It is less than
> > +#     or equal to the number of sequential write required zones of
> > +#     the device (default 0).
> > +#
> > +# @max-active-zones: The maximal number of zones in the implicit
> > +#     open, explicit open or closed state.  It is less than or equal
> > +#     to the max open zones (default 0).
> > +#
> > +# @max-append-bytes: The maximal number of bytes of a zone
> > +#     append request that can be issued to the device.  It must be
> > +#     512-byte aligned and less than the zone capacity
> > +#     (default 64 KB).
> > +#
> > +# Since 11.0
> > +##
> > +{ 'struct': 'Qcow2ZoneHostManaged',
> > +  'data': { '*size':          'size',
> > +            '*capacity':      'size',
> > +            '*conventional-zones': 'uint32',
> > +            '*max-open-zones':     'uint32',
> > +            '*max-active-zones':   'uint32',
> > +            '*max-append-bytes':   'size' } }
> > +
> > +##
> > +# @Qcow2ZoneCreateOptions:
> > +#
> > +# The zone device model for the qcow2 image.
> > +#
> > +# @mode: The zone device model modes.
> > +#
> > +# Since 11.0
> > +##
> > +{ 'union': 'Qcow2ZoneCreateOptions',
> > +  'base': { 'mode': 'Qcow2ZoneModel' },
> > +  'discriminator': 'mode',
> > +  'data': { 'host-managed': 'Qcow2ZoneHostManaged' } }
> > +
> >  ##
> >  # @BlockdevCreateOptionsQcow2:
> >  #
> > @@ -5310,6 +5374,9 @@
> >  # @compression-type: The image cluster compression method
> >  #     (default: zlib, since 5.1)
> >  #
> > +# @zone: The zone device model modes.  The default is that the
> > +#     device is not zoned.  (since 11.0)
> > +#
> >  # Since: 2.12
> >  ##
> >  { 'struct': 'BlockdevCreateOptionsQcow2',
> > @@ -5326,7 +5393,8 @@
> >              '*preallocation':   'PreallocMode',
> >              '*lazy-refcounts':  'bool',
> >              '*refcount-bits':   'int',
> > -            '*compression-type':'Qcow2CompressionType' } }
> > +            '*compression-type':'Qcow2CompressionType',
> > +            '*zone':            'Qcow2ZoneCreateOptions' } }
> >
> >  ##
> >  # @BlockdevCreateOptionsQed:
> > --
> > 2.43.0
> >

