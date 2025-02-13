Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D353CC0219D
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Feb 2025 12:38:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tiYT1-0001Hu-VR; Thu, 13 Feb 2025 07:37:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tiYSz-0001Hd-R7
 for qemu-devel@nongnu.org; Thu, 13 Feb 2025 07:37:17 -0500
Received: from mail-ej1-x62c.google.com ([2a00:1450:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tiYSy-0005RN-BC
 for qemu-devel@nongnu.org; Thu, 13 Feb 2025 07:37:17 -0500
Received: by mail-ej1-x62c.google.com with SMTP id
 a640c23a62f3a-ab7483b9bf7so103728366b.3
 for <qemu-devel@nongnu.org>; Thu, 13 Feb 2025 04:37:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1739450232; x=1740055032; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=4laTtZSqzuInN9tSy4PH6rGTH02p8BHqK9IF7KMMQQA=;
 b=A+Q4M8e6+UfZsIuo7yLbrIqWzbeAZpGf82sRGJsaD46B//3irrkQr4C/A3BKQ82HFU
 axGOs095WdmJ76sQekBccI/SVL7HOoAeP86CH3CZTMMa2WjnFpntNa0hC74J5B2MLaCw
 atFMIZdZb4q7EJzPv3iO66atlmzU2ib0AT/gNsjBvE3S3qisxpd8nL2aBZFYkMInCI4a
 4HV0u+QWOtgwHwLmhqCmj8mzE450SyPXIaqVhfrzyaDX9bdbbd1slRHZrBPMMUkTrXzN
 eODQNMW1ZEzX9MCsUk5gxtOsxZNylegDhXChWv6nslNo89YNktjbUU8cGooWTrfSm1u2
 wy1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739450232; x=1740055032;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=4laTtZSqzuInN9tSy4PH6rGTH02p8BHqK9IF7KMMQQA=;
 b=k9sXT069wBwHU5EIKHeWUFm7D8MGPQxq2w/4//OUtdAXri8Fe6MgLS3XeRusJpCxKa
 gCzBvu89SooxLBBiPclXXq4jOMKi031ORolR2ewNp71Elz4zFWIcWqDnez8skjEqYsHJ
 mXdD3q9qeA+P8kmhUKdKwSrspgvkfAAll3Ej1l2Fw+9U3WOB6d9XiUE1m5fvhw6fmUgB
 A9ia6SBSqY9rpjPDFbpS/zIUBtESVSKtsRT7JKq6VXQTM4elD/tn3I2UTs5WN6a5Dg0z
 XGFaop82Q3X1umHdksWlM3uEJMDFNz7qV1/aC/SytfgXE+fE9jvSW9CyNsQU6bU5dWfJ
 gfRw==
X-Forwarded-Encrypted: i=1;
 AJvYcCX8KULQosVe405sVwvY20MtNTi0EkvNPgnqt6n8PmWCBtj762heBMAju59B+qilW20W/f5S810wJiUZ@nongnu.org
X-Gm-Message-State: AOJu0Yzj9V7N5xna0OjPYpESRR1StKKnq5to/wI/f0krcgPC3kijX6q5
 SWiAvbryJfFzhLnHyGT+etYId3jDDU0P5O+PHsXE6x0ZelXpHBDnxCisSx00cJc=
X-Gm-Gg: ASbGnctFpyiIXmFw0EcD5OlMfA7iYvbuX4VdqpJCykjZPc+TIV6ey+pvwuFIfxtKEm3
 46gNtN2csRUL8k/XAKQ5k2Dd7UlaVZqELdGHzGegXny+78qP7TWjf2WgTQcCfkQwwp3IdxCxU7k
 wuSEehKvKlJPzF0xsKwEyLNpwIipuGFU2KRZ/JHleSgWQ0743OQ/qKygPiYwypybwjfyyIDJnzS
 oTmWMqkVQQ7FprzMDN8lNSQWy8PxSkkF4EP0E3v7UP0JZg9PPDlGwG9OwMr7vjr4qoawe6W7hQE
 n1HnIu55pbn9x1epNGzVS0MvpE1a+W2NhhesXrUSytIIqXg51Hxn
X-Google-Smtp-Source: AGHT+IFceA9sFiHoB3vVdZcqqEtDEbNMV8ylXtPZwQ5RjlFzmIoc/T8dknpQYrgAxu9g5d+EpFyZ+Q==
X-Received: by 2002:a17:907:720d:b0:ab7:bac4:b321 with SMTP id
 a640c23a62f3a-ab7f33d3571mr644676266b.29.1739450232428; 
 Thu, 13 Feb 2025 04:37:12 -0800 (PST)
Received: from [10.223.46.213] (6.170.88.92.rev.sfr.net. [92.88.170.6])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-aba53231f5bsm123402466b.7.2025.02.13.04.37.10
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 13 Feb 2025 04:37:11 -0800 (PST)
Message-ID: <ad364fce-f73d-4dde-b890-0ea86d9c4674@linaro.org>
Date: Thu, 13 Feb 2025 13:37:09 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/9] target/microblaze: Always use TARGET_LONG_BITS == 32
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: edgar.iglesias@gmail.com, "Edgar E. Iglesias" <edgar.iglesias@amd.com>,
 Luc Michel <luc.michel@amd.com>, Sai Pavan Boddu <sai.pavan.boddu@amd.com>,
 Michal Simek <michal.simek@amd.com>
References: <20250212220155.1147144-1-richard.henderson@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250212220155.1147144-1-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62c;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x62c.google.com
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

+AMD folks

On 12/2/25 23:01, Richard Henderson wrote:
> Use out-of-line helpers to implement extended address memory ops.
> With this, we can reduce TARGET_LONG_BITS to the more natural 32
> for this 32-bit cpu.

I thought about something similar 2 months ago, but then realized
MicroBlaze cores can be synthetized in 64-bit, and IIRC there is
not much missing (I'd say effort would be to add 20% more of what
we currently have). Just wanted to mention before taking the
decision to restrict to 32-bit. OTOH if there are no plan for
adding 64-bit support at AMD, then I'm more than happy to simplify
by considering only 32-bit.

> Richard Henderson (9):
>    target/microblaze: Split out mb_unaligned_access_internal
>    target/microblaze: Split out mb_transaction_failed_internal
>    target/microblaze: Implement extended address load/store out of line
>    target/microblaze: Use uint64_t for CPUMBState.ear
>    target/microblaze: Use TCGv_i64 for compute_ldst_addr_ea
>    target/microblaze: Fix printf format in mmu_translate
>    target/microblaze: Use TARGET_LONG_BITS == 32 for system mode
>    target/microblaze: Drop DisasContext.r0
>    target/microblaze: Simplify compute_ldst_addr_type{a,b}


