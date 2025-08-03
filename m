Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04AA1C87FD2
	for <qemu-devel@archiver.kernel.org>; Sun,  3 Aug 2025 01:00:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uiN50-0004iB-5z; Sat, 02 Aug 2025 21:00:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uiN1v-0001sj-Hf
 for qemu-devel@nongnu.org; Sat, 02 Aug 2025 20:56:52 -0400
Received: from mail-oo1-xc2a.google.com ([2607:f8b0:4864:20::c2a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uiN1u-0007d4-4R
 for qemu-devel@nongnu.org; Sat, 02 Aug 2025 20:56:51 -0400
Received: by mail-oo1-xc2a.google.com with SMTP id
 006d021491bc7-61997c8e2a1so419057eaf.1
 for <qemu-devel@nongnu.org>; Sat, 02 Aug 2025 17:56:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1754182608; x=1754787408; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=bPx1fwNrKUvD263O5OlNaqN/0Vo8TkktzT4hE/upl7M=;
 b=mZUU1Lw+SBaM1uAgGbzCC/SBOEG6VuEcKo4jjeMn+3WBnKyQJacPoHoqhgK9IGNY6U
 sflKYyEWVWOvJOUjh4BOAkOxqsP7UAahYRMBk28Z++TzJ8B3WUZOecB5pGVLLSmwjlq0
 AyuJuj9mncKrF64nDlnv7127LNU8PaZp3cvak7cBmQBLhmRwmicKK/FmlZfz+nulBEqF
 3O3NomFQle1hibu8s0nWKAINVyw4acOwgmQ3+qH4crfZ8JwN3gB3p9cq54GEkdiZWzYe
 Ci6Gx9U+v3uo13sZSCubAq7dJJaRpIeuChpx2H+2ZcNbqMfxV1HXi0As1ifSj7v9mnmR
 7RUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754182608; x=1754787408;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=bPx1fwNrKUvD263O5OlNaqN/0Vo8TkktzT4hE/upl7M=;
 b=qEP+XMieM4K5Wu95xpFYLGvCco+qKcLFXvHHtgkWiPkhEcGbNK2Sw13mTMlavAESlb
 FlF+9y8/YeMMcnaNdpoqMFvOS+jnzG6Ib6tguhJnHaDvryVOalRPq0sD67LAwxPnN9PR
 xRSAC7nhxZQH4uMpLxSRk7Zr4VdhkWytlptc9fFLD0VivubA9zFEWeJvTkYMQ0GXvIQc
 j7TUsFcBFA72zwkKBDi5xccfldwrr4qc1WFvT19abRT9aJnIxS1YXvfFWvLy/wluHPxH
 umZv5HBCYdbLNxLC30a3yz3iVrVhTmrgDbCu30w2HaE6KfHgBDK7KRu6u0yLgDVmSN5g
 Ih5g==
X-Forwarded-Encrypted: i=1;
 AJvYcCVMPcEfd9H22fyM0YMV3bAqhXDTTDbDyRULXOXsh2iaW5dJ3QRg4kxrn9FNeB4wdIY7ZfV5GkiPsZwt@nongnu.org
X-Gm-Message-State: AOJu0Yzcrym9Zae7AVzpaR78hhTKwQT07+wj5je9TqtcMSPWesjmBuPa
 acVK54pU8PFPu3Ua3SFHy8of7HMSfKuvS1WSjpncZtJkCd3r/3z+xK6B9GTgGjJklUw=
X-Gm-Gg: ASbGnct3HPtGsXdDETtNBdaxlCSbyxUOuCf3aHUPYP1QEx/QAVEtX7do1I9sJbGaXyM
 ALcV+CjRd0oBmuar2DRpmrS7LROeMwYB+mib6XpTTrlW1eiyxWkcRsG+Slt0JBo5BUp56N83EUN
 8Eg75t0oe8QFKkMl7sGpt5LndorMiYtkev1AVajvY1qSW7anrO4aovvo3XNYYIBfXQyEJ/QTcOr
 S175+6/tCk7BWrAtKnk0RGAj2GcfrgTz/5uWpXQLpxcTWh3GDAF0n06QjqCRZtO53TKk0NSp2ay
 7NnHZvur3iUkk2X/2SnIUUDGi3wmaNWtt2TJ93ewsFwGYI0Eqd2Fy64wOZO3gSZmE6NQ0m0zC6V
 mzNEMNUE6L4S3wbZwJ+UOmI4n4W2UOvHucv44YMBFkQFMSgW+1zg7zr1ZnqAv8uyf
X-Google-Smtp-Source: AGHT+IFtIzj4Hi4Ph8bsAk8zkX3TTdDyM7z5tqyRglLWww8VS9H9OUbbRoThA2ZrK5FZ8hDdHuKa0A==
X-Received: by 2002:a05:6808:3087:b0:41f:500e:b902 with SMTP id
 5614622812f47-433f06594aemr2796784b6e.10.1754182608609; 
 Sat, 02 Aug 2025 17:56:48 -0700 (PDT)
Received: from [10.153.194.227] ([172.58.111.133])
 by smtp.gmail.com with ESMTPSA id
 5614622812f47-433568ea5e2sm1524466b6e.3.2025.08.02.17.56.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 02 Aug 2025 17:56:48 -0700 (PDT)
Message-ID: <03ef3162-8993-4224-acf2-ac1cd0defa86@linaro.org>
Date: Sun, 3 Aug 2025 10:56:41 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 09/14] target/arm: cpu: mark WHPX as supporting PSCI 1.1
To: Mohamed Mediouni <mohamed@unpredictable.fr>, qemu-devel@nongnu.org
References: <20250802081800.76030-1-mohamed@unpredictable.fr>
 <20250802081800.76030-10-mohamed@unpredictable.fr>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20250802081800.76030-10-mohamed@unpredictable.fr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::c2a;
 envelope-from=richard.henderson@linaro.org; helo=mail-oo1-xc2a.google.com
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

On 8/2/25 18:17, Mohamed Mediouni wrote:
> Hyper-V supports PSCI 1.3, and that implementation is exposed through
> WHPX.
> 
> Signed-off-by: Mohamed Mediouni<mohamed@unpredictable.fr>
> ---
>   target/arm/cpu.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

