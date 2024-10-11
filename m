Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7CA8CCFD31E
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Oct 2024 10:34:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1szCyA-0008Vr-4d; Fri, 11 Oct 2024 06:34:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1szCy8-0008Vj-Oi
 for qemu-devel@nongnu.org; Fri, 11 Oct 2024 06:34:00 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1szCy5-0002Mo-M7
 for qemu-devel@nongnu.org; Fri, 11 Oct 2024 06:34:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1728642836;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=uRqvm8Gf8/xc+htbSVUQOyCLGO5AQrNEXnvtainRDBc=;
 b=i6m/kth7yOvLfvm0WFrnhrf3UihEhgQbiFt7EFTXStEcQZ+wI/ui1GgoNwQGf6DIF1fxJP
 PAB2GOhfJe3v3VnCxhO0oXw06Er0ZWv/LhCDpKKg+kTFNKPgfWNUErmTTmbMJh2KcAMgsd
 GR79Zo0lOmmKnx1fXykTot6W7twXax0=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-393-iXBJszhhNq2Ft6Lfv1gvuQ-1; Fri, 11 Oct 2024 06:33:54 -0400
X-MC-Unique: iXBJszhhNq2Ft6Lfv1gvuQ-1
Received: by mail-ej1-f70.google.com with SMTP id
 a640c23a62f3a-a993dc3d6e2so147374066b.0
 for <qemu-devel@nongnu.org>; Fri, 11 Oct 2024 03:33:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728642832; x=1729247632;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=uRqvm8Gf8/xc+htbSVUQOyCLGO5AQrNEXnvtainRDBc=;
 b=L7RvPvBUjPpieZDocSComQ8kqRTjNtjAB7GwSaT4OFM80vKZh+gDlh0FWr9weWMbU3
 c96H+rWazRzC9I1XsLpptV6f2CZa7SQwzSTZTExyhzykoCxVVmVgEg/NTpoUtY8hmwB5
 4261LIV6VxRRJi7LIqXBT6FBCNXQ+v0U4/4BFsKyjatb2G5nl9DHqtchrH/Nbs+FNJSF
 SGhsUt9YPci0Q4zcB0nEairwKrRXY3VR6TjQ41REtrgs8mBRvE0esx3cJ8F0p+os7k6p
 yYZfWeJN81zFrxoPFqvHuRXJszwXgGOcGqVl7udO1grzh3KiluRqmi3b18sezlUpGMAv
 zzDw==
X-Forwarded-Encrypted: i=1;
 AJvYcCW9UQ8bHb/MEHO3mDgu5rPaOhRMpvC9yDV3LNaCQbJfglPt8SpKiH6IH1RBQ+E4T/uudZsEhdw2+ZzY@nongnu.org
X-Gm-Message-State: AOJu0YwJUd5KjM297/mAy7PTHW5hdTLpkq0zaPjLRF/htkKmS01MkHmV
 iKLYGnq+58k7tA2YV0S1ZashnSVDg9gDe6fL9Hx7H7eQsuHqGZNo1S4q7aiXBuXKfOZBIHhVdFV
 pWiWGioF2rnJsuPgO3Q9aPOgH/p/VgX/fSrYJgO/XKkczb/GAUgteDaEl9N85OWM=
X-Received: by 2002:a17:907:e292:b0:a99:7736:f14 with SMTP id
 a640c23a62f3a-a99b966a23cmr176039566b.52.1728642832251; 
 Fri, 11 Oct 2024 03:33:52 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFEipS9yEK3CAYhTaOozQvgRnmU6V62AUdkwPd8vW0m68BbfHPnrmTjzGQg/2D2cG8irMC0UQ==
X-Received: by 2002:a17:907:e292:b0:a99:7736:f14 with SMTP id
 a640c23a62f3a-a99b966a23cmr176036666b.52.1728642831647; 
 Fri, 11 Oct 2024 03:33:51 -0700 (PDT)
Received: from [192.168.10.81] ([151.81.124.37])
 by smtp.googlemail.com with ESMTPSA id
 a640c23a62f3a-a99a7ec5747sm198611266b.37.2024.10.11.03.33.49
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 11 Oct 2024 03:33:50 -0700 (PDT)
Message-ID: <d6e0a128-b596-46d4-b3e6-5b10d0ce568f@redhat.com>
Date: Fri, 11 Oct 2024 12:33:49 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6/7] include: Move QemuLockCnt APIs to their own header
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>
References: <20240816132212.3602106-1-peter.maydell@linaro.org>
 <20240816132212.3602106-7-peter.maydell@linaro.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Content-Language: en-US
Autocrypt: addr=pbonzini@redhat.com; keydata=
 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
In-Reply-To: <20240816132212.3602106-7-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.149,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On 8/16/24 15:22, Peter Maydell wrote:
> Currently the QemuLockCnt data structure and associated functions are
> in the include/qemu/thread.h header.  Move them to their own
> qemu/lockcnt.h.  The main reason for doing this is that it means we
> can autogenerate the documentation comments into the docs/devel
> documentation.
> 
> The copyright/author in the new header is drawn from lockcnt.c,
> since the header changes were added in the same commit as
> lockcnt.c; since neither thread.h nor lockcnt.c state an explicit
> license, the standard default of GPL-2-or-later applies.
> 
> We include the new header (and the .c file, which was accidentally
> omitted previously) in the "RCU" part of MAINTAINERS, since that
> is where the lockcnt.rst documentation is categorized.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>

Acked-by: Paolo Bonzini <pbonzini@redhat.com>

Yeah, GPLv2+ is intended for both these declarations and lockcnt.c.

Thanks,

Paolo

> ---
> Paolo: could you confirm that you meant GPL2+ for this code?
> ---
>   MAINTAINERS            |   2 +
>   docs/devel/lockcnt.rst |   2 +-
>   include/block/aio.h    |   1 +
>   include/hw/core/cpu.h  |   1 +
>   include/qemu/lockcnt.h | 130 +++++++++++++++++++++++++++++++++++++++++
>   include/qemu/thread.h  | 111 -----------------------------------
>   accel/accel-blocker.c  |   1 +
>   hw/core/cpu-common.c   |   1 +
>   util/aio-posix.c       |   1 +
>   util/aio-win32.c       |   1 +
>   util/async.c           |   1 +
>   util/fdmon-epoll.c     |   1 +
>   util/lockcnt.c         |   1 +
>   13 files changed, 142 insertions(+), 112 deletions(-)
>   create mode 100644 include/qemu/lockcnt.h
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index f8f4df44460..2da11411ff3 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -3115,8 +3115,10 @@ S: Maintained
>   F: docs/devel/lockcnt.rst
>   F: docs/devel/rcu.rst
>   F: include/qemu/rcu*.h
> +F: include/qemu/lockcnt.h
>   F: tests/unit/rcutorture.c
>   F: tests/unit/test-rcu-*.c
> +F: util/lockcnt.c
>   F: util/rcu.c
>   
>   Human Monitor (HMP)
> diff --git a/docs/devel/lockcnt.rst b/docs/devel/lockcnt.rst
> index 994aeb57151..728594bcea3 100644
> --- a/docs/devel/lockcnt.rst
> +++ b/docs/devel/lockcnt.rst
> @@ -175,7 +175,7 @@ three instructions in the critical path, two assignments and a ``smp_wmb()``.
>   ``QemuLockCnt`` API
>   -------------------
>   
> -The ``QemuLockCnt`` API is described in ``include/qemu/thread.h``.
> +The ``QemuLockCnt`` API is described in ``include/qemu/lockcnt.h``.
>   
>   
>   ``QemuLockCnt`` usage
> diff --git a/include/block/aio.h b/include/block/aio.h
> index 4ee81936ed5..43883a8a33a 100644
> --- a/include/block/aio.h
> +++ b/include/block/aio.h
> @@ -20,6 +20,7 @@
>   #include "qemu/coroutine-core.h"
>   #include "qemu/queue.h"
>   #include "qemu/event_notifier.h"
> +#include "qemu/lockcnt.h"
>   #include "qemu/thread.h"
>   #include "qemu/timer.h"
>   #include "block/graph-lock.h"
> diff --git a/include/hw/core/cpu.h b/include/hw/core/cpu.h
> index 1c9c775df65..ecbeeb1c0dd 100644
> --- a/include/hw/core/cpu.h
> +++ b/include/hw/core/cpu.h
> @@ -33,6 +33,7 @@
>   #include "qemu/bitmap.h"
>   #include "qemu/rcu_queue.h"
>   #include "qemu/queue.h"
> +#include "qemu/lockcnt.h"
>   #include "qemu/thread.h"
>   #include "qom/object.h"
>   
> diff --git a/include/qemu/lockcnt.h b/include/qemu/lockcnt.h
> new file mode 100644
> index 00000000000..2c92ae17c9e
> --- /dev/null
> +++ b/include/qemu/lockcnt.h
> @@ -0,0 +1,130 @@
> +/* SPDX-License-Identifier: GPL-2.0-or-later */
> +/*
> + * QemuLockCnt implementation
> + *
> + * Copyright Red Hat, Inc. 2017
> + *
> + * Author:
> + *   Paolo Bonzini <pbonzini@redhat.com>
> + *
> + */
> +
> +#ifndef QEMU_LOCKCNT_H
> +#define QEMU_LOCKCNT_H
> +
> +#include "qemu/thread.h"
> +
> +typedef struct QemuLockCnt QemuLockCnt;
> +
> +struct QemuLockCnt {
> +#ifndef CONFIG_LINUX
> +    QemuMutex mutex;
> +#endif
> +    unsigned count;
> +};
> +
> +/**
> + * qemu_lockcnt_init: initialize a QemuLockcnt
> + * @lockcnt: the lockcnt to initialize
> + *
> + * Initialize lockcnt's counter to zero and prepare its mutex
> + * for usage.
> + */
> +void qemu_lockcnt_init(QemuLockCnt *lockcnt);
> +
> +/**
> + * qemu_lockcnt_destroy: destroy a QemuLockcnt
> + * @lockcnt: the lockcnt to destruct
> + *
> + * Destroy lockcnt's mutex.
> + */
> +void qemu_lockcnt_destroy(QemuLockCnt *lockcnt);
> +
> +/**
> + * qemu_lockcnt_inc: increment a QemuLockCnt's counter
> + * @lockcnt: the lockcnt to operate on
> + *
> + * If the lockcnt's count is zero, wait for critical sections
> + * to finish and increment lockcnt's count to 1.  If the count
> + * is not zero, just increment it.
> + *
> + * Because this function can wait on the mutex, it must not be
> + * called while the lockcnt's mutex is held by the current thread.
> + * For the same reason, qemu_lockcnt_inc can also contribute to
> + * AB-BA deadlocks.  This is a sample deadlock scenario:
> + *
> + *            thread 1                      thread 2
> + *            -------------------------------------------------------
> + *            qemu_lockcnt_lock(&lc1);
> + *                                          qemu_lockcnt_lock(&lc2);
> + *            qemu_lockcnt_inc(&lc2);
> + *                                          qemu_lockcnt_inc(&lc1);
> + */
> +void qemu_lockcnt_inc(QemuLockCnt *lockcnt);
> +
> +/**
> + * qemu_lockcnt_dec: decrement a QemuLockCnt's counter
> + * @lockcnt: the lockcnt to operate on
> + */
> +void qemu_lockcnt_dec(QemuLockCnt *lockcnt);
> +
> +/**
> + * qemu_lockcnt_dec_and_lock: decrement a QemuLockCnt's counter and
> + * possibly lock it.
> + * @lockcnt: the lockcnt to operate on
> + *
> + * Decrement lockcnt's count.  If the new count is zero, lock
> + * the mutex and return true.  Otherwise, return false.
> + */
> +bool qemu_lockcnt_dec_and_lock(QemuLockCnt *lockcnt);
> +
> +/**
> + * qemu_lockcnt_dec_if_lock: possibly decrement a QemuLockCnt's counter and
> + * lock it.
> + * @lockcnt: the lockcnt to operate on
> + *
> + * If the count is 1, decrement the count to zero, lock
> + * the mutex and return true.  Otherwise, return false.
> + */
> +bool qemu_lockcnt_dec_if_lock(QemuLockCnt *lockcnt);
> +
> +/**
> + * qemu_lockcnt_lock: lock a QemuLockCnt's mutex.
> + * @lockcnt: the lockcnt to operate on
> + *
> + * Remember that concurrent visits are not blocked unless the count is
> + * also zero.  You can use qemu_lockcnt_count to check for this inside a
> + * critical section.
> + */
> +void qemu_lockcnt_lock(QemuLockCnt *lockcnt);
> +
> +/**
> + * qemu_lockcnt_unlock: release a QemuLockCnt's mutex.
> + * @lockcnt: the lockcnt to operate on.
> + */
> +void qemu_lockcnt_unlock(QemuLockCnt *lockcnt);
> +
> +/**
> + * qemu_lockcnt_inc_and_unlock: combined unlock/increment on a QemuLockCnt.
> + * @lockcnt: the lockcnt to operate on.
> + *
> + * This is the same as
> + *
> + *     qemu_lockcnt_unlock(lockcnt);
> + *     qemu_lockcnt_inc(lockcnt);
> + *
> + * but more efficient.
> + */
> +void qemu_lockcnt_inc_and_unlock(QemuLockCnt *lockcnt);
> +
> +/**
> + * qemu_lockcnt_count: query a LockCnt's count.
> + * @lockcnt: the lockcnt to query.
> + *
> + * Note that the count can change at any time.  Still, while the
> + * lockcnt is locked, one can usefully check whether the count
> + * is non-zero.
> + */
> +unsigned qemu_lockcnt_count(QemuLockCnt *lockcnt);
> +
> +#endif
> diff --git a/include/qemu/thread.h b/include/qemu/thread.h
> index fb74e21c08a..7eba27a7049 100644
> --- a/include/qemu/thread.h
> +++ b/include/qemu/thread.h
> @@ -293,115 +293,4 @@ static inline void qemu_spin_unlock(QemuSpin *spin)
>   #endif
>   }
>   
> -struct QemuLockCnt {
> -#ifndef CONFIG_LINUX
> -    QemuMutex mutex;
> -#endif
> -    unsigned count;
> -};
> -
> -/**
> - * qemu_lockcnt_init: initialize a QemuLockcnt
> - * @lockcnt: the lockcnt to initialize
> - *
> - * Initialize lockcnt's counter to zero and prepare its mutex
> - * for usage.
> - */
> -void qemu_lockcnt_init(QemuLockCnt *lockcnt);
> -
> -/**
> - * qemu_lockcnt_destroy: destroy a QemuLockcnt
> - * @lockcnt: the lockcnt to destruct
> - *
> - * Destroy lockcnt's mutex.
> - */
> -void qemu_lockcnt_destroy(QemuLockCnt *lockcnt);
> -
> -/**
> - * qemu_lockcnt_inc: increment a QemuLockCnt's counter
> - * @lockcnt: the lockcnt to operate on
> - *
> - * If the lockcnt's count is zero, wait for critical sections
> - * to finish and increment lockcnt's count to 1.  If the count
> - * is not zero, just increment it.
> - *
> - * Because this function can wait on the mutex, it must not be
> - * called while the lockcnt's mutex is held by the current thread.
> - * For the same reason, qemu_lockcnt_inc can also contribute to
> - * AB-BA deadlocks.  This is a sample deadlock scenario:
> - *
> - *            thread 1                      thread 2
> - *            -------------------------------------------------------
> - *            qemu_lockcnt_lock(&lc1);
> - *                                          qemu_lockcnt_lock(&lc2);
> - *            qemu_lockcnt_inc(&lc2);
> - *                                          qemu_lockcnt_inc(&lc1);
> - */
> -void qemu_lockcnt_inc(QemuLockCnt *lockcnt);
> -
> -/**
> - * qemu_lockcnt_dec: decrement a QemuLockCnt's counter
> - * @lockcnt: the lockcnt to operate on
> - */
> -void qemu_lockcnt_dec(QemuLockCnt *lockcnt);
> -
> -/**
> - * qemu_lockcnt_dec_and_lock: decrement a QemuLockCnt's counter and
> - * possibly lock it.
> - * @lockcnt: the lockcnt to operate on
> - *
> - * Decrement lockcnt's count.  If the new count is zero, lock
> - * the mutex and return true.  Otherwise, return false.
> - */
> -bool qemu_lockcnt_dec_and_lock(QemuLockCnt *lockcnt);
> -
> -/**
> - * qemu_lockcnt_dec_if_lock: possibly decrement a QemuLockCnt's counter and
> - * lock it.
> - * @lockcnt: the lockcnt to operate on
> - *
> - * If the count is 1, decrement the count to zero, lock
> - * the mutex and return true.  Otherwise, return false.
> - */
> -bool qemu_lockcnt_dec_if_lock(QemuLockCnt *lockcnt);
> -
> -/**
> - * qemu_lockcnt_lock: lock a QemuLockCnt's mutex.
> - * @lockcnt: the lockcnt to operate on
> - *
> - * Remember that concurrent visits are not blocked unless the count is
> - * also zero.  You can use qemu_lockcnt_count to check for this inside a
> - * critical section.
> - */
> -void qemu_lockcnt_lock(QemuLockCnt *lockcnt);
> -
> -/**
> - * qemu_lockcnt_unlock: release a QemuLockCnt's mutex.
> - * @lockcnt: the lockcnt to operate on.
> - */
> -void qemu_lockcnt_unlock(QemuLockCnt *lockcnt);
> -
> -/**
> - * qemu_lockcnt_inc_and_unlock: combined unlock/increment on a QemuLockCnt.
> - * @lockcnt: the lockcnt to operate on.
> - *
> - * This is the same as
> - *
> - *     qemu_lockcnt_unlock(lockcnt);
> - *     qemu_lockcnt_inc(lockcnt);
> - *
> - * but more efficient.
> - */
> -void qemu_lockcnt_inc_and_unlock(QemuLockCnt *lockcnt);
> -
> -/**
> - * qemu_lockcnt_count: query a LockCnt's count.
> - * @lockcnt: the lockcnt to query.
> - *
> - * Note that the count can change at any time.  Still, while the
> - * lockcnt is locked, one can usefully check whether the count
> - * is non-zero.
> - */
> -unsigned qemu_lockcnt_count(QemuLockCnt *lockcnt);
> -
>   #endif
> diff --git a/accel/accel-blocker.c b/accel/accel-blocker.c
> index e083f24aa80..75daaa29113 100644
> --- a/accel/accel-blocker.c
> +++ b/accel/accel-blocker.c
> @@ -25,6 +25,7 @@
>    */
>   
>   #include "qemu/osdep.h"
> +#include "qemu/lockcnt.h"
>   #include "qemu/thread.h"
>   #include "qemu/main-loop.h"
>   #include "hw/core/cpu.h"
> diff --git a/hw/core/cpu-common.c b/hw/core/cpu-common.c
> index 7982ecd39a5..09c79035949 100644
> --- a/hw/core/cpu-common.c
> +++ b/hw/core/cpu-common.c
> @@ -24,6 +24,7 @@
>   #include "sysemu/hw_accel.h"
>   #include "qemu/log.h"
>   #include "qemu/main-loop.h"
> +#include "qemu/lockcnt.h"
>   #include "exec/log.h"
>   #include "exec/gdbstub.h"
>   #include "sysemu/tcg.h"
> diff --git a/util/aio-posix.c b/util/aio-posix.c
> index 266c9dd35fa..06bf9f456cf 100644
> --- a/util/aio-posix.c
> +++ b/util/aio-posix.c
> @@ -17,6 +17,7 @@
>   #include "block/block.h"
>   #include "block/thread-pool.h"
>   #include "qemu/main-loop.h"
> +#include "qemu/lockcnt.h"
>   #include "qemu/rcu.h"
>   #include "qemu/rcu_queue.h"
>   #include "qemu/sockets.h"
> diff --git a/util/aio-win32.c b/util/aio-win32.c
> index d144f9391fb..6583d5c5f31 100644
> --- a/util/aio-win32.c
> +++ b/util/aio-win32.c
> @@ -18,6 +18,7 @@
>   #include "qemu/osdep.h"
>   #include "block/block.h"
>   #include "qemu/main-loop.h"
> +#include "qemu/lockcnt.h"
>   #include "qemu/queue.h"
>   #include "qemu/sockets.h"
>   #include "qapi/error.h"
> diff --git a/util/async.c b/util/async.c
> index 3e3e4fc7126..99db28389f6 100644
> --- a/util/async.c
> +++ b/util/async.c
> @@ -30,6 +30,7 @@
>   #include "block/graph-lock.h"
>   #include "qemu/main-loop.h"
>   #include "qemu/atomic.h"
> +#include "qemu/lockcnt.h"
>   #include "qemu/rcu_queue.h"
>   #include "block/raw-aio.h"
>   #include "qemu/coroutine_int.h"
> diff --git a/util/fdmon-epoll.c b/util/fdmon-epoll.c
> index c6413cb18fe..9fb8800dde8 100644
> --- a/util/fdmon-epoll.c
> +++ b/util/fdmon-epoll.c
> @@ -5,6 +5,7 @@
>   
>   #include "qemu/osdep.h"
>   #include <sys/epoll.h>
> +#include "qemu/lockcnt.h"
>   #include "qemu/rcu_queue.h"
>   #include "aio-posix.h"
>   
> diff --git a/util/lockcnt.c b/util/lockcnt.c
> index 5da36946b1b..d07c6cc5cee 100644
> --- a/util/lockcnt.c
> +++ b/util/lockcnt.c
> @@ -7,6 +7,7 @@
>    *   Paolo Bonzini <pbonzini@redhat.com>
>    */
>   #include "qemu/osdep.h"
> +#include "qemu/lockcnt.h"
>   #include "qemu/thread.h"
>   #include "qemu/atomic.h"
>   #include "trace.h"


