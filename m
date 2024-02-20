Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1097BC5475B
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Feb 2024 17:46:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rcUC2-00066L-0o; Tue, 20 Feb 2024 12:46:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1rcUBz-00065f-KL
 for qemu-devel@nongnu.org; Tue, 20 Feb 2024 12:46:07 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1rcUBw-0005lk-Hc
 for qemu-devel@nongnu.org; Tue, 20 Feb 2024 12:46:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1708451163;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=wcKJDn2zZ3ELSOgcaQE/bB6yQIJsMPTI7J2YPLX1Zp0=;
 b=WIvtwe/uJ98iM4ZCk0q6jLkF7kAzuaQqzAea/Z0B5QvSHEGpwNs0eybGcNOQp1/l/1yHFT
 6vPmjr4vxHPQCbjxy98UbswNX4PYJS54DQuyGAn5/tnDsJdyY8w5mobCYjLPg0ClG6GogM
 DCn/1Zcm9ypXwWLw0MkmxBKgkwU4iew=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-544-xmZEqi-IO4CKDAiy8Qu7xg-1; Tue,
 20 Feb 2024 12:46:01 -0500
X-MC-Unique: xmZEqi-IO4CKDAiy8Qu7xg-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com
 [10.11.54.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 409A138562C7;
 Tue, 20 Feb 2024 17:46:01 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.50])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id B2CCE1C060AF;
 Tue, 20 Feb 2024 17:46:00 +0000 (UTC)
Date: Tue, 20 Feb 2024 17:45:58 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Michael Tokarev <mjt@tls.msk.ru>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org
Subject: Re: [PATCH 12/23] qemu-img: make -l (list) the default for
 "snapshot" subcommand
Message-ID: <ZdTlVnQ2YvTLctDp@redhat.com>
References: <cover.1707513011.git.mjt@tls.msk.ru>
 <71d69214d43897e5649fed00804a5969b0fd718b.1707513011.git.mjt@tls.msk.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <71d69214d43897e5649fed00804a5969b0fd718b.1707513011.git.mjt@tls.msk.ru>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.7
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.05,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Sat, Feb 10, 2024 at 12:22:33AM +0300, Michael Tokarev wrote:
> also remove bdrv_oflags handling (only list can use RO mode)
> ---
>  qemu-img.c | 13 ++++++++-----
>  1 file changed, 8 insertions(+), 5 deletions(-)

I'd suggest docs/tools/qemu-img.rst should also be updated to say

 Lists all snapshots in the given image (default action)

> 
> diff --git a/qemu-img.c b/qemu-img.c
> index 1e09b78d00..d9dfff2f07 100644
> --- a/qemu-img.c
> +++ b/qemu-img.c
> @@ -3541,7 +3541,7 @@ static int img_snapshot(const img_cmd_t *ccmd, int argc, char **argv)
>      BlockDriverState *bs;
>      QEMUSnapshotInfo sn;
>      char *filename, *fmt = NULL, *snapshot_name = NULL;
> -    int c, ret = 0, bdrv_oflags;
> +    int c, ret = 0;
>      int action = 0;
>      bool quiet = false;
>      Error *err = NULL;
> @@ -3549,7 +3549,6 @@ static int img_snapshot(const img_cmd_t *ccmd, int argc, char **argv)
>      bool force_share = false;
>      int64_t rt;
>  
> -    bdrv_oflags = BDRV_O_RDWR;
>      /* Parse commandline parameters */
>      for(;;) {
>          static const struct option long_options[] = {
> @@ -3583,7 +3582,6 @@ static int img_snapshot(const img_cmd_t *ccmd, int argc, char **argv)
>                  return 0;
>              }
>              action = SNAPSHOT_LIST;
> -            bdrv_oflags &= ~BDRV_O_RDWR; /* no need for RW */
>              break;
>          case 'a':
>              if (action) {
> @@ -3629,9 +3627,14 @@ static int img_snapshot(const img_cmd_t *ccmd, int argc, char **argv)
>      }
>      filename = argv[optind++];
>  
> +    if (!action) {
> +        action = SNAPSHOT_LIST;
> +    }
> +
>      /* Open the image */
> -    blk = img_open(image_opts, filename, fmt, bdrv_oflags, false, quiet,
> -                   force_share);
> +    blk = img_open(image_opts, filename, fmt,
> +                   action == SNAPSHOT_LIST ? 0 : BDRV_O_RDWR,
> +                   false, quiet, force_share);
>      if (!blk) {
>          return 1;
>      }
> -- 
> 2.39.2
> 
> 

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


