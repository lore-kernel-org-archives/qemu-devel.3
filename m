Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB654C83F03
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Jul 2025 22:45:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uXSf0-00047h-5F; Thu, 03 Jul 2025 18:44:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uXSey-00047T-SO
 for qemu-devel@nongnu.org; Thu, 03 Jul 2025 18:44:04 -0400
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uXSet-0007QZ-2Q
 for qemu-devel@nongnu.org; Thu, 03 Jul 2025 18:44:04 -0400
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-450cf0120cdso2443485e9.2
 for <qemu-devel@nongnu.org>; Thu, 03 Jul 2025 15:43:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751582636; x=1752187436; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=f60uyiGRDY1SfwtkXWgGdTFoQ6xZMMsmojGyhdi27ps=;
 b=Z0lVS8lAHpBzNB0MYUlRIhTxFggIPccLQCLOjdTMNYe8TrDe/VKzUdBW1DZem6TVCt
 wg0krWysixJyKyim3ZiARri6noalXCurIsSJfyXJ3KnFvszJnfM23g/UYR4UGzRg2vBJ
 6acuhKS+5jjZiD8OnZO3UHh3AWs7h15sjSUve+/yfnSiHYl782rFHhUgGu8kL49y2Dru
 A+hI48kCyNyBT4xB45nIEZc7W7HWKMooJRBqhux6eDcpDUkaVD50y+JB90u3hh4P6VO7
 wKqKC9q+BAWRn5F7KDHvX7DHhV0skVufNCfoAdFdTCC9Pt+CE9I5KG6ys84AIBm6MfOv
 B6tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751582636; x=1752187436;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=f60uyiGRDY1SfwtkXWgGdTFoQ6xZMMsmojGyhdi27ps=;
 b=hnGqEx/FLI49sDkOziz8FkrENcLy3EfyMTJk/5EAbBeO4TmYWNj/VyrOOrszVgxs3q
 MJqCt0h0NTNdzTOki2Dk8FEXFtwojkiNDox59ynL1PvFZNbZ87caHi6zhgAKAPCruSNV
 nRSlRK+ScMObmtLgrjU7XTs0Vls0K9TeqB2YOVLuDD+zOk3RanKS2UWjX5xuEJC3sLT0
 kyIyy0WLs/XMP2XBmVv+rg30nTY4O0AGm0zq1XqJdK+jXxSrfp37oxRp/JdaChmgBoUi
 mkg63EsxxvpXW7xHFnbtjQtGHxhYazmhp37PVDXfgL03gKStIDreqyGSWDRElnHgGmJf
 6OUg==
X-Gm-Message-State: AOJu0YxO/kwH0ivTt5UK8wfOaUpkDHjQ4Vy1lDDoYdrI3zfBe7kCHQBI
 XhUNOFcsOcefG8g6l2aktHqDAWpgbzH5FaqYxXSkHMJWH2WYKbJRWM+m4k9lYUbqI2MrI1xt/Uo
 pKFLMlF0=
X-Gm-Gg: ASbGncvCCBSLootgC/kZmQcs2STnZEs9Cvp+F+sArYMjmzRf8l/cYGenfPX79iYEzsE
 3eqA418sdBa8TDBOskTmnHFrljP2fMtUF5ZNJLhZoq1nsrMp+4C/JN7mpOQ5ADSCl+C03eMEg9D
 w0BvqWrv7UOlKgiwpJcG55ejpWWCZEZB3QkUVdYcivExbvxNni6Hu9Yw6OvcBWWeICemZJrDSNc
 jt3J/b5OfcAropBKREruxPiyEPSc9mHwL5YjUkV0SJbEvyC4Y5MRSq8TjJvp7+D0WIjNbxUsAgK
 wdivDNF4RBtCDTvQos4UOJvtZTDFmlHdphNY93WaIRjv/Jw7HrDMlTguLz1MIgiIVZu4hBKoyRb
 n1t7ZMwqJvj0yKsbGB1tbK0DPLM1w5g==
X-Google-Smtp-Source: AGHT+IFm401XH0luVmrjvkWihYw3z9UtEZt7PeENWcCecULAxixvvV6cPM+8nel4azNjuGWIdmV2fQ==
X-Received: by 2002:a05:6000:4a15:b0:3a6:da76:38b0 with SMTP id
 ffacd0b85a97d-3b4964ff64fmr120403f8f.25.1751582636389; 
 Thu, 03 Jul 2025 15:43:56 -0700 (PDT)
Received: from [192.168.69.218] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b47285c903sm837389f8f.90.2025.07.03.15.42.56
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 03 Jul 2025 15:43:55 -0700 (PDT)
Message-ID: <d006157a-d98f-4259-ba97-eb92ea0df044@linaro.org>
Date: Fri, 4 Jul 2025 00:42:55 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 39/39] MAINTAINERS: Add me as reviewer of overall
 accelerators section
To: qemu-devel@nongnu.org
Cc: Zhao Liu <zhao1.liu@intel.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
References: <20250703173248.44995-1-philmd@linaro.org>
 <20250703173248.44995-40-philmd@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250703173248.44995-40-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

On 3/7/25 19:32, Philippe Mathieu-Daudé wrote:
> I'd like to be informed of overall changes of accelerators.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   MAINTAINERS | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index e3e08d4607f..a8bf3f9ccfa 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -495,6 +495,7 @@ Guest CPU Cores (other accelerators)
>   Overall
>   M: Richard Henderson <richard.henderson@linaro.org>
>   R: Paolo Bonzini <pbonzini@redhat.com>
> +M: Philippe Mathieu-Daudé <philmd@linaro.org>

Bad copy/paste, I meant s/M/R/ :)

>   S: Maintained
>   F: include/exec/cpu*.h
>   F: include/exec/target_long.h


