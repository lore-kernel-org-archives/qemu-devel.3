Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B989FC87FD2
	for <qemu-devel@archiver.kernel.org>; Thu, 31 Jul 2025 23:24:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uhccv-00039O-KV; Thu, 31 Jul 2025 19:23:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uhccp-000362-PQ
 for qemu-devel@nongnu.org; Thu, 31 Jul 2025 19:23:52 -0400
Received: from mail-pf1-x433.google.com ([2607:f8b0:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uhcco-0008T8-2b
 for qemu-devel@nongnu.org; Thu, 31 Jul 2025 19:23:51 -0400
Received: by mail-pf1-x433.google.com with SMTP id
 d2e1a72fcca58-76bde897110so20645b3a.3
 for <qemu-devel@nongnu.org>; Thu, 31 Jul 2025 16:23:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1754004228; x=1754609028; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=IOUFVW0Mt2hN6k7UYKA+Jg/uSapVQRARuDkpfsHoiME=;
 b=VXMhmK5KmDLz2CmsgqVKbhbo2LtTSHEY+iPaYGjP7J/nTpBFSqbuRgZIiFXfMez7b0
 PRs5YYVdg6WYh8qDYRrEmc4NanfLqSZklE4324nlh6lRgCMr+9D/dnjL0g5ZGa1ivlDF
 A8Z3Dhuoc9gFb3u79oFSb8BJjFDLbAJ0FxpDmwFT4rz1Yib1LunPKl2hXKJhOXKZsIq2
 WgnIlwAH76nFoSq+OQ03sHpaDNpmuJfWURJrjve9D7iI3w0Lrf0kTQkSbu7Vd2m+eKqw
 PG83Oz5GRI6BqybgpQ1IggB3ufGqnenVKkbvxC+u4PTSsOlpHmU3Lr3RM2xdJN/yQAQl
 73uQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754004228; x=1754609028;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=IOUFVW0Mt2hN6k7UYKA+Jg/uSapVQRARuDkpfsHoiME=;
 b=a576CLJPvEFo4zROgIuV/V/PZ6Txn1LxvkvpAUB9VnyLJRmkp7O1hvxF6LSuT2j104
 3Bty26HlZ8HTZYM7/GLeLsdFGB6RmUQU5cSHVVjdxSC2/8JQ7pvI/4PHpKf5sSnnl7hU
 glLYQaz6jYzM1ejv9FAkDevvO2Qm0KScQmrBizek56al8RO/OMHG4Pzm5geulqbMpTWo
 MiBo3CJ3O8gfUCUfRPUJqr5t1y5La8eoMhhZgHThr7BthsaBQenOIir05n5zPRRcPCRm
 /DNHfCQ26F9mv56VwlfI00TTusi00+FR4QRHiuLjfLgiaALLuhvz9wGCn9KYK3WYOvsa
 cZrA==
X-Forwarded-Encrypted: i=1;
 AJvYcCW/unWo9GXJjmX+HGCBbtMQVrigmEKOW1CQ/7KU4A6DA5qXReHYYWyNER+nJ8DAyyGk0WT5Pt+AwOft@nongnu.org
X-Gm-Message-State: AOJu0YxxyCn/iIxCTus7b+8bU7mfwBOrWhccwW9HSWXEHsjwSElz0yYs
 9V2c17LxoIbRudYvigInD8q+KjM6vor2F/BM14SD/HJIFywGenZEH0rx7YwuMMqZuhA=
X-Gm-Gg: ASbGncuhIDlGya/87gnxZsJNwDiD84xPjLAYDdwmW7DUcAaHTuaAdxyqFvZO/ui1lOS
 FgErEwOb4eaWkErBqC2TjyrT9GeGDIiqzlosyLcYMHyR12c8hze8SJcKycZoU9idhZ5s31SgjSC
 IIlaQfjX2pJ+KYHOh/5OUy4Za2FVNI+KsscYMQRd/1WHurhVJmBRaNq1XfXEAoS/mjfC9OacMsx
 r/N8oTXQ7+nYsPOPkeIIRk+Bln/mH5in717PGDTGcYwFBYApvXwkraAsoKWudW/ptUkRd+OIEnP
 t3QyxgFxCkJvhw1vASnvOKS4LXgbc3UsSYxrgllhGx9/r8Euf164GOGNjHQ2ZcE46sfWFat6+rt
 YiG+FJDHpebHpRSvVuBRohAUwqN7yCudjvtzt05iJ
X-Google-Smtp-Source: AGHT+IF9JR0Dx+MVKegSbjD7dfxBP32qQb/zF0vijOj2VXBMtsiBygQzHZiGymoH3+XSJkpTG+D2SQ==
X-Received: by 2002:a05:6a00:139d:b0:76b:ce90:f6cd with SMTP id
 d2e1a72fcca58-76bce90fd72mr4611177b3a.6.1754004227941; 
 Thu, 31 Jul 2025 16:23:47 -0700 (PDT)
Received: from [192.168.4.112] ([180.233.125.160])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-76bccfbce15sm2592678b3a.64.2025.07.31.16.23.43
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 31 Jul 2025 16:23:47 -0700 (PDT)
Message-ID: <18591023-453d-45f1-9b06-f1e5cdc3113b@linaro.org>
Date: Fri, 1 Aug 2025 09:23:39 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 04/10] target/{arm,riscv}/common-semi-target: eradicate
 target_ulong
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-devel@nongnu.org
Cc: Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Weiwei Li <liwei1518@gmail.com>, philmd@linaro.org,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, qemu-riscv@nongnu.org,
 Alistair Francis <alistair.francis@wdc.com>
References: <20250730220621.1142496-1-pierrick.bouvier@linaro.org>
 <20250730220621.1142496-5-pierrick.bouvier@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20250730220621.1142496-5-pierrick.bouvier@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::433;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x433.google.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On 7/31/25 08:06, Pierrick Bouvier wrote:
> We replace mechanically with uint64_t.
> There is no semantic change, and allows us to extract a proper API from
> this set of functions.
> 
> Signed-off-by: Pierrick Bouvier<pierrick.bouvier@linaro.org>
> ---
>   target/arm/common-semi-target.h   | 6 +++---
>   target/riscv/common-semi-target.h | 6 +++---
>   2 files changed, 6 insertions(+), 6 deletions(-)


Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

