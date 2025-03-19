Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2DC9DC282EC
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Mar 2025 01:36:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tuiM6-0008R6-CD; Tue, 18 Mar 2025 21:36:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tuiJb-0007Yv-I9
 for qemu-devel@nongnu.org; Tue, 18 Mar 2025 21:33:54 -0400
Received: from mail-pl1-x630.google.com ([2607:f8b0:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tuiJZ-00077O-Ni
 for qemu-devel@nongnu.org; Tue, 18 Mar 2025 21:33:51 -0400
Received: by mail-pl1-x630.google.com with SMTP id
 d9443c01a7336-2254e0b4b79so20184315ad.2
 for <qemu-devel@nongnu.org>; Tue, 18 Mar 2025 18:33:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1742348028; x=1742952828; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=qJ1lwZ42ltNioLUBhyZTOqSNEn59jmSzx3466w2s6do=;
 b=fE44VKpc5NmogI0l4aP515P9rKoJcCpRS+zYX4soxovGbTF0cFBOBW2uwUMg8B5XRP
 nBwt+Uj+VgILYJWkMSiLzMHl6zfgyhqQiLIl9n7jq6An/cCWBI6iLgPb4Uklj/xMs9xn
 apG7kEzOjtgPkNXWh3IGSzIL9lSI3vBloKfvml/EHMNPaXNA0cAJ6SUWcanJwtFtQ3P+
 obVYIv5bbasqlaRIjPFClQeXTpVeEE4x9x2fo9+clRbz/FKe8rlk9umlMEfyNqGxAh6D
 iS111xGUgEw5T701WQfdJRMdvwqGM6lYPB8x/TajWZ4tCqURF8x4P6ZlqH/ravrdZNpa
 ziIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742348028; x=1742952828;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=qJ1lwZ42ltNioLUBhyZTOqSNEn59jmSzx3466w2s6do=;
 b=ZJu0QR1YG33HhRUn5hqsrqwr68FIZ3valsbf3jR2tfRQ6D+qpWZVNVYqRrUK6IkxZD
 ro+9FbM9f+vLnJk09zmcIMoE1+wpnV54bME0mgw2ukgVDKhyIJk5OokpAy1K3E0DJ4NW
 1RwptQMt2GXNP/StkcBNED03Qj+dZ6blN4fEGUoYXj0lCDVFrQTx8h+T8Kx/1SMi4WGN
 NWXTC4dwjEfHoLwPdWuuSPGvWczSGoOVIEtIhCDA6yW2z0YI1vSzV/EljsSZ2wfYQONR
 RL86alwL9gz8Q8sX7/+mMrznQGAFsSL3xkJOXHNL2Oqqz54mD+Y14k0YqvZt3vEPm+ZZ
 r91A==
X-Forwarded-Encrypted: i=1;
 AJvYcCX2MO9jEghldl4zmfGbKbtkSSe/A6XhmcJoxZCITWsyRXOLVjrmS9bT5DkklyV/195s2uiGuNO9JLWZ@nongnu.org
X-Gm-Message-State: AOJu0YxH0d37SC+H80MxSQZQzRugVJh26KZ+DIAWXl8XLgNptNcDRo4z
 YqYgpUNmYbU/HyMwVOS5FJS+2MqoZloIc4LRLayUq5Easv2jmcIouzKS96++QEQ=
X-Gm-Gg: ASbGncs8153Hf7zB1qMpE9y3zVwxQyqKyCjSUBWfT4YHZd9lHFf+7oA6+eWejErZL1A
 XsouCUNPdo5vIFNtet25XAHQnkaKHP/NPiQ+HrWmA9o1WSl2RbMg9TyyalNOq32FAHtDgJlKCNW
 qQ5q/c+7AjcBMHju23R9N0/De6s10BmNCGfoGuGup7jSDV0wEpLrAhBz6Z2oagos2nC+a3FXkRi
 9IVSj2Td5hYrZqFesQP5onvM6AiJCh7mMOsnWZhxFtCOoCcfhGjdW4MvchvIJKiSmHERR3UwExd
 urg/YtHqEgHUTL2wZECcKASk9QaYI0WroRniavHFN1Q1XAdhHqCr1Xk3s/MuZGtrcVf1++h4Gjs
 +PJNoWrYt
X-Google-Smtp-Source: AGHT+IGJf/J+cc1jPpfNpzQbgYLQSMs9dhSEiSq/D5A/t/noukwTzwxVKg4O2Z2veDqb51+HBx4mdw==
X-Received: by 2002:a17:902:d582:b0:224:1774:1ecd with SMTP id
 d9443c01a7336-2264982aeb4mr15259955ad.4.1742348028010; 
 Tue, 18 Mar 2025 18:33:48 -0700 (PDT)
Received: from [192.168.0.4] (174-21-74-48.tukw.qwest.net. [174.21.74.48])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-225c6bd4d61sm101987165ad.242.2025.03.18.18.33.47
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 18 Mar 2025 18:33:47 -0700 (PDT)
Message-ID: <8f285e2b-105b-4081-bf6a-05f2067744dd@linaro.org>
Date: Tue, 18 Mar 2025 18:33:46 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 29/42] include/exec: Split out watchpoint.h
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-devel@nongnu.org
Cc: philmd@linaro.org
References: <20250318213209.2579218-1-richard.henderson@linaro.org>
 <20250318213209.2579218-30-richard.henderson@linaro.org>
 <618b1e6a-21ff-4fb3-9d43-a1ef123ab138@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <618b1e6a-21ff-4fb3-9d43-a1ef123ab138@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::630;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x630.google.com
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

On 3/18/25 17:30, Pierrick Bouvier wrote:
>>   include/exec/watchpoint.h           | 41 +++++++++++++++++++++++++++++
>>   include/hw/core/cpu.h               | 30 ---------------------
>>   accel/tcg/tcg-accel-ops.c           |  1 +
>>   system/watchpoint.c                 |  1 +
>>   target/arm/debug_helper.c           |  1 +
>>   target/i386/cpu.c                   |  1 +
>>   target/i386/machine.c               |  2 +-
>>   target/i386/tcg/system/bpt_helper.c |  1 +
>>   target/ppc/cpu.c                    |  1 +
>>   target/ppc/cpu_init.c               |  2 +-
>>   target/riscv/debug.c                |  1 +
>>   target/s390x/helper.c               |  1 +
>>   target/s390x/tcg/excp_helper.c      |  1 +
>>   target/xtensa/dbg_helper.c          |  1 +
>>   14 files changed, 53 insertions(+), 32 deletions(-)
...
> To push further, it could be worth to remove inline stubs, put definitions in common-user/ 
> watchpoint.c, and add this file to user_ss.

I thought about it, and even had it that way at one point.
But every single usage was within a file that is already
target specific, or system-only.


r~

