Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F184C3ABD8
	for <qemu-devel@archiver.kernel.org>; Fri, 16 May 2025 12:59:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uFueF-000613-K2; Fri, 16 May 2025 08:58:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1uFue5-0005zz-11
 for qemu-devel@nongnu.org; Fri, 16 May 2025 08:58:37 -0400
Received: from mail-pf1-x42f.google.com ([2607:f8b0:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1uFue1-0001CS-Gr
 for qemu-devel@nongnu.org; Fri, 16 May 2025 08:58:36 -0400
Received: by mail-pf1-x42f.google.com with SMTP id
 d2e1a72fcca58-742af84818cso355959b3a.1
 for <qemu-devel@nongnu.org>; Fri, 16 May 2025 05:58:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1747400311; x=1748005111;
 darn=nongnu.org; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=b8s+JtZ932CtugIN22jXC5Ai3CgCrddx5V3y9bkGGic=;
 b=r6hWFSSeY08L5wPe6B6mD4mnXUqDtJlROsjFYA2MqclbiTgg8CFyNNsQxl16Zycad8
 Y0KrNlxC3sYUl8p7vNhf6U1yDEu48vl5bf7Wj4Db57Xp6LlRsOTi446u+YNWATLdp/4g
 tYbx73BPIIjHw6BPzAcSBUQpv4dnkQhfEQRNO51gcTQ/CbL8CA3kU5jlyAOWO3W8MzZA
 wDxVy1vVERdPTgB4J0ZwJusxGVBJzbDgBilVZBWNc7hia4cyk/knzg9AA5DaHCpxaV05
 iWbrvwJw/ROkl2S6DpOeJg5lN59rK/ibilKHOxNH6DAgP5N0kzAeufTCfxHYWOsIybgE
 eMjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747400311; x=1748005111;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=b8s+JtZ932CtugIN22jXC5Ai3CgCrddx5V3y9bkGGic=;
 b=aHI7l5dWcReBo6Ipe3v57uWj0aVc5mrDZBtRLoB17sqJ7qfknKDkBWwQBA3Vym0K1f
 h9BqgTpwj3e33IUV+SoIX0+N95JXjjDUyTDb9FJSO/8PSs09Debgco8wHbeyqs8GpQWS
 EH6peUXbCglD2zt6eAJ3iENAoPDKU1346h6mH0OUviOgxSQA/dXazIX8I0Kw2DxCiAsM
 +C6q/5NFUJDHJ8y+5YQQ8eK8ureZ4oEfvsDi+0qkAd3rUKDyLroAVum7pIQEs/X0mV1o
 fX9eH7GKcUWJdFq1jQsAl5JUoAxq5FoHPIgmKnAsyKOAXiSQPXZ7S4P6cRxUfK+Jccj/
 ILpA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXon5Nb7RcEREp/IKjInJQsakEoo/Zz9fZzSybUOAx9j+naTopnYYVSh5FQvXbngfeA3qa1ryBBp3fs@nongnu.org
X-Gm-Message-State: AOJu0YwzlgUIxqm7hguFWCLnPctI8PVvo9lnAwgQ8FLiiJBo5vqxKXQc
 /xo3TLBPxI3g/tODiK5oFvBDbtUODvpFuhILF1Aa9OOrRMH5T2vwjtoh4GhpIYw1nzA=
X-Gm-Gg: ASbGncuta/kg7hQyokM3KixQUGraQJucAp9s4gv7F77RRZsoTtdPZnx08fGTeay2waj
 vzioHfddqJ7jAUzkj4o/VGgloB0YF6vSQ0/TW1wZTspQayv3EjL+j18B2ZRokWrxdovZiicwNDh
 HwGTui54qF+9WVUR4IlP3MDIA1101gNX/ZyLD7chlQWPm5mTAGBuCkk8jzBqoEzLioVBqPxF8Eo
 RkiOTj0H3eIagGDuSuheZhEUvJ9OWb6+DABpG0QpQQVXp46xwCi0M4nHzimHsAzdBMsEOtAgunH
 fo7n2x9H6veW7LSonrrnCeiZVtZcnBMy+nQZw3T3tByajqbmjNRV/33IGkesdm54
X-Google-Smtp-Source: AGHT+IF7VPkI5V79QrwuGu9qU8zJoCW3ihuUiYgWDKwmpRDDX+3Zu7u3ty/eM4Bi8Diqu90Cs/B9JA==
X-Received: by 2002:a05:6a21:3987:b0:203:c29b:eb6c with SMTP id
 adf61e73a8af0-21621882824mr5108630637.4.1747400310824; 
 Fri, 16 May 2025 05:58:30 -0700 (PDT)
Received: from [157.82.203.223] ([157.82.203.223])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-b26eb081b06sm1503652a12.52.2025.05.16.05.58.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 16 May 2025 05:58:30 -0700 (PDT)
Message-ID: <12b1dba8-ecb5-4167-841f-0a32256285d5@daynix.com>
Date: Fri, 16 May 2025 21:58:27 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 04/10] qemu-thread: Avoid futex abstraction for
 non-Linux
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Stefan Weil <sw@weilnetz.de>, Peter Xu <peterx@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Hailiang Zhang <zhanghailiang@xfusion.com>,
 Phil Dennis-Jordan <phil@philjordan.eu>, qemu-devel <qemu-devel@nongnu.org>,
 devel@daynix.com, =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?=
 <marcandre.lureau@redhat.com>, =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?=
 <berrange@redhat.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>
References: <20250511-event-v3-0-f7f69247d303@daynix.com>
 <20250511-event-v3-4-f7f69247d303@daynix.com>
 <e86aeab6-ef67-4f5a-9110-93309a77acf6@redhat.com>
 <a40b0b1d-b1f8-478d-bde4-cac386323691@daynix.com>
 <CABgObfa+sBbA3OURGm=6WGzs1TQKyaHjRj+QS3n9dUvSjEPkZw@mail.gmail.com>
Content-Language: en-US
From: Akihiko Odaki <akihiko.odaki@daynix.com>
In-Reply-To: <CABgObfa+sBbA3OURGm=6WGzs1TQKyaHjRj+QS3n9dUvSjEPkZw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42f;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pf1-x42f.google.com
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

On 2025/05/16 20:09, 'Paolo Bonzini' via devel wrote:
> 
> 
> Il mer 14 mag 2025, 08:57 Akihiko Odaki <akihiko.odaki@daynix.com 
> <mailto:akihiko.odaki@daynix.com>> ha scritto:
> 
>     Honestly, I do not understand why smp_mb() is placed here even in the
>     futex case. The comment says:
>       > qemu_event_set has release semantics, but because it *loads*
>       > ev->value we need a full memory barrier here.
> 
>     The barrier is indeed followed by a load: qatomic_read(&ev->value) !
>     = EV_SET
>     However, the caller of qemu_event_set() should not care whether the
>     event is already set or not
> 
>     so I'm not sure if smp_mb() is needed in
>     the first place.
> 
> 
> The barrier is needed to ensure correct ordering in all cases. You have 
> on one side
> 
> done=true
> Set
>    Read ev->value
>    If not EV_SET, set the event+ wake up waiters
> 
> 
> And on the other
> 
> Write EV_FREE
>    Write
> If not done
>    Wait
> 
> If one that calls qemu_event_set and the other calls qemu_event_reset, 
> you need to avoid that set reads a previous EV_SET for the value *and* 
> the other side reads done equal to false. The only way to avoid this is 
> for both sides to use a memory barrier before the read.
> 
>     qemu_event_set(): release *if the event is not already set*; otherwise
>     it has no effect on synchronization so we don't need a barrier either.
> 
> 
> It needs to be release always. This ensures that, whenever the setter 
> declares the event to be set, the other side sees whatever the setter 
> did before the call.

That is what I misunderstood, and now I can also imagine why it should 
always release. Thinking of the scenario with the "done" flag we have 
discussed, if we have two setters, the resetter should acquire the state 
from both of the two setters.

If the event is already set, we need to ensure all stores specified 
before qatomic_read(&ev->value) != EV_SET should happen before 
qatomic_read(&ev->value), which requires us to put a full barrier.

But I have a new question: do we really need "if 
(qatomic_read(&ev->value) != EV_SET)"?

With git blame, I found it didn't have the full barrier until commit 
374293ca6fb0 ("qemu-thread: use acquire/release to clarify semantics of 
QemuEvent"), which added it.

atomic_mb_read() was used until the commit instead. 
include/qemu/atomic.h at that time had the following comment:
 > /* atomic_mb_read/set semantics map Java volatile variables. They are
 >  * less expensive on some platforms (notably POWER & ARMv7) than fully
 >  * sequentially consistent operations.

We place a full barrier anyway, so we no longer have a reason to have 
qatomic_read() before performing qatomic_xchg().

I also found smp_mb__after_rmw() before qemu_futex_wake_all() is no 
longer necessary. Summing up, I think the code should look like as follows:

#ifdef HAVE_FUTEX
     if (qatomic_xchg(&ev->value, EV_SET) == EV_BUSY) {
         /* There were waiters, wake them up.  */
         qemu_futex_wake_all(ev);
     }
#else
     pthread_mutex_lock(&ev->lock);
     qatomic_store_release(&ev->value, EV_SET);
     pthread_cond_broadcast(&ev->cond);
     pthread_mutex_unlock(&ev->lock);
#endif

Regards,
Akihiko Odaki

