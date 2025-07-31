Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B993C87FCA
	for <qemu-devel@archiver.kernel.org>; Thu, 31 Jul 2025 22:11:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uhbUM-0002iD-RI; Thu, 31 Jul 2025 18:11:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uhbP7-0006DB-Rv
 for qemu-devel@nongnu.org; Thu, 31 Jul 2025 18:05:43 -0400
Received: from mail-pl1-x632.google.com ([2607:f8b0:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uhbP6-00053o-1w
 for qemu-devel@nongnu.org; Thu, 31 Jul 2025 18:05:37 -0400
Received: by mail-pl1-x632.google.com with SMTP id
 d9443c01a7336-23fc5aedaf0so7796015ad.2
 for <qemu-devel@nongnu.org>; Thu, 31 Jul 2025 15:05:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1753999534; x=1754604334; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=83PVYiKDyIirv2WVwkBm9KU1K/Q/DopTJ8dmfiHBusI=;
 b=nusJRiFa58u3qbc0lPHUQxrEyXJ54xezxpiK8yfLKcMQLCNJ1F5zv0dscEorbWhPjZ
 JQ1GAvsZ0F6GsvF6eJzsnJE5rNOe+xT7xeaKxbyQXHSOR5R2Y3pHh6elFAR8RlBO3i/G
 xp3jt/rOU/rtuZWFXgvXXPnLWV1nnlFfxGBl0tAuaMVSw+J+ZuV0jw5ZkLGbb3iXRutB
 DF1bNfrH036/Fm1NzSg01fI0ZFziKxnpHigzJYZaqPOg8LxkgDfUfoMaGt53bKl+lMol
 DEzB6kgZgcGo9dnh6N9UfPKFs7mkwK7S6QJZVxmHrK/qCLrAMTiOmGGZ/LL02SGmJQBg
 kV2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753999534; x=1754604334;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=83PVYiKDyIirv2WVwkBm9KU1K/Q/DopTJ8dmfiHBusI=;
 b=jctOOCRpP97Q9oz8RtWmGWMPqZ33k2BXmb7huxQiQHaJoWg9FdOJKaBkS1lET8rYoN
 /2qGB+FdkMeXCeabFB1Y4nKh65tAYivt5CwVWS2AYunhQOyv8q23Jis4rxqkzqxxjXKn
 dohixfKJ0XJeF+Ed5VjkWVv1Sc1EiAP13T2HKUNCk73QqcTyxCXYx/ULdZdfPtZaoBpB
 jggBNtHyUHbtEzHehpRyRhDhVOv+SmpaOut0aYy0m+B1L+BsENYK4wHuNIjS5gFHRsDg
 aakTRgNlJ8z1mMrkcW2JgeBYn9OL2nVGQZKdtZY6Dl1aSxcnZhA+t5idmEsv0LPEKfcH
 tQiw==
X-Forwarded-Encrypted: i=1;
 AJvYcCU2S2C6OmHYpjS++2mzZgQhxfAvQgR7efA8fYKCGHsVGbh6v4mVV/QMBDvmFg7bO986gZ2u0bNadIUl@nongnu.org
X-Gm-Message-State: AOJu0Yxr3HV9PTrpdT0W/LleqG77MAFjmjTTcLI0eGWoiX9mC77LI3iA
 uP4yGmPO9zQmPXJeY3d/mjrj52yEBaNaa+1Tyx3KtFVKndHVPvE5qKUF8iLKZq5ybot5rROvQgG
 K2IPp
X-Gm-Gg: ASbGncuC9pxY6vZSKWhhhC4f8ksef38zyGhXKWo9eHVOJN9Xqy4xsD2KKluxZ3a6Eqb
 g874EYnTtTs463k15gFARQGUtQkGuGUPBcdxOCO4KoP9EYXPEbwqRFCDbPJX6gwZjVLnNA4pEHA
 FzCYVb37JjYFeKTf+4v91kPW1WcpDCTlnlh1P7QiMhkcXmL4s+ch6PLnyD0x7S9RHt9yI7svJAW
 gq0TD+OrDLD42aIBZ5mVSEIpqpmGUv0tRe8HSxop7Vowy68zVaPXqqPhdQVHd3kiKro1t9DXs0m
 edQlMy6a9qTFITk3hOTPsQah+urdj6OSlwdU9zfRce3pVIamdCsxO3zby6EPLgM/xlyLx4YTxRW
 uCer6CFU+kKyrHZhhUsYO7cjfY8R/8ijUZTg=
X-Google-Smtp-Source: AGHT+IEJBwqTN9BAPKUHPRD9MUjIMNxnPUtbqixaIZe2N2W9pF/jDvQMNkgd8a7JtpRIelFC1Kp+iw==
X-Received: by 2002:a17:903:1a67:b0:240:8fa2:15d2 with SMTP id
 d9443c01a7336-2422a69a02cmr3412345ad.33.1753999533573; 
 Thu, 31 Jul 2025 15:05:33 -0700 (PDT)
Received: from [192.168.1.87] ([38.41.223.211])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-241e8aafb8csm26470765ad.179.2025.07.31.15.05.32
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 31 Jul 2025 15:05:32 -0700 (PDT)
Message-ID: <0aec42a2-17e1-4a86-aca9-f1709923be79@linaro.org>
Date: Thu, 31 Jul 2025 15:05:31 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 80/82] tests/tcg/aarch64: Add gcsstr
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
References: <20250727080254.83840-1-richard.henderson@linaro.org>
 <20250727080254.83840-81-richard.henderson@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20250727080254.83840-81-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::632;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x632.google.com
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
> Add some infrastructure for testing gcs in userspace.
> Validate successful and trapped executions of GCSSTR.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   tests/tcg/aarch64/gcs.h           | 71 +++++++++++++++++++++++++++++++
>   tests/tcg/aarch64/gcsstr.c        | 48 +++++++++++++++++++++
>   tests/tcg/aarch64/Makefile.target |  5 +++
>   3 files changed, 124 insertions(+)
>   create mode 100644 tests/tcg/aarch64/gcs.h
>   create mode 100644 tests/tcg/aarch64/gcsstr.c

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>


