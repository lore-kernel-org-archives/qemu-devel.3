Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB0ABC3ABC3
	for <qemu-devel@archiver.kernel.org>; Sat, 10 May 2025 15:03:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uDljA-0003Zf-2b; Sat, 10 May 2025 11:03:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uDlj7-0003ZP-6Y
 for qemu-devel@nongnu.org; Sat, 10 May 2025 11:02:57 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uDlj3-0006lb-Pb
 for qemu-devel@nongnu.org; Sat, 10 May 2025 11:02:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1746889369;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=YdCpAelFZ594j6QduP0suf0lYGyWqFqixFvIcyZiHqo=;
 b=QKCF0Gxlgb/KG7K1d1Bb4Rlut3D+UrFATJ5x/eQoA0hG/BAU0BXzfC+M0F6+LJEdaebM5O
 y+SISzUJY2tJC5rpx9205o+zDd8Dc4iIypICbQpT/dQFQwFnC2IuKDvSeLTHooyZvjqzuV
 TKxAPv1DycTQvLfVqNbIKm86wdHNElY=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-255-pArkIyNkNBiVpNhd9aZNBg-1; Sat, 10 May 2025 11:02:47 -0400
X-MC-Unique: pArkIyNkNBiVpNhd9aZNBg-1
X-Mimecast-MFC-AGG-ID: pArkIyNkNBiVpNhd9aZNBg_1746889367
Received: by mail-ej1-f71.google.com with SMTP id
 a640c23a62f3a-ad2363a3949so79675566b.0
 for <qemu-devel@nongnu.org>; Sat, 10 May 2025 08:02:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746889366; x=1747494166;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=YdCpAelFZ594j6QduP0suf0lYGyWqFqixFvIcyZiHqo=;
 b=rpYhAb+37dwpfZQLTaZCTAvDqu542mRZSdA1y3At/aCcWWEB7s1gtvrvenorl7x0Ha
 qGz0qaz/psQ0O3wSYaskHtAFP6XBWw2uK5O8cjwINZj651mPbR0BmmcXYOn6ZXb7uhNd
 Tr/DwuV4QV7LMlPn+wCOIPJmkLOMCId7VUj0LoM4rqaTrr0dcIztKuq6vLwFH+c9m5wz
 /bVbHdzcyXRFmbFiOOMFncPJqPxfZnEPI0LN5f7b8e2Q6ETBI5RQmmoRC23cBY6G2uuX
 52ILYIqanKOxuuXS1xOqrpHVUY/7OJX2M5l7zWrCXZ9SXZdSMZmmSDbNarnnHEoRk3qX
 8j9w==
X-Forwarded-Encrypted: i=1;
 AJvYcCURn7QkLqedVfJgcoxAq5UWgbg3/+DAAnehcqjALTxosx0wKpFeIo8kcIoCVxt6HCvqclK/j+A9l1kU@nongnu.org
X-Gm-Message-State: AOJu0Ywpyj6DZGbQUgkadNK1FgtTeiHDkw7DeHZEuZ5etEnGZceXB0SS
 5GWoxTRQlFpF9GDvR+gPUdj+/5xbdwe9cx0dJjXgoAUgUaPLsBcE+JevPQmjaKcrU5qplm9MFeL
 RaG/0QelBtghJz1cEdPncL3NgOTBUCjQU7vYmAOj1jQtYI7xXAwMn
X-Gm-Gg: ASbGnctUOgeXaTx9BY3NBFPQBEsuLu6Tlt1mXhgJ2DIvAxuYjOIGvOt1i8sxGqyiDTv
 3flqIm6ABzQklFnFUkXNi086CqasDYYqqKlZo6gA+ziQ9v1n4XWz1KF830GRGXVJ4SpH747eifN
 9kYVKhZc2PCWzjYSN/12T9JUrdKAhMA+TePx/RM6GXzylm3KzBCaDq+zRyog5sw1naVYe4DuTAy
 39/xmkuju89qV6bHvXkxTRDP7NB+GwYKUSMoUnYxjvKef+J16REbuMPAeeTuz0YFTrZn427arir
 GOtDxnCwgjJMIrg=
X-Received: by 2002:a05:6402:5187:b0:5f5:6299:ad68 with SMTP id
 4fb4d7f45d1cf-5fca0759ac0mr6111378a12.11.1746889366538; 
 Sat, 10 May 2025 08:02:46 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEAIsLNPS0nHo4JAa1vEtIBp26NrF9J5Ag64/7/to8LTtY8rybpcII9IHTxeO8wKYsN8wbhQg==
X-Received: by 2002:a05:6402:5187:b0:5f5:6299:ad68 with SMTP id
 4fb4d7f45d1cf-5fca0759ac0mr6111327a12.11.1746889366033; 
 Sat, 10 May 2025 08:02:46 -0700 (PDT)
Received: from [192.168.10.48] ([151.62.197.53])
 by smtp.googlemail.com with ESMTPSA id
 4fb4d7f45d1cf-5fc9cbe516asm2988741a12.15.2025.05.10.08.02.44
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 10 May 2025 08:02:45 -0700 (PDT)
Message-ID: <54bb98a7-110d-41d2-a683-1428cb7d94a2@redhat.com>
Date: Sat, 10 May 2025 17:02:42 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/9] qemu-thread: Avoid futex abstraction for non-Linux
To: Akihiko Odaki <akihiko.odaki@daynix.com>, Stefan Weil <sw@weilnetz.de>,
 Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Hailiang Zhang <zhanghailiang@xfusion.com>
Cc: Phil Dennis-Jordan <phil@philjordan.eu>, qemu-devel@nongnu.org,
 devel@daynix.com, =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?=
 <marcandre.lureau@redhat.com>, =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?=
 <berrange@redhat.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>
References: <20250510-event-v2-0-7953177ce1b8@daynix.com>
 <20250510-event-v2-3-7953177ce1b8@daynix.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Content-Language: en-US
Autocrypt: addr=pbonzini@redhat.com; keydata=
 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
In-Reply-To: <20250510-event-v2-3-7953177ce1b8@daynix.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -34
X-Spam_score: -3.5
X-Spam_bar: ---
X-Spam_report: (-3.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.413,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On 5/10/25 10:51, Akihiko Odaki wrote:
> Add special implementations of qemu_event_set() and qemu_event_wait()
> using pthread primitives. qemu_event_wait() will ensure qemu_event_set()
> finishes, and these functions will avoid complex barrier and atomic
> operations.

Unfortunately not...

> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
> Tested-by: Phil Dennis-Jordan <phil@philjordan.eu>
> Reviewed-by: Phil Dennis-Jordan <phil@philjordan.eu>
> ---
>   util/qemu-thread-posix.c | 45 ++++++++++++++++++---------------------------
>   1 file changed, 18 insertions(+), 27 deletions(-)
> 
> diff --git a/util/qemu-thread-posix.c b/util/qemu-thread-posix.c
> index 13459e44c768..805cac444f15 100644
> --- a/util/qemu-thread-posix.c
> +++ b/util/qemu-thread-posix.c
> @@ -319,28 +319,6 @@ void qemu_sem_wait(QemuSemaphore *sem)
>   
>   #ifdef __linux__
>   #include "qemu/futex.h"
> -#else
> -static inline void qemu_futex_wake(QemuEvent *ev, int n)
> -{
> -    assert(ev->initialized);
> -    pthread_mutex_lock(&ev->lock);
> -    if (n == 1) {
> -        pthread_cond_signal(&ev->cond);
> -    } else {
> -        pthread_cond_broadcast(&ev->cond);
> -    }
> -    pthread_mutex_unlock(&ev->lock);
> -}
> -
> -static inline void qemu_futex_wait(QemuEvent *ev, unsigned val)
> -{
> -    assert(ev->initialized);
> -    pthread_mutex_lock(&ev->lock);
> -    if (ev->value == val) {
> -        pthread_cond_wait(&ev->cond, &ev->lock);
> -    }
> -    pthread_mutex_unlock(&ev->lock);
> -}
>   #endif
>   
>   /* Valid transitions:
> @@ -363,7 +341,7 @@ static inline void qemu_futex_wait(QemuEvent *ev, unsigned val)
>   
>   void qemu_event_init(QemuEvent *ev, bool init)
>   {
> -#ifndef __linux__
> +#ifndef CONFIG_LINUX
>       pthread_mutex_init(&ev->lock, NULL);
>       pthread_cond_init(&ev->cond, NULL);
>   #endif
> @@ -376,7 +354,7 @@ void qemu_event_destroy(QemuEvent *ev)
>   {
>       assert(ev->initialized);
>       ev->initialized = false;
> -#ifndef __linux__
> +#ifndef CONFIG_LINUX
>       pthread_mutex_destroy(&ev->lock);
>       pthread_cond_destroy(&ev->cond);
>   #endif
> @@ -386,6 +364,7 @@ void qemu_event_set(QemuEvent *ev)
>   {
>       assert(ev->initialized);
>   
> +#ifdef CONFIG_LINUX
>       /*
>        * Pairs with both qemu_event_reset() and qemu_event_wait().
>        *

The user of this code will not have mutexes so some care is needed.  You 
have:

	if (!qatomic_load_acquire(&done)) {
		qemu_event_reset(&ev);
		if (!qatomic_load_acquire(&done))
			qemu_event_wait(&ev);
	}

and on the other side

	qatomic_store_release(&done, 1);
	qemu_event_set(&ev);
	--> qatomic_set(&ev.value, EV_SET);

I don't think this is correct without the memory barrier in 
qemu_event_set(), though I am not actually sure how you'd
add it.

The problem is, I don't see anything that prevents this:

				set done
				qemu_event_set()
				  pthread_mutex_lock()
				  ev.value = SET
	qemu_event_reset()
	  ev.value |= FREE
	  smp_mb__after_rmw()
				  // store buffer not flushed yet,
				  // so other thread doesn't see "done"
	read done
	pthread_mutex_lock()
				  pthread_cond_broadcast()
				  pthread_mutex_unlock()
	while ev.value != SET
		// hang
		pthread_cond_wait()

The barrier in qemu_event_reset() is not enough, you need one on each side.

> +#else
> +    pthread_mutex_lock(&ev->lock);
> +    if (qatomic_read(&ev->value) != EV_SET) {

Apart from the above this needs to be a while(), because condition 
variables also have spurious wakeups.

Paolo

> +        pthread_cond_wait(&ev->cond, &ev->lock);
> +    }
> +    pthread_mutex_unlock(&ev->lock);
> +#endif
>   }
>   
>   static __thread NotifierList thread_exit;
> 


