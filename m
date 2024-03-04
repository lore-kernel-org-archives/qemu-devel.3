Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A208BC48BF6
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Mar 2024 21:05:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rhFUa-0004Js-RA; Mon, 04 Mar 2024 16:05:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1rhFUW-0004HJ-Sm
 for qemu-devel@nongnu.org; Mon, 04 Mar 2024 16:04:56 -0500
Received: from smtp-out1.suse.de ([195.135.223.130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1rhFUJ-0005Dv-5V
 for qemu-devel@nongnu.org; Mon, 04 Mar 2024 16:04:56 -0500
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 9512734405;
 Mon,  4 Mar 2024 21:04:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1709586280; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Hrp6kocWCD3djP0NCBM0tHaQTvoNptJrc2+GYYbhTqk=;
 b=xIbFnrp/Xf/2DHEwSmnz/AtssAsU8ptOVZZrlrfkmoEuF5Jpg16sBGOOhLGciPLpfhegcu
 BtgS4tuVGrL0TmHKA1udQt5+cIan5ADpUrLydUjoypf5txGmCQm/F1PcVvDL1tnRhYpkpO
 rNy31LGM6EefxEERgZXrw3x6M5Ivk50=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1709586280;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Hrp6kocWCD3djP0NCBM0tHaQTvoNptJrc2+GYYbhTqk=;
 b=Ow2X26+v2VBlJ6uPsoIhbUC16+Z1J9Q3+XqVvE3++Zze0xV6xmmx0+36MJjHcquFlb8WiW
 yv7O4Gt4/xsB+OAw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1709586280; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Hrp6kocWCD3djP0NCBM0tHaQTvoNptJrc2+GYYbhTqk=;
 b=xIbFnrp/Xf/2DHEwSmnz/AtssAsU8ptOVZZrlrfkmoEuF5Jpg16sBGOOhLGciPLpfhegcu
 BtgS4tuVGrL0TmHKA1udQt5+cIan5ADpUrLydUjoypf5txGmCQm/F1PcVvDL1tnRhYpkpO
 rNy31LGM6EefxEERgZXrw3x6M5Ivk50=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1709586280;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Hrp6kocWCD3djP0NCBM0tHaQTvoNptJrc2+GYYbhTqk=;
 b=Ow2X26+v2VBlJ6uPsoIhbUC16+Z1J9Q3+XqVvE3++Zze0xV6xmmx0+36MJjHcquFlb8WiW
 yv7O4Gt4/xsB+OAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 1EB0613A5B;
 Mon,  4 Mar 2024 21:04:39 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id aGyUNWc35mV2SAAAD6G6ig
 (envelope-from <farosas@suse.de>); Mon, 04 Mar 2024 21:04:39 +0000
From: Fabiano Rosas <farosas@suse.de>
To: =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@redhat.com>, qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Alex Williamson
 <alex.williamson@redhat.com>, Avihai Horon <avihaih@nvidia.com>, Philippe
 =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>, Markus Armbruster
 <armbru@redhat.com>,
 =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@redhat.com>, Stefan Hajnoczi
 <stefanha@redhat.com>
Subject: Re: [PATCH v3 03/26] migration: Always report an error in
 block_save_setup()
In-Reply-To: <20240304122844.1888308-4-clg@redhat.com>
References: <20240304122844.1888308-1-clg@redhat.com>
 <20240304122844.1888308-4-clg@redhat.com>
Date: Mon, 04 Mar 2024 18:04:37 -0300
Message-ID: <87plw9hfoa.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b="xIbFnrp/";
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=Ow2X26+v
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-6.51 / 50.00]; ARC_NA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 FROM_HAS_DN(0.00)[]; TO_DN_SOME(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; BAYES_HAM(-3.00)[100.00%];
 MIME_GOOD(-0.10)[text/plain]; NEURAL_HAM_LONG(-1.00)[-1.000];
 DWL_DNSWL_MED(-2.00)[suse.de:dkim]; RCVD_COUNT_THREE(0.00)[3];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 DKIM_TRACE(0.00)[suse.de:+]; MX_GOOD(-0.01)[];
 RCPT_COUNT_SEVEN(0.00)[9]; NEURAL_HAM_SHORT(-0.20)[-1.000];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 MIME_TRACE(0.00)[0:+]; RCVD_TLS_ALL(0.00)[];
 MID_RHS_MATCH_FROM(0.00)[]
X-Rspamd-Queue-Id: 9512734405
Received-SPF: pass client-ip=195.135.223.130; envelope-from=farosas@suse.de;
 helo=smtp-out1.suse.de
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

C=C3=A9dric Le Goater <clg@redhat.com> writes:

> This will prepare ground for futur changes adding an Error** argument
> to the save_setup() handler. We need to make sure that on failure,
> block_save_setup() always sets a new error.
>
> Cc: Stefan Hajnoczi <stefanha@redhat.com>
> Signed-off-by: C=C3=A9dric Le Goater <clg@redhat.com>
> ---
>  migration/block.c | 18 +++++++++++++-----
>  1 file changed, 13 insertions(+), 5 deletions(-)
>
> diff --git a/migration/block.c b/migration/block.c
> index 8c6ebafacc1ffe930d1d4f19d968817b14852c69..06f5857cf049df3261d2cf1d7=
c3607ab92350ac6 100644
> --- a/migration/block.c
> +++ b/migration/block.c
> @@ -367,7 +367,7 @@ static void unset_dirty_tracking(void)
>      }
>  }
>=20=20
> -static int init_blk_migration(QEMUFile *f)
> +static int init_blk_migration(QEMUFile *f, Error **errp)
>  {
>      BlockDriverState *bs;
>      BlkMigDevState *bmds;
> @@ -378,7 +378,6 @@ static int init_blk_migration(QEMUFile *f)
>          BlkMigDevState *bmds;
>          BlockDriverState *bs;
>      } *bmds_bs;
> -    Error *local_err =3D NULL;
>      int ret;
>=20=20
>      GRAPH_RDLOCK_GUARD_MAINLOOP();

There's a negative return below at:

    for (i =3D 0, bs =3D bdrv_first(&it); bs; bs =3D bdrv_next(&it), i++) {
        if (bdrv_is_read_only(bs)) {
            continue;
        }

        sectors =3D bdrv_nb_sectors(bs);
        if (sectors <=3D 0) {
            ret =3D sectors;
                ^
            bdrv_next_cleanup(&it);
            goto out;
        }
        ...

I presume that must be covered by an error as well. A similar function
somewhere else reports:

        total_sectors =3D blk_nb_sectors(blk);
        if (total_sectors <=3D 0) {
            error_report("Error getting length of block device %s",
                         device_name);
            return -EINVAL;
        }

> @@ -439,9 +438,8 @@ static int init_blk_migration(QEMUFile *f)
>          bs =3D bmds_bs[i].bs;
>=20=20
>          if (bmds) {
> -            ret =3D blk_insert_bs(bmds->blk, bs, &local_err);
> +            ret =3D blk_insert_bs(bmds->blk, bs, errp);
>              if (ret < 0) {
> -                error_report_err(local_err);
>                  goto out;
>              }
>=20=20
> @@ -711,6 +709,7 @@ static void block_migration_cleanup(void *opaque)
>  static int block_save_setup(QEMUFile *f, void *opaque)
>  {
>      int ret;
> +    Error *local_err =3D NULL;
>=20=20
>      trace_migration_block_save("setup", block_mig_state.submitted,
>                                 block_mig_state.transferred);
> @@ -718,18 +717,27 @@ static int block_save_setup(QEMUFile *f, void *opaq=
ue)
>      warn_report("block migration is deprecated;"
>                  " use blockdev-mirror with NBD instead");
>=20=20
> -    ret =3D init_blk_migration(f);
> +    ret =3D init_blk_migration(f, &local_err);
>      if (ret < 0) {
> +        error_report_err(local_err);
>          return ret;
>      }
>=20=20
>      /* start track dirty blocks */
>      ret =3D set_dirty_tracking();
>      if (ret) {
> +        error_setg_errno(&local_err, -ret,
> +                         "Failed to start block dirty tracking");
> +        error_report_err(local_err);
>          return ret;
>      }
>=20=20
>      ret =3D flush_blks(f);
> +    if (ret) {
> +        error_setg_errno(&local_err, -ret, "Flushing block failed");
> +        error_report_err(local_err);
> +        return ret;
> +    }
>      blk_mig_reset_dirty_cursor();
>      qemu_put_be64(f, BLK_MIG_FLAG_EOS);

