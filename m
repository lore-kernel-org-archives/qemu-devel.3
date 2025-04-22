Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8BFC7C369C2
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Apr 2025 17:11:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u7H8N-0004Mn-3z; Tue, 22 Apr 2025 13:10:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u7H8K-0004L9-VP
 for qemu-devel@nongnu.org; Tue, 22 Apr 2025 13:10:09 -0400
Received: from mail-pl1-x62e.google.com ([2607:f8b0:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u7H8I-0004SM-OK
 for qemu-devel@nongnu.org; Tue, 22 Apr 2025 13:10:08 -0400
Received: by mail-pl1-x62e.google.com with SMTP id
 d9443c01a7336-227c7e57da2so47808415ad.0
 for <qemu-devel@nongnu.org>; Tue, 22 Apr 2025 10:10:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745341805; x=1745946605; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=v2QlFdpqV/cwkuN9lzK2uY7RhQgPJ3iWuZb1rcjImDI=;
 b=A4QAxTOtjyWttVBCCTKCZMeD26/29BP+rMrs0kZtDTkcibtB0xFfMeKVpNIVt+M6bw
 1E1C5lQBmFokFb3Kpz2HbWUeOGH0HnH2e7Cq7LSfxe7hqzPNfKHYXBZvnLDTzZr1XuGg
 4dgBYWv5Y0PR4DkCaOBQRY/Rf0Lz0xMsgQj9x/Lxhfpux8pbRyf4HBzXCibAldOYN9IM
 FZoglnsFEmla/dtUpy2OvupVYte+X6IfgFm614q0I+66Xa3jYaVIIE7l5m3hqalTHSce
 VQcUwomIrmNEgrZsmpt6PlqC3/AvxMJS5o1DOkEWPus9MNz6iPtr3xz55WNGbtDVDLyB
 U87w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745341805; x=1745946605;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=v2QlFdpqV/cwkuN9lzK2uY7RhQgPJ3iWuZb1rcjImDI=;
 b=Fg2yRGUh+IcMXoh6rbUmaj1YWwZMvH5p6ccO2vbPl+TmtSUmu8mX5QGXyPCl0sbmjA
 b1zy0VWJevErTO4eFZIND/StGEbyiy6t+SuF0KLvHQd792pl10q10XsGzFwX5hBRvit/
 DOlD4nyiMMyb213DJky1JIkw/55kKg9zZwwylBy4v7oMbxWfCsA3KIi6VYOI0xk1fKVB
 iEluKkpAEy0clV670sUhBlyU/Yq0sKlQfO9YdQqL0xRMJhqoPSoKSNoSLBnNpfIyIbXy
 jTVVQshd1Fb8g31lFeFsOTv7CoGUeTMYM7wdryc86xFV3aRqA43O9dWGRVArnfHsdzYK
 GtNw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUvwfCKuJN5WVQVzQT9xSH26MTBCZpFX6IyfpSt6xwVIAQDR3EgiJkbbXxsIDdeisbeY2aUko7tgF/e@nongnu.org
X-Gm-Message-State: AOJu0Yynd9EUoBYyRO61nW4G2TtLbKceqyzIZcLkGt5EaIp/5ixW6fBa
 44V/LFRjgoiVQ7nXZpIxe5EdJ1ifjK24Kb9Z06O18D3tc7VYE16E7gH3k2eOytY=
X-Gm-Gg: ASbGnctnhqMifQS3FgzzOnlTIqEp2R/2Yt0pIBJKYm4ChNOo/FiVz20sGrGTmxR8PMe
 mlFhuWxIGKYMkhkPU0Wy9e3Qh2CJDyMFvgW0rabrByI9QczVNuZMN6+iNjpRXj4ZPNrrkx7FTvQ
 9LphIoQ44gs1MD6hLOT25stlt98RNoPuHV4DvnIkjxAJJvCV6Y1jn9/PRiBwIwcglhHdMPF+TcA
 jNU3dqN61ITdgkzIkv73KOUjXAFL7bhQNZg1WRiE/HobpwKuIwUEsqYBabFJrdcjJOlPNLjBcBs
 iofPzJpBpWHdtR3A8PTsQ5vuTlB3oGtOPf4k76gaQnKWuisEfMj3AiujF85Xzckany/SVzJgd1E
 rn/6Mx5Q=
X-Google-Smtp-Source: AGHT+IEkx90NNAPoJDGV7TE9sq9n3oG/rPYuDBebQUegEek7ZXXpnQGokm2oMrNVCBK1d1J7AUw6uQ==
X-Received: by 2002:a17:902:ea07:b0:223:88af:2c30 with SMTP id
 d9443c01a7336-22c5357f3b2mr211427365ad.16.1745341804719; 
 Tue, 22 Apr 2025 10:10:04 -0700 (PDT)
Received: from [192.168.0.4] (71-212-47-143.tukw.qwest.net. [71.212.47.143])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22c50bde120sm87749055ad.42.2025.04.22.10.10.04
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 22 Apr 2025 10:10:04 -0700 (PDT)
Message-ID: <c99098ba-bd49-48e7-ae61-289c86d9068f@linaro.org>
Date: Tue, 22 Apr 2025 10:10:02 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 149/163] tcg: Remove add2/sub2 opcodes
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
References: <20250415192515.232910-1-richard.henderson@linaro.org>
 <20250415192515.232910-150-richard.henderson@linaro.org>
 <1d6adf81-15fe-43c5-87a4-45974e6a8a68@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <1d6adf81-15fe-43c5-87a4-45974e6a8a68@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62e;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62e.google.com
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

On 4/22/25 09:42, Philippe Mathieu-Daudé wrote:
> On 15/4/25 21:25, Richard Henderson wrote:
>> All uses have been replaced by add/sub carry opcodes.
>>
>> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
>> ---
>>   include/tcg/tcg-opc.h            |  5 --
>>   tcg/aarch64/tcg-target-has.h     |  5 --
>>   tcg/arm/tcg-target-has.h         |  4 --
>>   tcg/i386/tcg-target-has.h        |  5 --
>>   tcg/loongarch64/tcg-target-has.h |  4 --
>>   tcg/mips/tcg-target-has.h        |  5 --
>>   tcg/ppc/tcg-target-has.h         |  4 --
>>   tcg/riscv/tcg-target-has.h       |  5 --
>>   tcg/s390x/tcg-target-has.h       |  7 ---
>>   tcg/sparc64/tcg-target-has.h     |  7 ---
>>   tcg/tcg-has.h                    |  2 -
>>   tcg/tci/tcg-target-has.h         |  4 --
>>   tcg/optimize.c                   | 87 --------------------------------
>>   tcg/tcg-op.c                     | 26 ----------
>>   tcg/tcg.c                        | 36 -------------
>>   15 files changed, 206 deletions(-)
> 
> Missing doc removal:

Good catch, thanks.


r~

