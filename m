Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0CE3AC87FD2
	for <qemu-devel@archiver.kernel.org>; Thu, 31 Jul 2025 22:04:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uhbNF-00025w-1R; Thu, 31 Jul 2025 18:03:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uhbHA-0000j5-PO
 for qemu-devel@nongnu.org; Thu, 31 Jul 2025 17:57:29 -0400
Received: from mail-pf1-x42b.google.com ([2607:f8b0:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uhbH9-0003w5-AU
 for qemu-devel@nongnu.org; Thu, 31 Jul 2025 17:57:24 -0400
Received: by mail-pf1-x42b.google.com with SMTP id
 d2e1a72fcca58-76bd050184bso1272801b3a.2
 for <qemu-devel@nongnu.org>; Thu, 31 Jul 2025 14:57:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1753999042; x=1754603842; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=c8K2ENVkHObB6eaxJt/lxbHu3SyT9KYMZ5ymlsNoBKw=;
 b=hYdMciXR5bobPwTaa939tor9RiJWotsqwsDIebnJ4OTHDV4tFolBFazeVCYtUZi1Uo
 83rmLFKZ9npEbeMN0xoecy+lTm+ehmVngj0sRx0atulaFQQjm0GDnJ8uiYJ2+6X7TDPz
 tOQfU46AUDnOPbNarniG/2TTJ3dQz/LtnnCcGWPT0CpWg7KtMOsKwvvFS0skL70YCmym
 vOy1/A/rV95bz+ivgHAmeVCnvjnT8bMqA+hJU4dcDwrVbM0V6US1FU3KuK7Xr76ui3Lq
 H6+NDQRM5Uv7v96baCetFa6sb4y3ceOVl1Eoni26V01Md3uqg8/myPd7Xw0RKqzGMguC
 GPVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753999042; x=1754603842;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=c8K2ENVkHObB6eaxJt/lxbHu3SyT9KYMZ5ymlsNoBKw=;
 b=pHajacoJUvh9pDBZ+Dx9UHb4EMf8MuQeQZDSIEeux7egrlzyWloLazi6s0msOp58ag
 X9U3A8FNAn5t1wu9pWT3gZPiZkKcBKc09/OEXL4BXyH5AITL7ztLHQ7CjEpQUT5ojeBu
 krwCVhd53SCv1P8JsuyeEXTuR62CtlZIGJAgUemX6+Jp9UmocIieBSZKM25PF2Iyeow3
 7H3SNvD2j7prBPKOwuQ+H/SlJ8FbjidNEDKlLfCIes5qcWkMl2i+Y0H3O92iHHaqDuKv
 +KVR7GntQdK+KGeT9M6uWNCn+OfXhNdQMKKb4LAHSo7v5PydRqyIUDCMMoIIM2bpzWth
 SVVg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWL8nkEGMXOyYMX31i+KeoWDNi52X6Yte4c4N8Xc5ez7dnWlCNGj/eSAcI0vuRmqZjMghiCniAnNfI1@nongnu.org
X-Gm-Message-State: AOJu0Yx7eUWiNANJn64hH2gfNylNPdc/a1HX20BnDVDdk+EwyDX9daup
 DW8oh1uIcZOXEewHQdFegy9tk+G0g71iw8720vrirmAlvjEDpHB1QVhr3Ftt7a7rgiI=
X-Gm-Gg: ASbGncthR3N4+TuKo8XOzXHxJkLlQk2FYLjI+zAsAy5kuWVJzeD2Lfrta/7qEx3JRFq
 tP3UmkkcMCQyk7qlSmlaz5iiaftMSngldqeDqLGqYZ9oXRBoeFgePZ9pdxx4O5e7Gm8invCNqyT
 w5Wl8CGkBjl+b2C19/GWZtar6Pmp+J91ptqNPRGOz0/q97SIktcr6ShLRG2CifJOg47dibgn4IA
 8MblP/KyHEL67WgQCTX+BM8NFCZxVQUKe2cTfMxyiyhTCLFHJ4M/7qD+z2cZ7JWDV2rzxQesk0O
 NXqhXZVw8F1qTdXTHHceYbDdah8i+L21jsci+vtIBGBLln8SVMwC28v2We6LKwXuQa8+9Z2YtGu
 LpFxxxN2N9QsH5/yRJf/UOaFis/BgLvQ/nHw=
X-Google-Smtp-Source: AGHT+IGixCdcT/eUzNoL305PtAIKLv3Gl8m5VzGLCVrOyXRHKflufVcwXOmeD6l+JlROSSbPp6CT0g==
X-Received: by 2002:a05:6a00:22d3:b0:76b:c7d3:f54d with SMTP id
 d2e1a72fcca58-76bc7d3f702mr7496369b3a.10.1753999042071; 
 Thu, 31 Jul 2025 14:57:22 -0700 (PDT)
Received: from [192.168.1.87] ([38.41.223.211])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-76bccfdc25dsm2491518b3a.110.2025.07.31.14.57.21
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 31 Jul 2025 14:57:21 -0700 (PDT)
Message-ID: <d229892f-37db-4878-aec6-dbad64619cc6@linaro.org>
Date: Thu, 31 Jul 2025 14:57:20 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 77/82] linux-user/aarch64: Generate GCS signal records
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
References: <20250727080254.83840-1-richard.henderson@linaro.org>
 <20250727080254.83840-78-richard.henderson@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20250727080254.83840-78-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42b;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x42b.google.com
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

On 7/27/25 1:02 AM, Richard Henderson wrote:
> Here we must push and pop a cap on the GCS stack as
> well as the gcs record on the normal stack.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   linux-user/aarch64/signal.c | 129 ++++++++++++++++++++++++++++++++++--
>   1 file changed, 123 insertions(+), 6 deletions(-)

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>


