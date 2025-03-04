Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7E28C282D0
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Mar 2025 22:48:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tpb3g-0006c4-7J; Tue, 04 Mar 2025 17:48:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tpb3e-0006bt-97
 for qemu-devel@nongnu.org; Tue, 04 Mar 2025 17:48:14 -0500
Received: from mail-pj1-x1029.google.com ([2607:f8b0:4864:20::1029])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tpb3c-0004LD-Ok
 for qemu-devel@nongnu.org; Tue, 04 Mar 2025 17:48:14 -0500
Received: by mail-pj1-x1029.google.com with SMTP id
 98e67ed59e1d1-2fea47bcb51so12305282a91.2
 for <qemu-devel@nongnu.org>; Tue, 04 Mar 2025 14:48:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741128491; x=1741733291; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=zlZkUiEwJxxP9yr7fJ4dUGKweuRsCqVf5qbO3fA3710=;
 b=utnik92ZxGG/35aelzVSkg7Kfuvc7MA1F9Z4VwR0tC0diDMsCtgK3qzjSgBDXuqoVB
 77h+sqUd2hwO3u60jSkYtEFj1LzHN+chnKxFoxt7kv20EMOYnRtwzMiNLNJnw0Uwhr/h
 IJV5MfUDvdHO9xpOAfACyik8j27az24VDEoshewsK8b7lipFUqUDPaliuCY4QcwVv6zU
 vz4WhWEpTXGob3o8v9Y548HqHtXQZjhDTsrBxQmYk1RIrQtKkFnaWcNXyqBZVmJ3h5Lh
 IDwdf5bW111D6fA//45L0JNyyH9BZHFvOpkrUgH5jD1Q/utKEB+ylD3HoUM+HwnbA59o
 IkLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741128491; x=1741733291;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=zlZkUiEwJxxP9yr7fJ4dUGKweuRsCqVf5qbO3fA3710=;
 b=Vfcj6bSapep1V95NqLvy9i9RD9gMzVoBuIC2+d0Q/A6q5+UXpabNk/Z5osLDrjyU7G
 LZrWJS1+i3iRrCLBjcXEd8a58XcnmLNrw6rVwhPT+TOJ/WoTi48kuQEaFyTxO8Czl74g
 JjZV0/0dH3rybrw3UaVl0v37Ht+qrk2fOMWVkKd1wYdLJyn/FcX6hqfSpeIj08gg0eMH
 92iVnEu7arfzwJ1JDXKQZplU48eZPQwoQz8lrXiew8dI2WrH1cFKdCOWZmQCjlsNm+Gw
 s6apTEWCeKEJJc5raPbLSGUi8j5cg/+60ljvw18A/M3JZ9y2vRW4f+E811awVSSj3vj1
 cRhw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXugYU50KyqxjTX4hiYLe8DpMx5s/YsyY4MHLHX8ACwSR+oRoli6xlLqQUCkw7C+TjnM/Fj8H4we71q@nongnu.org
X-Gm-Message-State: AOJu0Yyz9V0J8usa1QAv+hvHp9ms66GOwt0fQ+lzpPRGED4r9MZF3rQo
 XkfTyt2fG771KKtKa5j2IifRwmffTz8Q6bV97zSzLxLVR5Jkr+zldyQ/zbXh/V4ZmjYJuE7rwCX
 F
X-Gm-Gg: ASbGncu3GtNteLXyVaM4zisuioUrpyjfZ+sXgZR0sMuxvnEX0626ZsBy6LK0/qdUnGm
 eHDPKPXNz/qT8k0wyKGNdQG1n/JLvGeTNRi7+qkbJlQZ31vohjGT1Y5XPcbCJRtlARPnj4CZuhb
 sw0UfZJHAnjAztVoQ0uUrdswcafMTSoi9jKXzxFxT1Jz9ijgIiYxebnZE0sh47dR/cR3vhRwoYm
 IAJPkndKck5ebdBK7uebOOewqk7yxafTZgqGfUr/LzcuiQKxWSxQaM9BiPDNcP+s5JU5V5+UrZJ
 y40BvsGFXps/MxYzFh8/jYxuiaHnaQU2Fd04TXaMwPYeZ+fko+1Mu8plC3j9PW1kW4PcEvudjh6
 BRK4BStkz
X-Google-Smtp-Source: AGHT+IFhCjGPHWNxT1Oox9qm0Fv42CGHqZALFBjQZXiSYRk5EQoXHIWGjIv+afZ2knN1q3Ti+r4/8Q==
X-Received: by 2002:a17:90b:2e0f:b0:2ee:c91a:acf7 with SMTP id
 98e67ed59e1d1-2ff4971748cmr1619659a91.4.1741128490794; 
 Tue, 04 Mar 2025 14:48:10 -0800 (PST)
Received: from [192.168.0.4] (174-21-74-48.tukw.qwest.net. [174.21.74.48])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2235052beaasm100869435ad.233.2025.03.04.14.48.10
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 04 Mar 2025 14:48:10 -0800 (PST)
Message-ID: <7f5fcc93-9e88-4591-a33c-9533ab8dea6e@linaro.org>
Date: Tue, 4 Mar 2025 14:48:08 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 14/32] tests/tcg: add message to _Static_assert in
 test-avx
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
References: <20250304222439.2035603-1-alex.bennee@linaro.org>
 <20250304222439.2035603-15-alex.bennee@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250304222439.2035603-15-alex.bennee@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1029;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1029.google.com
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

On 3/4/25 14:24, Alex Bennée wrote:
> In preparation for enabling clang and avoiding:
> 
>    error: '_Static_assert' with no message is a C2x extension [-Werror,-Wc2x-extensions]
> 
> let us just add the message to silence the warning.
> 
> Message-Id: <20250226140343.3907080-13-alex.bennee@linaro.org>
> Reviewed-by: Thomas Huth <thuth@redhat.com>
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> 
> ---
> v2
>    - /defined/expected/
>    - let us
> ---
>   tests/tcg/i386/test-avx.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

> 
> diff --git a/tests/tcg/i386/test-avx.c b/tests/tcg/i386/test-avx.c
> index 230e6d84b8..80fe363cfc 100644
> --- a/tests/tcg/i386/test-avx.c
> +++ b/tests/tcg/i386/test-avx.c
> @@ -244,7 +244,7 @@ v4di indexd = {0x00000002ffffffcdull, 0xfffffff500000010ull,
>                  0x0000003afffffff0ull, 0x000000000000000eull};
>   
>   v4di gather_mem[0x20];
> -_Static_assert(sizeof(gather_mem) == 1024);
> +_Static_assert(sizeof(gather_mem) == 1024, "gather_mem not expected size");
>   
>   void init_f16reg(v4di *r)
>   {


