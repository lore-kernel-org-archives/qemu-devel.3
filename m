Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2BB17C04FFE
	for <qemu-devel@archiver.kernel.org>; Wed,  8 May 2024 08:28:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s4ceV-0000dz-46; Wed, 08 May 2024 04:27:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1s4ceR-0000dT-0O
 for qemu-devel@nongnu.org; Wed, 08 May 2024 04:27:47 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1s4ceN-0007MN-IB
 for qemu-devel@nongnu.org; Wed, 08 May 2024 04:27:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1715156862;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=9KMFdzheHs4wcy4cwBBnEP5ReSDD726Lvp4KrtfvQJc=;
 b=DMxn54GmUUrX0dnSeALH5a7sDXrSCxNSv1Pn7h6Nu1PZl1bXhrJ7xW+eKiM5/YCa0roKE1
 8cRtkPHo3/ogJGT6Zu+BTZtpmfEr58XfRMkqzmPc2e2+5Vt/c+oghHkeVJVM5hJ8vmhVxk
 im/9ozWQ1BZsSyCsA78OEPNJ4hc5Cb0=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-460-R-OfdC-tNvWLmFllHbtfZQ-1; Wed,
 08 May 2024 04:27:41 -0400
X-MC-Unique: R-OfdC-tNvWLmFllHbtfZQ-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com
 [10.11.54.9])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id C2F2A3806701;
 Wed,  8 May 2024 08:27:40 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.29])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 9E216492BC6;
 Wed,  8 May 2024 08:27:39 +0000 (UTC)
Date: Wed, 8 May 2024 09:27:37 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org, armbru@redhat.com, Peter Xu <peterx@redhat.com>,
 Claudio Fontana <cfontana@suse.de>, Jim Fehlig <jfehlig@suse.com>
Subject: Re: [PATCH 5/9] migration/multifd: Add direct-io support
Message-ID: <Zjs3eZ_PGGzyQkDN@redhat.com>
References: <20240426142042.14573-1-farosas@suse.de>
 <20240426142042.14573-6-farosas@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240426142042.14573-6-farosas@suse.de>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.9
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
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

On Fri, Apr 26, 2024 at 11:20:38AM -0300, Fabiano Rosas wrote:
> When multifd is used along with mapped-ram, we can take benefit of a
> filesystem that supports the O_DIRECT flag and perform direct I/O in
> the multifd threads. This brings a significant performance improvement
> because direct-io writes bypass the page cache which would otherwise
> be thrashed by the multifd data which is unlikely to be needed again
> in a short period of time.
> 
> To be able to use a multifd channel opened with O_DIRECT, we must
> ensure that a certain aligment is used. Filesystems usually require a
> block-size alignment for direct I/O. The way to achieve this is by
> enabling the mapped-ram feature, which already aligns its I/O properly
> (see MAPPED_RAM_FILE_OFFSET_ALIGNMENT at ram.c).
> 
> By setting O_DIRECT on the multifd channels, all writes to the same
> file descriptor need to be aligned as well, even the ones that come
> from outside multifd, such as the QEMUFile I/O from the main migration
> code. This makes it impossible to use the same file descriptor for the
> QEMUFile and for the multifd channels. The various flags and metadata
> written by the main migration code will always be unaligned by virtue
> of their small size. To workaround this issue, we'll require a second
> file descriptor to be used exclusively for direct I/O.
> 
> The second file descriptor can be obtained by QEMU by re-opening the
> migration file (already possible), or by being provided by the user or
> management application (support to be added in future patches).
> 
> Signed-off-by: Fabiano Rosas <farosas@suse.de>
> ---
>  migration/file.c      | 22 +++++++++++++++++++---
>  migration/migration.c | 23 +++++++++++++++++++++++
>  2 files changed, 42 insertions(+), 3 deletions(-)
> 
> diff --git a/migration/file.c b/migration/file.c
> index 8f30999400..b9265b14dd 100644
> --- a/migration/file.c
> +++ b/migration/file.c
> @@ -83,17 +83,33 @@ void file_cleanup_outgoing_migration(void)
>  
>  bool file_send_channel_create(gpointer opaque, Error **errp)
>  {
> -    QIOChannelFile *ioc;
> +    QIOChannelFile *ioc = NULL;
>      int flags = O_WRONLY;
> -    bool ret = true;
> +    bool ret = false;
> +
> +    if (migrate_direct_io()) {
> +#ifdef O_DIRECT
> +        /*
> +         * Enable O_DIRECT for the secondary channels. These are used
> +         * for sending ram pages and writes should be guaranteed to be
> +         * aligned to at least page size.
> +         */
> +        flags |= O_DIRECT;
> +#else
> +        error_setg(errp, "System does not support O_DIRECT");
> +        error_append_hint(errp,
> +                          "Try disabling direct-io migration capability\n");
> +        goto out;
> +#endif

If we conditionalize existance of 'direct-io' feature in the QAPI
schema, then the '#else' clause no longer needs to even exist as
it will be unreachable - it could be a g_assert_not_reached();

> +    }
>  
>      ioc = qio_channel_file_new_path(outgoing_args.fname, flags, 0, errp);
>      if (!ioc) {
> -        ret = false;
>          goto out;
>      }
>  
>      multifd_channel_connect(opaque, QIO_CHANNEL(ioc));
> +    ret = true;
>  
>  out:
>      /*
> diff --git a/migration/migration.c b/migration/migration.c
> index b5af6b5105..cb923a3f62 100644
> --- a/migration/migration.c
> +++ b/migration/migration.c
> @@ -155,6 +155,16 @@ static bool migration_needs_seekable_channel(void)
>      return migrate_mapped_ram();
>  }
>  
> +static bool migration_needs_multiple_fds(void)
> +{
> +    /*
> +     * When doing direct-io, multifd requires two different,
> +     * non-duplicated file descriptors so we can use one of them for
> +     * unaligned IO.
> +     */
> +    return migrate_multifd() && migrate_direct_io();
> +}
> +
>  static bool transport_supports_seeking(MigrationAddress *addr)
>  {
>      if (addr->transport == MIGRATION_ADDRESS_TYPE_FILE) {
> @@ -164,6 +174,12 @@ static bool transport_supports_seeking(MigrationAddress *addr)
>      return false;
>  }
>  
> +static bool transport_supports_multiple_fds(MigrationAddress *addr)
> +{
> +    /* file: works because QEMU can open it multiple times */
> +    return addr->transport == MIGRATION_ADDRESS_TYPE_FILE;
> +}
> +
>  static bool
>  migration_channels_and_transport_compatible(MigrationAddress *addr,
>                                              Error **errp)
> @@ -180,6 +196,13 @@ migration_channels_and_transport_compatible(MigrationAddress *addr,
>          return false;
>      }
>  
> +    if (migration_needs_multiple_fds() &&
> +        !transport_supports_multiple_fds(addr)) {
> +        error_setg(errp,
> +                   "Migration requires a transport that allows for multiple fds (e.g. file)");
> +        return false;
> +    }
> +
>      return true;
>  }
>  
> -- 
> 2.35.3
> 

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


