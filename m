Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A54A7CC6B34
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Oct 2026 08:07:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xHGV4-0006o6-LU; Thu, 15 Oct 2026 04:07:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1xHGV2-0006md-SG
 for qemu-devel@nongnu.org; Thu, 15 Oct 2026 04:07:40 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1xHGV1-0005nA-5l
 for qemu-devel@nongnu.org; Thu, 15 Oct 2026 04:07:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1792051658;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=FPcAYo23CZWmPDf53wDrw3hldsjkt3mnBmeFTQf3FG0=;
 b=U3UEcD0N1iRwGdyPfpwJOyw/upfXqfr7R/M7R+y0EbYN3fXB1xaBG9SQ060a7iMMGkVeVp
 zus0ParF/stUTGJSEC5fQtchN0lwGjN/rDGDzGIBxItl7ZNcapM64NIjnfEKv9szW8/n3s
 P+d6Na7dYc8vPoQRJrKvpccAYBZ/v9M=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-435-gncjpXZTOc6k03QTKyrNyg-1; Thu,
 15 Oct 2026 08:07:36 +0000
X-MC-Unique: gncjpXZTOc6k03QTKyrNyg-1
X-Mimecast-MFC-AGG-ID: gncjpXZTOc6k03QTKyrNyg_1792051656
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id E1E6E1955F17; Thu, 15 Oct 2026 08:07:35 +0000 (UTC)
Received: from redhat.com (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 511171955F10; Thu, 15 Oct 2026 08:07:34 +0000 (UTC)
Date: Thu, 15 Oct 2026 09:07:30 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Filip Hejsek <filip.hejsek@gmail.com>
Cc: qemu-devel@nongnu.org,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH v2 2/2] io: report a warning when a file channel is
 created from a stdio fd
Message-ID: <atCJwox47RUEkD1I@redhat.com>
References: <20261015-fix-stdio-close-v2-0-0f01e6580e24@gmail.com>
 <20261015-fix-stdio-close-v2-2-0f01e6580e24@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20261015-fix-stdio-close-v2-2-0f01e6580e24@gmail.com>
User-Agent: Mutt/2.4.2 (2026-08-30)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 10
X-Spam_score: 1.0
X-Spam_bar: +
X-Spam_report: (1.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.24,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
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

On Thu, Oct 15, 2026 at 03:58:25AM +0200, Filip Hejsek wrote:
> A channel closes its fd when the last reference to it is dropped.
> Closing stdio fds is typically unwanted, so warn when they are passed to
> qio_channel_file_new_fd().
> 
> Signed-off-by: Filip Hejsek <filip.hejsek@gmail.com>
> ---
>  io/channel-file.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/io/channel-file.c b/io/channel-file.c
> index 5cef75a67c..4c9da6619b 100644
> --- a/io/channel-file.c
> +++ b/io/channel-file.c
> @@ -23,6 +23,7 @@
>  #include "io/channel-util.h"
>  #include "io/channel-watch.h"
>  #include "qapi/error.h"
> +#include "qemu/error-report.h"
>  #include "qemu/module.h"
>  #include "qemu/sockets.h"
>  #include "trace.h"
> @@ -32,6 +33,11 @@ qio_channel_file_new_fd(int fd)
>  {
>      QIOChannelFile *ioc;
>  
> +    if (fd <= STDERR_FILENO) {
> +        warn_report("potential bug: creating a channel from stdio fd %d; "
> +                    "the fd will be closed when the channel is destroyed", fd);
> +    }
> +
>      ioc = QIO_CHANNEL_FILE(object_new(TYPE_QIO_CHANNEL_FILE));
>  
>      ioc->fd = fd;

Can we also update the API docs for qio_channel_file_new_fd, to
say

   @fd must not point to stdin/stdout/stderr, since the FD
   will be closed by the channel on destruction. If requiring
   a channel to wrap stdio, use qio_channel_file_new_dupfd()
   instead.


With regards,
Daniel
-- 
|: https://berrange.com       ~~        https://hachyderm.io/@berrange :|
|: https://libvirt.org          ~~          https://entangle-photo.org :|
|: https://pixelfed.art/berrange   ~~    https://fstop138.berrange.com :|


