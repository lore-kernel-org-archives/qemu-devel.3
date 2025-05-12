Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2976CC3ABC3
	for <qemu-devel@archiver.kernel.org>; Mon, 12 May 2025 10:33:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uEQTR-0002Aw-TB; Mon, 12 May 2025 06:33:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uEQTN-0002Ac-5m
 for qemu-devel@nongnu.org; Mon, 12 May 2025 06:33:25 -0400
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uEQTD-0005uj-0F
 for qemu-devel@nongnu.org; Mon, 12 May 2025 06:33:16 -0400
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-3a0b9625662so3462663f8f.3
 for <qemu-devel@nongnu.org>; Mon, 12 May 2025 03:33:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1747045993; x=1747650793; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=QB5jZWj6PMkp8QsmsQmpVDwxWNyGaqvKbABIS0a1NP8=;
 b=Ph1m9H2CfnUYU6rebArjg9/jfiAmh5tWZRfPWBIyrVqQrHjYt4ghYPA1b8c3vHmlAC
 W8JuMoD38o1T4ODVIp7RLWbmljqPvAQfq/wF/kjzNTx32757zUG0+AUS9YrJHsnLl+ds
 td/hsLvLtMRZABhyiBFelzxnTIa6ZcYH4J+zgDBLi+CwOtioTJd1JFz9BEKszFUWA+5A
 2U9ABkby3i8hoyoXAMamMudMhCoNl5LYIqWjbPf8Peki/RR8YRDxo87OmLvAHEJ+q45Q
 5JXSy37eO72xfP7YfYod5WMhKmdFYNj6+0Ogk2LCJdHu5q+xPWxjtl1J8gCytaKtLuYQ
 7/sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747045993; x=1747650793;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=QB5jZWj6PMkp8QsmsQmpVDwxWNyGaqvKbABIS0a1NP8=;
 b=PpZk0bUo6yDGxoQPBI3h4338YetYiYgTdTyqpuK71+XPsoDTro2F9NI6jHt8UAhsaj
 67zjvFOihhG4hR2XVTtGPZLMqcxEMr02gSy+Pgeb3mAYpxotrjjB8/kKq+XDhuGI1cxN
 FQCz03ugg7hhUqjfPD/ZJUvzVQlob/oR3XjRZvoJIxHP96Lo0VIRj+6xRep4aFCZGGak
 D0lEO/u868mBOaQBlSUNPmnMjfe2bM6b+AVYJqCBQAm7Hfz2Dzqlv8bAKuMUAInu3CHo
 OEcn/H4AAqvMPZbZKbvReLdsFVMzZ6TZAXvZt2ExP37rkrAzrxlR+NVqLIaZwKqiYY35
 /T5Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCV4KCcorNLLAjLu+ccSkhfHWCHg86EnLja6VWGuzoigrhTbflILNPVJ8peVGfxuHJAiRENovAmWlxt4@nongnu.org
X-Gm-Message-State: AOJu0YxAr6arUAqgiD5gJ5nEyTy/zzfJ8/TyxXIfqoERzqVCgInlafT7
 oioHc763IwqB/JwNA7hDLKWt/2jtJ/iUjrs5gb2fpoF36Mgb8qW8kcJ28Mp5k4U=
X-Gm-Gg: ASbGncu5cYNgKrXCxUnSuedToL7vvsR8WOYY8beMVH+NcPfbRPWYLn38HFyH7WUj8In
 AN9dtxnMTQJ9bMVf7ipfPq/OyUvWpWhbAM1E6ceVOXESIFIjl0O+fZrhevDwNH6PCOyzveFvVGS
 +9E4kz5XPTRHZ05wKfiWnZNEHlCl+GVipKhvqkiEyMVVgQIkQSw05avHsnqEKeDn/GPSsTYOA3J
 OL7LW/x/QNPuF02FhFhl69WiJlJdPUU+A1K12Qi/bmjB33ehQ25iH/ImijtMoUJvME6Yx46FDuE
 NASMP8YmltII364Y4UiGtqiyP+VvorYljjEkeCEIuJiruirCGecNIWJRs6PyEdHjfSA0Ul3Vr6X
 j/6aJefsFgBAmZHy4n/jy3YtFD0VS2w==
X-Google-Smtp-Source: AGHT+IEVpPlEBC+TYqKsSjOBsFzfOFV7sEGeXCESGO+2LeyE2rThrDIL9DfRM/EmhRm1NWwjkYOx1g==
X-Received: by 2002:a05:6000:2511:b0:3a0:7fd4:2848 with SMTP id
 ffacd0b85a97d-3a1f64c0cb2mr11215845f8f.52.1747045992959; 
 Mon, 12 May 2025 03:33:12 -0700 (PDT)
Received: from [172.19.170.213] (74.160.185.81.rev.sfr.net. [81.185.160.74])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a1f57ddfd6sm11814242f8f.4.2025.05.12.03.33.11
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 12 May 2025 03:33:12 -0700 (PDT)
Message-ID: <3f774491-87eb-4a88-85b8-ab5e63eadb69@linaro.org>
Date: Mon, 12 May 2025 12:33:10 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 25/26] target/riscv: remove .instance_post_init
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: dbarboza@ventanamicro.com, alistair23@gmail.com,
 richard.henderson@linaro.org
References: <20250512095226.93621-1-pbonzini@redhat.com>
 <20250512095226.93621-26-pbonzini@redhat.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250512095226.93621-26-pbonzini@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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

Hi Paolo,

On 12/5/25 11:52, Paolo Bonzini wrote:
> Unlike other uses of .instance_post_init, accel_cpu_instance_init()
> *registers* properties, and therefore must be run before
> device_post_init() which sets them to their values from -global.

Does x86_cpu_post_initfn() suffer from the same problem?

> In order to move all registration of properties to .instance_init,
> call accel_cpu_instance_init() at the end of riscv_cpu_init().
> 
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>   target/riscv/cpu.c | 8 ++------
>   1 file changed, 2 insertions(+), 6 deletions(-)


