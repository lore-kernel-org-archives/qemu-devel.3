Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6CFCECCD199
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Oct 2025 13:01:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v9NaU-0007vl-DB; Thu, 16 Oct 2025 09:00:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1v9NaR-0007vC-Tf
 for qemu-devel@nongnu.org; Thu, 16 Oct 2025 09:00:07 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1v9NaM-0005Vi-RD
 for qemu-devel@nongnu.org; Thu, 16 Oct 2025 09:00:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1760619593;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=89D+Y4HDeAT2I8IIMHhuMGNESt9dWXv9OPPMwWqnqiY=;
 b=GimamzHv6gW7vnGXDO1wOaV83uE4O2JUFoK3COnwlciE+z/LBtYeWEKCVMx2NqnWJXJzve
 bcI+/S+xHBE38KnAIirdMv7NO5AxffrTddHm+f6CdNpI81p2yuxtr6jTSkIEk9n+v8/i1A
 +supxCxQchfOxj/doNPHd0Wa0AgaAbM=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-582-trvziNQhOB2FOGKXQVH7iw-1; Thu, 16 Oct 2025 08:59:51 -0400
X-MC-Unique: trvziNQhOB2FOGKXQVH7iw-1
X-Mimecast-MFC-AGG-ID: trvziNQhOB2FOGKXQVH7iw_1760619591
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-47111dc7bdbso7627565e9.0
 for <qemu-devel@nongnu.org>; Thu, 16 Oct 2025 05:59:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760619591; x=1761224391;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=89D+Y4HDeAT2I8IIMHhuMGNESt9dWXv9OPPMwWqnqiY=;
 b=M90ZK9gWrQ6FXdp/oK+C11YPytPTKWVt2QvvDxVdCiFhVUME0CsxbI/Wx3IWiYYdLM
 ATFTQpjKPsyRbd5AQ8wtGj2KAWlEv1yc5+Zzl/9b7ChTvyacN/kNvvdUvWdR4RxbOHMJ
 pqRl6Dng/Ptm82kwgr2YZOs19KGplxdyhYFkUGfu3w+Lm8pPbbHXNbsHV/kd72cor/OD
 7mX5h2dgQHNOEr/otVL9772C4jb8xLuZEU4JS2D+RSBJ+/42XXol9nGajEMjB/7pXkDD
 I4cjwOYesW4eRQ2RUQToybkY0C6Y/N//nGBcBf82tLjFhoX00aCmdGit7TIxGxUJFkuc
 6aAw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWhyZwnvZxpveewF8UUqVEvxd5LpUIuyrUghW5KW3vyngBnKwi+73gweMzD3ISIW/sGWVj3jWAKEzgW@nongnu.org
X-Gm-Message-State: AOJu0YwlvJwEMIhE+iCqlUZGZk5JzYNTORD0aJVWhjHUs7CqyxNGECVe
 0GAWJyKuaKgv32JpLHt+0sxrKx1K3JCVY4HVpExgM0snsyE0u5//yfreakJulWqvEb7YK3NUfjr
 vvUIHjL7zwskL34KpHpgwZW03Kp2C+l9F+f9sdN1sytwmkcDfzmCZaI0s
X-Gm-Gg: ASbGncs3lV/mrPjnzOtsjNRmrQExGFmkdKTx8s/KwnvcxP5Wz95G1AxSVIIa4IBgjHN
 EkhjJI47WGZ7qDdMFkidGYelnppQAI76/j/z28dZaJup2QAbcDcMYX1ETG/d4PvDrGqZw+kSIqi
 WxRHva0XLL85BcC0tY1Q4aFe7B9wLnXGICHbxtN4fVyjH4gUsgnu4j4gEaCRN+Ypfi6bjnj0Ead
 aIXW0S4z3Ypp9O/a6rgXsJibzApxjR69BTpLiQW0UbC8bQ2QQoxo6h8K2cbPEJ2bO0AsNFOmLrg
 5WA0/1S9tQ5ApckwoMxyXEs89+P2A9khJKJch327UzgUEkLD3gmZrVOdhCgKR6/qDcZMFZVXYqb
 wPz5ljhQBe2h2ajVucP9sLzM6IU9FcWWqAhC9W4m4uwiogBn0POIk1a8B1q22AheaD5K9AtVya+
 k=
X-Received: by 2002:a05:600c:4ed4:b0:45d:f88f:9304 with SMTP id
 5b1f17b1804b1-46fa9b0e7b3mr225469575e9.30.1760619590548; 
 Thu, 16 Oct 2025 05:59:50 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFLREg/Uo5O/Pt1QhG3tXH+sA69rayPRcCLp6yW0Zux8YmUiv+JEup4P67TXaB6EMS8Et+O1g==
X-Received: by 2002:a05:600c:4ed4:b0:45d:f88f:9304 with SMTP id
 5b1f17b1804b1-46fa9b0e7b3mr225469265e9.30.1760619590010; 
 Thu, 16 Oct 2025 05:59:50 -0700 (PDT)
Received: from [192.168.1.84] ([93.56.170.18])
 by smtp.googlemail.com with ESMTPSA id
 5b1f17b1804b1-4711442d6c6sm24933055e9.6.2025.10.16.05.59.49
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 16 Oct 2025 05:59:49 -0700 (PDT)
Message-ID: <e0e263c3-980c-47ed-9a93-048de6e47e8b@redhat.com>
Date: Thu, 16 Oct 2025 14:59:48 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] rcu: Unify force quiescent state
To: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>, qemu-devel@nongnu.org
Cc: David Hildenbrand <david@redhat.com>, Eric Blake <eblake@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Dmitry Osipenko <dmitry.osipenko@collabora.com>,
 Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Peter Xu <peterx@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>
References: <20251016-force-v1-1-919a82112498@rsg.ci.i.u-tokyo.ac.jp>
From: Paolo Bonzini <pbonzini@redhat.com>
Content-Language: en-US
Autocrypt: addr=pbonzini@redhat.com; keydata=
 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
In-Reply-To: <20251016-force-v1-1-919a82112498@rsg.ci.i.u-tokyo.ac.jp>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 10/16/25 08:34, Akihiko Odaki wrote:
> Borrow the concept of force quiescent state from Linux to ensure readers
> remain fast during normal operation and to avoid stalls.

Very nice solution!  The code of the call RCU thread is simpler.  I will 
follow up with extracting

             node = try_dequeue();
             while (!node) {
                 bql_unlock();
                 qemu_event_reset(&rcu_call_ready_event);
                 node = try_dequeue();
                 if (!node) {
                     qemu_event_wait(&rcu_call_ready_event);
                     node = try_dequeue();
                 }
                 bql_lock();
             }


to its own function dequeue().

Paolo

> Background
> ==========
> 
> The previous implementation had four steps to begin reclamation.
> 
> 1. call_rcu_thread() would wait for the first callback.
> 
> 2. call_rcu_thread() would periodically poll until a decent number of
>     callbacks piled up or it timed out.
> 
> 3. synchronize_rcu() would statr a grace period (GP).
> 
> 4. wait_for_readers() would wait for the GP to end. It would also
>     trigger the force_rcu notifier to break busy loops in a read-side
>     critical section if drain_call_rcu() had been called.
> 
> Problem
> =======
> 
> The separation of waiting logic across these steps led to suboptimal
> behavior:
> 
> The GP was delayed until call_rcu_thread() stops polling.
> 
> force_rcu was not consistently triggered when call_rcu_thread() detected
> a high number of pending callbacks or a timeout. This inconsistency
> sometimes led to stalls, as reported in a virtio-gpu issue where memory
> unmapping was blocked[1].
> 
> wait_for_readers() imposed unnecessary overhead in non-urgent cases by
> unconditionally executing qatomic_set(&index->waiting, true) and
> qemu_event_reset(&rcu_gp_event), which are necessary only for expedited
> synchronization.
> 
> Solution
> ========
> 
> Move the polling in call_rcu_thread() to wait_for_readers() to prevent
> the delay of the GP. Additionally, reorganize wait_for_readers() to
> distinguish between two states:
> 
> Normal State: it relies exclusively on periodic polling to detect
> the end of the GP and maintains the read-side fast path.
> 
> Force Quiescent State: Whenever expediting synchronization, it always
> triggers force_rcu and executes both qatomic_set(&index->waiting, true)
> and qemu_event_reset(&rcu_gp_event). This avoids stalls while confining
> the read-side overhead to this state.
> 
> This unified approach, inspired by the Linux RCU, ensures consistent and
> efficient RCU grace period handling and confirms resolution of the
> virtio-gpu issue.
> 
> [1] https://lore.kernel.org/qemu-devel/20251014111234.3190346-9-alex.bennee@linaro.org/
> 
> Signed-off-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
> ---
>   util/rcu.c | 79 ++++++++++++++++++++++++++++++++++++++++----------------------
>   1 file changed, 51 insertions(+), 28 deletions(-)
> 
> diff --git a/util/rcu.c b/util/rcu.c
> index b703c86f15a3..acac9446ea98 100644
> --- a/util/rcu.c
> +++ b/util/rcu.c
> @@ -43,10 +43,14 @@
>   #define RCU_GP_LOCKED           (1UL << 0)
>   #define RCU_GP_CTR              (1UL << 1)
>   
> +
> +#define RCU_CALL_MIN_SIZE        30
> +
>   unsigned long rcu_gp_ctr = RCU_GP_LOCKED;
>   
>   QemuEvent rcu_gp_event;
>   static int in_drain_call_rcu;
> +static int rcu_call_count;
>   static QemuMutex rcu_registry_lock;
>   static QemuMutex rcu_sync_lock;
>   
> @@ -76,15 +80,29 @@ static void wait_for_readers(void)
>   {
>       ThreadList qsreaders = QLIST_HEAD_INITIALIZER(qsreaders);
>       struct rcu_reader_data *index, *tmp;
> +    int sleeps = 0;
> +    bool forced = false;
>   
>       for (;;) {
> -        /* We want to be notified of changes made to rcu_gp_ongoing
> -         * while we walk the list.
> +        /*
> +         * Force the grace period to end and wait for it if any of the
> +         * following heuristical conditions are satisfied:
> +         * - A decent number of callbacks piled up.
> +         * - It timed out.
> +         * - It is in a drain_call_rcu() call.
> +         *
> +         * Otherwise, periodically poll the grace period, hoping it ends
> +         * promptly.
>            */
> -        qemu_event_reset(&rcu_gp_event);
> +        if (!forced &&
> +            (qatomic_read(&rcu_call_count) >= RCU_CALL_MIN_SIZE ||
> +             sleeps >= 5 || qatomic_read(&in_drain_call_rcu))) {
> +            forced = true;
>   
> -        QLIST_FOREACH(index, &registry, node) {
> -            qatomic_set(&index->waiting, true);
> +            QLIST_FOREACH(index, &registry, node) {
> +                notifier_list_notify(&index->force_rcu, NULL);
> +                qatomic_set(&index->waiting, true);
> +            }
>           }
>   
>           /* Here, order the stores to index->waiting before the loads of
> @@ -106,8 +124,6 @@ static void wait_for_readers(void)
>                    * get some extra futex wakeups.
>                    */
>                   qatomic_set(&index->waiting, false);
> -            } else if (qatomic_read(&in_drain_call_rcu)) {
> -                notifier_list_notify(&index->force_rcu, NULL);
>               }
>           }
>   
> @@ -115,7 +131,8 @@ static void wait_for_readers(void)
>               break;
>           }
>   
> -        /* Wait for one thread to report a quiescent state and try again.
> +        /*
> +         * Sleep for a while and try again.
>            * Release rcu_registry_lock, so rcu_(un)register_thread() doesn't
>            * wait too much time.
>            *
> @@ -133,7 +150,20 @@ static void wait_for_readers(void)
>            * rcu_registry_lock is released.
>            */
>           qemu_mutex_unlock(&rcu_registry_lock);
> -        qemu_event_wait(&rcu_gp_event);
> +
> +        if (forced) {
> +            qemu_event_wait(&rcu_gp_event);
> +
> +            /*
> +             * We want to be notified of changes made to rcu_gp_ongoing
> +             * while we walk the list.
> +             */
> +            qemu_event_reset(&rcu_gp_event);
> +        } else {
> +            g_usleep(10000);
> +            sleeps++;
> +        }
> +
>           qemu_mutex_lock(&rcu_registry_lock);
>       }
>   
> @@ -173,15 +203,11 @@ void synchronize_rcu(void)
>       }
>   }
>   
> -
> -#define RCU_CALL_MIN_SIZE        30
> -
>   /* Multi-producer, single-consumer queue based on urcu/static/wfqueue.h
>    * from liburcu.  Note that head is only used by the consumer.
>    */
>   static struct rcu_head dummy;
>   static struct rcu_head *head = &dummy, **tail = &dummy.next;
> -static int rcu_call_count;
>   static QemuEvent rcu_call_ready_event;
>   
>   static void enqueue(struct rcu_head *node)
> @@ -259,30 +285,27 @@ static void *call_rcu_thread(void *opaque)
>       rcu_register_thread();
>   
>       for (;;) {
> -        int tries = 0;
> -        int n = qatomic_read(&rcu_call_count);
> +        int n;
>   
> -        /* Heuristically wait for a decent number of callbacks to pile up.
> +        /*
>            * Fetch rcu_call_count now, we only must process elements that were
>            * added before synchronize_rcu() starts.
>            */
> -        while (n == 0 || (n < RCU_CALL_MIN_SIZE && ++tries <= 5)) {
> -            g_usleep(10000);
> -            if (n == 0) {
> -                qemu_event_reset(&rcu_call_ready_event);
> -                n = qatomic_read(&rcu_call_count);
> -                if (n == 0) {
> +        for (;;) {
> +            qemu_event_reset(&rcu_call_ready_event);
> +            n = qatomic_read(&rcu_call_count);
> +            if (n) {
> +                break;
> +            }
> +
>   #if defined(CONFIG_MALLOC_TRIM)
> -                    malloc_trim(4 * 1024 * 1024);
> +            malloc_trim(4 * 1024 * 1024);
>   #endif
> -                    qemu_event_wait(&rcu_call_ready_event);
> -                }
> -            }
> -            n = qatomic_read(&rcu_call_count);
> +            qemu_event_wait(&rcu_call_ready_event);
>           }
>   
> -        qatomic_sub(&rcu_call_count, n);
>           synchronize_rcu();
> +        qatomic_sub(&rcu_call_count, n);
>           bql_lock();
>           while (n > 0) {
>               node = try_dequeue();
> 
> ---
> base-commit: 0dc905ac306c68649e05cdaf8434123c8f917b41
> change-id: 20251015-force-c4e03a9ba719
> 
> Best regards,
> --
> Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
> 
> 
> 


