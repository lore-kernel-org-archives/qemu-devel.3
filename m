Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F6C6CCD1BC
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Oct 2025 18:21:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vBzw2-0002CD-2H; Thu, 23 Oct 2025 14:21:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1vBzvt-0002AZ-SN
 for qemu-devel@nongnu.org; Thu, 23 Oct 2025 14:21:06 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1vBzvr-0006Us-I1
 for qemu-devel@nongnu.org; Thu, 23 Oct 2025 14:21:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1761243661;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=tpvw1ocDqVJ6iJOZ/XM4STlfLgrjUCg2rMhKsgkLDp0=;
 b=VVCn8oYyW2Yea1aR0vqwOe7cz+28BzQKEpmdDfC9ChGY0S40iszn51j6EJJybbmLpbpC/Y
 Nb9cd7niGSaCv1qMCNPwYezBX6FNzAIOgIq7Hy3CPY6cWLJYAzoKohfDp9hfol0u/JbVt8
 JEZm0zO2zvPA+LeSaGre6qNLgvSrVHU=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-496-BraGkLnwNTi21S2NyBwY8Q-1; Thu,
 23 Oct 2025 14:20:59 -0400
X-MC-Unique: BraGkLnwNTi21S2NyBwY8Q-1
X-Mimecast-MFC-AGG-ID: BraGkLnwNTi21S2NyBwY8Q_1761243657
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 03368195609D; Thu, 23 Oct 2025 18:20:57 +0000 (UTC)
Received: from redhat.com (unknown [10.45.225.90])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 3EC633000B50; Thu, 23 Oct 2025 18:20:54 +0000 (UTC)
Date: Thu, 23 Oct 2025 20:20:51 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: =?iso-8859-1?Q?Cl=E9ment?= Chigot <chigot@adacore.com>
Cc: qemu-devel@nongnu.org, hreitz@redhat.com, qemu-block@nongnu.org
Subject: Re: [PATCH 1/5] vvfat: introduce no-mbr option
Message-ID: <aPpyAzn7abZZ5WNv@redhat.com>
References: <20250903075721.77623-1-chigot@adacore.com>
 <20250903075721.77623-2-chigot@adacore.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250903075721.77623-2-chigot@adacore.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
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
> This option when set prevents a master boot record (MBR) to be
> initialized. This is mandatory as some operating system don't recognized
> mounted disks if a MBR is present.
> 
> Signed-off-by: Clément Chigot <chigot@adacore.com>

Can we actually give an example of such an OS in the commit message?

> ---
>  block/vvfat.c | 16 +++++++++++++++-
>  1 file changed, 15 insertions(+), 1 deletion(-)
> 
> diff --git a/block/vvfat.c b/block/vvfat.c
> index 814796d918..0220dd828b 100644
> --- a/block/vvfat.c
> +++ b/block/vvfat.c
> @@ -1082,6 +1082,11 @@ static QemuOptsList runtime_opts = {
>              .type = QEMU_OPT_BOOL,
>              .help = "Make the image writable",
>          },
> +        {
> +            .name = "no-mbr",
> +            .type = QEMU_OPT_BOOL,
> +            .help = "Do not add a Master Boot Record on this disk",
> +        },

Let's keep option names positive to avoid double negations like
'no-mbr=false'. We can have an 'mbr' option that defaults to true. Or in
fact, maybe calling it 'partitioned' would be easier to understand.

You need to update BlockdevOptionsVVFAT in qapi/block-core.json, too, to
make the new option work with -blockdev. You should update the
description for @floppy there, too, because it says that hard disks are
always partitioned.

It should also be added to vvfat_strong_runtime_opts because the value
of this option changes the data that the guest sees.

>          { /* end of list */ }
>      },
>  };
> @@ -1092,6 +1097,7 @@ static void vvfat_parse_filename(const char *filename, QDict *options,
>      int fat_type = 0;
>      bool floppy = false;
>      bool rw = false;
> +    bool no_mbr = false;
>      int i;
>  
>      if (!strstart(filename, "fat:", NULL)) {
> @@ -1116,6 +1122,10 @@ static void vvfat_parse_filename(const char *filename, QDict *options,
>          rw = true;
>      }
>  
> +    if (strstr(filename, ":no-mbr:")) {

In the string, the negative form can stay (because the positive one
doesn't exist here).

> +        no_mbr = true;
> +    }
> +
>      /* Get the directory name without options */
>      i = strrchr(filename, ':') - filename;
>      assert(i >= 3);
> @@ -1131,6 +1141,7 @@ static void vvfat_parse_filename(const char *filename, QDict *options,
>      qdict_put_int(options, "fat-type", fat_type);
>      qdict_put_bool(options, "floppy", floppy);
>      qdict_put_bool(options, "rw", rw);
> +    qdict_put_bool(options, "no-mbr", no_mbr);
>  }
>  
>  static int vvfat_open(BlockDriverState *bs, QDict *options, int flags,
> @@ -1196,7 +1207,10 @@ static int vvfat_open(BlockDriverState *bs, QDict *options, int flags,
>          if (!s->fat_type) {
>              s->fat_type = 16;
>          }
> -        s->offset_to_bootsector = 0x3f;
> +        /* Reserver space for MBR */
> +        if (!qemu_opt_get_bool(opts, "no-mbr", false)) {
> +            s->offset_to_bootsector = 0x3f;
> +        }
>          cyls = s->fat_type == 12 ? 64 : 1024;
>          heads = 16;
>          secs = 63;

Kevin


