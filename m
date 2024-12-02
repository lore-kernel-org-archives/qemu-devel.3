Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3067D7833D
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Dec 2024 17:37:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tIAMT-0004Fa-1J; Mon, 02 Dec 2024 12:37:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tIAMR-0004FQ-Qv
 for qemu-devel@nongnu.org; Mon, 02 Dec 2024 12:37:27 -0500
Received: from mail-ot1-x32f.google.com ([2607:f8b0:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tIAMQ-0003QT-GC
 for qemu-devel@nongnu.org; Mon, 02 Dec 2024 12:37:27 -0500
Received: by mail-ot1-x32f.google.com with SMTP id
 46e09a7af769-71d5984e56fso2075910a34.3
 for <qemu-devel@nongnu.org>; Mon, 02 Dec 2024 09:37:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733161045; x=1733765845; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=cj6DjLsVzrTs0OwxAUo6lMhTrJNFWKCyIz6kx3m8Z14=;
 b=pIrQt4x2U0gxz7brz7z5xQSQ8F9Vwh4A0FORcZEYrwa2vOD3yfwBjN5093V6nL0K4O
 c+7lT5d6aG+3nLJZKkODdnWt+mY47N0iA5rnIT01iDk4udZkFoDwOsZQGGSdv++35kEb
 bAnKASZUdR0PPaZiZtFi8MYea7lVSS78FacaUeXiC2Sj71nHLHP/ztX+shmf5hyIw56S
 SROFScz7/7ZSnJt4RA5ve8FLXVslxTw8m5F6pRmzra7C1mNcO5jHRMoHVnONFjWd7lqW
 XSp7vVDyL87KF//zOzptmlAeT8MR2rYNcRKcR8FygD0+DYMmqIBdRO26TjSmml759LqL
 9B5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733161045; x=1733765845;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=cj6DjLsVzrTs0OwxAUo6lMhTrJNFWKCyIz6kx3m8Z14=;
 b=k9A3BdZUGbzDrPG3uYsodHt01Rz7ILUibmjNvf0NmBnNzL4cH5C1WQ1J/CMt50yu5/
 4ExiHGEBqZbbBlTtG9ujE3qB0lZTmuo06ha3TvPRNLDtbCw07wEwWRIIaeoCY8JhsUVo
 PwHmbpSJj1Oqa/nxbT7b1k2XGsTqNBh9Op6pXzjDR5qKRbNg7h6h72boKKAj8/B3pAx/
 kSlH/oyjedX3NgMQXFV21yuwTVvePNZqFMLZJZbdO0AZyPJpdhQ6kOwx7ac3J9B2zDed
 8xpmNwRaIHyDOyOCoGgDfoeRQGirGPZM9XTp8lEYzrIL4DhDUbTSZ6SG/6z3Pflr/WJ4
 34ug==
X-Forwarded-Encrypted: i=1;
 AJvYcCVUOSF+axIUZCmu/uHiR/lSd6sKmdxlQ3GnBEWwTLxHzRtnejK+PlnS4c0omyjbSVj4md6gT7dMovNW@nongnu.org
X-Gm-Message-State: AOJu0Yy4uwVLIQ78n4QCPuktkomY+Vksvs7bkFeEY1fPSVa/qQVRV/En
 YBlVLMF59jywsi6uaWXOVJyBkl5MDgQ4Cer6FUXnO7b+SeQt6i51j3A7mhCyWkRGNEqbZeS2pQX
 pEvM=
X-Gm-Gg: ASbGncuPV7Bl3hV5tyuTwahXIAL0Nf9kmewU6oiWv8IPJTRlDGuXH9pfAOriEPTJ8R1
 ZB8000ewtAqcNRji+j+pbZc+yNxRItuMSga/ptj/cMdy99MD06bkiiiDh4q3EaVQiB2zqRm/cCp
 NcsAn6UE4y3jDDY8dSueFcafAx5FJD+8FeOhK3NdBbMFeo1nl1VhzFojOF5o38Z/atY1dTPOQXE
 h0r3Mp/7K7ZUSKtqKTGeJNrqv8P1xtfhhxourvK9xTJDoTwFucD/ZP2/0Ttm0sdkMdYpBk=
X-Google-Smtp-Source: AGHT+IEDODl6kv5fwypqBzNIXsYrrVpXa5jNyLznfY+yZ5U9wbR+1+yh2DjR5v2MsUVA0UORUXvxLQ==
X-Received: by 2002:a05:6830:25d0:b0:71d:5f22:afec with SMTP id
 46e09a7af769-71d65c9542bmr13067459a34.12.1733161045189; 
 Mon, 02 Dec 2024 09:37:25 -0800 (PST)
Received: from [192.168.170.227] ([187.217.227.247])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-71d725d8639sm2331853a34.51.2024.12.02.09.37.24
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 02 Dec 2024 09:37:24 -0800 (PST)
Message-ID: <04949680-afc3-44f4-9c91-ea0b3be25f2b@linaro.org>
Date: Mon, 2 Dec 2024 11:37:22 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 for-10.0 49/54] target/sparc: Set default NaN pattern
 explicitly
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
References: <20241202131347.498124-1-peter.maydell@linaro.org>
 <20241202131347.498124-50-peter.maydell@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20241202131347.498124-50-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::32f;
 envelope-from=richard.henderson@linaro.org; helo=mail-ot1-x32f.google.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On 12/2/24 07:13, Peter Maydell wrote:
> Set the default NaN pattern explicitly for SPARC, and remove
> the ifdef from parts64_default_nan.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>   target/sparc/cpu.c             | 2 ++
>   fpu/softfloat-specialize.c.inc | 5 +----
>   2 files changed, 3 insertions(+), 4 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

