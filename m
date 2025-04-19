Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68613C369BD
	for <qemu-devel@archiver.kernel.org>; Sat, 19 Apr 2025 07:41:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u62os-0001dZ-SS; Sat, 19 Apr 2025 03:40:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1u62or-0001dP-Gr
 for qemu-devel@nongnu.org; Sat, 19 Apr 2025 03:40:57 -0400
Received: from mail-pf1-x42b.google.com ([2607:f8b0:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1u62oo-0006YA-Pg
 for qemu-devel@nongnu.org; Sat, 19 Apr 2025 03:40:57 -0400
Received: by mail-pf1-x42b.google.com with SMTP id
 d2e1a72fcca58-739b3fe7ce8so2237046b3a.0
 for <qemu-devel@nongnu.org>; Sat, 19 Apr 2025 00:40:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1745048453; x=1745653253;
 darn=nongnu.org; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=MSrEU5gkByW+1KkmirSwq6Qa7UVeG2HtukyToBd5Utw=;
 b=eIP0y97y+ssoBDUGgURHWhNlCpvB4C4hndYo2HhTFtiIgY2VLE5KvEjqe20VG1gEJ4
 0sLpRaBUkk09UuvxHkidBEwJpCC0oDa2GYXk+xWGJBy3ODzfL91FA4cFuY2smL+96ArF
 jUnEfMZTgBlyg14RrpG7TOG80qnxQqxr5Cw5w88+1V1JhjAzbgX+hdXwi0GNtuQhwSJ/
 FGUfH9fiGvNisl6ZVTBR3b2OqHBlyViFQ+AFAJ8F8JS9BkUJuNZoR7G9S0nFuwzHobod
 Vo5tmIWWyYpwHet9ol0orbN2nED/JHH3kdMu6w+Nr3FI7rkwBHaniYkSk/e4rmnnaLih
 c+bQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745048453; x=1745653253;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=MSrEU5gkByW+1KkmirSwq6Qa7UVeG2HtukyToBd5Utw=;
 b=e3AVXu0r7Bfg9ZsmJeosdcHTg9JJ/CNyuulbAqP3MFIXHog5gm2A7WA1WIexaC3Lme
 Z/ocP0Ey/e6QcCx85Olo0LiZc5VG74GQ/N6XpK+Cni9DmZwhEIIiK+ST2jj0WicROl4F
 46LlsZGmoRLyD3S3cA+xlR79FsOaXfNT0lj+gi2oiHlvdMdJQ7U6tXP5+RtHb1/lDUd4
 iWbj2ssTS1IrSNT0VyZz0K0GAVteiXhObG7AiJc3QiEO72Vg1TfcmOZONQlQwA1V5NVP
 z2b2Mkuu+idb2AwbC31gAYuCIHEcR7S6/y+ozbn6MTkwjFLi7ds33h8x8IHYssvWTJnE
 Q/5A==
X-Gm-Message-State: AOJu0YxG8J5/Jg6OMnzpQ1+VfYSUsXBkJZ5OOQNhfgE4kKB7Z/vrJrp2
 vxcPKw1MsEgLOI4KUy3Z28RXFE9/4b/dkRTrCBbogMJ0qPGopiYvxsF08+ZIbTE=
X-Gm-Gg: ASbGncv1kgJHrQvCxfbeak/l7qkEqhO+ZUtWnWoZhxa6d3BDZ0kxa1BWvqAnMiVq0CF
 v6qX99fjvcn/IQ+umo9mhlcYvpiG/jEgY+Ohgp03Ch9qpV/kjv1xzOsX49Wl7osqsw2bXFc0LKC
 FDxFvcq8lJ7vXbxqDBFOB2fM4z3hh4cSw1rgtcW+2wvJEKRrJoHoCNdmLUl7Nwx4vO5lCW0O70M
 trU4/vtfhohf/v+1eyhdcRMK6b+cg0QYadFPn1CcZx9zR+kQ1u48UVJHHeF4oAauP0nxNTE+QE/
 R8d6fSgGD97al83VwtlIbhrm6g5v2F1QZcRU0/tbo2o+QMFcKK3Ma6Y9hO0+NRLuic+iol1gHbv
 uqT3x/dwoZ4XEL1HZ1KA=
X-Google-Smtp-Source: AGHT+IFEHWKHTjcs4j+uHklSzFHy9xtUwg7xvPGWyJumpB2xtIslIMpGTmu5KfXx0396+n33mvT1Kw==
X-Received: by 2002:a05:6a00:1907:b0:736:5dae:6b0d with SMTP id
 d2e1a72fcca58-73dc14b430cmr5999741b3a.10.1745048453168; 
 Sat, 19 Apr 2025 00:40:53 -0700 (PDT)
Received: from ?IPV6:2400:4050:b783:b00:9e36:5f4c:928c:4ec2?
 ([2400:4050:b783:b00:9e36:5f4c:928c:4ec2])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-73dbf8e4932sm2859857b3a.55.2025.04.19.00.40.51
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 19 Apr 2025 00:40:52 -0700 (PDT)
Message-ID: <83b372f2-9790-468d-9cbb-7ea26a663473@daynix.com>
Date: Sat, 19 Apr 2025 16:40:50 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 6/8] net/igb: Implement EITR Moderation Counter
To: Nicholas Piggin <npiggin@gmail.com>
Cc: qemu-devel@nongnu.org, Dmitry Fleytman <dmitry.fleytman@gmail.com>,
 Jason Wang <jasowang@redhat.com>,
 Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>,
 Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
References: <20250411043128.201289-1-npiggin@gmail.com>
 <20250411043128.201289-7-npiggin@gmail.com>
Content-Language: en-US
From: Akihiko Odaki <akihiko.odaki@daynix.com>
In-Reply-To: <20250411043128.201289-7-npiggin@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42b;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pf1-x42b.google.com
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
> IGB EITR registers have counter fields which reflect the current ITR
> and LLI counter values, as well as a bit to enable LLI moderation,
> and a bit to write the register without modifying the counter fields.
> 
> Implement the EITR Moderation Counter (aka EITR counter), and counter
> ignore bit. The EITR counter is the time remaining in the interrupt
> moderation delay which is implemented as a QEMU timer.
> 
> Log an unimp message if software tries to enable LLI moderation.
> 
> Add a note about the problem with reloading timers after migration.
> 
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> ---
>   hw/net/igb_regs.h |  8 +++++--
>   hw/net/igb_core.c | 54 ++++++++++++++++++++++++++++++++++++++++-------
>   2 files changed, 52 insertions(+), 10 deletions(-)
> 
> diff --git a/hw/net/igb_regs.h b/hw/net/igb_regs.h
> index 1ed5ee5039a..b612248264a 100644
> --- a/hw/net/igb_regs.h
> +++ b/hw/net/igb_regs.h
> @@ -321,8 +321,12 @@ union e1000_adv_rx_desc {
>   #define E1000_EICR_TX_QUEUE3    0x00000800 /* Tx Queue 3 Interrupt */
>   #define E1000_EICR_OTHER        0x80000000 /* Interrupt Cause Active */
>   
> -/* Extended Interrupt Cause Set */
> -/* E1000_EITR_CNT_IGNR is only for 82576 and newer */
> +/* Extended Interrupt Throttle */
> +/* These are only for 82576 and newer */
> +#define E1000_EITR_INTERVAL     0x00007FFC
> +#define E1000_EITR_LLI_EN       0x00008000
> +#define E1000_EITR_LLI_CNT      0x001F0000
> +#define E1000_EITR_ITR_CNT      0x7FE00000

This part is copied from Linux. Please put the new definitions after the 
line saying: /* new */

>   #define E1000_EITR_CNT_IGNR     0x80000000 /* Don't reset counters on write */
>   
>   #define E1000_TSYNCTXCTL_VALID    0x00000001 /* tx timestamp valid */
> diff --git a/hw/net/igb_core.c b/hw/net/igb_core.c
> index 8fcc872a7c0..3ae3e53530b 100644
> --- a/hw/net/igb_core.c
> +++ b/hw/net/igb_core.c
> @@ -140,12 +140,8 @@ static void igb_msix_notify(IGBCore *core, unsigned int cause)
>   }
>   
>   static inline void
> -igb_intrmgr_rearm_timer(IGBIntrDelayTimer *timer)
> +igb_intrmgr_arm_timer(IGBIntrDelayTimer *timer, int64_t delay_ns)
>   {
> -    int64_t delay_ns =
> -            (int64_t)((timer->core->mac[timer->delay_reg] & 0x7FFC) >> 2) *
> -                     timer->delay_resolution_ns;
> -
>       trace_e1000e_irq_rearm_timer(timer->delay_reg << 2, delay_ns);
>   
>       timer_mod(timer->timer, qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL) + delay_ns);
> @@ -153,6 +149,16 @@ igb_intrmgr_rearm_timer(IGBIntrDelayTimer *timer)
>       timer->running = true;
>   }
>   
> +static inline void
> +igb_intrmgr_rearm_timer(IGBIntrDelayTimer *timer)
> +{
> +    uint32_t interval = (timer->core->mac[timer->delay_reg] &
> +                         E1000_EITR_INTERVAL) >> 2;
> +    int64_t delay_ns = (int64_t)interval * timer->delay_resolution_ns;
> +
> +    igb_intrmgr_arm_timer(timer, delay_ns);
> +}
> +
>   static void
>   igb_intmgr_timer_resume(IGBIntrDelayTimer *timer)
>   {
> @@ -2881,7 +2887,21 @@ igb_mac_swsm_read(IGBCore *core, int index)
>   static uint32_t
>   igb_mac_eitr_read(IGBCore *core, int index)
>   {
> -    return core->mac[index - EITR0];
> +    uint32_t eitr_num = index - EITR0;
> +    uint32_t val = core->mac[eitr_num];
> +    IGBIntrDelayTimer *timer = &core->eitr[eitr_num];
> +
> +    if (timer->running) { /* timer is pending, find time remaining */
> +        int64_t remains = timer_expire_time_ns(timer->timer) -
> +                          qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL);
> +        if (remains > 0) {
> +            uint32_t cnt; /* CNT is the most significant 10 of 12 bits */
> +            cnt = remains / timer->delay_resolution_ns;
> +            val |= ((cnt >> 2) << 21) & E1000_EITR_ITR_CNT;
> +        }
> +    }
> +
> +    return val;
>   }
>   
>   static uint32_t igb_mac_vfmailbox_read(IGBCore *core, int index)
> @@ -3047,7 +3067,23 @@ igb_set_eitr(IGBCore *core, int index, uint32_t val)
>   
>       trace_igb_irq_eitr_set(eitr_num, val);
>   
> -    core->mac[index] = val & 0x7FFE;
> +    if (val & (E1000_EITR_LLI_EN | E1000_EITR_LLI_CNT)) {
> +        qemu_log_mask(LOG_UNIMP, "%s: LLI moderation not supported, ignoring\n",
> +                                 __func__);
> +    }
> +
> +    if (!(val & E1000_EITR_CNT_IGNR)) {
> +        IGBIntrDelayTimer *timer = &core->eitr[eitr_num];
> +        uint32_t itr_cnt = (val & E1000_EITR_ITR_CNT) >> 21;
> +        /* CNT is the most significant 10 of 12 bits */
> +        uint64_t ns = (itr_cnt << 2) * timer->delay_resolution_ns;
> +
> +        igb_intrmgr_arm_timer(timer, ns);
> +    }
> +
> +    val &= E1000_EITR_INTERVAL | E1000_EITR_LLI_EN;
> +
> +    core->mac[index] = val;
>   }
>   
>   static void
> @@ -4553,7 +4589,9 @@ igb_core_post_load(IGBCore *core)
>   
>       /*
>        * we need to restart intrmgr timers, as an older version of
> -     * QEMU can have stopped them before migration
> +     * QEMU can have stopped them before migration.
> +     * XXX: re-setting timers with fresh values breaks deterministic
> +     * replay.
>        */
>       igb_intrmgr_resume(core);
>       igb_autoneg_resume(core);


