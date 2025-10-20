Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ECA98CCD1A2
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Oct 2025 23:38:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vAzSG-00061j-9x; Mon, 20 Oct 2025 19:38:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vAzSD-0005zJ-S2
 for qemu-devel@nongnu.org; Mon, 20 Oct 2025 19:38:17 -0400
Received: from mail-pl1-x630.google.com ([2607:f8b0:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vAzSB-0001NC-RT
 for qemu-devel@nongnu.org; Mon, 20 Oct 2025 19:38:17 -0400
Received: by mail-pl1-x630.google.com with SMTP id
 d9443c01a7336-269af38418aso59490305ad.1
 for <qemu-devel@nongnu.org>; Mon, 20 Oct 2025 16:38:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761003494; x=1761608294; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=JbO8y8YIRGJ8NkjP3/YApQs91c0gk7hl5Ggg9pFvz5I=;
 b=mTdKEachiCdW8VgLaF3P3naGzCyb7os16tMdmuhbrbhrVZdhbxRiE/15iejVrqIrkV
 KaiYp2KPi+eB5EenOUVLyzs20u8z8GVZWSatUvfHV/shLMq0qcEmhUJMYM8UQFA8sLdE
 VCl77l2CQg0xCP30+AnTpVImKJTtf1wO0rklGz/pv0zjVHfMpMlSgfB/KrKvnRnA16Q4
 X6TWJJOQ+MJI48ZOkq3ex1PKQ5YN48VRZic6JAWR1G1xdiy17XfYX3G4R3939WwsCEKg
 3tvtbXHA3xJGaCJWu8fl/Puh+xnGIn1UmvH/YWOFIv2OVMvmHzrx+S/p6OQyeCYug8ap
 eZqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761003494; x=1761608294;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=JbO8y8YIRGJ8NkjP3/YApQs91c0gk7hl5Ggg9pFvz5I=;
 b=mTd8wTq1kMTp+zBZOFfXgM5A6TcIDNKV3KQMOrJXMY5DlO7by5NsbqNqy20J4IUCSH
 sP1dQRT19JvGz74Bmf7btUkBrVHNBtBgONZxEE43V/Gqd3XKuKPTZ1BwQCFpIfKE6yJa
 Ey4Z/k/2iIxBzSZdhR51weSGPLNH5dC0QcqOq8Z5ebG34zp+aDh2TqH/sksukgZVw+Ks
 BwGrh02D9sDqlK2bZv9YKQqZKKPJfrglQDnqjFT1OUeXMIuO2Pkn63SapHIimIqNTXaw
 FNMCM61HvNqa963d49BYnYq1bOCRXoLe4n2AEte3Lh/lxnejA2H40jL+lAb5y8dRbewM
 FjIg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXSVTRe2pSN2FDDerA6cbyXSyG2k3sOj8nBYdIczCHmhiBjPphM3fxJubxsDCTYQxHMnd2W4+15Fu7g@nongnu.org
X-Gm-Message-State: AOJu0YyEOGSIFsbWoei23lwyKOWZN3K3slhK2EGrTFaqWGTZdeOO4BT8
 VT2WktWtv4vV0xI3UUbhVNrIQRNFOWB6npiRBzlHkrAj2n4/E6OAGjrIEtHB8yXFHc4=
X-Gm-Gg: ASbGncstXBb9c2D0iQ37TaAhd0BnSYy5KLVY0c0RtDDC7mKsnKFcXyYBU+bt3HstrRj
 4HzLVdnLLG9ZuNqqZJl9sC9/yGltaPW/ANp9//dH7MgQHbRWCqEOFCB3pZt4R8TRH5dadet1Nn8
 XdDFikfYgny+mVHhtNMA8gxevg2idQIkZ+8w9whZBLdbrjxPnlBKI+iifQ15lQWJ+YvSxZf8ioY
 BVxJrHw1EP+cE/SOREY0MQaOaQ0KvH36EGOUT5TlzrWHwDs+QETp32kkPF0Ij4/7irG84prD3N8
 bBlD1MGTD958rs5A2mdipnjkJVKlqWFZF/ISUOXktj6Shqh7bhopEG6GgGODLmvhIHBsOY5mv/V
 /wbcZAAafzNUmwNqyQ3diLhx3bBtw/RmxR/pX55cn0287eG4Qy5mf77rYwUXgbTWJpfSIJ6kYXb
 6IE8CYgaBwcw4rqkAUooYF7LXs
X-Google-Smtp-Source: AGHT+IGA5anJWVQxatUVMxNg8eUgmko0qX6je3He3XUnFq1jXaB2lC5RDpwCS+8jZKvElFtF7yekSQ==
X-Received: by 2002:a17:903:287:b0:24b:4a9a:703a with SMTP id
 d9443c01a7336-290c9cbc0d7mr182893225ad.17.1761003493914; 
 Mon, 20 Oct 2025 16:38:13 -0700 (PDT)
Received: from [192.168.1.111] ([38.41.223.211])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-29246fcc2bcsm91521625ad.33.2025.10.20.16.38.13
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 20 Oct 2025 16:38:13 -0700 (PDT)
Message-ID: <29fd6a34-7cc9-4a57-b0d1-cf7de6b37ad3@linaro.org>
Date: Mon, 20 Oct 2025 16:38:12 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 24/30] hw/arm/sbsa-ref: Include missing 'cpu.h' header
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Anton Johansson <anjo@rev.ng>, qemu-arm@nongnu.org,
 Radoslaw Biernacki <rad@semihalf.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Leif Lindholm <leif.lindholm@oss.qualcomm.com>
References: <20251020220941.65269-1-philmd@linaro.org>
 <20251020221508.67413-9-philmd@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20251020221508.67413-9-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::630;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x630.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 2025-10-20 15:15, Philippe Mathieu-Daudé wrote:
> "cpu.h" is indirectly pulled in by another header. Include
> it explicitly in order to avoid when changing default CPPFLAGS path:
> 
>    hw/arm/sbsa-ref.c:162:25: error: use of undeclared identifier 'ARM_DEFAULT_CPUS_PER_CLUSTER'
>      162 |     uint8_t clustersz = ARM_DEFAULT_CPUS_PER_CLUSTER;
>          |                         ^
>    hw/arm/sbsa-ref.c:163:12: error: call to undeclared function 'arm_build_mp_affinity'
>      163 |     return arm_build_mp_affinity(idx, clustersz);
>          |            ^
>    hw/arm/sbsa-ref.c:746:25: error: use of undeclared identifier 'QEMU_PSCI_CONDUIT_DISABLED'
>      746 |     sms->psci_conduit = QEMU_PSCI_CONDUIT_DISABLED;
>          |                         ^
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   hw/arm/sbsa-ref.c | 1 +
>   1 file changed, 1 insertion(+)
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>


