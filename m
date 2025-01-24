Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02A68C02181
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jan 2025 17:08:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tbN7v-0003Vo-BZ; Fri, 24 Jan 2025 12:05:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tbN7m-0003Tb-EA
 for qemu-devel@nongnu.org; Fri, 24 Jan 2025 12:05:49 -0500
Received: from mail-pl1-x634.google.com ([2607:f8b0:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tbN7k-0004fn-Ct
 for qemu-devel@nongnu.org; Fri, 24 Jan 2025 12:05:42 -0500
Received: by mail-pl1-x634.google.com with SMTP id
 d9443c01a7336-21619108a6bso40896175ad.3
 for <qemu-devel@nongnu.org>; Fri, 24 Jan 2025 09:05:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1737738338; x=1738343138; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Dd+aG1twDpqirL1tKMkyzk/bBXE6Ersc67qRFYrHKAg=;
 b=u4GEGrtuPKzKL0sfuZo2LCQc6OcwbTPVco2SVQ9cy/LlFopc79kJ8VbhetRGjJtYwD
 zKRXS6E08Y/9PPqiqRRBK3DdNNt/qKILH7K4im2SC9hj7aVFBAZn4ekw9w9of19i1c8P
 YnpL0FRqkEJYQqlDxcVwnnojnZH3uCJAoDSmMyOcsUusTGERnsePH88CgNWO3VZt/nWv
 0moYe9LH7LA9BmoE6xbO0sbkKwDLCvVnz17avikBbFaxgmj1p3Ao37PjqU/cziEjz9yc
 uopUFJ29jjfSaZ/JuUC+sDH1S/LePJiPy8fD+PoIOL1Yik+szZk7rPwmzuDK1rZZs+F8
 Mmgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737738338; x=1738343138;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Dd+aG1twDpqirL1tKMkyzk/bBXE6Ersc67qRFYrHKAg=;
 b=E3gvFsgFGoX6gh0zXOfzUHn2K5zM25yc7MKZQ49XVWFunDoRWNEyYWCtYomy3QPmU5
 7xzK8YmIwgB7HFzKXnAxcBBzsLIuCVAzZ7vIRyqBfUSqkbze32N3cISDlR4F9bG65xPY
 AwGdy7JuBd6raPUrAgUWpu4kZzQzjO6EolQ3AI0uPtbvmjjLChmbtpVRRFO1IHHfgeVe
 4qGP8jCTCAouaPxbDPTi3oBfm/xGKQmsZUTRbYLmxbWhxhBwOrI5qKJD1jduFneKA/m5
 UON3vvJqWyufdOGz88rpthWTcjuf3HjKyPEVy9jlzfHTITanZn0/QTkzZNLCRChH4EKf
 T6Ew==
X-Forwarded-Encrypted: i=1;
 AJvYcCUrgGTCmwMacyG3HPLLDEGDCc7K8JUrY0ReA6RAkyOb9115y23D6Vzk4BWPP30vFveuKkDqxDyXfkHB@nongnu.org
X-Gm-Message-State: AOJu0Yw/xMSy17MhMMBeFJp76PEybHBSeyriubsOLJ8FjbIWTN+y3glh
 ge6Ot2hCIvP4QRmWThs9MweAPmd6sWItRatglJ/b0MKckB+bR5uvJpPA/1n+ptM=
X-Gm-Gg: ASbGncuQLhG+qBS0hsC3czAAkf9HF0XMEii5B8dcw+ZbctE82HNoJRI4CPRzNc4X7OH
 MOBHXZpYtuSyeCS9rCzyNomaf6UCmVGFRDozCO4emtGeeSgjFUAaSTq4KCbjmPd3NGeSe/ze1bT
 WtBFeAjqhu9WJFYyk6/ayptUhVFjy10uRBhu4T23i0miYfDY+B1DC9en1JFzrxEfmDtPjeq7pKK
 pNiIst+kRFKry3+/A8unylfUHO5tm9EBKPjXnMRdmkqhxBibGMP7tvEYd1NB4ZUNBiAXW0Ve3Uk
 Ln72Di26MTEZS7gc/F7e18z9
X-Google-Smtp-Source: AGHT+IGYq5j97v7WYNZBhpdqRcsaOMjK6A+Hi0lgPGGLBdBM5ExDIDyYiKIvQ1cPeaCNZ5zia+7haQ==
X-Received: by 2002:a17:903:2381:b0:21a:8dec:e596 with SMTP id
 d9443c01a7336-21c355b54e7mr517678395ad.35.1737738337888; 
 Fri, 24 Jan 2025 09:05:37 -0800 (PST)
Received: from [192.168.163.227] ([75.147.178.105])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-21da424aee6sm18487735ad.215.2025.01.24.09.05.37
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 24 Jan 2025 09:05:37 -0800 (PST)
Message-ID: <44625264-685d-4e99-b837-56879e199af7@linaro.org>
Date: Fri, 24 Jan 2025 09:05:35 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 07/28] cpus: Introduce SysemuCPUOps::has_work() handler
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, qemu-s390x@nongnu.org, qemu-riscv@nongnu.org,
 qemu-ppc@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>
References: <20250121142341.17001-1-philmd@linaro.org>
 <20250121142341.17001-8-philmd@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250121142341.17001-8-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::634;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x634.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

On 1/21/25 06:23, Philippe Mathieu-Daudé wrote:
> SysemuCPUOps::has_work() is similar to CPUClass::has_work(),
> but only exposed on system emulation.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   include/hw/core/sysemu-cpu-ops.h | 4 ++++
>   hw/core/cpu-system.c             | 4 ++++
>   2 files changed, 8 insertions(+)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

