Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3852C28B28
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Mar 2025 00:33:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tuhN5-0003Tu-Qh; Tue, 18 Mar 2025 20:33:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tuhMz-0003QV-CE
 for qemu-devel@nongnu.org; Tue, 18 Mar 2025 20:33:17 -0400
Received: from mail-pl1-x634.google.com ([2607:f8b0:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tuhMx-0003oE-OC
 for qemu-devel@nongnu.org; Tue, 18 Mar 2025 20:33:17 -0400
Received: by mail-pl1-x634.google.com with SMTP id
 d9443c01a7336-223594b3c6dso135421745ad.2
 for <qemu-devel@nongnu.org>; Tue, 18 Mar 2025 17:33:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1742344394; x=1742949194; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=b2WSyN/g/Hj6jDI+Wr70DeSWOToHEk/UnM4Mldgjidk=;
 b=ZCNeoy6XQmOnmmH2T1gAEAmGdH465FKHAfKw4nUci+E11XNYLgepAajCvn9o+vMtWe
 9NfuK+CWnImAe5mKdZnHtDFe5MVc8H/JHuNPrjZoFHjxsGNwiZfmA4yg9RvValhev/TH
 SBaAUPhTh/ZqxHio0DOwPVEVXkFXWoinarIYk1oQDF4Kz1njD7bqDLjxKR0DNh9EY2H3
 LNfg7l8WwVXTbyxnIZJETnQ/9BIa+7DR9IGLxAVeShS5101CYGfbmYd7oc6G6ZeWh3VW
 k0CprzLpGK1lP0JBJYjBoIHCq0jyLTwkcy9DYH3eWDj9i1WU1VG0lnvAc8Bxc0lcLNcX
 r40g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742344394; x=1742949194;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=b2WSyN/g/Hj6jDI+Wr70DeSWOToHEk/UnM4Mldgjidk=;
 b=pWqI8wExTd+jXbelSNC2+SZXz9sOhStPkcKvtOI2GdT1sX+iqROTIHq18SOE7tD2fa
 tQ7SMufXbjwizqTmZrcZHstEu/uOdHG30fHxLJa74pyzKo3LtI14mmjYb1LKPYLnfV45
 +nG6UtScnhh36JXnPJHtaeOmOrX5ia/vxsBv81KECb47B/Vw7pSiYNWu9hEOhTOOsPq4
 CuPXzcg0f/eKpmWBmKrzKlTzUY5+Y/JQg2eZgK177+zm2cW7VLyvxV/7qZ6XGQjZbjBb
 jreU6cX9A4htiSLPK0FHJnvTIsUTLYGqd7qGXvT28day5W89Ed7u/nO+Zcu3HVS4OcgA
 Uz9A==
X-Forwarded-Encrypted: i=1;
 AJvYcCU+HvmyiC+OqKkiaT6CT+dKvC0cnhrnw8+Sz9y8YN0mNiclenkRbGtInSdIM/IW1NK0NDLwJuZajeTI@nongnu.org
X-Gm-Message-State: AOJu0YziPrFxmKH+TRnWMl9akIdqxb3fWfd4MejQDKRHQo3wNPtUgC3+
 VrOLlH7+JCmMubyDMc4kft1wXZRq6m7SvJFLRTK/iM2aON0bpUDCvjIhWZ7mgmfz4WNB2bPdihi
 R
X-Gm-Gg: ASbGncthUn6B4FaFA8qF0SfFxDWqdrLhEnI1RQqc2x0h0v5WQqwvK5IOBj02OdXD+Gs
 8BOonCjoZYOY30XhdhMuiFcxPOW+k2G8fWE21aJvlikrRbAF179v+P63rpTPZXiWUo/MZjbufyY
 5L1s606ZrbBpIlgdbEzFY6HZATRZaSNxaPQWUI83aWTQbhx5J/BFelS0F7Bl87JSIL60KLlj4cj
 qZsS3Dat6XuZmeun8y2dK3N2U0t/zLpC54MFrnoy5hbnnwawzaCSzgGNJ09kjjZd3uWnbDp9tKc
 v3JVPxnnCCV/T2mQPuD96FlOxs3M1D0vY6ikchsH6zlxkd5edCl/Pd2y7w==
X-Google-Smtp-Source: AGHT+IHRB2ztF/cbObwJSYV9Bd2EfyBvMY6/cEm6Rxe6SID1rOZzNaGtx5lDn7ucV2IRVvxwK0s2Cw==
X-Received: by 2002:a05:6a20:9f4d:b0:1f3:2e85:c052 with SMTP id
 adf61e73a8af0-1fbed31614amr1291542637.35.1742344394073; 
 Tue, 18 Mar 2025 17:33:14 -0700 (PDT)
Received: from [192.168.1.67] ([38.39.164.180])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-af56e902eb6sm9795324a12.0.2025.03.18.17.33.13
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 18 Mar 2025 17:33:13 -0700 (PDT)
Message-ID: <61583c72-0c21-4a6d-9ce9-2ce944b1f0b0@linaro.org>
Date: Tue, 18 Mar 2025 17:33:13 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 35/42] include/hw/intc: Remove ifndef CONFIG_USER_ONLY
 from armv7m_nvic.h
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: philmd@linaro.org
References: <20250318213209.2579218-1-richard.henderson@linaro.org>
 <20250318213209.2579218-36-richard.henderson@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20250318213209.2579218-36-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::634;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x634.google.com
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

On 3/18/25 14:32, Richard Henderson wrote:
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

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>


