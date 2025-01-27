Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E627C02188
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jan 2025 21:14:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tcWQa-0005T9-3I; Mon, 27 Jan 2025 16:13:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tcWQX-0005Le-J0
 for qemu-devel@nongnu.org; Mon, 27 Jan 2025 16:13:50 -0500
Received: from mail-pl1-x62a.google.com ([2607:f8b0:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tcWQU-0000oE-H1
 for qemu-devel@nongnu.org; Mon, 27 Jan 2025 16:13:48 -0500
Received: by mail-pl1-x62a.google.com with SMTP id
 d9443c01a7336-2166651f752so100122265ad.3
 for <qemu-devel@nongnu.org>; Mon, 27 Jan 2025 13:13:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1738012425; x=1738617225; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=lMluLNAOvaEWt9zJ/HFJ/dscsMm/gOn1zHA8uO+W198=;
 b=UCKaACd6IR0t+f5+nczBPBir/ey6E5Bwf8uQrYua0vzZf+MMfWlHfrA+8NdK7dmeb3
 NZm+yadJjThKDpOs3lnlx9h9RQ9IdPiPvS//K0xsu2kGTRLyyBJwBA3t7GK19+RCjijR
 DIFQx1ys6TN5+1NJumWIoTyTLMuTMd4w2YaBsL7YNuQVfl0ByUqxsoepVSMp0wiCTVsZ
 XejWqWlxQmcSabXqT++qrABa+jQqKv+KUp9VqyplKtoUcDA7U9Z4RKdLAQlKWibqSZ2x
 6IDvVWR0h3u4Yg6cjugBBVs35i/JNWIVvPlNXVg+99z4Ze8Dtb9xDAPMAe+C3yc5Muwm
 ZUDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738012425; x=1738617225;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=lMluLNAOvaEWt9zJ/HFJ/dscsMm/gOn1zHA8uO+W198=;
 b=im/mQJVukgYBTc+x7BJitAswNozMkJmcJ0R8uXFXufOGodOTZ/e6b0KmYxHHXDQcQ3
 DLtN8XIiyrF5dL7dhlAAYvaz8sFyainbBv8+2ya1Oh8BUa+uT3UjoslAKMUTHagnWQVZ
 9Pl7wq5JYeHQ6Hlqeag3pnrRZXa6wUm8PDJCN6AGGiMzYILZ4iKFLIpX54R9uRpIprPv
 /XRPIxH+y88Iz8ycg8pJPHIsDayzC3A6FFYmu3+GizH8jnNZ6qjrIiQz6CSp3l8S2lJd
 FSaXrHJMGF1KfhPDxnKiMzsoL4YwHoGtVIMUwkELiT8wKza3t7U1zRlPJIa7to2ucw2H
 3wNQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXFfSMxRxjRHh0K1sjKOQB1/LaDt9Gs8Po+Iy6HndoT1igizuT7horUrZtKty4r4BY8Y7oD99JcwAPy@nongnu.org
X-Gm-Message-State: AOJu0YzVnADce0XsP/nuyZTLripR7tae1epCfYjAp0BwHwAxrXhP14Qa
 r2zSUHgTz9vuaJT3oQ+pUqDFXuoND6it/4LxDcXRf/aDM0Ti2YXeRLiCxD2z9HU=
X-Gm-Gg: ASbGncuubCFvFDkrmwu2Ne0wp+Fj61jRoGcxNjS4FyfyPpZSK8Gau4NpE8wS7MqnYiR
 cZiFBYTKcDwOpFsaZT9u9SOxpc184iPAQ/APWW4ZIgUQQmwy4XdgfEZI/FyzFXY4UazVUgc0e7a
 Hu8hEuwkKLffuHnWO6h2OvCs7xL0sxwJyJNVcwsbqcaJtYmEQl38npoMiIFxzqYj/zNMxlZ2dW7
 bW5r8Y8Qu/+OPGLRalh151ceqp5FftMg2i9FfnNd4Agtcbq8Hn5oYbIU73cDU2ne6VswDL9w//8
 To9nVcN2LymOemzV3JtAfi1mWLk8cm6WQ5kOpL4vtfSID5s=
X-Google-Smtp-Source: AGHT+IH5/FvtDd1IRsC7NKLG/fWT8NKEhP3xO2cTb/Aya7H8+6OEu26bIoo3/xHTcvEL9umhhBo8Wg==
X-Received: by 2002:a05:6a21:6da6:b0:1db:eff0:6ae7 with SMTP id
 adf61e73a8af0-1eb2157dcc1mr62769252637.33.1738012424554; 
 Mon, 27 Jan 2025 13:13:44 -0800 (PST)
Received: from [192.168.0.4] (174-21-71-127.tukw.qwest.net. [174.21.71.127])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-72f8a78e41dsm7929191b3a.173.2025.01.27.13.13.44
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 27 Jan 2025 13:13:44 -0800 (PST)
Message-ID: <bf36a5cf-c74c-4dba-8aed-cbf314f380f8@linaro.org>
Date: Mon, 27 Jan 2025 13:13:42 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/6] hw/loader: Clarify local variable name in
 load_elf_ram_sym()
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, qemu-ppc@nongnu.org, qemu-s390x@nongnu.org,
 qemu-arm@nongnu.org, Peter Maydell <peter.maydell@linaro.org>
References: <20250127113824.50177-1-philmd@linaro.org>
 <20250127113824.50177-4-philmd@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250127113824.50177-4-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62a;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

On 1/27/25 03:38, Philippe Mathieu-Daudé wrote:
> load_elf_ram_sym() compares target_data_order versus
> host data_order. Rename 'data_order' -> 'host_data_order'
> to ease code review.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   hw/core/loader.c | 8 ++++----
>   1 file changed, 4 insertions(+), 4 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

