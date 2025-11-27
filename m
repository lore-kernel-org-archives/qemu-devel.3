Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73DEBD116E2
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Nov 2025 14:44:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vOdEE-0000sb-TB; Thu, 27 Nov 2025 09:44:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1vOdEC-0000rM-C7; Thu, 27 Nov 2025 09:44:12 -0500
Received: from zero.eik.bme.hu ([2001:738:2001:2001::2001])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1vOdEA-0003Vs-Pj; Thu, 27 Nov 2025 09:44:12 -0500
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id A1B60596A03;
 Thu, 27 Nov 2025 15:44:07 +0100 (CET)
X-Virus-Scanned: amavis at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by localhost (zero.eik.bme.hu [127.0.0.1]) (amavis, port 10028) with ESMTP
 id E27tyGaokHCg; Thu, 27 Nov 2025 15:44:05 +0100 (CET)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id ADFAC596A00; Thu, 27 Nov 2025 15:44:05 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id AC4385969FC;
 Thu, 27 Nov 2025 15:44:05 +0100 (CET)
Date: Thu, 27 Nov 2025 15:44:05 +0100 (CET)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: =?ISO-8859-15?Q?Cl=E9ment_Chigot?= <chigot@adacore.com>
cc: qemu-block@nongnu.org, qemu-devel@nongnu.org, kwolf@redhat.com, 
 hreitz@redhat.com, eblake@redhat.com, armbru@redhat.com
Subject: Re: [PATCH v3 2/5] vvfat: move fat_type check prior to size setup
In-Reply-To: <20251127142417.710094-3-chigot@adacore.com>
Message-ID: <cc8d6f2b-6cfe-38a2-a9bc-584d81dab864@eik.bme.hu>
References: <20251127142417.710094-1-chigot@adacore.com>
 <20251127142417.710094-3-chigot@adacore.com>
MIME-Version: 1.0
Content-Type: multipart/mixed;
 boundary="3866299591-1243946181-1764254645=:65476"
Received-SPF: pass client-ip=2001:738:2001:2001::2001;
 envelope-from=balaton@eik.bme.hu; helo=zero.eik.bme.hu
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--3866299591-1243946181-1764254645=:65476
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8BIT

On Thu, 27 Nov 2025, Clément Chigot wrote:
> This allows to handle the default FAT size in a single place and make the
> following part taking care only about size parameters. It will be later
> moved away in a specific function.
>
> The selection of floppy size was a bit unusual:
> - fat-type undefined: a FAT 12 2880 Kib disk (default)
> - fat-type=16: a FAT 16 2880 Kib disk
> - fat-type=12: a FAT 12 1440 Kib disk
>
> Now, that fat-type undefined means fat-type=12, it's no longer possible
> to make that size distinction. Therefore, it's being changed for the
> following:
> - fat-type=12: a FAT 12 1440 Kib disk (default)
> - fat-type=16: a FAT 16 2880 Kib dis
>
> This has been choosen for two reasons: keep fat-type=12 the default and
> create a more usual size for it: 1440 Kib.
>
> The possibility to create a FAT 12 2880 KiB floppy will be added back
> later, through the fs-size parameter.
>
> Signed-off-by: Clément Chigot <chigot@adacore.com>
> ---
> block/vvfat.c | 43 ++++++++++++++++++++++---------------------
> 1 file changed, 22 insertions(+), 21 deletions(-)
>
> diff --git a/block/vvfat.c b/block/vvfat.c
> index dd0b3689c1..baf04e678b 100644
> --- a/block/vvfat.c
> +++ b/block/vvfat.c
> @@ -1188,28 +1188,8 @@ static int vvfat_open(BlockDriverState *bs, QDict *options, int flags,
>         memcpy(s->volume_label, "QEMU VVFAT", 10);
>     }
>
> -    if (floppy) {
> -        /* 1.44MB or 2.88MB floppy.  2.88MB can be FAT12 (default) or FAT16. */
> -        if (!s->fat_type) {
> -            s->fat_type = 12;
> -            secs = 36;
> -            s->sectors_per_cluster = 2;
> -        } else {
> -            secs = s->fat_type == 12 ? 18 : 36;
> -            s->sectors_per_cluster = 1;
> -        }
> -        cyls = 80;
> -        heads = 2;
> -    } else {
> -        /* 32MB or 504MB disk*/
> -        if (!s->fat_type) {
> -            s->fat_type = 16;
> -        }
> -        cyls = s->fat_type == 12 ? 64 : 1024;
> -        heads = 16;
> -        secs = 63;
> -    }
>
> +    /* Verify FAT type  */
>     switch (s->fat_type) {
>     case 32:
>         warn_report("FAT32 has not been tested. You are welcome to do so!");
> @@ -1217,12 +1197,33 @@ static int vvfat_open(BlockDriverState *bs, QDict *options, int flags,
>     case 16:
>     case 12:
>         break;
> +    case 0:
> +        /* Set a default type */
> +        if (floppy) {
> +            s->fat_type = 12;
> +        } else {
> +            s->fat_type = 16;
> +        }
> +        break;
>     default:
>         error_setg(errp, "Valid FAT types are only 12, 16 and 32");
>         ret = -EINVAL;
>         goto fail;
>     }
>
> +
> +    if (floppy) {
> +        /* Choose floppy size. 1440 KiB for FAT 12, 2880 KiB for FAT-16 */
> +        secs = s->fat_type == 12 ? 18 : 36;
> +        cyls = 80;
> +        heads = 2;
> +    } else {
> +        /* 32MB or 504MB disk*/
> +        cyls = s->fat_type == 12 ? 64 : 1024;
> +        heads = 16;
> +        secs = 63;
> +    }
> +
>     /* Reserver space for MBR */

Previous patch but only noticed here. This may be correct in French but in 
English to many r-s in Reserve.

Regards,
BALATON Zoltan

>     if (partitioned) {
>         s->offset_to_bootsector = 0x3f;
>
--3866299591-1243946181-1764254645=:65476--

