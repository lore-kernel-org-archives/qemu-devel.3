Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 079AFCCF9FE
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Nov 2025 14:00:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vFv6I-0007aB-HQ; Mon, 03 Nov 2025 09:00:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1vFv6G-0007Wa-5H
 for qemu-devel@nongnu.org; Mon, 03 Nov 2025 09:00:00 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1vFv68-0001OX-MV
 for qemu-devel@nongnu.org; Mon, 03 Nov 2025 08:59:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1762178385;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=CSfd1uvO9jc4LuFFZQWP6UcqKVsZ+Lz4TmRQ3Fk7qks=;
 b=coS0CzpYuHP1sx9RMHBbJQmjkyjgFsdB+isBV6lWsYtwyIuUrBx7HifnoozC4fYAy6qEfo
 vckKl40CG1ShzvBFTl6iRiY3X4OWQIb86HXTLiwTqpN/RyGtXvb8MrzP0nAWO1TXK1fQW9
 fdROF+SB49ToEQjKnNIq87lYK0TsTGU=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-515-EGXKrTOHN6Sy84kjW2dqtw-1; Mon, 03 Nov 2025 08:59:44 -0500
X-MC-Unique: EGXKrTOHN6Sy84kjW2dqtw-1
X-Mimecast-MFC-AGG-ID: EGXKrTOHN6Sy84kjW2dqtw_1762178383
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-426ce339084so3322531f8f.0
 for <qemu-devel@nongnu.org>; Mon, 03 Nov 2025 05:59:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1762178383; x=1762783183; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=CSfd1uvO9jc4LuFFZQWP6UcqKVsZ+Lz4TmRQ3Fk7qks=;
 b=GSLxr+267/FqEi0HtmY8tAq6itVcQae0X9rwKmUlEA7xC+fGvqrnUwr5xK9AC8TaH6
 tdwi+ZpWP4SwzGB6Rn6rkbskEafUknvD+eBbvwC+TCf5mbNV18n6hpmmzGPLBp7nbFQj
 6kmez69G5ehqFlGVRnm52H6cY+O45vR12Sifo4oDX7oTYMzwg7rvmq8lRbGClKHDnptV
 Ft8yLP6MPZ5lxl7mU+fUjVWP00MYFoYkdLUxnmZ6shFGm46wOFRIgcTbCTo6uUt0cBkR
 aJBuikarTWpGYM11kqqUNAw+z8V5/aNrZtuGs7NqrvPZq5vgwk8sFc2+RmskORjDJBdn
 6aKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762178383; x=1762783183;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CSfd1uvO9jc4LuFFZQWP6UcqKVsZ+Lz4TmRQ3Fk7qks=;
 b=hLgQCoK8mjp8YV5LJvCjD7us+TKb9BvjgEwJFdIlnzE7NnHfwpJ9LgqBFeXNhfVXBC
 KsIsNMu7Py0lsUYKA+WXLJfeYLDO8GxydmDkfB0Yes2YUvVGFB3ydQomdgemR95mBQ3C
 ddYCWVaOpTSlr0xk9aFfcwpLqJzifsDXjLFSx0OKPJ7RKLmM4AMS1G+sO1nGHCJDB3g7
 C2fbZz3q8+lmDZInHC63yGg1HP/hmsIbaVha20bzf8z8Fpeb5uAekyG3SJeYCTzkU/kP
 c/dZnaaW37D3Eei2qzXqpgWTv7gfQmNLmgvIgDuZWkPLjuWGsBQ/ejXFPJIBwjaaP8iM
 GMvQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUttaki46YQ0989Kh3INHrlJecEEF6kAeNLQauGNT58Xs/CO/kvEhj9bmq99jA4nAutb+GmaxPQEW4c@nongnu.org
X-Gm-Message-State: AOJu0YwD+2d4YDErtLuYO+QxiDzbxhpBvkdtx/mFH4A72/OaX9L7rEYk
 zzstHBqH/qk3j78t1WgvoYtuTGM44BxcTgIs3wCkcSRdS5lGEXVwUkX2mxib7uNDEWB/79NzwY0
 FvbBzzzpykIvjPgzuH0acXt/NphWjgSB+7McgdZ2ro7Wh6Wgqo+2E/omjN9Y9MpmK
X-Gm-Gg: ASbGnctz8qVtYmZjcy+xQm+KhggS6qo61oiPokuRJLmyYRipNMXKQgG/pV23CT70PXb
 rLKfCqCstD4whbui8O+ZvCctF+v4lLxl3NtUUbrdaf9VGvwddofb5uNb655tize4KxV0M4JX7wj
 TFmOjno8IVh76j1FzAOv1JFZG+meZ3JQdk140BATKk0y2YxITtIg9zoXPic+9JKv0JLGPRp7JI/
 C5BiR8dmorsZlBR7eJPG7tn9BSwWkfYpFQaKm+QvKnNmIBbK8xXJ5GuqJUTefILXXPXPGQXhC2X
 hnsltVjBKjTekltawtTqN6IE6yqdUoOhOWhyXYtbn1JGSk9AhSrI+WHI+DxCvNSGE+oUDH8=
X-Received: by 2002:a05:6000:310a:b0:429:bca4:6b44 with SMTP id
 ffacd0b85a97d-429bd675f82mr11468393f8f.13.1762178383189; 
 Mon, 03 Nov 2025 05:59:43 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE5xiaqTKARyYPjw4esGyXALMN9yo9ct2JAWkwcEvgubnuHUdgnB+akuJ+Bz3mo9smmrBJu8w==
X-Received: by 2002:a05:6000:310a:b0:429:bca4:6b44 with SMTP id
 ffacd0b85a97d-429bd675f82mr11468362f8f.13.1762178382665; 
 Mon, 03 Nov 2025 05:59:42 -0800 (PST)
Received: from [192.168.0.7] ([47.64.112.33]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-429c1142e7dsm20694926f8f.17.2025.11.03.05.59.41
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 03 Nov 2025 05:59:42 -0800 (PST)
Message-ID: <cb41dc20-5a87-42b6-8819-08f5a1ee4303@redhat.com>
Date: Mon, 3 Nov 2025 14:59:41 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Regression with the "replay" test on target alpha (was: [PULL 03/18]
 rcu: Unify force quiescent state)
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Cc: Dmitry Osipenko <dmitry.osipenko@collabora.com>,
 Richard Henderson <richard.henderson@linaro.org>
References: <20251028173430.2180057-1-pbonzini@redhat.com>
 <20251028173430.2180057-4-pbonzini@redhat.com>
Content-Language: en-US
From: Thomas Huth <thuth@redhat.com>
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <20251028173430.2180057-4-pbonzini@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
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

On 28/10/2025 18.34, Paolo Bonzini wrote:
> From: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
> 
> Borrow the concept of force quiescent state from Linux to ensure readers
> remain fast during normal operation and to avoid stalls.

  Hi Akihiko,

looks like this commit has introduced a regression with the "replay" 
functional test on the alpha target.
When I run something like:

  pyvenv/bin/meson test --no-rebuild -t 1 --setup thorough \
   --num-processes 1 --repeat 10 func-alpha-replay

in the build folder, approx. half of the test runs are failing for me now.

I bisected the issue to this patch here - when I rebuild qemu-system-alpha 
with the commit right before this change here, the above test runs work 
fine, so I'm pretty sure that the problem has been introduced by this commit 
here.

Could you please have a look?

  Thanks,
   Thomas


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
> Link: https://lore.kernel.org/r/20251016-force-v1-1-919a82112498@rsg.ci.i.u-tokyo.ac.jp
> Tested-by: Dmitry Osipenko <dmitry.osipenko@collabora.com>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>   util/rcu.c | 81 +++++++++++++++++++++++++++++++++++-------------------
>   1 file changed, 52 insertions(+), 29 deletions(-)
> 
> diff --git a/util/rcu.c b/util/rcu.c
> index b703c86f15a..acac9446ea9 100644
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
> -#if defined(CONFIG_MALLOC_TRIM)
> -                    malloc_trim(4 * 1024 * 1024);
> -#endif
> -                    qemu_event_wait(&rcu_call_ready_event);
> -                }
> -            }
> +        for (;;) {
> +            qemu_event_reset(&rcu_call_ready_event);
>               n = qatomic_read(&rcu_call_count);
> +            if (n) {
> +                break;
> +            }
> +
> +#if defined(CONFIG_MALLOC_TRIM)
> +            malloc_trim(4 * 1024 * 1024);
> +#endif
> +            qemu_event_wait(&rcu_call_ready_event);
>           }
>   
> -        qatomic_sub(&rcu_call_count, n);
>           synchronize_rcu();
> +        qatomic_sub(&rcu_call_count, n);
>           bql_lock();
>           while (n > 0) {
>               node = try_dequeue();


