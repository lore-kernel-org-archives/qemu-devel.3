Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53971FF495E
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Mar 2026 13:43:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w7Ctr-0003DJ-9M; Mon, 30 Mar 2026 09:43:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1w7Ctp-0003C0-5b
 for qemu-devel@nongnu.org; Mon, 30 Mar 2026 09:43:25 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1w7Ctm-0002P2-JU
 for qemu-devel@nongnu.org; Mon, 30 Mar 2026 09:43:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1774878200;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=21ztP/JKNYyajacLTv2VZBb+x/ur9yFC74QVg7IQS08=;
 b=UI+tB5dslJq1wQw9YEKBqgOxefUuVdwSNXMljyngrh+MW90Gnmu/kKB+XXlrnlytBpk6TG
 WiVayrczwGh+KHD4G33AcQ8izO+9Qn+xxIZjv5NQ9tmifWdUn6kPzYiueJDEYyoEXhsJXf
 O5ooUGIew+FbEKrM+mY6UXgYCIzszEE=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-411-cZtcrZr2O42gSgdUZws1ew-1; Mon,
 30 Mar 2026 09:43:19 -0400
X-MC-Unique: cZtcrZr2O42gSgdUZws1ew-1
X-Mimecast-MFC-AGG-ID: cZtcrZr2O42gSgdUZws1ew_1774878197
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 06C1518002FD; Mon, 30 Mar 2026 13:43:17 +0000 (UTC)
Received: from redhat.com (unknown [10.44.36.79])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 44B6C180035F; Mon, 30 Mar 2026 13:43:15 +0000 (UTC)
Date: Mon, 30 Mar 2026 14:43:11 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Stepan Popov <Stepan.Popov@kaspersky.com>
Cc: qemu-devel@nongnu.org, qemu-trivial@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH] thread-pool: signal condition variable while holding lock
Message-ID: <acp97_c_brNSk7t4@redhat.com>
References: <20260330130104.85200-1-Stepan.Popov@kaspersky.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260330130104.85200-1-Stepan.Popov@kaspersky.com>
User-Agent: Mutt/2.2.14 (2025-02-20)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -5
X-Spam_score: -0.6
X-Spam_bar: /
X-Spam_report: (-0.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.54,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=1,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=1, SPF_HELO_PASS=-0.001,
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

On Mon, Mar 30, 2026 at 04:01:04PM +0300, Stepan Popov wrote:
> Move qemu_cond_signal() inside the critical section protected by pool->lock.
> Signaling while holding the lock imposes more predictable scheduling behavior.
> 
> Signed-off-by: Stepan Popov <Stepan.Popov@kaspersky.com>
> ---
>  util/thread-pool.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/util/thread-pool.c b/util/thread-pool.c
> index 8f8cb38d5c..8e55aefd07 100644
> --- a/util/thread-pool.c
> +++ b/util/thread-pool.c
> @@ -265,8 +265,8 @@ BlockAIOCB *thread_pool_submit_aio(ThreadPoolFunc *func, void *arg,
>          spawn_thread(pool);
>      }
>      QTAILQ_INSERT_TAIL(&pool->request_list, req, reqs);
> -    qemu_mutex_unlock(&pool->lock);
>      qemu_cond_signal(&pool->request_cond);
> +    qemu_mutex_unlock(&pool->lock);
>      return &req->common;
>  }

Doesn't this order mean that when the signal wakes up the waiting
thread, that thread will get temporarily re-blocked waiting for
'lock' to be released by the original thread too.

With regards,
Daniel
-- 
|: https://berrange.com       ~~        https://hachyderm.io/@berrange :|
|: https://libvirt.org          ~~          https://entangle-photo.org :|
|: https://pixelfed.art/berrange   ~~    https://fstop138.berrange.com :|


