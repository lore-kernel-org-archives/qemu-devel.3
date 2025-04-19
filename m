Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CAB0FC369BD
	for <qemu-devel@archiver.kernel.org>; Sat, 19 Apr 2025 07:13:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u62NW-0001Fw-Tq; Sat, 19 Apr 2025 03:12:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1u62NL-0001FG-3Y
 for qemu-devel@nongnu.org; Sat, 19 Apr 2025 03:12:32 -0400
Received: from mail-pg1-x52d.google.com ([2607:f8b0:4864:20::52d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1u62NE-0002Zm-PE
 for qemu-devel@nongnu.org; Sat, 19 Apr 2025 03:12:27 -0400
Received: by mail-pg1-x52d.google.com with SMTP id
 41be03b00d2f7-aee79a0f192so1589550a12.3
 for <qemu-devel@nongnu.org>; Sat, 19 Apr 2025 00:12:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1745046742; x=1745651542;
 darn=nongnu.org; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=PzisTexGoHkAntn097QKQcRs/R7FHxa172jmGFen9Jg=;
 b=ODkbwIS3u6Kv18A0i91uUOongDY8yPfBElvXe+vKDlc6fY5Z+amycV7POhuk2cS31G
 1HZ+gr2WtXqrOHCi7crW/iYy7Qf+GlHU6NvT1MmhnhuXn+XgSohIxioL14/enJ+78zEu
 oJORxnVyBRLp1KoddV9d9hqqW98Zqmq7Z617L0mPnAQuPEsdO6lzMM+V/ii4nCV3F2ol
 0jebv9jIqhnemctlsyNvKLKqoxgbBk92NxzunFGFfaKqmX68Ea+GpGREW/vNk5j+Sk8L
 gEroXhj9AVd9NGylMxsFaDOWJiCo4ObBMwm+VfU3lG6xOXQ66tRpkhVgbPfVtPPD3nYd
 puIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745046742; x=1745651542;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=PzisTexGoHkAntn097QKQcRs/R7FHxa172jmGFen9Jg=;
 b=EEWNeXRdRPhyEZLCmYV79iPnxsHxKDZls+Z4TTRtl+sH5sel5eLssG/f/ULyRv04tt
 8uKA3RzAt9/cXFbK3Yr+eSgyujVYX3kKueq6vrWHg3F1Y85v2ElOwnx02lVxFOHg0Y0N
 u+nXuKwLBI1bDxHWInvDm5LUWAgIIeaSVpJ9vIQAOdYAYWT4fAAzTPfBw2YdtW90wEhy
 QAqRu/CSLoGYBloAr8oot/g9VDayjw66vx85AWa8wEzy9iscFqM9nWI5Akgs+hJBekFE
 1ouNa8nE4Qkyx6gOxQ7gk/VTeEPdHKgMxHa5xfsNhM217JFZwbrg1tpqLs8xa47YTe+6
 9B3Q==
X-Gm-Message-State: AOJu0YzdZNAJz/BaAIHsu/lPSDOXYpZiqJRUmuEPNGQwiTktKWUxllL9
 IZZRqbxhbt/TGzOpE2rSTGQtOhSuwnxNYC18icUGCcSGXnWs1AM3DSaCAWAfeQ0=
X-Gm-Gg: ASbGncvOisbgn7MiklLhaKyx4wE2TWk42QQEs/wJf3KWP0M26Zu/J9xleSUKlwuGOV9
 vqHbjrEXv6ktbmuLzS5lctnFci3ZaGASi7nfDbXrcW3SbRGMZUHzkdhPyF1wdVeKi4hm3JUVDGO
 aiZ1fg8y5mILLRxCqxtltZuOrTAeyuXOWbRp26Tg8httr2J0niiCrzRm+J9IDxuQ3pTsJMgOhVQ
 mHXcazlVQ2U+osiCOn+9OevWTKltJE+0SORNh24DAwjQxK8RamrHN1oBk6LRj0el3m1ai2wo6kE
 76/91PlzlzHjuqiNvKuooZdzsOiiCpYu5NmpnvKNpi34UrO+JCgjk48JuGEmAONLHQmKr/+cWji
 FUt8KzH/Et02G7wgd/dXikuQJnoZtng==
X-Google-Smtp-Source: AGHT+IEVjYYRvGP2rz7elK2rr9FhWP2fq4Ed8A0JVPqHqt5NjUzqqzq71a4H8jhk8l+V1/3OB/l65g==
X-Received: by 2002:a17:90b:5748:b0:2ff:7ad4:77af with SMTP id
 98e67ed59e1d1-3087bb6e9dbmr7638355a91.20.1745046742448; 
 Sat, 19 Apr 2025 00:12:22 -0700 (PDT)
Received: from ?IPV6:2400:4050:b783:b00:9e36:5f4c:928c:4ec2?
 ([2400:4050:b783:b00:9e36:5f4c:928c:4ec2])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3087e116e0dsm2387457a91.46.2025.04.19.00.12.20
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 19 Apr 2025 00:12:22 -0700 (PDT)
Message-ID: <a766c04a-992a-49e7-aacc-cc51360d662d@daynix.com>
Date: Sat, 19 Apr 2025 16:12:19 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/8] hw/net/e1000e|igb: Remove xitr_guest_value logic
To: Nicholas Piggin <npiggin@gmail.com>
Cc: qemu-devel@nongnu.org, Dmitry Fleytman <dmitry.fleytman@gmail.com>,
 Jason Wang <jasowang@redhat.com>,
 Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>,
 Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
References: <20250411043128.201289-1-npiggin@gmail.com>
 <20250411043128.201289-4-npiggin@gmail.com>
Content-Language: en-US
From: Akihiko Odaki <akihiko.odaki@daynix.com>
In-Reply-To: <20250411043128.201289-4-npiggin@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52d;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pg1-x52d.google.com
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
> The guest value xITR logic is not required now that the write functions
> store necessary data to be read back, and internal users mask and shift
> fields they need as they go.
> 
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> ---
>   hw/net/e1000e_core.c | 31 +++++++++++++++----------------
>   hw/net/igb_core.c    | 14 ++++++++++++--
>   2 files changed, 27 insertions(+), 18 deletions(-)
> 
> diff --git a/hw/net/e1000e_core.c b/hw/net/e1000e_core.c
> index 96f74f1ea14..f8e6522f810 100644
> --- a/hw/net/e1000e_core.c
> +++ b/hw/net/e1000e_core.c
> @@ -2563,18 +2563,6 @@ e1000e_mac_swsm_read(E1000ECore *core, int index)
>       return val;
>   }
>   
> -static uint32_t
> -e1000e_mac_itr_read(E1000ECore *core, int index)
> -{
> -    return core->itr_guest_value;
> -}
> -
> -static uint32_t
> -e1000e_mac_eitr_read(E1000ECore *core, int index)
> -{
> -    return core->eitr_guest_value[index - EITR];
> -}
> -
>   static uint32_t
>   e1000e_mac_icr_read(E1000ECore *core, int index)
>   {
> @@ -2792,7 +2780,6 @@ e1000e_set_itr(E1000ECore *core, int index, uint32_t val)
>   
>       trace_e1000e_irq_itr_set(val);
>   
> -    core->itr_guest_value = interval;
>       core->mac[index] = interval;
>   }
>   
> @@ -2804,7 +2791,6 @@ e1000e_set_eitr(E1000ECore *core, int index, uint32_t val)
>   
>       trace_e1000e_irq_eitr_set(eitr_num, val);
>   
> -    core->eitr_guest_value[eitr_num] = interval;
>       core->mac[index] = interval;
>   }
>   
> @@ -3029,6 +3015,7 @@ static const readops e1000e_macreg_readops[] = {
>       e1000e_getreg(GSCN_1),
>       e1000e_getreg(FCAL),
>       e1000e_getreg(FLSWCNT),
> +    e1000e_getreg(ITR),
>   
>       [TOTH]    = e1000e_mac_read_clr8,
>       [GOTCH]   = e1000e_mac_read_clr8,
> @@ -3062,7 +3049,6 @@ static const readops e1000e_macreg_readops[] = {
>       [MPRC]    = e1000e_mac_read_clr4,
>       [BPTC]    = e1000e_mac_read_clr4,
>       [TSCTC]   = e1000e_mac_read_clr4,
> -    [ITR]     = e1000e_mac_itr_read,
>       [CTRL]    = e1000e_get_ctrl,
>       [TARC1]   = e1000e_get_tarc,
>       [SWSM]    = e1000e_mac_swsm_read,
> @@ -3087,7 +3073,7 @@ static const readops e1000e_macreg_readops[] = {
>       [RETA ... RETA + 31]   = e1000e_mac_readreg,
>       [RSSRK ... RSSRK + 31] = e1000e_mac_readreg,
>       [MAVTV0 ... MAVTV3]    = e1000e_mac_readreg,
> -    [EITR...EITR + E1000E_MSIX_VEC_NUM - 1] = e1000e_mac_eitr_read
> +    [EITR...EITR + E1000E_MSIX_VEC_NUM - 1] = e1000e_mac_readreg,
>   };
>   enum { E1000E_NREADOPS = ARRAY_SIZE(e1000e_macreg_readops) };
>   
> @@ -3517,13 +3503,26 @@ void e1000e_core_pre_save(E1000ECore *core)
>               core->tx[i].skip_cp = true;
>           }
>       }
> +
> +    /* back compat, QEMU moves xITR in itr_guest_value state */
> +    core->itr_guest_value = core->mac[ITR];
> +    for (i = 0; i < E1000E_MSIX_VEC_NUM; i++) {
> +        core->eitr_guest_value[i] = core->mac[EITR + i];
> +    }
>   }
>   
>   int
>   e1000e_core_post_load(E1000ECore *core)
>   {
> +    int i;
>       NetClientState *nc = qemu_get_queue(core->owner_nic);
>   
> +    /* back compat */
> +    core->mac[ITR] = core->itr_guest_value;
> +    for (i = 0; i < E1000E_MSIX_VEC_NUM; i++) {
> +        core->mac[EITR + i] = core->eitr_guest_value[i];
> +    }
> +
>       /*
>        * nc.link_down can't be migrated, so infer link_down according
>        * to link status bit in core.mac[STATUS].
> diff --git a/hw/net/igb_core.c b/hw/net/igb_core.c
> index 39e3ce1c8fe..5d169c059d9 100644
> --- a/hw/net/igb_core.c
> +++ b/hw/net/igb_core.c
> @@ -2880,7 +2880,7 @@ igb_mac_swsm_read(IGBCore *core, int index)
>   static uint32_t
>   igb_mac_eitr_read(IGBCore *core, int index)
>   {
> -    return core->eitr_guest_value[index - EITR0];
> +    return core->mac[index - EITR0];
>   }
>   
>   static uint32_t igb_mac_vfmailbox_read(IGBCore *core, int index)
> @@ -3046,7 +3046,6 @@ igb_set_eitr(IGBCore *core, int index, uint32_t val)
>   
>       trace_igb_irq_eitr_set(eitr_num, val);
>   
> -    core->eitr_guest_value[eitr_num] = val & ~E1000_EITR_CNT_IGNR;
>       core->mac[index] = val & 0x7FFE;

EITR has writable bits not covered with 0x7FFE and they should be preserved.

>   }
>   
> @@ -4527,13 +4526,24 @@ void igb_core_pre_save(IGBCore *core)
>               core->tx[i].skip_cp = true;
>           }
>       }
> +
> +    /* back compat, QEMU moves EITR in eitr_guest_value state */
> +    for (i = 0; i < IGB_INTR_NUM; i++) {
> +        core->eitr_guest_value[i] = core->mac[EITR0 + i];
> +    }
>   }
>   
>   int
>   igb_core_post_load(IGBCore *core)
>   {
> +    int i;
>       NetClientState *nc = qemu_get_queue(core->owner_nic);
>   
> +    /* back compat */
> +    for (i = 0; i < IGB_INTR_NUM; i++) {
> +        core->mac[EITR0 + i] = core->eitr_guest_value[i];
> +    }
> +
>       /*
>        * nc.link_down can't be migrated, so infer link_down according
>        * to link status bit in core.mac[STATUS].


