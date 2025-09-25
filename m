Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C63BCAC5A5
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Sep 2025 10:38:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v1jLq-0002IB-8n; Thu, 25 Sep 2025 06:37:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v1jLZ-000296-Rz
 for qemu-devel@nongnu.org; Thu, 25 Sep 2025 06:37:11 -0400
Received: from mail-wr1-x42e.google.com ([2a00:1450:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v1jLG-000550-5P
 for qemu-devel@nongnu.org; Thu, 25 Sep 2025 06:36:56 -0400
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-3ef166e625aso679538f8f.2
 for <qemu-devel@nongnu.org>; Thu, 25 Sep 2025 03:36:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1758796603; x=1759401403; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:references:cc:to:from
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=ly/axfF7fUyaUOYjaVc2/I5qFMYdx0A7yG5xF5VGyMg=;
 b=MAwIUXFL/+eS38MKJ8nL1c3TKYQu+z9yvdy5+jjkZK1MgTn9R24dpBmE05npWaYqGU
 nGEvdUT6WzDpy8e0XZtc8JhFSeU7e2MEy5+lTt/RTynexgHqovtzKJ77PmIdfULbC3J6
 QexwimZrwkHAIY3nmVRPbsJmbYosMC2qOELkeH+mx8WsxPPRHXbx+djQW+NUKvEQiLmu
 8g8NPrG65KOkSII3iJlxvHDc5pL03zysg40xpKhgB0sFd7pMl0JqmK+0I27+igimuoJi
 JyB50C/eeDkOG73Y3jaV+gHX7SORhHDJ4l48CE0PbenyPc2ZQ+M79okPrqs9GL1C4lHW
 aWbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758796603; x=1759401403;
 h=content-transfer-encoding:in-reply-to:references:cc:to:from
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ly/axfF7fUyaUOYjaVc2/I5qFMYdx0A7yG5xF5VGyMg=;
 b=pF8wo9zI8yEyJ3T5EPKmF1ubt9khG1ZUhbr5YkP7qNW6QPOKGxt2A1OM+KwfwIj+DZ
 lB4LSAIdVdL6vZF7phToKmXVA8qKMLNkMbkVCz9MHGvxBbfX+nHjPgVXbryvC2XvfMPB
 fyCczWDSVkQHGuEQCSrQdyUpyffzIcTvx3CAooSzrgfVmpKVpw5vVtxyaDDSBdZWscnL
 pZZyJuODdYmYDf6fCW8znNjqYy/EJH7a9A1ErF5pNmxfwojOBlyZan/P6z0j7qmdTi3Z
 RtJrD1CdBurk8HEzoiZ5axOwRYSyxL7MXkxdYVJPeWPHPXBEJktf53PeoWdc94g2dZpd
 mX9g==
X-Forwarded-Encrypted: i=1;
 AJvYcCUExqZUFVLI3ypvXxnA1copJwJNtQJmalfX+Ak47YQeO6zh+MnzYBbjDoL6qGX0iu509BNgh1f3wzmg@nongnu.org
X-Gm-Message-State: AOJu0YwHXu4/xfRR1OO3+AT+oZBbyXLFYv0wJKtNE/8G6Z/GcuxFonFr
 gTkTIi/KkR9akpdXfCsjByPFaVslI4rhjyFD0VnpKY3EOIDSgCaIqIvHO0JDXR2zUvI=
X-Gm-Gg: ASbGnctMOyf91QPdZNS5gNARzREa7DkbaMZGmsD3x5NUfEftoZ/DrQfuKE4ENaRccqi
 s0JVgCdi9FtoVN/WoFY0s0ThjEDEHyJnrGBfvq1esFVIZLSW87SQXgkg/hwfH6/IpfiGPi5+VRW
 9v0uJPIPrtZKQYlWDyBbRE51Q2E+oQo46iF01eVL9k3aNQoz+YQQFHtdF3t8uydDBOzOmMLSC8g
 UTBQlbw/SLtUpSVAKTegGWNk/plkOMdT4UNEt5oUTjGtCYzuOfhAV/0OUtasBcSFZkoMbQk6SXh
 PAIsbrta6sYXGsA/HHOxInKFF9NSXOFo9egATLLxqcA5/qwHt8n+5euWq63Q397Pr5QxdgSA5Lx
 dY+vGRTttjOK6CAPu4PYghJ9BouSvR4S1eOfemYl2iuwjQwDp202A6StRYF1UI99XNQ==
X-Google-Smtp-Source: AGHT+IFW/R+aMmmdCplYNVfoK03N2En6sWGcm1242H2b78TYYFkFgiIiv1oRZqw1XyI2d3p/jZlg/g==
X-Received: by 2002:a05:6000:400b:b0:3f4:8579:36b8 with SMTP id
 ffacd0b85a97d-40e4ff1990bmr3250343f8f.45.1758796603262; 
 Thu, 25 Sep 2025 03:36:43 -0700 (PDT)
Received: from [192.168.69.221] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-40fc5602eccsm2545901f8f.40.2025.09.25.03.36.42
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 25 Sep 2025 03:36:42 -0700 (PDT)
Message-ID: <1af5ea72-47d6-420b-8c13-35038bb6117d@linaro.org>
Date: Thu, 25 Sep 2025 12:36:41 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 11/36] target/arm: Rename all ARMCPRegInfo from opaque
 to ri
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, peter.maydell@linaro.org,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
References: <20250916142238.664316-1-richard.henderson@linaro.org>
 <20250916142238.664316-12-richard.henderson@linaro.org>
 <9cf69af4-fe5f-4998-acae-cffee41d2c91@linaro.org>
In-Reply-To: <9cf69af4-fe5f-4998-acae-cffee41d2c91@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42e;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42e.google.com
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

On 23/9/25 12:31, Philippe Mathieu-Daudé wrote:
> On 16/9/25 16:22, Richard Henderson wrote:
>> These pointers are no opaque, they have a specific type.
>>
>> Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
>> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
>> ---
>>   target/arm/cpregs.h | 10 +++++-----
>>   target/arm/helper.c |  6 +++---
>>   2 files changed, 8 insertions(+), 8 deletions(-)
> 
> Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

FWIW:
Tested-by: Philippe Mathieu-Daudé <philmd@linaro.org>


