Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32505C0219B
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Feb 2025 16:32:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1thWhi-0001H2-9k; Mon, 10 Feb 2025 11:32:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1thWhU-00011h-EC
 for qemu-devel@nongnu.org; Mon, 10 Feb 2025 11:32:02 -0500
Received: from mail-pl1-x62b.google.com ([2607:f8b0:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1thWhS-0004Mm-RS
 for qemu-devel@nongnu.org; Mon, 10 Feb 2025 11:32:00 -0500
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-21f55fbb72bso52591675ad.2
 for <qemu-devel@nongnu.org>; Mon, 10 Feb 2025 08:31:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1739205117; x=1739809917; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=12CbQEpCPianDbSiaHuldNx/DpianNvUPrkbzazwvQw=;
 b=Tj3nbTY7JQtiUiZ2cUuqk9Ms9QEPU/y6BtA3GLVJ2BdaKq2pbQ7rEKG3TlzBi0HrpI
 VLZbZJHYPJG65rQivjG19nqUnWwCztqWuF619eBhyi4SckrXihMf/VsWk9Wg8TxC9Fro
 KTxGsKYHSEnnF0MONnhTC4ZoAb2U57I5a+VP69dDfLEid5D7xRALmVjxtP0M0054ThGm
 2K1muptndXwfVOWYWjWa3W35Fc3sC8NhrK6c0p9rCEuWnyB+/M3DnnhZPniPlRn2fhVD
 tfUcuMz3hSDiG+JQeXFEDUsud3xnVizrF9cd07xePs8TdeJjz2ZGVlZkJUjq8/hMzTyA
 P/pQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739205117; x=1739809917;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=12CbQEpCPianDbSiaHuldNx/DpianNvUPrkbzazwvQw=;
 b=o8VXSw31cfX+6PFWYb8tIg3X7E1Dus8wigfP5Z2lM6X3ijcN8d0Mf6YxWRGeepkof7
 yik5ODzGj8ColOL+SXaRbgdTSCZ7rXjTGtRDPj3+6lsM+hpjMZpvg8MOZJymZjG34oQ4
 FH/l3zwquJj5tWvHxMFnGR7sw9QoZgSyXmNdu6x5T1nvlrM00SGuFTBaZXQfwSP0jJmk
 pxLGVNF4etbZZslzalQlMRlzx1SgR8fUvtyBQV/HkykBKsgMFhqIBjTasB1mJfeJf22h
 A08FBfiKbfaS/p0mOvOjcgK6oNfwBD8sPw7CnXqfkjKdSZj8bfS4w2gtKK50O8YbLhjb
 QnwA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXpBNnKdacGIfMV9FQnpx3L1cjkCdfkUssgbpTRNbBJGgajSzbJ01C758PFkAl5MLKfvDHKcQMqQb3Y@nongnu.org
X-Gm-Message-State: AOJu0YwoCYN+js0Fb6oEp8DhwUAkZ4qb+mmT2cCho0QvjUFaLh4RbWLy
 TdixBa5IGk0fPcKdvlsTWhtD1TAoBqZcO0+XjC97yNlYLc/HjO7BjP64j7JelPk=
X-Gm-Gg: ASbGnctKsQZzIsQXCAWqIR9cdWbFebK1tm9yVTpZoeFZFuKXTDa8iGiHYwAcgZAm/rQ
 kfnoawByzT5nvVv6H0HarIfyeXZx04BV3R1wFIQqe/WlTH+CDoO6al6i7SghLnMN7e4R8qo2sZd
 +/mMIvXADoE+G9YfisHDrczGXu7biZ4hEqIrgPxjGGhOxhp+BxiElVgqfYDkrdA5CbA7SV4G6Pd
 exnjnyNo478ypoq+xroimnLmhWiV4WZf1bD8SgnZKFZkfPAKdqahUCOtcA+34NSyRTciIjOtByT
 3CHlTWw0/ERjivFt+qwF1htw9dm6du85j1dAHCm/bvC4c2rchm1UsFk=
X-Google-Smtp-Source: AGHT+IFFWEftsfkSdGjm+736gE4C1ddxbd+4hzUX1a43y14NKfYMJPtTzdUq7+eghSsTvUWTvpr7nw==
X-Received: by 2002:a17:902:f54d:b0:21f:3a7b:f4f1 with SMTP id
 d9443c01a7336-21f4e73af02mr230206585ad.32.1739205117043; 
 Mon, 10 Feb 2025 08:31:57 -0800 (PST)
Received: from [192.168.0.4] (71-212-39-66.tukw.qwest.net. [71.212.39.66])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-21f3683d8d3sm80112585ad.156.2025.02.10.08.31.56
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 10 Feb 2025 08:31:56 -0800 (PST)
Message-ID: <3bc0e1a1-3587-44db-9802-8d80381339b9@linaro.org>
Date: Mon, 10 Feb 2025 08:31:55 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 04/11] target/riscv: Declare
 RISCVCPUClass::misa_mxl_max as RISCVMXL
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-riscv@nongnu.org
References: <20250210133134.90879-1-philmd@linaro.org>
 <20250210133134.90879-5-philmd@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250210133134.90879-5-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62b;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62b.google.com
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

On 2/10/25 05:31, Philippe Mathieu-Daudé wrote:
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
> Cc: qemu-riscv@nongnu.org
> ---
>   target/riscv/cpu.h | 2 +-
>   target/riscv/cpu.c | 2 +-
>   2 files changed, 2 insertions(+), 2 deletions(-)


Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

