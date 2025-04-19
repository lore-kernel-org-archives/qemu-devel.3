Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87DD9C369BD
	for <qemu-devel@archiver.kernel.org>; Sat, 19 Apr 2025 07:56:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u6336-00045y-Rv; Sat, 19 Apr 2025 03:55:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1u6333-00045e-BB
 for qemu-devel@nongnu.org; Sat, 19 Apr 2025 03:55:37 -0400
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1u6330-0007yb-Dv
 for qemu-devel@nongnu.org; Sat, 19 Apr 2025 03:55:36 -0400
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-2295d78b45cso41606845ad.0
 for <qemu-devel@nongnu.org>; Sat, 19 Apr 2025 00:55:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1745049330; x=1745654130;
 darn=nongnu.org; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=gO0vFw3nwmCL8/ULbpecCxPBXfgKafRRKgugxMb/dEI=;
 b=1OuQiFjE87uxTQBWiCua74dKIo5q9Pa5ZHZvsyPtGRERaJnuiuDw3gUuwvUrhUpD6e
 CjVOpa+htM7SZA4w+lTbOP24osvq4t8A3Cq+VevJlFkdfk4RrpWef8Jk0HBHAclIiG83
 TVBMPehngsTpUh0gJ41tzF6CpU3UWf+iDbMFRa+gp2eTME1n5YpkQJpzOIz9BVZHyP52
 Ns3iMSxOOBKPqa7UGweakh9CPCMsyi+POof+v17uZBNo3doyZoFTCfM+BLaP6dfWyrZ6
 MMT0Iu/hS8iHkGCCvVbN6XLSfzxh/3Ym6r82KwdsKu7UKtVwHncaDHxWVENVTOVyLP1u
 qzBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745049330; x=1745654130;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=gO0vFw3nwmCL8/ULbpecCxPBXfgKafRRKgugxMb/dEI=;
 b=Jybes3ZFefiS7L+8JGbNWpkaW04xjC4uYOBypJSO1Z1PhFxrfloIEcv4WWJ0SEOrAR
 x65jNaYK5hULc/jy2ElcHKXy5OAmFsnSHYc3u3eJ3IwbNQ/ApcdLC+AQiR1EYZ98B68/
 IXUmNWKTX9hFZMCCPfLydDplXPv+0VL5UWo7bfuuACct/2SQD4IsIKhj6R5xUKWwqNgf
 1qfm16qvhqMk58ummZF9SyZjmceOHNDspSwZiYanwHm0Id3vewYvxlUk9r8BsLxMzDp4
 PFfXRQQEMTLpZ8mc5VUaG/RcrPr4Bf680R8F6s0D0K+ciaf2NOL+FFvph7SdkTAB/Ooa
 3HYg==
X-Gm-Message-State: AOJu0Yy4H4W7zcdLydL//mnh470HpCT/ukQQs2RhhflL1AdR0xsWivMs
 ZDpgj7nViY2jCmlbxXRPVdGgoFT7plhw6QMQrFbfgXhLL5UqwOmGTBqvQSzpkig=
X-Gm-Gg: ASbGnct0+xKIHweQOE29HwS4JDhbBa32UFnIcrYkTG+n0IBKI5BXDLrd/pyfD8toG/3
 NrJtT5rWd7tF34ZyGfGL0lCv+q5/z5rj6+mdI+SU2CPHlVkIC6EhVqznNChZT/skSZFhEDq8zK7
 wGNWL82y1KfVAosxKqEcpAq2u3+hoNkUb9TaebfdfUmLpOQkO9fMvKKE80mNi5IwGXtqOy7T3dL
 TPvctGM2os+LTEcqQHP+zdUyzQe+iZhek5ARnELfvZA/zVvbLQXTiUAwa4mXC9zjgUj6G7Tcm/Z
 nYwNlwRj+PNgmnOQrWczbz6ln/m1fT5z7iyzu6xbaPdQsutR9x1jx8umyTtSWpZJNhfx+cbkXVp
 0BnfsAfMv0zjmH3evfew=
X-Google-Smtp-Source: AGHT+IEFW2K/5FlgO80Av6GedNmcwlcsrX+KXncxsRbkIynDc/xKEdMqy+8KIg1RbAeJtOB9PNzzmw==
X-Received: by 2002:a17:903:41c9:b0:220:efc8:60b1 with SMTP id
 d9443c01a7336-22c53605049mr79369115ad.39.1745049330346; 
 Sat, 19 Apr 2025 00:55:30 -0700 (PDT)
Received: from ?IPV6:2400:4050:b783:b00:9e36:5f4c:928c:4ec2?
 ([2400:4050:b783:b00:9e36:5f4c:928c:4ec2])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-73dbfaaf900sm2759147b3a.154.2025.04.19.00.55.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 19 Apr 2025 00:55:30 -0700 (PDT)
Message-ID: <04330f14-ba99-4df2-ab5f-5126b863fd64@daynix.com>
Date: Sat, 19 Apr 2025 16:55:27 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 7/8] net/e1000e|igb: Fix interrupt throttling logic
To: Nicholas Piggin <npiggin@gmail.com>
Cc: qemu-devel@nongnu.org, Dmitry Fleytman <dmitry.fleytman@gmail.com>,
 Jason Wang <jasowang@redhat.com>,
 Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>,
 Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
References: <20250411043128.201289-1-npiggin@gmail.com>
 <20250411043128.201289-8-npiggin@gmail.com>
Content-Language: en-US
From: Akihiko Odaki <akihiko.odaki@daynix.com>
In-Reply-To: <20250411043128.201289-8-npiggin@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::631;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pl1-x631.google.com
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

On 2025/04/11 13:31, Nicholas Piggin wrote:
> Interrupt throttling is broken in several ways:
> - Timer expiry sends an interrupt even if there is no cause.
> - (e1000e) Mitigated interrupts still auto-clear cause bits.
> - Timer expiry that results in an interrupt does not re-arm the timer so
>    an interrupt can appear immediately after the timer expiry interrupt.
> 
> To fix:
> 
> - When the throttle timer expires, check the cause bits corresponding to
>    the msix vector before sending an irq.
> - (e1000e) Skip the auto-clear logic if an interrupt is delayed, and
>    send delayed irqs using e1000e_msix_notify() to perform auto-clear.
> - Re-load the throttle timer when a delayed interrupt is signaled. e1000e
>    gets this by signaling them with e1000e_msix_notify(), igb calls
>    igb_intrmgr_rearm_timer() directly.

Please split this patch into independent changes.

> 
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> ---
>   hw/net/e1000e_core.c | 59 +++++++++++++++++++++++++++++++++++++++-----
>   hw/net/igb_core.c    | 50 ++++++++++++++++++++++++-------------
>   2 files changed, 86 insertions(+), 23 deletions(-)
> 
> diff --git a/hw/net/e1000e_core.c b/hw/net/e1000e_core.c
> index f8e6522f810..6fb8da32e4d 100644
> --- a/hw/net/e1000e_core.c
> +++ b/hw/net/e1000e_core.c
> @@ -178,16 +178,62 @@ e1000e_intrmgr_on_throttling_timer(void *opaque)
>       }
>   }
>   
> +static uint32_t find_msix_causes(E1000ECore *core, int vec)
> +{
> +    uint32_t causes = 0;
> +    uint32_t int_cfg;
> +
> +    int_cfg = E1000_IVAR_RXQ0(core->mac[IVAR]);
> +    if (E1000_IVAR_ENTRY_VALID(int_cfg) &&
> +        E1000_IVAR_ENTRY_VEC(int_cfg) == vec) {
> +        causes |= E1000_ICR_RXQ0;
> +    }
> +
> +    int_cfg = E1000_IVAR_RXQ1(core->mac[IVAR]);
> +    if (E1000_IVAR_ENTRY_VALID(int_cfg) &&
> +        E1000_IVAR_ENTRY_VEC(int_cfg) == vec) {
> +        causes |= E1000_ICR_RXQ1;
> +    }
> +
> +    int_cfg = E1000_IVAR_TXQ0(core->mac[IVAR]);
> +    if (E1000_IVAR_ENTRY_VALID(int_cfg) &&
> +        E1000_IVAR_ENTRY_VEC(int_cfg) == vec) {
> +        causes |= E1000_ICR_TXQ0;
> +    }
> +
> +    int_cfg = E1000_IVAR_TXQ1(core->mac[IVAR]);
> +    if (E1000_IVAR_ENTRY_VALID(int_cfg) &&
> +        E1000_IVAR_ENTRY_VEC(int_cfg) == vec) {
> +        causes |= E1000_ICR_TXQ1;
> +    }
> +
> +    int_cfg = E1000_IVAR_OTHER(core->mac[IVAR]);
> +    if (E1000_IVAR_ENTRY_VALID(int_cfg) &&
> +        E1000_IVAR_ENTRY_VEC(int_cfg) == vec) {
> +        causes |= E1000_ICR_OTHER;
> +    }
> +
> +    return causes;
> +}
> +
> +static void
> +e1000e_msix_notify(E1000ECore *core, uint32_t causes);
> +
>   static void
>   e1000e_intrmgr_on_msix_throttling_timer(void *opaque)
>   {
>       E1000IntrDelayTimer *timer = opaque;
> -    int idx = timer - &timer->core->eitr[0];
> +    E1000ECore *core = timer->core;
> +    int idx = timer - &core->eitr[0];
> +    uint32_t causes;
>   
>       timer->running = false;
>   
> -    trace_e1000e_irq_msix_notify_postponed_vec(idx);
> -    msix_notify(timer->core->owner, idx);
> +    causes = find_msix_causes(core, idx) & core->mac[IMS] & core->mac[ICR];
> +    if (causes) {
> +        trace_e1000e_irq_msix_notify_postponed_vec(idx);
> +        e1000e_msix_notify(core, causes);
> +    }
>   }
>   
>   static void
> @@ -1992,10 +2038,11 @@ e1000e_msix_notify_one(E1000ECore *core, uint32_t cause, uint32_t int_cfg)
>       if (E1000_IVAR_ENTRY_VALID(int_cfg)) {
>           uint32_t vec = E1000_IVAR_ENTRY_VEC(int_cfg);
>           if (vec < E1000E_MSIX_VEC_NUM) {
> -            if (!e1000e_eitr_should_postpone(core, vec)) {
> -                trace_e1000e_irq_msix_notify_vec(vec);
> -                msix_notify(core->owner, vec);
> +            if (e1000e_eitr_should_postpone(core, vec)) {
> +                return;
>               }
> +            trace_e1000e_irq_msix_notify_vec(vec);
> +            msix_notify(core->owner, vec);
>           } else {
>               trace_e1000e_wrn_msix_vec_wrong(cause, int_cfg);
>           }
> diff --git a/hw/net/igb_core.c b/hw/net/igb_core.c
> index 3ae3e53530b..cc25a1d5baa 100644
> --- a/hw/net/igb_core.c
> +++ b/hw/net/igb_core.c
> @@ -152,11 +152,14 @@ igb_intrmgr_arm_timer(IGBIntrDelayTimer *timer, int64_t delay_ns)
>   static inline void
>   igb_intrmgr_rearm_timer(IGBIntrDelayTimer *timer)
>   {
> -    uint32_t interval = (timer->core->mac[timer->delay_reg] &
> -                         E1000_EITR_INTERVAL) >> 2;
> -    int64_t delay_ns = (int64_t)interval * timer->delay_resolution_ns;
> +    uint32_t eitr = timer->core->mac[timer->delay_reg];
>   
> -    igb_intrmgr_arm_timer(timer, delay_ns);
> +    if (eitr != 0) {
> +        uint32_t interval = (eitr & E1000_EITR_INTERVAL) >> 2;
> +        int64_t delay_ns = (int64_t)interval * timer->delay_resolution_ns;
> +
> +        igb_intrmgr_arm_timer(timer, delay_ns);
> +    }
>   }
>   
>   static void
> @@ -168,16 +171,7 @@ igb_intmgr_timer_resume(IGBIntrDelayTimer *timer)
>   }
>   
>   static void
> -igb_intrmgr_on_msix_throttling_timer(void *opaque)
> -{
> -    IGBIntrDelayTimer *timer = opaque;
> -    int idx = timer - &timer->core->eitr[0];
> -
> -    timer->running = false;
> -
> -    trace_e1000e_irq_msix_notify_postponed_vec(idx);
> -    igb_msix_notify(timer->core, idx);
> -}
> +igb_intrmgr_on_msix_throttling_timer(void *opaque);
>   
>   static void
>   igb_intrmgr_initialize_all_timers(IGBCore *core, bool create)
> @@ -2253,9 +2247,7 @@ igb_postpone_interrupt(IGBIntrDelayTimer *timer)
>           return true;
>       }
>   
> -    if (timer->core->mac[timer->delay_reg] != 0) {
> -        igb_intrmgr_rearm_timer(timer);
> -    }
> +    igb_intrmgr_rearm_timer(timer);
>   
>       return false;
>   }
> @@ -2279,6 +2271,30 @@ static void igb_send_msix(IGBCore *core, uint32_t causes)
>       }
>   }
>   
> +static void
> +igb_intrmgr_on_msix_throttling_timer(void *opaque)
> +{
> +    IGBIntrDelayTimer *timer = opaque;
> +    IGBCore *core = timer->core;
> +    int vector = timer - &core->eitr[0];
> +    uint32_t causes;
> +
> +    timer->running = false;
> +
> +    causes = core->mac[EICR] & core->mac[EIMS];
> +    if (causes & BIT(vector)) {
> +        /*
> +         * The moderation counter is loaded with interval value whenever the
> +         * interrupt is signaled. This includes when the interrupt is signaled
> +         * by the counter reaching 0.
> +         */
> +        igb_intrmgr_rearm_timer(timer);
> +
> +        trace_e1000e_irq_msix_notify_postponed_vec(vector);
> +        igb_msix_notify(core, vector);
> +    }
> +}
> +
>   static inline void
>   igb_fix_icr_asserted(IGBCore *core)
>   {


