Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38067C71157
	for <qemu-devel@archiver.kernel.org>; Sun, 22 Jun 2025 00:24:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uT8V8-0001Od-J6; Sat, 21 Jun 2025 20:24:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uT8V7-0001OC-CB
 for qemu-devel@nongnu.org; Sat, 21 Jun 2025 20:24:01 -0400
Received: from mail-pj1-x102c.google.com ([2607:f8b0:4864:20::102c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uT8V5-0003cZ-RE
 for qemu-devel@nongnu.org; Sat, 21 Jun 2025 20:24:01 -0400
Received: by mail-pj1-x102c.google.com with SMTP id
 98e67ed59e1d1-313154270bbso3296129a91.2
 for <qemu-devel@nongnu.org>; Sat, 21 Jun 2025 17:23:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1750551838; x=1751156638; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=pI39NXHiuWRF47W1/azFVblK2OxV8m+ynVzNZcEnhP4=;
 b=FEKJOcEJOHpUT4Ky2Tp1xgo4FpCGivsr3JQ6aHndZ5j4zeXW4NPiTrucS7q7x5xJMW
 Bgg4q5treRKVLWXQWJg3JIhf6zEq9ylvhEzMfU9yUVnu0JtMwJRVpxVgUBmkh8CaAoI7
 Gr22DeUEt14QkJvdYdVdCAuNHSUY77eto3VeyGcj7Qco1nTAcRsWqwaqFRZV+wVP/IME
 Mj8ekPqZ1M1ezZFYjFTRNOKOWUP20qM+r0GAc7h25UVNa658ts2IXH8yHBLmI4OkG0cO
 TzGNKBnLyZPLnXajEnQnebGU4aGyTR8qdHN9m6SFdpTJ12111Rlvf/0Eo5L7+aapqz1x
 mJww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750551838; x=1751156638;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=pI39NXHiuWRF47W1/azFVblK2OxV8m+ynVzNZcEnhP4=;
 b=g43FPHuwoDtONEfkHErHTSf8NHjswtloQ8Uesy4H/ID8CWITlZ5yhohbnIB903g2lW
 wRHSbKim2dGINTpL4gSINoDNATzOVbLLNUd9KYGgthykpjA+1P6zX0T0tob2+8HPVQyU
 eDNHXUZgc7qEyOicLWRWFFGyhHYXCtTS6tply/BMsu3DDInlDY1HiMldWxXpZE+VVdmW
 WRsUNJUU8HDiI9HMKE3v+xbKgVOquJWldrEgPGJDOUv7AS7l851PQJNbQVR3nHBwOoUk
 NEZhFyy8wMWGaRDdprV/7F1+gZFqEtE9YS9M8Pb7XfoLuH2qvcwP0R4nVFI9sLSBN48a
 QMVw==
X-Forwarded-Encrypted: i=1;
 AJvYcCX27CSc1FZdvuVsRrrnL3zSZidWmIcRuUVfoKTzwIkLyUDgS4qoVrVKZ3dujeP1a2Vso5cR4vWICGze@nongnu.org
X-Gm-Message-State: AOJu0Ywhh628jX1f/L+PeMNLuEgwk2BdhbwqI/PCb/ZiqWKfsbInApEa
 hGScRjsLQC9m20LH8oS/sZAOlUjfLfHydJOTJnM3atv2C4JVmBH815B8S88uyasq7YI=
X-Gm-Gg: ASbGnctEjUssr2M9ag2hFeou/b7PULTj/Eq00vMNeOEy4ylgqi/9IreDapwZSW6Z4KM
 8yxPKP6ZW3XZ4YYZhJFbp+T4EAAHrMfBVqEl6PUkfFdLE0hLG46vgz8JypxCzYRkIS185saPCef
 R+Sk883WSPEFB7/FnCNN/WPvvxf2OYubT9SlS2o5dX3TOQliMqkUwtZ5FzDJe53MjS6Brzqtzx3
 /a6x97bkOlzMxk+3+BX5Xrb/eUH6HmuSCNH1UDWmcUCc9ZRN8QTpNEMoCratBIVuifGTNpqSbED
 7QkQaB0rQ9IDhspTb5h/dxY3eI/6e95qa+KBkRZokeLfRuwI18pkhrDVcdZUTbFptRHBJkFTTdg
 kSqix4M9FVLr3rxL0WHUUKbY+5J1N
X-Google-Smtp-Source: AGHT+IE/Yv8kGTskynH79VYSdfOmePXu9GeWcA3RqpjgKC9ZfFnjLLB3sFefb9uFGzz+bjTSfdg+Tw==
X-Received: by 2002:a17:90b:3f87:b0:312:25dd:1c99 with SMTP id
 98e67ed59e1d1-3159d8c5c7amr11098625a91.19.1750551837891; 
 Sat, 21 Jun 2025 17:23:57 -0700 (PDT)
Received: from [192.168.0.4] (174-21-67-243.tukw.qwest.net. [174.21.67.243])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3159df812bdsm5230602a91.12.2025.06.21.17.23.57
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 21 Jun 2025 17:23:57 -0700 (PDT)
Message-ID: <6bece6a7-2422-49c4-937d-77c706291d66@linaro.org>
Date: Sat, 21 Jun 2025 17:23:56 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 15/26] accel: Introduce
 AccelOpsClass::cpu_target_realize() hook
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
References: <20250620130709.31073-1-philmd@linaro.org>
 <20250620130709.31073-16-philmd@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250620130709.31073-16-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102c;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x102c.google.com
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

On 6/20/25 06:06, Philippe Mathieu-Daudé wrote:
> Allow accelerators to set vCPU properties before its realization.
> 
> Signed-off-by: Philippe Mathieu-Daudé<philmd@linaro.org>
> ---
>   include/system/accel-ops.h | 1 +
>   accel/accel-common.c       | 3 +++
>   2 files changed, 4 insertions(+)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

