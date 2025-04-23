Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D283C369CB
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Apr 2025 09:23:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u7WJu-0003aK-G8; Wed, 23 Apr 2025 05:23:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u7WJs-0003Ze-BW
 for qemu-devel@nongnu.org; Wed, 23 Apr 2025 05:23:04 -0400
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u7WJq-0006P9-Jq
 for qemu-devel@nongnu.org; Wed, 23 Apr 2025 05:23:04 -0400
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-3913d129c1aso537360f8f.0
 for <qemu-devel@nongnu.org>; Wed, 23 Apr 2025 02:23:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745400181; x=1746004981; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=zV4KrXQ0bSuAprew4M/lzU92ZSlDJ8w0OUwPsjrNJD4=;
 b=OLrZylPbkcuAPslLTVjHK1Vn3OnKJBDh+d/TNmpSmMyASgTZwZ6mDiTWWKXYD/igpo
 oG4pVGMaPN13R+NsE2TNDEdWy1KqQz6Tim4eRyxVKRkNCY6nmqG4WfwKaR4s9z1nxV82
 8gRsbY9/NxMiW6W4pljdoySvlWryVLYKXvnsKYc81dbZ82uZP2uzFTXreoc5oBvJodif
 OXxT3Tw/wSObgCV0nIjUQtVUAC42O1JkgHpcCfbsz1vvE1JCDX4NVw0+KU0sD0KwldEQ
 uwm9m9iUv/o9JBXGK9HFQMrppFp6uZ7b4CIEogJvb1k4Ybqq3T0+NjcMWC2sNsPDjJ3C
 mEsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745400181; x=1746004981;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=zV4KrXQ0bSuAprew4M/lzU92ZSlDJ8w0OUwPsjrNJD4=;
 b=aRN0xeNx44ktyMqp85Ge2SW2phi2Hzjz2wEN4KGm1sU3AP/QJwLQsnicqb59buYkew
 hslHO+9dOrzpIs70/jh8LijyU3UoWuusVYSCwdl6ONZEFJBBxBuD8PE2IJJlGbmsw6MM
 zTHGPWlEVlfA+CeVyYeQfzeO10q5dCSJwtnUZTLtL+ZqxKtGBq/vsgmi1tMyQGqAXlqv
 KfrmjWx2qRZf6eob0qLzt5dvFUtZ2htGvhEH4sULeKIs/V2YOLKK7nfnmnpXQeMEMIZd
 D1ThvjqI5JUC08CVsrUC8v/Hqn9cwzwvT5GLzMNNwu5mK0lLtqP2Ml47AGHcPFzJ89VM
 hJRA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWkIY+ZFC0lvg7K7v+hZXmA0jT9NXquC5rq1ES/wUOsUNNL7+SciFjgNnwhvBplonxk8dkFr58Jfi2X@nongnu.org
X-Gm-Message-State: AOJu0YyCh4b92A4DaJrTUHzTDSVcF4ZDM+wRS4bP7xx7IgwN+LG70eJP
 Xg0tAdhKGco1p8zRX6fjz5DzAAAT9XnjF0+0NDHSOKrcZ/O7zhHTL3XQurfquZY=
X-Gm-Gg: ASbGncv+4ebBjjlquH2Cg+aBw9nWOHlLHGnOQzPBrItFNq0kbo3E3n3Hp63X7XKJs9Q
 aWC1zVUtb8q3lNqgZCTqh6Zj24vJED4TSFXzxwYg41rlprtLbuOH9poJc5W3CtMhSUIY6l05X8a
 aE1mFjtvfV238WI5aBlOGnQq5egwm4VuAstTsjMrccUYj6JzoFw0NtgBhzIwuzjgyCPL6IXOpi2
 3RpB4P9sbMsTuY6UCOXqa4dU94FgX6mnvjI14KQF50T2j9RSrglbJE4xWxE8rKZ5m3SIrO3YlGm
 8IlD3ID27SID1K5+VKThywPTesNcA4KsPWByl767airnz2m8Ltv1NX03RETr24unbIKlgt9ajWQ
 W/f3p8jRv
X-Google-Smtp-Source: AGHT+IFoQMIOHVv7zxIpdi8v+esbCpR6K4jmhnm9FgLgJSNHrLIQX5YcRgWBbgUz9smZ+l0dyUTTWw==
X-Received: by 2002:a05:6000:420f:b0:39c:30f7:a599 with SMTP id
 ffacd0b85a97d-3a067285addmr1547425f8f.18.1745400180090; 
 Wed, 23 Apr 2025 02:23:00 -0700 (PDT)
Received: from [192.168.69.169] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-44092d37332sm19101625e9.30.2025.04.23.02.22.59
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 23 Apr 2025 02:22:59 -0700 (PDT)
Message-ID: <dfcf9c43-4585-46e0-8d7c-0855d348c38a@linaro.org>
Date: Wed, 23 Apr 2025 11:22:58 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 013/147] system/xen: remove inline stubs
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>
References: <20250422192819.302784-1-richard.henderson@linaro.org>
 <20250422192819.302784-14-richard.henderson@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250422192819.302784-14-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42b;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42b.google.com
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

Hi Pierrick,

On 22/4/25 21:26, Richard Henderson wrote:
> From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
> 
> Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> Message-ID: <20250317183417.285700-14-pierrick.bouvier@linaro.org>
> ---
>   include/system/xen-mapcache.h | 41 -----------------------------------
>   include/system/xen.h          | 21 +++---------------
>   2 files changed, 3 insertions(+), 59 deletions(-)


> diff --git a/include/system/xen.h b/include/system/xen.h
> index 990c19a8ef..5f41915732 100644
> --- a/include/system/xen.h
> +++ b/include/system/xen.h
> @@ -25,30 +25,15 @@
>   #endif /* COMPILING_PER_TARGET */
>   
>   #ifdef CONFIG_XEN_IS_POSSIBLE
> -
>   extern bool xen_allowed;
> -
>   #define xen_enabled()           (xen_allowed)
> +#else /* !CONFIG_XEN_IS_POSSIBLE */
> +#define xen_enabled() 0
> +#endif /* CONFIG_XEN_IS_POSSIBLE */

Just to be sure, you said we should remove CONFIG_XEN_IS_POSSIBLE?

