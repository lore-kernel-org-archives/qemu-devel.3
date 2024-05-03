Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3945C4345F
	for <qemu-devel@archiver.kernel.org>; Fri,  3 May 2024 17:34:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s2wn4-0005vg-5I; Fri, 03 May 2024 13:33:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1s2wmu-0005eT-5y
 for qemu-devel@nongnu.org; Fri, 03 May 2024 13:33:39 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1s2wmr-0001DK-4j
 for qemu-devel@nongnu.org; Fri, 03 May 2024 13:33:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1714757611;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=TkSM51CJixVq+TBbF1NL3KayY8PN8r2+MeEAiNZPCUI=;
 b=ClLGh57EFBsdDxK2yog4XadVJVZ7iAAQf1+gdINafF5yr7ol4kRZJ1m6stH54yECALuTOG
 74takb4U0sK1Mw4LjyKOSa3B/hxbYHxJeI2EAzhCi7ZTyuHj5EVjO5PG2HTTaU6nYuYQIV
 X0B+2oddHl9ACohmWz7LLUvAoBkzw9s=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-190-vijmVxjLMCKAwtUUTpjVWQ-1; Fri, 03 May 2024 13:33:27 -0400
X-MC-Unique: vijmVxjLMCKAwtUUTpjVWQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com
 [10.11.54.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 85322801FAE;
 Fri,  3 May 2024 17:33:26 +0000 (UTC)
Received: from redhat.com (unknown [10.39.193.134])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 1F6DF1C0654E;
 Fri,  3 May 2024 17:33:23 +0000 (UTC)
Date: Fri, 3 May 2024 19:33:17 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: qemu-devel@nongnu.org, Michael Roth <michael.roth@amd.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>, qemu-block@nongnu.org,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Subject: Re: [PATCH v2 5/5] monitor: use aio_co_reschedule_self()
Message-ID: <ZjUf3TkiBO1N264C@redhat.com>
References: <20240206190610.107963-1-stefanha@redhat.com>
 <20240206190610.107963-6-stefanha@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240206190610.107963-6-stefanha@redhat.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.7
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.483,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Am 06.02.2024 um 20:06 hat Stefan Hajnoczi geschrieben:
> The aio_co_reschedule_self() API is designed to avoid the race
> condition between scheduling the coroutine in another AioContext and
> yielding.
> 
> The QMP dispatch code uses the open-coded version that appears
> susceptible to the race condition at first glance:
> 
>   aio_co_schedule(qemu_get_aio_context(), qemu_coroutine_self());
>   qemu_coroutine_yield();
> 
> The code is actually safe because the iohandler and qemu_aio_context
> AioContext run under the Big QEMU Lock. Nevertheless, set a good example
> and use aio_co_reschedule_self() so it's obvious that there is no race.
> 
> Suggested-by: Hanna Reitz <hreitz@redhat.com>
> Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
> Reviewed-by: Hanna Czenczek <hreitz@redhat.com>
> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> ---
>  qapi/qmp-dispatch.c | 7 ++-----
>  1 file changed, 2 insertions(+), 5 deletions(-)
> 
> diff --git a/qapi/qmp-dispatch.c b/qapi/qmp-dispatch.c
> index 176b549473..f3488afeef 100644
> --- a/qapi/qmp-dispatch.c
> +++ b/qapi/qmp-dispatch.c
> @@ -212,8 +212,7 @@ QDict *coroutine_mixed_fn qmp_dispatch(const QmpCommandList *cmds, QObject *requ
>               * executing the command handler so that it can make progress if it
>               * involves an AIO_WAIT_WHILE().
>               */
> -            aio_co_schedule(qemu_get_aio_context(), qemu_coroutine_self());
> -            qemu_coroutine_yield();
> +            aio_co_reschedule_self(qemu_get_aio_context());

Turns out that this one actually causes a regression. [1] This code is
ŕun in iohandler_ctx, aio_co_reschedule_self() looks at the new context
and compares it with qemu_get_current_aio_context() - and because both
are qemu_aio_context, it decides that it has nothing to do. So the
command handler coroutine actually still runs in iohandler_ctx now,
which is not what we want.

We could just revert this patch because it was only meant as a cleanup
without a semantic difference.

Or aio_co_reschedule_self() could look at qemu_coroutine_self()->ctx
instead of using qemu_get_current_aio_context(). That would be a little
more indirect, though, and I'm not sure if co->ctx is always up to date.

Any opinions on what is the best way to fix this?

Kevin

[1] https://issues.redhat.com/browse/RHEL-34618


