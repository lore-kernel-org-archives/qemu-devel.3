Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4CED3E77188
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Dec 2024 21:29:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tQvQP-0003DQ-AA; Thu, 26 Dec 2024 16:29:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tQvQG-0003Cf-SY
 for qemu-devel@nongnu.org; Thu, 26 Dec 2024 16:29:37 -0500
Received: from mail-pj1-x1033.google.com ([2607:f8b0:4864:20::1033])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tQvQF-0003zr-HT
 for qemu-devel@nongnu.org; Thu, 26 Dec 2024 16:29:36 -0500
Received: by mail-pj1-x1033.google.com with SMTP id
 98e67ed59e1d1-2ee76befe58so8018809a91.2
 for <qemu-devel@nongnu.org>; Thu, 26 Dec 2024 13:29:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1735248574; x=1735853374; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=yjcjTj/hAHZ5vaCIDyMQt89cO/R1NDZpYRGdJ3NjVWA=;
 b=YbIdWhp5NXjGRSOjMb9nkh9Xg0H39Oa6sRhu5v2m77yvBIh7QxZNHVJfMzxYEGs8jt
 Wqm6SiDrrfyrb96JABeABkgZhengzb1o9hrEelfe/gBA/zcIitC5LOg9BH2zIcNJ0b1a
 fX16gaQwUK90t45OBKQmVMJWMpc1y9ZeB11zGlIFdwn58Xz95jkOTqptDFREabv/H5GP
 3mGdIRqgQ2Z7ffBugmzgDMwVx6MQkDTx8vB6lMKsQuvqY7TXDbwTYLfle29e/8XPMMxK
 +rxS3zpy0W4lXy92OOdsp6ugBaTXYnyXyK4G+N65/C/oi2Z/ltpxhmL/GueKrcR+4uXq
 G7bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1735248574; x=1735853374;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=yjcjTj/hAHZ5vaCIDyMQt89cO/R1NDZpYRGdJ3NjVWA=;
 b=eHXjjG2hTgFr0wGvIFtHez5oKXPV59LyRbK/tPD8iBv9P7Ag66XIn48XCbxtOA+1Lj
 UFtGWflGdjgLVSxA+XvMcsK8QoW4NOR0H0iJCai/BUo9iYmGfW8TYy5K6cNJ6mer0WbE
 v4qJTgXQO987TG10hkXy5oS3Z2dtdznSuyBvFJVee92hX6KB31QO/M0/ZgLFaC27W4cO
 eI2f3xiS+HsBu9kAiyxffxx9O22zklqM9PHCzzykAT67Deei5NQ1nNIFt195iC6Edsds
 VgBkDdGG3/RFf2UW/XkRCbu07dwcJuTqKV0p5ik3iMpVJH8HXEqali7Wwi5MaTUmqW5C
 1nSg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWSOieP8DTJbGemssdFWPxONP4oIny6rfe/4Xu7KpRhdctV/yNePppODhuR+a3GjTgjTXa+V6I9eN0A@nongnu.org
X-Gm-Message-State: AOJu0YwwT/x5X4gR5G20f6AfrtyEBCoiLyU0pMQTCgxiSeIMhK+CNcDO
 OZueViPD4b+/x5bKtnAOGlbjIGKp3nHWFaspC57+ajzQ5NGh8TEC46UdUKge38U=
X-Gm-Gg: ASbGncuoBMjgzRj+ScXrh6axb6aMyCp5YINHgBS76QX7Zg8LIzE3qhsvbJ/UJ/eMVTN
 hKnuvpmNR0p/JyqTenodp9g6BjP4EUFqA1mtYPA/jXnaYcFLw/s2WtWbkR0QOfkiavRjarzPtnk
 Z4Nm0ZAdrjQeo8dzcWgUJzSD/VlCamfJFKzqt1Yu4aVhNsuspLJY1jVCfuCG1ENVR9UkvVmw8af
 4jrEYnnf6CBxGdv/lP2HmURsC8bLVrOhsJVnGsSGI6gSoAkWzC7uS46jrsapc3VVJDJ+ZLEfTYP
 Vh8m7xjBZz6jXSrfVs/cwVm/oFMDsvKDhtttsOQ=
X-Google-Smtp-Source: AGHT+IGfaPMZHT06EzMO5TE4tXKKqNIvO67Z5X3bG5LRZBEjRcGezjeBUhFLAvjRrIEGWfq+qwDIYA==
X-Received: by 2002:a05:6a00:392a:b0:728:e906:e446 with SMTP id
 d2e1a72fcca58-72abdeb7855mr38778195b3a.24.1735248574261; 
 Thu, 26 Dec 2024 13:29:34 -0800 (PST)
Received: from [192.168.125.227] (syn-156-019-246-023.biz.spectrum.com.
 [156.19.246.23]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-72aad81572dsm13367110b3a.14.2024.12.26.13.29.33
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 26 Dec 2024 13:29:33 -0800 (PST)
Message-ID: <68a37378-5d95-4b33-9ab2-a64e0a5ef449@linaro.org>
Date: Thu, 26 Dec 2024 13:29:31 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 08/23] target/loongarch: Fix some modifiers for log
 formatting
To: Jiaxun Yang <jiaxun.yang@flygoat.com>, qemu-devel@nongnu.org
Cc: Song Gao <gaosong@loongson.cn>, Bibo Mao <maobibo@loongson.cn>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>, Zhao Liu <zhao1.liu@intel.com>,
 Paolo Bonzini <pbonzini@redhat.com>
References: <20241226-la32-fixes1-v2-0-0414594f8cb5@flygoat.com>
 <20241226-la32-fixes1-v2-8-0414594f8cb5@flygoat.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20241226-la32-fixes1-v2-8-0414594f8cb5@flygoat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1033;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1033.google.com
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

On 12/26/24 13:19, Jiaxun Yang wrote:
> target_ulong -> TARGET_FMT_ld
> vaddr -> VADDR_PRIx
> uint32_t -> PRIx32
> 
> Signed-off-by: Jiaxun Yang<jiaxun.yang@flygoat.com>
> ---
>   target/loongarch/tcg/insn_trans/trans_atomic.c.inc | 2 +-
>   target/loongarch/tcg/tlb_helper.c                  | 2 +-
>   target/loongarch/tcg/translate.c                   | 5 ++---
>   3 files changed, 4 insertions(+), 5 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

