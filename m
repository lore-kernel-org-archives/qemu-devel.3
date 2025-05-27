Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E31BC5AE59
	for <qemu-devel@archiver.kernel.org>; Tue, 27 May 2025 03:01:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uJkZ9-0004Im-9B; Mon, 26 May 2025 23:01:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1uJkZ3-0004IP-8g
 for qemu-devel@nongnu.org; Mon, 26 May 2025 23:01:17 -0400
Received: from mail-qt1-x82e.google.com ([2607:f8b0:4864:20::82e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1uJkZ1-0002zK-4o
 for qemu-devel@nongnu.org; Mon, 26 May 2025 23:01:17 -0400
Received: by mail-qt1-x82e.google.com with SMTP id
 d75a77b69052e-4811fca8658so34351671cf.3
 for <qemu-devel@nongnu.org>; Mon, 26 May 2025 20:01:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1748314874; x=1748919674;
 darn=nongnu.org; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=X5q3WGTFS4MNrWs6s5H+7XaPGDI8+4YUcG9TDgq2HWw=;
 b=2OjzUgaMBPtDERIPuUEb6GCMdtVYq6eG6RsU18Ened43r1nYbSdvPRNg0DLBdqxE52
 VPlESLcsDFzCWSYZMvV2MS1VGomn8kzS5JJ7S+JawKjGV/ZtQVwfitG8l5xLMxTedHZe
 QEbVqr4PhxaaqV4q5QfL+d3HxGibmTC28SiZoEYAt0ZeD/Jt7mndoKGRVAS7eNTkW+qk
 MOW47hWMUnKwUa32GFZuML5eQh0zcRvKP75f6gPJSAFIXHOZpyA89wM+vej5CCCjfaPS
 MpgrmTBnw+8zDyAokFicJ81JYfd1A25YWvS7oZaYJ/gatLDvTz4JBw2eZXhEYmHAHEKW
 xGEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748314874; x=1748919674;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=X5q3WGTFS4MNrWs6s5H+7XaPGDI8+4YUcG9TDgq2HWw=;
 b=TAcDTCZ5lFWCOQxiS7x2C6jksQK0tB/I+ODajYQL/KCN7IHls0gbiB8ldP/7Q4q0wJ
 8cMCkuA2PpttIXaghuzgPLN3r4pT1nBhO0TeBXan79c236muAr0fc4XQ7c3+p9vuZg31
 eiI0aIuN1M7PeBJMs6EBiiIUe/xCBd/cO2u/XMFaMSnO0TJpA+WZaEwYPEwvJzqilTkh
 BphXtLvUqGfW+8dQG3RS28FIx83TeFl6pbGQL3XjL3b5RW9j/H90redHvYeF2roYk2RT
 EAN9wwVJ46K/UBrq/cRIlksq8ngI46Ugc/Cl/aIiAXHt347u8lMeuBGilFrdhTvs/bqC
 4TTg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXGMJ6eW8sWNi13DVMxloAssSIGH+RkwF84IGTbsZ1CWuQWe/qX5oiBLAyT5rq1O0gq4fTOutceqllr@nongnu.org
X-Gm-Message-State: AOJu0YxfKOQ+gri67TykJp/4yDxkyDZAq59fMDrtTpg/raVjvNH8JQDp
 iIE7hgQSYw09thZRB58/7amwWeb0bD9OcIEBqjg8cCyHMfQJO1aFciLVUDecG8+HhGECKTcnngS
 EGBmU
X-Gm-Gg: ASbGncsiE5lulM/PvVcun7BW6nErqKIb88ih9yhzVQC9vFMKGRJe0kqZiy2aLjD3571
 Src2fo3TDu7B1jiXXaFkoqwAQbczQ9oDxLM760i8VCUTnQwTcufNqAccLR5SrR8NgOO+eCZdn0q
 IQcKqJ5WI1pLIDCwsqJyvbmoq4x2zYbvn9L1oVMIp5K7hIAcCCvyPS7UvNiXoHCaVhqn1jp/d/v
 ECdiVXoNDKNLvIhIXBIcXQKc9cYV47cXlQTvBkYq9F0C8+7ksujLhOBrPsgAIPRyOWjnOKpCQoh
 ivQFcswcRjubN+zUjnhC1Qf4VdYj3VM81uM3tgd97/ZPxG9+RYwraVqQ10tqNA==
X-Google-Smtp-Source: AGHT+IEM/3wnITCEkxnczls0DbkQEytqh6aL4/KjcqOOCqPPucTQRER0x1wj65L/YBlMzenvcNZ6pw==
X-Received: by 2002:a17:903:1d0:b0:233:fbb3:c5c1 with SMTP id
 d9443c01a7336-23415000aecmr167414975ad.46.1748314863382; 
 Mon, 26 May 2025 20:01:03 -0700 (PDT)
Received: from [10.100.116.185] ([157.82.128.1])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-23449ce4839sm31071765ad.37.2025.05.26.20.01.00
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 26 May 2025 20:01:03 -0700 (PDT)
Message-ID: <a8d508a2-7369-4ccd-a6a7-7c74b38c962a@daynix.com>
Date: Tue, 27 May 2025 12:00:59 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 00/11] Improve futex usage
To: Paolo Bonzini <pbonzini@redhat.com>, Stefan Weil <sw@weilnetz.de>,
 Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Hailiang Zhang <zhanghailiang@xfusion.com>
Cc: Phil Dennis-Jordan <phil@philjordan.eu>, qemu-devel@nongnu.org,
 devel@daynix.com, =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?=
 <marcandre.lureau@redhat.com>, =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?=
 <berrange@redhat.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>
References: <20250526-event-v4-0-5b784cc8e1de@daynix.com>
 <9461fc05-3c1d-4236-a0b7-99f39781f278@redhat.com>
Content-Language: en-US
From: Akihiko Odaki <akihiko.odaki@daynix.com>
In-Reply-To: <9461fc05-3c1d-4236-a0b7-99f39781f278@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::82e;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-qt1-x82e.google.com
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

On 2025/05/27 1:51, Paolo Bonzini wrote:
> On 5/26/25 07:29, Akihiko Odaki wrote:
>> Changes in v4:
>> - Added patch "qemu-thread: Remove qatomic_read() in qemu_event_set()".
> 
> Hi Akihiko,
> 
> I'm not so confident about putting this patch before the other changes;
> I'm referring basically to this hunk:
> 
> diff --git a/util/event.c b/util/event.c
> index 366c77c90cf..663b7042b17 100644
> --- a/util/event.c
> +++ b/util/event.c
> @@ -48,22 +48,9 @@ void qemu_event_set(QemuEvent *ev)
>       assert(ev->initialized);
> 
>   #ifdef HAVE_FUTEX
> -    /*
> -     * Pairs with both qemu_event_reset() and qemu_event_wait().
> -     *
> -     * qemu_event_set has release semantics, but because it *loads*
> -     * ev->value we need a full memory barrier here.
> -     */
> -    smp_mb();
> -    if (qatomic_read(&ev->value) != EV_SET) {
> -        int old = qatomic_xchg(&ev->value, EV_SET);
> -
> -        /* Pairs with memory barrier in kernel futex_wait system call.  */
> -        smp_mb__after_rmw();
> -        if (old == EV_BUSY) {
> -            /* There were waiters, wake them up.  */
> -            qemu_futex_wake_all(ev);
> -        }
> +    if (qatomic_xchg(&ev->value, EV_SET) == EV_BUSY) {
> +        /* There were waiters, wake them up.  */
> +        qemu_futex_wake_all(ev);
>       }
>   #else
>       pthread_mutex_lock(&ev->lock);
> 
> 
> ... feel free to resubmit that separately, also because it's missing
> a smp_mb__before_rmw().

I'd like to submit it with "[PATCH v4 05/11] qemu-thread: Avoid futex 
abstraction for non-Linux" because it aligns the implementations of 
Linux and non-Linux versions to rely on a store-release of EV_SET in 
qemu_event_set().

smp_mb__before_rmw() is removed with "[PATCH v4 01/11] futex: Check 
value after qemu_futex_wait()" because the fact mentioned with the 
comment "Pairs with memory barrier in kernel futex_wait system call" is 
no longer relevant; the patch makes QEMU always rely on 
qatomic_load_acquire() or qatomic_cmpxchg() to perform a load-acquire of 
EV_SET for ordering.

In either case, I can simply that say the ordering between 
qemu_event_set() and qemu_event_wait() are ensured by load-acquire and 
store-release operations of EV_SET, but to make the correctness 
absolutely sure, I recommend to look at my past explanation:
https://lore.kernel.org/qemu-devel/ab6b66d7-fa8c-4049-9a3b-975f7f9c06ab@daynix.com

The explanation is long but so comprehensive that it lists all memory 
accesses, ordering requirements, and features of atomic primitives and 
futex employed to satisfy the requirements.

> 
> 
> Also, I'm not sure what was your opinion of the more optimized version
> of qemu_event_reset:
> 
> diff --git a/util/event.c b/util/event.c
> index 366c77c90cf..663b7042b17 100644
> --- a/util/event.c
> +++ b/util/event.c
> @@ -78,6 +78,7 @@ void qemu_event_reset(QemuEvent *ev)
>   {
>       assert(ev->initialized);
> 
> +#ifdef HAVE_FUTEX
>       /*
>        * If there was a concurrent reset (or even reset+wait),
>        * do nothing.  Otherwise change EV_SET->EV_FREE.
> @@ -86,6 +87,28 @@ void qemu_event_reset(QemuEvent *ev)
>        */
>       smp_mb__after_rmw();
> +#else
> +    /*
> +     * If futexes are not available, there are no EV_FREE->EV_BUSY
> +     * transitions because wakeups are done entirely through the
> +     * condition variable.  Since qatomic_set() only writes EV_FREE,
> +     * the load seems useless but in reality, the acquire synchronizes
> +     * with qemu_event_set()'s store release: if qemu_event_reset()
> +     * sees EV_SET here, then the caller will certainly see a
> +     * successful condition and skip qemu_event_wait():
> +     *
> +     * done = 1;                 if (done == 0)
> +     * qemu_event_set() {          qemu_event_reset() {
> +     *   lock();
> +     *   ev->value = EV_SET ----->     load ev->value
> +     *                                 ev->value = old value | EV_FREE
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
> Do you think it's incorrect?  I'll wait for your answer before sending
> out the actual pull request.

It's correct, but I don't think it's worthwhile.

This code path is only used by platforms without a futex wrapper. 
Currently we only have one for Linux and this series adds one for 
Windows, but FreeBSD[1] and OpenBSD[2] have their own futex. macOS also 
gained one with version 14.4.[3] We can add wrappers for them too if 
their performance really matters.

So the only platforms listed in docs/about/build-platforms.rst that 
require the non-futex version are macOS older than 14.4 and NetBSD. 
macOS older than 14.4 will not be supported after June 5 since macOS 14 
was released June 5, 2023 and docs/about/build-platforms.rst says:

 > Support for the previous major version will be dropped 2 years after
 > the new major version is released or when the vendor itself drops
 > support, whichever comes first.

 > Within each major release, only the most recent minor release is
 > considered.

There are too few relevant platforms to justify the effort potentially 
needed for quality assurance.

Moreover, qemu_event_reset() is often followed by qemu_event_wait() or 
other barriers so probably relaxing ordering here does not affect the 
overall ordering constraint (and performance) much.

Regards,
Akihiko Odaki

[1] 
https://man.freebsd.org/cgi/man.cgi?query=_umtx_op&apropos=0&sektion=2&manpath=FreeBSD+14.2-RELEASE&arch=default&format=html
[2] https://man.openbsd.org/futex
[3] 
https://developer.apple.com/documentation/os/synchronization?language=objc#Futex-Conditional-Wait-Primitives

