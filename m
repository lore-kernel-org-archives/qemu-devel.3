Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD3E5C02183
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jan 2025 18:00:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tYUA2-0000E2-11; Thu, 16 Jan 2025 13:00:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tYU9w-000098-3k
 for qemu-devel@nongnu.org; Thu, 16 Jan 2025 13:00:01 -0500
Received: from mail-pl1-x636.google.com ([2607:f8b0:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tYU9u-0006EU-Lz
 for qemu-devel@nongnu.org; Thu, 16 Jan 2025 12:59:59 -0500
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-21675fd60feso27582805ad.2
 for <qemu-devel@nongnu.org>; Thu, 16 Jan 2025 09:59:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1737050397; x=1737655197; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=/RbDN/0oADli28JG1O+4dKtdpx2vIR3RqtJSS8M1gKI=;
 b=DpvGyie8LTeMrTxEQqG/mLp3WVf4Sl/bkJi8VZXnBlrHof0iAO2p98qXAZY0+fk25A
 8KZ6OfNjM0ckOvD/dplaQyPgs0ND4bout2kYw6S3hLFN5f+3gRPMlyrOwJ3UKPFBGfKr
 xnrYFEEaaDLXZ+JhYPCSEOSsPo9U57pswk/h8jyTieDqCTyXl23enL0UhfgqY7JPRdQV
 05n81Xrq1SsSWiZoiogLMVvCBj5hznI+gh8rxDZPVI3rkvF6/bzYpEkgbJ/qvPMuR3Z8
 oOh5i25W/5nIyJGokFNAQOVANtkyHRVZjPHxuB7+DJ6F3vSleN0MoCoSe0FXY2DWIaa4
 YnwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737050397; x=1737655197;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=/RbDN/0oADli28JG1O+4dKtdpx2vIR3RqtJSS8M1gKI=;
 b=FB5AW+HuUkCBp0VuU4UVB8JmlOPESnPf/baPiGZBTc8uylUajCrNVZYYijBPx46eff
 YVi47bNUymuGOBd0P97g0K1QoMSH9U9EmmCvt6uLgObdxKreSpy4uWNMwk3FCK6BOrgl
 xl7LLr2fZUvjCOZpE2gs/XCGA0iHyB7PkE9/evt84bv0rHUVhZ4tcT90f7FF4OMJiia0
 LI9wgrF9928LDDxtjnNIKqel4IsHMOeHegt1Qgm0PupSIxpB/d3LGw7wY/tsezQdEGfX
 ia5ow0s1NhJIv1i5U9/Mg7PC4diitucGpN2qt1R8+DLzcxVohCAAkxOcm+RldAcdhLH5
 z92A==
X-Gm-Message-State: AOJu0YzfwVZKdqG3eSF3JhEphRaVrDfBlZB0gmFAA3v+d2P9Be2T/X5Y
 uYTprtxUo7/oryGeBWKyYtwhSNWSCgHoo29VSrhBU/gi1h2hi7wPhYBnVYBgRLchrTOVfsfyFR9
 7
X-Gm-Gg: ASbGnct9CtyTuwBQGTXTHA4cv65AiTZGK8iAWIHqCG2UAFtO7CkC6qu66wPE21o6Dwr
 YbjPWBQcKDVMHIp30TYk+JPsQEbZECBXSW1mfyWwg3wbHKKyP8OxP2B9x2/p2yve7w39WkeU7t+
 bjg+EoDYPJaRHDU0zfYWwe7v/tSGTJq7XpNv8z7haVisNrKE+M59tUS5OjluesgJMjo1rjHx8Q4
 QmQPzh/JyRTSBEqg295NTGSQsPHKFOsEV84MVT+SBKF8ju2fKy7S05B00gctfx6HSgflSvRP3GO
 XYanYYksmdkkj8hbMpXimG0=
X-Google-Smtp-Source: AGHT+IFLdxuvO1MplsG3h6l0Sb44V4r/8bbUnVinBOWaResqk/O/26N7KFUoghnsINdmIz5GtEU1Rg==
X-Received: by 2002:a17:903:41c4:b0:212:5786:7bb6 with SMTP id
 d9443c01a7336-21a83f469b8mr469733775ad.3.1737050396923; 
 Thu, 16 Jan 2025 09:59:56 -0800 (PST)
Received: from [192.168.0.4] (174-21-71-127.tukw.qwest.net. [174.21.71.127])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-21c2d3ac0bfsm2917545ad.134.2025.01.16.09.59.56
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 16 Jan 2025 09:59:56 -0800 (PST)
Message-ID: <08f1b301-e656-498a-b5ae-2c59fa35d394@linaro.org>
Date: Thu, 16 Jan 2025 09:59:55 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH-for-10.1 v2 09/13] hw/arm/virt: Remove deprecated
 virt-2.10 machine
To: qemu-devel@nongnu.org
References: <20250116145944.38028-1-philmd@linaro.org>
 <20250116145944.38028-10-philmd@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250116145944.38028-10-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::636;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x636.google.com
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
>   hw/arm/virt.c | 9 ---------
>   1 file changed, 9 deletions(-)
> 
> diff --git a/hw/arm/virt.c b/hw/arm/virt.c
> index 14fc4b100a3..54c7b92b6d9 100644
> --- a/hw/arm/virt.c
> +++ b/hw/arm/virt.c
> @@ -3551,12 +3551,3 @@ static void virt_machine_2_11_options(MachineClass *mc)
>       vmc->smbios_old_sys_ver = true;
>   }
>   DEFINE_VIRT_MACHINE(2, 11)
> -
> -static void virt_machine_2_10_options(MachineClass *mc)
> -{
> -    virt_machine_2_11_options(mc);
> -    compat_props_add(mc->compat_props, hw_compat_2_10, hw_compat_2_10_len);
> -    /* before 2.11 we never faulted accesses to bad addresses */
> -    mc->ignore_memory_transaction_failures = true;
> -}
> -DEFINE_VIRT_MACHINE(2, 10)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

