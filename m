Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8AFC3C369C2
	for <qemu-devel@archiver.kernel.org>; Mon,  5 May 2025 06:04:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uBovs-0000BO-3m; Mon, 05 May 2025 02:04:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1uBovp-0000Aw-U0
 for qemu-devel@nongnu.org; Mon, 05 May 2025 02:04:01 -0400
Received: from mail-pf1-x42f.google.com ([2607:f8b0:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1uBovl-0002e7-Lm
 for qemu-devel@nongnu.org; Mon, 05 May 2025 02:04:01 -0400
Received: by mail-pf1-x42f.google.com with SMTP id
 d2e1a72fcca58-7398d65476eso3147654b3a.1
 for <qemu-devel@nongnu.org>; Sun, 04 May 2025 23:03:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1746425036; x=1747029836;
 darn=nongnu.org; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=iM1h/TiQQKrgq/BZlQRFlCX9fcxamaNQT1oJ7HwKq9Q=;
 b=vjwrRfAGQgdF6d+BaRJ+4PDGteW9bifmmb9n5r4GsR0cJAgM/9MwTXfr7kMLvJFROw
 pfO+wcUiAiJcILSnS0rGqLEZIPXaycNptkIHOn3jXmpbqqP2Y1OwG41Exxm4ORf/lcNQ
 cncSbmBEcWjZcYFMvs95vGBK8lkHw21Srmj+KnHjtObOZh91DhRpI2X/iH6BmolxTV9h
 3a7U+tMJI9V/+tFYkufdxo7G7CW65cGGi8b2pwKn8fNfV+VYmFYZ3S8+zMLIozYPCOfw
 Xc6Q7npRzLUf7EynceajzKywxm+rxc3WhG0ezjEqKVDo+K4TZTPFFml3gHXBpF9Zotml
 9wjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746425036; x=1747029836;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=iM1h/TiQQKrgq/BZlQRFlCX9fcxamaNQT1oJ7HwKq9Q=;
 b=qOzXjxz1zweZiH4CRfZZVoJrMmY6WLYdZqWIlnzrcLpctGhtf6BZxRPksvurw0vQOd
 tVCaVa0Tu8j++USjIr+GCWC1hgzyyD+R6rFvnYlD6rVZwWq8k3xandnaN8MFUzVDDHSq
 1srLKtxUXomSHuKqCJAF4iViBesicHivB3+6isnwoPOyTWHBYR5S0+0pIfY5yLWFJ4fT
 ePRmnDT8Vf7vzcGZOJ1BB0qLXn3znzj6Ow3UcSfp0Xr0yjrLJgh8I5tgreAQc2uBJ1A/
 bI/oihf7PUpcsTe83dlOiTVwUpp5dgOQMECX5X9kSZ0UciG2PPD+EFjait0VBuAwxFTF
 4hbg==
X-Gm-Message-State: AOJu0YwyfiKDh9rYpCEVbSlFvrLV5BqMIwxG0hw37K1WCo+7JpIxznHF
 FxJnTLorhaxo7WYbFPLDA23HBngMKWgDq3mjkjl2RjtIgPaYbJKXcdobB2tU8Hx355sioF7/oSo
 9
X-Gm-Gg: ASbGnctP4qrjYBLuHATk4/0fe/qQGofC+qwZj6Q49pukbRJCy9mCE1i25ytnXbs8eH2
 RUegymRgUUalVvVYeml8M3SmyfRpIwPWZ9n3Wedjkm1GVptW9bReQVqlQruPAg0DwxJ6B0mFesx
 81zjzFU0TSWs/3vnh6D3nOB+yUaVwtC6OdlepKwzpiCE6Kpx8lVQyf4vpdEkKG+8cmxx/JR3kU0
 pki94cXUrveq7CPV8AYPJd8NAOGV1ixFzlGy32gyd4Wt3XoP9lOv0Ee8GTJJQLzMlaZHtZE76em
 YOZeFn/xESwTCSJ7yrsxeq5bbUDk3C/ZguBORzbjAS70zlpwRjo=
X-Google-Smtp-Source: AGHT+IEwVcWnXW2ZDHRiLjtNDXfX26xz2p4UmSfNSnt27Ojo4cZOO1OpAWf0qX560pLMp9ocu5A1Vw==
X-Received: by 2002:a05:6a00:8c01:b0:736:4d05:2e35 with SMTP id
 d2e1a72fcca58-74057afb16amr17743215b3a.3.1746425036170; 
 Sun, 04 May 2025 23:03:56 -0700 (PDT)
Received: from [157.82.207.61] ([157.82.207.61])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-740590a2921sm6086598b3a.178.2025.05.04.23.03.54
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 04 May 2025 23:03:55 -0700 (PDT)
Message-ID: <57c9b65a-bfdf-47e6-a438-6559f791f7dd@daynix.com>
Date: Mon, 5 May 2025 15:03:52 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 11/12] net/e1000e|igb: Fix interrupt throttling rearming
To: Nicholas Piggin <npiggin@gmail.com>
Cc: qemu-devel@nongnu.org, Dmitry Fleytman <dmitry.fleytman@gmail.com>,
 Jason Wang <jasowang@redhat.com>,
 Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>,
 Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
References: <20250502031705.100768-1-npiggin@gmail.com>
 <20250502031705.100768-12-npiggin@gmail.com>
Content-Language: en-US
From: Akihiko Odaki <akihiko.odaki@daynix.com>
In-Reply-To: <20250502031705.100768-12-npiggin@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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

On 2025/05/02 12:17, Nicholas Piggin wrote:
> Timer expiry that results in an interrupt does not rearm the timer so
> an interrupt can appear immediately after the interrupt generated by
> timer expiry.
> 
> Fix this by rearming the throttle timer when a delayed interrupt is
> processed. e1000e gets this by reusing the e1000e_msix_notify()
> logic, igb calls igb_intrmgr_rearm_timer() directly.
> 
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> ---
>   hw/net/e1000e_core.c |  5 ++--
>   hw/net/igb_core.c    | 55 ++++++++++++++++++++++++++------------------
>   2 files changed, 35 insertions(+), 25 deletions(-)
> 
> diff --git a/hw/net/e1000e_core.c b/hw/net/e1000e_core.c
> index d53f70065ef..2932122c04b 100644
> --- a/hw/net/e1000e_core.c
> +++ b/hw/net/e1000e_core.c
> @@ -218,7 +218,7 @@ static uint32_t find_msix_causes(E1000ECore *core, int vec)
>   }
>   
>   static void
> -e1000e_msix_auto_clear_mask(E1000ECore *core, uint32_t cause);
> +e1000e_msix_notify(E1000ECore *core, uint32_t causes);
>   
>   static void
>   e1000e_intrmgr_on_msix_throttling_timer(void *opaque)
> @@ -233,8 +233,7 @@ e1000e_intrmgr_on_msix_throttling_timer(void *opaque)
>       causes = find_msix_causes(core, idx) & core->mac[IMS] & core->mac[ICR];
>       if (causes) {
>           trace_e1000e_irq_msix_notify_postponed_vec(idx);
> -        msix_notify(core->owner, causes);
> -        e1000e_msix_auto_clear_mask(core, causes);
> +        e1000e_msix_notify(core, causes);
>       }
>   }
>   
> diff --git a/hw/net/igb_core.c b/hw/net/igb_core.c
> index 035637f81f8..cc25a1d5baa 100644
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
> @@ -168,21 +171,7 @@ igb_intmgr_timer_resume(IGBIntrDelayTimer *timer)
>   }
>   
>   static void
> -igb_intrmgr_on_msix_throttling_timer(void *opaque)
> -{
> -    IGBIntrDelayTimer *timer = opaque;
> -    IGBCore *core = timer->core;
> -    int vector = timer - &core->eitr[0];
> -    uint32_t causes;
> -
> -    timer->running = false;
> -
> -    causes = core->mac[EICR] & core->mac[EIMS];
> -    if (causes & BIT(vector)) {
> -        trace_e1000e_irq_msix_notify_postponed_vec(vector);
> -        igb_msix_notify(core, vector);
> -    }
> -}
> +igb_intrmgr_on_msix_throttling_timer(void *opaque);
>   
>   static void
>   igb_intrmgr_initialize_all_timers(IGBCore *core, bool create)
> @@ -2258,9 +2247,7 @@ igb_postpone_interrupt(IGBIntrDelayTimer *timer)
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
> @@ -2284,6 +2271,30 @@ static void igb_send_msix(IGBCore *core, uint32_t causes)
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

I wonder why the definition is moved. This patch adds a 
igb_intrmgr_rearm_timer() call but it's already placed earlier than this 
function.

>   static inline void
>   igb_fix_icr_asserted(IGBCore *core)
>   {


