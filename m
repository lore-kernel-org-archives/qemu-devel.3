Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DEFC0C282DE
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Mar 2025 21:01:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tspfl-0004fz-0g; Thu, 13 Mar 2025 17:00:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tspfg-0004VX-9v
 for qemu-devel@nongnu.org; Thu, 13 Mar 2025 17:00:53 -0400
Received: from mail-pl1-x62e.google.com ([2607:f8b0:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tspfV-0006TR-Eu
 for qemu-devel@nongnu.org; Thu, 13 Mar 2025 17:00:49 -0400
Received: by mail-pl1-x62e.google.com with SMTP id
 d9443c01a7336-224100e9a5cso30970775ad.2
 for <qemu-devel@nongnu.org>; Thu, 13 Mar 2025 14:00:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741899638; x=1742504438; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=EiupZ/DqtNIC5Z9RHjPBm2AJYrGiXmR6qL3h7yQW/Zk=;
 b=uNSsZo21OTW994fihzBfIuF8bww6M+1FSzPl8cj8wbnudrPZW53Z0CmrzLTGQOGTCM
 tURowuzZ/nWYlT29maL2kPEf3yZ9x2idMgPCtOHS6oqqJL5UjTvOztNRpMOwAUZTLiml
 SGkbJ6eur2xJHfAcYCfS2FDWLI2Y/DSs7Fo9rseg4kb536v+dO4oeOzWT4wNtKG1TeED
 1iR+7lH1SO4ovnuhKD3iGozkW+pOOfGphX3d6l7zt/oxhIKp4tcjrxJTU3vZ5WUXj4dF
 F3AyohKeEVwaVUs6qoPUX/CkszcSfOc33axCp+xbkKdf5IsJQNHy23ny/4mhe9+CD8vu
 DGgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741899638; x=1742504438;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=EiupZ/DqtNIC5Z9RHjPBm2AJYrGiXmR6qL3h7yQW/Zk=;
 b=pffNPzKJYilVLeoClrPWq5cl9C5T8Kutw0P+ubQ3cvf0KCXzWaGaJ2uhuO2sB51FWA
 CnhqBin9dpaI/J4ALZBsrO6RY5N5hmGs+9S0+S93keIDzpfc1CeCWpIupHpbSjD0LtOs
 03n/nuq2bGkAyTXs6OLOOsJj1SsztJpBtuDqk3Rv7+mEBl+rCZdc4+qw6kXbUpWpWTdS
 1TBPRHAGBpbADNFkD94kTxJTReMeMapOP3Xnarn1vbV7XKLL+Tk4FMePAVWXXU//g5o7
 W8IaR4pbyh978sCOEB/tJIh02Yy7YSCg38iQZjvebEcD1f5DQHJyIeN+kxzdqvjvaQ03
 YtQA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWGDl5f6bW1nkfFXKYIALlwP+eEVVakiBridh1qWR9DD0ARboYIMOmHckeTa594DKKw8fgu9yYEXXMq@nongnu.org
X-Gm-Message-State: AOJu0Ywiev0hJ+vH2bc5UjsO2o996NwGjSA07laBknDjkmXSxSt1gMS1
 TIxL5KUAoObH7+JRED+fSv3SMe+RrQW8LJtO4G3XqtEDWBGkChRzWFbWbg4ixgrxBJ4iijjqjDC
 ieBo=
X-Gm-Gg: ASbGnctZO9IWe/F2tLiN6mKfgWzN0gg0PgyeolV31cos7fr1BFKkFHWzvP4B41U41Oq
 YT5g/T6VzlC1ebPXfV4ZcM91j+yJtupyPWafPZMuLq5gVj8x+zrmu/HKLwyHrffjf+7ZRIovwZU
 6zmpLyRkVZO0N111nBtMz6SYM0wx0PZCAXG6oL9mDUNRnHJP0EhoUWQPu7yiWpSTVn6NeQxsh7K
 2ndfM+Xl0qQw9Kh9lz9NJVkjjubhBVZBkK6zHuRS1gf1KD14Ki6DvuHxNR4U7MSWP2zjRH4OM3/
 Q6n5Un5c1WP7mzP7gMeyIXGxvV9oN1VB8VAFS6pwYU0wQp+KGTZQrOLV+A==
X-Google-Smtp-Source: AGHT+IHP85pcV/SA84T2m+WPKc+NC3fydaqahe0WeieJpinVrgeKLfA0CzHd0HSy2iW/PKaMnj7d7g==
X-Received: by 2002:a17:903:1b63:b0:224:c46:d162 with SMTP id
 d9443c01a7336-225e0a63de3mr837055ad.20.1741899637900; 
 Thu, 13 Mar 2025 14:00:37 -0700 (PDT)
Received: from [192.168.1.67] ([38.39.164.180])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-225c6bbe58asm17924095ad.179.2025.03.13.14.00.37
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 13 Mar 2025 14:00:37 -0700 (PDT)
Message-ID: <7f665a47-2bba-4c3a-980c-a252ec44723c@linaro.org>
Date: Thu, 13 Mar 2025 14:00:36 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 32/37] include/hw/intc: Remove ifndef CONFIG_USER_ONLY
 from armv7m_nvic.h
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, philmd@linaro.org
References: <20250313034524.3069690-1-richard.henderson@linaro.org>
 <20250313034524.3069690-33-richard.henderson@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20250313034524.3069690-33-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62e;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x62e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

On 3/12/25 20:45, Richard Henderson wrote:
> We were hiding a number of declarations from user-only,
> although it hurts nothing to allow them.  The inlines
> for user-only are unused.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   include/hw/intc/armv7m_nvic.h | 14 --------------
>   1 file changed, 14 deletions(-)
> 
> diff --git a/include/hw/intc/armv7m_nvic.h b/include/hw/intc/armv7m_nvic.h
> index 89fe8aedaa..7b9964fe7e 100644
> --- a/include/hw/intc/armv7m_nvic.h
> +++ b/include/hw/intc/armv7m_nvic.h
> @@ -189,21 +189,7 @@ int armv7m_nvic_raw_execution_priority(NVICState *s);
>    * @secure: the security state to test
>    * This corresponds to the pseudocode IsReqExecPriNeg().
>    */
> -#ifndef CONFIG_USER_ONLY
>   bool armv7m_nvic_neg_prio_requested(NVICState *s, bool secure);
> -#else
> -static inline bool armv7m_nvic_neg_prio_requested(NVICState *s, bool secure)
> -{
> -    return false;
> -}
> -#endif
> -#ifndef CONFIG_USER_ONLY
>   bool armv7m_nvic_can_take_pending_exception(NVICState *s);
> -#else
> -static inline bool armv7m_nvic_can_take_pending_exception(NVICState *s)
> -{
> -    return true;
> -}
> -#endif
>   
>   #endif

I'm a bit worried we might have regression when doing things this way.
Maybe we could have a runtime check:
config_user_mode()
config_system_mode()

And assert we are only in system.

