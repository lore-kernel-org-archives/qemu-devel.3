Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F01DC83030
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Jul 2025 03:28:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uXX5m-0005jZ-Fw; Thu, 03 Jul 2025 23:28:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uXX5e-0005gI-SU
 for qemu-devel@nongnu.org; Thu, 03 Jul 2025 23:27:54 -0400
Received: from mail-oo1-xc31.google.com ([2607:f8b0:4864:20::c31])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uXX5R-0004gR-2w
 for qemu-devel@nongnu.org; Thu, 03 Jul 2025 23:27:53 -0400
Received: by mail-oo1-xc31.google.com with SMTP id
 006d021491bc7-60d666804ebso955774eaf.1
 for <qemu-devel@nongnu.org>; Thu, 03 Jul 2025 20:23:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751599420; x=1752204220; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Nh3jJ8bDFB5ahixra5Mg10UMCf525DQw21oT2/4YTE0=;
 b=vgEfgN7+m1vLkrDroND095p3PD9GvYQxzD1eSzKNwgor48w3M7Dts2vLt16eUc0m/d
 axfzoXruz7dt1KAGBgmLPIRPsjz6rH5751OI3OqlrkoFh1XQ3ZM3I0d4k7uE6VnPBNsm
 DP91VMNPU1H/3uLeLwTNpL3h8G59RHBzRQrD+ntWr2cxOxuyW1P4XPUbYn2xGqqK1zoI
 n064zGcPx9TBGC7DCsDmfM+nuAJAubvsJT+c6Ee/hM864zQRN33iggR2Xq/KN1ruFVjU
 J6UDagO5WrjlOzTQTxHw5RHbGd2OGb9Xk+cQAmiboAbHOC7uPMmoG9Z/wuZ0mQVX+HlH
 rVlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751599420; x=1752204220;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Nh3jJ8bDFB5ahixra5Mg10UMCf525DQw21oT2/4YTE0=;
 b=LTGRJOoN+v+5PH0d3b9dqrWPGckuRSuhqusnfqOKK34DI08xsT3+k2KJklFEoh042n
 1iBovLWQ/h7t7QI3cwb/9zhZrk6pJg1JzoDb9aBYelFrZHZ2dVzmX5Y7v40BIioVT+Wg
 +TNgYjjhiqkuhocQWtEgeTcYYZdu2UjqTyILUDnWMl60UfNS92DT3YAeIE5QVZzFGXCK
 Ua/zCZ1vZqfThIsveWJ1DUCS/mVPk4OCHIUCi74ULL3CgBW4X/GIu+6siinVi5lsMlp0
 yklfRufFuOgoYH01Yj2Af6unNkps92XwGYvPOqXzKh74DpEdBtbiXd3Op1Ystf/efVi1
 Tagg==
X-Forwarded-Encrypted: i=1;
 AJvYcCU1CvhC7pn/yGsICtO0vVwM28sj2YtSkrmDNulO+OqN2Q1evMpwM1fEz3ZF0qZ6XQgLKQY/QZji1VTI@nongnu.org
X-Gm-Message-State: AOJu0YzHQKMr/V2GjbaY4Y/ODJOKqbj3XEPami0bJgK4OJxyl5F0UBrA
 DErAi5vu3V0eq4xatETjvbI4wQhb6wU5DeoCxa9NIC696H+0uhBG24e5wm0PdESVXhE=
X-Gm-Gg: ASbGncsmrl2UJW8rDs3KgifjQwaeciWmkm0oGIXK4chkflwH3Cd0cGHUUfnHX3Z4qf6
 TuqlTXIKur0hx0ZFbfwCfjY0tiZKKImjDMYERq24ICXT9nTc/ekeXR3AIGjbtrjCw9RAjFFEswB
 pKXvaYmGpF95GjO7hYADuW+MfswLG+eHRy1chU63X+2/T2kulcrEqjQVAk33BLeCDFUOywohIXo
 SwKUXA2oTrDWEIrxcXRgzYAIc060ERVeLKqA5CFci9xxdVqN1l+6i+IVEMgklcuW86ObEn3rhVN
 C/PnXNjWAkeX7YsgtEMfhVjuCFU154tbgfsAAYIXngiS4urQASYhy6q+EGaoXGZvNCh063CYTEs
 edXa4LOHllzyjT1gddd3OYJy9zn8LSSHuMlqvjqSB
X-Google-Smtp-Source: AGHT+IFhE8+SwkEa8me6+KEWOxR3eG8enNDQGCD/ak1MegXpyi9GSX0ewei/IJYN+ZtPhf5c+Kqv7g==
X-Received: by 2002:a05:6870:6590:b0:2d4:c1f4:4309 with SMTP id
 586e51a60fabf-2f7919c0f16mr1082131fac.0.1751599419878; 
 Thu, 03 Jul 2025 20:23:39 -0700 (PDT)
Received: from [192.168.4.112] (fixed-187-189-51-143.totalplay.net.
 [187.189.51.143]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-73c9f735144sm245401a34.14.2025.07.03.20.23.38
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 03 Jul 2025 20:23:39 -0700 (PDT)
Message-ID: <afc71f1a-cb76-449e-9961-7e77d43ab839@linaro.org>
Date: Thu, 3 Jul 2025 21:23:37 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 39/39] MAINTAINERS: Add me as reviewer of overall
 accelerators section
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Zhao Liu <zhao1.liu@intel.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
References: <20250703173248.44995-1-philmd@linaro.org>
 <20250703173248.44995-40-philmd@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250703173248.44995-40-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::c31;
 envelope-from=richard.henderson@linaro.org; helo=mail-oo1-xc31.google.com
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

On 7/3/25 11:32, Philippe Mathieu-Daudé wrote:
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
>   S: Maintained
>   F: include/exec/cpu*.h
>   F: include/exec/target_long.h

With R:,

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

