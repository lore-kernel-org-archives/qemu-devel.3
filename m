Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A9B3C02187
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jan 2025 18:04:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tYUDr-0002LR-P9; Thu, 16 Jan 2025 13:04:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tYUDY-0002Cm-Ku
 for qemu-devel@nongnu.org; Thu, 16 Jan 2025 13:03:53 -0500
Received: from mail-pl1-x62e.google.com ([2607:f8b0:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tYUDX-0006wS-1F
 for qemu-devel@nongnu.org; Thu, 16 Jan 2025 13:03:44 -0500
Received: by mail-pl1-x62e.google.com with SMTP id
 d9443c01a7336-2166f1e589cso29506155ad.3
 for <qemu-devel@nongnu.org>; Thu, 16 Jan 2025 10:03:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1737050620; x=1737655420; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=kCLOo0f11r+JkZR0LjLGbkqmpV4siVjEzKF7KZgaS84=;
 b=snM5X8YphSH6X+qHz9KUd58qNZaJ6/jHCAvoa2vgGPi/HPQruPYgPHdpjmgyQ7o6C/
 W5yikDcBLZQVz7bGULvWNstOYtVrZrCtPQbi3DSTc/vZF0HpToK4y8t0GJPw4XKnSQTw
 hswzsVCGX7ggoRvfbdZzwQ/ZMo/uSsry/++X44o7JnkxtfR8Z9nstU3dfjMrjDxxhiiK
 b/eXY7xgx9fMAYboju5BId1bf+Xiy2uDVF7LtQZonfhlcX2iGaTOoCF8o7kiXkKDHjKC
 J1sFwihlBSKbDsyhLskaJxun3ZciOLB3BeclTS4QFgY3M6ilb+Fffb0XnjoOrYO3Rpix
 shfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737050620; x=1737655420;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=kCLOo0f11r+JkZR0LjLGbkqmpV4siVjEzKF7KZgaS84=;
 b=f5jBBUMaW3X1bda0ur8uwBN7ourZTHt+5wEVQg3XoBRa7YX6BEMcuxWhDLhegbEMfD
 MrR0iZKJE3dVJVsp2v/U5TMITDUe2uFfajB+Pcamq1JiAezT1BYtEBwNCkJxfXx3GBvA
 3js6d9YqIvq48V8IjklGuljBbT56olnUf8cMzKe/bAQsM3UuVoeBBa1h/fuGVpIQGxqm
 1S+rFyD7wgND1oleBhsTdkcZI7xX0AxjRFrKv8794qJNv0HSUUg1WjFuxnMgZIivb7DK
 i1Dx0IQSFsYK+bpuRraR4WHdHSgqTtWBVVLXgVqewG18yRpPnAveNTXzg2TsGvvvjvsw
 AJVg==
X-Gm-Message-State: AOJu0YzmyseIH4LLiLPRbJBVgma+jJ+CBN9RCCNajE0OagCp/2sMR4s+
 h5Oa0QNTs1z4RxLHfKxatmnfzV1BVlwtV+L59pdtFljZnHIGenB0ZR/1fNqwDIx3NfeUWhS2YVM
 0
X-Gm-Gg: ASbGncsb5gQ3Jh2Zbful4ghU+Av3VHe3f112tZR5ooY4esm7oMiiCOrxe/VhdPCDBa2
 cIe3+sOKHll43CVqZacMiHEAfF4eQzutwJlIv9MO5orkXkcpoBqDrCRL+YkEW1NUlbuA7B6XxHW
 t8Sa7EhzVnz8vBBJNUOAkDnr6jKlPHbRnpdvD1ePgL73lskY+OAp2LbNQbhvbGdotQKYEttEniS
 6Yjh8PCb41QkgcjmHsUuNe4QmRhEgKOSDlV7e+fAVqPZnwTXiBJ4eqxPNuboBECoVDCZkrnNGk8
 QLaCZnmoGXtPf81y//IjFbw=
X-Google-Smtp-Source: AGHT+IE+NbaSyOD5vxT8oIm2/WZz9KQjkbbXdVRxbPHlxMWplisWHDqpmczrkSfYsjQ0CTmCnZ4JRw==
X-Received: by 2002:a17:902:d2d2:b0:216:3dc0:c8ab with SMTP id
 d9443c01a7336-21a83f3ee9emr490000565ad.9.1737050619532; 
 Thu, 16 Jan 2025 10:03:39 -0800 (PST)
Received: from [192.168.0.4] (174-21-71-127.tukw.qwest.net. [174.21.71.127])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-21c2d42cb87sm2863195ad.254.2025.01.16.10.03.39
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 16 Jan 2025 10:03:39 -0800 (PST)
Message-ID: <818abb2c-b68c-473e-b0d1-9703466f43e9@linaro.org>
Date: Thu, 16 Jan 2025 10:03:37 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH-for-10.1 v2 11/13] hw/arm/virt: Remove
 VirtMachineClass::smbios_old_sys_ver field
To: qemu-devel@nongnu.org
References: <20250116145944.38028-1-philmd@linaro.org>
 <20250116145944.38028-12-philmd@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250116145944.38028-12-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62e;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62e.google.com
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
> The VirtMachineClass::smbios_old_sys_ver field was
> only used by virt-2.11 machine, which got removed.
> Remove it and simplify virt_build_smbios().
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> Reviewed-by: Thomas Huth <thuth@redhat.com>
> ---
>   include/hw/arm/virt.h | 1 -
>   hw/arm/virt.c         | 4 +---
>   2 files changed, 1 insertion(+), 4 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

