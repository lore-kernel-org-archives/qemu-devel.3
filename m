Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2CE8C02185
	for <qemu-devel@archiver.kernel.org>; Sat, 18 Jan 2025 07:51:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tZ3bF-0000XB-4U; Sat, 18 Jan 2025 02:50:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1tZ3bD-0000TV-H7
 for qemu-devel@nongnu.org; Sat, 18 Jan 2025 02:50:31 -0500
Received: from mail-pl1-x62a.google.com ([2607:f8b0:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1tZ3bA-0006B5-T9
 for qemu-devel@nongnu.org; Sat, 18 Jan 2025 02:50:31 -0500
Received: by mail-pl1-x62a.google.com with SMTP id
 d9443c01a7336-216401de828so52044025ad.3
 for <qemu-devel@nongnu.org>; Fri, 17 Jan 2025 23:50:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1737186626; x=1737791426;
 darn=nongnu.org; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=V2GLSNYc6zJEIx3QeRPnxdnHPQ/jpWX6VYshOCDjmy8=;
 b=0Cu4knsJ7+Hy5Hv909rl5GPsQeLxaZffzhQ2dekcHD088mGsLXPwBSzTZhw9lY+aiL
 LPdiE3HA7kjSaZaAThs7pkmKqy+ZxsGnTfy3bl1O7P36EfOjoyE+xCXaK2Cp7Q4xAeQM
 npxv9LNpvXW/9GH1eEE7TBEdyb3u5w5mImfTHjIzf7bZ8hN7pSj+69pz+hGaOmhjKwpQ
 IoL/cBY8VdWXTmSC4g9bEJycpbyh+9NtaiFFGyHk6czM5M3x+8t3Zfc4EFHwd/qu5J3D
 wJi8tJpspGXXmxs7JLMRB4Mvq6W/azI0m8xEi4artdrjt3UHxRaDgvAN9GUNrSuUaCUE
 r7/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737186626; x=1737791426;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=V2GLSNYc6zJEIx3QeRPnxdnHPQ/jpWX6VYshOCDjmy8=;
 b=c6W99q2s2wxZZHjOZVQy/ZlewSzKL/hPwYywvC9ElqysXy7p9pS9GhaejxuJ8grA6w
 WlaPI9ZJvuT0bcyjAQlZMw5bOiyvfi1TvTF6+SQZqohr5FjlZU2HukREfyuaxCmtsQBR
 D17/y1xxZUJRasSbjuw+eXl/eQogSXah+x72jqKaUpt/TbN/AjYexwwnjVF2PA3UssKN
 TEaMpLb6mEdXW/34bRLE+Hpw3P39CyrLaKy6m+G42BDSIbcCmGYiulhPD0hUh6apAlKr
 mBe1XLFA1B+r6XBeLlL8WI8eyQW59WtJE3GL1DQSATJY21ejRY57NpwscWvUrEChcIQm
 vmIg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWoCVONu/kB52e7eufDhT+b0hMdSLHOgi791TIVNlcoDHS1prKlUWzoiJgIjD4T0mIDjpggrmclwGKR@nongnu.org
X-Gm-Message-State: AOJu0Yy14bAxXLq9gBXCtdrD2qTL4fqPXQnGDpnOSCTAPNczWjOV//W7
 t5f5X36nloDvFNUBqc8sHSD22Eqe4KbInUqxsf7oAw/TNriZu4v7wGYuJ2LUEbs=
X-Gm-Gg: ASbGncsOv5Pai6xwJlV9hg8FEuRMWsvawa5QcFawziuntLAS/+gsNYjsLH5IHSvX1+W
 sdJ4sW25amvRvaz/0hb5CfpxVf0BZK96tOsejSO30/GHgp7p/dl+ZQ7zchZ8MjUnISkHP2iN6W6
 Ihqae7qXIQ1lW2zseBB54EQcFx9iejVcxibgp467DKfmTySg2jRYNn3d596tGZAxXXnY+oj2OTM
 SpztHdms3fJ4JOefJXr3LSz3UeUBLXYrfRWo0Ih54zNHLTobndr7FAQE4OHtZ/Y0LGGgwhigRQo
 Ms0=
X-Google-Smtp-Source: AGHT+IFt6EQtlHd6vOeeTE7TT2cVclmokJXbmkMvYy+3PNblfgiJjA7zegU+LS09zsfmyhqlknFu8A==
X-Received: by 2002:a17:902:eccf:b0:215:7cde:7fa3 with SMTP id
 d9443c01a7336-21c355301e2mr76658835ad.25.1737186626191; 
 Fri, 17 Jan 2025 23:50:26 -0800 (PST)
Received: from [10.4.77.142] ([118.103.63.134])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-21c2d40275csm26884805ad.215.2025.01.17.23.50.23
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 17 Jan 2025 23:50:25 -0800 (PST)
Message-ID: <446f6d7c-d838-4ead-b967-5d6e52dbbb8a@daynix.com>
Date: Sat, 18 Jan 2025 16:50:22 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 8/9] net/e1000e: Fix xITR minimum value
To: Nicholas Piggin <npiggin@gmail.com>, qemu-devel@nongnu.org
Cc: Dmitry Fleytman <dmitry.fleytman@gmail.com>,
 Jason Wang <jasowang@redhat.com>,
 Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>,
 Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
References: <20250117170306.403075-1-npiggin@gmail.com>
 <20250117170306.403075-9-npiggin@gmail.com>
Content-Language: en-US
From: Akihiko Odaki <akihiko.odaki@daynix.com>
In-Reply-To: <20250117170306.403075-9-npiggin@gmail.com>
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
> The ITR minimum value may be a mis-reading or ambiguity in the spec.
> Section 10.2.4.2 says the maximum observable interrupt rate should never
> exceed 7813, but that is in context of example of the interval being
> programmed to 500. On the other hand 7.4.4 does say ITR rules permit
> no more than that rate.
> 
> There is no minimum value specified, and zero is explicitly allowed and
> disables throttling logic (which is already supported behaviour in the
> throttling code of the models). This seems to fall outside ITR rules, so
> should not cause any limit.
> 
> Spec 7.4.4 also says that EITR registers should be initialised to zero.
> 
> Remove the minimum value from the ITR and EITR registers, and set ITR
> default to 500.
> 
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>

Please squash this change into "[PATCH 2/9] net/e1000e: Permit disabling 
interrupt throttling".

> ---
>   hw/net/e1000e_core.c | 24 ++++++++++--------------
>   1 file changed, 10 insertions(+), 14 deletions(-)
> 
> diff --git a/hw/net/e1000e_core.c b/hw/net/e1000e_core.c
> index c5be20bcbbe..34bb5f8096b 100644
> --- a/hw/net/e1000e_core.c
> +++ b/hw/net/e1000e_core.c
> @@ -51,8 +51,13 @@
>   
>   #include "trace.h"
>   
> -/* No more then 7813 interrupts per second according to spec 10.2.4.2 */
> -#define E1000E_MIN_XITR     (500)
> +/*
> + * A suggested range for ITR is 651-5580, according to spec 10.2.4.2, but
> + * QEMU has traditionally set 500 here and spec 7.4.4 ITR rules says the
> + * max observable interrupts from the adapter should be 7813/s (corresponding
> + * to 500).
> + */
> +#define E1000E_DEFAULT_ITR (500)
>   
>   #define E1000E_MAX_TX_FRAGS (64)
>   
> @@ -2831,11 +2836,7 @@ e1000e_set_itr(E1000ECore *core, int index, uint32_t val)
>       trace_e1000e_irq_itr_set(val);
>   
>       core->itr_guest_value = interval;
> -    if (interval == 0) {
> -        core->mac[index] = 0;
> -    } else {
> -        core->mac[index] = MAX(interval, E1000E_MIN_XITR);
> -    }
> +    core->mac[index] = interval;
>   }
>   
>   static void
> @@ -2847,11 +2848,7 @@ e1000e_set_eitr(E1000ECore *core, int index, uint32_t val)
>       trace_e1000e_irq_eitr_set(eitr_num, val);
>   
>       core->eitr_guest_value[eitr_num] = interval;
> -    if (interval == 0) {
> -        core->mac[index] = 0;
> -    } else {
> -        core->mac[index] = MAX(interval, E1000E_MIN_XITR);
> -    }
> +    core->mac[index] = interval;
>   }
>   
>   static void
> @@ -3500,8 +3497,7 @@ static const uint32_t e1000e_mac_reg_init[] = {
>       [FACTPS]        = E1000_FACTPS_LAN0_ON | 0x20000000,
>       [SWSM]          = 1,
>       [RXCSUM]        = E1000_RXCSUM_IPOFLD | E1000_RXCSUM_TUOFLD,
> -    [ITR]           = E1000E_MIN_XITR,
> -    [EITR...EITR + E1000E_MSIX_VEC_NUM - 1] = E1000E_MIN_XITR,
> +    [ITR]           = E1000E_DEFAULT_ITR,
>   };
>   
>   static void e1000e_reset(E1000ECore *core, bool sw)


