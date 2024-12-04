Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59FA3E7716D
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Dec 2024 19:26:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tIuzo-0000Ye-GZ; Wed, 04 Dec 2024 14:25:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tIuzm-0000XI-Ev
 for qemu-devel@nongnu.org; Wed, 04 Dec 2024 14:25:10 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tIuzk-0002S2-KY
 for qemu-devel@nongnu.org; Wed, 04 Dec 2024 14:25:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1733340306;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=S/yuftUsdgguPdL9SAtF8bT0M9RHzEwhpTZQD6JdTEE=;
 b=OXKXQnleH6KQnII2C/rX1zIqgahtCg+bA8/6gXquEqvQiCdjeIwgTzHHy+3DdpNbhtGqzD
 qFH3Z5Ce9baKY98PQVdvVmf5lLsuraSroHssokN0J7Prp2KDeCXYODXiSjkblH3bBv48/8
 izN4wU1ec0LossQK9OSBRtEm3FokBdM=
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com
 [209.85.166.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-94-2MB1E1WGMXSwZ2-V3rpfEA-1; Wed, 04 Dec 2024 14:25:04 -0500
X-MC-Unique: 2MB1E1WGMXSwZ2-V3rpfEA-1
X-Mimecast-MFC-AGG-ID: 2MB1E1WGMXSwZ2-V3rpfEA
Received: by mail-io1-f70.google.com with SMTP id
 ca18e2360f4ac-8418f68672eso4522339f.3
 for <qemu-devel@nongnu.org>; Wed, 04 Dec 2024 11:25:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733340303; x=1733945103;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=S/yuftUsdgguPdL9SAtF8bT0M9RHzEwhpTZQD6JdTEE=;
 b=N5GE+Q/JBSspT1Ev609eQGdCj0cPAIxHyK80JvfDRFkbx3upB5JYA+HvzIWfSVrYF4
 igjT/ZGfe1ik7VgOpZIhQosPyCRSn7DMSoqZsGjBMPsCFOn4kZV4ZjBwUQOnKtVsuLwV
 ktGrBiY7oSpd1ARwUVGouehQzBfOkRo+gonTM6rJzxNCHfzREg+3N/p7dxWE3vgc9GFj
 WsjMMfLXbEVxizW35PpBhqJYAZGv0mWpt8VAMb+4Vv/9GGP84nEEjrPUXdp4OCs/LPwU
 u9PiOXkZnp4aj6GJzaz+BRfA2O8iU2ZiH2l4XreJpZa1ne2g0boxX3gpV0QWateG+dB6
 vQsQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWATfFqllNM6QK/Ndxyu4tBXlij4myuplddF+1RN9Cwre13wClPttwmy91ODIkw4b9dd0UsLvkLHoIL@nongnu.org
X-Gm-Message-State: AOJu0YxDly7eoPhC/CiiGYqYYBY9gJhvooIxMggIApjLHnG4VUOJwjm7
 9nrOe/ThYyEG09m9kbE92Z9hzTtKQnDpOnKcGSHTMgV6HKZJOj85gU0MAmP28FXvKvnXVRLvdvx
 7lvZ+YET9MS27r8cvpiqy9vJ5XXthiqOXyWpeCrDEC0BJ5eNoKH+Z
X-Gm-Gg: ASbGnctqvRjbLX6lC7Kl1frTHZxvcmSzDvs/lKbZXwDnBHMgE1w0++0tlyGds+QdIj1
 DtIw9X2iJ/J97zkOpJU8yd7EseRMrOyIxkdsoJRwQllsWyMZCIFI2GtU0Mk6eBmpkpnnAjWS7bI
 /bzh3VRPsVGR5/W5TpN8QKf212s1B7LAMdVyDc7O5pWFNNU/lSf64RpuQtxunkHnmq6+EQojN8w
 xbj8X1wo1AnWhTt+Wy2fHXT9qCC75lJPFa+7AE/HNxlTAKfqWF3WNJkGauYSmgfK5dOs+U6Tjzn
 7NJJ3UhTXJU=
X-Received: by 2002:a05:6602:29c2:b0:83d:e5e8:6fcd with SMTP id
 ca18e2360f4ac-8445b6dc3camr1026163639f.15.1733340302972; 
 Wed, 04 Dec 2024 11:25:02 -0800 (PST)
X-Google-Smtp-Source: AGHT+IERuyiW1/CttmRDHumgdw6z80yoG8HoGKvJumhoIWiNFthecq1QmNyBWTsu22+Xr+wAINeiXQ==
X-Received: by 2002:a05:6602:29c2:b0:83d:e5e8:6fcd with SMTP id
 ca18e2360f4ac-8445b6dc3camr1026160839f.15.1733340302639; 
 Wed, 04 Dec 2024 11:25:02 -0800 (PST)
Received: from x1n (pool-99-254-114-190.cpe.net.cable.rogers.com.
 [99.254.114.190]) by smtp.gmail.com with ESMTPSA id
 ca18e2360f4ac-84405ec8613sm323665139f.11.2024.12.04.11.25.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Dec 2024 11:25:01 -0800 (PST)
Date: Wed, 4 Dec 2024 14:24:59 -0500
From: Peter Xu <peterx@redhat.com>
To: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
Cc: Fabiano Rosas <farosas@suse.de>,
 Alex Williamson <alex.williamson@redhat.com>,
 =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@redhat.com>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Daniel P =?utf-8?B?LiBCZXJyYW5nw6k=?= <berrange@redhat.com>,
 Avihai Horon <avihaih@nvidia.com>,
 Joao Martins <joao.m.martins@oracle.com>, qemu-devel@nongnu.org
Subject: Re: [PATCH v3 02/24] thread-pool: Remove thread_pool_submit() function
Message-ID: <Z1Csi3bM2KYflTax@x1n>
References: <cover.1731773021.git.maciej.szmigiero@oracle.com>
 <dc48aed87cb7d22d01996d948adf3eef4dd25240.1731773021.git.maciej.szmigiero@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <dc48aed87cb7d22d01996d948adf3eef4dd25240.1731773021.git.maciej.szmigiero@oracle.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -50
X-Spam_score: -5.1
X-Spam_bar: -----
X-Spam_report: (-5.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.999,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

On Sun, Nov 17, 2024 at 08:19:57PM +0100, Maciej S. Szmigiero wrote:
> From: "Maciej S. Szmigiero" <maciej.szmigiero@oracle.com>
> 
> This function name conflicts with one used by a future generic thread pool
> function and it was only used by one test anyway.
> 
> Update the trace event name in thread_pool_submit_aio() accordingly.
> 
> Signed-off-by: Maciej S. Szmigiero <maciej.szmigiero@oracle.com>

Reviewed-by: Peter Xu <peterx@redhat.com>

One nitpick:

> ---
>  include/block/thread-pool.h   | 3 +--
>  tests/unit/test-thread-pool.c | 2 +-
>  util/thread-pool.c            | 7 +------
>  util/trace-events             | 2 +-
>  4 files changed, 4 insertions(+), 10 deletions(-)
> 
> diff --git a/include/block/thread-pool.h b/include/block/thread-pool.h
> index 948ff5f30c31..4f6694026123 100644
> --- a/include/block/thread-pool.h
> +++ b/include/block/thread-pool.h
> @@ -30,13 +30,12 @@ ThreadPool *thread_pool_new(struct AioContext *ctx);
>  void thread_pool_free(ThreadPool *pool);
>  
>  /*
> - * thread_pool_submit* API: submit I/O requests in the thread's
> + * thread_pool_submit_{aio,co} API: submit I/O requests in the thread's
>   * current AioContext.
>   */
>  BlockAIOCB *thread_pool_submit_aio(ThreadPoolFunc *func, void *arg,
>                                     BlockCompletionFunc *cb, void *opaque);
>  int coroutine_fn thread_pool_submit_co(ThreadPoolFunc *func, void *arg);
> -void thread_pool_submit(ThreadPoolFunc *func, void *arg);
>  
>  void thread_pool_update_params(ThreadPool *pool, struct AioContext *ctx);
>  
> diff --git a/tests/unit/test-thread-pool.c b/tests/unit/test-thread-pool.c
> index 1483e53473db..7a7055141ddb 100644
> --- a/tests/unit/test-thread-pool.c
> +++ b/tests/unit/test-thread-pool.c
> @@ -46,7 +46,7 @@ static void done_cb(void *opaque, int ret)
>  static void test_submit(void)

The test name was still trying to follow the name of API.  It can be
renamed to test_submit_no_complete() (also the test name str below).

>  {
>      WorkerTestData data = { .n = 0 };
> -    thread_pool_submit(worker_cb, &data);
> +    thread_pool_submit_aio(worker_cb, &data, NULL, NULL);
>      while (data.n == 0) {
>          aio_poll(ctx, true);
>      }
> diff --git a/util/thread-pool.c b/util/thread-pool.c
> index 27eb777e855b..2f751d55b33f 100644
> --- a/util/thread-pool.c
> +++ b/util/thread-pool.c
> @@ -256,7 +256,7 @@ BlockAIOCB *thread_pool_submit_aio(ThreadPoolFunc *func, void *arg,
>  
>      QLIST_INSERT_HEAD(&pool->head, req, all);
>  
> -    trace_thread_pool_submit(pool, req, arg);
> +    trace_thread_pool_submit_aio(pool, req, arg);
>  
>      qemu_mutex_lock(&pool->lock);
>      if (pool->idle_threads == 0 && pool->cur_threads < pool->max_threads) {
> @@ -290,11 +290,6 @@ int coroutine_fn thread_pool_submit_co(ThreadPoolFunc *func, void *arg)
>      return tpc.ret;
>  }
>  
> -void thread_pool_submit(ThreadPoolFunc *func, void *arg)
> -{
> -    thread_pool_submit_aio(func, arg, NULL, NULL);
> -}
> -
>  void thread_pool_update_params(ThreadPool *pool, AioContext *ctx)
>  {
>      qemu_mutex_lock(&pool->lock);
> diff --git a/util/trace-events b/util/trace-events
> index 49a4962e1886..5be12d7fab89 100644
> --- a/util/trace-events
> +++ b/util/trace-events
> @@ -14,7 +14,7 @@ aio_co_schedule_bh_cb(void *ctx, void *co) "ctx %p co %p"
>  reentrant_aio(void *ctx, const char *name) "ctx %p name %s"
>  
>  # thread-pool.c
> -thread_pool_submit(void *pool, void *req, void *opaque) "pool %p req %p opaque %p"
> +thread_pool_submit_aio(void *pool, void *req, void *opaque) "pool %p req %p opaque %p"
>  thread_pool_complete(void *pool, void *req, void *opaque, int ret) "pool %p req %p opaque %p ret %d"
>  thread_pool_cancel(void *req, void *opaque) "req %p opaque %p"
>  
> 

-- 
Peter Xu


