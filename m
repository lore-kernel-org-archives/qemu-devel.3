Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67CACE77188
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jan 2025 21:40:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tUupe-00068c-43; Mon, 06 Jan 2025 16:40:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tUupc-00067v-OC
 for qemu-devel@nongnu.org; Mon, 06 Jan 2025 16:40:16 -0500
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tUupb-0004v3-8X
 for qemu-devel@nongnu.org; Mon, 06 Jan 2025 16:40:16 -0500
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-436281c8a38so106478725e9.3
 for <qemu-devel@nongnu.org>; Mon, 06 Jan 2025 13:40:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1736199613; x=1736804413; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=X78H0/zkL7WtPPkwStiSHJcCAdAGrfnnir2GudGvhEk=;
 b=hclRg5TpyyqtDyYA2vnRQVhi5hrKWm5yU48/83jTA3r6QSWpniHPH2OO6eJC1mv1gt
 Xp5/H+ZD9cOQf/ansN4/PmtksLxHqkxJj/ZL/Xmb9awjit1tCL+nHFANpcMekmSHTNXS
 p4rTYfAVL0G1uzL+K8XuVDaE2WOsuwQzSjiDxvVwJ7as0itCCzvq5JtRbz7bvi+c9xAi
 IFTLrqobXzeFfn0JOMzXhMmekRxfjVmnJXaCdaclPDFOyb1PYV7Q4Lz/uTtFJkr7XuMl
 7PsuI8549GMyqgnD8aUroKXWzckLZaSrFFZF+qaaMewnoKBunUe/r/nC7LLT/ueb68d0
 y3sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736199613; x=1736804413;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=X78H0/zkL7WtPPkwStiSHJcCAdAGrfnnir2GudGvhEk=;
 b=R0ire8Tq7EoL0HPj9+Z/vG2EE94UKxVIciFLmLfDzqo5fMVAuI0TYsO4zOYcT4LyiE
 tUUkHTpBcoXjAjBokti0S+sL6mZSk6og+6B5o8LDGRO0V3Q6NLKP7vDAsUhKOlKBhvIj
 VyxsvtJIzvG8FW6jueN7IzFxSodKnmcp3yiIEd+mFif4NkpyjEP7XM+hyIEfrpkJl5kL
 NcqbDkth+pnimFQ6970XLsh0rSYwmKXUByXdv6fvnmXsll2AA820Xdr/DOEAtpCjYKds
 LWUTqAiaqe8UQtyHqheUF7bqhsFlQJWZ6XludYXGtQCD3uk8ZWtuaFm5VvE7wFWQcn+y
 mCBg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUfpprYorzxYx2TNUiwS71HyfA/VZb/ibFqhCG0z0jX4nUs+XLNbx6/1O115mcNvYv9O0S0sWzXvWdJ@nongnu.org
X-Gm-Message-State: AOJu0Yxet2NmdHK3XCpwWsXHZ/s71RXb9BaFncOg/KrpKfGUExbHDsr0
 mdux/uyWWY3X/v9PlgtE0oFYanQwbFCHvnI9sMwvWbAwzrz8r8zsLqw/oOlP1ck=
X-Gm-Gg: ASbGncv0dpE7C3xGwNdQDJnPoDaRmW9ynQGLwsXkZdcccFu0carKYOcAFDBppcv2G7b
 xNjuwxS79Niy5qpfOjX4UvvW/zNmJkQo2di1uRRHizCmBxi4tlODne7bn9BmSBg6B8zFdWnjIBm
 PQKmkfYfJhC9a3CHhWg20pVMd1lvuUtKQEv8yS5XY0UnZbk5EdLQJaI3lMzuHWrb7snQX0C54kH
 LHS4zWfeoRp34TxI37qfXC59uzdZ0tGqC4mvffwWSa4HlOTlBJFdyT65Hjjuvcp5VpJY8sISqKp
 rrgo2GAgH2SdH8SQX7f1ETLq
X-Google-Smtp-Source: AGHT+IGJsdb2RqxFpPtxiPzHHH8jy2r4XL50sTi0eVrVIurxxYtuOb7wGnel354s7xdkkb1jaCEskQ==
X-Received: by 2002:a05:600c:3150:b0:434:9fac:b158 with SMTP id
 5b1f17b1804b1-4366854718emr393021975e9.1.1736199613518; 
 Mon, 06 Jan 2025 13:40:13 -0800 (PST)
Received: from [192.168.69.132] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4366128a62asm574320705e9.44.2025.01.06.13.40.12
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 06 Jan 2025 13:40:13 -0800 (PST)
Message-ID: <64793b6a-8d85-4c1e-909a-6fc328ae913c@linaro.org>
Date: Mon, 6 Jan 2025 22:40:12 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 20/73] tcg: Split out tcg-target-mo.h
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20250102180654.1420056-1-richard.henderson@linaro.org>
 <20250102180654.1420056-21-richard.henderson@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250102180654.1420056-21-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32f.google.com
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

On 2/1/25 19:06, Richard Henderson wrote:
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   accel/tcg/internal-target.h     |  1 +
>   tcg/aarch64/tcg-target-mo.h     | 12 ++++++++++++
>   tcg/aarch64/tcg-target.h        |  2 --
>   tcg/arm/tcg-target-mo.h         | 13 +++++++++++++
>   tcg/arm/tcg-target.h            |  2 --
>   tcg/i386/tcg-target-mo.h        | 19 +++++++++++++++++++
>   tcg/i386/tcg-target.h           | 11 -----------
>   tcg/loongarch64/tcg-target-mo.h | 12 ++++++++++++
>   tcg/loongarch64/tcg-target.h    |  2 --
>   tcg/mips/tcg-target-mo.h        | 13 +++++++++++++
>   tcg/mips/tcg-target.h           |  2 --
>   tcg/ppc/tcg-target-mo.h         | 12 ++++++++++++
>   tcg/ppc/tcg-target.h            |  2 --
>   tcg/riscv/tcg-target-mo.h       | 12 ++++++++++++
>   tcg/riscv/tcg-target.h          |  2 --
>   tcg/s390x/tcg-target-mo.h       | 12 ++++++++++++
>   tcg/s390x/tcg-target.h          |  2 --
>   tcg/sparc64/tcg-target-mo.h     | 12 ++++++++++++
>   tcg/sparc64/tcg-target.h        |  2 --
>   tcg/tci/tcg-target-mo.h         | 17 +++++++++++++++++
>   tcg/tci/tcg-target.h            |  5 -----
>   tcg/tcg-op-ldst.c               |  1 +
>   22 files changed, 136 insertions(+), 32 deletions(-)
>   create mode 100644 tcg/aarch64/tcg-target-mo.h
>   create mode 100644 tcg/arm/tcg-target-mo.h
>   create mode 100644 tcg/i386/tcg-target-mo.h
>   create mode 100644 tcg/loongarch64/tcg-target-mo.h
>   create mode 100644 tcg/mips/tcg-target-mo.h
>   create mode 100644 tcg/ppc/tcg-target-mo.h
>   create mode 100644 tcg/riscv/tcg-target-mo.h
>   create mode 100644 tcg/s390x/tcg-target-mo.h
>   create mode 100644 tcg/sparc64/tcg-target-mo.h
>   create mode 100644 tcg/tci/tcg-target-mo.h

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


