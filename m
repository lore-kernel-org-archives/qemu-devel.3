Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4872C369C2
	for <qemu-devel@archiver.kernel.org>; Mon,  5 May 2025 05:42:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uBoaL-0000k7-DD; Mon, 05 May 2025 01:41:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1uBoaI-0000jx-SQ
 for qemu-devel@nongnu.org; Mon, 05 May 2025 01:41:47 -0400
Received: from mail-pj1-x1029.google.com ([2607:f8b0:4864:20::1029])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1uBoaH-0000de-8I
 for qemu-devel@nongnu.org; Mon, 05 May 2025 01:41:46 -0400
Received: by mail-pj1-x1029.google.com with SMTP id
 98e67ed59e1d1-301302a328bso5078638a91.2
 for <qemu-devel@nongnu.org>; Sun, 04 May 2025 22:41:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1746423703; x=1747028503;
 darn=nongnu.org; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=NWER6GUp+AG9jr26RcxOWOjBIhGVqNSX7hinpOrhCKU=;
 b=MFjsoGgVYPkQh+k6aEc5vzyGrPN7e6Unv0LQjkCsXInGpqkNO2uXrme6pftIW9QZAK
 9vaIh1FdJqN6reoPdH4Y2h1wVcLNn+Snm5x1dsttjzG8v2QoCYx8z09tIyruaa36SJOz
 9knWk2jcR80cEZgRXyT3RXDYeAqVsDtO57o5Qa+qcPcQ8vO3uKwrLwus9M6/FzRcPaoP
 //FCkkTJOK3qD2BR03jSbw6YGv1oSztaLHicNrbsYO7inPAB0gVs1FyRU7milR3WZ6qa
 HlM+twvsQ9CS5XYlsYjh4N72vSw0dRH9uL/ZW5Tcpu8B/XvM6BlJ+ZvynrIrZThJfIDi
 jkNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746423703; x=1747028503;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=NWER6GUp+AG9jr26RcxOWOjBIhGVqNSX7hinpOrhCKU=;
 b=VreUoGzYZoqtuD+BxEyBnPXnRHvsOEpbXxqZc+CJcF40hmg2lSAs6R43aPF1vrtEwe
 WFU5+CAP8NnWl2Chl3Y/zRFZz58TzIF9O/i7M4FIS3iNSMw/Bp4/qxKoHsjOUoT9qV8G
 lfxQBucal9IYs18SWhW5lPUFixZo0rroifkP8xRg6e8DjJaHyfZERDgD2IRng+CAEWUb
 VGBaTI7uwKz8EGQ8OnOxUv2lvuPKEHx+jOC72JHyPCU66G8ohCCk9yrR7HD9qGvW9btD
 8D+1bjWT6bmdZ1EonZ67XhHQ2hNx8PEoQ4keQJTz86URuQEj/lyDSVMJOT+5M2IYtJ+L
 fZpA==
X-Gm-Message-State: AOJu0YzGiyrBa9av5eVTD9cF8TsWVTChyCeh+5cBUOzQpQaHj4jVJjbL
 ylSedxaCvUUBO4cd9ZloA0txDrJFrqFg0w8Tu7TZU1rSLs0ZDNC7dLt4SVYGkFc=
X-Gm-Gg: ASbGncs4kHUAHwVdGJ7uW2fRJyWkMb9HfayJMt2jNTmDwr1INQIAQ/VV0uI0SC5hUND
 HdacySlg+0Gb8VdgNl6Pttr2v/NyowOE0jfKjkZbbG+8tmCXI1ZTYZs1x1HvcDRQrpED1W1A/4S
 vn9iDrzYA3kbuJDQvpG8HrwRzKnSkBcEkGFyAeG0D5HMLGLdVY0dks4WrXzcl/EFtTelnWnQi5e
 pLB+1I/3IwdnO9G2gQ4NwSD4/f/nBaHxG/3Zv/YsU+KQql7Cs44dvKK0J94qZdjT50eJma2VISg
 pGMTCn5lfinTdEUz5kdssm3L9fh+kWXJBrnLeGlmiBYfwI4KRfE=
X-Google-Smtp-Source: AGHT+IGwNXObBB1rijZ85orNF8QTOG6VV4qFsLEkiZUdCvR9IiNNePhYLdvXRPPAGRxdUNTqEKOQOg==
X-Received: by 2002:a17:90b:5745:b0:2fc:3264:3657 with SMTP id
 98e67ed59e1d1-30a6174fd95mr11247384a91.0.1746423703145; 
 Sun, 04 May 2025 22:41:43 -0700 (PDT)
Received: from [157.82.207.61] ([157.82.207.61])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-30a4b21514fsm8062525a91.14.2025.05.04.22.41.41
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 04 May 2025 22:41:42 -0700 (PDT)
Message-ID: <ca80c0c3-e921-4f60-8a23-fcae0805e756@daynix.com>
Date: Mon, 5 May 2025 14:41:39 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 02/12] net/e1000e: Permit disabling interrupt throttling
To: Nicholas Piggin <npiggin@gmail.com>
Cc: qemu-devel@nongnu.org, Dmitry Fleytman <dmitry.fleytman@gmail.com>,
 Jason Wang <jasowang@redhat.com>,
 Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>,
 Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
References: <20250502031705.100768-1-npiggin@gmail.com>
 <20250502031705.100768-3-npiggin@gmail.com>
Content-Language: en-US
From: Akihiko Odaki <akihiko.odaki@daynix.com>
In-Reply-To: <20250502031705.100768-3-npiggin@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1029;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pj1-x1029.google.com
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

The cover letter says this version changes "initial ITR as well as EITR" 
but the ITR value is unchanged here. Forgot to commit the change?

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
>   };
>   
>   static void e1000e_reset(E1000ECore *core, bool sw)


