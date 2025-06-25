Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83E84C7EE2A
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Jun 2025 14:50:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uURRk-00016D-S1; Wed, 25 Jun 2025 10:49:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uURRj-000165-CC
 for qemu-devel@nongnu.org; Wed, 25 Jun 2025 10:49:55 -0400
Received: from mail-pl1-x635.google.com ([2607:f8b0:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uURRh-0005MF-EC
 for qemu-devel@nongnu.org; Wed, 25 Jun 2025 10:49:55 -0400
Received: by mail-pl1-x635.google.com with SMTP id
 d9443c01a7336-2353a2bc210so60088065ad.2
 for <qemu-devel@nongnu.org>; Wed, 25 Jun 2025 07:49:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1750862991; x=1751467791; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Y3VxumaolHYyFfuT8qvUDY22bgfxJFSKF8n8eWqVg1k=;
 b=ClZajVMcKLVHi8mCGS/ChwpLqybg/9GB8vxEAihcY2hJer6Wg4jfBmiwxvN+BnGL2B
 gNY7bbJLesZxXzcWGe0ncOBuyarjJnwCBa4FwyMNC3IMsiS39hzxQSLfCtmv8/qCfzzl
 woAd3Z2LYYmKGAAoZuMSs5s9Z0WRzreI3SqpKeEdnABRkuMdyLzWdCV9eit8iUQugKr1
 ozx79BmwI0o2tUoIP+oGh8Q++g9Pb2YKQ9toP2aaNWSsUjmbPnBPOVkldRbPVjQG7NvC
 f31Mnc9oGrjRaBm9SBr5U9QW2GsZFZdKurw6Um+2fo66gfZmt1WGQyrc9uVRSJHnj/e4
 SAHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750862991; x=1751467791;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Y3VxumaolHYyFfuT8qvUDY22bgfxJFSKF8n8eWqVg1k=;
 b=q1dQwT5CHQ4niLK0iClmmp+EX4kwszPeSIT7oS2FB84gbIcamB3cvOtmXIujzR5Idf
 o2FEIjka2O1D4Z7qI/cbyjN+VMNJp2Qh5TlcL2LZgOpu4ueM6ZtLC3TdpRbuJPnlwUL5
 ACS74hKIdNdpPR/8S2hIX55wDvzHYIHj2vzOLcXkmoLFU1LUxShAR4naC6b56QUZUztV
 0fjmBoEdNKOhI9ppL/cI17GhTuHePN4KOM3KySVp5CDxue81sFnwsIDbTWxpZhKn4MDD
 Uc+vhv9ib36mHCHHLjxMWdXbR+6I9WZ1Ojmqd7JfCkIF5GDLETiDisExKwcWNu0qrxEF
 +IDw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXp7aTTftGJiN3Vplsu0BGSyuvau8ApnZRB3msPXVXlGOamPoKZqltELvowg+FtkFMjeoCFnb306Uk3@nongnu.org
X-Gm-Message-State: AOJu0Yx72SdTNSdQij6bwSnKZUN6nYoo0w3KRjaTqgeaUcPlRkUEl4E+
 7StjKEWQKXClonMY1BB2tCSWhfoFmlULn8dewEth/kao3K2xqmSt92MdUtRaffYgYGU=
X-Gm-Gg: ASbGncv1w/CKt72hroqy4Pbf6I08rgctYBHEyyqgEmyYj7gu2sYDbb/x4BDEmS/cF8l
 rdPIS2ifaJmgWoAAbI8nat0v8MKhT335gTVWOnw63dKDjGngbBnev93Q9PvUFTRy9X9i4IsU6v/
 zEbQ1zPImt1ejs97D7+vDcm80GH4BrdT129vXwJjwnDhhPzUNR9+dISGksKG18GUpQCllh31SbH
 Y2r1eNKRinLjKRhUsjJ79iMRTcJxjzDIqry/qw0HOmr+xR+/rb7x9XR539xq1R6F8LfivQm8A/s
 kAZeEKY2hdKJ3DmF7hcXa7ZhAI5nkPu9ix+RNlTOwvmQ7OV1WGl513+sAn974AR+tWIUqcn5svE
 =
X-Google-Smtp-Source: AGHT+IG8RIVfswRdbRMpr2y7G9vQgb1xBwT4rg1Y5S0lQTIhmGpYdl10MANQYcNmkSKW13fRL88pyA==
X-Received: by 2002:a17:903:4b30:b0:235:129e:f649 with SMTP id
 d9443c01a7336-23823f99aa7mr57752175ad.12.1750862991655; 
 Wed, 25 Jun 2025 07:49:51 -0700 (PDT)
Received: from [192.168.1.87] ([38.41.223.211])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-237d86f701csm134186885ad.217.2025.06.25.07.49.50
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 25 Jun 2025 07:49:51 -0700 (PDT)
Message-ID: <7d830685-26bb-4a5c-b62d-9a3933859f62@linaro.org>
Date: Wed, 25 Jun 2025 07:49:50 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 12/27] tcg/optimize: Build and use o_bits in fold_xor
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: pbonzini@redhat.com
References: <20250603080908.559594-1-richard.henderson@linaro.org>
 <20250603080908.559594-13-richard.henderson@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20250603080908.559594-13-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::635;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x635.google.com
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

On 6/3/25 1:08 AM, Richard Henderson wrote:
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   tcg/optimize.c | 9 ++++++---
>   1 file changed, 6 insertions(+), 3 deletions(-)

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>


