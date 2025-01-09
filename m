Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A324EE77197
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jan 2025 15:48:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tVulO-00054R-BP; Thu, 09 Jan 2025 10:48:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tVulL-00053I-7e
 for qemu-devel@nongnu.org; Thu, 09 Jan 2025 10:47:59 -0500
Received: from mail-pl1-x632.google.com ([2607:f8b0:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tVulJ-0001Xs-MS
 for qemu-devel@nongnu.org; Thu, 09 Jan 2025 10:47:58 -0500
Received: by mail-pl1-x632.google.com with SMTP id
 d9443c01a7336-215770613dbso13402455ad.2
 for <qemu-devel@nongnu.org>; Thu, 09 Jan 2025 07:47:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1736437676; x=1737042476; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=7kjNvJJQkbN5Q5AJuP+1Gj7V9kBG+81sEXOSaFwVI+0=;
 b=XgX4YQYV+xAR5n6gvZ/y+8MlWdc5HYZo4FwxLOWVlDNwJMaNz8XpwrK6ql4kbGEkSI
 Z5lVzmNFke7qxe6fFe1G/O21jv1eEehFZx1rSmOiZwkMDckilNc2ijF0mzVbIKP+NfKm
 j58AZ3+VbzcBiYbpnHTQtUQLRdUJf6Y6iAOADtKXKrMbiFvIhNCiNtxNw3Sdz7qVb5MA
 XOZwiPWv0QPqx+tDvuFj8PD2PtHWaDHclrq4zn5Ipnx+9op0zYX33i82hcjvYGgh1Lyu
 xC6hnMJe6emfgudGweXmi4PZ+BHKtpRXv8ssmy7epGdjmxwyxmfr5QmxjBvrdHE/lecB
 arCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736437676; x=1737042476;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=7kjNvJJQkbN5Q5AJuP+1Gj7V9kBG+81sEXOSaFwVI+0=;
 b=GDUEopUbf4rGe1dtKvDSwjvgD6+m6vxhGkfMIW5JD9+cPJz88nezgn5DQCWvoF+F3e
 PC2btnrZ6+MMFtNjCKPOka83+iAJHFf8NscalXMIgjLOm044JfhwCCh1iAqhr114Yswv
 +FPXrTrSt/SADVCdJmO8W2eNByYhfnqy521C5vxD+iedTFhQ/4J4hxzaXtAkT2ONjyfC
 m73/ke/G0zF1onK+YaTd2iokebnNGopQVUKJe4ulFW9238watm3ISd+v2ngpjLEpaFnE
 Kd3PvmlrAGFSGPF820qWgr1x5CRpGF+oRGRr+bKv+Nt9nWLoinBy1ODPj4s9UOxmLyVZ
 J53w==
X-Forwarded-Encrypted: i=1;
 AJvYcCXoBfLXzUyAQlXcnsEx9lzqb6WoQkXuc07KUX6bT17/FicTE3e/iFdT1p3RzuNs9YbAoR8rE/JnePzN@nongnu.org
X-Gm-Message-State: AOJu0YwF9xAuS/Dp9ZKILVvXNibiuC/iBUmfgnvKXb8AEItFMwSicCg+
 3mZGrygzVtvTFGPU/cXVsE+bIv/BVg3Gjd08kkBwEkTTBxHiHz1jh1XQz4pfe+w=
X-Gm-Gg: ASbGncvnwg5/7ArkKV0DFQUIEifTNVkqdwMMLDM+fcYTzNvEL4rLhTm2YmhaLWl70fe
 qRM935n/PwseCXbBaWcjWZSYI+6u52/z6krjRQJwc8rUVPcuBqsA4mBiRBRQ8/fnNRbYmXMIvoG
 m3ca/W8hmd61s+mmMiAnx8LRu234ixVfuVcI8wF7f+ZnWdSfOw2Jg8ecKS9evAlnAbkKmsPOfnZ
 NIteHN+Dt1WLXxVEucaNgp7dql6zyD/o76tLds4XeEOLXhNKj4msL5qKL1eU+zC7+/dlkZBgAGn
 LCJ7BJACBMsadVOGnlM3H7vP7oTFvF0=
X-Google-Smtp-Source: AGHT+IGMCh9YAtSksiMJmB5+lB8XNRO4Cwv4jA48xgb1ch32f4onhsd/CuR+Z2jIcu7HIqKM5b7brw==
X-Received: by 2002:a05:6a00:884:b0:725:8c0f:6fa3 with SMTP id
 d2e1a72fcca58-72d21feaa9emr11034433b3a.22.1736437676190; 
 Thu, 09 Jan 2025 07:47:56 -0800 (PST)
Received: from [192.168.132.227] (76-14-228-138.or.wavecable.com.
 [76.14.228.138]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-72aad8fd2fdsm37345449b3a.156.2025.01.09.07.47.54
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 09 Jan 2025 07:47:55 -0800 (PST)
Message-ID: <04d9fec4-3ac0-498b-a958-51aa41370690@linaro.org>
Date: Thu, 9 Jan 2025 07:47:52 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] target/cpus: Remove pointless re-assignment of
 CPUState::exception_index
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Stafford Horne <shorne@gmail.com>, Zhao Liu <zhao1.liu@intel.com>,
 qemu-ppc@nongnu.org, Yanan Wang <wangyanan55@huawei.com>,
 Eduardo Habkost <eduardo@habkost.net>, Song Gao <gaosong@loongson.cn>,
 Bernhard Beschow <shentey@gmail.com>, qemu-arm@nongnu.org,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>
References: <20241230153929.87137-1-philmd@linaro.org>
 <20241230153929.87137-3-philmd@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20241230153929.87137-3-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::632;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x632.google.com
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

On 12/30/24 07:39, Philippe Mathieu-Daudé wrote:
> TheCPUState::exception_index field is always re-initialized
> by the parent CPU ResetHold() handler in cpu_common_reset_hold(),
> no need to have targets manually initializing it.
> 
> Signed-off-by: Philippe Mathieu-Daudé<philmd@linaro.org>
> ---
>   target/hppa/cpu.c      | 1 -
>   target/loongarch/cpu.c | 1 -
>   target/openrisc/cpu.c  | 1 -
>   3 files changed, 3 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

