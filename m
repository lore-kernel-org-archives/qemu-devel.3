Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8148BC02183
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jan 2025 18:04:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tYUDC-000265-Kt; Thu, 16 Jan 2025 13:03:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tYUD9-000236-CT
 for qemu-devel@nongnu.org; Thu, 16 Jan 2025 13:03:19 -0500
Received: from mail-pl1-x62f.google.com ([2607:f8b0:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tYUD7-0006sP-Rd
 for qemu-devel@nongnu.org; Thu, 16 Jan 2025 13:03:19 -0500
Received: by mail-pl1-x62f.google.com with SMTP id
 d9443c01a7336-216634dd574so14986405ad.2
 for <qemu-devel@nongnu.org>; Thu, 16 Jan 2025 10:03:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1737050595; x=1737655395; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=oyu2DOKDwTvMSfn+WRUM8tRebM6QLAz21qIQV4cHgio=;
 b=PVyxyCvGm+A3u6Tar8y+BcZ7ZgpHklBVG7mX6ayf/IP1ReZact1+whdZfRpW81646p
 y9ffeSg4PzO/bSRa9zq0VeUH4fE/A6z5ipcsvb/yRf2FKOQr+rSfcFDw07c/mLux2OpS
 pyAfxfzEqcX4NkjEFatmmFyphZqxhChwC6QAS5sV3h5TVkVRBG9Voc+97n/rdbX54JTN
 dqMbkFM8DFfiYrd1qCCM4XQAiKYhyArD87GOBdXPiXjcHsZPrBQVXMaxytJUOz5jbmOP
 QBbjAn638jN4ZtxbA3GfIjGFrqX/4msW0YX41PgxW+DpQwhr27r/UBbQxmzRfYsCmnYD
 v/ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737050595; x=1737655395;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=oyu2DOKDwTvMSfn+WRUM8tRebM6QLAz21qIQV4cHgio=;
 b=kh75tatoUhyahp3n/+6SPRYqqfg710P6qzHgCiEvoPmzJa4F5POfGOQquIABpoaVNy
 xvHxumuogFfdywwJewtggySTAUToD2eL84gHC0vNdbaQpa2f2zt9d54MpDAF/9OIqoAF
 jBq69fvfF1a/UIl6LaDJEsLu3LwNyiaavpy5Dsqu/sK1de4/EMcHdHJzIgdm0VER+y4B
 qcJfiI22eT5Mz59xM+D18U0V7s1kHabgszmi++5Cgs++UfU+WElMNvKsPgbbVIJ/MT9m
 gycubBJi0PhhJUfFBCX8YH+jQ29v7BC68L0OH0NbhWzIa2TuyPW9cjr+rrrd0zGTSAYd
 drAA==
X-Gm-Message-State: AOJu0YzdlsEJDGJOnCrs6GjjZs387dV6kabrb3VFn0vJbPTrF82pZSOz
 bo4nSYwqqe9t7JnAd5AlDhKx9iihmdF6YqQUwdoZdah77XzjJJ6+7tIVCPVskQRI7XEE8YwrZAL
 +
X-Gm-Gg: ASbGncvcVMxyjelMQ3043l6mlfecxC2OqW7tRZEQdmb64xiMBEjQLf7hxBfxklt0nXT
 coN+jBl2ZVJ9I4GPJzll3KCMfA+eQvoKFD5sfkcIi7p3k88qCYiBGtVPm8j9z4blSMQqh++xZm5
 J/1Vf6KB+Qg4BgJnn0Nww8Jf5S30PbueYpJSRU9iaLJFJPRWkwONWQqVlmI1sDXYabSPLEy1VYV
 h4OHfdSvgLcUTBFmjdE6UYRx7sJCRlzWXp913jnQn251gwM7BxwooViEeCNjLqXQLLSL/cZdGvf
 XE1F2QU6FTK4BGQp5IGcsZs=
X-Google-Smtp-Source: AGHT+IFEAegg/ZviR8Wbpx9RSYTsXJXiy/wHVfK5kScqRVw4IHCbNKL6pMgwmxRynCtpuiS3l3jm6w==
X-Received: by 2002:a17:903:2b03:b0:216:2f7f:ff69 with SMTP id
 d9443c01a7336-21a83f36d33mr567333205ad.5.1737050594691; 
 Thu, 16 Jan 2025 10:03:14 -0800 (PST)
Received: from [192.168.0.4] (174-21-71-127.tukw.qwest.net. [174.21.71.127])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-21c2cebaebcsm3103935ad.99.2025.01.16.10.03.14
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 16 Jan 2025 10:03:14 -0800 (PST)
Message-ID: <098e395b-716c-432e-adcc-4878b8c14638@linaro.org>
Date: Thu, 16 Jan 2025 10:03:12 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH-for-10.1 v2 10/13] hw/arm/virt: Remove deprecated
 virt-2.11 machine
To: qemu-devel@nongnu.org
References: <20250116145944.38028-1-philmd@linaro.org>
 <20250116145944.38028-11-philmd@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250116145944.38028-11-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62f;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62f.google.com
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

On 1/16/25 06:59, Philippe Mathieu-Daudé wrote:
> This machine has been supported for a period of more than 6 years.
> According to our versioned machine support policy (see commit
> ce80c4fa6ff "docs: document special exception for machine type
> deprecation & removal") it can now be removed.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   hw/arm/virt.c | 10 ----------
>   1 file changed, 10 deletions(-)
> 
> diff --git a/hw/arm/virt.c b/hw/arm/virt.c
> index 54c7b92b6d9..582a5aa077b 100644
> --- a/hw/arm/virt.c
> +++ b/hw/arm/virt.c
> @@ -3541,13 +3541,3 @@ static void virt_machine_2_12_options(MachineClass *mc)
>       mc->max_cpus = 255;
>   }
>   DEFINE_VIRT_MACHINE(2, 12)
> -
> -static void virt_machine_2_11_options(MachineClass *mc)
> -{
> -    VirtMachineClass *vmc = VIRT_MACHINE_CLASS(OBJECT_CLASS(mc));
> -
> -    virt_machine_2_12_options(mc);
> -    compat_props_add(mc->compat_props, hw_compat_2_11, hw_compat_2_11_len);
> -    vmc->smbios_old_sys_ver = true;
> -}
> -DEFINE_VIRT_MACHINE(2, 11)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

