Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06386CCA470
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Sep 2025 20:20:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v3got-0000Sr-4B; Tue, 30 Sep 2025 16:19:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v3gom-0000Lg-BM
 for qemu-devel@nongnu.org; Tue, 30 Sep 2025 16:19:26 -0400
Received: from mail-pl1-x629.google.com ([2607:f8b0:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v3goh-0005In-I5
 for qemu-devel@nongnu.org; Tue, 30 Sep 2025 16:19:23 -0400
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-28e7cd6dbc0so7626245ad.0
 for <qemu-devel@nongnu.org>; Tue, 30 Sep 2025 13:19:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1759263551; x=1759868351; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=L4Ub3OL6SJsWiOnIUyGAZRsHfoGGH3JqvJK/BI81PrM=;
 b=whUHmGZ9FoWzdDrz81vtehlMcPDGk1Njp1H7habAmbZyAB/VGn38udrNjk2ohQZNAl
 n4NODkjYY7zZ8bax83/XMoBcoEILKfGPSTZP0fTsNxopwufs2uK1VgP1cYuegwvsu6XP
 HQdaIz/zvV35dOjz4gsO7UVfDWCAnpiL1TMqQXyZZ4pZh0eeRA4BHvvWUcActq5o6lZ/
 Cne4DQD/6deLF4X/xbLR9MhZ8pdlW+KoW0zdV3jRXO7/UD/HzM5iv1JFj9OgXjkr79VK
 kPV8Axnbd+h0Zr5/07g9PYRdY2ly4IwJegyMuRnJQfzYlVPstckPBgFz16xAVVxDy06S
 EY/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759263551; x=1759868351;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=L4Ub3OL6SJsWiOnIUyGAZRsHfoGGH3JqvJK/BI81PrM=;
 b=rwWN8MQ1JpuWoV+pV8v49GphasDcCXfRxOuD+jjYEfYYUk88JqtHpnINs8uanenbTu
 0YKIWYnlbwhnUzFIxmgyyXWm1iowL8Cc5UUNTu6Y521T7b44DZesxE6zDYLDf2rWyGWS
 LDLgGqwqslpH6DC+JYrByYlHq/pOMHWrEvyr3JwLM8IP2dia2dw66K2KamXbtW/ubW8D
 u762U5uv0IaGilX9rlX2U/mAaYL6qDKvkeYOtycDlc6lZ4vhHz2w7VhDv/n0cVCtxBmF
 h9OmWIsLqxctdh1RN6ArYRXcYgLo0VyhG47gEnTv/H10KRLah8uYn7BiWtQdR2zTBJiY
 aP3Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCVB+3gTh+rnpH+JeqyYHXAr7CqQ/ftY6IWYMDDl3Vv4VGzk3cQlaHSpwOLVbO0yUWP33p7MtiEVL+qf@nongnu.org
X-Gm-Message-State: AOJu0YzjZjNpGipT/2JndDro4xXUQXYFtWN67L8iIdOMlzti/18V2xTE
 gdd2YUq1JDpeIeckM6MqcavnEJr1U4QY9JDMVA6ZEo6GzFlxXnbxXPFuZo41h5rouJQ=
X-Gm-Gg: ASbGncvlxsN20Uc0wwP7okrcX6eU78dQox6djuhnp4UnfUewItDgTlywqsIbLkuJ7az
 oXYFpemLSrfLD8Ykf1a/NFKh/zdZ3hg3GAkHiNEIqZT7lKrBwXXVowZwVOWAnuIBX0G1U6Cib+o
 VNRzecMXmNxwmGEHf9FuEbpelMc1jTXC9AllAtt1zxXf6wYRklpzCCeuHk198AXdUx4zRkSqlac
 STqhpihUB1tnY1duu0Lf0R6JwzCcaabexBH/rbzd6hd8pBmC6e+FY3l7ydzqC3E7oEcqrIVpzlT
 vdpz2ZHUgCeEH0JjlZbQzz1FpMIMZjLBtcEFrMRwYB9uDoiUjGMtElVZSc8LDldphJ4clI6ieCQ
 BhU3ewwds2Ad/GX0ersiz2iM1M0EaJuGdjp2GvnYj5BkzV0JkJONu1USGvOo4j5DAl1M8ueQ=
X-Google-Smtp-Source: AGHT+IFBqmBYp3cvtvLAsA0HZylVtikKNBk1/mYBUpjBEVtyHZsnIqEca2AgkdxlD0PDWFB2g93eSQ==
X-Received: by 2002:a17:902:f68c:b0:281:613:844b with SMTP id
 d9443c01a7336-28e7f442c7dmr13184315ad.52.1759263550974; 
 Tue, 30 Sep 2025 13:19:10 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.157.132])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-27ed66cda43sm168049085ad.25.2025.09.30.13.19.10
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 30 Sep 2025 13:19:10 -0700 (PDT)
Message-ID: <81c23fc8-55e5-4bc8-8129-95bbd2c3dcbe@linaro.org>
Date: Tue, 30 Sep 2025 13:19:09 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 05/18] hw/s390x/sclp: Use address_space_memory_is_io()
 in sclp_service_call()
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>
References: <20250930082126.28618-1-philmd@linaro.org>
 <20250930082126.28618-6-philmd@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20250930082126.28618-6-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::629;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x629.google.com
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

On 9/30/25 01:21, Philippe Mathieu-Daudé wrote:
> When cpu_address_space_init() isn't called during vCPU creation,
> its single address space is the global &address_space_memory.
> 
> As s390x boards don't call cpu_address_space_init(),
> cpu_get_address_space(CPU(cpu), 0) returns &address_space_memory.
> 
> We can then replace cpu_physical_memory_is_io() by the semantically
> equivalent address_space_memory_is_io() call.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> Reviewed-by: Thomas Huth <thuth@redhat.com>
> ---
>   hw/s390x/sclp.c | 4 +++-
>   1 file changed, 3 insertions(+), 1 deletion(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

