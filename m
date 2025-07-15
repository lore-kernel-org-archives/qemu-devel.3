Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64912C83F2D
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Jul 2025 19:31:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ublLe-0001Om-QY; Tue, 15 Jul 2025 15:29:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1ubkq7-0000LH-B1
 for qemu-devel@nongnu.org; Tue, 15 Jul 2025 14:57:32 -0400
Received: from mail-pf1-x433.google.com ([2607:f8b0:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1ubkq5-0007MC-CO
 for qemu-devel@nongnu.org; Tue, 15 Jul 2025 14:57:19 -0400
Received: by mail-pf1-x433.google.com with SMTP id
 d2e1a72fcca58-748d982e97cso4944733b3a.1
 for <qemu-devel@nongnu.org>; Tue, 15 Jul 2025 11:57:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1752605835; x=1753210635; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=XyYH5Hl4WUronB517+OhdQBEd21THfUBEcCiQSc7GTs=;
 b=fUha/YjCSDjR6vUM2ANrgjn+8ftJP7HmJc8tWGeVeCAyuox+N5oXWuUVqxAs39J4ac
 XfSNxZh6Bkz3K/WJ6RXs6wo8DzcxOtQr3d31zmyvv+dIyO35FD4VfV0wLHHvOtly7J9S
 kYMAHwTpULWK/uZEz4vC9/xYJkf0aobgOBJUpbjWuLPEPFV1RzCh4jlYdlh+Vfh6woHo
 GU35OLm1YhCUqcML6hNH2tWlrhsosnrJGWONHv5BvzmmlqgLDoB+DHKU/FvY84PC1vpn
 E0O6/jSCZyhCyYJqPPCW6+PiWdqX8KHLl+AN6VPpJA3LktThU55UIqa42zTocrX/AqpQ
 M4Dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752605835; x=1753210635;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=XyYH5Hl4WUronB517+OhdQBEd21THfUBEcCiQSc7GTs=;
 b=f8Ko1o655dhz8bNjYtSYzM6+Rxu3Ob9M8wvKf5VIapx61uHXDMEqfPnhEtHCLr6O33
 zt6HrzgVZdMzGCFuuFz15wzpHqExNeTmZeNE7Ypa8OlhYzLWJPe6AJiG1M4mDNEsQNxa
 5XO6jEeqy/5V6IN7WoD/iKxVBa8qIQlSrzKrRicuVHMPBirYjWImxdB9JMf0wQ5BRkM8
 KXJiry0cl0myGAwl/wGfTJ7/As3770RyUIss53xn+85MbCz0R5bnNTjhg4/oTjDNaAt3
 LBzuidvKY+e59LVNqhcsbG3ovcNtUls5QztnhFQqlVWkgpMrR1hQXZhmnDjVJjKkTBEQ
 YaWQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCV05FnoAMwvIfJjGCV3g3WLzhXHPxQHELpbrff6ollzj3rVTAeGvTOUqYJTAjrtCJj8cJ/f8ZKH64QO@nongnu.org
X-Gm-Message-State: AOJu0YxCrmDuTVBdkjvNhsiWz1yeO7UjslEAVNyzPDensWM6H1aXyM7G
 TpHKHT2ksfUUdxqPUbgkOMl9CVDkR3gw1oQkrJMwC4R5jIT3sX4FuocGRs+YugnpqB4=
X-Gm-Gg: ASbGncuhMo2hVwxg3AOraYugYfZsofoAyBT8uBp1Yamjy9dKMpf34sBg0yzIekvPuAY
 BSm+scSRVeCAMx5AKosJk4VJCJ4KRMUIu4QW9AfIQa0EmDRUtYjzzyCHCQmrmIaqA7lVzg7OXKp
 dOaDNK7SF2RyAB9zwaR9Js4aDFIAU9s/syU2jbZRaGwHFBA9+bfu5oaPmTEiWFCa48J8CEy3DtM
 JpUhcq6dy/7W+dzxSviZoTksTpk7pCxUUz86QMKPoe+/j3oKTsfBoc1gB/6iW7qiAKY8/9dhkbu
 eJlDlPRGkGLwnBtjxxwVpFW7ARJTxcRqGCHJ6IXac6ObxUeDtmI6pqV+2JzxQXgbAh2XVJm+qKH
 iLI5o4wO5dC4qL3Vlb78dnP5qBtYnPfetg2Q=
X-Google-Smtp-Source: AGHT+IF51wDjS0Uu9RCAhwjoiZQ729vy16sVMhp+zTaIz+Xs4/k/jDZOWTxlVdn5mRZEuc0JA5QBzg==
X-Received: by 2002:a05:6a21:6185:b0:232:1f25:7965 with SMTP id
 adf61e73a8af0-237d5401600mr712381637.5.1752605834695; 
 Tue, 15 Jul 2025 11:57:14 -0700 (PDT)
Received: from [192.168.1.87] ([38.41.223.211])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-b3bbe52d38asm12354592a12.9.2025.07.15.11.57.13
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 15 Jul 2025 11:57:14 -0700 (PDT)
Message-ID: <98861f28-1148-4468-acea-8b199a241516@linaro.org>
Date: Tue, 15 Jul 2025 11:57:12 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH-for-10.1] system/runstate: Document
 qemu_add_vm_change_state_handler_prio* in hdr
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Zhao Liu <zhao1.liu@intel.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Xiaoyao Li <xiaoyao.li@intel.com>
References: <20250715171920.89670-1-philmd@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Content-Language: en-US
In-Reply-To: <20250715171920.89670-1-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::433;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x433.google.com
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

On 7/15/25 10:19 AM, Philippe Mathieu-Daudé wrote:
> Generally APIs to the rest of QEMU should be documented in the headers.
> Comments on individual functions or internal details are fine to live
> in the C files. Make qemu_add_vm_change_state_handler_prio[_full]()
> docstrings consistent by moving them from source to header.
> 
> Suggested-by: Xiaoyao Li <xiaoyao.li@intel.com>
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
> Based-on: <20250703173248.44995-4-philmd@linaro.org>
> ---
>   include/system/runstate.h | 30 ++++++++++++++++++++++++++++++
>   system/runstate.c         | 30 ------------------------------
>   2 files changed, 30 insertions(+), 30 deletions(-)

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>


