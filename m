Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B569C71157
	for <qemu-devel@archiver.kernel.org>; Sun, 22 Jun 2025 01:58:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uT9yG-0004br-9Q; Sat, 21 Jun 2025 21:58:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uT9yF-0004bh-43
 for qemu-devel@nongnu.org; Sat, 21 Jun 2025 21:58:11 -0400
Received: from mail-pj1-x1033.google.com ([2607:f8b0:4864:20::1033])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uT9yD-0006dw-Ks
 for qemu-devel@nongnu.org; Sat, 21 Jun 2025 21:58:10 -0400
Received: by mail-pj1-x1033.google.com with SMTP id
 98e67ed59e1d1-313b6625cf1so2083106a91.0
 for <qemu-devel@nongnu.org>; Sat, 21 Jun 2025 18:58:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1750557488; x=1751162288; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=4UFbXz52NqRMX08uQiUjPWpm4BNWbll9p3w00OYXtls=;
 b=XG5R9hu1gm3BqUO7ct4AFppre/FQrRg4WasUAERmG6/ZoMLz72NmgIhO391gLSOrgc
 PTUo+7fIXfoWBVFxabylQjODaE81Ic6huv1r/sHgfLm6gn/3S7Eg8V5zXwZUCxGPUxFl
 VP89mq/fyK57J5MJRxqeo0KoaZX9pTYa/UcOEJyjgQfuWm1k2nbR+DPXnxTlpc561O8d
 cY1ZB9A+Zh1jBUl0fR/LLqJ/pYC27Szdb833n9zWU/LGp5YT65qX21EG8P5BUs74PqXG
 1uWpOuUERIRxmx51/0RnXFZ97jW0LbDv3BzJ1kCBgwfxr5LOwoIV62X4WyYZLzdSLNt4
 0Tlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750557488; x=1751162288;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=4UFbXz52NqRMX08uQiUjPWpm4BNWbll9p3w00OYXtls=;
 b=q6ICin8vMZNMoS02ubyvPmg0PktJvyG8dtOnLXyBMuxasCWQvLhCYmmWZZ1VknpwDC
 J/8RmSENb9Bry0FDck4oB0OEjtvz7oOcEbKot8AM09syel0nE6BPp87MKecI1lIJPrF3
 pZUsZ90AR6jaxgOGw22/XI+v3XcaQBOKQlR8j4ObGFq4IZuhg/QtzQ5flyZfFhiyYyV5
 +lt1CyMHPjBzNCCsahQsbPPkrcdaLdHBMkwOIQjzXQ2vR0H3JC4kffZQaglZ/DiiG1VH
 5HHWJNcOuwb4KN8phLYZZejo+2FQKXDqA/y68Cn7StqQ9cSdUhBw7OIxk/ppn/Y/aWAS
 S4hw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUNDAX1yKkpJsviF4Mn4gg90Yz97qaQ8DpyxvPk1Sn+iqw1cR7iO/pEBMoA6s7DgpYZoiCCeb9xZILR@nongnu.org
X-Gm-Message-State: AOJu0Ywjp4ej/R124H5AX7NVkqc8ObmjcAnchGfZ9PWD8UJH/NhhwhpB
 BdptrsJNsYX1/9Fnec7H4L7TutNWZzCpvNhftAingCz1r/RVyNA3VytW5IXaelr8atk=
X-Gm-Gg: ASbGncvNBlbUOpg5n1f1Atr4AJIMBqce/PtiS3QMmENtAPxbxmt2Gn1ij3Xoif/SgoK
 96mnuEmdC8VXipjBteurQnWXO9dJNFleKBreWq7DzoqMHQXKxzKjDzxv/AqY//gTRrlKT2cYY7P
 kY+5fZlSZsTYDGWdH8yJpMEi5e8ZFdXn6yYNO09Al6Zr0ALPO6S5izAEsmZRlwCcsCNTYB2FGsT
 EDkpB1nDKpQYfPN8kwI0Nzv4mILodXrwb59hS++exe27QUz1clg5wxaEvwuIAsT0/SA52qgtYSf
 2fnQ66E3clyHIoRQiTkbNGuGdPp/eSE730A8SaaCfUnSeIz8A3j1xIE3780rxRxLyNZUVlmcEQo
 Bipf2Go6TT9c+xk4eS+jlqKme6VtF
X-Google-Smtp-Source: AGHT+IHWovS8gKWsjfb91m8ImdoVthuA7CX5yI1ojhuGHZtogbYGAoLL9kwsb3DaD8j519mfXYc4Lg==
X-Received: by 2002:a17:90b:5605:b0:30e:3737:7c87 with SMTP id
 98e67ed59e1d1-3159f46c29fmr11038944a91.5.1750557488069; 
 Sat, 21 Jun 2025 18:58:08 -0700 (PDT)
Received: from [192.168.0.4] (174-21-67-243.tukw.qwest.net. [174.21.67.243])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3158a31c6aesm7313101a91.41.2025.06.21.18.58.07
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 21 Jun 2025 18:58:07 -0700 (PDT)
Message-ID: <fdabc43b-d67a-4f5b-aa97-2399304ef976@linaro.org>
Date: Sat, 21 Jun 2025 18:58:06 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v2 30/48] accel: Introduce
 AccelOpsClass::cpu_thread_routine handler
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
References: <20250620171342.92678-1-philmd@linaro.org>
 <20250620171342.92678-31-philmd@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250620171342.92678-31-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1033;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1033.google.com
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
> In order to have a generic function creating threads,
> introduce the thread_precreate() and cpu_thread_routine()
> handlers.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   include/system/accel-ops.h |  5 ++++-
>   accel/accel-common.c       | 16 +++++++++++++++-
>   system/cpus.c              |  2 +-
>   3 files changed, 20 insertions(+), 3 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

