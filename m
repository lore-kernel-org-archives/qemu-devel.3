Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75227C54E58
	for <qemu-devel@archiver.kernel.org>; Fri, 15 Mar 2024 09:19:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rl3iM-0003K7-SN; Fri, 15 Mar 2024 05:18:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1rl3iL-0003I6-Uc
 for qemu-devel@nongnu.org; Fri, 15 Mar 2024 05:18:57 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1rl3iK-0000YF-9E
 for qemu-devel@nongnu.org; Fri, 15 Mar 2024 05:18:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1710494335;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=j5PWWCTUbve5HZqg5gNONsxDza5Z88BZwyMjQ/11dZc=;
 b=GgiA4wJGaSPX5v4j/sjwFsjEz3P8sNTr0IkGrKyqnDNin89JCbfsZJP+DSe9Fr/9B9Vaxu
 32pJtBChQ6u3kGNm1S4pcy4Te5czUwJr58DMCxKwSPwctFtcV6O8WtQU2tF8KS83LGZef6
 gO8Pc9JF0hdk9Y6nKNi5nUqoW/t8eZ8=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-226-B1AxVKRlOpWVefx_8aUj9A-1; Fri,
 15 Mar 2024 05:18:52 -0400
X-MC-Unique: B1AxVKRlOpWVefx_8aUj9A-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
 [10.11.54.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 1017B3C0D7BD;
 Fri, 15 Mar 2024 09:18:52 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.78])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 86CDF10E4B;
 Fri, 15 Mar 2024 09:18:50 +0000 (UTC)
Date: Fri, 15 Mar 2024 09:18:48 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Alexander Ivanov <alexander.ivanov@virtuozzo.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, den@virtuozzo.com,
 andrey.drobyshev@virtuozzo.com, jsnow@redhat.com,
 vsementsov@yandex-team.ru, kwolf@redhat.com, hreitz@redhat.com
Subject: Re: [PATCH v3] block: Use LVM tools for LV block device truncation
Message-ID: <ZfQSeHe7-4fNkiCI@redhat.com>
References: <20240315085838.226506-1-alexander.ivanov@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240315085838.226506-1-alexander.ivanov@virtuozzo.com>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.5
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.987,
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

On Fri, Mar 15, 2024 at 09:58:38AM +0100, Alexander Ivanov wrote:
> If a block device is an LVM logical volume we can resize it using
> standard LVM tools.
> 
> Add a helper to detect if a device is a DM device. In raw_co_truncate()
> check if the block device is DM and resize it executing lvresize.
> 
> Signed-off-by: Alexander Ivanov <alexander.ivanov@virtuozzo.com>
> ---
>  block/file-posix.c | 61 ++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 61 insertions(+)

Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>


> 
> diff --git a/block/file-posix.c b/block/file-posix.c
> index 35684f7e21..af17a43fe9 100644
> --- a/block/file-posix.c
> +++ b/block/file-posix.c
> @@ -2642,6 +2642,38 @@ raw_regular_truncate(BlockDriverState *bs, int fd, int64_t offset,
>      return raw_thread_pool_submit(handle_aiocb_truncate, &acb);
>  }
>  
> +static bool device_is_dm(struct stat *st)
> +{
> +    unsigned int maj, maj2;
> +    char line[32], devname[16];
> +    bool ret = false;
> +    FILE *f;
> +
> +    if (!S_ISBLK(st->st_mode)) {
> +        return false;
> +    }
> +
> +    f = fopen("/proc/devices", "r");
> +    if (!f) {
> +        return false;
> +    }
> +
> +    maj = major(st->st_rdev);
> +
> +    while (fgets(line, sizeof(line), f)) {
> +        if (sscanf(line, "%u %15s", &maj2, devname) != 2) {
> +            continue;
> +        }
> +        if (strcmp(devname, "device-mapper") == 0) {
> +            ret = (maj == maj2);
> +            break;
> +        }
> +    }
> +
> +    fclose(f);
> +    return ret;
> +}
> +
>  static int coroutine_fn raw_co_truncate(BlockDriverState *bs, int64_t offset,
>                                          bool exact, PreallocMode prealloc,
>                                          BdrvRequestFlags flags, Error **errp)
> @@ -2670,6 +2702,35 @@ static int coroutine_fn raw_co_truncate(BlockDriverState *bs, int64_t offset,
>      if (S_ISCHR(st.st_mode) || S_ISBLK(st.st_mode)) {
>          int64_t cur_length = raw_getlength(bs);
>  
> +        /*
> +         * Try to resize an LVM device using LVM tools.
> +         */
> +        if (device_is_dm(&st) && offset > 0) {
> +            int spawn_flags = G_SPAWN_SEARCH_PATH | G_SPAWN_STDOUT_TO_DEV_NULL;
> +            int status;
> +            bool success;
> +            char *err;
> +            GError *gerr = NULL, *gerr_exit = NULL;
> +            g_autofree char *size_str = g_strdup_printf("%" PRId64 "B", offset);
> +            const char *cmd[] = {"lvresize", "-f", "-L",
> +                                 size_str, bs->filename, NULL};
> +
> +            success = g_spawn_sync(NULL, (gchar **)cmd, NULL, spawn_flags,
> +                                   NULL, NULL, NULL, &err, &status, &gerr);
> +
> +            if (success && g_spawn_check_exit_status(status, &gerr_exit)) {
> +                return 0;
> +            }
> +
> +            if (success) {
> +                error_setg(errp, "%s: %s", gerr_exit->message, err);
> +            } else {
> +                error_setg(errp, "lvresize execution error: %s", gerr->message);
> +            }
> +
> +            return -EINVAL;
> +        }
> +
>          if (offset != cur_length && exact) {
>              error_setg(errp, "Cannot resize device files");
>              return -ENOTSUP;
> -- 
> 2.40.1
> 
> 

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


