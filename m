Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8AE93C3ABC3
	for <qemu-devel@archiver.kernel.org>; Sun, 11 May 2025 04:42:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uDyVJ-0000Ef-C3; Sun, 11 May 2025 00:41:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1uDyVH-0000E0-0W
 for qemu-devel@nongnu.org; Sun, 11 May 2025 00:41:31 -0400
Received: from mail-pl1-x62c.google.com ([2607:f8b0:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1uDyVE-0002Ne-Tq
 for qemu-devel@nongnu.org; Sun, 11 May 2025 00:41:30 -0400
Received: by mail-pl1-x62c.google.com with SMTP id
 d9443c01a7336-22e331215dbso34080575ad.1
 for <qemu-devel@nongnu.org>; Sat, 10 May 2025 21:41:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1746938487; x=1747543287;
 darn=nongnu.org; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=SnN7elGbhJ5UYY3XjFQrJcRKgRTxFPqEFsafip8SGlA=;
 b=HDHI7h8E1+R0NoHOX4RU+6/h4CLa0RGTWa/Zld+JQGivUG2SEl39eQORoQ/bZ4Q4i/
 pgYWaWw5wNZCe0LGIN3veW79XA68TdKigbkJhVpa1BHoOQsQnsC5tR4kQqD9hbQYjHi4
 eWi0v+F9ZXJt0XYRmL0bIZRxylIDEPeAxUrub+yod5ACF5cq4DZG4hkcUx0T5fhNZHZN
 2Lw52COth52KIVFVeGzC/Bj6DEhHoe5HyrAHtATGC4HHXf0PqA7Uhx4DS8D3QNhLqiLn
 +BR+sp5sM7SdTC+Fl59G4delbnovugN9QMoVgmkZUI9ND09i8R5lfNRtm1/V2NLcXgJb
 Yocg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746938487; x=1747543287;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=SnN7elGbhJ5UYY3XjFQrJcRKgRTxFPqEFsafip8SGlA=;
 b=YqAAiFiSMds9jx3vQ4wFX+Z8KpC4qyS3c3kjLFk0m6XaeQHmCnpxUKARYTRreVp4yP
 3dnRAAF6fvovWg4WEc/Jg0qhprM4BqZoO/HKq518C5I6o7GQ/sAt3yVKwD37EnLMpWOI
 MpA165OEPLDCind1yw/skpM9Z3hQFx7mkUaw8YNb6g5ZFZujTfernP11ssZFSl2LQmIn
 XOvLujRup0rXz7nKTDPtjIygtRgMIuMIFKFRGELgjlx4ZuGgTaxQ8GxoFl1YIgi94+Vi
 HUJx+4xQSFhvdTxiOu05BY1DYGvTcgqKWUcZvhKz64qNChIhJspkLcfCQxlcg+IjpJ6G
 AtlA==
X-Forwarded-Encrypted: i=1;
 AJvYcCW0wl/daOFsUh2RFwVE6l+anFrFEIq2+15/pNyWaBapi83PjQoSGlgR8DzfDUn1OOhtkbsjb/s3YBdr@nongnu.org
X-Gm-Message-State: AOJu0Yxnmf8bpr6daos7bUsUj0Lyws6KbTXzweUHwQLv9lEBSebL2Kcf
 1rIflLR9DhzUnICVAlKQUPQZDDJ+CFWtxIIu1dqGnTrYEmsZLrKxCgX5IcqmNXo=
X-Gm-Gg: ASbGncuxw57ZdUPcp2GW8bPHPtEnKi/fiomIsTfyqNL2GJ+QcqQdk0MSE2C2t9VL2Fo
 O7LDptbuHEC21+72IaKmitLZ/g2WZonKsVYc3F1JWFO4GGeK0rXa3GZ8cC71AYzLmVNJvgEtQi7
 JRqgQeNX/SAt7uYwGMD89MkVTXSgsnKgAJhlMjM72jkN5LM2F3rhPUi/aGMb98V/oXgjK/1aIUk
 yU6/3PjTwjvzL6fEF4qnV+/YbJuDEvNXf6zyDf8Kd2qtvaA8FhpurqyqvQm7oy+LOZ1L9CEHXWF
 Lbo9Ynjk0Pco6mYdrIVShQMxLQZ3RrkfFaxEkaKG3jcNWXBEg25miyOxy85CyfXXp233Z4j1Q9A
 =
X-Google-Smtp-Source: AGHT+IGWehGM8bGSzrcnWEDEbYYZydpnrrc7wUMxoBLNJzOkdYli9xYZ5Ct1Fjcaui9DWBXpZeW8cA==
X-Received: by 2002:a17:903:2443:b0:221:1497:7b08 with SMTP id
 d9443c01a7336-22e847b818emr204938925ad.23.1746938486805; 
 Sat, 10 May 2025 21:41:26 -0700 (PDT)
Received: from [157.82.203.223] ([157.82.203.223])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22fc75469edsm40733225ad.40.2025.05.10.21.41.24
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 10 May 2025 21:41:26 -0700 (PDT)
Message-ID: <b80a7e2a-8675-4c33-9295-d460c6093cc5@daynix.com>
Date: Sun, 11 May 2025 13:41:23 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/9] qemu-thread: Avoid futex abstraction for non-Linux
To: Paolo Bonzini <pbonzini@redhat.com>, Stefan Weil <sw@weilnetz.de>,
 Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Hailiang Zhang <zhanghailiang@xfusion.com>
Cc: Phil Dennis-Jordan <phil@philjordan.eu>, qemu-devel@nongnu.org,
 devel@daynix.com, =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?=
 <marcandre.lureau@redhat.com>, =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?=
 <berrange@redhat.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>
References: <20250510-event-v2-0-7953177ce1b8@daynix.com>
 <20250510-event-v2-3-7953177ce1b8@daynix.com>
 <54bb98a7-110d-41d2-a683-1428cb7d94a2@redhat.com>
Content-Language: en-US
From: Akihiko Odaki <akihiko.odaki@daynix.com>
In-Reply-To: <54bb98a7-110d-41d2-a683-1428cb7d94a2@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62c;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pl1-x62c.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 2025/05/11 0:02, Paolo Bonzini wrote:
> On 5/10/25 10:51, Akihiko Odaki wrote:
>> Add special implementations of qemu_event_set() and qemu_event_wait()
>> using pthread primitives. qemu_event_wait() will ensure qemu_event_set()
>> finishes, and these functions will avoid complex barrier and atomic
>> operations.
> 
> Unfortunately not...
> 
>> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
>> Tested-by: Phil Dennis-Jordan <phil@philjordan.eu>
>> Reviewed-by: Phil Dennis-Jordan <phil@philjordan.eu>
>> ---
>>   util/qemu-thread-posix.c | 45 +++++++++++++++++ 
>> +---------------------------
>>   1 file changed, 18 insertions(+), 27 deletions(-)
>>
>> diff --git a/util/qemu-thread-posix.c b/util/qemu-thread-posix.c
>> index 13459e44c768..805cac444f15 100644
>> --- a/util/qemu-thread-posix.c
>> +++ b/util/qemu-thread-posix.c
>> @@ -319,28 +319,6 @@ void qemu_sem_wait(QemuSemaphore *sem)
>>   #ifdef __linux__
>>   #include "qemu/futex.h"
>> -#else
>> -static inline void qemu_futex_wake(QemuEvent *ev, int n)
>> -{
>> -    assert(ev->initialized);
>> -    pthread_mutex_lock(&ev->lock);
>> -    if (n == 1) {
>> -        pthread_cond_signal(&ev->cond);
>> -    } else {
>> -        pthread_cond_broadcast(&ev->cond);
>> -    }
>> -    pthread_mutex_unlock(&ev->lock);
>> -}
>> -
>> -static inline void qemu_futex_wait(QemuEvent *ev, unsigned val)
>> -{
>> -    assert(ev->initialized);
>> -    pthread_mutex_lock(&ev->lock);
>> -    if (ev->value == val) {
>> -        pthread_cond_wait(&ev->cond, &ev->lock);
>> -    }
>> -    pthread_mutex_unlock(&ev->lock);
>> -}
>>   #endif
>>   /* Valid transitions:
>> @@ -363,7 +341,7 @@ static inline void qemu_futex_wait(QemuEvent *ev, 
>> unsigned val)
>>   void qemu_event_init(QemuEvent *ev, bool init)
>>   {
>> -#ifndef __linux__
>> +#ifndef CONFIG_LINUX
>>       pthread_mutex_init(&ev->lock, NULL);
>>       pthread_cond_init(&ev->cond, NULL);
>>   #endif
>> @@ -376,7 +354,7 @@ void qemu_event_destroy(QemuEvent *ev)
>>   {
>>       assert(ev->initialized);
>>       ev->initialized = false;
>> -#ifndef __linux__
>> +#ifndef CONFIG_LINUX
>>       pthread_mutex_destroy(&ev->lock);
>>       pthread_cond_destroy(&ev->cond);
>>   #endif
>> @@ -386,6 +364,7 @@ void qemu_event_set(QemuEvent *ev)
>>   {
>>       assert(ev->initialized);
>> +#ifdef CONFIG_LINUX
>>       /*
>>        * Pairs with both qemu_event_reset() and qemu_event_wait().
>>        *
> 
> The user of this code will not have mutexes so some care is needed.  You 
> have:
> 
>      if (!qatomic_load_acquire(&done)) {
>          qemu_event_reset(&ev);
>          if (!qatomic_load_acquire(&done))
>              qemu_event_wait(&ev);
>      }
> 
> and on the other side
> 
>      qatomic_store_release(&done, 1);
>      qemu_event_set(&ev);
>      --> qatomic_set(&ev.value, EV_SET);
> 
> I don't think this is correct without the memory barrier in 
> qemu_event_set(), though I am not actually sure how you'd
> add it.
> 
> The problem is, I don't see anything that prevents this:
> 
>                  set done
>                  qemu_event_set()
>                    pthread_mutex_lock()
>                    ev.value = SET
>      qemu_event_reset()
>        ev.value |= FREE
>        smp_mb__after_rmw()
>                    // store buffer not flushed yet,
>                    // so other thread doesn't see "done"
>      read done
>      pthread_mutex_lock()
>                    pthread_cond_broadcast()
>                    pthread_mutex_unlock()
>      while ev.value != SET
>          // hang
>          pthread_cond_wait()
> 
> The barrier in qemu_event_reset() is not enough, you need one on each side.

This is insightful; I will restore smp_mb() in qemu_event_set().

> 
>> +#else
>> +    pthread_mutex_lock(&ev->lock);
>> +    if (qatomic_read(&ev->value) != EV_SET) {
> 
> Apart from the above this needs to be a while(), because condition 
> variables also have spurious wakeups.

I will fix it with the next version too.

Regards,
Akihiko Odaki

> 
> Paolo
> 
>> +        pthread_cond_wait(&ev->cond, &ev->lock);
>> +    }
>> +    pthread_mutex_unlock(&ev->lock);
>> +#endif
>>   }
>>   static __thread NotifierList thread_exit;
>>
> 


