Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C549C25B75
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Jun 2024 10:32:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sE4zY-0006q9-1f; Mon, 03 Jun 2024 06:32:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1sE4zQ-0006lm-VR
 for qemu-devel@nongnu.org; Mon, 03 Jun 2024 06:32:32 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1sE4zK-0005Oj-Ip
 for qemu-devel@nongnu.org; Mon, 03 Jun 2024 06:32:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1717410745;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=7C/v62astoOTqjH9x0lSFNEsMY22ED/cqcJv0b2FtuI=;
 b=ObX1A3vdUy08Vz3gtJ8XrOEQs0zTgfQSbMcqub2z7CyC6yiT0nkp4UkYulror/gKNIv70T
 UfSGNvysUytuqc9BqBeBxlFOxaY/iCfnsUQLOJxen4jf4X9SygA41W4oyWvR3nLIIJKPv8
 Y9IUry+/yHsA1RyEwrqOux9pgCjmb84=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-93-7VUm1CIQPBKfVdXaCSn3tg-1; Mon, 03 Jun 2024 06:32:22 -0400
X-MC-Unique: 7VUm1CIQPBKfVdXaCSn3tg-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com
 [10.11.54.9])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 2E71A185A780;
 Mon,  3 Jun 2024 10:32:22 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.80])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 73107402EB1;
 Mon,  3 Jun 2024 10:32:20 +0000 (UTC)
Date: Mon, 3 Jun 2024 11:32:18 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org, armbru@redhat.com, Peter Xu <peterx@redhat.com>,
 Claudio Fontana <cfontana@suse.de>, Jim Fehlig <jfehlig@suse.com>
Subject: Re: [PATCH v2 16/18] io/channel-file: Add direct-io support
Message-ID: <Zl2bsnOjSwM1uhEa@redhat.com>
References: <20240523190548.23977-1-farosas@suse.de>
 <20240523190548.23977-17-farosas@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240523190548.23977-17-farosas@suse.de>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.9
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.142,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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

On Thu, May 23, 2024 at 04:05:46PM -0300, Fabiano Rosas wrote:
> Add support for setting/clearing the O_DIRECT flag on a file
> descriptor. This will be used for enabling O_DIRECT in the main
> migration channel when multifd is not in use.
> 
> Signed-off-by: Fabiano Rosas <farosas@suse.de>
> ---
>  include/io/channel-file.h |  8 ++++++++
>  io/channel-file.c         | 25 +++++++++++++++++++++++++
>  2 files changed, 33 insertions(+)
> 
> diff --git a/include/io/channel-file.h b/include/io/channel-file.h
> index d373a4e44d..ecb4450e8e 100644
> --- a/include/io/channel-file.h
> +++ b/include/io/channel-file.h
> @@ -107,4 +107,12 @@ qio_channel_file_new_path(const char *path,
>                            mode_t mode,
>                            Error **errp);
>  
> +/**
> + * qio_channel_file_set_direct_io:
> + * @ioc: the QIOChannel object
> + * @enabled: the desired state of the O_DIRECT flag
> + * @errp: pointer to initialized error object
> + */
> +void qio_channel_file_set_direct_io(QIOChannel *ioc, bool enabled,
> +                                    Error **errp);

This should return 'int' rather than void, giving -1 on error,
0 on success, so callers don't deference the errp parameter
to check status.

>  #endif /* QIO_CHANNEL_FILE_H */
> diff --git a/io/channel-file.c b/io/channel-file.c
> index 2ea8d08360..a89cd3a6d5 100644
> --- a/io/channel-file.c
> +++ b/io/channel-file.c
> @@ -231,6 +231,31 @@ static int qio_channel_file_set_blocking(QIOChannel *ioc,
>  #endif
>  }
>  
> +void qio_channel_file_set_direct_io(QIOChannel *ioc, bool enabled, Error **errp)
> +{
> +#ifdef O_DIRECT
> +    QIOChannelFile *fioc = QIO_CHANNEL_FILE(ioc);
> +    int flags = fcntl(fioc->fd, F_GETFL);
> +
> +    if (flags == -1) {
> +        error_setg_errno(errp, errno, "Unable to read file descriptor flags");
> +        return;
> +    }
> +
> +    if (enabled) {
> +        flags |= O_DIRECT;
> +    } else {
> +        flags &= ~O_DIRECT;
> +    }
> +
> +    if (fcntl(fioc->fd, F_SETFL, flags) == -1) {
> +        error_setg_errno(errp, errno, "Unable to set file descriptor flags");
> +        return;
> +    }
> +#else
> +    error_setg(errp, "System does not support O_DIRECT");
> +#endif
> +}
>  
>  static off_t qio_channel_file_seek(QIOChannel *ioc,
>                                     off_t offset,
> -- 
> 2.35.3
> 

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


