Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 629DCC369C2
	for <qemu-devel@archiver.kernel.org>; Mon,  5 May 2025 05:52:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uBokJ-00031A-J6; Mon, 05 May 2025 01:52:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1uBokI-00030w-AE
 for qemu-devel@nongnu.org; Mon, 05 May 2025 01:52:06 -0400
Received: from mail-pl1-x62c.google.com ([2607:f8b0:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1uBokG-0001gx-Pj
 for qemu-devel@nongnu.org; Mon, 05 May 2025 01:52:06 -0400
Received: by mail-pl1-x62c.google.com with SMTP id
 d9443c01a7336-2264aefc45dso62020445ad.0
 for <qemu-devel@nongnu.org>; Sun, 04 May 2025 22:52:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1746424323; x=1747029123;
 darn=nongnu.org; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=S4DoZDJGudCeG5KbAWUe3iX6F1PxYgTD56UpUi9BEmA=;
 b=j9iMzYddjGNYirxuoQIUzF8r/Xi/yLJWRWXs06b+J1iomEC/BCPitiviN2yokHEnVk
 t5XOfkFTjjvYutxiSvTXDtKK9oV5j8AaU1mD9p6AewcgKjjIuDIClueztdr1skgYtOK0
 4H1YBRF64Rdmzwqz9BPRSiN/C547I5X98Od2RsajZMHCrYm+h58LF0cd4miDrzSKcH/X
 8QO0I6ZPqlAQvVMxtHX9+INXsC4XOdMc6laebqAMZCeHugTa1xT+UFSUpThnBC4GhB5N
 5xFzvkpnDel/av5TFGcyKaXUcKYItH0UIIydV6uCuhHnwmj5dGvIiBBV14FlgFq4BI/d
 6YGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746424323; x=1747029123;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=S4DoZDJGudCeG5KbAWUe3iX6F1PxYgTD56UpUi9BEmA=;
 b=vOhvCbZbH3Ufd9R5fwtcloONrh2tfSIJGi+mv69pkq33EU+7TODWX5pGKNzCV7Tpas
 5JSe5D5fqsoySBh3Eby0cTe6P+qoolA5ACgaYxrxnSAAxkmcA8w3KNyi4s9bLdTSi233
 ao/OdK5MqSsZ61z+K9L09LoXB1EneSHS5zNufhHwj6vcIzqoub9jDXoGuGSlycGKNxbe
 4/UESPZzF/RxFHAWo+R1OR391Lz3C9Mjc6sPlxajzMVsw4a0SRn+eOB+Nx2hudxQbJQ5
 6oz4JC2pXUBT5dm+mPVRWrtP8UnAmIfncC4pfZ5ex6JLulKHB1cvSvERk1NxqsAFuQg/
 6HNQ==
X-Gm-Message-State: AOJu0Yw8zKczmiFkgDeWfOnDgekFtW+oTCgX2ATeV2plJEXRYKP43WKP
 ZADEHOItS03L0Dy5NalC8j6sDEu/RoLK9aeClMPWErMSMS4UFcoQ6Rgx+6IU4oc=
X-Gm-Gg: ASbGncvYSjnuD7jW1C3KYzQUNIgl3Q64Q9OrMgpW4uyk7KT6pmNy6qNcHbcxhtXm3hC
 1EMgLlgeqhoJ0YMBiYjVVuCpg9yJS8Y1S5kg4pEn0K+CQbMpZnWaGqJdWVLWDOR4ThDI7vtuLF/
 AcWc04DklxdbhA8yZtJbeaLD0eEDQ9XedW2bBraPeqTaCpKM7L15ZWd9PVymiVS7wuxaoOLFZ0/
 gvJGfV6VmM18sHBQgxIXhgX4z+/sY12cbTnsSAfiA1fQxxJYqTmWVdmoYPaYyNjOdlSiVuWrDag
 xwL3YU/Q58A2xvT6R7SkitgBKshds0jR82GW5utrlcpdPc0T/P0NvZdsDZGA1g==
X-Google-Smtp-Source: AGHT+IF6rT2AfJoqPsgaMUR4mhbfkXJITq8RLJWSKJT7mZuSkte1vXGiVY1vRAmvZjb24QPovoVctQ==
X-Received: by 2002:a17:902:fc86:b0:227:ac2a:2472 with SMTP id
 d9443c01a7336-22e1ea7c667mr97624915ad.28.1746424322837; 
 Sun, 04 May 2025 22:52:02 -0700 (PDT)
Received: from [157.82.207.61] ([157.82.207.61])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-74058d7b1cdsm5894476b3a.25.2025.05.04.22.52.00
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 04 May 2025 22:52:02 -0700 (PDT)
Message-ID: <0ff9c661-bb52-4a07-924b-96fb57ecda81@daynix.com>
Date: Mon, 5 May 2025 14:51:59 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 10/12] net/e1000e|igb: Only send delayed msix
 interrupts that have a cause
To: Nicholas Piggin <npiggin@gmail.com>
Cc: qemu-devel@nongnu.org, Dmitry Fleytman <dmitry.fleytman@gmail.com>,
 Jason Wang <jasowang@redhat.com>,
 Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>,
 Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
References: <20250502031705.100768-1-npiggin@gmail.com>
 <20250502031705.100768-11-npiggin@gmail.com>
Content-Language: en-US
From: Akihiko Odaki <akihiko.odaki@daynix.com>
In-Reply-To: <20250502031705.100768-11-npiggin@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62c;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pl1-x62c.google.com
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
> The msix interrupt throttling timer expiry sends an interrupt even if
> there is no unmasked interrupt causes. This can be observed by seeing
> two interrupts in response to a single event when throttling is active.
> 
> The e1000e non-msix paths seem to get this right by masking and testing
> ICR and IMS. Add similar checks for the msix cases in e1000e and igb.
> 
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> ---
>   hw/net/e1000e_core.c | 10 ++++++----
>   hw/net/igb_core.c    | 11 ++++++++---
>   2 files changed, 14 insertions(+), 7 deletions(-)
> 
> diff --git a/hw/net/e1000e_core.c b/hw/net/e1000e_core.c
> index 022884a2ea0..d53f70065ef 100644
> --- a/hw/net/e1000e_core.c
> +++ b/hw/net/e1000e_core.c
> @@ -230,10 +230,12 @@ e1000e_intrmgr_on_msix_throttling_timer(void *opaque)
>   
>       timer->running = false;
>   
> -    causes = find_msix_causes(core, idx);
> -    trace_e1000e_irq_msix_notify_postponed_vec(idx);
> -    msix_notify(core->owner, idx);
> -    e1000e_msix_auto_clear_mask(core, causes);
> +    causes = find_msix_causes(core, idx) & core->mac[IMS] & core->mac[ICR];
> +    if (causes) {
> +        trace_e1000e_irq_msix_notify_postponed_vec(idx);
> +        msix_notify(core->owner, causes);

I think this should be: msix_notify(core->owner, idx);

> +        e1000e_msix_auto_clear_mask(core, causes);
> +    }
>   }
>   
>   static void
> diff --git a/hw/net/igb_core.c b/hw/net/igb_core.c
> index 3ae3e53530b..035637f81f8 100644
> --- a/hw/net/igb_core.c
> +++ b/hw/net/igb_core.c
> @@ -171,12 +171,17 @@ static void
>   igb_intrmgr_on_msix_throttling_timer(void *opaque)
>   {
>       IGBIntrDelayTimer *timer = opaque;
> -    int idx = timer - &timer->core->eitr[0];
> +    IGBCore *core = timer->core;
> +    int vector = timer - &core->eitr[0];
> +    uint32_t causes;
>   
>       timer->running = false;
>   
> -    trace_e1000e_irq_msix_notify_postponed_vec(idx);
> -    igb_msix_notify(timer->core, idx);
> +    causes = core->mac[EICR] & core->mac[EIMS];
> +    if (causes & BIT(vector)) {
> +        trace_e1000e_irq_msix_notify_postponed_vec(vector);
> +        igb_msix_notify(core, vector);
> +    }
>   }
>   
>   static void


