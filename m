Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D548C282DE
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Mar 2025 01:41:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tsu2Q-0006CF-2a; Thu, 13 Mar 2025 21:40:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tsu2M-0006Bp-8Q
 for qemu-devel@nongnu.org; Thu, 13 Mar 2025 21:40:34 -0400
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tsu2K-0000AI-DC
 for qemu-devel@nongnu.org; Thu, 13 Mar 2025 21:40:33 -0400
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-2232aead377so35746665ad.0
 for <qemu-devel@nongnu.org>; Thu, 13 Mar 2025 18:40:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741916430; x=1742521230; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=qpYiQsw5ouFh3lv4P7mw0ZvHP/DFk/XObRv111Tmbgs=;
 b=jXDWQz4DHZCjFRtS7nzIJMbW5lPIcrNgEAiWL6ZzOzIqFO4qzWyKRe4D0I2yJtJ6gi
 +QFNUyZvwDKMDscDSrVSvbPjKlnGQPGw5RCIvIBMZFDjZI0cten/bvpatc5DDW+zR4uc
 L35xHa/VRVJI9XteHkXx2OAArmkNeVkpgZJFxPgi2RZFcgI7qD0Aw0bbcf3lrKm1YvHg
 ZYZxPlmFQKtsF5tZ7mkRSkimml5stTOsPI+NtdjlutGN01MKQD7A/8NmKX2+SsxpBllK
 HqVcrBU94EC0l/vI+9U4WMMlpn/F5HIz1A5KAaXolOo4XId4jC/K427ussdFIK1+/rcD
 VMiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741916430; x=1742521230;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=qpYiQsw5ouFh3lv4P7mw0ZvHP/DFk/XObRv111Tmbgs=;
 b=RyQ1UjfnH84KOycmZo0UrDAdyc/btC2Vg+HHdFKDKRlpADjVOm3sw745OCGSdBLQOv
 cakXRvs0eZAkYFVzLY4I3JtfVXLLatRiegS2+W+LzANaUqMPocfbP8mq52TbynQhjCjj
 PNap91y8iDOUurgWBaxpYmBbXn7+ujhDMArTN+zc7Y5eWVBSqWqoMOtXFiwwcNy85K1y
 FVBsJ+0UlgIY5rs63YCcbkwv+JVzGcnkTAC+8cLbnXJGsyg3ys0EjjTprtGnhK1pNwRF
 3ulcN9R5BtcPC+4C8lkUClKc6fBio0+0eRh+1bEOaPjvilQAoCS317mv+kd4iqVIQSNt
 pNJQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWuIUitEH62ElhEZ4qFshXGxkw1+KArBLNTia/daBEMmF1A6t7IE1SzDloYt7hX0YrV5TK225CblHqH@nongnu.org
X-Gm-Message-State: AOJu0YxM4WRweDfDxAYOms4Db3TLNV1H5k2MEgqe0JbthmDLh1G5ey1w
 2/pSKStlMEEOc3j0BSsM4TVkFA2LVHs0a+Im+7UGLOtBVJ5UGc+Ga3vCTm0GA6Y=
X-Gm-Gg: ASbGncuL3aUKxT1yWL9KHxDXTqxVFQTo7SmAHbTfvyozbeElEivc7BD7ZGYL9rVmpH2
 bRn0rp3nH3BuEMRdKHSAQPJtbQk68q4Cg4+fFatGxunZgMwhasXoXcc5FyGRhQw4hoLdMBnYdtv
 5Jh/kv+UVqhFIbkyJs9xKtq7xpQQVgLKL6GghhuVZXQlrZOXoGS/6W0CxBo4gBd4wjGUV50gVr0
 d1Iy6b6IkA4Emb6rlsiBMxzS8YhduhWhaXfd11wDle++qsgDF49BmrWTppAH9S7TNiGfSwGcDib
 RldR0civ3Zd/kERLyvMGOZX/rzT1UD748DVONOF9nOHpI4YuC+kbTiKOrve5IPzoeMBlC3mNjN1
 kxcVrZVOB
X-Google-Smtp-Source: AGHT+IFEM5/bcvLM4uiT8V7+ed4Fb6iAVdismkhDVttU2crXmE4Gt+277Dhxc7W1j156XNTPqm0SIQ==
X-Received: by 2002:a17:903:98b:b0:220:c813:dfcc with SMTP id
 d9443c01a7336-225e0aee7b9mr11287455ad.40.1741916430542; 
 Thu, 13 Mar 2025 18:40:30 -0700 (PDT)
Received: from [192.168.0.4] (174-21-74-48.tukw.qwest.net. [174.21.74.48])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-225c6888d9bsm20305815ad.49.2025.03.13.18.40.29
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 13 Mar 2025 18:40:30 -0700 (PDT)
Message-ID: <dfa2fe02-548a-48d0-adcc-6be5b78252f6@linaro.org>
Date: Thu, 13 Mar 2025 18:40:28 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 13/37] include/exec: Split out mmap-lock.h
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: pierrick.bouvier@linaro.org, pbonzini@redhat.com
References: <20250313034524.3069690-1-richard.henderson@linaro.org>
 <20250313034524.3069690-14-richard.henderson@linaro.org>
 <0272cb13-e973-40f3-9659-dbc8c8ccbff5@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <0272cb13-e973-40f3-9659-dbc8c8ccbff5@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::631;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x631.google.com
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

On 3/13/25 02:58, Philippe Mathieu-Daudé wrote:
> On 13/3/25 04:44, Richard Henderson wrote:
>> Split out mmap_lock, et al from page-protection.h
>> to a new header.
>>
>> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
>> ---
>>   accel/tcg/internal-target.h    |  1 +
>>   include/exec/mmap-lock.h       | 33 +++++++++++++++++++++++++++++++++
> 
> What about include/accel/tcg/mmap-lock.h?

I'm not especially keen on that, no.

I thought about include/user/mmap-lock.h, dropping the system stubs.
The only user outside accel/tcg/ appears to be target/arm/helper.c.
So I could probably come up with something...


r~

