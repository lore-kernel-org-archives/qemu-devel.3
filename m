Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E1CDC02187
	for <qemu-devel@archiver.kernel.org>; Sat, 18 Jan 2025 08:40:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tZ4MI-0000bA-Nm; Sat, 18 Jan 2025 03:39:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1tZ4MG-0000aX-Nc
 for qemu-devel@nongnu.org; Sat, 18 Jan 2025 03:39:08 -0500
Received: from mail-pl1-x62a.google.com ([2607:f8b0:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1tZ4ME-0005yH-H7
 for qemu-devel@nongnu.org; Sat, 18 Jan 2025 03:39:08 -0500
Received: by mail-pl1-x62a.google.com with SMTP id
 d9443c01a7336-21669fd5c7cso53363345ad.3
 for <qemu-devel@nongnu.org>; Sat, 18 Jan 2025 00:39:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1737189545; x=1737794345;
 darn=nongnu.org; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=MbokdyzoEL/KGy9/78hKTpLE+nyLufZMu13ENUb0aw0=;
 b=WWqct5keG2RRH7uBQdsrIgk7XWBnOwHjkohl0BQXFl6jdr9dD6LGlr7sEMzKRAcLBb
 rNBOp9BK0y8lVROeohgcufxqKysDYqD6eAsF9kNKM3xWpb8/0qei+G6EGAoyZGbgoukC
 u2eerBVlA9reOjWicJOSZkUvnMLHSq+8O71ENYDohfKjj+0fufgbT4Ox62y5AMKKktzO
 28pbnuuDHMpmpyMIDzfjg2i/Vz6hkyRpPM/QA3b0hU9JAU1EotpOY9A7Linbc/zR9VFV
 1nAks4SooqdVg1JqLTDRIVY5OX6/tog3n+nAoIMrB2awQYZes2rQohRU/RVpi5/P7UIj
 vjlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737189545; x=1737794345;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=MbokdyzoEL/KGy9/78hKTpLE+nyLufZMu13ENUb0aw0=;
 b=p9xegVztH5fRSMh3riI77WZaG0qHIWbYR8CXs5QSsfLYWxFecQ6GmHjTuKTZCfwg/W
 IbR2daA9V+3F99rQ+K9PGOd/migZwo4BkGNpGV5Afe/camDXFLhT0LJdWtUT24q0zMcD
 2R5ZlhtErnnVJRu9kane3aIwEJBmE81Ceh8K6HZEnrP4krwMX9oZc8FQh84OBvXdvmRU
 9l1KllyPXFsibmeD28ZCwQkPvZL1odA9nF77JdKPWt+34HppNonLjzNCCQI+wGAP6V9c
 Pzj/310IBQCUj+fwpYPbIj3fH3byUznVB6emufiVNISc2O41hwfbbTP69TLte/yNEKEA
 JMJQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWk/JlGcnWY2tQk4TdgjXrC8a5VCD/5xm7Qm26hVFh0GSJs8ItP0lF+1g2wNxPQSEbyXGEgaWcpf/Co@nongnu.org
X-Gm-Message-State: AOJu0YwBM4tdKysrC8yVXK0jNOBe17K3lyUdvA0zNUbHhxXta9KC+n5c
 OPS9Hm25OrxCrGFAcJ9CSnCXCGg0CelzUiW9scM11EVqjUac7BqJMnSooRfCILg=
X-Gm-Gg: ASbGncsuxyE1R0jx0QnZaApD7Sxq9695hthE/9DxFZ4VCnp38MdXajQWVHhodq4vuWQ
 kZd5t84Qy2eFaFoC3uCkA06nWA40hTTuA/St4kdD37aJJmdP2yTCPNBQB3mQ4OZYBiCTop7UUum
 3MfBTBPjXFn2N/FLOiVg3v5sHBdovcXM6JlJsbgKOLlM6F/zM7++/ZfB/s7H5ihJ2G4rrXJvolI
 6OMbJwEIzk1J143SKGJd/qnUQRRJtByfj/EQER/yWYrfKOqcbf45UWuNcM69R1yP76MY3PO913H
 6o4=
X-Google-Smtp-Source: AGHT+IFkWy4DGFwkxJuvxzL03BIKyug67VFlJ1OdnrbemYk8hHX+j/2ikET7nvGjGB4Jv/iNWT3feQ==
X-Received: by 2002:a17:902:ce0c:b0:21c:e34:c8c3 with SMTP id
 d9443c01a7336-21c35540560mr106130105ad.24.1737189544947; 
 Sat, 18 Jan 2025 00:39:04 -0800 (PST)
Received: from [10.4.77.142] ([118.103.63.134])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-21c2cea08e4sm27681795ad.7.2025.01.18.00.39.01
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 18 Jan 2025 00:39:04 -0800 (PST)
Message-ID: <8f359213-5dd0-48e2-afdc-209784e4c95e@daynix.com>
Date: Sat, 18 Jan 2025 17:37:52 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/9] net/igb: Fix EITR LLI and counter fields
To: Nicholas Piggin <npiggin@gmail.com>, qemu-devel@nongnu.org
Cc: Dmitry Fleytman <dmitry.fleytman@gmail.com>,
 Jason Wang <jasowang@redhat.com>,
 Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>,
 Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
References: <20250117170306.403075-1-npiggin@gmail.com>
 <20250117170306.403075-6-npiggin@gmail.com>
Content-Language: en-US
From: Akihiko Odaki <akihiko.odaki@daynix.com>
In-Reply-To: <20250117170306.403075-6-npiggin@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62a;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pl1-x62a.google.com
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

On 2025/01/18 2:03, Nicholas Piggin wrote:
> IGB EITR registers have counter fields which reflect the current ITR
> and LLI counter values, as well as a bit to enable LLI moderation,
> and a bit to write the register without modifying the counter fields.
> 
> Implement the ITR counter and log an unimp message if software tries
> to enable LLI moderation. Fix the implementation of the counter ignore
> bit.
> 
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> ---
>   hw/net/igb_regs.h |  8 +++++--
>   hw/net/igb_core.c | 53 ++++++++++++++++++++++++++++++++++++++++-------
>   2 files changed, 51 insertions(+), 10 deletions(-)
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
>   #define E1000_EITR_CNT_IGNR     0x80000000 /* Don't reset counters on write */
>   
>   #define E1000_TSYNCTXCTL_VALID    0x00000001 /* tx timestamp valid */
> diff --git a/hw/net/igb_core.c b/hw/net/igb_core.c
> index 94f9785749a..cdebc917d2e 100644
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
> @@ -2881,7 +2887,22 @@ igb_mac_swsm_read(IGBCore *core, int index)
>   static uint32_t
>   igb_mac_eitr_read(IGBCore *core, int index)
>   {
> -    return core->eitr_guest_value[index - EITR0];
> +    uint32_t eitr_num = index - EITR0;
> +    uint32_t val = core->mac[eitr_num];
> +    IGBIntrDelayTimer *timer = &core->eitr[eitr_num];
> +
> +    if (timer->running) { /* ITR is enabled, get ITR counter */

Saying "ITR is enabled" here is a bit confusing. timer->running may be 
false even if ITR is enabled because the timer is already expired.

> +        int64_t remains = timer_expire_time_ns(timer->timer) -
> +                          qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL);
> +        if (remains > 0) {
> +            /* CNT is the most significant 10 of 12 bits */
> +            uint32_t cnt;
> +            cnt = remains / timer->delay_resolution_ns;
> +            val |= ((cnt >> 2) << 21) & E1000_EITR_ITR_CNT;
> +        }
> +    }
> +
> +    return val;
>   }
>   
>   static uint32_t igb_mac_vfmailbox_read(IGBCore *core, int index)
> @@ -3047,8 +3068,24 @@ igb_set_eitr(IGBCore *core, int index, uint32_t val)
>   
>       trace_igb_irq_eitr_set(eitr_num, val);
>   
> -    core->eitr_guest_value[eitr_num] = val & ~E1000_EITR_CNT_IGNR;
> -    core->mac[index] = val & 0x7FFE;
> +    if (val & E1000_EITR_LLI_EN) {
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
> +    core->eitr_guest_value[eitr_num] = val;
>   }
>   
>   static void


