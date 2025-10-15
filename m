Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D680BCCD185
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Oct 2025 18:22:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v968H-0006Kp-Rt; Wed, 15 Oct 2025 14:21:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v968C-0006IX-DA
 for qemu-devel@nongnu.org; Wed, 15 Oct 2025 14:21:48 -0400
Received: from mail-pf1-x429.google.com ([2607:f8b0:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v9688-00017g-2e
 for qemu-devel@nongnu.org; Wed, 15 Oct 2025 14:21:48 -0400
Received: by mail-pf1-x429.google.com with SMTP id
 d2e1a72fcca58-78af743c232so6281478b3a.1
 for <qemu-devel@nongnu.org>; Wed, 15 Oct 2025 11:21:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1760552498; x=1761157298; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=sEZv/rDH/KQU+LRp69TEnzymzVBlREonIs51lYfiTFQ=;
 b=Tq9tlWF9EltKf4JawDk2C9yKrlkC49lWX6DMUYiOGmxupbq2EbnEeuQdlEj+NHL/NI
 ZOYb2T/cza6XF/fOJjiFC11ISeZ7dVSW9TiFR2T9Y3E+8DDkPyL7X3dqysp78NT5GHnz
 rPBCnkcC02wiFYQ2npGWc9PcVYoGjjOUZqZA0HJdR0ceSpejD8RkrVanwtex5iiIHu7D
 1oOx2X0DEehgPzUARYq7UO1T7N/mw9kx0Dfy71VFIkds//Cgc8oDb7LkuDAWa2FjIl0j
 NuOrlEKmw7UTcC85/F0nggDe7czf9BuLtL6C+aKUUYAfeGj+eq6gWc4N1K3EoY4eXtiW
 TUHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760552498; x=1761157298;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=sEZv/rDH/KQU+LRp69TEnzymzVBlREonIs51lYfiTFQ=;
 b=m2AgqrGVMDI/KCIZ2rJLkwY5poPtLvZW21stPvWcuIE1GAkOSbSMg7EnMOJmBfbIBU
 U8Fs4YcahGLDgHOtVpNNo5z3YiSYlIO9Ea6nRt1nVJwTTtHCK04t5AH+NrQwLh9eaDlU
 ZRFLdeP29WnkdgMhvjVs2v4s6bKbvG8k3n+s2VApIOZ/ShMw4x4unNsa5Dfj5+ZQ1XKL
 j9lB6hALeUKuVz8Wt7BxlOdrIpYNJtAX/iYV95w/4JKVnjfvlCAxfTiAEr//Pn/mKyAO
 JCA4BzHxTBMW2XMIjSIW/A7L2esZa5w+RQwkQ2Ja5gCMW7y36v6LyhPIcrMbJ6IQ3mnt
 GnYQ==
X-Gm-Message-State: AOJu0YzqJdvQaLdeo7MKjqVqGb+s1fOeVjhEBtiHWuHKCmQTEG0BXAHS
 qBl+Q25twqazNhKhLQDuMxPd25YykJIgsBdG0zE16mKLfoivD2feupJcJQVYkcEPQYqMhOJNnFe
 GaE5NmJs=
X-Gm-Gg: ASbGncu9q4WzX8EaPFNc0CjY/suPABJr0BS+5MrPwcNv2RPGKMYQjJgQPX1kEJY30zM
 0+f6TCl5bDc9kbzVvXbsk5FiKwHC73j7zFGqL0dAsOHBQSxFPF3RkW2aRYNWilLL1fsBoayhoIl
 qWwKcWm5gxSEkMOT7rQs6+jeYZI3F8A1Zor9siSPB4lTwTwg/KzYWyoMqOJoO9WN1nFs1GdbJCw
 EQFHJ8jM/PzW6x5yZ9iqYnh1EpEzqNZzS7JXDZzJYnn0f7LJESr9qPIe0TrvWTH2+Lae2mH/sNn
 0zXY3dwaWrpdc/6eGl6wPrfy2P8Rh+lhmuhXCbQxNWWL1/Y9MlzW16YR15iyzZtT7ZE90V7Rs9n
 YMuKSMRd1MoSREqkqisRjhD6/iIS5WKvOkYttAP5rk242qrcBLYSS2SDetes=
X-Google-Smtp-Source: AGHT+IGl3h2mT+LT3kfTpXyYNgonanZNtNw9oNHEYopSFJgdxNifMHQz3iM27kmfM95YK1zq5yCtSg==
X-Received: by 2002:a17:90b:2244:b0:329:e4d1:c20f with SMTP id
 98e67ed59e1d1-33b51162533mr39347300a91.9.1760552497815; 
 Wed, 15 Oct 2025 11:21:37 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.157.132])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-b6a22b7b01fsm275625a12.21.2025.10.15.11.21.36
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 15 Oct 2025 11:21:37 -0700 (PDT)
Message-ID: <ca60cb0f-684b-40c1-994a-8dbc56351a95@linaro.org>
Date: Wed, 15 Oct 2025 11:21:35 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/7] target/microblaze: Remove target_ulong use in
 cpu_handle_mmu_fault()
To: qemu-devel@nongnu.org
References: <20251015180115.97493-1-philmd@linaro.org>
 <20251015180115.97493-2-philmd@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20251015180115.97493-2-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::429;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x429.google.com
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

On 10/15/25 11:01, Philippe Mathieu-Daudé wrote:
> cpu_handle_mmu_fault() -- renamed in commit f429d607c71 -- expects
> a vaddr type for its address argument since commit 7510454e3e7
> ("cpu: Turn cpu_handle_mmu_fault() into a CPUClass hook").
> 
> Signed-off-by: Philippe Mathieu-Daudé<philmd@linaro.org>
> Reviewed-by: Anton Johansson<anjo@rev.ng>
> Reviewed-by: Pierrick Bouvier<pierrick.bouvier@linaro.org>
> ---
>   target/microblaze/mmu.h | 2 +-
>   target/microblaze/mmu.c | 4 ++--
>   2 files changed, 3 insertions(+), 3 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

