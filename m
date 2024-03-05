Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1139AC54E4A
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Mar 2024 17:50:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rhYvA-00062O-A9; Tue, 05 Mar 2024 12:49:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1rhYv8-00061y-W5
 for qemu-devel@nongnu.org; Tue, 05 Mar 2024 12:49:43 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1rhYv6-0005GR-Vc
 for qemu-devel@nongnu.org; Tue, 05 Mar 2024 12:49:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1709660979;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=owdGxSyj40DbxDONORGcj4APZ4vIp/Tp7sKAfAEdF4Y=;
 b=anfxbR1l68abvqneOKofdaQVS23OPMz7x2FRUM7BKQ8fUpNASB3DKksJFFsO09gsMSMVjR
 gS9eZTZ4i34U+2mWQzKOyjjMJuQhqVRErp/APDbWjz0qJqMIgfza+KZbkuGa3MG1jUQgYv
 /szdxD0WnLZuBoTOz9+0+h4j26ga63A=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-688-ckj6LodRPSGb_vjEjnY1mg-1; Tue,
 05 Mar 2024 12:49:38 -0500
X-MC-Unique: ckj6LodRPSGb_vjEjnY1mg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
 [10.11.54.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 45722285F991;
 Tue,  5 Mar 2024 17:49:37 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.66])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 3F7A22166AE8;
 Tue,  5 Mar 2024 17:49:36 +0000 (UTC)
Date: Tue, 5 Mar 2024 17:49:33 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org, peterx@redhat.com
Subject: Re: [PATCH] migration/multifd: Don't fsync when closing QIOChannelFile
Message-ID: <ZedbLT2pFNyRoX90@redhat.com>
References: <20240305174332.2553-1-farosas@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240305174332.2553-1-farosas@suse.de>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.6
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.568,
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

On Tue, Mar 05, 2024 at 02:43:32PM -0300, Fabiano Rosas wrote:
> Commit bc38feddeb ("io: fsync before closing a file channel") added a
> fsync/fdatasync at the closing point of the QIOChannelFile to ensure
> integrity of the migration stream in case of QEMU crash.
> 
> The decision to do the sync at qio_channel_close() was not the best
> since that function runs in the main thread and the fsync can cause
> QEMU to hang for several minutes, depending on the migration size and
> disk speed.
> 
> To fix the hang, remove the fsync from qio_channel_file_close().
> 
> At this moment, the migration code is the only user of the fsync and
> we're taking the tradeoff of not having a sync at all, leaving the
> responsibility to the upper layers.
> 
> Fixes: bc38feddeb ("io: fsync before closing a file channel")
> Signed-off-by: Fabiano Rosas <farosas@suse.de>
> ---
>  docs/devel/migration/main.rst |  3 ++-
>  io/channel-file.c             |  5 -----
>  migration/multifd.c           | 13 -------------
>  3 files changed, 2 insertions(+), 19 deletions(-)
> 
> diff --git a/docs/devel/migration/main.rst b/docs/devel/migration/main.rst
> index 8024275d6d..54385a23e5 100644
> --- a/docs/devel/migration/main.rst
> +++ b/docs/devel/migration/main.rst
> @@ -44,7 +44,8 @@ over any transport.
>  - file migration: do the migration using a file that is passed to QEMU
>    by path. A file offset option is supported to allow a management
>    application to add its own metadata to the start of the file without
> -  QEMU interference.
> +  QEMU interference. Note that QEMU does not flush cached file
> +  data/metadata at the end of migration.
>  
>  In addition, support is included for migration using RDMA, which
>  transports the page data using ``RDMA``, where the hardware takes care of
> diff --git a/io/channel-file.c b/io/channel-file.c
> index d4706fa592..a6ad7770c6 100644
> --- a/io/channel-file.c
> +++ b/io/channel-file.c
> @@ -242,11 +242,6 @@ static int qio_channel_file_close(QIOChannel *ioc,
>  {
>      QIOChannelFile *fioc = QIO_CHANNEL_FILE(ioc);
>  
> -    if (qemu_fdatasync(fioc->fd) < 0) {
> -        error_setg_errno(errp, errno,
> -                         "Unable to synchronize file data with storage device");
> -        return -1;
> -    }
>      if (qemu_close(fioc->fd) < 0) {
>          error_setg_errno(errp, errno,
>                           "Unable to close file");

Upto here:

   Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>


> diff --git a/migration/multifd.c b/migration/multifd.c
> index d4a44da559..2edcd5104e 100644
> --- a/migration/multifd.c
> +++ b/migration/multifd.c
> @@ -709,19 +709,6 @@ static bool multifd_send_cleanup_channel(MultiFDSendParams *p, Error **errp)
>  {
>      if (p->c) {
>          migration_ioc_unregister_yank(p->c);
> -        /*
> -         * An explicit close() on the channel here is normally not
> -         * required, but can be helpful for "file:" iochannels, where it
> -         * will include fdatasync() to make sure the data is flushed to the
> -         * disk backend.
> -         *
> -         * The object_unref() cannot guarantee that because: (1) finalize()
> -         * of the iochannel is only triggered on the last reference, and
> -         * it's not guaranteed that we always hold the last refcount when
> -         * reaching here, and, (2) even if finalize() is invoked, it only
> -         * does a close(fd) without data flush.
> -         */
> -        qio_channel_close(p->c, &error_abort);
>          object_unref(OBJECT(p->c));
>          p->c = NULL;
>      }

I don't think you should be removing this. Calling qio_channel_close()
remains recommended best practice, even with fdatasync() removed, as
it provides a strong guarantee that the FD is released which you don't
get if you rely on the ref count being correctly decremented in all
code paths.

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


