Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02B1BFCE08C
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Feb 2026 14:38:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vvcVJ-0000yZ-E1; Thu, 26 Feb 2026 09:38:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1vvcVG-0000xz-D8
 for qemu-devel@nongnu.org; Thu, 26 Feb 2026 09:38:11 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1vvcVE-0005Nc-86
 for qemu-devel@nongnu.org; Thu, 26 Feb 2026 09:38:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1772116685;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5h4Nvd8kUN0cHGizKXCp0mvsTIrS+9ElT112DOOyBBU=;
 b=ZpXwp467aaw0c5MfCClp5xm1ZbchddecobOetHuaNqzUb0Yi4H1kaoI5IS4SCxS8eP3TZ3
 cXLpWrzyxdDEEoU4MRdE5IY0ljU7JxY/xaQYggErQMtXYkeUJxrpEYHaANXK7vCxFBWZVD
 NNg8XDkX7t5s+YgYt4/sqPcpno7moC8=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-625-PBudAMgRNlKITV9GeMq4Jg-1; Thu, 26 Feb 2026 09:38:04 -0500
X-MC-Unique: PBudAMgRNlKITV9GeMq4Jg-1
X-Mimecast-MFC-AGG-ID: PBudAMgRNlKITV9GeMq4Jg_1772116683
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-483bcfdaf7dso10364805e9.0
 for <qemu-devel@nongnu.org>; Thu, 26 Feb 2026 06:38:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1772116683; x=1772721483; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=5h4Nvd8kUN0cHGizKXCp0mvsTIrS+9ElT112DOOyBBU=;
 b=RI/AOkHagYR8u4fAwHQPgebbwN78waJlcHeMd89QTq8zI2Y/YTtCuOJhzC2V5acn71
 JKZFN0W8ba1qd0b5mOKcK4Aas9mPNkv3/OAM1/5HRNI1RVBT1mV7jsX4JjJijzNbsi3Y
 2NtNugAPXvS/dv2aB8SVc0nXJiT+8Tuh9tUY2gsaEN7l1T4drPiW8uBxULHc6uHtoaoj
 II6yc2Rws5MP99S5gOXRoBjx7/s2lePQAxYljZT52ykXuV8JE+AzrNSzpbcpcGGY4hJL
 ZgDh9AFrvNbip+ZsEs1QfDRIaO0dNoz9CZ/qu6rZoShayzx3e4ZjBGdmUxx3XH0+h0V+
 6mug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772116683; x=1772721483;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=5h4Nvd8kUN0cHGizKXCp0mvsTIrS+9ElT112DOOyBBU=;
 b=aeYuIRX72Ittw2ywkTMVrD3tRskmD4oOpfbNdLSX+CcTOztOgRtmh7xSF97eug01Wu
 t8KCincfDrvpP2GvMtSERE9+Bj3b7BEavXq/BywiUYXxmzGRrnrOeG6Zc6lMIWUwd82C
 lYVdEHUHnbfdTJs6MoxBfj1boXhALBSC48Xq1VYgQaT3TPCcKAAK8pMXr8ON8DRyXMwH
 wAr5f7thwzoE6b2osg44O/PrlGYwCSagSR6ad81X42mdLPrraagXZzhiWN/SC02RnH2h
 Y2ECd1ClhWDZ57va9Dd//Zy0zjVsc9dMJa1sNlmB7opZpAnfHCyAl5WnftdPWl++VRVt
 DTNg==
X-Gm-Message-State: AOJu0Yzf/XElu9weFEnqJlN/wKKl+m0Pykn7GUsyScCNBG5cgstumnfF
 MNFlHeKMONG6YSBCG0ZE94VfLCHNdwTQ52ljIVwXVrU4+3EfySyZrhIEYvTK74e1m0/psTti9/l
 QwYIHC24PyDBUm19Bp6ptHuQ9DJa1cTnW9XyNGL9LqEC5HIVpwNhpwT5a
X-Gm-Gg: ATEYQzy3Zpz4j1Jy2DBkAwaXCKBKaAlpWiES6uplmsApZIEicU+M4yVem7q+2zUCImT
 1GD2VEyotYF9oISgeSRhP5bc7iE+ca6TBOocXR+NR1HxefyqF05uB0s16X0kcmVpXtwCulTLp20
 JhY1o2BvBt/ovykzV9ZTdtTS9YlJ2x+vOUyOmBtDVnoTJNbbIg77XIyXk8s5ekBKrsbAQvwPXkW
 W7vIM4vKFVjzv4luB06SdEMuqfkABI99/IJ6DPPv9N4Ehhtv6P4WBd1NCz8dpy2x5vR2Qzp4P0s
 Vl2pF125OiIh/5U6frCiqjgAxmxy58OvMUV9F93otLRhanN4tIcls17HRfMGWC/w1OLt69Z2usb
 egeUFEqcRIXGsqxe+VAFFYq02Lsg2PwhAfguC8T2GS16PjAfi6fZSMYDyRGUJE4Vvd0R7HkSfm3
 XxBzHBRlm2zqvMsZYKFlZZNCfc9+qUYaxXKtZJaXPNIs7vStQX
X-Received: by 2002:a05:600c:8211:b0:477:76bf:e1fb with SMTP id
 5b1f17b1804b1-483c3de3dd6mr43969665e9.16.1772116682718; 
 Thu, 26 Feb 2026 06:38:02 -0800 (PST)
X-Received: by 2002:a05:600c:8211:b0:477:76bf:e1fb with SMTP id
 5b1f17b1804b1-483c3de3dd6mr43969195e9.16.1772116682123; 
 Thu, 26 Feb 2026 06:38:02 -0800 (PST)
Received: from ?IPV6:2003:cf:d737:d0ab:d7d1:715d:290:b740?
 (p200300cfd737d0abd7d1715d0290b740.dip0.t-ipconnect.de.
 [2003:cf:d737:d0ab:d7d1:715d:290:b740])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-483c3b770c2sm45968365e9.10.2026.02.26.06.38.00
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 26 Feb 2026 06:38:01 -0800 (PST)
Message-ID: <5011ccf5-7af5-4f88-8261-35514c72bc84@redhat.com>
Date: Thu, 26 Feb 2026 15:37:59 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH resend] block/throttle-groups: fix deadlock with iolimits
 and muliple iothreads
To: Dmitry Guryanov <dmitry.guryanov@gmail.com>, qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Alberto Garcia <berto@igalia.com>,
 Kevin Wolf <kwolf@redhat.com>
References: <20251208085528.890098-1-dmitry.guryanov@gmail.com>
Content-Language: en-US
From: Hanna Czenczek <hreitz@redhat.com>
In-Reply-To: <20251208085528.890098-1-dmitry.guryanov@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=hreitz@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.306, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.668,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 08.12.25 09:55, Dmitry Guryanov wrote:
> Details: https://gitlab.com/qemu-project/qemu/-/issues/3144
>
> The function schedule_next_request is called with tg->lock held and
> it may call throttle_group_co_restart_queue, which takes
> tgm->throttled_reqs_lock, qemu_co_mutex_lock may leave current
> coroutine if other iothread has taken the lock. If the next
> coroutine will call throttle_group_co_io_limits_intercept - it
> will try to take the mutex tg->lock which will never be released.
>
> Here is the backtrace of the iothread:
> Thread 30 (Thread 0x7f8aad1fd6c0 (LWP 24240) "IO iothread2"):
>   #0  futex_wait (futex_word=0x5611adb7d828, expected=2, private=0) at ../sysdeps/nptl/futex-internal.h:146
>   #1  __GI___lll_lock_wait (futex=futex@entry=0x5611adb7d828, private=0) at lowlevellock.c:49
>   #2  0x00007f8ab5a97501 in lll_mutex_lock_optimized (mutex=0x5611adb7d828) at pthread_mutex_lock.c:48
>   #3  ___pthread_mutex_lock (mutex=0x5611adb7d828) at pthread_mutex_lock.c:93
>   #4  0x00005611823f5482 in qemu_mutex_lock_impl (mutex=0x5611adb7d828, file=0x56118289daca "../block/throttle-groups.c", line=372) at ../util/qemu-thread-posix.c:94
>   #5  0x00005611822b0b39 in throttle_group_co_io_limits_intercept (tgm=0x5611af1bb4d8, bytes=4096, direction=THROTTLE_READ) at ../block/throttle-groups.c:372
>   #6  0x00005611822473b1 in blk_co_do_preadv_part (blk=0x5611af1bb490, offset=15972311040, bytes=4096, qiov=0x7f8aa4000f98, qiov_offset=0, flags=BDRV_REQ_REGISTERED_BUF) at ../block/block-backend.c:1354
>   #7  0x0000561182247fa0 in blk_aio_read_entry (opaque=0x7f8aa4005910) at ../block/block-backend.c:1619
>   #8  0x000056118241952e in coroutine_trampoline (i0=-1543497424, i1=32650) at ../util/coroutine-ucontext.c:175
>   #9  0x00007f8ab5a56f70 in ?? () at ../sysdeps/unix/sysv/linux/x86_64/__start_context.S:66 from target:/lib64/libc.so.6
>   #10 0x00007f8aad1ef190 in ?? ()
>   #11 0x0000000000000000 in ?? ()
>
> The lock is taken in line 386:
> (gdb) p tg.lock
> $1 = {lock = {__data = {__lock = 2, __count = 0, __owner = 24240, __nusers = 1, __kind = 0, __spins = 0, __elision = 0, __list = {__prev = 0x0, __next = 0x0}},
>      __size = "\002\000\000\000\000\000\000\000\260^\000\000\001", '\000' <repeats 26 times>, __align = 2}, file = 0x56118289daca "../block/throttle-groups.c",
>    line = 386, initialized = true}
>
> The solution is to use tg->lock to protect both ThreadGroup fields and
> ThrottleGroupMember.throttled_reqs. It doesn't seem to be possible
> to use separate locks because we need to first manipulate ThrottleGroup
> fields, then schedule next coroutine using throttled_reqs and after than
> update token field from ThrottleGroup depending on the throttled_reqs
> state.
>
> Signed-off-by: Dmitry Guryanov <dmitry.guryanov@gmail.com>
> ---
>   block/throttle-groups.c         | 21 ++++++---------------
>   include/block/throttle-groups.h |  1 -
>   2 files changed, 6 insertions(+), 16 deletions(-)
>
> diff --git a/block/throttle-groups.c b/block/throttle-groups.c
> index 66fdce9a90..bb01e52516 100644
> --- a/block/throttle-groups.c
> +++ b/block/throttle-groups.c
> @@ -295,19 +295,15 @@ static bool throttle_group_schedule_timer(ThrottleGroupMember *tgm,
>   /* Start the next pending I/O request for a ThrottleGroupMember. Return whether
>    * any request was actually pending.
>    *
> + * This assumes that tg->lock is held.
> + *
>    * @tgm:       the current ThrottleGroupMember
>    * @direction: the ThrottleDirection
>    */
>   static bool coroutine_fn throttle_group_co_restart_queue(ThrottleGroupMember *tgm,
>                                                            ThrottleDirection direction)
>   {
> -    bool ret;
> -
> -    qemu_co_mutex_lock(&tgm->throttled_reqs_lock);
> -    ret = qemu_co_queue_next(&tgm->throttled_reqs[direction]);
> -    qemu_co_mutex_unlock(&tgm->throttled_reqs_lock);
> -
> -    return ret;
> +    return qemu_co_queue_next(&tgm->throttled_reqs[direction]);;

Double semicolon here, should just be one.

>   }
>   
>   /* Look for the next pending I/O request and schedule it.

[...]

> diff --git a/include/block/throttle-groups.h b/include/block/throttle-groups.h
> index 2355e8d9de..374c7c0215 100644
> --- a/include/block/throttle-groups.h
> +++ b/include/block/throttle-groups.h
> @@ -36,7 +36,6 @@
>   typedef struct ThrottleGroupMember {
>       AioContext   *aio_context;
>       /* throttled_reqs_lock protects the CoQueues for throttled requests.  */

This comment should be updated to something like "Protected by 
ThrottleGroup.lock".

With both of these fixed:

Reviewed-by: Hanna Czenczek <hreitz@redhat.com>

> -    CoMutex      throttled_reqs_lock;
>       CoQueue      throttled_reqs[THROTTLE_MAX];
>   
>       /* Nonzero if the I/O limits are currently being ignored; generally


