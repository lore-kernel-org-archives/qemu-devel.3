Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC6BAC7115C
	for <qemu-devel@archiver.kernel.org>; Sun, 22 Jun 2025 02:04:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uTA4G-0008AO-QH; Sat, 21 Jun 2025 22:04:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uTA4F-00089x-4J
 for qemu-devel@nongnu.org; Sat, 21 Jun 2025 22:04:23 -0400
Received: from mail-pg1-x532.google.com ([2607:f8b0:4864:20::532])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uTA4D-0007GM-Ij
 for qemu-devel@nongnu.org; Sat, 21 Jun 2025 22:04:22 -0400
Received: by mail-pg1-x532.google.com with SMTP id
 41be03b00d2f7-b31d8dd18cbso3253583a12.3
 for <qemu-devel@nongnu.org>; Sat, 21 Jun 2025 19:04:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1750557860; x=1751162660; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=JgxJGcGommeovoYwlmkU4jSwnVKZyCtmtYMNqyxaCME=;
 b=RiP0bsYGmPNNk0t6E2uIhFv6U8P/SsFNSZhDCGosTw/K9UuYKSCWfJ53fW/WY/uT/W
 7j+aZOxDfm/XSxKwva7sGjPJmL3XSmjgtpDGl+c3HtovnYbjHg7L3QopsnRd5+WZ+RKK
 4UPUJACMm2xKdbVQA/4vQWQoFUE08dfIt8wczsAi3l5oafPu7SknIephlFNXsm9A/k/u
 4GmFqU3IjhFkUrosTuzcVJJYuQDTcFxiPTYJjGgxoIcSkK5kP8wmdFat2p7a43DGbbTs
 F+3AcOka/w4rxPvc03nT6e/9x5HOrTFhSYXkZConJt7GscnfDLfSPqhiBNFihY1L1hKy
 n/5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750557860; x=1751162660;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=JgxJGcGommeovoYwlmkU4jSwnVKZyCtmtYMNqyxaCME=;
 b=WP6D4NTNmen5Slsm5RNbIa2i46wX2iVlTHz97zbgUP/suBxhtiH6X38xpobxFVan/r
 vC3Qs9cbpsX6dgbq8EPALzi6wKOHa7QlUahwDW4xqK9xijT7r9JePqw3eJd7ro+x4c8m
 hls03KyOJ1N4LmGwxuyF2dD/t9cVsDK6qwzMsWjbw2KqDmpEHZW235DHRiimAiwTwwYQ
 xYDZUMtlHbkbrUIMzTtEVl5N4Aixei7VYaT59cKGZn2bHCgriJ+bNWyOXl5Ngld/ju9O
 kxYtnJOiq02Z+VkpQjAjK1hYZP70yqNdgD+wrAAxXRoNksOO9kmevwqh/oKZEWODYP/L
 wGfA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVCEYg8o0pxblqO9MuUfB5qKeA/TP4zYixlF6rnalFz+ziUBqJeVIxElhxwP2AEqJ0/UE/qCiojHSr2@nongnu.org
X-Gm-Message-State: AOJu0Ywy75IgtyIj1ozW/cffs6CFq02ExWEoLQViXW/p8cHeC66pvnoJ
 VEdiD/Y4vlaKzUF6e9QzB1iuUf80JV4qwTxpUyzA1YezICgnAAJGkXSQI8bbT/f+NdQ=
X-Gm-Gg: ASbGncswVe5zGnPVxDpuBXeaAwAPmz2qw24u8AhopTTrP0bkmVklIqiLzPAYF5TcT2T
 EXLGah0OAZ4a3KydYU+DXiJ4RVxwwbMjq6bSv8mUkrcBcs/+9Y6f5PXhUjcjLRoP1msmoUnWLPH
 YHWxgUdhg1fbC2ifNRA8uqILDCXHQtbu6YE47DesVGqRGYAYm7G+ccRK/m/RIx+zqUqSqtxp542
 jRZ9xPUGdB8/SI+LdsqnirxyHMLQQ1h3sFBx8+hdxYrsLo9eEvsUJuJPz0/Ab3wT3ILy7MxTesn
 oAhpN1tbTUnuTmK6FHW3h50b4PCGYVC7IZFHAZwNEZrFh9N1oQvV8YRJNJaBJKqaa+DZUTb70zF
 GoFNLQPo6kGSC2pD6J1pdMT3QUBZc
X-Google-Smtp-Source: AGHT+IGYRiXdBzBTzt4bSYsl0SA/CcqeLnCVfwrBOewFHhKB1Wo4fH8K0zts6icQJ6aU854Uyp6uDw==
X-Received: by 2002:a05:6a21:a45:b0:21f:4ecc:11b7 with SMTP id
 adf61e73a8af0-22026f13b9amr13290005637.36.1750557860144; 
 Sat, 21 Jun 2025 19:04:20 -0700 (PDT)
Received: from [192.168.0.4] (174-21-67-243.tukw.qwest.net. [174.21.67.243])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-b31f119e4e8sm4783375a12.26.2025.06.21.19.04.19
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 21 Jun 2025 19:04:19 -0700 (PDT)
Message-ID: <33d5d33d-f9a0-49e2-aa1a-e305c61e1447@linaro.org>
Date: Sat, 21 Jun 2025 19:04:18 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v2 33/48] accel/hvf: Convert to
 AccelOpsClass::cpu_thread_routine
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
References: <20250620171342.92678-1-philmd@linaro.org>
 <20250620171342.92678-34-philmd@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250620171342.92678-34-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::532;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x532.google.com
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

On 6/20/25 10:13, Philippe Mathieu-Daudé wrote:
> By converting toAccelOpsClass::cpu_thread_routine we can
> let the common accel_create_vcpu_thread() create the thread.
> 
> Signed-off-by: Philippe Mathieu-Daudé<philmd@linaro.org>
> ---
>   accel/hvf/hvf-accel-ops.c | 18 +-----------------
>   1 file changed, 1 insertion(+), 17 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

