Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EDF65C04FFE
	for <qemu-devel@archiver.kernel.org>; Wed,  8 May 2024 08:01:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s4cEL-0006jn-9A; Wed, 08 May 2024 04:00:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1s4cE4-0006gf-Fb
 for qemu-devel@nongnu.org; Wed, 08 May 2024 04:00:43 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1s4cE0-0006vV-1g
 for qemu-devel@nongnu.org; Wed, 08 May 2024 04:00:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1715155225;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=swI8IhoqVPcVgQN4ZmJQ+Dk8KSNn5MlQhCM4NwKYZ0c=;
 b=Hvg7BO9iSlhbfLsGm+VOrXwJXuiraVMrboV2X+Lej76aUqtNeVOysFzI2xEOGc+wQ+oQA8
 S74VRnyI9YPvIdpvjaQmbsuacjcFyWFrKaSKfC0K+SDZLzdPlAliXb7RXFxnuut1iWuOFS
 CMXEX3YH16msF04MoFJhgfMXCynGIHk=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-583-1O8lt-1HNjqvzK0-tCvtrg-1; Wed, 08 May 2024 04:00:22 -0400
X-MC-Unique: 1O8lt-1HNjqvzK0-tCvtrg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
 [10.11.54.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 13E1580021D;
 Wed,  8 May 2024 08:00:22 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.29])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id EC3212166B32;
 Wed,  8 May 2024 08:00:20 +0000 (UTC)
Date: Wed, 8 May 2024 09:00:19 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org, armbru@redhat.com, Peter Xu <peterx@redhat.com>,
 Claudio Fontana <cfontana@suse.de>, Jim Fehlig <jfehlig@suse.com>
Subject: Re: [PATCH 2/9] migration: Fix file migration with fdset
Message-ID: <ZjsxE9p4CsfZQK8Y@redhat.com>
References: <20240426142042.14573-1-farosas@suse.de>
 <20240426142042.14573-3-farosas@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240426142042.14573-3-farosas@suse.de>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.6
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.581,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Fri, Apr 26, 2024 at 11:20:35AM -0300, Fabiano Rosas wrote:
> When the migration using the "file:" URI was implemented, I don't
> think any of us noticed that if you pass in a file name with the
> format "/dev/fdset/N", this allows a file descriptor to be passed in
> to QEMU and that behaves just like the "fd:" URI. So the "file:"
> support has been added without regard for the fdset part and we got
> some things wrong.
> 
> The first issue is that we should not truncate the migration file if
> we're allowing an fd + offset. We need to leave the file contents
> untouched.
> 
> The second issue is that there's an expectation that QEMU removes the
> fd after the migration has finished. That's what the "fd:" code
> does. Otherwise a second migration on the same VM could attempt to
> provide an fdset with the same name and QEMU would reject it.
> 
> We can fix the first issue by detecting when we're using the fdset
> vs. the plain file name. This requires storing the fdset_id
> somewhere. We can then use this stored fdset_id to do cleanup at the
> end and also fix the second issue.

The use of /dev/fdset is supposed to be transparent to code in
QEMU, so modifying migration to learn about FD sets to do manual
cleanup is breaking that API facade.

IMHO the transparency of the design points towards the mgmt app
calling 'remove-fd' set after migration has started, in order
that a later migraiton can use the same fdset name.

Ideally the truncation issue needs to be transparent too.

Rather than detecting use of fdset, we can not use O_TRUNC
at all. Instead we can call ftruncate(fd, offset), which
should work in both normal and fdset scenarios.

> 
> Fixes: 385f510df5 ("migration: file URI offset")
> Signed-off-by: Fabiano Rosas <farosas@suse.de>
> ---
>  migration/file.c | 48 ++++++++++++++++++++++++++++++++++++++++++++++--
>  1 file changed, 46 insertions(+), 2 deletions(-)
> 
> diff --git a/migration/file.c b/migration/file.c
> index ab18ba505a..8f30999400 100644
> --- a/migration/file.c
> +++ b/migration/file.c
> @@ -10,6 +10,7 @@
>  #include "qemu/cutils.h"
>  #include "qemu/error-report.h"
>  #include "qapi/error.h"
> +#include "qapi/qapi-commands-misc.h"
>  #include "channel.h"
>  #include "file.h"
>  #include "migration.h"
> @@ -23,6 +24,7 @@
>  
>  static struct FileOutgoingArgs {
>      char *fname;
> +    int64_t fdset_id;
>  } outgoing_args;
>  
>  /* Remove the offset option from @filespec and return it in @offsetp. */
> @@ -44,10 +46,39 @@ int file_parse_offset(char *filespec, uint64_t *offsetp, Error **errp)
>      return 0;
>  }
>  
> +static void file_remove_fdset(void)
> +{
> +    if (outgoing_args.fdset_id != -1) {
> +        qmp_remove_fd(outgoing_args.fdset_id, false, -1, NULL);
> +        outgoing_args.fdset_id = -1;
> +    }
> +}
> +
> +static bool file_parse_fdset(const char *filename, int64_t *fdset_id,
> +                             Error **errp)
> +{
> +    const char *fdset_id_str;
> +
> +    *fdset_id = -1;
> +
> +    if (!strstart(filename, "/dev/fdset/", &fdset_id_str)) {
> +        return true;
> +    }
> +
> +    *fdset_id = qemu_parse_fd(fdset_id_str);
> +    if (*fdset_id == -1) {
> +        error_setg_errno(errp, EINVAL, "Could not parse fdset %s", fdset_id_str);
> +        return false;
> +    }
> +
> +    return true;
> +}
> +
>  void file_cleanup_outgoing_migration(void)
>  {
>      g_free(outgoing_args.fname);
>      outgoing_args.fname = NULL;
> +    file_remove_fdset();
>  }
>  
>  bool file_send_channel_create(gpointer opaque, Error **errp)
> @@ -81,11 +112,24 @@ void file_start_outgoing_migration(MigrationState *s,
>      g_autofree char *filename = g_strdup(file_args->filename);
>      uint64_t offset = file_args->offset;
>      QIOChannel *ioc;
> +    int flags = O_CREAT | O_WRONLY;
>  
>      trace_migration_file_outgoing(filename);
>  
> -    fioc = qio_channel_file_new_path(filename, O_CREAT | O_WRONLY | O_TRUNC,
> -                                     0600, errp);
> +    if (!file_parse_fdset(filename, &outgoing_args.fdset_id, errp)) {
> +        return;
> +    }
> +
> +    /*
> +     * Only truncate if it's QEMU opening the file. If an fd has been
> +     * passed in the file will already contain data written by the
> +     * management layer.
> +     */
> +    if (outgoing_args.fdset_id == -1) {
> +        flags |= O_TRUNC;
> +    }
> +
> +    fioc = qio_channel_file_new_path(filename, flags, 0600, errp);
>      if (!fioc) {
>          return;
>      }
> -- 
> 2.35.3
> 

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


