Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B24FC87FCA
	for <qemu-devel@archiver.kernel.org>; Thu, 31 Jul 2025 22:00:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uhbK1-0005ee-8H; Thu, 31 Jul 2025 18:00:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uhb8t-0000KF-HZ
 for qemu-devel@nongnu.org; Thu, 31 Jul 2025 17:48:51 -0400
Received: from mail-pf1-x435.google.com ([2607:f8b0:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uhb8s-0002SC-2x
 for qemu-devel@nongnu.org; Thu, 31 Jul 2025 17:48:51 -0400
Received: by mail-pf1-x435.google.com with SMTP id
 d2e1a72fcca58-748e378ba4fso2001304b3a.1
 for <qemu-devel@nongnu.org>; Thu, 31 Jul 2025 14:48:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1753998528; x=1754603328; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=hO5JyWHKxi2Jv2W5ftG0yToSzBkMlRmQ8qKyW5GQ/jo=;
 b=El7OzMXHj8RWgANrxoDxTMp8g8Hg0c75mXQH3iaaffN19uPh/MVhl4nP4WZ4ViAMTb
 JV85+Eh6kbxwDVRRIlgnKQNc1NaPgU8uYpa4fUBKXKKqk/cObImZftEQn5GXWOlb0CRu
 j0FL9XmOoD4LtCOhxiIzBoBjL6VaG3qPmCJj/DKKIBly3aQ4Rmp3ESr1faY4qNX8MMPL
 9a9x6Q5BW+sNuivsw3j0RZwPkh71FDRPwSzqmPxSC64qHTd8Rf6feap9CijCIhb5m4gP
 Yts5IaaoZFBMrg+0fTOYQ0n6WwBHm8kw8ErnJwDtGlc3OKYSNQlrROwOCGB7GGySBaax
 Ousw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753998528; x=1754603328;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=hO5JyWHKxi2Jv2W5ftG0yToSzBkMlRmQ8qKyW5GQ/jo=;
 b=FKRwOtUgVcHJ7Sa+nCDD+rjhDQE0Gof/kaX6om4uEjE1r+UGUUohdqimAbrFu6b2QE
 /e5/Px1CZNalpFRMyd07sP3ziyoys/gHbn5iv8DAsPjDFbnmcnLQAsHi34Dt6h7GaZJV
 kWNuXjqg4hz+H71TR9Sf8YXMvime8wC9RhNqfk7mtmfoOtYKAhk1SExkIuCefTsNFquP
 VdaTQCU16nm6et5q1Jd3VaRb0yQWJirGHlTA7WA82FlcZIpIN3hflrXnXsSD0iYL4RLU
 ujO6WE/VQEslZft+cpDHWAEheJB+WKhCXzDAv9WW9tu5agqSyF8nE+ghhz2bV+41dzk9
 nXGQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWbzXZwHD4AgVGTZf2skRcF5MFpnP/j3fag82Ku0VuESC/9GnSOlbDsXZsmlwJZsvExxE2j27ZkSkcX@nongnu.org
X-Gm-Message-State: AOJu0YweZsVPrObFaEAdAVuwTbIan+tZmzIwGMlkShVjbkR58Qmi1yrc
 3Q3Pko8ZangJsFdHwoK+5Q+5vdtaZflFU0anGwo8t/UuMqW6mXqSIA4eyGR8VrwWNRI=
X-Gm-Gg: ASbGncuTMd0BB9TcFTGlmxfSd8d4qppyFYMUygKWCZCEtgjp7S0t6q3kiJHQDJIgMLd
 zl7iaH2djlCvFtOthlOnHD+LOHjYA8/9sheSFOIsRQgwGbPKRRMvT8fT/OsxxzLWK2HnIwBOoZr
 HQ9kmAp6rQapNjFn3IjkDCM+xdK4cv0cYNWRbCJ9STXrilcRhxSpYrkI7cRJQtsbDVm7qMebDeU
 EOkLj86y8XpSyuQVYzHl6qJjMs9kG39xz0dOqEvsIiQY30mtpYSptdU2f1nlppgtroByIvf8Gwg
 ZxzQ9Q2dJvWhvQf9ivjN0iHO/AUwMsfHi2AeyCbUlVoG9xY3G7GmNwphBwyEHQ5elYqbssB5VDD
 LmMc8Dj2Wq3k/9nnQL8dtdah+Y1GsVzqZW00=
X-Google-Smtp-Source: AGHT+IGcammhUMsi8EgoBrbXOncfDE4A0MVXc4Y+RN7MewwNda5PZ5UMZMg5dNxaA6nBC2lBlMXygA==
X-Received: by 2002:a05:6a20:958f:b0:23d:7abf:9de4 with SMTP id
 adf61e73a8af0-23dc0f37b6bmr13348954637.42.1753998528149; 
 Thu, 31 Jul 2025 14:48:48 -0700 (PDT)
Received: from [192.168.1.87] ([38.41.223.211])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-b422bb0db0fsm2262598a12.61.2025.07.31.14.48.47
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 31 Jul 2025 14:48:47 -0700 (PDT)
Message-ID: <de74f8b3-9cfb-4d64-a40c-60e46eedd44d@linaro.org>
Date: Thu, 31 Jul 2025 14:48:47 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 68/82] target/arm: Copy EXLOCKEn to EXLOCK on exception to
 the same EL
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
References: <20250727080254.83840-1-richard.henderson@linaro.org>
 <20250727080254.83840-69-richard.henderson@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20250727080254.83840-69-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::435;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x435.google.com
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
> Per R_WTXBY, PSTATE.EXLOCK is 0 on an exception to a higher EL,
> and copied from EXLOCKEn otherwise.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   target/arm/helper.c | 9 +++++++--
>   1 file changed, 7 insertions(+), 2 deletions(-)

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>


