Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38818C369BD
	for <qemu-devel@archiver.kernel.org>; Sat, 19 Apr 2025 07:23:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u62X7-0003RS-4q; Sat, 19 Apr 2025 03:22:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1u62X4-0003RD-MO
 for qemu-devel@nongnu.org; Sat, 19 Apr 2025 03:22:34 -0400
Received: from mail-pf1-x430.google.com ([2607:f8b0:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1u62X3-00044p-2I
 for qemu-devel@nongnu.org; Sat, 19 Apr 2025 03:22:34 -0400
Received: by mail-pf1-x430.google.com with SMTP id
 d2e1a72fcca58-736c277331eso3248655b3a.1
 for <qemu-devel@nongnu.org>; Sat, 19 Apr 2025 00:22:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1745047351; x=1745652151;
 darn=nongnu.org; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=wa2FMKXZ6RAoAgzfBBEH2pYxaYnj8x5HJHMn1T64v5g=;
 b=JOanb6kBoP16jTVPQX/myIXEIhx9aaLVdOc3RfEMbV10kEThQXjUGNWbf5J81+WOGF
 hECQ61Jpwjqe53wbFVtFwQU4edK+4ia5TcuVd0SFlkeX1CtRNs/jERm5upiIaiNuTEWt
 e0OoJHS8TayKSxPiw8U1Dcj2zT+sB0e54lmyRxvjVSFlIYP3gXodlOq+2UqzkupgDh+I
 cvYUfml/7yJR0Y7+NIxuoCAPsHv/jSNXlpfpa6c8i42np9lN2OtsU1OnQc5K2LJpDwhD
 OAMGhEchEFSI9Xo5z9janvIxmSimQV2vvYg4D0SMP+0zI1lMG++vdX08fqO8VPLBtYP3
 +Lmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745047351; x=1745652151;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=wa2FMKXZ6RAoAgzfBBEH2pYxaYnj8x5HJHMn1T64v5g=;
 b=o8n2qcW3cT3bAtjANb13o/A058pUJ/lOdRc+910WCmtR3ehpRFwkQIqb5i+0ZfFC4O
 s+3GhPxKPVxDbAzA6sVPBGV9RW6ab132webMRqQ1p+rIbPvqeY6BhRpKi/qEnA2YdYDy
 LSm/UsNSx9YECuCrxfPUSn9ttM52EA91K8waNYmzhdVWC7E1EAcA/8v0cNolzB4WzwUT
 N0ebjWGyzDIf6mTC3qVvd/GBZYyrD38QM8FwNdNa2+/KQqSuzzYVEGCavGQN+QWpA/uE
 hluBaE0WNSH7HgMdvOee37ZsjPPy7nHw6pzpSQhZ+siLvEfikI1Aik8mTON3bS1qrRmU
 hAhg==
X-Gm-Message-State: AOJu0Yw7s3iixjmnQQ5aGR+FUJuWMD2Xr769Vi7CDsIqUnCOjGdKX5Hs
 EOAjCUzcu2PgLvWWWRuuYUQu/LN8zY6IfNw+1MI5i4FsfE2sdmLNZzEywXBZBkY=
X-Gm-Gg: ASbGncsdV2qqHTX2VqS7KoZpHFJhdhZ7+T9Jslkpq+KKMxfu/nAjQuDj+5XmGHth4rl
 XdlA7j+QdSDPDJx/ieRzOQ29Cw8g/acfPzAM2qeK1/bZcRi1qt7HUDASJJx7mgbDj5sF9Ti0qyq
 /vh6VtPuPfCqJwUzZNDamICaoK2LwVgKZ1gGg9avjUbhhilKg+pQBaCD4delAf2qE57xjjOKIme
 tN+BAW4Vgd8HpkxzSRl/HMWe6DEWa+GeFPa10uNeiMBWtbOsBJaWRs9Ic/P6IQYk+a36g9lUSMo
 G1OGDgCeeTzwviK55npyN8bQERDcZ9MEzUxHjSlKYqxzisK4rqWlfq5Y1ZvznHct5g7hGtcSQhK
 3VK/irHB5CySHNAP+noo=
X-Google-Smtp-Source: AGHT+IEzbPn2rcLJKGHFAE4yGRLPz98HXeZJXDs3Nlv5SX/I6oRi8YTnmM5LiDOIFjqsTEnRPe60bg==
X-Received: by 2002:a05:6a20:158e:b0:1f0:e2d0:fb65 with SMTP id
 adf61e73a8af0-203cc5a86d8mr7304476637.2.1745047350736; 
 Sat, 19 Apr 2025 00:22:30 -0700 (PDT)
Received: from ?IPV6:2400:4050:b783:b00:9e36:5f4c:928c:4ec2?
 ([2400:4050:b783:b00:9e36:5f4c:928c:4ec2])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-73dbfa58871sm2836154b3a.102.2025.04.19.00.22.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 19 Apr 2025 00:22:30 -0700 (PDT)
Message-ID: <6ed925fc-ee81-4342-bc40-5ef15eaa0e08@daynix.com>
Date: Sat, 19 Apr 2025 16:22:27 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 5/8] net/igb: Fix interrupt throttling interval
 calculation
To: Nicholas Piggin <npiggin@gmail.com>
Cc: qemu-devel@nongnu.org, Dmitry Fleytman <dmitry.fleytman@gmail.com>,
 Jason Wang <jasowang@redhat.com>,
 Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>,
 Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
References: <20250411043128.201289-1-npiggin@gmail.com>
 <20250411043128.201289-6-npiggin@gmail.com>
Content-Language: en-US
From: Akihiko Odaki <akihiko.odaki@daynix.com>
In-Reply-To: <20250411043128.201289-6-npiggin@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::430;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pf1-x430.google.com
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
> IGB throttling granularity is 1us, and interval field is in bits 2..14
> of the EITRx registers.
> 
> Fixes: 3a977deebe6b ("Intrdocue igb device emulation")
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
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

Let's use the SCALE_US definition.

> +
>   /* VLAN info */
>   #define IGB_TX_FLAGS_VLAN_MASK     0xffff0000
>   #define IGB_TX_FLAGS_VLAN_SHIFT    16
> diff --git a/hw/net/igb_core.c b/hw/net/igb_core.c
> index 5d169c059d9..8fcc872a7c0 100644
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


