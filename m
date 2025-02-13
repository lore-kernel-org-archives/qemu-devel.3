Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 510E0C021A4
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Feb 2025 17:05:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ticeN-0004D2-Up; Thu, 13 Feb 2025 12:05:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1ticeK-0004CQ-Ku
 for qemu-devel@nongnu.org; Thu, 13 Feb 2025 12:05:18 -0500
Received: from mail-pj1-x102a.google.com ([2607:f8b0:4864:20::102a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1ticeH-0007QJ-6y
 for qemu-devel@nongnu.org; Thu, 13 Feb 2025 12:05:15 -0500
Received: by mail-pj1-x102a.google.com with SMTP id
 98e67ed59e1d1-2fc291f7ddbso244837a91.1
 for <qemu-devel@nongnu.org>; Thu, 13 Feb 2025 09:05:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1739466311; x=1740071111; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=iNAUmZMKt2sgYSzjzTShTuref5DInHOJIFw2EGGg9ZI=;
 b=Ix4bPK8SyaMoijvAXfAtONE1gSi5TvYYKctmx6L3/k3vRj7OXVQQR72cxnypRHVS9h
 cRsx+Ul2NuPft0YVyJKs5W8CWNTP4mQCLqwgbas0ARzy8Vj2pahewVa7WkbnKKE7SVgJ
 6vLVsxfR7Rwm7LmQkiH0f49+HwJ6ndwj9WAMwv6SjzrSLor2/C260+KSc7KTevHrDI9I
 OhJ30ls+aF9SaVWmHt0LFri3w9Ve3Jhw3a4Qxnc4OQLQN783Q4CXu3lv9+ART1bRuJ/l
 UIXWwqFK3AO4GHMe3oN/dNaU8x1EFHeTVI3xERXRQF6mEuSFAmc3qMjppPJsiJDqmqiE
 ZuXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739466311; x=1740071111;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=iNAUmZMKt2sgYSzjzTShTuref5DInHOJIFw2EGGg9ZI=;
 b=dbWtXdiztjorX9gIMs0/vFbUfLKipS7AZGUvhk5VXhw2Gsba84MXjo7IgWTr+qoXN4
 J1TBHzdx5TuBb6exuMmTi5SyOiFJDVsi19oCyEqrIKPG055+FHFVPMXZWr/jp7f8bgQm
 PRcOwxnKdZNTb0+CSzlqEekjLCj1aLDa4OZkiQ3HCAN0UmEODLDXqNkdihVt+qZ5Vm1M
 zWVfccaJ8Vihe+uo3GIScRQSd+tBJAAQbE7ir1xwqIRVr0tg2BIgmB6FAF+rtK80F+tv
 j8nwJGX5ZuOnEj1rwtsZFqPW6N5BZ/ogpw3nCbMJQZIqNp00dcJSqtjp0Xdb3aZivRk+
 xcMQ==
X-Gm-Message-State: AOJu0YwB10fBnmjqpGWqzgdMiFYP3foPmCTfbwYyeiLpqp2hIiwT8zwY
 mGQQWyRHvnwpsv0B9L3CdZ6IgxKcBZanAtRF5183ObWKVc9KW6GRFW0fgbpl3FNd/AxZ+pZZM5l
 q
X-Gm-Gg: ASbGncv2g1bNxuSRWz6nVjm3GhQdM/XEB+Nly0XEThSjdFfjQHW60/BCsxIFWuqzldU
 ZxW6Ki7NSInCw3v+LR2ZP8aqurVZ7pJV8HT6/CLh8l6wKJuEoS5lCjlO7YmRpiyTTOB1r2s774B
 FiVv/XW6Pf3H8SZICwevyjzOOrzkeoaFOa+ImXnKXqsSXJZmhGNzygIcEGIwcEvpHpkwS8BEy26
 mSHPDu44ejKxUHi3VgSG32DUv/Eh+1BNvAT0bUoFEILwZFgzL7Nc4j7j09kJPRPCro5yIxOEmF/
 Q/vG3JuRfpdCpHaMCreC4iTs/XVugEuqQNyJNlZCKR7cr/woYX2nPG4=
X-Google-Smtp-Source: AGHT+IF8kkWr5W8df2PlWhkpXGb6gNtPZgvp2siqnkqrXhO6zYhTMcYVdItJfWLTyswPCIqGCx+pfg==
X-Received: by 2002:a17:90b:17c1:b0:2ee:4513:f1d1 with SMTP id
 98e67ed59e1d1-2fc0f0b07afmr4252029a91.23.1739466310959; 
 Thu, 13 Feb 2025 09:05:10 -0800 (PST)
Received: from [192.168.0.4] (71-212-39-66.tukw.qwest.net. [71.212.39.66])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2fc13abfd17sm1491475a91.11.2025.02.13.09.05.10
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 13 Feb 2025 09:05:10 -0800 (PST)
Message-ID: <aba9b44a-6d01-4417-be2c-d58db1445ffc@linaro.org>
Date: Thu, 13 Feb 2025 09:05:09 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 1/6] hw/qdev-properties-system: Introduce EndianMode
 QAPI enum
To: qemu-devel@nongnu.org
References: <20250213122217.62654-1-philmd@linaro.org>
 <20250213122217.62654-2-philmd@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250213122217.62654-2-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102a;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x102a.google.com
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

On 2/13/25 04:22, Philippe Mathieu-Daudé wrote:
> Introduce the EndianMode type and the DEFINE_PROP_ENDIAN() macros.
> Endianness can be BIG, LITTLE or unspecified (default).
> 
> Reviewed-by: Thomas Huth<thuth@redhat.com>
> Acked-by: Markus Armbruster<armbru@redhat.com>
> Signed-off-by: Philippe Mathieu-Daudé<philmd@linaro.org>
> ---
>   qapi/common.json                    | 14 ++++++++++++++
>   include/hw/qdev-properties-system.h |  7 +++++++
>   hw/core/qdev-properties-system.c    | 11 +++++++++++
>   3 files changed, 32 insertions(+)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

