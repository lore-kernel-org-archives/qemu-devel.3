Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7725DC5475B
	for <qemu-devel@archiver.kernel.org>; Mon, 11 Mar 2024 18:27:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rjkLL-00069s-3h; Mon, 11 Mar 2024 14:25:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1rjkKg-000622-4m
 for qemu-devel@nongnu.org; Mon, 11 Mar 2024 14:25:13 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1rjkKe-00086g-73
 for qemu-devel@nongnu.org; Mon, 11 Mar 2024 14:25:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1710181492;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=ZqSp48UUkbpqeui6N0nxaPtpILZYFkgE6PmsXB9uBi8=;
 b=Lqsedbi5sWYdu985GQEXZnzHmEulIdnMYXpj2tX6YMH9IVvN4iGOYz2cWLmzCSe1L2va1e
 vI8/b1BD/CcKHUj84RGzk1sl9zt5HCfVW4PlUtDriLghBSzuqCW8LwqTGDTGZAtSGsSloe
 mZ+1suAkxTXR9mlZy6CocE7/b7WzlaU=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-602-ke4eFbJjP9aUOebHrzbuwg-1; Mon, 11 Mar 2024 14:24:50 -0400
X-MC-Unique: ke4eFbJjP9aUOebHrzbuwg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
 [10.11.54.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 6B97689C56D;
 Mon, 11 Mar 2024 18:24:50 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.132])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 1F2611121306;
 Mon, 11 Mar 2024 18:24:49 +0000 (UTC)
Date: Mon, 11 Mar 2024 18:24:47 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Alexander Ivanov <alexander.ivanov@virtuozzo.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, den@virtuozzo.com,
 andrey.drobyshev@virtuozzo.com, jsnow@redhat.com,
 vsementsov@yandex-team.ru, kwolf@redhat.com, hreitz@redhat.com
Subject: Re: [PATCH] block: Use LVM tools for LV block device truncation
Message-ID: <Ze9Mb6pHcTOdghCy@redhat.com>
References: <20240311174044.67094-1-alexander.ivanov@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240311174044.67094-1-alexander.ivanov@virtuozzo.com>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.3
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.029,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Mon, Mar 11, 2024 at 06:40:44PM +0100, Alexander Ivanov wrote:
> If a block device is an LVM logical volume we can resize it using
> standard LVM tools.
> 
> In raw_co_truncate() check if the block device is a LV using lvdisplay
> and resize it executing lvresize.
> 
> Signed-off-by: Alexander Ivanov <alexander.ivanov@virtuozzo.com>
> ---
>  block/file-posix.c | 27 +++++++++++++++++++++++++++
>  1 file changed, 27 insertions(+)
> 
> diff --git a/block/file-posix.c b/block/file-posix.c
> index 35684f7e21..cf8a04e6f7 100644
> --- a/block/file-posix.c
> +++ b/block/file-posix.c
> @@ -2670,6 +2670,33 @@ static int coroutine_fn raw_co_truncate(BlockDriverState *bs, int64_t offset,
>      if (S_ISCHR(st.st_mode) || S_ISBLK(st.st_mode)) {
>          int64_t cur_length = raw_getlength(bs);
>  
> +        /*
> +         * Check if the device is an LVM logical volume and try to resize
> +         * it using LVM tools.
> +         */
> +        if (S_ISBLK(st.st_mode) && offset > 0) {
> +            char cmd[PATH_MAX + 32];
> +
> +            snprintf(cmd, sizeof(cmd), "lvdisplay %s > /dev/null",
> +                     bs->filename);

PATH_MAX + snprint is a bad practice - g_strdup_printf() is recommended
for dynamic allocation, along with g_autofree for release.

> +            ret = system(cmd);

IMHO using 'system' for spawning processes is dubious in any non-trivial
program.

Historically at least it does not have well defined behaviour wrt signal
handling in the child, before execve is called. ie potentially a signal
handler registered by QEMU in the parent could run in the child having
ill-effects.

'system' also executes via the shell which opens up many risks with
unsanitized files path being substituted into the command line.

> +            if (ret != 0) {
> +                error_setg(errp, "lvdisplay returned %d error for '%s'",
> +                           ret, bs->filename);
> +                return ret;
> +            }

Calling 'lvdisplay' doesn't seem to be needed. Surely 'lvresize' is
going to report errors if it isn't an LVM device.

If we want to detect an LVM device though, couldn't we lookup
'device-mapper'  in /proc/devices and then major the device major
node number.

> +
> +            snprintf(cmd, sizeof(cmd), "lvresize -f -L %ldB %s > /dev/null",
> +                     offset, bs->filename);
> +            ret = system(cmd);
> +            if (ret != 0) {
> +                error_setg(errp, "lvresize returned %d error for '%s'",
> +                           ret, bs->filename);

lvresize might display an message on stderr on failure but that's at best
going to QEMU's stderr. Any error needs to be captured and put into
this error message that's fed back to the user / QMP client.

> +            }
> +
> +            return ret;
> +        }
> +

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


