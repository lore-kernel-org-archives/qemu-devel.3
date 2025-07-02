Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72B33C7EE30
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Jul 2025 02:47:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uWnUh-0007Or-G4; Tue, 01 Jul 2025 22:46:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uWnUf-0007OH-6O
 for qemu-devel@nongnu.org; Tue, 01 Jul 2025 22:46:41 -0400
Received: from mail-oa1-x32.google.com ([2001:4860:4864:20::32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uWnUV-0006ot-2M
 for qemu-devel@nongnu.org; Tue, 01 Jul 2025 22:46:40 -0400
Received: by mail-oa1-x32.google.com with SMTP id
 586e51a60fabf-2ef891cd058so3094142fac.1
 for <qemu-devel@nongnu.org>; Tue, 01 Jul 2025 19:46:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751424389; x=1752029189; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=96n9EZ8b0C2EwsH/ZJ4qVSRKyT5trAiRa//5q7yHY3Q=;
 b=OzSTEhbLn8ISiD2w8mni+geKlYaVEDAeJwnJO+ioZEU1lGlio/6fnjDW8GpWibj8bN
 0CDZGlhvzxoVE5ZjfC6PSwuuL95mJ9MJpdEmlXmwPohaIb2FhfJK4jySLKTeUR+1/N2m
 JQiBhWog8rDPZzNhuFklO+Z60I5TZS14m+V0pGnf44hCneRzmXFBjEiDulfnTBWL+Ppb
 AOYj6IuhxNaTzVsbaAGVO1NN0mTYwSkwZn+z70GsndnHYYh8Q9L4bRKyLZPrCYTyH06I
 MGD5CQNq+7ek5JNBrIIkLhkCJMQcGCV/U6vnzvA1I0RRH9mKghYkKo84nxAUXL/OchTg
 cANg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751424389; x=1752029189;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=96n9EZ8b0C2EwsH/ZJ4qVSRKyT5trAiRa//5q7yHY3Q=;
 b=k4Z9SJBWq98K5TAS7zpSFWG6LYCAT/wiJYFgePeA5Wk6uaBBkKxaToHi28mdKyW08S
 38o2JWK6ZfJ5yXepCv4AroZWHIS0oCslv601tWViwbLeFufiRHiBByaHiQyrQxkMP0uf
 RXhhxt1WdlbCZ75RMVm5CiilZPwjdDf+qVJTyLVjZqQl3hGVBuf69bbZWhBKlKYprkPO
 NC0XaetK7hXb2PC+C15N1Lf0enrd1hDw8Y7vyhU1Zk4HZxt/u5GwRl/catYOAftguqYU
 LfkYR7qNqbh5xIiJloDjNzP3Y8IO0ZPQ6KVCEsDepjRQkN2kYV0x+54dgqkAT017czbZ
 N+zg==
X-Forwarded-Encrypted: i=1;
 AJvYcCX3NBupEqnVPOTN6B8tQNeTTnpknY4W8UsiKZZd4E7T2bNIPO/jpdaV31ENnSyGuKYM+Y4STS5j4xfH@nongnu.org
X-Gm-Message-State: AOJu0Ywdea82XiJW0ETDPGQREtUzcGiN0PMlum5zgv7xrp1eIurF3Ofr
 uaO89NOLZb+YBhybCZzQhEg8qhaaUKAW6M+pzYEs4q84Z5BfMSUUGJSxg+zfhllfLR4=
X-Gm-Gg: ASbGncuyH/OFgj0EIePfbTc2ZqGRikeqv+uJdlZi4loF4m58VN7rJL7sz227KA3zpKi
 U8Mi2UUxvfFdJjakhJTjqmuEasyoib6a9cD+rsjVdBnW4SYB3+8ejwLeji2kblKU/I1C6x7VmM4
 xuaGsRk1Lqm+eOEvdVHm+p9fMdBFnhDQIaOiu4gmymCpbieH6Hf+lOePzjDddHM/BSry4XYhBv1
 dyMTLZD/qpG/T6eMXXcHXyhwSdQPIqm2f73jsSeL5qba7gJ6wU5UHp7IfALqLhWY9bl8Gt1WvrU
 XDNb+wDSo6xPuOSmYCQWwaUgl1fk4uY4SDr2spzre/KZq4bBRtkyObTtf7lcdkVVikWgK3JSndG
 aWw==
X-Google-Smtp-Source: AGHT+IEoRDMDm3Ftn/aO6k5J3H50g5jYMGinid7/SIVbddVmJIgv1kAov+22pk2AUCSHofTkTA1dxA==
X-Received: by 2002:a05:6871:282:b0:2bc:7811:5bb8 with SMTP id
 586e51a60fabf-2f5a8c8e55emr909357fac.18.1751424388678; 
 Tue, 01 Jul 2025 19:46:28 -0700 (PDT)
Received: from [10.25.7.201] ([187.210.107.185])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-73afb122a27sm2352181a34.62.2025.07.01.19.46.27
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 01 Jul 2025 19:46:28 -0700 (PDT)
Message-ID: <1f354c18-4a7e-4e0d-8f7d-5a27269ab99b@linaro.org>
Date: Tue, 1 Jul 2025 20:46:26 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 14/68] accel/kvm: Directly pass KVMState argument to
 do_kvm_create_vm()
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>, Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Julian Armistead <julian.armistead@linaro.org>
References: <20250701144017.43487-1-philmd@linaro.org>
 <20250701144017.43487-15-philmd@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250701144017.43487-15-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2001:4860:4864:20::32;
 envelope-from=richard.henderson@linaro.org; helo=mail-oa1-x32.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

On 7/1/25 08:39, Philippe Mathieu-Daudé wrote:
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   accel/kvm/kvm-all.c | 7 ++-----
>   1 file changed, 2 insertions(+), 5 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~


