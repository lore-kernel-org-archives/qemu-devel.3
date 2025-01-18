Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25519C02185
	for <qemu-devel@archiver.kernel.org>; Sat, 18 Jan 2025 08:23:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tZ46j-0005sv-OZ; Sat, 18 Jan 2025 03:23:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1tZ46h-0005sj-Ie
 for qemu-devel@nongnu.org; Sat, 18 Jan 2025 03:23:03 -0500
Received: from mail-pl1-x630.google.com ([2607:f8b0:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1tZ46f-0002xB-75
 for qemu-devel@nongnu.org; Sat, 18 Jan 2025 03:23:03 -0500
Received: by mail-pl1-x630.google.com with SMTP id
 d9443c01a7336-2163dc5155fso54801985ad.0
 for <qemu-devel@nongnu.org>; Sat, 18 Jan 2025 00:23:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1737188579; x=1737793379;
 darn=nongnu.org; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=CwvfOnR70dFh+IMMbChoYbTK5VOYF2LCTqFFPyfu94Q=;
 b=YwIDT+xNBUi0yzhAXUZUurY8BpuLoQ3gnacNv8zbWBmbqzBU/zx0imPDO6nUeAo6Eq
 QoIe5z1cZo/tsJKpzDPHbc2woWYvEB1fSQPpYL5eEI6JxeXQ47Nt+P0Xzdngi2eXsrqW
 WQhF+agayAG3/SoLv5JogEWqAh6ZrP56m5LKUTMfzyhEfMPccwELU+98jlUoach+4W3r
 1EqAdJnWLNlo4AEameZhzoEqfH5KV5fCLjsAlV5X9sejBmDrfBeVNQg8yYHNU4Q043dC
 mfiqZ9PO8SVJBlalNrnp/E80sBlo76QTfcBCk0vILePF3pBKvvNnRbBnj6+uoujk2uU2
 TWuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737188579; x=1737793379;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=CwvfOnR70dFh+IMMbChoYbTK5VOYF2LCTqFFPyfu94Q=;
 b=j3cMyYx3bBZ1eA+W2qGfuM7l0vsIvQCSt+1l86h6iNzgKhb9IgUXKBxDH4bmEHyJN9
 BH2GOVxtMEr8HG5/VPPoSPC7y07fJOaOdELf1BEEuFWgKNGfpVezgPgNBLhkgbcOLab7
 VIGpowkG/MC36TmU0FGuNnhClw4dilTcagwu5GJSESnQ2Jei7gkByyEFomPCVsQFtYxR
 6N65RJCRqwusuZbl1yv2N17CkdK77s2ZX02dadqjvx0GaiRVoDOf5JdM9+F+bjE5bihW
 gO4xJsHlERGHGu2kpbQLoTwTWRLlz4jtoF4hAPvfpGidLTWlhGK1upDRPrK2wnoo3Ori
 fGrg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVDHNKJ5VUelBPc+yAV2WqKYWWj/Zj7C15+ZjRkqeznb4FbMLznlELPKqfUTVkhlk+TzTD0JSvZ58FE@nongnu.org
X-Gm-Message-State: AOJu0YyGuGr7MBuEy/HXYDH1N9p8y0QHNWqdYiyI6vqyozHsnUgSGVMe
 vuxZMrsOY13g631gn7VERElWy0+UPqC5dazCgnLuORxpl5K4D/UMZq1APkSEtAk=
X-Gm-Gg: ASbGncs/vTyAqs6BzHFBk8JaHXqYVPT0CfuFg/LajEW8BcnfV1DDmKy+542MSzceqBv
 mecZIqBBD7PtTH2vzoL/o9VkR9EU5cbcTLU1jQAF9Vm0J5LQTxddbzNZFqgbBnOmm1s5dWm1BHy
 Ghm1vMEGgz3WEAtWiUn+8kCNCaxw4yhtKM+zx1k7ik8MVDaI+3ELL8tdB3ZUOofoQenheyNIXJz
 exqwBgSCwgewo5sdCGCqGAaaTnFkcjjnDFQ5JRLPKE5Ndz9O9cNwPYXUml6ytvz7gJqX8m7LzQK
 NZI=
X-Google-Smtp-Source: AGHT+IH6P9KGQ+PaNlDFJBCR2wgieChvfZp3kX8C29N2vw3ZFaOweXaguOPibvk2UBRlEn/vR0eoOw==
X-Received: by 2002:a17:90a:d2d0:b0:2ea:7fd8:9dc1 with SMTP id
 98e67ed59e1d1-2f782c9cb34mr9126167a91.18.1737188579555; 
 Sat, 18 Jan 2025 00:22:59 -0800 (PST)
Received: from [10.4.77.142] ([118.103.63.134])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-a9bdd30d1fdsm3131359a12.60.2025.01.18.00.22.57
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 18 Jan 2025 00:22:59 -0800 (PST)
Message-ID: <36897771-e2c3-4ad6-a665-ec674d8bfa0a@daynix.com>
Date: Sat, 18 Jan 2025 17:22:55 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/9] net/igb: Fix interrupt throttling interval calculation
To: Nicholas Piggin <npiggin@gmail.com>, qemu-devel@nongnu.org
Cc: Dmitry Fleytman <dmitry.fleytman@gmail.com>,
 Jason Wang <jasowang@redhat.com>,
 Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>,
 Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
References: <20250117170306.403075-1-npiggin@gmail.com>
 <20250117170306.403075-5-npiggin@gmail.com>
Content-Language: en-US
From: Akihiko Odaki <akihiko.odaki@daynix.com>
In-Reply-To: <20250117170306.403075-5-npiggin@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::630;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pl1-x630.google.com
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
> IGB throttling granularity is 1us, and interval field is in bits 2..14
> of the EITRx registers.
> 
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>

Please add Fixes: as described in docs/devel/submitting-a-patch.rst

> ---
>   hw/net/igb_regs.h | 3 +++
>   hw/net/igb_core.c | 7 ++++---
>   2 files changed, 7 insertions(+), 3 deletions(-)
> 
> diff --git a/hw/net/igb_regs.h b/hw/net/igb_regs.h
> index 4dc4c31da27..1ed5ee5039a 100644
> --- a/hw/net/igb_regs.h
> +++ b/hw/net/igb_regs.h
> @@ -146,6 +146,9 @@ union e1000_adv_rx_desc {
>   #define IGB_82576_VF_DEV_ID        0x10CA
>   #define IGB_I350_VF_DEV_ID         0x1520
>   
> +/* Delay increments in nanoseconds for interrupt throttling registers */
> +#define IGB_INTR_THROTTLING_NS_RES (1000)
> +
>   /* VLAN info */
>   #define IGB_TX_FLAGS_VLAN_MASK     0xffff0000
>   #define IGB_TX_FLAGS_VLAN_SHIFT    16
> diff --git a/hw/net/igb_core.c b/hw/net/igb_core.c
> index 39e3ce1c8fe..94f9785749a 100644
> --- a/hw/net/igb_core.c
> +++ b/hw/net/igb_core.c
> @@ -142,8 +142,9 @@ static void igb_msix_notify(IGBCore *core, unsigned int cause)
>   static inline void
>   igb_intrmgr_rearm_timer(IGBIntrDelayTimer *timer)
>   {
> -    int64_t delay_ns = (int64_t) timer->core->mac[timer->delay_reg] *
> -                                 timer->delay_resolution_ns;
> +    int64_t delay_ns =
> +            (int64_t)((timer->core->mac[timer->delay_reg] & 0x7FFC) >> 2) *
> +                     timer->delay_resolution_ns;
>   
>       trace_e1000e_irq_rearm_timer(timer->delay_reg << 2, delay_ns);
>   
> @@ -180,7 +181,7 @@ igb_intrmgr_initialize_all_timers(IGBCore *core, bool create)
>       for (i = 0; i < IGB_INTR_NUM; i++) {
>           core->eitr[i].core = core;
>           core->eitr[i].delay_reg = EITR0 + i;
> -        core->eitr[i].delay_resolution_ns = E1000_INTR_DELAY_NS_RES;
> +        core->eitr[i].delay_resolution_ns = IGB_INTR_THROTTLING_NS_RES;
>       }
>   
>       if (!create) {


