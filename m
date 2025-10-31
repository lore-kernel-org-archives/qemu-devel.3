Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B3E4CCF9FF
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Oct 2025 09:30:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vElRt-0001yk-DN; Fri, 31 Oct 2025 05:29:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1vElRq-0001xg-Rl
 for qemu-devel@nongnu.org; Fri, 31 Oct 2025 05:29:30 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1vElRg-0003mU-Gn
 for qemu-devel@nongnu.org; Fri, 31 Oct 2025 05:29:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1761902954;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Ag5lI1UPkpi4D/CydEoNJdHOa5d1MaFHtmLdOB9/2po=;
 b=g4kiT5vtgqw8YRg+n9mzZXA3PJ2PKhKMYlkpqnTIfEnW8KVQOjYco2tfop4M/RoX1Qm8Dr
 F4Pdld7aiFUrBnPme1ALcjOdZ8Ofn7mNPA8gRYc+YZsYrDRM3WT0sAyugObVP7aeOjvkmX
 dSq7XwQ4u/OCJyfJ4ce5wI8SvoUtj+Y=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-690-VZ3YznT2OQ29l7EOgTZs0w-1; Fri, 31 Oct 2025 05:29:13 -0400
X-MC-Unique: VZ3YznT2OQ29l7EOgTZs0w-1
X-Mimecast-MFC-AGG-ID: VZ3YznT2OQ29l7EOgTZs0w_1761902952
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-427015f62a7so1609476f8f.0
 for <qemu-devel@nongnu.org>; Fri, 31 Oct 2025 02:29:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761902951; x=1762507751;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Ag5lI1UPkpi4D/CydEoNJdHOa5d1MaFHtmLdOB9/2po=;
 b=PG6hg9biElN7nJVnnupiu2s147RxpG67k7iTXCvuTT/NFQe4u82vM8CVSNNGVJA2sv
 KSXnIUjFPRrPchhxZM82B4hYQuPtFaRowQ/SO5A31+3i9L0qvWDdVYEO1Hlv9DdfnSRi
 LUxKsu4fD2vBQigmcLkjXAxC+uNy7q6b5Nqvn11h5LQu2fD6M5h9upuXDdr6LvBovDqJ
 kGioaCPAE/xFEQwePZOck/rk1EiB2LskvOZBBEIN9CQak4Io1kMVO+4AeFqP5C1OwbzA
 QY/SbG0R/E3sEyuBuoyFn7NDZrg+/9JVwJW5t/PbwK8kUXmTbhIydvdKNnDctRzFnKjx
 XcpQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUbO3mWFCmFoL2zQBNuq9CSxGPVBGxGBpMNemrS307Io3jLLcItykxRDu+1fUHxn54WC3OKd21xL3rD@nongnu.org
X-Gm-Message-State: AOJu0YzBTWL+AcYq1Xieu7kRB9G/ToYzqihAmc26kq3yiqEHEzFGSmkW
 lPSsf+tzh7QAVNKxy3PwqOsTT8Ag4scpL6LxqVYxvXR6DYx39LfcabGK5NWIvhMUyMfBiqiiAWO
 Gijcv2UwNgyCrDVQIK7SOvPWFmvG2xPZFvKkinNa+iGf7jmX4Hdm6UZ8zlU1DN1Om
X-Gm-Gg: ASbGncuHYmT4Dbq1Y8cz82z3fORU7CwikOioxav2KOoPPVoQoHQQwDZ8OsSynvWT+pn
 v4VQMWYeGqhwlizWNwojm+Hu+NYdok7Fc9mvXL393Ci9UrZDUVakvQv/8aAPE5hZNeVWYqbZoYq
 kMMvXVySMZb5EUra+JHhKVDXDpWPVK9K54iml4Zm8zG6i4WXAEMgJMUL1+5LdoO7OEv1vSzB+cM
 lM81pJjUhtKDgsy6TGibH91iFKgifxU+JLoJcG6GDXAlmjAwWfPLRW2NZx/2XVVYkhTEGm/MRTk
 yrQkurYtjzOVvG54BVCPpogWAfrIdvNRKehbL+Ktx76xvHO5ih+bNcIOh7xArofR6GbI/p7pRY6
 H33R5zyo/AxRRWoJWtbhy30ZE0cjzlcl+9qjy9Bxiyg8gUKDQsNblt6XMpDGh/WBgC3m5HyRmxR
 R1FeJqQ0PW1PIIIoIUtP9ppNeaOAP5
X-Received: by 2002:a05:6000:420b:b0:428:3da6:b1f5 with SMTP id
 ffacd0b85a97d-429bd6c1f73mr2429957f8f.59.1761902950905; 
 Fri, 31 Oct 2025 02:29:10 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF6WXA0ibXgRkyM0octDIbQ+J0EE3IcqyAIe3bwujLbJPQWe4JV+XYufUPpwgbU73f+3l6Dcg==
X-Received: by 2002:a05:6000:420b:b0:428:3da6:b1f5 with SMTP id
 ffacd0b85a97d-429bd6c1f73mr2429917f8f.59.1761902950419; 
 Fri, 31 Oct 2025 02:29:10 -0700 (PDT)
Received: from ?IPV6:2003:cf:d717:1f4c:b757:9963:8006:395e?
 (p200300cfd7171f4cb75799638006395e.dip0.t-ipconnect.de.
 [2003:cf:d717:1f4c:b757:9963:8006:395e])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-429c13e1c9esm2632417f8f.22.2025.10.31.02.29.08
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 31 Oct 2025 02:29:09 -0700 (PDT)
Message-ID: <0d98f477-722c-4023-9b28-54d8faffff66@redhat.com>
Date: Fri, 31 Oct 2025 10:29:07 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 10/16] qcow2: Fix cache_clean_timer
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org,
 Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 "Richard W . M . Jones" <rjones@redhat.com>,
 Ilya Dryomov <idryomov@gmail.com>, Peter Lieven <pl@dlhnet.de>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Fam Zheng <fam@euphon.net>, Ronnie Sahlberg <ronniesahlberg@gmail.com>
References: <20251028163343.116249-1-hreitz@redhat.com>
 <20251028163343.116249-11-hreitz@redhat.com> <aQJ30-Ifcji8lrme@redhat.com>
Content-Language: en-US
From: Hanna Czenczek <hreitz@redhat.com>
In-Reply-To: <aQJ30-Ifcji8lrme@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=hreitz@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001,
 T_SPF_TEMPERROR=0.01 autolearn=unavailable autolearn_force=no
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

On 29.10.25 21:23, Kevin Wolf wrote:
> Am 28.10.2025 um 17:33 hat Hanna Czenczek geschrieben:
>> The cache-cleaner runs as a timer CB in the BDS AioContext.  With
>> multiqueue, it can run concurrently to I/O requests, and because it does
>> not take any lock, this can break concurrent cache accesses, corrupting
>> the image.  While the chances of this happening are low, it can be
>> reproduced e.g. by modifying the code to schedule the timer CB every
>> 5 ms (instead of at most once per second) and modifying the last (inner)
>> while loop of qcow2_cache_clean_unused() like so:
>>
>>      while (i < c->size && can_clean_entry(c, i)) {
>>          for (int j = 0; j < 1000 && can_clean_entry(c, i); j++) {
>>              usleep(100);
>>          }
>>          c->entries[i].offset = 0;
>>          c->entries[i].lru_counter = 0;
>>          i++;
>>          to_clean++;
>>      }
>>
>> i.e. making it wait on purpose for the point in time where the cache is
>> in use by something else.
>>
>> The solution chosen for this in this patch is not the best solution, I
>> hope, but I admittedly can’t come up with anything strictly better.
>>
>> We can protect from concurrent cache accesses either by taking the
>> existing s->lock, or we introduce a new (non-coroutine) mutex
>> specifically for cache accesses.  I would prefer to avoid the latter so
>> as not to introduce additional (very slight) overhead.
> In theory, the old plan was that eventually qcow2 would use fine grained
> locks instead of the single s->lock, and having a separate cache lock
> would be a step towards it. But if we never actually make use of it to
> hold s->lock for a shorter time, that's not really a good argument. I'm
> not sure if that's ever going to happen unless for a rewrite in Rust or
> something.
>
> I never tried to measure specifically if lock contention is a problem
> with high queue depth and random I/O on a huge disk. Intuitively,
> holding s->lock while doing I/O for loading entries into the cache can't
> be really good.
>
> Anyway, I went a bit on a tangent there...
>
>> Using s->lock, which is a coroutine mutex, however means that we need to
>> take it in a coroutine, so the timer CB must enter such a coroutine.  As
>> a result, descheduling the timer is no longer a guarantee that the
>> cache-cleaner will not run, because it may now be yielding in
>> qemu_co_mutex_lock().
> I think creating a coroutine in cache_clean_timer_cb() is the wrong
> approach. Instead, cache_clean_timer_init() could create a coroutine
> and its implementation could be something like this:
>
>      while (!s->cache_clean_timer_stopping) {
>          qemu_co_sleep_ns_wakeable(&s->cache_clean_timer_wake,
>                                    QEMU_CLOCK_VIRTUAL,
>                                    s->cache_clean_interval * NANOSECONDS_PER_SECOND);
>
>          qemu_co_mutex_lock(&s->lock);
>          qcow2_cache_clean_unused(s->l2_table_cache);
>          qcow2_cache_clean_unused(s->refcount_block_cache);
>          qemu_co_mutex_unlock(&s->lock);
>      }
>      s->cache_clean_timer_stopping = false;

Ah, that’s nicer.  I think we can replace the flag by checking 
s->cache_clean_interval > 0 and adding a CoQueue to wake up waiting 
coroutines.

>> (Note even now this was only guaranteed for cache_clean_timer_del()
>> callers that run in the BDS (the timer’s) AioContext.  For callers
>> running in the main context, the problem may have already existed,
>> though maybe the BQL prevents timers from running in other contexts, I’m
>> not sure.)
>>
>> Polling to await the timer to actually settle seems very complicated for
>> something that’s rather a minor problem, but I can’t come up with any
>> better solution that doesn’t again just overlook potential problems.
>>
>> (One cleaner idea may be to have a generic way to have timers run
>> coroutines, and to await those when descheduling the timer.  But while
>> cleaner, it would also be more complicated, and I don’t think worth it
>> at this point.)
>>
>> (Not Cc-ing qemu-stable, as the issue is quite unlikely to be hit, and
>> I’m not too fond of this solution.)
>>
>> Signed-off-by: Hanna Czenczek <hreitz@redhat.com>
>> ---
>>   block/qcow2.h |  1 +
>>   block/qcow2.c | 90 ++++++++++++++++++++++++++++++++++++++++++++-------
>>   2 files changed, 79 insertions(+), 12 deletions(-)
>> @@ -867,6 +893,39 @@ static void cache_clean_timer_del(BlockDriverState *bs)
>>       }
>>   }
>>   
>> +/*
>> + * Delete the cache clean timer and await any yet running instance.
>> + * Must be called from the main or BDS AioContext, holding s->lock.
>> + */
>> +static void coroutine_fn
>> +cache_clean_timer_locked_co_del_and_wait(BlockDriverState *bs)
>> +{
>> +    BDRVQcow2State *s = bs->opaque;
>> +    IO_OR_GS_CODE();
>> +    cache_clean_timer_del(bs);
>> +    if (qatomic_read(&s->cache_clean_running)) {
>> +        qemu_co_mutex_unlock(&s->lock);
>> +        qatomic_set(&s->cache_clean_polling, true);
>> +        BDRV_POLL_WHILE(bs, qatomic_read(&s->cache_clean_running));
> Polling in a coroutine_fn is verboten.
>
> If we do need this function, I think it would be a yield here and a wake
> on the other side. I think we might be able to get around it if we move
> the call from qcow2_do_open() into qcow2_open() (i.e. outside the
> coroutine). A bit ugly, so your choice.

We can let a CoQueue do the waking, no?

>> +        qemu_co_mutex_lock(&s->lock);
>> +    }
>> +}
>> +
>> +/*
>> + * Delete the cache clean timer and await any yet running instance.
>> + * Must be called from the main or BDS AioContext without s->lock held.
>> + */
>> +static void cache_clean_timer_del_and_wait(BlockDriverState *bs)
>> +{
>> +    BDRVQcow2State *s = bs->opaque;
>> +    IO_OR_GS_CODE();
>> +    cache_clean_timer_del(bs);
>> +    if (qatomic_read(&s->cache_clean_running)) {
>> +        qatomic_set(&s->cache_clean_polling, true);
>> +        BDRV_POLL_WHILE(bs, qatomic_read(&s->cache_clean_running));
>> +    }
>> +}
>> +
>>   static void qcow2_detach_aio_context(BlockDriverState *bs)
>>   {
>>       cache_clean_timer_del(bs);
>> @@ -1214,12 +1273,20 @@ fail:
>>       return ret;
>>   }
>>   
>> +/* s_locked specifies whether s->lock is held or not */
>>   static void qcow2_update_options_commit(BlockDriverState *bs,
>> -                                        Qcow2ReopenState *r)
>> +                                        Qcow2ReopenState *r,
>> +                                        bool s_locked)
>>   {
>>       BDRVQcow2State *s = bs->opaque;
>>       int i;
>>   
>> +    if (s_locked) {
>> +        cache_clean_timer_locked_co_del_and_wait(bs);
>> +    } else {
>> +        cache_clean_timer_del_and_wait(bs);
>> +    }
>> +
>>       if (s->l2_table_cache) {
>>           qcow2_cache_destroy(s->l2_table_cache);
>>       }
>> @@ -1228,6 +1295,10 @@ static void qcow2_update_options_commit(BlockDriverState *bs,
>>       }
>>       s->l2_table_cache = r->l2_table_cache;
>>       s->refcount_block_cache = r->refcount_block_cache;
>> +
>> +    s->cache_clean_interval = r->cache_clean_interval;
>> +    cache_clean_timer_init(bs, bdrv_get_aio_context(bs));
>> +
>>       s->l2_slice_size = r->l2_slice_size;
>>   
>>       s->overlap_check = r->overlap_check;
>> @@ -1239,12 +1310,6 @@ static void qcow2_update_options_commit(BlockDriverState *bs,
>>   
>>       s->discard_no_unref = r->discard_no_unref;
>>   
>> -    if (s->cache_clean_interval != r->cache_clean_interval) {
>> -        cache_clean_timer_del(bs);
>> -        s->cache_clean_interval = r->cache_clean_interval;
>> -        cache_clean_timer_init(bs, bdrv_get_aio_context(bs));
>> -    }
>> -
> I think the del/init pair here won't be necessary any more after
> switching to the background coroutine. It will just start using the new
> value of s->cache_clean_interval the next time it sleeps.

One problem is that if we don’t lock s->lock, the coroutine can read 
s->l2_table_cache and s->refcount_block_cache while they’re invalid, 
which is why I moved the deletion above.  We also still need to delete 
if the interval is set to 0 (or special-case that in the coroutine to 
wait forever).

We could run all of this in a coroutine so we can lock s->lock, or we 
have to force-stop the timer/coroutine at the start.  Maybe running it 
in a coroutine is better…

Hanna


