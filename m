Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F45CC3600C
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Apr 2025 17:22:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u0OGM-0001mZ-If; Thu, 03 Apr 2025 13:21:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u0OGL-0001mP-H7
 for qemu-devel@nongnu.org; Thu, 03 Apr 2025 13:21:57 -0400
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u0OGJ-0005l0-Py
 for qemu-devel@nongnu.org; Thu, 03 Apr 2025 13:21:57 -0400
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-2255003f4c6so12135065ad.0
 for <qemu-devel@nongnu.org>; Thu, 03 Apr 2025 10:21:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1743700914; x=1744305714; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=zOHzce89H5d9MLVZt5g59EpME4w7sz8Zoyc5MAMKMik=;
 b=ldoovLxm/31mCw+oNSh3S8F08jBLK8dBxubGtdnmrD7oBS3xz/4fOFL4+L3tVMl5TM
 8iivfEFzr6m8A0pFj8lOYhYhi85RX9kCoCOwTp9MH8V33K71SvZPykU4z3OsTFG6PjFm
 MJGin+vzSGeyDQKL8ofge+ZjYPkkstizZUxQYNSdA5GctT3k1mVFxyPQuueTb/OBQXwm
 FYgrq7NyB6gJbFT3XafnFRUIp+yY8lih61z2RwGDcASP8M+4bCq+Z3GLzMfyEjNZAjlO
 2anJvv41uYT9XiKvnYKm7kPTKkJSiXob7ULTN1c7gzRpRkGrwdi5o269iL5PKyvuOQ66
 L1QA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743700914; x=1744305714;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=zOHzce89H5d9MLVZt5g59EpME4w7sz8Zoyc5MAMKMik=;
 b=V0ktbYUIB/Xn7B1rL+rS3LzfJGsctNc86c79JwtYtvOK9LG73J+9wY62is6TXmJqXF
 dTWYCmGP8tsEE/+f0kkbI1m7J9yyGla918dYxUzLoyDd84vL+FL7bQGT/pEvCEeJHbIp
 bri/Nz8oXhwfIujWTkPTehM2WCId8zjinvb13V4/ok7GEPbCoAMfOFgVMEtTg5D24xLz
 BAsqFgWdeJZJhO4HYjEnCpUDnhReQhDdMA1+g3IjZuAZaiFpo+sAMJicO1hEbUJbkOmO
 TTiM7AMJl4517sb8CKDxcef1+29f1AmrXlcOQBl1bmmAqYeT5xRmKHpdWem/nmKheHBq
 VDqQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCU28F9nhrn18mf9KGYuXyUogyomKgfBdqeDWY78Y+fTa6CUKMLytW0IAW7LemUVj5jE52JAlFxrMv0f@nongnu.org
X-Gm-Message-State: AOJu0YzvGQkxsR61tziSY+w1P/IMu7C+ZId8zAfC7txUxbeOrungpHEQ
 ySbcAYNZbKJae2tKRSiWOS5hPmZfFjWWG0hXL63GAbX1v+P7Up8SaBhJ3GOiSKk=
X-Gm-Gg: ASbGncvvTnR5MN6uK4TlRltLb1IuirFxC6uK5HfFCKkQOXwTcEDQaBAAY43IB2iQ/wH
 JpUxrUe3OwkZbPwdN84Al23BdDBEDcyyj7gN9koFmcnTsVNpO2HFVUaIQb4+hB9Pzr2dh1YAwe6
 xkDuwFVFSKUcShPR4j8uZOD1VOZUXoi4ZdO8z9PRs0kHB0Agtlapj1M1FwLjTYip9SEyYrT5vLg
 MBVT7ex0LVWVX69xjJTcEbs1xCUKoSV+ciu966Gh2qb6zJiCItPrFUzVNsnL+tQcXXjw+Taa+Yi
 4LCuYunZ3ptWURRZzTVYHw3L5eEPbDRDwBZS9FUjz/UNOR87+fmxwejKghd90OqzCCu1XSzVPbh
 LpMNe5Onf
X-Google-Smtp-Source: AGHT+IEv3UGhXGWo7JyQIcbl7h0cwssQ4+1ecvhTUDe/kdznsZiO2nJliFS2Vo/EqRoCWg8LqMsw2Q==
X-Received: by 2002:a17:903:2302:b0:219:e4b0:4286 with SMTP id
 d9443c01a7336-22993c20215mr43836815ad.29.1743700913437; 
 Thu, 03 Apr 2025 10:21:53 -0700 (PDT)
Received: from [192.168.0.4] (174-21-74-48.tukw.qwest.net. [174.21.74.48])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-739da0e7d3fsm1766626b3a.180.2025.04.03.10.21.51
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 03 Apr 2025 10:21:53 -0700 (PDT)
Message-ID: <a90e5b30-1992-4460-86fa-f7e447dbdcfb@linaro.org>
Date: Thu, 3 Apr 2025 10:21:49 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH-for-10.1 00/24] cpus: Restrict SoftMMU mmu_index() to TCG
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Gustavo Romero <gustavo.romero@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>
References: <20250401080938.32278-1-philmd@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250401080938.32278-1-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::631;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x631.google.com
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

On 4/1/25 01:09, Philippe Mathieu-Daudé wrote:
> mmu_index() is specific to TCG SoftMMU,
> moveCPUClass::mmu_index() toTCGCPUOps::mmu_index().
> 
> Philippe Mathieu-Daudé (24):
>    hw/core/cpu: UpdateCPUClass::mmu_index docstring
>    accel/tcg: IntroduceTCGCPUOps::mmu_index() callback
>    target/alpha: Restrict SoftMMU mmu_index() to TCG
>    target/arm: Restrict SoftMMU mmu_index() to TCG
>    target/avr: Restrict SoftMMU mmu_index() to TCG
>    target/hppa: Restrict SoftMMU mmu_index() to TCG
>    target/i386: Remove unused cpu_(ldub,stb)_kernel macros
>    target/i386: Restrict cpu_mmu_index_kernel() to TCG
>    target/i386: Restrict SoftMMU mmu_index() to TCG
>    target/loongarch: Restrict SoftMMU mmu_index() to TCG
>    target/m68k: Restrict SoftMMU mmu_index() to TCG
>    target/microblaze: Restrict SoftMMU mmu_index() to TCG
>    target/mips: Restrict SoftMMU mmu_index() to TCG
>    target/openrisc: Restrict SoftMMU mmu_index() to TCG
>    target/ppc: Restrict SoftMMU mmu_index() to TCG
>    target/riscv: Restrict SoftMMU mmu_index() to TCG
>    target/rx: Restrict SoftMMU mmu_index() to TCG
>    target/s390x: Restrict SoftMMU mmu_index() to TCG
>    target/sh4: Restrict SoftMMU mmu_index() to TCG
>    target/sparc: Restrict SoftMMU mmu_index() to TCG
>    target/tricore: Restrict SoftMMU mmu_index() to TCG
>    target/xtensa: Restrict SoftMMU mmu_index() to TCG
>    hw/core/cpu: RemoveCPUClass::mmu_index()
>    exec: Restrict cpu-mmu-index.h to accel/tcg/

Queued to tcg-next, including the addition of the assert.


r~

