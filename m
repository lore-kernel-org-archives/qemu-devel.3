Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0957C369DC
	for <qemu-devel@archiver.kernel.org>; Thu,  1 May 2025 15:06:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uAVUf-0006ZF-OH; Thu, 01 May 2025 11:06:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uAVUb-0006Yo-Mp
 for qemu-devel@nongnu.org; Thu, 01 May 2025 11:06:31 -0400
Received: from mail-pg1-x535.google.com ([2607:f8b0:4864:20::535])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uAVUa-00007V-0M
 for qemu-devel@nongnu.org; Thu, 01 May 2025 11:06:29 -0400
Received: by mail-pg1-x535.google.com with SMTP id
 41be03b00d2f7-b041afe0ee1so1021549a12.1
 for <qemu-devel@nongnu.org>; Thu, 01 May 2025 08:06:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746111985; x=1746716785; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=iZWcy/gQwmgZzW18F5hJaXUmKEUe5Bw5th9wm/LSgKg=;
 b=UcoJYJzHSslOs4zxrO2aBkueSaPGEB1MvF3cCj8L5NdZ6l0ysFG6snlJWGfzaZQAFu
 1NnIsXdZF2skynhzzmHeS5JfFNVEHxYjiNccgjmJP09kaon1gE7g3acZAjtQJjJpp977
 3qVSfzRPKAuhpBINn8auwsbqGlc5MBn182M51l4Nwc7GntprSWIJ1utj1u6U8x8EnEfm
 Ybrvz+wnan3J3VuqrE4uc+e/e3jCSwngLGV/R6Gn0f5KNJXqkLviEYOl+qBukO39Uzla
 sNPf2cGsvYsuK+hT2ab6RviN2k0j6OHkl3tih3vzVUG9GSN5M4U69Obtp9fiuMypyn4c
 demg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746111985; x=1746716785;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=iZWcy/gQwmgZzW18F5hJaXUmKEUe5Bw5th9wm/LSgKg=;
 b=opF16SoW7yQFWSe+Gt+CQ7L5cnux5lSCMEc7KDs5+w4AoZN0l8ONrVb93Xx6+mNYgz
 pC6bfqBvRbGU8zuWT+NkahC9tiWyWtb+EgGO97e1DtB41Zwgn9G8CQAYzl9hnjgcEGDV
 q4BzlmsFms0S0PkekALgg5ehYXPS9KVjrQd3ieUjDsT5/SdkPTiV3LOhN+GDb+E0V5iZ
 LiYOdIA7VQm1zfnSRuYiYyxjTVA3EKszNul01heGC9bfs5j+PCCAojqKqwSCimtpsvLe
 cBKK2oVVLs2Dj6yLYd1PZTM4e457J64ckXwB3sp9dgsAU4lHv2WXJIKg75lQfpHbuuFA
 juQg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVi6xC+Y4YwySwCkLjRWl54GAgCfhfSUVGZtIPAQH5+oNY5w03MP2GRdYEKgdR9QWg4tzuklc2inGS7@nongnu.org
X-Gm-Message-State: AOJu0YxXerNUDTKs3LXnas2Il6alDrXr2MC9/Iy4WF2nH1sAc87DtA46
 yTrSkCGjxUIOxBz4fy1qnd7LfOPLHJB0zhceHRQgawEWm/ZIfshOm1dBYpP/Cwg=
X-Gm-Gg: ASbGncsN8obwv59yClKyYC7siMG8i1yBEleQyELh52N62a1FS8PdeliGkrua2r5bhSp
 Fa/Srn7f5SiR8FIQUr5Td7FcMZryKpqi+GocqJmbiS/qbpxJDVrsUmRz1bdcEp7FROJEdlTwDdR
 42Nq3X0wsVJlxJ+ze3G7HFf3MUXLRXoYhzu7KPnKf7TpOtmbk4Xaic8Q9HR3rVQffFtWSicA3mI
 MXW+v4AHrwe8YLmAbi6m8iNcBMUtRrl19unToEWA5TFAXYmq9ENRwIs3eO2GF2KDn2ERZuTVd5N
 lNQFd/1zVhX8RK9iXbNYpqjly5K7zznhM2AT3byuxpHlL5N3Gv9Crg/RsgZzpWzmXduaIbFc4Q5
 XRCDeXrI=
X-Google-Smtp-Source: AGHT+IEYYi57/VU7OygPpKRkUXmhr7nlLM7U1UenGjpFwEyAsZYWV7KSkhl1VmFWd5WF1whtavzxLA==
X-Received: by 2002:a05:6a21:1788:b0:1f5:730b:e09a with SMTP id
 adf61e73a8af0-20ba73fbe81mr4682296637.20.1746111984650; 
 Thu, 01 May 2025 08:06:24 -0700 (PDT)
Received: from [192.168.0.4] (71-212-47-143.tukw.qwest.net. [71.212.47.143])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7404ef18c61sm933502b3a.62.2025.05.01.08.06.23
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 01 May 2025 08:06:24 -0700 (PDT)
Message-ID: <8f480fa1-609f-4b90-b6e7-02a76d2767d2@linaro.org>
Date: Thu, 1 May 2025 08:06:22 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 15/33] target/arm/helper: extract common helpers
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 alex.bennee@linaro.org, Paolo Bonzini <pbonzini@redhat.com>, anjo@rev.ng,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 kvm@vger.kernel.org
References: <20250501062344.2526061-1-pierrick.bouvier@linaro.org>
 <20250501062344.2526061-16-pierrick.bouvier@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250501062344.2526061-16-pierrick.bouvier@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::535;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x535.google.com
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

On 4/30/25 23:23, Pierrick Bouvier wrote:
> Signed-off-by: Pierrick Bouvier<pierrick.bouvier@linaro.org>
> ---
>   target/arm/helper.h     | 1152 +-------------------------------------
>   target/arm/tcg/helper.h | 1153 +++++++++++++++++++++++++++++++++++++++
>   2 files changed, 1155 insertions(+), 1150 deletions(-)
>   create mode 100644 target/arm/tcg/helper.h

Why?

r~

