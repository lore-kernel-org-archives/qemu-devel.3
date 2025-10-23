Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1825ECCD193
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Oct 2025 19:31:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vC10e-0005F1-Qd; Thu, 23 Oct 2025 15:30:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1vC10Y-0005B9-LD
 for qemu-devel@nongnu.org; Thu, 23 Oct 2025 15:29:59 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1vC10U-0006UT-IQ
 for qemu-devel@nongnu.org; Thu, 23 Oct 2025 15:29:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1761247792;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=qd09n11yc0LBgSrLA/KzeJ9GAdPFP1xacT50pjnaa0M=;
 b=b/9X2z/6iuVtgor0ZyBXI3o5WJyR6ihGtatUFMKLEwkU/Rp5eXTmV0roSXqG1VuX8UsYMO
 M9zYsogNQhy/LjvM07j5yxNH4MeM43adUp14ue461jio4VVDlSNC6nQxjgkMuc9cCyupm4
 cYxs9NJlRnlLfeHTtLQlcv7SrhuYttk=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-622-6dTG96AsNvCnK1rrFWgq1A-1; Thu,
 23 Oct 2025 15:29:47 -0400
X-MC-Unique: 6dTG96AsNvCnK1rrFWgq1A-1
X-Mimecast-MFC-AGG-ID: 6dTG96AsNvCnK1rrFWgq1A_1761247786
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 80D3C1800675; Thu, 23 Oct 2025 19:29:46 +0000 (UTC)
Received: from redhat.com (unknown [10.45.225.90])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 4EE8F19560B5; Thu, 23 Oct 2025 19:29:44 +0000 (UTC)
Date: Thu, 23 Oct 2025 21:29:41 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: =?iso-8859-1?Q?Cl=E9ment?= Chigot <chigot@adacore.com>
Cc: qemu-devel@nongnu.org, hreitz@redhat.com, qemu-block@nongnu.org,
 armbru@redhat.com
Subject: Re: [PATCH 5/5] vvfat: add support for "size" options
Message-ID: <aPqCJRNCjxcZ6jq5@redhat.com>
References: <20250903075721.77623-1-chigot@adacore.com>
 <20250903075721.77623-6-chigot@adacore.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250903075721.77623-6-chigot@adacore.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

Am 03.09.2025 um 09:57 hat Clément Chigot geschrieben:
> This allows more flexibility to vvfat backend. The value for "Number of
> Heads" and "Sectors per track" are based on SD specifications Part 2.
> 
> Some limitations remains, the size parameter is recognized only when
> "format=vvfat" is passed. In particular, "format=raw,size=xxx" is
> keeping the previously hardcoded value: 504MB for FAT16 and 32 MB for
> FAT12. FAT32 has not been adjusted and thus still default to 504MB.
> 
> Moreover, for flopyy, size=1M is creating a disk 1.44 MB, and size=2M a
> disk of 2.88 MB. This avoids having to worry about float operations.
> 
> Signed-off-by: Clément Chigot <chigot@adacore.com>
> ---
>  block/vvfat.c | 165 ++++++++++++++++++++++++++++++++++++++++++--------
>  1 file changed, 141 insertions(+), 24 deletions(-)
> 
> diff --git a/block/vvfat.c b/block/vvfat.c
> index 6526c585a2..4537c39d5c 100644
> --- a/block/vvfat.c
> +++ b/block/vvfat.c
> @@ -1091,6 +1091,11 @@ static QemuOptsList runtime_opts = {
>              .type = QEMU_OPT_BOOL,
>              .help = "Do not add a Master Boot Record on this disk",
>          },
> +        {
> +            .name = BLOCK_OPT_SIZE,
> +            .type = QEMU_OPT_SIZE,
> +            .help = "Virtual disk size"
> +        },
>          { /* end of list */ }
>      },
>  };

Like in patch 1, you need additional changes, in particular to add the
option to the QAPI schema in qapi/block-core.json.

> @@ -1148,10 +1153,141 @@ static void vvfat_parse_filename(const char *filename, QDict *options,
>      qdict_put_bool(options, "no-mbr", no_mbr);
>  }
>  
> +static void vvfat_get_size_parameters(uint64_t size, BDRVVVFATState *s,
> +                                      bool floppy, Error **errp)
> +{
> +    if (floppy) {
> +        /*
> +         * Floppy emulation only supports 1.44 MB or 2.88 MB (default).
> +         * In order to avoid floating operations ambiguity, 1 MB is
> +         * recognized for 1.44 MB and 2 MB for 2.88 MB.
> +         */
> +        if (!size) {
> +            size = 2 * 1024 * 1024;
> +        } else {
> +            if (size == 1024 * 1024 && s->fat_type == 16) {
> +                error_setg(errp,
> +                           "floppy FAT16 unsupported size; only support 2M "
> +                           "(for an effective size of 2.88 MB)");
> +            } else if (size != 2 * 1024 * 1024 && size != 1024 * 1024) {
> +                error_setg(errp,
> +                           "floppy unsupported size; should be 1MB (for "
> +                           "an effective size of 1.44 MB) or 2.88M (for "
> +                           "2.88MB)");
> +            }
> +        }

This is horrible. To be fair, it's pretty hard to do something not
horrible when the usual units to describe floppy sizes are already
horrible. :-)

But I'd still like us to do better here.

To me it looks a bit like what we really want is an enum for floppy
sizes (though is there any real reason why we have only those two?), but
an arbitrary size for hard disks.

Without the enum, obviously, users could specify 1440k and that would do
the right thing. Maybe special casing whatever 1.44M and 2.88M result
in and translating them into 1440k and 2880k could be more justifiable
than special casing 1M and 2M, but it would still be ugly.

Markus, do you have any advice how this should be represented in QAPI?

Kevin

> +
> +        if (s->fat_type == 12) {
> +            if (size == 2 * 1024 * 1024) {
> +                s->sectors_per_cluster = 2;
> +            } else {
> +                s->sectors_per_cluster = 1;
> +            }
> +        } else {
> +            s->sectors_per_cluster = 1;
> +        }
> +
> +        s->sectors_per_track = 36;
> +        s->cylinders = 80;
> +        s->number_of_heads = 2;
> +    } else {
> +        /* LATER TODO: if FAT32, adjust */
> +        s->sectors_per_cluster = 0x10;
> +
> +        switch (s->fat_type) {
> +        case 12:
> +
> +            /* Default is 32 MB */
> +            if (!size) {
> +                size = 32 * 1024 * 1024;
> +            } else if (size > 32 * 1024 * 1024) {
> +                error_setg(errp, "FAT12 unsupported size; higher than 32Mb");
> +            }
> +
> +            s->cylinders = 64;
> +
> +            /*
> +             * Based on CHS Recommandation table:
> +             *  Card Capacity | Number of Headers | Sectors per track
> +             *     ~ 2 MB     |         4         |       16
> +             *     ~ 4 MB     |         8         |       16
> +             *     ~ 8 MB     |        16         |       16
> +             *     ~ 16 MB    |         2         |       32
> +             *     ~ 32 MB    |         4         |       32
> +             *
> +             * For 2 MB, SD is recommending heads = 2 and sectors = 16, but
> +             * this requires a different number of cylinders. Thus, it was
> +             * adjusted to keep this number constant.
> +             */
> +            if (size <= 8 * 1024 * 1024) {
> +                s->sectors_per_track = 16;
> +            } else {
> +                s->sectors_per_track = 32;
> +            }
> +
> +            /*
> +             * The formula between the size (in bytes) and the parameters are:
> +             *  size = SECTOR_SIZE * sectors_per_track * number_of_headers *
> +             *         cylinders
> +             */
> +            s->number_of_heads = size / s->sectors_per_track /
> +                SECTOR_SIZE / s->cylinders;
> +            return;
> +
> +        case 16:
> +            /* Default is 504 MB */
> +            if (!size) {
> +                size = 504 * 1024 * 1024;
> +            } else if (size / 1024 > 4 * 1024 * 1024) {
> +                error_setg(errp, "FAT16 unsupported size; higher than 4Gb");
> +            }
> +
> +            s->cylinders = 1024;
> +
> +            /*
> +             * Based on CHS Recommandation table:
> +             *  Card Capacity | Number of Headers | Sectors per track
> +             *     ~64 MB     |         4         |       32
> +             *     ~128 MB    |         8         |       32
> +             *     ~256 MB    |        16         |       32
> +             *     ~504 MB    |        16         |       63
> +             *    ~1008 MB    |        32         |       63
> +             *    ~2016 MB    |        64         |       63
> +             */
> +            if (size <= 256 * 1024 * 1024) {
> +                s->sectors_per_track = 32;
> +            } else {
> +                s->sectors_per_track = 63;
> +            }
> +
> +            /*
> +             * The formula between the size (in bytes) and the parameters are:
> +             *  size = SECTOR_SIZE * sectors_per_track * number_of_headers *
> +             *         cylinders
> +             */
> +            s->number_of_heads = size / s->sectors_per_track /
> +                SECTOR_SIZE / s->cylinders;
> +            return;
> +
> +        case 32:
> +            /* TODO FAT32 adjust  */
> +            if (size) {
> +                warn_report("size parameters not supported with FAT32;"
> +                            "default to 504MB.");
> +            }
> +            s->cylinders = 1024;
> +            s->number_of_heads = 16;
> +            s->sectors_per_track = 63;
> +            return;
> +        }
> +    }
> +}
> +
>  static int vvfat_open(BlockDriverState *bs, QDict *options, int flags,
>                        Error **errp)
>  {
>      BDRVVVFATState *s = bs->opaque;
> +    uint64_t size;
>      bool floppy;
>      const char *dirname, *label;
>      QemuOpts *opts;
> @@ -1178,6 +1314,7 @@ static int vvfat_open(BlockDriverState *bs, QDict *options, int flags,
>  
>      s->fat_type = qemu_opt_get_number(opts, "fat-type", 0);
>      floppy = qemu_opt_get_bool(opts, "floppy", false);
> +    size = qemu_opt_get_size_del(opts, "size", 0);
>  
>      memset(s->volume_label, ' ', sizeof(s->volume_label));
>      label = qemu_opt_get(opts, "label");
> @@ -1215,35 +1352,15 @@ static int vvfat_open(BlockDriverState *bs, QDict *options, int flags,
>          goto fail;
>      }
>  
> +    vvfat_get_size_parameters(size, s, floppy, errp);
>  
> -    if (floppy) {
> -        /* 2.88MB floppy */
> -        if (s->fat_type == 12) {
> -            s->sectors_per_track = 36;
> -            s->sectors_per_cluster = 2;
> -        } else {
> -            s->sectors_per_track = 36;
> -            s->sectors_per_cluster = 1;
> -        }
> -        s->cylinder = 80;
> -        s->number_of_heads = 2;
> -    } else {
> -        /* Reserver space for MBR */
> -        if (!qemu_opt_get_bool(opts, "no-mbr", false)) {
> -            s->offset_to_bootsector = 0x3f;
> -        }
> -        /* 32MB or 504MB disk*/
> -        s->cylinders = s->fat_type == 12 ? 64 : 1024;
> -        s->number_of_heads = 16;
> -        s->sectors_per_track = 63;
> +    /* Reserver space for MBR */
> +    if (!floppy && !qemu_opt_get_bool(opts, "no-mbr", false)) {
> +        s->offset_to_bootsector = 0x3f;
>      }
>  
> -
>      s->bs = bs;
>  
> -    /* LATER TODO: if FAT32, adjust */
> -    s->sectors_per_cluster=0x10;
> -
>      s->current_cluster=0xffffffff;
>  
>      s->qcow = NULL;
> -- 
> 2.34.1
> 


