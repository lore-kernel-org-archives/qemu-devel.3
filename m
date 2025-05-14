Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B273C3ABCC
	for <qemu-devel@archiver.kernel.org>; Wed, 14 May 2025 13:08:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uFBfv-00015b-Vm; Wed, 14 May 2025 08:57:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1uFBfq-0000x8-9B
 for qemu-devel@nongnu.org; Wed, 14 May 2025 08:57:26 -0400
Received: from mail-pf1-x430.google.com ([2607:f8b0:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1uFBfm-0007ku-43
 for qemu-devel@nongnu.org; Wed, 14 May 2025 08:57:25 -0400
Received: by mail-pf1-x430.google.com with SMTP id
 d2e1a72fcca58-7399838db7fso811325b3a.0
 for <qemu-devel@nongnu.org>; Wed, 14 May 2025 05:57:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1747227439; x=1747832239;
 darn=nongnu.org; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=US5JaN7AtoSkfoc9C+e5KIKSSrt2g602Ql6aeUQNdtY=;
 b=mlOJECcpMY0+ZN6OfEyXXZpK7BlwhNPkpnYlOFgPqlPpzLMnBrikc+SisASZaGweTx
 qSJk0/6NUMa+EPRHgU8e/y4Ms7nAr59cJ/6aRdHMBboH33Vp7ncwVHGVynWrbvhu75jI
 nwzpcmS5Uq3bzxzbXJsSb95Vbth2eQcuiAun0vsuDFCAOCgckoB0TrahEqBkyK3oniLU
 wuNGXIfRJkPYDKVvmN/uiFHw9gUiIZfTmZfkU6+pXpBGtD6BXqPc6ivsu7eStwLyTKXD
 Gg6oLSBM9qjJeSLavQ/7R9ad5APtMBzVyzb1fQ2/uG5jxIlCuIc5mNLzHRVJya8mzBxx
 UgIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747227439; x=1747832239;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=US5JaN7AtoSkfoc9C+e5KIKSSrt2g602Ql6aeUQNdtY=;
 b=qy8nv6S8jLv/05J5R6ArA9OEnBr0RBr/kjm7BftJtt56XltkctxfBbkhQCMl8NYG/q
 yOj1MzMSNsRkxRPMIBIdvzAC2ZbA6MGvvpxRKSi6jaPWJu8zLIQQdv0v5AGS5Kp6RXKe
 5WfdcSxDZvSYm01R6sgJpqxG8hjGrIYm8D8WyiSil8aU+ev+X/bYjDO0y+gL6a4oxqs4
 wDIYAHTCCEYjLuiF7UixmfEQos+TI9Nww7BtFgMlrYotUH7QzpdO3g2dX7v9XIGct1Xv
 tNn5nFKN7Ckc5SUECWgc/3L+Ag6OlE96rMyV9DufaUKMnpqwqxGWdOs4mvC1ODiEKjdF
 MW6g==
X-Forwarded-Encrypted: i=1;
 AJvYcCVnQtF809dXV9h6qHYbRDvCr3FoEWUz06TorkrVrU52BN5pmxeMvBAmdaiwlMnGGEQtbwM5uRcNhSGn@nongnu.org
X-Gm-Message-State: AOJu0YyzZFE7EuH1fkr8ylqpNzmyEUQD3huOx+n5UfQysbKa6T+/Ltd4
 DOVkD4dRO0YI6O0PXYJWwqE3bVvl214qvn1oM0zfkROemQ8+XQR/tvOstCgaYU4=
X-Gm-Gg: ASbGnctjTwASZiM9BXwfX3+GgQ8SlfkiyswPimMKDKhpqkqfwhkBLalNdGqU5tq8mXz
 V19XtB6tIqV0VFaWGgZMteJi75NpzEDzpPwxly8vwPTVhbg8GzAOC9u0jgTz7K6ToCDXKZmMF76
 dO5auykSeqUfVA2t66dgjeYRWL63wjyPJ0VHPRthsQHCFnZFFvHNWUwzbn7PPkogWk0S2P2TfXc
 kB01nnrjDdjuM4dJSAhvruFJ0z9KK6CY7uu7f/ud4+8pnjr7N4TAgS+wyYE8FeaPgB53IsDs+eq
 ShNkAy7QekfbhrVH/NkKOUQ5FzY+IznyMD0K81kdWgiFYLtM436YdkTTu9MQFxAW
X-Google-Smtp-Source: AGHT+IFuuix0qUXrnWaI3YOS7eVMwcAy9ZQY40KojsPG+5rsyuABl4zla4QaOXKp81ZeTN82Fsn7yg==
X-Received: by 2002:a05:6a21:33a0:b0:201:8a06:6e3b with SMTP id
 adf61e73a8af0-215fdd5f403mr5282291637.9.1747227438735; 
 Wed, 14 May 2025 05:57:18 -0700 (PDT)
Received: from [157.82.203.223] ([157.82.203.223])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-b2349ec83e4sm8928633a12.23.2025.05.14.05.57.15
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 14 May 2025 05:57:18 -0700 (PDT)
Message-ID: <a40b0b1d-b1f8-478d-bde4-cac386323691@daynix.com>
Date: Wed, 14 May 2025 21:57:15 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 04/10] qemu-thread: Avoid futex abstraction for
 non-Linux
To: Paolo Bonzini <pbonzini@redhat.com>, Stefan Weil <sw@weilnetz.de>,
 Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Hailiang Zhang <zhanghailiang@xfusion.com>
Cc: Phil Dennis-Jordan <phil@philjordan.eu>, qemu-devel@nongnu.org,
 devel@daynix.com, =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?=
 <marcandre.lureau@redhat.com>, =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?=
 <berrange@redhat.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>
References: <20250511-event-v3-0-f7f69247d303@daynix.com>
 <20250511-event-v3-4-f7f69247d303@daynix.com>
 <e86aeab6-ef67-4f5a-9110-93309a77acf6@redhat.com>
Content-Language: en-US
From: Akihiko Odaki <akihiko.odaki@daynix.com>
In-Reply-To: <e86aeab6-ef67-4f5a-9110-93309a77acf6@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::430;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pf1-x430.google.com
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

On 2025/05/14 9:51, 'Paolo Bonzini' via devel wrote:
> On 5/11/25 08:08, Akihiko Odaki wrote:
>> @@ -387,12 +365,17 @@ void qemu_event_set(QemuEvent *ev)
>>       assert(ev->initialized);
>>       /*
>> -     * Pairs with both qemu_event_reset() and qemu_event_wait().
>> +     * Pairs with qemu_event_wait() (on Linux) and qemu_event_reset().
>>        *
>>        * qemu_event_set has release semantics, but because it *loads*
>>        * ev->value we need a full memory barrier here.
>> +     *
>> +     * qemu_event_wait() do not have a paired barrier on non-Linux 
>> because
>> +     * ev->lock ensures ordering.
>>        */
> 
> Thanks for trying to write down the idea.  This works, but there's
> still room for improvement. :)  The insight is that the logic becomes:
> 
>    if (done == 0) {                  done = 1;
>      <read ev->value>                ev->value = EV_SET;
>      ev->value = EV_FREE;
>      if (done == 0) {
>        pthread_cond_wait();          pthread_cond_broadcast();
>      }
>    }
> 
> which is a lot simplified compared to the futex case because all the
> differences between EV_FREE and EV_BUSY are replaced by the condition
> variable.  In order to avoid the slow path, all that's needed is to
> ensure that if qemu_event_reset() sees EV_SET, the caller also sees
> done == 1 in the second "if".
> 
> The futex case needs qatomic_or() because there can be a concurrent
> EV_FREE->EV_BUSY, and a smp_mb() because qemu_event_set() needs to
> *read* ev->value.  The non-futex case instead it can do this:
> 
>    if (done == 0) {                    done = 1;
>      v = load_acquire(ev->value); <--- store_release(value, EV_SET);
>      ev->value = v | EV_FREE;
>      if (done == 0) {
>        pthread_cond_wait();          pthread_cond_broadcast();
>      }
>    }
> 
> where load<---store indicates that the load on the left reads the
> value that the store writes, and the store "happens before" the load.
 > In other words:>
> - because v reads EV_SET, everything before the store_release is ordered
> before everything that follows the load_acquire
> 
> - therefore if v reads EV_SET, the pthread_cond_wait() won't be reached
> and there's no possibility of a hang (I think :))
> 
> 
> This becomes the following patch:
> 
> diff --git a/util/event.c b/util/event.c
> index 20853d61a7c..489cec08de7 100644
> --- a/util/event.c
> +++ b/util/event.c
> @@ -47,18 +47,14 @@ void qemu_event_set(QemuEvent *ev)
>   {
>       assert(ev->initialized);
> 
> +#ifdef HAVE_FUTEX
>       /*
> -     * Pairs with qemu_event_wait() (on Linux) and qemu_event_reset().
> -     *
> +     * Pairs with qemu_event_wait() and qemu_event_reset().
>        * qemu_event_set has release semantics, but because it *loads*
>        * ev->value we need a full memory barrier here.
> -     *
> -     * qemu_event_wait() do not have a paired barrier on non-Linux because
> -     * ev->lock ensures ordering.
>        */
>       smp_mb();
> 
> -#ifdef HAVE_FUTEX
>       if (qatomic_read(&ev->value) != EV_SET) {
>           int old = qatomic_xchg(&ev->value, EV_SET);
> 
> @@ -71,7 +67,8 @@ void qemu_event_set(QemuEvent *ev)
>       }
>   #else
>       pthread_mutex_lock(&ev->lock);
> -    qatomic_set(&ev->value, EV_SET);
> +    /* Pairs with qemu_event_reset()'s load acquire.  */
> +    qatomic_store_release(&ev->value, EV_SET);
>       pthread_cond_broadcast(&ev->cond);
>       pthread_mutex_unlock(&ev->lock);
>   #endif
> @@ -81,6 +78,7 @@ void qemu_event_reset(QemuEvent *ev)
>   {
>       assert(ev->initialized);
> 
> +#ifdef HAVE_FUTEX
>       /*
>        * If there was a concurrent reset (or even reset+wait),
>        * do nothing.  Otherwise change EV_SET->EV_FREE.
> @@ -92,6 +90,28 @@ void qemu_event_reset(QemuEvent *ev)
>        * Pairs with the first memory barrier in qemu_event_set().
>        */
>       smp_mb__after_rmw();
> +#else
> +    /*
> +     * If futexes are not available, there are no EV_FREE->EV_BUSY
> +     * transitions because wakeups are done entirely through the
> +     * condition variable.  Since qatomic_set() always writes EV_FREE
> +     * the load seems useless, but in reality its acquire synchronizes
> +     * with qemu_event_set()'s store-release: if qemu_event_reset()
> +     * sees EV_SET here, then the caller will certainly see a
> +     * successful condition and skip qemu_event_wait():
> +     *
> +     * done = 1;                 if (done == 0)
> +     * qemu_event_set() {          qemu_event_reset() {
> +     *   lock();
> +     *   ev->value = EV_SET ----->     v = ev->value
> +     *                                 ev->value = v | EV_FREE
> +     *   cond_broadcast()
> +     *   unlock();                 }
> +     * }                           if (done == 0)
> +     *                               // qemu_event_wait() not called
> +     */
> +    qatomic_set(&ev->value, qatomic_load_acquire(&ev->value) | EV_FREE);
> +#endif
>   }
> 
>   void qemu_event_wait(QemuEvent *ev)
> 
> 
> You don't need to post v4 (which would include the above diff in
> this patch, in qemu-thread-posix.c); I can post the above change
> as a follow up too.  What you have now is not wrong, it's only the
> explanation that isn't too precise.

Honestly, I do not understand why smp_mb() is placed here even in the 
futex case. The comment says:
 > qemu_event_set has release semantics, but because it *loads*
 > ev->value we need a full memory barrier here.

The barrier is indeed followed by a load: qatomic_read(&ev->value) != EV_SET
However, the caller of qemu_event_set() should not care whether the 
event is already set or not, so I'm not sure if smp_mb() is needed in 
the first place.

Perhaps what is missing here is a clear documentation of concurrency 
semantics of these functions. In my understanding, these functions need 
to satisfy the following semantics:

qemu_event_set(): release *if the event is not already set*; otherwise 
it has no effect on synchronization so we don't need a barrier either.

qemu_event_reset(): acquire; this enables checking the state for the 
event set before resetting.

qemu_event_wait(): acquire

Regards,
Akihiko Odaki

