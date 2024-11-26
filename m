Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 613A0D3B9AC
	for <qemu-devel@archiver.kernel.org>; Tue, 26 Nov 2024 16:26:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tFyO7-0004Bc-3d; Tue, 26 Nov 2024 11:26:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1tFyNz-00047m-Ns
 for qemu-devel@nongnu.org; Tue, 26 Nov 2024 11:26:00 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1tFyNy-0003RY-0I
 for qemu-devel@nongnu.org; Tue, 26 Nov 2024 11:25:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1732638356;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=0CZ3fPtLp4BLa1ycRZfCYLKPMiOOPu/JKlHEx6fkj6k=;
 b=fZx1EofkFw4nG9IeMj5A7TN4uh6tho+xrrtWdQ8v44jHAg2cgkk/XdibBi/1iI/Tk3TbVM
 Z5MDswULtqU9fqll7gZvGZ7eiFScCcAKNQ+t++N1usCy/Jv5i0kU7QiLVa99CO5go/s7eN
 tDp5rPFExV4KDhw00hDu3jHMJzG6YSA=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-271-_k0xzsbRNWy80R8prJNyDg-1; Tue, 26 Nov 2024 11:25:54 -0500
X-MC-Unique: _k0xzsbRNWy80R8prJNyDg-1
X-Mimecast-MFC-AGG-ID: _k0xzsbRNWy80R8prJNyDg
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-3823d2f712fso3189462f8f.2
 for <qemu-devel@nongnu.org>; Tue, 26 Nov 2024 08:25:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732638350; x=1733243150;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0CZ3fPtLp4BLa1ycRZfCYLKPMiOOPu/JKlHEx6fkj6k=;
 b=Yzw/IX0ae8902dKsHc9RR6KRorD7DsoEfdsCZjK+FfcI0ngNprRHr3yXaBh2SsJJ6U
 MqzNK1tFKgQU8ZQNWbF4dK6q9hw2o0HTXeVTw7IVSd7lvBvI7e1x5SPoBN+8fvPHYLLy
 IOY+qbrMVAF0NJQCwbVKWYMjFNv/C/MML4pKuooNiRLoFcMF91qPby0TehdHi28iLvoL
 XZiNnhMYWfm0jIYpsbWWKC1aq4TBTjd45XUAlNolP8x1N49CDF2NoMeUbxLg2urK8H3d
 y/VOqH/V+Y9tjLtoqZN55ULhveLyo+BeMw2g2Rr52oD2OMTXE7cvN8gYBNd/DGq0/vk3
 Lztw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVRrkrVDX9brgofcSfKQgVRO8QEAmZruzO9v5z4I8qu8U00iPFdxjBygIx8+KEUDfXgXh3SH9b1mbz5@nongnu.org
X-Gm-Message-State: AOJu0Yw3EPxb6dJbtwAmIHjSXY0sLsLCyjSnzjsKcPgTV7yBasDl5N+B
 Wc/RQTd3EjLKuOwVXsypqqK7kwXCF52xLR0RGudk0jDC3NQN3Mabs9vIdV6xIpqT4vJyVZ7RHvl
 uq85jlHuQbJM+hAQL1/mEKhYHGZ87CSTs91TeEcA52VzRWsHJdfRG
X-Gm-Gg: ASbGncv4iUZbUl0toV/Kz7FGQntdDITEhnGY9QD92tkPp9CAwtUmSJNSuDHCzk12RlA
 Nrn56nfTPSnVVjdFRK6bmOOHw7tRgtgY1DbhgfG8T2x9WLvhAjYOZiqW+oHePo8+7KMUHnRf1sk
 yKskZ2ZfDRBwkJ90FB77tVbVtKjaWhhQs7wGhT7CAQph9bzIUsDP0U6FNNT9Ch+TIRFCMoZ7mFN
 waQqcGQjtylqV9b4usIharBBFcQwGk3y1oAmr5UkonRUs80MC2htdE4FhdeCFh7inuMBStN6l4I
 Kf16VO/okREv
X-Received: by 2002:a05:6000:4813:b0:382:134d:65e0 with SMTP id
 ffacd0b85a97d-38260be5f63mr16275846f8f.56.1732638350388; 
 Tue, 26 Nov 2024 08:25:50 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGbZJswEeBssspTyECs45i/745Wk1QAOr4nX1t+Jcov/2cBvTpG7cO1h96QilDBpRErm0KRcQ==
X-Received: by 2002:a05:6000:4813:b0:382:134d:65e0 with SMTP id
 ffacd0b85a97d-38260be5f63mr16275816f8f.56.1732638350002; 
 Tue, 26 Nov 2024 08:25:50 -0800 (PST)
Received: from ?IPV6:2a01:e0a:280:24f0:9db0:474c:ff43:9f5c?
 ([2a01:e0a:280:24f0:9db0:474c:ff43:9f5c])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3825fbedad6sm13659277f8f.91.2024.11.26.08.25.48
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 26 Nov 2024 08:25:49 -0800 (PST)
Message-ID: <114ef1d5-8e3c-4bb4-abf1-47433299f88f@redhat.com>
Date: Tue, 26 Nov 2024 17:25:47 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 02/24] thread-pool: Remove thread_pool_submit() function
To: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>,
 Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>
Cc: Alex Williamson <alex.williamson@redhat.com>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Avihai Horon <avihaih@nvidia.com>, Joao Martins <joao.m.martins@oracle.com>,
 qemu-devel@nongnu.org
References: <cover.1731773021.git.maciej.szmigiero@oracle.com>
 <dc48aed87cb7d22d01996d948adf3eef4dd25240.1731773021.git.maciej.szmigiero@oracle.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <dc48aed87cb7d22d01996d948adf3eef4dd25240.1731773021.git.maciej.szmigiero@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -29
X-Spam_score: -3.0
X-Spam_bar: ---
X-Spam_report: (-3.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.931,
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

On 11/17/24 20:19, Maciej S. Szmigiero wrote:
> From: "Maciej S. Szmigiero" <maciej.szmigiero@oracle.com>
> 
> This function name conflicts with one used by a future generic thread pool
> function and it was only used by one test anyway.
> 
> Update the trace event name in thread_pool_submit_aio() accordingly.
> 
> Signed-off-by: Maciej S. Szmigiero <maciej.szmigiero@oracle.com>


Reviewed-by: Cédric Le Goater <clg@redhat.com>

Thanks,

C.


> ---
>   include/block/thread-pool.h   | 3 +--
>   tests/unit/test-thread-pool.c | 2 +-
>   util/thread-pool.c            | 7 +------
>   util/trace-events             | 2 +-
>   4 files changed, 4 insertions(+), 10 deletions(-)
> 
> diff --git a/include/block/thread-pool.h b/include/block/thread-pool.h
> index 948ff5f30c31..4f6694026123 100644
> --- a/include/block/thread-pool.h
> +++ b/include/block/thread-pool.h
> @@ -30,13 +30,12 @@ ThreadPool *thread_pool_new(struct AioContext *ctx);
>   void thread_pool_free(ThreadPool *pool);
>   
>   /*
> - * thread_pool_submit* API: submit I/O requests in the thread's
> + * thread_pool_submit_{aio,co} API: submit I/O requests in the thread's
>    * current AioContext.
>    */
>   BlockAIOCB *thread_pool_submit_aio(ThreadPoolFunc *func, void *arg,
>                                      BlockCompletionFunc *cb, void *opaque);
>   int coroutine_fn thread_pool_submit_co(ThreadPoolFunc *func, void *arg);
> -void thread_pool_submit(ThreadPoolFunc *func, void *arg);
>   
>   void thread_pool_update_params(ThreadPool *pool, struct AioContext *ctx);
>   
> diff --git a/tests/unit/test-thread-pool.c b/tests/unit/test-thread-pool.c
> index 1483e53473db..7a7055141ddb 100644
> --- a/tests/unit/test-thread-pool.c
> +++ b/tests/unit/test-thread-pool.c
> @@ -46,7 +46,7 @@ static void done_cb(void *opaque, int ret)
>   static void test_submit(void)
>   {
>       WorkerTestData data = { .n = 0 };
> -    thread_pool_submit(worker_cb, &data);
> +    thread_pool_submit_aio(worker_cb, &data, NULL, NULL);
>       while (data.n == 0) {
>           aio_poll(ctx, true);
>       }
> diff --git a/util/thread-pool.c b/util/thread-pool.c
> index 27eb777e855b..2f751d55b33f 100644
> --- a/util/thread-pool.c
> +++ b/util/thread-pool.c
> @@ -256,7 +256,7 @@ BlockAIOCB *thread_pool_submit_aio(ThreadPoolFunc *func, void *arg,
>   
>       QLIST_INSERT_HEAD(&pool->head, req, all);
>   
> -    trace_thread_pool_submit(pool, req, arg);
> +    trace_thread_pool_submit_aio(pool, req, arg);
>   
>       qemu_mutex_lock(&pool->lock);
>       if (pool->idle_threads == 0 && pool->cur_threads < pool->max_threads) {
> @@ -290,11 +290,6 @@ int coroutine_fn thread_pool_submit_co(ThreadPoolFunc *func, void *arg)
>       return tpc.ret;
>   }
>   
> -void thread_pool_submit(ThreadPoolFunc *func, void *arg)
> -{
> -    thread_pool_submit_aio(func, arg, NULL, NULL);
> -}
> -
>   void thread_pool_update_params(ThreadPool *pool, AioContext *ctx)
>   {
>       qemu_mutex_lock(&pool->lock);
> diff --git a/util/trace-events b/util/trace-events
> index 49a4962e1886..5be12d7fab89 100644
> --- a/util/trace-events
> +++ b/util/trace-events
> @@ -14,7 +14,7 @@ aio_co_schedule_bh_cb(void *ctx, void *co) "ctx %p co %p"
>   reentrant_aio(void *ctx, const char *name) "ctx %p name %s"
>   
>   # thread-pool.c
> -thread_pool_submit(void *pool, void *req, void *opaque) "pool %p req %p opaque %p"
> +thread_pool_submit_aio(void *pool, void *req, void *opaque) "pool %p req %p opaque %p"
>   thread_pool_complete(void *pool, void *req, void *opaque, int ret) "pool %p req %p opaque %p ret %d"
>   thread_pool_cancel(void *req, void *opaque) "req %p opaque %p"
>   
> 


