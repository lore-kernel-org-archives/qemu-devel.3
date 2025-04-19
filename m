Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3270C369BD
	for <qemu-devel@archiver.kernel.org>; Sat, 19 Apr 2025 07:16:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u62QU-00028Z-HT; Sat, 19 Apr 2025 03:15:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1u62QR-00028N-4x
 for qemu-devel@nongnu.org; Sat, 19 Apr 2025 03:15:43 -0400
Received: from mail-pj1-x1031.google.com ([2607:f8b0:4864:20::1031])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1u62QO-0003BE-M7
 for qemu-devel@nongnu.org; Sat, 19 Apr 2025 03:15:42 -0400
Received: by mail-pj1-x1031.google.com with SMTP id
 98e67ed59e1d1-303a66af07eso1943444a91.2
 for <qemu-devel@nongnu.org>; Sat, 19 Apr 2025 00:15:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1745046939; x=1745651739;
 darn=nongnu.org; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=y0Orie7HTNvmntMaEh4zzmJdAjAJy7b6qRhW8Wvk8zg=;
 b=LanAmJuUbJVUBu7EBikRyt9tWdY4/ouRDZ/cDzd+VlnpDGk0SKw4HhawoK9x7DAKId
 2CV1laVOHEUx6qzhytvPk8RF1UDDvajlrKUI0yhMiXQnO9gCqHU5l9oB5vEjXlXrvHw1
 ZnX/YXVjMw/2HyVoYc34BGaE+oWXziSymCA+RtcKCKZnw6w+5O5N/bl26a7O+DeadQP5
 E/L6rH7SwhCjB6UR52a4imzobXri6ncmDaBZFcJYhtl6xlEJRUiv+tYFdpBslvJhRliu
 5AOP11dHHtZ/hmXdkq0L+pMdZYrkuD07f7a2gnXXeeza/Jj9gA/TZQ3iypequQ63/wrE
 Xc3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745046939; x=1745651739;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=y0Orie7HTNvmntMaEh4zzmJdAjAJy7b6qRhW8Wvk8zg=;
 b=M6k+8+jX5ehrPZbfxDtR0IkrrVSrmARnK/jslCc4A87IOIu4T1/7xFjp7XZPYNE+R1
 B2ZEyRFYiPkGeVQYSKpYFgK/S3GgDvXb130SGXZwEIT3GN9Isxh7t4k/5AuZ8qS+Xzc+
 jWpJYZjr4raoWUdK87sdo9LRGp4iJ9IQ4tJjZKj5nqsZK/dQyfVVvnC7qWB63/WXhsgk
 A3FDBIDTY0uPtNFdG+i1DX/aJp2hD+/Tn688ax5ZtMw6ER5wx3JTkantEK4anqEq70Dg
 /5XZEQnGr2OEuGBxaZFE2at5RdDSRv2OUlij0yrkWhxRucQxmjU7qJGaWwUXM+bY9XRc
 DUBw==
X-Gm-Message-State: AOJu0YxST8tpd08pe7QvBkVJOItkIij+gjnjz0IhVVIH5H8bnrkGQR7N
 M/8xzAVcHX4k2jEatZBYeAvq1/yczbc8gCjOibwmXQKb2nDIEgw62an+28lQFK4=
X-Gm-Gg: ASbGncsTutUmblnG7qjrkjQbGSe6NBiVar5eWrA+aIN+Ga0YVuoRWvcCDiIKaX11PdL
 kFt9w8rF9/1W1l/d4VCW6aq2JAItKXwU5sQZ/qfYDRFhUmtVWF0JQo+pHkoo7SX6WX1l5kDFOdD
 iZ4sapqGKtWnOp/16D/1jOT/RWYLXyb1DCfXnbkLpKPObuEtYQ+TOCXZDdP0RNXfq8QX92G2vVE
 myc+tWkR/iws84TE2U5VX8DIgIGRYZmypPllsFB3XtJ76z2m/XJ4m8zUJmx1nOIjuSEnH7Vot0/
 3BERyFB2bUTCl0Md079lJJumA3MCKRSr6UfpnGu321lXevPOZB6KVznItXzTxN7W1FJFYRRmynE
 aS4M0A2Rj6ODI+NP96S7XJAnhxkVNpQ==
X-Google-Smtp-Source: AGHT+IEZJ8kQDOZo5f7fCeSosMbVQsqHReT5pYRRzGT/OgbwcFofN/cBGbDpEHJKZaHWjU56zHxn+g==
X-Received: by 2002:a17:90b:2801:b0:2fe:99cf:f566 with SMTP id
 98e67ed59e1d1-3087bb573d8mr7448566a91.13.1745046938785; 
 Sat, 19 Apr 2025 00:15:38 -0700 (PDT)
Received: from ?IPV6:2400:4050:b783:b00:9e36:5f4c:928c:4ec2?
 ([2400:4050:b783:b00:9e36:5f4c:928c:4ec2])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3087dee88d4sm2435263a91.1.2025.04.19.00.15.36
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 19 Apr 2025 00:15:38 -0700 (PDT)
Message-ID: <f433b729-c9ab-4d06-9220-708c8158f3a3@daynix.com>
Date: Sat, 19 Apr 2025 16:15:35 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/8] net/e1000e: Permit disabling interrupt throttling
To: Nicholas Piggin <npiggin@gmail.com>
Cc: qemu-devel@nongnu.org, Dmitry Fleytman <dmitry.fleytman@gmail.com>,
 Jason Wang <jasowang@redhat.com>,
 Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>,
 Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
References: <20250411043128.201289-1-npiggin@gmail.com>
 <20250411043128.201289-3-npiggin@gmail.com>
Content-Language: en-US
From: Akihiko Odaki <akihiko.odaki@daynix.com>
In-Reply-To: <20250411043128.201289-3-npiggin@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1031;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pj1-x1031.google.com
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
> The spec explicitly permits xITR register interval field to have a value
> of zero to disable throttling. The e1000e model already allows for this
> in the throttling logic, so remove the minimum value for the register.
> 
> The spec appears to say there is a maximum observable interrupt rate
> when throttling is enabled, regardless of ITR value, so throttle timer
> calculation is clamped to that minimum value.
> 
> EITR registers default to 0, as specified in spec 7.4.4.
> 
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> ---
>   hw/net/e1000e_core.c | 25 +++++++++++++++++--------
>   1 file changed, 17 insertions(+), 8 deletions(-)
> 
> diff --git a/hw/net/e1000e_core.c b/hw/net/e1000e_core.c
> index 24138587905..96f74f1ea14 100644
> --- a/hw/net/e1000e_core.c
> +++ b/hw/net/e1000e_core.c
> @@ -51,8 +51,17 @@
>   
>   #include "trace.h"
>   
> -/* No more then 7813 interrupts per second according to spec 10.2.4.2 */
> -#define E1000E_MIN_XITR     (500)
> +/*
> + * A suggested range for ITR is 651-5580, according to spec 10.2.4.2, but
> + * QEMU has traditionally set 500 here.
> + */
> +#define E1000E_DEFAULT_ITR (500)
> +
> +/*
> + * spec 7.4.4 ITR rules says the maximum observable interrupt rate from the
> + * adapter should not exceed 7813/s (corresponding to 500).
> + */
> +#define E1000E_EFFECTIVE_MIN_XITR (500)
>   
>   #define E1000E_MAX_TX_FRAGS (64)
>   
> @@ -105,8 +114,9 @@ e1000e_lower_legacy_irq(E1000ECore *core)
>   static inline void
>   e1000e_intrmgr_rearm_timer(E1000IntrDelayTimer *timer)
>   {
> -    int64_t delay_ns = (int64_t) timer->core->mac[timer->delay_reg] *
> -                                 timer->delay_resolution_ns;
> +    uint32_t delay = MAX(timer->core->mac[timer->delay_reg],
> +                         E1000E_EFFECTIVE_MIN_XITR);
> +    int64_t delay_ns = (int64_t)delay * timer->delay_resolution_ns;
>   
>       trace_e1000e_irq_rearm_timer(timer->delay_reg << 2, delay_ns);
>   
> @@ -2783,7 +2793,7 @@ e1000e_set_itr(E1000ECore *core, int index, uint32_t val)
>       trace_e1000e_irq_itr_set(val);
>   
>       core->itr_guest_value = interval;
> -    core->mac[index] = MAX(interval, E1000E_MIN_XITR);
> +    core->mac[index] = interval;
>   }
>   
>   static void
> @@ -2795,7 +2805,7 @@ e1000e_set_eitr(E1000ECore *core, int index, uint32_t val)
>       trace_e1000e_irq_eitr_set(eitr_num, val);
>   
>       core->eitr_guest_value[eitr_num] = interval;
> -    core->mac[index] = MAX(interval, E1000E_MIN_XITR);
> +    core->mac[index] = interval;
>   }
>   
>   static void
> @@ -3444,8 +3454,7 @@ static const uint32_t e1000e_mac_reg_init[] = {
>       [FACTPS]        = E1000_FACTPS_LAN0_ON | 0x20000000,
>       [SWSM]          = 1,
>       [RXCSUM]        = E1000_RXCSUM_IPOFLD | E1000_RXCSUM_TUOFLD,
> -    [ITR]           = E1000E_MIN_XITR,
> -    [EITR...EITR + E1000E_MSIX_VEC_NUM - 1] = E1000E_MIN_XITR,
> +    [ITR]           = E1000E_DEFAULT_ITR,

I think you can change the initial ITR value as you do for EITR.

>   };
>   
>   static void e1000e_reset(E1000ECore *core, bool sw)


