Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55A5ED59D77
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Dec 2025 17:03:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vU6XF-00011q-N1; Fri, 12 Dec 2025 12:02:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vU6XE-0000zf-CE
 for qemu-devel@nongnu.org; Fri, 12 Dec 2025 12:02:28 -0500
Received: from mail-oa1-x2d.google.com ([2001:4860:4864:20::2d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vU6XB-00064Q-P9
 for qemu-devel@nongnu.org; Fri, 12 Dec 2025 12:02:28 -0500
Received: by mail-oa1-x2d.google.com with SMTP id
 586e51a60fabf-3ec96ee3dabso1045007fac.1
 for <qemu-devel@nongnu.org>; Fri, 12 Dec 2025 09:02:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1765558944; x=1766163744; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=kTGOkY+kEDWvUv3R37Kdx2A0DmfJLxklSU9TBT6kNts=;
 b=qqyOp6QrtO9ZHQC2J+RNkH3Q4ZUDrKHaURF7qNqcaZnxloO5FxbuteVTKkCpd2HoZ6
 xFZifUyvA4itJgRfqbj6zcM6F36sWIOcEIY0RxA0z+4TpJH83eSt4TUgUQgEfkbxB6YX
 vOouuhY/BhLZ+jr/dIpLViN5BURXFB5ulTpbMdj/FPbXqLz2K834lzPcUJXy0Vb2086V
 CIRn0kxXSSsxDlZVPwtYVSl26tFyuwgowrLVKorqMP3lAmbgjpSEubyYRuw6+komNW1t
 01/odSlBjYG1CsPaUJod43Voen2vHcpgPqXrnsImuzemFKqH0UaftaDdjiyPfdccK2Zx
 usng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765558944; x=1766163744;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=kTGOkY+kEDWvUv3R37Kdx2A0DmfJLxklSU9TBT6kNts=;
 b=Um9NE8ZoKmqLMYS7/XNLPQkQQvqoxRf4oURySM9tC+YdQ3Z1RWMCQNHebrwPLF96hj
 wEqbJus/jczO5TwDZswAqk0HgisEbLJ9IbRSDcPt+tSXe8d4LOXmmu1P0ugfZ9XhfvNc
 +oeJH5tSi8L5stxzkwJr/C1m22jtTQyaoMtdipVcQvGPiLVGYoZ7mY7mpzpPbVRD4vm8
 970CduQvU1bfMNhjl9gCeUcYKrExfs/xDRAkQ/tDSSxP1l+hz/RK1Tk16sCvJ3t9zUZ3
 LISTxHy/KsUdO58kLXhtAYuAb999VgRHp7A91PRsLpKhiJcAvoWx/ID/YO0NNKlQZJpg
 5+jw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWhqpdHORnwd9AbDEl9hk4+ET2CO0EENeYUKAMqJ+B8nu0sBpDH2bBO1WlT4MyiuHj5xC9gnKsOD/nQ@nongnu.org
X-Gm-Message-State: AOJu0YybGEpUPt6/nwd3GatAR8kbkHUJEipuB/EJIORgc2W1wMxb45CQ
 8Ai6dvHiy9Qn1q0BV9SRD4/Oya288gN0or8K4qijhQsMdvc5h1gPexzKTVSll0uSUH0=
X-Gm-Gg: AY/fxX7pTVx4bXbOy4NzOpLrkw0GsF23BBmWRx8/uLHi9JOsNdAmd2zPjXIZiYTbDkt
 B+Zhf1/mHDhy9f8nKbzlSoZ2/ThGVq5Yf1MXwQ1roptmc7tPB84MnCU9jhLQgTWOjqtZOeEYjC3
 ZSeuJhrPsKqE38+4YDt2FuGEVZsE6qT78dCIHMrUYsj/TvshaC901SmNoQcgIefUJKgeJFYufV3
 iriHAU+eAzzo+bDx+fDJbcm+Bk7Tbw4x5+2Cs9Ca7sANET0cy218corIXB79w5RDfiA0+dOkxas
 7e8EIoz0PqcA2IdISt799/IfvIFHNvvn5kb+6syA8GhaKfJlFTFPDNd6UhzrzE0QfeTwZ9sRRWd
 A7JeLrbN6g5QYeyuyojS8EOyxKBSjckyWFoRjFSUBZ0AWYnZMFniRrrpVRiXAlArNzXC5AJ6sjw
 l4JMMZ+WGd8/v+G6r613Y9ZWI6Ogn3
X-Google-Smtp-Source: AGHT+IEKAvW6u/eHNREglt+DKvfGc6GgW3Z1f2U6msaxerOMx1CR0eH38ZoQZi2XxRaEA5Bg7MfC8w==
X-Received: by 2002:a05:6820:2214:b0:659:9a49:8fbe with SMTP id
 006d021491bc7-65b452848f3mr1310234eaf.55.1765558943978; 
 Fri, 12 Dec 2025 09:02:23 -0800 (PST)
Received: from [10.229.62.227] ([187.217.227.247])
 by smtp.gmail.com with ESMTPSA id
 006d021491bc7-65b35f2b589sm3128203eaf.1.2025.12.12.09.02.21
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 12 Dec 2025 09:02:22 -0800 (PST)
Message-ID: <26ae9852-26ca-418d-becf-5e893a7ae5a3@linaro.org>
Date: Fri, 12 Dec 2025 11:02:19 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH-for-11.0 v3 21/22] target/ppc: Simplify endianness
 handling in Altivec opcodes
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, qemu-riscv@nongnu.org, qemu-ppc@nongnu.org,
 Nicholas Piggin <npiggin@gmail.com>, Chinmay Rath <rathc@linux.ibm.com>
References: <20251126202200.23100-1-philmd@linaro.org>
 <20251126202200.23100-22-philmd@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20251126202200.23100-22-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2001:4860:4864:20::2d;
 envelope-from=richard.henderson@linaro.org; helo=mail-oa1-x2d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 11/26/25 14:21, Philippe Mathieu-Daudé wrote:
> Access the memory in big-endian order, swap bytes
> when MSR.LE is set.
> 
> Signed-off-by: Philippe Mathieu-Daudé<philmd@linaro.org>
> ---
>   target/ppc/mem_helper.c | 31 ++++++++++---------------------
>   1 file changed, 10 insertions(+), 21 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

