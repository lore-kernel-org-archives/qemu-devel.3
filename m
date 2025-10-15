Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F39FCCD194
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Oct 2025 16:52:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v94hs-0002pW-PX; Wed, 15 Oct 2025 12:50:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v94ho-0002or-Kf
 for qemu-devel@nongnu.org; Wed, 15 Oct 2025 12:50:28 -0400
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v94hg-0001kc-V2
 for qemu-devel@nongnu.org; Wed, 15 Oct 2025 12:50:28 -0400
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-46b303f7469so47410695e9.1
 for <qemu-devel@nongnu.org>; Wed, 15 Oct 2025 09:50:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1760547015; x=1761151815; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=6jVY2IP7Y5KFMq1Tm0Se0N6RmBdWmQ0cT47Mj57kWiA=;
 b=C5zZbNtYMN0cBBcMlgLF78mQxjb97A8lg1Un5QXfQFHLEwMzLpCiJuV1JSu8WwKlf3
 3I7jfUnFtBOZr3lzLDzAmI5/cU0MtMUaYSxpFIGfoKsnseyRKbMob1f/+rKZ4Hxbowjy
 k8q3QAT744PyJ93c0G+kT+6x6edDsKm6fPFAe7uFhNqQZL4Ne6Bhl66B/YzNm4OlxOvb
 3aeoRsPnFZuoYnY/79cwFPLeq/5BKUwEstUePknF2MGPlb3/BmovLypdkB6aP+/Ybqiy
 QMAU/uQ7d3dTiaajDKCRMFRBHj1YmTm83nN/mMTt1QbDnbnJkuW9ltrIZh3A6v4Wuye4
 qMew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760547015; x=1761151815;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=6jVY2IP7Y5KFMq1Tm0Se0N6RmBdWmQ0cT47Mj57kWiA=;
 b=D5rOrNHDXmh59I+gyRYSeIhQPoiZs98H4bQOcwwiFH2d8mzKDqRR5dH/hIPBwNLW/G
 QMchrI9yLZXdi24UOeVDl9sRsS54IZQpcPIUgV4KNZ/jrSOIvetMryJfxa9O3Rh0oSMB
 i/axe08UZljXs6JdqPK/ECfbfgKmo8+MlcEP23GRbVu1TgbJ0cT1rurOk1qiYIfKG6EF
 XKneJkpWwlx839k8VFjtD32I1Cv11R0tEdjCBbCP65lfQxsvua0m4oTZiIKGH333gCF1
 DrOPDDA9qeD6IjH6CvQ6sUXGb/WhwQ/E4kDAOBu+QRWD2B4orRzg1L5/xf/WBXBaF+SM
 q9tg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUprfxg4T6pOXx5qRjPUA/QZOJG7s9OmAAm/p34dqriowI6vIec6H8aYOZNZzguaidhl9ZOEIvmKGuG@nongnu.org
X-Gm-Message-State: AOJu0Yww2Iq+86KQtWRs0Ki9DLEkkpHCn5W/DtClDG6qSYlMgj63hdsQ
 KAJxIY+PpH2Nu2xj4cVi4icg+WyvUsuR7nmjD1yOmgDoD1/IJjYLNEDstTnJLci6vt0=
X-Gm-Gg: ASbGncscv6PJXDpMCJjXXq80O++nTywpAXGQlTrfK5qVLJDQVtlFXEQ7zn19Yb0Y2uk
 o0qYQewTtbu8kJilE3y4Dbfhm1R9JYZJxKLrfYZND3YUoKgZj5kyEWteWfObkzAQG5L23JA85sN
 isrduiogOl7tnhTvNRt0VzlASCYWeIC13RVlKG0F2GlC6FL8pharMVb9V6VzRs4ELCDBRCrleIw
 V8YS0Qvwq1hDOWtdbkwbQxyXQ1dmGOei/0bbTiKuHPPdX/whenrQH0sTtl6+0q+7ERurPvd28Tg
 QFltXjLwy92f5c7J8e2OtTeGSsQ1b/1VfOLwXl4Yhr9bmOrVhdYaxgzUO9hXJwub6kOigW9LGiU
 I9iEFdV8nf7J9o+CiAJRisToBD6s8feqzO0yWVRSIb5BFlX7oUri3JPhRvQNASGVQLXVZ9e1yl2
 l/VnEZOxNHij2yAhxaWSPpA9g=
X-Google-Smtp-Source: AGHT+IHUglrMkF35mclyFIIBgd1yWj0b9GE2cUOd/2EzuOUdzXr4UOY5bqx8ZgAi+hQXBVy3ZAlkiQ==
X-Received: by 2002:a05:600c:8903:b0:46f:b43a:aef2 with SMTP id
 5b1f17b1804b1-46fb43aaf82mr97842085e9.38.1760547014926; 
 Wed, 15 Oct 2025 09:50:14 -0700 (PDT)
Received: from [192.168.69.221] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-426ce5d0006sm30335322f8f.34.2025.10.15.09.50.13
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 15 Oct 2025 09:50:14 -0700 (PDT)
Message-ID: <81133d1f-28db-4d6d-a479-fb941d126490@linaro.org>
Date: Wed, 15 Oct 2025 18:50:13 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/5] hw/riscv: Replace target_ulong uses
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>,
 Anton Johansson <anjo@rev.ng>, qemu-devel@nongnu.org
Cc: pierrick.bouvier@linaro.org, alistair.francis@wdc.com, palmer@dabbelt.com
References: <20251015-feature-single-binary-hw-v1-v1-0-8b416eda42cf@rev.ng>
 <20251015-feature-single-binary-hw-v1-v1-2-8b416eda42cf@rev.ng>
 <1fc99217-f1e3-4ad9-8f67-89ab47995c98@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <1fc99217-f1e3-4ad9-8f67-89ab47995c98@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x336.google.com
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

On 15/10/25 18:31, Richard Henderson wrote:
> On 10/15/25 06:27, Anton Johansson wrote:
>> -                mask = (1L << (TARGET_LONG_BITS - (va_len - 1))) - 1;
>> +                mask = (1L << (target_long_bits() - (va_len - 1))) - 1;
> 
> While you're at it, long, via 1L, is always wrong.
> 
> Here, use MAKE_64BIT_MASK.

Oh, right.


