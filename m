Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67224C282EC
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Mar 2025 15:39:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tuCYa-00015w-9O; Mon, 17 Mar 2025 11:39:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tuCXz-0000w0-MQ
 for qemu-devel@nongnu.org; Mon, 17 Mar 2025 11:38:40 -0400
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tuCXy-0005tC-19
 for qemu-devel@nongnu.org; Mon, 17 Mar 2025 11:38:35 -0400
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-3995ff6b066so1009749f8f.3
 for <qemu-devel@nongnu.org>; Mon, 17 Mar 2025 08:38:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1742225911; x=1742830711; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=IdjOii3YNltXHh3kuXFKj2sjqR664q2yCvNio08+erM=;
 b=lXWe2g84Wd1s6J+XsTr8FO3UHk2CM3yU2bImnJ1xEfcTODhWy5TFweyLZWilWPyo7/
 CrH4uaKxsoLOXYb8PeFF4zlLyPqlKu/2LU4tdZm31dUtesJH/WgbNoKen7HrVvMJTV1d
 JyJAl0wd3ZihQ4EdSH7IO1SCfzTtOjxf4pqjnRol3UrnAxQnGzusEdbw3jlICcmZiYnz
 HHUfuHO8j2utVki12Azix/7aSlPv8V+W/5H5R2Os/v2eVmNfjN49+jmfTS/2oXjjA+i3
 j6zud6FnE7jFFCzPDWpxQatuwODfyf8uRLSVYDl5Jo6MNDFSCIHYhNhcS2ws1wrf46xQ
 kxKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742225911; x=1742830711;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=IdjOii3YNltXHh3kuXFKj2sjqR664q2yCvNio08+erM=;
 b=PVbikZfjyQRhyayEFzCJrSZonOEkLsquhzENUEGUIZBjZhpq0H+QsSYQ11pa+LcDf4
 ESYii+oTYhs013uMZc045oFpQ34wvxqyRcVyYKXYI+v4EfAKEtzjsKRHQj7eBZGLe2Uu
 BtxchVEmEWqM+qIRAIfw/6J0Sg3Omm/rLxle/EZbRmE8Wn/qadX7iFIsdhmANGYZwrPT
 pcLxkbNfpVSPaeFl5zmmDKBzqeOydJobjRZLBh4K/atIC2wltm+58YRNOOFgpTHcJvwB
 64piqQXMeY8ewm+lfTYeWQueT0YB+dzvuPs3OgejDvjicZxYrnXlSnWg9nf0TgO4q8S0
 0P0Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCVSBX2Tf0ZppzC9PmTSM2abLFOxkO6CXSuW6/IYCNjXJiIJ/vWgJlIqlVZObP/Ggm+xhOWNDoEciIHT@nongnu.org
X-Gm-Message-State: AOJu0YwCa/C5rj9AgUyrNTTgjTdqhIg2bUWf+Nx9awDF5XvIgAUDuVRQ
 EyZKW+oTM/9ct/4oBEbvVdDTPU+GmHIwbKuLwbpc4xoMIEKFIvFDB6EURzp+1SQ=
X-Gm-Gg: ASbGnctCfckKKk3T124+NThCGURlLHmW6WaLDDneXFkCS8x9AzKY4qKSV8ZGEJS1Bob
 /02cKchZEIYZQi+SRN2w2XL1zTXhqHNAstGy5Gd6jOwib5//YyolVM5n3zIoBYWMRG84mZA/YxK
 s591hFDZ6iHXYjyTkhAfRVzJPcJD9tQDyd3DFaRod2roGsfp0zoqMRNX3bpgjkOZ+RTFXaHcsaV
 O2TB4S2fnNFbXYVq1G7QLQEsg6HyhEycdVRxu669bJ7fIgLw7aINXwA/1FTqbwpSbBfVI9wW9DQ
 lAhIviGRMv/VoyU14FNQZhempOQSRvyHDgVdWFRGzLWRl1Mcw6pQbSumlliD+VwfUxFnbv2NfcA
 XqQc8Wa7f4A==
X-Google-Smtp-Source: AGHT+IHfF4OT9MciP568W6ic5HI371Ui7PjBTqfC5fZ8XbhcgyzTf5gpjNkrt5xeKBqdbKZaoYSxiw==
X-Received: by 2002:a05:6000:1a87:b0:390:f0ff:2c1c with SMTP id
 ffacd0b85a97d-3971e96b183mr10810405f8f.18.1742225911191; 
 Mon, 17 Mar 2025 08:38:31 -0700 (PDT)
Received: from [192.168.1.74] (88-187-86-199.subs.proxad.net. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-395cb7eb92csm15695543f8f.91.2025.03.17.08.38.30
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 17 Mar 2025 08:38:30 -0700 (PDT)
Message-ID: <1986222a-9913-434c-a87c-52561b167450@linaro.org>
Date: Mon, 17 Mar 2025 16:38:29 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH for-10.1 8/9] target/arm/kvm: don't check TYPE_AARCH64_CPU
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
References: <20250317142819.900029-1-peter.maydell@linaro.org>
 <20250317142819.900029-9-peter.maydell@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250317142819.900029-9-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42d;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42d.google.com
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

On 17/3/25 15:28, Peter Maydell wrote:
> We want to merge TYPE_AARCH64_CPU with TYPE_ARM_CPU, so enforcing in
> kvm_arch_init_vcpu() that the CPU class is a subclass of
> TYPE_AARCH64_CPU will no longer be possible.
> 
> It's safe to just remove this test, because any purely-AArch32 CPU
> will fail the "kvm_target isn't set" check, because we no longer
> support the old AArch32-host KVM setup and so CPUs like the Cortex-A7
> no longer set cpu->kvm_target. Only the 'host', 'max', and the
> odd special cases 'cortex-a53' and 'cortex-a57' set kvm_target.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>   target/arm/kvm.c | 3 +--
>   1 file changed, 1 insertion(+), 2 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


