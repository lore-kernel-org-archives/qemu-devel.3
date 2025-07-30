Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27D44C87FC9
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Jul 2025 21:19:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uhEDE-0001Pn-QU; Wed, 30 Jul 2025 17:19:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uhEAQ-0003om-R6
 for qemu-devel@nongnu.org; Wed, 30 Jul 2025 17:16:55 -0400
Received: from mail-pf1-x42d.google.com ([2607:f8b0:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uhEAO-0008V6-S7
 for qemu-devel@nongnu.org; Wed, 30 Jul 2025 17:16:54 -0400
Received: by mail-pf1-x42d.google.com with SMTP id
 d2e1a72fcca58-76b8d289f73so227801b3a.1
 for <qemu-devel@nongnu.org>; Wed, 30 Jul 2025 14:16:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1753910211; x=1754515011; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=15jtU3lgpXWl52esT27DLThhvQtwMeh3ZCHR7rBmV9A=;
 b=XywqpkAviZBaU0r6C6EPeGBNLMXxx7kpNkbbZmINUQfuOH/tNbXEpqHA0YzsBiSSwv
 PGfSN53NzngJHeuoYBDflvQhCJym+sq59qpbKrt7azH63A8wNvVmK+QVcY86KO1jHyUv
 czuLPWbJpaPQI5qr4cnZssfKS1fK6KU5M7gEr19ax9NIBuSDosNlbZqVAiHwI216saUg
 IGSrNAYGI30GUNLjucjG4N+pryVbT2M73T8JiPgnKFQO2hwZwKVwF5rzlTqXkU9mj1kL
 YclKGWVoRhLGT9hq/xxAohVmGYiz52+ghclAJfBCWNhyurNygB8S2LU/6TxAzoVEtznq
 Geqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753910211; x=1754515011;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=15jtU3lgpXWl52esT27DLThhvQtwMeh3ZCHR7rBmV9A=;
 b=l/BrHHJ9oUzcd763wakLjBQJ6yPTenjRuFaK9ru9TNFRdvay1/Y6CxSV7IQbgRQOny
 gzBkI/AQ5Y8xfKHa4SBA2MsyPGWJcb/FXWpahztzo9JWFcgIIK2yl9Pm7GAANHbZqxGu
 56B8lX6CogHUdUfHRSe3GSQIsXf3kW7lmBvHK2YWHrrl6lfZ4rwx6ktlw7Igrt+jYfOZ
 NtuMSFd5s8GLDpZdEP8rYzWAoRf9xVDrTeoY4WOZqzV3dENloo5vqcG92sfLIV8+YGNE
 Q6ihN0QXxrq+MuAra7qmZaHJoX45ZVJhUZsg0ibZTqJhYdcD34qMEDMNjNnSUF91HQbu
 Busg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVEN3G1miziJ5H89SB18E7FO884IOSTuOM3Op21uP2mjFjSYVbVCs99xn0yshAAJy/nXqdy1FYKZMGV@nongnu.org
X-Gm-Message-State: AOJu0YyPW6Ubs4fLmX8FfS+xiUg6V2+WR3LJe1djBJI8JxkaqTHueq0t
 b/CzKJSP2K9NU5Sbm4BJM2cZE4ZPBAFTStvJ0JyxLYvIYOkS3VWgvMJuHI5Bdo2GuVA=
X-Gm-Gg: ASbGncu5ICw+ytdCBh+/SU4LPzk1qVOZFSr8xQryttfbk7/3XgvPXkj49VVy4bbZt+A
 79KUJgC/bBz+JV69OpU8+0CSyeHYT/Zyvou0zaVEPUiCjg6AWB12DeOYbRNPHS37nO3L27q+xH8
 DU16+EMSzXjaEA3zc5ZJQWbVZ2rgYAralLlKRKKCzNu0CeN3oSdD8dbGtPUR2yuBn38spBJ9pDo
 vqodjlfK2vvJAz2pLm214nsnbUUygq1bjaZ1Ek3HxmMWF9P/lfpZmAO0kQ4Ufgh6raihRA5m6xb
 nkD2iIBMHsZD8VWfql9T94TvxmQYrj7arKEDc7WADXdbZ218EBdufBgb/k0bt5oUjGa5PD2FM7L
 U3MZh3mjBOMROFx19Pj6JBBMLerCboVKFDOg=
X-Google-Smtp-Source: AGHT+IF8phU/OOuU/bjfsw5AEMPuRpPD1ArsGroIyyoUtfRaO8CdUthd1KMRLM3tZKVp4VS01eOIbg==
X-Received: by 2002:a05:6a00:949c:b0:759:4c66:9917 with SMTP id
 d2e1a72fcca58-76ab30cd7e7mr7343402b3a.20.1753910210971; 
 Wed, 30 Jul 2025 14:16:50 -0700 (PDT)
Received: from [192.168.1.87] ([38.41.223.211])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-764087294d6sm11470269b3a.21.2025.07.30.14.16.50
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 30 Jul 2025 14:16:50 -0700 (PDT)
Message-ID: <5e11f3b3-3a56-42d5-96f7-dab50d6c7759@linaro.org>
Date: Wed, 30 Jul 2025 14:16:49 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 33/82] target/arm: Convert regime_has_2_ranges from switch
 to table
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
References: <20250727080254.83840-1-richard.henderson@linaro.org>
 <20250727080254.83840-34-richard.henderson@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20250727080254.83840-34-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42d;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x42d.google.com
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

On 7/27/25 1:02 AM, Richard Henderson wrote:
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   target/arm/internals.h       | 28 ----------------------------
>   target/arm/mmuidx-internal.h | 17 +++++++++++++++++
>   target/arm/mmuidx.c          | 19 ++++++++++---------
>   3 files changed, 27 insertions(+), 37 deletions(-)

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>


