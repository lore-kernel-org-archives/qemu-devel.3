Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D811EED63A
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Sep 2024 18:21:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sooRP-0006GM-Jn; Thu, 12 Sep 2024 14:21:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sooRH-0005dv-DB
 for qemu-devel@nongnu.org; Thu, 12 Sep 2024 14:21:11 -0400
Received: from mail-pg1-x534.google.com ([2607:f8b0:4864:20::534])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sooRF-0000kh-R7
 for qemu-devel@nongnu.org; Thu, 12 Sep 2024 14:21:07 -0400
Received: by mail-pg1-x534.google.com with SMTP id
 41be03b00d2f7-7cf5e179b68so1093852a12.1
 for <qemu-devel@nongnu.org>; Thu, 12 Sep 2024 11:21:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1726165264; x=1726770064; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=7jrkPypAQr6q46cYoA6TpfjxrDYdRiQqTN6npFoz81Y=;
 b=V1DUuHzVC6bOF4UHRtErg3NKExeXQ+LMncjkmFALeDxLMqgFGEOUoFRPsCmZV+OFY4
 EV6DrnAyJxSsGgfsw25KvZ19SRPpN3pwz/9fJAayUen/abx2uwMYB6iq/68jPzkgaO0x
 hUCjL+HCOvWFCIem0m5EVj2sFYPiJhID9mUBqkksXj06chbO/D1bWlocRNm5FMrGcC2v
 tmmGCkVzH2Jztd3WTXRYYT/kNJe5aSuvSz73dQoBQ7sPnp3+sjWo/JZYT4G3cV1PmXzt
 PxWQ5q8av/18kV3hEEYjeODdlw1mnepcNJNP/NqgHutbQS1anAm1lCYlmXtS6bHoyKRL
 tV4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726165264; x=1726770064;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=7jrkPypAQr6q46cYoA6TpfjxrDYdRiQqTN6npFoz81Y=;
 b=h4+r/L3Dua5NI3d6RKQ7CtEPQwylBSFv5CjZ/lGcfG/ji2lMim0fbNaKGvY/nGfqtU
 LuJMhMOTOJ2ZxAFtvaIrK3LDpbsRNg89cnp0F5qFXfmlz5SmfH8O7mR7LXy3alUTvkJp
 bAjOghAYQ7NIMK2RLBFlry3chQkn5sCZmMBtwDDXQnfWBG7O12WOqwqcHqmzgi08D1xQ
 Vr6/4zqAy4OjEefmNrLomx8xgj49uJALZW5oA2v6moknRtqHwP486z+gtCMPgeUd87R6
 R+YsLVE20sK0znuS4pHACNo2I1djwFlUev9j34I0hGPxFMHt1FpWIyfDTIxP0gVWfFdN
 xU5g==
X-Forwarded-Encrypted: i=1;
 AJvYcCX3eQoAl5iT36DHabjnvk0z88Pi5EJoLzlBm4C+HGHUaEH3UQ7PQzDIc6eXosBwRglKazk15JxtnmtO@nongnu.org
X-Gm-Message-State: AOJu0YwK11q3kJadhEiCcXtLXC+IOMiHqoyHfr2nX81XbEWYKdU4GtNC
 jbX4FbNm/Y9kBwkqlyjoF+wF66fla/s9SbNQkDRfa8ahMxdqzhsCe1L3Vcw36/QhfTqwRn0yblW
 J
X-Google-Smtp-Source: AGHT+IEAMdJvT8hgz8Ck5lBU7ay0TsQjmvASGFYsw1q4sEkdj23Mn2HRT19SuX+qMzT+GYJeykO9mA==
X-Received: by 2002:a17:902:ea03:b0:202:4bd9:aea5 with SMTP id
 d9443c01a7336-2074c623694mr151724755ad.14.1726165264427; 
 Thu, 12 Sep 2024 11:21:04 -0700 (PDT)
Received: from [192.168.0.4] (174-21-81-121.tukw.qwest.net. [174.21.81.121])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2076b01b3fasm16860445ad.289.2024.09.12.11.21.03
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 12 Sep 2024 11:21:04 -0700 (PDT)
Message-ID: <09fa5e23-2feb-4cfc-8af8-3aaf0f1f35d8@linaro.org>
Date: Thu, 12 Sep 2024 11:21:02 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 47/48] tests/qtest: remove return after
 g_assert_not_reached()
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-devel@nongnu.org
References: <20240912161150.483515-1-pierrick.bouvier@linaro.org>
 <20240912161150.483515-4-pierrick.bouvier@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240912161150.483515-4-pierrick.bouvier@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::534;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x534.google.com
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

On 9/12/24 09:11, Pierrick Bouvier wrote:
> This patch is part of a series that moves towards a consistent use of
> g_assert_not_reached() rather than an ad hoc mix of different
> assertion mechanisms.
> 
> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
> ---
>   tests/qtest/acpi-utils.c | 1 -
>   1 file changed, 1 deletion(-)
> 
> diff --git a/tests/qtest/acpi-utils.c b/tests/qtest/acpi-utils.c
> index 673fc975862..9dc24fbe5a0 100644
> --- a/tests/qtest/acpi-utils.c
> +++ b/tests/qtest/acpi-utils.c
> @@ -156,5 +156,4 @@ uint64_t acpi_find_rsdp_address_uefi(QTestState *qts, uint64_t start,
>           g_usleep(TEST_DELAY);
>       }
>       g_assert_not_reached();
> -    return 0;
>   }

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

