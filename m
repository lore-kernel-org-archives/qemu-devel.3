Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6EEB3C369C2
	for <qemu-devel@archiver.kernel.org>; Mon,  5 May 2025 05:46:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uBoeQ-0001hq-6l; Mon, 05 May 2025 01:46:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1uBoeH-0001h0-Qn
 for qemu-devel@nongnu.org; Mon, 05 May 2025 01:45:55 -0400
Received: from mail-pl1-x636.google.com ([2607:f8b0:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1uBoeD-00011x-EK
 for qemu-devel@nongnu.org; Mon, 05 May 2025 01:45:51 -0400
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-22c3407a87aso59994005ad.3
 for <qemu-devel@nongnu.org>; Sun, 04 May 2025 22:45:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1746423947; x=1747028747;
 darn=nongnu.org; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=kQ6BqmhseH93J9aEhZzYz92D/qDV4m12C97EfAkE4YQ=;
 b=C1TmZxgFFyvgWNC0RGPJU2FONp4S0z9Oiqh/aMQ7vKt9Tzf5CHYAtf6BWTdBFD3Han
 C8BZkFq3joBeOnjJW9gGlpls8HrIG1AIyjm/9TPJi6eL+GcPW+DpF7AkPIiqBRmNZsnL
 ae/TK2YxhQAOeEioGi7os1vtcrRJoVQgssOoFgzoiuze2gb7J036aikfcMQy+tRGGzIs
 rl86P1OehFwSFUMoLcmbfneDSQN6l80iUODPnL4+Pxyd2/Kyw+d+T/emg/vZ5eES692/
 t7+PIL4Lk2UBdM8QR5fVSeCha8ITouqP5lSFYWgIY6kegUij3/qRfL1yyErUYbHTpgrQ
 agAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746423947; x=1747028747;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=kQ6BqmhseH93J9aEhZzYz92D/qDV4m12C97EfAkE4YQ=;
 b=u5bvXgF2eRRcZJGKPfMrW7lyHr0sDd305GX20OlFF+99jZDT1Nl6I1kHLqHmRTGP+x
 bXvz7HtpDVEB55pMYP7SuXAQdCMTm4lgtWao7OboxnX9YZj+5HZDWNKiHdd8pZueIOQe
 iOi+x7LQhe7ULQDMW7rFtajxDc6Bykr9LMRcbd4xQL2zHR+j0Yrjc4fxhfRFuh1m2eLp
 ClJOhqCcWQ3UYK4vQHdeOQAwIJPe0Bdgr/m6+5tCZL0/QNpJCs7jh/MfDMrQ7tXiMlym
 aKwmaqyPhzPkc+CzmRKDF4Ln0xyN6atETWdpgJXGOqbVtCu1t9E4B8g19MTJAmmgNnXd
 CvMw==
X-Gm-Message-State: AOJu0YwCn6yDHDHpSIR7Q7iwM5DodBMet+DA74XihfGg4jfn6bSAGilI
 /9NtHEl57BZOslRRfb9rQR9wzAzTp5q4kpQvYypQEbfLNSnvlzRdRbLfehOM4gI=
X-Gm-Gg: ASbGncvJYTUk/qA+FmnOw1gV5W8YWw3T2UYk/KZFiYyN9+ORuYMIsBnhIC4rbivxxGK
 ejePz9vhGGUt4qc6LMaueqWWUlI9g03/5pwOLHTwEQ8OEVXZ9oMZzgP7E4rc5JLrxS7wU9K7CfS
 iRzRYMB8hLyihx8Z3ZP5/KZaieOw2bkzsjRZm52T7sDY8aGJTPcRs2JmfWAflXZ8h8BYsuzMsJ2
 V9ONB6k7RuUYpRML1JTTcD5A4Hfyjcu988Pr/wJEb866++exgp+IoMkawFtGJ01tW3T48f1Lylu
 LOcKF9OeIkxGrdKHdcyRrlDtB58+hxot8LkiLrP/MzwzK8b86iIHtkcIeEAaZg==
X-Google-Smtp-Source: AGHT+IE2IvVGRClOziuFBG2yfkb49xS0XJLuxn9rrzWDl4T0VqYU5/CoUOmnSjfPCwfis1MNtx5Xlg==
X-Received: by 2002:a17:902:cf42:b0:227:e709:f71 with SMTP id
 d9443c01a7336-22e1ea822aemr103324855ad.29.1746423941169; 
 Sun, 04 May 2025 22:45:41 -0700 (PDT)
Received: from [157.82.207.61] ([157.82.207.61])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22e1521fc90sm46432525ad.148.2025.05.04.22.45.39
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 04 May 2025 22:45:40 -0700 (PDT)
Message-ID: <5576bcff-aa0a-44b7-a3e2-bc2389f9ffaf@daynix.com>
Date: Mon, 5 May 2025 14:45:37 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 03/12] hw/net/e1000e|igb: Remove xitr_guest_value logic
To: Nicholas Piggin <npiggin@gmail.com>
Cc: qemu-devel@nongnu.org, Dmitry Fleytman <dmitry.fleytman@gmail.com>,
 Jason Wang <jasowang@redhat.com>,
 Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>,
 Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
References: <20250502031705.100768-1-npiggin@gmail.com>
 <20250502031705.100768-4-npiggin@gmail.com>
Content-Language: en-US
From: Akihiko Odaki <akihiko.odaki@daynix.com>
In-Reply-To: <20250502031705.100768-4-npiggin@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::636;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pl1-x636.google.com
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

On 2025/05/02 12:16, Nicholas Piggin wrote:
> The guest value xITR logic is not required now that the write functions
> store necessary data to be read back, and internal users mask and shift
> fields they need as they go.
> 
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> ---
>   hw/net/e1000e_core.c | 31 +++++++++++++++----------------
>   hw/net/igb_core.c    | 16 +++++++++++++---
>   2 files changed, 28 insertions(+), 19 deletions(-)
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
> index 39e3ce1c8fe..271c54380e9 100644
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
> @@ -3046,8 +3046,7 @@ igb_set_eitr(IGBCore *core, int index, uint32_t val)
>   
>       trace_igb_irq_eitr_set(eitr_num, val);
>   
> -    core->eitr_guest_value[eitr_num] = val & ~E1000_EITR_CNT_IGNR;
> -    core->mac[index] = val & 0x7FFE;
> +    core->mac[index] = val;

This change will keep the CNT_INGR although the specification says it 
"is always read as zero".

>   }
>   
>   static void
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


