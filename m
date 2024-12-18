Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 567E5E77187
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Dec 2024 16:43:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tNx8X-0001M6-0F; Wed, 18 Dec 2024 11:43:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tNx8P-0001Hv-KC
 for qemu-devel@nongnu.org; Wed, 18 Dec 2024 11:42:54 -0500
Received: from mail-lf1-x12a.google.com ([2a00:1450:4864:20::12a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tNx8N-0005Hc-3S
 for qemu-devel@nongnu.org; Wed, 18 Dec 2024 11:42:53 -0500
Received: by mail-lf1-x12a.google.com with SMTP id
 2adb3069b0e04-5401c68b89eso1170804e87.0
 for <qemu-devel@nongnu.org>; Wed, 18 Dec 2024 08:42:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734540169; x=1735144969; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=skTa914Q1FD23NZE+r74upL7gYLo7AYB0M7NL/RbDOs=;
 b=ss5JyFqavMFyhA7WqQCPDIlBO7R5QeTKwm7A1TbfwEzYMW+YqNmcDCf3IG13g0FMEG
 I+QPnYVZm1WEqR7EwbqTrPbwFUg0MSB0bJSyn3xJCzK975HBcizZ/2XAArMPXMNBlAU2
 cHAQoDvUMIods6YGpZbssg3gRFkOiH8VxvBrSwssd0IT7ERCkhMrA/DNidXznzXVMkM2
 JfzbXMNCnsFPORZZhVsVQyX2Icc56ZU6G5X5v9/MPo48ztCSyYwS4DIV48fJe6+Qsb5l
 V+ootHUQpE/axonFj/F27BFm4yUwxVwMB4Vl5iJj7jtWDRao8IuHsM4ulZfwJ+Ol6wk2
 V6KQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734540169; x=1735144969;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=skTa914Q1FD23NZE+r74upL7gYLo7AYB0M7NL/RbDOs=;
 b=i7TT0C2/xJrVga0cVnh1MpfiKdcQp9WMiRiBSjHykeZ9mvPttSLxBZAdbxm8LNH3zu
 qAzng+x/r7Zo50a3h6BjgVMENQsGOwvNyEwGOr3idxIyCNrp8ipsLB71C45+T80+OwRL
 cT/hBYTJHV5QbNMaoSXzJegzR1irTsTPPyc9NvRxL4iDnmzNFU4fni7ISCEefsaevr91
 Bvp4L4L226j3gKvVZh9PRqcE/HQzKpYomYVqCpXSI2wuawOFDVWYczQwd9wVe9XOTzk6
 rogA+Gq1mnZ1/Wtn3VR8t4nYGY+qC4BdhaVaTsWv2m4J1IXX15iOMApC6c0yDmwnwzk5
 j9yg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWczKLy+HI1TJJadvw8ZI0vMSrNMRrlhnT37eN7BV2OSI0H82ss91fEoVSbaFfj+aok8qsoOfX7Kpdo@nongnu.org
X-Gm-Message-State: AOJu0YyrnVs5jr7NbSaOUvPd86FGi9SAAdgDtTpf22ujLv9mjHjpAq6X
 TIJ3qWOkVQu5LVLEa3GY5R4KB0nl1h8TpqkCqZV4GNzCnNpJZXQz/8vJ26HGFfM=
X-Gm-Gg: ASbGncukeGnTugOpKmr3p28n7niIvZLEWwX7+ulVjB6s8CAT8rXXIMksFzncTlaonhp
 SpadAKu+b5UsGDKZZbOtqOVXaoO3IaTfOttqO49Azx18AseM8ukscRRiCX73zLADa7w0Pe89iUQ
 6f9BNVdHx8UxxawJ37Gkp6tbVqF6agufkLo6BiBhkVHNajWjX/QMjZQVuJe4Sa19RKuJ4IlD4J6
 RjRlQZov08N8fRFYJHbgCEgXtDG88YGQUiyv24v+4xrK39N3qzHE0YxY5JC4oXtwE175x8S2cc=
X-Google-Smtp-Source: AGHT+IERo5ziguBlPsfKbIHRz6R6u/oBGoHY+CzW3uNugO+Qy3vUnE0pcCcrA3QYDWdtb7TKK2eBjw==
X-Received: by 2002:a05:6512:3ca7:b0:540:3550:b0ef with SMTP id
 2adb3069b0e04-5421b6bc1d7mr1076729e87.11.1734540169065; 
 Wed, 18 Dec 2024 08:42:49 -0800 (PST)
Received: from [192.168.242.227] ([91.209.212.65])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-54120c0019esm1499268e87.141.2024.12.18.08.42.44
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 18 Dec 2024 08:42:47 -0800 (PST)
Message-ID: <68eba002-1dc8-40f3-b1c7-72a6ad930a63@linaro.org>
Date: Wed, 18 Dec 2024 10:42:41 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/4] include: Header cleanups around "cpu.h"
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-ppc@nongnu.org
References: <20241218155202.71931-1-philmd@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20241218155202.71931-1-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::12a;
 envelope-from=richard.henderson@linaro.org; helo=mail-lf1-x12a.google.com
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

On 12/18/24 09:51, Philippe Mathieu-Daudé wrote:
> Philippe Mathieu-Daudé (4):
>    target/ppc: Include missing headers in mmu-hash[32,64].h
>    tcg/tci: Include missing 'disas/dis-asm.h' header
>    exec/ram_addr: Include missing 'exec/hwaddr.h' and 'exec/cpu-common.h'
>    exec/cpu-all: Include 'cpu.h' earlier so MMU_USER_IDX is always
>      defined

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

Though, frankly these are hard to review in isolation.


r~

