Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6477EC02185
	for <qemu-devel@archiver.kernel.org>; Sat, 18 Jan 2025 09:51:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tZ5Tf-0000w5-Do; Sat, 18 Jan 2025 04:50:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1tZ5Td-0000vi-Hf
 for qemu-devel@nongnu.org; Sat, 18 Jan 2025 04:50:49 -0500
Received: from mail-pj1-x102c.google.com ([2607:f8b0:4864:20::102c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1tZ5Ta-00068e-Tj
 for qemu-devel@nongnu.org; Sat, 18 Jan 2025 04:50:49 -0500
Received: by mail-pj1-x102c.google.com with SMTP id
 98e67ed59e1d1-2ef28f07dbaso4112119a91.2
 for <qemu-devel@nongnu.org>; Sat, 18 Jan 2025 01:50:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1737193845; x=1737798645;
 darn=nongnu.org; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=ay3sZTO0hcWd5/DERHM1419q3zoJAz5ggux5EruSaF4=;
 b=w2cL7CvQdXmPxZevvXRZYRU7V2OD07LxVe+lPVAvPLUPo+SD4gfYW3Y+Q+At4coLQm
 FZkWNVwTBm1br0v6nUA39HzJcgvohrbCxm0CwfyzmJgh24zQ+yQRWDs39bMmx0ke/Ma1
 YlyQunSU/eo0efnBwsWBmVHQqcJcSklZJYoxRC+kWacbX5eVDloUHHv20vjXw/ISnGT4
 QvWN7vO+JAVMuPz0WIPVWijH4K8pfdmhuThMJ5+MelSjN1Htu5hdhtwJkAboW/Q7IPsL
 VBzHeJGZRRhNfp6PxRWE7U9rlYD9Wi0VDKkxYtGGVWbveHTLavuH6pu2fwFv96Y8dc3b
 mBfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737193845; x=1737798645;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ay3sZTO0hcWd5/DERHM1419q3zoJAz5ggux5EruSaF4=;
 b=PL7ft3haKc+7RDpEUc5TEhn481KDv+Wi7zy5LnJorlkOOO8MhZZ+KZ5HmNbsBoLU2J
 UYxYfujCfBJU1dRFX4+W8BG56hD2su24Xkz8juIj/yw49glQHmf4mXyobh0k3P0Q6+ex
 pnXnosz4CFb4DXAh0uuQAV8B4Ej1jfUANhQd+usei+zWqB9k0V1rkFY1nfsyxpNdGoQ8
 E5H3Bo4katcof66O/faYaMAIeOd1SbF1ZS9htlgIMkA6shU3mwsw0jj/MB0eyBj4eRjg
 s0Eeka2+j6EeKWo04rdjcLCgPZDyBQ700EaIUMBjNo+YBE1fQEyRHosqjWgP4wHuVeYO
 zueQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUmQ7Buog8p6qAQuENzvu6FmtA3PjZ0Vvbt8HS87wmUcveIeXxAPZ7K1JD4h60ND0LqTOfij8w3unpJ@nongnu.org
X-Gm-Message-State: AOJu0Yw7ioh0mHYM/5PhSDqMjFRP7fOFV+q6OBQcCidJDXrmKdK+R4ik
 qT1MEOs9lNgM0IQaYjzVk7eAqtPX5KD/r7i6b7KlWec8jObTpWLGillOAxp5LC8=
X-Gm-Gg: ASbGncsJU3XaVvTwfTBXnmpsY0oNIlhjUpsNaAhgcqKS3pJg9gLaYk3X7C/5/kpl/xm
 nqvbwiOFbn5WP2E1z378X9rbCiJEqcwuIiTVdQ1PY8NxaqIvBj8aHmyUcm2KDxuqF5Dyi5Po0Qf
 oNCVRVH4r/m7HKJge1fTT8FMBfpeWgy+cMX9Ry1acYVaYy5harzMjHTLzFugRDENwUgoo43PpYQ
 bnqeKVDwwsS6GlDPrrw3SHKR7DH1KrKnubeYtN7QH0avXkX7EULBa48QYlyNqOwePGVr3R0ViEk
 WeA=
X-Google-Smtp-Source: AGHT+IFdwGQohRirOqOtpE3DVxHuUzFQpGCdUYXQtZ5q4hhaGjBMBvXTCxJuvZ4UBi5kR4+mR9M6oQ==
X-Received: by 2002:a05:6a00:448e:b0:72d:a208:d34e with SMTP id
 d2e1a72fcca58-72dafb557c2mr9603046b3a.18.1737193845294; 
 Sat, 18 Jan 2025 01:50:45 -0800 (PST)
Received: from [10.4.77.245] ([118.103.63.140])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-72dab5e0dd0sm3387796b3a.0.2025.01.18.01.50.42
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 18 Jan 2025 01:50:44 -0800 (PST)
Message-ID: <6bd93213-8b6a-4f14-a209-f2c3dca1a6c5@daynix.com>
Date: Sat, 18 Jan 2025 18:50:41 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6/9] net/e1000e|igb: Fix interrupt throttling logic
To: Nicholas Piggin <npiggin@gmail.com>, qemu-devel@nongnu.org
Cc: Dmitry Fleytman <dmitry.fleytman@gmail.com>,
 Jason Wang <jasowang@redhat.com>,
 Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>,
 Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
References: <20250117170306.403075-1-npiggin@gmail.com>
 <20250117170306.403075-7-npiggin@gmail.com>
Content-Language: en-US
From: Akihiko Odaki <akihiko.odaki@daynix.com>
In-Reply-To: <20250117170306.403075-7-npiggin@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102c;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pj1-x102c.google.com
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
> Interrupt throttling is broken in several ways:
> - Timer expiry sends an interrupt even if there is no cause.
> - Timer expiry that results in an interrupt does not re-arm
>    the timer so an interrupt can appear immediately after the
>    timer expiry interrupt.
> - Interrupt auto-clear should not clear cause if an interrupt
>    is delayed by throttling.
> 
> Fix these by skipping the auto-clear logic if an interrupt is
> delayed, and when the throttle timer expires check the cause
> bits corresponding to the msix vector before sending an irq,
> and send it using the functions that run the throttling state
> machine and perform auto-clear.
> 
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> ---
>   hw/net/e1000e_core.c | 60 +++++++++++++++++++++++++++++++++++++++-----
>   hw/net/igb_core.c    | 28 +++++++++++++--------
>   2 files changed, 72 insertions(+), 16 deletions(-)
> 
> diff --git a/hw/net/e1000e_core.c b/hw/net/e1000e_core.c
> index e32955d244b..c5be20bcbbe 100644
> --- a/hw/net/e1000e_core.c
> +++ b/hw/net/e1000e_core.c
> @@ -168,16 +168,63 @@ e1000e_intrmgr_on_throttling_timer(void *opaque)
>       }
>   }
>   
> +/* Find causes from IVAR vectors and only interrupt if causes are set */

This comment is misplaced as find_msix_causes() is just to find causes 
and will not cause an interrupt by its own.

The function name is descriptive enough and the comment is a bit 
redundant so I suggest simply removing it.

> +static uint32_t find_msix_causes(E1000ECore *core, int vec)
 > +{> +    uint32_t causes = 0;
> +    uint32_t int_cfg;
> +
> +    int_cfg = E1000_IVAR_RXQ0(core->mac[IVAR]);
> +    if (E1000_IVAR_ENTRY_VALID(int_cfg) &&
> +        E1000_IVAR_ENTRY_VEC(int_cfg) == vec) {
> +        causes |= E1000_ICR_RXQ0;
> +    }
> +
> +    int_cfg = E1000_IVAR_RXQ1(core->mac[IVAR]);
> +    if (E1000_IVAR_ENTRY_VALID(int_cfg) &&
> +        E1000_IVAR_ENTRY_VEC(int_cfg) == vec) {
> +        causes |= E1000_ICR_RXQ1;
> +    }
> +
> +    int_cfg = E1000_IVAR_TXQ0(core->mac[IVAR]);
> +    if (E1000_IVAR_ENTRY_VALID(int_cfg) &&
> +        E1000_IVAR_ENTRY_VEC(int_cfg) == vec) {
> +        causes |= E1000_ICR_TXQ0;
> +    }
> +
> +    int_cfg = E1000_IVAR_TXQ1(core->mac[IVAR]);
> +    if (E1000_IVAR_ENTRY_VALID(int_cfg) &&
> +        E1000_IVAR_ENTRY_VEC(int_cfg) == vec) {
> +        causes |= E1000_ICR_TXQ1;
> +    }
> +
> +    int_cfg = E1000_IVAR_OTHER(core->mac[IVAR]);
> +    if (E1000_IVAR_ENTRY_VALID(int_cfg) &&
> +        E1000_IVAR_ENTRY_VEC(int_cfg) == vec) {
> +        causes |= E1000_ICR_OTHER;
> +    }
> +
> +    return causes;
> +}
> +
> +static void
> +e1000e_msix_notify(E1000ECore *core, uint32_t causes);
> +
>   static void
>   e1000e_intrmgr_on_msix_throttling_timer(void *opaque)
>   {
>       E1000IntrDelayTimer *timer = opaque;
> -    int idx = timer - &timer->core->eitr[0];
> +    E1000ECore *core = timer->core;
> +    int idx = timer - &core->eitr[0];
> +    uint32_t causes;
>   
>       timer->running = false;
>   
> -    trace_e1000e_irq_msix_notify_postponed_vec(idx);
> -    msix_notify(timer->core->owner, idx);
> +    causes = find_msix_causes(core, idx);
> +    if (core->mac[IMS] & core->mac[ICR] & causes) {

To raise only pending interrupts, I think you should do:
causes = core->mac[IMS] & core->mac[ICR] & find_msix_causes(core, idx);
if (causes) {

> +        trace_e1000e_irq_msix_notify_postponed_vec(idx);
> +        e1000e_msix_notify(core, causes);
> +    }
>   }
>   
>   static void
> @@ -1982,10 +2029,11 @@ e1000e_msix_notify_one(E1000ECore *core, uint32_t cause, uint32_t int_cfg)
>       if (E1000_IVAR_ENTRY_VALID(int_cfg)) {
>           uint32_t vec = E1000_IVAR_ENTRY_VEC(int_cfg);
>           if (vec < E1000E_MSIX_VEC_NUM) {
> -            if (!e1000e_eitr_should_postpone(core, vec)) {
> -                trace_e1000e_irq_msix_notify_vec(vec);
> -                msix_notify(core->owner, vec);
> +            if (e1000e_eitr_should_postpone(core, vec)) {
> +                return;
>               }
> +            trace_e1000e_irq_msix_notify_vec(vec);
> +            msix_notify(core->owner, vec);
>           } else {
>               trace_e1000e_wrn_msix_vec_wrong(cause, int_cfg);
>           }
> diff --git a/hw/net/igb_core.c b/hw/net/igb_core.c
> index cdebc917d2e..dad32be54fd 100644
> --- a/hw/net/igb_core.c
> +++ b/hw/net/igb_core.c
> @@ -168,16 +168,7 @@ igb_intmgr_timer_resume(IGBIntrDelayTimer *timer)
>   }
>   
>   static void
> -igb_intrmgr_on_msix_throttling_timer(void *opaque)
> -{
> -    IGBIntrDelayTimer *timer = opaque;
> -    int idx = timer - &timer->core->eitr[0];
> -
> -    timer->running = false;
> -
> -    trace_e1000e_irq_msix_notify_postponed_vec(idx);
> -    igb_msix_notify(timer->core, idx);
> -}
> +igb_intrmgr_on_msix_throttling_timer(void *opaque);
>   
>   static void
>   igb_intrmgr_initialize_all_timers(IGBCore *core, bool create)
> @@ -2279,6 +2270,23 @@ static void igb_send_msix(IGBCore *core, uint32_t causes)
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
> +    if ((causes & BIT(vector)) && !igb_eitr_should_postpone(core, vector)) {

Why does it check for igb_eitr_should_postpone() while 
e1000e_intrmgr_on_msix_throttling_timer() doesn't?

Please remove it unless it is necessary; it implies 
igb_eitr_should_postpone() can be true in this function and is 
potentially misleading.

> +        trace_e1000e_irq_msix_notify_postponed_vec(vector);
> +        igb_msix_notify(core, vector);
> +    }
> +}
> +
>   static inline void
>   igb_fix_icr_asserted(IGBCore *core)
>   {


