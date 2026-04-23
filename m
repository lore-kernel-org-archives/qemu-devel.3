Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D260CFAD3E1
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Apr 2026 01:13:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wFich-0003mn-RE; Wed, 22 Apr 2026 21:12:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wFicg-0003mJ-1a
 for qemu-devel@nongnu.org; Wed, 22 Apr 2026 21:12:54 -0400
Received: from mail-qk1-x736.google.com ([2607:f8b0:4864:20::736])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wFice-0000th-Lz
 for qemu-devel@nongnu.org; Wed, 22 Apr 2026 21:12:53 -0400
Received: by mail-qk1-x736.google.com with SMTP id
 af79cd13be357-8ec9f099fc6so363354085a.0
 for <qemu-devel@nongnu.org>; Wed, 22 Apr 2026 18:12:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1776906771; x=1777511571; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=sO38SNSyIDMHo4kX1u9C8dYmluqXuU2dXsyThR8atow=;
 b=RuiXr5Lys16wzAxRwhqDUaNoKxduXHX9dce4+SCYV8gqyGDEgRWWBftOy4VUv6Zwdc
 3JWesp/XO9CWyU0/rv8a1Wo+YxvZ8+1sOPbbDesrjJXqislaeMdzpyPZKKWzu4ElDa2w
 eyaXEv0pGUtklRvyVlKnOHqetaGtlgbDArNm/GzPYsF639kcp7jxSp7Z6qIsv503UDCa
 +iRnD0bBg3VdPks+bhP3p6I/QUA2jsGJhGThTbt+b6UVeB/NYW6tRaT7F38HPBP06ajU
 tt0KGtej5ZOPtaB6AX2OolE0C5h8K+wWWQ5wLSGG5WPM3pH8OBEWzgXcuS8jn79vkkqY
 CndA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776906771; x=1777511571;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=sO38SNSyIDMHo4kX1u9C8dYmluqXuU2dXsyThR8atow=;
 b=K7BFYoB4OG4+LYnALARDqAEkv+UggPWaHmaFI0nL4DLPopT3j+PEJ3Eh0GH1/ypV8R
 lgdgaEkvSVroOcEw4sxNDjdiPbFJRF7UvEkZGqoi6TtkLo7++AN4N998IEbrheeOepQv
 DctYBArw8r2OE4nRyOT6bL3rgSoB+Wq00PiaTaNu0hmzUQHT533nSPqb0tvfcXNKYjTm
 5GDjRIjLhNkDMupcEP6BPSViVV5PBkxJe1P6OsoJUKunw/sThzedmAeFpeJFX/LPfBMf
 3LQlaX8SXHd9eBIMS8CxPZRV77BBWArgWR0aCq89tjlgoQfZs5M9Yzd8PzElGXRWmQS6
 6Wog==
X-Gm-Message-State: AOJu0YzRS5R9TbbVB0p36kzC0R7HP8iMxhykjCRktKLT1vSX9BNauOwK
 nxe0+44+Hg55SfsKA2wl+0FdkGxrNprYy29Cv4d6IuMG+SGbWvlFFQt01d21E1TpSzuMa2ayvO8
 PCZWS0k0=
X-Gm-Gg: AeBDieuDUgzEVG5cAYUgB+sDiFME94b9ulgSYH80gSdhmJwGDQn8Qpyiwbg1rhjwqze
 33Yz0GMCxlCIhaT8gN6y439bY/ckR3VDDXphmj9bNnlSlIxl+EO+mHDLaP8FOfHuZQSJjq4iB7i
 iCXjRMX1ric6mC3UyDUMnB7wLt6l10LF/Z66Vlg+2AjtxyW9doqny3vRWV7BKP5hE3rZWuUTVCJ
 h1TiyA/68kkfg1HSZvrY5PZ5zo98cs6m4oRLZxfKciLJA5WdIxfrawFj6N9kfBalDp5l8aegAeF
 3zmhDXihzV5LejU0EK7RkY0/td8D3q8TGug36iMdFWCuqkdiuIliOYlP37erniF3ejigST3G6IC
 Ephmzksb1h5jXYX/CcHIKBf0MhRUNf8N4rw5/IIJFDMtrEChtznZdQMJhCHTkkZyRBcnINhFscL
 DD0+xSvBJQdwU3uSQv8ZVzVi98Z/4mufyptZYtkV1iT5ayY5R4hjRm4nl/RCCO3In7IT4vg0p4u
 iz53XhgNgCdXj3/qWbw/AKX73aa
X-Received: by 2002:a05:620a:29c8:b0:8cd:8569:b957 with SMTP id
 af79cd13be357-8e79217c725mr3510224585a.43.1776906771452; 
 Wed, 22 Apr 2026 18:12:51 -0700 (PDT)
Received: from [10.72.56.227] ([172.59.184.224])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-8e7d5fe90a4sm1531564585a.9.2026.04.22.18.12.49
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 22 Apr 2026 18:12:51 -0700 (PDT)
Message-ID: <b957470b-60b2-4f0b-ab60-a184484a9ff0@linaro.org>
Date: Thu, 23 Apr 2026 11:12:43 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 03/14] meson, target/arm/mshv: Enable arm64 build & add
 initial MSHV support
To: qemu-devel@nongnu.org
References: <20260421-mshv_accel_arm64_supp-v3-0-469f544778ba@linux.microsoft.com>
 <20260421-mshv_accel_arm64_supp-v3-3-469f544778ba@linux.microsoft.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260421-mshv_accel_arm64_supp-v3-3-469f544778ba@linux.microsoft.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::736;
 envelope-from=richard.henderson@linaro.org; helo=mail-qk1-x736.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 4/21/26 15:21, Aastha Rawat wrote:
> @@ -855,8 +856,8 @@ if get_option('kvm').allowed() and host_os == 'linux'
>   endif
>   
>   if get_option('mshv').allowed() and host_os == 'linux'
> -  if get_option('mshv').enabled() and host_machine.cpu() != 'x86_64'
> -    error('mshv accelerator requires x64_64 host')
> +  if get_option('mshv').enabled() and not (host_machine.cpu() in [ 'x86_64', 'aarch64' ])
> +    error('The mshv accelerator requires an x86_64 or aarch64 host')
>     endif
>     accelerators += 'CONFIG_MSHV'
>   endif

This error should be handled by

if 'CONFIG_MSHV' not in accelerators and get_option('mshv').enabled()
   error('mshv not available on this platform')
endif

later in meson.build.


r~

