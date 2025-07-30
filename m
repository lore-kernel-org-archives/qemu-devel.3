Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5EF2C83F26
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Jul 2025 20:52:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uhDmT-0001NN-ED; Wed, 30 Jul 2025 16:52:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uhDc9-0005As-71
 for qemu-devel@nongnu.org; Wed, 30 Jul 2025 16:41:29 -0400
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uhDc4-0008Sn-U8
 for qemu-devel@nongnu.org; Wed, 30 Jul 2025 16:41:28 -0400
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-23ffdea3575so2170045ad.2
 for <qemu-devel@nongnu.org>; Wed, 30 Jul 2025 13:41:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1753908083; x=1754512883; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=OYgBCM3nuBqToX/h+EMMSXKCRxI1VinmCOSjPbsDOeg=;
 b=YUKg2uz6K3Lm8eZRTtv+vE2y3soM4Er1Q3qDUuUUMacA4SgBeFOi5YCrJzpjNWckgK
 YlmOE7VDHU8L2qguEOR/Igk3ETKAHpe9yOwFBMkAzSyrP/m8WfZ0MynCv4joYyoaHNgC
 m1Ff+Zb6odG+fJhGEL/e63v6wADvLZ+agx6sCcV48esqiTjbbUYHOQhrW0K7tnMx5Wwa
 klvahfF7NPyyTgI5Nswt7c7hl5QHE9p/YrKeNBGkYdTDDWzklLbh7CSNoFJetiOl+Y4Y
 FcvnWsL8SlXfhoDiQys7Px8tXeMItkcNobHtSfWaKsSeL7CmNxytHxiKLdbNuss+3ZZ1
 Qe0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753908083; x=1754512883;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=OYgBCM3nuBqToX/h+EMMSXKCRxI1VinmCOSjPbsDOeg=;
 b=X9HSm7Wz3pnTtbRzrg5VuP2ltXyHeHeRFlipfD55N6XQ3W07GrHQsJfRhFXUQ3PA7Q
 HeOIO2CuBTxesrZ5VRdF1WnK+mpcE3RcqpJYGlQtKeML6by1p9zJ1Yvwnhr/8ECeUW0Q
 US8o6WJ+VPiX78VqjWJ4NH8EKU7AU+uNbDUM+odyvdsr8pH0ByvYfO8fZ3X3nvGuNyFv
 pjDJHfQUUbbC3/rDmt8E+DLMicn8EVUgk9ClI7pc441tYwLVjKXO/aPmNaKNUg1YmGok
 JQtiyD3ssSfiGFfgtLa6pQtNyz1rEU8zYx7mRZfFYVVk9/pn5JvW/fYXO2G5rIH6qWcl
 qyeg==
X-Forwarded-Encrypted: i=1;
 AJvYcCV00D30c02kiSbSr6SiYQW4VLIfLtxNzCITxomRkAz20x0OM1DNh3EJAZsZV6Px8u0LjqkayNh/sLRk@nongnu.org
X-Gm-Message-State: AOJu0YxOvCbkHdtO91u3G5joc5qMrePdPq97mrJ0XG+YaJhrglHDQ3bO
 QlY7gPuGsWaYvphhBmN01LH3TCy7lAWO8frxEtPZn485ZittTAT6284U/EEMWJFVmfI=
X-Gm-Gg: ASbGncsnpcLxMlTyunGrXrHwsUPx8oto0JDZYENvI0NsyyVHAFt6aaDPQy0OY2rSQML
 lg0xPTXEcouNqFvMfQHWcsbDtXjK8C5HW+xb6K4ijNzYtm36XYV8QOIqc68ETR742hf3l5kDIXb
 MdO10JiJeEXAjBRuwKwC+1D87eGFBf2KRyehHGzppGiGsOmfpy2lwYYqjLzES+TjOyWQyWJ/8Kb
 Ei+p+zWKDEYX7WAYkvDV7GQB1Ox+iiYaCnkuGCGEoK7mYZJg3nY59qpEVEmq+sXc5e5Gb+eRNNI
 9ojG4YWUONbDK+jQTEyUldulllduGbyNjyCHqaQSDVA77Fv4TrxPL/5Cz8O42Hxp1DT6VABlfdA
 vjPgY4XD2oa/AvCjrC3Dh4zCwp/H333J1k0rCCjFhbUO+vw==
X-Google-Smtp-Source: AGHT+IE/3m25bXE1jg8MeV2TjFIMSV4dGivJ7gf08btjmEclwImSa+T6lteCbHKHg0/z7k86bMKX2w==
X-Received: by 2002:a17:903:291:b0:240:7fcf:ced7 with SMTP id
 d9443c01a7336-24096ab043bmr69373475ad.21.1753908083326; 
 Wed, 30 Jul 2025 13:41:23 -0700 (PDT)
Received: from [192.168.1.87] ([38.41.223.211])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-241d1f2193bsm152955ad.70.2025.07.30.13.41.22
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 30 Jul 2025 13:41:22 -0700 (PDT)
Message-ID: <c8a13e38-d29d-4150-af61-d810d28ea41a@linaro.org>
Date: Wed, 30 Jul 2025 13:41:22 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 12/82] target/arm: Implement PIR_ELx, PIRE0_ELx, S2PIR_EL2
 registers
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
References: <20250727080254.83840-1-richard.henderson@linaro.org>
 <20250727080254.83840-13-richard.henderson@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20250727080254.83840-13-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::631;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x631.google.com
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

On 7/27/25 1:01 AM, Richard Henderson wrote:
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   target/arm/cpregs.h |  2 ++
>   target/arm/cpu.h    |  4 +++
>   target/arm/cpu.c    |  4 +++
>   target/arm/helper.c | 70 +++++++++++++++++++++++++++++++++++++++++++++
>   4 files changed, 80 insertions(+)

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>


