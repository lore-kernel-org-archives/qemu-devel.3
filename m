Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3240CC36010
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Apr 2025 11:50:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tza7z-0006ao-8w; Tue, 01 Apr 2025 07:50:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tza7L-0006ND-6N
 for qemu-devel@nongnu.org; Tue, 01 Apr 2025 07:49:46 -0400
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tza7I-0004Mb-8N
 for qemu-devel@nongnu.org; Tue, 01 Apr 2025 07:49:18 -0400
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-43d0782d787so36127625e9.0
 for <qemu-devel@nongnu.org>; Tue, 01 Apr 2025 04:49:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1743508154; x=1744112954; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=fikYIebl0dXQd2EX7nlr78lXlATN4J5NNn6N21wdHnw=;
 b=j44wVTE6JPniKJ+00/jnpavH/GsGU0S+svoDsbuz0t6gD/GiPdgXN9DSNPJjkZwDjD
 yiI7u2fXCM3KruF8a5cCo5o+gxO3H8xAot42DG974R9PtP92z05dLMB6OW9Jj4RHa9sK
 B233FUr1PwcFrEN6FlV3egrzB5UuCi1rjsloPbFhXzo8KQl62P3QMZGKsNS9hKb6yR1l
 y7ZPvdfBhCg/vvz3hDuAc20KnhWpRTOJhUPHHrzvnTASqzEVicpiEJ2u1Ea62zfnGId9
 KmKt3Cv8reOAHjjp9eBSwyJnmq8CtdCDPb+UvwaMOzqcwQIGhWWrJJp63r4iTRdKyPf8
 QPNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743508154; x=1744112954;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=fikYIebl0dXQd2EX7nlr78lXlATN4J5NNn6N21wdHnw=;
 b=m1EojNNvVQW4ca/D7VUu7/j269wVqzobhO0G26aj6VFYpYWQ91RmohFtEVWo2sW/nN
 gUm+mvDA84bSw21PaJOo7xNLv+d/w8cj5ATBjezEs98yHFJbn9QJq5Vh3SHviESPxm+O
 M+ObcT0948QKd8B6RbLpJ93ruSwI43bSvfU1ie98pZsAjiwyawG8a01Y9qMyRiZ+0VH6
 /mNHsMZ8p3UFWCiojmXqB5ahrSfXWeyVHp3xEB9oGS/eBR5gKt/FCi3l5lSoj+Gb0QQ4
 HEm5uDRXUP6UlnyT++rk0BQ57tU2wMGwFmXCJkqyrJV2SWLcOXnKM6cq9g2bKA5GuOsp
 XEcQ==
X-Gm-Message-State: AOJu0YyW4PlrR99MAjBhSXYmv5nuEPD6W4RWnyP9NQ9iOjlhUsau7WNw
 G2tjx4Pw8FcT28sePzxLRIep3h79eXQ/6VsbmpiL36u+uH1doPmnkhKHJC51ujc=
X-Gm-Gg: ASbGncsQVRdoVGN0w/nNzhS2tvW7AM7hsF690wyowitVdQx/uKf7dDagZLjypWEyiYJ
 M2+yT41gSNC+ZRMXNgcthiOcPwfpTFz1QH85QSx4bamptlWmRfhALgTUzdzVBBiNxZMk4Oe7iAu
 B5coyOTwOreKAxhFu+m6/3qjOMiFjnXo1Z1r9ZGn30V/DBWMbplqriPI+0uDyMztXl3NL7pjqtI
 shz4OUWPND8gXtO5XOEKZtacMTcr/b7w1XOJ96z9zsq4KZhhgoG0A0lR8hhUwF07Dpyfp9wrtT7
 tFrLPmpePHkzfBBfCnfUIqzofw8M/VnOLvHg/A2RtkEIU44P7DaDL7io7WWE5WxAQfgba6nV1gq
 qhX6UwX9ZGdFD
X-Google-Smtp-Source: AGHT+IGQHv7C0Taq4lcfKMOeJafLFGwD9LZjHNYqVibUGO4kryVzZiIsMtTXoFSvo7NpGpLXEy5CJw==
X-Received: by 2002:a05:600c:468c:b0:43d:83a:417d with SMTP id
 5b1f17b1804b1-43db622a42emr126560175e9.12.1743508154265; 
 Tue, 01 Apr 2025 04:49:14 -0700 (PDT)
Received: from [192.168.69.235] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43d8fccfe2fsm153936325e9.22.2025.04.01.04.49.13
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 01 Apr 2025 04:49:13 -0700 (PDT)
Message-ID: <76c5c76c-2051-4464-b4c8-ea39cfde5f21@linaro.org>
Date: Tue, 1 Apr 2025 13:49:13 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/5] ipmi/pci-ipmi-bt: Rename copy-paste variables
To: Nicholas Piggin <npiggin@gmail.com>, Corey Minyard <minyard@acm.org>
Cc: qemu-devel@nongnu.org
References: <20250401114412.676636-1-npiggin@gmail.com>
 <20250401114412.676636-2-npiggin@gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250401114412.676636-2-npiggin@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x329.google.com
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

On 1/4/25 13:44, Nicholas Piggin wrote:
> IPMI drivers use p/k suffix in variable names depending on bt or kcs.
> The pci bt driver must have come from the kcs driver because it's
> still using k suffixes in some cases. Rename.
> 
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> ---
>   hw/ipmi/pci_ipmi_bt.c | 38 +++++++++++++++++++-------------------
>   1 file changed, 19 insertions(+), 19 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


