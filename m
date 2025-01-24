Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9AC8EC02181
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jan 2025 17:07:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tbN8b-0003yC-4s; Fri, 24 Jan 2025 12:06:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tbN8I-0003jC-Vv
 for qemu-devel@nongnu.org; Fri, 24 Jan 2025 12:06:16 -0500
Received: from mail-pj1-x1030.google.com ([2607:f8b0:4864:20::1030])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tbN8F-0004oW-Vx
 for qemu-devel@nongnu.org; Fri, 24 Jan 2025 12:06:13 -0500
Received: by mail-pj1-x1030.google.com with SMTP id
 98e67ed59e1d1-2f4409fc8fdso3838581a91.1
 for <qemu-devel@nongnu.org>; Fri, 24 Jan 2025 09:06:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1737738370; x=1738343170; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=TrNfx2IQLbCv8te2qs82IcX9IkurKqGHcLiP17zLtEY=;
 b=yGAeAJwruMArXHnxrQ5SQzI56J9XHlY0/7c+4xy+OnVu09H4Zkos5agwE8g/aRm/HD
 p3AqfS/hfgoRSF8WTn4lT0TG2sjqs+HQoQhuW+KQXec5ixupTxUA7lzKGj0BR3b0qauU
 eBhGrw4QH+UVMt+M0X8TUognQmHZzxvjLM2FU0GWnxpwezD7zHMtz8dA/tLeCzI7sDhS
 rqrJ2EXQzx7dYxL5/qcEEB/tdCII8Arx4OsaOiONVYs1axS8dllckRT818b02OX3Ag4g
 uQsNgL2LMHkze+BPAndQpwF+E1dnPSdWcyEVjc3MPS+CeCJs7UPWd+KNkAja7irCEPk4
 yQcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737738370; x=1738343170;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=TrNfx2IQLbCv8te2qs82IcX9IkurKqGHcLiP17zLtEY=;
 b=Uwi7d1tUs2lclClORXTXMEseUOVo98DmksgH+EeDL15audZFCsXUQzrN0wjfnHVvQK
 GXJnxu93gFX4aAnlvGnarYwJOt00tD6Or9jNConHylIp6gRtRIJlvwZgiYxgKCFqpHTA
 FxT6a+n+Y02QBTQ2O+hefaYWQwtnAQehtCpU1HaQ6b9/FvcoiRrrJudYHl2sudzxYtKn
 pLfY4Kc6kMYL8vcXjOgsLUbNpCgkWqZ3nC24ZKj+b4j3ThMc8ZB7GFpRupKirm1xE+n8
 10eAO9vyz22vXrbEqXiNTg0+7fiGpCWKdZGSxlnv65Bs+HiZ5DpfrrwXPjUqnpY4q4ZZ
 R+zA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWd0vRcZheiAJgFLA/KEVpSiHYJKnfpNQ2e6Z/5cVLQ6kBHfbWAH/OinZfGqbFtsyB3Rwt9ISYSlM2C@nongnu.org
X-Gm-Message-State: AOJu0YxxVAbwPQvlS7umGTsN8hYC48mgifpQSbVyZY98UM88pQLA0myF
 TwyLEiYL35Rk/8BoKYdQ7WirwiDh4mabVXLJ7kvWhyVbDZSibkjBVkWmRGNfwumOhOD/FZ5yUHW
 E
X-Gm-Gg: ASbGncvMdwzSfugzs6OryhgH5FMAOjG8srbULI/3ITaI7USGJSbzw2agYFRY477+BhD
 N00Y9VUJNM6UCV41lDHRaXCjWeASz+e4zPiKYWIMVghsAlaStyeNe9AUGM7gVg191uwQIehtRvt
 rsYVjltQ8rK/4LWBSE9t/ZL9KLErDpKO7YnQpwVEDKHbCY/IDOO9HpW82I6pU3uuXYJm6AnOCYj
 3pWfg0ASHlyLgZVBe2BldHMuhOeLd0BT/4Q/wSiZwQn+h5fHvAi0086YfKEo78AHXv9tvSJAMWl
 xQMUneIqYuaIlnqU2Sn81Ngo
X-Google-Smtp-Source: AGHT+IG5LgDdTFqhvy9653F/gzEQg3yZsG+nvhDh0F9tVkY2PaJoUPkS96T7jCGIHQGU5xUqK9fDdw==
X-Received: by 2002:a17:90b:2b8c:b0:2f5:63a:44f8 with SMTP id
 98e67ed59e1d1-2f7ff2beae0mr7103688a91.8.1737738370636; 
 Fri, 24 Jan 2025 09:06:10 -0800 (PST)
Received: from [192.168.163.227] ([75.147.178.105])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2f7ffa8318asm1971992a91.47.2025.01.24.09.06.09
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 24 Jan 2025 09:06:10 -0800 (PST)
Message-ID: <b2a7f8e9-7571-432f-9cde-ec549217fcbb@linaro.org>
Date: Fri, 24 Jan 2025 09:06:08 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 08/28] target/alpha: Move has_work() from CPUClass to
 SysemuCPUOps
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, qemu-s390x@nongnu.org, qemu-riscv@nongnu.org,
 qemu-ppc@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>
References: <20250121142341.17001-1-philmd@linaro.org>
 <20250121142341.17001-9-philmd@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250121142341.17001-9-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1030;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1030.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On 1/21/25 06:23, Philippe Mathieu-Daudé wrote:
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   target/alpha/cpu.c | 4 +++-
>   1 file changed, 3 insertions(+), 1 deletion(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

