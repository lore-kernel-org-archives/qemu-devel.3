Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09AF5C44501
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jul 2026 18:30:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1whX20-0001Ip-LT; Wed, 08 Jul 2026 14:30:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1whX1z-0001Ia-Q8
 for qemu-devel@nongnu.org; Wed, 08 Jul 2026 14:29:59 -0400
Received: from mail-pl1-x635.google.com ([2607:f8b0:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1whX1y-000523-8C
 for qemu-devel@nongnu.org; Wed, 08 Jul 2026 14:29:59 -0400
Received: by mail-pl1-x635.google.com with SMTP id
 d9443c01a7336-2cc97653887so11835855ad.1
 for <qemu-devel@nongnu.org>; Wed, 08 Jul 2026 11:29:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1783535396; x=1784140196; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=tNbpc4NoKl0FaQi6spUPt+OKe/TOrFk9OIkEU4iEUqM=;
 b=s7YMoW1vSfUVG171260RYbUyNmN6iIgA56qljkL6PX7iREM6TQraXK21hEWrNtfFH+
 Kbk8OlaYGY0NJDQt10JNR+4Mzk/9pflkLo+3SP3g5l7zSzuwXcctS74z8eIloVouKZU5
 CWN4NsnbQZbnQZykstZsQFxiYGjpU93LjlCxBsRBR0ZNHXr1vUu/1EDFIQXDyhRKu/O8
 s7tlsQOuCZ+WcgTuhF0denaLeaCMW7WaqMfEIhSCjQS3LOx9bgxRMUNHMdMS3WHU+D46
 w2SVceb/cUfWObTiZQzI5ubiJv0vsypMhyqMKJ3ESQFT/dnOdSXLZssJGgvt1YlXCXso
 6e8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783535396; x=1784140196;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=tNbpc4NoKl0FaQi6spUPt+OKe/TOrFk9OIkEU4iEUqM=;
 b=HHe3fBZcx+YhQ7GOJ0IS5qXpgO+rSFl7Sa+QYpOpFSMN5+gmSlDNj3HovVLj4q1TuK
 g2kX9hKVSLpG9ShF2i63DajvjGSBq7JzCzjRTkLRHgE4Xk+l/ZZ4RTygPOnwELrBw/tb
 Yyj4FCIKRBggcC9b+e9IHCrpXzddUn7BHM2VKMvSPZxtnFpf+rtVHZNrTE4ojXG+uvF1
 Ao9kt4vkaBJRXK2gWMx4mnLzwQI/AQfCsHVbMMNWn1AQYjve/ECmgrMTK9Q4xJ0F1gaz
 V63K3d+8VsOaavLw6en50qDpcBjOfPI9Y/sgX+XWf+KYEhRkc5j57WuP0byv2oN0FthW
 6aeQ==
X-Gm-Message-State: AOJu0YwPx26Huyvm3cxz+1EJvvUVTtZWHTDyOiKgRZol+zqWQpM3Sazp
 WprPrukQ8dN4R2U47lkbMOKBU2kXSFltzsw0YOV2/RWMhBfSUc0LlIzqKZ3e11Hq/Ked7lPHEgb
 MSmEW
X-Gm-Gg: AfdE7ckF/fEOisv2MVdvNeu6M8tCpWd7Znoo7tLq05ZaEn/dFzw1pij04n+aPMHcMaw
 S50qdBTVu3uO+IZy8+wIGh1n/39sFToCxlMGpEYKRrdT1EtE+qyQxg3+VuiIZphw987kEJlrKNM
 Yf2Ty9wuEqOjtGWPExXaxC1mZd9C13t07p6KeUnIXAiDqujNM2mJjpu+f1pimFr3Hpodf53mBNc
 hsWoaIy523eUjSgMgMeNJpScalujkmbcksE9dNXMsHks6UG96VYtL3gjMxL8R3R6jK9AxU13Z9r
 doYOUAdMFHJZ3hnO8PHQPwAg9syy9Hk9ybXHzYKxcVQOTf/Kissp2gKSOltvkn/IpzIkrs4iGMo
 2dLQsazvRt9YnjRM0QriF/QCOyixFdTqzN1dD+B1r1EhXM63DTIIT3xgqIfk1By5PrPx6ijU1pb
 ubXpl20SfTpBYc9Kh8nTGz+rZ47uQ/JPhDOaZ17Dzz+1UlZdMKy/URYWg=
X-Received: by 2002:a05:6a21:7a43:b0:3c0:9c19:65b3 with SMTP id
 adf61e73a8af0-3c0bd3a358bmr4336808637.75.1783535395929; 
 Wed, 08 Jul 2026 11:29:55 -0700 (PDT)
Received: from [192.168.0.4] (71-212-39-188.tukw.qwest.net. [71.212.39.188])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-ca5b3162d56sm2679728a12.20.2026.07.08.11.29.55
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 08 Jul 2026 11:29:55 -0700 (PDT)
Message-ID: <ddc71b3c-0f28-4c6e-abde-3ff90403d832@linaro.org>
Date: Wed, 8 Jul 2026 11:29:54 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] target/loongarch: Enable TARGET_PAGE_BITS_VARY for
 loongarch64 user-only
To: qemu-devel@nongnu.org
References: <20260630-loong64-vary-page-sz-v1-1-1d1a894674be@gmail.com>
 <2018af95-66aa-40c6-b3eb-b7bba9bd26a1@tls.msk.ru>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <2018af95-66aa-40c6-b3eb-b7bba9bd26a1@tls.msk.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::635;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x635.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 7/8/26 04:38, Michael Tokarev wrote:
> On 30.06.2026 10:56, Miao Wang via B4 Relay wrote:
>> From: Miao Wang <shankerwangmiao@gmail.com>
>>
>> Hard coding PAGE_SIZE to 4K will prevent user-only emulation from
>> working on hosts with 16K page size.
> 
> Doesn't the same apply to all other targets - hard-coding PAGE_SIZE to
> 4k for any linux-user target will prevent this target from working on
> hosts with 16k page size?

But some targets really have a fixed page size and aren't prepared for any changes.  E.g. 
x86 and m68k.  Thus it's up to the target to decide if variable page size is ok.


r~

