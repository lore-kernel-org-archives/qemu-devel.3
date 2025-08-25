Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75C88CA0EFA
	for <qemu-devel@archiver.kernel.org>; Mon, 25 Aug 2025 09:42:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uqTi2-00087G-TY; Mon, 25 Aug 2025 05:41:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uqThy-00086q-7J
 for qemu-devel@nongnu.org; Mon, 25 Aug 2025 05:41:46 -0400
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uqThr-0000jE-82
 for qemu-devel@nongnu.org; Mon, 25 Aug 2025 05:41:45 -0400
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-3c51f0158d8so3041360f8f.1
 for <qemu-devel@nongnu.org>; Mon, 25 Aug 2025 02:41:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1756114896; x=1756719696; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=xEH35gJAAzR1i0A4YEprU3DLhSa+rpNpisrsV2O4bNA=;
 b=NLljzDBohuFrwQ5HOmZ5YvejOIf08aLgAff+BScQxPbth0mqbwb5I7Mf9z8xFURCFM
 bp8MWOjVMIZContyLWUDSJC02BCd1xPq/NPSt41Y19cyGLFFNwaCfVGp8GDLUdsHodCp
 gT2T9i43CbPLfEY6SHxX7QWHH5kihYncO08fWZ3CM4OBJoGSDSweTWAXCWFhovJ/nLRX
 CE6CjxEEhxN0X3csIRdkPeRfJ85OaTB+WvwU2MJNrnqohrwtsvQY8mltcH5JSeQLrUjK
 IVteD8WBPVPcfhgvw9OUUemYmnUKSy69zXdAmUTigd9f502FgTTGGHGSz1se1e44Fi3+
 5AUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756114896; x=1756719696;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=xEH35gJAAzR1i0A4YEprU3DLhSa+rpNpisrsV2O4bNA=;
 b=Is9CxI9Qh3hfn8SSEv8p9nJg8ieDOLsJT8f8D0WT14O2SF31bsUwbVswG8V+4PBN32
 n5gqk2I4dhajRQe/gyYtwS1/pCJeVBGLDdcFNl1LEmEaeH+Sji8sMD4NQiPjmsmQoAQg
 ZrI04ms0oPJZA2i3OghPrMzvbuHYevHUmy/6nMNVwKjA5JqhwPavIa1bJ8OxNJu7BOpK
 9N2Ud8ihfudREEYfZKHyiMYwlRuPdzuUwbtQEp2vx828X30YBPI2WdWu21ujAVgWimG8
 K8Yt93VIbGppAHc1/d753u/34NfMbd3HtBfSRYXcpgQSN3TSqyV2UdW0ZFIpzJR1FJfL
 Sivg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWYzbWo/oe8/AF4SCz9GEd1PIiMqGbeBYpBIwU0RhoMLurqy+dcF62PqfIL/qctU1ARTr5XgHX3SDCg@nongnu.org
X-Gm-Message-State: AOJu0Ywc/aCWq+HS8qlw9pnBoRDjBgigkHFgNHToW3faE3/4vJp+k4Cq
 mfD3ZtBXpR/Q2AqBrLDAzJdQwWVOjNDlz170F/jo6fqkhXmHhSntiMnSJPv+uP4lhCKZYYqT/G/
 ugn2o
X-Gm-Gg: ASbGncvONSDYJ93+ifVhA3OWpIaMbOFcugpOXSN/0cRJ7Molb6BhF9n+DyWkfgIk4mY
 MqxfJk8aLMKEs7K9Z3ZUdZzm24xmQuHU20AqWmIXbL5DDO2IHBMnytPcBzxXnR1uUG7GIrT0m9v
 hB/wsyf9NhvYeTUke9E7QeNeuvAtAoZQxrVwm4LuGaoe+jnXm9BcEgJZ9CGnwMhtYqo0YkMS896
 ZDjwWM2rDCbtxhdyBpEoDV7L7+a5nUvtyJ+wNoIzCiYTyRljsnLPaJ1xUBshTEGL8Q+zpBqRce5
 WS3ya6Qhm21uXf7tU3p2CxrrXwFu35f/d9WfgXhkJZyQA8lBS6wJUtDnR+RQejxvQUQzZbcdCkT
 aIOpBNHoUD7OGbbWVrRz3VdgVRpDmvEx271nuQhmSCN8zrbPsLKkh8M4KxGfU5CsDKw==
X-Google-Smtp-Source: AGHT+IH88pnBdCqYzf0f9K+nPGT6rqu6yI4IXJHAXY5S+rGKkOX4AH7koz+Ha0s5OFTI5uH+Lc71jQ==
X-Received: by 2002:a5d:5d0f:0:b0:3ca:7d27:6d98 with SMTP id
 ffacd0b85a97d-3ca7d277083mr595826f8f.14.1756114896130; 
 Mon, 25 Aug 2025 02:41:36 -0700 (PDT)
Received: from [192.168.69.208] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-45b57449e72sm103009235e9.7.2025.08.25.02.41.35
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 25 Aug 2025 02:41:35 -0700 (PDT)
Message-ID: <8f04ee1f-1806-40a1-aa8f-0bb7ca634b98@linaro.org>
Date: Mon, 25 Aug 2025 11:41:34 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/8] hw/sd/sdcard: Refactor sd_bootpart_offset
To: Jan Kiszka <jan.kiszka@siemens.com>, qemu-devel <qemu-devel@nongnu.org>
Cc: Bin Meng <bmeng.cn@gmail.com>, qemu-block@nongnu.org,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
References: <cover.1756019920.git.jan.kiszka@siemens.com>
 <ed81074b51bd85d51930424ed0e9ff24654a95c1.1756019920.git.jan.kiszka@siemens.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <ed81074b51bd85d51930424ed0e9ff24654a95c1.1756019920.git.jan.kiszka@siemens.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42b;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42b.google.com
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

On 24/8/25 09:18, Jan Kiszka wrote:
> From: Jan Kiszka <jan.kiszka@siemens.com>
> 
> This function provides the offset for any partition in the block image,
> not only the boot partitions, therefore rename it. Align the constant
> names with the numbering scheme in the standard and use constants for
> both boot partitions for consistency reasons. There is also no reason to
> return early if boot_part_size is zero because the existing code will
> provide the right value in that case as well.
> 
> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
> ---
>   hw/sd/sd.c             | 16 ++++++++--------
>   hw/sd/sdmmc-internal.h |  3 ++-
>   2 files changed, 10 insertions(+), 9 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


