Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08F14CAC5A5
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Sep 2025 03:21:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v1G44-00018J-4M; Tue, 23 Sep 2025 23:21:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v1G42-00016m-9q
 for qemu-devel@nongnu.org; Tue, 23 Sep 2025 23:21:06 -0400
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v1G3w-0000ZT-4H
 for qemu-devel@nongnu.org; Tue, 23 Sep 2025 23:21:06 -0400
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-46b303f755aso33480735e9.1
 for <qemu-devel@nongnu.org>; Tue, 23 Sep 2025 20:20:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1758684054; x=1759288854; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=YLX49obdJMPMpGt08w9a4FQVU1y9F6W/ixg4YaEp+FI=;
 b=f9yfDy21kaHQnKwXOYGYu3jy0/gz1dINX5aJi07ThKeG4vlwxrFoF5RVqbR3M8Xqgu
 DotQj71+YSgkfMjLNp+Dj/e+fbxv+c1s1RlJvFRaln4NuVaMzq4+WWnLP32QjFqQV82/
 j+CwhsEBlIEO+5Ff6EGQFzGyjS/iBFMGfoBlyvAmluV0IQcgRNFYYQDu8DeyyDv8JsHT
 7+RnWOcjdt+jyO7C2jOY99wPgvC0wxpMFASzfFX4n1WghRKQ4HE1747vPGfus2oBufdB
 7X6DxEuSa7mhEO87dXF7VjABwWVyp81rEdRWMFjhr+/HLodmuH6ygXVUvJThqJrT+eP8
 1DmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758684054; x=1759288854;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=YLX49obdJMPMpGt08w9a4FQVU1y9F6W/ixg4YaEp+FI=;
 b=DMNb2tQgwDuFCDKrij9e6wYS622FanPSrestY0Xt47GEUMjrIXvtFVzbiM4v8ikI6f
 HabSYrQjBE3jBSurJ98DiXPLs4kndL1UTuUKLV98GTZNF5NfbvEP3r7NBfMDbgUbI8Bz
 HAYeu6qtehVFhmiGSq8wgmygZom3jt6XRTFibDMpqDTnYpbB++yDaAuTPjMJZRAynIDh
 aaw8TIDeaI2P9lUIraBZ71lPoDBrQP8BRcgFFZfKBebnaaPloM3NXnM7r8pe1ntjlSMg
 weX8mSeHL50NwxKUomhV8Do/MNmQbzonEXgEuI7U0glI7mef3s1AE46mYoUCzgWooCJv
 0YMw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXTuydjAP58V9NpBpx9bxs2iTvHwPs9MDJXNzfR7NTWC+qkbSvfONTKBhQ5Zw84M+d91hCF8PfG3cWt@nongnu.org
X-Gm-Message-State: AOJu0YyR4xJCAJhHavA0wkOhFvVpM3lIvmT0UvFZeiu1WJxHsF369no5
 naiPaGeZ4Yc6YfRgaBnVKwdXrf8CCicba3C+oZvnavcSs+goTqTJ0FUx9EMUL90AyUo=
X-Gm-Gg: ASbGncva3pXFO/+jBEZLfOgh6iSKMsNitAZIrNxZP+6dpng0C1OzJyXrn2eXRDKmxbq
 9Ai5ctLNlMHAaAajNUnr5iiuHGL8uA6bFUleJMRAwAwDs+zvTM25D4DvLEub9fss2rxOuBUiKyN
 yCg+jaNHjTxZbAo/6xL3o1kfRYbgjPolfv9dZdc5sIBwUyZ/X7kKJnGG2EFWKET5ddKAjVinAOS
 dnBdsKf/Ez6t6SIHUdU24r99R2ECs50Jouy4wbtlv5bkFdg74WSprQifGOYPL9/Vfz+sw6lYzR3
 FU21fE+iJ8TrGcjpnnJ7lupn+7+1JMI9jVqns2Q84wtUNO8mU4+FWAlY00XLwLuYbdN2Ef7B2zB
 L+3eteWrU9SAJ9u/omi9jPI0WH2Gi62cMeEm5qkMcFP4ZW2+NqrETFhYF5C7uY6Oukw==
X-Google-Smtp-Source: AGHT+IEEr5Mi8w2EoGQYuWmbSxGy3aD3mqYVBts/QDhtbGYrt7YI7Gj6Hi5xyqfOMc53HJ8tih20Aw==
X-Received: by 2002:a05:600c:a48:b0:46d:45e:350a with SMTP id
 5b1f17b1804b1-46e1dab50e6mr54933205e9.17.1758684053784; 
 Tue, 23 Sep 2025 20:20:53 -0700 (PDT)
Received: from [192.168.69.221] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-46e1cf8fb6esm23507515e9.3.2025.09.23.20.20.52
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 23 Sep 2025 20:20:53 -0700 (PDT)
Message-ID: <1379c80d-ede5-4afd-9ba4-97dc34c76ab8@linaro.org>
Date: Wed, 24 Sep 2025 05:20:52 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 04/10] hw/ppc/spapr: Use tb_invalidate_phys_range in
 h_page_init
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: Harsh Prateek Bora <harshpb@linux.ibm.com>
References: <20250923215425.3685950-1-richard.henderson@linaro.org>
 <20250923215425.3685950-5-richard.henderson@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250923215425.3685950-5-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32d.google.com
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

On 23/9/25 23:54, Richard Henderson wrote:
> We only need invalidate tbs from a single page, not flush
> all translations.
> 
> Reviewed-by: Harsh Prateek Bora <harshpb@linux.ibm.com>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   hw/ppc/spapr_hcall.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


