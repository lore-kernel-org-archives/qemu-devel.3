Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85BBBCED603
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Nov 2025 11:02:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vLJT2-0007dW-NV; Tue, 18 Nov 2025 06:01:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1vLJSz-0007UH-3P
 for qemu-devel@nongnu.org; Tue, 18 Nov 2025 06:01:45 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1vLJSv-00014o-Cr
 for qemu-devel@nongnu.org; Tue, 18 Nov 2025 06:01:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1763463699;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=jM1BJdmL9ao9+V3ggb+YmLVFnsdaekFUREFZ0eqNafM=;
 b=R9YjPDt44HwRoSt1i0dNZioEGRJqLwaNABLK//m4GXBkJfiIY4F2IJfE7hfZZqIwywInqA
 wdA17oz8qXjFokVazpvbnCOzfJJZc+H8vHu6jGbUwnrx9LBnXf0aAoC2+4iPQyKyLC3fJ1
 umE/KZfXYY1w1NB2VouwWdEQqGBf6GE=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-692-B7akOgtnMBiZ0HLJYLKbUA-1; Tue, 18 Nov 2025 06:01:38 -0500
X-MC-Unique: B7akOgtnMBiZ0HLJYLKbUA-1
X-Mimecast-MFC-AGG-ID: B7akOgtnMBiZ0HLJYLKbUA_1763463697
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-4777b03b90fso26067675e9.1
 for <qemu-devel@nongnu.org>; Tue, 18 Nov 2025 03:01:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1763463697; x=1764068497; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=jM1BJdmL9ao9+V3ggb+YmLVFnsdaekFUREFZ0eqNafM=;
 b=uJU8qSmMl1cWeb0FhwoBdkfDQb2s8wsKScEcwoUBlmkQkTLLOxoPQWTahsYf8knhIJ
 MX5htYdTDjRLXiOkf7YZE0cjjvkqvLQYOEG6oiZCrpZndoDxv5uwCX3wwFrkceoYFtle
 Z1UpCNnnAOofah0KvAaqcetcUd5JZT81g+JYAPM6e+14ba495VjsVGgvErn/EtP2v+Xr
 puHWB67mb8OkZ7IC+HL2MtOO/txxsW7HTRD8gIlQ9gkGSSK+wCyCLx0slkh3Jgl5Om/E
 Xj6jiqY0OKcA5UJgoOU43Y2Fjl0rVXIj2ALAEcMNum0leuY4o8DM5kyewkjPjRMGwd8e
 pHug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763463697; x=1764068497;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=jM1BJdmL9ao9+V3ggb+YmLVFnsdaekFUREFZ0eqNafM=;
 b=lpJmK1GNVC0zc48nOcekiliQhzF34JJymj95pzabFVakzcw4quMsijlu2lzbvvhHLn
 R1wlVDchSoXF3u2WV+ZYb3Tp8ONyapQ9RH5Tb/t+kE1hkXYH6rgV9iEV8Itz0GzDtuhX
 jPkoHqAzxtmqY3s4sJeuZ+IIXWLEK0e/GWDyemOSzfjNiT5WW041Smv18mvENZFd4Cxr
 vYYl9TgWKPmadWfzJniO20rOQvku8z5fPtiyoRlm1bdYrynWIBGcNEm5CCLdTsS4gcsj
 nW30LU1Fw1PoUB7clv3xDp4jCducZN+AIpjU8+2fFSAWhHQfrWbamoiP3cK4W2mv6RnL
 QC8g==
X-Forwarded-Encrypted: i=1;
 AJvYcCVeQ2+ymEIa08DknbAqVd/+Jc49LufXeXPY2amwrokb4vAZH+FhGzHsDcWT7C2+RRRhIp2Rst3gVCRX@nongnu.org
X-Gm-Message-State: AOJu0YzDCao3mUNI374PTmDOxeemNi1WrpsYz3L+UA53CkK/MhjH8vqI
 bfolLTEyEWt+3bJsbHTSi2F35ivprzGll8IroRoyWnWgunAXpgITOOypEDEXIMkUT532uCUScxE
 ng5FmT619kMiUoGhdZsJRXvISUWxuwbiALbr705K3qLZeVb4svBbpgXKD
X-Gm-Gg: ASbGnctl+3n4IxSuEEZvqW3tEpFFGQIaui8ir3yyA4YTh2/aUvvNisZvfdNfc3aSXt5
 iIb6N9j+LNpG9hOFD7vALbON83lMpNF4okSvL8GVJgeQqfbd6p7rBDREMBAnPYP3bVRMcjefZNT
 KXu4prfMmnwZZ6s33WpNui9uxmuHE+vkky8s07rerVJp46jH5cFyPGL2Ba1gJS3/hOhoqyrP7u2
 1C6V6FdwEF/by7BPuSJK7Jqxcq+gTE8T3E0K+VvEIRBCjQaAn5ej7q53LRU+yAmRzEaQxukZwBE
 hAte9YOjUG57Q15Xzsp+XcYZyTWbS7L5sBIdk08Auar2/gg7ZnMXQoGFm1pNgYJ+iZ6JA4ZUhv2
 4ivFtOqsI01Dk82OszgQL2ueFXF0tS2o4FBZLuJNvKUHRvHR9sXNPBasQVqzXPONKfa9dmhELek
 nwszylM2myjNtWxoqqPxUMmrAFnLfXyyOX9MSESTs=
X-Received: by 2002:a05:600c:4f93:b0:477:bb0:751b with SMTP id
 5b1f17b1804b1-4778fea1056mr136172085e9.27.1763463696689; 
 Tue, 18 Nov 2025 03:01:36 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHisHyPbzLASd3oLVUUxR8NRXAz52SoqwS8LwXlWPNmeBlTaBhXUcYOH/icM/9kUDAbCjYwtw==
X-Received: by 2002:a05:600c:4f93:b0:477:bb0:751b with SMTP id
 5b1f17b1804b1-4778fea1056mr136171655e9.27.1763463696127; 
 Tue, 18 Nov 2025 03:01:36 -0800 (PST)
Received: from ?IPV6:2003:cf:d717:1f76:905c:29a8:188b:2aad?
 (p200300cfd7171f76905c29a8188b2aad.dip0.t-ipconnect.de.
 [2003:cf:d717:1f76:905c:29a8:188b:2aad])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4779a2892c8sm183481855e9.1.2025.11.18.03.01.34
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 18 Nov 2025 03:01:34 -0800 (PST)
Message-ID: <7a3dc3f2-cded-4e2f-a914-938acd52576f@redhat.com>
Date: Tue, 18 Nov 2025 12:01:31 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 12/19] qcow2: Fix cache_clean_timer
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org,
 Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 "Richard W . M . Jones" <rjones@redhat.com>,
 Ilya Dryomov <idryomov@gmail.com>, Peter Lieven <pl@dlhnet.de>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Fam Zheng <fam@euphon.net>, Ronnie Sahlberg <ronniesahlberg@gmail.com>
References: <20251110154854.151484-1-hreitz@redhat.com>
 <20251110154854.151484-13-hreitz@redhat.com> <aRs2OSuFy0HyW4EU@redhat.com>
Content-Language: en-US
From: Hanna Czenczek <hreitz@redhat.com>
In-Reply-To: <aRs2OSuFy0HyW4EU@redhat.com>
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
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 17.11.25 15:50, Kevin Wolf wrote:
> Am 10.11.2025 um 16:48 hat Hanna Czenczek geschrieben:
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
>>
>> Using s->lock, which is a coroutine mutex, however means that we need to
>> take it in a coroutine, so the timer must run in a coroutine.  We can
>> transform it from the current timer CB style into a coroutine that
>> sleeps for the set interval.  As a result, however, we can no longer
>> just deschedule the timer to instantly guarantee it won’t run anymore,
>> but have to await the coroutine’s exit.
>>
>> (Note even before this patch there were places that may not have been so
>> guaranteed after all: Anything calling cache_clean_timer_del() from the
>> QEMU main AioContext could have been running concurrently to an existing
>> timer CB invocation.)
>>
>> Polling to await the timer to actually settle seems very complicated for
>> something that’s rather a minor problem, but I can’t come up with any
>> better solution that doesn’t again just overlook potential problems.
>>
>> (Not Cc-ing qemu-stable, as the issue is quite unlikely to be hit, and
>> I’m not too fond of this solution.)
>>
>> Signed-off-by: Hanna Czenczek <hreitz@redhat.com>
>> -static void cache_clean_timer_cb(void *opaque)
>> +static void coroutine_fn cache_clean_timer(void *opaque)
>>   {
>> -    BlockDriverState *bs = opaque;
>> -    BDRVQcow2State *s = bs->opaque;
>> -    qcow2_cache_clean_unused(s->l2_table_cache);
>> -    qcow2_cache_clean_unused(s->refcount_block_cache);
>> -    timer_mod(s->cache_clean_timer, qemu_clock_get_ms(QEMU_CLOCK_VIRTUAL) +
>> -              (int64_t) s->cache_clean_interval * 1000);
>> +    BDRVQcow2State *s = opaque;
>> +    uint64_t wait_ns;
>> +
>> +    WITH_QEMU_LOCK_GUARD(&s->lock) {
>> +        wait_ns = s->cache_clean_interval * NANOSECONDS_PER_SECOND;
>> +    }
>> +
>> +    while (wait_ns > 0) {
>> +        qemu_co_sleep_ns_wakeable(&s->cache_clean_timer_wake,
>> +                                  QEMU_CLOCK_VIRTUAL, wait_ns);
>> +
>> +        WITH_QEMU_LOCK_GUARD(&s->lock) {
>> +            if (s->cache_clean_interval > 0) {
>> +                qcow2_cache_clean_unused(s->l2_table_cache);
>> +                qcow2_cache_clean_unused(s->refcount_block_cache);
>> +            }
>> +
>> +            wait_ns = s->cache_clean_interval * NANOSECONDS_PER_SECOND;
>> +        }
>> +    }
>> +
>> +    WITH_QEMU_LOCK_GUARD(&s->lock) {
>> +        s->cache_clean_timer_co = NULL;
>> +        qemu_co_queue_restart_all(&s->cache_clean_timer_exit);
>> +    }
>>   }
>> +/**
>> + * Delete the cache clean timer and await any yet running instance.
>> + * Called holding s->lock.
>> + */
>> +static void coroutine_fn
>> +cache_clean_timer_co_locked_del_and_wait(BlockDriverState *bs)
>> +{
>> +    BDRVQcow2State *s = bs->opaque;
>> +
>> +    if (s->cache_clean_timer_co) {
>> +        s->cache_clean_interval = 0;
>> +        qemu_co_sleep_wake(&s->cache_clean_timer_wake);
>> +        qemu_co_queue_wait(&s->cache_clean_timer_exit, &s->lock);
>>       }
>>   }
> I don't want to count the number of context switches this dance between
> cache_clean_timer_co_locked_del_and_wait() and cache_clean_timer()
> takes! Good that it's not a hot path. :-)
>
>> +/* s_locked specifies whether s->lock is held or not */
>>   static void qcow2_update_options_commit(BlockDriverState *bs,
>> -                                        Qcow2ReopenState *r)
>> +                                        Qcow2ReopenState *r,
>> +                                        bool s_locked)
>>   {
>>       BDRVQcow2State *s = bs->opaque;
>>       int i;
>>   
>> +    /*
>> +     * We need to stop the cache-clean-timer before destroying the metadata
>> +     * table caches
>> +     */
>> +    if (s_locked) {
>> +        cache_clean_timer_co_locked_del_and_wait(bs);
>> +    } else {
>> +        cache_clean_timer_del_and_wait(bs);
>> +    }
>> +
>>       if (s->l2_table_cache) {
>>           qcow2_cache_destroy(s->l2_table_cache);
>>       }
>> @@ -1228,6 +1312,10 @@ static void qcow2_update_options_commit(BlockDriverState *bs,
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
>> @@ -1239,12 +1327,6 @@ static void qcow2_update_options_commit(BlockDriverState *bs,
>>   
>>       s->discard_no_unref = r->discard_no_unref;
>>   
>> -    if (s->cache_clean_interval != r->cache_clean_interval) {
>> -        cache_clean_timer_del(bs);
>> -        s->cache_clean_interval = r->cache_clean_interval;
>> -        cache_clean_timer_init(bs, bdrv_get_aio_context(bs));
>> -    }
>> -
>>       qapi_free_QCryptoBlockOpenOptions(s->crypto_opts);
>>       s->crypto_opts = r->crypto_opts;
>>   }
> Is there any specific reason why you move cache_clean_timer_init()
> earlier? I don't see an actual problem with the code as it is after this
> change, but s->l2_slice_size is related to the cache in a way, so it
> would feel safer if the cache cleaner were only started once all the
> settings are updated and not only those that it actually happens to
> access at the moment.

Oh.  I don’t think there’s a good reason.  I think it makes sense to 
keep the set-up in the old place.  Can you do that in your tree?

(I think it’s just because when I split it to stop the timer before 
deleting the caches, I decided it would conversely make sense to start 
it after they have been set up.)

Hanna


