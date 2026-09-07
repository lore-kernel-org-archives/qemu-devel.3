Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47B55C79FA0
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Sep 2026 12:56:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x3YtH-0003th-Ki; Mon, 07 Sep 2026 08:56:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1x3YtF-0003tJ-IT
 for qemu-devel@nongnu.org; Mon, 07 Sep 2026 08:56:01 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1x3YtD-0004NK-8g
 for qemu-devel@nongnu.org; Mon, 07 Sep 2026 08:56:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1788785758;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=wddc8XwlGM+oZdxiX+VYasU1fgZeAgxR9RIMruWfvlA=;
 b=R+Fu4kBmx6oJ1YXwgmml9bbg2a/zaNX280CFSOlQSFe1AIhFspMkAIyHq9hGPMhPhL0T+p
 O22riCENte9AluEUlvoZV3qyaxTzHkkrrkTfyA8STu3jg1pm+pwTMxdfPy83D6oxxfphVw
 62hrSSrej11Ql/BnXJnl8cGFZByALfQ=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-390-kdBlPkU6NqmqoUxUt5KdOw-1; Mon,
 07 Sep 2026 08:55:55 -0400
X-MC-Unique: kdBlPkU6NqmqoUxUt5KdOw-1
X-Mimecast-MFC-AGG-ID: kdBlPkU6NqmqoUxUt5KdOw_1788785754
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 463A7182A124; Mon,  7 Sep 2026 12:55:54 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.44.22.5])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id DCA341956044; Mon,  7 Sep 2026 12:55:53 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 8002521E6A04; Mon, 07 Sep 2026 14:55:51 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Zhang Chen <zhangckid@gmail.com>
Cc: qemu-devel <qemu-devel@nongnu.org>,  Eric Blake <eblake@redhat.com>,
 "'Michael S . Tsirkin'" <mst@redhat.com>,  Stefan Hajnoczi
 <stefanha@redhat.com>,  Paolo Bonzini <pbonzini@redhat.com>,  'Daniel P .
 =?utf-8?Q?Berrang=C3=A9'?= <berrange@redhat.com>,  Jason Wang
 <jasowangio@gmail.com>
Subject: Re: [PATCH V15 13/14] iothread: make legacy AioContext getter
 explicitly unsafe
In-Reply-To: <20260907063725.626685-14-zhangckid@gmail.com> (Zhang Chen's
 message of "Mon, 7 Sep 2026 14:37:24 +0800")
References: <20260907063725.626685-1-zhangckid@gmail.com>
 <20260907063725.626685-14-zhangckid@gmail.com>
Date: Mon, 07 Sep 2026 14:55:51 +0200
Message-ID: <87zextw78o.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Zhang Chen <zhangckid@gmail.com> writes:

> Now that holder-aware callers have been converted, rename
> iothread_get_aio_context() to iothread_unsafe_get_aio_context() and
> update qmp_x_blockdev_set_iothread(). This avoids adding a duplicate
> accessor only to remove the old one later.

The last sentence appears to justify the change since v14.  If that's
the intent, drop it, please.  If not, what is the intent?

> The block graph retains only the AioContext, while detachment happens
> outside qmp_x_blockdev_set_iothread(), so this call site cannot provide
> a matching holder lifecycle. The new name makes its existing lifetime
> assumption explicit.

Suggest to start like "The only remaining user is
qmp_x_blockdev_set_iothread()" and then explain why this caller cannot
use iothread_ref_and_get_aio_context().

> New code should use iothread_ref_and_get_aio_context().
>
> Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
> Signed-off-by: Zhang Chen <zhangckid@gmail.com>
> ---
>  blockdev.c                |  7 ++++++-
>  include/system/iothread.h | 11 ++++++++++-
>  iothread.c                |  2 +-
>  3 files changed, 17 insertions(+), 3 deletions(-)
>
> diff --git a/blockdev.c b/blockdev.c
> index 6e86c6262f..97d161079a 100644
> --- a/blockdev.c
> +++ b/blockdev.c
> @@ -3683,7 +3683,12 @@ void qmp_x_blockdev_set_iothread(const char *node_name, StrOrNull *iothread,
>              goto out;
>          }
>  
> -        new_context = iothread_get_aio_context(obj);
> +        /*
> +         * The block graph retains only the AioContext, not the IOThread.
> +         * Context detachment happens outside this command, so there is no
> +         * point here where a matching IOThread holder can be released.
> +         */

This is fine for readers who already know what this is about: why we
can't use iothread_ref_and_get_aio_context() /
iothread_unsafe_get_aio_context() here.  Others will lack context.

Suggest to start like

           /*
            * We cannot use iothread_ref_and_get_aio_context() /
            * iothread_unref_and_put_aio_context() here.

then explain why.

> +        new_context = iothread_unsafe_get_aio_context(obj);
>      } else {
>          new_context = qemu_get_aio_context();
>      }

[...]


