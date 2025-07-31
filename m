Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1048EC87FCA
	for <qemu-devel@archiver.kernel.org>; Thu, 31 Jul 2025 21:49:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uhb8w-0000Qi-8R; Thu, 31 Jul 2025 17:48:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uhauq-0002kE-KJ
 for qemu-devel@nongnu.org; Thu, 31 Jul 2025 17:34:32 -0400
Received: from mail-pl1-x62e.google.com ([2607:f8b0:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uhauo-0000Bx-Pm
 for qemu-devel@nongnu.org; Thu, 31 Jul 2025 17:34:19 -0400
Received: by mail-pl1-x62e.google.com with SMTP id
 d9443c01a7336-236377f00a1so12889295ad.3
 for <qemu-devel@nongnu.org>; Thu, 31 Jul 2025 14:34:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1753997657; x=1754602457; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=OkHzUj8X79poqHM+hzx90X+R9KktHZvKdEgw3SZPIgI=;
 b=DgsAznLBY9LIoPk/e6wF9gkWG0EBgeslm1Gc6DxrCjAoDFHXg0t2/KzAmjr10A1Zya
 4uijoSYTWTNiIrXE+zdi6/beDr60/w+q3B09UBB6QpAzg28isV96izjv/eTIuslY+Ee+
 neMu2fI3MaXyAnwaYYkZzqWjZKYWqD/mHS821RB4KUkbZpKyFvOHBQPp10EXkw5a63AR
 p49C/8PVi1M6+oAWOHeW53uLkrkdy8eoaNsjhhnVTYOeyMZtAideYBM60WvoYRc78M5F
 WvhLWCDnxwsvtzNRJDzdMjKekzdXrrFdU9/BRlOMZ90BimD1VeLxCNwxrCZovuU+OY+i
 wTCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753997657; x=1754602457;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=OkHzUj8X79poqHM+hzx90X+R9KktHZvKdEgw3SZPIgI=;
 b=JFD2hT1r11JR8pAbAJPiGsofsBXUtUPdOk/xL4xmQq0Zsuk+Zg8BzUyuqdCucbVZ8z
 TSesKKA4GT4GGgZWaEE5osBGd+vsyDxBOxE8F1gC5tK8j0pY5LQM987kPQflyNOekIMY
 XeQc3b8Znd+qtaIOuOegacTFd9dAESYEmFSwPbaTb/BBNLfMInC2pubWMiDnnR+yOiUT
 pqbeZ8xL6UXWq5e0izo7QFanoAgl458patzWWFDO4Ii7StT5LYyOshJEgEhJnJqexj/X
 EdgEhth3nQMvbHpYnNwBkoEvB46OF+v/tBeawqfEvNhGV6zePTi8hQLR3MGJepG8Hbve
 0H9w==
X-Forwarded-Encrypted: i=1;
 AJvYcCV/xnGO4C3T9kF10n5/Z8sXWwlklx5CF4Xs+xe5ZLSC/92l+SnTMQepUEttmMj/iTbEDYbo6K1m8GbY@nongnu.org
X-Gm-Message-State: AOJu0Yyjmb0Ehp5IkVRByGyhMu5Fv2orkM7h0cPAR7mETUdSfck9HfqQ
 s/kYhuN+1RYAEsZh4qToeNRQM448qtWfXSkiuXprAKXoAbC7M7p2Qb5YKd7MyVok24NzVCwmtNK
 zhVzR
X-Gm-Gg: ASbGncuerqVG1U1llMK3HkyIEPKB8/JEfy9QqxlmLU1dXlxuIDjGV+nSUPi6sFVq6QZ
 KiMKHTYmdlriJI0ukbhfBVs00s0SMiCJUYqN4KVpi0wMUYy6g2nnWZj9ihm4TNr1ZLr4ks2Ivub
 xJ0pmaERE4sjAJF6aPSL0mdoQIr/7368TLVUQPbizjc7TFZN9XBEcWLplciS45kLNakE+WDYBuL
 afcKdLRq8RHJ5fqpKg6p6ZUzalNDyh6qFuJ+NOLsU6wl9GJvibOt64rdVPhiTihhNYPOZw0rE64
 pLxnQ4ItYBjlJf337+oeV0vs/d0BXN7X3snYjBTe/N3+atJuYkSKVeIxox4TIBxpuEsWz1L75q6
 EuG9G1MhagjZX5kTRgXmE1Yjbkg6Wjvk7njM=
X-Google-Smtp-Source: AGHT+IHZ360Q8T/eiSiBjjdE5U160O8+dEt35gndVQ31UV+2uknGw2jI5W9YDpH8j6JdOWjP5+u8mg==
X-Received: by 2002:a17:902:ebc7:b0:240:8cdf:f933 with SMTP id
 d9443c01a7336-24096a9dd25mr126814195ad.22.1753997657007; 
 Thu, 31 Jul 2025 14:34:17 -0700 (PDT)
Received: from [192.168.1.87] ([38.41.223.211])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-241e8976ca5sm26007085ad.100.2025.07.31.14.34.16
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 31 Jul 2025 14:34:16 -0700 (PDT)
Message-ID: <c46e1960-7727-42af-a75c-4a74043cd6e8@linaro.org>
Date: Thu, 31 Jul 2025 14:34:16 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 57/82] target/arm: Implement GCSPOPM
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
References: <20250727080254.83840-1-richard.henderson@linaro.org>
 <20250727080254.83840-58-richard.henderson@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20250727080254.83840-58-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62e;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x62e.google.com
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

On 7/27/25 1:02 AM, Richard Henderson wrote:
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   target/arm/cpregs.h            |  1 +
>   target/arm/cpregs-gcs.c        |  3 +++
>   target/arm/tcg/translate-a64.c | 27 +++++++++++++++++++++++++++
>   3 files changed, 31 insertions(+)

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>


